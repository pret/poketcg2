; Save a pointer to a list, given at de, to wListPointer
SetListPointer::
	push hl
	ld hl, wListPointer
SetListPointer_Common:
	ld [hl], e
	inc hl
	ld [hl], d
	pop hl
	ret

SetListPointer2::
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
SetNextElementOfList::
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

SetNextElementOfList2::
	push hl
	push de
	ld hl, wListPointer2
	jr SetNextElementOfList_Common

GetNextWordOfList:
	push hl
	push bc
	ld hl, wListPointer
GetNextWordOfList_Common:
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld a, [bc]
	ld e, a
	inc bc
	ld a, [bc]
	ld d, a
	inc bc
SetListToNextWordPosition:
	ld [hl], b
	dec hl
	ld [hl], c
	pop bc
	pop hl
	ret

GetNextWordOfList2:
	push hl
	push bc
	ld hl, wListPointer2
	jr GetNextWordOfList_Common

SetNextWordOfList:
	push hl
	push bc
	ld hl, wListPointer
SetNextWordOfList_Common:
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld a, e
	ld [bc], a
	inc bc
	ld a, d
	ld [bc], a
	inc bc
	jr SetListToNextWordPosition

SetNextWordOfList2::
	push hl
	push bc
	ld hl, wListPointer2
	jr SetNextWordOfList_Common

AddToListPointer:
	push hl
	ld hl, wListPointer
AddToListPointer_Common:
	add [hl]
	ld [hli], a
	ld a, [hl]
	adc $00
	ld [hl], a
	pop hl
	ret

AddToListPointer2:
	push hl
	ld hl, wListPointer2
	jr AddToListPointer_Common
