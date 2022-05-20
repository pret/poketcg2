NumberOfSFX1:
	db $a1

SFXHeaderPointers1:
	dw SfxStop
	dw Sfx01
	dw Sfx02
	dw Sfx03
	dw Sfx04
	dw Sfx05
	dw Sfx06
	dw Sfx07
	dw Sfx08
	dw Sfx09
	dw Sfx0a
	dw Sfx0b
	dw Sfx0c
	dw Sfx0d
	dw Sfx0e
	dw Sfx0f
	dw Sfx10
	dw Sfx11
	dw Sfx12
	dw Sfx13
	dw Sfx14
	dw Sfx15
	dw Sfx16
	dw Sfx17
	dw Sfx18
	dw Sfx19
	dw Sfx1a
	dw Sfx1b
	dw Sfx1c
	dw Sfx1d
	dw Sfx1e
	dw Sfx1f
	dw Sfx20
	dw Sfx21
	dw Sfx22
	dw Sfx23
	dw Sfx24
	dw Sfx25
	dw Sfx26
	dw Sfx27
	dw Sfx28
	dw Sfx29
	dw Sfx2a
	dw Sfx2b
	dw Sfx2c
	dw Sfx2d
	dw Sfx2e
	dw Sfx2f
	dw Sfx30
	dw Sfx31
	dw Sfx32
	dw Sfx33
	dw Sfx34
	dw Sfx35
	dw Sfx36
	dw Sfx37
	dw Sfx38
	dw Sfx39
	dw Sfx3a
	dw Sfx3b
	dw Sfx3c
	dw Sfx3d
	dw Sfx3e
	dw Sfx3f
	dw Sfx40
	dw Sfx41
	dw Sfx42
	dw Sfx43
	dw Sfx44
	dw Sfx45
	dw Sfx46
	dw Sfx47
	dw Sfx48
	dw Sfx49
	dw Sfx4a
	dw Sfx4b
	dw Sfx4c
	dw Sfx4d
	dw Sfx4e
	dw Sfx4f
	dw Sfx50
	dw Sfx51
	dw Sfx52
	dw Sfx53
	dw Sfx54
	dw Sfx55
	dw Sfx56
	dw Sfx57
	dw Sfx58
	dw Sfx59
	dw Sfx5a
	dw Sfx5b
	dw Sfx5c
	dw Sfx5d
	dw Sfx5e
	dw Sfx5f
	dw Sfx60
	dw Sfx61
	dw Sfx62
	dw Sfx63
	dw Sfx64
	dw Sfx65
	dw Sfx66
	dw Sfx67
	dw Sfx68
	dw Sfx69
	dw Sfx6a
	dw Sfx6b
	dw Sfx6c
	dw Sfx6d
	dw Sfx6e
	dw Sfx6f
	dw Sfx70
	dw Sfx71
	dw Sfx72
	dw Sfx73
	dw Sfx74
	dw Sfx75
	dw Sfx76
	dw Sfx77
	dw Sfx78
	dw Sfx79
	dw Sfx7a
	dw Sfx7b
	dw Sfx7c
	dw Sfx7d
	dw Sfx7e
	dw Sfx7f
	dw Sfx80
	dw Sfx81
	dw Sfx82
	dw Sfx83
	dw Sfx84
	dw Sfx85
	dw Sfx86
	dw Sfx87
	dw Sfx88
	dw Sfx89
	dw Sfx8a
	dw Sfx8b
	dw Sfx8c
	dw Sfx8d
	dw Sfx8e
	dw Sfx8f
	dw Sfx90
	dw Sfx91
	dw Sfx92
	dw Sfx93
	dw Sfx94
	dw Sfx95
	dw Sfx96
	dw Sfx97
	dw Sfx98
	dw Sfx99
	dw Sfx9a
	dw Sfx9b
	dw Sfx9c
	dw Sfx9d
	dw Sfx9e
	dw Sfx9f
	dw Sfxa0

Sfx60:
Sfx61:
Sfx62:
Sfx63:
	db BANK(Sfx60)
	db %0001
	dw Sfx60_Ch1

;SfxUnused
	db BANK(SfxUnused)
	db %0001
	dw SfxUnused_Ch1

SfxStop:
	db BANK(SfxStop)
	db %0000

Sfx01:
	db BANK(Sfx01)
	db %0001
	dw Sfx01_Ch1

Sfx02:
	db BANK(Sfx02)
	db %0001
	dw Sfx02_Ch1

Sfx03:
	db BANK(Sfx03)
	db %0001
	dw Sfx03_Ch1

Sfx04:
	db BANK(Sfx04)
	db %0001
	dw Sfx04_Ch1

Sfx05:
	db BANK(Sfx05)
	db %0001
	dw Sfx05_Ch1

Sfx06:
	db BANK(Sfx06)
	db %0001
	dw Sfx06_Ch1

Sfx07:
	db BANK(Sfx07)
	db %1000
	dw Sfx07_Ch1

Sfx08:
	db BANK(Sfx08)
	db %1000
	dw Sfx08_Ch1

Sfx09:
	db BANK(Sfx09)
	db %1000
	dw Sfx09_Ch1

Sfx0a:
	db BANK(Sfx0a)
	db %0001
	dw Sfx0a_Ch1

Sfx0b:
	db BANK(Sfx0b)
	db %0001
	dw Sfx0b_Ch1

Sfx0c:
	db BANK(Sfx0c)
	db %1000
	dw Sfx0c_Ch1

Sfx0d:
	db BANK(Sfx0d)
	db %0001
	dw Sfx0d_Ch1

Sfx0e:
	db BANK(Sfx0e)
	db %0001
	dw Sfx0e_Ch1

Sfx0f:
	db BANK(Sfx0f)
	db %1000
	dw Sfx0f_Ch1

Sfx10:
	db BANK(Sfx10)
	db %0001
	dw Sfx10_Ch1

Sfx11:
	db BANK(Sfx11)
	db %0001
	dw Sfx11_Ch1

Sfx12:
	db BANK(Sfx12)
	db %0001
	dw Sfx12_Ch1

Sfx13:
	db BANK(Sfx13)
	db %0001
	dw Sfx13_Ch1

Sfx14:
	db BANK(Sfx14)
	db %0001
	dw Sfx14_Ch1

Sfx15:
	db BANK(Sfx15)
	db %0001
	dw Sfx15_Ch1

Sfx16:
	db BANK(Sfx16)
	db %1000
	dw Sfx16_Ch1

Sfx17:
	db BANK(Sfx17)
	db %1000
	dw Sfx17_Ch1

Sfx18:
	db BANK(Sfx18)
	db %1000
	dw Sfx18_Ch1

Sfx19:
	db BANK(Sfx19)
	db %1000
	dw Sfx19_Ch1

Sfx1a:
	db BANK(Sfx1a)
	db %1000
	dw Sfx1a_Ch1

Sfx1b:
	db BANK(Sfx1b)
	db %1000
	dw Sfx1b_Ch1

Sfx1c:
	db BANK(Sfx1c)
	db %1000
	dw Sfx1c_Ch1

Sfx1d:
	db BANK(Sfx1d)
	db %1000
	dw Sfx1d_Ch1

Sfx1e:
	db BANK(Sfx1e)
	db %1000
	dw Sfx1e_Ch1

Sfx1f:
	db BANK(Sfx1f)
	db %1000
	dw Sfx1f_Ch1

Sfx20:
	db BANK(Sfx20)
	db %1000
	dw Sfx20_Ch1

Sfx21:
	db BANK(Sfx21)
	db %1000
	dw Sfx21_Ch1

Sfx22:
	db BANK(Sfx22)
	db %1000
	dw Sfx22_Ch1

Sfx23:
	db BANK(Sfx23)
	db %1000
	dw Sfx23_Ch1

Sfx24:
	db BANK(Sfx24)
	db %1000
	dw Sfx24_Ch1

Sfx25:
	db BANK(Sfx25)
	db %0001
	dw Sfx25_Ch1

Sfx26:
	db BANK(Sfx26)
	db %0001
	dw Sfx26_Ch1

Sfx27:
	db BANK(Sfx27)
	db %0001
	dw Sfx27_Ch1

Sfx28:
	db BANK(Sfx28)
	db %1001
	dw Sfx28_Ch1
	dw Sfx28_Ch2

Sfx29:
	db BANK(Sfx29)
	db %1000
	dw Sfx29_Ch1

Sfx2a:
	db BANK(Sfx2a)
	db %1000
	dw Sfx2a_Ch1

Sfx2b:
	db BANK(Sfx2b)
	db %0001
	dw Sfx2b_Ch1

Sfx2c:
	db BANK(Sfx2c)
	db %0001
	dw Sfx2c_Ch1

Sfx2d:
	db BANK(Sfx2d)
	db %1000
	dw Sfx2d_Ch1

Sfx2e:
	db BANK(Sfx2e)
	db %1000
	dw Sfx2e_Ch1

Sfx2f:
	db BANK(Sfx2f)
	db %1000
	dw Sfx2f_Ch1

Sfx30:
	db BANK(Sfx30)
	db %1000
	dw Sfx30_Ch1

Sfx31:
	db BANK(Sfx31)
	db %0001
	dw Sfx31_Ch1

Sfx32:
	db BANK(Sfx32)
	db %1001
	dw Sfx32_Ch1
	dw Sfx32_Ch2

Sfx33:
	db BANK(Sfx33)
	db %1001
	dw Sfx33_Ch1
	dw Sfx33_Ch2

Sfx34:
	db BANK(Sfx34)
	db %0001
	dw Sfx34_Ch1

Sfx35:
	db BANK(Sfx35)
	db %1000
	dw Sfx35_Ch1

Sfx36:
	db BANK(Sfx36)
	db %0001
	dw Sfx36_Ch1

Sfx37:
	db BANK(Sfx37)
	db %1001
	dw Sfx37_Ch1
	dw Sfx37_Ch2

Sfx38:
	db BANK(Sfx38)
	db %0001
	dw Sfx38_Ch1

Sfx39:
	db BANK(Sfx39)
	db %1001
	dw Sfx39_Ch1
	dw Sfx39_Ch2

Sfx3a:
	db BANK(Sfx3a)
	db %0001
	dw Sfx3a_Ch1

Sfx3b:
	db BANK(Sfx3b)
	db %0001
	dw Sfx3b_Ch1

Sfx3c:
	db BANK(Sfx3c)
	db %0001
	dw Sfx3c_Ch1

Sfx3d:
	db BANK(Sfx3d)
	db %0001
	dw Sfx3d_Ch1

Sfx3e:
	db BANK(Sfx3e)
	db %0001
	dw Sfx3e_Ch1

Sfx3f:
	db BANK(Sfx3f)
	db %1000
	dw Sfx3f_Ch1

Sfx40:
	db BANK(Sfx40)
	db %0001
	dw Sfx40_Ch1

Sfx41:
	db BANK(Sfx41)
	db %0001
	dw Sfx41_Ch1

Sfx42:
	db BANK(Sfx42)
	db %0001
	dw Sfx42_Ch1

Sfx43:
	db BANK(Sfx43)
	db %1000
	dw Sfx43_Ch1

Sfx44:
	db BANK(Sfx44)
	db %1000
	dw Sfx44_Ch1

Sfx45:
	db BANK(Sfx45)
	db %0001
	dw Sfx45_Ch1

Sfx46:
	db BANK(Sfx46)
	db %0001
	dw Sfx46_Ch1

Sfx47:
	db BANK(Sfx47)
	db %1000
	dw Sfx47_Ch1

Sfx48:
	db BANK(Sfx48)
	db %1000
	dw Sfx48_Ch1

Sfx49:
	db BANK(Sfx49)
	db %0001
	dw Sfx49_Ch1

Sfx4a:
	db BANK(Sfx4a)
	db %0001
	dw Sfx4a_Ch1

Sfx4b:
	db BANK(Sfx4b)
	db %1000
	dw Sfx4b_Ch1

Sfx4c:
	db BANK(Sfx4c)
	db %0001
	dw Sfx4c_Ch1

Sfx4d:
	db BANK(Sfx4d)
	db %0001
	dw Sfx4d_Ch1

Sfx4e:
	db BANK(Sfx4e)
	db %0001
	dw Sfx4e_Ch1

Sfx4f:
	db BANK(Sfx4f)
	db %0001
	dw Sfx4f_Ch1

Sfx50:
	db BANK(Sfx50)
	db %1001
	dw Sfx50_Ch1
	dw Sfx50_Ch2

Sfx51:
	db BANK(Sfx51)
	db %1001
	dw Sfx51_Ch1
	dw Sfx51_Ch2

Sfx52:
	db BANK(Sfx52)
	db %1001
	dw Sfx52_Ch1
	dw Sfx52_Ch2

Sfx53:
	db BANK(Sfx53)
	db %1001
	dw Sfx53_Ch1
	dw Sfx53_Ch2

Sfx54:
	db BANK(Sfx54)
	db %0001
	dw Sfx54_Ch1

Sfx55:
	db BANK(Sfx55)
	db %0001
	dw Sfx55_Ch1

Sfx56:
	db BANK(Sfx56)
	db %0001
	dw Sfx56_Ch1

Sfx57:
	db BANK(Sfx57)
	db %0001
	dw Sfx57_Ch1

Sfx58:
	db BANK(Sfx58)
	db %0001
	dw Sfx58_Ch1

Sfx59:
	db BANK(Sfx59)
	db %0001
	dw Sfx59_Ch1

Sfx5a:
	db BANK(Sfx5a)
	db %0001
	dw Sfx5a_Ch1

Sfx5b:
	db BANK(Sfx5b)
	db %0001
	dw Sfx5b_Ch1

Sfx5c:
	db BANK(Sfx5c)
	db %1000
	dw Sfx5c_Ch1

Sfx5d:
	db BANK(Sfx5d)
	db %1011
	dw Sfx5d_Ch1
	dw Sfx5d_Ch2
	dw Sfx5d_Ch3

Sfx5e:
	db BANK(Sfx5e)
	db %0001
	dw Sfx5e_Ch1

Sfx5f:
	db BANK(Sfx5f)
	db %1000
	dw Sfx5f_Ch1

;Sfx64
	db BANK(Sfx64)
	db %1001
	dw Sfx64_Ch1
	dw Sfx64_Ch2

;Sfx65
	db BANK(Sfx65)
	db %1001
	dw Sfx65_Ch1
	dw Sfx65_Ch2

;Sfx66
	db BANK(Sfx66)
	db %0001
	dw Sfx66_Ch1

;Sfx67
	db BANK(Sfx67)
	db %1001
	dw Sfx67_Ch1
	dw Sfx67_Ch2

;Sfx68
	db BANK(Sfx68)
	db %1001
	dw Sfx68_Ch1
	dw Sfx68_Ch2

;Sfx69
	db BANK(Sfx69)
	db %1001
	dw Sfx69_Ch1
	dw Sfx69_Ch2

;Sfx6a
	db BANK(Sfx6a)
	db %1001
	dw Sfx6a_Ch1
	dw Sfx6a_Ch2

;Sfx6b
	db BANK(Sfx6b)
	db %0001
	dw Sfx6b_Ch1

;Sfx6c
	db BANK(Sfx6c)
	db %1001
	dw Sfx6c_Ch1
	dw Sfx6c_Ch2

;Sfx6d
	db BANK(Sfx6d)
	db %0001
	dw Sfx6d_Ch1

;Sfx6e
	db BANK(Sfx6e)
	db %1001
	dw Sfx6e_Ch1
	dw Sfx6e_Ch2

;Sfx6f
	db BANK(Sfx6f)
	db %1001
	dw Sfx6f_Ch1
	dw Sfx6f_Ch2

;Sfx70
	db BANK(Sfx70)
	db %0001
	dw Sfx70_Ch1

;Sfx71
	db BANK(Sfx71)
	db %1001
	dw Sfx71_Ch1
	dw Sfx71_Ch2

;Sfx72
	db BANK(Sfx72)
	db %0001
	dw Sfx72_Ch1

;Sfx73
	db BANK(Sfx73)
	db %1001
	dw Sfx73_Ch1
	dw Sfx73_Ch2

;Sfx74
	db BANK(Sfx74)
	db %1001
	dw Sfx74_Ch1
	dw Sfx74_Ch2

;Sfx75
	db BANK(Sfx75)
	db %1001
	dw Sfx75_Ch1
	dw Sfx75_Ch2

;Sfx76
	db BANK(Sfx76)
	db %0001
	dw Sfx76_Ch1

;Sfx77
	db BANK(Sfx77)
	db %0001
	dw Sfx77_Ch1

;Sfx78
	db BANK(Sfx78)
	db %0001
	dw Sfx78_Ch1

;Sfx79
	db BANK(Sfx79)
	db %1000
	dw Sfx79_Ch1

;Sfx7a
	db BANK(Sfx7a)
	db %1001
	dw Sfx7a_Ch1
	dw Sfx7a_Ch2

;Sfx7b
	db BANK(Sfx7b)
	db %1001
	dw Sfx7b_Ch1
	dw Sfx7b_Ch2

;Sfx7c
	db BANK(Sfx7c)
	db %0001
	dw Sfx7c_Ch1

;Sfx7d
	db BANK(Sfx7d)
	db %0001
	dw Sfx7d_Ch1

;Sfx7e
	db BANK(Sfx7e)
	db %0001
	dw Sfx7e_Ch1

;Sfx7f
	db BANK(Sfx7f)
	db %1000
	dw Sfx7f_Ch1

;Sfx80
	db BANK(Sfx80)
	db %0001
	dw Sfx80_Ch1

;Sfx81
	db BANK(Sfx81)
	db %0001
	dw Sfx81_Ch1

;Sfx82
	db BANK(Sfx82)
	db %0001
	dw Sfx82_Ch1

;Sfx83
	db BANK(Sfx83)
	db %0001
	dw Sfx83_Ch1

;Sfx84
	db BANK(Sfx84)
	db %0001
	dw Sfx84_Ch1

;Sfx85
	db BANK(Sfx85)
	db %0001
	dw Sfx85_Ch1

;Sfx86
	db BANK(Sfx86)
	db %0001
	dw Sfx86_Ch1

;Sfx87
	db BANK(Sfx87)
	db %0001
	dw Sfx87_Ch1

;Sfx88
	db BANK(Sfx88)
	db %0001
	dw Sfx88_Ch1

;Sfx89
	db BANK(Sfx89)
	db %1001
	dw Sfx89_Ch1
	dw Sfx89_Ch2

;Sfx8a
	db BANK(Sfx8a)
	db %1001
	dw Sfx8a_Ch1
	dw Sfx8a_Ch2

;Sfx8b
	db BANK(Sfx8b)
	db %0001
	dw Sfx8b_Ch1

;Sfx8c
	db BANK(Sfx8c)
	db %1001
	dw Sfx8c_Ch1
	dw Sfx8c_Ch2

;Sfx8d
	db BANK(Sfx8d)
	db %1001
	dw Sfx8d_Ch1
	dw Sfx8d_Ch2

;Sfx8e
	db BANK(Sfx8e)
	db %1001
	dw Sfx8e_Ch1
	dw Sfx8e_Ch2

;Sfx8f
	db BANK(Sfx8f)
	db %0001
	dw Sfx8f_Ch1

;Sfx90
	db BANK(Sfx90)
	db %0001
	dw Sfx90_Ch1

;Sfx91
	db BANK(Sfx91)
	db %0001
	dw Sfx91_Ch1

;Sfx92
	db BANK(Sfx92)
	db %1000
	dw Sfx92_Ch1

;Sfx93
	db BANK(Sfx93)
	db %1001
	dw Sfx93_Ch1
	dw Sfx93_Ch2

;Sfx94
	db BANK(Sfx94)
	db %0001
	dw Sfx94_Ch1

;Sfx95
	db BANK(Sfx95)
	db %0001
	dw Sfx95_Ch1

;Sfx96
	db BANK(Sfx96)
	db %1001
	dw Sfx96_Ch1
	dw Sfx96_Ch2

;Sfx97
	db BANK(Sfx97)
	db %1001
	dw Sfx97_Ch1
	dw Sfx97_Ch2

;Sfx98
	db BANK(Sfx98)
	db %1001
	dw Sfx98_Ch1
	dw Sfx98_Ch2

;Sfx99
	db BANK(Sfx99)
	db %0001
	dw Sfx99_Ch1

;Sfx9a
	db BANK(Sfx9a)
	db %0001
	dw Sfx9a_Ch1

;Sfx9b
	db BANK(Sfx9b)
	db %1001
	dw Sfx9b_Ch1
	dw Sfx9b_Ch2

;Sfx9c
	db BANK(Sfx9c)
	db %0001
	dw Sfx9c_Ch1

;Sfx9d
	db BANK(Sfx9d)
	db %0001
	dw Sfx9d_Ch1

;Sfx9e
	db BANK(Sfx9e)
	db %0001
	dw Sfx9e_Ch1

;Sfx9f
	db BANK(Sfx9f)
	db %0001
	dw Sfx9f_Ch1

;Sfxa0
	db BANK(Sfxa0)
	db %0001
	dw Sfxa0_Ch1
