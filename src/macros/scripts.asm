MACRO start_script
	call Func_33f2
ENDM

MACRO run_command
	db \1_index
ENDM

	const_def
	const ScriptCommand_00_index ; $00
	const ScriptCommand_01_index ; $01
	const ScriptCommand_02_index ; $02
	const ScriptCommand_03_index ; $03
	const ScriptCommand_04_index ; $04
	const ScriptCommand_05_index ; $05
	const ScriptCommand_06_index ; $06
	const ScriptCommand_07_index ; $07
	const ScriptCommand_08_index ; $08
	const ScriptCommand_09_index ; $09
	const ScriptCommand_0A_index ; $0a
	const ScriptCommand_0B_index ; $0b
	const ScriptCommand_0C_index ; $0c
	const ScriptCommand_0D_index ; $0d
	const ScriptCommand_0E_index ; $0e
	const ScriptCommand_0F_index ; $0f
	const ScriptCommand_10_index ; $10
	const ScriptCommand_11_index ; $11
	const ScriptCommand_12_index ; $12
	const ScriptCommand_13_index ; $13
	const ScriptCommand_14_index ; $14
	const ScriptCommand_15_index ; $15
	const ScriptCommand_16_index ; $16
	const ScriptCommand_17_index ; $17
	const ScriptCommand_18_index ; $18
	const ScriptCommand_19_index ; $19
	const ScriptCommand_1A_index ; $1a
	const ScriptCommand_1B_index ; $1b
	const ScriptCommand_1C_index ; $1c
	const ScriptCommand_1D_index ; $1d
	const ScriptCommand_1E_index ; $1e
	const ScriptCommand_1F_index ; $1f
	const ScriptCommand_20_index ; $20
	const ScriptCommand_21_index ; $21
	const ScriptCommand_22_index ; $22
	const ScriptCommand_23_index ; $23
	const ScriptCommand_24_index ; $24
	const ScriptCommand_25_index ; $25
	const ScriptCommand_26_index ; $26
	const ScriptCommand_27_index ; $27
	const ScriptCommand_28_index ; $28
	const ScriptCommand_29_index ; $29
	const ScriptCommand_2A_index ; $2a
	const ScriptCommand_2B_index ; $2b
	const ScriptCommand_2C_index ; $2c
	const ScriptCommand_2D_index ; $2d
	const ScriptCommand_2E_index ; $2e
	const ScriptCommand_2F_index ; $2f
	const ScriptCommand_30_index ; $30
	const ScriptCommand_31_index ; $31
	const ScriptCommand_32_index ; $32
	const ScriptCommand_33_index ; $33
	const ScriptCommand_34_index ; $34
	const ScriptCommand_35_index ; $35
	const ScriptCommand_36_index ; $36
	const ScriptCommand_37_index ; $37
	const ScriptCommand_38_index ; $38
	const ScriptCommand_39_index ; $39
	const ScriptCommand_3A_index ; $3a
	const ScriptCommand_3B_index ; $3b
	const ScriptCommand_3C_index ; $3c
	const ScriptCommand_3D_index ; $3d
	const ScriptCommand_3E_index ; $3e
	const ScriptCommand_3F_index ; $3f
	const ScriptCommand_40_index ; $40
	const ScriptCommand_41_index ; $41
	const ScriptCommand_42_index ; $42
	const ScriptCommand_43_index ; $43
	const ScriptCommand_44_index ; $44
	const ScriptCommand_45_index ; $45
	const ScriptCommand_46_index ; $46
	const ScriptCommand_47_index ; $47
	const ScriptCommand_48_index ; $48
	const ScriptCommand_49_index ; $49
	const ScriptCommand_4A_index ; $4a
	const ScriptCommand_4B_index ; $4b
	const ScriptCommand_4C_index ; $4c
	const ScriptCommand_4D_index ; $4d
	const ScriptCommand_4E_index ; $4e
	const ScriptCommand_4F_index ; $4f
	const ScriptCommand_50_index ; $50
	const ScriptCommand_51_index ; $51
	const ScriptCommand_52_index ; $52
	const ScriptCommand_53_index ; $53
	const ScriptCommand_54_index ; $54
	const ScriptCommand_55_index ; $55
	const ScriptCommand_56_index ; $56
	const ScriptCommand_57_index ; $57
	const ScriptCommand_58_index ; $58
	const ScriptCommand_59_index ; $59
	const ScriptCommand_5A_index ; $5a
	const ScriptCommand_5B_index ; $5b
	const ScriptCommand_5C_index ; $5c
	const ScriptCommand_5D_index ; $5d
	const ScriptCommand_5E_index ; $5e
	const ScriptCommand_5F_index ; $5f
	const ScriptCommand_60_index ; $60
	const ScriptCommand_61_index ; $61
	const ScriptCommand_62_index ; $62
	const ScriptCommand_63_index ; $63
	const ScriptCommand_64_index ; $64
	const ScriptCommand_65_index ; $65
	const ScriptCommand_66_index ; $66
	const ScriptCommand_67_index ; $67
	const ScriptCommand_68_index ; $68
	const ScriptCommand_69_index ; $69
	const ScriptCommand_6A_index ; $6a
	const ScriptCommand_6B_index ; $6b
	const ScriptCommand_6C_index ; $6c
	const ScriptCommand_6D_index ; $6d
	const ScriptCommand_6E_index ; $6e
	const ScriptCommand_6F_index ; $6f
	const ScriptCommand_70_index ; $70
	const ScriptCommand_71_index ; $71
	const ScriptCommand_72_index ; $72
	const ScriptCommand_73_index ; $73
	const ScriptCommand_74_index ; $74
	const ScriptCommand_75_index ; $75
	const ScriptCommand_76_index ; $76
	const ScriptCommand_77_index ; $77
	const ScriptCommand_78_index ; $78
	const ScriptCommand_79_index ; $79
	const ScriptCommand_7A_index ; $7a
	const ScriptCommand_7B_index ; $7b
	const ScriptCommand_7C_index ; $7c
	const ScriptCommand_7D_index ; $7d

DEF NUM_SCRIPT_COMMANDS EQU const_value

; Script Macros

MACRO end_script
	run_command ScriptCommand_00
ENDM

MACRO script_command_01
	run_command ScriptCommand_01
ENDM

MACRO script_command_02
	run_command ScriptCommand_02
ENDM

MACRO script_command_03
	run_command ScriptCommand_03
	tx \1
ENDM

MACRO script_command_04
	run_command ScriptCommand_04
	tx \1
	tx \2
ENDM

MACRO script_command_05
	run_command ScriptCommand_05
	tx \1
ENDM

MACRO script_command_06
	run_command ScriptCommand_06
	tx \1
	tx \2
ENDM

MACRO script_command_07
	run_command ScriptCommand_07
	tx \1
	db \2
ENDM

MACRO script_command_08
	run_command ScriptCommand_08
	dw \1
ENDM

MACRO script_command_09
	run_command ScriptCommand_09
	dw \1
ENDM

MACRO script_command_0a
	run_command ScriptCommand_0A
	dw \1
ENDM

MACRO script_command_0b
	run_command ScriptCommand_0B
	dw \1
ENDM

MACRO script_command_0c
	run_command ScriptCommand_0C
	dw \1
ENDM

MACRO script_command_0d
	run_command ScriptCommand_0D
	db \1
ENDM

MACRO script_command_0e
	run_command ScriptCommand_0E
	db \1
ENDM

MACRO script_command_0f
	run_command ScriptCommand_0F
	db \1
ENDM

MACRO script_command_10
	run_command ScriptCommand_10
	db \1
ENDM

MACRO script_command_11
	run_command ScriptCommand_11
	db \1
	db \2
ENDM

MACRO script_command_12
	run_command ScriptCommand_12
	db \1
ENDM

MACRO script_command_13
	run_command ScriptCommand_13
	db \1
ENDM

MACRO script_command_14
	run_command ScriptCommand_14
	db \1
ENDM

MACRO script_command_15
	run_command ScriptCommand_15
	db \1
	db \2
	db \3
	db \4
ENDM

MACRO script_command_16
	run_command ScriptCommand_16
	db \1
ENDM

MACRO script_command_17
	run_command ScriptCommand_17
	db \1
ENDM

MACRO script_command_18
	run_command ScriptCommand_18
	db \1
ENDM

MACRO script_command_19
	run_command ScriptCommand_19
	db \1
ENDM

MACRO script_command_1a
	run_command ScriptCommand_1A
	dw \1
	db \2
	db \3
ENDM

MACRO script_command_1b
	run_command ScriptCommand_1B
	dw \1
ENDM

MACRO script_command_1c
	run_command ScriptCommand_1C
	db \1
	db \2
ENDM

MACRO script_command_1d
	run_command ScriptCommand_1D
	db \1
	db \2
ENDM

MACRO script_command_1e
	run_command ScriptCommand_1E
	db \1
ENDM

MACRO script_command_1f
	run_command ScriptCommand_1F
	db \1
	db \2
ENDM

MACRO script_command_20
	run_command ScriptCommand_20
	db \1
	tx \2
ENDM

MACRO script_command_21
	run_command ScriptCommand_21
	db \1
	db \2
	db \3
ENDM

MACRO script_command_22
	run_command ScriptCommand_22
	db \1
	db \2
	db \3
	db \4
ENDM

MACRO script_command_23
	run_command ScriptCommand_23
	db \1
	db \2
ENDM

MACRO script_command_24
	run_command ScriptCommand_24
	db \1
	db \2
ENDM

MACRO script_command_25
	run_command ScriptCommand_25
	db \1
	db \2
ENDM

MACRO script_command_26
	run_command ScriptCommand_26
	db \1
	db \2
	db \3
ENDM

MACRO script_command_27
	run_command ScriptCommand_27
	db \1
	db \2
	db \3
ENDM

MACRO script_command_28
	run_command ScriptCommand_28
	db \1
	db \2
ENDM

MACRO script_command_29
	run_command ScriptCommand_29
	db \1
	db \2
	db \3
ENDM

MACRO script_command_2a
	run_command ScriptCommand_2A
	db \1
	db \2
ENDM

MACRO script_command_2b
	run_command ScriptCommand_2B
	dw \1
	db \2
ENDM

MACRO script_command_2c
	run_command ScriptCommand_2C
	db \1
	dw \2
ENDM

MACRO script_command_2d
	run_command ScriptCommand_2D
	dw \1
ENDM

MACRO script_command_2e
	run_command ScriptCommand_2E
	db \1
	db \2
ENDM

MACRO script_command_2f
	run_command ScriptCommand_2F
ENDM

MACRO script_command_30
	run_command ScriptCommand_30
ENDM

MACRO script_command_31
	run_command ScriptCommand_31
	dw \1
ENDM

MACRO script_command_32
	run_command ScriptCommand_32
	dw \1
ENDM

MACRO script_command_33
	run_command ScriptCommand_33
	dw \1
ENDM

MACRO script_command_34
	run_command ScriptCommand_34
	dw \1
ENDM

MACRO script_command_35
	run_command ScriptCommand_35
	tx \1
	db \2
ENDM

MACRO script_command_36
	run_command ScriptCommand_36
ENDM

MACRO script_command_37
	run_command ScriptCommand_37
	db \1
	db \2
ENDM

MACRO script_command_38
	run_command ScriptCommand_38
ENDM

MACRO script_command_39
	run_command ScriptCommand_39
ENDM

MACRO script_command_3a
	run_command ScriptCommand_3A
ENDM

MACRO script_command_3b
	run_command ScriptCommand_3B
	db \1
ENDM

MACRO script_command_3c
	run_command ScriptCommand_3C
	dw \1
ENDM

MACRO script_command_3d
	run_command ScriptCommand_3D
ENDM

MACRO script_command_3e
	run_command ScriptCommand_3E
	dw \1
ENDM

MACRO script_command_3f
	run_command ScriptCommand_3F
	db \1
ENDM

MACRO script_command_40
	run_command ScriptCommand_40
	db \1
ENDM

MACRO script_command_41
	run_command ScriptCommand_41
	db \1
ENDM

MACRO script_command_42
	run_command ScriptCommand_42
ENDM

MACRO script_command_43
	run_command ScriptCommand_43
ENDM

MACRO script_command_44
	run_command ScriptCommand_44
	db \1
ENDM

MACRO script_command_45
	run_command ScriptCommand_45
	db \1
ENDM

MACRO script_command_46
	run_command ScriptCommand_46
	tx \1
ENDM

MACRO script_command_47
	run_command ScriptCommand_47
	tx \1
	tx \2
ENDM

MACRO script_command_48
	run_command ScriptCommand_48
	db \1
ENDM

MACRO script_command_49
	run_command ScriptCommand_49
ENDM

MACRO script_command_4a
	run_command ScriptCommand_4A
ENDM

MACRO script_command_4b
	run_command ScriptCommand_4B
	db \1
ENDM

MACRO script_command_4c
	run_command ScriptCommand_4C
	db \1
	dw \2
ENDM

MACRO script_command_4d
	run_command ScriptCommand_4D
	db \1
	dw \2
ENDM

MACRO script_command_4e
	run_command ScriptCommand_4E
ENDM

MACRO script_command_4f
	run_command ScriptCommand_4F
ENDM

MACRO script_command_50
	run_command ScriptCommand_50
	dw \1
	db \2
ENDM

MACRO script_command_51
	run_command ScriptCommand_51
ENDM

MACRO script_command_52
	run_command ScriptCommand_52
	db \1
ENDM

MACRO script_command_53
	run_command ScriptCommand_53
ENDM

MACRO script_command_54
	run_command ScriptCommand_54
	db \1
	db \2
	db \3
ENDM

MACRO script_command_55
	run_command ScriptCommand_55
ENDM

MACRO script_command_56
	run_command ScriptCommand_56
	dw \1
ENDM

MACRO script_command_57
	run_command ScriptCommand_57
	db \1
ENDM

MACRO script_command_58
	run_command ScriptCommand_58
ENDM

MACRO script_command_59
	run_command ScriptCommand_59
	dw \1
ENDM

MACRO script_command_5a
	run_command ScriptCommand_5A
ENDM

MACRO script_command_5b
	run_command ScriptCommand_5B
	db \1
ENDM

MACRO script_command_5c
	run_command ScriptCommand_5C
ENDM

MACRO script_command_5d
	run_command ScriptCommand_5D
	IF _NARG > 1
		dw \2
		db \1
	ELSE
		dw \1
		db BANK(\1)
	ENDC
ENDM

MACRO script_command_5e
	run_command ScriptCommand_5E
ENDM

MACRO script_command_5f
	run_command ScriptCommand_5F
	db \1
ENDM

MACRO script_command_60
	run_command ScriptCommand_60
	db \1
ENDM

MACRO script_command_61
	run_command ScriptCommand_61
	tx \1
ENDM

MACRO script_command_62
	run_command ScriptCommand_62
	tx \1
	tx \2
ENDM

MACRO script_command_63
	run_command ScriptCommand_63
	db \1
	db \2
ENDM

MACRO script_command_64
	run_command ScriptCommand_64
	db \1
ENDM

MACRO script_command_65
	run_command ScriptCommand_65
	db \1
ENDM

MACRO script_command_66
	run_command ScriptCommand_66
	db \1
ENDM

MACRO script_command_67
	run_command ScriptCommand_67
	db \1
	db \2
ENDM

MACRO script_command_68
	run_command ScriptCommand_68
ENDM

MACRO script_command_69
	run_command ScriptCommand_69
	tx \1
ENDM

MACRO script_command_6a
	run_command ScriptCommand_6A
	db \1
	db \2
ENDM

MACRO script_command_6b
	run_command ScriptCommand_6B
	db \1
	db \1
ENDM

MACRO script_command_6c
	run_command ScriptCommand_6C
	dw \1
ENDM

MACRO script_command_6d
	run_command ScriptCommand_6D
ENDM

MACRO script_command_6e
	run_command ScriptCommand_6E
	dw \1
ENDM

MACRO script_command_6f
	run_command ScriptCommand_6F
ENDM

MACRO script_command_70
	run_command ScriptCommand_70
ENDM

MACRO script_command_71
	run_command ScriptCommand_71
ENDM

MACRO script_command_72
	run_command ScriptCommand_72
	dw \1
ENDM

MACRO script_command_73
	run_command ScriptCommand_73
	dw \1
ENDM

MACRO script_command_74
	run_command ScriptCommand_74
ENDM

MACRO script_command_75
	run_command ScriptCommand_75
ENDM

MACRO script_command_76
	run_command ScriptCommand_76
ENDM

MACRO script_command_77
	run_command ScriptCommand_77
ENDM

MACRO script_command_78
	run_command ScriptCommand_78
ENDM

MACRO script_command_79
	run_command ScriptCommand_79
	dw \1
ENDM

MACRO script_command_7a
	run_command ScriptCommand_7A
	db \1
	dw \2
ENDM

MACRO script_command_7b
	run_command ScriptCommand_7B
ENDM

MACRO script_command_7c
	run_command ScriptCommand_7C
	tx \1
ENDM

MACRO script_command_7d
	run_command ScriptCommand_7D
ENDM
