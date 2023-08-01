TCGIslandPlayerPaths:
	dw .MasonLaboratoryPaths  ; OWMAP_MASON_LABORATORY
	dw .IshiharasHousePaths   ; OWMAP_ISHIHARAS_HOUSE
	dw .LightningClubPaths    ; OWMAP_LIGHTNING_CLUB
	dw .PsychicClubPaths      ; OWMAP_PSYCHIC_CLUB
	dw .RockClubPaths         ; OWMAP_ROCK_CLUB
	dw .FightingClubPaths     ; OWMAP_FIGHTING_CLUB
	dw .GrassClubPaths        ; OWMAP_GRASS_CLUB
	dw .ScienceClubPaths      ; OWMAP_SCIENCE_CLUB
	dw .WaterClubPaths        ; OWMAP_WATER_CLUB
	dw .FireClubPaths         ; OWMAP_FIRE_CLUB
	dw .TCGAirportPaths       ; OWMAP_TCG_AIRPORT
	dw .TCGChallengeHallPaths ; OWMAP_TCG_CHALLENGE_HALL
	dw .PokemonDomePaths      ; OWMAP_POKEMON_DOME

.MasonLaboratoryPaths:
	dw NULL
	dw .MasonLaboratory_IshiharasHouse
	dw .MasonLaboratory_LightningClub
	dw .MasonLaboratory_PsychicClub
	dw .MasonLaboratory_RockClub
	dw .MasonLaboratory_FightingClub
	dw .MasonLaboratory_GrassClub
	dw .MasonLaboratory_ScienceClub
	dw .MasonLaboratory_WaterClub
	dw .MasonLaboratory_FireClub
	dw .MasonLaboratory_TCGAirport
	dw .MasonLaboratory_TCGChallengeHall
	dw .MasonLaboratory_PokemonDome

.IshiharasHousePaths:
	dw .IshiharasHouse_MasonLaboratory
	dw NULL
	dw .IshiharasHouse_LightningClub
	dw .IshiharasHouse_PsychicClub
	dw .IshiharasHouse_RockClub
	dw .IshiharasHouse_FightingClub
	dw .IshiharasHouse_GrassClub
	dw .IshiharasHouse_ScienceClub
	dw .IshiharasHouse_WaterClub
	dw .IshiharasHouse_FireClub
	dw .IshiharasHouse_TCGAirport
	dw .IshiharasHouse_TCGChallengeHall
	dw .IshiharasHouse_PokemonDome

.LightningClubPaths:
	dw .LightningClub_MasonLaboratory
	dw .LightningClub_IshiharasHouse
	dw NULL
	dw .LightningClub_PsychicClub
	dw .LightningClub_RockClub
	dw .LightningClub_FightingClub
	dw .LightningClub_GrassClub
	dw .LightningClub_ScienceClub
	dw .LightningClub_WaterClub
	dw .LightningClub_FireClub
	dw .LightningClub_TCGAirport
	dw .LightningClub_TCGChallengeHall
	dw .LightningClub_PokemonDome

.PsychicClubPaths:
	dw .PsychicClub_MasonLaboratory
	dw .PsychicClub_IshiharasHouse
	dw .PsychicClub_LightningClub
	dw NULL
	dw .PsychicClub_RockClub
	dw .PsychicClub_FightingClub
	dw .PsychicClub_GrassClub
	dw .PsychicClub_ScienceClub
	dw .PsychicClub_WaterClub
	dw .PsychicClub_FireClub
	dw .PsychicClub_TCGAirport
	dw .PsychicClub_TCGChallengeHall
	dw .PsychicClub_PokemonDome

.RockClubPaths:
	dw .RockClub_MasonLaboratory
	dw .RockClub_IshiharasHouse
	dw .RockClub_LightningClub
	dw .RockClub_PsychicClub
	dw NULL
	dw .RockClub_FightingClub
	dw .RockClub_GrassClub
	dw .RockClub_ScienceClub
	dw .RockClub_WaterClub
	dw .RockClub_FireClub
	dw .RockClub_TCGAirport
	dw .RockClub_TCGChallengeHall
	dw .RockClub_PokemonDome

.FightingClubPaths:
	dw .FightingClub_MasonLaboratory
	dw .FightingClub_IshiharasHouse
	dw .FightingClub_LightningClub
	dw .FightingClub_PsychicClub
	dw .FightingClub_RockClub
	dw NULL
	dw .FightingClub_GrassClub
	dw .FightingClub_ScienceClub
	dw .FightingClub_WaterClub
	dw .FightingClub_FireClub
	dw .FightingClub_TCGAirport
	dw .FightingClub_TCGChallengeHall
	dw .FightingClub_PokemonDome

.GrassClubPaths:
	dw .GrassClub_MasonLaboratory
	dw .GrassClub_IshiharasHouse
	dw .GrassClub_LightningClub
	dw .GrassClub_PsychicClub
	dw .GrassClub_RockClub
	dw .GrassClub_FightingClub
	dw NULL
	dw .GrassClub_ScienceClub
	dw .GrassClub_WaterClub
	dw .GrassClub_FireClub
	dw .GrassClub_TCGAirport
	dw .GrassClub_TCGChallengeHall
	dw .GrassClub_PokemonDome

.ScienceClubPaths:
	dw .ScienceClub_MasonLaboratory
	dw .ScienceClub_IshiharasHouse
	dw .ScienceClub_LightningClub
	dw .ScienceClub_PsychicClub
	dw .ScienceClub_RockClub
	dw .ScienceClub_FightingClub
	dw .ScienceClub_GrassClub
	dw NULL
	dw .ScienceClub_WaterClub
	dw .ScienceClub_FireClub
	dw .ScienceClub_TCGAirport
	dw .ScienceClub_TCGChallengeHall
	dw .ScienceClub_PokemonDome

.WaterClubPaths:
	dw .WaterClub_MasonLaboratory
	dw .WaterClub_IshiharasHouse
	dw .WaterClub_LightningClub
	dw .WaterClub_PsychicClub
	dw .WaterClub_RockClub
	dw .WaterClub_FightingClub
	dw .WaterClub_GrassClub
	dw .WaterClub_ScienceClub
	dw NULL
	dw .WaterClub_FireClub
	dw .WaterClub_TCGAirport
	dw .WaterClub_TCGChallengeHall
	dw .WaterClub_PokemonDome

.FireClubPaths:
	dw .FireClub_MasonLaboratory
	dw .FireClub_IshiharasHouse
	dw .FireClub_LightningClub
	dw .FireClub_PsychicClub
	dw .FireClub_RockClub
	dw .FireClub_FightingClub
	dw .FireClub_GrassClub
	dw .FireClub_ScienceClub
	dw .FireClub_WaterClub
	dw NULL
	dw .FireClub_TCGAirport
	dw .FireClub_TCGChallengeHall
	dw .FireClub_PokemonDome

.TCGAirportPaths:
	dw .TCGAirport_MasonLaboratory
	dw .TCGAirport_IshiharasHouse
	dw .TCGAirport_LightningClub
	dw .TCGAirport_PsychicClub
	dw .TCGAirport_RockClub
	dw .TCGAirport_FightingClub
	dw .TCGAirport_GrassClub
	dw .TCGAirport_ScienceClub
	dw .TCGAirport_WaterClub
	dw .TCGAirport_FireClub
	dw NULL
	dw .TCGAirport_TCGChallengeHall
	dw .TCGAirport_PokemonDome

.TCGChallengeHallPaths:
	dw .TCGChallengeHall_MasonLaboratory
	dw .TCGChallengeHall_IshiharasHouse
	dw .TCGChallengeHall_LightningClub
	dw .TCGChallengeHall_PsychicClub
	dw .TCGChallengeHall_RockClub
	dw .TCGChallengeHall_FightingClub
	dw .TCGChallengeHall_GrassClub
	dw .TCGChallengeHall_ScienceClub
	dw .TCGChallengeHall_WaterClub
	dw .TCGChallengeHall_FireClub
	dw .TCGChallengeHall_TCGAirport
	dw NULL
	dw .TCGChallengeHall_PokemonDome

.PokemonDomePaths:
	dw .PokemonDome_MasonLaboratory
	dw .PokemonDome_IshiharasHouse
	dw .PokemonDome_LightningClub
	dw .PokemonDome_PsychicClub
	dw .PokemonDome_RockClub
	dw .PokemonDome_FightingClub
	dw .PokemonDome_GrassClub
	dw .PokemonDome_ScienceClub
	dw .PokemonDome_WaterClub
	dw .PokemonDome_FireClub
	dw .PokemonDome_TCGAirport
	dw .PokemonDome_TCGChallengeHall
	dw NULL

.MasonLaboratory_IshiharasHouse:
	db $24, $68
	db $34, $50
	db $34, $38
	db $1c, $18
	db $00, $00
	db $ff, $ff ; end

.MasonLaboratory_LightningClub:
	db $24, $68
	db $30, $54
	db $00, $00
	db $ff, $ff ; end

.MasonLaboratory_PsychicClub:
	db $24, $68
	db $30, $54
	db $54, $50
	db $00, $00
	db $ff, $ff ; end

.MasonLaboratory_RockClub:
	db $24, $68
	db $34, $50
	db $34, $40
	db $00, $00
	db $ff, $ff ; end

.MasonLaboratory_GrassClub:
.MasonLaboratory_ScienceClub:
	db $24, $68
	db $30, $54
	db $54, $50
	db $00, $00
	db $ff, $ff ; end

.MasonLaboratory_WaterClub:
	db $24, $68
	db $30, $54
	db $58, $54
	db $00, $00
	db $ff, $ff ; end

.MasonLaboratory_FireClub:
	db $24, $68
	db $30, $54
	db $54, $50
	db $6c, $38
	db $00, $00
	db $ff, $ff ; end

.MasonLaboratory_TCGAirport:
	db $24, $68
	db $30, $54
	db $50, $5c
	db $00, $00
	db $ff, $ff ; end

.MasonLaboratory_TCGChallengeHall:
	db $24, $68
	db $34, $50
	db $34, $40
	db $3c, $2c
	db $00, $00
	db $ff, $ff ; end

.MasonLaboratory_PokemonDome:
	db $24, $68
	db $00, $00
	db $ff, $ff ; end

.IshiharasHouse_MasonLaboratory:
	db $1c, $18
	db $34, $38
	db $34, $50
	db $24, $68
	db $00, $00
	db $ff, $ff ; end

.IshiharasHouse_LightningClub:
	db $1c, $18
	db $24, $2c
	db $00, $00
	db $ff, $ff ; end

.IshiharasHouse_PsychicClub:
	db $1c, $18
	db $24, $2c
	db $00, $00
	db $ff, $ff ; end

.IshiharasHouse_RockClub:
	db $1c, $18
	db $24, $2c
	db $00, $00
	db $ff, $ff ; end

.IshiharasHouse_FightingClub:
	db $1c, $18
	db $34, $40
	db $00, $00
	db $ff, $ff ; end

.IshiharasHouse_GrassClub:
	db $1c, $18
	db $24, $2c
	db $4c, $34
	db $00, $00
	db $ff, $ff ; end

.IshiharasHouse_ScienceClub:
	db $1c, $18
	db $24, $2c
	db $4c, $2c
	db $54, $20
	db $00, $00
	db $ff, $ff ; end

.IshiharasHouse_WaterClub:
	db $1c, $18
	db $34, $50
	db $58, $54
	db $00, $00
	db $ff, $ff ; end

.IshiharasHouse_FireClub:
	db $1c, $18
	db $24, $2c
	db $4c, $2c
	db $54, $20
	db $00, $00
	db $ff, $ff ; end

.IshiharasHouse_TCGAirport:
	db $1c, $18
	db $34, $50
	db $50, $5c
	db $00, $00
	db $ff, $ff ; end

.IshiharasHouse_TCGChallengeHall:
	db $1c, $18
	db $24, $2c
	db $3c, $2c
	db $00, $00
	db $ff, $ff ; end

.IshiharasHouse_PokemonDome:
	db $1c, $18
	db $24, $2c
	db $00, $00
	db $ff, $ff ; end

.LightningClub_MasonLaboratory:
	db $30, $54
	db $24, $68
	db $00, $00
	db $ff, $ff ; end

.LightningClub_IshiharasHouse:
	db $24, $2c
	db $1c, $18
	db $00, $00
	db $ff, $ff ; end

.LightningClub_PsychicClub:
	db $34, $38
	db $00, $00
	db $ff, $ff ; end

.LightningClub_GrassClub:
.LightningClub_ScienceClub:
	db $54, $50
	db $00, $00
	db $ff, $ff ; end

.LightningClub_WaterClub:
	db $34, $50
	db $58, $54
	db $00, $00
	db $ff, $ff ; end

.LightningClub_FireClub:
	db $34, $38
	db $54, $20
	db $00, $00
	db $ff, $ff ; end

.LightningClub_TCGAirport:
	db $50, $5c
	db $00, $00
	db $ff, $ff ; end

.LightningClub_TCGChallengeHall:
	db $3c, $2c
	db $00, $00
	db $ff, $ff ; end


.PsychicClub_MasonLaboratory:
	db $54, $50
	db $30, $54
	db $24, $68
	db $00, $00
	db $ff, $ff ; end

.PsychicClub_IshiharasHouse:
	db $24, $2c
	db $1c, $18
	db $00, $00
	db $ff, $ff ; end

.PsychicClub_LightningClub:
	db $34, $38
	db $00, $00
	db $ff, $ff ; end

.PsychicClub_FightingClub:
	db $54, $50
	db $00, $00
	db $ff, $ff ; end

.PsychicClub_WaterClub:
	db $58, $54
	db $00, $00
	db $ff, $ff ; end

.PsychicClub_TCGAirport:
	db $54, $50
	db $00, $00
	db $ff, $ff ; end

.PsychicClub_TCGChallengeHall:
	db $3c, $2c
	db $00, $00
	db $ff, $ff ; end

.RockClub_MasonLaboratory:
	db $34, $40
	db $34, $50
	db $24, $68
	db $00, $00
	db $ff, $ff ; end

.RockClub_IshiharasHouse:
	db $24, $2c
	db $1c, $18
	db $00, $00
	db $ff, $ff ; end

.RockClub_FightingClub:
	db $34, $40
	db $00, $00
	db $ff, $ff ; end

.RockClub_GrassClub:
	db $6c, $38
	db $00, $00
	db $ff, $ff ; end

.RockClub_ScienceClub:
.RockClub_FireClub:
	db $4c, $2c
	db $54, $20
	db $00, $00
	db $ff, $ff ; end

.RockClub_WaterClub:
	db $34, $40
	db $34, $50
	db $58, $54
	db $00, $00
	db $ff, $ff ; end

.RockClub_TCGAirport:
	db $34, $40
	db $34, $50
	db $50, $5c
	db $00, $00
	db $ff, $ff ; end

.RockClub_TCGChallengeHall:
	db $3c, $2c
	db $00, $00
	db $ff, $ff ; end

.FightingClub_IshiharasHouse:
	db $34, $40
	db $1c, $18
	db $00, $00
	db $ff, $ff ; end

.FightingClub_PsychicClub:
	db $54, $50
	db $00, $00
	db $ff, $ff ; end

.FightingClub_RockClub:
	db $34, $40
	db $00, $00
	db $ff, $ff ; end

.FightingClub_GrassClub:
.FightingClub_ScienceClub:
	db $54, $50
	db $00, $00
	db $ff, $ff ; end

.FightingClub_WaterClub:
	db $58, $54
	db $00, $00
	db $ff, $ff ; end

.FightingClub_FireClub:
	db $6c, $38
	db $00, $00
	db $ff, $ff ; end

.FightingClub_TCGAirport:
	db $50, $5c
	db $00, $00
	db $ff, $ff ; end

.FightingClub_TCGChallengeHall:
	db $34, $38
	db $3c, $2c
	db $00, $00
	db $ff, $ff ; end

.GrassClub_MasonLaboratory:
	db $54, $50
	db $30, $54
	db $24, $68
	db $00, $00
	db $ff, $ff ; end

.GrassClub_IshiharasHouse:
	db $4c, $34
	db $24, $2c
	db $1c, $18
	db $00, $00
	db $ff, $ff ; end

.GrassClub_LightningClub:
	db $54, $50
	db $00, $00
	db $ff, $ff ; end

.GrassClub_RockClub:
	db $6c, $38
	db $00, $00
	db $ff, $ff ; end

.GrassClub_FightingClub:
	db $54, $50
	db $00, $00
	db $ff, $ff ; end

.GrassClub_WaterClub:
	db $54, $50
	db $58, $54
	db $00, $00
	db $ff, $ff ; end

.GrassClub_FireClub:
	db $6c, $2c
	db $00, $00
	db $ff, $ff ; end

.GrassClub_TCGAirport:
	db $54, $50
	db $50, $5c
	db $00, $00
	db $ff, $ff ; end

.GrassClub_TCGChallengeHall:
	db $3c, $2c
	db $00, $00
	db $ff, $ff ; end

.ScienceClub_MasonLaboratory:
	db $54, $50
	db $30, $54
	db $24, $68
	db $00, $00
	db $ff, $ff ; end

.ScienceClub_IshiharasHouse:
	db $54, $20
	db $4c, $2c
	db $24, $2c
	db $1c, $18
	db $00, $00
	db $ff, $ff ; end

.ScienceClub_LightningClub:
	db $54, $50
	db $00, $00
	db $ff, $ff ; end

.ScienceClub_RockClub:
	db $54, $20
	db $4c, $2c
	db $00, $00
	db $ff, $ff ; end

.ScienceClub_FightingClub:
	db $54, $50
	db $00, $00
	db $ff, $ff ; end

.ScienceClub_WaterClub:
	db $58, $54
	db $00, $00
	db $ff, $ff ; end

.ScienceClub_TCGAirport:
	db $50, $5c
	db $00, $00
	db $ff, $ff ; end

.ScienceClub_TCGChallengeHall:
	db $54, $20
	db $4c, $2c
	db $3c, $2c
	db $00, $00
	db $ff, $ff ; end

.ScienceClub_PokemonDome:
	db $6c, $38
	db $00, $00
	db $ff, $ff ; end

.WaterClub_MasonLaboratory:
	db $58, $54
	db $30, $54
	db $24, $68
	db $00, $00
	db $ff, $ff ; end

.WaterClub_IshiharasHouse:
	db $58, $54
	db $34, $50
	db $1c, $18
	db $00, $00
	db $ff, $ff ; end

.WaterClub_LightningClub:
	db $58, $54
	db $34, $50
	db $00, $00
	db $ff, $ff ; end

.WaterClub_PsychicClub:
	db $58, $54
	db $00, $00
	db $ff, $ff ; end

.WaterClub_RockClub:
	db $58, $54
	db $34, $50
	db $34, $40
	db $00, $00
	db $ff, $ff ; end

.WaterClub_FightingClub:
	db $58, $54
	db $00, $00
	db $ff, $ff ; end

.WaterClub_GrassClub:
	db $58, $54
	db $54, $50
	db $00, $00
	db $ff, $ff ; end

.WaterClub_ScienceClub:
	db $58, $54
	db $00, $00
	db $ff, $ff ; end

.WaterClub_FireClub:
	db $58, $54
	db $6c, $38
	db $00, $00
	db $ff, $ff ; end

.WaterClub_TCGAirport:
	db $58, $54
	db $50, $5c
	db $00, $00
	db $ff, $ff ; end

.WaterClub_TCGChallengeHall:
	db $58, $54
	db $54, $38
	db $4c, $34
	db $3c, $2c
	db $00, $00
	db $ff, $ff ; end

.WaterClub_PokemonDome:
	db $58, $54
	db $00, $00
	db $ff, $ff ; end

.FireClub_MasonLaboratory:
	db $6c, $38
	db $54, $50
	db $30, $54
	db $24, $68
	db $00, $00
	db $ff, $ff ; end

.FireClub_IshiharasHouse:
	db $54, $20
	db $4c, $2c
	db $24, $2c
	db $1c, $18
	db $00, $00
	db $ff, $ff ; end

.FireClub_LightningClub:
	db $54, $20
	db $34, $38
	db $00, $00
	db $ff, $ff ; end

.FireClub_RockClub:
	db $54, $20
	db $4c, $2c
	db $00, $00
	db $ff, $ff ; end

.FireClub_FightingClub:
	db $6c, $38
	db $00, $00
	db $ff, $ff ; end

.FireClub_GrassClub:
	db $6c, $2c
	db $00, $00
	db $ff, $ff ; end

.FireClub_WaterClub:
	db $6c, $38
	db $58, $54
	db $00, $00
	db $ff, $ff ; end

.FireClub_TCGAirport:
	db $6c, $38
	db $50, $5c
	db $00, $00
	db $ff, $ff ; end

.FireClub_TCGChallengeHall:
	db $54, $20
	db $4c, $2c
	db $3c, $2c
	db $00, $00
	db $ff, $ff ; end

.FireClub_PokemonDome:
	db $54, $20
	db $00, $00
	db $ff, $ff ; end

.TCGAirport_MasonLaboratory:
	db $50, $5c
	db $30, $54
	db $24, $68
	db $00, $00
	db $ff, $ff ; end

.TCGAirport_IshiharasHouse:
	db $50, $5c
	db $34, $50
	db $1c, $18
	db $00, $00
	db $ff, $ff ; end

.TCGAirport_LightningClub:
	db $50, $5c
	db $00, $00
	db $ff, $ff ; end

.TCGAirport_PsychicClub:
	db $50, $5c
	db $54, $50
	db $00, $00
	db $ff, $ff ; end

.TCGAirport_RockClub:
	db $50, $5c
	db $34, $50
	db $34, $40
	db $00, $00
	db $ff, $ff ; end

.TCGAirport_FightingClub:
	db $50, $5c
	db $00, $00
	db $ff, $ff ; end

.TCGAirport_GrassClub:
	db $7c, $74
	db $84, $68
	db $84, $50
	db $00, $00
	db $ff, $ff ; end

.TCGAirport_ScienceClub:
	db $50, $5c
	db $00, $00
	db $ff, $ff ; end

.TCGAirport_WaterClub:
	db $50, $5c
	db $58, $54
	db $00, $00
	db $ff, $ff ; end

.TCGAirport_FireClub:
	db $50, $5c
	db $6c, $38
	db $00, $00
	db $ff, $ff ; end

.TCGAirport_TCGChallengeHall:
	db $50, $5c
	db $34, $50
	db $34, $40
	db $3c, $2c
	db $00, $00
	db $ff, $ff ; end

.TCGAirport_PokemonDome:
	db $50, $5c
	db $00, $00
	db $ff, $ff ; end

.TCGChallengeHall_MasonLaboratory:
	db $3c, $2c
	db $34, $40
	db $34, $50
	db $24, $68
	db $00, $00
	db $ff, $ff ; end

.TCGChallengeHall_IshiharasHouse:
	db $3c, $2c
	db $24, $2c
	db $1c, $18
	db $00, $00
	db $ff, $ff ; end

.TCGChallengeHall_LightningClub:
	db $3c, $2c
	db $00, $00
	db $ff, $ff ; end

.TCGChallengeHall_PsychicClub:
	db $3c, $2c
	db $00, $00
	db $ff, $ff ; end

.TCGChallengeHall_RockClub:
	db $3c, $2c
	db $00, $00
	db $ff, $ff ; end

.TCGChallengeHall_FightingClub:
	db $3c, $2c
	db $34, $38
	db $00, $00
	db $ff, $ff ; end

.TCGChallengeHall_GrassClub:
	db $3c, $2c
	db $00, $00
	db $ff, $ff ; end

.TCGChallengeHall_ScienceClub:
	db $3c, $2c
	db $4c, $2c
	db $54, $20
	db $00, $00
	db $ff, $ff ; end

.TCGChallengeHall_WaterClub:
	db $3c, $2c
	db $4c, $34
	db $54, $38
	db $58, $54
	db $00, $00
	db $ff, $ff ; end

.TCGChallengeHall_FireClub:
	db $3c, $2c
	db $4c, $2c
	db $54, $20
	db $00, $00
	db $ff, $ff ; end

.TCGChallengeHall_TCGAirport:
	db $3c, $2c
	db $34, $40
	db $34, $50
	db $50, $5c
	db $00, $00
	db $ff, $ff ; end

.TCGChallengeHall_PokemonDome:
	db $3c, $2c
	db $00, $00
	db $ff, $ff ; end

.PokemonDome_MasonLaboratory:
	db $24, $68
	db $00, $00
	db $ff, $ff ; end

.PokemonDome_IshiharasHouse:
	db $24, $2c
	db $1c, $18
	db $00, $00
	db $ff, $ff ; end

.PokemonDome_ScienceClub:
	db $6c, $38
	db $00, $00
	db $ff, $ff ; end

.PokemonDome_WaterClub:
	db $58, $54
	db $00, $00
	db $ff, $ff ; end

.PokemonDome_FireClub:
	db $54, $20
	db $00, $00
	db $ff, $ff ; end

.PokemonDome_TCGAirport:
	db $50, $5c
	db $00, $00
	db $ff, $ff ; end

.PokemonDome_TCGChallengeHall:
	db $3c, $2c
	db $00, $00
	db $ff, $ff ; end

.MasonLaboratory_FightingClub:
.LightningClub_RockClub:
.LightningClub_FightingClub:
.LightningClub_PokemonDome:
.PsychicClub_RockClub:
.PsychicClub_GrassClub:
.PsychicClub_ScienceClub:
.PsychicClub_FireClub:
.PsychicClub_PokemonDome:
.RockClub_LightningClub:
.RockClub_PsychicClub:
.RockClub_PokemonDome:
.FightingClub_MasonLaboratory:
.FightingClub_LightningClub:
.FightingClub_PokemonDome:
.GrassClub_PsychicClub:
.GrassClub_ScienceClub:
.GrassClub_PokemonDome:
.ScienceClub_PsychicClub:
.ScienceClub_GrassClub:
.ScienceClub_FireClub:
.FireClub_PsychicClub:
.FireClub_ScienceClub:
.PokemonDome_LightningClub:
.PokemonDome_PsychicClub:
.PokemonDome_RockClub:
.PokemonDome_FightingClub:
.PokemonDome_GrassClub:
	db $00, $00
	db $ff, $ff ; end
