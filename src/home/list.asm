; Save a pointer to a list, given at de, to wListPointer
SetListPointer:
	push hl
	ld hl, wListPointer
SetListPointer_Common:
	ld [hl], e
	inc hl
	ld [hl], d
	pop hl
	ret

SetListPointer2:
	push hl
	ld hl, wListPointer2
	jr SetListPointer_Common

; Return the current element of the list at wListPointer,
; and advance the list to the next element
GetNextElementOfList:
	push hl
	push de
	ld hl, wListPointer
GetNextElementOfList_Common:
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, [de]
	inc de
;	fallthrough

SetListToNextPosition:
	ld [hl], d
	dec hl
	ld [hl], e
	pop de
	pop hl
	ret

GetNextElementOfList2:
	push hl
	push de
	ld hl, wListPointer2
	jr GetNextElementOfList_Common

; Set the current element of the list at wListPointer to a,
; and advance the list to the next element
SetNextElementOfList:
	push hl
	push de
	ld hl, wListPointer
SetNextElementOfList_Common:
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld [de], a
	inc de
	jr SetListToNextPosition

SetNextElementOfList2:
	push hl
	push de
	ld hl, wListPointer2
	jr SetNextElementOfList_Common

Func_0b6e:
	push hl
	push bc
	ld hl, wListPointer
Func_0b73:
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld a, [bc]
	ld e, a
	inc bc
	ld a, [bc]
	ld d, a
	inc bc
Func_0b7c:
	ld [hl], b
	dec hl
	ld [hl], c
	pop bc
	pop hl
	ret

Func_0b82:
	push hl
	push bc
	ld hl, wListPointer2
	jr Func_0b73

Func_0b89:
	push hl
	push bc
	ld hl, wListPointer
Func_0b8e:
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld a, e
	ld [bc], a
	inc bc
	ld a, d
	ld [bc], a
	inc bc
	jr Func_0b7c

Func_0b99:
	push hl
	push bc
	ld hl, wListPointer2
	jr Func_0b8e

Func_0ba0:
	push hl
	ld hl, wListPointer
Func_0ba4:
	add [hl]
	ld [hli], a
	ld a, [hl]
	adc $00
	ld [hl], a
	pop hl
	ret

Func_0bac:
	push hl
	ld hl, wListPointer2
	jr Func_0ba4
