Tilemap000:
	db 20 ; width
	db 18 ; height
	dw Permissions000
	db $1 ; unknown
	INCBIN "data/maps/tiles/tilemap000.bin"
Permissions000:
	INCBIN "data/maps/permissions/permissions000.bin"

Tilemap001:
	db 13 ; width
	db 3 ; height
	dw Permissions001
	db $1 ; unknown
	INCBIN "data/maps/tiles/tilemap001.bin"
Permissions001:
	INCBIN "data/maps/permissions/permissions001.bin"

Tilemap002:
	db 13 ; width
	db 3 ; height
	dw Permissions002
	db $1 ; unknown
	INCBIN "data/maps/tiles/tilemap002.bin"
Permissions002:
	INCBIN "data/maps/permissions/permissions002.bin"

Tilemap004:
	db 13 ; width
	db 3 ; height
	dw Permissions004
	db $1 ; unknown
	INCBIN "data/maps/tiles/tilemap004.bin"
Permissions004:
	INCBIN "data/maps/permissions/permissions004.bin"

Tilemap005:
	db 28 ; width
	db 30 ; height
	dw Permissions005
	db $1 ; unknown
	INCBIN "data/maps/tiles/tilemap005.bin"
Permissions005:
	INCBIN "data/maps/permissions/permissions005.bin"

Tilemap00C:
	db 16 ; width
	db 3 ; height
	dw Permissions00C
	db $1 ; unknown
	INCBIN "data/maps/tiles/tilemap00C.bin"
Permissions00C:
	INCBIN "data/maps/permissions/permissions00C.bin"

Tilemap01A:
	db 4 ; width
	db 3 ; height
	dw Permissions01A
	db $1 ; unknown
	INCBIN "data/maps/tiles/tilemap01A.bin"
Permissions01A:
	INCBIN "data/maps/permissions/permissions01A.bin"
