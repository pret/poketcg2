; \1 = x coordinate
; \2 = y coordinate
; \3 = a register passed to function
; \4-\5 = de register passed to function
; \6 = b register passed to function
; \7-\9 = function to call
MACRO _ow_coordinate_function ; 9 bytes
	db \1, \2
	db \3
	db \4, \5
	db \6

	IF _NARG == 7
		dba \7
	ELIF _NARG == 8
		dbw \7, \8
	ELSE
		db \7, \8, \9
	ENDC
ENDM

; \1 = x coordinate of exit
; \2 = y coordinate of exit
; \3 = destination map id
; \4 = x coordinate to load player in dest map
; \5 = y coordinate to load player in dest map
; \6 = direction player faces when loaded in dest map
MACRO map_exit ; 9 bytes
	_ow_coordinate_function \1, \2, \3, \4, \5, \6, SetWarpData
ENDM

; \1 = NPC_* object id
; \2 = x coordinate
; \3 = y coordinate
; \4 = direction
; \5-\6 = addr of function that decides if NPC should be loaded (this bank)
MACRO npc ; 6 bytes
	db \1
	db \2, \3
	db \4

	IF _NARG == 5
		dw \5
	ELSE
		db \5, \6
	ENDC
ENDM

; \1 = NPC_* object id
; \2-\4 = bank, address of NPC function
MACRO npc_script ; 4 bytes
	db \1

	IF _NARG == 2
		dba \2
	ELIF _NARG == 3
		dbw \2, \3
	ELSE
		db \2, \3, \4
	ENDC
ENDM

; \1 = x coordinate of interaction hotspot
; \2 = y coordinate of interaction hotspot
; \3-\5 = bank, addr of function
MACRO ow_script ; 9 bytes
	IF _NARG == 3
		_ow_coordinate_function \1, \2, 0, 0, 0, 0, \3
	ELIF _NARG == 4
		_ow_coordinate_function \1, \2, 0, 0, 0, 0, \3, \4
	ELSE
		_ow_coordinate_function \1, \2, 0, 0, 0, 0, \3, \4, \5
	ENDC
ENDM
