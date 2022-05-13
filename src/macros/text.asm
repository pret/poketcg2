DEF text EQUS "db TX_HALFWIDTH, "
DEF line EQUS "db TX_LINE, "
DEF done EQUS "db TX_END"

DEF half2full EQUS "db TX_HALF2FULL"

MACRO katakana
	db TX_KATAKANA
	REPT _NARG
		IF STRCMP(STRSUB(\1, 1, 4), "FW0_") == 0
			db \1
		ELIF STRCMP(STRSUB(\1, 1, 1), "<") == 0 && STRLEN(\1) > 1
			db \1
		ELSE
			FOR i, STRLEN(\1)
				db STRCAT("FW0_", STRSUB(\1, i + 1, 1))
			ENDR
		ENDC
		SHIFT
	ENDR
ENDM

MACRO hiragana
	db TX_HIRAGANA
	REPT _NARG
		IF STRCMP(STRSUB(\1, 1, 4), "FW0_") == 0
			db \1
		ELIF STRCMP(STRSUB(\1, 1, 1), "<") == 0 && STRLEN(\1) > 1
			db \1
		ELSE
			FOR i, STRLEN(\1)
				db STRCAT("FW0_", STRSUB(\1, i + 1, 1))
			ENDR
		ENDC
		SHIFT
	ENDR
ENDM

MACRO textfw0
	REPT _NARG
		IF STRCMP(STRSUB(\1, 1, 4), "FW0_") == 0
			db \1
		ELIF STRCMP(STRSUB(\1, 1, 1), "<") == 0 && STRLEN(\1) > 1
			db \1
		ELSE
			FOR i, STRLEN(\1)
				db STRCAT("FW0_", STRSUB(\1, i + 1, 1))
			ENDR
		ENDC
		SHIFT
	ENDR
ENDM

MACRO textfw1
	REPT _NARG
		IF STRCMP(STRSUB(\1, 1, 4), "FW1_") == 0
			db TX_FULLWIDTH1, \1
		ELIF STRCMP(STRSUB(\1, 1, 1), "<") == 0 && STRLEN(\1) > 1
			db \1
		ELSE
			FOR i, STRLEN(\1)
				IF STRCMP(STRSUB(\1, i + 1, 1), " ") == 0
					db STRCAT("FW0_", STRSUB(\1, i + 1, 1))
				ELSE
					db TX_FULLWIDTH1, STRCAT("FW1_", STRSUB(\1, i + 1, 1))
				ENDC
			ENDR
		ENDC
		SHIFT
	ENDR
ENDM

MACRO textfw2
	REPT _NARG
		IF STRCMP(STRSUB(\1, 1, 4), "FW2_") == 0
			db TX_FULLWIDTH2, \1
		ELIF STRCMP(STRSUB(\1, 1, 1), "<") == 0 && STRLEN(\1) > 1
			db \1
		ELSE
			FOR i, STRLEN(\1)
				IF STRCMP(STRSUB(\1, i + 1, 1), " ") == 0
					db STRCAT("FW0_", STRSUB(\1, i + 1, 1))
				ELSE
					db TX_FULLWIDTH2, STRCAT("FW2_", STRSUB(\1, i + 1, 1))
				ENDC
			ENDR
		ENDC
		SHIFT
	ENDR
ENDM

MACRO textfw3
	REPT _NARG
		IF STRCMP(STRSUB(\1, 1, 4), "FW3_") == 0
			db TX_FULLWIDTH3, \1
		ELIF STRCMP(STRSUB(\1, 1, 1), "<") == 0 && STRLEN(\1) > 1
			db \1
		ELSE
			FOR i, STRLEN(\1)
				IF STRCMP(STRSUB(\1, i + 1, 1), " ") == 0
					db STRCAT("FW0_", STRSUB(\1, i + 1, 1))
				ELSE
					db TX_FULLWIDTH3, STRCAT("FW3_", STRSUB(\1, i + 1, 1))
				ENDC
			ENDR
		ENDC
		SHIFT
	ENDR
ENDM

MACRO textfw4
	REPT _NARG
		IF STRCMP(STRSUB(\1, 1, 4), "FW4_") == 0
			db TX_FULLWIDTH4, \1
		ELIF STRCMP(STRSUB(\1, 1, 1), "<") == 0 && STRLEN(\1) > 1
			db \1
		ELSE
			FOR i, STRLEN(\1)
				IF STRCMP(STRSUB(\1, i + 1, 1), " ") == 0
					db STRCAT("FW0_", STRSUB(\1, i + 1, 1))
				ELSE
					db TX_FULLWIDTH4, STRCAT("FW4_", STRSUB(\1, i + 1, 1))
				ENDC
			ENDR
		ENDC
		SHIFT
	ENDR
ENDM

MACRO ldfw3
	ld \1, (TX_FULLWIDTH3 << 8) | STRCAT("FW3_", \2)
ENDM
