PrizeCountPersonalityEmotionMatrix:
	;  PERSONALITY_STANDARD    PERSONALITY_SERIOUS     PERSONALITY_EMOTIONAL  ; prize count difference
	db EMOTION_SAD,            EMOTION_SAD,            EMOTION_SAD    ; -6 ; player lead
	db EMOTION_SAD,            EMOTION_SAD,            EMOTION_SAD    ; -5
	db EMOTION_SAD,            EMOTION_SAD,            EMOTION_SAD    ; -4
	db EMOTION_SAD,            EMOTION_NORMAL,         EMOTION_SAD    ; -3
	db EMOTION_NORMAL,         EMOTION_NORMAL,         EMOTION_SAD    ; -2
	db EMOTION_NORMAL,         EMOTION_NORMAL,         EMOTION_NORMAL ; -1
	db EMOTION_NORMAL,         EMOTION_NORMAL,         EMOTION_HAPPY  ;  0 ; neutral
	db EMOTION_HAPPY,          EMOTION_NORMAL,         EMOTION_HAPPY  ;  1
	db EMOTION_HAPPY,          EMOTION_HAPPY,          EMOTION_HAPPY  ;  2
	db EMOTION_HAPPY,          EMOTION_HAPPY,          EMOTION_HAPPY  ;  3
	db EMOTION_HAPPY,          EMOTION_HAPPY,          EMOTION_HAPPY  ;  4 ; opp lead
