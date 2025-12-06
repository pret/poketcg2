MACRO end_mail
	dw MAIL_TERMINATOR
ENDM

MACRO no_card
	dw $0000
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
	tx MailBlackBoxOutputBody1Text
	db $00, MAIL_COMMAND_GIVE_BLACK_BOX
	tx MailBlackBoxOutputBody2Text
	no_card
	end_mail

.MailBillsPCOutput
	tx MailBillsPCOutputSenderText
	tx MailBillsPCOutputSubjectText
	tx MailBillsPCOutputBody1Text
	db $00, MAIL_COMMAND_GIVE_BILLS_PC
	tx MailBillsPCOutputBody2Text
	no_card
	end_mail

.MailMailboxIntro
	tx MailMailboxIntroSenderText
	tx MailMailboxIntroSubjectText
	tx MailMailboxIntroBody1Text
	no_card
	tx MailMailboxIntroBody2Text
	no_card
	tx MailMailboxIntroBody3Text
	db BOOSTER_PRESENT_PACK_1, MAIL_COMMAND_GIVE_BOOSTER
	end_mail

.MailDeckDiagnosis1
	tx MailDeckDiagnosis1SenderText
	tx MailDeckDiagnosis1SubjectText
	tx MailDeckDiagnosis1Body1Text
	no_card
	tx MailDeckDiagnosis1Body2Text
	no_card
	tx MailDeckDiagnosis1Body3Text
	no_card
	tx MailDeckDiagnosis1Body4Text
	no_card
	end_mail

.MailDeckDiagnosis2
	tx MailDeckDiagnosis2SenderText
	tx MailDeckDiagnosis2SubjectText
	tx MailDeckDiagnosis2Body1Text
	no_card
	tx MailDeckDiagnosis2Body2Text
	no_card
	tx MailDeckDiagnosis2Body3Text
	no_card
	tx MailDeckDiagnosis2Body4Text
	no_card
	end_mail

.MailDeckDiagnosis3
	tx MailDeckDiagnosis3SenderText
	tx MailDeckDiagnosis3SubjectText
	tx MailDeckDiagnosis3Body1Text
	no_card
	tx MailDeckDiagnosis3Body2Text
	no_card
	tx MailDeckDiagnosis3Body3Text
	no_card
	end_mail

.MailDeckDiagnosis4
	tx MailDeckDiagnosis4SenderText
	tx MailDeckDiagnosis4SubjectText
	tx MailDeckDiagnosis4Body1Text
	no_card
	tx MailDeckDiagnosis4Body2Text
	no_card
	end_mail

.MailAutoDeckMachine1
	tx MailAutoDeckMachine1SenderText
	tx MailAutoDeckMachine1SubjectText
	tx MailAutoDeckMachine1Body1Text
	no_card
	tx MailAutoDeckMachine1Body2Text
	no_card
	tx MailAutoDeckMachine1Body3Text
	db BOOSTER_BEGINNING_POKEMON, MAIL_COMMAND_GIVE_BOOSTER
	end_mail

.MailAutoDeckMachine2
	tx MailAutoDeckMachine2SenderText
	tx MailAutoDeckMachine2SubjectText
	tx MailAutoDeckMachine2Body1Text
	no_card
	tx MailAutoDeckMachine2Body2Text
	db BOOSTER_LEGENDARY_POWER, MAIL_COMMAND_GIVE_BOOSTER
	end_mail

.MailAutoDeckMachine3
	tx MailAutoDeckMachine3SenderText
	tx MailAutoDeckMachine3SubjectText
	tx MailAutoDeckMachine3Body1Text
	no_card
	tx MailAutoDeckMachine3Body2Text
	no_card
	tx MailAutoDeckMachine3Body3Text
	db BOOSTER_ISLAND_OF_FOSSIL, MAIL_COMMAND_GIVE_BOOSTER
	end_mail

.MailAutoDeckMachine4
	tx MailAutoDeckMachine4SenderText
	tx MailAutoDeckMachine4SubjectText
	tx MailAutoDeckMachine4Body1Text
	no_card
	tx MailAutoDeckMachine4Body2Text
	no_card
	tx MailAutoDeckMachine4Body3Text
	db BOOSTER_SKY_FLYING_POKEMON, MAIL_COMMAND_GIVE_BOOSTER
	end_mail

.MailAutoDeckMachine5
	tx MailAutoDeckMachine5SenderText
	tx MailAutoDeckMachine5SubjectText
	tx MailAutoDeckMachine5Body1Text
	no_card
	tx MailAutoDeckMachine5Body2Text
	no_card
	tx MailAutoDeckMachine5Body3Text
	no_card
	end_mail

.MailChallengeMachine
	tx MailChallengeMachineSenderText
	tx MailChallengeMachineSubjectText
	tx MailChallengeMachineBody1Text
	no_card
	tx MailChallengeMachineBody2Text
	no_card
	end_mail

.MailGRChallengeMachine
	tx MailGRChallengeMachineSenderText
	tx MailGRChallengeMachineSubjectText
	tx MailGRChallengeMachineBody1Text
	no_card
	tx MailGRChallengeMachineBody2Text
	no_card
	tx MailGRChallengeMachineBody3Text
	no_card
	end_mail

.MailGrandMasterCup
	tx MailGrandMasterCupSenderText
	tx MailGrandMasterCupSubjectText
	tx MailGrandMasterCupBody1Text
	no_card
	tx MailGrandMasterCupBody2Text
	no_card
	end_mail

.MailRonaldsScoutGR1
	tx MailRonaldsScoutGR1SenderText
	tx MailRonaldsScoutGR1SubjectText
	tx MailRonaldsScoutGR1Body1Text
	no_card
	tx MailRonaldsScoutGR1Body2Text
	no_card
	end_mail

.MailRonaldsScoutGR2
	tx MailRonaldsScoutGR2SenderText
	tx MailRonaldsScoutGR2SubjectText
	tx MailRonaldsScoutGR2Body1Text
	no_card
	tx MailRonaldsScoutGR2Body2Text
	no_card
	end_mail

.MailRonaldsScoutGR3
	tx MailRonaldsScoutGR3SenderText
	tx MailRonaldsScoutGR3SubjectText
	tx MailRonaldsScoutGR3Body1Text
	no_card
	tx MailRonaldsScoutGR3Body2Text
	no_card
	end_mail

.MailRonaldsScoutGR4
	tx MailRonaldsScoutGR4SenderText
	tx MailRonaldsScoutGR4SubjectText
	tx MailRonaldsScoutGR4Body1Text
	no_card
	tx MailRonaldsScoutGR4Body2Text
	no_card
	end_mail

.MailRonaldsScoutMorino
	tx MailRonaldsScoutMorinoSenderText
	tx MailRonaldsScoutMorinoSubjectText
	tx MailRonaldsScoutMorinoBody1Text
	no_card
	tx MailRonaldsScoutMorinoBody2Text
	no_card
	tx MailRonaldsScoutMorinoBody3Text
	no_card
	tx MailRonaldsScoutMorinoBody4Text
	no_card
	end_mail

.MailRonaldsScoutCatherine
	tx MailRonaldsScoutCatherineSenderText
	tx MailRonaldsScoutCatherineSubjectText
	tx MailRonaldsScoutCatherineBody1Text
	no_card
	tx MailRonaldsScoutCatherineBody2Text
	no_card
	tx MailRonaldsScoutCatherineBody3Text
	no_card
	end_mail

.MailRonaldsScoutHidero
	tx MailRonaldsScoutHideroSenderText
	tx MailRonaldsScoutHideroSubjectText
	tx MailRonaldsScoutHideroBody1Text
	no_card
	tx MailRonaldsScoutHideroBody2Text
	no_card
	tx MailRonaldsScoutHideroBody3Text
	no_card
	end_mail

.MailRonaldsScoutKanoko
	tx MailRonaldsScoutKanokoSenderText
	tx MailRonaldsScoutKanokoSubjectText
	tx MailRonaldsScoutKanokoBody1Text
	no_card
	tx MailRonaldsScoutKanokoBody2Text
	no_card
	tx MailRonaldsScoutKanokoBody3Text
	no_card
	end_mail

.MailRonaldsScoutKamiya
	tx MailRonaldsScoutKamiyaSenderText
	tx MailRonaldsScoutKamiyaSubjectText
	tx MailRonaldsScoutKamiyaBody1Text
	no_card
	tx MailRonaldsScoutKamiyaBody2Text
	no_card
	tx MailRonaldsScoutKamiyaBody3Text
	no_card
	end_mail

.MailRonaldsScoutMami
	tx MailRonaldsScoutMamiSenderText
	tx MailRonaldsScoutMamiSubjectText
	tx MailRonaldsScoutMamiBody1Text
	no_card
	tx MailRonaldsScoutMamiBody2Text
	no_card
	tx MailRonaldsScoutMamiBody3Text
	no_card
	tx MailRonaldsScoutMamiBody4Text
	no_card
	tx MailRonaldsScoutMamiBody5Text
	no_card
	end_mail

.MailRonaldsScoutColorlessAltar
	tx MailRonaldsScoutColorlessAltarSenderText
	tx MailRonaldsScoutColorlessAltarSubjectText
	tx MailRonaldsScoutColorlessAltarBody1Text
	no_card
	tx MailRonaldsScoutColorlessAltarBody2Text
	no_card
	tx MailRonaldsScoutColorlessAltarBody3Text
	no_card
	tx MailRonaldsScoutColorlessAltarBody4Text
	no_card
	end_mail

.MailRonaldsScoutBiruritchi
	tx MailRonaldsScoutBiruritchiSenderText
	tx MailRonaldsScoutBiruritchiSubjectText
	tx MailRonaldsScoutBiruritchiBody1Text
	no_card
	tx MailRonaldsScoutBiruritchiBody2Text
	no_card
	tx MailRonaldsScoutBiruritchiBody3Text
	no_card
	tx MailRonaldsScoutBiruritchiBody4Text
	no_card
	tx MailRonaldsScoutBiruritchiBody5Text
	no_card
	end_mail

.MailLinkDuel
	tx MailLinkDuelSenderText
	tx MailLinkDuelSubjectText
	tx MailLinkDuelBody1Text
	no_card
	tx MailLinkDuelBody2Text
	no_card
	end_mail
