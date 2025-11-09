GRIslandPlayerPaths:
	dw .GRAirportPaths           ; OWMAP_GR_AIRPORT
	dw .IshiharasVillaPaths      ; OWMAP_ISHIHARAS_VILLA
	dw .GameCenterPaths          ; OWMAP_GAME_CENTER
	dw .SealedFortPaths          ; OWMAP_SEALED_FORT
	dw .GRChallengeHallPaths     ; OWMAP_GR_CHALLENGE_HALL
	dw .GRGrassFortPaths         ; OWMAP_GR_GRASS_FORT
	dw .GRLightningFortPaths     ; OWMAP_GR_LIGHTNING_FORT
	dw .GRFireFortPaths          ; OWMAP_GR_FIRE_FORT
	dw .GRWaterFortPaths         ; OWMAP_GR_WATER_FORT
	dw .GRFightingFortPaths      ; OWMAP_GR_FIGHTING_FORT
	dw .GRPsychicStrongholdPaths ; OWMAP_GR_PSYCHIC_STRONGHOLD
	dw .ColorlessAltarPaths      ; OWMAP_COLORLESS_ALTAR
	dw .GRCastlePaths            ; OWMAP_GR_CASTLE

.GRAirportPaths:
	dw NULL
	dw .GRAirport_IshiharasVilla
	dw .GRAirport_GameCenter
	dw .GRAirport_SealedFort
	dw .GRAirport_GRChallengeHall
	dw .GRAirport_GRGrassFort
	dw .GRAirport_GRLightningFort
	dw .GRAirport_GRFireFort
	dw .GRAirport_GRWaterFort
	dw .GRAirport_GRFightingFort
	dw .GRAirport_GRPsychicStronghold
	dw .GRAirport_ColorlessAltar
	dw .GRAirport_GRCastle

.IshiharasVillaPaths:
	dw .IshiharasVilla_GRAirport
	dw NULL
	dw .IshiharasVilla_GameCenter
	dw .IshiharasVilla_SealedFort
	dw .IshiharasVilla_GRChallengeHall
	dw .IshiharasVilla_GRGrassFort
	dw .IshiharasVilla_GRLightningFort
	dw .IshiharasVilla_GRFireFort
	dw .IshiharasVilla_GRWaterFort
	dw .IshiharasVilla_GRFightingFort
	dw .IshiharasVilla_GRPsychicStronghold
	dw .IshiharasVilla_ColorlessAltar
	dw .IshiharasVilla_GRCastle

.GameCenterPaths:
	dw .GameCenter_GRAirport
	dw .GameCenter_IshiharasVilla
	dw NULL
	dw .GameCenter_SealedFort
	dw .GameCenter_GRChallengeHall
	dw .GameCenter_GRGrassFort
	dw .GameCenter_GRLightningFort
	dw .GameCenter_GRFireFort
	dw .GameCenter_GRWaterFort
	dw .GameCenter_GRFightingFort
	dw .GameCenter_GRPsychicStronghold
	dw .GameCenter_ColorlessAltar
	dw .GameCenter_GRCastle

.SealedFortPaths:
	dw .SealedFort_GRAirport
	dw .SealedFort_IshiharasVilla
	dw .SealedFort_GameCenter
	dw NULL
	dw .SealedFort_GRChallengeHall
	dw .SealedFort_GRGrassFort
	dw .SealedFort_GRLightningFort
	dw .SealedFort_GRFireFort
	dw .SealedFort_GRWaterFort
	dw .SealedFort_GRFightingFort
	dw .SealedFort_GRPsychicStronghold
	dw .SealedFort_ColorlessAltar
	dw .SealedFort_GRCastle

.GRChallengeHallPaths:
	dw .GRChallengeHall_GRAirport
	dw .GRChallengeHall_IshiharasVilla
	dw .GRChallengeHall_GameCenter
	dw .GRChallengeHall_SealedFort
	dw NULL
	dw .GRChallengeHall_GRGrassFort
	dw .GRChallengeHall_GRLightningFort
	dw .GRChallengeHall_GRFireFort
	dw .GRChallengeHall_GRWaterFort
	dw .GRChallengeHall_GRFightingFort
	dw .GRChallengeHall_GRPsychicStronghold
	dw .GRChallengeHall_ColorlessAltar
	dw .GRChallengeHall_GRCastle

.GRGrassFortPaths:
	dw .GRGrassFort_GRAirport
	dw .GRGrassFort_IshiharasVilla
	dw .GRGrassFort_GameCenter
	dw .GRGrassFort_SealedFort
	dw .GRGrassFort_GRChallengeHall
	dw NULL
	dw .GRGrassFort_GRLightningFort
	dw .GRGrassFort_GRFireFort
	dw .GRGrassFort_GRWaterFort
	dw .GRGrassFort_GRFightingFort
	dw .GRGrassFort_GRPsychicStronghold
	dw .GRGrassFort_ColorlessAltar
	dw .GRGrassFort_GRCastle

.GRLightningFortPaths:
	dw .GRLightningFort_GRAirport
	dw .GRLightningFort_IshiharasVilla
	dw .GRLightningFort_GameCenter
	dw .GRLightningFort_SealedFort
	dw .GRLightningFort_GRChallengeHall
	dw .GRLightningFort_GRGrassFort
	dw NULL
	dw .GRLightningFort_GRFireFort
	dw .GRLightningFort_GRWaterFort
	dw .GRLightningFort_GRFightingFort
	dw .GRLightningFort_GRPsychicStronghold
	dw .GRLightningFort_ColorlessAltar
	dw .GRLightningFort_GRCastle

.GRFireFortPaths:
	dw .GRFireFort_GRAirport
	dw .GRFireFort_IshiharasVilla
	dw .GRFireFort_GameCenter
	dw .GRFireFort_SealedFort
	dw .GRFireFort_GRChallengeHall
	dw .GRFireFort_GRGrassFort
	dw .GRFireFort_GRLightningFort
	dw NULL
	dw .GRFireFort_GRWaterFort
	dw .GRFireFort_GRFightingFort
	dw .GRFireFort_GRPsychicStronghold
	dw .GRFireFort_ColorlessAltar
	dw .GRFireFort_GRCastle

.GRWaterFortPaths:
	dw .GRWaterFort_GRAirport
	dw .GRWaterFort_IshiharasVilla
	dw .GRWaterFort_GameCenter
	dw .GRWaterFort_SealedFort
	dw .GRWaterFort_GRChallengeHall
	dw .GRWaterFort_GRGrassFort
	dw .GRWaterFort_GRLightningFort
	dw .GRWaterFort_GRFireFort
	dw NULL
	dw .GRWaterFort_GRFightingFort
	dw .GRWaterFort_GRPsychicStronghold
	dw .GRWaterFort_ColorlessAltar
	dw .GRWaterFort_GRCastle

.GRFightingFortPaths:
	dw .GRFightingFort_GRAirport
	dw .GRFightingFort_IshiharasVilla
	dw .GRFightingFort_GameCenter
	dw .GRFightingFort_SealedFort
	dw .GRFightingFort_GRChallengeHall
	dw .GRFightingFort_GRGrassFort
	dw .GRFightingFort_GRLightningFort
	dw .GRFightingFort_GRFireFort
	dw .GRFightingFort_GRWaterFort
	dw NULL
	dw .GRFightingFort_GRPsychicStronghold
	dw .GRFightingFort_ColorlessAltar
	dw .GRFightingFort_GRCastle

.GRPsychicStrongholdPaths:
	dw .GRPsychicStronghold_GRAirport
	dw .GRPsychicStronghold_IshiharasVilla
	dw .GRPsychicStronghold_GameCenter
	dw .GRPsychicStronghold_SealedFort
	dw .GRPsychicStronghold_GRChallengeHall
	dw .GRPsychicStronghold_GRGrassFort
	dw .GRPsychicStronghold_GRLightningFort
	dw .GRPsychicStronghold_GRFireFort
	dw .GRPsychicStronghold_GRWaterFort
	dw .GRPsychicStronghold_GRFightingFort
	dw NULL
	dw .GRPsychicStronghold_ColorlessAltar
	dw .GRPsychicStronghold_GRCastle

.ColorlessAltarPaths:
	dw .ColorlessAltar_GRAirport
	dw .ColorlessAltar_IshiharasVilla
	dw .ColorlessAltar_GameCenter
	dw .ColorlessAltar_SealedFort
	dw .ColorlessAltar_GRChallengeHall
	dw .ColorlessAltar_GRGrassFort
	dw .ColorlessAltar_GRLightningFort
	dw .ColorlessAltar_GRFireFort
	dw .ColorlessAltar_GRWaterFort
	dw .ColorlessAltar_GRFightingFort
	dw .ColorlessAltar_GRPsychicStronghold
	dw NULL
	dw .ColorlessAltar_GRCastle

.GRCastlePaths:
	dw .GRCastle_GRAirport
	dw .GRCastle_IshiharasVilla
	dw .GRCastle_GameCenter
	dw .GRCastle_SealedFort
	dw .GRCastle_GRChallengeHall
	dw .GRCastle_GRGrassFort
	dw .GRCastle_GRLightningFort
	dw .GRCastle_GRFireFort
	dw .GRCastle_GRWaterFort
	dw .GRCastle_GRFightingFort
	dw .GRCastle_GRPsychicStronghold
	dw .GRCastle_ColorlessAltar
	dw NULL

.GRAirport_IshiharasVilla:
	db $24, $98
	db $3c, $98
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $76, $6a
	db $84, $44
	db $ff, $02
	db $84, $30
	db $84, $24
	db $84, $14
	db $00, $00
	db $ff, $ff ; end

.GRAirport_GameCenter:
	db $34, $b0
	db $00, $00
	db $ff, $ff ; end

.GRAirport_SealedFort:
	db $14, $98
	db $14, $8c
	db $00, $00
	db $ff, $ff ; end

.GRAirport_GRChallengeHall:
	db $24, $98
	db $3c, $98
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $00, $00
	db $ff, $ff ; end

.GRAirport_GRGrassFort:
	db $24, $98
	db $3c, $98
	db $00, $00
	db $ff, $ff ; end

.GRAirport_GRLightningFort:
	db $24, $98
	db $3c, $98
	db $3c, $78
	db $54, $78
	db $00, $00
	db $ff, $01
	db $ff, $ff ; end

.GRAirport_GRFireFort:
	db $24, $98
	db $3c, $98
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $5c, $4c
	db $5c, $34
	db $00, $00
	db $ff, $ff ; end

.GRAirport_GRWaterFort:
	db $24, $98
	db $3c, $98
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $84, $78
	db $00, $00
	db $ff, $ff ; end

.GRAirport_GRFightingFort:
	db $24, $98
	db $3c, $98
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $76, $6a
	db $00, $00
	db $ff, $02
	db $ff, $ff ; end

.GRAirport_GRPsychicStronghold:
	db $24, $98
	db $3c, $98
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $76, $6a
	db $84, $44
	db $ff, $02
	db $84, $30
	db $00, $00
	db $ff, $ff ; end

.GRAirport_ColorlessAltar:
	db $24, $98
	db $3c, $98
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $76, $6a
	db $84, $44
	db $ff, $02
	db $84, $30
	db $98, $30
	db $9c, $38
	db $ac, $38
	db $00, $00
	db $ff, $ff ; end

.GRAirport_GRCastle:
	db $24, $98
	db $3c, $98
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $76, $6a
	db $84, $44
	db $ff, $02
	db $84, $30
	db $84, $24
	db $00, $00
	db $ff, $ff ; end

.IshiharasVilla_GRAirport:
	db $84, $14
	db $84, $24
	db $84, $44
	db $76, $6a
	db $ff, $01
	db $54, $78
	db $3c, $78
	db $3c, $88
	db $ff, $00
	db $3c, $98
	db $24, $98
	db $00, $00
	db $ff, $ff ; end

.IshiharasVilla_GameCenter:
	db $84, $14
	db $84, $24
	db $84, $44
	db $76, $6a
	db $ff, $01
	db $54, $78
	db $3c, $78
	db $3c, $88
	db $ff, $00
	db $3c, $98
	db $24, $98
	db $24, $b0
	db $34, $b0
	db $00, $00
	db $ff, $ff ; end

.IshiharasVilla_SealedFort:
	db $84, $14
	db $84, $24
	db $84, $44
	db $76, $6a
	db $ff, $01
	db $54, $78
	db $3c, $78
	db $3c, $88
	db $ff, $00
	db $3c, $98
	db $24, $98
	db $14, $98
	db $14, $8c
	db $00, $00
	db $ff, $ff ; end

.IshiharasVilla_GRChallengeHall:
	db $84, $14
	db $84, $24
	db $84, $44
	db $00, $00
	db $ff, $01
	db $ff, $ff ; end

.IshiharasVilla_GRGrassFort:
	db $84, $14
	db $84, $24
	db $84, $44
	db $76, $6a
	db $ff, $01
	db $54, $78
	db $3c, $78
	db $00, $00
	db $ff, $00
	db $ff, $ff ; end

.IshiharasVilla_GRLightningFort:
	db $84, $14
	db $84, $24
	db $84, $44
	db $76, $6a
	db $ff, $01
	db $00, $00
	db $ff, $ff ; end

.IshiharasVilla_GRFireFort:
	db $84, $14
	db $84, $24
	db $84, $44
	db $5c, $4c
	db $ff, $01
	db $5c, $34
	db $00, $00
	db $ff, $ff ; end

.IshiharasVilla_GRWaterFort:
	db $84, $14
	db $84, $24
	db $84, $44
	db $76, $6a
	db $ff, $01
	db $74, $78
	db $84, $78
	db $00, $00
	db $ff, $ff ; end

.IshiharasVilla_GRFightingFort:
	db $84, $14
	db $84, $24
	db $84, $44
	db $00, $00
	db $ff, $ff ; end

.IshiharasVilla_GRPsychicStronghold:
	db $84, $14
	db $84, $24
	db $00, $00
	db $ff, $ff ; end

.IshiharasVilla_ColorlessAltar:
	db $84, $24
	db $9c, $38
	db $ac, $38
	db $00, $00
	db $ff, $ff ; end

.IshiharasVilla_GRCastle:
	db $84, $14
	db $84, $24
	db $00, $00
	db $ff, $ff ; end

.GameCenter_GRAirport:
	db $34, $b0
	db $00, $00
	db $ff, $ff ; end

.GameCenter_IshiharasVilla:
	db $34, $b0
	db $24, $b0
	db $24, $98
	db $3c, $98
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $76, $6a
	db $84, $44
	db $ff, $02
	db $84, $24
	db $84, $14
	db $00, $00
	db $ff, $ff ; end

.GameCenter_SealedFort:
	db $34, $b0
	db $24, $b0
	db $14, $98
	db $14, $8c
	db $00, $00
	db $ff, $ff ; end

.GameCenter_GRChallengeHall:
	db $34, $b0
	db $24, $b0
	db $24, $98
	db $3c, $98
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $00, $00
	db $ff, $ff ; end

.GameCenter_GRGrassFort:
	db $34, $b0
	db $24, $b0
	db $24, $98
	db $3c, $98
	db $00, $00
	db $ff, $ff ; end

.GameCenter_GRLightningFort:
	db $34, $b0
	db $24, $b0
	db $24, $98
	db $3c, $98
	db $3c, $78
	db $54, $78
	db $00, $00
	db $ff, $01
	db $ff, $ff ; end

.GameCenter_GRFireFort:
	db $34, $b0
	db $24, $b0
	db $24, $98
	db $3c, $98
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $5c, $4c
	db $5c, $34
	db $00, $00
	db $ff, $ff ; end

.GameCenter_GRWaterFort:
	db $34, $b0
	db $24, $b0
	db $24, $98
	db $3c, $98
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $84, $78
	db $00, $00
	db $ff, $ff ; end

.GameCenter_GRFightingFort:
	db $34, $b0
	db $24, $b0
	db $24, $98
	db $3c, $98
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $76, $6a
	db $00, $00
	db $ff, $02
	db $ff, $ff ; end

.GameCenter_GRPsychicStronghold:
	db $34, $b0
	db $24, $b0
	db $24, $98
	db $3c, $98
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $76, $6a
	db $84, $44
	db $ff, $02
	db $84, $30
	db $00, $00
	db $ff, $ff ; end

.GameCenter_ColorlessAltar:
	db $34, $b0
	db $24, $b0
	db $24, $98
	db $3c, $98
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $76, $6a
	db $84, $44
	db $ff, $02
	db $84, $30
	db $98, $30
	db $9c, $38
	db $ac, $38
	db $00, $00
	db $ff, $ff ; end

.GameCenter_GRCastle:
	db $34, $b0
	db $24, $b0
	db $24, $98
	db $3c, $98
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $76, $6a
	db $84, $44
	db $ff, $02
	db $84, $30
	db $84, $24
	db $00, $00
	db $ff, $ff ; end

.SealedFort_GRAirport:
	db $14, $8c
	db $14, $98
	db $00, $00
	db $ff, $ff ; end

.SealedFort_IshiharasVilla:
	db $14, $8c
	db $14, $98
	db $24, $98
	db $3c, $98
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $76, $6a
	db $84, $44
	db $ff, $02
	db $84, $24
	db $84, $14
	db $00, $00
	db $ff, $ff ; end

.SealedFort_GameCenter:
	db $14, $8c
	db $14, $98
	db $24, $b0
	db $34, $b0
	db $00, $00
	db $ff, $ff ; end

.SealedFort_GRChallengeHall:
	db $14, $8c
	db $14, $98
	db $24, $98
	db $3c, $98
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $00, $00
	db $ff, $ff ; end

.SealedFort_GRGrassFort:
	db $14, $8c
	db $14, $98
	db $24, $98
	db $3c, $98
	db $00, $00
	db $ff, $ff ; end

.SealedFort_GRLightningFort:
	db $14, $8c
	db $14, $98
	db $24, $98
	db $3c, $98
	db $3c, $78
	db $54, $78
	db $00, $00
	db $ff, $01
	db $ff, $ff ; end

.SealedFort_GRFireFort:
	db $14, $8c
	db $14, $98
	db $24, $98
	db $3c, $98
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $5c, $4c
	db $5c, $34
	db $00, $00
	db $ff, $ff ; end

.SealedFort_GRWaterFort:
	db $14, $8c
	db $14, $98
	db $24, $98
	db $3c, $98
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $84, $78
	db $00, $00
	db $ff, $ff ; end

.SealedFort_GRFightingFort:
	db $14, $8c
	db $14, $98
	db $24, $98
	db $3c, $98
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $76, $6a
	db $00, $00
	db $ff, $02
	db $ff, $ff ; end

.SealedFort_GRPsychicStronghold:
	db $14, $8c
	db $14, $98
	db $24, $98
	db $3c, $98
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $76, $6a
	db $84, $44
	db $ff, $02
	db $84, $30
	db $00, $00
	db $ff, $ff ; end

.SealedFort_ColorlessAltar:
	db $14, $8c
	db $14, $98
	db $24, $98
	db $3c, $98
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $76, $6a
	db $84, $44
	db $ff, $02
	db $84, $30
	db $98, $30
	db $9c, $38
	db $ac, $38
	db $00, $00
	db $ff, $ff ; end

.SealedFort_GRCastle:
	db $14, $8c
	db $14, $98
	db $24, $98
	db $3c, $98
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $76, $6a
	db $84, $44
	db $ff, $02
	db $84, $30
	db $84, $24
	db $00, $00
	db $ff, $ff ; end

.GRChallengeHall_GRAirport:
	db $54, $78
	db $3c, $78
	db $3c, $88
	db $ff, $00
	db $3c, $98
	db $24, $98
	db $00, $00
	db $ff, $ff ; end

.GRChallengeHall_IshiharasVilla:
	db $84, $44
	db $ff, $02
	db $84, $24
	db $84, $14
	db $00, $00
	db $ff, $ff ; end

.GRChallengeHall_GameCenter:
	db $54, $78
	db $3c, $78
	db $3c, $88
	db $ff, $00
	db $3c, $98
	db $24, $98
	db $24, $b0
	db $34, $b0
	db $00, $00
	db $ff, $ff ; end

.GRChallengeHall_SealedFort:
	db $54, $78
	db $3c, $78
	db $3c, $88
	db $ff, $00
	db $3c, $98
	db $24, $98
	db $14, $98
	db $14, $8c
	db $00, $00
	db $ff, $ff ; end

.GRChallengeHall_GRGrassFort:
	db $54, $78
	db $3c, $78
	db $00, $00
	db $ff, $00
	db $ff, $ff ; end

.GRChallengeHall_GRFireFort:
	db $5c, $4c
	db $5c, $34
	db $00, $00
	db $ff, $ff ; end

.GRChallengeHall_GRWaterFort:
	db $74, $78
	db $84, $78
	db $00, $00
	db $ff, $ff ; end

.GRChallengeHall_GRFightingFort:
	db $00, $00
	db $ff, $02
	db $ff, $ff ; end

.GRChallengeHall_GRPsychicStronghold:
	db $84, $44
	db $ff, $02
	db $84, $30
	db $00, $00
	db $ff, $ff ; end

.GRChallengeHall_ColorlessAltar:
	db $84, $44
	db $ff, $02
	db $84, $30
	db $98, $30
	db $9c, $38
	db $ac, $38
	db $00, $00
	db $ff, $ff ; end

.GRChallengeHall_GRCastle:
	db $84, $44
	db $ff, $02
	db $84, $30
	db $84, $24
	db $00, $00
	db $ff, $ff ; end

.GRGrassFort_GRAirport:
	db $3c, $98
	db $24, $98
	db $00, $00
	db $ff, $ff ; end

.GRGrassFort_IshiharasVilla:
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $76, $6a
	db $84, $44
	db $ff, $02
	db $84, $24
	db $84, $14
	db $00, $00
	db $ff, $ff ; end

.GRGrassFort_GameCenter:
	db $3c, $98
	db $24, $98
	db $24, $b0
	db $34, $b0
	db $00, $00
	db $ff, $ff ; end

.GRGrassFort_SealedFort:
	db $3c, $98
	db $24, $98
	db $14, $98
	db $14, $8c
	db $00, $00
	db $ff, $ff ; end

.GRGrassFort_GRChallengeHall:
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $00, $00
	db $ff, $ff ; end

.GRGrassFort_GRLightningFort:
	db $3c, $78
	db $54, $78
	db $00, $00
	db $ff, $01
	db $ff, $ff ; end

.GRGrassFort_GRFireFort:
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $5c, $4c
	db $5c, $34
	db $00, $00
	db $ff, $ff ; end

.GRGrassFort_GRWaterFort:
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $84, $78
	db $00, $00
	db $ff, $ff ; end

.GRGrassFort_GRFightingFort:
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $76, $6a
	db $00, $00
	db $ff, $02
	db $ff, $ff ; end

.GRGrassFort_GRPsychicStronghold:
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $76, $6a
	db $84, $44
	db $ff, $02
	db $84, $30
	db $00, $00
	db $ff, $ff ; end

.GRGrassFort_ColorlessAltar:
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $76, $6a
	db $84, $44
	db $ff, $02
	db $84, $30
	db $98, $30
	db $9c, $38
	db $ac, $38
	db $00, $00
	db $ff, $ff ; end

.GRGrassFort_GRCastle:
	db $3c, $78
	db $54, $78
	db $ff, $01
	db $76, $6a
	db $84, $44
	db $ff, $02
	db $84, $30
	db $84, $24
	db $00, $00
	db $ff, $ff ; end

.GRLightningFort_GRAirport:
	db $54, $78
	db $3c, $78
	db $3c, $88
	db $ff, $00
	db $3c, $98
	db $24, $98
	db $00, $00
	db $ff, $ff ; end

.GRLightningFort_IshiharasVilla:
	db $76, $6a
	db $84, $44
	db $ff, $02
	db $84, $24
	db $00, $00
	db $ff, $ff ; end

.GRLightningFort_GameCenter:
	db $54, $78
	db $3c, $78
	db $3c, $88
	db $ff, $00
	db $3c, $98
	db $24, $98
	db $24, $b0
	db $34, $b0
	db $00, $00
	db $ff, $ff ; end

.GRLightningFort_SealedFort:
	db $54, $78
	db $3c, $78
	db $3c, $88
	db $ff, $00
	db $3c, $98
	db $24, $98
	db $14, $98
	db $14, $8c
	db $00, $00
	db $ff, $ff ; end

.GRLightningFort_GRGrassFort:
	db $54, $78
	db $3c, $78
	db $00, $00
	db $ff, $00
	db $ff, $ff ; end

.GRLightningFort_GRFireFort:
	db $5c, $4c
	db $5c, $34
	db $00, $00
	db $ff, $ff ; end

.GRLightningFort_GRWaterFort:
	db $84, $78
	db $00, $00
	db $ff, $ff ; end

.GRLightningFort_GRFightingFort:
	db $76, $6a
	db $00, $00
	db $ff, $02
	db $ff, $ff ; end

.GRLightningFort_GRPsychicStronghold:
	db $76, $6a
	db $84, $44
	db $ff, $02
	db $84, $30
	db $00, $00
	db $ff, $ff ; end

.GRLightningFort_ColorlessAltar:
	db $76, $6a
	db $84, $44
	db $ff, $02
	db $84, $30
	db $98, $30
	db $9c, $38
	db $ac, $38
	db $00, $00
	db $ff, $ff ; end

.GRLightningFort_GRCastle:
	db $76, $6a
	db $84, $44
	db $ff, $02
	db $84, $30
	db $84, $24
	db $00, $00
	db $ff, $ff ; end

.GRFireFort_GRAirport:
	db $5c, $34
	db $5c, $4c
	db $54, $78
	db $3c, $78
	db $3c, $88
	db $ff, $00
	db $3c, $98
	db $24, $98
	db $00, $00
	db $ff, $ff ; end

.GRFireFort_IshiharasVilla:
	db $5c, $34
	db $5c, $4c
	db $84, $44
	db $ff, $02
	db $84, $24
	db $84, $14
	db $00, $00
	db $ff, $ff ; end

.GRFireFort_GameCenter:
	db $5c, $34
	db $5c, $4c
	db $54, $78
	db $3c, $78
	db $3c, $88
	db $ff, $00
	db $3c, $98
	db $24, $98
	db $24, $b0
	db $34, $b0
	db $00, $00
	db $ff, $ff ; end

.GRFireFort_SealedFort:
	db $5c, $34
	db $5c, $4c
	db $54, $78
	db $3c, $78
	db $3c, $88
	db $ff, $00
	db $3c, $98
	db $24, $98
	db $14, $98
	db $14, $8c
	db $00, $00
	db $ff, $ff ; end

.GRFireFort_GRChallengeHall:
	db $5c, $34
	db $5c, $4c
	db $00, $00
	db $ff, $ff ; end

.GRFireFort_GRGrassFort:
	db $5c, $34
	db $5c, $4c
	db $54, $78
	db $3c, $78
	db $00, $00
	db $ff, $00
	db $ff, $ff ; end

.GRFireFort_GRLightningFort:
	db $5c, $34
	db $5c, $4c
	db $00, $00
	db $ff, $ff ; end

.GRFireFort_GRWaterFort:
	db $5c, $34
	db $5c, $4c
	db $54, $64
	db $74, $78
	db $84, $78
	db $00, $00
	db $ff, $ff ; end

.GRFireFort_GRFightingFort:
	db $5c, $34
	db $5c, $4c
	db $00, $00
	db $ff, $02
	db $ff, $ff ; end

.GRFireFort_GRPsychicStronghold:
	db $5c, $34
	db $5c, $4c
	db $84, $44
	db $ff, $02
	db $84, $30
	db $00, $00
	db $ff, $ff ; end

.GRFireFort_ColorlessAltar:
	db $5c, $34
	db $5c, $4c
	db $84, $44
	db $ff, $02
	db $84, $30
	db $98, $30
	db $9c, $38
	db $ac, $38
	db $00, $00
	db $ff, $ff ; end

.GRFireFort_GRCastle:
	db $5c, $34
	db $5c, $4c
	db $84, $44
	db $ff, $02
	db $84, $30
	db $84, $24
	db $00, $00
	db $ff, $ff ; end

.GRWaterFort_GRAirport:
	db $84, $78
	db $54, $78
	db $3c, $78
	db $3c, $88
	db $ff, $00
	db $3c, $98
	db $24, $98
	db $00, $00
	db $ff, $ff ; end

.GRWaterFort_IshiharasVilla:
	db $84, $78
	db $74, $78
	db $84, $44
	db $ff, $02
	db $84, $24
	db $84, $14
	db $00, $00
	db $ff, $ff ; end

.GRWaterFort_GameCenter:
	db $84, $78
	db $54, $78
	db $3c, $78
	db $3c, $88
	db $ff, $00
	db $3c, $98
	db $24, $98
	db $24, $b0
	db $34, $b0
	db $00, $00
	db $ff, $ff ; end

.GRWaterFort_SealedFort:
	db $84, $78
	db $54, $78
	db $3c, $78
	db $3c, $88
	db $ff, $00
	db $3c, $98
	db $24, $98
	db $14, $98
	db $14, $8c
	db $00, $00
	db $ff, $ff ; end

.GRWaterFort_GRChallengeHall:
	db $84, $78
	db $74, $78
	db $00, $00
	db $ff, $ff ; end

.GRWaterFort_GRGrassFort:
	db $84, $78
	db $54, $78
	db $3c, $78
	db $00, $00
	db $ff, $00
	db $ff, $ff ; end

.GRWaterFort_GRLightningFort:
	db $84, $78
	db $74, $78
	db $00, $00
	db $ff, $ff ; end

.GRWaterFort_GRFireFort:
	db $84, $78
	db $74, $78
	db $54, $64
	db $5c, $4c
	db $5c, $34
	db $00, $00
	db $ff, $ff ; end

.GRWaterFort_GRFightingFort:
	db $84, $78
	db $74, $78
	db $00, $00
	db $ff, $02
	db $ff, $ff ; end

.GRWaterFort_GRPsychicStronghold:
	db $84, $78
	db $74, $78
	db $84, $44
	db $ff, $02
	db $84, $30
	db $00, $00
	db $ff, $ff ; end

.GRWaterFort_ColorlessAltar:
	db $84, $78
	db $74, $78
	db $84, $44
	db $ff, $02
	db $84, $30
	db $98, $30
	db $9c, $38
	db $ac, $38
	db $00, $00
	db $ff, $ff ; end

.GRWaterFort_GRCastle:
	db $84, $78
	db $74, $78
	db $84, $44
	db $ff, $02
	db $84, $30
	db $84, $24
	db $00, $00
	db $ff, $ff ; end

.GRFightingFort_GRAirport:
	db $76, $6a
	db $ff, $01
	db $54, $78
	db $3c, $78
	db $3c, $88
	db $ff, $00
	db $3c, $98
	db $24, $98
	db $00, $00
	db $ff, $ff ; end

.GRFightingFort_IshiharasVilla:
	db $84, $44
	db $84, $24
	db $84, $14
	db $00, $00
	db $ff, $ff ; end

.GRFightingFort_GameCenter:
	db $76, $6a
	db $ff, $01
	db $54, $78
	db $3c, $78
	db $3c, $88
	db $ff, $00
	db $3c, $98
	db $24, $98
	db $24, $b0
	db $34, $b0
	db $00, $00
	db $ff, $ff ; end

.GRFightingFort_SealedFort:
	db $76, $6a
	db $ff, $01
	db $54, $78
	db $3c, $78
	db $3c, $88
	db $ff, $00
	db $3c, $98
	db $24, $98
	db $14, $98
	db $14, $8c
	db $00, $00
	db $ff, $ff ; end

.GRFightingFort_GRChallengeHall:
	db $00, $00
	db $ff, $01
	db $ff, $ff ; end

.GRFightingFort_GRGrassFort:
	db $76, $6a
	db $ff, $01
	db $54, $78
	db $3c, $78
	db $00, $00
	db $ff, $00
	db $ff, $ff ; end

.GRFightingFort_GRLightningFort:
	db $76, $6a
	db $ff, $01
	db $00, $00
	db $ff, $ff ; end

.GRFightingFort_GRFireFort:
	db $5c, $4c
	db $ff, $01
	db $5c, $34
	db $00, $00
	db $ff, $ff ; end

.GRFightingFort_GRWaterFort:
	db $76, $6a
	db $ff, $01
	db $74, $78
	db $84, $78
	db $00, $00
	db $ff, $ff ; end

.GRFightingFort_GRPsychicStronghold:
	db $84, $44
	db $84, $30
	db $00, $00
	db $ff, $ff ; end

.GRFightingFort_ColorlessAltar:
	db $84, $44
	db $84, $30
	db $98, $30
	db $9c, $38
	db $ac, $38
	db $00, $00
	db $ff, $ff ; end

.GRFightingFort_GRCastle:
	db $84, $44
	db $84, $30
	db $84, $24
	db $00, $00
	db $ff, $ff ; end

.GRPsychicStronghold_GRAirport:
	db $84, $30
	db $84, $44
	db $76, $6a
	db $ff, $01
	db $54, $78
	db $3c, $78
	db $3c, $88
	db $ff, $00
	db $3c, $98
	db $24, $98
	db $00, $00
	db $ff, $ff ; end

.GRPsychicStronghold_IshiharasVilla:
	db $84, $24
	db $84, $14
	db $00, $00
	db $ff, $ff ; end

.GRPsychicStronghold_GameCenter:
	db $84, $30
	db $84, $44
	db $76, $6a
	db $ff, $01
	db $54, $78
	db $3c, $78
	db $3c, $88
	db $ff, $00
	db $3c, $98
	db $24, $98
	db $24, $b0
	db $34, $b0
	db $00, $00
	db $ff, $ff ; end

.GRPsychicStronghold_SealedFort:
	db $84, $30
	db $84, $44
	db $76, $6a
	db $ff, $01
	db $54, $78
	db $3c, $78
	db $3c, $88
	db $ff, $00
	db $3c, $98
	db $24, $98
	db $14, $98
	db $14, $8c
	db $00, $00
	db $ff, $ff ; end

.GRPsychicStronghold_GRChallengeHall:
	db $84, $30
	db $84, $44
	db $00, $00
	db $ff, $01
	db $ff, $ff ; end

.GRPsychicStronghold_GRGrassFort:
	db $84, $30
	db $84, $44
	db $76, $6a
	db $ff, $01
	db $54, $78
	db $3c, $78
	db $00, $00
	db $ff, $00
	db $ff, $ff ; end

.GRPsychicStronghold_GRLightningFort:
	db $84, $30
	db $84, $44
	db $76, $6a
	db $ff, $01
	db $00, $00
	db $ff, $ff ; end

.GRPsychicStronghold_GRFireFort:
	db $84, $30
	db $84, $44
	db $5c, $4c
	db $ff, $01
	db $5c, $34
	db $00, $00
	db $ff, $ff ; end

.GRPsychicStronghold_GRWaterFort:
	db $84, $30
	db $84, $44
	db $76, $6a
	db $ff, $01
	db $74, $78
	db $84, $78
	db $00, $00
	db $ff, $ff ; end

.GRPsychicStronghold_GRFightingFort:
	db $84, $30
	db $84, $44
	db $00, $00
	db $ff, $ff ; end

.GRPsychicStronghold_ColorlessAltar:
	db $9c, $38
	db $ac, $38
	db $00, $00
	db $ff, $ff ; end

.ColorlessAltar_GRAirport:
	db $ac, $38
	db $9c, $38
	db $98, $30
	db $84, $30
	db $84, $44
	db $76, $6a
	db $ff, $01
	db $54, $78
	db $3c, $78
	db $3c, $88
	db $ff, $00
	db $3c, $98
	db $24, $98
	db $00, $00
	db $ff, $ff ; end

.ColorlessAltar_IshiharasVilla:
	db $ac, $38
	db $9c, $38
	db $84, $24
	db $84, $14
	db $00, $00
	db $ff, $ff ; end

.ColorlessAltar_GameCenter:
	db $ac, $38
	db $9c, $38
	db $98, $30
	db $84, $30
	db $84, $44
	db $76, $6a
	db $ff, $01
	db $54, $78
	db $3c, $78
	db $3c, $88
	db $ff, $00
	db $3c, $98
	db $24, $98
	db $24, $b0
	db $34, $b0
	db $00, $00
	db $ff, $ff ; end

.ColorlessAltar_SealedFort:
	db $ac, $38
	db $9c, $38
	db $98, $30
	db $84, $30
	db $84, $44
	db $76, $6a
	db $ff, $01
	db $54, $78
	db $3c, $78
	db $3c, $88
	db $ff, $00
	db $3c, $98
	db $24, $98
	db $14, $98
	db $14, $8c
	db $00, $00
	db $ff, $ff ; end

.ColorlessAltar_GRChallengeHall:
	db $ac, $38
	db $9c, $38
	db $98, $30
	db $84, $30
	db $84, $44
	db $00, $00
	db $ff, $01
	db $ff, $ff ; end

.ColorlessAltar_GRGrassFort:
	db $ac, $38
	db $9c, $38
	db $98, $30
	db $84, $30
	db $84, $44
	db $76, $6a
	db $ff, $01
	db $54, $78
	db $3c, $78
	db $00, $00
	db $ff, $00
	db $ff, $ff ; end

.ColorlessAltar_GRLightningFort:
	db $ac, $38
	db $9c, $38
	db $98, $30
	db $84, $30
	db $84, $44
	db $76, $6a
	db $ff, $01
	db $00, $00
	db $ff, $ff ; end

.ColorlessAltar_GRFireFort:
	db $ac, $38
	db $9c, $38
	db $98, $30
	db $84, $30
	db $84, $44
	db $5c, $4c
	db $ff, $01
	db $5c, $34
	db $00, $00
	db $ff, $ff ; end

.ColorlessAltar_GRWaterFort:
	db $ac, $38
	db $9c, $38
	db $98, $30
	db $84, $30
	db $84, $44
	db $76, $6a
	db $ff, $01
	db $74, $78
	db $84, $78
	db $00, $00
	db $ff, $ff ; end

.ColorlessAltar_GRFightingFort:
	db $ac, $38
	db $9c, $38
	db $98, $30
	db $84, $30
	db $84, $44
	db $00, $00
	db $ff, $ff ; end

.ColorlessAltar_GRPsychicStronghold:
.ColorlessAltar_GRCastle:
	db $ac, $38
	db $9c, $38
	db $00, $00
	db $ff, $ff ; end

.GRCastle_GRAirport:
	db $84, $24
	db $84, $44
	db $76, $6a
	db $ff, $01
	db $54, $78
	db $3c, $78
	db $3c, $88
	db $ff, $00
	db $3c, $98
	db $24, $98
	db $00, $00
	db $ff, $ff ; end

.GRCastle_IshiharasVilla:
	db $84, $24
	db $84, $14
	db $00, $00
	db $ff, $ff ; end

.GRCastle_GameCenter:
	db $84, $24
	db $84, $44
	db $76, $6a
	db $ff, $01
	db $54, $78
	db $3c, $78
	db $3c, $88
	db $ff, $00
	db $3c, $98
	db $24, $98
	db $24, $b0
	db $34, $b0
	db $00, $00
	db $ff, $ff ; end

.GRCastle_SealedFort:
	db $84, $24
	db $84, $44
	db $76, $6a
	db $ff, $01
	db $54, $78
	db $3c, $78
	db $3c, $88
	db $ff, $00
	db $3c, $98
	db $24, $98
	db $14, $98
	db $14, $8c
	db $00, $00
	db $ff, $ff ; end

.GRCastle_GRChallengeHall:
	db $84, $24
	db $84, $44
	db $00, $00
	db $ff, $01
	db $ff, $ff ; end

.GRCastle_GRGrassFort:
	db $84, $24
	db $84, $44
	db $76, $6a
	db $ff, $01
	db $54, $78
	db $3c, $78
	db $00, $00
	db $ff, $00
	db $ff, $ff ; end

.GRCastle_GRLightningFort:
	db $84, $24
	db $84, $44
	db $76, $6a
	db $ff, $01
	db $00, $00
	db $ff, $ff ; end

.GRCastle_GRFireFort:
	db $84, $24
	db $84, $44
	db $5c, $4c
	db $ff, $01
	db $5c, $34
	db $00, $00
	db $ff, $ff ; end

.GRCastle_GRWaterFort:
	db $84, $24
	db $84, $44
	db $76, $6a
	db $ff, $01
	db $74, $78
	db $84, $78
	db $00, $00
	db $ff, $ff ; end

.GRCastle_GRFightingFort:
	db $84, $24
	db $84, $44
	db $00, $00
	db $ff, $ff ; end

.GRCastle_ColorlessAltar:
	db $9c, $38
	db $ac, $38
	db $00, $00
	db $ff, $ff ; end

.GRChallengeHall_GRLightningFort:
.GRLightningFort_GRChallengeHall:
.GRPsychicStronghold_GRCastle:
.GRCastle_GRPsychicStronghold:
	db $00, $00
	db $ff, $ff ; end
