RunCreditsCommands:
.start
	ld hl, Credits
.loop
	ld a, [hli]
	cp CREDITSCMD_RESET
	jr z, .start
	cp CREDITS_END
	ret z
	push af
	ld a, [hli]
	ld [wCreditsCmdArg1], a
	ld a, [hli]
	ld [wCreditsCmdArg2], a
	ld a, [hli]
	ld [wCreditsCmdArg3], a
	ld a, [hli]
	ld [wCreditsCmdArg4], a
	ld a, [hli]
	ld [wCreditsCmdArg5], a
	pop af
	push hl
	ld hl, .CommandFunctions
	call CallMappedFunction
	pop hl
	jr .loop

.CommandFunctions:
	key_func CREDITSCMD_WAIT,                CreditsCmd_Wait
	key_func CREDITSCMD_DRAW_BOX,            CreditsCmd_DrawBox
	key_func CREDITSCMD_FADE_OUT,            CreditsCmd_FadeOut
	key_func CREDITSCMD_FADE_IN,             CreditsCmd_FadeIn
	key_func CREDITSCMD_SET_MUSIC,           CreditsCmd_SetMusic
	key_func CREDITSCMD_STOP_MUSIC,          CreditsCmd_StopMusic
	key_func CREDITSCMD_SHOW_COMPANIES,      CreditsCmd_ShowCompanies
	key_func CREDITSCMD_SHOW_TITLE,          CreditsCmd_ShowTitle
	key_func CREDITSCMD_SHOW_CARD,           CreditsCmd_ShowCard
	key_func CREDITSCMD_SHOW_SET,            CreditsCmd_ShowSet
	key_func CREDITSCMD_SHOW_PORTRAIT,       CreditsCmd_ShowPortrait
	key_func CREDITSCMD_PRINT_HEADER,        CreditsCmd_PrintHeader
	key_func CREDITSCMD_PRINT_TEXT,          CreditsCmd_PrintBlack
	key_func CREDITSCMD_SCROLL,              CreditsCmd_Scroll
	key_func CREDITSCMD_WAIT_INPUT,          CreditsCmd_WaitInput
	key_func CREDITSCMD_MUSIC_FADE_OUT,      CreditsCmd_MusicFadeOut
	key_func CREDITSCMD_SET_VOLUME,          CreditsCmd_SetVolume
	key_func CREDITSCMD_LOAD_MAP,            CreditsCmd_LoadMap
	key_func CREDITSCMD_INIT_OW,             CreditsCmd_InitOW
	key_func CREDITSCMD_DEINIT_OW,           CreditsCmd_DeinitOW
	key_func CREDITSCMD_LOAD_TILEMAP,        CreditsCmd_LoadTilemap
	key_func CREDITSCMD_LOAD_OW_OBJ,         CreditsCmd_LoadOWObject
	key_func CREDITSCMD_LOAD_OW_OBJ_IN_MAP,  CreditsCmd_LoadOWObjectInMap
	key_func CREDITSCMD_SHOW_TILE,           CreditsCmd_ShowTile
	db $ff ; end

INCLUDE "data/credits.asm"
