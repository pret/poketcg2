; control characters
	charmap "<RAMNAME>", TX_RAM1
	charmap "<RAMTEXT>", TX_RAM2
	charmap "<RAMNUM>",  TX_RAM3

; ascii half-width font
	charmap "\n", $0a
	charmap " ", $20
	charmap "!", $21
	charmap "”", $22
	charmap "≠", $23
	charmap "♂", $24
	charmap "♀", $25
	charmap "&", $26
	charmap "'", $27
	charmap "(", $28
	charmap ")", $29
	charmap "*", $2a
	charmap "+", $2b
	charmap ",", $2c
	charmap "-", $2d
	charmap ".", $2e
	charmap "/", $2f
	charmap "0", $30
	charmap "1", $31
	charmap "2", $32
	charmap "3", $33
	charmap "4", $34
	charmap "5", $35
	charmap "6", $36
	charmap "7", $37
	charmap "8", $38
	charmap "9", $39
	charmap ":", $3a
	charmap ";", $3b
	charmap "<", $3c
	charmap "=", $3d
	charmap ">", $3e
	charmap "?", $3f
	charmap "É", $40
	charmap "A", $41
	charmap "B", $42
	charmap "C", $43
	charmap "D", $44
	charmap "E", $45
	charmap "F", $46
	charmap "G", $47
	charmap "H", $48
	charmap "I", $49
	charmap "J", $4a
	charmap "K", $4b
	charmap "L", $4c
	charmap "M", $4d
	charmap "N", $4e
	charmap "O", $4f
	charmap "P", $50
	charmap "Q", $51
	charmap "R", $52
	charmap "S", $53
	charmap "T", $54
	charmap "U", $55
	charmap "V", $56
	charmap "W", $57
	charmap "X", $58
	charmap "Y", $59
	charmap "Z", $5a
	charmap "[", $5b
	charmap "\\", $5c
	charmap "]", $5d
	charmap "^", $5e
	charmap "_", $5f
	charmap "é", $60
	charmap "a", $61
	charmap "b", $62
	charmap "c", $63
	charmap "d", $64
	charmap "e", $65
	charmap "f", $66
	charmap "g", $67
	charmap "h", $68
	charmap "i", $69
	charmap "j", $6a
	charmap "k", $6b
	charmap "l", $6c
	charmap "m", $6d
	charmap "n", $6e
	charmap "o", $6f
	charmap "p", $70
	charmap "q", $71
	charmap "r", $72
	charmap "s", $73
	charmap "t", $74
	charmap "u", $75
	charmap "v", $76
	charmap "w", $77
	charmap "x", $78
	charmap "y", $79
	charmap "z", $7a
	charmap "\{", $7b
	charmap "¦", $7c
	charmap "}", $7d
	charmap "|", $7e
	charmap "‾", $7f

MACRO fwcharmap
	charmap STRCAT("FW{x:\1}_", \2), \3
ENDM

; TX_KATAKANA
	fwcharmap TX_KATAKANA, "ヲ", $10
	fwcharmap TX_KATAKANA, "ア", $11
	fwcharmap TX_KATAKANA, "イ", $12
	fwcharmap TX_KATAKANA, "ウ", $13
	fwcharmap TX_KATAKANA, "エ", $14
	fwcharmap TX_KATAKANA, "オ", $15
	fwcharmap TX_KATAKANA, "カ", $16
	fwcharmap TX_KATAKANA, "キ", $17
	fwcharmap TX_KATAKANA, "ク", $18
	fwcharmap TX_KATAKANA, "ケ", $19
	fwcharmap TX_KATAKANA, "コ", $1a
	fwcharmap TX_KATAKANA, "サ", $1b
	fwcharmap TX_KATAKANA, "シ", $1c
	fwcharmap TX_KATAKANA, "ス", $1d
	fwcharmap TX_KATAKANA, "セ", $1e
	fwcharmap TX_KATAKANA, "ソ", $1f
	fwcharmap TX_KATAKANA, "タ", $20
	fwcharmap TX_KATAKANA, "チ", $21
	fwcharmap TX_KATAKANA, "ツ", $22
	fwcharmap TX_KATAKANA, "テ", $23
	fwcharmap TX_KATAKANA, "ト", $24
	fwcharmap TX_KATAKANA, "ナ", $25
	fwcharmap TX_KATAKANA, "ニ", $26
	fwcharmap TX_KATAKANA, "ヌ", $27
	fwcharmap TX_KATAKANA, "ネ", $28
	fwcharmap TX_KATAKANA, "ノ", $29
	fwcharmap TX_KATAKANA, "ハ", $2a
	fwcharmap TX_KATAKANA, "ヒ", $2b
	fwcharmap TX_KATAKANA, "フ", $2c
	fwcharmap TX_KATAKANA, "ヘ", $2d
	fwcharmap TX_KATAKANA, "ホ", $2e
	fwcharmap TX_KATAKANA, "マ", $2f
	fwcharmap TX_KATAKANA, "ミ", $30
	fwcharmap TX_KATAKANA, "ム", $31
	fwcharmap TX_KATAKANA, "メ", $32
	fwcharmap TX_KATAKANA, "モ", $33
	fwcharmap TX_KATAKANA, "ヤ", $34
	fwcharmap TX_KATAKANA, "ユ", $35
	fwcharmap TX_KATAKANA, "ヨ", $36
	fwcharmap TX_KATAKANA, "ラ", $37
	fwcharmap TX_KATAKANA, "リ", $38
	fwcharmap TX_KATAKANA, "ル", $39
	fwcharmap TX_KATAKANA, "レ", $3a
	fwcharmap TX_KATAKANA, "ロ", $3b
	fwcharmap TX_KATAKANA, "ワ", $3c
	fwcharmap TX_KATAKANA, "ン", $3d
	fwcharmap TX_KATAKANA, "ガ", $3e
	fwcharmap TX_KATAKANA, "ギ", $3f
	fwcharmap TX_KATAKANA, "グ", $40
	fwcharmap TX_KATAKANA, "ゲ", $41
	fwcharmap TX_KATAKANA, "ゴ", $42
	fwcharmap TX_KATAKANA, "ザ", $43
	fwcharmap TX_KATAKANA, "ジ", $44
	fwcharmap TX_KATAKANA, "ズ", $45
	fwcharmap TX_KATAKANA, "ゼ", $46
	fwcharmap TX_KATAKANA, "ゾ", $47
	fwcharmap TX_KATAKANA, "ダ", $48
	fwcharmap TX_KATAKANA, "ヂ", $49
	fwcharmap TX_KATAKANA, "ヅ", $4a
	fwcharmap TX_KATAKANA, "デ", $4b
	fwcharmap TX_KATAKANA, "ド", $4c
	fwcharmap TX_KATAKANA, "バ", $4d
	fwcharmap TX_KATAKANA, "ビ", $4e
	fwcharmap TX_KATAKANA, "ブ", $4f
	fwcharmap TX_KATAKANA, "ベ", $50
	fwcharmap TX_KATAKANA, "ボ", $51
	fwcharmap TX_KATAKANA, "パ", $52
	fwcharmap TX_KATAKANA, "ピ", $53
	fwcharmap TX_KATAKANA, "プ", $54
	fwcharmap TX_KATAKANA, "ペ", $55
	fwcharmap TX_KATAKANA, "ポ", $56
	fwcharmap TX_KATAKANA, "ァ", $57
	fwcharmap TX_KATAKANA, "ィ", $58
	fwcharmap TX_KATAKANA, "ゥ", $59
	fwcharmap TX_KATAKANA, "ェ", $5a
	fwcharmap TX_KATAKANA, "ォ", $5b
	fwcharmap TX_KATAKANA, "ャ", $5c
	fwcharmap TX_KATAKANA, "ュ", $5d
	fwcharmap TX_KATAKANA, "ョ", $5e
	fwcharmap TX_KATAKANA, "ッ", $5f

; TX_HIRAGANA
	fwcharmap TX_HIRAGANA, "を", $10
	fwcharmap TX_HIRAGANA, "あ", $11
	fwcharmap TX_HIRAGANA, "い", $12
	fwcharmap TX_HIRAGANA, "う", $13
	fwcharmap TX_HIRAGANA, "え", $14
	fwcharmap TX_HIRAGANA, "お", $15
	fwcharmap TX_HIRAGANA, "か", $16
	fwcharmap TX_HIRAGANA, "き", $17
	fwcharmap TX_HIRAGANA, "く", $18
	fwcharmap TX_HIRAGANA, "け", $19
	fwcharmap TX_HIRAGANA, "こ", $1a
	fwcharmap TX_HIRAGANA, "さ", $1b
	fwcharmap TX_HIRAGANA, "し", $1c
	fwcharmap TX_HIRAGANA, "す", $1d
	fwcharmap TX_HIRAGANA, "せ", $1e
	fwcharmap TX_HIRAGANA, "そ", $1f
	fwcharmap TX_HIRAGANA, "た", $20
	fwcharmap TX_HIRAGANA, "ち", $21
	fwcharmap TX_HIRAGANA, "つ", $22
	fwcharmap TX_HIRAGANA, "て", $23
	fwcharmap TX_HIRAGANA, "と", $24
	fwcharmap TX_HIRAGANA, "な", $25
	fwcharmap TX_HIRAGANA, "に", $26
	fwcharmap TX_HIRAGANA, "ぬ", $27
	fwcharmap TX_HIRAGANA, "ね", $28
	fwcharmap TX_HIRAGANA, "の", $29
	fwcharmap TX_HIRAGANA, "は", $2a
	fwcharmap TX_HIRAGANA, "ひ", $2b
	fwcharmap TX_HIRAGANA, "ふ", $2c
	fwcharmap TX_HIRAGANA, "へ", $2d
	fwcharmap TX_HIRAGANA, "ほ", $2e
	fwcharmap TX_HIRAGANA, "ま", $2f
	fwcharmap TX_HIRAGANA, "み", $30
	fwcharmap TX_HIRAGANA, "む", $31
	fwcharmap TX_HIRAGANA, "め", $32
	fwcharmap TX_HIRAGANA, "も", $33
	fwcharmap TX_HIRAGANA, "や", $34
	fwcharmap TX_HIRAGANA, "ゆ", $35
	fwcharmap TX_HIRAGANA, "よ", $36
	fwcharmap TX_HIRAGANA, "ら", $37
	fwcharmap TX_HIRAGANA, "り", $38
	fwcharmap TX_HIRAGANA, "る", $39
	fwcharmap TX_HIRAGANA, "れ", $3a
	fwcharmap TX_HIRAGANA, "ろ", $3b
	fwcharmap TX_HIRAGANA, "わ", $3c
	fwcharmap TX_HIRAGANA, "ん", $3d
	fwcharmap TX_HIRAGANA, "が", $3e
	fwcharmap TX_HIRAGANA, "ぎ", $3f
	fwcharmap TX_HIRAGANA, "ぐ", $40
	fwcharmap TX_HIRAGANA, "げ", $41
	fwcharmap TX_HIRAGANA, "ご", $42
	fwcharmap TX_HIRAGANA, "ざ", $43
	fwcharmap TX_HIRAGANA, "じ", $44
	fwcharmap TX_HIRAGANA, "ず", $45
	fwcharmap TX_HIRAGANA, "ぜ", $46
	fwcharmap TX_HIRAGANA, "ぞ", $47
	fwcharmap TX_HIRAGANA, "だ", $48
	fwcharmap TX_HIRAGANA, "ぢ", $49
	fwcharmap TX_HIRAGANA, "づ", $4a
	fwcharmap TX_HIRAGANA, "で", $4b
	fwcharmap TX_HIRAGANA, "ど", $4c
	fwcharmap TX_HIRAGANA, "ば", $4d
	fwcharmap TX_HIRAGANA, "び", $4e
	fwcharmap TX_HIRAGANA, "ぶ", $4f
	fwcharmap TX_HIRAGANA, "べ", $50
	fwcharmap TX_HIRAGANA, "ぼ", $51
	fwcharmap TX_HIRAGANA, "ぱ", $52
	fwcharmap TX_HIRAGANA, "ぴ", $53
	fwcharmap TX_HIRAGANA, "ぷ", $54
	fwcharmap TX_HIRAGANA, "ぺ", $55
	fwcharmap TX_HIRAGANA, "ぽ", $56
	fwcharmap TX_HIRAGANA, "ぁ", $57
	fwcharmap TX_HIRAGANA, "ぃ", $58
	fwcharmap TX_HIRAGANA, "ぅ", $59
	fwcharmap TX_HIRAGANA, "ぇ", $5a
	fwcharmap TX_HIRAGANA, "ぉ", $5b
	fwcharmap TX_HIRAGANA, "ゃ", $5c
	fwcharmap TX_HIRAGANA, "ゅ", $5d
	fwcharmap TX_HIRAGANA, "ょ", $5e
	fwcharmap TX_HIRAGANA, "っ", $5f

; TX_KATAKANA, TX_HIRAGANA, and TX_FULLWIDTH0
	fwcharmap TX_FULLWIDTH0, "0", $60
	fwcharmap TX_FULLWIDTH0, "1", $61
	fwcharmap TX_FULLWIDTH0, "2", $62
	fwcharmap TX_FULLWIDTH0, "3", $63
	fwcharmap TX_FULLWIDTH0, "4", $64
	fwcharmap TX_FULLWIDTH0, "5", $65
	fwcharmap TX_FULLWIDTH0, "6", $66
	fwcharmap TX_FULLWIDTH0, "7", $67
	fwcharmap TX_FULLWIDTH0, "8", $68
	fwcharmap TX_FULLWIDTH0, "9", $69
	fwcharmap TX_FULLWIDTH0, "+", $6a
	fwcharmap TX_FULLWIDTH0, "-", $6b
	fwcharmap TX_FULLWIDTH0, "×", $6c
	fwcharmap TX_FULLWIDTH0, "/", $6d
	fwcharmap TX_FULLWIDTH0, "!", $6e
	fwcharmap TX_FULLWIDTH0, "?", $6f
	fwcharmap TX_FULLWIDTH0, " ", $70
	fwcharmap TX_FULLWIDTH0, "(", $71
	fwcharmap TX_FULLWIDTH0, ")", $72
	fwcharmap TX_FULLWIDTH0, "「", $73
	fwcharmap TX_FULLWIDTH0, "」", $74
	fwcharmap TX_FULLWIDTH0, "、", $75
	fwcharmap TX_FULLWIDTH0, "。", $76
	fwcharmap TX_FULLWIDTH0, "・", $77
	fwcharmap TX_FULLWIDTH0, "ー", $78
	fwcharmap TX_FULLWIDTH0, "ṛ", $79 ; r.

	; [相手]
	fwcharmap TX_FULLWIDTH0, "7a", $7a
	fwcharmap TX_FULLWIDTH0, "7b", $7b
	fwcharmap TX_FULLWIDTH0, "7c", $7c

	; [自分]
	fwcharmap TX_FULLWIDTH0, "7d", $7d
	fwcharmap TX_FULLWIDTH0, "7e", $7e
	fwcharmap TX_FULLWIDTH0, "7f", $7f

	fwcharmap TX_FULLWIDTH0, "手", $80
	fwcharmap TX_FULLWIDTH0, "戦", $81
	fwcharmap TX_FULLWIDTH0, "対", $82
	fwcharmap TX_FULLWIDTH0, "説", $83
	fwcharmap TX_FULLWIDTH0, "枚", $84
	fwcharmap TX_FULLWIDTH0, "札", $85
	fwcharmap TX_FULLWIDTH0, "相", $86
	fwcharmap TX_FULLWIDTH0, "名", $87
	fwcharmap TX_FULLWIDTH0, "人", $88
	fwcharmap TX_FULLWIDTH0, "伝", $89
	fwcharmap TX_FULLWIDTH0, "選", $8a
	fwcharmap TX_FULLWIDTH0, "自", $8b
	fwcharmap TX_FULLWIDTH0, "分", $8c
	fwcharmap TX_FULLWIDTH0, "力", $8d
	fwcharmap TX_FULLWIDTH0, "場", $8e
	fwcharmap TX_FULLWIDTH0, "山", $8f
	fwcharmap TX_FULLWIDTH0, "勝", $90
	fwcharmap TX_FULLWIDTH0, "使", $91
	fwcharmap TX_FULLWIDTH0, "択", $92
	fwcharmap TX_FULLWIDTH0, "化", $93
	fwcharmap TX_FULLWIDTH0, "時", $94
	fwcharmap TX_FULLWIDTH0, "状", $95
	fwcharmap TX_FULLWIDTH0, "進", $96
	fwcharmap TX_FULLWIDTH0, "回", $97
	fwcharmap TX_FULLWIDTH0, "番", $98
	fwcharmap TX_FULLWIDTH0, "態", $99
	fwcharmap TX_FULLWIDTH0, "出", $9a
	fwcharmap TX_FULLWIDTH0, "中", $9b
	fwcharmap TX_FULLWIDTH0, "投", $9c
	fwcharmap TX_FULLWIDTH0, "強", $9d
	fwcharmap TX_FULLWIDTH0, "本", $9e
	fwcharmap TX_FULLWIDTH0, "果", $9f
	fwcharmap TX_FULLWIDTH0, "効", $a0
	fwcharmap TX_FULLWIDTH0, "解", $a1
	fwcharmap TX_FULLWIDTH0, "定", $a2
	fwcharmap TX_FULLWIDTH0, "色", $a3
	fwcharmap TX_FULLWIDTH0, "見", $a4
	fwcharmap TX_FULLWIDTH0, "無", $a5
	fwcharmap TX_FULLWIDTH0, "物", $a6
	fwcharmap TX_FULLWIDTH0, "判", $a7
	fwcharmap TX_FULLWIDTH0, "炎", $a8
	fwcharmap TX_FULLWIDTH0, "数", $a9
	fwcharmap TX_FULLWIDTH0, "水", $aa
	fwcharmap TX_FULLWIDTH0, "後", $ab
	fwcharmap TX_FULLWIDTH0, "控", $ac
	fwcharmap TX_FULLWIDTH0, "信", $ad
	fwcharmap TX_FULLWIDTH0, "受", $ae
	fwcharmap TX_FULLWIDTH0, "入", $af
	fwcharmap TX_FULLWIDTH0, "大", $b0
	fwcharmap TX_FULLWIDTH0, "弱", $b1
	fwcharmap TX_FULLWIDTH0, "点", $b2
	fwcharmap TX_FULLWIDTH0, "超", $b3
	fwcharmap TX_FULLWIDTH0, "気", $b4
	fwcharmap TX_FULLWIDTH0, "動", $b5
	fwcharmap TX_FULLWIDTH0, "上", $b6
	fwcharmap TX_FULLWIDTH0, "体", $b7
	fwcharmap TX_FULLWIDTH0, "目", $b8
	fwcharmap TX_FULLWIDTH0, "抗", $b9
	fwcharmap TX_FULLWIDTH0, "抵", $ba
	fwcharmap TX_FULLWIDTH0, "拡", $bb
	fwcharmap TX_FULLWIDTH0, "通", $bc
	fwcharmap TX_FULLWIDTH0, "替", $bd
	fwcharmap TX_FULLWIDTH0, "張", $be
	fwcharmap TX_FULLWIDTH0, "加", $bf
	fwcharmap TX_FULLWIDTH0, "特", $c0
	fwcharmap TX_FULLWIDTH0, "殊", $c1
	fwcharmap TX_FULLWIDTH0, "能", $c2
	fwcharmap TX_FULLWIDTH0, "建", $c3
	fwcharmap TX_FULLWIDTH0, "子", $c4
	fwcharmap TX_FULLWIDTH0, "全", $c5
	fwcharmap TX_FULLWIDTH0, "次", $c6
	fwcharmap TX_FULLWIDTH0, "切", $c7
	fwcharmap TX_FULLWIDTH0, "雷", $c8
	fwcharmap TX_FULLWIDTH0, "匹", $c9
	fwcharmap TX_FULLWIDTH0, "明", $ca
	fwcharmap TX_FULLWIDTH0, "研", $cb
	fwcharmap TX_FULLWIDTH0, "究", $cc
	fwcharmap TX_FULLWIDTH0, "草", $cd
	fwcharmap TX_FULLWIDTH0, "男", $ce
	fwcharmap TX_FULLWIDTH0, "面", $cf
	fwcharmap TX_FULLWIDTH0, "生", $d0
	fwcharmap TX_FULLWIDTH0, "文", $d1
	fwcharmap TX_FULLWIDTH0, "闘", $d2
	fwcharmap TX_FULLWIDTH0, "地", $d3
	fwcharmap TX_FULLWIDTH0, "間", $d4
	fwcharmap TX_FULLWIDTH0, "基", $d5
	fwcharmap TX_FULLWIDTH0, "品", $d6
	fwcharmap TX_FULLWIDTH0, "岩", $d7
	fwcharmap TX_FULLWIDTH0, "空", $d8
	fwcharmap TX_FULLWIDTH0, "身", $d9
	fwcharmap TX_FULLWIDTH0, "関", $da
	fwcharmap TX_FULLWIDTH0, "係", $db
	fwcharmap TX_FULLWIDTH0, "飛", $dc
	fwcharmap TX_FULLWIDTH0, "持", $dd
	fwcharmap TX_FULLWIDTH0, "賞", $de
	fwcharmap TX_FULLWIDTH0, "作", $df
	fwcharmap TX_FULLWIDTH0, "好", $e0
	fwcharmap TX_FULLWIDTH0, "追", $e1
	fwcharmap TX_FULLWIDTH0, "的", $e2
	fwcharmap TX_FULLWIDTH0, "以", $e3
	fwcharmap TX_FULLWIDTH0, "電", $e4
	fwcharmap TX_FULLWIDTH0, "引", $e5
	fwcharmap TX_FULLWIDTH0, "日", $e6
	fwcharmap TX_FULLWIDTH0, "敗", $e7
	fwcharmap TX_FULLWIDTH0, "最", $e8
	fwcharmap TX_FULLWIDTH0, "度", $e9
	fwcharmap TX_FULLWIDTH0, "個", $ea
	fwcharmap TX_FULLWIDTH0, "与", $eb
	fwcharmap TX_FULLWIDTH0, "確", $ec
	fwcharmap TX_FULLWIDTH0, "認", $ed
	fwcharmap TX_FULLWIDTH0, "成", $ee
	fwcharmap TX_FULLWIDTH0, "発", $ef
	fwcharmap TX_FULLWIDTH0, "家", $f0
	fwcharmap TX_FULLWIDTH0, "終", $f1
	fwcharmap TX_FULLWIDTH0, "三", $f2
	fwcharmap TX_FULLWIDTH0, "移", $f3
	fwcharmap TX_FULLWIDTH0, "足", $f4
	fwcharmap TX_FULLWIDTH0, "員", $f5
	fwcharmap TX_FULLWIDTH0, "消", $f6
	fwcharmap TX_FULLWIDTH0, "長", $f7
	fwcharmap TX_FULLWIDTH0, "外", $f8
	fwcharmap TX_FULLWIDTH0, "毒", $f9
	fwcharmap TX_FULLWIDTH0, "意", $fa
	fwcharmap TX_FULLWIDTH0, "交", $fb
	fwcharmap TX_FULLWIDTH0, "高", $fc
	fwcharmap TX_FULLWIDTH0, "失", $fd
	fwcharmap TX_FULLWIDTH0, "収", $fe
	fwcharmap TX_FULLWIDTH0, "一", $ff

; TX_FULLWIDTH1
	fwcharmap TX_FULLWIDTH1, "攻", $10
	fwcharmap TX_FULLWIDTH1, "性", $11
	fwcharmap TX_FULLWIDTH1, "変", $12
	fwcharmap TX_FULLWIDTH1, "尾", $13
	fwcharmap TX_FULLWIDTH1, "所", $14
	fwcharmap TX_FULLWIDTH1, "小", $15
	fwcharmap TX_FULLWIDTH1, "画", $16
	fwcharmap TX_FULLWIDTH1, "換", $17
	fwcharmap TX_FULLWIDTH1, "尻", $18
	fwcharmap TX_FULLWIDTH1, "功", $19
	fwcharmap TX_FULLWIDTH1, "限", $1a
	fwcharmap TX_FULLWIDTH1, "花", $1b
	fwcharmap TX_FULLWIDTH1, "何", $1c
	fwcharmap TX_FULLWIDTH1, "海", $1d
	fwcharmap TX_FULLWIDTH1, "互", $1e
	fwcharmap TX_FULLWIDTH1, "育", $1f
	fwcharmap TX_FULLWIDTH1, "前", $20
	fwcharmap TX_FULLWIDTH1, "不", $21
	fwcharmap TX_FULLWIDTH1, "操", $22
	fwcharmap TX_FULLWIDTH1, "用", $23
	fwcharmap TX_FULLWIDTH1, "者", $24
	fwcharmap TX_FULLWIDTH1, "頭", $25
	fwcharmap TX_FULLWIDTH1, "栄", $26
	fwcharmap TX_FULLWIDTH1, "格", $27
	fwcharmap TX_FULLWIDTH1, "怒", $28
	fwcharmap TX_FULLWIDTH1, "光", $29
	fwcharmap TX_FULLWIDTH1, "元", $2a
	fwcharmap TX_FULLWIDTH1, "了", $2b
	fwcharmap TX_FULLWIDTH1, "角", $2c
	fwcharmap TX_FULLWIDTH1, "口", $2d
	fwcharmap TX_FULLWIDTH1, "別", $2e
	fwcharmap TX_FULLWIDTH1, "鋭", $2f
	fwcharmap TX_FULLWIDTH1, "左", $30
	fwcharmap TX_FULLWIDTH1, "右", $31
	fwcharmap TX_FULLWIDTH1, "擊", $32
	fwcharmap TX_FULLWIDTH1, "覆", $33
	fwcharmap TX_FULLWIDTH1, "皮", $34
	fwcharmap TX_FULLWIDTH1, "毛", $35
	fwcharmap TX_FULLWIDTH1, "逃", $36
	fwcharmap TX_FULLWIDTH1, "方", $37
	fwcharmap TX_FULLWIDTH1, "弟", $38
	fwcharmap TX_FULLWIDTH1, "石", $39
	fwcharmap TX_FULLWIDTH1, "同", $3a
	fwcharmap TX_FULLWIDTH1, "新", $3b
	fwcharmap TX_FULLWIDTH1, "台", $3c
	fwcharmap TX_FULLWIDTH1, "現", $3d
	fwcharmap TX_FULLWIDTH1, "少", $3e
	fwcharmap TX_FULLWIDTH1, "多", $3f
	fwcharmap TX_FULLWIDTH1, "幻", $40
	fwcharmap TX_FULLWIDTH1, "心", $41
	fwcharmap TX_FULLWIDTH1, "眠", $42
	fwcharmap TX_FULLWIDTH1, "待", $43
	fwcharmap TX_FULLWIDTH1, "固", $44
	fwcharmap TX_FULLWIDTH1, "送", $45
	fwcharmap TX_FULLWIDTH1, "常", $46
	fwcharmap TX_FULLWIDTH1, "歩", $47
	fwcharmap TX_FULLWIDTH1, "姿", $48
	fwcharmap TX_FULLWIDTH1, "得", $49
	fwcharmap TX_FULLWIDTH1, "火", $4a
	fwcharmap TX_FULLWIDTH1, "合", $4b
	fwcharmap TX_FULLWIDTH1, "詞", $4c
	fwcharmap TX_FULLWIDTH1, "暴", $4d
	fwcharmap TX_FULLWIDTH1, "泳", $4e
	fwcharmap TX_FULLWIDTH1, "鳥", $4f
	fwcharmap TX_FULLWIDTH1, "実", $50
	fwcharmap TX_FULLWIDTH1, "羽", $51
	fwcharmap TX_FULLWIDTH1, "射", $52
	fwcharmap TX_FULLWIDTH1, "非", $53
	fwcharmap TX_FULLWIDTH1, "女", $54
	fwcharmap TX_FULLWIDTH1, "達", $55
	fwcharmap TX_FULLWIDTH1, "針", $56
	fwcharmap TX_FULLWIDTH1, "機", $57
	fwcharmap TX_FULLWIDTH1, "近", $58
	fwcharmap TX_FULLWIDTH1, "年", $59
	fwcharmap TX_FULLWIDTH1, "開", $5a
	fwcharmap TX_FULLWIDTH1, "音", $5b
	fwcharmap TX_FULLWIDTH1, "先", $5c
	fwcharmap TX_FULLWIDTH1, "半", $5d
	fwcharmap TX_FULLWIDTH1, "要", $5e
	fwcharmap TX_FULLWIDTH1, "必", $5f
	fwcharmap TX_FULLWIDTH1, "突", $60
	fwcharmap TX_FULLWIDTH1, "戻", $61
	fwcharmap TX_FULLWIDTH1, "両", $62
	fwcharmap TX_FULLWIDTH1, "立", $63
	fwcharmap TX_FULLWIDTH1, "波", $64
	fwcharmap TX_FULLWIDTH1, "獲", $65
	fwcharmap TX_FULLWIDTH1, "美", $66
	fwcharmap TX_FULLWIDTH1, "息", $67
	fwcharmap TX_FULLWIDTH1, "知", $68
	fwcharmap TX_FULLWIDTH1, "放", $69
	fwcharmap TX_FULLWIDTH1, "言", $6a
	fwcharmap TX_FULLWIDTH1, "刺", $6b
	fwcharmap TX_FULLWIDTH1, "記", $6c
	fwcharmap TX_FULLWIDTH1, "種", $6d
	fwcharmap TX_FULLWIDTH1, "退", $6e
	fwcharmap TX_FULLWIDTH1, "食", $6f
	fwcharmap TX_FULLWIDTH1, "字", $70
	fwcharmap TX_FULLWIDTH1, "木", $71
	fwcharmap TX_FULLWIDTH1, "猛", $72
	fwcharmap TX_FULLWIDTH1, "絶", $73
	fwcharmap TX_FULLWIDTH1, "削", $74
	fwcharmap TX_FULLWIDTH1, "設", $75
	fwcharmap TX_FULLWIDTH1, "初", $76
	fwcharmap TX_FULLWIDTH1, "重", $77
	fwcharmap TX_FULLWIDTH1, "速", $78
	fwcharmap TX_FULLWIDTH1, "事", $79
	fwcharmap TX_FULLWIDTH1, "復", $7a
	fwcharmap TX_FULLWIDTH1, "敵", $7b
	fwcharmap TX_FULLWIDTH1, "続", $7c
	fwcharmap TX_FULLWIDTH1, "住", $7d
	fwcharmap TX_FULLWIDTH1, "部", $7e
	fwcharmap TX_FULLWIDTH1, "様", $7f
	fwcharmap TX_FULLWIDTH1, "狂", $80
	fwcharmap TX_FULLWIDTH1, "線", $81
	fwcharmap TX_FULLWIDTH1, "背", $82
	fwcharmap TX_FULLWIDTH1, "植", $83
	fwcharmap TX_FULLWIDTH1, "走", $84
	fwcharmap TX_FULLWIDTH1, "膚", $85
	fwcharmap TX_FULLWIDTH1, "完", $86
	fwcharmap TX_FULLWIDTH1, "未", $87
	fwcharmap TX_FULLWIDTH1, "国", $88
	fwcharmap TX_FULLWIDTH1, "助", $89
	fwcharmap TX_FULLWIDTH1, "補", $8a
	fwcharmap TX_FULLWIDTH1, "在", $8b
	fwcharmap TX_FULLWIDTH1, "活", $8c
	fwcharmap TX_FULLWIDTH1, "始", $8d
	fwcharmap TX_FULLWIDTH1, "表", $8e
	fwcharmap TX_FULLWIDTH1, "掘", $8f
	fwcharmap TX_FULLWIDTH1, "暗", $90
	fwcharmap TX_FULLWIDTH1, "列", $91
	fwcharmap TX_FULLWIDTH1, "行", $92
	fwcharmap TX_FULLWIDTH1, "連", $93
	fwcharmap TX_FULLWIDTH1, "結", $94
	fwcharmap TX_FULLWIDTH1, "残", $95
	fwcharmap TX_FULLWIDTH1, "断", $96
	fwcharmap TX_FULLWIDTH1, "除", $97
	fwcharmap TX_FULLWIDTH1, "主", $98
	fwcharmap TX_FULLWIDTH1, "闇", $99
	fwcharmap TX_FULLWIDTH1, "命", $9a
	fwcharmap TX_FULLWIDTH1, "屋", $9b
	fwcharmap TX_FULLWIDTH1, "捨", $9c
	fwcharmap TX_FULLWIDTH1, "滅", $9d
	fwcharmap TX_FULLWIDTH1, "胞", $9e
	fwcharmap TX_FULLWIDTH1, "思", $9f
	fwcharmap TX_FULLWIDTH1, "揺", $a0
	fwcharmap TX_FULLWIDTH1, "利", $a1
	fwcharmap TX_FULLWIDTH1, "遺", $a2
	fwcharmap TX_FULLWIDTH1, "注", $a3
	fwcharmap TX_FULLWIDTH1, "夜", $a4
	fwcharmap TX_FULLWIDTH1, "険", $a5
	fwcharmap TX_FULLWIDTH1, "倍", $a6
	fwcharmap TX_FULLWIDTH1, "威", $a7
	fwcharmap TX_FULLWIDTH1, "試", $a8
	fwcharmap TX_FULLWIDTH1, "巣", $a9
	fwcharmap TX_FULLWIDTH1, "離", $aa
	fwcharmap TX_FULLWIDTH1, "決", $ab
	fwcharmap TX_FULLWIDTH1, "骨", $ac
	fwcharmap TX_FULLWIDTH1, "燃", $ad
	fwcharmap TX_FULLWIDTH1, "覚", $ae
	fwcharmap TX_FULLWIDTH1, "液", $af
	fwcharmap TX_FULLWIDTH1, "磁", $b0
	fwcharmap TX_FULLWIDTH1, "倒", $b1
	fwcharmap TX_FULLWIDTH1, "落", $b2
	fwcharmap TX_FULLWIDTH1, "学", $b3
	fwcharmap TX_FULLWIDTH1, "顏", $b4
	fwcharmap TX_FULLWIDTH1, "風", $b5
	fwcharmap TX_FULLWIDTH1, "昔", $b6
	fwcharmap TX_FULLWIDTH1, "影", $b7
	fwcharmap TX_FULLWIDTH1, "難", $b8
	fwcharmap TX_FULLWIDTH1, "巻", $b9
	fwcharmap TX_FULLWIDTH1, "響", $ba
	fwcharmap TX_FULLWIDTH1, "工", $bb
	fwcharmap TX_FULLWIDTH1, "粉", $bc
	fwcharmap TX_FULLWIDTH1, "脱", $bd
	fwcharmap TX_FULLWIDTH1, "危", $be
	fwcharmap TX_FULLWIDTH1, "吸", $bf
	fwcharmap TX_FULLWIDTH1, "殻", $c0
	fwcharmap TX_FULLWIDTH1, "寒", $c1
	fwcharmap TX_FULLWIDTH1, "養", $c2
	fwcharmap TX_FULLWIDTH1, "歌", $c3
	fwcharmap TX_FULLWIDTH1, "理", $c4
	fwcharmap TX_FULLWIDTH1, "組", $c5
	fwcharmap TX_FULLWIDTH1, "更", $c6
	fwcharmap TX_FULLWIDTH1, "由", $c7
	fwcharmap TX_FULLWIDTH1, "取", $c8
	fwcharmap TX_FULLWIDTH1, "順", $c9
	fwcharmap TX_FULLWIDTH1, "逆", $ca
	fwcharmap TX_FULLWIDTH1, "細", $cb
	fwcharmap TX_FULLWIDTH1, "丸", $cc
	fwcharmap TX_FULLWIDTH1, "葉", $cd
	fwcharmap TX_FULLWIDTH1, "裂", $ce
	fwcharmap TX_FULLWIDTH1, "当", $cf
	fwcharmap TX_FULLWIDTH1, "温", $d0
	fwcharmap TX_FULLWIDTH1, "痛", $d1
	fwcharmap TX_FULLWIDTH1, "耳", $d2
	fwcharmap TX_FULLWIDTH1, "然", $d3
	fwcharmap TX_FULLWIDTH1, "軽", $d4
	fwcharmap TX_FULLWIDTH1, "激", $d5
	fwcharmap TX_FULLWIDTH1, "袋", $d6
	fwcharmap TX_FULLWIDTH1, "議", $d7
	fwcharmap TX_FULLWIDTH1, "下", $d8
	fwcharmap TX_FULLWIDTH1, "起", $d9
	fwcharmap TX_FULLWIDTH1, "界", $da
	fwcharmap TX_FULLWIDTH1, "世", $db
	fwcharmap TX_FULLWIDTH1, "臭", $dc
	fwcharmap TX_FULLWIDTH1, "根", $dd
	fwcharmap TX_FULLWIDTH1, "伸", $de
	fwcharmap TX_FULLWIDTH1, "聞", $df
	fwcharmap TX_FULLWIDTH1, "遠", $e0
	fwcharmap TX_FULLWIDTH1, "烈", $e1
	fwcharmap TX_FULLWIDTH1, "模", $e2
	fwcharmap TX_FULLWIDTH1, "腹", $e3
	fwcharmap TX_FULLWIDTH1, "感", $e4
	fwcharmap TX_FULLWIDTH1, "舌", $e5
	fwcharmap TX_FULLWIDTH1, "集", $e6
	fwcharmap TX_FULLWIDTH1, "雨", $e7
	fwcharmap TX_FULLWIDTH1, "硬", $e8
	fwcharmap TX_FULLWIDTH1, "香", $e9
	fwcharmap TX_FULLWIDTH1, "寄", $ea
	fwcharmap TX_FULLWIDTH1, "絵", $eb
	fwcharmap TX_FULLWIDTH1, "話", $ec
	fwcharmap TX_FULLWIDTH1, "西", $ed
	fwcharmap TX_FULLWIDTH1, "北", $ee
	fwcharmap TX_FULLWIDTH1, "室", $ef
	fwcharmap TX_FULLWIDTH1, "算", $f0
	fwcharmap TX_FULLWIDTH1, "氏", $f1
	fwcharmap TX_FULLWIDTH1, "第", $f2
	fwcharmap TX_FULLWIDTH1, "誘", $f3
	fwcharmap TX_FULLWIDTH1, "溶", $f4
	fwcharmap TX_FULLWIDTH1, "役", $f5
	fwcharmap TX_FULLWIDTH1, "道", $f6
	fwcharmap TX_FULLWIDTH1, "普", $f7
	fwcharmap TX_FULLWIDTH1, "段", $f8
	fwcharmap TX_FULLWIDTH1, "孫", $f9
	fwcharmap TX_FULLWIDTH1, "熱", $fa
	fwcharmap TX_FULLWIDTH1, "帶", $fb
	fwcharmap TX_FULLWIDTH1, "呼", $fc
	fwcharmap TX_FULLWIDTH1, "異", $fd
	fwcharmap TX_FULLWIDTH1, "仮", $fe
	fwcharmap TX_FULLWIDTH1, "正", $ff

; TX_FULLWIDTH2
	fwcharmap TX_FULLWIDTH2, "書", $10
	fwcharmap TX_FULLWIDTH2, "複", $11
	fwcharmap TX_FULLWIDTH2, "満", $12
	fwcharmap TX_FULLWIDTH2, "杯", $13
	fwcharmap TX_FULLWIDTH2, "抜", $14
	fwcharmap TX_FULLWIDTH2, "鎌", $15
	fwcharmap TX_FULLWIDTH2, "登", $16
	fwcharmap TX_FULLWIDTH2, "鑑", $17
	fwcharmap TX_FULLWIDTH2, "図", $18
	fwcharmap TX_FULLWIDTH2, "笛", $19
	fwcharmap TX_FULLWIDTH2, "輝", $1a
	fwcharmap TX_FULLWIDTH2, "良", $1b
	fwcharmap TX_FULLWIDTH2, "深", $1c
	fwcharmap TX_FULLWIDTH2, "処", $1d
	fwcharmap TX_FULLWIDTH2, "継", $1e
	fwcharmap TX_FULLWIDTH2, "幹", $1f
	fwcharmap TX_FULLWIDTH2, "裏", $20
	fwcharmap TX_FULLWIDTH2, "捕", $21
	fwcharmap TX_FULLWIDTH2, "紙", $22
	fwcharmap TX_FULLWIDTH2, "池", $23
	fwcharmap TX_FULLWIDTH2, "内", $24
	fwcharmap TX_FULLWIDTH2, "翼", $25
	fwcharmap TX_FULLWIDTH2, "負", $26
	fwcharmap TX_FULLWIDTH2, "圧", $27
	fwcharmap TX_FULLWIDTH2, "教", $28
	fwcharmap TX_FULLWIDTH2, "湖", $29
	fwcharmap TX_FULLWIDTH2, "優", $2a
	fwcharmap TX_FULLWIDTH2, "印", $2b
	fwcharmap TX_FULLWIDTH2, "透", $2c
	fwcharmap TX_FULLWIDTH2, "触", $2d
	fwcharmap TX_FULLWIDTH2, "壊", $2e
	fwcharmap TX_FULLWIDTH2, "万", $2f
	fwcharmap TX_FULLWIDTH2, "辺", $30
	fwcharmap TX_FULLWIDTH2, "赤", $31
	fwcharmap TX_FULLWIDTH2, "乱", $32
	fwcharmap TX_FULLWIDTH2, "混", $33
	fwcharmap TX_FULLWIDTH2, "魚", $34
	fwcharmap TX_FULLWIDTH2, "古", $35
	fwcharmap TX_FULLWIDTH2, "代", $36
	fwcharmap TX_FULLWIDTH2, "死", $37
	fwcharmap TX_FULLWIDTH2, "側", $38
	fwcharmap TX_FULLWIDTH2, "愛", $39
	fwcharmap TX_FULLWIDTH2, "浮", $3a
	fwcharmap TX_FULLWIDTH2, "爆", $3b
	fwcharmap TX_FULLWIDTH2, "膨", $3c
	fwcharmap TX_FULLWIDTH2, "驚", $3d
	fwcharmap TX_FULLWIDTH2, "雲", $3e
	fwcharmap TX_FULLWIDTH2, "穴", $3f
	fwcharmap TX_FULLWIDTH2, "肉", $40
	fwcharmap TX_FULLWIDTH2, "運", $41
	fwcharmap TX_FULLWIDTH2, "秒", $42
	fwcharmap TX_FULLWIDTH2, "転", $43
	fwcharmap TX_FULLWIDTH2, "声", $44
	fwcharmap TX_FULLWIDTH2, "寝", $45
	fwcharmap TX_FULLWIDTH2, "考", $46
	fwcharmap TX_FULLWIDTH2, "催", $47
	fwcharmap TX_FULLWIDTH2, "術", $48
	fwcharmap TX_FULLWIDTH2, "広", $49
	fwcharmap TX_FULLWIDTH2, "嚇", $4a
	fwcharmap TX_FULLWIDTH2, "瞳", $4b
	fwcharmap TX_FULLWIDTH2, "虫", $4c
	fwcharmap TX_FULLWIDTH2, "隠", $4d
	fwcharmap TX_FULLWIDTH2, "金", $4e
	fwcharmap TX_FULLWIDTH2, "接", $4f
	fwcharmap TX_FULLWIDTH2, "片", $50
	fwcharmap TX_FULLWIDTH2, "丈", $51
	fwcharmap TX_FULLWIDTH2, "黃", $52
	fwcharmap TX_FULLWIDTH2, "53", $53
	fwcharmap TX_FULLWIDTH2, "夫", $54
	fwcharmap TX_FULLWIDTH2, "零", $55
	fwcharmap TX_FULLWIDTH2, "真", $56
	fwcharmap TX_FULLWIDTH2, "白", $57
	fwcharmap TX_FULLWIDTH2, "増", $58
	fwcharmap TX_FULLWIDTH2, "象", $59
	fwcharmap TX_FULLWIDTH2, "彈", $5a
	fwcharmap TX_FULLWIDTH2, "血", $5b
	fwcharmap TX_FULLWIDTH2, "匂", $5c
	fwcharmap TX_FULLWIDTH2, "馬", $5d
	fwcharmap TX_FULLWIDTH2, "錄", $5e
	fwcharmap TX_FULLWIDTH2, "済", $5f
	fwcharmap TX_FULLWIDTH2, "鈍", $60
	fwcharmap TX_FULLWIDTH2, "押", $61
	fwcharmap TX_FULLWIDTH2, "刷", $62
	fwcharmap TX_FULLWIDTH2, "王", $63
	fwcharmap TX_FULLWIDTH2, "肌", $64
	fwcharmap TX_FULLWIDTH2, "調", $65
	fwcharmap TX_FULLWIDTH2, "公", $66
	fwcharmap TX_FULLWIDTH2, "示", $67
	fwcharmap TX_FULLWIDTH2, "双", $68
	fwcharmap TX_FULLWIDTH2, "指", $69
	fwcharmap TX_FULLWIDTH2, "来", $6a
	fwcharmap TX_FULLWIDTH2, "志", $6b
	fwcharmap TX_FULLWIDTH2, "林", $6c
	fwcharmap TX_FULLWIDTH2, "川", $6d
	fwcharmap TX_FULLWIDTH2, "幾", $6e
	fwcharmap TX_FULLWIDTH2, "止", $6f
	fwcharmap TX_FULLWIDTH2, "源", $70
	fwcharmap TX_FULLWIDTH2, "卵", $71
	fwcharmap TX_FULLWIDTH2, "棚", $72
	fwcharmap TX_FULLWIDTH2, "宇", $73
	fwcharmap TX_FULLWIDTH2, "質", $74
	fwcharmap TX_FULLWIDTH2, "問", $75
	fwcharmap TX_FULLWIDTH2, "備", $76
	fwcharmap TX_FULLWIDTH2, "準", $77
	fwcharmap TX_FULLWIDTH2, "宙", $78
	fwcharmap TX_FULLWIDTH2, "疑", $79
	fwcharmap TX_FULLWIDTH2, "周", $7a
	fwcharmap TX_FULLWIDTH2, "汚", $7b
	fwcharmap TX_FULLWIDTH2, "月", $7c
	fwcharmap TX_FULLWIDTH2, "德", $7d
	fwcharmap TX_FULLWIDTH2, "蜜", $7e
	fwcharmap TX_FULLWIDTH2, "法", $7f
	fwcharmap TX_FULLWIDTH2, "破", $80
	fwcharmap TX_FULLWIDTH2, "殴", $81
	fwcharmap TX_FULLWIDTH2, "忙", $82
	fwcharmap TX_FULLWIDTH2, "降", $83
	fwcharmap TX_FULLWIDTH2, "乗", $84
	fwcharmap TX_FULLWIDTH2, "十", $85
	fwcharmap TX_FULLWIDTH2, "薬", $86
	fwcharmap TX_FULLWIDTH2, "違", $87
	fwcharmap TX_FULLWIDTH2, "会", $88
	fwcharmap TX_FULLWIDTH2, "似", $89
	fwcharmap TX_FULLWIDTH2, "眼", $8a
	fwcharmap TX_FULLWIDTH2, "船", $8b
	fwcharmap TX_FULLWIDTH2, "雪", $8c
	fwcharmap TX_FULLWIDTH2, "級", $8d
	fwcharmap TX_FULLWIDTH2, "冷", $8e
	fwcharmap TX_FULLWIDTH2, "凍", $8f
	fwcharmap TX_FULLWIDTH2, "拾", $90
	fwcharmap TX_FULLWIDTH2, "帰", $91
	fwcharmap TX_FULLWIDTH2, "敬", $92
	fwcharmap TX_FULLWIDTH2, "克", $93
	fwcharmap TX_FULLWIDTH2, "服", $94
	fwcharmap TX_FULLWIDTH2, "夏", $95
	fwcharmap TX_FULLWIDTH2, "休", $96
	fwcharmap TX_FULLWIDTH2, "岸", $97
	fwcharmap TX_FULLWIDTH2, "昼", $98
	fwcharmap TX_FULLWIDTH2, "咲", $99
	fwcharmap TX_FULLWIDTH2, "太", $9a
	fwcharmap TX_FULLWIDTH2, "噛", $9b
	fwcharmap TX_FULLWIDTH2, "反", $9c
	fwcharmap TX_FULLWIDTH2, "珍", $9d
	fwcharmap TX_FULLWIDTH2, "喜", $9e
	fwcharmap TX_FULLWIDTH2, "陽", $9f
	fwcharmap TX_FULLWIDTH2, "緑", $a0
	fwcharmap TX_FULLWIDTH2, "糸", $a1
	fwcharmap TX_FULLWIDTH2, "約", $a2
	fwcharmap TX_FULLWIDTH2, "包", $a3
	fwcharmap TX_FULLWIDTH2, "識", $a4
	fwcharmap TX_FULLWIDTH2, "悲", $a5
	fwcharmap TX_FULLWIDTH2, "耐", $a6
	fwcharmap TX_FULLWIDTH2, "貫", $a7
	fwcharmap TX_FULLWIDTH2, "天", $a8
	fwcharmap TX_FULLWIDTH2, "司", $a9
	fwcharmap TX_FULLWIDTH2, "神", $aa
	fwcharmap TX_FULLWIDTH2, "情", $ab
	fwcharmap TX_FULLWIDTH2, "千", $ac
	fwcharmap TX_FULLWIDTH2, "過", $ad
	fwcharmap TX_FULLWIDTH2, "巨", $ae
	fwcharmap TX_FULLWIDTH2, "稲", $af
	fwcharmap TX_FULLWIDTH2, "妻", $b0
	fwcharmap TX_FULLWIDTH2, "守", $b1
	fwcharmap TX_FULLWIDTH2, "産", $b2
	fwcharmap TX_FULLWIDTH2, "森", $b3
	fwcharmap TX_FULLWIDTH2, "球", $b4
	fwcharmap TX_FULLWIDTH2, "迫", $b5
	fwcharmap TX_FULLWIDTH2, "団", $b6
	fwcharmap TX_FULLWIDTH2, "爪", $b7
	fwcharmap TX_FULLWIDTH2, "浅", $b8
	fwcharmap TX_FULLWIDTH2, "盛", $b9
	fwcharmap TX_FULLWIDTH2, "油", $ba
	fwcharmap TX_FULLWIDTH2, "凶", $bb
	fwcharmap TX_FULLWIDTH2, "筋", $bc
	fwcharmap TX_FULLWIDTH2, "織", $bd
	fwcharmap TX_FULLWIDTH2, "供", $be
	fwcharmap TX_FULLWIDTH2, "墓", $bf
	fwcharmap TX_FULLWIDTH2, "疲", $c0
	fwcharmap TX_FULLWIDTH2, "靱", $c1
	fwcharmap TX_FULLWIDTH2, "荷", $c2
	fwcharmap TX_FULLWIDTH2, "瞬", $c3
	fwcharmap TX_FULLWIDTH2, "搬", $c4
	fwcharmap TX_FULLWIDTH2, "仕", $c5
	fwcharmap TX_FULLWIDTH2, "腕", $c6
	fwcharmap TX_FULLWIDTH2, "類", $c7
	fwcharmap TX_FULLWIDTH2, "坂", $c8
	fwcharmap TX_FULLWIDTH2, "可", $c9
	fwcharmap TX_FULLWIDTH2, "盤", $ca
	fwcharmap TX_FULLWIDTH2, "土", $cb
	fwcharmap TX_FULLWIDTH2, "母", $cc
	fwcharmap TX_FULLWIDTH2, "親", $cd
	fwcharmap TX_FULLWIDTH2, "棲", $ce
	fwcharmap TX_FULLWIDTH2, "寂", $cf
	fwcharmap TX_FULLWIDTH2, "科", $d0
	fwcharmap TX_FULLWIDTH2, "泣", $d1
	fwcharmap TX_FULLWIDTH2, "武", $d2
	fwcharmap TX_FULLWIDTH2, "器", $d3
	fwcharmap TX_FULLWIDTH2, "縮", $d4
	fwcharmap TX_FULLWIDTH2, "蹴", $d5
	fwcharmap TX_FULLWIDTH2, "魂", $d6
	fwcharmap TX_FULLWIDTH2, "悪", $d7
	fwcharmap TX_FULLWIDTH2, "層", $d8
	fwcharmap TX_FULLWIDTH2, "厚", $d9
	fwcharmap TX_FULLWIDTH2, "砕", $da
	fwcharmap TX_FULLWIDTH2, "計", $db
	fwcharmap TX_FULLWIDTH2, "惑", $dc
	fwcharmap TX_FULLWIDTH2, "再", $dd
	fwcharmap TX_FULLWIDTH2, "護", $de
	fwcharmap TX_FULLWIDTH2, "恐", $df
	fwcharmap TX_FULLWIDTH2, "竜", $e0
	fwcharmap TX_FULLWIDTH2, "形", $e1
	fwcharmap TX_FULLWIDTH2, "鳴", $e2
	fwcharmap TX_FULLWIDTH2, "原", $e3
	fwcharmap TX_FULLWIDTH2, "朝", $e4
	fwcharmap TX_FULLWIDTH2, "存", $e5
	fwcharmap TX_FULLWIDTH2, "割", $e6
	fwcharmap TX_FULLWIDTH2, "因", $e7
	fwcharmap TX_FULLWIDTH2, "興", $e8
	fwcharmap TX_FULLWIDTH2, "漢", $e9
	fwcharmap TX_FULLWIDTH2, "奮", $ea
	fwcharmap TX_FULLWIDTH2, "謎", $eb
	fwcharmap TX_FULLWIDTH2, "誰", $ec
	fwcharmap TX_FULLWIDTH2, "遭", $ed
	fwcharmap TX_FULLWIDTH2, "串", $ee
	fwcharmap TX_FULLWIDTH2, "牙", $ef
	fwcharmap TX_FULLWIDTH2, "黑", $f0
	fwcharmap TX_FULLWIDTH2, "薄", $f1
	fwcharmap TX_FULLWIDTH2, "念", $f2
	fwcharmap TX_FULLWIDTH2, "湿", $f3
	fwcharmap TX_FULLWIDTH2, "臓", $f4
	fwcharmap TX_FULLWIDTH2, "南", $f5
	fwcharmap TX_FULLWIDTH2, "渦", $f6
	fwcharmap TX_FULLWIDTH2, "暮", $f7
	fwcharmap TX_FULLWIDTH2, "晶", $f8
	fwcharmap TX_FULLWIDTH2, "執", $f9
	fwcharmap TX_FULLWIDTH2, "並", $fa
	fwcharmap TX_FULLWIDTH2, "期", $fb
	fwcharmap TX_FULLWIDTH2, "配", $fc
	fwcharmap TX_FULLWIDTH2, "魅", $fd
	fwcharmap TX_FULLWIDTH2, "夕", $fe
	fwcharmap TX_FULLWIDTH2, "彗", $ff

; TX_FULLWIDTH3
	fwcharmap TX_FULLWIDTH3, "散", $10
	fwcharmap TX_FULLWIDTH3, "振", $11
	fwcharmap TX_FULLWIDTH3, "去", $12
	fwcharmap TX_FULLWIDTH3, "件", $13
	fwcharmap TX_FULLWIDTH3, "首", $14
	fwcharmap TX_FULLWIDTH3, "甲", $15
	fwcharmap TX_FULLWIDTH3, "羅", $16
	fwcharmap TX_FULLWIDTH3, "込", $17
	fwcharmap TX_FULLWIDTH3, "勢", $18
	fwcharmap TX_FULLWIDTH3, "召", $19
	fwcharmap TX_FULLWIDTH3, "喚", $1a
	fwcharmap TX_FULLWIDTH3, "酔", $1b
	fwcharmap TX_FULLWIDTH3, "直", $1c
	fwcharmap TX_FULLWIDTH3, "悩", $1d
	fwcharmap TX_FULLWIDTH3, "詰", $1e
	fwcharmap TX_FULLWIDTH3, "例", $1f
	fwcharmap TX_FULLWIDTH3, "越", $20
	fwcharmap TX_FULLWIDTH3, "京", $21
	fwcharmap TX_FULLWIDTH3, "東", $22
	fwcharmap TX_FULLWIDTH3, "壁", $23
	fwcharmap TX_FULLWIDTH3, "付", $24
	fwcharmap TX_FULLWIDTH3, "跳", $25
	fwcharmap TX_FULLWIDTH3, "吠", $26
	fwcharmap TX_FULLWIDTH3, "徵", $27
	fwcharmap TX_FULLWIDTH3, "誕", $28
	fwcharmap TX_FULLWIDTH3, "今", $29
	fwcharmap TX_FULLWIDTH3, "封", $2a
	fwcharmap TX_FULLWIDTH3, "雅", $2b
	fwcharmap TX_FULLWIDTH3, "誠", $2c
	fwcharmap TX_FULLWIDTH3, "置", $2d
	fwcharmap TX_FULLWIDTH3, "祟", $2e
	fwcharmap TX_FULLWIDTH3, "掴", $2f
	fwcharmap TX_FULLWIDTH3, "飲", $30
	fwcharmap TX_FULLWIDTH3, "噂", $31
	fwcharmap TX_FULLWIDTH3, "稼", $32
	fwcharmap TX_FULLWIDTH3, "介", $33
	fwcharmap TX_FULLWIDTH3, "塊", $34
	fwcharmap TX_FULLWIDTH3, "階", $35
	fwcharmap TX_FULLWIDTH3, "観", $36
	fwcharmap TX_FULLWIDTH3, "棄", $37
	fwcharmap TX_FULLWIDTH3, "技", $38
	fwcharmap TX_FULLWIDTH3, "急", $39
	fwcharmap TX_FULLWIDTH3, "牛", $3a
	fwcharmap TX_FULLWIDTH3, "業", $3b
	fwcharmap TX_FULLWIDTH3, "窟", $3c
	fwcharmap TX_FULLWIDTH3, "繰", $3d
	fwcharmap TX_FULLWIDTH3, "嫌", $3e
	fwcharmap TX_FULLWIDTH3, "検", $3f
	fwcharmap TX_FULLWIDTH3, "向", $40
	fwcharmap TX_FULLWIDTH3, "校", $41
	fwcharmap TX_FULLWIDTH3, "参", $42
	fwcharmap TX_FULLWIDTH3, "飼", $43
	fwcharmap TX_FULLWIDTH3, "歯", $44
	fwcharmap TX_FULLWIDTH3, "襲", $45
	fwcharmap TX_FULLWIDTH3, "従", $46
	fwcharmap TX_FULLWIDTH3, "傷", $47
	fwcharmap TX_FULLWIDTH3, "焼", $48
	fwcharmap TX_FULLWIDTH3, "殖", $49
	fwcharmap TX_FULLWIDTH3, "瀬", $4a
	fwcharmap TX_FULLWIDTH3, "星", $4b
	fwcharmap TX_FULLWIDTH3, "造", $4c
	fwcharmap TX_FULLWIDTH3, "他", $4d
	fwcharmap TX_FULLWIDTH3, "探", $4e
	fwcharmap TX_FULLWIDTH3, "致", $4f
	fwcharmap TX_FULLWIDTH3, "挑", $50
	fwcharmap TX_FULLWIDTH3, "町", $51
	fwcharmap TX_FULLWIDTH3, "釣", $52
	fwcharmap TX_FULLWIDTH3, "低", $53
	fwcharmap TX_FULLWIDTH3, "提", $54
	fwcharmap TX_FULLWIDTH3, "吐", $55
	fwcharmap TX_FULLWIDTH3, "洞", $56
	fwcharmap TX_FULLWIDTH3, "独", $57
	fwcharmap TX_FULLWIDTH3, "乳", $58
	fwcharmap TX_FULLWIDTH3, "廃", $59
	fwcharmap TX_FULLWIDTH3, "兵", $5a
	fwcharmap TX_FULLWIDTH3, "癖", $5b
	fwcharmap TX_FULLWIDTH3, "保", $5c
	fwcharmap TX_FULLWIDTH3, "抱", $5d
	fwcharmap TX_FULLWIDTH3, "貌", $5e
	fwcharmap TX_FULLWIDTH3, "防", $5f
	fwcharmap TX_FULLWIDTH3, "没", $60
	fwcharmap TX_FULLWIDTH3, "煙", $61
	fwcharmap TX_FULLWIDTH3, "応", $62
	fwcharmap TX_FULLWIDTH3, "横", $63
	fwcharmap TX_FULLWIDTH3, "汗", $64
	fwcharmap TX_FULLWIDTH3, "規", $65
	fwcharmap TX_FULLWIDTH3, "競", $66
	fwcharmap TX_FULLWIDTH3, "茶", $67
	fwcharmap TX_FULLWIDTH3, "苦", $68
	fwcharmap TX_FULLWIDTH3, "駆", $69
	fwcharmap TX_FULLWIDTH3, "訓", $6a
	fwcharmap TX_FULLWIDTH3, "幸", $6b
	fwcharmap TX_FULLWIDTH3, "腰", $6c
	fwcharmap TX_FULLWIDTH3, "砂", $6d
	fwcharmap TX_FULLWIDTH3, "邪", $6e
	fwcharmap TX_FULLWIDTH3, "掌", $6f
	fwcharmap TX_FULLWIDTH3, "衝", $70
	fwcharmap TX_FULLWIDTH3, "寸", $71
	fwcharmap TX_FULLWIDTH3, "制", $72
	fwcharmap TX_FULLWIDTH3, "跡", $73
	fwcharmap TX_FULLWIDTH3, "争", $74
	fwcharmap TX_FULLWIDTH3, "則", $75
	fwcharmap TX_FULLWIDTH3, "短", $76
	fwcharmap TX_FULLWIDTH3, "着", $77
	fwcharmap TX_FULLWIDTH3, "踏", $78
	fwcharmap TX_FULLWIDTH3, "読", $79
	fwcharmap TX_FULLWIDTH3, "濡", $7a
	fwcharmap TX_FULLWIDTH3, "版", $7b
	fwcharmap TX_FULLWIDTH3, "氷", $7c
	fwcharmap TX_FULLWIDTH3, "布", $7d
	fwcharmap TX_FULLWIDTH3, "平", $7e
	fwcharmap TX_FULLWIDTH3, "返", $7f
	fwcharmap TX_FULLWIDTH3, "募", $80
	fwcharmap TX_FULLWIDTH3, "魔", $81
	fwcharmap TX_FULLWIDTH3, "容", $82
	fwcharmap TX_FULLWIDTH3, "踊", $83
	fwcharmap TX_FULLWIDTH3, "陸", $84
	fwcharmap TX_FULLWIDTH3, "侵", $85
	fwcharmap TX_FULLWIDTH3, "域", $86
	fwcharmap TX_FULLWIDTH3, "遅", $87
	fwcharmap TX_FULLWIDTH3, "素", $88
	fwcharmap TX_FULLWIDTH3, "腦", $89
	fwcharmap TX_FULLWIDTH3, "吹", $8a
	fwcharmap TX_FULLWIDTH3, "笑", $8b
	fwcharmap TX_FULLWIDTH3, "己", $8c
	fwcharmap TX_FULLWIDTH3, "忍", $8d
	fwcharmap TX_FULLWIDTH3, "条", $8e
	fwcharmap TX_FULLWIDTH3, "刀", $8f
	fwcharmap TX_FULLWIDTH3, "怠", $90
	fwcharmap TX_FULLWIDTH3, "遊", $91
	fwcharmap TX_FULLWIDTH3, "型", $92
	fwcharmap TX_FULLWIDTH3, "博", $93
	fwcharmap TX_FULLWIDTH3, "士", $94
	fwcharmap TX_FULLWIDTH3, "勇", $95
	fwcharmap TX_FULLWIDTH3, "環", $96
	fwcharmap TX_FULLWIDTH3, "境", $97
	fwcharmap TX_FULLWIDTH3, "暑", $98
	fwcharmap TX_FULLWIDTH3, "玉", $99
	fwcharmap TX_FULLWIDTH3, "噴", $9a
	fwcharmap TX_FULLWIDTH3, "停", $9b
	fwcharmap TX_FULLWIDTH3, "装", $9c
	fwcharmap TX_FULLWIDTH3, "号", $9d
	fwcharmap TX_FULLWIDTH3, "島", $9e
	fwcharmap TX_FULLWIDTH3, "覽", $9f
	fwcharmap TX_FULLWIDTH3, "莊", $a0
	fwcharmap TX_FULLWIDTH3, "祭", $a1
	fwcharmap TX_FULLWIDTH3, "壇", $a2
	fwcharmap TX_FULLWIDTH3, "予", $a3
	fwcharmap TX_FULLWIDTH3, "範", $a4
	fwcharmap TX_FULLWIDTH3, "囲", $a5
	fwcharmap TX_FULLWIDTH3, "商", $a6
	fwcharmap TX_FULLWIDTH3, "報", $a7
	fwcharmap TX_FULLWIDTH3, "率", $a8
	fwcharmap TX_FULLWIDTH3, "私", $a9
	fwcharmap TX_FULLWIDTH3, "語", $aa
	fwcharmap TX_FULLWIDTH3, "妖", $ab
	fwcharmap TX_FULLWIDTH3, "脅", $ac
	fwcharmap TX_FULLWIDTH3, "精", $ad
	fwcharmap TX_FULLWIDTH3, "仲", $ae
	fwcharmap TX_FULLWIDTH3, "底", $af
	fwcharmap TX_FULLWIDTH3, "静", $b0
	fwcharmap TX_FULLWIDTH3, "撒", $b1
	fwcharmap TX_FULLWIDTH3, "街", $b2
	fwcharmap TX_FULLWIDTH3, "題", $b3
	fwcharmap TX_FULLWIDTH3, "秘", $b4
	fwcharmap TX_FULLWIDTH3, "密", $b5
	fwcharmap TX_FULLWIDTH3, "靭", $b6

; TX_FULLWIDTH4
	fwcharmap TX_FULLWIDTH4, "A", $10
	fwcharmap TX_FULLWIDTH4, "B", $11
	fwcharmap TX_FULLWIDTH4, "C", $12
	fwcharmap TX_FULLWIDTH4, "D", $13
	fwcharmap TX_FULLWIDTH4, "E", $14
	fwcharmap TX_FULLWIDTH4, "F", $15
	fwcharmap TX_FULLWIDTH4, "G", $16
	fwcharmap TX_FULLWIDTH4, "H", $17
	fwcharmap TX_FULLWIDTH4, "I", $18
	fwcharmap TX_FULLWIDTH4, "J", $19
	fwcharmap TX_FULLWIDTH4, "K", $1a
	fwcharmap TX_FULLWIDTH4, "L", $1b
	fwcharmap TX_FULLWIDTH4, "M", $1c
	fwcharmap TX_FULLWIDTH4, "N", $1d
	fwcharmap TX_FULLWIDTH4, "O", $1e
	fwcharmap TX_FULLWIDTH4, "P", $1f
	fwcharmap TX_FULLWIDTH4, "Q", $20
	fwcharmap TX_FULLWIDTH4, "R", $21
	fwcharmap TX_FULLWIDTH4, "S", $22
	fwcharmap TX_FULLWIDTH4, "T", $23
	fwcharmap TX_FULLWIDTH4, "U", $24
	fwcharmap TX_FULLWIDTH4, "V", $25
	fwcharmap TX_FULLWIDTH4, "W", $26
	fwcharmap TX_FULLWIDTH4, "X", $27
	fwcharmap TX_FULLWIDTH4, "Y", $28
	fwcharmap TX_FULLWIDTH4, "Z", $29
	fwcharmap TX_FULLWIDTH4, "a", $2a
	fwcharmap TX_FULLWIDTH4, "b", $2b
	fwcharmap TX_FULLWIDTH4, "c", $2c
	fwcharmap TX_FULLWIDTH4, "d", $2d
	fwcharmap TX_FULLWIDTH4, "e", $2e
	fwcharmap TX_FULLWIDTH4, "f", $2f
	fwcharmap TX_FULLWIDTH4, "g", $30
	fwcharmap TX_FULLWIDTH4, "h", $31
	fwcharmap TX_FULLWIDTH4, "i", $32
	fwcharmap TX_FULLWIDTH4, "j", $33
	fwcharmap TX_FULLWIDTH4, "k", $34
	fwcharmap TX_FULLWIDTH4, "l", $35
	fwcharmap TX_FULLWIDTH4, "m", $36
	fwcharmap TX_FULLWIDTH4, "n", $37
	fwcharmap TX_FULLWIDTH4, "o", $38
	fwcharmap TX_FULLWIDTH4, "p", $39
	fwcharmap TX_FULLWIDTH4, "q", $3a
	fwcharmap TX_FULLWIDTH4, "r", $3b
	fwcharmap TX_FULLWIDTH4, "s", $3c
	fwcharmap TX_FULLWIDTH4, "t", $3d
	fwcharmap TX_FULLWIDTH4, "u", $3e
	fwcharmap TX_FULLWIDTH4, "v", $3f
	fwcharmap TX_FULLWIDTH4, "w", $40
	fwcharmap TX_FULLWIDTH4, "x", $41
	fwcharmap TX_FULLWIDTH4, "y", $42
	fwcharmap TX_FULLWIDTH4, "z", $43
	fwcharmap TX_FULLWIDTH4, "~", $44
	fwcharmap TX_FULLWIDTH4, "※", $45
	fwcharmap TX_FULLWIDTH4, "о", $46
	fwcharmap TX_FULLWIDTH4, "^", $47
	fwcharmap TX_FULLWIDTH4, "♪", $48
	fwcharmap TX_FULLWIDTH4, "♀", $49
	fwcharmap TX_FULLWIDTH4, "♂", $4a
	fwcharmap TX_FULLWIDTH4, "々", $4b
	fwcharmap TX_FULLWIDTH4, "ヴ", $4c
	fwcharmap TX_FULLWIDTH4, "@", $4d
	fwcharmap TX_FULLWIDTH4, ":", $4e
	fwcharmap TX_FULLWIDTH4, ";", $4f
	fwcharmap TX_FULLWIDTH4, "【", $50
	fwcharmap TX_FULLWIDTH4, "】", $51
	fwcharmap TX_FULLWIDTH4, "○", $52
	fwcharmap TX_FULLWIDTH4, "●", $53
	fwcharmap TX_FULLWIDTH4, "◆", $54
	fwcharmap TX_FULLWIDTH4, "★", $55
	fwcharmap TX_FULLWIDTH4, "☆", $56
	fwcharmap TX_FULLWIDTH4, "_", $57
	fwcharmap TX_FULLWIDTH4, "▪", $58
	fwcharmap TX_FULLWIDTH4, "℃", $59
	fwcharmap TX_FULLWIDTH4, "゛", $5a
	fwcharmap TX_FULLWIDTH4, "°", $5b
	fwcharmap TX_FULLWIDTH4, "゜", $5c
	fwcharmap TX_FULLWIDTH4, "ˍ", $5d
	fwcharmap TX_FULLWIDTH4, "&", $5e
	fwcharmap TX_FULLWIDTH4, "*", $5f
	fwcharmap TX_FULLWIDTH4, "<", $60
	fwcharmap TX_FULLWIDTH4, ">", $61
	fwcharmap TX_FULLWIDTH4, "=", $62
	fwcharmap TX_FULLWIDTH4, "◇", $63
	fwcharmap TX_FULLWIDTH4, "ˉ", $64

DEF FW_SPACE EQU $70

MACRO txsymbol
	const SYM_\1
	charmap "\1>", const_value - 1
ENDM

; TX_SYMBOL
; TODO: If user-defined functions ever become a thing a symbol(*) syntax
;       would probably be preferred over SYM_*
	charmap "<", TX_SYMBOL
	const_def
	txsymbol SPACE      ; $00
	txsymbol FIRE       ; $01
	txsymbol GRASS      ; $02
	txsymbol LIGHTNING  ; $03
	txsymbol WATER      ; $04
	txsymbol FIGHTING   ; $05
	txsymbol PSYCHIC    ; $06
	txsymbol COLORLESS  ; $07
	txsymbol RAINBOW    ; $08
	txsymbol POISONED   ; $09
	txsymbol ASLEEP     ; $0a
	txsymbol CONFUSED   ; $0b
	txsymbol PARALYZED  ; $0c
	txsymbol CURSOR_U   ; $0d
	txsymbol ATK_DESCR  ; $0e
	txsymbol CURSOR_R   ; $0f
	txsymbol HP         ; $10
	txsymbol Lv         ; $11
	txsymbol E          ; $12
	txsymbol No         ; $13
	txsymbol PLUSPOWER  ; $14
	txsymbol DEFENDER   ; $15
	txsymbol HP_OK      ; $16
	txsymbol HP_NOK     ; $17
	txsymbol BOX_TOP_L  ; $18
	txsymbol BOX_TOP_R  ; $19
	txsymbol BOX_BTM_L  ; $1a
	txsymbol BOX_BTM_R  ; $1b
	txsymbol BOX_TOP    ; $1c
	txsymbol BOX_BOTTOM ; $1d
	txsymbol BOX_LEFT   ; $1e
	txsymbol BOX_RIGHT  ; $1f
	txsymbol 0          ; $20
	txsymbol 1          ; $21
	txsymbol 2          ; $22
	txsymbol 3          ; $23
	txsymbol 4          ; $24
	txsymbol 5          ; $25
	txsymbol 6          ; $26
	txsymbol 7          ; $27
	txsymbol 8          ; $28
	txsymbol 9          ; $29
	txsymbol DOT        ; $2a
	txsymbol PLUS       ; $2b
	txsymbol MINUS      ; $2c
	txsymbol CROSS      ; $2d
	txsymbol SLASH      ; $2e
	txsymbol CURSOR_D   ; $2f
	txsymbol PRIZE      ; $30
	txsymbol BOX_ALT_1  ; $31
	txsymbol BOX_ALT_2  ; $32
	txsymbol BOX_ALT_3  ; $33
	txsymbol BOX_ALT_4  ; $34
	txsymbol POKEMON    ; $35
	txsymbol CHERRY     ; $36
