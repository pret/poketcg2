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
	practicetext 2, Text0502, Text04ff
	practicetext 5, Text0503, Text0500
	practicetext 8, Text0504, Text0501
	db $00

PracticeDuelText_Turn2:
	practicetext 2, Text050a, Text0508
	practicetext 5, Text050b, Text0509
	db $00

PracticeDuelText_Turn3:
	practicetext 2, Text050f, Text050c
	practicetext 5, Text0510, Text050d
	practicetext 8, Text0511, Text050e
	db $00

PracticeDuelText_Turn4:
	practicetext 2, Text0515, Text0512
	practicetext 5, Text0516, Text0513
	practicetext 8, Text0517, Text0514
	db $00

PracticeDuelText_Turn5:
	practicetext 2, Text0520, Text051d
	practicetext 5, Text0521, Text051e
	practicetext 8, Text0522, Text051f
	db $00

PracticeDuelText_Turn6:
	practicetext 2, Text0526, Text0523
	practicetext 5, Text0527, Text0524
	practicetext 8, Text0528, Text0525
	db $00

PracticeDuelText_SamTurn4:
	practicetext 2, Text051a, Text0518
	practicetext 6, Text051b, Text0519
	db $00
