MACRO start_script
	call StartScript
ENDM

MACRO run_command
	db \1_index
ENDM

	const_def
	const ScriptCommand_EndScript_index                        ; $00
	const ScriptCommand_01_index                               ; $01
	const ScriptCommand_02_index                               ; $02
	const ScriptCommand_PrintText_index                        ; $03
	const ScriptCommand_PrintVariableText_index                ; $04
	const ScriptCommand_PrintNPCText_index                     ; $05
	const ScriptCommand_PrintVariableNPCText_index             ; $06
	const ScriptCommand_AskQuestion_index                      ; $07
	const ScriptCommand_ScriptJump_index                       ; $08
	const ScriptCommand_ScriptJump_b0nz_index                  ; $09
	const ScriptCommand_ScriptJump_b0z_index                   ; $0a
	const ScriptCommand_ScriptJump_b1nz_index                  ; $0b
	const ScriptCommand_ScriptJump_b1z_index                   ; $0c
	const ScriptCommand_CompareLoadedVar_index                 ; $0d
	const ScriptCommand_SetEvent_index                         ; $0e
	const ScriptCommand_ResetEvent_index                       ; $0f
	const ScriptCommand_CheckEvent_index                       ; $10
	const ScriptCommand_SetVar_index                           ; $11
	const ScriptCommand_GetVar_index                           ; $12
	const ScriptCommand_IncVar_index                           ; $13
	const ScriptCommand_DecVar_index                           ; $14
	const ScriptCommand_LoadNPC_index                          ; $15
	const ScriptCommand_UnloadNPC_index                        ; $16
	const ScriptCommand_SetPlayerDirection_index               ; $17
	const ScriptCommand_SetActiveNPCDirection_index            ; $18
	const ScriptCommand_DoFrames_index                         ; $19
	const ScriptCommand_LoadTilemap_index                      ; $1a
	const ScriptCommand_ShowCardReceivedScreen_index           ; $1b
	const ScriptCommand_SetPlayerPosition_index                ; $1c
	const ScriptCommand_SetActiveNPCPosition_index             ; $1d
	const ScriptCommand_SetScrollState_index                   ; $1e
	const ScriptCommand_ScrollToPosition_index                 ; $1f
	const ScriptCommand_SetActiveNPC_index                     ; $20
	const ScriptCommand_SetPlayerPositionAndDirection_index    ; $21
	const ScriptCommand_SetNPCPositionAndDirection_index       ; $22
	const ScriptCommand_FadeIn_index                           ; $23
	const ScriptCommand_FadeOut_index                          ; $24
	const ScriptCommand_SetNPCDirection_index                  ; $25
	const ScriptCommand_SetNPCPosition_index                   ; $26
	const ScriptCommand_SetActiveNPCPositionAndDirection_index ; $27
	const ScriptCommand_AnimatePlayerMovement_index            ; $28
	const ScriptCommand_AnimateNPCMovement_index               ; $29
	const ScriptCommand_AnimateActiveNPCMovement_index         ; $2a
	const ScriptCommand_MovePlayer_index                       ; $2b
	const ScriptCommand_MoveNPC_index                          ; $2c
	const ScriptCommand_MoveActiveNPC_index                    ; $2d
	const ScriptCommand_StartDuel_index                        ; $2e
	const ScriptCommand_WaitForPlayerAnimation_index           ; $2f
	const ScriptCommand_WaitForFade_index                      ; $30
	const ScriptCommand_GetCardCountInCollectionAndDecks_index ; $31
	const ScriptCommand_GetCardCountInCollection_index         ; $32
	const ScriptCommand_GiveCard_index                         ; $33
	const ScriptCommand_TakeCard_index                         ; $34
	const ScriptCommand_NPCAskQuestion_index                   ; $35
	const ScriptCommand_GetPlayerDirection_index               ; $36
	const ScriptCommand_CompareVar_index                       ; $37
	const ScriptCommand_GetActiveNPCDirection_index            ; $38
	const ScriptCommand_ScrollToActiveNPC_index                ; $39
	const ScriptCommand_ScrollToPlayer_index                   ; $3a
	const ScriptCommand_ScrollToNPC_index                      ; $3b
	const ScriptCommand_SpinActiveNPC_index                    ; $3c
	const ScriptCommand_RestoreActiveNPCDirection_index        ; $3d
	const ScriptCommand_SpinActiveNPCReverse_index             ; $3e
	const ScriptCommand_ResetNPCFlag6_index                    ; $3f
	const ScriptCommand_SetNPCFlag6_index                      ; $40
	const ScriptCommand_DuelRequirementCheck_index             ; $41
	const ScriptCommand_GetActiveNPCOppositeDirection_index    ; $42
	const ScriptCommand_GetPlayerOppositeDirection_index       ; $43
	const ScriptCommand_PlaySFX_index                          ; $44
	const ScriptCommand_PlaySFXAndWait_index                   ; $45
	const ScriptCommand_SetTextRAM2_index                      ; $46
	const ScriptCommand_SetVariableTextRAM2_index              ; $47
	const ScriptCommand_WaitForNPCAnimation_index              ; $48
	const ScriptCommand_GetPlayerXPosition_index               ; $49
	const ScriptCommand_GetPlayerYPosition_index               ; $4a
	const ScriptCommand_RestoreNPCDirection_index              ; $4b
	const ScriptCommand_SpinNPC_index                          ; $4c
	const ScriptCommand_SpinNPCReverse_index                   ; $4d
	const ScriptCommand_PushVar_index                          ; $4e
	const ScriptCommand_PopVar_index                           ; $4f
	const ScriptCommand_ScriptCall_index                       ; $50
	const ScriptCommand_ScriptRet_index                        ; $51
	const ScriptCommand_GiveCoin_index                         ; $52
	const ScriptCommand_BackupActiveNPC_index                  ; $53
	const ScriptCommand_LoadPlayer_index                       ; $54
	const ScriptCommand_UnloadPlayer_index                     ; $55
	const ScriptCommand_GiveBoosterPacks_index                 ; $56
	const ScriptCommand_GetRandom_index                        ; $57
	const ScriptCommand_58_index                               ; $58
	const ScriptCommand_SetTextRAM3_index                      ; $59
	const ScriptCommand_QuitScript_index                       ; $5a
	const ScriptCommand_PlaySong_index                         ; $5b
	const ScriptCommand_ResumeSong_index                       ; $5c
	const ScriptCommand_ScriptCallfar_index                    ; $5d
	const ScriptCommand_ScriptRetfar_index                     ; $5e
	const ScriptCommand_CardPop_index                          ; $5f
	const ScriptCommand_PlaySongNext_index                     ; $60
	const ScriptCommand_SetTextRAM2b_index                     ; $61
	const ScriptCommand_SetVariableTextRAM2b_index             ; $62
	const ScriptCommand_ReplaceNPC_index                       ; $63
	const ScriptCommand_SendMail_index                         ; $64
	const ScriptCommand_CheckNPCLoaded_index                   ; $65
	const ScriptCommand_GiveDeck_index                         ; $66
	const ScriptCommand_67_index                               ; $67
	const ScriptCommand_68_index                               ; $68
	const ScriptCommand_PrintNPCTextInstant_index              ; $69
	const ScriptCommand_VarAdd_index                           ; $6a
	const ScriptCommand_VarSub_index                           ; $6b
	const ScriptCommand_ReceiveCard_index                      ; $6c
	const ScriptCommand_GetGameCenterChips_index               ; $6d
	const ScriptCommand_CompareLoadedVarWord_index             ; $6e
	const ScriptCommand_GetGameCenterBankedChips_index         ; $6f
	const ScriptCommand_GameCenter_index                       ; $70
	const ScriptCommand_71_index                               ; $71
	const ScriptCommand_GiveChips_index                        ; $72
	const ScriptCommand_TakeChips_index                        ; $73
	const ScriptCommand_LoadTextRAM3_index                     ; $74
	const ScriptCommand_DepositChips_index                     ; $75
	const ScriptCommand_WithdrawChips_index                    ; $76
	const ScriptCommand_LinkDuel_index                         ; $77
	const ScriptCommand_WaitSong_index                         ; $78
	const ScriptCommand_LoadPalette_index                      ; $79
	const ScriptCommand_SetSpriteFrameset_index                ; $7a
	const ScriptCommand_WaitSFX_index                          ; $7b
	const ScriptCommand_PrintTextWideTextbox_index             ; $7c
	const ScriptCommand_WaitInput_index                        ; $7d

DEF NUM_SCRIPT_COMMANDS EQU const_value

; Script Macros

MACRO end_script
	run_command ScriptCommand_EndScript
ENDM

MACRO script_command_01
	run_command ScriptCommand_01
ENDM

MACRO script_command_02
	run_command ScriptCommand_02
ENDM

MACRO print_text
	run_command ScriptCommand_PrintText
	tx \1 ; text
ENDM

MACRO print_variable_text
	run_command ScriptCommand_PrintVariableText
	tx \1 ; text 1
	tx \2 ; text 2
ENDM

MACRO print_npc_text
	run_command ScriptCommand_PrintNPCText
	tx \1 ; text
ENDM

MACRO print_variable_npc_text
	run_command ScriptCommand_PrintVariableNPCText
	tx \1 ; text 1
	tx \2 ; text 2
ENDM

MACRO ask_question
	run_command ScriptCommand_AskQuestion
	tx \1 ; text
	db \2 ; 0: default "yes", 1: default "no"
ENDM

MACRO script_jump
	run_command ScriptCommand_ScriptJump
	dw \1 ; script
ENDM

MACRO script_jump_if_b0nz
	run_command ScriptCommand_ScriptJump_b0nz
	dw \1 ; script
ENDM

MACRO script_jump_if_b0z
	run_command ScriptCommand_ScriptJump_b0z
	dw \1 ; script
ENDM

MACRO script_jump_if_b1nz
	run_command ScriptCommand_ScriptJump_b1nz
	dw \1 ; script
ENDM

MACRO script_jump_if_b1z
	run_command ScriptCommand_ScriptJump_b1z
	dw \1 ; script
ENDM

MACRO compare_loaded_var
	run_command ScriptCommand_CompareLoadedVar
	db \1 ; value to compare
ENDM

MACRO set_event
	run_command ScriptCommand_SetEvent
	db \1 ; event to set
ENDM

MACRO reset_event
	run_command ScriptCommand_ResetEvent
	db \1 ; event to reset
ENDM

MACRO check_event
	run_command ScriptCommand_CheckEvent
	db \1 ; event to check
ENDM

MACRO set_var
	run_command ScriptCommand_SetVar
	db \1 ; var to set
	db \2 ; value to set it to
ENDM

MACRO get_var
	run_command ScriptCommand_GetVar
	db \1 ; var to get
ENDM

MACRO inc_var
	run_command ScriptCommand_IncVar
	db \1 ; var to inc
ENDM

MACRO dec_var
	run_command ScriptCommand_DecVar
	db \1 ; var to dec
ENDM

MACRO load_npc
	run_command ScriptCommand_LoadNPC
	db \1     ; npc to load
	db \2, \3 ; position
	db \4     ; direction
ENDM

MACRO unload_npc
	run_command ScriptCommand_UnloadNPC
	db \1 ; npc to unload
ENDM

MACRO set_player_direction
	run_command ScriptCommand_SetPlayerDirection
	db \1 ; direction
ENDM

MACRO set_active_npc_direction
	run_command ScriptCommand_SetActiveNPCDirection
	db \1 ; direction
ENDM

MACRO do_frames
	run_command ScriptCommand_DoFrames
	db \1 ; number of frames
ENDM

MACRO load_tilemap
	run_command ScriptCommand_LoadTilemap
	dw \1     ; tilemap
	db \2, \3 ; position
ENDM

MACRO show_card_received_screen
	run_command ScriptCommand_ShowCardReceivedScreen
	dw \1 ; card
ENDM

MACRO set_player_position
	run_command ScriptCommand_SetPlayerPosition
	db \1, \2 ; position
ENDM

MACRO set_active_npc_position
	run_command ScriptCommand_SetActiveNPCPosition
	db \1, \2 ; position
ENDM

MACRO set_scroll_state
	run_command ScriptCommand_SetScrollState
	db \1 ; scroll state
ENDM

MACRO scroll_to_position
	run_command ScriptCommand_ScrollToPosition
	db \1, \2 ; position
ENDM

MACRO set_active_npc
	run_command ScriptCommand_SetActiveNPC
	db \1 ; npc
	tx \2 ; npc name
ENDM

MACRO set_player_position_and_direction
	run_command ScriptCommand_SetPlayerPositionAndDirection
	db \1, \2 ; position
	db \3     ; direction
ENDM

MACRO set_npc_position_and_direction
	run_command ScriptCommand_SetNPCPositionAndDirection
	db \1     ; npc
	db \2, \3 ; position
	db \4     ; direction
ENDM

MACRO fade_in
	run_command ScriptCommand_FadeIn
	db \1 ; VBlankCounter mask
	db \2 ; 0: fade from white, 1: fade from black
ENDM

MACRO fade_out
	run_command ScriptCommand_FadeOut
	db \1 ; VBlankCounter mask
	db \2 ; 0: fade to white, 1: fade to black
ENDM

MACRO set_npc_direction
	run_command ScriptCommand_SetNPCDirection
	db \1 ; npc
	db \2 ; direction
ENDM

MACRO set_npc_position
	run_command ScriptCommand_SetNPCPosition
	db \1     ; npc
	db \2, \3 ; position
ENDM

MACRO set_active_npc_position_and_direction
	run_command ScriptCommand_SetActiveNPCPositionAndDirection
	db \1, \2 ; position
	db \3     ; direction
ENDM

MACRO animate_player_movement
	run_command ScriptCommand_AnimatePlayerMovement
	db \1 ; unknown
	db \2 ; unknown
ENDM

MACRO animate_npc_movement
	run_command ScriptCommand_AnimateNPCMovement
	db \1 ; npc
	db \2 ; unknown
	db \3 ; unknown
ENDM

MACRO animate_active_npc_movement
	run_command ScriptCommand_AnimateActiveNPCMovement
	db \1 ; unknown
	db \2 ; unknown
ENDM

MACRO move_player
	run_command ScriptCommand_MovePlayer
	dw \1 ; movement data ptr
	db \2 ; 0: don't animate, 1: animate
ENDM

MACRO move_npc
	run_command ScriptCommand_MoveNPC
	db \1 ; npc
	dw \2 ; movement data ptr
ENDM

MACRO move_active_npc
	run_command ScriptCommand_MoveActiveNPC
	dw \1 ; movement data ptr
ENDM

MACRO start_duel
	run_command ScriptCommand_StartDuel
	db \1 ; deck
	db \2 ; theme
ENDM

MACRO wait_for_player_animation
	run_command ScriptCommand_WaitForPlayerAnimation
ENDM

MACRO wait_for_fade
	run_command ScriptCommand_WaitForFade
ENDM

MACRO get_card_count_in_collection_and_decks
	run_command ScriptCommand_GetCardCountInCollectionAndDecks
	dw \1 ; card
ENDM

MACRO get_card_count_in_collection
	run_command ScriptCommand_GetCardCountInCollection
	dw \1 ; card
ENDM

MACRO give_card
	run_command ScriptCommand_GiveCard
	dw \1 ; card
ENDM

MACRO take_card
	run_command ScriptCommand_TakeCard
	dw \1 ; card
ENDM

MACRO npc_ask_question
	run_command ScriptCommand_NPCAskQuestion
	tx \1 ; text
	db \2 ; 0: default "yes", 1: default "no"
ENDM

MACRO get_player_direction
	run_command ScriptCommand_GetPlayerDirection
ENDM

MACRO compare_var
	run_command ScriptCommand_CompareVar
	db \1 ; var
	db \2 ; value to compare
ENDM

MACRO get_active_npc_direction
	run_command ScriptCommand_GetActiveNPCDirection
ENDM

MACRO scroll_to_active_npc
	run_command ScriptCommand_ScrollToActiveNPC
ENDM

MACRO scroll_to_player
	run_command ScriptCommand_ScrollToPlayer
ENDM

MACRO scroll_to_npc
	run_command ScriptCommand_ScrollToNPC
	db \1 ; npc
ENDM

MACRO spin_active_npc
	run_command ScriptCommand_SpinActiveNPC
	dw \1 ; number of frames
ENDM

MACRO restore_active_npc_direction
	run_command ScriptCommand_RestoreActiveNPCDirection
ENDM

MACRO spin_active_npc_reverse
	run_command ScriptCommand_SpinActiveNPCReverse
	dw \1 ; number of frames
ENDM

MACRO reset_npc_flag6
	run_command ScriptCommand_ResetNPCFlag6
	db \1 ; npc
ENDM

MACRO set_npc_flag6
	run_command ScriptCommand_SetNPCFlag6
	db \1 ; npc
ENDM

MACRO duel_requirement_check
	run_command ScriptCommand_DuelRequirementCheck
	db \1 ; duel requirement
ENDM

MACRO get_active_npc_opposite_direction
	run_command ScriptCommand_GetActiveNPCOppositeDirection
ENDM

MACRO get_player_opposite_direction
	run_command ScriptCommand_GetPlayerOppositeDirection
ENDM

MACRO play_sfx
	run_command ScriptCommand_PlaySFX
	db \1 ; sfx
ENDM

MACRO play_sfx_and_wait
	run_command ScriptCommand_PlaySFXAndWait
	db \1 ; sfx
ENDM

MACRO set_text_ram2
	run_command ScriptCommand_SetTextRAM2
	tx \1 ; text
ENDM

MACRO set_variable_text_ram2
	run_command ScriptCommand_SetVariableTextRAM2
	tx \1 ; text 1
	tx \2 ; text 2
ENDM

MACRO wait_for_npc_animation
	run_command ScriptCommand_WaitForNPCAnimation
	db \1 ; npc
ENDM

MACRO get_player_x_position
	run_command ScriptCommand_GetPlayerXPosition
ENDM

MACRO get_player_y_position
	run_command ScriptCommand_GetPlayerYPosition
ENDM

MACRO restore_npc_direction
	run_command ScriptCommand_RestoreNPCDirection
	db \1 ; npc
ENDM

MACRO spin_npc
	run_command ScriptCommand_SpinNPC
	db \1 ; npc
	dw \2 ; number of frames
ENDM

MACRO spin_npc_reverse
	run_command ScriptCommand_SpinNPCReverse
	db \1 ; npc
	dw \2 ; number of frames
ENDM

MACRO push_var
	run_command ScriptCommand_PushVar
ENDM

MACRO pop_var
	run_command ScriptCommand_PopVar
ENDM

; call conditions
DEF b0nz EQU 1
DEF b0z  EQU 2
DEF b1nz EQU 3
DEF b1z  EQU 4

MACRO script_call
	run_command ScriptCommand_ScriptCall
	IF _NARG > 1
		dw \2 ; script
		db \1 ; condition
	ELSE
		dw \1 ; script
		db 0  ; no condition
	ENDC
ENDM

MACRO script_ret
	run_command ScriptCommand_ScriptRet
ENDM

MACRO give_coin
	run_command ScriptCommand_GiveCoin
	db \1 ; coin
ENDM

MACRO backup_active_npc
	run_command ScriptCommand_BackupActiveNPC
ENDM

MACRO load_player
	run_command ScriptCommand_LoadPlayer
	db \1, \2 ; position
	db \3     ; direction
ENDM

MACRO unload_player
	run_command ScriptCommand_UnloadPlayer
ENDM

MACRO give_booster_packs
	run_command ScriptCommand_GiveBoosterPacks
	dw \1 ; booster data ptr
ENDM

MACRO get_random
	run_command ScriptCommand_GetRandom
	db \1 ; max (exclusive)
ENDM

MACRO script_command_58
	run_command ScriptCommand_58
ENDM

MACRO set_text_ram3
	run_command ScriptCommand_SetTextRAM3
	dw \1 ; value
ENDM

MACRO quit_script
	run_command ScriptCommand_QuitScript
ENDM

MACRO play_song
	run_command ScriptCommand_PlaySong
	db \1 ; song
ENDM

MACRO resume_song
	run_command ScriptCommand_ResumeSong
ENDM

MACRO script_callfar
	run_command ScriptCommand_ScriptCallfar
	IF _NARG > 1
		dw \2       ; script
		db \1       ; bank
	ELSE
		dw \1       ; script
		db BANK(\1) ; bank
	ENDC
ENDM

MACRO script_retfar
	run_command ScriptCommand_ScriptRetfar
ENDM

MACRO card_pop
	run_command ScriptCommand_CardPop
	db \1 ; in-game Card Pop! event
ENDM

MACRO play_song_next
	run_command ScriptCommand_PlaySongNext
	db \1 ; song
ENDM

MACRO set_text_ram2b
	run_command ScriptCommand_SetTextRAM2b
	tx \1 ; text
ENDM

MACRO set_variable_text_ram2b
	run_command ScriptCommand_SetVariableTextRAM2b
	tx \1 ; text 1
	tx \2 ; text 2
ENDM

MACRO replace_npc
	run_command ScriptCommand_ReplaceNPC
	db \1 ; npc to unload
	db \2 ; npc to load
ENDM

MACRO send_mail
	run_command ScriptCommand_SendMail
	db \1
ENDM

MACRO check_npc_loaded
	run_command ScriptCommand_CheckNPCLoaded
	db \1 ; npc
ENDM

MACRO give_deck
	run_command ScriptCommand_GiveDeck
	db \1 ; deck
ENDM

MACRO script_command_67
	run_command ScriptCommand_67
	db \1
	db \2
ENDM

MACRO script_command_68
	run_command ScriptCommand_68
ENDM

MACRO print_npc_text_instant
	run_command ScriptCommand_PrintNPCTextInstant
	tx \1 ; text
ENDM

MACRO var_add
	run_command ScriptCommand_VarAdd
	db \1 ; var
	db \2 ; value to add
ENDM

MACRO var_sub
	run_command ScriptCommand_VarSub
	db \1 ; var
	db \2 ; value to subtract
ENDM

MACRO receive_card
	run_command ScriptCommand_ReceiveCard
	dw \1 ; card
ENDM

MACRO get_game_center_chips
	run_command ScriptCommand_GetGameCenterChips
ENDM

MACRO compare_loaded_var_word
	run_command ScriptCommand_CompareLoadedVarWord
	dw \1 ; value to compare
ENDM

MACRO get_game_center_banked_chips
	run_command ScriptCommand_GetGameCenterBankedChips
ENDM

MACRO game_center
	run_command ScriptCommand_GameCenter
ENDM

MACRO script_command_71
	run_command ScriptCommand_71
ENDM

MACRO give_chips
	run_command ScriptCommand_GiveChips
	dw \1
ENDM

MACRO take_chips
	run_command ScriptCommand_TakeChips
	dw \1
ENDM

MACRO load_text_ram3
	run_command ScriptCommand_LoadTextRAM3
ENDM

MACRO deposit_chips
	run_command ScriptCommand_DepositChips
ENDM

MACRO withdraw_chips
	run_command ScriptCommand_WithdrawChips
ENDM

MACRO link_duel
	run_command ScriptCommand_LinkDuel
ENDM

MACRO wait_song
	run_command ScriptCommand_WaitSong
ENDM

MACRO load_palette
	run_command ScriptCommand_LoadPalette
	dw \1 ; palette
ENDM

MACRO set_sprite_frameset
	run_command ScriptCommand_SetSpriteFrameset
	db \1 ; npc
	dw \2 ; frameset
ENDM

MACRO wait_sfx
	run_command ScriptCommand_WaitSFX
ENDM

MACRO print_text_wide_textbox
	run_command ScriptCommand_PrintTextWideTextbox
	tx \1 ; text
ENDM

MACRO wait_input
	run_command ScriptCommand_WaitInput
ENDM
