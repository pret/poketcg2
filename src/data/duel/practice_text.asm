PracticeDuelTextPointerTable:
	dw PracticeDuelText_Turn1
	dw PracticeDuelText_Turn2
	dw PracticeDuelText_Turn3
	dw PracticeDuelText_Turn4
	dw PracticeDuelText_Turn5
	dw PracticeDuelText_Turn6

MACRO practicetext
	db \1 ; Y coord to place the point-by-point instruction
	tx \2 ; Dr. Mason's instruction
	tx \3 ; static point-by-point instruction
ENDM

PracticeDuelText_Turn1:
	practicetext 2, PracticeDuelTurn1Mason1Text, PracticeDuelTurn1Instr1Text
	practicetext 5, PracticeDuelTurn1Mason2Text, PracticeDuelTurn1Instr2Text
	practicetext 8, PracticeDuelTurn1Mason3Text, PracticeDuelTurn1Instr3Text
	db $00

PracticeDuelText_Turn2:
	practicetext 2, PracticeDuelTurn2Mason1Text, PracticeDuelTurn2Instr1Text
	practicetext 5, PracticeDuelTurn2Mason2Text, PracticeDuelTurn2Instr2Text
	db $00

PracticeDuelText_Turn3:
	practicetext 2, PracticeDuelTurn3Mason1Text, PracticeDuelTurn3Instr1Text
	practicetext 5, PracticeDuelTurn3Mason2Text, PracticeDuelTurn3Instr2Text
	practicetext 8, PracticeDuelTurn3Mason3Text, PracticeDuelTurn3Instr3Text
	db $00

PracticeDuelText_Turn4:
	practicetext 2, PracticeDuelTurn4Mason1Text, PracticeDuelTurn4Instr1Text
	practicetext 5, PracticeDuelTurn4Mason2Text, PracticeDuelTurn4Instr2Text
	practicetext 8, PracticeDuelTurn4Mason3Text, PracticeDuelTurn4Instr3Text
	db $00

PracticeDuelText_Turn5:
	practicetext 2, PracticeDuelTurn5Mason1Text, PracticeDuelTurn5Instr1Text
	practicetext 5, PracticeDuelTurn5Mason2Text, PracticeDuelTurn5Instr2Text
	practicetext 8, PracticeDuelTurn5Mason3Text, PracticeDuelTurn5Instr3Text
	db $00

PracticeDuelText_Turn6:
	practicetext 2, PracticeDuelTurn6Mason1Text, PracticeDuelTurn6Instr1Text
	practicetext 5, PracticeDuelTurn6Mason2Text, PracticeDuelTurn6Instr2Text
	practicetext 8, PracticeDuelTurn6Mason3Text, PracticeDuelTurn6Instr3Text
	db $00

PracticeDuelText_SamTurn4:
	practicetext 2, PracticeDuelKnockedOutMason1Text, PracticeDuelKnockedOutInstr1Text
	practicetext 6, PracticeDuelKnockedOutMason2Text, PracticeDuelKnockedOutInstr2Text
	db $00
