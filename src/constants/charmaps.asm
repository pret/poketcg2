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
	charmap STRCAT("FW\1_", \2), \3
ENDM

; TX_KATAKANA
	fwcharmap 0, "ヲ", $10
	fwcharmap 0, "ア", $11
	fwcharmap 0, "イ", $12
	fwcharmap 0, "ウ", $13
	fwcharmap 0, "エ", $14
	fwcharmap 0, "オ", $15
	fwcharmap 0, "カ", $16
	fwcharmap 0, "キ", $17
	fwcharmap 0, "ク", $18
	fwcharmap 0, "ケ", $19
	fwcharmap 0, "コ", $1a
	fwcharmap 0, "サ", $1b
	fwcharmap 0, "シ", $1c
	fwcharmap 0, "ス", $1d
	fwcharmap 0, "セ", $1e
	fwcharmap 0, "ソ", $1f
	fwcharmap 0, "タ", $20
	fwcharmap 0, "チ", $21
	fwcharmap 0, "ツ", $22
	fwcharmap 0, "テ", $23
	fwcharmap 0, "ト", $24
	fwcharmap 0, "ナ", $25
	fwcharmap 0, "ニ", $26
	fwcharmap 0, "ヌ", $27
	fwcharmap 0, "ネ", $28
	fwcharmap 0, "ノ", $29
	fwcharmap 0, "ハ", $2a
	fwcharmap 0, "ヒ", $2b
	fwcharmap 0, "フ", $2c
	fwcharmap 0, "ヘ", $2d
	fwcharmap 0, "ホ", $2e
	fwcharmap 0, "マ", $2f
	fwcharmap 0, "ミ", $30
	fwcharmap 0, "ム", $31
	fwcharmap 0, "メ", $32
	fwcharmap 0, "モ", $33
	fwcharmap 0, "ヤ", $34
	fwcharmap 0, "ユ", $35
	fwcharmap 0, "ヨ", $36
	fwcharmap 0, "ラ", $37
	fwcharmap 0, "リ", $38
	fwcharmap 0, "ル", $39
	fwcharmap 0, "レ", $3a
	fwcharmap 0, "ロ", $3b
	fwcharmap 0, "ワ", $3c
	fwcharmap 0, "ン", $3d
	fwcharmap 0, "ガ", $3e
	fwcharmap 0, "ギ", $3f
	fwcharmap 0, "グ", $40
	fwcharmap 0, "ゲ", $41
	fwcharmap 0, "ゴ", $42
	fwcharmap 0, "ザ", $43
	fwcharmap 0, "ジ", $44
	fwcharmap 0, "ズ", $45
	fwcharmap 0, "ゼ", $46
	fwcharmap 0, "ゾ", $47
	fwcharmap 0, "ダ", $48
	fwcharmap 0, "ヂ", $49
	fwcharmap 0, "ヅ", $4a
	fwcharmap 0, "デ", $4b
	fwcharmap 0, "ド", $4c
	fwcharmap 0, "バ", $4d
	fwcharmap 0, "ビ", $4e
	fwcharmap 0, "ブ", $4f
	fwcharmap 0, "ベ", $50
	fwcharmap 0, "ボ", $51
	fwcharmap 0, "パ", $52
	fwcharmap 0, "ピ", $53
	fwcharmap 0, "プ", $54
	fwcharmap 0, "ペ", $55
	fwcharmap 0, "ポ", $56
	fwcharmap 0, "ァ", $57
	fwcharmap 0, "ィ", $58
	fwcharmap 0, "ゥ", $59
	fwcharmap 0, "ェ", $5a
	fwcharmap 0, "ォ", $5b
	fwcharmap 0, "ャ", $5c
	fwcharmap 0, "ュ", $5d
	fwcharmap 0, "ョ", $5e
	fwcharmap 0, "ッ", $5f

; TX_HIRAGANA
	fwcharmap 0, "を", $10
	fwcharmap 0, "あ", $11
	fwcharmap 0, "い", $12
	fwcharmap 0, "う", $13
	fwcharmap 0, "え", $14
	fwcharmap 0, "お", $15
	fwcharmap 0, "か", $16
	fwcharmap 0, "き", $17
	fwcharmap 0, "く", $18
	fwcharmap 0, "け", $19
	fwcharmap 0, "こ", $1a
	fwcharmap 0, "さ", $1b
	fwcharmap 0, "し", $1c
	fwcharmap 0, "す", $1d
	fwcharmap 0, "せ", $1e
	fwcharmap 0, "そ", $1f
	fwcharmap 0, "た", $20
	fwcharmap 0, "ち", $21
	fwcharmap 0, "つ", $22
	fwcharmap 0, "て", $23
	fwcharmap 0, "と", $24
	fwcharmap 0, "な", $25
	fwcharmap 0, "に", $26
	fwcharmap 0, "ぬ", $27
	fwcharmap 0, "ね", $28
	fwcharmap 0, "の", $29
	fwcharmap 0, "は", $2a
	fwcharmap 0, "ひ", $2b
	fwcharmap 0, "ふ", $2c
	fwcharmap 0, "へ", $2d
	fwcharmap 0, "ほ", $2e
	fwcharmap 0, "ま", $2f
	fwcharmap 0, "み", $30
	fwcharmap 0, "む", $31
	fwcharmap 0, "め", $32
	fwcharmap 0, "も", $33
	fwcharmap 0, "や", $34
	fwcharmap 0, "ゆ", $35
	fwcharmap 0, "よ", $36
	fwcharmap 0, "ら", $37
	fwcharmap 0, "り", $38
	fwcharmap 0, "る", $39
	fwcharmap 0, "れ", $3a
	fwcharmap 0, "ろ", $3b
	fwcharmap 0, "わ", $3c
	fwcharmap 0, "ん", $3d
	fwcharmap 0, "が", $3e
	fwcharmap 0, "ぎ", $3f
	fwcharmap 0, "ぐ", $40
	fwcharmap 0, "げ", $41
	fwcharmap 0, "ご", $42
	fwcharmap 0, "ざ", $43
	fwcharmap 0, "じ", $44
	fwcharmap 0, "ず", $45
	fwcharmap 0, "ぜ", $46
	fwcharmap 0, "ぞ", $47
	fwcharmap 0, "だ", $48
	fwcharmap 0, "ぢ", $49
	fwcharmap 0, "づ", $4a
	fwcharmap 0, "で", $4b
	fwcharmap 0, "ど", $4c
	fwcharmap 0, "ば", $4d
	fwcharmap 0, "び", $4e
	fwcharmap 0, "ぶ", $4f
	fwcharmap 0, "べ", $50
	fwcharmap 0, "ぼ", $51
	fwcharmap 0, "ぱ", $52
	fwcharmap 0, "ぴ", $53
	fwcharmap 0, "ぷ", $54
	fwcharmap 0, "ぺ", $55
	fwcharmap 0, "ぽ", $56
	fwcharmap 0, "ぁ", $57
	fwcharmap 0, "ぃ", $58
	fwcharmap 0, "ぅ", $59
	fwcharmap 0, "ぇ", $5a
	fwcharmap 0, "ぉ", $5b
	fwcharmap 0, "ゃ", $5c
	fwcharmap 0, "ゅ", $5d
	fwcharmap 0, "ょ", $5e
	fwcharmap 0, "っ", $5f

; TX_KATAKANA, TX_HIRAGANA, and TX_FULLWIDTH0
	fwcharmap 0, "0", $60
	fwcharmap 0, "1", $61
	fwcharmap 0, "2", $62
	fwcharmap 0, "3", $63
	fwcharmap 0, "4", $64
	fwcharmap 0, "5", $65
	fwcharmap 0, "6", $66
	fwcharmap 0, "7", $67
	fwcharmap 0, "8", $68
	fwcharmap 0, "9", $69
	fwcharmap 0, "+", $6a
	fwcharmap 0, "-", $6b
	fwcharmap 0, "×", $6c
	fwcharmap 0, "/", $6d
	fwcharmap 0, "!", $6e
	fwcharmap 0, "?", $6f
	fwcharmap 0, " ", $70
	fwcharmap 0, "(", $71
	fwcharmap 0, ")", $72
	fwcharmap 0, "「", $73
	fwcharmap 0, "」", $74
	fwcharmap 0, "、", $75
	fwcharmap 0, "。", $76
	fwcharmap 0, "・", $77
	fwcharmap 0, "ー", $78
	fwcharmap 0, "ṛ", $79 ; r.

	; [相手]
	fwcharmap 0, "7a", $7a
	fwcharmap 0, "7b", $7b
	fwcharmap 0, "7c", $7c

	; [自分]
	fwcharmap 0, "7d", $7d
	fwcharmap 0, "7e", $7e
	fwcharmap 0, "7f", $7f

	fwcharmap 0, "手", $80
	fwcharmap 0, "戦", $81
	fwcharmap 0, "対", $82
	fwcharmap 0, "説", $83
	fwcharmap 0, "枚", $84
	fwcharmap 0, "札", $85
	fwcharmap 0, "相", $86
	fwcharmap 0, "名", $87
	fwcharmap 0, "人", $88
	fwcharmap 0, "伝", $89
	fwcharmap 0, "選", $8a
	fwcharmap 0, "自", $8b
	fwcharmap 0, "分", $8c
	fwcharmap 0, "力", $8d
	fwcharmap 0, "場", $8e
	fwcharmap 0, "山", $8f
	fwcharmap 0, "勝", $90
	fwcharmap 0, "使", $91
	fwcharmap 0, "択", $92
	fwcharmap 0, "化", $93
	fwcharmap 0, "時", $94
	fwcharmap 0, "状", $95
	fwcharmap 0, "進", $96
	fwcharmap 0, "回", $97
	fwcharmap 0, "番", $98
	fwcharmap 0, "態", $99
	fwcharmap 0, "出", $9a
	fwcharmap 0, "中", $9b
	fwcharmap 0, "投", $9c
	fwcharmap 0, "強", $9d
	fwcharmap 0, "本", $9e
	fwcharmap 0, "果", $9f
	fwcharmap 0, "効", $a0
	fwcharmap 0, "解", $a1
	fwcharmap 0, "定", $a2
	fwcharmap 0, "色", $a3
	fwcharmap 0, "見", $a4
	fwcharmap 0, "無", $a5
	fwcharmap 0, "物", $a6
	fwcharmap 0, "判", $a7
	fwcharmap 0, "炎", $a8
	fwcharmap 0, "数", $a9
	fwcharmap 0, "水", $aa
	fwcharmap 0, "後", $ab
	fwcharmap 0, "控", $ac
	fwcharmap 0, "信", $ad
	fwcharmap 0, "受", $ae
	fwcharmap 0, "入", $af
	fwcharmap 0, "大", $b0
	fwcharmap 0, "弱", $b1
	fwcharmap 0, "点", $b2
	fwcharmap 0, "超", $b3
	fwcharmap 0, "気", $b4
	fwcharmap 0, "動", $b5
	fwcharmap 0, "上", $b6
	fwcharmap 0, "体", $b7
	fwcharmap 0, "目", $b8
	fwcharmap 0, "抗", $b9
	fwcharmap 0, "抵", $ba
	fwcharmap 0, "拡", $bb
	fwcharmap 0, "通", $bc
	fwcharmap 0, "替", $bd
	fwcharmap 0, "張", $be
	fwcharmap 0, "加", $bf
	fwcharmap 0, "特", $c0
	fwcharmap 0, "殊", $c1
	fwcharmap 0, "能", $c2
	fwcharmap 0, "建", $c3
	fwcharmap 0, "子", $c4
	fwcharmap 0, "全", $c5
	fwcharmap 0, "次", $c6
	fwcharmap 0, "切", $c7
	fwcharmap 0, "雷", $c8
	fwcharmap 0, "匹", $c9
	fwcharmap 0, "明", $ca
	fwcharmap 0, "研", $cb
	fwcharmap 0, "究", $cc
	fwcharmap 0, "草", $cd
	fwcharmap 0, "男", $ce
	fwcharmap 0, "面", $cf
	fwcharmap 0, "生", $d0
	fwcharmap 0, "文", $d1
	fwcharmap 0, "闘", $d2
	fwcharmap 0, "地", $d3
	fwcharmap 0, "間", $d4
	fwcharmap 0, "基", $d5
	fwcharmap 0, "品", $d6
	fwcharmap 0, "岩", $d7
	fwcharmap 0, "空", $d8
	fwcharmap 0, "身", $d9
	fwcharmap 0, "関", $da
	fwcharmap 0, "係", $db
	fwcharmap 0, "飛", $dc
	fwcharmap 0, "持", $dd
	fwcharmap 0, "賞", $de
	fwcharmap 0, "作", $df
	fwcharmap 0, "好", $e0
	fwcharmap 0, "追", $e1
	fwcharmap 0, "的", $e2
	fwcharmap 0, "以", $e3
	fwcharmap 0, "電", $e4
	fwcharmap 0, "引", $e5
	fwcharmap 0, "日", $e6
	fwcharmap 0, "敗", $e7
	fwcharmap 0, "最", $e8
	fwcharmap 0, "度", $e9
	fwcharmap 0, "個", $ea
	fwcharmap 0, "与", $eb
	fwcharmap 0, "確", $ec
	fwcharmap 0, "認", $ed
	fwcharmap 0, "成", $ee
	fwcharmap 0, "発", $ef
	fwcharmap 0, "家", $f0
	fwcharmap 0, "終", $f1
	fwcharmap 0, "三", $f2
	fwcharmap 0, "移", $f3
	fwcharmap 0, "足", $f4
	fwcharmap 0, "員", $f5
	fwcharmap 0, "消", $f6
	fwcharmap 0, "長", $f7
	fwcharmap 0, "外", $f8
	fwcharmap 0, "毒", $f9
	fwcharmap 0, "意", $fa
	fwcharmap 0, "交", $fb
	fwcharmap 0, "高", $fc
	fwcharmap 0, "失", $fd
	fwcharmap 0, "収", $fe
	fwcharmap 0, "一", $ff

; TX_FULLWIDTH1
	fwcharmap 1, "攻", $10
	fwcharmap 1, "性", $11
	fwcharmap 1, "変", $12
	fwcharmap 1, "尾", $13
	fwcharmap 1, "所", $14
	fwcharmap 1, "小", $15
	fwcharmap 1, "画", $16
	fwcharmap 1, "換", $17
	fwcharmap 1, "尻", $18
	fwcharmap 1, "功", $19
	fwcharmap 1, "限", $1a
	fwcharmap 1, "花", $1b
	fwcharmap 1, "何", $1c
	fwcharmap 1, "海", $1d
	fwcharmap 1, "互", $1e
	fwcharmap 1, "育", $1f
	fwcharmap 1, "前", $20
	fwcharmap 1, "不", $21
	fwcharmap 1, "操", $22
	fwcharmap 1, "用", $23
	fwcharmap 1, "者", $24
	fwcharmap 1, "頭", $25
	fwcharmap 1, "栄", $26
	fwcharmap 1, "格", $27
	fwcharmap 1, "怒", $28
	fwcharmap 1, "光", $29
	fwcharmap 1, "元", $2a
	fwcharmap 1, "了", $2b
	fwcharmap 1, "角", $2c
	fwcharmap 1, "口", $2d
	fwcharmap 1, "別", $2e
	fwcharmap 1, "鋭", $2f
	fwcharmap 1, "左", $30
	fwcharmap 1, "右", $31
	fwcharmap 1, "擊", $32
	fwcharmap 1, "覆", $33
	fwcharmap 1, "皮", $34
	fwcharmap 1, "毛", $35
	fwcharmap 1, "逃", $36
	fwcharmap 1, "方", $37
	fwcharmap 1, "弟", $38
	fwcharmap 1, "石", $39
	fwcharmap 1, "同", $3a
	fwcharmap 1, "新", $3b
	fwcharmap 1, "台", $3c
	fwcharmap 1, "現", $3d
	fwcharmap 1, "少", $3e
	fwcharmap 1, "多", $3f
	fwcharmap 1, "幻", $40
	fwcharmap 1, "心", $41
	fwcharmap 1, "眠", $42
	fwcharmap 1, "待", $43
	fwcharmap 1, "固", $44
	fwcharmap 1, "送", $45
	fwcharmap 1, "常", $46
	fwcharmap 1, "歩", $47
	fwcharmap 1, "姿", $48
	fwcharmap 1, "得", $49
	fwcharmap 1, "火", $4a
	fwcharmap 1, "合", $4b
	fwcharmap 1, "詞", $4c
	fwcharmap 1, "暴", $4d
	fwcharmap 1, "泳", $4e
	fwcharmap 1, "鳥", $4f
	fwcharmap 1, "実", $50
	fwcharmap 1, "羽", $51
	fwcharmap 1, "射", $52
	fwcharmap 1, "非", $53
	fwcharmap 1, "女", $54
	fwcharmap 1, "達", $55
	fwcharmap 1, "針", $56
	fwcharmap 1, "機", $57
	fwcharmap 1, "近", $58
	fwcharmap 1, "年", $59
	fwcharmap 1, "開", $5a
	fwcharmap 1, "音", $5b
	fwcharmap 1, "先", $5c
	fwcharmap 1, "半", $5d
	fwcharmap 1, "要", $5e
	fwcharmap 1, "必", $5f
	fwcharmap 1, "突", $60
	fwcharmap 1, "戻", $61
	fwcharmap 1, "両", $62
	fwcharmap 1, "立", $63
	fwcharmap 1, "波", $64
	fwcharmap 1, "獲", $65
	fwcharmap 1, "美", $66
	fwcharmap 1, "息", $67
	fwcharmap 1, "知", $68
	fwcharmap 1, "放", $69
	fwcharmap 1, "言", $6a
	fwcharmap 1, "刺", $6b
	fwcharmap 1, "記", $6c
	fwcharmap 1, "種", $6d
	fwcharmap 1, "退", $6e
	fwcharmap 1, "食", $6f
	fwcharmap 1, "字", $70
	fwcharmap 1, "木", $71
	fwcharmap 1, "猛", $72
	fwcharmap 1, "絕", $73
	fwcharmap 1, "削", $74
	fwcharmap 1, "設", $75
	fwcharmap 1, "初", $76
	fwcharmap 1, "重", $77
	fwcharmap 1, "速", $78
	fwcharmap 1, "事", $79
	fwcharmap 1, "復", $7a
	fwcharmap 1, "敵", $7b
	fwcharmap 1, "続", $7c
	fwcharmap 1, "住", $7d
	fwcharmap 1, "部", $7e
	fwcharmap 1, "様", $7f
	fwcharmap 1, "狂", $80
	fwcharmap 1, "線", $81
	fwcharmap 1, "背", $82
	fwcharmap 1, "植", $83
	fwcharmap 1, "走", $84
	fwcharmap 1, "膚", $85
	fwcharmap 1, "完", $86
	fwcharmap 1, "未", $87
	fwcharmap 1, "国", $88
	fwcharmap 1, "助", $89
	fwcharmap 1, "補", $8a
	fwcharmap 1, "在", $8b
	fwcharmap 1, "活", $8c
	fwcharmap 1, "始", $8d
	fwcharmap 1, "表", $8e
	fwcharmap 1, "掘", $8f
	fwcharmap 1, "暗", $90
	fwcharmap 1, "列", $91
	fwcharmap 1, "行", $92
	fwcharmap 1, "連", $93
	fwcharmap 1, "結", $94
	fwcharmap 1, "残", $95
	fwcharmap 1, "断", $96
	fwcharmap 1, "除", $97
	fwcharmap 1, "主", $98
	fwcharmap 1, "闇", $99
	fwcharmap 1, "命", $9a
	fwcharmap 1, "屋", $9b
	fwcharmap 1, "捨", $9c
	fwcharmap 1, "滅", $9d
	fwcharmap 1, "胞", $9e
	fwcharmap 1, "思", $9f
	fwcharmap 1, "揺", $a0
	fwcharmap 1, "利", $a1
	fwcharmap 1, "遺", $a2
	fwcharmap 1, "注", $a3
	fwcharmap 1, "夜", $a4
	fwcharmap 1, "険", $a5
	fwcharmap 1, "倍", $a6
	fwcharmap 1, "威", $a7
	fwcharmap 1, "試", $a8
	fwcharmap 1, "巣", $a9
	fwcharmap 1, "離", $aa
	fwcharmap 1, "決", $ab
	fwcharmap 1, "骨", $ac
	fwcharmap 1, "燃", $ad
	fwcharmap 1, "覚", $ae
	fwcharmap 1, "液", $af
	fwcharmap 1, "磁", $b0
	fwcharmap 1, "倒", $b1
	fwcharmap 1, "落", $b2
	fwcharmap 1, "学", $b3
	fwcharmap 1, "顏", $b4
	fwcharmap 1, "風", $b5
	fwcharmap 1, "昔", $b6
	fwcharmap 1, "影", $b7
	fwcharmap 1, "難", $b8
	fwcharmap 1, "巻", $b9
	fwcharmap 1, "響", $ba
	fwcharmap 1, "工", $bb
	fwcharmap 1, "粉", $bc
	fwcharmap 1, "脱", $bd
	fwcharmap 1, "危", $be
	fwcharmap 1, "吸", $bf
	fwcharmap 1, "殻", $c0
	fwcharmap 1, "寒", $c1
	fwcharmap 1, "養", $c2
	fwcharmap 1, "歌", $c3
	fwcharmap 1, "理", $c4
	fwcharmap 1, "組", $c5
	fwcharmap 1, "更", $c6
	fwcharmap 1, "由", $c7
	fwcharmap 1, "取", $c8
	fwcharmap 1, "順", $c9
	fwcharmap 1, "逆", $ca
	fwcharmap 1, "細", $cb
	fwcharmap 1, "丸", $cc
	fwcharmap 1, "葉", $cd
	fwcharmap 1, "裂", $ce
	fwcharmap 1, "当", $cf
	fwcharmap 1, "温", $d0
	fwcharmap 1, "痛", $d1
	fwcharmap 1, "耳", $d2
	fwcharmap 1, "然", $d3
	fwcharmap 1, "轻", $d4
	fwcharmap 1, "激", $d5
	fwcharmap 1, "袋", $d6
	fwcharmap 1, "議", $d7
	fwcharmap 1, "下", $d8
	fwcharmap 1, "起", $d9
	fwcharmap 1, "界", $da
	fwcharmap 1, "世", $db
	fwcharmap 1, "臭", $dc
	fwcharmap 1, "根", $dd
	fwcharmap 1, "伸", $de
	fwcharmap 1, "聞", $df
	fwcharmap 1, "遠", $e0
	fwcharmap 1, "烈", $e1
	fwcharmap 1, "模", $e2
	fwcharmap 1, "腹", $e3
	fwcharmap 1, "感", $e4
	fwcharmap 1, "舌", $e5
	fwcharmap 1, "集", $e6
	fwcharmap 1, "雨", $e7
	fwcharmap 1, "硬", $e8
	fwcharmap 1, "香", $e9
	fwcharmap 1, "寄", $ea
	fwcharmap 1, "絵", $eb
	fwcharmap 1, "話", $ec
	fwcharmap 1, "西", $ed
	fwcharmap 1, "北", $ee
	fwcharmap 1, "室", $ef
	fwcharmap 1, "算", $f0
	fwcharmap 1, "氏", $f1
	fwcharmap 1, "第", $f2
	fwcharmap 1, "誘", $f3
	fwcharmap 1, "溶", $f4
	fwcharmap 1, "役", $f5
	fwcharmap 1, "道", $f6
	fwcharmap 1, "普", $f7
	fwcharmap 1, "段", $f8
	fwcharmap 1, "孫", $f9
	fwcharmap 1, "熱", $fa
	fwcharmap 1, "帶", $fb
	fwcharmap 1, "呼", $fc
	fwcharmap 1, "異", $fd
	fwcharmap 1, "仮", $fe
	fwcharmap 1, "正", $ff

; TX_FULLWIDTH2
	fwcharmap 2, "書", $10
	fwcharmap 2, "複", $11
	fwcharmap 2, "満", $12
	fwcharmap 2, "杯", $13
	fwcharmap 2, "抜", $14
	fwcharmap 2, "鎌", $15
	fwcharmap 2, "登", $16
	fwcharmap 2, "鑑", $17
	fwcharmap 2, "図", $18
	fwcharmap 2, "笛", $19
	fwcharmap 2, "辉", $1a
	fwcharmap 2, "良", $1b
	fwcharmap 2, "深", $1c
	fwcharmap 2, "処", $1d
	fwcharmap 2, "継", $1e
	fwcharmap 2, "幹", $1f
	fwcharmap 2, "裏", $20
	fwcharmap 2, "捕", $21
	fwcharmap 2, "紙", $22
	fwcharmap 2, "池", $23
	fwcharmap 2, "内", $24
	fwcharmap 2, "翼", $25
	fwcharmap 2, "負", $26
	fwcharmap 2, "圧", $27
	fwcharmap 2, "教", $28
	fwcharmap 2, "湖", $29
	fwcharmap 2, "優", $2a
	fwcharmap 2, "印", $2b
	fwcharmap 2, "透", $2c
	fwcharmap 2, "触", $2d
	fwcharmap 2, "壊", $2e
	fwcharmap 2, "万", $2f
	fwcharmap 2, "辺", $30
	fwcharmap 2, "赤", $31
	fwcharmap 2, "乱", $32
	fwcharmap 2, "混", $33
	fwcharmap 2, "魚", $34
	fwcharmap 2, "古", $35
	fwcharmap 2, "代", $36
	fwcharmap 2, "死", $37
	fwcharmap 2, "側", $38
	fwcharmap 2, "愛", $39
	fwcharmap 2, "浮", $3a
	fwcharmap 2, "爆", $3b
	fwcharmap 2, "膨", $3c
	fwcharmap 2, "驚", $3d
	fwcharmap 2, "雲", $3e
	fwcharmap 2, "穴", $3f
	fwcharmap 2, "肉", $40
	fwcharmap 2, "運", $41
	fwcharmap 2, "秒", $42
	fwcharmap 2, "転", $43
	fwcharmap 2, "声", $44
	fwcharmap 2, "寝", $45
	fwcharmap 2, "考", $46
	fwcharmap 2, "催", $47
	fwcharmap 2, "術", $48
	fwcharmap 2, "広", $49
	fwcharmap 2, "嚇", $4a
	fwcharmap 2, "瞳", $4b
	fwcharmap 2, "虫", $4c
	fwcharmap 2, "隠", $4d
	fwcharmap 2, "金", $4e
	fwcharmap 2, "接", $4f
	fwcharmap 2, "片", $50
	fwcharmap 2, "丈", $51
	fwcharmap 2, "黃", $52
	fwcharmap 2, "53", $53
	fwcharmap 2, "夫", $54
	fwcharmap 2, "零", $55
	fwcharmap 2, "真", $56
	fwcharmap 2, "白", $57
	fwcharmap 2, "増", $58
	fwcharmap 2, "象", $59
	fwcharmap 2, "彈", $5a
	fwcharmap 2, "血", $5b
	fwcharmap 2, "匂", $5c
	fwcharmap 2, "馬", $5d
	fwcharmap 2, "錄", $5e
	fwcharmap 2, "済", $5f
	fwcharmap 2, "鈍", $60
	fwcharmap 2, "押", $61
	fwcharmap 2, "刷", $62
	fwcharmap 2, "王", $63
	fwcharmap 2, "肌", $64
	fwcharmap 2, "調", $65
	fwcharmap 2, "公", $66
	fwcharmap 2, "示", $67
	fwcharmap 2, "双", $68
	fwcharmap 2, "指", $69
	fwcharmap 2, "来", $6a
	fwcharmap 2, "志", $6b
	fwcharmap 2, "林", $6c
	fwcharmap 2, "川", $6d
	fwcharmap 2, "幾", $6e
	fwcharmap 2, "止", $6f
	fwcharmap 2, "源", $70
	fwcharmap 2, "卵", $71
	fwcharmap 2, "棚", $72
	fwcharmap 2, "宇", $73
	fwcharmap 2, "質", $74
	fwcharmap 2, "問", $75
	fwcharmap 2, "備", $76
	fwcharmap 2, "準", $77
	fwcharmap 2, "宙", $78
	fwcharmap 2, "疑", $79
	fwcharmap 2, "周", $7a
	fwcharmap 2, "汚", $7b
	fwcharmap 2, "月", $7c
	fwcharmap 2, "德", $7d
	fwcharmap 2, "蜜", $7e
	fwcharmap 2, "法", $7f
	fwcharmap 2, "破", $80
	fwcharmap 2, "殴", $81
	fwcharmap 2, "忙", $82
	fwcharmap 2, "降", $83
	fwcharmap 2, "乗", $84
	fwcharmap 2, "十", $85
	fwcharmap 2, "薬", $86
	fwcharmap 2, "違", $87
	fwcharmap 2, "会", $88
	fwcharmap 2, "似", $89
	fwcharmap 2, "眼", $8a
	fwcharmap 2, "船", $8b
	fwcharmap 2, "雪", $8c
	fwcharmap 2, "級", $8d
	fwcharmap 2, "冷", $8e
	fwcharmap 2, "凍", $8f
	fwcharmap 2, "拾", $90
	fwcharmap 2, "帰", $91
	fwcharmap 2, "敬", $92
	fwcharmap 2, "克", $93
	fwcharmap 2, "服", $94
	fwcharmap 2, "夏", $95
	fwcharmap 2, "休", $96
	fwcharmap 2, "岸", $97
	fwcharmap 2, "昼", $98
	fwcharmap 2, "咲", $99
	fwcharmap 2, "太", $9a
	fwcharmap 2, "噛", $9b
	fwcharmap 2, "反", $9c
	fwcharmap 2, "珍", $9d
	fwcharmap 2, "喜", $9e
	fwcharmap 2, "陽", $9f
	fwcharmap 2, "緑", $a0
	fwcharmap 2, "糸", $a1
	fwcharmap 2, "約", $a2
	fwcharmap 2, "包", $a3
	fwcharmap 2, "識", $a4
	fwcharmap 2, "悲", $a5
	fwcharmap 2, "耐", $a6
	fwcharmap 2, "貫", $a7
	fwcharmap 2, "天", $a8
	fwcharmap 2, "司", $a9
	fwcharmap 2, "神", $aa
	fwcharmap 2, "情", $ab
	fwcharmap 2, "千", $ac
	fwcharmap 2, "過", $ad
	fwcharmap 2, "巨", $ae
	fwcharmap 2, "稲", $af
	fwcharmap 2, "妻", $b0
	fwcharmap 2, "守", $b1
	fwcharmap 2, "産", $b2
	fwcharmap 2, "森", $b3
	fwcharmap 2, "球", $b4
	fwcharmap 2, "迫", $b5
	fwcharmap 2, "団", $b6
	fwcharmap 2, "爪", $b7
	fwcharmap 2, "浅", $b8
	fwcharmap 2, "盛", $b9
	fwcharmap 2, "油", $ba
	fwcharmap 2, "凶", $bb
	fwcharmap 2, "筋", $bc
	fwcharmap 2, "織", $bd
	fwcharmap 2, "供", $be
	fwcharmap 2, "墓", $bf
	fwcharmap 2, "疲", $c0
	fwcharmap 2, "靱", $c1
	fwcharmap 2, "荷", $c2
	fwcharmap 2, "瞬", $c3
	fwcharmap 2, "搬", $c4
	fwcharmap 2, "仕", $c5
	fwcharmap 2, "腕", $c6
	fwcharmap 2, "類", $c7
	fwcharmap 2, "坂", $c8
	fwcharmap 2, "可", $c9
	fwcharmap 2, "盤", $ca
	fwcharmap 2, "土", $cb
	fwcharmap 2, "母", $cc
	fwcharmap 2, "親", $cd
	fwcharmap 2, "棲", $ce
	fwcharmap 2, "寂", $cf
	fwcharmap 2, "科", $d0
	fwcharmap 2, "泣", $d1
	fwcharmap 2, "武", $d2
	fwcharmap 2, "器", $d3
	fwcharmap 2, "縮", $d4
	fwcharmap 2, "蹴", $d5
	fwcharmap 2, "魂", $d6
	fwcharmap 2, "悪", $d7
	fwcharmap 2, "層", $d8
	fwcharmap 2, "厚", $d9
	fwcharmap 2, "砕", $da
	fwcharmap 2, "計", $db
	fwcharmap 2, "惑", $dc
	fwcharmap 2, "再", $dd
	fwcharmap 2, "護", $de
	fwcharmap 2, "恐", $df
	fwcharmap 2, "竜", $e0
	fwcharmap 2, "形", $e1
	fwcharmap 2, "鳴", $e2
	fwcharmap 2, "原", $e3
	fwcharmap 2, "朝", $e4
	fwcharmap 2, "存", $e5
	fwcharmap 2, "割", $e6
	fwcharmap 2, "因", $e7
	fwcharmap 2, "興", $e8
	fwcharmap 2, "漢", $e9
	fwcharmap 2, "奮", $ea
	fwcharmap 2, "謎", $eb
	fwcharmap 2, "誰", $ec
	fwcharmap 2, "遭", $ed
	fwcharmap 2, "串", $ee
	fwcharmap 2, "牙", $ef
	fwcharmap 2, "黑", $f0
	fwcharmap 2, "薄", $f1
	fwcharmap 2, "念", $f2
	fwcharmap 2, "湿", $f3
	fwcharmap 2, "臓", $f4
	fwcharmap 2, "南", $f5
	fwcharmap 2, "渦", $f6
	fwcharmap 2, "暮", $f7
	fwcharmap 2, "晶", $f8
	fwcharmap 2, "執", $f9
	fwcharmap 2, "並", $fa
	fwcharmap 2, "期", $fb
	fwcharmap 2, "配", $fc
	fwcharmap 2, "魅", $fd
	fwcharmap 2, "夕", $fe
	fwcharmap 2, "彗", $ff

; TX_FULLWIDTH3
	fwcharmap 3, "散", $10
	fwcharmap 3, "振", $11
	fwcharmap 3, "去", $12
	fwcharmap 3, "件", $13
	fwcharmap 3, "首", $14
	fwcharmap 3, "甲", $15
	fwcharmap 3, "羅", $16
	fwcharmap 3, "込", $17
	fwcharmap 3, "勢", $18
	fwcharmap 3, "召", $19
	fwcharmap 3, "喚", $1a
	fwcharmap 3, "酔", $1b
	fwcharmap 3, "直", $1c
	fwcharmap 3, "悩", $1d
	fwcharmap 3, "詰", $1e
	fwcharmap 3, "例", $1f
	fwcharmap 3, "越", $20
	fwcharmap 3, "京", $21
	fwcharmap 3, "東", $22
	fwcharmap 3, "壁", $23
	fwcharmap 3, "付", $24
	fwcharmap 3, "跳", $25
	fwcharmap 3, "吠", $26
	fwcharmap 3, "徵", $27
	fwcharmap 3, "誕", $28
	fwcharmap 3, "今", $29
	fwcharmap 3, "封", $2a
	fwcharmap 3, "雅", $2b
	fwcharmap 3, "誠", $2c
	fwcharmap 3, "置", $2d
	fwcharmap 3, "祟", $2e
	fwcharmap 3, "掴", $2f
	fwcharmap 3, "飲", $30
	fwcharmap 3, "噂", $31
	fwcharmap 3, "稼", $32
	fwcharmap 3, "介", $33
	fwcharmap 3, "塊", $34
	fwcharmap 3, "階", $35
	fwcharmap 3, "観", $36
	fwcharmap 3, "棄", $37
	fwcharmap 3, "技", $38
	fwcharmap 3, "急", $39
	fwcharmap 3, "牛", $3a
	fwcharmap 3, "業", $3b
	fwcharmap 3, "窟", $3c
	fwcharmap 3, "繰", $3d
	fwcharmap 3, "嫌", $3e
	fwcharmap 3, "検", $3f
	fwcharmap 3, "向", $40
	fwcharmap 3, "校", $41
	fwcharmap 3, "参", $42
	fwcharmap 3, "飼", $43
	fwcharmap 3, "歯", $44
	fwcharmap 3, "襲", $45
	fwcharmap 3, "従", $46
	fwcharmap 3, "傷", $47
	fwcharmap 3, "焼", $48
	fwcharmap 3, "殖", $49
	fwcharmap 3, "瀬", $4a
	fwcharmap 3, "星", $4b
	fwcharmap 3, "造", $4c
	fwcharmap 3, "他", $4d
	fwcharmap 3, "探", $4e
	fwcharmap 3, "致", $4f
	fwcharmap 3, "挑", $50
	fwcharmap 3, "町", $51
	fwcharmap 3, "釣", $52
	fwcharmap 3, "低", $53
	fwcharmap 3, "提", $54
	fwcharmap 3, "吐", $55
	fwcharmap 3, "洞", $56
	fwcharmap 3, "独", $57
	fwcharmap 3, "乳", $58
	fwcharmap 3, "廃", $59
	fwcharmap 3, "兵", $5a
	fwcharmap 3, "癖", $5b
	fwcharmap 3, "保", $5c
	fwcharmap 3, "抱", $5d
	fwcharmap 3, "貌", $5e
	fwcharmap 3, "防", $5f
	fwcharmap 3, "没", $60
	fwcharmap 3, "煙", $61
	fwcharmap 3, "応", $62
	fwcharmap 3, "横", $63
	fwcharmap 3, "汗", $64
	fwcharmap 3, "規", $65
	fwcharmap 3, "競", $66
	fwcharmap 3, "茶", $67
	fwcharmap 3, "苦", $68
	fwcharmap 3, "駆", $69
	fwcharmap 3, "訓", $6a
	fwcharmap 3, "幸", $6b
	fwcharmap 3, "腰", $6c
	fwcharmap 3, "砂", $6d
	fwcharmap 3, "邪", $6e
	fwcharmap 3, "掌", $6f
	fwcharmap 3, "衝", $70
	fwcharmap 3, "寸", $71
	fwcharmap 3, "制", $72
	fwcharmap 3, "跡", $73
	fwcharmap 3, "争", $74
	fwcharmap 3, "則", $75
	fwcharmap 3, "短", $76
	fwcharmap 3, "着", $77
	fwcharmap 3, "踏", $78
	fwcharmap 3, "読", $79
	fwcharmap 3, "濡", $7a
	fwcharmap 3, "版", $7b
	fwcharmap 3, "氷", $7c
	fwcharmap 3, "布", $7d
	fwcharmap 3, "平", $7e
	fwcharmap 3, "返", $7f
	fwcharmap 3, "募", $80
	fwcharmap 3, "魔", $81
	fwcharmap 3, "容", $82
	fwcharmap 3, "踊", $83
	fwcharmap 3, "陸", $84
	fwcharmap 3, "侵", $85
	fwcharmap 3, "域", $86
	fwcharmap 3, "遅", $87
	fwcharmap 3, "素", $88
	fwcharmap 3, "腦", $89
	fwcharmap 3, "吹", $8a
	fwcharmap 3, "笑", $8b
	fwcharmap 3, "己", $8c
	fwcharmap 3, "忍", $8d
	fwcharmap 3, "条", $8e
	fwcharmap 3, "刀", $8f
	fwcharmap 3, "怠", $90
	fwcharmap 3, "遊", $91
	fwcharmap 3, "型", $92
	fwcharmap 3, "博", $93
	fwcharmap 3, "士", $94
	fwcharmap 3, "勇", $95
	fwcharmap 3, "環", $96
	fwcharmap 3, "境", $97
	fwcharmap 3, "暑", $98
	fwcharmap 3, "玉", $99
	fwcharmap 3, "喷", $9a
	fwcharmap 3, "停", $9b
	fwcharmap 3, "装", $9c
	fwcharmap 3, "号", $9d
	fwcharmap 3, "島", $9e
	fwcharmap 3, "覽", $9f
	fwcharmap 3, "莊", $a0
	fwcharmap 3, "祭", $a1
	fwcharmap 3, "壇", $a2
	fwcharmap 3, "予", $a3
	fwcharmap 3, "範", $a4
	fwcharmap 3, "囲", $a5
	fwcharmap 3, "商", $a6
	fwcharmap 3, "報", $a7
	fwcharmap 3, "率", $a8
	fwcharmap 3, "私", $a9
	fwcharmap 3, "語", $aa
	fwcharmap 3, "妖", $ab
	fwcharmap 3, "脅", $ac
	fwcharmap 3, "精", $ad
	fwcharmap 3, "仲", $ae
	fwcharmap 3, "底", $af
	fwcharmap 3, "静", $b0
	fwcharmap 3, "撒", $b1
	fwcharmap 3, "街", $b2
	fwcharmap 3, "題", $b3
	fwcharmap 3, "秘", $b4
	fwcharmap 3, "密", $b5
	fwcharmap 3, "靭", $b6

; TX_FULLWIDTH4
	fwcharmap 4, "A", $10
	fwcharmap 4, "B", $11
	fwcharmap 4, "C", $12
	fwcharmap 4, "D", $13
	fwcharmap 4, "E", $14
	fwcharmap 4, "F", $15
	fwcharmap 4, "G", $16
	fwcharmap 4, "H", $17
	fwcharmap 4, "I", $18
	fwcharmap 4, "J", $19
	fwcharmap 4, "K", $1a
	fwcharmap 4, "L", $1b
	fwcharmap 4, "M", $1c
	fwcharmap 4, "N", $1d
	fwcharmap 4, "O", $1e
	fwcharmap 4, "P", $1f
	fwcharmap 4, "Q", $20
	fwcharmap 4, "R", $21
	fwcharmap 4, "S", $22
	fwcharmap 4, "T", $23
	fwcharmap 4, "U", $24
	fwcharmap 4, "V", $25
	fwcharmap 4, "W", $26
	fwcharmap 4, "X", $27
	fwcharmap 4, "Y", $28
	fwcharmap 4, "Z", $29
	fwcharmap 4, "a", $2a
	fwcharmap 4, "b", $2b
	fwcharmap 4, "c", $2c
	fwcharmap 4, "d", $2d
	fwcharmap 4, "e", $2e
	fwcharmap 4, "f", $2f
	fwcharmap 4, "g", $30
	fwcharmap 4, "h", $31
	fwcharmap 4, "i", $32
	fwcharmap 4, "j", $33
	fwcharmap 4, "k", $34
	fwcharmap 4, "l", $35
	fwcharmap 4, "m", $36
	fwcharmap 4, "n", $37
	fwcharmap 4, "o", $38
	fwcharmap 4, "p", $39
	fwcharmap 4, "q", $3a
	fwcharmap 4, "r", $3b
	fwcharmap 4, "s", $3c
	fwcharmap 4, "t", $3d
	fwcharmap 4, "u", $3e
	fwcharmap 4, "v", $3f
	fwcharmap 4, "w", $40
	fwcharmap 4, "x", $41
	fwcharmap 4, "y", $42
	fwcharmap 4, "z", $43
	fwcharmap 4, "~", $44
	fwcharmap 4, "※", $45
	fwcharmap 4, "о", $46
	fwcharmap 4, "^", $47
	fwcharmap 4, "♪", $48
	fwcharmap 4, "♀", $49
	fwcharmap 4, "♂", $4a
	fwcharmap 4, "々", $4b
	fwcharmap 4, "ヴ", $4c
	fwcharmap 4, "@", $4d
	fwcharmap 4, ":", $4e
	fwcharmap 4, ";", $4f
	fwcharmap 4, "【", $50
	fwcharmap 4, "】", $51
	fwcharmap 4, "○", $52
	fwcharmap 4, "●", $53
	fwcharmap 4, "◆", $54
	fwcharmap 4, "★", $55
	fwcharmap 4, "☆", $56
	fwcharmap 4, "_", $57
	fwcharmap 4, "▪", $58
	fwcharmap 4, "℃", $59
	fwcharmap 4, "゛", $5a
	fwcharmap 4, "°", $5b
	fwcharmap 4, "゜", $5c
	fwcharmap 4, "ˍ", $5d
	fwcharmap 4, "&", $5e
	fwcharmap 4, "*", $5f
	fwcharmap 4, "<", $60
	fwcharmap 4, ">", $61
	fwcharmap 4, "=", $62
	fwcharmap 4, "◇", $63
	fwcharmap 4, "ˉ", $64

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
