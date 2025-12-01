MACRO mail
	tx \1
	IF _NARG > 1
		db \2, \3
	ELSE
		db 0, 0
	ENDC
ENDM

MACRO end_mail
	dw MAIL_TERMINATOR
ENDM

Mail:
	dw .MailEmpty
	dw .MailBlackBox
	dw .MailBillsPCOutput
	dw .MailMailboxIntro
	dw .MailDeckDiagnosis1
	dw .MailDeckDiagnosis2
	dw .MailDeckDiagnosis3
	dw .MailDeckDiagnosis4
	dw .MailAutoDeckMachine1
	dw .MailAutoDeckMachine2
	dw .MailAutoDeckMachine3
	dw .MailAutoDeckMachine4
	dw .MailAutoDeckMachine5
	dw .MailChallengeMachine
	dw .MailGRChallengeMachine
	dw .MailGrandMasterCup
	dw .MailRonaldsScoutGR1
	dw .MailRonaldsScoutGR2
	dw .MailRonaldsScoutGR3
	dw .MailRonaldsScoutGR4
	dw .MailRonaldsScoutMorino
	dw .MailRonaldsScoutCatherine
	dw .MailRonaldsScoutHidero
	dw .MailRonaldsScoutKanoko
	dw .MailRonaldsScoutKamiya
	dw .MailRonaldsScoutMami
	dw .MailRonaldsScoutColorlessAltar
	dw .MailRonaldsScoutBiruritchi
	dw .MailLinkDuel

.MailEmpty
	tx MailboxEmptySenderText
	tx MailboxEmptySubjectText
	end_mail

.MailBlackBox
	tx MailBlackBoxOutputSenderText
	tx MailBlackBoxOutputSubjectText
	mail MailBlackBoxOutputBody1Text, $00, MAIL_COMMAND_GIVE_BLACK_BOX
	mail MailBlackBoxOutputBody2Text
	end_mail

.MailBillsPCOutput
	tx MailBillsPCOutputSenderText
	tx MailBillsPCOutputSubjectText
	mail MailBillsPCOutputBody1Text, $00, MAIL_COMMAND_GIVE_BILLS_PC
	mail MailBillsPCOutputBody2Text
	end_mail

.MailMailboxIntro
	tx MailMailboxIntroSenderText
	tx MailMailboxIntroSubjectText
	mail MailMailboxIntroBody1Text
	mail MailMailboxIntroBody2Text
	mail MailMailboxIntroBody3Text, BOOSTER_PRESENT_10_ENERGY, MAIL_COMMAND_GIVE_BOOSTER
	end_mail

.MailDeckDiagnosis1
	tx MailDeckDiagnosis1SenderText
	tx MailDeckDiagnosis1SubjectText
	mail MailDeckDiagnosis1Body1Text
	mail MailDeckDiagnosis1Body2Text
	mail MailDeckDiagnosis1Body3Text
	mail MailDeckDiagnosis1Body4Text
	end_mail

.MailDeckDiagnosis2
	tx MailDeckDiagnosis2SenderText
	tx MailDeckDiagnosis2SubjectText
	mail MailDeckDiagnosis2Body1Text
	mail MailDeckDiagnosis2Body2Text
	mail MailDeckDiagnosis2Body3Text
	mail MailDeckDiagnosis2Body4Text
	end_mail

.MailDeckDiagnosis3
	tx MailDeckDiagnosis3SenderText
	tx MailDeckDiagnosis3SubjectText
	mail MailDeckDiagnosis3Body1Text
	mail MailDeckDiagnosis3Body2Text
	mail MailDeckDiagnosis3Body3Text
	end_mail

.MailDeckDiagnosis4
	tx MailDeckDiagnosis4SenderText
	tx MailDeckDiagnosis4SubjectText
	mail MailDeckDiagnosis4Body1Text
	mail MailDeckDiagnosis4Body2Text
	end_mail

.MailAutoDeckMachine1
	tx MailAutoDeckMachine1SenderText
	tx MailAutoDeckMachine1SubjectText
	mail MailAutoDeckMachine1Body1Text
	mail MailAutoDeckMachine1Body2Text
	mail MailAutoDeckMachine1Body3Text, BOOSTER_BEGINNING_POKEMON, MAIL_COMMAND_GIVE_BOOSTER
	end_mail

.MailAutoDeckMachine2
	tx MailAutoDeckMachine2SenderText
	tx MailAutoDeckMachine2SubjectText
	mail MailAutoDeckMachine2Body1Text
	mail MailAutoDeckMachine2Body2Text, BOOSTER_LEGENDARY_POWER, MAIL_COMMAND_GIVE_BOOSTER
	end_mail

.MailAutoDeckMachine3
	tx MailAutoDeckMachine3SenderText
	tx MailAutoDeckMachine3SubjectText
	mail MailAutoDeckMachine3Body1Text
	mail MailAutoDeckMachine3Body2Text
	mail MailAutoDeckMachine3Body3Text, BOOSTER_ISLAND_OF_FOSSIL, MAIL_COMMAND_GIVE_BOOSTER
	end_mail

.MailAutoDeckMachine4
	tx MailAutoDeckMachine4SenderText
	tx MailAutoDeckMachine4SubjectText
	mail MailAutoDeckMachine4Body1Text
	mail MailAutoDeckMachine4Body2Text
	mail MailAutoDeckMachine4Body3Text, BOOSTER_SKY_FLYING_POKEMON, MAIL_COMMAND_GIVE_BOOSTER
	end_mail

.MailAutoDeckMachine5
	tx MailAutoDeckMachine5SenderText
	tx MailAutoDeckMachine5SubjectText
	mail MailAutoDeckMachine5Body1Text
	mail MailAutoDeckMachine5Body2Text
	mail MailAutoDeckMachine5Body3Text
	end_mail

.MailChallengeMachine
	tx MailChallengeMachineSenderText
	tx MailChallengeMachineSubjectText
	mail MailChallengeMachineBody1Text
	mail MailChallengeMachineBody2Text
	end_mail

.MailGRChallengeMachine
	tx MailGRChallengeMachineSenderText
	tx MailGRChallengeMachineSubjectText
	mail MailGRChallengeMachineBody1Text
	mail MailGRChallengeMachineBody2Text
	mail MailGRChallengeMachineBody3Text
	end_mail

.MailGrandMasterCup
	tx MailGrandMasterCupSenderText
	tx MailGrandMasterCupSubjectText
	mail MailGrandMasterCupBody1Text
	mail MailGrandMasterCupBody2Text
	end_mail

.MailRonaldsScoutGR1
	tx MailRonaldsScoutGR1SenderText
	tx MailRonaldsScoutGR1SubjectText
	mail MailRonaldsScoutGR1Body1Text
	mail MailRonaldsScoutGR1Body2Text
	end_mail

.MailRonaldsScoutGR2
	tx MailRonaldsScoutGR2SenderText
	tx MailRonaldsScoutGR2SubjectText
	mail MailRonaldsScoutGR2Body1Text
	mail MailRonaldsScoutGR2Body2Text
	end_mail

.MailRonaldsScoutGR3
	tx MailRonaldsScoutGR3SenderText
	tx MailRonaldsScoutGR3SubjectText
	mail MailRonaldsScoutGR3Body1Text
	mail MailRonaldsScoutGR3Body2Text
	end_mail

.MailRonaldsScoutGR4
	tx MailRonaldsScoutGR4SenderText
	tx MailRonaldsScoutGR4SubjectText
	mail MailRonaldsScoutGR4Body1Text
	mail MailRonaldsScoutGR4Body2Text
	end_mail

.MailRonaldsScoutMorino
	tx MailRonaldsScoutMorinoSenderText
	tx MailRonaldsScoutMorinoSubjectText
	mail MailRonaldsScoutMorinoBody1Text
	mail MailRonaldsScoutMorinoBody2Text
	mail MailRonaldsScoutMorinoBody3Text
	mail MailRonaldsScoutMorinoBody4Text
	end_mail

.MailRonaldsScoutCatherine
	tx MailRonaldsScoutCatherineSenderText
	tx MailRonaldsScoutCatherineSubjectText
	mail MailRonaldsScoutCatherineBody1Text
	mail MailRonaldsScoutCatherineBody2Text
	mail MailRonaldsScoutCatherineBody3Text
	end_mail

.MailRonaldsScoutHidero
	tx MailRonaldsScoutHideroSenderText
	tx MailRonaldsScoutHideroSubjectText
	mail MailRonaldsScoutHideroBody1Text
	mail MailRonaldsScoutHideroBody2Text
	mail MailRonaldsScoutHideroBody3Text
	end_mail

.MailRonaldsScoutKanoko
	tx MailRonaldsScoutKanokoSenderText
	tx MailRonaldsScoutKanokoSubjectText
	mail MailRonaldsScoutKanokoBody1Text
	mail MailRonaldsScoutKanokoBody2Text
	mail MailRonaldsScoutKanokoBody3Text
	end_mail

.MailRonaldsScoutKamiya
	tx MailRonaldsScoutKamiyaSenderText
	tx MailRonaldsScoutKamiyaSubjectText
	mail MailRonaldsScoutKamiyaBody1Text
	mail MailRonaldsScoutKamiyaBody2Text
	mail MailRonaldsScoutKamiyaBody3Text
	end_mail

.MailRonaldsScoutMami
	tx MailRonaldsScoutMamiSenderText
	tx MailRonaldsScoutMamiSubjectText
	mail MailRonaldsScoutMamiBody1Text
	mail MailRonaldsScoutMamiBody2Text
	mail MailRonaldsScoutMamiBody3Text
	mail MailRonaldsScoutMamiBody4Text
	mail MailRonaldsScoutMamiBody5Text
	end_mail

.MailRonaldsScoutColorlessAltar
	tx MailRonaldsScoutColorlessAltarSenderText
	tx MailRonaldsScoutColorlessAltarSubjectText
	mail MailRonaldsScoutColorlessAltarBody1Text
	mail MailRonaldsScoutColorlessAltarBody2Text
	mail MailRonaldsScoutColorlessAltarBody3Text
	mail MailRonaldsScoutColorlessAltarBody4Text
	end_mail

.MailRonaldsScoutBiruritchi
	tx MailRonaldsScoutBiruritchiSenderText
	tx MailRonaldsScoutBiruritchiSubjectText
	mail MailRonaldsScoutBiruritchiBody1Text
	mail MailRonaldsScoutBiruritchiBody2Text
	mail MailRonaldsScoutBiruritchiBody3Text
	mail MailRonaldsScoutBiruritchiBody4Text
	mail MailRonaldsScoutBiruritchiBody5Text
	end_mail

.MailLinkDuel
	tx MailLinkDuelSenderText
	tx MailLinkDuelSubjectText
	mail MailLinkDuelBody1Text
	mail MailLinkDuelBody2Text
	end_mail
