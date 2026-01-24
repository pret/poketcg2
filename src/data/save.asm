MACRO wram_sram_map
	dw \1 ; WRAM address
	dw \2 ; number of bytes
	db \3 ; min allowed value
	db \4 ; max allowed value
ENDM

; maps WRAM addresses to SRAM addresses in order
; to save and subsequently retrieve them on game load
; in tcg1, it used to check if the values saved in SRAM
; were valid within the given range,
; but the valid range is now $00–$ff (anything) for all values

; 441 bytes
WRAMToSRAMMapper_GeneralSave::
	wram_sram_map wPlayTimeCounter + 0,                       1, $00, $ff
	wram_sram_map wPlayTimeCounter + 1,                       1, $00, $ff
	wram_sram_map wPlayTimeCounter + 2,                       1, $00, $ff
	wram_sram_map wPlayTimeCounter + 3,                       2, $00, $ff
	wram_sram_map wCurMusic,                                  1, $00, $ff
	wram_sram_map wNextGameEvent,                             1, $00, $ff
	wram_sram_map wNextWarpMap,                               1, $00, $ff
	wram_sram_map wd54e,                                      2, $00, $ff
	wram_sram_map wPlayerOWObject,                            1, $00, $ff
	wram_sram_map wCurMapScriptsBank,                         1, $00, $ff
	wram_sram_map wCurMapScriptsPointer,                      2, $00, $ff
	wram_sram_map wOverworldMode,                             1, $00, $ff
	wram_sram_map wOverworldTransition,                       1, $00, $ff
	wram_sram_map wPrevMap,                                   1, $00, $ff
	wram_sram_map wTempPrevMap,                               1, $00, $ff
	wram_sram_map wCurMap,                                    1, $00, $ff
	wram_sram_map wCurOWLocation,                             1, $00, $ff
	wram_sram_map wCurIsland,                                 1, $00, $ff
	wram_sram_map wPlayerOWLocation,                          1, $00, $ff
	wram_sram_map wNextMapHeaderData,    MAPHEADERSTRUCT_LENGTH, $00, $ff
	wram_sram_map wNextWarpPlayerData,                        3, $00, $ff
	wram_sram_map wScriptNPC,                                 1, $00, $ff
	wram_sram_map wScriptNPCName,                             2, $00, $ff
	wram_sram_map wSentMailBitfield,                          4, $00, $ff
	wram_sram_map wTempCardDungeonBet,                        1, $00, $ff
	wram_sram_map wEventVars,               EVENT_VAR_BYTES - 2, $00, $ff
	wram_sram_map wGeneralVars,           GENERAL_VAR_BYTES - 2, $00, $ff
	wram_sram_map wOWData,                                  177, $00, $ff
	wram_sram_map wd98b,                 5 * MAX_NUM_OW_OBJECTS, $00, $ff
	wram_sram_map wScrollTargetObject,                        1, $00, $ff
	wram_sram_map wSelectedCoin,                              1, $00, $ff
	wram_sram_map wCoinPage,                                  1, $00, $ff
	wram_sram_map wPauseMenuCursorPosition,                   1, $00, $ff
	wram_sram_map wMinicomMenuCursorPosition,                 1, $00, $ff
	wram_sram_map wdc06,                                      1, $00, $ff
	wram_sram_map wNumMailInQueue,                            1, $00, $ff
	wram_sram_map wMailQueue,            MAIL_QUEUE_BUFFER_SIZE, $00, $ff
	wram_sram_map wMailCount,                                 1, $00, $ff
	wram_sram_map wMailList,                   MAIL_BUFFER_SIZE, $00, $ff
	wram_sram_map wNewMail,                                   1, $00, $ff
	wram_sram_map wTempNumMailInQueue,                        1, $00, $ff
	wram_sram_map wMailboxPage,                               1, $00, $ff
	wram_sram_map wSelectedMailCursorPosition,                1, $00, $ff
	wram_sram_map wMailOptionSelected,                        1, $00, $ff
	wram_sram_map wBlackBoxCardReceived, BLACK_BOX_OUTPUT_BYTES, $00, $ff
	wram_sram_map wBillsPCCardReceived,                       2, $00, $ff
	wram_sram_map wPCMenuCursorPosition,                      1, $00, $ff
	wram_sram_map wGameCenterChips,                           2, $00, $ff
	wram_sram_map wGameCenterBankedChips,                     2, $00, $ff
	wram_sram_map wdb1f,                                      1, $00, $ff
	wram_sram_map wOWObj1Flags,                               1, $00, $ff
	dw NULL

; 64 bytes
WRAMToSRAMMapper_ChallengeMachineSave::
	wram_sram_map wChallengeMachineOpponentTitlesAndNames, 4 * NUM_CHALLENGE_MACHINE_ROUNDS_PER_SET, $00, $ff
	wram_sram_map wChallengeMachineSetsWonRecords,                                            2 * 2, $00, $ff
	wram_sram_map wChallengeMachineCurWinStreaks,                                             2 * 2, $00, $ff
	wram_sram_map wChallengeMachineWinStreakRecords,                                          2 * 2, $00, $ff
	wram_sram_map wChallengeMachinePlayerNames,                              NAME_BUFFER_LENGTH * 2, $00, $ff
	dw NULL
