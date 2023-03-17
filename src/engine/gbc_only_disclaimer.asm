GBCOnlyDisclaimer:
	xor a
	ld [wTileMapFill], a
	call EmptyScreen
	ld a, SCENE_GBC_ONLY_DISCLAIMER
	lb bc, 0, 0
	call LoadScene
	lb de, $30, $5f
	call SetupText
	lb de, 3, 9
	ldtx hl, Text00f9
	call InitTextPrinting_ProcessTextFromID
	bank1call ZeroObjectPositionsAndToggleOAMCopy
	call EnableLCD
.loop
	call DoFrame
	jr .loop
