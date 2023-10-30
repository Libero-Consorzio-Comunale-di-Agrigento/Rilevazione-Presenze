inherited WC504FMenuStagiuFM: TWC504FMenuStagiuFM
  inherited ActionList: TActionList
    Top = 80
    object actSGStampaCertificati: TAction [0]
      Tag = 308
      Category = 'Elaborazioni'
      Caption = 'Stampa modelli .rtf'
      Hint = 'Stampa modelli .rtf'
      ImageIndex = 100
      OnExecute = actExecute
    end
    inherited actOperatori: TAction [1]
    end
    inherited actAziende: TAction [2]
    end
    inherited actPermessi: TAction [3]
    end
    inherited actFiltroAnagrafe: TAction [4]
    end
    inherited actFiltroFunzioni: TAction [5]
    end
    inherited actFiltroDizionario: TAction [6]
    end
    inherited actLoginDipendenti: TAction [7]
    end
    inherited actAccessi: TAction [8]
    end
    inherited actGestioneSicurezza: TAction [9]
      Category = 'Amministrazione sistema'
    end
    object actRidefinizioneCampiAnagrafici: TAction [10]
      Tag = 115
      Category = 'Amministrazione sistema'
      Caption = 'Ridefinizione campi anagrafici'
      OnExecute = actExecute
    end
    inherited actAllineaStorici: TAction [11]
    end
    inherited actManipolazioneDati: TAction [12]
    end
    inherited actUtilityDB: TAction [13]
    end
    inherited actMsgElaborazioni: TAction [14]
    end
    inherited actDatiLiberi: TAction [15]
    end
    object actLayoutSchedaAnagrafica: TAction [16]
      Tag = 151
      Category = 'Amministrazione sistema'
      Caption = 'Layout scheda anagrafica'
      OnExecute = actExecute
    end
    inherited actMonitoraggioLog: TAction [17]
    end
    inherited actEntiLocali: TAction [18]
    end
    object actQualificheMinisteriali: TAction [19]
      Tag = 191
      Category = 'Ambiente'
      Caption = 'Qualifiche ministeriali'
      Hint = 'Qualifiche ministeriali'
      OnExecute = actExecute
    end
    object actCalendari: TAction [20]
      Tag = 101
      Category = 'Ambiente'
      Caption = 'Calendari'
      Hint = 'Calendari'
      OnExecute = actExecute
    end
    object actPartTime: TAction [21]
      Tag = 144
      Category = 'Tabelle anagrafiche'
      Caption = 'Part-time'
      Hint = 'Part-time'
      OnExecute = actExecute
    end
    object actTipoRapporto: TAction [22]
      Tag = 143
      Category = 'Ambiente'
      Caption = 'Tipi di rapporto'
      Hint = 'Tipi di rapporto'
      OnExecute = actExecute
    end
    object actProfiliAssenzeAnn: TAction [23]
      Tag = 104
      Category = 'Ambiente'
      Caption = 'Profili assenze annuali'
      Hint = 'Profili assenze annuali'
      OnExecute = actExecute
    end
    object actCausaliAssenza: TAction [24]
      Tag = 105
      Category = 'Ambiente'
      Caption = 'Causali di assenza'
      Hint = 'Causali di assenza'
      ImageIndex = 24
      OnExecute = actExecute
    end
    object actRaggrAssenze: TAction [25]
      Tag = 106
      Category = 'Ambiente'
      Caption = 'Raggruppamenti di assenza'
      Hint = 'Raggruppamenti di assenza'
      OnExecute = actExecute
    end
    object actAccorpamentiCausali: TAction [26]
      Tag = 196
      Category = 'Ambiente'
      Caption = 'Accorpamenti causali di assenza'
      Hint = 'Accorpamenti causali di assenza'
      OnExecute = actExecute
    end
    object actCausaliPresenza: TAction [27]
      Tag = 107
      Category = 'Ambiente'
      Caption = 'Causali di presenza'
      Hint = 'Causali di presenza'
      ImageIndex = 25
      OnExecute = actExecute
    end
    object actRaggrPres: TAction [28]
      Tag = 108
      Category = 'Ambiente'
      Caption = 'Raggruppamenti di presenza'
      Hint = 'Raggruppamenti di presenza'
      OnExecute = actExecute
    end
    object actRaggrInterrogazioni: TAction [29]
      Tag = 52
      Category = 'Ambiente'
      Caption = 'Raggruppamenti interrogazioni di servizio'
      Hint = 'Raggruppamenti interrogazioni di servizio'
      OnExecute = actExecute
    end
    object actGiustifAssPres: TAction [30]
      Tag = 2
      Category = 'Personale'
      Caption = 'Giustificativi ass./pres.'
      Hint = 'Giustificativi ass./pres.'
      OnExecute = actExecute
    end
    object actResiduiAnnoPrecedente: TAction [31]
      Tag = 11
      Category = 'Personale'
      Caption = 'Residui anno precedente'
      Hint = 'Residui anno precedente'
      OnExecute = actExecute
    end
    object actCompAsseInd: TAction [32]
      Tag = 4
      Category = 'Ambiente'
      Caption = 'Competenze assenze individuali'
      Hint = 'Competenze assenze individuali'
      OnExecute = actExecute
    end
    object actCalendarioIndividuale: TAction [33]
      Tag = 1
      Category = 'Personale'
      Caption = 'Calendario individuale'
      Hint = 'Calendario individuale'
      OnExecute = actExecute
    end
    object actSchedaAnagrafica: TAction [34]
      Category = 'Personale'
      Caption = 'Scheda anagrafica'
      Hint = 'Scheda anagrafica'
      ImageIndex = 11
      OnExecute = actExecute
    end
    inherited actAnagraficaStipendi: TAction [35]
    end
    object actCdcPercent: TAction [36]
      Tag = 162
      Category = 'Personale'
      Caption = 'Centri di costo percentualizzati'
      Hint = 'Centri di costo percentualizzati'
      ImageIndex = 12
      OnExecute = actExecute
    end
    object actFamiliari: TAction [37]
      Tag = 303
      Category = 'Personale'
      Caption = 'Familiari'
      Hint = 'Familiari'
      ImageIndex = 23
      OnExecute = actExecute
    end
    object actSGProvvedimenti: TAction [38]
      Tag = 304
      Category = 'Personale'
      Caption = 'Gestione provvedimenti'
      Hint = 'Gestione provvedimenti'
      OnExecute = actExecute
    end
    inherited actTabelleDatiLiberi: TAction [39]
    end
    inherited actRelazioni: TAction [40]
    end
    object actInserimentoGiust: TAction [41]
      Tag = 47
      Category = 'Elaborazioni'
      Caption = 'Inserimento giustificativi collettivi'
      Hint = 'Inserimento giustificativi collettivi'
      OnExecute = actExecute
    end
    object actAssenzeIndividuali: TAction [42]
      Tag = 30
      Category = 'Elaborazioni'
      Caption = 'Elenco assenze individuali'
      Hint = 'Elenco assenze individuali'
      ImageIndex = 28
      OnExecute = actExecute
    end
    object actSchedaAnnualeAssenze: TAction [43]
      Tag = 41
      Category = 'Elaborazioni'
      Caption = 'Scheda annuale assenze'
      Hint = 'Scheda annuale assenze'
      OnExecute = actExecute
    end
    object actStoricoGiustificativi: TAction [44]
      Tag = 6
      Category = 'Elaborazioni'
      Caption = 'Storico giustificativi'
      Hint = 'Storico giustificativi'
      OnExecute = actExecute
    end
    object actStatisticaMinisterialeAssenze: TAction [45]
      Tag = 595
      Category = 'Elaborazioni'
      Caption = 'Statistica ministeriale assenze'
      Hint = 'Statistica ministeriale assenze'
      OnExecute = actExecute
    end
    object actGeneratoreStampe: TAction [46]
      Tag = 139
      Category = 'Elaborazioni'
      Caption = 'Generatore di stampe'
      Hint = 'Generatore di stampe'
      ImageIndex = 37
      OnExecute = actExecute
    end
    object actElencoStorici: TAction [47]
      Tag = 42
      Category = 'Elaborazioni'
      Caption = 'Elenco movimenti storici'
      Hint = 'Elenco movimenti storici'
      OnExecute = actExecute
    end
    object actInterrogazioniServizio: TAction [48]
      Tag = 31
      Category = 'Elaborazioni'
      Caption = 'Interrogazioni di servizio'
      Hint = 'Interrogazioni di servizio'
      ImageIndex = 18
      OnExecute = actExecute
    end
    object actPassaggioAnno: TAction [49]
      Tag = 37
      Category = 'Elaborazioni'
      Caption = 'Passaggio di anno'
      Hint = 'Passaggio di anno'
      OnExecute = actExecute
    end
    object actEstremiStruttura: TAction [50]
      Tag = 322
      Category = 'Pianta organica'
      Caption = 'Estremi struttura/atti'
      OnExecute = actExecute
    end
    inherited actElaborazioneFluper: TAction [51]
    end
    object actRelazioniTabelle: TAction [52]
      Tag = 299
      Category = 'Flussi statistici'
      Caption = 'Relazioni tabelle FLUPER'
      OnExecute = actExecute
    end
    object actRegoleFluper: TAction [53]
      Tag = 571
      Category = 'Flussi statistici'
      Caption = 'Regole fornitura FLUPER'
      OnExecute = actExecute
    end
    object actFornituraFluper: TAction [54]
      Tag = 572
      Category = 'Flussi statistici'
      Caption = 'Fornitura FLUPER'
      OnExecute = actExecute
    end
    object actContoAnnRegole: TAction [55]
      Tag = 580
      Category = 'Conto annuale'
      Caption = 'Regole conto annuale'
      Hint = 'Regole conto annuale'
      OnExecute = actExecute
    end
    object actCalcolaContoAnnuale: TAction [56]
      Tag = 583
      Category = 'Conto annuale'
      Caption = 'Elaborazione conto annuale'
      Hint = 'Elaborazione conto annuale'
      OnExecute = actExecute
    end
    object actContoAnnuale: TAction [57]
      Tag = 582
      Category = 'Conto annuale'
      Caption = 'Conto annuale'
      Hint = 'Conto annuale'
      OnExecute = actExecute
    end
    object actContoAnnRisRes: TAction [58]
      Tag = 584
      Category = 'Conto annuale'
      Caption = 'Risorse residue conto annuale'
      Hint = 'Risorse residue conto annuale'
      OnExecute = actExecute
    end
    object actAssenteismo: TAction [59]
      Tag = 197
      Category = 'Conto annuale'
      Caption = 'Assenteismo e Forza Lavoro'
      Hint = 'Assenteismo e Forza Lavoro'
      OnExecute = actExecute
    end
    object actTipologieRischi: TAction [60]
      Tag = 326
      Category = 'Modulo Rischi e prescrizioni'
      Caption = 'Tipologie rischi e visite'
      Hint = 'Tipologie rischi e visite'
      OnExecute = actExecute
    end
    object actTipologiePrescrizioni: TAction [61]
      Tag = 330
      Category = 'Modulo Rischi e prescrizioni'
      Caption = 'Tipologie prescrizioni'
      Hint = 'Tipologie prescrizioni'
      OnExecute = actExecute
    end
    object actTipologieAttivita: TAction [62]
      Tag = 348
      Category = 'Modulo Rischi e prescrizioni'
      Caption = 'Tipologie attivit'#224
      Hint = 'Tipologie attivit'#224
      OnExecute = actExecute
    end
    object actTipologieEsposizione: TAction [63]
      Tag = 349
      Category = 'Modulo Rischi e prescrizioni'
      Caption = 'Tipologie esposizioni'
      Hint = 'Tipologie esposizioni'
      OnExecute = actExecute
    end
    object actCessazioniRischi: TAction [64]
      Tag = 327
      Category = 'Modulo Rischi e prescrizioni'
      Caption = 'Motivazioni cessazione rischi'
      Hint = 'Motivazioni cessazione rischi'
      OnExecute = actExecute
    end
    object actGestioneRischi: TAction [65]
      Tag = 328
      Category = 'Modulo Rischi e prescrizioni'
      Caption = 'Gestione rischi e prescrizioni'
      Hint = 'Gestione rischi e prescrizioni'
      OnExecute = actExecute
    end
    object actStampaRischi: TAction [66]
      Tag = 331
      Category = 'Modulo Rischi e prescrizioni'
      Caption = 'Stampa periodi rischio'
      Hint = 'Stampa periodi rischio'
      OnExecute = actExecute
    end
    object actRegoleValutazioni: TAction [67]
      Tag = 350
      Category = 'Modulo Valutazioni'
      Caption = 'Regole valutazioni'
      OnExecute = actExecute
    end
    object actStatiAvanzamento: TAction [68]
      Tag = 354
      Category = 'Modulo Valutazioni'
      Caption = 'Stati avanzamento valutazioni'
      OnExecute = actExecute
    end
    object actAreeValutazioni: TAction [69]
      Tag = 342
      Category = 'Modulo Valutazioni'
      Caption = 'Aree ed elementi di valutazione'
      OnExecute = actExecute
    end
    object actProfiliAree: TAction [70]
      Tag = 345
      Category = 'Modulo Valutazioni'
      Caption = 'Profili valutazioni'
      OnExecute = actExecute
    end
    object actFScaglioniIncentivi: TAction [71]
      Tag = 353
      Category = 'Modulo Incentivi'
      Caption = 'Scaglioni valutazioni per incentivi'
      OnExecute = actExecute
    end
    object actPunteggiValutazioni: TAction [72]
      Tag = 340
      Category = 'Modulo Valutazioni'
      Caption = 'Punteggi valutazioni'
      OnExecute = actExecute
    end
    object actParProtocollo: TAction [73]
      Tag = 355
      Category = 'Modulo Valutazioni'
      Caption = 'Parametrizzazione protocollazione'
      OnExecute = actExecute
    end
    object actStampaValutazioni: TAction [74]
      Tag = 347
      Category = 'Modulo Valutazioni'
      Caption = 'Elaborazione schede di valutazione'
      OnExecute = actExecute
    end
    inherited actInformazioniSu: TAction [75]
    end
    inherited actFiltroCessati: TAction [76]
    end
    inherited actDatiCalcolati: TAction [77]
    end
    inherited actDataLavoro: TAction [78]
    end
    inherited actCheckRimborsi: TAction [79]
    end
    inherited actProfiloIterAutorizzativi: TAction [80]
    end
    object actTipoDocumenti: TAction
      Tag = 317
      Category = 'Ambiente'
      Caption = 'Tipologie documenti'
      Hint = 'Tipologie documenti'
      OnExecute = actExecute
    end
    object actMotivazioniProvvedimento: TAction
      Tag = 301
      Category = 'Ambiente'
      Caption = 'Motivazioni provvedimento'
      Hint = 'Motivazioni provvedimento'
      OnExecute = actExecute
    end
    object actTipoEsperienze: TAction
      Tag = 319
      Category = 'Ambiente'
      Caption = 'Tipologie esperienze'
      Hint = 'Tipologie esperienze'
      OnExecute = actExecute
    end
    object actDettaglioEsperienze: TAction
      Tag = 320
      Category = 'Ambiente'
      Caption = 'Dettaglio esperienze'
      Hint = 'Dettaglio esperienze'
      OnExecute = actExecute
    end
    object actDefinizioneVariabili: TAction
      Tag = 302
      Category = 'Ambiente'
      Caption = 'Definizione variabili'
      Hint = 'Definizione variabili'
      OnExecute = actExecute
    end
    object actCategorieIncarichi: TAction
      Tag = 333
      Category = 'Incarichi'
      Caption = 'Categorie incarichi'
      Hint = 'Categorie incarichi'
      OnExecute = actExecute
    end
    object actTipiIncarichi: TAction
      Tag = 334
      Category = 'Incarichi'
      Caption = 'Tipi incarichi'
      Hint = 'Tipi incarichi'
      OnExecute = actExecute
    end
    object actIncarichiAziendali: TAction
      Tag = 335
      Category = 'Incarichi'
      Caption = 'Incarichi aziendali'
      Hint = 'Incarichi aziendali'
      OnExecute = actExecute
    end
    object actTipiVerifiche: TAction
      Tag = 351
      Category = 'Incarichi'
      Caption = 'Tipologie verifiche'
      Hint = 'Tipologie verifiche'
      OnExecute = actExecute
    end
    object actCommissioni: TAction
      Tag = 336
      Category = 'Incarichi'
      Caption = 'Commissioni'
      Hint = 'Commissioni'
      OnExecute = actExecute
    end
    object actComponentiCommissioni: TAction
      Tag = 337
      Category = 'Incarichi'
      Caption = 'Componenti delle commissioni'
      Hint = 'Componenti delle commissioni'
      OnExecute = actExecute
    end
    object actGestioneIncarichi: TAction
      Tag = 338
      Category = 'Incarichi'
      Caption = 'Gestione incarichi'
      Hint = 'Gestione incarichi'
      OnExecute = actExecute
    end
    object actVerificheIndennita: TAction
      Tag = 352
      Category = 'Incarichi'
      Caption = 'Verifiche indennit'#224
      Hint = 'Verifiche indennit'#224
      OnExecute = actExecute
    end
    object actAllineamentoIncarichi: TAction
      Tag = 346
      Category = 'Incarichi'
      Caption = 'Allineamento incarichi'
      Hint = 'Allineamento incarichi'
      OnExecute = actExecute
    end
    object actContoAnnRelTab: TAction
      Tag = 647
      Category = 'Conto annuale'
      Caption = 'Relazioni tabelle conto annuale'
      Hint = 'Relazioni tabelle conto annuale'
      OnExecute = actExecute
    end
    object actRiepilogoIncarichi: TAction
      Tag = 339
      Category = 'Incarichi'
      Caption = 'Riepilogo incarichi'
      Hint = 'Riepilogo incarichi'
      OnExecute = actExecute
    end
    object actGestioneDocumentale: TAction
      Tag = 76
      Category = 'Modulo Gestione documentale'
      Caption = 'Gestione documentale'
      Hint = 'Gestione documentale'
      OnExecute = actExecute
    end
    object actRicercaDocumentale: TAction
      Tag = 77
      Category = 'Modulo Gestione documentale'
      Caption = 'Ricerca documentale'
      Hint = 'Ricerca documentale'
      OnExecute = actExecute
    end
    object actImportazioneMassivaDocumenti: TAction
      Tag = 154
      Category = 'Modulo Gestione documentale'
      Caption = 'Importazione massiva documenti'
      Hint = 'Importazione massiva documenti'
      OnExecute = actExecute
    end
    object actSituazioneOrganico: TAction
      Tag = 312
      Category = 'Pianta organica'
      Caption = 'Distribuzione organico'
      OnExecute = actExecute
    end
    object actVisualizzazionePianta: TAction
      Tag = 323
      Category = 'Pianta organica'
      Caption = 'Visualizzazione pianta organica'
      OnExecute = actExecute
    end
    object actStampaSituazioneOrganico: TAction
      Tag = 313
      Category = 'Pianta organica'
      Caption = 'Stampa situazione organico'
      OnExecute = actExecute
    end
    object actGestioneOrdiniProf: TAction
      Tag = 356
      Category = 'Modulo Gestione documentale'
      Caption = 'Gestione Ordini professionali'
      Hint = 'Gestione Ordini professionali'
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
      object Qualificheministeriali1: TMenuItem
        Action = actQualificheMinisteriali
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Calendari1: TMenuItem
        Action = actCalendari
      end
      object Parttime1: TMenuItem
        Action = actPartTime
      end
      object ipidirapporto1: TMenuItem
        Action = actTipoRapporto
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object ipologiedocumenti1: TMenuItem
        Action = actTipoDocumenti
      end
      object Motivazioniprovvedimento1: TMenuItem
        Action = actMotivazioniProvvedimento
      end
      object Curriculum1: TMenuItem
        Caption = 'Curriculum'
        object ipologieesperienze1: TMenuItem
          Action = actTipoEsperienze
        end
        object Dettaglioesperienze1: TMenuItem
          Action = actDettaglioEsperienze
        end
      end
      object Certificazione1: TMenuItem
        Caption = 'Certificazione'
        object Definizionedatiliberi2: TMenuItem
          Action = actDefinizioneVariabili
        end
      end
      object Incarichi2: TMenuItem
        Caption = 'Incarichi'
        object actCategorieIncarichi1: TMenuItem
          Action = actCategorieIncarichi
        end
        object ipiincarichi1: TMenuItem
          Action = actTipiIncarichi
        end
        object Incarichiaziendali1: TMenuItem
          Action = actIncarichiAziendali
        end
        object Allineamentoincarichi1: TMenuItem
          Action = actAllineamentoIncarichi
        end
        object N18: TMenuItem
          Caption = '-'
        end
        object ipologieverifiche1: TMenuItem
          Action = actTipiVerifiche
        end
        object Commissioni1: TMenuItem
          Action = actCommissioni
        end
        object Componentidellecommissioni1: TMenuItem
          Action = actComponentiCommissioni
        end
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object Profiliassenzeannuali1: TMenuItem
        Action = actProfiliAssenzeAnn
      end
      object Causali1: TMenuItem
        Caption = 'Causali'
        object Causalidiassenza1: TMenuItem
          Action = actCausaliAssenza
        end
        object Raggruppamentidiassenza1: TMenuItem
          Action = actRaggrAssenze
        end
        object Accorpamenticausalidiassenza1: TMenuItem
          Action = actAccorpamentiCausali
        end
        object N16: TMenuItem
          Caption = '-'
        end
        object Causalidipresenza1: TMenuItem
          Action = actCausaliPresenza
        end
        object Raggruppamentidipresenza1: TMenuItem
          Action = actRaggrPres
        end
      end
      object Raggruppamentiinterrogazionidiservizio1: TMenuItem
        Action = actRaggrInterrogazioni
      end
    end
    inherited Personale1: TMenuItem [3]
      object Giustificativiasspres1: TMenuItem [0]
        Action = actGiustifAssPres
      end
      object Residuiannoprecedente1: TMenuItem [1]
        Action = actResiduiAnnoPrecedente
      end
      object Competenzeassenzeindividuali1: TMenuItem [2]
        Action = actCompAsseInd
      end
      object Calendarioindividuale1: TMenuItem [3]
        Action = actCalendarioIndividuale
      end
      object N6: TMenuItem [4]
        Caption = '-'
      end
      object Schedaanagrafica1: TMenuItem [5]
        Action = actSchedaAnagrafica
      end
      object Centridicostopercentualizzati1: TMenuItem [7]
        Action = actCdcPercent
      end
      object N7: TMenuItem [8]
        Caption = '-'
      end
      object Familiari1: TMenuItem [9]
        Action = actFamiliari
      end
      object N10: TMenuItem [10]
        Caption = '-'
      end
      object Gestioneprovvedimenti1: TMenuItem [11]
        Action = actSGProvvedimenti
      end
      object Incarichi1: TMenuItem [12]
        Caption = 'Incarichi'
        object Gestioneincarichi1: TMenuItem
          Action = actGestioneIncarichi
        end
        object Riepilogoincarichi1: TMenuItem
          Action = actRiepilogoIncarichi
        end
        object N19: TMenuItem
          Caption = '-'
        end
        object Verificheindennita1: TMenuItem
          Action = actVerificheIndennita
        end
      end
      object N11: TMenuItem [13]
        Caption = '-'
      end
    end
    object Elaborazioni1: TMenuItem [4]
      Caption = 'Elaborazioni'
      object Stampamodellirtf1: TMenuItem
        Action = actSGStampaCertificati
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object Inserimentogiustificativicollettivi1: TMenuItem
        Action = actInserimentoGiust
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object Elencoassenzeindividuali1: TMenuItem
        Action = actAssenzeIndividuali
      end
      object Schedaannualeassenze1: TMenuItem
        Action = actSchedaAnnualeAssenze
      end
      object Storicogiustificativi1: TMenuItem
        Action = actStoricoGiustificativi
      end
      object Statisticaministerialeassenze1: TMenuItem
        Action = actStatisticaMinisterialeAssenze
      end
      object Generatoredistampe1: TMenuItem
        Action = actGeneratoreStampe
      end
      object Elencomovimentistorici1: TMenuItem
        Action = actElencoStorici
      end
      object N14: TMenuItem
        Caption = '-'
      end
      object Interrogazionidiservizio1: TMenuItem
        Action = actInterrogazioniServizio
      end
      object N15: TMenuItem
        Caption = '-'
      end
      object Passaggiodianno1: TMenuItem
        Action = actPassaggioAnno
      end
    end
    inherited Moduliaccessori1: TMenuItem
      object Piantaorganica1: TMenuItem
        Caption = 'Pianta organica'
        object Estremistrutturaatti1: TMenuItem
          Action = actEstremiStruttura
        end
        object Distribuzioneorganico1: TMenuItem
          Action = actSituazioneOrganico
        end
        object Visualizzazionepiantaorganica1: TMenuItem
          Action = actVisualizzazionePianta
        end
        object Stampasituazioneorganico1: TMenuItem
          Action = actStampaSituazioneOrganico
        end
      end
      object Flussistatistici1: TMenuItem
        Caption = 'Flussi statistici'
        object RelazionitabelleFLUPER1: TMenuItem
          Action = actRelazioniTabelle
        end
        object RegolefornituraFLUPER1: TMenuItem
          Action = actRegoleFluper
        end
        object ElaborazionefornituraFLUPER1: TMenuItem
          Action = actElaborazioneFluper
        end
        object FornituraFLUPER1: TMenuItem
          Action = actFornituraFluper
        end
      end
      object Contoannuale1: TMenuItem
        Caption = 'Conto annuale'
        object Relazionitabellecontoannuale1: TMenuItem
          Action = actContoAnnRelTab
        end
        object Regolecontoannuale1: TMenuItem
          Action = actContoAnnRegole
        end
        object Elaborazionecontoannuale1: TMenuItem
          Action = actCalcolaContoAnnuale
        end
        object Contoannuale2: TMenuItem
          Action = actContoAnnuale
        end
        object Risorseresiduecontoannuale1: TMenuItem
          Action = actContoAnnRisRes
        end
        object N17: TMenuItem
          Caption = '-'
        end
        object AssenteismoeForzaLavoro1: TMenuItem
          Action = actAssenteismo
        end
      end
      object Rischieprescrizioni1: TMenuItem
        Caption = 'Rischi e prescrizioni'
        object Tipologierischievisite1: TMenuItem
          Action = actTipologieRischi
        end
        object Tipologieprescrizioni1: TMenuItem
          Action = actTipologiePrescrizioni
        end
        object Tipologieattivit1: TMenuItem
          Action = actTipologieAttivita
        end
        object Tipologieesposizioni1: TMenuItem
          Action = actTipologieEsposizione
        end
        object Motivazionicessazionerischi1: TMenuItem
          Action = actCessazioniRischi
        end
        object Gestionerischieprescrizioni1: TMenuItem
          Action = actGestioneRischi
        end
        object Stampaperiodirischio1: TMenuItem
          Action = actStampaRischi
        end
      end
      object Valutazioni1: TMenuItem
        Caption = 'Valutazioni'
        object Regolevalutazioni1: TMenuItem
          Action = actRegoleValutazioni
        end
        object Statiavanzamentovalutazioni1: TMenuItem
          Action = actStatiAvanzamento
        end
        object Areeedelementidivalutazione1: TMenuItem
          Action = actAreeValutazioni
        end
        object Profilivalutazioni1: TMenuItem
          Action = actProfiliAree
        end
        object Punteggivalutazioni1: TMenuItem
          Action = actPunteggiValutazioni
        end
        object Scaglionivalutazioniperincentivi1: TMenuItem
          Action = actFScaglioniIncentivi
        end
        object Parametrizzazioneprotocollazione1: TMenuItem
          Action = actParProtocollo
        end
        object Elaborazioneschededivalutazione1: TMenuItem
          Action = actStampaValutazioni
        end
      end
      object Gestionedocumentale1: TMenuItem
        Caption = 'Gestione documentale'
        object Gestionedocumentale2: TMenuItem
          Tag = 76
          Action = actGestioneDocumentale
        end
        object Ricercadocumentale1: TMenuItem
          Tag = 77
          Action = actRicercaDocumentale
        end
        object Importazionemassivadocumenti1: TMenuItem
          Tag = 154
          Action = actImportazioneMassivaDocumenti
        end
        object GestioneOrdiniprofessionali1: TMenuItem
          Tag = 356
          Action = actGestioneOrdiniProf
          OnClick = actExecute
        end
      end
    end
  end
end
