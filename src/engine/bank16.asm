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

EffectCommands_58000:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6875c
	dbw EFFECTCMDTYPE_AI, Func_68753
	db $00

EffectCommands_58008:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6876e
	db $00

EffectCommands_5800d:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_68772
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6878e
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_68776
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, Func_68776
	db $00

EffectCommands_5801b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_687a1
	dbw EFFECTCMDTYPE_AI, Func_68798
	db $00

EffectCommands_58023:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_687ae
	dbw EFFECTCMDTYPE_AI, Func_687a5
	db $00

EffectCommands_5802b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_687b2
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_687d5
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_687b6
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_687cf
	db $00

EffectCommands_58039:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_687e9
	db $00

EffectCommands_5803e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_687f6
	db $00

EffectCommands_58043:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_687fa
	db $00

EffectCommands_58048:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68807
	dbw EFFECTCMDTYPE_AI, Func_687fe
	db $00

EffectCommands_58050:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6880b
	db $00

EffectCommands_58055:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68818
	db $00

EffectCommands_5805a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68835
	dbw EFFECTCMDTYPE_AI, Func_6882c
	db $00

EffectCommands_58062:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_68839
	db $00

EffectCommands_58067:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68843
	db $00

EffectCommands_5806c:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_68847
	db $00

EffectCommands_58071:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68851
	db $00

EffectCommands_58076:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68857
	db $00

EffectCommands_5807b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6885b
	db $00

EffectCommands_58080:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6886e
	dbw EFFECTCMDTYPE_AI, Func_68865
	db $00

EffectCommands_58088:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6888f
	dbw EFFECTCMDTYPE_AI, Func_68886
	db $00

EffectCommands_58090:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68893
	db $00

EffectCommands_58095:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_68897
	db $00

EffectCommands_5809a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_688ac
	dbw EFFECTCMDTYPE_AI, Func_688a4
	db $00

EffectCommands_580a2:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_688b8
	db $00

EffectCommands_580a7:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_688cc
	db $00

EffectCommands_580ac:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_688d0
	db $00

EffectCommands_580b1:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_688d4
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6891b
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_688de
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_688ff
	db $00

EffectCommands_580bf:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6893b
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6895b
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6893f
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_68952
	db $00

EffectCommands_580cd:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68985
	dbw EFFECTCMDTYPE_AI, Func_68966
	db $00

EffectCommands_580d5:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_689b5
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_689c4
	dbw EFFECTCMDTYPE_AI, Func_689ac
	db $00

EffectCommands_580e0:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_689d6
	dbw EFFECTCMDTYPE_AI, Func_689ce
	db $00

EffectCommands_580e8:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_689da
	db $00

EffectCommands_580ed:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68a07
	dbw EFFECTCMDTYPE_AI, Func_689fe
	db $00

EffectCommands_580f5:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_68a1c
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_68a5d
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_68a26
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_68a44
	db $00

EffectCommands_58103:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68a86
	dbw EFFECTCMDTYPE_AI, Func_68a7d
	db $00

EffectCommands_5810b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68a9c
	db $00

EffectCommands_58110:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68aa9
	dbw EFFECTCMDTYPE_AI, Func_68aa0
	db $00

EffectCommands_58118:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68aca
	dbw EFFECTCMDTYPE_AI, Func_68ac1
	db $00

EffectCommands_58120:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_68aea
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_68ae2
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, Func_68ae2
	db $00

EffectCommands_5812b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_68af0
	db $00

EffectCommands_58130:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68b08
	db $00

EffectCommands_58135:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68b0c
	db $00

EffectCommands_5813a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68b19
	dbw EFFECTCMDTYPE_AI, Func_68b10
	db $00

EffectCommands_58142:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68b26
	dbw EFFECTCMDTYPE_AI, Func_68b1d
	db $00

EffectCommands_5814a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_68b2a
	db $00

EffectCommands_5814f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_68b37
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68b3b
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_68b39
	dbw EFFECTCMDTYPE_UNK_11, Func_68b3d
	db $00

EffectCommands_5815d:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_68c52
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68c58
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_68c55
	dbw EFFECTCMDTYPE_UNK_11, Func_68c5b
	db $00

EffectCommands_5816b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68c5d
	db $00

EffectCommands_58170:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68c61
	db $00

EffectCommands_58175:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_68c67
	db $00

EffectCommands_5817a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68c72
	dbw EFFECTCMDTYPE_AI, Func_68c69
	db $00

EffectCommands_58182:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_68c76
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_68cbd
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_68c80
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_68ca1
	db $00

EffectCommands_58190:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68ce6
	dbw EFFECTCMDTYPE_AI, Func_68cdd
	db $00

EffectCommands_58198:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_68cea
	db $00

EffectCommands_5819d:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_68d06
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68d44
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_68d09
	db $00

EffectCommands_581a8:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68d6b
	dbw EFFECTCMDTYPE_AI, Func_68d63
	db $00

EffectCommands_581b0:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68d7f
	db $00

EffectCommands_581b5:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68d8c
	dbw EFFECTCMDTYPE_AI, Func_68d83
	db $00

EffectCommands_581bd:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_68d90
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68d9b
	db $00

EffectCommands_581c5:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68dfc
	dbw EFFECTCMDTYPE_AI, Func_68df3
	db $00

EffectCommands_581cd:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68e1c
	db $00

EffectCommands_581d2:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68e29
	dbw EFFECTCMDTYPE_AI, Func_68e20
	db $00

EffectCommands_581da:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_68e2d
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68e44
	db $00

EffectCommands_581e2:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_68e70
	db $00

EffectCommands_581e7:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68ed8
	dbw EFFECTCMDTYPE_AI, Func_68ed8
	db $00

EffectCommands_581ef:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68ee6
	dbw EFFECTCMDTYPE_AI, Func_68edd
	db $00

EffectCommands_581f7:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_68efe
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68f08
	db $00

EffectCommands_581ff:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68f10
	dbw EFFECTCMDTYPE_AI, Func_68f10
	db $00

EffectCommands_58207:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68f16
	db $00

EffectCommands_5820c:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_68f2a
	db $00

EffectCommands_58211:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68f2c
	dbw EFFECTCMDTYPE_AI, Func_68f2c
	db $00

EffectCommands_58219:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_68f32
	db $00

EffectCommands_5821e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68f34
	dbw EFFECTCMDTYPE_AI, Func_68f34
	db $00

EffectCommands_58226:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68f36
	db $00

EffectCommands_5822b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68f3e
	dbw EFFECTCMDTYPE_AI, Func_68f3a
	db $00

EffectCommands_58233:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_68f47
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_68f8e
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_68f51
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_68f72
	db $00

EffectCommands_58241:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68fb2
	dbw EFFECTCMDTYPE_AI, Func_68fae
	db $00

EffectCommands_58249:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68fbb
	db $00

EffectCommands_5824e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68fcc
	dbw EFFECTCMDTYPE_AI, Func_68fc3
	db $00

EffectCommands_58256:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68fe1
	db $00

EffectCommands_5825b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_68feb
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_68fe5
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_68fe8
	db $00

EffectCommands_58266:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68fee
	dbw EFFECTCMDTYPE_AI, Func_68fee
	db $00

EffectCommands_5826e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_68ff4
	db $00

EffectCommands_58273:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69006
	db $00

EffectCommands_58278:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6900a
	db $00

EffectCommands_5827d:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69027
	dbw EFFECTCMDTYPE_AI, Func_6901e
	db $00

EffectCommands_58285:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6902d
	dbw EFFECTCMDTYPE_AI, Func_6902d
	db $00

EffectCommands_5828d:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69033
	db $00

EffectCommands_58292:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_69037
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_69052
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_69076
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Func_69070
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_69065
	db $00

EffectCommands_582a3:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69082
	db $00

EffectCommands_582a8:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69086
	db $00

EffectCommands_582ad:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6908a
	db $00

EffectCommands_582b2:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6909e
	db $00

EffectCommands_582b7:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_690a4
	db $00

EffectCommands_582bc:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_690b1
	dbw EFFECTCMDTYPE_AI, Func_690a8
	db $00

EffectCommands_582c4:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_690b5
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_690b9
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_690c1
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_690bd
	db $00

EffectCommands_582d2:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69112
	dbw EFFECTCMDTYPE_AI, Func_69109
	db $00

EffectCommands_582da:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6912a
	dbw EFFECTCMDTYPE_AI, Func_6912a
	db $00

EffectCommands_582e2:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_69136
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_69130
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_69133
	db $00

EffectCommands_582ed:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69139
	dbw EFFECTCMDTYPE_AI, Func_69139
	db $00

EffectCommands_582f5:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69149
	dbw EFFECTCMDTYPE_AI, Func_6913f
	db $00

EffectCommands_582fd:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6916b
	dbw EFFECTCMDTYPE_AI, Func_69162
	db $00

EffectCommands_58305:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69183
	db $00

EffectCommands_5830a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69187
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_69190
	db $00

EffectCommands_58312:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_691aa
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_691d9
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_691c4
	db $00

EffectCommands_5831d:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_691ff
	dbw EFFECTCMDTYPE_AI, Func_691ff
	db $00

EffectCommands_58325:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69205
	db $00

EffectCommands_5832a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_69209
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, Func_6920b
	db $00

EffectCommands_58332:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69250
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_69255
	db $00

EffectCommands_5833a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69266
	db $00

EffectCommands_5833f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6929a
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6929d
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Func_692a3
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_692a0
	db $00

EffectCommands_5834d:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_692a9
	db $00

EffectCommands_58352:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_692b8
	dbw EFFECTCMDTYPE_AI, Func_692af
	db $00

EffectCommands_5835a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_692be
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_692c6
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69306
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Func_692f7
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_692ee
	dbw EFFECTCMDTYPE_AI, Func_69302
	db $00

EffectCommands_5836e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69318
	dbw EFFECTCMDTYPE_AI, Func_6930f
	db $00

EffectCommands_58376:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6931e
	db $00

EffectCommands_5837b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_69330
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_69353
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_69334
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6934d
	db $00

EffectCommands_58389:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_69367
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6936a
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Func_69370
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6936d
	db $00

EffectCommands_58397:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_69376
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_69379
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Func_6937f
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6937c
	db $00

EffectCommands_583a5:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_69385
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_69393
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_693e6
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Func_693d8
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_693d3
	db $00

EffectCommands_583b6:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69424
	dbw EFFECTCMDTYPE_AI, Func_6941b
	db $00

EffectCommands_583be:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69443
	dbw EFFECTCMDTYPE_AI, Func_6943a
	db $00

EffectCommands_583c6:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_69449
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6944c
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Func_69452
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6944f
	db $00

EffectCommands_583d4:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_69458
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6945b
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Func_69461
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6945e
	db $00

EffectCommands_583e2:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69467
	db $00

EffectCommands_583e7:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69476
	dbw EFFECTCMDTYPE_AI, Func_6946d
	db $00

EffectCommands_583ef:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6947a
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6947d
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Func_69483
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_69480
	db $00

EffectCommands_583fd:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_69489
	db $00

EffectCommands_58402:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6948b
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6948d
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Func_6948f
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_69491
	db $00

EffectCommands_58410:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6950c
	db $00

EffectCommands_58415:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6950e
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_69511
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Func_69513
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_69515
	db $00

EffectCommands_58423:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69517
	db $00

EffectCommands_58428:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6951f
	dbw EFFECTCMDTYPE_AI, Func_6951b
	db $00

EffectCommands_58430:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_69528
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6953f
	db $00

EffectCommands_58438:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_695a4
	dbw EFFECTCMDTYPE_AI, Func_6959b
	db $00

EffectCommands_58440:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_695b9
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, Func_695bb
	db $00

EffectCommands_58448:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69670
	dbw EFFECTCMDTYPE_AI, Func_69667
	db $00

EffectCommands_58450:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69708
	db $00

EffectCommands_58455:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6970c
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_697b4
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6972f
	db $00

EffectCommands_58460:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_69816
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_69804
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_69808
	db $00

EffectCommands_5846b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69829
	db $00

EffectCommands_58470:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6982d
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_69830
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69853
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Func_6984d
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_69842
	db $00

EffectCommands_58481:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69859
	db $00

EffectCommands_58486:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6985d
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_69884
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_69864
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6986b
	db $00

EffectCommands_58494:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_698a6
	db $00

EffectCommands_58499:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_698aa
	db $00

EffectCommands_5849e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_698b9
	db $00

EffectCommands_584a3:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_698bb
	db $00

EffectCommands_584a8:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_698bf
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_69915
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_698d6
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_69910
	db $00

EffectCommands_584b6:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_69a0f
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_699fd
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_69a01
	db $00

EffectCommands_584c1:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69a22
	db $00

EffectCommands_584c6:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_69a26
	db $00

EffectCommands_584cb:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69a28
	dbw EFFECTCMDTYPE_AI, Func_69a28
	db $00

EffectCommands_584d3:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_69a37
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69a4b
	dbw EFFECTCMDTYPE_UNK_11, Func_69acc
	db $00

EffectCommands_584de:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69af1
	db $00

EffectCommands_584e3:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69afb
	dbw EFFECTCMDTYPE_AI, Func_69af5
	db $00

EffectCommands_584eb:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_69b05
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_69b16
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69b68
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_69b6d
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_69b50
	db $00

EffectCommands_584fc:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_69c2e
	db $00

EffectCommands_58501:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69c30
	db $00

EffectCommands_58506:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69c3a
	dbw EFFECTCMDTYPE_AI, Func_69c34
	db $00

EffectCommands_5850e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_69c47
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_69c4a
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69c6d
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Func_69c67
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_69c5c
	db $00

EffectCommands_5851f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_69c73
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_69c9a
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_69c7a
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_69c81
	db $00

EffectCommands_5852d:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_69cab
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_69cd2
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_69cb2
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_69cb9
	db $00

EffectCommands_5853b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_69ce3
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69d03
	dbw EFFECTCMDTYPE_UNK_11, Func_69d59
	db $00

EffectCommands_58546:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69d79
	db $00

EffectCommands_5854b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_69d7d
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69d88
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_69d99
	db $00

EffectCommands_58556:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_69da4
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_69daf
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_69df4
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_69ddb
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Func_69dd5
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_69dc2
	db $00

EffectCommands_5856a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_69e09
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_69e0d
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69e15
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_69e11
	db $00

EffectCommands_58578:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_69e19
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_69e26
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_69e49
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Func_69e43
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_69e38
	db $00

EffectCommands_58589:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69e5e
	dbw EFFECTCMDTYPE_AI, Func_69e55
	db $00

EffectCommands_58591:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69e73
	dbw EFFECTCMDTYPE_AI, Func_69e73
	db $00

EffectCommands_58599:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69e8b
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_69ec0
	dbw EFFECTCMDTYPE_AI, Func_69e82
	db $00

EffectCommands_585a4:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69ed5
	dbw EFFECTCMDTYPE_AI, Func_69ecc
	db $00

EffectCommands_585ac:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69ef8
	db $00

EffectCommands_585b1:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69f07
	dbw EFFECTCMDTYPE_AI, Func_69efe
	db $00

EffectCommands_585b9:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69f1d
	db $00

EffectCommands_585be:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_69f33
	db $00

EffectCommands_585c3:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_69f35
	db $00

EffectCommands_585c8:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_69f37
	db $00

EffectCommands_585cd:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69f4f
	db $00

EffectCommands_585d2:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69f59
	dbw EFFECTCMDTYPE_AI, Func_69f55
	db $00

EffectCommands_585da:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69f6b
	dbw EFFECTCMDTYPE_AI, Func_69f62
	db $00

EffectCommands_585e2:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_69f83
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_69fc4
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_69f8d
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_69fab
	db $00

EffectCommands_585f0:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_69fec
	dbw EFFECTCMDTYPE_AI, Func_69fe4
	db $00

EffectCommands_585f8:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6a003
	db $00

EffectCommands_585fd:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6a009
	db $00

EffectCommands_58602:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a025
	db $00

EffectCommands_58607:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6a033
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6a02b
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, Func_6a02b
	db $00

EffectCommands_58612:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a041
	db $00

EffectCommands_58617:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6a055
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6a063
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6a059
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6a05d
	db $00

EffectCommands_58625:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a073
	db $00

EffectCommands_5862a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a082
	dbw EFFECTCMDTYPE_AI, Func_6a079
	db $00

EffectCommands_58632:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6a098
	db $00

EffectCommands_58637:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6a0a1
	db $00

EffectCommands_5863c:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6a0a3
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a0a6
	db $00

EffectCommands_58644:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a0f9
	db $00

EffectCommands_58649:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6a10b
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6a12c
	db $00

EffectCommands_58651:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a190
	db $00

EffectCommands_58656:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a19d
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6a1ac
	dbw EFFECTCMDTYPE_AI, Func_6a194
	db $00

EffectCommands_58661:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a1b6
	db $00

EffectCommands_58666:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a1c5
	dbw EFFECTCMDTYPE_AI, Func_6a1bc
	db $00

EffectCommands_5866e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a1d8
	db $00

EffectCommands_58673:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6a1dc
	db $00

EffectCommands_58678:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a1f8
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6a207
	db $00

EffectCommands_58680:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a217
	db $00

EffectCommands_58685:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6a227
	db $00

EffectCommands_5868a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a2c4
	dbw EFFECTCMDTYPE_AI, Func_6a2bb
	db $00

EffectCommands_58692:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a2d3
	dbw EFFECTCMDTYPE_AI, Func_6a2ca
	db $00

EffectCommands_5869a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a2e9
	db $00

EffectCommands_5869f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a2ef
	dbw EFFECTCMDTYPE_AI, Func_6a2ed
	db $00

EffectCommands_586a7:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a318
	db $00

EffectCommands_586ac:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a31e
	dbw EFFECTCMDTYPE_AI, Func_6a31c
	db $00

EffectCommands_586b4:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a320
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6a32f
	db $00

EffectCommands_586bc:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6a351
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6a33f
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6a343
	db $00

EffectCommands_586c7:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a366
	db $00

EffectCommands_586cc:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a36c
	db $00

EffectCommands_586d1:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a370
	db $00

EffectCommands_586d6:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a376
	db $00

EffectCommands_586db:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6a37a
	db $00

EffectCommands_586e0:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a3c0
	db $00

EffectCommands_586e5:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a3d2
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6a3e1
	db $00

EffectCommands_586ed:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6a4f7
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6a3f1
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6a49f
	db $00

EffectCommands_586f8:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a511
	db $00

EffectCommands_586fd:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6a515
	db $00

EffectCommands_58702:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a531
	dbw EFFECTCMDTYPE_AI, Func_6a531
	db $00

EffectCommands_5870a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6a537
	db $00

EffectCommands_5870f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6a553
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, Func_6a555
	db $00

EffectCommands_58717:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6a59a
	db $00

EffectCommands_5871c:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6a5a4
	db $00

EffectCommands_58721:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a63b
	dbw EFFECTCMDTYPE_AI, Func_6a63b
	db $00

EffectCommands_58729:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6a641
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6a681
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6a646
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6a67c
	db $00

EffectCommands_58737:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a6c2
	dbw EFFECTCMDTYPE_AI, Func_6a6b9
	db $00

EffectCommands_5873f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a6d8
	db $00

EffectCommands_58744:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a6dc
	db $00

EffectCommands_58749:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a6f9
	dbw EFFECTCMDTYPE_AI, Func_6a6f0
	db $00

EffectCommands_58751:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6a702
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6a705
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a711
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6a714
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6a708
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6a70b
	dbw EFFECTCMDTYPE_AI, Func_6a6ff
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, Func_6a70e
	db $00

EffectCommands_5876b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a717
	db $00

EffectCommands_58770:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6a729
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a738
	db $00

EffectCommands_58778:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a74b
	dbw EFFECTCMDTYPE_AI, Func_6a742
	db $00

EffectCommands_58780:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6a762
	db $00

EffectCommands_58785:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a764
	db $00

EffectCommands_5878a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6a771
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a782
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Func_6a77c
	dbw EFFECTCMDTYPE_AI, Func_6a768
	db $00

EffectCommands_58798:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6a78e
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6a793
	db $00

EffectCommands_587a0:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a7ba
	dbw EFFECTCMDTYPE_AI, Func_6a7b1
	db $00

EffectCommands_587a8:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a7d9
	dbw EFFECTCMDTYPE_AI, Func_6a7d0
	db $00

EffectCommands_587b0:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a7e9
	dbw EFFECTCMDTYPE_AI, Func_6a7df
	db $00

EffectCommands_587b8:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a807
	dbw EFFECTCMDTYPE_AI, Func_6a7fe
	db $00

EffectCommands_587c0:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6a81c
	db $00

EffectCommands_587c5:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a822
	dbw EFFECTCMDTYPE_AI, Func_6a81e
	db $00

EffectCommands_587cd:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6a82b
	db $00

EffectCommands_587d2:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a859
	dbw EFFECTCMDTYPE_AI, Func_6a850
	db $00

EffectCommands_587da:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6a875
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6a871
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6a873
	db $00

EffectCommands_587e5:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6a8bf
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6a8cc
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6a8c8
	db $00

EffectCommands_587f0:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a8d2
	db $00

EffectCommands_587f5:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6a8d8
	db $00

EffectCommands_587fa:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6a927
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6a91f
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, Func_6a91f
	db $00

EffectCommands_58805:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6a930
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6a933
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a93f
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6a942
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6a936
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6a939
	dbw EFFECTCMDTYPE_AI, Func_6a92d
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, Func_6a93c
	db $00

EffectCommands_5881f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a945
	db $00

EffectCommands_58824:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6a949
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6a956
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6a952
	db $00

EffectCommands_5882f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a9de
	db $00

EffectCommands_58834:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a9e2
	dbw EFFECTCMDTYPE_AI, Func_6a9e2
	db $00

EffectCommands_5883c:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6a9ed
	db $00

EffectCommands_58841:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6a9f1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6a9fc
	db $00

EffectCommands_58849:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6aa03
	db $00

EffectCommands_5884e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6aa09
	db $00

EffectCommands_58853:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6aa0f
	db $00

EffectCommands_58858:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6aa13
	db $00

EffectCommands_5885d:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6aa1f
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6aa17
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, Func_6aa17
	db $00

EffectCommands_58868:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6aa25
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6aa27
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6aa2c
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6aa29
	db $00

EffectCommands_58876:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6aa7c
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6aa7e
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6aa82
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6aa80
	db $00

EffectCommands_58884:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6ab44
	db $00

EffectCommands_58889:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6ab58
	db $00

EffectCommands_5888e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6ab5e
	dbw EFFECTCMDTYPE_AI, Func_6ab5e
	db $00

; unreferenced
EffectCommands_58896:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6ab6f
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6ab8c
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6ab77
	db $00

EffectCommands_588a1:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6aba1
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, Func_6aba3
	db $00

EffectCommands_588a9:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6abf9
	dbw EFFECTCMDTYPE_AI, Func_6abf0
	db $00

EffectCommands_588b1:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6ac31
	db $00

EffectCommands_588b6:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6ac47
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6ac4c
	db $00

EffectCommands_588be:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6ad1a
	db $00

EffectCommands_588c3:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6ad2b
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6ad31
	db $00

EffectCommands_588cb:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6ad65
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6ad6f
	db $00

EffectCommands_588d3:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6adab
	db $00

EffectCommands_588d8:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6adb1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6ade0
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6adb5
	db $00

EffectCommands_588e3:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6ae09
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6ae3a
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6ae23
	dbw EFFECTCMDTYPE_AI, Func_6ae00
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, Func_6ae10
	db $00

EffectCommands_588f4:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6ae4f
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6aef6
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6aea9
	dbw EFFECTCMDTYPE_AI, Func_6ae56
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, Func_6ae75
	db $00

EffectCommands_58905:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6af16
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6af1a
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Func_6af22
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6af1e
	db $00

EffectCommands_58913:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6af62
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6af2c
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6af27
	db $00

EffectCommands_5891e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6af82
	dbw EFFECTCMDTYPE_AI, Func_6af7e
	db $00

EffectCommands_58926:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6af8b
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6aff0
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6afc5
	dbw EFFECTCMDTYPE_AI, Func_6af8f
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, Func_6afaa
	db $00

EffectCommands_58937:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b014
	dbw EFFECTCMDTYPE_AI, Func_6b00b
	db $00

EffectCommands_5893f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b029
	db $00

EffectCommands_58944:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b02f
	dbw EFFECTCMDTYPE_AI, Func_6b02f
	db $00

EffectCommands_5894c:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b036
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6b045
	db $00

EffectCommands_58954:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6b059
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6b05e
	db $00

EffectCommands_5895c:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b07c
	dbw EFFECTCMDTYPE_AI, Func_6b07c
	db $00

EffectCommands_58964:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6b083
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6b0a4
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6b0ba
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Func_6b0b5
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6b097
	db $00

EffectCommands_58975:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6b0da
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6b131
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6b0f4
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6b115
	db $00

EffectCommands_58983:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6b149
	db $00

EffectCommands_58988:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b14b
	db $00

EffectCommands_5898d:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6b157
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6b14f
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6b153
	db $00

EffectCommands_58998:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b164
	dbw EFFECTCMDTYPE_AI, Func_6b15b
	db $00

EffectCommands_589a0:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b182
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6b184
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6b17c
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6b180
	dbw EFFECTCMDTYPE_AI, Func_6b176
	db $00

EffectCommands_589b1:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b1f3
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6b1f7
	db $00

EffectCommands_589b9:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6b208
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6b20a
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, Func_6b21b
	db $00

EffectCommands_589c4:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b23e
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6b252
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6b234
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6b238
	dbw EFFECTCMDTYPE_AI, Func_6b22e
	db $00

EffectCommands_589d5:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b267
	db $00

EffectCommands_589da:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b274
	dbw EFFECTCMDTYPE_AI, Func_6b26b
	db $00

EffectCommands_589e2:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6b278
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b27c
	db $00

EffectCommands_589ea:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b2ca
	dbw EFFECTCMDTYPE_AI, Func_6b2c1
	db $00

EffectCommands_589f2:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6b2ce
	db $00

EffectCommands_589f7:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b2d9
	dbw EFFECTCMDTYPE_AI, Func_6b2d0
	db $00

EffectCommands_589ff:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b307
	dbw EFFECTCMDTYPE_AI, Func_6b2fe
	db $00

EffectCommands_58a07:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b314
	dbw EFFECTCMDTYPE_AI, Func_6b30b
	db $00

EffectCommands_58a0f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6b324
	db $00

EffectCommands_58a14:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b32f
	dbw EFFECTCMDTYPE_AI, Func_6b326
	db $00

EffectCommands_58a1c:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b33c
	dbw EFFECTCMDTYPE_AI, Func_6b333
	db $00

EffectCommands_58a24:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b340
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6b357
	dbw EFFECTCMDTYPE_AI, Func_6b340
	db $00

EffectCommands_58a2f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b3fa
	db $00

EffectCommands_58a34:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6b40a
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6b41f
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6b40e
	db $00

EffectCommands_58a3f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b44d
	db $00

EffectCommands_58a44:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6b451
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b470
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6b463
	db $00

EffectCommands_58a4f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b4a4
	dbw EFFECTCMDTYPE_AI, Func_6b4a4
	db $00

EffectCommands_58a57:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b4c9
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6b4d4
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6b4aa
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6b4c4
	db $00

EffectCommands_58a65:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b4fd
	dbw EFFECTCMDTYPE_AI, Func_6b4fd
	db $00

EffectCommands_58a6d:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6b503
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6b53f
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6b508
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6b526
	db $00

EffectCommands_58a7b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6b54f
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6b551
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, Func_6b59e
	db $00

EffectCommands_58a86:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b5cb
	dbw EFFECTCMDTYPE_AI, Func_6b5c2
	db $00

EffectCommands_58a8e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6b5dd
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b5e1
	db $00

EffectCommands_58a96:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b626
	db $00

EffectCommands_58a9b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6b640
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b644
	dbw EFFECTCMDTYPE_AI, Func_6b62a
	db $00

EffectCommands_58aa6:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b689
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6b69d
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6b67f
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6b683
	dbw EFFECTCMDTYPE_AI, Func_6b679
	db $00

EffectCommands_58ab7:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6b6af
	db $00

EffectCommands_58abc:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b6ba
	dbw EFFECTCMDTYPE_AI, Func_6b6b1
	db $00

EffectCommands_58ac4:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6b6d4
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6b6df
	db $00

EffectCommands_58acc:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b6f2
	dbw EFFECTCMDTYPE_AI, Func_6b6e9
	db $00

EffectCommands_58ad4:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6b6f8
	db $00

EffectCommands_58ad9:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b717
	dbw EFFECTCMDTYPE_AI, Func_6b6fa
	db $00

EffectCommands_58ae1:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6b724
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b73f
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6b728
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6b739
	db $00

EffectCommands_58aef:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6b77b
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6b773
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, Func_6b773
	db $00

EffectCommands_58afa:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6b781
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6b785
	db $00

EffectCommands_58b02:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6b7cc
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b7d5
	db $00

EffectCommands_58b0a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b82c
	dbw EFFECTCMDTYPE_AI, Func_6b823
	db $00

EffectCommands_58b12:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b83b
	dbw EFFECTCMDTYPE_AI, Func_6b832
	db $00

EffectCommands_58b1a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6b84d
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b880
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6b8a1
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6b857
	dbw EFFECTCMDTYPE_AI, Func_6b851
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, Func_6b871
	db $00

EffectCommands_58b2e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6b8bc
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b8c2
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6b8c4
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6b8be
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6b8c0
	db $00

EffectCommands_58b3f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b927
	dbw EFFECTCMDTYPE_AI, Func_6b91e
	db $00

EffectCommands_58b47:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b92b
	db $00

EffectCommands_58b4c:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6b931
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6b935
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6b93d
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6b939
	db $00

EffectCommands_58b5a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b941
	db $00

EffectCommands_58b5f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b945
	db $00

EffectCommands_58b64:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6b949
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b971
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6b952
	db $00

EffectCommands_58b6f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6b99a
	dbw EFFECTCMDTYPE_AI, Func_6b991
	db $00

EffectCommands_58b77:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6b9a0
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6b9a2
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, Func_6ba36
	db $00

EffectCommands_58b82:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6ba69
	dbw EFFECTCMDTYPE_AI, Func_6ba60
	db $00

EffectCommands_58b8a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6ba7b
	dbw EFFECTCMDTYPE_AI, Func_6ba7b
	db $00

EffectCommands_58b92:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6ba9e
	dbw EFFECTCMDTYPE_AI, Func_6ba9e
	db $00

EffectCommands_58b9a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6bae8
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6babb
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6baa4
	db $00

EffectCommands_58ba5:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6bb51
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bb60
	dbw EFFECTCMDTYPE_UNK_11, Func_6bbd7
	db $00

EffectCommands_58bb0:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bbe6
	db $00

EffectCommands_58bb5:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bbec
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6bbf9
	db $00

EffectCommands_58bbd:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_64000
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_64009
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64022
	db $00

EffectCommands_58bc8:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6405e
	db $00

EffectCommands_58bcd:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64098
	db $00

EffectCommands_58bd2:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_64120
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64143
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_64125
	db $00

EffectCommands_58bdd:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64162
	db $00

EffectCommands_58be2:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_641ba
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6416b
	db $00

EffectCommands_58bea:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_641d0
	db $00

EffectCommands_58bef:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_641d6
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64221
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_641dd
	db $00

EffectCommands_58bfa:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, Func_6427d
	db $00

EffectCommands_58bff:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, Func_6428b
	db $00

EffectCommands_58c04:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, Func_6429d
	db $00

EffectCommands_58c09:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64352
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_642aa
	db $00

EffectCommands_58c11:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_643b4
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_643bf
	db $00

EffectCommands_58c19:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bc0c
	dbw EFFECTCMDTYPE_AI, Func_6bc03
	db $00

EffectCommands_58c21:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_643ce
	db $00

EffectCommands_58c26:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_643d5
	db $00

EffectCommands_58c2b:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_643dc
	db $00

EffectCommands_58c30:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bc10
	db $00

EffectCommands_58c35:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bc1d
	dbw EFFECTCMDTYPE_AI, Func_6bc14
	db $00

EffectCommands_58c3d:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_643de
	db $00

EffectCommands_58c42:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_643ea
	dbw EFFECTCMDTYPE_AI, Func_643e0
	db $00

EffectCommands_58c4a:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_643f1
	db $00

EffectCommands_58c4f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bc21
	db $00

EffectCommands_58c54:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6440b
	db $00

EffectCommands_58c59:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64421
	db $00

EffectCommands_58c5e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bc2e
	dbw EFFECTCMDTYPE_AI, Func_6bc25
	db $00

EffectCommands_58c66:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6443b
	db $00

EffectCommands_58c6b:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6444c
	dbw EFFECTCMDTYPE_AI, Func_64442
	db $00

EffectCommands_58c73:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_64461
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_64486
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_64466
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, Func_6447f
	db $00

EffectCommands_58c81:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bc32
	db $00

EffectCommands_58c86:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6449a
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64502
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_644b5
	db $00

EffectCommands_58c91:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6451c
	db $00

EffectCommands_58c96:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bc36
	db $00

EffectCommands_58c9b:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_64523
	db $00

EffectCommands_58ca0:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6452e
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_64538
	db $00

EffectCommands_58ca8:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_64542
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_64589
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6454c
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6456d
	db $00

EffectCommands_58cb6:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bc43
	dbw EFFECTCMDTYPE_AI, Func_6bc3a
	db $00

EffectCommands_58cbe:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_645ad
	db $00

EffectCommands_58cc3:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bc47
	db $00

EffectCommands_58cc8:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_645b8
	db $00

EffectCommands_58ccd:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bc4b
	db $00

EffectCommands_58cd2:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_645cb
	dbw EFFECTCMDTYPE_AI, Func_645cb
	db $00

EffectCommands_58cda:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_645e6
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_645fc
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_645da
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_645df
	dbw EFFECTCMDTYPE_AI, Func_645d3
	db $00

EffectCommands_58ceb:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64613
	db $00

EffectCommands_58cf0:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_646be
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6466a
	dbw EFFECTCMDTYPE_AI, Func_6461a
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, Func_64636
	db $00

EffectCommands_58cfe:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_646df
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_646d6
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, Func_646d6
	db $00

EffectCommands_58d09:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_646e6
	db $00

EffectCommands_58d0e:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_646f7
	dbw EFFECTCMDTYPE_AI, Func_646ed
	db $00

EffectCommands_58d16:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bc4f
	db $00

EffectCommands_58d1b:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64719
	dbw EFFECTCMDTYPE_AI, Func_6470f
	db $00

EffectCommands_58d23:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bc53
	db $00

EffectCommands_58d28:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6472a
	dbw EFFECTCMDTYPE_AI, Func_64720
	db $00

EffectCommands_58d30:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_64742
	db $00

EffectCommands_58d35:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6474e
	dbw EFFECTCMDTYPE_AI, Func_64744
	db $00

EffectCommands_58d3d:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6476f
	dbw EFFECTCMDTYPE_AI, Func_64765
	db $00

EffectCommands_58d45:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64780
	dbw EFFECTCMDTYPE_AI, Func_64776
	db $00

EffectCommands_58d4d:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6479f
	dbw EFFECTCMDTYPE_AI, Func_64795
	db $00

EffectCommands_58d55:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_647b6
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_647bb
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_647c5
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_647c0
	db $00

EffectCommands_58d63:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_647ca
	db $00

EffectCommands_58d68:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_647cc
	db $00

EffectCommands_58d6d:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_647db
	dbw EFFECTCMDTYPE_AI, Func_647db
	db $00

EffectCommands_58d75:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_64813
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6481f
	db $00

EffectCommands_58d7d:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6485b
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_648fc
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6489d
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, Func_6486c
	db $00

EffectCommands_58d8b:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_64930
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64958
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6493a
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_64935
	db $00

EffectCommands_58d99:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_64977
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6498a
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_649d9
	db $00

EffectCommands_58da4:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_64a03
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64a4f
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_64a08
	db $00

EffectCommands_58daf:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_64a75
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_64a77
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64a8e
	db $00

EffectCommands_58dba:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_64ade
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64ade
	db $00

EffectCommands_58dc2:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_64ae3
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64b30
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_64af3
	db $00

EffectCommands_58dcd:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64b75
	dbw EFFECTCMDTYPE_AI, Func_64b6b
	db $00

EffectCommands_58dd5:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64b96
	dbw EFFECTCMDTYPE_AI, Func_64b8c
	db $00

EffectCommands_58ddd:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64ba7
	dbw EFFECTCMDTYPE_AI, Func_64b9d
	db $00

EffectCommands_58de5:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_64bbc
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64c3a
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_64c5b
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_64bf1
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_64c10
	db $00

EffectCommands_58df6:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bc57
	db $00

EffectCommands_58dfb:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bc64
	dbw EFFECTCMDTYPE_AI, Func_6bc5b
	db $00

EffectCommands_58e03:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64c8d
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_64c92
	dbw EFFECTCMDTYPE_AI, Func_64c88
	db $00

EffectCommands_58e0e:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_64d2d
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_64d00
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_64ce6
	db $00

EffectCommands_58e19:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64d57
	db $00

EffectCommands_58e1e:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64d6a
	db $00

EffectCommands_58e23:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_64d86
	db $00

EffectCommands_58e28:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64d97
	dbw EFFECTCMDTYPE_AI, Func_64d8d
	db $00

EffectCommands_58e30:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64da8
	dbw EFFECTCMDTYPE_AI, Func_64d9e
	db $00

EffectCommands_58e38:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_64dcc
	db $00

EffectCommands_58e3d:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_64ddb
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64e4d
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_64dee
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_64e27
	db $00

EffectCommands_58e4b:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64e8a
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_64ea0
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_64e85
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_64e7e
	dbw EFFECTCMDTYPE_AI, Func_64e77
	db $00

EffectCommands_58e5c:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_64eb7
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64f1f
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_64f35
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_64ef0
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_64ec3
	dbw EFFECTCMDTYPE_AI, Func_64ebc
	db $00

EffectCommands_58e70:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64f71
	db $00

EffectCommands_58e75:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bc68
	db $00

EffectCommands_58e7a:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64f78
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_64f88
	db $00

EffectCommands_58e82:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bc6c
	db $00

EffectCommands_58e87:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64f95
	dbw EFFECTCMDTYPE_AI, Func_64f95
	db $00

EffectCommands_58e8f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bc70
	db $00

EffectCommands_58e94:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64f9d
	db $00

EffectCommands_58e99:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bc74
	db $00

EffectCommands_58e9e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bc78
	db $00

EffectCommands_58ea3:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64fac
	dbw EFFECTCMDTYPE_AI, Func_64fac
	db $00

EffectCommands_58eab:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_64fe8
	dbw EFFECTCMDTYPE_AI, Func_64fde
	db $00

EffectCommands_58eb3:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bc7c
	db $00

EffectCommands_58eb8:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_65002
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6504d
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_65020
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_65007
	db $00

EffectCommands_58ec6:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bc80
	db $00

EffectCommands_58ecb:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bc84
	db $00

EffectCommands_58ed0:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bc88
	db $00

EffectCommands_58ed5:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_65064
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65069
	db $00

EffectCommands_58edd:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6507a
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_650b8
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_65083
	db $00

EffectCommands_58ee8:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6511e
	dbw EFFECTCMDTYPE_AI, Func_65114
	db $00

EffectCommands_58ef0:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bc8c
	db $00

EffectCommands_58ef5:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_65125
	db $00

EffectCommands_58efa:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_65136
	db $00

EffectCommands_58eff:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bc90
	db $00

EffectCommands_58f04:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_65138
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_65182
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_65167
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6513d
	db $00

EffectCommands_58f12:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6519e
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_651af
	dbw EFFECTCMDTYPE_AI, Func_65194
	db $00

EffectCommands_58f1d:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_651b9
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_651f3
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65218
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6521b
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_65210
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_65212
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, Func_65215
	db $00

EffectCommands_58f34:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6535f
	db $00

EffectCommands_58f39:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_653df
	dbw EFFECTCMDTYPE_AI, Func_653d5
	db $00

EffectCommands_58f41:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bc94
	db $00

EffectCommands_58f46:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6540d
	dbw EFFECTCMDTYPE_AI, Func_653fc
	db $00

EffectCommands_58f4e:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65415
	db $00

EffectCommands_58f53:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65438
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_65451
	dbw EFFECTCMDTYPE_AI, Func_6542e
	db $00

EffectCommands_58f5e:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6545a
	dbw EFFECTCMDTYPE_AI, Func_6545a
	db $00

EffectCommands_58f66:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6548c
	dbw EFFECTCMDTYPE_AI, Func_65482
	db $00

EffectCommands_58f6e:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_654b0
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_654c7
	dbw EFFECTCMDTYPE_AI, Func_654a6
	db $00

EffectCommands_58f79:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_654f2
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_654d8
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_654d1
	db $00

EffectCommands_58f84:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6553a
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65563
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_65552
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_65543
	db $00

EffectCommands_58f92:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bc98
	db $00

EffectCommands_58f97:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65578
	dbw EFFECTCMDTYPE_AI, Func_65578
	db $00

EffectCommands_58f9f:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6558a
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_655de
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_655e7
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_65593
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_655bb
	db $00

EffectCommands_58fb0:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6560a
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6560f
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Func_65619
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_65614
	db $00

EffectCommands_58fbe:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6561f
	dbw EFFECTCMDTYPE_AI, Func_6561f
	db $00

EffectCommands_58fc6:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65636
	db $00

EffectCommands_58fcb:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6563d
	dbw EFFECTCMDTYPE_AI, Func_6563d
	db $00

EffectCommands_58fd3:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_65648
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6567e
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_65697
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Func_65654
	dbw EFFECTCMDTYPE_AI, Func_65665
	db $00

EffectCommands_58fe4:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bc9c
	db $00

EffectCommands_58fe9:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_656f6
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65739
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6573e
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_65702
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_65728
	dbw EFFECTCMDTYPE_AI, Func_656fb
	db $00

EffectCommands_58ffd:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6578e
	dbw EFFECTCMDTYPE_AI, Func_65779
	db $00

EffectCommands_59005:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_657b6
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_657ad
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, Func_657ad
	db $00

EffectCommands_59010:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_657bd
	db $00

EffectCommands_59015:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bca0
	db $00

EffectCommands_5901a:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_657d2
	db $00

EffectCommands_5901f:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_65816
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_65852
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_65822
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_65839
	db $00

EffectCommands_5902d:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6585b
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6588a
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_65860
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_65875
	db $00

EffectCommands_5903b:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_659e7
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65ac2
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_65af7
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_659f5
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_659f1
	dbw EFFECTCMDTYPE_AI, Func_659ca
	db $00

EffectCommands_5904f:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_65b5d
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65ba3
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_65b81
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_65b6d
	dbw EFFECTCMDTYPE_AI, Func_65b62
	db $00

EffectCommands_59060:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_65bb0
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65bb7
	db $00

EffectCommands_59068:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_65bc6
	db $00

EffectCommands_5906d:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65bdb
	db $00

EffectCommands_59072:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bca4
	db $00

EffectCommands_59077:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65bed
	dbw EFFECTCMDTYPE_AI, Func_65be3
	db $00

EffectCommands_5907f:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65c41
	db $00

EffectCommands_59084:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bca8
	db $00

EffectCommands_59089:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65c54
	dbw EFFECTCMDTYPE_AI, Func_65c54
	db $00

EffectCommands_59091:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_65c6a
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_65c70
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, Func_65c91
	db $00

EffectCommands_5909c:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65cde
	db $00

EffectCommands_590a1:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_65cf1
	db $00

EffectCommands_590a6:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65cf3
	db $00

; unreferenced
EffectCommands_590ab:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65cf9
	db $00

EffectCommands_590b0:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_65d04
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65d63
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_65d6b
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_65d11
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_65d0d
	db $00

EffectCommands_590c1:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65d8a
	db $00

EffectCommands_590c6:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_65d91
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65de4
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_65df4
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_65db7
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_65da0
	dbw EFFECTCMDTYPE_AI, Func_65d96
	db $00

EffectCommands_590da:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_65e0f
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65e14
	db $00

EffectCommands_590e2:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_65e28
	db $00

EffectCommands_590e7:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_65e3a
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_65e3f
	db $00

EffectCommands_590ef:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65e7f
	dbw EFFECTCMDTYPE_AI, Func_65e75
	db $00

EffectCommands_590f7:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65e90
	dbw EFFECTCMDTYPE_AI, Func_65e86
	db $00

EffectCommands_590ff:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65ea9
	db $00

EffectCommands_59104:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65ec2
	dbw EFFECTCMDTYPE_AI, Func_65ec2
	db $00

EffectCommands_5910c:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_65ee0
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_65eca
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_65ed5
	db $00

EffectCommands_59117:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_65f06
	db $00

EffectCommands_5911c:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_65f0c
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65f13
	db $00

EffectCommands_59124:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65fa2
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_65f32
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_65f2d
	dbw EFFECTCMDTYPE_AI, Func_65f1a
	db $00

EffectCommands_59132:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_65fbb
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65fdd
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_65fe8
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_65fca
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_65fca
	dbw EFFECTCMDTYPE_AI, Func_65fc0
	db $00

EffectCommands_59146:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_65ff3
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_65fff
	db $00

EffectCommands_5914e:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6603a
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66049
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_66059
	db $00

EffectCommands_59159:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6607f
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66086
	db $00

EffectCommands_59161:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_660a0
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_660b1
	db $00

EffectCommands_59169:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_660e0
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6611c
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_660ec
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_66103
	db $00

EffectCommands_59177:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_66125
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66134
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_66139
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6612f
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6612a
	db $00

EffectCommands_59188:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bcb5
	dbw EFFECTCMDTYPE_AI, Func_6bcac
	db $00

EffectCommands_59190:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6613e
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66143
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_66157
	db $00

EffectCommands_5919b:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6617b
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_66187
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_661a6
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_66180
	db $00

EffectCommands_591a9:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_661cc
	dbw EFFECTCMDTYPE_AI, Func_661c2
	db $00

EffectCommands_591b1:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_661e4
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_661ee
	db $00

EffectCommands_591b9:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_66223
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6627e
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6621f
	dbw EFFECTCMDTYPE_AI, Func_66202
	db $00

EffectCommands_591c7:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6629a
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_66315
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_662c4
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, Func_662c0
	db $00

EffectCommands_591d5:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66358
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6636e
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6634c
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_66351
	dbw EFFECTCMDTYPE_AI, Func_66345
	db $00

EffectCommands_591e6:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_66385
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_663c1
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6638a
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_663a8
	db $00

EffectCommands_591f4:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_663d2
	db $00

EffectCommands_591f9:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_663ec
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_663fd
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Func_663f7
	db $00

EffectCommands_59204:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66415
	dbw EFFECTCMDTYPE_AI, Func_6640b
	db $00

EffectCommands_5920c:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66436
	dbw EFFECTCMDTYPE_AI, Func_6642c
	db $00

EffectCommands_59214:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6643d
	db $00

EffectCommands_59219:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6654e
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6643f
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_664f6
	db $00

EffectCommands_59224:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_66570
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_665a4
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6657a
	db $00

EffectCommands_5922f:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_665c1
	dbw EFFECTCMDTYPE_AI, Func_665b7
	db $00

EffectCommands_59237:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_665e0
	dbw EFFECTCMDTYPE_AI, Func_665d6
	db $00

EffectCommands_5923f:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66601
	dbw EFFECTCMDTYPE_AI, Func_665f7
	db $00

EffectCommands_59247:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6661a
	db $00

EffectCommands_5924c:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_66621
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6663e
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_66634
	db $00

EffectCommands_59257:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66672
	dbw EFFECTCMDTYPE_AI, Func_66672
	db $00

EffectCommands_5925f:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6667a
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6667f
	db $00

EffectCommands_59267:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_66684
	db $00

EffectCommands_5926c:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bcc2
	dbw EFFECTCMDTYPE_AI, Func_6bcb9
	db $00

EffectCommands_59274:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bcc6
	db $00

EffectCommands_59279:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6669c
	dbw EFFECTCMDTYPE_AI, Func_66692
	db $00

EffectCommands_59281:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_666a3
	db $00

EffectCommands_59286:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bcca
	db $00

EffectCommands_5928b:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_666bd
	dbw EFFECTCMDTYPE_AI, Func_666b3
	db $00

EffectCommands_59293:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_666df
	dbw EFFECTCMDTYPE_AI, Func_666d5
	db $00

EffectCommands_5929b:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66700
	dbw EFFECTCMDTYPE_AI, Func_666f6
	db $00

EffectCommands_592a3:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_66715
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6671a
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Func_66724
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_6671f
	db $00

EffectCommands_592b1:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_6672a
	db $00

EffectCommands_592b6:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bcd7
	dbw EFFECTCMDTYPE_AI, Func_6bcce
	db $00

EffectCommands_592be:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6bcdb
	db $00

EffectCommands_592c3:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_66730
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66767
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_66739
	db $00

EffectCommands_592ce:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_667b8
	db $00

EffectCommands_592d3:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_667e6
	db $00

EffectCommands_592d8:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_667e8
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_667f7
	db $00

EffectCommands_592e0:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66829
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_66833
	db $00

EffectCommands_592e8:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6688d
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_668a5
	db $00

EffectCommands_592f0:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_668ef
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_66902
	db $00

EffectCommands_592f8:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6696c
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66974
	db $00

EffectCommands_59300:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_669da
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_669e9
	db $00

EffectCommands_59308:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66a62
	db $00

EffectCommands_5930d:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_66a69
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_66a70
	db $00

EffectCommands_59315:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_66a77
	db $00

EffectCommands_5931a:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66a96
	db $00

EffectCommands_5931f:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66abc
	dbw EFFECTCMDTYPE_AI, Func_66ab2
	db $00

EffectCommands_59327:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_66ad3
	db $00

EffectCommands_5932c:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_66b1c
	db $00

EffectCommands_59331:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66b2a
	dbw EFFECTCMDTYPE_AI, Func_66b1e
	db $00

EffectCommands_59339:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_66b63
	db $00

EffectCommands_5933e:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Func_66b65
	db $00

EffectCommands_59343:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66bac
	db $00

EffectCommands_59348:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66bd1
	dbw EFFECTCMDTYPE_AI, Func_66bca
	db $00

EffectCommands_59350:
	db $19 ; effect bank
	db $00

EffectCommands_59352:
	db $19 ; effect bank
	db $00

EffectCommands_59354:
	db $19 ; effect bank
	db $00

EffectCommands_59356:
	db $19 ; effect bank
	db $00

EffectCommands_59358:
	db $19 ; effect bank
	db $00

EffectCommands_5935a:
	db $19 ; effect bank
	db $00

EffectCommands_5935c:
	db $19 ; effect bank
	db $00

EffectCommands_5935e:
	db $19 ; effect bank
	db $00

EffectCommands_59360:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_66bf3
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_66c02
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66c50
	db $00

EffectCommands_5936b:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66caf
	db $00

EffectCommands_59370:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_66cce
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_66cdb
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66cf0
	dbw EFFECTCMDTYPE_AI_SELECTION, Func_66ceb
	db $00

EffectCommands_5937e:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_66d0c
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_66d1d
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66d79
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_66d36
	db $00

EffectCommands_5938c:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_66d9d
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66dc5
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_66da7
	db $00

EffectCommands_59397:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66df4
	db $00

EffectCommands_5939c:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_66e1e
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_66e26
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66e44
	db $00

EffectCommands_593a7:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66e4e
	db $00

EffectCommands_593ac:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_66e92
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_66ea0
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66eba
	db $00

EffectCommands_593b7:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_66edf
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66ef0
	db $00

EffectCommands_593bf:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_66f09
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66f0e
	db $00

EffectCommands_593c7:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_66f14
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66f1e
	db $00

EffectCommands_593cf:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66f2c
	db $00

EffectCommands_593d4:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_66f5f
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_66f72
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66f8d
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_66f76
	db $00

EffectCommands_593e2:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_66fa9
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66fae
	db $00

EffectCommands_593ea:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_66fb4
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_66fb9
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_66fca
	db $00

EffectCommands_593f5:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_67018
	db $00

EffectCommands_593fa:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_67024
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_67029
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6703a
	db $00

EffectCommands_59405:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_67041
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_67049
	db $00

EffectCommands_5940d:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_67086
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6709c
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_670ba
	db $00

EffectCommands_59418:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_670de
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_670ec
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6711f
	db $00

EffectCommands_59423:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_671bc
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_671c1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_671e4
	db $00

EffectCommands_5942e:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6724b
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6725b
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_672b0
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_67276
	db $00

EffectCommands_5943c:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_67302
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_673c7
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_6730c
	db $00

EffectCommands_59447:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_673e1
	db $00

EffectCommands_5944c:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_67406
	db $00

EffectCommands_59451:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_67493
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6749c
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_674a6
	db $00

EffectCommands_5945c:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_674c6
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_674f8
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_674d0
	db $00

EffectCommands_59467:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_67519
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6754f
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_67527
	db $00

EffectCommands_59472:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_67567
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_67571
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6758f
	db $00

EffectCommands_5947d:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_675b3
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_675ca
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_67640
	db $00

EffectCommands_59488:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_67678
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_6768c
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6771e
	db $00

EffectCommands_59493:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_67751
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_67762
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_677a8
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Func_67766
	db $00

EffectCommands_594a1:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Func_6780e
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Func_67813
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Func_6782a
	db $00

INCLUDE "data/decks.asm"
