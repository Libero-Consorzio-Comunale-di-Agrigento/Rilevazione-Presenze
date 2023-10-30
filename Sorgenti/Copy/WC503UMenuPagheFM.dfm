inherited WC503FMenuPagheFM: TWC503FMenuPagheFM
  Width = 756
  ExplicitWidth = 756
  inherited IWFrameRegion: TIWRegion
    Width = 756
    ExplicitWidth = 756
  end
  inherited ActionList: TActionList
    inherited actOperatori: TAction [0]
    end
    inherited actAziende: TAction [1]
    end
    inherited actPermessi: TAction [2]
    end
    inherited actFiltroAnagrafe: TAction [3]
    end
    inherited actFiltroFunzioni: TAction [4]
    end
    inherited actFiltroDizionario: TAction [5]
    end
    inherited actProfiloIterAutorizzativi: TAction [6]
    end
    inherited actLoginDipendenti: TAction [7]
    end
    inherited actAccessi: TAction [8]
    end
    inherited actGestioneSicurezza: TAction [9]
      Category = 'Amministrazione sistema'
    end
    inherited actCambioAzienda: TAction [10]
    end
    object actRidefinizioneCampiAnagrafici: TAction [11]
      Tag = 115
      Category = 'Amministrazione sistema'
      Caption = 'Ridefinizione campi anagrafici'
      OnExecute = actExecute
    end
    inherited actAllineaStorici: TAction [12]
    end
    inherited actManipolazioneDati: TAction [13]
    end
    inherited actUtilityDB: TAction [14]
    end
    inherited actMonitoraggioLog: TAction [15]
    end
    inherited actMsgElaborazioni: TAction [16]
    end
    inherited actDatiLiberi: TAction [17]
    end
    inherited actRelazioni: TAction [18]
    end
    object actLayoutSchedaAnagrafica: TAction [19]
      Tag = 151
      Category = 'Amministrazione sistema'
      Caption = 'Layout scheda anagrafica'
      OnExecute = actExecute
    end
    object actEntiAppartenenza: TAction [20]
      Tag = 637
      Category = 'Ambiente'
      Caption = 'Enti di appartenenza'
      Hint = 'Enti di appartenenza'
      OnExecute = actExecute
    end
    object actStatoCivile: TAction [21]
      Tag = 548
      Category = 'Ambiente'
      Caption = 'Stato civile'
      Hint = 'Stato civile'
      OnExecute = actExecute
    end
    object actNazionalita: TAction [22]
      Tag = 549
      Category = 'Ambiente'
      Caption = 'Nazionalit'#224
      Hint = 'Nazionalit'#224
      OnExecute = actExecute
    end
    object actBanche: TAction [23]
      Tag = 515
      Category = 'Ambiente'
      Caption = 'Banche'
      Hint = 'Banche'
      OnExecute = actExecute
    end
    object actModalitaPagamento: TAction [24]
      Tag = 514
      Category = 'Ambiente'
      Caption = 'Modalit'#224' di pagamento'
      Hint = 'Modalit'#224' di pagamento'
      OnExecute = actExecute
    end
    object actPagamenti: TAction [25]
      Tag = 514
      Category = 'Ambiente'
      Caption = 'Modalit'#224' di pagamento'
      Hint = 'Modalit'#224' di pagamento'
      OnExecute = actExecute
    end
    object actTabelleANF: TAction [26]
      Tag = 513
      Category = 'Ambiente'
      Caption = 'Tabelle ANF'
      Hint = 'Tabelle ANF'
      OnExecute = actExecute
    end
    object actPartTime: TAction [27]
      Tag = 512
      Category = 'Ambiente'
      Caption = 'Part-time'
      Hint = 'Part-time'
      OnExecute = actExecute
    end
    object actCodiciINPS: TAction [28]
      Tag = 528
      Category = 'Ambiente'
      Caption = 'Codici INPS'
      Hint = 'Codici INPS'
      OnExecute = actExecute
    end
    object actFPC: TAction [29]
      Tag = 613
      Category = 'Ambiente'
      Caption = 'Fondi previdenza complementare'
      Hint = 'Fondi previdenza complementare'
      OnExecute = actExecute
    end
    object actConfigDatiAziendali: TAction [30]
      Tag = 543
      Category = 'Ambiente'
      Caption = 'Configurazione dati aziendali'
      Hint = 'Configurazione dati aziendali'
      OnExecute = actExecute
    end
    object actConfigDatiEconomici: TAction [31]
      Tag = 520
      Category = 'Ambiente'
      Caption = 'Configurazione dati economici'
      Hint = 'Configurazione dati economici'
      OnExecute = actExecute
    end
    object actAreeContrattuali: TAction [32]
      Tag = 508
      Category = 'Ambiente'
      Caption = 'Aree contrattuali'
      Hint = 'Aree contrattuali'
      OnExecute = actExecute
    end
    object actContrattiVoci: TAction [33]
      Tag = 507
      Category = 'Ambiente'
      Caption = 'Contratti voci'
      Hint = 'Contratti voci'
      OnExecute = actExecute
    end
    object actMisureQuantita: TAction [34]
      Tag = 521
      Category = 'Ambiente'
      Caption = 'Misure quantit'#224
      Hint = 'Misure quantit'#224
      OnExecute = actExecute
    end
    object actRaggruppamentoVoci: TAction [35]
      Tag = 524
      Category = 'Ambiente'
      Caption = 'Raggruppamenti voci'
      Hint = 'Raggruppamenti voci'
      OnExecute = actExecute
    end
    object actCausaliIrpef: TAction [36]
      Tag = 522
      Category = 'Ambiente'
      Caption = 'Causali versamenti Irpef'
      Hint = 'Causali versamenti Irpef'
      OnExecute = actExecute
    end
    object actBeneficiari: TAction [37]
      Tag = 617
      Category = 'Ambiente'
      Caption = 'Beneficiari'
      Hint = 'Beneficiari'
      OnExecute = actExecute
    end
    object actVoci: TAction [38]
      Tag = 501
      Category = 'Ambiente'
      Caption = 'Voci'
      OnExecute = actExecute
    end
    object actAlberoAssoggettamenti: TAction [39]
      Tag = 502
      Category = 'Ambiente'
      Caption = 'Albero assoggettamenti'
      OnExecute = actExecute
    end
    object actTipiAccorpamento: TAction [40]
      Tag = 550
      Category = 'Ambiente'
      Caption = 'Accorpamenti voci: tipologie'
      Hint = 'Accorpamenti voci: tipologie'
      OnExecute = actExecute
    end
    object actAccorpamentiVoci: TAction [41]
      Tag = 552
      Category = 'Ambiente'
      Caption = 'Accorpamenti voci'
      Hint = 'Accorpamenti voci'
      OnExecute = actExecute
    end
    object actLivelli: TAction [42]
      Tag = 509
      Category = 'Ambiente'
      Caption = 'Posizioni economiche'
      Hint = 'Posizioni economiche'
      OnExecute = actExecute
    end
    object actVociAggiuntive: TAction [43]
      Tag = 510
      Category = 'Ambiente'
      Caption = 'Voci aggiuntive'
      Hint = 'Voci aggiuntive'
      OnExecute = actExecute
    end
    object actVociAggiuntiveImporti: TAction [44]
      Tag = 511
      Category = 'Ambiente'
      Caption = 'Importi voci aggiuntive'
      Hint = 'Importi voci aggiuntive'
      OnExecute = actExecute
    end
    object actRegoleSostituzioniConvenzionati: TAction [45]
      Tag = 620
      Category = 'Ambiente'
      Caption = 'Regole sostituzioni convenzionati'
      Hint = 'Regole sostituzioni convenzionati'
      OnExecute = actExecute
    end
    object actTipiAssoggettamenti: TAction [46]
      Tag = 534
      Category = 'Ambiente'
      Caption = 'Tipi assoggettamenti'
      Hint = 'Tipi assoggettamenti'
      OnExecute = actExecute
    end
    object actEntiIRPEF: TAction [47]
      Tag = 525
      Category = 'Ambiente'
      Caption = 'Tabelle addizionali IRPEF'
      Hint = 'Tabelle addizionali IRPEF'
      OnExecute = actExecute
    end
    object actValute: TAction [48]
      Tag = 517
      Category = 'Ambiente'
      Caption = 'Valute'
      Hint = 'Valute'
      OnExecute = actExecute
    end
    object actArrotondamenti: TAction [49]
      Tag = 519
      Category = 'Ambiente'
      Caption = 'Arrotondamenti valute'
      Hint = 'Arrotondamenti valute'
      OnExecute = actExecute
    end
    object actCambiValute: TAction [50]
      Tag = 518
      Category = 'Ambiente'
      Caption = 'Cambi valute'
      Hint = 'Cambi valute'
      OnExecute = actExecute
    end
    inherited actTabelleDatiLiberi: TAction [51]
    end
    object actQualificheMinisteriali: TAction [52]
      Tag = 191
      Category = 'Ambiente'
      Caption = 'Qualifiche ministeriali'
      Hint = 'Qualifiche ministeriali'
      OnExecute = actExecute
    end
    object actTipoRapporto: TAction [53]
      Tag = 143
      Category = 'Ambiente'
      Caption = 'Tipi di rapporto'
      Hint = 'Tipi di rapporto'
      OnExecute = actExecute
    end
    inherited actEntiLocali: TAction [54]
    end
    object actCodiciINAIL: TAction [55]
      Tag = 529
      Category = 'Ambiente'
      Caption = 'Codici INAIL'
      Hint = 'Codici INAIL'
      OnExecute = actExecute
    end
    object actCalcoloMinimaleMassimaleINAIL: TAction [56]
      Tag = 601
      Category = 'Ambiente'
      Caption = 'Calcolo parametri INAIL'
      OnExecute = actExecute
    end
    object actCAF: TAction [57]
      Tag = 537
      Category = 'Ambiente'
      Caption = 'C.A.F.'
      Hint = 'C.A.F.'
      OnExecute = actExecute
    end
    object actTipoImporti: TAction [58]
      Tag = 538
      Category = 'Ambiente'
      Caption = 'Tipi importi'
      Hint = 'Tipi importi'
      OnExecute = actExecute
    end
    object actRegoleCalcoloCU: TAction [59]
      Tag = 544
      Category = 'Ambiente'
      Caption = 'Regole di calcolo della CU'
      OnExecute = actExecute
    end
    object actInquadramentoINPS: TAction [60]
      Tag = 540
      Category = 'Ambiente'
      Caption = 'Inquadramenti INPS'
      Hint = 'Inquadramenti INPS'
      OnExecute = actExecute
    end
    object actInquadramentoINPDAP: TAction [61]
      Tag = 541
      Category = 'Ambiente'
      Caption = 'Inquadramenti INPDAP'
      Hint = 'Inquadramenti INPDAP'
      OnExecute = actExecute
    end
    object actEntiPrevidenziali: TAction [62]
      Tag = 594
      Category = 'Ambiente'
      Caption = 'Enti Previdenziali'
      OnExecute = actExecute
    end
    object actRegoleCalcolo770: TAction [63]
      Tag = 545
      Category = 'Ambiente'
      Caption = 'actRegoleCalcolo770'
      OnExecute = actExecute
    end
    object actRegoleFornituraINPSUniEmens: TAction [64]
      Tag = 618
      Category = 'Ambiente'
      Caption = 'Regole fornitura INPS - uniEMens'
      OnExecute = actExecute
    end
    object actRegoleINPDAP: TAction [65]
      Tag = 559
      Category = 'Ambiente'
      Caption = 'Regole fornitura INPDAP - DMA'
      OnExecute = actExecute
    end
    object actRelazioniTabelle: TAction [66]
      Tag = 299
      Category = 'Ambiente'
      Caption = 'Relazioni tabelle FLUPER'
      OnExecute = actExecute
    end
    object actRegoleFLUPER: TAction [67]
      Tag = 571
      Category = 'Ambiente'
      Caption = 'Regole fornitura FLUPER'
      OnExecute = actExecute
    end
    object actRegoleContabilita: TAction [68]
      Tag = 586
      Category = 'Ambiente'
      Caption = 'Regole contabilit'#224
      OnExecute = actExecute
    end
    object actContoAnnRelTab: TAction [69]
      Tag = 647
      Category = 'Ambiente'
      Caption = 'Relazioni tabelle conto annuale'
      Hint = 'Relazioni tabelle conto annuale'
      OnExecute = actExecute
    end
    object actRegoleContoAnnuale: TAction [70]
      Tag = 580
      Category = 'Ambiente'
      Caption = 'Regole conto annuale'
      OnExecute = actExecute
    end
    object actRisorseContoAnnuale: TAction [71]
      Tag = 584
      Category = 'Ambiente'
      Caption = 'Risorse residue conto annuale'
      OnExecute = actExecute
    end
    object actMacrocategorieFondi: TAction [72]
      Tag = 607
      Category = 'Ambiente'
      Caption = 'Macrocategorie fondi'
      OnExecute = actExecute
    end
    object actRaggruppamentiFondi: TAction [73]
      Tag = 608
      Category = 'Ambiente'
      Caption = 'Raggruppamenti fondi'
      OnExecute = actExecute
    end
    object actDefinizioneFondi: TAction [74]
      Tag = 609
      Category = 'Ambiente'
      Caption = 'Definizione fondi'
      OnExecute = actExecute
    end
    object actCalcoloFondi: TAction [75]
      Tag = 610
      Category = 'Ambiente'
      Caption = 'Calcolo consumi mensili fondi'
      OnExecute = actExecute
    end
    object actMonitoraggioFondi: TAction [76]
      Tag = 611
      Category = 'Ambiente'
      Caption = 'Monitoraggio fondi'
      OnExecute = actExecute
    end
    object actStampaFondi: TAction [77]
      Tag = 612
      Category = 'Ambiente'
      Caption = 'Stampa fondi'
      OnExecute = actExecute
    end
    object actCausaliAssenza: TAction [78]
      Tag = 105
      Category = 'Ambiente'
      Caption = 'Causali di assenza'
      Hint = 'Causali di assenza'
      ImageIndex = 24
      OnExecute = actExecute
    end
    object actRaggrAssenze: TAction [79]
      Tag = 106
      Category = 'Ambiente'
      Caption = 'Raggruppamenti di assenza'
      Hint = 'Raggruppamenti di assenza'
      OnExecute = actExecute
    end
    object actAccorpamentiCausali: TAction [80]
      Tag = 196
      Category = 'Ambiente'
      Caption = 'Accorpamenti causali di assenza'
      Hint = 'Accorpamenti causali di assenza'
      OnExecute = actExecute
    end
    object actCodiciAccorpCausali: TAction [81]
      Tag = 91
      Category = 'Ambiente'
      Caption = 'actCodiciAccorpCausali'
      OnExecute = actExecute
    end
    object actRaggrInterrogazioni: TAction [82]
      Tag = 52
      Category = 'Ambiente'
      Caption = 'Raggruppamenti interrogazioni di servizio'
      Hint = 'Raggruppamenti interrogazioni di servizio'
      OnExecute = actExecute
    end
    object actGestioneImmagini: TAction [83]
      Tag = 164
      Category = 'Ambiente'
      Caption = 'Loghi aziendali'
      Hint = 'Loghi aziendali'
      OnExecute = actExecute
    end
    object actSchedaAnagrafica: TAction [84]
      Category = 'Personale'
      Caption = 'Scheda anagrafica'
      Hint = 'Scheda anagrafica'
      OnExecute = actExecute
    end
    inherited actAnagraficaStipendi: TAction [85]
    end
    object actCDCPercent: TAction [86]
      Tag = 162
      Category = 'Personale'
      Caption = 'Centri di costo percentualizzati'
      Hint = 'Centri di costo percentualizzati'
      OnExecute = actExecute
    end
    object actFamiliari: TAction [87]
      Tag = 303
      Category = 'Personale'
      Caption = 'Familiari'
      Hint = 'Familiari'
      OnExecute = actExecute
    end
    object actDatiRapportiPrecedenti: TAction [88]
      Tag = 547
      Category = 'Personale'
      Caption = 'Dati rapporti precedenti'
      Hint = 'Dati rapporti precedenti'
      OnExecute = actExecute
    end
    object actVociProgrammate: TAction [89]
      Tag = 506
      Category = 'Personale'
      Caption = 'Voci programmate'
      OnExecute = actExecute
    end
    object actVociVariabili: TAction [90]
      Tag = 504
      Category = 'Personale'
      Caption = 'Voci variabili'
      OnExecute = actExecute
    end
    object actRecuperoVoci: TAction [91]
      Tag = 625
      Category = 'Personale'
      Caption = 'Voci da recuperare/recuperate'
      Hint = 'Voci da recuperare/recuperate'
      OnExecute = actExecute
    end
    object actQuantitaMensili: TAction [92]
      Tag = 590
      Category = 'Personale'
      Caption = 'Quantit'#224' mensili'
      Hint = 'Quantit'#224' mensili'
      OnExecute = actExecute
    end
    object actSostituzioniConvenzionati: TAction [93]
      Tag = 621
      Category = 'Personale'
      Caption = 'Sostituzioni convenzionati'
      OnExecute = actExecute
    end
    object actGiustifAssPres: TAction [94]
      Tag = 2
      Category = 'Personale'
      Caption = 'Giustificativi ass./pres.'
      Hint = 'Giustificativi ass./pres.'
      OnExecute = actExecute
    end
    object actCedolini: TAction [95]
      Tag = 523
      Category = 'Personale'
      Caption = 'Cedolini'
      Hint = 'Cedolini'
      OnExecute = actExecute
    end
    object actDatiMensili: TAction [96]
      Tag = 527
      Category = 'Personale'
      Caption = 'Dati mensili'
      Hint = 'Dati mensili'
      OnExecute = actExecute
    end
    object actFornituraINPDAP: TAction [97]
      Tag = 561
      Category = 'Personale'
      Caption = 'Fornitura INPDAP - DMA'
      OnExecute = actExecute
    end
    object actFornituraINPS: TAction [98]
      Tag = 573
      Category = 'Personale'
      Caption = 'Fornitura INPS - uniEMens'
      OnExecute = actExecute
    end
    object actFornituraFluper: TAction [99]
      Tag = 572
      Category = 'Personale'
      Caption = 'Fornitura FLUPER'
      OnExecute = actExecute
    end
    object actDatiContabilita: TAction [100]
      Tag = 588
      Category = 'Personale'
      Caption = 'Dati contabilit'#224
      Hint = 'Dati contabilit'#224
      OnExecute = actExecute
    end
    object actParcheggioVoci: TAction [101]
      Tag = 568
      Category = 'Personale'
      Caption = 'Parcheggio voci'
      OnExecute = actExecute
    end
    object actRedditiAnnuali: TAction [102]
      Tag = 554
      Category = 'Personale'
      Caption = 'Redditi annuali'
      Hint = 'Redditi anni precedenti'
      OnExecute = actExecute
    end
    object actAddizionaliIRPEF: TAction [103]
      Tag = 526
      Category = 'Personale'
      Caption = 'Addizionali IRPEF'
      Hint = 'Addizionali IRPEF'
      OnExecute = actExecute
    end
    object actDatiONAOSI: TAction [104]
      Tag = 557
      Category = 'Personale'
      Caption = 'Dati O.N.A.O.S.I.'
      Hint = 'Dati O.N.A.O.S.I.'
      OnExecute = actExecute
    end
    object actModello730: TAction [105]
      Tag = 539
      Category = 'Personale'
      Caption = 'Modello 730'
      Hint = 'Modello 730'
      OnExecute = actExecute
    end
    object actModelloCU: TAction [106]
      Tag = 551
      Category = 'Personale'
      Caption = 'Modello CU'
      OnExecute = actExecute
    end
    object actModelliCUparticolari: TAction [107]
      Tag = 500
      Category = 'Personale'
      Caption = 'Modelli CU particolari'
      OnExecute = actExecute
    end
    object actModello770: TAction [108]
      Tag = 553
      Category = 'Personale'
      Caption = 'Modello 770'
      OnExecute = actExecute
    end
    object actContoAnnuale: TAction [109]
      Tag = 582
      Category = 'Personale'
      Caption = 'Conto annuale'
      OnExecute = actExecute
    end
    inherited actDataLavoro: TAction [110]
    end
    inherited actFiltroCessati: TAction [111]
    end
    object actAcquisizioneQuantitaMensili: TAction [112]
      Tag = 592
      Category = 'Elaborazioni'
      Caption = 'Acquisizione quantit'#224' mensili'
      OnExecute = actExecute
    end
    object actControlloTettoAccessorie: TAction [113]
      Tag = 619
      Category = 'Elaborazioni'
      Caption = 'Controllo tetto accesorie'
      OnExecute = actExecute
    end
    object actPremioOperosita: TAction [114]
      Tag = 614
      Category = 'Elaborazioni'
      Caption = 'Premio di operosit'#224
      OnExecute = actExecute
    end
    object actPremioOperositaMaturato: TAction [115]
      Tag = 651
      Category = 'Elaborazioni'
      Caption = 'Premio di operosit'#224' maturato'
      OnExecute = actExecute
    end
    object actElaborazioneCedolini: TAction [116]
      Tag = 505
      Category = 'Elaborazioni'
      Caption = 'Elaborazione cedolini'
      OnExecute = actExecute
    end
    object actFileInadempienze: TAction [117]
      Tag = 648
      Category = 'Elaborazioni'
      Caption = 'Creazione file verifica inadempienze'
      OnExecute = actExecute
    end
    object actFileSEPA: TAction [118]
      Tag = 562
      Category = 'Elaborazioni'
      Caption = 'Creazione file SEPA'
      OnExecute = actExecute
    end
    object actConguagliRetroattivi: TAction [119]
      Tag = 567
      Category = 'Elaborazioni'
      Caption = 'Conguagli retroattivi'
      OnExecute = actExecute
    end
    object actCalcoloTredicesimaVirtuale: TAction [120]
      Tag = 569
      Category = 'Elaborazioni'
      Caption = 'Calcolo tredicesima virtuale'
      OnExecute = actExecute
    end
    object actChiusuraANF: TAction [121]
      Tag = 585
      Category = 'Elaborazioni'
      Caption = 'Calcolo variazioni e chiusura A.N.F.'
      OnExecute = actExecute
    end
    object actRiepilogoMensileInps: TAction [122]
      Tag = 531
      Category = 'Elaborazioni'
      Caption = 'Riepiloghi mensili INPS'
      OnExecute = actExecute
    end
    object actINPSCalcolo: TAction [123]
      Tag = 570
      Category = 'Elaborazioni'
      Caption = 'Elaborazione fornitura INPS - uniEMens'
      OnExecute = actExecute
    end
    object actElaborazioneF24EP: TAction [124]
      Tag = 593
      Category = 'Elaborazioni'
      Caption = 'Elaborazione fornitura F24 EP'
      OnExecute = actExecute
    end
    object actElaborazioneF24Ord: TAction [125]
      Tag = 631
      Category = 'Elaborazioni'
      Caption = 'Elaborazione fornitura F24 ordinario'
      OnExecute = actExecute
    end
    object actElaborazionePerseo: TAction [126]
      Tag = 622
      Category = 'Elaborazioni'
      Caption = 'Elaborazione fornitura Perseo'
      OnExecute = actExecute
    end
    object actElaborazioneENPAP: TAction [127]
      Tag = 623
      Category = 'Elaborazioni'
      Caption = 'Elaborazione fornitura ENPAP'
      OnExecute = actExecute
    end
    object actElaborazioneENPAV: TAction [128]
      Tag = 558
      Category = 'Elaborazioni'
      Caption = 'Elaborazione fornitura ENPAV'
      OnExecute = actExecute
    end
    object actElaborazioneMensileENPAM: TAction [129]
      Tag = 576
      Category = 'Elaborazioni'
      Caption = 'Elaborazione fornitura mensile ENPAM'
      OnExecute = actExecute
    end
    object actElaborazioneENPAM: TAction [130]
      Tag = 560
      Category = 'Elaborazioni'
      Caption = 'Elaborazione fornitura annuale ENPAM'
      OnExecute = actExecute
    end
    object actElaborazioneContab: TAction [131]
      Tag = 587
      Category = 'Elaborazioni'
      Caption = 'Contabilit'#224
      OnExecute = actExecute
    end
    object actStampaInail: TAction [132]
      Tag = 533
      Category = 'Elaborazioni'
      Caption = 'Stampa INAIL'
      OnExecute = actExecute
    end
    object actCalcolaINAIL: TAction [133]
      Tag = 575
      Category = 'Elaborazioni'
      Caption = 'Calcolo ritenute INAIL ente'
      OnExecute = actExecute
    end
    object actElaborazioneONAOSI: TAction [134]
      Tag = 556
      Category = 'Elaborazioni'
      Caption = 'Elaborazione modello O.N.A.O.S.I.'
      OnExecute = actExecute
    end
    object actImportazioneModelli730: TAction [135]
      Tag = 564
      Category = 'Elaborazioni'
      Caption = 'Importazione modelli 730 da file'
      OnExecute = actExecute
    end
    object actImpostazionePercRimbLuglio: TAction [136]
      Tag = 624
      Category = 'Elaborazioni'
      Caption = 'Impostazione % rimb. Luglio mod.730'
      OnExecute = actExecute
    end
    object actElaborazioneModelliCU: TAction [137]
      Tag = 542
      Category = 'Elaborazioni'
      Caption = 'Elaborazione modelli CU'
      OnExecute = actExecute
    end
    object actStampaModelliCU: TAction [138]
      Tag = 516
      Category = 'Elaborazioni'
      Caption = 'Stampa modelli CU'
      OnExecute = actExecute
    end
    object actImportazioneRicevuteModelliCU: TAction [139]
      Tag = 630
      Category = 'Elaborazioni'
      Caption = 'Importazione ricevute modelli CU'
      OnExecute = actExecute
    end
    object actElaborazioneModelli770: TAction [140]
      Tag = 546
      Category = 'Elaborazioni'
      Caption = 'Elaborazione modelli 770'
      OnExecute = actExecute
    end
    object actStatisticaMinisterialeAssenze: TAction [141]
      Tag = 595
      Category = 'Elaborazioni'
      Caption = 'Statistica ministeriale assenze'
      Hint = 'Statistica ministeriale assenze'
      OnExecute = actExecute
    end
    object actCalcolaContoAnnuale: TAction [142]
      Tag = 583
      Category = 'Elaborazioni'
      Caption = 'Elaborazione conto annuale'
      Hint = 'Elaborazione conto annuale'
      OnExecute = actExecute
    end
    object actStoricoRetribContrattuale: TAction [143]
      Tag = 566
      Category = 'Elaborazioni'
      Caption = 'Storico retribuzione contrattuale'
      OnExecute = actExecute
    end
    object actStampaStoricoRetribContrattuale: TAction [144]
      Tag = 578
      Category = 'Elaborazioni'
      Caption = 'Stampa storico retribuzione contrattuale'
      OnExecute = actExecute
    end
    object actPeriodiPensPrev: TAction [145]
      Tag = 596
      Category = 'Elaborazioni'
      Caption = 'Periodi pensionistici e previdenziali'
      OnExecute = actExecute
    end
    object actPeriodiRetributivi: TAction [146]
      Tag = 597
      Category = 'Elaborazioni'
      Caption = 'Periodi retributivi'
      OnExecute = actExecute
    end
    object actStampaPeriodiRetributivi: TAction [147]
      Tag = 598
      Category = 'Elaborazioni'
      Caption = 'Stampa periodi retributivi'
      OnExecute = actExecute
    end
    object actModelliTFR1: TAction [148]
      Tag = 644
      Category = 'Elaborazioni'
      Caption = 'Modelli TFR 1'
      OnExecute = actExecute
    end
    object actElaborazioneModelliTFR1: TAction [149]
      Tag = 643
      Category = 'Elaborazioni'
      Caption = 'Elaborazione modelli TFR 1'
      OnExecute = actExecute
    end
    object actStampaModelliTFR1: TAction [150]
      Tag = 645
      Category = 'Elaborazioni'
      Caption = 'Stampa modelli TFR 1'
      OnExecute = actExecute
    end
    object actPassaggioAnno: TAction [151]
      Tag = 555
      Category = 'Elaborazioni'
      Caption = 'Passaggio di anno'
      OnExecute = actExecute
    end
    object actCalcoloAddizionaliIRPEF: TAction [152]
      Tag = 581
      Category = 'Elaborazioni'
      Caption = 'Calcolo addizionali IRPEF'
      OnExecute = actExecute
    end
    object actImportazioneVociProgrammate: TAction [153]
      Tag = 600
      Category = 'Elaborazioni'
      Caption = 'Importazione voci programmate'
      OnExecute = actExecute
    end
    object actStoricoGiustificativi: TAction [154]
      Tag = 6
      Category = 'Elaborazioni'
      Caption = 'Storico giustificativi'
      Hint = 'Storico giustificativi'
      OnExecute = actExecute
    end
    object actAssenzeIndividuali: TAction [155]
      Tag = 30
      Category = 'Elaborazioni'
      Caption = 'Elenco assenze individuali'
      Hint = 'Elenco assenze individuali'
      ImageIndex = 28
      OnExecute = actExecute
    end
    object actGeneratoreStampe: TAction [156]
      Tag = 139
      Category = 'Elaborazioni'
      Caption = 'Generatore di stampe'
      Hint = 'Generatore di stampe'
      ImageIndex = 37
      OnExecute = actExecute
    end
    object actElencoStorici: TAction [157]
      Tag = 42
      Category = 'Elaborazioni'
      Caption = 'Elenco movimenti storici'
      Hint = 'Elenco movimenti storici'
      OnExecute = actExecute
    end
    object actInterrogazioniServizio: TAction [158]
      Tag = 31
      Category = 'Elaborazioni'
      Caption = 'Interrogazioni di servizio'
      Hint = 'Interrogazioni di servizio'
      ImageIndex = 18
      OnExecute = actExecute
    end
    inherited actDatiCalcolati: TAction [159]
    end
    object actAcquisizioneFileVoci: TAction [160]
      Tag = 535
      Category = 'Interfacce'
      Caption = 'Acquisizione file voci'
      Hint = 'Acquisizione file voci'
      OnExecute = actExecute
    end
    object actParametriAcquisizione: TAction [161]
      Tag = 536
      Category = 'Interfacce'
      Caption = 'Parametri acquisizione file voci'
      Hint = 'Parametri acquisizione file voci'
      OnExecute = actExecute
    end
    object actRegoleArchiviazioneDoc: TAction [162]
      Tag = 79
      Category = 'Interfacce'
      Caption = 'Regole archivazione documenti'
      Hint = 'Regole archiviazione documenti'
      OnExecute = actExecute
    end
    inherited actElaborazioneFluper: TAction [163]
      Category = 'Elaborazioni'
    end
    inherited actFotoDipendente: TAction [164]
    end
    inherited actInformazioniSu: TAction [165]
    end
    inherited actCheckRimborsi: TAction [166]
    end
  end
  inherited MainMenu: TMainMenu
    inherited Amministrazionesistema1: TMenuItem
      object Ridefinizionecampianagrafici1: TMenuItem [2]
        Action = actRidefinizioneCampiAnagrafici
      end
      object Layoutschedaanagrafica1: TMenuItem
        Action = actLayoutSchedaAnagrafica
      end
    end
    inherited Ambiente1: TMenuItem [2]
      object Ta1: TMenuItem [0]
        Caption = 'Tabelle anagrafiche'
        object Entidiappartenenza1: TMenuItem
          Action = actEntiAppartenenza
        end
        object mnuStatocivile: TMenuItem
          Action = actStatoCivile
        end
        object Nazionalit1: TMenuItem
          Action = actNazionalita
        end
        object Banche1: TMenuItem
          Action = actBanche
        end
        object Modalitdipagamento1: TMenuItem
          Action = actPagamenti
        end
        object N2: TMenuItem
          Caption = '-'
        end
        object abelleANF1: TMenuItem
          Action = actTabelleANF
        end
        object mnuParttime: TMenuItem
          Action = actPartTime
        end
        object CodiciINPS1: TMenuItem
          Action = actCodiciINPS
        end
        object Fondiprevidenzacomplementare1: TMenuItem
          Action = actFPC
        end
      end
      object abellediconfigurazione1: TMenuItem [1]
        Caption = 'Tabelle di configurazione'
        object Configurazionedatiaziendali1: TMenuItem
          Action = actConfigDatiAziendali
        end
        object Configurazionedatieconomici1: TMenuItem
          Action = actConfigDatiEconomici
        end
        object Areecontrattuali1: TMenuItem
          Action = actAreeContrattuali
        end
        object N10: TMenuItem
          Caption = '-'
        end
        object abellevoci1: TMenuItem
          Caption = 'Tabelle voci'
          object Contrattivoci1: TMenuItem
            Action = actContrattiVoci
          end
          object Misurequantit1: TMenuItem
            Action = actMisureQuantita
          end
          object Raggruppamentivoci1: TMenuItem
            Action = actRaggruppamentoVoci
          end
          object CausaliversamentiIrpef1: TMenuItem
            Action = actCausaliIrpef
          end
          object Beneficiari1: TMenuItem
            Action = actBeneficiari
          end
          object N21: TMenuItem
            Caption = '-'
          end
          object Voci1: TMenuItem
            Action = actVoci
          end
          object Alberoassoggettamenti1: TMenuItem
            Action = actAlberoAssoggettamenti
          end
          object N12: TMenuItem
            Caption = '-'
          end
          object Tipoaccorpamentovoci1: TMenuItem
            Action = actTipiAccorpamento
          end
          object Accorpamentivoci1: TMenuItem
            Action = actAccorpamentiVoci
          end
        end
        object Posizioniretributive1: TMenuItem
          Caption = 'Posizioni retributive'
          object Posizionieconomiche1: TMenuItem
            Action = actLivelli
          end
          object Vociaggiuntive1: TMenuItem
            Action = actVociAggiuntive
          end
          object Importivociaggiuntive1: TMenuItem
            Action = actVociAggiuntiveImporti
          end
          object Regolesostituzioniconvenzionati1: TMenuItem
            Action = actRegoleSostituzioniConvenzionati
          end
        end
        object N3: TMenuItem
          Caption = '-'
        end
        object ipiassoggettamenti1: TMenuItem
          Action = actTipiAssoggettamenti
        end
        object abelleaddizionaliRPEF1: TMenuItem
          Action = actEntiIRPEF
        end
        object Valute1: TMenuItem
          Caption = 'Valute'
          object Valute2: TMenuItem
            Action = actValute
          end
          object Arrotondamentivalute1: TMenuItem
            Action = actArrotondamenti
          end
          object Cambivalute1: TMenuItem
            Action = actCambiValute
          end
        end
      end
      object Qualificheministeriali1: TMenuItem [3]
        Action = actQualificheMinisteriali
      end
      object Tipidirapporto1: TMenuItem [4]
        Action = actTipoRapporto
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object PremioINAIL1: TMenuItem
        Caption = 'Premio INAIL'
        object CodiciINAIL1: TMenuItem
          Action = actCodiciINAIL
        end
        object CalcoloParametriINAIL1: TMenuItem
          Action = actCalcoloMinimaleMassimaleINAIL
        end
      end
      object Modello7301: TMenuItem
        Caption = 'Modello 730'
        object CAF1: TMenuItem
          Action = actCAF
        end
        object ipiimporti1: TMenuItem
          Action = actTipoImporti
        end
      end
      object ModelloCUD1: TMenuItem
        Caption = 'Modello CU'
        object RegoleCalcoloCU1: TMenuItem
          Action = actRegoleCalcoloCU
        end
        object InquadramentiINPS1: TMenuItem
          Action = actInquadramentoINPS
        end
        object InquadramentiINPDAP1: TMenuItem
          Action = actInquadramentoINPDAP
        end
        object Entiprevidenziali1: TMenuItem
          Action = actEntiPrevidenziali
        end
      end
      object Modello7701: TMenuItem
        Caption = 'Modello 770'
        object RegoleCalcolo7701: TMenuItem
          Action = actRegoleCalcolo770
          Caption = 'Regole di calcolo del770'
        end
      end
      object Regolefornitureperiodiche1: TMenuItem
        Caption = 'Regole forniture periodiche'
        object RegolefornituraINPSuniEMens1: TMenuItem
          Action = actRegoleFornituraINPSUniEmens
        end
        object RegolefornituraINPDAPDMA1: TMenuItem
          Action = actRegoleINPDAP
        end
        object RelazionitabelleFLUPER1: TMenuItem
          Action = actRelazioniTabelle
        end
        object RegolefornituraFLUPER1: TMenuItem
          Action = actRegoleFLUPER
        end
      end
      object Contabilita1: TMenuItem
        Caption = 'Contabilit'#224
        object Regolecontabilita1: TMenuItem
          Action = actRegoleContabilita
        end
      end
      object Contoannuale2: TMenuItem
        Caption = 'Conto annuale'
        object Relazionitabellecontoannuale1: TMenuItem
          Action = actContoAnnRelTab
        end
        object Regolecontoannuale1: TMenuItem
          Action = actRegoleContoAnnuale
        end
        object Risorseresiduecontoannuale1: TMenuItem
          Action = actRisorseContoAnnuale
        end
      end
      object Fondi1: TMenuItem
        Caption = 'Fondi'
        object Macrocategoriefondi1: TMenuItem
          Action = actMacrocategorieFondi
        end
        object Raggruppamentifondi1: TMenuItem
          Action = actRaggruppamentiFondi
        end
        object Definizionefondi1: TMenuItem
          Action = actDefinizioneFondi
        end
        object Calcolofondi1: TMenuItem
          Action = actCalcoloFondi
        end
        object Monitoraggiofondi1: TMenuItem
          Action = actMonitoraggioFondi
        end
        object Stampafondi1: TMenuItem
          Action = actStampaFondi
        end
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object Causalidiassenza1: TMenuItem
        Caption = 'Causali di assenza'
        object Causalidiassenza2: TMenuItem
          Action = actCausaliAssenza
        end
        object Raggruppamentidiassenza1: TMenuItem
          Action = actRaggrAssenze
        end
        object Accorpamenticausalidiassenza1: TMenuItem
          Action = actAccorpamentiCausali
        end
      end
      object Raggruppamentiinterrogazionidiservizio1: TMenuItem
        Action = actRaggrInterrogazioni
      end
      object Loghiaziendali1: TMenuItem
        Action = actGestioneImmagini
      end
    end
    inherited Personale1: TMenuItem [3]
      object Schedaanagrafica1: TMenuItem [0]
        Action = actSchedaAnagrafica
      end
      object Centridicostopercentualizzati1: TMenuItem [2]
        Action = actCDCPercent
      end
      object Familiari1: TMenuItem [3]
        Action = actFamiliari
      end
      object Datirapportiprecedenti1: TMenuItem [4]
        Action = actDatiRapportiPrecedenti
      end
      object N6: TMenuItem [5]
        Caption = '-'
      end
      object Vociprogrammate1: TMenuItem [6]
        Action = actVociProgrammate
      end
      object Vocivariabili1: TMenuItem [7]
        Action = actVociVariabili
      end
      object N16: TMenuItem [8]
        Caption = '-'
      end
      object Vocidarecuperarerecuperate1: TMenuItem [9]
        Action = actRecuperoVoci
      end
      object Quantitmensili1: TMenuItem [10]
        Action = actQuantitaMensili
      end
      object Sostituzioniconvenzionati1: TMenuItem [11]
        Action = actSostituzioniConvenzionati
      end
      object Giustificativiasspres1: TMenuItem [12]
        Action = actGiustifAssPres
      end
      object N5: TMenuItem [13]
        Caption = '-'
      end
      object Cedolini1: TMenuItem [14]
        Action = actCedolini
      end
      object Datimensili1: TMenuItem [15]
        Action = actDatiMensili
      end
      object Fornitureperiodiche1: TMenuItem [16]
        Caption = 'Forniture periodiche'
        object FornituraINPDAPDMA1: TMenuItem
          Action = actFornituraINPDAP
        end
        object FornituraINPSuniEMens1: TMenuItem
          Action = actFornituraINPS
        end
        object FornituraFLUPER1: TMenuItem
          Action = actFornituraFluper
        end
      end
      object Daticontabilit1: TMenuItem [17]
        Action = actDatiContabilita
        Caption = 'Contabilit'#224
        Hint = 'Contabilit'#224
      end
      object Parcheggiovoci1: TMenuItem [18]
        Action = actParcheggioVoci
      end
      object N14: TMenuItem [19]
        Caption = '-'
      end
      object Redditiannuali1: TMenuItem [20]
        Action = actRedditiAnnuali
      end
      object AddizionaliIRPEF1: TMenuItem [21]
        Action = actAddizionaliIRPEF
      end
      object DatiONAOSI1: TMenuItem [22]
        Action = actDatiONAOSI
      end
      object Modello7302: TMenuItem [23]
        Action = actModello730
      end
      object ModelloCU1: TMenuItem [24]
        Caption = 'Modello CU'
        object ModelliCU1: TMenuItem
          Action = actModelloCU
        end
        object ModelliCUparticolari1: TMenuItem
          Action = actModelliCUparticolari
        end
      end
      object Modello7703: TMenuItem [25]
        Caption = 'Modello 770'
        object Modello7704: TMenuItem
          Action = actModello770
        end
      end
      object Contoannuale3: TMenuItem [26]
        Action = actContoAnnuale
      end
      inherited N26: TMenuItem [27]
      end
      inherited Datadilavoro1: TMenuItem [28]
      end
      inherited Visualizzadipendenticessati1: TMenuItem [29]
      end
    end
    object Elaborazioni1: TMenuItem [4]
      Caption = 'Elaborazioni'
      object Acquisizionequantitmensili1: TMenuItem
        Action = actAcquisizioneQuantitaMensili
      end
      object Controllotettoaccesorie1: TMenuItem
        Action = actControlloTettoAccessorie
      end
      object Premiodioperosit1: TMenuItem
        Caption = 'Premio di operosit'#224
        object Premiodioperosit2: TMenuItem
          Action = actPremioOperosita
        end
        object Premiodioperositmaturato1: TMenuItem
          Action = actPremioOperositaMaturato
        end
      end
      object N19: TMenuItem
        Caption = '-'
      end
      object Cedolinomensile1: TMenuItem
        Caption = 'Cedolino mensile'
        object Elaborazionecedolini1: TMenuItem
          Action = actElaborazioneCedolini
        end
        object Creazionefileverificainadempienze1: TMenuItem
          Action = actFileInadempienze
        end
        object CreazionefileSEPA1: TMenuItem
          Action = actFileSEPA
        end
        object Conguagliretroattivi1: TMenuItem
          Action = actConguagliRetroattivi
        end
        object N20: TMenuItem
          Caption = '-'
        end
        object Calcolotredicesimavirtuale1: TMenuItem
          Action = actCalcoloTredicesimaVirtuale
        end
      end
      object ChiusuraANF1: TMenuItem
        Action = actChiusuraANF
      end
      object RiepiloghimensiliINPS1: TMenuItem
        Action = actRiepilogoMensileInps
      end
      object Fornitureperiodiche2: TMenuItem
        Caption = 'Forniture periodiche'
        object ElaborazionefornituraINPSuniEMens1: TMenuItem
          Action = actINPSCalcolo
        end
        object ElaborazionefornituraF24EP1: TMenuItem
          Action = actElaborazioneF24EP
        end
        object ElaborazionefornitureF24ordinario1: TMenuItem
          Action = actElaborazioneF24Ord
        end
        object ElaborazionefornituraFLUPER1: TMenuItem
          Action = actElaborazioneFluper
        end
        object ElaborazionefornituraPerseo2: TMenuItem
          Action = actElaborazionePerseo
        end
        object N15: TMenuItem
          Caption = '-'
        end
        object ElaborazioneFornituraENPAP1: TMenuItem
          Action = actElaborazioneENPAP
        end
        object ElaborazionefornituraENPAV1: TMenuItem
          Action = actElaborazioneENPAV
        end
        object ElaborazioneFornituraMensileENPAM1: TMenuItem
          Action = actElaborazioneMensileENPAM
        end
        object ElaborazionefornituraannualeENPAM1: TMenuItem
          Action = actElaborazioneENPAM
        end
      end
      object Contabilit1: TMenuItem
        Action = actElaborazioneContab
      end
      object N17: TMenuItem
        Caption = '-'
      end
      object PremioINAIL2: TMenuItem
        Caption = 'Premio INAIL'
        object StampaINAIL1: TMenuItem
          Action = actStampaInail
        end
        object CalcoloritenuteINAILente1: TMenuItem
          Action = actCalcolaINAIL
        end
      end
      object ModelloONAOSI1: TMenuItem
        Caption = 'Modello O.N.A.O.S.I.'
        object ElaborazionemodelloONAOSI1: TMenuItem
          Action = actElaborazioneONAOSI
        end
      end
      object Modello7303: TMenuItem
        Caption = 'Modello 730'
        object Importazionemodelli730dafile1: TMenuItem
          Action = actImportazioneModelli730
        end
        object Impostazionepercentualemodello7301: TMenuItem
          Action = actImpostazionePercRimbLuglio
          Caption = 'Impostazione percentuale rimborso Luglio modello 730'
        end
      end
      object ModelloCU2: TMenuItem
        Caption = 'Modello CU'
        object ElaborazionemodelliCU1: TMenuItem
          Action = actElaborazioneModelliCU
        end
        object StampamodelliCU1: TMenuItem
          Action = actStampaModelliCU
        end
        object ImportazionericevutemodelliCU1: TMenuItem
          Action = actImportazioneRicevuteModelliCU
        end
      end
      object Modello7702: TMenuItem
        Caption = 'Modello 770'
        object Elaborazionemodelli7701: TMenuItem
          Action = actElaborazioneModelli770
        end
      end
      object Contoannuale1: TMenuItem
        Caption = 'Conto annuale'
        object Statisticaministerialeassenze1: TMenuItem
          Action = actStatisticaMinisterialeAssenze
        end
        object Elaborazionecontoannuale1: TMenuItem
          Action = actCalcolaContoAnnuale
        end
      end
      object Storicoretribuzionecontrattuale1: TMenuItem
        Caption = 'Storico retribuzione contrattuale'
        object Storicoretribuzionecontrattuale2: TMenuItem
          Action = actStoricoRetribContrattuale
        end
        object Stampastoricoretribuzionecontrattuale1: TMenuItem
          Action = actStampaStoricoRetribContrattuale
        end
      end
      object Modulopensioni1: TMenuItem
        Caption = 'Modulo pensioni'
        object Periodipensionisticieprevidenziali1: TMenuItem
          Action = actPeriodiPensPrev
        end
        object Periodiretributivi1: TMenuItem
          Action = actPeriodiRetributivi
        end
        object Stampaperiodiretributivi1: TMenuItem
          Action = actStampaPeriodiRetributivi
        end
        object N23: TMenuItem
          Caption = '-'
        end
        object ModelliTFR11: TMenuItem
          Action = actModelliTFR1
        end
        object ElaborazionemodelliTFR11: TMenuItem
          Action = actElaborazioneModelliTFR1
        end
        object StampamodelliTFR11: TMenuItem
          Action = actStampaModelliTFR1
        end
      end
      object N18: TMenuItem
        Caption = '-'
      end
      object Passaggioanno1: TMenuItem
        Action = actPassaggioAnno
      end
      object CalcoloaddizionaliIRPEF1: TMenuItem
        Action = actCalcoloAddizionaliIRPEF
      end
      object Importazionevociprogrammate1: TMenuItem
        Action = actImportazioneVociProgrammate
      end
      object Storicogiustificativi1: TMenuItem
        Action = actStoricoGiustificativi
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object Elencoassenzeindividuali1: TMenuItem
        Action = actAssenzeIndividuali
      end
      object Generatoredistampe1: TMenuItem
        Action = actGeneratoreStampe
      end
      object Elencomovimentistorici1: TMenuItem
        Action = actElencoStorici
      end
      object Interrogazionidiservizio1: TMenuItem
        Action = actInterrogazioniServizio
      end
    end
    inherited Interfacce1: TMenuItem
      object Acquisizionefilevoci1: TMenuItem
        Action = actAcquisizioneFileVoci
      end
      object Parametriacquisizionefilevoci1: TMenuItem
        Action = actParametriAcquisizione
      end
      object N22: TMenuItem
        Caption = '-'
      end
      object Regolearchivazionedocumenti1: TMenuItem
        Action = actRegoleArchiviazioneDoc
      end
    end
  end
end
