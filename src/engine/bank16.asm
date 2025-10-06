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
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $475c
	dbw EFFECTCMDTYPE_AI, $4753
	db $00

EffectCommands_58008:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $476e
	db $00

EffectCommands_5800d:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $4772
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $478e
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $4776
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, $4776
	db $00

EffectCommands_5801b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $47a1
	dbw EFFECTCMDTYPE_AI, $4798
	db $00

EffectCommands_58023:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $47ae
	dbw EFFECTCMDTYPE_AI, $47a5
	db $00

EffectCommands_5802b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $47b2
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $47d5
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $47b6
	dbw EFFECTCMDTYPE_AI_SELECTION, $47cf
	db $00

EffectCommands_58039:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $47e9
	db $00

EffectCommands_5803e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $47f6
	db $00

EffectCommands_58043:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $47fa
	db $00

EffectCommands_58048:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4807
	dbw EFFECTCMDTYPE_AI, $47fe
	db $00

EffectCommands_58050:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $480b
	db $00

EffectCommands_58055:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4818
	db $00

EffectCommands_5805a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4835
	dbw EFFECTCMDTYPE_AI, $482c
	db $00

EffectCommands_58062:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $4839
	db $00

EffectCommands_58067:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4843
	db $00

EffectCommands_5806c:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $4847
	db $00

EffectCommands_58071:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4851
	db $00

EffectCommands_58076:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4857
	db $00

EffectCommands_5807b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $485b
	db $00

EffectCommands_58080:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $486e
	dbw EFFECTCMDTYPE_AI, $4865
	db $00

EffectCommands_58088:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $488f
	dbw EFFECTCMDTYPE_AI, $4886
	db $00

EffectCommands_58090:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4893
	db $00

EffectCommands_58095:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $4897
	db $00

EffectCommands_5809a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $48ac
	dbw EFFECTCMDTYPE_AI, $48a4
	db $00

EffectCommands_580a2:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $48b8
	db $00

EffectCommands_580a7:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $48cc
	db $00

EffectCommands_580ac:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $48d0
	db $00

EffectCommands_580b1:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $48d4
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $491b
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $48de
	dbw EFFECTCMDTYPE_AI_SELECTION, $48ff
	db $00

EffectCommands_580bf:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $493b
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $495b
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $493f
	dbw EFFECTCMDTYPE_AI_SELECTION, $4952
	db $00

EffectCommands_580cd:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4985
	dbw EFFECTCMDTYPE_AI, $4966
	db $00

EffectCommands_580d5:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $49b5
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $49c4
	dbw EFFECTCMDTYPE_AI, $49ac
	db $00

EffectCommands_580e0:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $49d6
	dbw EFFECTCMDTYPE_AI, $49ce
	db $00

EffectCommands_580e8:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $49da
	db $00

EffectCommands_580ed:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4a07
	dbw EFFECTCMDTYPE_AI, $49fe
	db $00

EffectCommands_580f5:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $4a1c
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $4a5d
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $4a26
	dbw EFFECTCMDTYPE_AI_SELECTION, $4a44
	db $00

EffectCommands_58103:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4a86
	dbw EFFECTCMDTYPE_AI, $4a7d
	db $00

EffectCommands_5810b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4a9c
	db $00

EffectCommands_58110:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4aa9
	dbw EFFECTCMDTYPE_AI, $4aa0
	db $00

EffectCommands_58118:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4aca
	dbw EFFECTCMDTYPE_AI, $4ac1
	db $00

EffectCommands_58120:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $4aea
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $4ae2
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, $4ae2
	db $00

EffectCommands_5812b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $4af0
	db $00

EffectCommands_58130:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4b08
	db $00

EffectCommands_58135:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4b0c
	db $00

EffectCommands_5813a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4b19
	dbw EFFECTCMDTYPE_AI, $4b10
	db $00

EffectCommands_58142:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4b26
	dbw EFFECTCMDTYPE_AI, $4b1d
	db $00

EffectCommands_5814a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $4b2a
	db $00

EffectCommands_5814f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $4b37
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4b3b
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $4b39
	dbw EFFECTCMDTYPE_UNK_11, $4b3d
	db $00

EffectCommands_5815d:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $4c52
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4c58
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $4c55
	dbw EFFECTCMDTYPE_UNK_11, $4c5b
	db $00

EffectCommands_5816b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4c5d
	db $00

EffectCommands_58170:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4c61
	db $00

EffectCommands_58175:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $4c67
	db $00

EffectCommands_5817a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4c72
	dbw EFFECTCMDTYPE_AI, $4c69
	db $00

EffectCommands_58182:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $4c76
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $4cbd
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $4c80
	dbw EFFECTCMDTYPE_AI_SELECTION, $4ca1
	db $00

EffectCommands_58190:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4ce6
	dbw EFFECTCMDTYPE_AI, $4cdd
	db $00

EffectCommands_58198:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $4cea
	db $00

EffectCommands_5819d:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $4d06
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4d44
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $4d09
	db $00

EffectCommands_581a8:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4d6b
	dbw EFFECTCMDTYPE_AI, $4d63
	db $00

EffectCommands_581b0:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4d7f
	db $00

EffectCommands_581b5:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4d8c
	dbw EFFECTCMDTYPE_AI, $4d83
	db $00

EffectCommands_581bd:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $4d90
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4d9b
	db $00

EffectCommands_581c5:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4dfc
	dbw EFFECTCMDTYPE_AI, $4df3
	db $00

EffectCommands_581cd:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4e1c
	db $00

EffectCommands_581d2:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4e29
	dbw EFFECTCMDTYPE_AI, $4e20
	db $00

EffectCommands_581da:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $4e2d
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4e44
	db $00

EffectCommands_581e2:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $4e70
	db $00

EffectCommands_581e7:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4ed8
	dbw EFFECTCMDTYPE_AI, $4ed8
	db $00

EffectCommands_581ef:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4ee6
	dbw EFFECTCMDTYPE_AI, $4edd
	db $00

EffectCommands_581f7:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $4efe
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4f08
	db $00

EffectCommands_581ff:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4f10
	dbw EFFECTCMDTYPE_AI, $4f10
	db $00

EffectCommands_58207:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4f16
	db $00

EffectCommands_5820c:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $4f2a
	db $00

EffectCommands_58211:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4f2c
	dbw EFFECTCMDTYPE_AI, $4f2c
	db $00

EffectCommands_58219:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $4f32
	db $00

EffectCommands_5821e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4f34
	dbw EFFECTCMDTYPE_AI, $4f34
	db $00

EffectCommands_58226:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4f36
	db $00

EffectCommands_5822b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4f3e
	dbw EFFECTCMDTYPE_AI, $4f3a
	db $00

EffectCommands_58233:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $4f47
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $4f8e
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $4f51
	dbw EFFECTCMDTYPE_AI_SELECTION, $4f72
	db $00

EffectCommands_58241:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4fb2
	dbw EFFECTCMDTYPE_AI, $4fae
	db $00

EffectCommands_58249:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4fbb
	db $00

EffectCommands_5824e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4fcc
	dbw EFFECTCMDTYPE_AI, $4fc3
	db $00

EffectCommands_58256:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4fe1
	db $00

EffectCommands_5825b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $4feb
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $4fe5
	dbw EFFECTCMDTYPE_AI_SELECTION, $4fe8
	db $00

EffectCommands_58266:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4fee
	dbw EFFECTCMDTYPE_AI, $4fee
	db $00

EffectCommands_5826e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4ff4
	db $00

EffectCommands_58273:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5006
	db $00

EffectCommands_58278:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $500a
	db $00

EffectCommands_5827d:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5027
	dbw EFFECTCMDTYPE_AI, $501e
	db $00

EffectCommands_58285:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $502d
	dbw EFFECTCMDTYPE_AI, $502d
	db $00

EffectCommands_5828d:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5033
	db $00

EffectCommands_58292:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5037
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $5052
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5076
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, $5070
	dbw EFFECTCMDTYPE_AI_SELECTION, $5065
	db $00

EffectCommands_582a3:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5082
	db $00

EffectCommands_582a8:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5086
	db $00

EffectCommands_582ad:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $508a
	db $00

EffectCommands_582b2:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $509e
	db $00

EffectCommands_582b7:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $50a4
	db $00

EffectCommands_582bc:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $50b1
	dbw EFFECTCMDTYPE_AI, $50a8
	db $00

EffectCommands_582c4:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $50b5
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $50b9
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $50c1
	dbw EFFECTCMDTYPE_AI_SELECTION, $50bd
	db $00

EffectCommands_582d2:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5112
	dbw EFFECTCMDTYPE_AI, $5109
	db $00

EffectCommands_582da:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $512a
	dbw EFFECTCMDTYPE_AI, $512a
	db $00

EffectCommands_582e2:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5136
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $5130
	dbw EFFECTCMDTYPE_AI_SELECTION, $5133
	db $00

EffectCommands_582ed:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5139
	dbw EFFECTCMDTYPE_AI, $5139
	db $00

EffectCommands_582f5:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5149
	dbw EFFECTCMDTYPE_AI, $513f
	db $00

EffectCommands_582fd:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $516b
	dbw EFFECTCMDTYPE_AI, $5162
	db $00

EffectCommands_58305:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5183
	db $00

EffectCommands_5830a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5187
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5190
	db $00

EffectCommands_58312:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $51aa
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $51d9
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $51c4
	db $00

EffectCommands_5831d:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $51ff
	dbw EFFECTCMDTYPE_AI, $51ff
	db $00

EffectCommands_58325:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5205
	db $00

EffectCommands_5832a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5209
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, $520b
	db $00

EffectCommands_58332:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5250
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5255
	db $00

EffectCommands_5833a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5266
	db $00

EffectCommands_5833f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $529a
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $529d
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, $52a3
	dbw EFFECTCMDTYPE_AI_SELECTION, $52a0
	db $00

EffectCommands_5834d:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $52a9
	db $00

EffectCommands_58352:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $52b8
	dbw EFFECTCMDTYPE_AI, $52af
	db $00

EffectCommands_5835a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $52be
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $52c6
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5306
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, $52f7
	dbw EFFECTCMDTYPE_AI_SELECTION, $52ee
	dbw EFFECTCMDTYPE_AI, $5302
	db $00

EffectCommands_5836e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5318
	dbw EFFECTCMDTYPE_AI, $530f
	db $00

EffectCommands_58376:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $531e
	db $00

EffectCommands_5837b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5330
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5353
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $5334
	dbw EFFECTCMDTYPE_AI_SELECTION, $534d
	db $00

EffectCommands_58389:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5367
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $536a
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, $5370
	dbw EFFECTCMDTYPE_AI_SELECTION, $536d
	db $00

EffectCommands_58397:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5376
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $5379
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, $537f
	dbw EFFECTCMDTYPE_AI_SELECTION, $537c
	db $00

EffectCommands_583a5:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5385
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $5393
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $53e6
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, $53d8
	dbw EFFECTCMDTYPE_AI_SELECTION, $53d3
	db $00

EffectCommands_583b6:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5424
	dbw EFFECTCMDTYPE_AI, $541b
	db $00

EffectCommands_583be:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5443
	dbw EFFECTCMDTYPE_AI, $543a
	db $00

EffectCommands_583c6:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5449
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $544c
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, $5452
	dbw EFFECTCMDTYPE_AI_SELECTION, $544f
	db $00

EffectCommands_583d4:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5458
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $545b
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, $5461
	dbw EFFECTCMDTYPE_AI_SELECTION, $545e
	db $00

EffectCommands_583e2:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5467
	db $00

EffectCommands_583e7:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5476
	dbw EFFECTCMDTYPE_AI, $546d
	db $00

EffectCommands_583ef:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $547a
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $547d
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, $5483
	dbw EFFECTCMDTYPE_AI_SELECTION, $5480
	db $00

EffectCommands_583fd:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5489
	db $00

EffectCommands_58402:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $548b
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $548d
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, $548f
	dbw EFFECTCMDTYPE_AI_SELECTION, $5491
	db $00

EffectCommands_58410:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $550c
	db $00

EffectCommands_58415:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $550e
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $5511
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, $5513
	dbw EFFECTCMDTYPE_AI_SELECTION, $5515
	db $00

EffectCommands_58423:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5517
	db $00

EffectCommands_58428:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $551f
	dbw EFFECTCMDTYPE_AI, $551b
	db $00

EffectCommands_58430:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5528
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $553f
	db $00

EffectCommands_58438:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $55a4
	dbw EFFECTCMDTYPE_AI, $559b
	db $00

EffectCommands_58440:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $55b9
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, $55bb
	db $00

EffectCommands_58448:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5670
	dbw EFFECTCMDTYPE_AI, $5667
	db $00

EffectCommands_58450:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5708
	db $00

EffectCommands_58455:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $570c
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $57b4
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $572f
	db $00

EffectCommands_58460:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5816
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $5804
	dbw EFFECTCMDTYPE_AI_SELECTION, $5808
	db $00

EffectCommands_5846b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5829
	db $00

EffectCommands_58470:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $582d
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $5830
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5853
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, $584d
	dbw EFFECTCMDTYPE_AI_SELECTION, $5842
	db $00

EffectCommands_58481:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5859
	db $00

EffectCommands_58486:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $585d
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5884
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $5864
	dbw EFFECTCMDTYPE_AI_SELECTION, $586b
	db $00

EffectCommands_58494:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $58a6
	db $00

EffectCommands_58499:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $58aa
	db $00

EffectCommands_5849e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $58b9
	db $00

EffectCommands_584a3:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $58bb
	db $00

EffectCommands_584a8:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $58bf
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5915
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $58d6
	dbw EFFECTCMDTYPE_AI_SELECTION, $5910
	db $00

EffectCommands_584b6:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5a0f
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $59fd
	dbw EFFECTCMDTYPE_AI_SELECTION, $5a01
	db $00

EffectCommands_584c1:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5a22
	db $00

EffectCommands_584c6:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5a26
	db $00

EffectCommands_584cb:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5a28
	dbw EFFECTCMDTYPE_AI, $5a28
	db $00

EffectCommands_584d3:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $5a37
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5a4b
	dbw EFFECTCMDTYPE_UNK_11, $5acc
	db $00

EffectCommands_584de:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5af1
	db $00

EffectCommands_584e3:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5afb
	dbw EFFECTCMDTYPE_AI, $5af5
	db $00

EffectCommands_584eb:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5b05
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $5b16
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5b68
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5b6d
	dbw EFFECTCMDTYPE_AI_SELECTION, $5b50
	db $00

EffectCommands_584fc:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5c2e
	db $00

EffectCommands_58501:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5c30
	db $00

EffectCommands_58506:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5c3a
	dbw EFFECTCMDTYPE_AI, $5c34
	db $00

EffectCommands_5850e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5c47
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $5c4a
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5c6d
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, $5c67
	dbw EFFECTCMDTYPE_AI_SELECTION, $5c5c
	db $00

EffectCommands_5851f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5c73
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5c9a
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $5c7a
	dbw EFFECTCMDTYPE_AI_SELECTION, $5c81
	db $00

EffectCommands_5852d:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5cab
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5cd2
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $5cb2
	dbw EFFECTCMDTYPE_AI_SELECTION, $5cb9
	db $00

EffectCommands_5853b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $5ce3
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5d03
	dbw EFFECTCMDTYPE_UNK_11, $5d59
	db $00

EffectCommands_58546:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5d79
	db $00

EffectCommands_5854b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5d7d
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5d88
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5d99
	db $00

EffectCommands_58556:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5da4
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $5daf
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5df4
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $5ddb
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, $5dd5
	dbw EFFECTCMDTYPE_AI_SELECTION, $5dc2
	db $00

EffectCommands_5856a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5e09
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $5e0d
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5e15
	dbw EFFECTCMDTYPE_AI_SELECTION, $5e11
	db $00

EffectCommands_58578:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5e19
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $5e26
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5e49
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, $5e43
	dbw EFFECTCMDTYPE_AI_SELECTION, $5e38
	db $00

EffectCommands_58589:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5e5e
	dbw EFFECTCMDTYPE_AI, $5e55
	db $00

EffectCommands_58591:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5e73
	dbw EFFECTCMDTYPE_AI, $5e73
	db $00

EffectCommands_58599:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5e8b
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5ec0
	dbw EFFECTCMDTYPE_AI, $5e82
	db $00

EffectCommands_585a4:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5ed5
	dbw EFFECTCMDTYPE_AI, $5ecc
	db $00

EffectCommands_585ac:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5ef8
	db $00

EffectCommands_585b1:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5f07
	dbw EFFECTCMDTYPE_AI, $5efe
	db $00

EffectCommands_585b9:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5f1d
	db $00

EffectCommands_585be:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5f33
	db $00

EffectCommands_585c3:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5f35
	db $00

EffectCommands_585c8:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5f37
	db $00

EffectCommands_585cd:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5f4f
	db $00

EffectCommands_585d2:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5f59
	dbw EFFECTCMDTYPE_AI, $5f55
	db $00

EffectCommands_585da:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5f6b
	dbw EFFECTCMDTYPE_AI, $5f62
	db $00

EffectCommands_585e2:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5f83
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5fc4
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $5f8d
	dbw EFFECTCMDTYPE_AI_SELECTION, $5fab
	db $00

EffectCommands_585f0:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5fec
	dbw EFFECTCMDTYPE_AI, $5fe4
	db $00

EffectCommands_585f8:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6003
	db $00

EffectCommands_585fd:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6009
	db $00

EffectCommands_58602:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6025
	db $00

EffectCommands_58607:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6033
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $602b
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, $602b
	db $00

EffectCommands_58612:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6041
	db $00

EffectCommands_58617:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6055
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6063
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $6059
	dbw EFFECTCMDTYPE_AI_SELECTION, $605d
	db $00

EffectCommands_58625:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6073
	db $00

EffectCommands_5862a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6082
	dbw EFFECTCMDTYPE_AI, $6079
	db $00

EffectCommands_58632:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6098
	db $00

EffectCommands_58637:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $60a1
	db $00

EffectCommands_5863c:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $60a3
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $60a6
	db $00

EffectCommands_58644:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $60f9
	db $00

EffectCommands_58649:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $610b
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $612c
	db $00

EffectCommands_58651:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6190
	db $00

EffectCommands_58656:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $619d
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $61ac
	dbw EFFECTCMDTYPE_AI, $6194
	db $00

EffectCommands_58661:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $61b6
	db $00

EffectCommands_58666:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $61c5
	dbw EFFECTCMDTYPE_AI, $61bc
	db $00

EffectCommands_5866e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $61d8
	db $00

EffectCommands_58673:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $61dc
	db $00

EffectCommands_58678:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $61f8
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6207
	db $00

EffectCommands_58680:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6217
	db $00

EffectCommands_58685:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6227
	db $00

EffectCommands_5868a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $62c4
	dbw EFFECTCMDTYPE_AI, $62bb
	db $00

EffectCommands_58692:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $62d3
	dbw EFFECTCMDTYPE_AI, $62ca
	db $00

EffectCommands_5869a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $62e9
	db $00

EffectCommands_5869f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $62ef
	dbw EFFECTCMDTYPE_AI, $62ed
	db $00

EffectCommands_586a7:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6318
	db $00

EffectCommands_586ac:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $631e
	dbw EFFECTCMDTYPE_AI, $631c
	db $00

EffectCommands_586b4:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6320
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $632f
	db $00

EffectCommands_586bc:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6351
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $633f
	dbw EFFECTCMDTYPE_AI_SELECTION, $6343
	db $00

EffectCommands_586c7:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6366
	db $00

EffectCommands_586cc:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $636c
	db $00

EffectCommands_586d1:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6370
	db $00

EffectCommands_586d6:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6376
	db $00

EffectCommands_586db:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $637a
	db $00

EffectCommands_586e0:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $63c0
	db $00

EffectCommands_586e5:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $63d2
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $63e1
	db $00

EffectCommands_586ed:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $64f7
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $63f1
	dbw EFFECTCMDTYPE_AI_SELECTION, $649f
	db $00

EffectCommands_586f8:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6511
	db $00

EffectCommands_586fd:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6515
	db $00

EffectCommands_58702:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6531
	dbw EFFECTCMDTYPE_AI, $6531
	db $00

EffectCommands_5870a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6537
	db $00

EffectCommands_5870f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6553
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, $6555
	db $00

EffectCommands_58717:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $659a
	db $00

EffectCommands_5871c:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $65a4
	db $00

EffectCommands_58721:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $663b
	dbw EFFECTCMDTYPE_AI, $663b
	db $00

EffectCommands_58729:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6641
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6681
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $6646
	dbw EFFECTCMDTYPE_AI_SELECTION, $667c
	db $00

EffectCommands_58737:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $66c2
	dbw EFFECTCMDTYPE_AI, $66b9
	db $00

EffectCommands_5873f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $66d8
	db $00

EffectCommands_58744:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $66dc
	db $00

EffectCommands_58749:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $66f9
	dbw EFFECTCMDTYPE_AI, $66f0
	db $00

EffectCommands_58751:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6702
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $6705
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6711
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6714
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $6708
	dbw EFFECTCMDTYPE_AI_SELECTION, $670b
	dbw EFFECTCMDTYPE_AI, $66ff
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, $670e
	db $00

EffectCommands_5876b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6717
	db $00

EffectCommands_58770:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $6729
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6738
	db $00

EffectCommands_58778:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $674b
	dbw EFFECTCMDTYPE_AI, $6742
	db $00

EffectCommands_58780:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6762
	db $00

EffectCommands_58785:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6764
	db $00

EffectCommands_5878a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6771
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6782
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, $677c
	dbw EFFECTCMDTYPE_AI, $6768
	db $00

EffectCommands_58798:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $678e
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6793
	db $00

EffectCommands_587a0:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $67ba
	dbw EFFECTCMDTYPE_AI, $67b1
	db $00

EffectCommands_587a8:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $67d9
	dbw EFFECTCMDTYPE_AI, $67d0
	db $00

EffectCommands_587b0:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $67e9
	dbw EFFECTCMDTYPE_AI, $67df
	db $00

EffectCommands_587b8:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6807
	dbw EFFECTCMDTYPE_AI, $67fe
	db $00

EffectCommands_587c0:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $681c
	db $00

EffectCommands_587c5:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6822
	dbw EFFECTCMDTYPE_AI, $681e
	db $00

EffectCommands_587cd:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $682b
	db $00

EffectCommands_587d2:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6859
	dbw EFFECTCMDTYPE_AI, $6850
	db $00

EffectCommands_587da:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6875
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $6871
	dbw EFFECTCMDTYPE_AI_SELECTION, $6873
	db $00

EffectCommands_587e5:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $68bf
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $68cc
	dbw EFFECTCMDTYPE_AI_SELECTION, $68c8
	db $00

EffectCommands_587f0:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $68d2
	db $00

EffectCommands_587f5:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $68d8
	db $00

EffectCommands_587fa:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6927
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $691f
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, $691f
	db $00

EffectCommands_58805:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6930
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $6933
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $693f
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6942
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $6936
	dbw EFFECTCMDTYPE_AI_SELECTION, $6939
	dbw EFFECTCMDTYPE_AI, $692d
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, $693c
	db $00

EffectCommands_5881f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6945
	db $00

EffectCommands_58824:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6949
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $6956
	dbw EFFECTCMDTYPE_AI_SELECTION, $6952
	db $00

EffectCommands_5882f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $69de
	db $00

EffectCommands_58834:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $69e2
	dbw EFFECTCMDTYPE_AI, $69e2
	db $00

EffectCommands_5883c:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $69ed
	db $00

EffectCommands_58841:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $69f1
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $69fc
	db $00

EffectCommands_58849:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6a03
	db $00

EffectCommands_5884e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6a09
	db $00

EffectCommands_58853:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6a0f
	db $00

EffectCommands_58858:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6a13
	db $00

EffectCommands_5885d:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6a1f
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $6a17
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, $6a17
	db $00

EffectCommands_58868:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6a25
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $6a27
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6a2c
	dbw EFFECTCMDTYPE_AI_SELECTION, $6a29
	db $00

EffectCommands_58876:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6a7c
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $6a7e
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6a82
	dbw EFFECTCMDTYPE_AI_SELECTION, $6a80
	db $00

EffectCommands_58884:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6b44
	db $00

EffectCommands_58889:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6b58
	db $00

EffectCommands_5888e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6b5e
	dbw EFFECTCMDTYPE_AI, $6b5e
	db $00

; unreferenced
EffectCommands_58896:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $6b6f
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6b8c
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $6b77
	db $00

EffectCommands_588a1:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6ba1
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, $6ba3
	db $00

EffectCommands_588a9:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6bf9
	dbw EFFECTCMDTYPE_AI, $6bf0
	db $00

EffectCommands_588b1:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6c31
	db $00

EffectCommands_588b6:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6c47
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6c4c
	db $00

EffectCommands_588be:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6d1a
	db $00

EffectCommands_588c3:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6d2b
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6d31
	db $00

EffectCommands_588cb:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6d65
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6d6f
	db $00

EffectCommands_588d3:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6dab
	db $00

EffectCommands_588d8:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $6db1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6de0
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $6db5
	db $00

EffectCommands_588e3:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6e09
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6e3a
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $6e23
	dbw EFFECTCMDTYPE_AI, $6e00
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, $6e10
	db $00

EffectCommands_588f4:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6e4f
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6ef6
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $6ea9
	dbw EFFECTCMDTYPE_AI, $6e56
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, $6e75
	db $00

EffectCommands_58905:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6f16
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $6f1a
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, $6f22
	dbw EFFECTCMDTYPE_AI_SELECTION, $6f1e
	db $00

EffectCommands_58913:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6f62
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $6f2c
	dbw EFFECTCMDTYPE_AI_SELECTION, $6f27
	db $00

EffectCommands_5891e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6f82
	dbw EFFECTCMDTYPE_AI, $6f7e
	db $00

EffectCommands_58926:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6f8b
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6ff0
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $6fc5
	dbw EFFECTCMDTYPE_AI, $6f8f
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, $6faa
	db $00

EffectCommands_58937:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7014
	dbw EFFECTCMDTYPE_AI, $700b
	db $00

EffectCommands_5893f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7029
	db $00

EffectCommands_58944:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $702f
	dbw EFFECTCMDTYPE_AI, $702f
	db $00

EffectCommands_5894c:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7036
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $7045
	db $00

EffectCommands_58954:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $7059
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $705e
	db $00

EffectCommands_5895c:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $707c
	dbw EFFECTCMDTYPE_AI, $707c
	db $00

EffectCommands_58964:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $7083
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $70a4
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $70ba
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, $70b5
	dbw EFFECTCMDTYPE_AI_SELECTION, $7097
	db $00

EffectCommands_58975:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $70da
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $7131
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $70f4
	dbw EFFECTCMDTYPE_AI_SELECTION, $7115
	db $00

EffectCommands_58983:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $7149
	db $00

EffectCommands_58988:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $714b
	db $00

EffectCommands_5898d:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $7157
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $714f
	dbw EFFECTCMDTYPE_AI_SELECTION, $7153
	db $00

EffectCommands_58998:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7164
	dbw EFFECTCMDTYPE_AI, $715b
	db $00

EffectCommands_589a0:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7182
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $7184
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $717c
	dbw EFFECTCMDTYPE_AI_SELECTION, $7180
	dbw EFFECTCMDTYPE_AI, $7176
	db $00

EffectCommands_589b1:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $71f3
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $71f7
	db $00

EffectCommands_589b9:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $7208
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $720a
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, $721b
	db $00

EffectCommands_589c4:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $723e
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $7252
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $7234
	dbw EFFECTCMDTYPE_AI_SELECTION, $7238
	dbw EFFECTCMDTYPE_AI, $722e
	db $00

EffectCommands_589d5:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7267
	db $00

EffectCommands_589da:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7274
	dbw EFFECTCMDTYPE_AI, $726b
	db $00

EffectCommands_589e2:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $7278
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $727c
	db $00

EffectCommands_589ea:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $72ca
	dbw EFFECTCMDTYPE_AI, $72c1
	db $00

EffectCommands_589f2:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $72ce
	db $00

EffectCommands_589f7:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $72d9
	dbw EFFECTCMDTYPE_AI, $72d0
	db $00

EffectCommands_589ff:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7307
	dbw EFFECTCMDTYPE_AI, $72fe
	db $00

EffectCommands_58a07:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7314
	dbw EFFECTCMDTYPE_AI, $730b
	db $00

EffectCommands_58a0f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $7324
	db $00

EffectCommands_58a14:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $732f
	dbw EFFECTCMDTYPE_AI, $7326
	db $00

EffectCommands_58a1c:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $733c
	dbw EFFECTCMDTYPE_AI, $7333
	db $00

EffectCommands_58a24:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7340
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $7357
	dbw EFFECTCMDTYPE_AI, $7340
	db $00

EffectCommands_58a2f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $73fa
	db $00

EffectCommands_58a34:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $740a
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $741f
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $740e
	db $00

EffectCommands_58a3f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $744d
	db $00

EffectCommands_58a44:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $7451
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7470
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $7463
	db $00

EffectCommands_58a4f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $74a4
	dbw EFFECTCMDTYPE_AI, $74a4
	db $00

EffectCommands_58a57:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $74c9
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $74d4
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $74aa
	dbw EFFECTCMDTYPE_AI_SELECTION, $74c4
	db $00

EffectCommands_58a65:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $74fd
	dbw EFFECTCMDTYPE_AI, $74fd
	db $00

EffectCommands_58a6d:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $7503
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $753f
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $7508
	dbw EFFECTCMDTYPE_AI_SELECTION, $7526
	db $00

EffectCommands_58a7b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $754f
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $7551
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, $759e
	db $00

EffectCommands_58a86:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $75cb
	dbw EFFECTCMDTYPE_AI, $75c2
	db $00

EffectCommands_58a8e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $75dd
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $75e1
	db $00

EffectCommands_58a96:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7626
	db $00

EffectCommands_58a9b:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $7640
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7644
	dbw EFFECTCMDTYPE_AI, $762a
	db $00

EffectCommands_58aa6:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7689
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $769d
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $767f
	dbw EFFECTCMDTYPE_AI_SELECTION, $7683
	dbw EFFECTCMDTYPE_AI, $7679
	db $00

EffectCommands_58ab7:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $76af
	db $00

EffectCommands_58abc:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $76ba
	dbw EFFECTCMDTYPE_AI, $76b1
	db $00

EffectCommands_58ac4:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $76d4
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $76df
	db $00

EffectCommands_58acc:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $76f2
	dbw EFFECTCMDTYPE_AI, $76e9
	db $00

EffectCommands_58ad4:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $76f8
	db $00

EffectCommands_58ad9:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7717
	dbw EFFECTCMDTYPE_AI, $76fa
	db $00

EffectCommands_58ae1:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $7724
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $773f
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $7728
	dbw EFFECTCMDTYPE_AI_SELECTION, $7739
	db $00

EffectCommands_58aef:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $777b
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $7773
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, $7773
	db $00

EffectCommands_58afa:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $7781
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $7785
	db $00

EffectCommands_58b02:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $77cc
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $77d5
	db $00

EffectCommands_58b0a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $782c
	dbw EFFECTCMDTYPE_AI, $7823
	db $00

EffectCommands_58b12:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $783b
	dbw EFFECTCMDTYPE_AI, $7832
	db $00

EffectCommands_58b1a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $784d
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7880
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $78a1
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $7857
	dbw EFFECTCMDTYPE_AI, $7851
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, $7871
	db $00

EffectCommands_58b2e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $78bc
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $78c2
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $78c4
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $78be
	dbw EFFECTCMDTYPE_AI_SELECTION, $78c0
	db $00

EffectCommands_58b3f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7927
	dbw EFFECTCMDTYPE_AI, $791e
	db $00

EffectCommands_58b47:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $792b
	db $00

EffectCommands_58b4c:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $7931
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $7935
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $793d
	dbw EFFECTCMDTYPE_AI_SELECTION, $7939
	db $00

EffectCommands_58b5a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7941
	db $00

EffectCommands_58b5f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7945
	db $00

EffectCommands_58b64:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $7949
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7971
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $7952
	db $00

EffectCommands_58b6f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $799a
	dbw EFFECTCMDTYPE_AI, $7991
	db $00

EffectCommands_58b77:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $79a0
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $79a2
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, $7a36
	db $00

EffectCommands_58b82:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7a69
	dbw EFFECTCMDTYPE_AI, $7a60
	db $00

EffectCommands_58b8a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7a7b
	dbw EFFECTCMDTYPE_AI, $7a7b
	db $00

EffectCommands_58b92:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7a9e
	dbw EFFECTCMDTYPE_AI, $7a9e
	db $00

EffectCommands_58b9a:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $7ae8
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $7abb
	dbw EFFECTCMDTYPE_AI_SELECTION, $7aa4
	db $00

EffectCommands_58ba5:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $7b51
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7b60
	dbw EFFECTCMDTYPE_UNK_11, $7bd7
	db $00

EffectCommands_58bb0:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7be6
	db $00

EffectCommands_58bb5:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7bec
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $7bf9
	db $00

EffectCommands_58bbd:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $4000
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $4009
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4022
	db $00

EffectCommands_58bc8:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $405e
	db $00

EffectCommands_58bcd:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4098
	db $00

EffectCommands_58bd2:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $4120
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4143
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $4125
	db $00

EffectCommands_58bdd:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4162
	db $00

EffectCommands_58be2:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $41ba
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $416b
	db $00

EffectCommands_58bea:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $41d0
	db $00

EffectCommands_58bef:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $41d6
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4221
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $41dd
	db $00

EffectCommands_58bfa:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, $427d
	db $00

EffectCommands_58bff:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, $428b
	db $00

EffectCommands_58c04:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, $429d
	db $00

EffectCommands_58c09:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4352
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $42aa
	db $00

EffectCommands_58c11:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $43b4
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $43bf
	db $00

EffectCommands_58c19:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7c0c
	dbw EFFECTCMDTYPE_AI, $7c03
	db $00

EffectCommands_58c21:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $43ce
	db $00

EffectCommands_58c26:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $43d5
	db $00

EffectCommands_58c2b:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $43dc
	db $00

EffectCommands_58c30:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7c10
	db $00

EffectCommands_58c35:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7c1d
	dbw EFFECTCMDTYPE_AI, $7c14
	db $00

EffectCommands_58c3d:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $43de
	db $00

EffectCommands_58c42:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $43ea
	dbw EFFECTCMDTYPE_AI, $43e0
	db $00

EffectCommands_58c4a:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $43f1
	db $00

EffectCommands_58c4f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7c21
	db $00

EffectCommands_58c54:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $440b
	db $00

EffectCommands_58c59:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4421
	db $00

EffectCommands_58c5e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7c2e
	dbw EFFECTCMDTYPE_AI, $7c25
	db $00

EffectCommands_58c66:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $443b
	db $00

EffectCommands_58c6b:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $444c
	dbw EFFECTCMDTYPE_AI, $4442
	db $00

EffectCommands_58c73:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $4461
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $4486
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $4466
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, $447f
	db $00

EffectCommands_58c81:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7c32
	db $00

EffectCommands_58c86:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $449a
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4502
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $44b5
	db $00

EffectCommands_58c91:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $451c
	db $00

EffectCommands_58c96:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7c36
	db $00

EffectCommands_58c9b:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $4523
	db $00

EffectCommands_58ca0:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $452e
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $4538
	db $00

EffectCommands_58ca8:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $4542
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $4589
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $454c
	dbw EFFECTCMDTYPE_AI_SELECTION, $456d
	db $00

EffectCommands_58cb6:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7c43
	dbw EFFECTCMDTYPE_AI, $7c3a
	db $00

EffectCommands_58cbe:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $45ad
	db $00

EffectCommands_58cc3:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7c47
	db $00

EffectCommands_58cc8:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $45b8
	db $00

EffectCommands_58ccd:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7c4b
	db $00

EffectCommands_58cd2:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $45cb
	dbw EFFECTCMDTYPE_AI, $45cb
	db $00

EffectCommands_58cda:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $45e6
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $45fc
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $45da
	dbw EFFECTCMDTYPE_AI_SELECTION, $45df
	dbw EFFECTCMDTYPE_AI, $45d3
	db $00

EffectCommands_58ceb:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4613
	db $00

EffectCommands_58cf0:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $46be
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $466a
	dbw EFFECTCMDTYPE_AI, $461a
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, $4636
	db $00

EffectCommands_58cfe:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $46df
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $46d6
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, $46d6
	db $00

EffectCommands_58d09:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $46e6
	db $00

EffectCommands_58d0e:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $46f7
	dbw EFFECTCMDTYPE_AI, $46ed
	db $00

EffectCommands_58d16:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7c4f
	db $00

EffectCommands_58d1b:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4719
	dbw EFFECTCMDTYPE_AI, $470f
	db $00

EffectCommands_58d23:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7c53
	db $00

EffectCommands_58d28:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $472a
	dbw EFFECTCMDTYPE_AI, $4720
	db $00

EffectCommands_58d30:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $4742
	db $00

EffectCommands_58d35:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $474e
	dbw EFFECTCMDTYPE_AI, $4744
	db $00

EffectCommands_58d3d:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $476f
	dbw EFFECTCMDTYPE_AI, $4765
	db $00

EffectCommands_58d45:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4780
	dbw EFFECTCMDTYPE_AI, $4776
	db $00

EffectCommands_58d4d:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $479f
	dbw EFFECTCMDTYPE_AI, $4795
	db $00

EffectCommands_58d55:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $47b6
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $47bb
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $47c5
	dbw EFFECTCMDTYPE_AI_SELECTION, $47c0
	db $00

EffectCommands_58d63:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $47ca
	db $00

EffectCommands_58d68:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $47cc
	db $00

EffectCommands_58d6d:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $47db
	dbw EFFECTCMDTYPE_AI, $47db
	db $00

EffectCommands_58d75:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $4813
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $481f
	db $00

EffectCommands_58d7d:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $485b
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $48fc
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $489d
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, $486c
	db $00

EffectCommands_58d8b:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $4930
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4958
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $493a
	dbw EFFECTCMDTYPE_AI_SELECTION, $4935
	db $00

EffectCommands_58d99:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $4977
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $498a
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $49d9
	db $00

EffectCommands_58da4:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $4a03
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4a4f
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $4a08
	db $00

EffectCommands_58daf:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $4a75
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $4a77
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4a8e
	db $00

EffectCommands_58dba:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $4ade
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4ade
	db $00

EffectCommands_58dc2:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $4ae3
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4b30
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $4af3
	db $00

EffectCommands_58dcd:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4b75
	dbw EFFECTCMDTYPE_AI, $4b6b
	db $00

EffectCommands_58dd5:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4b96
	dbw EFFECTCMDTYPE_AI, $4b8c
	db $00

EffectCommands_58ddd:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4ba7
	dbw EFFECTCMDTYPE_AI, $4b9d
	db $00

EffectCommands_58de5:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $4bbc
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4c3a
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $4c5b
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $4bf1
	dbw EFFECTCMDTYPE_AI_SELECTION, $4c10
	db $00

EffectCommands_58df6:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7c57
	db $00

EffectCommands_58dfb:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7c64
	dbw EFFECTCMDTYPE_AI, $7c5b
	db $00

EffectCommands_58e03:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4c8d
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $4c92
	dbw EFFECTCMDTYPE_AI, $4c88
	db $00

EffectCommands_58e0e:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $4d2d
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $4d00
	dbw EFFECTCMDTYPE_AI_SELECTION, $4ce6
	db $00

EffectCommands_58e19:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4d57
	db $00

EffectCommands_58e1e:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4d6a
	db $00

EffectCommands_58e23:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $4d86
	db $00

EffectCommands_58e28:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4d97
	dbw EFFECTCMDTYPE_AI, $4d8d
	db $00

EffectCommands_58e30:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4da8
	dbw EFFECTCMDTYPE_AI, $4d9e
	db $00

EffectCommands_58e38:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $4dcc
	db $00

EffectCommands_58e3d:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $4ddb
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4e4d
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $4dee
	dbw EFFECTCMDTYPE_AI_SELECTION, $4e27
	db $00

EffectCommands_58e4b:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4e8a
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $4ea0
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $4e85
	dbw EFFECTCMDTYPE_AI_SELECTION, $4e7e
	dbw EFFECTCMDTYPE_AI, $4e77
	db $00

EffectCommands_58e5c:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $4eb7
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4f1f
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $4f35
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $4ef0
	dbw EFFECTCMDTYPE_AI_SELECTION, $4ec3
	dbw EFFECTCMDTYPE_AI, $4ebc
	db $00

EffectCommands_58e70:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4f71
	db $00

EffectCommands_58e75:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7c68
	db $00

EffectCommands_58e7a:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4f78
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $4f88
	db $00

EffectCommands_58e82:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7c6c
	db $00

EffectCommands_58e87:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4f95
	dbw EFFECTCMDTYPE_AI, $4f95
	db $00

EffectCommands_58e8f:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7c70
	db $00

EffectCommands_58e94:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4f9d
	db $00

EffectCommands_58e99:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7c74
	db $00

EffectCommands_58e9e:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7c78
	db $00

EffectCommands_58ea3:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4fac
	dbw EFFECTCMDTYPE_AI, $4fac
	db $00

EffectCommands_58eab:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $4fe8
	dbw EFFECTCMDTYPE_AI, $4fde
	db $00

EffectCommands_58eb3:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7c7c
	db $00

EffectCommands_58eb8:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5002
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $504d
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $5020
	dbw EFFECTCMDTYPE_AI_SELECTION, $5007
	db $00

EffectCommands_58ec6:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7c80
	db $00

EffectCommands_58ecb:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7c84
	db $00

EffectCommands_58ed0:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7c88
	db $00

EffectCommands_58ed5:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $5064
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5069
	db $00

EffectCommands_58edd:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $507a
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $50b8
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $5083
	db $00

EffectCommands_58ee8:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $511e
	dbw EFFECTCMDTYPE_AI, $5114
	db $00

EffectCommands_58ef0:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7c8c
	db $00

EffectCommands_58ef5:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5125
	db $00

EffectCommands_58efa:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5136
	db $00

EffectCommands_58eff:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7c90
	db $00

EffectCommands_58f04:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5138
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5182
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $5167
	dbw EFFECTCMDTYPE_AI_SELECTION, $513d
	db $00

EffectCommands_58f12:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $519e
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $51af
	dbw EFFECTCMDTYPE_AI, $5194
	db $00

EffectCommands_58f1d:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $51b9
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $51f3
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5218
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $521b
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $5210
	dbw EFFECTCMDTYPE_AI_SELECTION, $5212
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, $5215
	db $00

EffectCommands_58f34:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $535f
	db $00

EffectCommands_58f39:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $53df
	dbw EFFECTCMDTYPE_AI, $53d5
	db $00

EffectCommands_58f41:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7c94
	db $00

EffectCommands_58f46:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $540d
	dbw EFFECTCMDTYPE_AI, $53fc
	db $00

EffectCommands_58f4e:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5415
	db $00

EffectCommands_58f53:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5438
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5451
	dbw EFFECTCMDTYPE_AI, $542e
	db $00

EffectCommands_58f5e:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $545a
	dbw EFFECTCMDTYPE_AI, $545a
	db $00

EffectCommands_58f66:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $548c
	dbw EFFECTCMDTYPE_AI, $5482
	db $00

EffectCommands_58f6e:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $54b0
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $54c7
	dbw EFFECTCMDTYPE_AI, $54a6
	db $00

EffectCommands_58f79:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $54f2
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $54d8
	dbw EFFECTCMDTYPE_AI_SELECTION, $54d1
	db $00

EffectCommands_58f84:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $553a
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5563
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $5552
	dbw EFFECTCMDTYPE_AI_SELECTION, $5543
	db $00

EffectCommands_58f92:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7c98
	db $00

EffectCommands_58f97:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5578
	dbw EFFECTCMDTYPE_AI, $5578
	db $00

EffectCommands_58f9f:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $558a
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $55de
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $55e7
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $5593
	dbw EFFECTCMDTYPE_AI_SELECTION, $55bb
	db $00

EffectCommands_58fb0:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $560a
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $560f
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, $5619
	dbw EFFECTCMDTYPE_AI_SELECTION, $5614
	db $00

EffectCommands_58fbe:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $561f
	dbw EFFECTCMDTYPE_AI, $561f
	db $00

EffectCommands_58fc6:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5636
	db $00

EffectCommands_58fcb:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $563d
	dbw EFFECTCMDTYPE_AI, $563d
	db $00

EffectCommands_58fd3:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5648
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $567e
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5697
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, $5654
	dbw EFFECTCMDTYPE_AI, $5665
	db $00

EffectCommands_58fe4:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7c9c
	db $00

EffectCommands_58fe9:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $56f6
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5739
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $573e
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $5702
	dbw EFFECTCMDTYPE_AI_SELECTION, $5728
	dbw EFFECTCMDTYPE_AI, $56fb
	db $00

EffectCommands_58ffd:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $578e
	dbw EFFECTCMDTYPE_AI, $5779
	db $00

EffectCommands_59005:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $57b6
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $57ad
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, $57ad
	db $00

EffectCommands_59010:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $57bd
	db $00

EffectCommands_59015:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7ca0
	db $00

EffectCommands_5901a:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $57d2
	db $00

EffectCommands_5901f:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5816
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5852
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $5822
	dbw EFFECTCMDTYPE_AI_SELECTION, $5839
	db $00

EffectCommands_5902d:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $585b
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $588a
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $5860
	dbw EFFECTCMDTYPE_AI_SELECTION, $5875
	db $00

EffectCommands_5903b:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $59e7
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5ac2
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5af7
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $59f5
	dbw EFFECTCMDTYPE_AI_SELECTION, $59f1
	dbw EFFECTCMDTYPE_AI, $59ca
	db $00

EffectCommands_5904f:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5b5d
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5ba3
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $5b81
	dbw EFFECTCMDTYPE_AI_SELECTION, $5b6d
	dbw EFFECTCMDTYPE_AI, $5b62
	db $00

EffectCommands_59060:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5bb0
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5bb7
	db $00

EffectCommands_59068:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5bc6
	db $00

EffectCommands_5906d:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5bdb
	db $00

EffectCommands_59072:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7ca4
	db $00

EffectCommands_59077:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5bed
	dbw EFFECTCMDTYPE_AI, $5be3
	db $00

EffectCommands_5907f:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5c41
	db $00

EffectCommands_59084:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7ca8
	db $00

EffectCommands_59089:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5c54
	dbw EFFECTCMDTYPE_AI, $5c54
	db $00

EffectCommands_59091:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5c6a
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $5c70
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, $5c91
	db $00

EffectCommands_5909c:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5cde
	db $00

EffectCommands_590a1:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5cf1
	db $00

EffectCommands_590a6:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5cf3
	db $00

; unreferenced
EffectCommands_590ab:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5cf9
	db $00

EffectCommands_590b0:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5d04
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5d63
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5d6b
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $5d11
	dbw EFFECTCMDTYPE_AI_SELECTION, $5d0d
	db $00

EffectCommands_590c1:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5d8a
	db $00

EffectCommands_590c6:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5d91
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5de4
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5df4
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $5db7
	dbw EFFECTCMDTYPE_AI_SELECTION, $5da0
	dbw EFFECTCMDTYPE_AI, $5d96
	db $00

EffectCommands_590da:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $5e0f
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5e14
	db $00

EffectCommands_590e2:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5e28
	db $00

EffectCommands_590e7:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5e3a
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5e3f
	db $00

EffectCommands_590ef:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5e7f
	dbw EFFECTCMDTYPE_AI, $5e75
	db $00

EffectCommands_590f7:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5e90
	dbw EFFECTCMDTYPE_AI, $5e86
	db $00

EffectCommands_590ff:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5ea9
	db $00

EffectCommands_59104:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5ec2
	dbw EFFECTCMDTYPE_AI, $5ec2
	db $00

EffectCommands_5910c:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5ee0
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $5eca
	dbw EFFECTCMDTYPE_AI_SELECTION, $5ed5
	db $00

EffectCommands_59117:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5f06
	db $00

EffectCommands_5911c:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5f0c
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5f13
	db $00

EffectCommands_59124:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5fa2
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $5f32
	dbw EFFECTCMDTYPE_AI_SELECTION, $5f2d
	dbw EFFECTCMDTYPE_AI, $5f1a
	db $00

EffectCommands_59132:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $5fbb
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5fdd
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $5fe8
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $5fca
	dbw EFFECTCMDTYPE_AI_SELECTION, $5fca
	dbw EFFECTCMDTYPE_AI, $5fc0
	db $00

EffectCommands_59146:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $5ff3
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $5fff
	db $00

EffectCommands_5914e:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $603a
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6049
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6059
	db $00

EffectCommands_59159:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $607f
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6086
	db $00

EffectCommands_59161:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $60a0
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $60b1
	db $00

EffectCommands_59169:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $60e0
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $611c
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $60ec
	dbw EFFECTCMDTYPE_AI_SELECTION, $6103
	db $00

EffectCommands_59177:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6125
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6134
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6139
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $612f
	dbw EFFECTCMDTYPE_AI_SELECTION, $612a
	db $00

EffectCommands_59188:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7cb5
	dbw EFFECTCMDTYPE_AI, $7cac
	db $00

EffectCommands_59190:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $613e
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6143
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6157
	db $00

EffectCommands_5919b:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $617b
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $6187
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $61a6
	dbw EFFECTCMDTYPE_AI_SELECTION, $6180
	db $00

EffectCommands_591a9:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $61cc
	dbw EFFECTCMDTYPE_AI, $61c2
	db $00

EffectCommands_591b1:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $61e4
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $61ee
	db $00

EffectCommands_591b9:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $6223
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $627e
	dbw EFFECTCMDTYPE_AI_SELECTION, $621f
	dbw EFFECTCMDTYPE_AI, $6202
	db $00

EffectCommands_591c7:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $629a
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6315
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $62c4
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, $62c0
	db $00

EffectCommands_591d5:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6358
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $636e
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $634c
	dbw EFFECTCMDTYPE_AI_SELECTION, $6351
	dbw EFFECTCMDTYPE_AI, $6345
	db $00

EffectCommands_591e6:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6385
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $63c1
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $638a
	dbw EFFECTCMDTYPE_AI_SELECTION, $63a8
	db $00

EffectCommands_591f4:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $63d2
	db $00

EffectCommands_591f9:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $63ec
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $63fd
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, $63f7
	db $00

EffectCommands_59204:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6415
	dbw EFFECTCMDTYPE_AI, $640b
	db $00

EffectCommands_5920c:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6436
	dbw EFFECTCMDTYPE_AI, $642c
	db $00

EffectCommands_59214:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $643d
	db $00

EffectCommands_59219:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $654e
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $643f
	dbw EFFECTCMDTYPE_AI_SELECTION, $64f6
	db $00

EffectCommands_59224:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $6570
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $65a4
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $657a
	db $00

EffectCommands_5922f:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $65c1
	dbw EFFECTCMDTYPE_AI, $65b7
	db $00

EffectCommands_59237:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $65e0
	dbw EFFECTCMDTYPE_AI, $65d6
	db $00

EffectCommands_5923f:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6601
	dbw EFFECTCMDTYPE_AI, $65f7
	db $00

EffectCommands_59247:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $661a
	db $00

EffectCommands_5924c:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6621
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $663e
	dbw EFFECTCMDTYPE_AI_SELECTION, $6634
	db $00

EffectCommands_59257:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6672
	dbw EFFECTCMDTYPE_AI, $6672
	db $00

EffectCommands_5925f:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $667a
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $667f
	db $00

EffectCommands_59267:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6684
	db $00

EffectCommands_5926c:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7cc2
	dbw EFFECTCMDTYPE_AI, $7cb9
	db $00

EffectCommands_59274:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7cc6
	db $00

EffectCommands_59279:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $669c
	dbw EFFECTCMDTYPE_AI, $6692
	db $00

EffectCommands_59281:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $66a3
	db $00

EffectCommands_59286:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7cca
	db $00

EffectCommands_5928b:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $66bd
	dbw EFFECTCMDTYPE_AI, $66b3
	db $00

EffectCommands_59293:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $66df
	dbw EFFECTCMDTYPE_AI, $66d5
	db $00

EffectCommands_5929b:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6700
	dbw EFFECTCMDTYPE_AI, $66f6
	db $00

EffectCommands_592a3:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6715
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $671a
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, $6724
	dbw EFFECTCMDTYPE_AI_SELECTION, $671f
	db $00

EffectCommands_592b1:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $672a
	db $00

EffectCommands_592b6:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7cd7
	dbw EFFECTCMDTYPE_AI, $7cce
	db $00

EffectCommands_592be:
	db $1a ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7cdb
	db $00

EffectCommands_592c3:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6730
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6767
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $6739
	db $00

EffectCommands_592ce:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $67b8
	db $00

EffectCommands_592d3:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $67e6
	db $00

EffectCommands_592d8:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $67e8
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $67f7
	db $00

EffectCommands_592e0:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6829
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6833
	db $00

EffectCommands_592e8:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $688d
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $68a5
	db $00

EffectCommands_592f0:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $68ef
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6902
	db $00

EffectCommands_592f8:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $696c
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6974
	db $00

EffectCommands_59300:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $69da
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $69e9
	db $00

EffectCommands_59308:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6a62
	db $00

EffectCommands_5930d:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6a69
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6a70
	db $00

EffectCommands_59315:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6a77
	db $00

EffectCommands_5931a:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6a96
	db $00

EffectCommands_5931f:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6abc
	dbw EFFECTCMDTYPE_AI, $6ab2
	db $00

EffectCommands_59327:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6ad3
	db $00

EffectCommands_5932c:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6b1c
	db $00

EffectCommands_59331:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6b2a
	dbw EFFECTCMDTYPE_AI, $6b1e
	db $00

EffectCommands_59339:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6b63
	db $00

EffectCommands_5933e:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, $6b65
	db $00

EffectCommands_59343:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6bac
	db $00

EffectCommands_59348:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6bd1
	dbw EFFECTCMDTYPE_AI, $6bca
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
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6bf3
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $6c02
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6c50
	db $00

EffectCommands_5936b:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6caf
	db $00

EffectCommands_59370:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6cce
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $6cdb
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6cf0
	dbw EFFECTCMDTYPE_AI_SELECTION, $6ceb
	db $00

EffectCommands_5937e:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6d0c
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $6d1d
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6d79
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $6d36
	db $00

EffectCommands_5938c:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6d9d
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6dc5
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $6da7
	db $00

EffectCommands_59397:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6df4
	db $00

EffectCommands_5939c:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6e1e
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $6e26
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6e44
	db $00

EffectCommands_593a7:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6e4e
	db $00

EffectCommands_593ac:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6e92
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $6ea0
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6eba
	db $00

EffectCommands_593b7:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $6edf
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6ef0
	db $00

EffectCommands_593bf:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6f09
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6f0e
	db $00

EffectCommands_593c7:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6f14
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6f1e
	db $00

EffectCommands_593cf:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6f2c
	db $00

EffectCommands_593d4:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6f5f
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $6f72
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6f8d
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $6f76
	db $00

EffectCommands_593e2:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6fa9
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6fae
	db $00

EffectCommands_593ea:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $6fb4
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $6fb9
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $6fca
	db $00

EffectCommands_593f5:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7018
	db $00

EffectCommands_593fa:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $7024
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $7029
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $703a
	db $00

EffectCommands_59405:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $7041
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7049
	db $00

EffectCommands_5940d:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $7086
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $709c
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $70ba
	db $00

EffectCommands_59418:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $70de
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $70ec
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $711f
	db $00

EffectCommands_59423:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $71bc
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $71c1
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $71e4
	db $00

EffectCommands_5942e:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $724b
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $725b
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $72b0
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $7276
	db $00

EffectCommands_5943c:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $7302
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $73c7
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $730c
	db $00

EffectCommands_59447:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $73e1
	db $00

EffectCommands_5944c:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7406
	db $00

EffectCommands_59451:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $7493
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $749c
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $74a6
	db $00

EffectCommands_5945c:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $74c6
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $74f8
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $74d0
	db $00

EffectCommands_59467:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $7519
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $754f
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $7527
	db $00

EffectCommands_59472:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $7567
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $7571
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $758f
	db $00

EffectCommands_5947d:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $75b3
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $75ca
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $7640
	db $00

EffectCommands_59488:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $7678
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $768c
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $771e
	db $00

EffectCommands_59493:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $7751
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $7762
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $77a8
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, $7766
	db $00

EffectCommands_594a1:
	db $19 ; effect bank
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, $780e
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, $7813
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, $782a
	db $00

INCLUDE "data/decks.asm"
