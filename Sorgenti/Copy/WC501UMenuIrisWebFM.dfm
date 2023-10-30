inherited WC501FMenuIrisWebFM: TWC501FMenuIrisWebFM
  Width = 578
  Height = 131
  ExplicitWidth = 578
  ExplicitHeight = 131
  inherited IWFrameRegion: TIWRegion
    Width = 578
    Height = 131
    LayoutMgr = TemplateProcessor
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderVisibility = False
    StyleRenderOptions.RenderStatus = False
    StyleRenderOptions.RenderAbsolute = False
    ExplicitWidth = 578
    ExplicitHeight = 131
    inherited IWMainMenu: TmeIWMenu
      AttachedMenu = MainMenu
    end
  end
  inherited ActionList: TActionList
    Left = 84
    Top = 80
    object actRicercaAnagrafe: TAction
      Tag = -1
      Caption = 'Ricerca anagrafe'
      Hint = 'Ricerca anagrafe'
      OnExecute = actExecute
    end
    object actAnagrafeElenco: TAction
      Tag = -2
      Caption = 'Elenco anagrafe'
      Hint = 'Elenco anagrafe'
      OnExecute = actExecute
    end
    object actGiustificativi: TAction
      Tag = 401
      Caption = 'Giustificativi ass./pres.'
      OnExecute = actExecute
    end
    object actPianifOrari: TAction
      Tag = 425
      Caption = 'Pianificazioni giornaliere'
      OnExecute = actExecute
    end
    object actAccessiMensa: TAction
      Tag = 416
      Caption = 'actAccessiMensa'
      OnExecute = actExecute
    end
    object actListaReperibili: TAction
      Tag = 404
      Caption = 'Elenco reperibili'
      OnExecute = actExecute
    end
    object actChiamateReperibili: TAction
      Tag = 435
      Caption = 'Chiamate in reperibilit'#224
      OnExecute = actExecute
    end
    object actReperibilita: TAction
      Tag = 403
      Caption = 'Pianificazione reperibilit'#224
      OnExecute = actExecute
    end
    object actNotificheElaborazioni: TAction
      Tag = 408
      Caption = 'Notifiche delle elaborazioni'
      OnExecute = actExecute
    end
    object actStampaCartellino: TAction
      Tag = 405
      Caption = 'Stampa cartellino'
      OnExecute = actExecute
    end
    object actValidazioneCartellino: TAction
      Tag = 442
      Caption = 'Validazione cartellino'
      Hint = 'Validazione cartellino'
      OnExecute = actExecute
    end
    object actStampaCedolino: TAction
      Tag = 417
      Caption = 'Stampa cedolino'
      OnExecute = actExecute
    end
    object actDetrazioniIRPEF: TAction
      Tag = 434
      Caption = 'Familiari a carico - A.N.F.'
      Hint = 'Familiari a carico - A.N.F.'
      OnExecute = actExecute
    end
    object actDatiConiuge: TAction
      Tag = 450
      Caption = 'Dati del coniuge'
      Hint = 'Dati del coniuge'
      OnExecute = actExecute
    end
    object actStampaCUD: TAction
      Tag = 422
      Caption = 'Stampa CUD/CU'
      OnExecute = actExecute
    end
    object actCambioProfilo: TAction
      Tag = 421
      Category = 'CODA'
      Caption = 'Cambio profilo'
      Hint = 'Cambio profilo'
      OnExecute = actExecute
    end
    object actGeneratoreStampe: TAction
      Tag = 414
      Caption = 'Generatore di stampe'
      OnExecute = actExecute
    end
    object actAnomalie: TAction
      Tag = 402
      Caption = 'Elenco anomalie'
      OnExecute = actExecute
    end
    object actSchedaAnagrafica: TAction
      Tag = 412
      Caption = 'Scheda anagrafica'
      OnExecute = actExecute
    end
    object actCartellino: TAction
      Tag = 400
      Caption = 'Cartellino interattivo'
      Hint = 'Cartellino interattivo'
      OnExecute = actExecute
    end
    object actDatiAtipici: TAction
      Tag = 464
      Caption = 'Registrazione dati atipici'
      OnExecute = actExecute
    end
    object actRichiestaAssenze: TAction
      Tag = 406
      Caption = 'Richiesta giustificativi'
      Hint = 'Richiesta giustificativi'
      OnExecute = actExecute
    end
    object actAutorizzazioneAssenze: TAction
      Tag = 407
      Caption = 'Autorizzazione giustificativi'
      Hint = 'Autorizzazione giustificativi'
      OnExecute = actExecute
    end
    object actProspettoAssenze: TAction
      Tag = 437
      Caption = 'Prospetto assenze'
      Hint = 'Prospetto assenze'
      OnExecute = actExecute
    end
    object actRichiestaTimbrature: TAction
      Tag = 418
      Caption = 'Richiesta modifica timbrature'
      Hint = 'Richiesta modifica timbrature'
      OnExecute = actExecute
    end
    object actAutorizzazioneTimbrature: TAction
      Tag = 419
      Caption = 'Autorizzazione modifica timbrature'
      Hint = 'Autorizzazione modifica timbrature'
      OnExecute = actExecute
    end
    object actRichiestaCambioOrario: TAction
      Tag = 430
      Caption = 'Richiesta cambio orario'
      Hint = 'Richiesta cambio orario'
      OnExecute = actExecute
    end
    object actAutorizzazioneCambioOrario: TAction
      Tag = 431
      Caption = 'Autorizzazione cambio orario'
      Hint = 'Autorizzazione cambio orario'
      OnExecute = actExecute
    end
    object actRichiestaStraordGG: TAction
      Tag = 432
      Caption = 'Richiesta ecced. giornaliere'
      Hint = 'Richiesta ecced. giornaliere'
      OnExecute = actExecute
    end
    object actAutorizzazioneStraordGG: TAction
      Tag = 433
      Caption = 'Autorizzazione ecced. giornaliere'
      Hint = 'Autorizzazione ecced. giornaliere'
      OnExecute = actExecute
    end
    object actRichiestaStraordinari: TAction
      Tag = 426
      Caption = 'Richiesta straordinari'
      Hint = 'Richiesta straordinari'
      OnExecute = actExecute
    end
    object actAutorizzazioneStraordinari: TAction
      Tag = 427
      Caption = 'Autorizzazione straordinari'
      Hint = 'Autorizzazione straordinari'
      OnExecute = actExecute
    end
    object actRichiestaMissioni: TAction
      Tag = 440
      Caption = 'Richiesta missioni'
      Hint = 'Richiesta missioni'
      OnExecute = actExecute
    end
    object actAutorizzazioneMissioni: TAction
      Tag = 441
      Caption = 'Autorizzazione missioni'
      Hint = 'Autorizzazione missioni'
      OnExecute = actExecute
    end
    object actCurriculum: TAction
      Tag = 409
      Caption = 'Curriculum'
      OnExecute = actExecute
    end
    object actPreferenze: TAction
      Tag = 410
      Caption = 'Preferenze'
      OnExecute = actExecute
    end
    object actTraspDirigenza: TAction
      Tag = 446
      Caption = 'Curriculum - Trasparenza'
      Hint = 'Curriculum - Trasparenza'
      OnExecute = actExecute
    end
    object actIscrizioneOrdiniProf: TAction
      Tag = 467
      Caption = 'Iscrizione ordine professionale'
      Hint = 'Iscrizione ordine professionale'
      OnExecute = actExecute
    end
    object actSchedaValutazioni: TAction
      Tag = 423
      Caption = 'Scheda di valutazione'
      Hint = 'Scheda di valutazione'
      OnExecute = actExecute
    end
    object actSchedaAutovalutazioni: TAction
      Tag = 424
      Caption = 'Scheda di autovalutazione'
      Hint = 'Scheda di autovalutazione'
      OnExecute = actExecute
    end
    object actStampaSchedaValutazioni: TAction
      Tag = 443
      Caption = 'Stampa scheda di valutazione'
      Hint = 'Stampa scheda di valutazione'
      OnExecute = actExecute
    end
    object actPesatureIndividuali: TAction
      Tag = 436
      Caption = 'Pesature individuali'
      Hint = 'Pesature individuali'
      OnExecute = actExecute
    end
    object actSchedeQuantIndividuali: TAction
      Tag = 439
      Caption = 'Schede quantitative individuali'
      Hint = 'Schede quantitative individuali'
      OnExecute = actExecute
    end
    object actRichiestaIscrCorsi: TAction
      Tag = 411
      Caption = 'Richiesta iscrizione corsi'
      Hint = 'Richiesta iscrizione corsi'
      OnExecute = actExecute
    end
    object actAutorizIscrCorsi: TAction
      Tag = 413
      Caption = 'Autorizzazione iscrizione corsi'
      Hint = 'Autorizzazione iscrizione corsi'
      OnExecute = actExecute
    end
    object actTabelloneTurni: TAction
      Tag = 438
      Caption = 'Tabellone turni'
      Hint = 'Tabellone turni'
      OnExecute = actExecute
    end
    object actPubblicazioneDocumenti: TAction
      Tag = 444
      Caption = 'Pubblicazione documenti'
      Hint = 'Pubblicazione documenti'
      OnExecute = actExecute
    end
    object actMessaggistica: TAction
      Tag = 445
      Caption = 'Messaggistica'
      Hint = 'Messaggistica'
      OnExecute = actExecute
    end
    object actClose: TAction
      Caption = 'actClose'
      OnExecute = actExecute
    end
    object actRichiestaScioperi: TAction
      Tag = 428
      Caption = 'Notifica adesione scioperi'
      Hint = 'Notifica adesione scioperi'
      OnExecute = actExecute
    end
    object actAutorizzazioneScioperi: TAction
      Tag = 429
      Caption = 'Autorizzazione adesione scioperi'
      Hint = 'Autorizzazione adesione scioperi'
      OnExecute = actExecute
    end
    object actBollatriceVirtuale: TAction
      Tag = 451
      Caption = 'Timbratura virtuale'
      Hint = 'Timbratura virtuale'
      OnExecute = actExecute
    end
    object actUploadDocumenti: TAction
      Tag = 449
      Caption = 'Upload documenti'
      Hint = 'Upload documenti'
      OnExecute = actExecute
    end
    object actInformazioniSu: TAction
      Caption = 'Informazioni su...'
      OnExecute = actExecute
    end
    object actQueryServizio: TAction
      Tag = 447
      Caption = 'Interrogazioni di servizio'
      OnExecute = actExecute
    end
    object actRichiestaDocumentale: TAction
      Tag = 457
      Caption = 'Richiesta documentale'
      Hint = 'Richiesta documentale'
      OnExecute = actExecute
    end
    object actAutorizzazioneDocumentale: TAction
      Tag = 458
      Caption = 'Autorizzazione documentale'
      Hint = 'Autorizzazione documentale'
      OnExecute = actExecute
    end
    object actGestioneDocumentale: TAction
      Tag = 448
      Caption = 'Gestione documentale'
      Hint = 'Gestione documentale'
      OnExecute = actExecute
    end
    object actModPersonaleReperibile: TAction
      Tag = 452
      Caption = 'Modifica personale reperibile'
      Hint = 'Modifica personale reperibile'
      OnExecute = actExecute
    end
    object actAcquistoTicket: TAction
      Tag = 466
      Caption = 'Acquisto ticket / buoni pasto'
      Hint = 'Acquisto ticket / buoni pasto'
      OnExecute = actExecute
    end
    object actCompensazioneSaldoNegativo: TAction
      Tag = 454
      Caption = 'Compensazione saldo negativo'
      Hint = 'Compensazione saldo negativo'
      OnExecute = actExecute
    end
    object actDatiGiuridici: TAction
      Tag = 465
      Caption = 'Autocertificazione dati giuridici'
      Hint = 'Autocertificazione dati giuridici'
      OnExecute = actExecute
    end
    object actCertificazioni: TAction
      Tag = 455
      Caption = 'Compilazione scheda informativa'
      Hint = 'Compilazione scheda informativa'
      OnExecute = actExecute
    end
    object actAutorizzazioneCertificazioni: TAction
      Tag = 456
      Caption = 'Validazione scheda informativa'
      Hint = 'Validazione scheda informativa'
      OnExecute = actExecute
    end
    object actGestioneCredenziali: TAction
      Tag = 415
      Category = 'CODA'
      Caption = 'Gestione credenziali'
      Hint = 'Gestione credenziali'
      OnExecute = actExecute
    end
    object actGestioneDeleghe: TAction
      Tag = 420
      Category = 'CODA'
      Caption = 'Gestione deleghe'
      Hint = 'Gestione deleghe'
      OnExecute = actExecute
    end
    object actCambioAzienda: TAction
      Tag = 453
      Category = 'CODA'
      Caption = 'Cambio azienda'
      Hint = 'Cambio azienda'
      OnExecute = actExecute
    end
    object actAutorizzazioneBudget: TAction
      Tag = 460
      Caption = 'Autorizzazione modifica budget'
      Hint = 'Autorizzazione modifica budget'
      OnExecute = actExecute
    end
    object actRichiestaBudget: TAction
      Tag = 461
      Caption = 'Richiesta modifica budget'
      OnExecute = actExecute
    end
    object actRichiestaDispTurni: TAction
      Tag = 462
      Caption = 'Inserimento disponibilit'#224' turni'
      Hint = 'Inserimento disponibilit'#224' turni'
      OnExecute = actExecute
    end
    object actAutorizzazioneDispTurni: TAction
      Tag = 463
      Caption = 'Autorizzazione disponibilit'#224' turni'
      Hint = 'Autorizzazione disponibilit'#224' turni'
      OnExecute = actExecute
    end
  end
  inherited MainMenu: TMainMenu
    Left = 16
    Top = 80
    object FunzioniOperative1: TMenuItem
      Caption = 'Funzioni operative'
      object Ricercaanagrafe1: TMenuItem
        Tag = 428
        Action = actRicercaAnagrafe
      end
      object Elencoanagrafe1: TMenuItem
        Tag = 429
        Action = actAnagrafeElenco
        ImageIndex = 16
      end
      object Giustificativiasspres1: TMenuItem
        Tag = 401
        Action = actGiustificativi
      end
      object Pianificazioneorari1: TMenuItem
        Tag = 425
        Action = actPianifOrari
      end
      object abelloneturni1: TMenuItem
        Tag = 438
        Action = actTabelloneTurni
      end
      object Richiestadisponibilitturni1: TMenuItem
        Action = actRichiestaDispTurni
      end
      object Autorizzazionedisponibilitturni1: TMenuItem
        Action = actAutorizzazioneDispTurni
      end
      object Accessimensa1: TMenuItem
        Tag = 416
        Action = actAccessiMensa
        Caption = 'Accessi mensa'
      end
      object Gestionedelbudget2: TMenuItem
        Action = actAutorizzazioneBudget
      end
      object Richiestamodificabudget1: TMenuItem
        Action = actRichiestaBudget
      end
      object Datiatipici1: TMenuItem
        Action = actDatiAtipici
      end
      object SepA01: TMenuItem
        Caption = '-'
      end
      object Reperibilita1: TMenuItem
        Tag = 403
        Action = actReperibilita
      end
      object Reperibili1: TMenuItem
        Tag = 404
        Action = actListaReperibili
      end
      object Chiamateinreperibilit1: TMenuItem
        Tag = 435
        Action = actChiamateReperibili
      end
      object Modificapersonalereperibile1: TMenuItem
        Tag = 452
        Action = actModPersonaleReperibile
      end
      object SepA02: TMenuItem
        Caption = '-'
      end
      object Uploaddocumenti1: TMenuItem
        Tag = 449
        Action = actUploadDocumenti
      end
    end
    object Puntoinformativo1: TMenuItem
      Caption = 'Punto informativo'
      object Schedaanagrafica1: TMenuItem
        Tag = 412
        Action = actSchedaAnagrafica
      end
      object DetrazioniIRPEF1: TMenuItem
        Tag = 434
        Action = actDetrazioniIRPEF
      end
      object Datidelconiuge1: TMenuItem
        Tag = 450
        Action = actDatiConiuge
      end
      object Messaggi1: TMenuItem
        Tag = 408
        Action = actNotificheElaborazioni
      end
      object Messaggi2: TMenuItem
        Tag = 445
        Action = actMessaggistica
      end
      object SepB01: TMenuItem
        Caption = '-'
      end
      object Stampacartellino1: TMenuItem
        Tag = 405
        Action = actStampaCartellino
      end
      object Validazionecartellino1: TMenuItem
        Tag = 442
        Action = actValidazioneCartellino
      end
      object StampaCedolino1: TMenuItem
        Tag = 417
        Action = actStampaCedolino
      end
      object StampaCUD1: TMenuItem
        Tag = 422
        Action = actStampaCUD
      end
      object Generatoredistampe1: TMenuItem
        Tag = 414
        Action = actGeneratoreStampe
      end
      object Interrogazionidiservizio1: TMenuItem
        Tag = 447
        Action = actQueryServizio
      end
      object Anomalie1: TMenuItem
        Tag = 402
        Action = actAnomalie
      end
      object SepB02: TMenuItem
        Caption = '-'
      end
      object Bollatricevirtuale1: TMenuItem
        Action = actBollatriceVirtuale
      end
      object Cartellinointerattivo1: TMenuItem
        Tag = 400
        Action = actCartellino
      end
      object Richiestatimbrature1: TMenuItem
        Tag = 418
        Action = actRichiestaTimbrature
      end
      object Autorizzazionetimbrature1: TMenuItem
        Tag = 419
        Action = actAutorizzazioneTimbrature
      end
      object SepB03: TMenuItem
        Caption = '-'
      end
      object Richiestaassenze1: TMenuItem
        Tag = 406
        Action = actRichiestaAssenze
      end
      object Autorizzazioneassenz1: TMenuItem
        Tag = 407
        Action = actAutorizzazioneAssenze
      end
      object Prospettoassenze1: TMenuItem
        Tag = 437
        Action = actProspettoAssenze
      end
      object SepB11: TMenuItem
        Caption = '-'
      end
      object Richiestacambioorario1: TMenuItem
        Tag = 430
        Action = actRichiestaCambioOrario
      end
      object Autorizzazionecambioorario1: TMenuItem
        Tag = 431
        Action = actAutorizzazioneCambioOrario
      end
      object SepB05: TMenuItem
        Caption = '-'
      end
      object Compensazionesaldonegativo1: TMenuItem
        Tag = 454
        Action = actCompensazioneSaldoNegativo
      end
      object Richiestastraordinari1: TMenuItem
        Tag = 426
        Action = actRichiestaStraordinari
      end
      object Autorizzazionestraordinari1: TMenuItem
        Tag = 427
        Action = actAutorizzazioneStraordinari
      end
      object SepB09: TMenuItem
        Caption = '-'
      end
      object Richiestastraordgiornaliero1: TMenuItem
        Tag = 432
        Action = actRichiestaStraordGG
      end
      object Autorizzazionestraordgiornaliero1: TMenuItem
        Tag = 433
        Action = actAutorizzazioneStraordGG
      end
      object SepB10: TMenuItem
        Caption = '-'
      end
      object Acquistoticket1: TMenuItem
        Tag = 466
        Action = actAcquistoTicket
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Richiestamissioni1: TMenuItem
        Tag = 440
        Action = actRichiestaMissioni
      end
      object Autorizzazionemissioni1: TMenuItem
        Tag = 441
        Action = actAutorizzazioneMissioni
      end
      object SepB12: TMenuItem
        Caption = '-'
      end
      object Richiestascioperi1: TMenuItem
        Tag = 428
        Action = actRichiestaScioperi
      end
      object Autorizzazionescioperi1: TMenuItem
        Tag = 429
        Action = actAutorizzazioneScioperi
      end
      object SepB06: TMenuItem
        Caption = '-'
      end
      object Autocertificazionedatigiuridici1: TMenuItem
        Action = actDatiGiuridici
      end
      object Curriculum1: TMenuItem
        Tag = 409
        Action = actCurriculum
      end
      object Preferenze1: TMenuItem
        Tag = 410
        Action = actPreferenze
      end
      object Trasparenzacurriculumperdirigenza1: TMenuItem
        Tag = 446
        Action = actTraspDirigenza
      end
      object OrdiniprofessionaliIscrizione1: TMenuItem
        Tag = 467
        Action = actIscrizioneOrdiniProf
      end
      object Schedavalutazioni1: TMenuItem
        Tag = 423
        Action = actSchedaValutazioni
      end
      object Schedaautovalutazioni1: TMenuItem
        Tag = 424
        Action = actSchedaAutovalutazioni
      end
      object Stampaschedadivalutazione1: TMenuItem
        Tag = 443
        Action = actStampaSchedaValutazioni
      end
      object Pesatureindividuali1: TMenuItem
        Tag = 436
        Action = actPesatureIndividuali
      end
      object Schedequantitativeindividuali1: TMenuItem
        Action = actSchedeQuantIndividuali
      end
      object SepB07: TMenuItem
        Caption = '-'
      end
      object RichiestaIscrizioneCorsi1: TMenuItem
        Tag = 411
        Action = actRichiestaIscrCorsi
      end
      object AutorizzIscrizioneCorsi1: TMenuItem
        Tag = 413
        Action = actAutorizIscrCorsi
      end
      object SepB08: TMenuItem
        Caption = '-'
      end
      object Richiestadocumentale1: TMenuItem
        Tag = 457
        Action = actRichiestaDocumentale
      end
      object Autorizzazionedocumentale1: TMenuItem
        Tag = 458
        Action = actAutorizzazioneDocumentale
      end
      object Gestionedocumentale1: TMenuItem
        Tag = 448
        Action = actGestioneDocumentale
      end
      object Pubblicazionedocumenti1: TMenuItem
        Tag = 444
        Action = actPubblicazioneDocumenti
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object RichiestCertificazioni1: TMenuItem
        Action = actCertificazioni
      end
      object AutorizzazioneCertificazioni1: TMenuItem
        Action = actAutorizzazioneCertificazioni
      end
    end
    object Gestionesicurezza1: TMenuItem
      Caption = 'Gestione sicurezza'
      object Gestionesicurezza2: TMenuItem
        Tag = 415
        Action = actGestioneCredenziali
      end
      object Gestionedeleghe1: TMenuItem
        Tag = 420
        Action = actGestioneDeleghe
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Cambioazienda1: TMenuItem
        Action = actCambioAzienda
      end
      object Cambioprofilo1: TMenuItem
        Tag = 421
        Action = actCambioProfilo
      end
    end
    object N1: TMenuItem
      Caption = '?'
      object Informazionisu1: TMenuItem
        Action = actInformazioniSu
      end
    end
  end
  inherited JQuery: TIWJQueryWidget
    Left = 16
    Top = 8
  end
end
