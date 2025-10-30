SECTION "Bank 6@46a6", ROMX[$46a6], BANK[$6]

INCLUDE "engine/glossary.asm"
; 0x1897e

SECTION "Bank 6@4a14", ROMX[$4a14], BANK[$6]

ResetAttackAnimationIsPlaying::
	xor a ; FALSE
	ld [wAttackAnimationIsPlaying], a
	ret
; 0x18a19

SECTION "Bank 6@4ab1", ROMX[$4ab1], BANK[$6]

; if [wLoadedAttackAnimation] != 0, wait until the animation is over
WaitAttackAnimation::
	ld a, [wLoadedAttackAnimation]
	or a
	ret z
	push de
.anim_loop
	call DoFrame
	call CheckAnyAnimationPlaying
	jr c, .anim_loop
	pop de
	ret

; play attack animation
; input:
; - [wLoadedAttackAnimation]: animation to play
; - de: damage dealt by the attack (to display the animation with the number)
; - b: PLAY_AREA_* location, if applicable
; - c: a wDamageEffectiveness constant (to print WEAK or RESIST if necessary)
PlayAttackAnimation::
	ldh a, [hWhoseTurn]
	push af
	push hl
	push de
	push bc
	ld a, [wWhoseTurn]
	ldh [hWhoseTurn], a
	ld a, c
	ld [wDamageAnimEffectiveness], a
	ldh a, [hWhoseTurn]
	cp h
	jr z, .got_location
	; on the non-turn duelist's side
	set 7, b
.got_location
	ld a, b
	ld [wDamageAnimPlayAreaLocation], a
	ld a, [wWhoseTurn]
	ld [wDamageAnimPlayAreaSide], a
	ld hl, wDamageAnimAmount
	ld [hl], e
	inc hl
	ld [hl], d

; if damage >= 70, ATK_ANIM_HIT becomes ATK_ANIM_BIG_HIT
	ld a, [wLoadedAttackAnimation]
	cp ATK_ANIM_HIT
	jr nz, .got_anim
	ld a, e
	cp 70
	jr c, .got_anim
	ld a, ATK_ANIM_BIG_HIT
	ld [wLoadedAttackAnimation], a

.got_anim
	call PlayAttackAnimationCommands
	pop bc
	pop de
	pop hl
	pop af
	ldh [hWhoseTurn], a
	ret

; reads the animation commands from PointerTable_AttackAnimation
; of attack in wLoadedAttackAnimation and plays them
PlayAttackAnimationCommands:
	ld a, [wLoadedAttackAnimation]
	or a
	ret z

	ld l, a
	ld h, 0
	add hl, hl
	ld de, PointerTable_AttackAnimation
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]

	push de
	ld hl, wAttackAnimationIsPlaying
	ld a, [hl]
	or a
	jr nz, .read_command
	ld [hl], TRUE ; wAttackAnimationIsPlaying
	call ResetAnimationQueue
	pop de
	push de
	ld a, DUEL_ANIM_SCREEN_MAIN_SCENE
	ld [wDuelAnimationScreen], a
	ld a, SET_ANIM_SCREEN_MAIN
	ld [wDuelAnimSetScreen], a
	xor a
	ld [wDuelAnimLocationParam], a
	ld a, [de]
	cp ANIMCMD_SET_SCREEN
	jr z, .read_command
	ld a, DUEL_ANIM_SET_SCREEN
	call PlayDuelAnimation
.read_command
	pop de
	; fallthrough

PlayAttackAnimationCommands_NextCommand:
	ld a, [de]
	inc de
	ld hl, AnimationCommandPointerTable
	jp JumpToFunctionInTable

AnimationCommand_AnimEnd:
	ret

AnimationCommand_AnimPlayer:
	xor a
	ld [wDuelAnimLocationParam], a
	ldh a, [hWhoseTurn]
	ld [wDuelAnimDuelistSide], a
	ld a, [wDuelType]
	cp $00
	jr nz, AnimationCommand_AnimNormal
	ld a, PLAYER_TURN
	ld [wDuelAnimDuelistSide], a
	jr AnimationCommand_AnimNormal

AnimationCommand_AnimOpponent:
	xor a
	ld [wDuelAnimLocationParam], a
	call SwapTurn
	ldh a, [hWhoseTurn]
	ld [wDuelAnimDuelistSide], a
	call SwapTurn
	ld a, [wDuelType]
	cp $00
	jr nz, AnimationCommand_AnimNormal
	ld a, OPPONENT_TURN
	ld [wDuelAnimDuelistSide], a
	jr AnimationCommand_AnimNormal

AnimationCommand_AnimPlayArea:
	ld a, [wDamageAnimPlayAreaLocation]
	and $7f
	ld [wDuelAnimLocationParam], a
	jr AnimationCommand_AnimNormal

AnimationCommand_AnimEnd2:
	ret

AnimationCommand_AnimNormal:
	ld a, [de]
	inc de
	cp DUEL_ANIM_SHOW_DAMAGE
	jr z, .show_damage
	cp DUEL_ANIM_SMALL_SHAKE_X
	jr z, .shake_1
	cp DUEL_ANIM_BIG_SHAKE_X
	jr z, .shake_2
	cp DUEL_ANIM_SMALL_SHAKE_Y
	jr z, .shake_3

.play_anim
	call PlayDuelAnimation
	jr PlayAttackAnimationCommands_NextCommand

.show_damage
	ld a, DUEL_PRINT_DAMAGE
	call PlayDuelAnimation
	ld a, [wDamageAnimEffectiveness]
	ld [wDuelAnimEffectiveness], a

	push de
	ld hl, wDamageAnimAmount
	ld de, wDuelAnimDamage
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	pop de

	ld a, DUEL_ANIM_DAMAGE_HUD
	call PlayDuelAnimation
	ld a, [wDuelDisplayedScreen]
	cp DUEL_MAIN_SCENE
	jr nz, .skip_update_hud
	ld a, DUEL_ANIM_UPDATE_HUD
	call PlayDuelAnimation
.skip_update_hud
	jp PlayAttackAnimationCommands_NextCommand

; screen shake happens differently
; depending on whose turn it is
.shake_1
	ld c, DUEL_ANIM_SMALL_SHAKE_X
	ld b, DUEL_ANIM_SMALL_SHAKE_Y
	jr .check_duelist

.shake_2
	ld c, DUEL_ANIM_BIG_SHAKE_X
	ld b, DUEL_ANIM_BIG_SHAKE_Y
	jr .check_duelist

.shake_3
	ld c, DUEL_ANIM_SMALL_SHAKE_Y
	ld b, DUEL_ANIM_SMALL_SHAKE_X

.check_duelist
	ldh a, [hWhoseTurn]
	cp PLAYER_TURN
	ld a, c
	jr z, .play_anim
	ld a, [wDuelType]
	cp $00
	ld a, c
	jr z, .play_anim
	ld a, b
	jr .play_anim

AnimationCommand_AnimScreen:
	ld a, [de]
	inc de
	ld [wDuelAnimSetScreen], a
	ld a, [wDamageAnimPlayAreaLocation]
	ld [wDuelAnimLocationParam], a
	call UpdateDuelAnimationScreen
	ld a, DUEL_ANIM_SET_SCREEN
	call PlayDuelAnimation
	jp PlayAttackAnimationCommands_NextCommand

AnimationCommandPointerTable:
	dw AnimationCommand_AnimEnd      ; ANIMCMD_END
	dw AnimationCommand_AnimNormal   ; ANIMCMD_NORMAL
	dw AnimationCommand_AnimPlayer   ; ANIMCMD_PLAYER_SIDE
	dw AnimationCommand_AnimOpponent ; ANIMCMD_OPP_SIDE
	dw AnimationCommand_AnimScreen   ; ANIMCMD_SET_SCREEN
	dw AnimationCommand_AnimPlayArea ; ANIMCMD_PLAY_AREA
	dw AnimationCommand_AnimEnd2     ; ANIMCMD_END_UNUSED

; sets wDuelAnimationScreen according to wDuelAnimSetScreen
; if SET_ANIM_SCREEN_MAIN,      set it to Main Scene
; if SET_ANIM_SCREEN_PLAY_AREA, set it to Play Area scene
UpdateDuelAnimationScreen:
	ld a, [wDuelAnimSetScreen]
	cp SET_ANIM_SCREEN_PLAY_AREA
	jr z, .set_play_area_screen
	cp SET_ANIM_SCREEN_MAIN
	ret nz
	ld a, DUEL_ANIM_SCREEN_MAIN_SCENE
	ld [wDuelAnimationScreen], a
	ret

.set_play_area_screen
	ld a, [wDuelAnimLocationParam]
	ld l, a
	ld a, [wWhoseTurn]
	ld h, a
	cp PLAYER_TURN
	jr z, .players_turn

; opponent's turn
	ld a, [wDuelType]
	cp $00
	jr z, .asm_50c6
; link duel or vs. AI
	bit 7, l
	jr z, .asm_50e2
	jr .asm_50d2
.asm_50c6
	bit 7, l
	jr z, .asm_50da
	jr .asm_50ea

.players_turn
	bit 7, l
	jr z, .asm_50d2
	jr .asm_50e2

.asm_50d2
	ld l, UNKNOWN_SCREEN_4
	ld h, PLAYER_TURN
	ld a, DUEL_ANIM_SCREEN_PLAYER_PLAY_AREA
	jr .ok
.asm_50da
	ld l, UNKNOWN_SCREEN_4
	ld h, OPPONENT_TURN
	ld a, DUEL_ANIM_SCREEN_PLAYER_PLAY_AREA
	jr .ok
.asm_50e2
	ld l, UNKNOWN_SCREEN_5
	ld h, OPPONENT_TURN
	ld a, DUEL_ANIM_SCREEN_OPP_PLAY_AREA
	jr .ok
.asm_50ea
	ld l, UNKNOWN_SCREEN_5
	ld h, PLAYER_TURN
	ld a, DUEL_ANIM_SCREEN_OPP_PLAY_AREA

.ok
	ld [wDuelAnimationScreen], a
	ret

SetScreenForDuelAnimation::
	ld a, [wDuelAnimSetScreen]
	cp SET_ANIM_SCREEN_PLAY_AREA
	jr z, .set_play_area_screen
	cp SET_ANIM_SCREEN_MAIN
	jr nz, .done
; set duel main screen
	ld a, DUEL_ANIM_SCREEN_MAIN_SCENE
	ld [wDuelAnimationScreen], a
	ld a, [wDuelDisplayedScreen]
	cp DUEL_MAIN_SCENE
	jr z, .done
	bank1call DrawDuelMainScene
.done
	ret

.set_play_area_screen
	call UpdateDuelAnimationScreen

	ld a, [wDuelDisplayedScreen]
	cp l
	jr z, .skip_change_screen
	ld a, l
	push af
	ld l, PLAYER_TURN
	ld a, [wDuelType]
	cp $00
	jr nz, .asm_5127
	ld a, [wWhoseTurn]
	ld l, a
.asm_5127
	call DrawYourOrOppPlayAreaScreen_Bank0
	pop af
	ld [wDuelDisplayedScreen], a
.skip_change_screen
	call DrawWideTextBox
	ret

; prints text related to the damage received
; by card stored in wTempNonTurnDuelistCardID
; takes into account type effectiveness
PrintDamageText::
	push hl
	push bc
	push de
	ld a, [wLoadedAttackAnimation]
	cp ATK_ANIM_HEAL
	jr z, .skip
	cp ATK_ANIM_HEALING_WIND_PLAY_AREA
	jr z, .skip

	ld hl, wTempNonTurnDuelistCardID
	ld e, [hl]
	inc hl
	ld d, [hl]
	call LoadCardDataToBuffer1_FromCardID
	ld a, 18
	call CopyCardNameAndLevel
	ld [hl], TX_END
	ld hl, wTxRam2
	xor a
	ld [hli], a
	ld [hl], a
	ld hl, wDamageAnimAmount
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call GetDamageText
	ld a, l
	or h
	call nz, DrawWideTextBox_PrintText
.skip
	pop de
	pop bc
	pop hl
	ret

; returns in hl the text id associated with
; the damage in hl and its effectiveness
GetDamageText:
	ld a, l
	or h
	jr z, .no_damage
	call LoadTxRam3
	ld a, [wDamageAnimEffectiveness]
	ldtx hl, AttackDamageText
	and (1 << RESISTANCE) | (1 << WEAKNESS)
	ret z ; not weak or resistant
	ldtx hl, WeaknessResistanceMixedDamageText
	cp (1 << RESISTANCE) | (1 << WEAKNESS)
	ret z ; weak and resistant
	and (1 << WEAKNESS)
	ldtx hl, WeaknessMoreDamageText
	ret nz ; weak
	ldtx hl, ResistanceLessDamageText
	ret ; resistant

.no_damage
	bank1call CheckNoDamageOrEffect
	ret c
	ldtx hl, NoDamageText
	ld a, [wDamageAnimEffectiveness]
	and (1 << RESISTANCE)
	ret z ; not resistant
	ldtx hl, ResistanceNoDamageText
	ret ; resistant

UpdateMainSceneHUD::
	bank1call DrawDuelHUDs
	ret

DuelAnim153::
DuelAnim154::
DuelAnim155::
DuelAnim156::
DuelAnim157::
	ret

PointerTable_AttackAnimation:
	dw NULL                                ; ATK_ANIM_NONE
	dw AttackAnimation_Hit                 ; ATK_ANIM_HIT
	dw AttackAnimation_BigHit              ; ATK_ANIM_BIG_HIT
	dw AttackAnimation_Earthquake          ; ATK_ANIM_EARTHQUAKE
	dw AttackAnimation_HitRecoil           ; ATK_ANIM_HIT_RECOIL
	dw AttackAnimation_HitEffect           ; ATK_ANIM_HIT_EFFECT
	dw AttackAnimation_Thundershock        ; ATK_ANIM_THUNDERSHOCK
	dw AttackAnimation_Thunder             ; ATK_ANIM_THUNDER
	dw AttackAnimation_Thunderbolt         ; ATK_ANIM_THUNDERBOLT
	dw AttackAnimation_ThundershockCopy    ; ATK_ANIM_THUNDERSHOCK_COPY
	dw AttackAnimation_ThunderWholeScreen  ; ATK_ANIM_THUNDER_WHOLE_SCREEN
	dw AttackAnimation_Unused0B            ; ATK_ANIM_UNUSED_0B
	dw AttackAnimation_Thunderstorm        ; ATK_ANIM_THUNDERSTORM
	dw AttackAnimation_ChainLightning      ; ATK_ANIM_CHAIN_LIGHTNING
	dw AttackAnimation_SmallFlame          ; ATK_ANIM_SMALL_FLAME
	dw AttackAnimation_BigFlame            ; ATK_ANIM_BIG_FLAME
	dw AttackAnimation_FireSpin            ; ATK_ANIM_FIRE_SPIN
	dw AttackAnimation_DiveBomb            ; ATK_ANIM_DIVE_BOMB
	dw AttackAnimation_WaterJets           ; ATK_ANIM_WATER_JETS
	dw AttackAnimation_WaterGun            ; ATK_ANIM_WATER_GUN
	dw AttackAnimation_Whirlpool           ; ATK_ANIM_WHIRLPOOL
	dw AttackAnimation_DragonRage          ; ATK_ANIM_DRAGON_RAGE
	dw AttackAnimation_HydroPump           ; ATK_ANIM_HYDRO_PUMP
	dw AttackAnimation_Aeroblast           ; ATK_ANIM_AEROBLAST
	dw AttackAnimation_Blizzard            ; ATK_ANIM_BLIZZARD
	dw AttackAnimation_PsychicHit          ; ATK_ANIM_PSYCHIC_HIT
	dw AttackAnimation_Nightmare           ; ATK_ANIM_NIGHTMARE
	dw AttackAnimation_Psyshock            ; ATK_ANIM_PSYSHOCK
	dw AttackAnimation_DarkMind            ; ATK_ANIM_DARK_MIND
	dw AttackAnimation_Beam                ; ATK_ANIM_BEAM
	dw AttackAnimation_HyperBeam           ; ATK_ANIM_HYPER_BEAM
	dw AttackAnimation_IceBeam             ; ATK_ANIM_ICE_BEAM
	dw AttackAnimation_Avalanche           ; ATK_ANIM_AVALANCHE
	dw AttackAnimation_StoneBarrage        ; ATK_ANIM_STONE_BARRAGE
	dw AttackAnimation_Punch               ; ATK_ANIM_PUNCH
	dw AttackAnimation_Thunderpunch        ; ATK_ANIM_THUNDERPUNCH
	dw AttackAnimation_FirePunch           ; ATK_ANIM_FIRE_PUNCH
	dw AttackAnimation_StretchKick         ; ATK_ANIM_STRETCH_KICK
	dw AttackAnimation_Slash               ; ATK_ANIM_SLASH
	dw AttackAnimation_Whip                ; ATK_ANIM_WHIP
	dw AttackAnimation_Tear                ; ATK_ANIM_TEAR
	dw AttackAnimation_MultipleSlash       ; ATK_ANIM_MULTIPLE_SLASH
	dw AttackAnimation_Unused2A            ; ATK_ANIM_UNUSED_2A
	dw AttackAnimation_Rampage             ; ATK_ANIM_RAMPAGE
	dw AttackAnimation_Drill               ; ATK_ANIM_DRILL
	dw AttackAnimation_PotSmash            ; ATK_ANIM_POT_SMASH
	dw AttackAnimation_Bonemerang          ; ATK_ANIM_BONEMERANG
	dw AttackAnimation_SeismicToss         ; ATK_ANIM_SEISMIC_TOSS
	dw AttackAnimation_Needles             ; ATK_ANIM_NEEDLES
	dw AttackAnimation_PoisonNeedle        ; ATK_ANIM_POISON_NEEDLE
	dw AttackAnimation_Smog                ; ATK_ANIM_SMOG
	dw AttackAnimation_PoisonGas           ; ATK_ANIM_POISON_GAS
	dw AttackAnimation_Unused34            ; ATK_ANIM_UNUSED_34
	dw AttackAnimation_FoulGas             ; ATK_ANIM_FOUL_GAS
	dw AttackAnimation_FoulOdor            ; ATK_ANIM_FOUL_ODOR
	dw AttackAnimation_PowderEffectChance  ; ATK_ANIM_POWDER_EFFECT_CHANCE
	dw AttackAnimation_PowderHitPoison     ; ATK_ANIM_POWDER_HIT_POISON
	dw AttackAnimation_PoisonPowder        ; ATK_ANIM_POISON_POWDER
	dw AttackAnimation_Unused3A            ; ATK_ANIM_UNUSED_3A
	dw AttackAnimation_StunSpore           ; ATK_ANIM_STUN_SPORE
	dw AttackAnimation_Poisonpowder        ; ATK_ANIM_POISONPOWDER
	dw AttackAnimation_Goo                 ; ATK_ANIM_GOO
	dw AttackAnimation_Unused3E            ; ATK_ANIM_UNUSED_3E
	dw AttackAnimation_SpitPoison          ; ATK_ANIM_SPIT_POISON
	dw AttackAnimation_StickyHands         ; ATK_ANIM_STICKY_HANDS
	dw AttackAnimation_Bubbles             ; ATK_ANIM_BUBBLES
	dw AttackAnimation_BubblesCopy         ; ATK_ANIM_BUBBLES_COPY
	dw AttackAnimation_StringShot          ; ATK_ANIM_STRING_SHOT
	dw AttackAnimation_Unused44            ; ATK_ANIM_UNUSED_44
	dw AttackAnimation_Boyfriends          ; ATK_ANIM_BOYFRIENDS
	dw AttackAnimation_Lure                ; ATK_ANIM_LURE
	dw AttackAnimation_Toxic               ; ATK_ANIM_TOXIC
	dw AttackAnimation_ConfuseRay          ; ATK_ANIM_CONFUSE_RAY
	dw AttackAnimation_Unused49            ; ATK_ANIM_UNUSED_49
	dw AttackAnimation_Sing                ; ATK_ANIM_SING
	dw AttackAnimation_Lullaby             ; ATK_ANIM_LULLABY
	dw AttackAnimation_Supersonic          ; ATK_ANIM_SUPERSONIC
	dw AttackAnimation_SupersonicCopy      ; ATK_ANIM_SUPERSONIC_COPY
	dw AttackAnimation_PetalDance          ; ATK_ANIM_PETAL_DANCE
	dw AttackAnimation_Protect             ; ATK_ANIM_PROTECT
	dw AttackAnimation_Barrier             ; ATK_ANIM_BARRIER
	dw AttackAnimation_QuickAttack         ; ATK_ANIM_QUICK_ATTACK
	dw AttackAnimation_AgilityProtect      ; ATK_ANIM_AGILITY_PROTECT
	dw AttackAnimation_Whirlwind           ; ATK_ANIM_WHIRLWIND
	dw AttackAnimation_Cry                 ; ATK_ANIM_CRY
	dw AttackAnimation_Amnesia             ; ATK_ANIM_AMNESIA
	dw AttackAnimation_Selfdestruct        ; ATK_ANIM_SELFDESTRUCT
	dw AttackAnimation_BigSelfdestruction  ; ATK_ANIM_BIG_SELFDESTRUCTION
	dw AttackAnimation_Recover             ; ATK_ANIM_RECOVER
	dw AttackAnimation_Drain               ; ATK_ANIM_DRAIN
	dw AttackAnimation_DarkGas             ; ATK_ANIM_DARK_GAS
	dw AttackAnimation_GlowEffect          ; ATK_ANIM_GLOW_EFFECT
	dw AttackAnimation_MirrorMove          ; ATK_ANIM_MIRROR_MOVE
	dw AttackAnimation_DevolutionBeam      ; ATK_ANIM_DEVOLUTION_BEAM
	dw AttackAnimation_PkmnPower1          ; ATK_ANIM_PKMN_POWER_1
	dw AttackAnimation_Firegiver           ; ATK_ANIM_FIREGIVER
	dw AttackAnimation_Quickfreeze         ; ATK_ANIM_QUICKFREEZE
	dw AttackAnimation_PealOfThunder       ; ATK_ANIM_PEAL_OF_THUNDER
	dw AttackAnimation_HealingWind         ; ATK_ANIM_HEALING_WIND
	dw AttackAnimation_WhirlwindZigzag     ; ATK_ANIM_WHIRLWIND_ZIGZAG
	dw AttackAnimation_BigThunder          ; ATK_ANIM_BIG_THUNDER
	dw AttackAnimation_SolarPower          ; ATK_ANIM_SOLAR_POWER
	dw AttackAnimation_PoisonFang          ; ATK_ANIM_POISON_FANG
	dw AttackAnimation_Unused67            ; ATK_ANIM_UNUSED_67
	dw AttackAnimation_Unused68            ; ATK_ANIM_UNUSED_68
	dw AttackAnimation_Unused69            ; ATK_ANIM_UNUSED_69
	dw AttackAnimation_FriendshipSong      ; ATK_ANIM_FRIENDSHIP_SONG
	dw AttackAnimation_Scrunch             ; ATK_ANIM_SCRUNCH
	dw AttackAnimation_CatPunch            ; ATK_ANIM_CAT_PUNCH
	dw AttackAnimation_MagneticStorm       ; ATK_ANIM_MAGNETIC_STORM
	dw AttackAnimation_PoisonWhip          ; ATK_ANIM_POISON_WHIP
	dw AttackAnimation_ThunderWave         ; ATK_ANIM_THUNDER_WAVE
	dw AttackAnimation_Unused70            ; ATK_ANIM_UNUSED_70
	dw AttackAnimation_Spore               ; ATK_ANIM_SPORE
	dw AttackAnimation_Hypnosis            ; ATK_ANIM_HYPNOSIS
	dw AttackAnimation_EnergyConversion    ; ATK_ANIM_ENERGY_CONVERSION
	dw AttackAnimation_Leer                ; ATK_ANIM_LEER
	dw AttackAnimation_ConfusionHit        ; ATK_ANIM_CONFUSION_HIT
	dw AttackAnimation_Unused76            ; ATK_ANIM_UNUSED_76
	dw AttackAnimation_Unused77            ; ATK_ANIM_UNUSED_77
	dw AttackAnimation_BenchHit            ; ATK_ANIM_BENCH_HIT
	dw AttackAnimation_Heal                ; ATK_ANIM_HEAL
	dw AttackAnimation_RecoilHit           ; ATK_ANIM_RECOIL_HIT
	dw AttackAnimation_Poison              ; ATK_ANIM_POISON
	dw AttackAnimation_Confusion           ; ATK_ANIM_CONFUSION
	dw AttackAnimation_Paralysis           ; ATK_ANIM_PARALYSIS
	dw AttackAnimation_Sleep               ; ATK_ANIM_SLEEP
	dw AttackAnimation_ImakuniConfusion    ; ATK_ANIM_IMAKUNI_CONFUSION
	dw AttackAnimation_SleepingGas         ; ATK_ANIM_SLEEPING_GAS
	dw AttackAnimation_Unused81            ; ATK_ANIM_UNUSED_81
	dw AttackAnimation_ThunderPlayArea     ; ATK_ANIM_THUNDER_PLAY_AREA
	dw AttackAnimation_CatPunchPlayArea    ; ATK_ANIM_CAT_PUNCH_PLAY_AREA
	dw AttackAnimation_FiregiverPlayer     ; ATK_ANIM_FIREGIVER_PLAYER
	dw AttackAnimation_FiregiverOpp        ; ATK_ANIM_FIREGIVER_OPP
	dw AttackAnimation_HealingWindPlayArea ; ATK_ANIM_HEALING_WIND_PLAY_AREA
	dw AttackAnimation_Gale                ; ATK_ANIM_GALE
	dw AttackAnimation_Expand              ; ATK_ANIM_EXPAND
	dw AttackAnimation_Unused89            ; ATK_ANIM_UNUSED_89
	dw AttackAnimation_FullHeal            ; ATK_ANIM_FULL_HEAL
	dw AttackAnimation_Unused8B            ; ATK_ANIM_UNUSED_8B
	dw AttackAnimation_SpitPoisonSuccess   ; ATK_ANIM_SPIT_POISON_SUCCESS
	dw AttackAnimation_GustOfWind          ; ATK_ANIM_GUST_OF_WIND
	dw AttackAnimation_HealBothSides       ; ATK_ANIM_HEAL_BOTH_SIDES
	dw AttackAnimation_Unused8F            ; ATK_ANIM_UNUSED_8F
	dw AttackAnimation_Unused90            ; ATK_ANIM_UNUSED_90
	dw AttackAnimation_Unused91            ; ATK_ANIM_UNUSED_91
	dw AttackAnimation_Unused92            ; ATK_ANIM_UNUSED_92
	dw AttackAnimation_Unused93            ; ATK_ANIM_UNUSED_93
	dw AttackAnimation_Unused94            ; ATK_ANIM_UNUSED_94
	dw AttackAnimation_Unused95            ; ATK_ANIM_UNUSED_95
	dw AttackAnimation_Unused96            ; ATK_ANIM_UNUSED_96
	dw AttackAnimation_SneakAttack         ; ATK_ANIM_SNEAK_ATTACK
	dw AttackAnimation_Unused98            ; ATK_ANIM_UNUSED_98
	dw AttackAnimation_Unused99            ; ATK_ANIM_UNUSED_99
	dw AttackAnimation_LightningFlash      ; ATK_ANIM_LIGHTNING_FLASH
	dw AttackAnimation_Unused9B            ; ATK_ANIM_UNUSED_9B
	dw AttackAnimation_Unused9C            ; ATK_ANIM_UNUSED_9C
	dw AttackAnimation_Unused9D            ; ATK_ANIM_UNUSED_9D
	dw AttackAnimation_Fireball            ; ATK_ANIM_FIREBALL
	dw AttackAnimation_ContinuousFireball  ; ATK_ANIM_CONTINUOUS_FIREBALL
	dw AttackAnimation_FlamePillar         ; ATK_ANIM_FLAME_PILLAR
	dw AttackAnimation_WaterBomb           ; ATK_ANIM_WATER_BOMB
	dw AttackAnimation_UnusedA2            ; ATK_ANIM_UNUSED_A2
	dw AttackAnimation_UnusedA3            ; ATK_ANIM_UNUSED_A3
	dw AttackAnimation_UnusedA4            ; ATK_ANIM_UNUSED_A4
	dw AttackAnimation_BenchManipulation   ; ATK_ANIM_BENCH_MANIPULATION
	dw AttackAnimation_Blink               ; ATK_ANIM_BLINK
	dw AttackAnimation_UnusedA7            ; ATK_ANIM_UNUSED_A7
	dw AttackAnimation_UnusedA8            ; ATK_ANIM_UNUSED_A8
	dw AttackAnimation_Psybeam             ; ATK_ANIM_PSYBEAM
	dw AttackAnimation_UnusedAA            ; ATK_ANIM_UNUSED_AA
	dw AttackAnimation_UnusedAB            ; ATK_ANIM_UNUSED_AB
	dw AttackAnimation_AuroraWave          ; ATK_ANIM_AURORA_WAVE
	dw AttackAnimation_UnusedAD            ; ATK_ANIM_UNUSED_AD
	dw AttackAnimation_RockThrow           ; ATK_ANIM_ROCK_THROW
	dw AttackAnimation_BoulderSmash        ; ATK_ANIM_BOULDER_SMASH
	dw AttackAnimation_MegaPunch           ; ATK_ANIM_MEGA_PUNCH
	dw AttackAnimation_Psypunch            ; ATK_ANIM_PSYPUNCH
	dw AttackAnimation_SludgePunch         ; ATK_ANIM_SLUDGE_PUNCH
	dw AttackAnimation_UnusedB3            ; ATK_ANIM_UNUSED_B3
	dw AttackAnimation_UnusedB4            ; ATK_ANIM_UNUSED_B4
	dw AttackAnimation_IcePunch            ; ATK_ANIM_ICE_PUNCH
	dw AttackAnimation_LegSweep            ; ATK_ANIM_LEG_SWEEP
	dw AttackAnimation_UnusedB7            ; ATK_ANIM_UNUSED_B7
	dw AttackAnimation_SparkingKick        ; ATK_ANIM_SPARKING_KICK
	dw AttackAnimation_UnusedB9            ; ATK_ANIM_UNUSED_B9
	dw AttackAnimation_PollenStench        ; ATK_ANIM_POLLEN_STENCH
	dw AttackAnimation_UnusedBB            ; ATK_ANIM_UNUSED_BB
	dw AttackAnimation_UnusedBC            ; ATK_ANIM_UNUSED_BC
	dw AttackAnimation_UnusedBD            ; ATK_ANIM_UNUSED_BD
	dw AttackAnimation_PoisonVapor         ; ATK_ANIM_POISON_VAPOR
	dw AttackAnimation_PoisonGasCopy       ; ATK_ANIM_POISON_GAS_COPY
	dw AttackAnimation_EerieLight          ; ATK_ANIM_EERIE_LIGHT
	dw AttackAnimation_Spookify            ; ATK_ANIM_SPOOKIFY
	dw AttackAnimation_MassExplosion       ; ATK_ANIM_MASS_EXPLOSION
	dw AttackAnimation_GasExplosion        ; ATK_ANIM_GAS_EXPLOSION
	dw AttackAnimation_UnusedC4            ; ATK_ANIM_UNUSED_C4
	dw AttackAnimation_UnusedC5            ; ATK_ANIM_UNUSED_C5
	dw AttackAnimation_Lick                ; ATK_ANIM_LICK
	dw AttackAnimation_UnusedC7            ; ATK_ANIM_UNUSED_C7
	dw AttackAnimation_TailSlap            ; ATK_ANIM_TAIL_SLAP
	dw AttackAnimation_TailWhip            ; ATK_ANIM_TAIL_WHIP
	dw AttackAnimation_UnusedCA            ; ATK_ANIM_UNUSED_CA
	dw AttackAnimation_Slap                ; ATK_ANIM_SLAP
	dw AttackAnimation_UnusedCC            ; ATK_ANIM_UNUSED_CC
	dw AttackAnimation_RocketTackle        ; ATK_ANIM_ROCKET_TACKLE
	dw AttackAnimation_Stare               ; ATK_ANIM_STARE
	dw AttackAnimation_UnusedCF            ; ATK_ANIM_UNUSED_CF
	dw AttackAnimation_CoinHurl            ; ATK_ANIM_COIN_HURL
	dw AttackAnimation_UnusedD1            ; ATK_ANIM_UNUSED_D1
	dw AttackAnimation_Teleport            ; ATK_ANIM_TELEPORT
	dw AttackAnimation_TeleportBlast       ; ATK_ANIM_TELEPORT_BLAST
	dw AttackAnimation_FollowMe            ; ATK_ANIM_FOLLOW_ME
	dw AttackAnimation_ShiningFinger       ; ATK_ANIM_SHINING_FINGER
	dw AttackAnimation_UnusedD6            ; ATK_ANIM_UNUSED_D6
	dw AttackAnimation_SuspiciousSoundwave ; ATK_ANIM_SUSPICIOUS_SOUNDWAVE
	dw AttackAnimation_3dAttack            ; ATK_ANIM_3D_ATTACK
	dw AttackAnimation_UnusedD9            ; ATK_ANIM_UNUSED_D9
	dw AttackAnimation_RollOver            ; ATK_ANIM_ROLL_OVER
	dw AttackAnimation_Swift               ; ATK_ANIM_SWIFT
	dw AttackAnimation_UnusedDC            ; ATK_ANIM_UNUSED_DC
	dw AttackAnimation_UnusedDD            ; ATK_ANIM_UNUSED_DD
	dw AttackAnimation_ColdBreath          ; ATK_ANIM_COLD_BREATH
	dw AttackAnimation_DryUp               ; ATK_ANIM_DRY_UP
	dw AttackAnimation_UnusedE0            ; ATK_ANIM_UNUSED_E0
	dw AttackAnimation_TransDamage         ; ATK_ANIM_TRANS_DAMAGE
	dw AttackAnimation_FocusBlast          ; ATK_ANIM_FOCUS_BLAST
	dw AttackAnimation_UnusedE3            ; ATK_ANIM_UNUSED_E3
	dw AttackAnimation_UnusedE4            ; ATK_ANIM_UNUSED_E4
	dw AttackAnimation_FadeToBlack         ; ATK_ANIM_FADE_TO_BLACK
	dw AttackAnimation_UnusedE8            ; ATK_ANIM_UNUSED_E8
	dw AttackAnimation_PoisonSeed          ; ATK_ANIM_POISON_SEED
	dw AttackAnimation_Twiddle             ; ATK_ANIM_TWIDDLE
	dw AttackAnimation_UnusedE9            ; ATK_ANIM_UNUSED_E9
	dw AttackAnimation_BigYawn             ; ATK_ANIM_BIG_YAWN
	dw AttackAnimation_BigSnore            ; ATK_ANIM_BIG_SNORE
	dw AttackAnimation_SandVeil            ; ATK_ANIM_SAND_VEIL
	dw AttackAnimation_UnusedED            ; ATK_ANIM_UNUSED_ED
	dw AttackAnimation_HelpingHand         ; ATK_ANIM_HELPING_HAND
	dw AttackAnimation_Rest                ; ATK_ANIM_REST
	dw AttackAnimation_TerrorStrike        ; ATK_ANIM_TERROR_STRIKE
	dw AttackAnimation_SkullBash           ; ATK_ANIM_SKULL_BASH
	dw AttackAnimation_RazorLeaf           ; ATK_ANIM_RAZOR_LEAF
	dw AttackAnimation_Guillotine          ; ATK_ANIM_GUILLOTINE
	dw AttackAnimation_VinePull            ; ATK_ANIM_VINE_PULL
	dw AttackAnimation_FuryStrikes         ; ATK_ANIM_FURY_STRIKES
	dw AttackAnimation_DrillDive           ; ATK_ANIM_DRILL_DIVE
	dw AttackAnimation_DarkSong            ; ATK_ANIM_DARK_SONG
	dw AttackAnimation_UnusedF8            ; ATK_ANIM_UNUSED_F8
	dw AttackAnimation_Perplex             ; ATK_ANIM_PERPLEX
	dw AttackAnimation_NineTails           ; ATK_ANIM_NINE_TAILS
	dw AttackAnimation_SpinningShower      ; ATK_ANIM_SPINNING_SHOWER
	dw AttackAnimation_SurpriseThunder     ; ATK_ANIM_SURPRISE_THUNDER
	dw AttackAnimation_PushAside           ; ATK_ANIM_PUSH_ASIDE
	dw AttackAnimation_BoneHeadbutt        ; ATK_ANIM_BONE_HEADBUTT
	dw AttackAnimation_UnusedFF            ; ATK_ANIM_UNUSED_FF

AttackAnimation_Hit:
AttackAnimation_Earthquake:
AttackAnimation_HitRecoil:
AttackAnimation_HitEffect:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_BigHit:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_BIG_HIT
	anim_normal    DUEL_ANIM_BIG_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Thundershock:
AttackAnimation_Thunder:
AttackAnimation_ThundershockCopy:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_THUNDER_SHOCK
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Thunderbolt:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_LIGHTNING
	anim_opponent  DUEL_ANIM_BORDER_SPARK
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_ThunderWholeScreen:
AttackAnimation_Unused0B:
AttackAnimation_Thunderstorm:
AttackAnimation_ChainLightning:
	anim_player    DUEL_ANIM_GLOW
	anim_normal    DUEL_ANIM_FLASH
	anim_normal    DUEL_ANIM_BIG_LIGHTNING
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_SmallFlame:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_SMALL_FLAME
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_BigFlame:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_BIG_FLAME
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_FireSpin:
	anim_player    DUEL_ANIM_GLOW
	anim_normal    DUEL_ANIM_FIRE_SPIN
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_DiveBomb:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_DIVE_BOMB
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_WaterJets:
	anim_player    DUEL_ANIM_GLOW
	anim_normal    DUEL_ANIM_WATER_JETS
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_WaterGun:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_WATER_GUN
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Whirlpool:
	anim_player    DUEL_ANIM_GLOW
	anim_normal    DUEL_ANIM_WHIRLPOOL
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_DragonRage:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_LIGHTNING
	anim_opponent  DUEL_ANIM_WATER_GUN
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_HydroPump:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_HYDRO_PUMP
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Aeroblast:
AttackAnimation_Blizzard:
	anim_player    DUEL_ANIM_GLOW
	anim_normal    DUEL_ANIM_BLIZZARD
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_PsychicHit:
AttackAnimation_Nightmare:
AttackAnimation_Psyshock:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_PSYCHIC
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_DarkMind:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_LEER
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Beam:
AttackAnimation_IceBeam:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_BEAM
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_HyperBeam:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_HYPER_BEAM
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Avalanche:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_ROCK_THROW
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_StoneBarrage:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_STONE_BARRAGE
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Punch:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_PUNCH
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Thunderpunch:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_THUNDERPUNCH
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_FirePunch:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_FIRE_PUNCH
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_StretchKick:
	anim_player    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_STRETCH_KICK
	anim_end

AttackAnimation_Slash:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_SLASH
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Whip:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_WHIP
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Tear:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_SONICBOOM
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_MultipleSlash:
AttackAnimation_Unused2A:
AttackAnimation_Rampage:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_FURY_SWIPES
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Drill:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_DRILL
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_PotSmash:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_POT_SMASH
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Bonemerang:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_BONEMERANG
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_SeismicToss:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_SEISMIC_TOSS
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Needles:
AttackAnimation_PoisonNeedle:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_NEEDLES
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Smog:
AttackAnimation_PoisonGas:
AttackAnimation_Unused34:
AttackAnimation_FoulGas:
AttackAnimation_FoulOdor:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_WHITE_GAS
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_PowderEffectChance:
AttackAnimation_PowderHitPoison:
AttackAnimation_Unused3A:
AttackAnimation_StunSpore:
AttackAnimation_Poisonpowder:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_POWDER
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_PoisonPowder:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_POWDER
	anim_end

AttackAnimation_Goo:
AttackAnimation_Unused3E:
AttackAnimation_StickyHands:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_GOO
	anim_normal    DUEL_ANIM_DISTORT
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_SpitPoison:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_GOO
	anim_normal    DUEL_ANIM_DISTORT
	anim_end

AttackAnimation_Bubbles:
AttackAnimation_BubblesCopy:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_BUBBLES
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_StringShot:
AttackAnimation_Unused44:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_STRING_SHOT
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Boyfriends:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_BOYFRIENDS
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Lure:
	anim_player    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_LURE
	anim_normal    DUEL_ANIM_DISTORT
	anim_end

AttackAnimation_Toxic:
	anim_player    DUEL_ANIM_GLOW
	anim_normal    DUEL_ANIM_DISTORT
	anim_opponent  DUEL_ANIM_TOXIC
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_ConfuseRay:
AttackAnimation_Unused49:
	anim_player    DUEL_ANIM_GLOW
	anim_normal    DUEL_ANIM_FLASH
	anim_opponent  DUEL_ANIM_CONFUSE_RAY
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Sing:
AttackAnimation_Lullaby:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_SING
	anim_end

AttackAnimation_Supersonic:
AttackAnimation_SupersonicCopy:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_SUPERSONIC
	anim_end

AttackAnimation_PetalDance:
	anim_player    DUEL_ANIM_GLOW
	anim_normal    DUEL_ANIM_PETAL_DANCE
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Protect:
	anim_player    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_PROTECT
	anim_end

AttackAnimation_Barrier:
	anim_player    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_BARRIER
	anim_end

AttackAnimation_QuickAttack:
	anim_player    DUEL_ANIM_GLOW
	anim_normal    DUEL_ANIM_SPEED
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_AgilityProtect:
	anim_player    DUEL_ANIM_GLOW
	anim_normal    DUEL_ANIM_SPEED
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_player    DUEL_ANIM_PROTECT
	anim_end

AttackAnimation_Whirlwind:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_WHIRLWIND
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Cry:
	anim_player    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_CRY
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_end

AttackAnimation_Amnesia:
	anim_player    DUEL_ANIM_GLOW
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_QUESTION_MARK
	anim_end

AttackAnimation_Selfdestruct:
	anim_player    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_SELFDESTRUCT
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_BigSelfdestruction:
	anim_player    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_BIG_SELFDESTRUCT_1
	anim_normal    DUEL_ANIM_FLASH
	anim_player    DUEL_ANIM_BIG_SELFDESTRUCT_2
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Recover:
	anim_player    DUEL_ANIM_GLOW
	anim_end

AttackAnimation_Drain:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_DRAIN
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_DarkGas:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_DARK_GAS
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_opponent  DUEL_ANIM_QUESTION_MARK
	anim_end

AttackAnimation_GlowEffect:
	anim_player    DUEL_ANIM_GLOW
	anim_normal    DUEL_ANIM_FLASH
	anim_end

AttackAnimation_MirrorMove:
	anim_player    DUEL_ANIM_GLOW
	anim_normal    DUEL_ANIM_FLASH
	anim_opponent  DUEL_ANIM_GLOW
	anim_end

AttackAnimation_DevolutionBeam:
	anim_player    DUEL_ANIM_GLOW
	anim_normal    DUEL_ANIM_FLASH
	anim_screen    DUEL_ANIM_CONFUSION
	anim_play_area DUEL_ANIM_BENCH_GLOW
	anim_end

AttackAnimation_PkmnPower1:
	anim_screen    DUEL_ANIM_CONFUSION
	anim_play_area DUEL_ANIM_BENCH_GLOW
	anim_normal    DUEL_ANIM_FLASH
	anim_end

AttackAnimation_Firegiver:
	anim_screen    DUEL_ANIM_CONFUSION
	anim_play_area DUEL_ANIM_BENCH_GLOW
	anim_normal    DUEL_ANIM_FLASH
	anim_play_area DUEL_ANIM_FIREGIVER_START
	anim_play_area DUEL_ANIM_FIREGIVER_START
	anim_end

AttackAnimation_Quickfreeze:
	anim_screen    DUEL_ANIM_CONFUSION
	anim_play_area DUEL_ANIM_BENCH_GLOW
	anim_normal    DUEL_ANIM_QUICKFREEZE
	anim_screen    DUEL_ANIM_GLOW
	anim_end

AttackAnimation_PealOfThunder:
	anim_screen    DUEL_ANIM_CONFUSION
	anim_play_area DUEL_ANIM_BENCH_GLOW
	anim_play_area DUEL_ANIM_BENCH_THUNDER
	anim_screen    DUEL_ANIM_CONFUSION
	anim_play_area DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_play_area DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_HealingWind:
	anim_screen    DUEL_ANIM_CONFUSION
	anim_play_area DUEL_ANIM_BENCH_GLOW
	anim_play_area DUEL_ANIM_HEALING_WIND
	anim_end

AttackAnimation_WhirlwindZigzag:
	anim_player    DUEL_ANIM_GLOW
	anim_screen    DUEL_ANIM_CONFUSION
	anim_normal    DUEL_ANIM_BENCH_WHIRLWIND
	anim_end

AttackAnimation_BigThunder:
	anim_player    DUEL_ANIM_GLOW
	anim_end

AttackAnimation_SolarPower:
	anim_player    DUEL_ANIM_GLOW
	anim_normal    DUEL_ANIM_FLASH
	anim_end

AttackAnimation_PoisonFang:
AttackAnimation_Unused67:
AttackAnimation_Unused68:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Unused69:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_NEEDLES
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_FriendshipSong:
	anim_player    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_SING
	anim_end

AttackAnimation_Scrunch:
	anim_player    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_EXPAND
	anim_end

AttackAnimation_CatPunch:
	anim_player    DUEL_ANIM_GLOW
	anim_end

AttackAnimation_MagneticStorm:
	anim_player    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_THUNDER_WAVE
	anim_end

AttackAnimation_PoisonWhip:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_WHIP
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_ThunderWave:
AttackAnimation_Unused70:
	anim_player    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_THUNDER_WAVE
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Spore:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_POWDER
	anim_end

AttackAnimation_Hypnosis:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_PSYCHIC
	anim_end

AttackAnimation_EnergyConversion:
	anim_player    DUEL_ANIM_GLOW
	anim_normal    DUEL_ANIM_FLASH
	anim_end

AttackAnimation_Leer:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_LEER
	anim_opponent  DUEL_ANIM_QUESTION_MARK
	anim_end

AttackAnimation_ConfusionHit:
	anim_player    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_CONFUSION
	anim_player    DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_Y
	anim_player    DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Unused76:
	anim_player    DUEL_ANIM_GLOW
	anim_normal    DUEL_ANIM_WATER_JETS
	anim_end

AttackAnimation_Unused77:
	anim_end

AttackAnimation_BenchHit:
	anim_screen    DUEL_ANIM_CONFUSION
	anim_play_area DUEL_ANIM_SINGLE_HIT
	anim_play_area DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Heal:
	anim_player    DUEL_ANIM_HEAL
	anim_player    DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_RecoilHit:
	anim_screen    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_Y
	anim_player    DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Poison:
	anim_screen    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_POISON
	anim_end

AttackAnimation_Confusion:
	anim_screen    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_CONFUSION
	anim_end

AttackAnimation_Paralysis:
	anim_screen    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_PARALYSIS
	anim_end

AttackAnimation_Sleep:
	anim_screen    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_SLEEP
	anim_end

AttackAnimation_ImakuniConfusion:
	anim_screen    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_CONFUSION
	anim_end

AttackAnimation_SleepingGas:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_WHITE_GAS
	anim_end

AttackAnimation_Unused81:
	anim_opponent  DUEL_ANIM_QUESTION_MARK
	anim_end

AttackAnimation_ThunderPlayArea:
	anim_screen    DUEL_ANIM_CONFUSION
	anim_play_area DUEL_ANIM_BENCH_THUNDER
	anim_play_area DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_play_area DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_CatPunchPlayArea:
	anim_screen    DUEL_ANIM_CONFUSION
	anim_play_area DUEL_ANIM_CAT_PUNCH
	anim_play_area DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_play_area DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_FiregiverPlayer:
	anim_screen    DUEL_ANIM_CONFUSION
	anim_normal    DUEL_ANIM_FIREGIVER_PLAYER
	anim_end

AttackAnimation_FiregiverOpp:
	anim_screen    DUEL_ANIM_CONFUSION
	anim_normal    DUEL_ANIM_FIREGIVER_OPP
	anim_end

AttackAnimation_HealingWindPlayArea:
	anim_screen    DUEL_ANIM_CONFUSION
	anim_play_area DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Gale:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_WHIRLWIND
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_normal    DUEL_ANIM_FLASH
	anim_end

AttackAnimation_Expand:
	anim_player    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_EXPAND
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Unused89:
	anim_player    DUEL_ANIM_POISON
	anim_player    DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_FullHeal:
	anim_player    DUEL_ANIM_HEAL
	anim_normal    DUEL_ANIM_UPDATE_HUD
	anim_end

AttackAnimation_Unused8B:
	anim_player    DUEL_ANIM_SLEEP
	anim_normal    DUEL_ANIM_UPDATE_HUD
	anim_end

AttackAnimation_SpitPoisonSuccess:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_GOO
	anim_normal    DUEL_ANIM_DISTORT
	anim_end

AttackAnimation_GustOfWind:
	anim_opponent  DUEL_ANIM_WHIRLWIND
	anim_end

AttackAnimation_HealBothSides:
	anim_screen    DUEL_ANIM_CONFUSION
	anim_play_area DUEL_ANIM_BENCH_GLOW
	anim_screen    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_HEAL
	anim_opponent  DUEL_ANIM_HEAL
	anim_end

AttackAnimation_Unused8F:
	anim_screen    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Unused90:
	anim_screen    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_SLEEP
	anim_end

AttackAnimation_Unused91:
	anim_screen    DUEL_ANIM_CONFUSION
	anim_play_area DUEL_ANIM_SINGLE_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_play_area DUEL_ANIM_SHOW_DAMAGE
	anim_play_area DUEL_ANIM_72
	anim_end

AttackAnimation_Unused92:
	anim_screen    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_POISON
	anim_end

AttackAnimation_Unused93:
	anim_player    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_THUNDER_WAVE
	anim_screen    DUEL_ANIM_CONFUSION
	anim_play_area DUEL_ANIM_SINGLE_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_play_area DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Unused94:
AttackAnimation_Unused95:
AttackAnimation_Unused96:
	anim_end

AttackAnimation_SneakAttack:
AttackAnimation_Unused98:
	anim_screen    DUEL_ANIM_CONFUSION
	anim_play_area DUEL_ANIM_SINGLE_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_play_area DUEL_ANIM_SHOW_DAMAGE
AttackAnimation_Unused99:
	anim_end

AttackAnimation_LightningFlash:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_THUNDER_SHOCK
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_opponent  DUEL_ANIM_QUESTION_MARK
	anim_end

AttackAnimation_Unused9B:
	anim_player    DUEL_ANIM_GLOW
	anim_screen    DUEL_ANIM_CONFUSION
	anim_play_area DUEL_ANIM_BENCH_THUNDER
	anim_play_area DUEL_ANIM_SINGLE_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_play_area DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Unused9C:
AttackAnimation_Unused9D:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_LIGHTNING
	anim_opponent  DUEL_ANIM_BORDER_SPARK
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Fireball:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_64
	anim_opponent  DUEL_ANIM_BIG_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_ContinuousFireball:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_65
	anim_opponent  DUEL_ANIM_BIG_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_FlamePillar:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_SMALL_FLAME
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_WaterBomb:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_HYDRO_PUMP
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_UnusedA2:
	anim_opponent  DUEL_ANIM_PSYCHIC
	anim_end

AttackAnimation_UnusedA3:
	anim_player    DUEL_ANIM_PSYCHIC
	anim_end

AttackAnimation_UnusedA4:
	anim_end

AttackAnimation_BenchManipulation:
	anim_player    DUEL_ANIM_GLOW
	anim_screen    DUEL_ANIM_CONFUSION
	anim_normal    DUEL_ANIM_66
	anim_play_area DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_play_area DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Blink:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_BEAM
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_player    DUEL_ANIM_PROTECT
	anim_end

AttackAnimation_UnusedA7:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_PSYCHIC
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_UnusedA8:
	anim_player    DUEL_ANIM_GLOW
	anim_screen    DUEL_ANIM_CONFUSION
	anim_play_area DUEL_ANIM_66
	anim_play_area DUEL_ANIM_SINGLE_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_play_area DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Psybeam:
AttackAnimation_AuroraWave:
AttackAnimation_UnusedAD:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_67
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_UnusedAA:
	anim_screen    DUEL_ANIM_CONFUSION
	anim_play_area DUEL_ANIM_BENCH_GLOW
	anim_screen    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_67
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_UnusedAB:
	anim_player    DUEL_ANIM_GLOW
	anim_screen    DUEL_ANIM_CONFUSION
	anim_play_area DUEL_ANIM_68
	anim_play_area DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_play_area DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_RockThrow:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_69
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_BoulderSmash:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_69
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_MegaPunch:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_6A
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Psypunch:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_6B
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_SludgePunch:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_6C
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_UnusedB3:
	anim_screen    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_69
	anim_screen    DUEL_ANIM_CONFUSION
	anim_play_area DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_play_area DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_UnusedB4:
AttackAnimation_IcePunch:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_6D
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_LegSweep:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_6E
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_UnusedB7:
AttackAnimation_SparkingKick:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_6E
	anim_opponent  DUEL_ANIM_BORDER_SPARK
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_UnusedB9:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_6E
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_PollenStench:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_POWDER
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_end

AttackAnimation_UnusedBB:
	anim_screen    DUEL_ANIM_CONFUSION
	anim_play_area DUEL_ANIM_BENCH_GLOW
	anim_screen    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_POWDER
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_end

AttackAnimation_UnusedBC:
	anim_screen    DUEL_ANIM_CONFUSION
	anim_play_area DUEL_ANIM_BENCH_GLOW
	anim_screen    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_POWDER
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_end

AttackAnimation_UnusedBD:
	anim_end

AttackAnimation_PoisonVapor:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_WHITE_GAS
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_EerieLight:
	anim_player    DUEL_ANIM_GLOW
	anim_normal    DUEL_ANIM_FLASH
	anim_opponent  DUEL_ANIM_CONFUSE_RAY
	anim_end

AttackAnimation_PoisonGasCopy:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_WHITE_GAS
	anim_end

AttackAnimation_Spookify:
	anim_player    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_LEER
	anim_normal    DUEL_ANIM_FLASH
	anim_opponent  DUEL_ANIM_QUESTION_MARK
	anim_end

AttackAnimation_MassExplosion:
	anim_player    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_BIG_SELFDESTRUCT_1
	anim_normal    DUEL_ANIM_FLASH
	anim_player    DUEL_ANIM_BIG_SELFDESTRUCT_2
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_GasExplosion:
AttackAnimation_UnusedC4:
	anim_player    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_SELFDESTRUCT
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_UnusedC5:
AttackAnimation_Lick:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_GOO
	anim_normal    DUEL_ANIM_DISTORT
	anim_end

AttackAnimation_UnusedC7:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_GOO
	anim_normal    DUEL_ANIM_DISTORT
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_player    DUEL_ANIM_QUESTION_MARK
	anim_end

AttackAnimation_TailSlap:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_6F
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_TailWhip:
	anim_player    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_70
	anim_normal    DUEL_ANIM_DISTORT
	anim_opponent  DUEL_ANIM_QUESTION_MARK
	anim_end

AttackAnimation_UnusedCA:
	anim_player    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_70
	anim_end

AttackAnimation_Slap:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_71
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_UnusedCC:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_73
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_RocketTackle:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_73
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_player    DUEL_ANIM_PROTECT
	anim_end

AttackAnimation_Stare:
	anim_player    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_LEER
	anim_normal    DUEL_ANIM_FLASH
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_opponent  DUEL_ANIM_QUESTION_MARK
	anim_end

AttackAnimation_UnusedCF:
	anim_player    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_LEER
	anim_normal    DUEL_ANIM_FLASH
	anim_end

AttackAnimation_CoinHurl:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_74
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_UnusedD1:
	anim_player    DUEL_ANIM_GLOW
	anim_screen    DUEL_ANIM_CONFUSION
	anim_play_area DUEL_ANIM_7D
	anim_play_area DUEL_ANIM_SINGLE_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_play_area DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Teleport:
	anim_player    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_75
	anim_end

AttackAnimation_TeleportBlast:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_PSYCHIC
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_player    DUEL_ANIM_75
	anim_end

AttackAnimation_FollowMe:
	anim_player    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_76
	anim_end

AttackAnimation_ShiningFinger:
	anim_player    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_76
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_UnusedD6:
AttackAnimation_SuspiciousSoundwave:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_SUPERSONIC
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_3dAttack:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_78
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_UnusedD9:
AttackAnimation_RollOver:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Swift:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_77
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_UnusedDC:
	anim_player    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_THUNDER_WAVE
	anim_screen    DUEL_ANIM_CONFUSION
	anim_play_area DUEL_ANIM_SINGLE_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_play_area DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_UnusedDD:
AttackAnimation_ColdBreath:
	anim_player    DUEL_ANIM_GLOW
	anim_normal    DUEL_ANIM_QUICKFREEZE
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_DryUp:
	anim_player    DUEL_ANIM_GLOW
	anim_normal    DUEL_ANIM_79
	anim_end

AttackAnimation_UnusedE0:
	anim_player    DUEL_ANIM_GLOW
	anim_normal    DUEL_ANIM_SPEED
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_TransDamage:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_DRAIN
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_FocusBlast:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_7A
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_UnusedE3:
	anim_player    DUEL_ANIM_GLOW
	anim_screen    DUEL_ANIM_CONFUSION
	anim_play_area DUEL_ANIM_7B
	anim_play_area DUEL_ANIM_SINGLE_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_play_area DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_UnusedE4:
AttackAnimation_FadeToBlack:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_DARK_GAS
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_UnusedE8:
	anim_player    DUEL_ANIM_GLOW
	anim_screen    DUEL_ANIM_CONFUSION
	anim_play_area DUEL_ANIM_7C
	anim_play_area DUEL_ANIM_SINGLE_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_play_area DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_PoisonSeed:
AttackAnimation_Twiddle:
	anim_end

AttackAnimation_UnusedE9:
AttackAnimation_BigYawn:
	anim_player    DUEL_ANIM_GLOW
	anim_end

AttackAnimation_BigSnore:
	anim_player    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_SLEEP
	anim_opponent  DUEL_ANIM_7E
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_SandVeil:
	anim_player    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_PROTECT
	anim_end

AttackAnimation_UnusedED:
	anim_player    DUEL_ANIM_GLOW
	anim_normal    DUEL_ANIM_SMALL_SHAKE_Y
	anim_player    DUEL_ANIM_QUESTION_MARK
	anim_end

AttackAnimation_HelpingHand:
	anim_player    DUEL_ANIM_HEAL
	anim_end

AttackAnimation_Rest:
	anim_player    DUEL_ANIM_GLOW
	anim_end

AttackAnimation_TerrorStrike:
	anim_player    DUEL_ANIM_GLOW
	anim_player    DUEL_ANIM_LEER
	anim_normal    DUEL_ANIM_FLASH
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_SkullBash:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_73
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_RazorLeaf:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_7F
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_Guillotine:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_80
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_VinePull:
	anim_opponent  DUEL_ANIM_81
	anim_end

AttackAnimation_FuryStrikes:
	anim_end

AttackAnimation_DrillDive:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_85
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_DarkSong:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_86
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_UnusedF8:
	anim_end

AttackAnimation_Perplex:
	anim_player    DUEL_ANIM_GLOW
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_82
	anim_end

AttackAnimation_NineTails:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_83
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_SpinningShower:
	anim_player    DUEL_ANIM_GLOW
	anim_screen    DUEL_ANIM_CONFUSION
	anim_normal    DUEL_ANIM_WATER_JETS
	anim_end

AttackAnimation_SurpriseThunder:
	anim_player    DUEL_ANIM_GLOW
	anim_normal    DUEL_ANIM_FLASH
	anim_normal    DUEL_ANIM_BIG_LIGHTNING
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_PushAside:
	anim_player    DUEL_ANIM_GLOW
	anim_screen    DUEL_ANIM_CONFUSION
	anim_normal    DUEL_ANIM_HEALING_WIND
	anim_play_area DUEL_ANIM_SINGLE_HIT
	anim_end

AttackAnimation_BoneHeadbutt:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_84
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_end

AttackAnimation_UnusedFF:
	anim_player    DUEL_ANIM_GLOW
	anim_opponent  DUEL_ANIM_BONEMERANG
	anim_opponent  DUEL_ANIM_HIT
	anim_normal    DUEL_ANIM_SMALL_SHAKE_X
	anim_opponent  DUEL_ANIM_SHOW_DAMAGE
	anim_opponent  DUEL_ANIM_QUESTION_MARK
	anim_end

; if carry flag is set, only delays
; if carry not set:
; - set rRP edge up, wait;
; - set rRP edge down, wait;
; - return
TransmitIRBit:
	jr c, .delay_once
	ld [hl], RP_WRITE_HIGH | RP_ENABLE
	ld a, 5
	jr .loop_delay_1 ; jump to possibly to add more cycles?
.loop_delay_1
	dec a
	jr nz, .loop_delay_1
	ld [hl], RP_WRITE_LOW | RP_ENABLE
	ld a, 14
	jr .loop_delay_2 ; jump to possibly to add more cycles?
.loop_delay_2
	dec a
	jr nz, .loop_delay_2
	ret

.delay_once
	ld a, 21
	jr .loop_delay_3 ; jump to possibly to add more cycles?
.loop_delay_3
	dec a
	jr nz, .loop_delay_3
	nop
	ret

; input a = byte to transmit through IR
TransmitByteThroughIR:
	push hl
	ld hl, rRP
	push de
	push bc
	ld b, a
	scf  ; carry set
	call TransmitIRBit
	or a ; carry not set
	call TransmitIRBit
	ld c, 8
	ld c, 8 ; number of input bits
.loop
	ld a, $00
	rr b
	call TransmitIRBit
	dec c
	jr nz, .loop
	pop bc
	pop de
	pop hl
	ldh a, [rJOYP]
	bit 1, a ; P11
	jr z, ReturnZFlagUnsetAndCarryFlagSet
	xor a ; return z set
	ret

; same as ReceiveByteThroughIR but
; returns $0 in a if there's an error in IR
ReceiveByteThroughIR_ZeroIfUnsuccessful:
	call ReceiveByteThroughIR
	ret nc
	xor a
	ret

	; returns carry if there's some time out
; and output in register a of $ff
; otherwise returns in a some sequence of bits
; related to how rRP sets/unsets bit 1
ReceiveByteThroughIR:
	push de
	push bc
	push hl

; waits for bit 1 in rRP to be unset
; up to $100 loops
	ld b, 0
	ld hl, rRP
.wait_ir
	bit B_RP_DATA_IN, [hl]
	jr z, .ok
	dec b
	jr nz, .wait_ir
	; looped around $100 times
	; return $ff and carry set
	pop hl
	pop bc
	pop de
	scf
	ld a, $ff
	ret

.ok
; delay for some cycles
	ld a, 15
.loop_delay
	dec a
	jr nz, .loop_delay

; loop for each bit
	ld e, 8
.loop
	ld a, $01
	; possibly delay cycles?
	ld b, 9
	ld b, 9
	ld b, 9
	ld b, 9

; checks for bit 1 in rRP
; if in any of the checks it is unset,
; then a is set to 0
; this is done a total of 9 times
	bit B_RP_DATA_IN, [hl]
	jr nz, .asm_196ec
	xor a
.asm_196ec
	bit B_RP_DATA_IN, [hl]
	jr nz, .asm_196f1
	xor a
.asm_196f1
	dec b
	jr nz, .asm_196ec
	; one bit received
	rrca
	rr d
	dec e
	jr nz, .loop
	ld a, d ; has bits set for each "cycle" that bit 1 was not unset
	pop hl
	pop bc
	pop de
	or a
	ret

ReturnZFlagUnsetAndCarryFlagSet:
	ld a, $ff
	or a ; z not set
	scf  ; carry set
	ret

; called when expecting to transmit data
Func_196e8:
	ld hl, rRP
.loop
	ldh a, [rJOYP]
	bit 1, a
	jr z, ReturnZFlagUnsetAndCarryFlagSet
	ld a, $a5 ; request
	call TransmitByteThroughIR
	push hl
	pop hl
	call ReceiveByteThroughIR_ZeroIfUnsuccessful
	cp $35 ; acknowledge
	jr nz, .loop
	xor a
	ret

; called when expecting to receive data
Func_1971e:
	ld hl, rRP
.asm_19721
	ldh a, [rJOYP]
	bit 1, a
	jr z, ReturnZFlagUnsetAndCarryFlagSet
	call ReceiveByteThroughIR_ZeroIfUnsuccessful
	cp $a5 ; request
	jr nz, .asm_19721
	ld a, $35 ; acknowledge
	call TransmitByteThroughIR
	xor a
	ret

ReturnZFlagUnsetAndCarryFlagSet2:
	jp ReturnZFlagUnsetAndCarryFlagSet

TransmitIRDataBuffer:
	call Func_196e8
	jr c, ReturnZFlagUnsetAndCarryFlagSet2
	ld a, $49
	call TransmitByteThroughIR
	ld a, $52
	call TransmitByteThroughIR
	ld hl, wIRDataBuffer
	ld c, 8
	jr TransmitNBytesFromHLThroughIR

ReceiveIRDataBuffer:
	call Func_1971e
	jr c, ReturnZFlagUnsetAndCarryFlagSet2
	call ReceiveByteThroughIR
	cp $49
	jr nz, ReceiveIRDataBuffer
	call ReceiveByteThroughIR
	cp $52
	jr nz, ReceiveIRDataBuffer
	ld hl, wIRDataBuffer
	ld c, 8
	jr ReceiveNBytesToHLThroughIR

; hl = start of data to transmit
; c = number of bytes to transmit
TransmitNBytesFromHLThroughIR:
	ld b, $0
.loop_data_bytes
	ld a, b
	add [hl]
	ld b, a
	ld a, [hli]
	call TransmitByteThroughIR
	jr c, .asm_1977c
	dec c
	jr nz, .loop_data_bytes
	ld a, b
	cpl
	inc a
	call TransmitByteThroughIR
.asm_1977c
	ret

; hl = address to write received data
; c = number of bytes to be received
ReceiveNBytesToHLThroughIR:
	ld b, 0
.loop_data_bytes
	call ReceiveByteThroughIR
	jr c, ReturnZFlagUnsetAndCarryFlagSet2
	ld [hli], a
	add b
	ld b, a
	dec c
	jr nz, .loop_data_bytes
	call ReceiveByteThroughIR
	add b
	or a
	jr nz, ReturnZFlagUnsetAndCarryFlagSet2
	ret

; disables interrupts, and sets joypad and IR communication port
; switches to CGB normal speed
StartIRCommunications:
	di
	call SwitchToCGBNormalSpeed
	ld a, P14
	ldh [rJOYP], a
	ld a, RP_ENABLE
	ldh [rRP], a
	ret

; reenables interrupts, and switches CGB back to double speed
CloseIRCommunications:
	ld a, P14 | P15
	ldh [rJOYP], a
.wait_vblank_on
	ldh a, [rSTAT]
	and STAT_MODE
	cp STAT_VBLANK
	jr z, .wait_vblank_on
.wait_vblank_off
	ldh a, [rSTAT]
	and STAT_MODE
	cp STAT_VBLANK
	jr nz, .wait_vblank_off
	call SwitchToCGBDoubleSpeed
	ei
	ret

; set rRP to 0
ClearRP:
	ld a, $00
	ldh [rRP], a
	ret

; expects to receive a command (IRCMD_* constant)
; in wIRDataBuffer + 1, then calls the subroutine
; corresponding to that command
ExecuteReceivedIRCommands:
	call StartIRCommunications
.loop_commands
	call ReceiveIRDataBuffer
	jr c, .error
	jr nz, .loop_commands
	ld hl, wIRDataBuffer + 1
	ld a, [hl]
	ld hl, .CmdPointerTable
	cp NUM_IR_COMMANDS
	jr nc, .loop_commands ; invalid command
	call .JumpToCmdPointer ; execute command
	jr .loop_commands
.error
	call CloseIRCommunications
	xor a
	scf
	ret

.JumpToCmdPointer
	add a ; *2
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
.jp_hl
	jp hl

.CmdPointerTable
	dw .Close                ; IRCMD_CLOSE
	dw .ReturnWithoutClosing ; IRCMD_RETURN_WO_CLOSING
	dw .TransmitData         ; IRCMD_TRANSMIT_DATA
	dw .ReceiveData          ; IRCMD_RECEIVE_DATA
	dw .CallFunction         ; IRCMD_CALL_FUNCTION

; closes the IR communications
; pops hl so that the sp points
; to the return address of ExecuteReceivedIRCommands
.Close
	pop hl
	call CloseIRCommunications
	or a
	ret

; returns without closing the IR communications
; will continue the command loop
.ReturnWithoutClosing
	or a
	ret

; receives an address and number of bytes
; and transmits starting at that address
.TransmitData
	call Func_196e8
	ret c
	call LoadRegistersFromIRDataBuffer
	jp TransmitNBytesFromHLThroughIR

; receives an address and number of bytes
; and writes the data received to that address
.ReceiveData
	call LoadRegistersFromIRDataBuffer
	ld l, e
	ld h, d
	call ReceiveNBytesToHLThroughIR
	jr c, .asm_19812
	sub b
	call TransmitByteThroughIR
.asm_19812
	ret

; receives an address to call, then stores
; the registers in the IR data buffer
.CallFunction
	call LoadRegistersFromIRDataBuffer
	call .jp_hl
	call StoreRegistersInIRDataBuffer
	ret

; returns carry set if request sent was not acknowledged
TrySendIRRequest:
	call StartIRCommunications
	ld hl, rRP
	ld c, 4
.send_request
	ld a, $a5 ; request
	push bc
	call TransmitByteThroughIR
	push bc
	pop bc
	call ReceiveByteThroughIR_ZeroIfUnsuccessful
	pop bc
	cp $35 ; acknowledgement
	jr z, .received_ack
	dec c
	jr nz, .send_request
	scf
	jr .close

.received_ack
	xor a
.close
	push af
	call CloseIRCommunications
	pop af
	ret

; returns carry set if request was not received
TryReceiveIRRequest:
	call StartIRCommunications
	ld hl, rRP
.wait_request
	call ReceiveByteThroughIR_ZeroIfUnsuccessful
	cp $a5 ; request
	jr z, .send_ack
	ldh a, [rJOYP]
	cpl
	and P10 | P11
	jr z, .wait_request
	scf
	jr .close

.send_ack
	ld a, $35 ; acknowledgement
	call TransmitByteThroughIR
	xor a
.close
	push af
	call CloseIRCommunications
	pop af
	ret

; sends request for other device to close current communication
RequestCloseIRCommunication:
	call StartIRCommunications
	ld a, IRCMD_CLOSE
	ld [wIRDataBuffer + 1], a
	call TransmitIRDataBuffer
;	fallthrough

; calls CloseIRCommunications while preserving af
SafelyCloseIRCommunications:
	push af
	call CloseIRCommunications
	pop af
	ret

; sends a request for data to be transmitted
; from the other device
; hl = start of data to request to transmit
; de = address to write data received
; c = length of data
RequestDataTransmissionThroughIR:
	ld a, IRCMD_TRANSMIT_DATA
	call TransmitRegistersThroughIR
	push de
	push bc
	call Func_1971e
	pop bc
	pop hl
	jr c, SafelyCloseIRCommunications
	call ReceiveNBytesToHLThroughIR
	jr SafelyCloseIRCommunications

; transmits data to be written in the other device
; hl = start of data to transmit
; de = address for other device to write data
; c = length of data
RequestDataReceivalThroughIR:
	ld a, IRCMD_RECEIVE_DATA
	call TransmitRegistersThroughIR
	call TransmitNBytesFromHLThroughIR
	jr c, SafelyCloseIRCommunications
	call ReceiveByteThroughIR
	jr c, SafelyCloseIRCommunications
	add b
	jr nz, .asm_1989e
	xor a
	jr SafelyCloseIRCommunications
.asm_1989e
	call ReturnZFlagUnsetAndCarryFlagSet
	jr SafelyCloseIRCommunications

; first stores all the current registers in wIRDataBuffer
; then transmits it through IR
TransmitRegistersThroughIR:
	push hl
	push de
	push bc
	call StoreRegistersInIRDataBuffer
	call StartIRCommunications
	call TransmitIRDataBuffer
	pop bc
	pop de
	pop hl
	ret nc
	inc sp
	inc sp
	jr SafelyCloseIRCommunications

; stores af, hl, de and bc in wIRDataBuffer
StoreRegistersInIRDataBuffer:
	push de
	push hl
	push af
	ld hl, wIRDataBuffer
	pop de
	ld [hl], e ; <- f
	inc hl
	ld [hl], d ; <- a
	inc hl
	pop de
	ld [hl], e ; <- l
	inc hl
	ld [hl], d ; <- h
	inc hl
	pop de
	ld [hl], e ; <- e
	inc hl
	ld [hl], d ; <- d
	inc hl
	ld [hl], c ; <- c
	inc hl
	ld [hl], b ; <- b
	ret

; loads all the registers that were stored
; from StoreRegistersInIRDataBuffer
LoadRegistersFromIRDataBuffer:
	ld hl, wIRDataBuffer
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push de
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push de
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld c, [hl]
	inc hl
	ld b, [hl]
	pop hl
	pop af
	ret

; empties screen and enables sprite animations
SetSpriteAnimationsAsVBlankFunction:
	call EmptyScreen
	lb de, $38, $7f
	call SetupText
	ld hl, wVBlankFunctionTrampoline + 1
	ld de, wVBlankFunctionTrampolineBackup
	call BackupVBlankFunctionTrampoline
	di
	call Func_3e4f
	ei
	ret

; sets backup VBlank function as wVBlankFunctionTrampoline
RestoreVBlankFunction:
	call Func_3e54
	ld hl, wVBlankFunctionTrampolineBackup
	ld de, wVBlankFunctionTrampoline + 1
	call BackupVBlankFunctionTrampoline
	ret

; copies 2 bytes from hl to de while interrupts are disabled
; used to load or store wVBlankFunctionTrampoline
; to wVBlankFunctionTrampolineBackup
BackupVBlankFunctionTrampoline:
	di
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hld]
	ld [de], a
	ei
	ret

; unreferenced
Func_198f7:
	ret

; clears saved data (card Collection/saved decks/Card Pop! data/etc)
; then adds the old starter decks as saved decks
; marks all cards in Collection as not owned
InitSaveData:
; clear card and deck save data
	call EnableSRAM
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
	ld hl, sCardAndDeckSaveData
	ld bc, sCardAndDeckSaveDataEnd - sCardAndDeckSaveData
.loop_clear
	xor a
	ld [hli], a
	dec bc
	ld a, c
	or b
	jr nz, .loop_clear

	; these have been kept from Pokémon TCG 1
	; and correspond to the old starter decks
	; they will be erased from SRAM afterwards
	ld a, SWEAT_ANTI_GR1_DECK ; old CHARMANDER_AND_FRIENDS_DECK
	ld hl, sSavedDeck1
	call .SaveDeck
	ld a, VENGEFUL_ANTI_GR3_DECK ; old SQUIRTLE_AND_FRIENDS_DECK
	ld hl, sSavedDeck2
	call .SaveDeck
	ld a, UNUSED_SAMS_PRACTICE_DECK ; old BULBASAUR_AND_FRIENDS_DECK
	ld hl, sSavedDeck3
	call .SaveDeck

; marks all cards in Collection to not owned
	call EnableSRAM
	ld hl, sCardCollection
	ld bc, CARD_COLLECTION_SIZE
.loop_collection
	ld [hl], CARD_NOT_OWNED
	inc hl
	dec bc
	ld a, c
	or b
	jr nz, .loop_collection

	ld hl, sCurrentDuel
	xor a
	ld [hli], a
	ld [hli], a ; sCurrentDuelChecksum
	ld [hl], a

	; clears Card Pop! names
	ld a, BANK(sCardPopNameList)
	call BankswitchSRAM
	ld hl, sCardPopNameList
	ld c, CARDPOP_NAME_LIST_MAX_ELEMS
.loop_card_pop_names
	ld [hl], $0
	ld de, NAME_BUFFER_LENGTH
	add hl, de
	dec c
	jr nz, .loop_card_pop_names
	ld hl, sCardPopRecords
	ld [hl], $00
	xor a
	call BankswitchSRAM

; saved configuration options
	ld a, 2
	ld [sPrinterContrastLevel], a
	ld a, 2
	ld [sTextSpeed], a
	ld [wTextSpeed], a

; miscellaneous data
	xor a
	ld [s0a007], a
	ld [sSkipDelayAllowed], a
	ld [s0a004], a
	ld [sTotalCardPopsDone], a
	ld [sClearedGame], a
	ld hl, sTotalDuelCounter
	ld [hli], a
	ld [hli], a
	ld [hli], a ; sLinkDuelCounter
	ld [hli], a

	farcall Func_8f10
	call DisableSRAM
	ret

; saves deck in a to SRAM address in hl
.SaveDeck:
	push de
	push bc
	push hl
	ld [wNPCDuelDeckID], a
	call LoadDeck
	jr c, .done
	call .LoadDeckName
	pop hl
	call EnableSRAM
	push hl
	ld de, wDefaultText
.loop_copy_name
	ld a, [de]
	inc de
	ld [hli], a
	or a
	jr nz, .loop_copy_name
	pop hl
	push hl
	ld de, DECK_NAME_SIZE
	add hl, de
	ld de, wPlayerDeck
	bank1call SaveDeckCards
	call DisableSRAM
	or a
.done
	pop hl
	pop bc
	pop de
	ret

.LoadDeckName:
	ld a, [wNPCDuelDeckID]
	sub 3
	farcall LoadDeckIDData
	ld hl, wOpponentDeckName
	ld a, [hli]
	ld h, [hl]
	ld l, a
	; fallthrough
.PrintName:
	ld de, wDuelTempList
	call CopyText
	ld c, $0f
	ld hl, wDuelTempList
	ld de, wDefaultText
.loop_chars
	ld a, [hl]
	or a
	jr z, .terminating_byte
	cp $0f
	jr nz, .asm_199dc
	ld c, a
	jr .next_char
.asm_199dc
	cp $0e
	jr nz, .asm_199e3
	ld c, a
	jr .next_char
.asm_199e3
	cp $06
	jr c, .copy_2_bytes
	ld a, c
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
.next_char
	inc hl
	jr .loop_chars
.copy_2_bytes
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	jr .loop_chars

.terminating_byte
	ld [de], a
	ret
; 0x199fa

SECTION "Bank 6@5a30", ROMX[$5a30], BANK[$6]

; prepares IR communication parameter data
; a = a IRPARAM_* constant for the function of this connection
InitIRCommunications:
	ld hl, wOwnIRCommunicationParams
	ld [hl], a
	inc hl
	ld [hl], $50
	inc hl
	ld [hl], $4b
	inc hl
	ld [hl], $32
	ld a, $ff
	ld [wIRCommunicationErrorCode], a
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
; clear wNameBuffer and wOpponentName
	xor a
	ld [wNameBuffer], a
	ld hl, wOpponentName
	ld [hli], a
	ld [hl], a
; loads player's name from SRAM
; to wDefaultText
	call EnableSRAM
	ld hl, sPlayerName
	ld de, wDefaultText
	ld c, NAME_BUFFER_LENGTH
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	call DisableSRAM
	ret
; 0x19a64

SECTION "Bank 6@5a92", ROMX[$5a92], BANK[$6]

; exchanges player names and IR communication parameters
; checks whether parameters for communication match
; and if they don't, an error is issued
ExchangeIRCommunicationParameters:
	ld hl, wOwnIRCommunicationParams
	ld de, wOtherIRCommunicationParams
	ld c, 4
	call RequestDataTransmissionThroughIR
	jr c, .error
	ld hl, wOtherIRCommunicationParams + 1
	ld a, [hli]
	cp $50
	jr nz, .error
	ld a, [hli]
	cp $4b
	jr nz, .error
	ld a, [wOwnIRCommunicationParams]
	ld hl, wOtherIRCommunicationParams
	cp [hl] ; do parameters match?
	jr nz, SetIRCommunicationErrorCode_Error

; receives wDefaultText from other device
; and writes it to wNameBuffer
	ld hl, wDefaultText
	ld de, wNameBuffer
	ld c, NAME_BUFFER_LENGTH
	call RequestDataTransmissionThroughIR
	jr c, .error
; transmits wDefaultText to be
; written in wNameBuffer in the other device
	ld hl, wDefaultText
	ld de, wNameBuffer
	ld c, NAME_BUFFER_LENGTH
	call RequestDataReceivalThroughIR
	jr c, .error
	or a
	ret

.error
	xor a
	scf
	ret

SetIRCommunicationErrorCode_Error:
	ld hl, wIRCommunicationErrorCode
	ld [hl], $01
	ld de, wIRCommunicationErrorCode
	ld c, 1
	call RequestDataReceivalThroughIR
	call RequestCloseIRCommunication
	ld a, $01
	scf
	ret

SetIRCommunicationErrorCode_NoError:
	ld hl, wOwnIRCommunicationParams
	ld [hl], $00
	ld de, wIRCommunicationErrorCode
	ld c, 1
	call RequestDataReceivalThroughIR
	ret c
	call RequestCloseIRCommunication
	or a
	ret
; 0x19afb

SECTION "Bank 6@5bf9", ROMX[$5bf9], BANK[$6]

_CardPopMenu:
	call EnableSRAM
	ld a, [sClearedGame]
	ld [wClearedGame], a
	call DisableSRAM
	xor a
	ld [wce27], a

; loads scene for Card Pop! menu
.asm_19c09
	call SetSpriteAnimationsAsVBlankFunction
	ld a, SCENE_CARD_POP_MENU
	lb bc, 0, 0
	call EmptyScreenAndLoadScene

	ld a, [wClearedGame]
	or a
	jr nz, .cleared_game
	lb de,  8, 0
	lb bc, 12, 8
	call DrawRegularTextBox
	ldtx hl, CardPopMenuText
	lb de, 10, 2
	call InitTextPrinting_ProcessTextFromID
	ld hl, CardPopMenuParams
	ld a, [wce27]
	call InitializeMenuParameters
	call DrawCardPopMenuBox

	call EnableLCD
.loop_input_1
	call DoFrame
	call HandleMenuInput
	ld [wce27], a
	jr nc, .loop_input_1

	; selected an option
	call RestoreVBlankFunction
	ldh a, [hCurScrollMenuItem]
	or a
	jr z, .card_pop
	cp 1
	jr z, .view_records
	jr .exit

.card_pop
	call DoCardPop
	jr .asm_19c09

.view_records
	call ViewCardPopRecords
	jr .asm_19c09

.cleared_game
	lb de,  8,  0
	lb bc, 12, 10
	call DrawRegularTextBox
	ldtx hl, CardPopMenuRareCardPopUnlockedText
	lb de, 10, 2
	call InitTextPrinting_ProcessTextFromID
	ld hl, CardPopMenuParams
	ld a, [wce27]
	call InitializeMenuParameters
	ld a, 4 ; override num items
	ld [wNumScrollMenuItems], a
	call DrawCardPopMenuBox

	call EnableLCD
.loop_input_2
	call DoFrame
	call HandleMenuInput
	ld [wce27], a
	jr nc, .loop_input_2

	call RestoreVBlankFunction
	ldh a, [hCurScrollMenuItem]
	or a
	jr z, .card_pop
	cp 1
	jr z, .rare_card_pop
	cp 2
	jr z, .view_records
	jr .exit

.rare_card_pop
	call DoRareCardPop
	jp .asm_19c09

.exit
	ret

; draws the Card Pop! menu box with the
; options the player can select
; Rare Card Pop! is only available after
; the player has cleared the game
DrawCardPopMenuBox:
	lb de,  0, 12
	lb bc, 20,  6
	call DrawRegularTextBox
	ldh a, [hCurScrollMenuItem]
	add a ; *2
	ld e, a
	ld d, $00
	ld hl, .text_ids_without_rare_card_pop
	ld a, [wClearedGame]
	or a
	jr z, .got_menu_text_ids
	ld hl, .text_ids_with_rare_card_pop
.got_menu_text_ids
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	lb de, 1, 14
	call InitTextPrinting_ProcessTextFromID
	ret

.text_ids_without_rare_card_pop
	tx CardPopEncouragementMessageText
	tx CardPopViewRecordsDescriptionText
	tx CardPopExitText

.text_ids_with_rare_card_pop
	tx CardPopEncouragementMessageText
	tx RareCardPopDescriptionText
	tx CardPopViewRecordsDescriptionText
	tx CardPopExitText

CardPopMenuParams:
	db 9 ; x pos
	db 2 ; y pos
	db 2 ; y spacing
	db 3 ; num entries
	db SYM_CURSOR_R ; visible cursor tile
	db SYM_SPACE ; invisible cursor tile
	dw HandleCardPopMenuInput ; wCardListHandlerFunction

; returns carry if selection with A btn was made
HandleCardPopMenuInput:
	ldh a, [hDPadHeld]
	and PAD_UP | PAD_DOWN
	jr z, .no_up_down
	call DrawCardPopMenuBox
.no_up_down
	ldh a, [hKeysPressed]
	bit B_PAD_A, a
	jr nz, .set_carry
	and PAD_B
	ret z
	ld a, $ff
	ldh [hCurScrollMenuItem], a
.set_carry
	scf
	ret

DoCardPop:
	ld a, IRPARAM_CARD_POP
	ld [wCardPopType], a

	call SetSpriteAnimationsAsVBlankFunction
	ld a, SCENE_CARD_POP
	lb bc, 0, 0
	call EmptyScreenAndLoadScene
	ldtx hl, AreYouBothReadyToCardPopText
	call PrintScrollableText_NoTextBoxLabel

	call RestoreVBlankFunction
	call PauseSong
	ld a, SCENE_LINK
	call LoadCardPopSceneAndHandleCommunications
	ld a, SCENE_CARD_POP_ERROR
	jr c, ShowCardPopError
	ldtx hl, ReceivedThroughCardPopText
;	fallthrough

; hl = text ID
DisplayCardReceivedThroughPop:
	farcall _DisplayCardDetailScreen
	call ResumeSong
	bank1call SetupDuel
	call DisableLCD
	bank1call OpenCardPage_FromHand
	ret

; a = scene ID
; hl = text ID for text box
ShowCardPopError:
	push hl
	push af
	call ResumeSong
	call SetSpriteAnimationsAsVBlankFunction
	pop af
	lb bc, 0, 0
	call EmptyScreenAndLoadScene
	pop hl
	call PrintScrollableText_NoTextBoxLabel
	call RestoreVBlankFunction
	ret

DoRareCardPop:
	ld a, IRPARAM_RARE_CARD_POP
	ld [wCardPopType], a

	call SetSpriteAnimationsAsVBlankFunction
	ld a, SCENE_RARE_CARD_POP
	lb bc, 0, 0
	call EmptyScreenAndLoadScene
	ldtx hl, AreYouBothReadyToRareCardPopText
	call PrintScrollableText_NoTextBoxLabel
	call RestoreVBlankFunction
	call PauseSong
	ld a, SCENE_LINK
	call LoadCardPopSceneAndHandleCommunications
	ld a, SCENE_RARE_CARD_POP_ERROR
	jr c, ShowCardPopError
	ldtx hl, ReceivedThroughRareCardPopText
	jr DisplayCardReceivedThroughPop

; a = scene ID
LoadCardPopSceneAndHandleCommunications:
	push af
	call SetSpriteAnimationsAsVBlankFunction
	pop af
	lb bc, 0, 0
	call EmptyScreenAndLoadScene
	ldtx hl, PositionGameBoyColorsAndPressAButtonText
	call DrawWideTextBox_PrintText
	call EnableLCD
	call HandleCardPopCommunications
	push af
	push hl
	call ClearRP
	call RestoreVBlankFunction
	pop hl
	pop af
	ret c ; not successful

	; Card Pop! successful, add to collection
	ld hl, wLoadedCard1ID
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, BANK("SRAM2")
	call BankswitchSRAM
	call AddCardToCollection
	xor a
	call BankswitchSRAM

.add_sram0
	ld hl, wLoadedCard1ID
	ld e, [hl]
	inc hl
	ld d, [hl]
	call AddCardToCollection

	; loads card name and plays obtain song
	ld hl, wLoadedCard1Name
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call LoadTxRam2
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
	ld a, SFX_5D
	call PlaySFX
.wait_sfx
	call AssertSFXFinished
	or a
	jr nz, .wait_sfx
	ld a, [wCardPopCardObtainSong]
	call PlaySong
	or a
	ret

; handles all communications to the other device to do Card Pop!
; returns carry if Card Pop! is unsuccessful
; and returns in hl the corresponding error text ID
HandleCardPopCommunications:
; copy CardPopNameList from SRAM to WRAM
	ld a, BANK("SRAM1")
	call BankswitchSRAM
	ld hl, sCardPopNameList
	ld de, wCardPopNameList
	ld bc, CARDPOP_NAME_LIST_SIZE
	call CopyDataHLtoDE
	xor a
	call BankswitchSRAM
	call DisableSRAM

	ld a, [wCardPopType]
	call InitIRCommunications
.loop_request
	call TryReceiveIRRequest ; receive request
	jr nc, .execute_commands
	bit 1, a
	jp nz, .asm_19e7f
	call TrySendIRRequest ; send request
	jr c, .loop_request

; do the player name search, then transmit the result
	call ExchangeIRCommunicationParameters
	jr c, .fail
	ld hl, wCardPopNameList
	ld de, wOtherPlayerCardPopNameList
	ld c, 0 ; $100 bytes = CARDPOP_NAME_LIST_SIZE
	call RequestDataTransmissionThroughIR
	jr c, .fail

	call LookUpNameInCardPopNameList
	call DecideCardToReceiveFromCardPop
	call FillCardPopSummary

	ld hl, wCardPopNameSearchResult
	ld e, l
	ld d, h
	ld c, 8 ; wCardPopNameSearchResult + wCardPopSummary
	call RequestDataReceivalThroughIR
	jr c, .fail
	call SetIRCommunicationErrorCode_NoError
	jr c, .fail
	call ExecuteReceivedIRCommands
	jr c, .fail
	call SetCardPopRecord
	jr .check_search_result

.execute_commands
; will receive commands to send card pop name list,
; and to receive the result of the name list search
	call ExecuteReceivedIRCommands
	ld a, [wIRCommunicationErrorCode]
	or a
	jr nz, .fail

	ld a, $32
	ld [wOtherIRCommunicationParams + 3], a
	call DecideCardToReceiveFromCardPop
	call SetCardPopRecord
	call FillCardPopSummary

	ld hl, wCardPopNameSearchResult
	ld e, l
	ld d, h
	ld c, 8 ; wCardPopNameSearchResult + wCardPopSummary
	call RequestDataReceivalThroughIR
	jr c, .fail
	call RequestCloseIRCommunication
	jr c, .fail

.check_search_result
	ld a, [wCardPopNameSearchResult]
	or a
	jr z, .success
	; not $00, means the name was found in the list
	ldtx hl, CannotCardPopWithFriendPreviouslyPoppedWithText
	ld a, [wCardPopType]
	cp $01
	jr z, .set_carry
	ldtx hl, CannotRareCardPopWithFriendPreviouslyPoppedWithText
	jr .set_carry

.fail
	ld a, [wIRCommunicationErrorCode]
	cp $01
	jr nz, .asm_19e7f
	ldtx hl, CardPopModeMismatchedText ; Card Pop from one side and Rare Card Pop from the other
	scf
	ret

.asm_19e7f
	ldtx hl, CardPopUnsuccessfulTryAgainText
.set_carry
	scf
	ret

.success

; increment number of times Card Pop! was done
; and write the other player's name to sCardPopNameList
; the spot where this is written in the list is derived
; from the lower nybble of sTotalCardPopsDone
; that means that after 16 Card Pop!, the older
; names start to get overwritten
	call EnableSRAM
	ld hl, sTotalCardPopsDone
	ld a, [hl]
	inc [hl]
	and $0f
	swap a ; *NAME_BUFFER_LENGTH
	ld l, a
	ld h, $0
	ld de, sCardPopNameList
	add hl, de
	ld e, l
	ld d, h
	ld hl, wNameBuffer
	ld bc, NAME_BUFFER_LENGTH
	ld a, BANK("SRAM1")
	call BankswitchSRAM
	call CopyDataHLtoDE
	ld a, [wOtherIRCommunicationParams + 3]
	cp $32
	jr nz, .asm_19ecb

	; copy SRAM so that sCardPopRecords is moved $20 forward
	ld hl, sCardPopRecords + MAX_NUM_CARDPOP_RECORDS * CARDPOP_RECORD_SIZE - 1
	ld de, sCardPopRecords + MAX_NUM_CARDPOP_RECORDS * CARDPOP_RECORD_SIZE - 1 + CARDPOP_RECORD_SIZE
	ld bc, MAX_NUM_CARDPOP_RECORDS * CARDPOP_RECORD_SIZE
.loop_copy_sram
	ld a, [hld]
	ld [de], a
	dec de
	dec bc
	ld a, c
	or b
	jr nz, .loop_copy_sram
	ld hl, wCardPopRecord
	ld de, sCardPopRecords
	ld bc, CARDPOP_RECORD_SIZE
	call CopyDataHLtoDE
.asm_19ecb
	xor a
	call BankswitchSRAM
	call DisableSRAM
	or a
	ret

; looks up the name in wNameBuffer in wCardPopNameList
; used to know whether this save file has done Card Pop!
; with the other player already
; returns carry and wCardPopNameSearchResult = $ff if the name was found;
; returns no carry and wCardPopNameSearchResult = $00 otherwise
LookUpNameInCardPopNameList:
; searches for other player's name in this game's name list
	ld hl, wCardPopNameList
	ld c, CARDPOP_NAME_LIST_MAX_ELEMS
.loop_own_card_pop_name_list
	push hl
	ld de, wNameBuffer
	call .CompareNames
	pop hl
	jr nc, .found_name
	ld de, NAME_BUFFER_LENGTH
	add hl, de
	dec c
	jr nz, .loop_own_card_pop_name_list

; name was not found in wCardPopNameList

; searches for this player's name in the other game's name list
	call EnableSRAM
	ld hl, wOtherPlayerCardPopNameList
	ld c, CARDPOP_NAME_LIST_MAX_ELEMS
.loop_other_card_pop_name_list
	push hl
	ld de, sPlayerName
	call .CompareNames ; discards result from comparison
	pop hl
	jr nc, .found_name
	ld de, NAME_BUFFER_LENGTH
	add hl, de
	dec c
	jr nz, .loop_other_card_pop_name_list
	xor a
	jr .no_carry

.found_name
	ld a, $ff
	scf
.no_carry
	ld [wCardPopNameSearchResult], a ; $00 if name was not found, $ff otherwise
	call DisableSRAM
	ret

; compares names in hl and de
; if they are different, return carry
.CompareNames
	ld b, NAME_BUFFER_LENGTH
.loop_chars
	ld a, [de]
	inc de
	cp [hl]
	jr nz, .not_same
	inc hl
	dec b
	jr nz, .loop_chars
	or a
	ret
.not_same
	scf
	ret

; in tcg2, a player may Card Pop! with the same partner again
; whenever the two duel each other
ResetCardPopStatusWithSamePartnerOnLinkDuel:
	call EnableSRAM
	ld a, BANK("SRAM1")
	call BankswitchSRAM
	ld hl, sCardPopNameList
	ld c, CARDPOP_NAME_LIST_MAX_ELEMS
.loop_name_list
	push hl
	ld de, wNameBuffer
	call LookUpNameInCardPopNameList.CompareNames
	pop hl
	jr nc, .found_name
	ld de, NAME_BUFFER_LENGTH
	add hl, de
	dec c
	jr nz, .loop_name_list
	jr .done
.found_name
	ld [hl], 0
; fallthrough
.done
	xor a
	call BankswitchSRAM
	call DisableSRAM
	ret

; loads in wLoadedCard1 a random card to be received
; this selection is done based on the rarity
; decided from the names of both participants
; the result will always be a non-Energy card that
; is not from a Promotional set, with the exception
; of VenusaurLv64 and MewLv15
; output:
; - e = card ID chosen
DecideCardToReceiveFromCardPop:
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
	call EnableSRAM
	ld hl, sPlayerName
	call .CalculateNameHash
	call DisableSRAM
	push de
	ld hl, wNameBuffer
	call .CalculateNameHash
	pop bc

; de = other player's name hash
; bc =  this player's name hash

; updates RNG values to subtraction of these two hashes
.get_rng
	ld hl, wRNG1
	ld a, b
	sub d
	ld d, a ; b - d
	ld [hli], a ; wRNG1
	ld a, c
	sub e
	ld e, a ; c - e
	ld [hli], a ; wRNG2
	add d
	ld [hl], a ; wRNGCounter

	ld a, [wCardPopType]
	cp IRPARAM_RARE_CARD_POP
	jr nz, .not_rare
	; Rare Card Pop!
	ld a, e
	cp 5
	jr z, .phantom
	jr .star_rarity
.not_rare

; depending on the values obtained from the hashes,
; determine which rarity card to give to the player
; along with the song to play with each rarity
; the probabilities of each possibility can be calculated
; as follows (given 2 random player names):
; 101/256 ~ 39% for Circle
;  90/256 ~ 35% for Diamond
;  63/256 ~ 25% for Star
;   1/256 ~ .4% for VenusaurLv64 or MewLv15
	ld a, e
	cp 5
	jr z, .phantom
	cp 64
	jr c, .star_rarity ; < 64
	cp 154
	jr c, .diamond_rarity ; < 154
	; >= 154

	ld a, MUSIC_BOOSTER_PACK
	ld b, CARDPOP_CIRCLE
	jr .got_rarity
.diamond_rarity
	ld a, MUSIC_BOOSTER_PACK
	ld b, CARDPOP_DIAMOND
	jr .got_rarity
.star_rarity
	ld a, MUSIC_MATCHVICTORY
	ld b, CARDPOP_STAR
	jr .got_rarity
.phantom
	ld a, MUSIC_MEDAL
	ld b, CARDPOP_PHANTOM
.got_rarity
	ld [wCardPopCardObtainSong], a
	ld a, b
	lb bc, BEGINNING_POKEMON, TEAM_ROCKETS_AMBITION
	farcall CreateCardPopCandidateList
	; pick randomly from list
	call Random
	ld l, a
	ld h, $00
	add hl, hl
	ld de, wCardPopCandidateList
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	call LoadCardDataToBuffer1_FromCardID
	ret

; creates a unique two-byte hash from the name given in hl
; the low byte is calculated by simply adding up all characters
; the high byte is calculated by xoring all characters together
; input:
; - hl = points to the start of the name buffer
; output:
; - de = hash
.CalculateNameHash:
	ld c, NAME_BUFFER_LENGTH
	ld de, $0
.loop
	ld a, e
	add [hl]
	ld e, a
	ld a, d
	xor [hl]
	ld d, a
	inc hl
	dec c
	jr nz, .loop
	ret

FillCardPopSummary:
	ld hl, wLoadedCard1ID
	ld de, wCardPopSummary
	call CopyWordFromHLToDE
	call EnableSRAM
	ld hl, sTotalDuelCounter
	call CopyWordFromHLToDE
	call DisableSRAM
	call GetAmountOfCardsOwned
	ld a, l
	ld [de], a
	inc de
	ld a, h
	ld [de], a
	inc de
	push de
	xor a
	farcall CountEventCoinsObtained
	pop de
	ld [de], a
	ret

CopyWordFromHLToDE:
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ret

SetCardPopRecord:
	ld hl, wNameBuffer
	ld de, wCardPopRecord
	ld bc, NAME_BUFFER_LENGTH
	call CopyDataHLtoDE
	ld hl, wLoadedCard1ID
	call CopyWordFromHLToDE
	ld hl, wCardPopSummary
	ld bc, 7
	call CopyDataHLtoDE
	ld a, [wCardPopType]
	ld [de], a
	ret

ClearCardPopNameList:
	call EnableSRAM
	ld a, BANK(sCardPopNameList)
	call BankswitchSRAM
	ld hl, sCardPopNameList
	ld de, NAME_BUFFER_LENGTH
	ld c, CARDPOP_NAME_LIST_MAX_ELEMS
.loop_clear
	ld [hl], $0
	add hl, de
	dec c
	jr nz, .loop_clear
	; the intention was to clear sTotalCardPopsDone,
	; but since we are in SRAM1, it clears a byte
	; in sCardPopNameList instead
	xor a
	ld [sCardPopNameList + $5], a
	call BankswitchSRAM ; SRAM0
	call DisableSRAM
	ret

ViewCardPopRecords:
	xor a
	ld [wce28], a
	ld [wCurMenuItem], a
	call .CountNumberOfRecords
	ld a, [wNumCardPopRecords]
	or a
	jr nz, .init_list
	ret nz

	; no Card Pop! records
	ldtx hl, NoCardPopRecordsText
	call DrawWideTextBox_WaitForInput
	ret

.init_list
	bank1call SetupDuel
	call .DrawSlashAndTopLineSeparator
	ld hl, .MenuParams
	ld a, [wCurMenuItem]
	call InitializeMenuParameters
	ld a, [wNumCardPopRecords]
	cp 5
	jr nc, .num_items_ok
	; overwrite number of items
	ld [wNumScrollMenuItems], a
.num_items_ok
	call .PrintRecordEntries
.loop_input
	call DoFrame
	call HandleMenuInput
	jr nc, .loop_input
	cp $ff
	ret z
	; selected a record entry
	call .LoadRecord
	ldh a, [hKeysPressed]
	and PAD_A
	jr nz, .show_record_page
	ld hl, wCardPopRecordYourCardID
	ld e, [hl]
	inc hl
	ld d, [hl]
	call LoadCardDataToBuffer1_FromCardID
	bank1call OpenCardPage_FromHand
	jr .init_list

.show_record_page
	; opens page to show details about this record
	call EmptyScreen
	lb de, 0, 0
	lb bc, 20, 10
	call DrawRegularTextBox
	lb de, 0, 10
	lb bc, 20, 8
	call DrawRegularTextBox
	ld hl, .text_items
	call PlaceTextItems
	lb de, 1, 0
	ld a, 11
	call ZeroAttributesAtDE
	lb de, 1, 10
	ld a, 5
	call ZeroAttributesAtDE

	lb de, 8, 2
	ld hl, wCardPopRecord
	call .PrintText
	ld a, [wCardPopRecordType]
	cp IRPARAM_RARE_CARD_POP
	jr nz, .rare_card_pop_1
	ldtx hl, StarRarityText
	lb de, 15, 2
	call InitTextPrinting_ProcessTextFromID
.rare_card_pop_1
	ld a, [wCardPopRecordNumCoins]
	lb bc, 13, 4
	bank1call WriteTwoDigitNumberInTxSymbolFormat
	ld hl, wCardPopRecordNumCards
	ld c, 6
	call .PrintNumberAtYCoord
	ld hl, wCardPopRecordNumBattles
	ld c, 8
	call .PrintNumberAtYCoord
	lb de, 4, 13
	ld hl, wCardPopRecordYourCardID
	call .PrintCardName
	lb de, 4, 16
	ld hl, wCardPopRecordTheirCardID
	call .PrintCardName

	; chooses a portrait based on player name
	ld a, [wCardPopRecordName + $d]
	ld e, a
	ld d, $00
	ld hl, .PicIDs
	add hl, de
	ld a, [hl]
	ld e, EMOTION_NORMAL
	lb bc, 1, 2
	call DrawNPCPortrait

	call EnableLCD
.loop_record_page_input
	call DoFrame
	ldh a, [hDPadHeld]
	bit B_PAD_START, a
	jr nz, .open_card_page
	bit B_PAD_UP, a
	jr nz, .show_previous_record
	bit B_PAD_DOWN, a
	jr nz, .show_next_record
	and PAD_A | PAD_B
	jr z, .loop_record_page_input
	jp .init_list

.open_card_page
	ld hl, wCardPopRecordTheirCardID
	ld e, [hl]
	inc hl
	ld d, [hl]
	call LoadCardDataToBuffer1_FromCardID
	bank1call OpenCardPage_FromHand
	jp .show_record_page

.show_previous_record
	ldh a, [hCurScrollMenuItem]
	or a
	jp z, .show_record_page
	dec a
	jr .update_menu_item
.show_next_record
	ldh a, [hCurScrollMenuItem]
	ld hl, wNumCardPopRecords
	inc a
	cp [hl]
	jp nc, .show_record_page
.update_menu_item
	ldh [hCurScrollMenuItem], a
	call .LoadRecord
	jp .show_record_page

; hl = pointer to card ID
; de = coordinates
.PrintCardName:
	push de
	ld e, [hl]
	inc hl
	ld d, [hl]
	call LoadCardDataToBuffer1_FromCardID
	ld a, 14
	call CopyCardNameAndLevel
	pop de
	ld hl, wDefaultText
	call .PrintText
	ret

; c = y coordinate
.PrintNumberAtYCoord:
	ld b, 12 ; x coordinate
	ld a, [hli]
	ld h, [hl]
	ld l, a
	bank1call Func_6079
	ret

.text_items
	textitem 1,  0, CardPopRecordContentText
	textitem 8,  4, CardPopRecordFriendCoinQuantityText
	textitem 8,  6, CardPopRecordFriendCardQuantityText
	textitem 8,  8, CardPopRecordFriendBattleQuantityText
	textitem 1, 10, CardPopRecordCardsText
	textitem 1, 12, CardPopRecordYourResultText
	textitem 1, 15, CardPopRecordFriendResultText
	db $ff ; end

.PicIDs
	db MARK_PIC
	db MINT_PIC
	db RONALD_PIC
	db IMAKUNI_BLACK_PIC
	db IMAKUNI_RED_PIC

.DrawSlashAndTopLineSeparator:
	lb bc, 17, 1
	ld a, [wNumCardPopRecords]
	bank1call WriteTwoDigitNumberInTxSymbolFormat
	ld hl, .SlashAndLineSeparatorTileData
	call WriteDataBlocksToBGMap0
	call BankswitchVRAM1
	ld hl, .LineSeparatorAttributes
	call WriteDataBlocksToBGMap0
	call BankswitchVRAM0
	ret

.SlashAndLineSeparatorTileData:
	db 16, 1, $2e, 0 ; slash
	db  0, 2, $1c, $1c, $1c, $1c, $1c, $1c, $1c, $1c, $1c, $1c, $1c, $1c, $1c, $1c, $1c, $1c, $1c, $1c, $1c, $1c, 0
	db $ff ; end

.LineSeparatorAttributes:
	db 0, 2, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, 0
	db $ff ; end

.CountNumberOfRecords:
	ld a, BANK("SRAM1")
	call BankswitchSRAM
	ld c, -1
	ld hl, sCardPopRecords - CARDPOP_RECORD_SIZE
	ld de, CARDPOP_RECORD_SIZE
.loop_records
	inc c
	add hl, de
	ld a, c
	cp MAX_NUM_CARDPOP_RECORDS + 1
	jr z, .got_count
	ld a, [hl]
	or a
	jr nz, .loop_records
.got_count
	ld a, c
	ld [wNumCardPopRecords], a
	xor a
	call BankswitchSRAM
	call DisableSRAM
	ret

; loads record with index in register a
; from SRAM to wCardPopRecord
.LoadRecord:
	ld l, a
	ld h, CARDPOP_RECORD_SIZE
	call HtimesL
	ld de, sCardPopRecords
	add hl, de
	ld a, BANK("SRAM1")
	call BankswitchSRAM
	ld de, wCardPopRecord
	ld bc, CARDPOP_RECORD_SIZE
	call CopyDataHLtoDE
	xor a
	call BankswitchSRAM
	call DisableSRAM
	ret

.MenuParams:
	db 1 ; x pos
	db 4 ; y pos
	db 3 ; y spacing
	db 5 ; num entries
	db SYM_CURSOR_R ; visible cursor tile
	db SYM_SPACE ; invisible cursor tile
	dw .HandleMenuInput ; wCardListHandlerFunction

.HandleMenuInput:
	ldh a, [hDPadHeld]
	ld b, a
	and PAD_CTRL_PAD
	jr z, .got_cur_menu_item
	bit B_PAD_UP, b
	jr nz, .d_up
	bit B_PAD_DOWN, b
	jr nz, .d_down
	bit B_PAD_RIGHT, b
	jr nz, .d_right

; d left
	ld hl, wce28
	ld a, [hl]
	or a
	jr z, .got_cur_menu_item
	sub 5
	jr nc, .asm_1a252
	xor a
.asm_1a252
	ld [hl], a
	jr .update_list_entries

.d_right
	ld a, [wNumCardPopRecords]
	ld e, a
	ld hl, wce28
	ld a, [hl]
	add 5
	cp e
	jr nc, .got_cur_menu_item
	ld [hl], a
	add 5
	cp e
	jr c, .update_list_entries
	ld a, e
	sub 5
	ld [hl], a
	jr .update_list_entries

.d_up
	ld hl, wCurMenuItem
	ld a, [wNumScrollMenuItems]
	dec a
	cp [hl]
	jr nz, .update_highlighted_record_number
	xor a
	ld [wCurMenuItem], a
	ld hl, wce28
	ld a, [hl]
	or a
	jr z, .update_highlighted_record_number
	dec [hl]
	jr .update_list_entries

.d_down
	ld hl, wCurMenuItem
	ld a, [hl]
	or a
	jr nz, .update_highlighted_record_number
	ld a, [wNumScrollMenuItems]
	dec a
	ld [hl], a
	ld hl, wce28
	add [hl]
	inc a
	ld hl, wNumCardPopRecords
	cp [hl]
	jr nc, .update_highlighted_record_number
	ld hl, wce28
	inc [hl]

.update_list_entries
	call .PrintRecordEntries
	jr .got_cur_menu_item
.update_highlighted_record_number
	call .UpdateHighlightedRecordNumber
.got_cur_menu_item
	ld a, [wCurMenuItem]
	ld hl, wce28
	add [hl]
	ldh [hCurScrollMenuItem], a

	ldh a, [hKeysPressed]
	and PAD_A | PAD_START
	jr nz, .a_btn_or_start
	ldh a, [hKeysPressed]
	and PAD_B
	ret z
; cancel
	ld a, $ff
	ldh [hCurScrollMenuItem], a
.a_btn_or_start
	scf
	ret

.UpdateHighlightedRecordNumber:
	ld a, [wCurMenuItem]
	ld hl, wce28
	add [hl]
	inc a
	lb bc, 14, 1
	bank1call WriteTwoDigitNumberInTxSymbolFormat
	ret

.PrintRecordEntries:
	lb de, 1, 1
	ldtx hl, CardPopRecordsText
	call InitTextPrinting_ProcessTextFromID
	ld a, $04
	ld [wce2a], a
	call .UpdateHighlightedRecordNumber

	; up arrow in list
	ld e, SYM_SPACE
	ld a, [wce28]
	ld [wce29], a
	or a
	jr z, .got_up_arrow_tile
	ld e, SYM_CURSOR_U
.got_up_arrow_tile
	ld a, e
	lb bc, 18, 4
	call WriteByteToBGMap0

	; down arrow in list
	ld e, SYM_SPACE
	ld a, [wce28]
	add 5
	ld hl, wNumCardPopRecords
	cp [hl]
	jr nc, .got_down_arrow_tile
	ld e, SYM_CURSOR_D
.got_down_arrow_tile
	ld a, e
	lb bc, 18, 17
	call WriteByteToBGMap0

.loop_visible_record_entries
	ld a, [wce29]
	call .LoadRecord
	ld a, [wce2a]
	ld e, a
	ld d, 2
	ldtx hl, CardPopRecordFriendNameText
	ld a, [wCardPopRecordType]
	cp IRPARAM_RARE_CARD_POP
	jr nz, .rare_card_pop_2
	ldtx hl, RareCardPopRecordFriendNameText
.rare_card_pop_2
	push de
	call InitTextPrinting_ProcessTextFromID
	pop de

	ld d, 7
	ld hl, wCardPopRecord
	call .PrintText
	ld hl, wCardPopRecordYourCardID
	ld e, [hl]
	inc hl
	ld d, [hl]
	call LoadCardDataToBuffer1_FromCardID
	ld a, 14
	call CopyCardNameAndLevel
	ld a, [wce2a]
	inc a
	ld e, a
	ld d, 4
	ld hl, wDefaultText
	call .PrintText
	ld hl, wce29
	inc [hl]
	ld a, [wNumCardPopRecords]
	cp [hl]
	jr z, .done_print_entries
	ld hl, wce2a
	ld a, [hl]
	add $03
	ld [hl], a
	cp $12
	jr c, .loop_visible_record_entries

.done_print_entries
	ret

.PrintText:
	call InitTextPrinting
	jp ProcessText

IngameCardPop:
.Imakuni_first
	ldtx hl, CardPopImakuniText
	ld a, SCRIPTED_CARD_POP_IMAKUNI + 2
	jr .got_partner
.Imakuni_rare
	ldtx hl, CardPopImakuniText
	ld a, SCRIPTED_RARE_CARD_POP_IMAKUNI + 2
	push af
	ld a, IRPARAM_RARE_CARD_POP
	jr .got_partner_and_type
.Ronald
	ldtx hl, CardPopRonaldText
	ld a, SCRIPTED_CARD_POP_RONALD + 2
; fallthrough
.got_partner
	push af
	ld a, IRPARAM_CARD_POP
; fallthrough
.got_partner_and_type
	ld [wCardPopType], a
	call InitSaveData.PrintName
	ld c, NAME_BUFFER_LENGTH
	ld hl, wDefaultText
	ld de, wNameBuffer
.loop_char
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	or a
	jr nz, .loop_char
	inc c
	jr .set_filler
.loop_filler
	xor a
	ld [de], a
	inc de
.set_filler
	dec c
	jr nz, .loop_filler

	pop af
	ld [wNameBuffer + MAX_PLAYER_NAME_LENGTH + 1], a
	ld bc, NAME_BUFFER_LENGTH
	ld hl, wNameBuffer
	ld de, wCardPopRecordName
	call CopyDataHLtoDE
	ld a, [wNameBuffer + MAX_PLAYER_NAME_LENGTH + 1]
	cp SCRIPTED_CARD_POP_IMAKUNI + 2
	jr z, .with_Imakuni_first

; with Ronald or Imakuni_rare
; fully random output
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
	ld hl, wNameBuffer
	call DecideCardToReceiveFromCardPop.CalculateNameHash
	push de
	call EnableSRAM
	ld hl, sPlayerName
	call DecideCardToReceiveFromCardPop.CalculateNameHash
	call DisableSRAM
	pop bc
	call DecideCardToReceiveFromCardPop.get_rng
	ld hl, wCardPopRecordTheirCardID
	ld [hl], e
	inc hl
	ld [hl], d
	call DecideCardToReceiveFromCardPop
	ld bc, .data1
	jr .got_data

; guaranteed to give IMAKUNI_CARD to player
; and choose a random card for Imakuni? from the list
.with_Imakuni_first
	ld a, 6
	call Random
	add a
	ld e, a
	ld d, 0
	ld hl, .card_list_Imakuni
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, wCardPopRecordTheirCardID
	ld [hl], e
	inc hl
	ld [hl], d
	ld de, IMAKUNI_CARD
	call LoadCardDataToBuffer1_FromCardID
	ld a, MUSIC_MATCHVICTORY
	ld [wCardPopCardObtainSong], a
	ld bc, .data2
; fallthrough
.got_data
	push bc
	ld hl, wCardPopRecordYourCardID
	ld [hl], e
	inc hl
	ld [hl], d
	pop hl
	ld de, wCardPopRecordNumBattles
	ld bc, CARDPOP_RECORD_STATS_SIZE
	call CopyDataHLtoDE
	ld a, 1
	ld [de], a
	ld a, [wNameBuffer + MAX_PLAYER_NAME_LENGTH + 1]
	cp SCRIPTED_RARE_CARD_POP_IMAKUNI + 2
	jr nz, .display_ingame_pop

; Imakuni_rare
; set his stats: NumBattles = yours / 2, NumCards = yours / 4, NumCoins = 4
	ld hl, wCardPopRecordNumBattles
	call EnableSRAM
	ld a, [sTotalDuelCounter]
	srl a
	ld [hli], a
	ld a, [sTotalDuelCounter + 1]
	rr a
	ld [hli], a
	call DisableSRAM
	push hl
	call GetAmountOfCardsOwned
REPT 2
	srl h
	rr l
ENDR
	ld e, l
	ld d, h
	pop hl
; wCardPopRecordNumCards
	ld [hl], e
	inc hl
	ld [hl], d
	inc hl
; wCardPopRecordNumCoins
	ld [hl], 4
	inc hl
; wCardPopRecordType
	ld [hl], IRPARAM_RARE_CARD_POP
; fallthrough
.display_ingame_pop
	call SetSpriteAnimationsAsVBlankFunction
	ld a, SCENE_CARD_POP
	lb bc, 0, 0
	call EmptyScreenAndLoadScene
	ldtx hl, AreYouBothReadyToCardPopText
	call PrintScrollableText_NoTextBoxLabel
	call PauseSong
	ld a, SCENE_LINK
	lb bc, 0, 0
	call EmptyScreenAndLoadScene
	ldtx hl, PositionGameBoyColorsAndPressAButtonText
	call DrawWideTextBox_PrintText
.loop_input
	call DoFrame
	ldh a, [hKeysPressed]
	and PAD_A
	jr z, .loop_input
; pressed A
	call RestoreVBlankFunction
	ld a, $32
	ld [wOtherIRCommunicationParams + 3], a
	call HandleCardPopCommunications.success
	call LoadCardPopSceneAndHandleCommunications.add_sram0
	ldtx hl, ReceivedThroughCardPopText
	call DisplayCardReceivedThroughPop
	ld hl, wCardPopRecordTheirCardID
	ld e, [hl]
	inc hl
	ld d, [hl]
	call GetCardName
	ld l, e
	ld h, d
	call LoadTxRam2
	ret

.card_list_Imakuni:
	dw BLASTOISE_LV52 ; $0
	dw GYARADOS       ; $1
	dw ZAPDOS_LV40    ; $2
	dw MEW_LV23       ; $3
	dw MACHAMP_LV67   ; $4
	dw CHANSEY_LV55   ; $5

; data pointer will be pushed to bc
; meant to be custom stats?
.data1
	db $00, $00, $39, $00, $01
.data2
	db $00, $00, $6c, $00, $01

; sends serial data to printer
; if there's an error in connection,
; show Printer Not Connected scene with error message
ConnectPrinter:
	ld bc, 0
	lb de, PRINTERPKT_DATA, FALSE
	call SendPrinterPacket
	ret nc ; return if no error

	ld hl, wPrinterStatus
	ld a, [hl]
	or a
	jr nz, .asm_1a4c4
	ld [hl], $ff
.asm_1a4c4
	ld a, [hl]
	cp $ff
	jr z, ShowPrinterIsNotConnected
;	fallthrough

; shows message on screen depending on wPrinterStatus
; also shows SCENE_GAMEBOY_PRINTER_NOT_CONNECTED.
HandlePrinterError:
	ld a, [wPrinterStatus]
	cp $ff
	jr z, .cable_or_printer_switch
	or a
	jr z, .interrupted
	bit PRINTER_ERROR_BATTERIES_LOST_CHARGE, a
	jr nz, .batteries_lost_charge
	bit PRINTER_ERROR_CABLE_PRINTER_SWITCH, a
	jr nz, .cable_or_printer_switch
	bit PRINTER_ERROR_PAPER_JAMMED, a
	jr nz, .jammed_printer

	ldtx hl, PrinterPacketErrorText
	ld a, $04
	jr ShowPrinterConnectionErrorScene
.cable_or_printer_switch
	ldtx hl, PrinterErrorText
	ld a, $04
	jr ShowPrinterConnectionErrorScene
.jammed_printer
	ldtx hl, PrinterPaperJamErrorText
	ld a, $04
	jr ShowPrinterConnectionErrorScene
.batteries_lost_charge
	ldtx hl, PrinterLowBatteryErrorText
	ld a, $01
	jr ShowPrinterConnectionErrorScene
.interrupted
	ldtx hl, PrintingWasInterruptedText
	call DrawWideTextBox_WaitForInput
	scf
	ret

ShowPrinterIsNotConnected:
	ldtx hl, PrinterNotConnectedErrorText
	ld a, $02
;	fallthrough

; a = error code
; hl = text ID to print in text box
ShowPrinterConnectionErrorScene:
	push hl
	; unnecessary loading TxRam, since the text data
	; already incorporate the error number
	ld l, a
	ld h, $00
	call LoadTxRam3

	call SetSpriteAnimationsAsVBlankFunction
	ld a, SCENE_GAMEBOY_PRINTER_NOT_CONNECTED
	lb bc, 0, 0
	call EmptyScreenAndLoadScene
	pop hl
	call DrawWideTextBox_WaitForInput
	call RestoreVBlankFunction
	scf
	ret

; main card printer function
RequestToPrintCard:
	call LoadCardDataToBuffer1_FromCardID
	call SetSpriteAnimationsAsVBlankFunction
	ld a, SCENE_GAMEBOY_PRINTER_TRANSMITTING
	lb bc, 0, 0
	call EmptyScreenAndLoadScene
	ld a, 20
	call CopyCardNameAndLevel
	ld [hl], TX_END
	ld hl, $0
	call LoadTxRam2
	ldtx hl, NowPrintingText
	call DrawWideTextBox_PrintText
	call EnableLCD
	call PrepareForPrinterCommunications
	call .DrawTopCardInfoInSRAMGfxBuffer0
	call Func_19f87
	call .DrawCardPicInSRAMGfxBuffer2
	call Func_19f99
	jr c, .error
	call DrawBottomCardInfoInSRAMGfxBuffer0
	call Func_1a011
	jr c, .error
	call RestoreVBlankFunction
	call ResetPrinterCommunicationSettings
	or a
	ret
.error
	call RestoreVBlankFunction
	call ResetPrinterCommunicationSettings
	jp HandlePrinterError

; draw card's picture in sGfxBuffer2
.DrawCardPicInSRAMGfxBuffer2:
	ld hl, wLoadedCard1Gfx
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, sGfxBuffer2
	call Func_1adbd
	ld a, $40
	lb hl, 12,  1
	lb de,  2, 68
	lb bc, 16, 12
	call FillRectangle
	ret

; writes the tiles necessary to draw
; the card's information in sGfxBuffer0
; this includes card's type, lv, HP and attacks if Pokemon card
; or otherwise just the card's name and type symbol
.DrawTopCardInfoInSRAMGfxBuffer0:
	call Func_1a025
	call Func_212f

	; draw empty text box frame
	ld hl, sGfxBuffer0
	ld a, $34
	lb de, $30, $31
	ld b, 20
	call CopyLine
	ld c, 15
.loop_lines
	xor a ; SYM_SPACE
	lb de, $36, $37
	ld b, 20
	call CopyLine
	dec c
	jr nz, .loop_lines

	; draw card type symbol
	ld a, $38
	lb hl, 1,  2
	lb de, 1, 65
	lb bc, 2,  2
	call FillRectangle
	; print card's name
	lb de, 4, 65
	ld hl, wLoadedCard1Name
	call InitTextPrinting_ProcessTextFromPointerToID

; prints card's type, lv, HP and attacks if it's a Pokemon card
	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr nc, .skip_pokemon_data
	inc a ; symbol corresponding to card's type (color)
	lb bc, 18, 65
	call WriteByteToBGMap0
	ld a, SYM_Lv
	lb bc, 11, 66
	call WriteByteToBGMap0
	ld a, [wLoadedCard1Level]
	lb bc, 12, 66
	bank1call WriteTwoDigitNumberInTxSymbolFormat
	ld a, SYM_HP
	lb bc, 15, 66
	call WriteByteToBGMap0
	ld a, [wLoadedCard1HP]
	inc b
	bank1call WriteTwoByteNumberInTxSymbolFormat
.skip_pokemon_data
	ret

Func_19f87:
	call TryInitPrinterCommunications
	ret c ; aborted
	ld hl, sGfxBuffer0
	call SendTilesToPrinter
	ret c
	call SendTilesToPrinter
	call SendPrinterInstructionPacket_1Sheet
	ret

Func_19f99:
	call TryInitPrinterCommunications
	ret c
	ld hl, sGfxBuffer0 + $8 tiles
	ld c, $06
.asm_19fa2
	call SendTilesToPrinter
	ret c
	dec c
	jr nz, .asm_19fa2
	call SendPrinterInstructionPacket_1Sheet
	ret

; writes the tiles necessary to draw
; the card's information in sGfxBuffer0
; this includes card's Retreat cost, Weakness, Resistance,
; and attack if it's Pokemon card
; or otherwise just the card's description.
DrawBottomCardInfoInSRAMGfxBuffer0:
	call Func_1a025
	xor a
	ld [wCardPageType], a
	ld hl, sGfxBuffer0
	ld b, 20
	ld c, 9
.loop_lines
	xor a ; SYM_SPACE
	lb de, $36, $37
	call CopyLine
	dec c
	jr nz, .loop_lines
	ld a, $35
	lb de, $32, $33
	call CopyLine

	ld a, [wLoadedCard1Type]
	cp TYPE_ENERGY
	jr nc, .not_pkmn_card
	ld hl, RetreatWeakResistData
	call PlaceTextItems
	ld c, 66
	bank1call DisplayCardPage_PokemonOverview.attacks

	ld a, SYM_No
	lb bc, 15, 72
	call WriteByteToBGMap0
	inc b
	ld a, [wLoadedCard1PokedexNumber]
	bank1call WriteTwoByteNumberInTxSymbolFormat
	ret

.not_pkmn_card
	bank1call SetNoLineSeparation
	lb de, 1, 66
	ld a, SYM_No
	call InitTextPrintingInTextbox
	ld hl, wLoadedCard1NonPokemonDescription
	call ProcessTextFromPointerToID
	bank1call SetOneLineSeparation
	ret

RetreatWeakResistData:
	textitem 1, 70, RetreatText
	textitem 1, 71, WeaknessText
	textitem 1, 72, ResistanceText
	db $ff

Func_1a011:
	call TryInitPrinterCommunications
	ret c
	ld hl, sGfxBuffer0
	ld c, $05
.asm_1a01a
	call SendTilesToPrinter
	ret c
	dec c
	jr nz, .asm_1a01a
	call SendPrinterInstructionPacket_1Sheet_3LineFeeds
	ret

; calls setup text and sets wTilePatternSelector
Func_1a025:
	lb de, $40, $bf
	call SetupText
	ld a, $a4
	ld [wTilePatternSelector], a
	xor a
	ld [wTilePatternSelectorCorrection], a
	ret

; switches to CGB normal speed, resets serial
; enables SRAM and switches to SRAM1
; and clears sGfxBuffer0
PrepareForPrinterCommunications:
	call SwitchToCGBNormalSpeed
	call ResetSerial
	ld a, $10
	ld [wPrinterNumberLineFeeds], a
	call EnableSRAM
	ld a, [sPrinterContrastLevel]
	ld [wPrinterContrastLevel], a
	ldh a, [hBankSRAM]
	ld [wTempPrinterSRAM], a
	ld a, BANK("SRAM3")
	call BankswitchSRAM
	call EnableSRAM
;	fallthrough

ClearPrinterGfxBuffer:
	ld hl, sGfxBuffer0
	ld bc, $400
.loop
	xor a
	ld [hli], a
	dec bc
	ld a, c
	or b
	jr nz, .loop
	xor a
	ld [wce9f], a
	ret

; reverts settings changed by PrepareForPrinterCommunications
ResetPrinterCommunicationSettings:
	push af
	call SwitchToCGBDoubleSpeed
	ld a, [wTempPrinterSRAM]
	call BankswitchSRAM
	call DisableSRAM
	lb de, $30, $bf
	call SetupText
	pop af
	ret

	; send some bytes through serial
Func_1a080: ; unreferenced
	ld bc, 0
	lb de, PRINTERPKT_NUL, FALSE
	jp SendPrinterPacket

; tries initiating the communications for
; sending data to printer
; returns carry if operation was cancelled
; by pressing B button or serial transfer took long
TryInitPrinterCommunications:
	xor a
	ld [wPrinterInitAttempts], a
.wait_input
	call DoFrame
	ldh a, [hKeysHeld]
	and PAD_B
	jr nz, .b_button
	ld bc, 0
	lb de, PRINTERPKT_NUL, FALSE
	call SendPrinterPacket
	jr c, .delay
	and (1 << PRINTER_STATUS_BUSY) | (1 << PRINTER_STATUS_PRINTING)
	jr nz, .wait_input

.init
	ld bc, 0
	lb de, PRINTERPKT_INIT, FALSE
	call SendPrinterPacket
	jr nc, .no_carry
	ld hl, wPrinterInitAttempts
	inc [hl]
	ld a, [hl]
	cp 3
	jr c, .wait_input
	; time out
	scf
	ret
.no_carry
	ret

.b_button
	xor a
	ld [wPrinterStatus], a
	scf
	ret

.delay
	ld c, 10
.delay_loop
	call DoFrame
	dec c
	jr nz, .delay_loop
	jr .init

; loads tiles given by map in hl to sGfxBuffer5
; copies first 20 tiles, then offsets by 2 tiles
; and copies another 20
; compresses this data and sends it to printer
SendTilesToPrinter:
	push bc
	ld de, sGfxBuffer5
	call .Copy20Tiles
	call .Copy20Tiles
	push hl
	call CompressDataForPrinterSerialTransfer
	call SendPrinterPacket
	pop hl
	pop bc
	ret

; copies 20 tiles given by hl to de
; then adds 2 tiles to hl
.Copy20Tiles
	push hl
	ld c, 20
.loop_tiles
	ld a, [hli]
	call .CopyTile
	dec c
	jr nz, .loop_tiles
	pop hl
	ld bc, 2 tiles
	add hl, bc
	ret

; copies a tile to de
; a = tile to get from sGfxBuffer1
.CopyTile
	push hl
	push bc
	ld l, a
	ld h, $00
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl ; *TILE_SIZE
	ld bc, sGfxBuffer1
	add hl, bc
	ld c, TILE_SIZE
.loop_copy
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop_copy
	pop bc
	pop hl
	ret

SendPrinterInstructionPacket_1Sheet_3LineFeeds:
	call GetPrinterContrastSerialData
	push hl
	lb hl, 3, 1
	jr SendPrinterInstructionPacket

; uses wPrinterNumberLineFeeds to get number
; of line feeds to insert before print
SendPrinterInstructionPacket_1Sheet:
	call GetPrinterContrastSerialData
	push hl
	ld hl, wPrinterNumberLineFeeds
	ld a, [hl]
	ld [hl], $00
	ld h, a
	ld l, 1
;	fallthrough

; h = number of line feeds where:
;     high nybble is number of line feeds before printing
;     low nybble is number of line feeds after printing
; l = number of sheets
; expects printer contrast information to be on stack
SendPrinterInstructionPacket:
	push hl
	ld bc, 0
	lb de, PRINTERPKT_DATA, FALSE
	call SendPrinterPacket
	jr c, .aborted
	ld hl, sp+$00 ; contrast level bytes
	ld bc, 4 ; instruction packets are 4 bytes in size
	lb de, PRINTERPKT_PRINT_INSTRUCTION, FALSE
	call SendPrinterPacket
.aborted
	pop hl
	pop hl
	ret

	; returns in h and l the bytes
; to be sent through serial to the printer
; for the set contrast level
GetPrinterContrastSerialData:
	ld a, [wPrinterContrastLevel]
	ld e, a
	ld d, $00
	ld hl, .contrast_level_data
	add hl, de
	ld h, [hl]
	ld l, %11100100 ; palette format
	ret

.contrast_level_data
	db $00, $20, $40, $60, $7f

Func_1a14b: ; unreferenced
	ld a, $01
	jr .asm_1a15d
	ld a, $02
	jr .asm_1a15d
	ld a, $03
	jr .asm_1a15d
	ld a, $04
	jr .asm_1a15d
	ld a, $05
.asm_1a15d
	ld [wce9d], a
	scf
	ret

; a = saved deck index to print
PrintDeckConfiguration:
; copies selected deck from SRAM to wDuelTempList
	call EnableSRAM
	ld l, a
	ld h, DECK_COMPRESSED_STRUCT_SIZE
	call HtimesL
	ld de, sSavedDecks
	add hl, de
	ld de, wDuelTempList
	ld bc, DECK_COMPRESSED_STRUCT_SIZE
	call CopyDataHLtoDE
	call DisableSRAM

	call ShowPrinterTransmitting
	call PrepareForPrinterCommunications
	call Func_1a025
	call Func_212f
	lb de, 0, 64
	lb bc, 20, 4
	call DrawRegularTextBoxDMG
	lb de, 4, 66
	call InitTextPrinting
	ld hl, wDuelTempList ; print deck name
	call ProcessText
	ldtx hl, DeckPrinterText
	call ProcessTextFromID

	ld a, 5
	ld [wPrinterHorizontalOffset], a
	ld hl, wPrinterTotalCardCount
	xor a
	ld [hli], a
	ld [hl], a
	ld [wPrintOnlyStarRarity], a

	ld hl, wCurDeckCards
.loop_cards
	ld a, [hli]
	ld e, a
	ld d, [hl]
	inc hl
	or d
	jr z, .asm_1a1d6
	call LoadCardDataToBuffer1_FromCardID

	; find out this card's count
	ld c, 1
.loop_card_count
	ld a, e
	cp [hl]
	jr nz, .got_card_count
	inc hl
	ld a, d
	cp [hl]
	jr nz, .got_card_count
	inc hl
	inc c
	jr .loop_card_count

.got_card_count
	ld a, c
	ld [wPrinterCardCount], a
	call LoadCardInfoForPrinter
	call AddToPrinterGfxBuffer
	jr c, .printer_error
	jr .loop_cards

.asm_1a1d6
	call SendCardListToPrinter
	jr c, .printer_error
	call ResetPrinterCommunicationSettings
	call RestoreVBlankFunction
	or a
	ret

.printer_error
	call ResetPrinterCommunicationSettings
	call RestoreVBlankFunction
	jp HandlePrinterError

SendCardListToPrinter:
	ld a, [wPrinterHorizontalOffset]
	cp 1
	jr z, .skip_load_gfx
	call LoadGfxBufferForPrinter
	ret c
.skip_load_gfx
	call TryInitPrinterCommunications
	ret c
	call SendPrinterInstructionPacket_1Sheet_3LineFeeds
	ret

; increases printer horizontal offset by 2
AddToPrinterGfxBuffer:
	push hl
	ld hl, wPrinterHorizontalOffset
	inc [hl]
	inc [hl]
	ld a, [hl]
	pop hl
	; return no carry if below 18
	cp 18
	ccf
	ret nc
	; >= 18
;	fallthrough

; copies Gfx to Gfx buffer and sends some serial data
; returns carry set if unsuccessful
LoadGfxBufferForPrinter:
	push hl
	call TryInitPrinterCommunications
	jr c, .set_carry
	ld a, [wPrinterHorizontalOffset]
	srl a
	ld c, a
	ld hl, sGfxBuffer0
.loop_gfx_buffer
	call SendTilesToPrinter
	jr c, .set_carry
	dec c
	jr nz, .loop_gfx_buffer
	call SendPrinterInstructionPacket_1Sheet
	jr c, .set_carry

	call ClearPrinterGfxBuffer
	ld a, 1
	ld [wPrinterHorizontalOffset], a
	pop hl
	or a
	ret

.set_carry
	pop hl
	scf
	ret

; load symbol, name, level and card count to buffer
LoadCardInfoForPrinter:
	push hl
	ld a, [wPrinterHorizontalOffset]
	or %1000000
	ld e, a
	ld d, 3
	ld a, [wPrintOnlyStarRarity]
	or a
	jr nz, .skip_card_symbol
	ld hl, wPrinterTotalCardCount
	ld a, [hli]
	or [hl]
	call z, DrawCardSymbol
.skip_card_symbol
	ld a, 14
	call CopyCardNameAndLevel
	call InitTextPrinting
	ld hl, wDefaultText
	call ProcessText
	ld a, [wPrinterHorizontalOffset]
	or %1000000
	ld c, a
	ld b, 16
	ld a, SYM_CROSS
	call WriteByteToBGMap0
	inc b
	ld a, [wPrinterCardCount]
	bank1call WriteTwoDigitNumberInTxSymbolFormat
	pop hl
	ret

PrintCardList:
; if Select button is held when printing card list
; only print cards with Star rarity (excluding Promotional cards)
; even if it's not marked as seen in the collection
	ld e, FALSE
	ldh a, [hKeysHeld]
	and PAD_SELECT
	jr z, .no_select
	inc e ; TRUE
.no_select
	ld a, e
	ld [wPrintOnlyStarRarity], a

	call ShowPrinterTransmitting
	bank1call CreateTempCardCollection
	ld de, wDefaultText
	call CopyPlayerName
	call PrepareForPrinterCommunications
	call Func_1a025
	call Func_212f

	lb de, 0, 64
	lb bc, 20, 4
	call DrawRegularTextBoxDMG
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
	lb de, 2, 66
	call InitTextPrinting
	ld hl, wDefaultText
	call ProcessText
	ldtx hl, AllCardsOwnedText
	call ProcessTextFromID
	ld a, [wPrintOnlyStarRarity]
	or a
	jr z, .asm_1a2c2
	lb de, 4, 85
	call Func_22ca
.asm_1a2c2
	ld a, $ff
	ld [wCurPrinterCardType], a
	xor a
	ld hl, wPrinterTotalCardCount
	ld [hli], a
	ld [hl], a
	ld hl, wPrinterNumCardTypes
	ld [hli], a
	ld [hl], a
	ld a, 5
	ld [wPrinterHorizontalOffset], a

	ld de, GRASS_ENERGY
.loop_cards
	push de
	call LoadCardDataToBuffer1_FromCardID
	jr c, .done_card_loop
	ld hl, wTempCardCollection
	add hl, de
	ld a, [hl] ; card ID count in collection
	ld [wPrinterCardCount], a
	call .LoadCardTypeEntry
	jr c, .printer_error_pop_de

	ld a, [wPrintOnlyStarRarity]
	or a
	jr z, .all_owned_cards_mode
	ld a, [wLoadedCard1RealSet]
	and %11110000
	cp $40 ; PROMOTIONAL
	jr z, .next_card
	ld a, [wLoadedCard1Rarity]
	cp STAR
	jr nz, .next_card
	; not Promotional, and Star rarity
	ld hl, wPrinterCardCount
	res CARD_NOT_OWNED_F, [hl]
	jr .got_card_count

.all_owned_cards_mode
	ld a, [wPrinterCardCount]
	or a
	jr z, .next_card
	cp CARD_NOT_OWNED
	jr z, .next_card ; ignore not owned cards

.got_card_count
	ld a, [wPrinterCardCount]
	and CARD_COUNT_MASK
	ld c, a

	; add to total card count
	ld hl, wPrinterTotalCardCount
	add [hl]
	ld [hli], a
	ld a, 0
	adc [hl]
	ld [hl], a

	; add to current card type count
	ld hl, wPrinterCurCardTypeCount
	ld a, c
	add [hl]
	ld [hli], a
	ld a, 0
	adc [hl]
	ld [hl], a

	ld hl, wPrinterNumCardTypes
	inc [hl]
	jr nz, .asm_1a99d
	inc hl
	inc [hl]
.asm_1a99d
	ld hl, wce98
	inc [hl]
	call LoadCardInfoForPrinter
	call AddToPrinterGfxBuffer
	jr c, .printer_error_pop_de
.next_card
	pop de
	inc de
	jr .loop_cards

.printer_error_pop_de
	pop de
.printer_error
	call ResetPrinterCommunicationSettings
	call RestoreVBlankFunction
	jp HandlePrinterError

.done_card_loop
	pop de
	; add separator line
	ld a, [wPrinterHorizontalOffset]
	dec a
	or $40
	ld c, a
	ld b, 0
	call BCCoordToBGMap0Address
	ld a, $35
	lb de, $35, $35
	ld b, 20
	call CopyLine
	call AddToPrinterGfxBuffer
	jr c, .printer_error

	ld hl, wPrinterTotalCardCount
	ld c, [hl]
	inc hl
	ld b, [hl]
	ldtx hl, TotalCardsCountText
	call .PrintTextWithNumber
	jr c, .printer_error
	ld a, [wPrintOnlyStarRarity]
	or a
	jr nz, .done
	ld hl, wPrinterNumCardTypes
	ld c, [hl]
	inc hl
	ld b, [hl]
	ldtx hl, TotalUniqueCardsCountText
	call .PrintTextWithNumber
	jr c, .printer_error

.done
	call SendCardListToPrinter
	jr c, .printer_error
	call ResetPrinterCommunicationSettings
	call RestoreVBlankFunction
	or a
	ret

; prints text ID given in hl
; with decimal representation of
; the number given in bc
; hl = text ID
; bc = number
.PrintTextWithNumber
	push bc
	ld a, [wPrinterHorizontalOffset]
	dec a
	or $40
	ld e, a
	ld d, 2
	call InitTextPrinting
	call ProcessTextFromID
	ld d, 14
	call InitTextPrinting
	pop hl
	call TwoByteNumberToTxSymbol_TrimLeadingZeros
	ld hl, wStringBuffer
	call ProcessText
	call AddToPrinterGfxBuffer
	ret

; loads this card's type icon and text
; if it's a new card type that hasn't been printed yet
.LoadCardTypeEntry
	ld a, [wLoadedCard1Type]
	ld c, a
	cp TYPE_ENERGY
	jr c, .got_type ; jump if Pokemon card
	ld c, $08
	cp TYPE_TRAINER
	jr nc, .got_type ; jump if Trainer card
	ld c, $07
.got_type
	ld hl, wCurPrinterCardType
	ld a, [hl]
	cp c
	ret z ; already handled this card type

	; show corresponding icon and text
	; for this new card type
	ld a, c
	ld [hl], a ; set it as current card type
	add a
	add c ; *3
	ld c, a
	ld b, $00
	ld hl, .IconTextList
	add hl, bc
	ld a, [wPrinterHorizontalOffset]
	dec a
	or %1000000
	ld e, a
	ld d, 1
	ld a, [hli]
	push hl
	lb bc, 2, 2
	lb hl, 1, 2
	call FillRectangle
	pop hl
	ld d, 3
	inc e
	call InitTextPrinting
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call ProcessTextFromID

	call AddToPrinterGfxBuffer
	ld hl, wPrinterCurCardTypeCount
	xor a
	ld [hli], a
	ld [hl], a
	ld [wce98], a
	ret

.IconTextList
	; Fire
	db $e0 ; icon tile
	tx FirePokemonText

	; Grass
	db $e4 ; icon tile
	tx GrassPokemonText

	; Lightning
	db $e8 ; icon tile
	tx LightningPokemonText

	; Water
	db $ec ; icon tile
	tx WaterPokemonText

	; Fighting
	db $f0 ; icon tile
	tx FightingPokemonText

	; Psychic
	db $f4 ; icon tile
	tx PsychicPokemonText

	; Colorless
	db $f8 ; icon tile
	tx ColorlessPokemonText

	; Energy
	db $fc ; icon tile
	tx EnergyCardText

	; Trainer
	db $dc ; icon tile
	tx TrainerCardText

ShowPrinterTransmitting:
	call SetSpriteAnimationsAsVBlankFunction
	ld a, SCENE_GAMEBOY_PRINTER_TRANSMITTING
	lb bc, 0, 0
	call EmptyScreenAndLoadScene
	ldtx hl, NowPrintingPleaseWaitText
	call DrawWideTextBox_PrintText
	call EnableLCD
	ret

; compresses $28 tiles in sGfxBuffer5
; and writes it in sGfxBuffer5 + $28 tiles.
; compressed data has 2 commands to instruct on how to decompress it.
; - a command byte with bit 7 not set, means to copy that many + 1
; bytes that are following it literally.
; - a command byte with bit 7 set, means to copy the following byte
; that many times + 2 (after masking the top bit of command byte).
; returns in bc the size of the compressed data and
; in de the packet type data.
CompressDataForPrinterSerialTransfer:
	ld hl, sGfxBuffer5
	ld de, sGfxBuffer5 + $28 tiles
	ld bc, $28 tiles
.loop_remaining_data
	ld a, $ff
	inc b
	dec b
	jr nz, .check_compression
	ld a, c
.check_compression
	push bc
	push de
	ld c, a
	call CheckDataCompression
	ld a, e
	ld c, e
	pop de
	jr c, .copy_byte
	ld a, c
	ld b, c
	dec a
	ld [de], a ; number of bytes to  copy literally - 1
	inc de
.copy_literal_sequence
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .copy_literal_sequence
	ld c, b
	jr .sub_added_bytes

.copy_byte
	ld a, c
	dec a
	dec a
	or %10000000 ; set high bit
	ld [de], a ; = (n times to copy - 2) | %10000000
	inc de
	ld a, [hl] ; byte to copy n times
	ld [de], a
	inc de
	ld b, $0
	add hl, bc

.sub_added_bytes
	ld a, c
	cpl
	inc a
	pop bc
	add c
	ld c, a
	ld a, $ff
	adc b
	ld b, a
	or c
	jr nz, .loop_remaining_data

	ld hl, $10000 - (sGfxBuffer5 + $28 tiles)
	add hl, de ; gets the size of the compressed data
	ld c, l
	ld b, h
	ld hl, sGfxBuffer5 + $28 tiles
	lb de, PRINTERPKT_DATA, TRUE
	ret

; checks whether the next byte sequence in hl, up to c bytes, can be compressed
; returns carry if the next sequence of bytes can be compressed,
; i.e. has at least 3 consecutive bytes with the same value.
; in that case, returns in e the number of consecutive
; same value bytes that were found.
; if there are no bytes with same value, then count as many bytes left
; as possible until either there are no more remaining data bytes,
; or until a sequence of 3 bytes with the same value are found.
; in that case, the number of bytes in this sequence is returned in e.
CheckDataCompression:
	push hl
	ld e, c
	ld a, c
; if number of remaining bytes is less than 4
; then no point in compressing
	cp 4
	jr c, .no_carry

; check first if there are at least
; 3 consecutive bytes with the same value
	ld b, c
	ld a, [hli]
	cp [hl]
	inc hl
	jr nz, .literal_copy ; not same
	cp [hl]
	inc hl
	jr nz, .literal_copy ; not same

; 3 consecutive bytes were found with same value
; keep track of how many consecutive bytes
; with the same value there are in e
	dec c
	dec c
	dec c
	ld e, 3
.loop_same_value
	cp [hl]
	jr nz, .set_carry ; exit when a different byte is found
	inc hl
	inc e
	dec c
	jr z, .set_carry ; exit when there is no more remaining data
	bit 5, e
	; exit if number of consecutive bytes >= $20
	jr z, .loop_same_value
.set_carry
	pop hl
	scf
	ret

.literal_copy
; consecutive bytes are not the same value
; count the number of bytes there are left
; until a sequence of 3 bytes with the same value is found
	pop hl
	push hl
	ld c, b ; number of remaining bytes
	ld e, 1
	ld a, [hli]
	dec c
	jr z, .no_carry ; exit if no more data
.reset_same_value_count
	ld d, 2 ; number of consecutive same value bytes to exit
.next_byte
	inc e
	dec c
	jr z, .no_carry
	bit 7, e
	jr nz, .no_carry ; exit if >= $80
	cp [hl]
	jr z, .same_consecutive_value
	ld a, [hli]
	jr .reset_same_value_count
.no_carry
	pop hl
	or a
	ret

.same_consecutive_value
	inc hl
	dec d
	jr nz, .next_byte
	; 3 consecutive bytes with same value found
	; discard the last 3 bytes in the sequence
	dec e
	dec e
	dec e
	jr .no_carry

; sets up to start a link duel
; decides which device will pick the number of prizes
; then exchanges names and duels between the players
; and starts the main duel routine
_SetUpAndStartLinkDuel:
	ld hl, sp+$00
	ld a, l
	ld [wDuelReturnAddress], a
	ld a, h
	ld [wDuelReturnAddress + 1], a
	call SetSpriteAnimationsAsVBlankFunction

	ld a, SCENE_LINK_INTRO_TRANSMITTING
	lb bc, 0, 0
	call EmptyScreenAndLoadScene

	bank1call LoadPlayerDeck
	bank1call DecideLinkDuelVariables
	push af
	call RestoreVBlankFunction
	pop af
	jp c, .error

	ld a, DUELIST_TYPE_PLAYER
	ld [wPlayerDuelistType], a
	ld a, DUELIST_TYPE_LINK_OPP
	ld [wOpponentDuelistType], a
	ld a, DUELTYPE_LINK
	ld [wDuelType], a

	call EmptyScreen
	ld a, [wSerialOp]
	cp SERIAL_OP_MASTER_TCG2
	jr nz, .opponent

	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
	call .ExchangeNamesAndDecks
	jp c, .error
	lb de, 6, 2
	lb bc, 8, 6
	call DrawRegularTextBox
	lb de, 7, 4
	call InitTextPrinting
	ldtx hl, PrizesNumberText
	call ProcessTextFromID
	ldtx hl, ChooseTheNumberOfPrizesText
	call DrawWideTextBox_PrintText
	call EnableLCD
	call .PickNumberOfPrizeCards
	ld a, [wSelectedCoin]
	ld b, a
	ld a, [wNPCDuelPrizes]
	call SerialSend8Bytes
	jr c, .error
	call SerialRecv8Bytes
	jr c, .error
	ld [wOppCoin], a
	jr .prizes_decided

.opponent
	ld a, OPPONENT_TURN
	ldh [hWhoseTurn], a
	call .ExchangeNamesAndDecks
	jr c, .error
	ldtx hl, PleaseWaitDecidingNumberOfPrizesText
	call DrawWideTextBox_PrintText
	call EnableLCD
	call SerialRecv8Bytes
	jr c, .error
	ld [wNPCDuelPrizes], a
	ld a, b
	ld [wOppCoin], a
	ld a, [wSelectedCoin]
	call SerialSend8Bytes
	jr c, .error

.prizes_decided
	call ExchangeRNG
	jr c, .error
	ld a, [wNameBuffer + MAX_PLAYER_NAME_LENGTH + 1]
	add MARK_LINK_PIC
	ld [wOpponentPicID], a
	ldh a, [hWhoseTurn]
	push af
	call EmptyScreen
	bank1call SetDefaultPalettes
	ld a, SHUFFLE_DECK
	ld [wDuelDisplayedScreen], a
	farcall DrawDuelistPortraitsAndNames
	ld a, OPPONENT_TURN
	ldh [hWhoseTurn], a
	ld a, [wNPCDuelPrizes]
	ld l, a
	ld h, $00
	call LoadTxRam3
	ldtx hl, BeginDuelOfXPrizesWithOpponentText
	call DrawWideTextBox_WaitForInput
	pop af
	ldh [hWhoseTurn], a
	call ExchangeRNG
	bank1call StartDuel_VS.init
	call ResetCardPopStatusWithSamePartnerOnLinkDuel
	ret

.error
	ld a, -1
	ld [wDuelResult], a
	call SetSpriteAnimationsAsVBlankFunction
	ld a, SCENE_LINK_INTRO_NOT_CONNECTED
	lb bc, 0, 0
	call EmptyScreenAndLoadScene
	ldtx hl, TransmissionErrorTryAgainText
	call DrawWideTextBox_WaitForInput
	call RestoreVBlankFunction
	call ResetSerial
	ret

.ExchangeNamesAndDecks
	ld de, wDefaultText
	push de
	call EnableSRAM
	ld hl, sPlayerName
	ld c, NAME_BUFFER_LENGTH
.copy_player_name_loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .copy_player_name_loop
	call DisableSRAM
	pop hl
	ld de, wNameBuffer
	ld c, NAME_BUFFER_LENGTH
	call SerialExchangeBytes
	ret c
	xor a
	ld hl, wOpponentName
	ld [hli], a
	ld [hl], a
	ld hl, wPlayerDeck
	ld de, wOpponentDeck
	ld c, DECK_SIZE_BYTES
	call SerialExchangeBytes
	ret

; handles player choice of number of prize cards
; pressing left/right makes it decrease/increase respectively
; selection is confirmed by pressing A button
.PickNumberOfPrizeCards:
	ld a, PRIZES_4
	ld [wNPCDuelPrizes], a
	xor a
	ld [wPrinterCurPrizeFrame], a
.loop_input
	call DoFrame
	call UpdateRNGSources
	ld a, [wNPCDuelPrizes]
	add SYM_0
	ld e, a

; check frame counter so that it
; either blinks or shows number
	ld hl, wPrinterCurPrizeFrame
	ld a, [hl]
	inc [hl]
	and $10
	jr z, .no_blink
	ld e, SYM_SPACE
.no_blink
	ld a, e
	lb bc, 9, 6
	call WriteByteToBGMap0
	ldh a, [hDPadHeld]
	ld b, a
	ld a, [wNPCDuelPrizes]
	bit B_PAD_LEFT, b
	jr z, .check_d_right
	dec a
	cp PRIZES_2
	jr nc, .got_prize_count
	ld a, PRIZES_6  ; wrap around to 6
	jr .got_prize_count
.check_d_right
	bit B_PAD_RIGHT, b
	jr z, .check_a_button
	inc a
	cp PRIZES_6 + 1
	jr c, .got_prize_count
	ld a, PRIZES_2
.got_prize_count
	ld [wNPCDuelPrizes], a
	xor a
	ld [wPrinterCurPrizeFrame], a
.check_a_button
	bit B_PAD_A, b
	jr z, .loop_input
	ret

Func_1acbf:
	ld [wNPCDuelDeckID], a
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
	call EnableSRAM
	ld hl, sDeck1Name
	ld c, NUM_DECKS
.check_player_deck_loop
	ld a, [hl]
	or a
	jr z, .next
	ld de, DECK_COMPRESSED_STRUCT_SIZE
	add hl, de
	dec c
	jr nz, .check_player_deck_loop

.fallback_too_many
	ld a, [wNPCDuelDeckID]
	add 2 ; *_DECK_ID = *_DECK - 2
	call LoadDeck
	ld hl, wPlayerDeck
.add_card_loop
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld a, e
	or d
	jr z, .done_carry
	call AddCardToCollection
	jr .add_card_loop
.done_carry
	scf
	ret

.next
	push hl
	bank1call CreateTempCardCollection
	ld a, [wNPCDuelDeckID]
	add 2 ; *_DECK_ID = *_DECK - 2
	call LoadDeck
	ld hl, wPlayerDeck
.handle_temp_card_loop
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld a, e
	or d
	jr z, .temp_card_done
	push hl
	ld hl, wTempCardCollection
	add hl, de
	res 7, [hl]
	inc [hl]
	ld a, [hl]
	pop hl
	cp MAX_AMOUNT_OF_CARD + 1
	jr c, .handle_temp_card_loop
	pop hl
	jr .fallback_too_many
.temp_card_done
	pop hl
	ld a, [wNPCDuelDeckID]
	add 2 ; *_DECK_ID = *_DECK - 2
	call InitSaveData.SaveDeck
	call EnableSRAM
	ld hl, wPlayerDeck
.handle_card_collection_loop
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld a, e
	or d
	jr z, .card_collection_done
	push hl
	ld hl, sCardCollection
	add hl, de
	res 7, [hl]
	pop hl
	jr .handle_card_collection_loop
.card_collection_done
	call DisableSRAM
	or a
	ret

; show screen with the received card at de with the text at hl
_ShowReceivedCardScreen:
	push hl
	push de
	lb de, $38, $9f
	call SetupText
	pop de
	call LoadCardDataToBuffer1_FromCardID
	call PauseSong
	ld a, MUSIC_MEDAL
	call PlaySong
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
	pop hl
	farcall _DisplayCardDetailScreen
.loop
	call AssertSongFinished
	or a
	jr nz, .loop
	call ResumeSong
	bank1call OpenCardPage_FromHand
	ret

; a = BOOSTER_* constant
; generate and display its content,
; and add the drawn cards to the player's collection (sCardCollection)
GetBoosterPack:
	farcall GenerateBoosterContent
	call DisplayBoosterContent
	ld hl, wPlayerDeck
.add_loop
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld a, e
	or d
	ret z
	call AddCardToCollection
	jr .add_loop

; clear wPlayerCardLocations, count wPlayerDeck into wDuelTempList,
; then display them
DisplayBoosterContent:
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
	ld h, a
	ld l, 0 ; wPlayerDuelVariables (wPlayerCardLocations)
.clear_loop
	xor a
	ld [hli], a
	ld a, l
	cp DECK_SIZE
	jr c, .clear_loop
	ld hl, wPlayerDeck
	ld de, wDuelTempList
	ld c, 0
.set_list_loop
	ld a, [hli]
	or [hl]
	inc hl
	jr z, .done
	ld a, c
	ld [de], a
	inc de
	inc c
	jr .set_list_loop
.done
	ld a, $ff
	ld [de], a
	bank1call SetupDuel
	bank1call InitAndDrawCardListScreenLayout
	ldtx hl, ChooseCardToCheckText
	ldtx de, BoosterPackCardsText
	bank1call SetCardListHeaderAndInfoText
	ld a, PAD_START + PAD_A
	ld [wNoItemSelectionMenuKeys], a
	bank1call DisplayCardList
	ret

Func_1adbd:
	push de
	ld de, wc000
	lb bc, $30, TILE_SIZE
	call Func_2dc4
	pop de
	ld hl, wc000
	ld c, $08
.asm_1adcd
	ld b, $06
.asm_1adcf
	push bc
	ld c, $08
.asm_1add2
	ld b, $02
.asm_1add4
	push bc
	push hl
	ld c, [hl]
	ld b, $04
.asm_1add9
	rr c
	rra
	sra a
	dec b
	jr nz, .asm_1add9
	ld hl, $c0
	add hl, de
	ld [hli], a
	inc hl
	ld [hl], a
	ld b, $04
.asm_1adea
	rr c
	rra
	sra a
	dec b
	jr nz, .asm_1adea
	ld [de], a
	ld hl, $2
	add hl, de
	ld [hl], a
	pop hl
	pop bc
	inc de
	inc hl
	dec b
	jr nz, .asm_1add4
	inc de
	inc de
	dec c
	jr nz, .asm_1add2
	pop bc
	dec b
	jr nz, .asm_1adcf
	ld a, $c0
	add e
	ld e, a
	ld a, $00
	adc d
	ld d, a
	dec c
	jr nz, .asm_1adcd
	ret

LoadHandCardsIcon:
	ld hl, HandCardsGfx
	ld de, v0Tiles2 + $38 tiles
	ld b, 4 tiles
	call Func_1b8f1
	ret

HandCardsGfx:
	INCBIN "gfx/hand_cards.2bpp"

WhatIsYourNameData:
	textitem 1, 1, WhatIsYourNameText
	db $ff ; end
; 0x1ae65

SECTION "Bank 6@6e92", ROMX[$6e92], BANK[$6]

; play different sfx by a.
; if a is 0xff play SFX_03 (usually following a B press),
; else play SFX_02 (usually following an A press).
PlayAcceptOrDeclineSFX_Bank06:
	push af
	inc a
	jr z, .sfx_decline
	ld a, SFX_02
	jr .sfx_accept
.sfx_decline
	ld a, SFX_03
.sfx_accept
	call PlaySFX
	pop af
	ret

; get player name from the user into hl
InputPlayerName:
	ld e, l
	ld d, h
	ld a, MAX_PLAYER_NAME_LENGTH
	ld hl, WhatIsYourNameData
	lb bc, 12, 1
	call InitializeInputName
	call Set_OBJ_8x8

	xor a
	ld [wd3ef], a
	ld [wTileMapFill], a
	call EmptyScreen
	call ZeroObjectPositions
	ld a, $01
	ld [wVBlankOAMCopyToggle], a
	call LoadSymbolsFont
	lb de, $38, $bf
	call SetupText
	call LoadFullWidthTextCursorTile
	xor a ; NAME_MODE_HIRAGANA
	ld [wNamingScreenMode], a

	call UpdateNamingScreenUI

	xor a
	ld [wNamingScreenCursorX], a
	ld [wNamingScreenCursorY], a

	ld a, 9
	ld [wNamingScreenNumColumns], a
	ld a, 7
	ld [wNamingScreenNumRows], a
	ld a, SYM_CURSOR_R
	ld [wMenuVisibleCursorTile], a
	ld a, SYM_SPACE
	ld [wMenuInvisibleCursorTile], a
.loop
	ld a, $01
	ld [wVBlankOAMCopyToggle], a
	call DoFrame

	call UpdateRNGSources

	ldh a, [hDPadHeld]
	and PAD_START
	jr z, .check_select
	ld a, $01
	call PlayAcceptOrDeclineSFX_Bank06
	call HideCursorAtCharPosition
	ld a, 6
	ld [wNamingScreenCursorY], a
	inc a ; 7
	ld [wNamingScreenCursorX], a
	call ShowCursorAtCharPosition
	jr .loop

.check_select
	ldh a, [hDPadHeld]
	and PAD_SELECT
	jr z, .asm_1af3b
	ld a, $01
	call PlayAcceptOrDeclineSFX_Bank06
	ld a, [wNamingScreenMode]
	inc a
	cp NUM_NAME_MODES
	jr c, .got_mode
	xor a ; NAME_MODE_HIRAGANA
.got_mode
	ld [wNamingScreenMode], a
	xor a
	ld [wNamingScreenCursorX], a
	ld [wNamingScreenCursorY], a
	call UpdateNamingScreenUI
	jr .loop

.asm_1af3b
	call HandleNamingScreenInput
	jr nc, .loop
	cp $ff
	jr z, .remove_last_char
	call SelectKeyboardItem
	jr nc, .loop
	call FinalizeInputName
	ret

.remove_last_char
	ld a, [wNamingScreenBufferLength]
	or a
	jr z, .loop
	ld e, a
	ld d, $00
	ld hl, wNamingScreenBuffer
	add hl, de
	dec hl
	dec hl
	ld [hl], TX_END
	ld hl, wNamingScreenBufferLength
	dec [hl]
	dec [hl]
	call ProcessTextWithUnderbar
	jr .loop

; called when naming (either player's or deck's) starts.
; a = maximum length of name (depending on whether player's or deck's).
; bc = position of name.
; de = dest. pointer.
; hl = pointer to text item of the question.
InitializeInputName:
	ld [wNamingScreenBufferMaxLength], a

	; wNamingScreenNamePosition = bc
	push hl
	ld hl, wNamingScreenNamePosition
	ld [hl], b
	inc hl
	ld [hl], c
	pop hl

	; wNamingScreenQuestionPointer = hl
	ld b, h
	ld c, l
	ld hl, wNamingScreenQuestionPointer
	ld [hl], c
	inc hl
	ld [hl], b

	; wNamingScreenDestPointer = de
	ld hl, wNamingScreenDestPointer
	ld [hl], e
	inc hl
	ld [hl], d

	; clear the name buffer
	ld a, NAMING_SCREEN_BUFFER_LENGTH
	ld hl, wNamingScreenBuffer
	farcall ClearNBytesFromHL

	ld a, [de]
	cp $06
	jr z, .get_length
	ld hl, wNamingScreenBuffer
	ld a, [wNamingScreenBufferMaxLength]
	ld b, a
	inc b
.loop
	ld a, [de]
	inc de
	ld [hli], a
	dec b
	jr nz, .loop
.get_length
	ld hl, wNamingScreenBuffer
	call GetTextLengthInTiles
	ld a, c
	ld [wNamingScreenBufferLength], a
	ret

FinalizeInputName:
	ld hl, wNamingScreenDestPointer
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld l, e
	ld h, d
	ld de, wNamingScreenBuffer
	ld a, [wNamingScreenBufferMaxLength]
	ld b, a
	inc b
	jr InitializeInputName.loop

; draws textbox around keyboard,
; the naming question and the actual
; items in the keyboard
UpdateNamingScreenUI:
	call DrawTextboxForKeyboard
	call ProcessTextWithUnderbar
	ld hl, wNamingScreenQuestionPointer
	ld c, [hl]
	inc hl
	ld a, [hl]
	ld h, a
	or c
	jr z, .print
	; print the question string.
	ld l, c
	call PlaceTextItems
.print
	ld hl, .text_items1
	call PlaceTextItems

	ld a, [wNamingScreenMode]
	or a
	jr nz, .asm_1afe5
; NAME_MODE_HIRAGANA
	ld hl, .text_items2
	call PlaceTextItems
	ldtx hl, HiraganaKeyboardText
	jr .asm_1b00a
.asm_1afe5
	dec a
	jr nz, .asm_1aff3
; NAME_MODE_KATAKANA
	ld hl, .text_items3
	call PlaceTextItems
	ldtx hl, KatakanaKeyboardText
	jr .asm_1b00a
.asm_1aff3
	dec a
	jr nz, .asm_1b001
; NAME_MODE_UPPER_ABC
	ld hl, .text_items4
	call PlaceTextItems
	ldtx hl, UppercaseKeyboardText
	jr .asm_1b00a
.asm_1b001
; NAME_MODE_LOWER_ABC
	ld hl, .text_items5
	call PlaceTextItems
	ldtx hl, LowercaseKeyboardText
.asm_1b00a
	lb de, 2, 4
	call InitTextPrinting
	call ProcessTextFromID
	call EnableLCD
	ret

.text_items1:
	textitem 16, 16, EndText
	db $ff ; end

.text_items2:
	textitem  2, 16, KatakanaOptionText
	textitem  7, 16, UppercaseOptionText
	textitem 12, 16, LowercaseOptionText
	db $ff ; end

.text_items3:
	textitem  2, 16, HiraganaOptionText
	textitem  7, 16, UppercaseOptionText
	textitem 12, 16, LowercaseOptionText
	db $ff ; end

.text_items4:
	textitem  2, 16, HiraganaOptionText
	textitem  7, 16, KatakanaOptionText
	textitem 12, 16, LowercaseOptionText
	db $ff ; end

.text_items5:
	textitem  2, 16, HiraganaOptionText
	textitem  7, 16, KatakanaOptionText
	textitem 12, 16, UppercaseOptionText
	db $ff ; end

DrawTextboxForKeyboard:
	lb de, 0, 3
	lb bc, 20, 15
	call DrawRegularTextBox
	ret

ProcessTextWithUnderbar:
	ld hl, wNamingScreenNamePosition
	ld d, [hl]
	inc hl
	ld e, [hl]
	push de
	call InitTextPrinting
	ld a, [wNamingScreenBufferMaxLength]
	ld e, a
	ld a, $14
	sub e
	inc a
	ld e, a ; = $14 - wNamingScreenBufferMaxLength + 1
	ld d, $00
	ld hl, .underbar_chars
	add hl, de
	call ProcessText
	pop de
	call InitTextPrinting
	ld hl, wNamingScreenBuffer
	call ProcessText
	ret

.underbar_chars
	db $57
	textfw "__________"
	done

HandleNamingScreenInput:
.start
	xor a
	ld [wMenuInputSFX], a
	ldh a, [hDPadHeld]
	or a
	jp z, .check_btns
	ld b, a
	ld a, [wNamingScreenNumRows]
	ld c, a
	ld a, [wNamingScreenCursorX]
	ld h, a
	ld a, [wNamingScreenCursorY]
	ld l, a
	bit B_PAD_UP, b
	jr z, .check_d_down
	; move cursor down
	dec a
	bit 7, a
	jr z, .apply_y_value
	; wrap around
	ld a, c
	dec a
	jr .apply_y_value
.check_d_down
	bit B_PAD_DOWN, b
	jr z, .horizontal_directions
	; move cursor up
	inc a
	cp c
	jr c, .apply_y_value
	; wrap around
	xor a
	jr .apply_y_value

.horizontal_directions
	ld a, [wNamingScreenNumColumns]
	ld c, a
	ld a, h
	bit B_PAD_LEFT, b
	jr z, .check_d_right
	ld d, a
	ld a, 6 ; is last row?
	cp l
	ld a, d
	jr nz, .move_left
	; handle last row movement
	push hl
	push bc
	push af
	call GetCharInfoFromPos
	inc hl
	inc hl
	inc hl
	inc hl
	inc hl
	ld a, [hl]
	dec a
	ld d, a
	pop af
	pop bc
	pop hl
	sub d ; cursor_x - d
	cp -1
	jr nz, .asm_1b0f1
	; wrap around
	ld a, c
	sub 2
	jr .apply_x_value
.asm_1b0f1
	cp -2
	jr nz, .move_left
	; wrap around
	ld a, c
	sub 3
	jr .apply_x_value

.move_left
	dec a
	bit 7, a
	jr z, .apply_x_value
	ld a, c
	dec a
	jr .apply_x_value

.check_d_right
	bit B_PAD_RIGHT, b
	jr z, .check_btns
	ld d, a
	ld a, 6 ; is last row?
	cp l
	ld a, d
	jr nz, .move_right
	push hl
	push bc
	push af
	call GetCharInfoFromPos
	inc hl
	inc hl
	inc hl
	inc hl
	ld a, [hl]
	dec a
	ld d, a
	pop af
	pop bc
	pop hl
	add d ; cursor_x + d
.move_right
	inc a
	cp c
	jr c, .apply_x_value
	inc c
	cp c
	jr c, .warp_around_right
	inc c
	cp c
	jr c, .warp_round_last_row
	ld a, 2
	jr .apply_x_value
.warp_round_last_row
	ld a, 1
	jr .apply_x_value
.warp_around_right
	xor a
	jr .apply_x_value

.apply_y_value
	ld l, a
	jr .got_new_cursor_position

.apply_x_value
	ld h, a

.got_new_cursor_position
	push hl
	call GetCharInfoFromPos
	inc hl
	inc hl
	inc hl
	ld a, [wNamingScreenMode]
	cp NAME_MODE_LOWER_ABC
	jr nz, .asm_1b14a
	inc hl
	inc hl
.asm_1b14a
	ld d, [hl]
	push de
	call HideCursorAtCharPosition
	pop de
	pop hl
	ld a, l
	ld [wNamingScreenCursorY], a
	ld a, h
	ld [wNamingScreenCursorX], a
	xor a
	ld [wNamingScreenCursorBlinkCounter], a
	ld a, KEYBOARD_UNKNOWN
	cp d
	jp z, .start
	ld a, SFX_01
	ld [wMenuInputSFX], a

.check_btns
	ldh a, [hKeysPressed]
	and PAD_A | PAD_B
	jr z, .no_pressed_btns
	and PAD_A
	jr nz, .asm_1b174
	ld a, $ff
.asm_1b174
	call PlayAcceptOrDeclineSFX_Bank06
	push af
	call ShowCursorAtCharPosition
	pop af
	scf
	ret

.no_pressed_btns
	ld a, [wMenuInputSFX]
	or a
	jr z, .skip_sfx
	call PlaySFX
.skip_sfx
	ld hl, wNamingScreenCursorBlinkCounter
	ld a, [hl]
	inc [hl]
	and $0f
	ret nz
	ld a, [wMenuVisibleCursorTile]
	bit 4, [hl]
	jr z, DrawSymbolAtCharPosition
; fallthrough

HideCursorAtCharPosition:
	ld a, [wMenuInvisibleCursorTile]
; fallthrough

DrawSymbolAtCharPosition:
	ld e, a
	ld a, [wNamingScreenCursorX]
	ld h, a
	ld a, [wNamingScreenCursorY]
	ld l, a
	call GetCharInfoFromPos
	ld a, [hli] ; y
	ld c, a
	ld a, [wd3ef]
	or a
	jr z, .asm_1b1ae
	inc c
.asm_1b1ae
	ld b, [hl] ; x
	dec b
	ld a, e ; tile
	call UpdateNameTextCursor
	call WriteByteToBGMap0
	or a
	ret

ShowCursorAtCharPosition:
	ld a, [wMenuVisibleCursorTile]
	jr DrawSymbolAtCharPosition

; a = tile of cursor
UpdateNameTextCursor:
	push af
	push bc
	push de
	push hl
	push af
	call ZeroObjectPositions
	pop af
	ld b, a
	ld a, [wMenuInvisibleCursorTile]
	cp b
	jr z, .done ; cursor is invisible, done
	ld a, [wd3ef]
	or a
	jr nz, .asm_1b201

; place text cursor on the next name character position
	ld a, [wNamingScreenBufferLength]
	srl a ; /2
	ld d, a
	ld a, [wNamingScreenBufferMaxLength]
	srl a ; /2
	ld e, a
	ld a, d
	cp e
	jr nz, .name_not_full
	dec a
.name_not_full
	ld hl, wNamingScreenNamePosition
	add [hl] ; add name x position
	ld d, a
	ld h, 8
	ld l, d
	call HtimesL
	ld a, l
	add 8
	ld d, a ; x
	ld e, 24 ; y
	lb bc, $0, $0 ; attributes, tile number
	call SetOneObjectAttributes
.done
	pop hl
	pop de
	pop bc
	pop af
	ret

.asm_1b201
	ld a, [wNamingScreenBufferLength]
	sub $24
	jr c, .asm_1b212
	cp $24
	jr nz, .asm_1b20e
	dec a
	dec a
.asm_1b20e
	ld e, 32 ; y
	jr .asm_1b217
.asm_1b212
	ld a, [wNamingScreenBufferLength]
	ld e, 24 ; y
.asm_1b217
	sra a
	ld l, a
	ld h, 8
	call HtimesL
	ld a, l
	add 16
	ld d, a ; x
	lb bc, $0, $0
	call SetOneObjectAttributes
	jr .done

; load, to the first tile of v0Tiles0, the graphics for the
; blinking black square used in name input screens
LoadFullWidthTextCursorTile:
	ld hl, v0Tiles0
	ld de, .black_tile
	ld b, $00
.loop
	ld a, TILE_SIZE
	cp b
	ret z
	inc b
	ld a, [de]
	inc de
	ld [hli], a
	jr .loop

.black_tile
REPT TILE_SIZE
	db $ff
ENDR

; return carry if player selected "Done"
SelectKeyboardItem:
	ld a, [wNamingScreenCursorX]
	ld h, a
	ld a, [wNamingScreenCursorY]
	ld l, a
	call GetCharInfoFromPos
	inc hl
	inc hl
	ld e, [hl]
	inc hl
	ld a, [hli]
	ld d, a
	cp KEYBOARD_DONE
	jp z, .set_carry
	cp KEYBOARD_TOGGLE_KATAKANA
	jr nz, .asm_1b276
	ld a, [wNamingScreenMode]
	or a
	jr nz, .hiragana_mode
	ld a, NAME_MODE_KATAKANA
	jp .set_mode
.hiragana_mode
	xor a ; NAME_MODE_HIRAGANA
	jp .set_mode
.asm_1b276
	cp KEYBOARD_TOGGLE_UPPER_ABC
	jr nz, .asm_1b289
	ld a, [wNamingScreenMode]
	cp NAME_MODE_UPPER_ABC
	jr c, .not_upper_abc_mode
	ld a, NAME_MODE_KATAKANA
	jr .set_mode
.not_upper_abc_mode
	ld a, NAME_MODE_UPPER_ABC
	jr .set_mode
.asm_1b289
	cp KEYBOARD_TOGGLE_LOWER_ABC
	jr nz, .character_item
	ld a, [wNamingScreenMode]
	cp NAME_MODE_LOWER_ABC
	jr nz, .not_lower_abc_mode
	ld a, NAME_MODE_UPPER_ABC
	jr .set_mode
.not_lower_abc_mode
	ld a, NAME_MODE_LOWER_ABC
.set_mode
	ld [wNamingScreenMode], a
	call UpdateNamingScreenUI
	or a
	ret

.character_item
	ld a, [wNamingScreenMode]
	cp NAME_MODE_UPPER_ABC
	jr z, .upper_abc
	cp NAME_MODE_LOWER_ABC
	jr z, .lower_abc

	; handle diacritics
	ldfw bc, "゛"
	ld a, d
	cp b
	jr nz, .check_handakuten
	ld a, e
	cp c
	jr nz, .check_handakuten
	push hl
	ld hl, DakutenTable
	call GetDiacriticCharacter
	pop hl
	jr c, .no_carry
	jr .apply_diacritic
.check_handakuten
	ldfw bc, "゜"
	ld a, d
	cp b
	jr nz, .not_diacritic
	ld a, e
	cp c
	jr nz, .not_diacritic
	push hl
	ld hl, HandakutenTable
	call GetDiacriticCharacter
	pop hl
	jr c, .no_carry
.apply_diacritic
	; decrease length by 2
	ld a, [wNamingScreenBufferLength]
	dec a
	dec a
	ld [wNamingScreenBufferLength], a

	; get pointer to last character in buffer
	ld hl, wNamingScreenBuffer
	push de
	ld d, $00
	ld e, a
	add hl, de
	pop de
	ld a, [hl]
	jr .add_character

.not_diacritic
	ld a, d
	or a
	jr nz, .add_character
	ld a, [wNamingScreenMode]
	or a
	jr nz, .asm_1b2fb
	; NAME_MODE_HIRAGANA
	ld a, TX_HIRAGANA
	jr .add_character
.asm_1b2fb
	; NAME_MODE_KATAKANA
	ld a, TX_KATAKANA
	jr .add_character
.lower_abc
	inc hl
	inc hl
.upper_abc
	ld e, [hl]
	inc hl
	ld a, [hl]
	or a
	jr nz, .add_character
	ld a, TX_HIRAGANA

; a = TX_* constant
; e = character byte
.add_character
	ld d, a
	ld hl, wNamingScreenBufferLength
	ld a, [hl]
	ld c, a
	push hl
	ld hl, wNamingScreenBufferMaxLength
	cp [hl]
	pop hl
	jr nz, .not_last_character
	; overwrite last character
	ld hl, wNamingScreenBuffer
	dec hl
	dec hl
	; hl = wNamingScreenBuffer - 2
	jr .got_char_position
.not_last_character
	inc [hl]
	inc [hl]
	ld hl, wNamingScreenBuffer
.got_char_position
	ld b, $00
	add hl, bc
	ld [hl], d
	inc hl
	ld [hl], e
	inc hl
	ld [hl], TX_END
	call ProcessTextWithUnderbar
.no_carry
	or a
	ret

.set_carry:
	scf
	ret

; input:
;  hl = pointer to either DakutenTable or HandakutenTable
; output:
;  d = $00
;  e = new character byte
GetDiacriticCharacter:
	ld a, [wNamingScreenBufferLength]
	or a
	jr z, .set_carry
	dec a
	dec a
	push hl
	ld hl, wNamingScreenBuffer
	ld d, $00
	ld e, a
	add hl, de
	ld e, [hl] ; TX_*
	inc hl
	ld d, [hl] ; character
	ld a, TX_KATAKANA
	cp e
	jr nz, .not_katakana
	dec e ; change to hiragana
.not_katakana
	pop hl
.loop
	ld a, [hli]
	or a
	jr z, .set_carry ; not in table
	cp d
	jr nz, .next
	ld a, [hl]
	cp e
	jr nz, .next
	inc hl
	ld e, [hl] ; new character byte
	inc hl
	ld d, [hl] ; unused byte
	or a
	ret
.next
	inc hl
	inc hl
	inc hl
	jr .loop

.set_carry
	scf
	ret

; given the position of the current cursor,
; it returns the pointer to the proper information.
; h: position x.
; l: position y.
GetCharInfoFromPos:
	push de
	; (information index) = (x) * (height) + (y)
	ld e, l
	ld d, h
	ld a, [wNamingScreenNumRows]
	ld l, a
	call HtimesL
	ld a, l
	add e
	ld hl, KeyboardData
	pop de
	or a
	ret z
.loop
REPT 8
	inc hl
ENDR
	dec a
	jr nz, .loop
	ret

; a set of keyboard datum
; \1 = absolute y coordinate
; \2 = absolute x coordinate
; \3 = hiragana character (must coincide with the
;      katakana character with the same byte value)
; \4 = uppercase alphabet character
; \5 = lowercase alphabet character
MACRO kbchar
	db \1, \2
	PUSHC fullwidth
	REPT 3
		get_charset \3
		IF charset == TX_KATAKANA
			db \3, charset
		ELIF charset == TX_HIRAGANA
			db \3, 0
		ELSE
			dwfw \3
		ENDC
		SHIFT
	ENDR
	POPC
ENDM

; \1 = absolute y coordinate
; \2 = absolute x coordinate
; \3 = keyboard function (KEYBOARD_* constant)
; \4 = cursor x offset to right
; \5 = cursor x offset to left
MACRO kbitem
	db \1, \2
	db $01 ; unused
	db \3
	db \4, \5
	db \4, \5 ; unused
ENDM

KeyboardData:
	; col 0
	kbchar  4,  2, "あ", "A", "a"
	kbchar  6,  2, "い", "J", "j"
	kbchar  8,  2, "う", "S", "s"
	kbchar 10,  2, "え", "?", "@"
	kbchar 12,  2, "お", "4", ":"
	kbchar 14,  2, "ゃ", "ぃ", "<LIGHTNING>"
	kbitem 16,  2, KEYBOARD_TOGGLE_KATAKANA, 3, 2

	; col 1
	kbchar  4,  4, "か", "B", "b"
	kbchar  6,  4, "き", "K", "k"
	kbchar  8,  4, "く", "T", "t"
	kbchar 10,  4, "け", "&", "&"
	kbchar 12,  4, "こ", "5", ";"
	kbchar 14,  4, "ゅ", "ぅ", "<GRASS>"
	kbitem 16,  2, KEYBOARD_TOGGLE_KATAKANA, 2, 2

	; col 2
	kbchar  4,  6, "さ", "C", "c"
	kbchar  6,  6, "し", "L", "l"
	kbchar  8,  6, "す", "U", "u"
	kbchar 10,  6, "せ", "+", "/"
	kbchar 12,  6, "そ", "6", "_"
	kbchar 14,  6, "ょ", "ぇ", "<FIRE>"
	kbitem 16,  2, KEYBOARD_TOGGLE_KATAKANA, 2, 3

	; col 3
	kbchar  4,  8, "た", "D", "d"
	kbchar  6,  8, "ち", "M", "m"
	kbchar  8,  8, "つ", "V", "v"
	kbchar 10,  8, "て", "-", "*"
	kbchar 12,  8, "と", "7", "<"
	kbchar 14,  8, "っ", "ぉ", "<WATER>"
	kbitem 16,  7, KEYBOARD_TOGGLE_UPPER_ABC, 2, 3

	; col 4
	kbchar  4, 10, "な", "E", "e"
	kbchar  6, 10, "に", "N", "n"
	kbchar  8, 10, "ぬ", "W", "w"
	kbchar 10, 10, "ね", "・", "+"
	kbchar 12, 10, "の", "8", ">"
	kbchar 14, 10, "を", "ァ", "<PSYCHIC>"
	kbitem 16,  7, KEYBOARD_TOGGLE_UPPER_ABC, 2, 2

	; col 5
	kbchar  4, 12, "は", "F", "f"
	kbchar  6, 12, "ひ", "O", "о"
	kbchar  8, 12, "ふ", "X", "x"
	kbchar 10, 12, "へ", "0", "-"
	kbchar 12, 12, "ほ", "9", " "
	kbchar 14, 12, "゛", "ィ", "<FIGHTING>"
	kbitem 16, 12, KEYBOARD_TOGGLE_LOWER_ABC, 2, 2

	; col 6
	kbchar  4, 14, "ま", "G", "g"
	kbchar  6, 14, "み", "P", "p"
	kbchar  8, 14, "む", "Y", "y"
	kbchar 10, 14, "め", "1", "="
	kbchar 12, 14, "も", "<No>", " "
	kbchar 14, 14, "゜", "ゥ", "<COLORLESS>"
	kbitem 16, 12, KEYBOARD_TOGGLE_LOWER_ABC, 2, 2

	; col 7
	kbchar  4, 16, "や", "H", "h"
	kbchar  6, 16, "ゆ", "Q", "q"
	kbchar  8, 16, "よ", "Z", "z"
	kbchar 10, 16, "わ", "2", "・"
	kbchar 12, 16, "ん", "<Lv>", " "
	kbchar 14, 16, "ー", "ェ", "<RAINBOW>"
	kbitem 16, 16, KEYBOARD_DONE, 2, 2

	; col 8
	kbchar  4, 18, "ら", "I", "i"
	kbchar  6, 18, "り", "R", "r"
	kbchar  8, 18, "る", "!", " "
	kbchar 10, 18, "れ", "3", "ˍ"
	kbchar 12, 18, "ろ", "ぁ", " "
	kbchar 14, 18, " ", "ォ", " "
	kbitem 16, 16, KEYBOARD_DONE, 3, 3

	db  0,  0, $00, $00, $00, $00, $00, $00

MACRO diacritic
	PUSHC hiragana
	db \1, TX_HIRAGANA
	db \2, 0
	POPC
ENDM

DakutenTable:
	diacritic "か", "が" ; katakana カ, ガ
	diacritic "き", "ぎ" ; katakana キ, ギ
	diacritic "く", "ぐ" ; katakana ク, グ
	diacritic "け", "げ" ; katakana ケ, ゲ
	diacritic "こ", "ご" ; katakana コ, ゴ
	diacritic "さ", "ざ" ; katakana サ, ザ
	diacritic "し", "じ" ; katakana シ, ジ
	diacritic "す", "ず" ; katakana ス, ズ
	diacritic "せ", "ぜ" ; katakana セ, ゼ
	diacritic "そ", "ぞ" ; katakana ソ, ゾ
	diacritic "た", "だ" ; katakana タ, ダ
	diacritic "ち", "ぢ" ; katakana チ, ヂ
	diacritic "つ", "づ" ; katakana ツ, ヅ
	diacritic "て", "で" ; katakana テ, デ
	diacritic "と", "ど" ; katakana ト, ド
	diacritic "は", "ば" ; katakana ハ, バ
	diacritic "ひ", "び" ; katakana ヒ, ビ
	diacritic "ふ", "ぶ" ; katakana フ, ブ
	diacritic "へ", "べ" ; katakana ヘ, ベ
	diacritic "ほ", "ぼ" ; katakana ホ, ボ
	diacritic "ぱ", "ば" ; katakana パ, バ
	diacritic "ぴ", "び" ; katakana ピ, ビ
	diacritic "ぷ", "ぶ" ; katakana プ, ブ
	diacritic "ぺ", "べ" ; katakana ペ, ベ
	diacritic "ぽ", "ぼ" ; katakana ポ, ボ
	dw 0 ; end

HandakutenTable:
	diacritic "は", "ぱ" ; katakana ハ, パ
	diacritic "ひ", "ぴ" ; katakana ヒ, ピ
	diacritic "ふ", "ぷ" ; katakana フ, プ
	diacritic "へ", "ぺ" ; katakana ヘ, ペ
	diacritic "ほ", "ぽ" ; katakana ホ, ポ
	diacritic "ば", "ぱ" ; katakana バ, パ
	diacritic "び", "ぴ" ; katakana ビ, ピ
	diacritic "ぶ", "ぷ" ; katakana ブ, プ
	diacritic "べ", "ぺ" ; katakana ベ, ペ
	diacritic "ぼ", "ぽ" ; katakana ボ, ポ
	dw 0 ; end
; 0x1b613

SECTION "Bank 6@78f1", ROMX[$78f1], BANK[$6]

Func_1b8f1:
	ld a, b
	or a
	ret z
.asm_1b8f4
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .asm_1b8f4
	ret
; 0x1b8fb
