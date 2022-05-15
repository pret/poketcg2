OpenDuelCheckMenu:
	ldh a, [hBankROM]
	push af
	ld a, $02 ; BANK(_OpenDuelCheckMenu)
	call BankswitchROM
	call $4000 ; _OpenDuelCheckMenu
	pop af
	call BankswitchROM
	ret

OpenInPlayAreaScreen_FromSelectButton:
	ldh a, [hBankROM]
	push af
	ld a, $06 ; BANK(OpenInPlayAreaScreen)
	call BankswitchROM
	ld a, $1
	ld [wInPlayAreaFromSelectButton], a
	call $4000 ; OpenInPlayAreaScreen
	pop bc
	ld a, b
	call BankswitchROM
	ret

; loads tiles and icons to display Your Play Area / Opp. Play Area screen,
; and draws the screen according to the turn player
; input: h -> [wCheckMenuPlayAreaWhichDuelist] and l -> [wCheckMenuPlayAreaWhichLayout]
; similar to DrawYourOrOppPlayArea (bank 2) except it also draws a wide text box.
; this is because bank 2's DrawYourOrOppPlayArea is supposed to come from the Check Menu,
; so the text box is always already there.
DrawYourOrOppPlayAreaScreen_Bank0:
	ld a, h
	ld [wCheckMenuPlayAreaWhichDuelist], a
	ld a, l
	ld [wCheckMenuPlayAreaWhichLayout], a
	ldh a, [hBankROM]
	push af
	ld a, $02 ; BANK(_DrawYourOrOppPlayAreaScreen)
	call BankswitchROM
	call $4321 ; _DrawYourOrOppPlayAreaScreen
	call DrawWideTextBox
	pop af
	call BankswitchROM
	ret

DrawPlayersPrizeAndBenchCards:
	ldh a, [hBankROM]
	push af
	ld a, $02 ; BANK(_DrawPlayersPrizeAndBenchCards)
	call BankswitchROM
	call $4453 ; _DrawPlayersPrizeAndBenchCards
	pop af
	call BankswitchROM
	ret

HandlePeekSelection:
	ldh a, [hBankROM]
	push af
	ld a, $02 ; BANK(_HandlePeekSelection)
	call BankswitchROM
	call $48a7 ; _HandlePeekSelection
	ld b, a
	pop af
	call BankswitchROM
	ld a, b
	ret

DrawAIPeekScreen:
	ld b, a
	ldh a, [hBankROM]
	push af
	ld a, $02 ; BANK(_DrawAIPeekScreen)
	call BankswitchROM
	call $4a6e ; _DrawAIPeekScreen
	pop af
	call BankswitchROM
	ret

; a = number of prize cards for player to select to take
SelectPrizeCards:
	ld [wNumberOfPrizeCardsToSelect], a
	ldh a, [hBankROM]
	push af
	ld a, $02 ; BANK(_SelectPrizeCards)
	call BankswitchROM
	call $4be6 ; _SelectPrizeCards
	pop af
	call BankswitchROM
	ret

DrawPlayAreaToPlacePrizeCards:
	ldh a, [hBankROM]
	push af
	ld a, $02 ; BANK(_DrawPlayAreaToPlacePrizeCards)
	call BankswitchROM
	call $4d4b ; _DrawPlayAreaToPlacePrizeCards
	pop af
	call BankswitchROM
	ret
