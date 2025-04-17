MACRO const_def
	IF _NARG > 0
		DEF const_value = \1
	ELSE
		DEF const_value = 0
	ENDC
ENDM

MACRO const
	DEF \1 EQU const_value
	DEF const_value = const_value + 1
ENDM

MACRO const_skip
	if _NARG > 0
		DEF const_value += \1
	else
		DEF const_value += 1
	endc
ENDM
