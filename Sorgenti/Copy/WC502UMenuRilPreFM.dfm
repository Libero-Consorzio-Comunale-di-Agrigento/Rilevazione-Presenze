inherited WC502FMenuRilPreFM: TWC502FMenuRilPreFM
  Height = 299
  ExplicitHeight = 299
  inherited IWFrameRegion: TIWRegion
    Height = 299
    ExplicitHeight = 299
  end
  inherited ActionList: TActionList
    object actGestioneBudget: TAction [0]
      Tag = 132
      Category = 'Modulo Budget straordinario'
      Caption = 'Gestione del budget'
      Hint = 'Gestione del budget'
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
      Tag = 152
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
    inherited actUtilityDB: TAction [12]
    end
    inherited actMonitoraggioLog: TAction [13]
    end
    inherited actMsgElaborazioni: TAction [14]
    end
    inherited actDatiLiberi: TAction [15]
    end
    object actInserimentoRiposi: TAction [16]
      Tag = 17
      Category = 'Elaborazioni'
      Caption = 'Inserimento automatico riposi'
      Hint = 'Inserimento automatico riposi'
      ImageIndex = 21
      OnExecute = actExecute
    end
    object actInserimentoGiust: TAction [17]
      Tag = 47
      Category = 'Elaborazioni'
      Caption = 'Inserimento giustificativi collettivi'
      Hint = 'Inserimento giustificativi collettivi'
      OnExecute = actExecute
    end
    object actCaricaGiustRich: TAction [18]
      Tag = 96
      Category = 'Elaborazioni'
      Caption = 'Carica giustificativi richiesti'
      Hint = 'Carica giustificativi richiesti'
      OnExecute = actExecute
    end
    object actElaboraOmesseTimbrature: TAction [19]
      Tag = 95
      Category = 'Elaborazioni'
      Caption = 'Elabora omesse timbrature'
      Hint = 'Elabora omesse timbrature'
      OnExecute = actExecute
    end
    object actStampaAnomalie: TAction [20]
      Tag = 12
      Category = 'Elaborazioni'
      Caption = 'Stampa anomalie'
      Hint = 'Stampa anomalie'
      OnExecute = actExecute
    end
    object actCarMen: TAction [21]
      Tag = 9
      Category = 'Elaborazioni'
      Caption = 'Cartellino mensile'
      Hint = 'Cartellino mensile'
      ImageIndex = 8
      OnExecute = actExecute
    end
    object actSicurezzaRiepiloghi: TAction [22]
      Tag = 59
      Category = 'Elaborazioni'
      Caption = 'Sicurezza riepiloghi'
      Hint = 'Sicurezza riepiloghi'
      OnExecute = actExecute
    end
    object actLiqOreCau: TAction [23]
      Tag = 48
      Category = 'Elaborazioni'
      Caption = 'Liquidazione ore causalizzate'
      Hint = 'Liquidazione ore causalizzate'
      ImageIndex = 30
      OnExecute = actExecute
    end
    object actLiqOreAnniPrec: TAction [24]
      Tag = 169
      Category = 'Elaborazioni'
      Caption = 'Liquidazione ore anni precedenti'
      Hint = 'Liquidazione ore anni precedenti'
      OnExecute = actExecute
    end
    object actImportazioneAssestamentoOre: TAction [25]
      Tag = 208
      Category = 'Elaborazioni'
      Caption = 'Importazione ore liquidate e di assestamento'
      Hint = 'Importazione ore liquidate e di assestamento'
      OnExecute = actExecute
    end
    object actInserimentoAutomaticoAssenze: TAction [26]
      Tag = 38
      Category = 'Elaborazioni'
      Caption = 'Inserimento automatico assenze'
      Hint = 'Inserimento automatico assenze'
      OnExecute = actExecute
    end
    object actCompensazioneAutomatica: TAction [27]
      Tag = 54
      Category = 'Elaborazioni'
      Caption = 'Compensazione giornaliera automatica'
      Hint = 'Compensazione giornaliera automatica'
      OnExecute = actExecute
    end
    object actPassaggioAnno: TAction [28]
      Tag = 37
      Category = 'Elaborazioni'
      Caption = 'Passaggio di anno'
      Hint = 'Passaggio di anno'
      OnExecute = actExecute
    end
    object actStoricoGiustificativi: TAction [29]
      Tag = 6
      Category = 'Elaborazioni'
      Caption = 'Storico giustificativi'
      Hint = 'Storico giustificativi'
      OnExecute = actExecute
    end
    object actElencoPresentiAssenti: TAction [30]
      Tag = 18
      Category = 'Elaborazioni'
      Caption = 'Stampe analitiche presenze/assenze'
      Hint = 'Stampe analitiche presenze/assenze'
      ImageIndex = 36
      OnExecute = actExecute
    end
    object actAssenzeIndividuali: TAction [31]
      Tag = 30
      Category = 'Elaborazioni'
      Caption = 'Elenco assenze individuali'
      Hint = 'Elenco assenze individuali'
      ImageIndex = 28
      OnExecute = actExecute
    end
    object actPrenotazionePasti: TAction [32]
      Tag = 141
      Category = 'Elaborazioni'
      Caption = 'Elenco timbrature causalizzate'
      Hint = 'Elenco timbrature causalizzate'
      OnExecute = actExecute
    end
    object actSchedaAnnualeAssenze: TAction [33]
      Tag = 41
      Category = 'Elaborazioni'
      Caption = 'Scheda annuale assenze'
      Hint = 'Scheda annuale assenze'
      OnExecute = actExecute
    end
    object actStatisticaMinisterialeAssenze: TAction [34]
      Tag = 595
      Category = 'Elaborazioni'
      Caption = 'Statistica ministeriale assenze'
      Hint = 'Statistica ministeriale assenze'
      OnExecute = actExecute
    end
    object actGeneratoreStampe: TAction [35]
      Tag = 139
      Category = 'Elaborazioni'
      Caption = 'Generatore di stampe'
      Hint = 'Generatore di stampe'
      ImageIndex = 37
      OnExecute = actExecute
    end
    object actElencoStorici: TAction [36]
      Tag = 42
      Category = 'Elaborazioni'
      Caption = 'Elenco movimenti storici'
      Hint = 'Elenco movimenti storici'
      OnExecute = actExecute
    end
    object actStampaTimbratureOriginali: TAction [37]
      Tag = 26
      Category = 'Elaborazioni'
      Caption = 'Stampa timbrature originali'
      Hint = 'Stampa timbrature originali'
      OnExecute = actExecute
    end
    object actInterrogazioniServizio: TAction [38]
      Tag = 31
      Category = 'Elaborazioni'
      Caption = 'Interrogazioni di servizio'
      Hint = 'Interrogazioni di servizio'
      ImageIndex = 18
      OnExecute = actExecute
    end
    object actCartellino: TAction [39]
      Tag = 7
      Category = 'Personale'
      Caption = 'Cartellino interattivo'
      Hint = 'Cartellino interattivo'
      ImageIndex = 34
      OnExecute = actExecute
    end
    object actGiustifAssPres: TAction [40]
      Tag = 2
      Category = 'Personale'
      Caption = 'Giustificativi ass./pres.'
      Hint = 'Giustificativi ass./pres.'
      OnExecute = actExecute
    end
    object actPianificazione: TAction [41]
      Tag = 8
      Category = 'Personale'
      Caption = 'Pianificazioni giornaliere'
      Hint = 'Pianificazioni giornaliere'
      OnExecute = actExecute
    end
    object actSchedaAnagrafica: TAction [42]
      Category = 'Personale'
      Caption = 'Scheda anagrafica'
      Hint = 'Scheda anagrafica'
      ImageIndex = 11
      OnExecute = actExecute
    end
    object actCdcPercent: TAction [43]
      Tag = 162
      Category = 'Personale'
      Caption = 'Centri di costo percentualizzati'
      Hint = 'Centri di costo percentualizzati'
      ImageIndex = 12
      OnExecute = actExecute
    end
    object actSchedaRiepilogativa: TAction [44]
      Tag = 10
      Category = 'Personale'
      Caption = 'Scheda riepilogativa'
      Hint = 'Scheda riepilogativa'
      ImageIndex = 22
      OnExecute = actExecute
    end
    object actResiduiAnnoPrecedente: TAction [45]
      Tag = 11
      Category = 'Personale'
      Caption = 'Residui anno precedente'
      Hint = 'Residui anno precedente'
      OnExecute = actExecute
    end
    object actOreLiquidateAnniPrec: TAction [46]
      Tag = 168
      Category = 'Personale'
      Caption = 'Assestamento ore anni precedenti'
      Hint = 'Assestamento ore anni precedenti'
      OnExecute = actExecute
    end
    object actCompAsseInd: TAction [47]
      Tag = 4
      Category = 'Personale'
      Caption = 'Competenze assenze individuali'
      Hint = 'Competenze assenze individuali'
      OnExecute = actExecute
    end
    object actCalendarioIndividuale: TAction [48]
      Tag = 1
      Category = 'Personale'
      Caption = 'Calendario individuale'
      Hint = 'Calendario individuale'
      OnExecute = actExecute
    end
    object actPlusOrarioIndividuale: TAction [49]
      Tag = 3
      Category = 'Personale'
      Caption = 'Debiti aggiuntivi individuali'
      Hint = 'Debiti aggiuntivi individuali'
      OnExecute = actExecute
    end
    object actFamiliari: TAction [50]
      Tag = 303
      Category = 'Personale'
      Caption = 'Familiari'
      Hint = 'Familiari'
      ImageIndex = 23
      OnExecute = actExecute
    end
    object actSGProvvedimenti: TAction [51]
      Tag = 304
      Category = 'Personale'
      Caption = 'Gestione provvedimenti'
      Hint = 'Gestione provvedimenti'
      OnExecute = actExecute
    end
    inherited actDataLavoro: TAction [52]
    end
    inherited actFiltroCessati: TAction [53]
    end
    inherited actTabelleDatiLiberi: TAction [54]
    end
    inherited actRelazioni: TAction [55]
    end
    object actLayoutSchedaAnagrafica: TAction [56]
      Tag = 151
      Category = 'Amministrazione sistema'
      Caption = 'Layout scheda anagrafica'
      OnExecute = actExecute
    end
    inherited actEntiLocali: TAction [57]
    end
    inherited actManipolazioneDati: TAction [58]
    end
    inherited actProfiloIterAutorizzativi: TAction [59]
    end
    object actDebitiAggiuntivi: TAction [61]
      Tag = 102
      Category = 'Ambiente'
      Caption = 'Debiti aggiuntivi'
      Hint = 'Debiti aggiuntivi'
      OnExecute = actExecute
    end
    object actQualificheMinisteriali: TAction [62]
      Tag = 191
      Category = 'Ambiente'
      Caption = 'Qualifiche ministeriali'
      Hint = 'Qualifiche ministeriali'
      OnExecute = actExecute
    end
    object actIndPresenza: TAction [63]
      Tag = 112
      Category = 'Ambiente'
      Caption = 'Indennit'#224' di presenza'
      Hint = 'Indennit'#224' di presenza'
      OnExecute = actExecute
    end
    object actRegIndPresenza: TAction [64]
      Tag = 117
      Category = 'Ambiente'
      Caption = 'Regole indennit'#224' presenza'
      Hint = 'Regole indennit'#224' presenza'
      OnExecute = actExecute
    end
    object actIndennitaGruppi: TAction [65]
      Tag = 138
      Category = 'Ambiente'
      Caption = 'Indennit'#224' di presenza associate'
      Hint = 'Indennit'#224' di presenza associate'
      OnExecute = actExecute
    end
    object actModelliOrario: TAction [66]
      Tag = 103
      Category = 'Ambiente'
      Caption = 'Modelli orario'
      Hint = 'Modelli orario'
      ImageIndex = 27
      OnExecute = actExecute
    end
    object actProfiliOrari: TAction [67]
      Tag = 113
      Category = 'Ambiente'
      Caption = 'Profili orario'
      Hint = 'Profili orario'
      ImageIndex = 9
      OnExecute = actExecute
    end
    object actTipologieCartellini: TAction [68]
      Tag = 142
      Category = 'Ambiente'
      Caption = 'Tipologie cartellini'
      Hint = 'Tipologie cartellini'
      OnExecute = actExecute
    end
    object actCalendari: TAction [69]
      Tag = 101
      Category = 'Ambiente'
      Caption = 'Calendari'
      Hint = 'Calendari'
      OnExecute = actExecute
    end
    object actCalendarioOraLegaleSolare: TAction [70]
      Tag = 50
      Category = 'Ambiente'
      Caption = 'Calendario ora Legale Solare'
      Hint = 'Calendario ora Legale Solare'
      OnExecute = actExecute
    end
    object actPartTime: TAction [71]
      Tag = 144
      Category = 'Ambiente'
      Caption = 'Part-time'
      Hint = 'Part-time'
      OnExecute = actExecute
    end
    object actTipoRapporto: TAction [72]
      Tag = 143
      Category = 'Ambiente'
      Caption = 'Tipi di rapporto'
      Hint = 'Tipi di rapporto'
      OnExecute = actExecute
    end
    object actContratti: TAction [73]
      Tag = 111
      Category = 'Ambiente'
      Caption = 'Contratti'
      Hint = 'Contratti'
      OnExecute = actExecute
    end
    object actMotivazioniProvvedimento: TAction [74]
      Tag = 301
      Category = 'Ambiente'
      Caption = 'Motivazioni provvedimento'
      Hint = 'Motivazioni provvedimento'
      OnExecute = actExecute
    end
    object actProfiliAssenzeAnn: TAction [75]
      Tag = 104
      Category = 'Ambiente'
      Caption = 'Profili assenze annuali'
      Hint = 'Profili assenze annuali'
      OnExecute = actExecute
    end
    object actCausaliAssenza: TAction [76]
      Tag = 105
      Category = 'Ambiente'
      Caption = 'Causali di assenza'
      Hint = 'Causali di assenza'
      ImageIndex = 24
      OnExecute = actExecute
    end
    object actRaggrAssenze: TAction [77]
      Tag = 106
      Category = 'Ambiente'
      Caption = 'Raggruppamenti di assenza'
      Hint = 'Raggruppamenti di assenza'
      OnExecute = actExecute
    end
    object actAccorpamentiCausali: TAction [78]
      Tag = 196
      Category = 'Ambiente'
      Caption = 'Accorpamenti causali di assenza'
      Hint = 'Accorpamenti causali di assenza'
      OnExecute = actExecute
    end
    object actCausaliPresenza: TAction [79]
      Tag = 107
      Category = 'Ambiente'
      Caption = 'Causali di presenza'
      Hint = 'Causali di presenza'
      ImageIndex = 25
      OnExecute = actExecute
    end
    object actRaggrPres: TAction [80]
      Tag = 108
      Category = 'Ambiente'
      Caption = 'Raggruppamenti di presenza'
      Hint = 'Raggruppamenti di presenza'
      OnExecute = actExecute
    end
    object actCausaliGiustif: TAction [81]
      Tag = 109
      Category = 'Ambiente'
      Caption = 'Causali di giustificazione'
      Hint = 'Causali di giustificazione'
      OnExecute = actExecute
    end
    object actRaggrGiustif: TAction [82]
      Tag = 110
      Category = 'Ambiente'
      Caption = 'Raggruppamenti di giustificazione'
      Hint = 'Raggruppamenti di giustificazione'
      OnExecute = actExecute
    end
    object actCompensazioneAutomaticaRegole: TAction [83]
      Tag = 163
      Category = 'Ambiente'
      Caption = 'Regole compensazione giornaliera'
      Hint = 'Regole compensazione giornaliera'
      OnExecute = actExecute
    end
    object actRegoleRiposi: TAction [84]
      Tag = 176
      Category = 'Ambiente'
      Caption = 'Regole inserimento riposi'
      Hint = 'Regole inserimento riposi'
      OnExecute = actExecute
    end
    object actParametrizzazioneStampaCartellino: TAction [85]
      Tag = 125
      Category = 'Ambiente'
      Caption = 'Parametrizzazione stampa del cartellino'
      OnExecute = actExecute
    end
    object actGestioneImmagini: TAction [86]
      Tag = 164
      Category = 'Ambiente'
      Caption = 'Loghi aziendali'
      Hint = 'Loghi aziendali'
      OnExecute = actExecute
    end
    object actDatiAziendali: TAction [87]
      Tag = 543
      Category = 'Ambiente'
      Caption = 'Configurazione dati aziendali'
      Hint = 'Configurazione dati aziendali'
      OnExecute = actExecute
    end
    object actSetupValute: TAction [88]
      Tag = 520
      Category = 'Ambiente'
      Caption = 'Configurazione dati economici'
      Hint = 'Configurazione dati economici'
      OnExecute = actExecute
    end
    object actValute: TAction [89]
      Tag = 517
      Category = 'Ambiente'
      Caption = 'Valute'
      Hint = 'Valute'
      OnExecute = actExecute
    end
    object actArrotondamentiValute: TAction [90]
      Tag = 519
      Category = 'Ambiente'
      Caption = 'Arrotondamenti valute'
      Hint = 'Arrotondamenti valute'
      OnExecute = actExecute
    end
    object actCambiValute: TAction [91]
      Tag = 518
      Category = 'Ambiente'
      Caption = 'Cambi valute'
      Hint = 'Cambi valute'
      OnExecute = actExecute
    end
    object actAcquisizioneTimbrature: TAction [92]
      Tag = 120
      Category = 'Interfacce'
      Caption = 'Acquisizione timbrature'
      Hint = 'Acquisizione timbrature'
      ImageIndex = 20
      OnExecute = actExecute
    end
    object actTimbratureIrregolari: TAction [93]
      Tag = 130
      Category = 'Interfacce'
      Caption = 'Timbrature irregolari'
      Hint = 'Timbrature irregolari'
      ImageIndex = 19
      OnExecute = actExecute
    end
    object actTimbratureScartate: TAction [94]
      Tag = 189
      Category = 'Interfacce'
      Caption = 'Timbrature scartate'
      Hint = 'Timbrature scartate'
      OnExecute = actExecute
    end
    object actBadgeServizio: TAction [95]
      Tag = 172
      Category = 'Interfacce'
      Caption = 'Badge di servizio'
      Hint = 'Badge di servizio'
      OnExecute = actExecute
    end
    object actCambioOraLegaleSolare: TAction [96]
      Tag = 178
      Category = 'Interfacce'
      Caption = 'Cambio ora legale/solare'
      Hint = 'Cambio ora legale/solare'
      OnExecute = actExecute
    end
    object actOrologi: TAction [97]
      Tag = 124
      Category = 'Interfacce'
      Caption = 'Orologi di timbratura'
      Hint = 'Orologi di timbratura'
      OnExecute = actExecute
    end
    object actParScarico: TAction [98]
      Tag = 119
      Category = 'Interfacce'
      Caption = 'Regole acquisizione timbrature'
      Hint = 'Regole acquisizione timbrature'
      OnExecute = actExecute
    end
    object actScaricoPaghe: TAction [99]
      Tag = 13
      Category = 'Interfacce'
      Caption = 'Scarico paghe'
      Hint = 'Scarico paghe'
      ImageIndex = 15
      OnExecute = actExecute
    end
    object actVociVariabiliScaricate: TAction [100]
      Tag = 14
      Category = 'Interfacce'
      Caption = 'Voci variabili scaricate'
      Hint = 'Voci variabili scaricate'
      OnExecute = actExecute
    end
    object actAttivazioneVociVariabili: TAction [101]
      Tag = 121
      Category = 'Interfacce'
      Caption = 'Attivazione voci variabili'
      Hint = 'Attivazione voci variabili'
      OnExecute = actExecute
    end
    object actParScaricoPaghe: TAction [102]
      Tag = 122
      Category = 'Interfacce'
      Caption = 'Regole scarico paghe'
      Hint = 'Regole scarico paghe'
      OnExecute = actExecute
    end
    object actAcquisizioneGiustificativi: TAction [103]
      Tag = 160
      Category = 'Interfacce'
      Caption = 'Acquisizione giustificativi'
      Hint = 'Acquisizione giustificativi'
      OnExecute = actExecute
    end
    object actParScaricoGiustif: TAction [104]
      Tag = 159
      Category = 'Interfacce'
      Caption = 'Regole acquisizione giustificativi'
      Hint = 'Regole acquisizione giustificativi'
      OnExecute = actExecute
    end
    object actRegoleTurniRep: TAction [105]
      Tag = 123
      Category = 'Modulo Reperibilit'#224
      Caption = 'Regole turni di reperibilit'#224'/guardia'
      Hint = 'Regole turni di reperibilit'#224'/guardia'
      OnExecute = actExecute
    end
    object actVincoliGuardia: TAction [106]
      Tag = 69
      Category = 'Modulo Reperibilit'#224
      Caption = 'Vincoli pianificazione guardia'
      Hint = 'Vincoli pianificazione guardia'
      OnExecute = actExecute
    end
    object actVincoliReperibilita: TAction [107]
      Tag = 68
      Category = 'Modulo Reperibilit'#224
      Caption = 'Vincoli pianificazione reperibilit'#224
      Hint = 'Vincoli pianificazione reperibilit'#224
      OnExecute = actExecute
    end
    object actPianificazioneTurniGuardia: TAction [108]
      Tag = 63
      Category = 'Modulo Reperibilit'#224
      Caption = 'Pianificazione turni guardia'
      Hint = 'Pianificazione turni guardia'
      ImageIndex = 32
      OnExecute = actExecute
    end
    object actPianificazioneTurniRep: TAction [109]
      Tag = 16
      Category = 'Modulo Reperibilit'#224
      Caption = 'Pianificazione turni reperibilit'#224
      Hint = 'Pianificazione turni reperibilit'#224
      ImageIndex = 31
      OnExecute = actExecute
    end
    object actCartellinoReperibilita: TAction [110]
      Tag = 19
      Category = 'Modulo Reperibilit'#224
      Caption = 'Cartolina reperibilit'#224
      Hint = 'Cartolina reperibilit'#224
      ImageIndex = 35
      OnExecute = actExecute
    end
    object actRiepilogoReperibilita: TAction [111]
      Tag = 15
      Category = 'Modulo Reperibilit'#224
      Caption = 'Riepilogo turni di reperibilit'#224
      Hint = 'Riepilogo turni di reperibilit'#224
      ImageIndex = 33
      OnExecute = actExecute
    end
    object actTurniRepSostitutivi: TAction [112]
      Tag = 32
      Category = 'Modulo Reperibilit'#224
      Caption = 'Turni di reperibilit'#224' sostitutivi'
      Hint = 'Turni di reperibilit'#224' sostitutivi'
      OnExecute = actExecute
    end
    object actMedicineLegali: TAction [113]
      Tag = 64
      Category = 'Modulo Visite fiscali'
      Caption = 'Medicine legali'
      Hint = 'Medicine legali'
      OnExecute = actExecute
    end
    object actComVisiteFiscali: TAction [114]
      Tag = 66
      Category = 'Modulo Visite fiscali'
      Caption = 'Comunicazione visite fiscali'
      OnExecute = actExecute
    end
    object actImpAttestatiMal: TAction [115]
      Tag = 70
      Category = 'Modulo Visite fiscali'
      Caption = 'Importazione certificati di malattia'
      Hint = 'Importazione certificati di malattia'
      OnExecute = actExecute
    end
    object actXMLVisiteFiscali: TAction [116]
      Tag = 148
      Category = 'Modulo Visite fiscali'
      Caption = 'XML visite fiscali'
      OnExecute = actExecute
    end
    object actProfiliAttestatiMal: TAction [117]
      Tag = 72
      Category = 'Modulo Visite fiscali'
      Caption = 'Profili importazione certificati INPS'
      OnExecute = actExecute
    end
    object actDefinizioneProfiliLP: TAction [118]
      Tag = 150
      Category = 'Modulo Libera professione'
      Caption = 'Profili libera professione'
      Hint = 'Profili libera professione'
      OnExecute = actExecute
    end
    object actPianificazioneAttivitaLP: TAction [119]
      Tag = 46
      Category = 'Modulo Libera professione'
      Caption = 'Pianificazione libera professione'
      Hint = 'Pianificazione libera professione'
      OnExecute = actExecute
    end
    object actRegoleTurniPrestAgg: TAction [120]
      Tag = 60
      Category = 'Modulo Prestazioni agguintive'
      Caption = 'Regole prestazioni aggiuntive'
      Hint = 'Regole prestazioni aggiuntive'
      OnExecute = actExecute
    end
    object actPianifPrestAgg: TAction [121]
      Tag = 61
      Category = 'Modulo Prestazioni agguintive'
      Caption = 'Pianificazione prestazioni aggiuntive'
      Hint = 'Pianificazione prestazioni aggiuntive'
      OnExecute = actExecute
    end
    object actSquadre: TAction [122]
      Tag = 128
      Category = 'Modulo Pianificazione turni'
      Caption = 'Squadre'
      Hint = 'Squadre'
      OnExecute = actExecute
    end
    object actCondizioniTurni: TAction [123]
      Tag = 184
      Category = 'Modulo Pianificazione turni'
      Caption = 'Condizioni'
      Hint = 'Condizioni'
      OnExecute = actExecute
    end
    object actCicli: TAction [124]
      Tag = 126
      Category = 'Modulo Pianificazione turni'
      Caption = 'Cicli'
      Hint = 'Cicli'
      OnExecute = actExecute
    end
    object actTurnazioni: TAction [125]
      Tag = 127
      Category = 'Modulo Pianificazione turni'
      Caption = 'Turnazioni dei cicli'
      Hint = 'Turnazioni dei cicli'
      OnExecute = actExecute
    end
    object actTurnazioniIndividuali: TAction [126]
      Tag = 22
      Category = 'Modulo Pianificazione turni'
      Caption = 'Assegnazione turnazioni'
      Hint = 'Assegnazione turnazioni'
      OnExecute = actExecute
    end
    object actSpostamentiSquadra: TAction [127]
      Tag = 23
      Category = 'Modulo Pianificazione turni'
      Caption = 'Spostamenti di squadra'
      Hint = 'Spostamenti di squadra'
      OnExecute = actExecute
    end
    object actParPianifTurni: TAction [128]
      Tag = 213
      Category = 'Modulo Pianificazione turni'
      Caption = 'Profili di pianificazione'
      Hint = 'Profili di pianificazione'
      OnExecute = actExecute
    end
    object actPianificazioneTI: TAction [129]
      Tag = 24
      Category = 'Modulo Pianificazione turni'
      Caption = 'Pianificazione tabellone'
      Hint = 'Pianificazione tabellone'
      ImageIndex = 38
      OnExecute = actExecute
    end
    object actControlloPianificazione: TAction [130]
      Tag = 25
      Category = 'Modulo Pianificazione turni'
      Caption = 'Controllo pianificazione'
      Hint = 'Controllo pianificazione'
      OnExecute = actExecute
    end
    object actSituazioneGiornaliera: TAction [131]
      Tag = 33
      Category = 'Modulo Pianificazione turni'
      Caption = 'Situazione giornaliera dei turni'
      Hint = 'Situazione giornaliera dei turni'
      OnExecute = actExecute
    end
    object actLimitiMensili: TAction [132]
      Tag = 43
      Category = 'Modulo Budget straordinario'
      Caption = 'Limiti mensili delle eccedenze orarie'
      Hint = 'Limiti mensili delle eccedenze orarie'
      ImageIndex = 26
      OnExecute = actExecute
    end
    object actCampiRaggr: TAction [133]
      Tag = 94
      Category = 'Modulo Budget straordinario'
      Caption = 'Definizione campi di raggruppamento'
      Hint = 'Definizione campi di raggruppamento'
      OnExecute = actExecute
    end
    object actLimitiEccLiq: TAction [134]
      Tag = 92
      Category = 'Modulo Budget straordinario'
      Caption = 'Limiti eccedenza liquidabile'
      Hint = 'Limiti eccedenza liquidabile'
      OnExecute = actExecute
    end
    object actLimitiEccRes: TAction [135]
      Tag = 93
      Category = 'Modulo Budget straordinario'
      Caption = 'Limiti eccedenza residuabile'
      Hint = 'Limiti eccedenza residuabile'
      OnExecute = actExecute
    end
    object actLiquidazioneAutomaticaStr: TAction [136]
      Tag = 44
      Category = 'Modulo Budget straordinario'
      Caption = 'Liquidazione automatica straordinario'
      Hint = 'Liquidazione automatica straordinario'
      ImageIndex = 29
      OnExecute = actExecute
    end
    object actRegoleAccessiMensa: TAction [137]
      Tag = 129
      Category = 'Modulo Accessi mensa'
      Caption = 'Regole accessi mensa'
      Hint = 'Regole accessi mensa'
      OnExecute = actExecute
    end
    object ActTimbratureMensa: TAction [138]
      Tag = 27
      Category = 'Modulo Accessi mensa'
      Caption = 'Timbrature di mensa'
      OnExecute = actExecute
    end
    object actCartolinaMensa: TAction [139]
      Tag = 28
      Category = 'Modulo Accessi mensa'
      Caption = 'Cartolina accessi mensa'
      Hint = 'Cartolina accessi mensa'
      ImageIndex = 8
      OnExecute = actExecute
    end
    object actRiepilogoMensileAM: TAction [140]
      Tag = 29
      Category = 'Modulo Accessi mensa'
      Caption = 'Riepilogo accessi mensa'
      Hint = 'Riepilogo accessi mensa'
      ImageIndex = 13
      OnExecute = actExecute
    end
    object actRegoleBuoni: TAction [141]
      Tag = 137
      Category = 'Modulo Buoni pasto'
      Caption = 'Regole di gestione buoni pasto/ticket'
      Hint = 'Regole di gestione buoni pasto/ticket'
      OnExecute = actExecute
    end
    object actRiepilogoBuoni: TAction [142]
      Tag = 36
      Category = 'Modulo Buoni pasto'
      Caption = 'Cartolina buoni pasto/ticket'
      Hint = 'Cartolina buoni pasto/ticket'
      ImageIndex = 17
      OnExecute = actExecute
    end
    object actGestioneMagazzino: TAction [143]
      Tag = 179
      Category = 'Modulo Buoni pasto'
      Caption = 'Magazzino buoni pasto/ticket'
      Hint = 'Magazzino buoni pasto/ticket'
      OnExecute = actExecute
    end
    object actGestioneAcquisto: TAction [144]
      Tag = 35
      Category = 'Modulo Buoni pasto'
      Caption = 'Riepilogo acquisto buoni pasto/ticket'
      Hint = 'Riepilogo acquisto buoni pasto/ticket'
      ImageIndex = 16
      OnExecute = actExecute
    end
    object actRiepilogoMensileBM: TAction [145]
      Tag = 34
      Category = 'Modulo Buoni pasto'
      Caption = 'Riepilogo buoni pasto/ticket'
      Hint = 'Riepilogo buoni pasto/ticket'
      ImageIndex = 14
      OnExecute = actExecute
    end
    object actMsgOrologiStrutture: TAction [146]
      Tag = 165
      Category = 'Modulo Messaggi orologi'
      Caption = 'Parametrizzazione interfacce messaggi'
      Hint = 'Parametrizzazione interfacce messaggi'
      OnExecute = actExecute
    end
    object actMsgOrologiCreazione: TAction [147]
      Tag = 166
      Category = 'Modulo Messaggi orologi'
      Caption = 'Generazione messaggi'
      Hint = 'Generazione messaggi'
      OnExecute = actExecute
    end
    object actAssenteismo: TAction [148]
      Tag = 197
      Category = 'Modulo Assenteismo'
      Caption = 'Assenteismo e Forza Lavoro'
      Hint = 'Assenteismo e Forza Lavoro'
      OnExecute = actExecute
    end
    object actRegoleMissioni: TAction [149]
      Tag = 155
      Category = 'Modulo Gestione trasferte'
      Caption = 'Regole trasferte'
      Hint = 'Regole trasferte'
      OnExecute = actExecute
    end
    object actTariffeTrasferte: TAction [150]
      Tag = 180
      Category = 'Modulo Gestione trasferte'
      Caption = 'Tariffe trasferte'
      OnExecute = actExecute
    end
    object actCategorieRimborsi: TAction [151]
      Tag = 118
      Category = 'Modulo Gestione trasferte'
      Caption = 'Categorie rimborsi'
      OnExecute = actExecute
    end
    object actTipiRimborso: TAction [152]
      Tag = 156
      Category = 'Modulo Gestione trasferte'
      Caption = 'Tipi rimborsi'
      OnExecute = actExecute
    end
    object actDistanzeChilometriche: TAction [153]
      Tag = 175
      Category = 'Modulo Gestione trasferte'
      Caption = 'Distanze chilometriche'
      OnExecute = actExecute
    end
    object actIndennitaKM: TAction [154]
      Tag = 157
      Category = 'Modulo Gestione trasferte'
      Caption = 'Indennit'#224' chilometriche'
      OnExecute = actExecute
    end
    object actTipiPagamento: TAction [155]
      Tag = 99
      Category = 'Modulo Gestione trasferte'
      Caption = 'Tipi di pagamento'
      OnExecute = actExecute
    end
    object actDatiLiberiIterMissioni: TAction [156]
      Tag = 207
      Category = 'Modulo Gestione trasferte'
      Caption = 'Dati liberi iter missioni'
      OnExecute = actExecute
    end
    object actGestioneAnticipi: TAction [157]
      Tag = 177
      Category = 'Modulo Gestione trasferte'
      Caption = 'Gestione anticipi'
      ImageIndex = 39
      OnExecute = actExecute
    end
    object actCalcoloSpeseAccesso: TAction [158]
      Tag = 195
      Category = 'Modulo Gestione trasferte'
      Caption = 'Calcolo spese di accesso'
      OnExecute = actExecute
    end
    object actRegistrazioneTrasferte: TAction [159]
      Tag = 49
      Category = 'Modulo Gestione trasferte'
      Caption = 'Registrazione trasferte'
      OnExecute = actExecute
    end
    object actStampaTrasferte: TAction [160]
      Tag = 53
      Category = 'Modulo Gestione trasferte'
      Caption = 'Stampa trasferte'
      OnExecute = actExecute
    end
    object actCapitoliTrasferte: TAction [161]
      Tag = 135
      Category = 'Modulo Gestione trasferte'
      Caption = 'Capitoli trasferte'
      OnExecute = actExecute
    end
    object actCapitoliRimborso: TAction [162]
      Tag = 147
      Category = 'Modulo Gestione trasferte'
      Caption = 'Capitoli rimborso'
      OnExecute = actExecute
    end
    object actSindacatiOrganizzazioni: TAction [163]
      Tag = 55
      Category = 'Modulo Permessi sindacali'
      Caption = 'Organizzazioni sindacali'
      Hint = 'Organizzazioni sindacali'
      ImageIndex = 41
      OnExecute = actExecute
    end
    object actSindacatiIscrizioni: TAction [164]
      Tag = 56
      Category = 'Modulo Permessi sindacali'
      Caption = 'Iscrizioni ai sindacati'
      Hint = 'Iscrizioni ai sindacati'
      ImageIndex = 42
      OnExecute = actExecute
    end
    object actSindacatiPartecipazioni: TAction [165]
      Tag = 57
      Category = 'Modulo Permessi sindacali'
      Caption = 'Partecipazioni ai sindacati'
      Hint = 'Partecipazioni ai sindacati'
      ImageIndex = 43
      OnExecute = actExecute
    end
    object actCodiciAccorpCausali: TAction [166]
      Tag = 91
      Category = 'Ambiente'
      Caption = 'actCodiciAccorpCausali'
      OnExecute = actExecute
    end
    object actConteggiServizio: TAction [167]
      Tag = 5
      Category = 'Personale'
      Caption = 'Conteggi di servizio'
      OnExecute = actExecute
    end
    object actRecapitiSindacali: TAction [168]
      Tag = 97
      Category = 'Modulo Permessi sindacali'
      Caption = 'actRecapitiSindacali'
      Enabled = False
      Hint = 'Recapiti sindacali'
      Visible = False
      OnExecute = actExecute
    end
    object actImpRichRimb: TAction [169]
      Tag = 98
      Category = 'Modulo Gestione trasferte'
      Caption = 'Importazione richieste rimborso'
    end
    object actSindacatiPermessi: TAction [170]
      Tag = 58
      Category = 'Modulo Permessi sindacali'
      Caption = 'Permessi sindacali'
      Hint = 'Permessi sindacali'
      OnExecute = actExecute
    end
    object actPartecipazioneScioperi: TAction [171]
      Tag = 21
      Category = 'Modulo Assenteismo'
      Caption = 'Partecipazione scioperi'
      Hint = 'Partecipazione scioperi'
      OnExecute = actExecute
    end
    object actComuniMedLegali: TAction [172]
      Tag = 65
      Category = 'Modulo Visite fiscali'
      Caption = 'Associazione comuni - medicine legali'
      OnExecute = actExecute
    end
    object actTipoAbbattimenti: TAction [173]
      Tag = 198
      Category = 'Modulo Incentivi'
      Caption = 'Tipologie di abbattimento incentivi'
      OnExecute = actExecute
    end
    object actAllineamentoBudget: TAction [174]
      Tag = 131
      Category = 'Modulo Budget straordinario'
      Caption = 'Allineamento del budget'
      Hint = 'Allineamento del budget'
      OnExecute = actExecute
    end
    object actValutaStr: TAction [175]
      Tag = 134
      Category = 'Modulo Incentivi'
      Caption = 'Monetizzazione ore di straordinario'
      OnExecute = actExecute
    end
    object actFPunteggiFasceIncentivi: TAction [176]
      Tag = 211
      Category = 'Modulo Incentivi'
      Caption = 'Scaglioni gg. effettivi incentivi'
      OnExecute = actExecute
    end
    object actScaglioniPT: TAction [177]
      Tag = 205
      Category = 'Modulo Incentivi'
      Caption = 'Scaglioni part-time incentivi'
      OnExecute = actExecute
    end
    object actScaglioniGGEffettivi: TAction [178]
      Tag = 211
      Category = 'Modulo Incentivi'
      Caption = 'Scaglioni gg. effettivi incentivi'
      OnExecute = actExecute
    end
    object actCartolinaIncentivi: TAction [179]
      Tag = 39
      Category = 'Modulo Incentivi'
      Caption = 'Cartolina incentivi'
      OnExecute = actExecute
    end
    object actFScaglioniIncentivi: TAction [180]
      Tag = 353
      Category = 'Modulo Incentivi'
      Caption = 'Scaglioni valutazioni per incentivi'
      OnExecute = actExecute
    end
    object actTipoQuote: TAction [181]
      Tag = 199
      Category = 'Modulo Incentivi'
      Caption = 'Tipologie quote'
      OnExecute = actExecute
    end
    object actQuoteIncentivazione: TAction [182]
      Tag = 146
      Category = 'Modulo Incentivi'
      Caption = 'Quote di incentivazione'
      OnExecute = actExecute
    end
    object actIncentiviMaturati: TAction [183]
      Tag = 40
      Category = 'Modulo Incentivi'
      Caption = 'Riepilogo incentivi'
      OnExecute = actExecute
    end
    object actIncentiviAssenze: TAction [184]
      Tag = 174
      Category = 'Modulo Incentivi'
      Caption = 'Abbattimento incentivi per assenze'
      OnExecute = actExecute
    end
    object actRegoleIncentivi: TAction [185]
      Tag = 145
      Category = 'Modulo Incentivi'
      Caption = 'Regole incentivi'
      OnExecute = actExecute
    end
    object actQuoteIndividuali: TAction [186]
      Tag = 62
      Category = 'Modulo Incentivi'
      Caption = 'Quote individuali'
      OnExecute = actExecute
    end
    object actPunteggiValutazioni: TAction [187]
      Tag = 340
      Category = 'Modulo Valutazioni'
      Caption = 'Punteggi valutazioni'
      OnExecute = actExecute
    end
    object actGruppiIncentivi: TAction [188]
      Tag = 204
      Category = 'Modulo Incentivi'
      Caption = 'Gruppi pesature/schede'
      OnExecute = actExecute
    end
    object actParProtocollo: TAction [189]
      Tag = 355
      Category = 'Modulo Valutazioni'
      Caption = 'Parametrizzazione protocollazione'
      OnExecute = actExecute
    end
    object actSchedeQuantitativeIndividuali: TAction [190]
      Tag = 206
      Category = 'Modulo Valutazioni'
      Caption = 'Schede quantitative individuali'
      OnExecute = actExecute
    end
    object actPesatureIndividuali: TAction [191]
      Tag = 173
      Category = 'Modulo Valutazioni'
      Caption = 'Pesature individuali'
      OnExecute = actExecute
    end
    object actStampaValutazioni: TAction [192]
      Tag = 347
      Category = 'Modulo Valutazioni'
      Caption = 'Elaborazione schede di valutazione'
      OnExecute = actExecute
    end
    object actRegoleFluper: TAction [193]
      Tag = 571
      Category = 'Modulo Flussi statistici'
      Caption = 'Regole fornitura FLUPER'
      OnExecute = actExecute
    end
    inherited actCheckRimborsi: TAction
      Category = 'Modulo Gestione trasferte'
    end
    inherited actElaborazioneFluper: TAction
      Category = 'Modulo Flussi statistici'
    end
    object actFornituraFluper: TAction
      Tag = 572
      Category = 'Modulo Flussi statistici'
      Caption = 'Fornitura FLUPER'
      OnExecute = actExecute
    end
    object actStatiAvanzamento: TAction
      Tag = 354
      Category = 'Modulo Valutazioni'
      Caption = 'Stati avanzamento valutazioni'
      OnExecute = actExecute
    end
    object actMotivazioniRichieste: TAction
      Tag = 203
      Category = 'Interfacce'
      Caption = 'Causali per iter autorizzativi'
      Hint = 'Causali per iter autorizzativi'
      OnExecute = actExecute
    end
    object actRegoleValutazioni: TAction
      Tag = 350
      Category = 'Modulo Valutazioni'
      Caption = 'Regole valutazioni'
      OnExecute = actExecute
    end
    object actContoAnnRelTab: TAction
      Tag = 647
      Category = 'Modulo Conto annuale'
      Caption = 'Relazioni tabelle conto annuale'
      Hint = 'Relazioni tabelle conto annuale'
      OnExecute = actExecute
    end
    object actContoAnnRegole: TAction
      Tag = 580
      Category = 'Modulo Conto annuale'
      Caption = 'Regole conto annuale'
      Hint = 'Regole conto annuale'
      OnExecute = actExecute
    end
    object actContoAnnRisRes: TAction
      Tag = 584
      Category = 'Modulo Conto annuale'
      Caption = 'Risorse residue conto annuale'
      Hint = 'Risorse residue conto annuale'
      OnExecute = actExecute
    end
    object actContoAnnuale: TAction
      Tag = 582
      Category = 'Modulo Conto annuale'
      Caption = 'Conto annuale'
      Hint = 'Conto annuale'
      OnExecute = actExecute
    end
    object actCalcolaContoAnnuale: TAction
      Tag = 583
      Category = 'Modulo Conto annuale'
      Caption = 'Elaborazione conto annuale'
      Hint = 'Elaborazione conto annuale'
      OnExecute = actExecute
    end
    object actProfiliAree: TAction
      Tag = 345
      Category = 'Modulo Valutazioni'
      Caption = 'Profili valutazioni'
      OnExecute = actExecute
    end
    object actAreeValutazioni: TAction
      Tag = 342
      Category = 'Modulo Valutazioni'
      Caption = 'Aree ed elementi di valutazione'
      OnExecute = actExecute
    end
    object actStampaSituazioneBudget: TAction
      Tag = 133
      Category = 'Modulo Budget straordinario'
      Caption = 'Stampa situazione del budget'
      Hint = 'Stampa situazione del budget'
      OnExecute = actExecute
    end
    object actRaggrInterrogazioni: TAction
      Tag = 52
      Category = 'Ambiente'
      Caption = 'Raggruppamenti interrogazioni di servizio'
      Hint = 'Raggruppamenti interrogazioni di servizio'
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
    object actRelazioniTabelle: TAction
      Tag = 299
      Category = 'Modulo Flussi statistici'
      Caption = 'Relazioni tabelle FLUPER'
      OnExecute = actExecute
    end
    object actArchiviazioneCartellini: TAction
      Tag = 75
      Category = 'Elaborazioni'
      Caption = 'Archiviazione cartellini'
      Hint = 'Archiviazione cartellini'
      OnExecute = actExecute
    end
    object actRegoleArchiviazioneDoc: TAction
      Tag = 79
      Category = 'Interfacce'
      Caption = 'Regole archiviazione documenti'
      Hint = 'Regole archiviazione documenti'
      OnExecute = actExecute
    end
    object actRiepilogoIterAutorizzativi: TAction
      Tag = 214
      Category = 'Interfacce'
      Caption = 'Riepilogo iter autorizzativi'
      OnExecute = actExecute
    end
    object actNotificheIrisWEB: TAction
      Tag = 78
      Category = 'Interfacce'
      Caption = 'Notifiche IrisWEB'
      OnExecute = actExecute
    end
    object actPubblicazioneDocumenti: TAction
      Tag = 210
      Category = 'Modulo Gestione documentale'
      Caption = 'Pubblicazione documenti'
      Hint = 'Pubblicazione documenti'
      OnExecute = actExecute
    end
    object actGestioneOrdiniProf: TAction
      Tag = 356
      Category = 'Modulo Gestione documentale'
      Caption = 'Gestione Ordini professionali'
      Hint = 'Gestione Ordini professionali'
    end
    object actImportazioneMassivaDocumenti: TAction
      Tag = 154
      Category = 'Modulo Gestione documentale'
      Caption = 'Importazione massiva documenti'
      Hint = 'Importazione massiva documenti'
      OnExecute = actExecute
    end
    object actFerieSolidali: TAction
      Tag = 81
      Category = 'Modulo Assenteismo'
      Caption = 'Ferie solidali'
      Hint = 'Ferie solidali'
      OnExecute = actExecute
    end
    object actPianifPersConv: TAction
      Tag = 153
      Category = 'Interfacce'
      Caption = 'Pianificazione personale convenzionato'
      Hint = 'Pianificazione personale convenzionato'
      OnExecute = actExecute
    end
    object actAreeTurni: TAction
      Tag = 193
      Category = 'Modulo Pianificazione turni'
      Caption = 'Aree turni'
      Hint = 'Aree turni'
      OnExecute = actExecute
    end
    object actRiepilogoRapportiLavoro: TAction
      Tag = 161
      Category = 'Personale'
      Caption = 'Riepilogo rapporti di lavoro'
      Hint = 'Riepilogo rapporti di lavoro'
      OnExecute = actExecute
    end
    object actDatiAtipici: TAction
      Tag = 181
      Category = 'Ambiente'
      Caption = 'Dati atipici'
      Hint = 'Dati atipici'
      OnExecute = actExecute
    end
    object actValidazionePeriodiGiuridici: TAction
      Tag = 182
      Category = 'Personale'
      Caption = 'Validazione periodi giuridici autocertificati'
      Hint = 'Validazione periodi giuridici autocertificati'
      OnExecute = actExecute
    end
    object actModelliCertificazione: TAction
      Tag = 183
      Category = 'Interfacce'
      Caption = 'Modelli di scheda informativa'
      Hint = 'Modelli di scheda informativa'
      OnExecute = actExecute
    end
    object actProfiliStampeRep: TAction
      Tag = 185
      Category = 'Modulo Reperibilit'#224
      Caption = 'Profili stampe reperibilit'#224
      OnExecute = actExecute
    end
    object actMacrocategorieFondi: TAction
      Tag = 607
      Category = 'Modulo Fondi'
      Caption = 'Macrocategorie fondi'
      OnExecute = actExecute
    end
    object actRaggruppamentiFondi: TAction
      Tag = 608
      Category = 'Modulo Fondi'
      Caption = 'Raggruppamenti fondi'
      OnExecute = actExecute
    end
    object actDefinizioneFondi: TAction
      Tag = 609
      Category = 'Modulo Fondi'
      Caption = 'Definizione fondi'
      OnExecute = actExecute
    end
    object actCalcoloFondi: TAction
      Tag = 610
      Category = 'Modulo Fondi'
      Caption = 'Calcolo consumi mensili fondi'
      OnExecute = actExecute
    end
    object actMonitoraggioFondi: TAction
      Tag = 611
      Category = 'Modulo Fondi'
      Caption = 'Monitoraggio fondi'
      OnExecute = actExecute
    end
    object actStampaFondi: TAction
      Tag = 612
      Category = 'Modulo Fondi'
      Caption = 'Stampa fondi'
      OnExecute = actExecute
    end
    object actIterAutorizzativi: TAction
      Tag = 167
      Category = 'Interfacce'
      Caption = 'Iter autorizzativi'
      Hint = 'Iter autorizzativi'
      OnExecute = actExecute
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
      object Debitiaggiuntivi1: TMenuItem
        Action = actDebitiAggiuntivi
      end
      object Qualificheministeriali1: TMenuItem
        Action = actQualificheMinisteriali
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object actIndPresenza1: TMenuItem
        Action = actIndPresenza
      end
      object Action11: TMenuItem
        Action = actRegIndPresenza
      end
      object IndennitdipresenzaAssociazioni1: TMenuItem
        Action = actIndennitaGruppi
      end
      object Datiatipici1: TMenuItem
        Action = actDatiAtipici
      end
      object N21: TMenuItem
        Caption = '-'
      end
      object Modelliorario1: TMenuItem
        Action = actModelliOrario
      end
      object Profiliorario1: TMenuItem
        Action = actProfiliOrari
      end
      object actTipologieCartellini1: TMenuItem
        Action = actTipologieCartellini
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object actCalendari1: TMenuItem
        Action = actCalendari
      end
      object CalendariooraLegaleSolare1: TMenuItem
        Action = actCalendarioOraLegaleSolare
      end
      object Rilpre1: TMenuItem
        Action = actPartTime
      end
      object ipidiRapporto1: TMenuItem
        Action = actTipoRapporto
      end
      object actContratti1: TMenuItem
        Action = actContratti
      end
      object N33: TMenuItem
        Caption = '-'
      end
      object Motivazioniprovvedimento1: TMenuItem
        Action = actMotivazioniProvvedimento
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object ProfiliAssenzeAnn: TMenuItem
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
        object N10: TMenuItem
          Caption = '-'
        end
        object Causalidipresenza1: TMenuItem
          Action = actCausaliPresenza
        end
        object actRaggrPres1: TMenuItem
          Action = actRaggrPres
        end
        object N11: TMenuItem
          Caption = '-'
        end
        object actCausaliGiustif1: TMenuItem
          Action = actCausaliGiustif
        end
        object actRaggrGiustif1: TMenuItem
          Action = actRaggrGiustif
          Caption = 'Raggruppamenti  di giustificazione'
        end
      end
      object Regolecompensazionegiornaliera1: TMenuItem
        Action = actCompensazioneAutomaticaRegole
      end
      object Regoleinserimentoriposi1: TMenuItem
        Action = actRegoleRiposi
      end
      object N17: TMenuItem
        Caption = '-'
      end
      object Parametrizzazionestampadelcartellino1: TMenuItem
        Action = actParametrizzazioneStampaCartellino
      end
      object actRaggrInterrogazioni1: TMenuItem
        Action = actRaggrInterrogazioni
      end
      object Gestioneimmagini1: TMenuItem
        Action = actGestioneImmagini
      end
      object Datieconomici1: TMenuItem
        Caption = 'Dati economici'
        Hint = 'Dati economici'
        object Configurazionedatiaziendali1: TMenuItem
          Action = actDatiAziendali
        end
        object Configurazionedatieconomici1: TMenuItem
          Action = actSetupValute
        end
        object Valute1: TMenuItem
          Action = actValute
        end
        object Arrotondamentivalute1: TMenuItem
          Action = actArrotondamentiValute
        end
        object Cambivalute1: TMenuItem
          Action = actCambiValute
        end
      end
    end
    inherited Personale1: TMenuItem [3]
      object Cartellinointerattivo1: TMenuItem [0]
        Action = actCartellino
      end
      object Giustificativiasspres1: TMenuItem [1]
        Action = actGiustifAssPres
      end
      object Pianificazionigiornaliere1: TMenuItem [2]
        Action = actPianificazione
      end
      object N7: TMenuItem [3]
        Caption = '-'
      end
      object Schedaanagrafica1: TMenuItem [4]
        Action = actSchedaAnagrafica
      end
      object Centridicostopercentualizzati1: TMenuItem [6]
        Action = actCdcPercent
      end
      object Schedariepilogativa1: TMenuItem [7]
        Tag = 10
        Action = actSchedaRiepilogativa
      end
      object Residuiannoprecedente1: TMenuItem [8]
        Action = actResiduiAnnoPrecedente
      end
      object Assestamentooreanniprecedenti1: TMenuItem [9]
        Action = actOreLiquidateAnniPrec
      end
      object N13: TMenuItem [10]
        Caption = '-'
      end
      object Profiliassenze1: TMenuItem [11]
        Action = actCompAsseInd
      end
      object N15: TMenuItem [12]
        Caption = '-'
      end
      object Calendarioindividuale1: TMenuItem [13]
        Action = actCalendarioIndividuale
      end
      object Debitiaggiuntiviindividuali1: TMenuItem [14]
        Action = actPlusOrarioIndividuale
      end
      object Familiari1: TMenuItem [15]
        Action = actFamiliari
      end
      object N34: TMenuItem [16]
        Caption = '-'
      end
      object Validazioneperiodigiuridiciautocertificati1: TMenuItem [17]
        Action = actValidazionePeriodiGiuridici
      end
      object Riepilogorapportidilavoro1: TMenuItem [18]
        Action = actRiepilogoRapportiLavoro
      end
      object Gestioneprovvedimenti1: TMenuItem [19]
        Action = actSGProvvedimenti
      end
      object N27: TMenuItem [20]
        Caption = '-'
      end
    end
    object Elaborazioni1: TMenuItem [4]
      Caption = 'Elaborazioni'
      object Inserimentoautomaticoriposi1: TMenuItem
        Tag = 17
        Action = actInserimentoRiposi
      end
      object Inserimentogiustificativi1: TMenuItem
        Action = actInserimentoGiust
      end
      object N24: TMenuItem
        Caption = '-'
      end
      object actCaricaGiustRich1: TMenuItem
        Action = actCaricaGiustRich
      end
      object Elaboraomessetimbrature1: TMenuItem
        Action = actElaboraOmesseTimbrature
      end
      object N25: TMenuItem
        Caption = '-'
      end
      object Stampaanomalie1: TMenuItem
        Tag = 1012
        Action = actStampaAnomalie
      end
      object Stampacartellino1: TMenuItem
        Action = actCarMen
      end
      object Archiviazionecartellini1: TMenuItem
        Action = actArchiviazioneCartellini
      end
      object Sicurezzariepiloghi1: TMenuItem
        Tag = 1059
        Action = actSicurezzaRiepiloghi
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object Liquidazioneorecausalizzate1: TMenuItem
        Action = actLiqOreCau
      end
      object Liquidazioneoreanniprecedenti1: TMenuItem
        Action = actLiqOreAnniPrec
      end
      object Importazioneassestamentoore1: TMenuItem
        Action = actImportazioneAssestamentoOre
      end
      object N20: TMenuItem
        Caption = '-'
      end
      object Inserimentoautomaticoassenze1: TMenuItem
        Action = actInserimentoAutomaticoAssenze
      end
      object Compensazionegiornalieraautomatica1: TMenuItem
        Action = actCompensazioneAutomatica
      end
      object N23: TMenuItem
        Caption = '-'
      end
      object Passaggiodianno1: TMenuItem
        Action = actPassaggioAnno
      end
      object Storicogiustificativi1: TMenuItem
        Action = actStoricoGiustificativi
      end
      object N14: TMenuItem
        Caption = '-'
      end
      object Stampeanalitichepresenzeassenze1: TMenuItem
        Action = actElencoPresentiAssenti
      end
      object Elencoassenzeindividuali1: TMenuItem
        Action = actAssenzeIndividuali
      end
      object Elencotimbraturecausalizzate1: TMenuItem
        Action = actPrenotazionePasti
      end
      object Schedaannualeassenze1: TMenuItem
        Action = actSchedaAnnualeAssenze
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
      object Stampatimbratureoriginali1: TMenuItem
        Action = actStampaTimbratureOriginali
      end
      object Interrogazionidiservizio1: TMenuItem
        Action = actInterrogazioniServizio
      end
    end
    inherited Interfacce1: TMenuItem
      object imbrature1: TMenuItem
        Caption = 'Timbrature'
        object Acquisizionetimbrature1: TMenuItem
          Action = actAcquisizioneTimbrature
        end
        object imbratureirregolari1: TMenuItem
          Action = actTimbratureIrregolari
        end
        object imbratureScartate1: TMenuItem
          Action = actTimbratureScartate
        end
        object N16: TMenuItem
          Caption = '-'
        end
        object Badgediservizio1: TMenuItem
          Action = actBadgeServizio
        end
        object cambiooralegalesolare1: TMenuItem
          Action = actCambioOraLegaleSolare
        end
        object actOrologi1: TMenuItem
          Action = actOrologi
        end
        object actParScarico1: TMenuItem
          Action = actParScarico
        end
      end
      object Scaricopaghe1: TMenuItem
        Caption = 'Scarico paghe'
        object Scaricopaghe2: TMenuItem
          Tag = 1013
          Action = actScaricoPaghe
        end
        object VociVariabiliScaricate1: TMenuItem
          Tag = 1014
          Action = actVociVariabiliScaricate
        end
        object N5: TMenuItem
          Caption = '-'
        end
        object Attivazionevocivariabili1: TMenuItem
          Tag = 1121
          Action = actAttivazioneVociVariabili
        end
        object actParScaricoPaghe1: TMenuItem
          Action = actParScaricoPaghe
        end
      end
      object Giustificativiassenza1: TMenuItem
        Caption = 'Giustificativi assenza'
        object Acquisizionegiustificativi1: TMenuItem
          Action = actAcquisizioneGiustificativi
        end
        object N18: TMenuItem
          Caption = '-'
        end
        object Parametrizzazioneacquisizione1: TMenuItem
          Action = actParScaricoGiustif
        end
      end
      object IrisWeb1: TMenuItem
        Caption = 'IrisWeb'
        object Riepilogoiterautorizzativi1: TMenuItem
          Action = actRiepilogoIterAutorizzativi
        end
        object Pianificazionepersonaleconvenzionato1: TMenuItem
          Action = actPianifPersConv
        end
        object N36: TMenuItem
          Caption = '-'
        end
        object Iterautorizzativi1: TMenuItem
          Action = actIterAutorizzativi
        end
        object Causaliperiterautorizzativi1: TMenuItem
          Action = actMotivazioniRichieste
        end
        object NotificheIrisWEB1: TMenuItem
          Action = actNotificheIrisWEB
        end
        object Modellidicertificazione1: TMenuItem
          Action = actModelliCertificazione
        end
      end
      object N32: TMenuItem
        Caption = '-'
      end
      object Regolearchiviazionedocumenti1: TMenuItem
        Action = actRegoleArchiviazioneDoc
      end
    end
    inherited Moduliaccessori1: TMenuItem
      object Reperibilit1: TMenuItem
        Caption = 'Reperibilit'#224'/guardia'
        object Regoleturni1: TMenuItem
          Action = actRegoleTurniRep
        end
        object Vincolipianificazioneguardia1: TMenuItem
          Action = actVincoliGuardia
        end
        object Vincolipianificazionereperibilit1: TMenuItem
          Action = actVincoliReperibilita
        end
        object Pianificazioneturniguardia1: TMenuItem
          Action = actPianificazioneTurniGuardia
        end
        object Pianificazioneturnireperibilit1: TMenuItem
          Action = actPianificazioneTurniRep
        end
        object Cartolinareperibilit1: TMenuItem
          Action = actCartellinoReperibilita
        end
        object Riepilogomensile3: TMenuItem
          Action = actRiepilogoReperibilita
        end
        object Gestioneturnisostitutivi1: TMenuItem
          Action = actTurniRepSostitutivi
        end
      end
      object VisiteFiscali1: TMenuItem
        Caption = 'Visite fiscali'
        object mnuMedicineLegali: TMenuItem
          Action = actMedicineLegali
        end
        object Associazionecomunimedicinelegali1: TMenuItem
          Action = actComuniMedLegali
        end
        object Comunicazionevisitefiscali1: TMenuItem
          Action = actComVisiteFiscali
        end
        object XMLvisitefiscali1: TMenuItem
          Action = actXMLVisiteFiscali
        end
        object N22: TMenuItem
          Caption = '-'
        end
        object IndennitdipresenzaAssociazioni2: TMenuItem
          Action = actImpAttestatiMal
        end
        object ProfiliimportazionecertificatiINPS1: TMenuItem
          Action = actProfiliAttestatiMal
        end
      end
      object Liberaprofessione1: TMenuItem
        Caption = 'Libera professione'
        object Definizioneprofili1: TMenuItem
          Action = actDefinizioneProfiliLP
        end
        object Pianificazioneattivit1: TMenuItem
          Action = actPianificazioneAttivitaLP
        end
      end
      object Prestazioniaggiuntive1: TMenuItem
        Caption = 'Prestazioni aggiuntive'
        object Regoleturni2: TMenuItem
          Action = actRegoleTurniPrestAgg
        end
        object ImportazionePianificazioneturni1: TMenuItem
          Action = actPianifPrestAgg
        end
      end
      object Pianificazione1: TMenuItem
        Caption = 'Pianificazione orari'
        object Squadre1: TMenuItem
          Action = actSquadre
        end
        object Condizioni1: TMenuItem
          Action = actCondizioniTurni
        end
        object Areeturni1: TMenuItem
          Action = actAreeTurni
        end
        object Cicli1: TMenuItem
          Action = actCicli
        end
        object urnazionideicicli1: TMenuItem
          Action = actTurnazioni
        end
        object Assegnazioneturnazioni1: TMenuItem
          Action = actTurnazioniIndividuali
        end
        object Spostamentidisquadra1: TMenuItem
          Action = actSpostamentiSquadra
        end
        object Profilidipianificazione1: TMenuItem
          Action = actParPianifTurni
        end
        object Pianificazionetabellone1: TMenuItem
          Action = actPianificazioneTI
        end
        object Controllopianificazione1: TMenuItem
          Action = actControlloPianificazione
        end
        object Situazionegiornalieradeiturni1: TMenuItem
          Action = actSituazioneGiornaliera
        end
      end
      object BudgetStraordinario1: TMenuItem
        Caption = 'Budget straordinario'
        object Gestionedelbudget1: TMenuItem
          Action = actGestioneBudget
        end
        object Allineamentodelbudget1: TMenuItem
          Action = actAllineamentoBudget
        end
        object Stampasituazionedelbudget1: TMenuItem
          Action = actStampaSituazioneBudget
        end
        object Monetizzazioneoredistraordinario1: TMenuItem
          Action = actValutaStr
        end
        object N29: TMenuItem
          Caption = '-'
        end
        object Limitimensilidelleeccedenzeorarie1: TMenuItem
          Action = actLimitiMensili
        end
        object Definizionecampiraggruppamento1: TMenuItem
          Action = actCampiRaggr
        end
        object Limitieccedenzaliquidabile1: TMenuItem
          Action = actLimitiEccLiq
        end
        object Limitieccedenzaresiduabile1: TMenuItem
          Action = actLimitiEccRes
        end
        object Liquidazioneautomatica1: TMenuItem
          Action = actLiquidazioneAutomaticaStr
        end
      end
      object Conteggiopasti1: TMenuItem
        Caption = 'Accessi mensa'
        object Regole2: TMenuItem
          Action = actRegoleAccessiMensa
        end
        object imbraturedimensa1: TMenuItem
          Action = ActTimbratureMensa
        end
        object Cartolina1: TMenuItem
          Action = actCartolinaMensa
        end
        object RiepilogoMensile1: TMenuItem
          Action = actRiepilogoMensileAM
        end
      end
      object Buonipastoticket1: TMenuItem
        Caption = 'Buoni pasto/ticket'
        object Regole1: TMenuItem
          Action = actRegoleBuoni
        end
        object Cartolina2: TMenuItem
          Action = actRiepilogoBuoni
        end
        object Gestionemagazzino1: TMenuItem
          Action = actGestioneMagazzino
        end
        object actGestioneAcquisto1: TMenuItem
          Action = actGestioneAcquisto
        end
        object RiepilogoMensile2: TMenuItem
          Action = actRiepilogoMensileBM
        end
      end
      object Incentivi1: TMenuItem
        Caption = 'Incentivi'
        object Regoleincentivi1: TMenuItem
          Action = actRegoleIncentivi
        end
        object ipologiediabbattimentoincentivi1: TMenuItem
          Action = actTipoAbbattimenti
        end
        object Abbattimentoincentiviperassenze1: TMenuItem
          Action = actIncentiviAssenze
        end
        object N28: TMenuItem
          Caption = '-'
        end
        object ipologiequote1: TMenuItem
          Action = actTipoQuote
        end
        object Quotediincentivazione1: TMenuItem
          Action = actQuoteIncentivazione
        end
        object Quoteindividuali1: TMenuItem
          Action = actQuoteIndividuali
        end
        object Scaglioniggeffettiviincentivi1: TMenuItem
          Action = actScaglioniPT
        end
        object Scaglioniggeffettiviincentivi2: TMenuItem
          Action = actScaglioniGGEffettivi
        end
        object PesatureIndividuali1: TMenuItem
          Action = actPesatureIndividuali
        end
        object N30: TMenuItem
          Caption = '-'
        end
        object Schedequantitativeindividuali1: TMenuItem
          Action = actSchedeQuantitativeIndividuali
        end
        object Gruppipesatureschede1: TMenuItem
          Action = actGruppiIncentivi
        end
        object N19: TMenuItem
          Caption = '-'
        end
        object Cartolinaincentivi1: TMenuItem
          Action = actCartolinaIncentivi
        end
        object RiepilogoIncentivi1: TMenuItem
          Action = actIncentiviMaturati
        end
      end
      object Messaggisticaorologi1: TMenuItem
        Caption = 'Messaggistica orologi'
        object Parametrizzazioneinterfaccemessaggi1: TMenuItem
          Action = actMsgOrologiStrutture
        end
        object Generazionemessaggi1: TMenuItem
          Action = actMsgOrologiCreazione
        end
      end
      object Flussistatistici1: TMenuItem
        Caption = 'Flussi statistici'
        object actRelazioniTabelle1: TMenuItem
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
      end
      object AssenteismoScioperi1: TMenuItem
        Caption = 'Assenteismo/Scioperi'
        object AssenteismoeForzaLavoro1: TMenuItem
          Action = actAssenteismo
        end
        object Partecipazionescioperi1: TMenuItem
          Action = actPartecipazioneScioperi
        end
        object Feriesolidali1: TMenuItem
          Action = actFerieSolidali
        end
      end
      object Gestionetrasferte1: TMenuItem
        Caption = 'Gestione trasferte'
        object Regole3: TMenuItem
          Action = actRegoleMissioni
        end
        object ariffetrasferte1: TMenuItem
          Action = actTariffeTrasferte
        end
        object Categorierimborsi1: TMenuItem
          Action = actCategorieRimborsi
        end
        object ipirimborsi1: TMenuItem
          Action = actTipiRimborso
        end
        object Elaboraomessetimbrature2: TMenuItem
          Action = actDistanzeChilometriche
        end
        object Indennitchilometriche1: TMenuItem
          Action = actIndennitaKM
        end
        object ipidipagamento1: TMenuItem
          Action = actTipiPagamento
        end
        object Datiliberiitermissioni1: TMenuItem
          Action = actDatiLiberiIterMissioni
        end
        object Gestioneanticipi1: TMenuItem
          Action = actGestioneAnticipi
        end
        object Calcolospesediaccesso1: TMenuItem
          Action = actCalcoloSpeseAccesso
        end
        object Registrazionetrasferte1: TMenuItem
          Action = actRegistrazioneTrasferte
        end
        object Stampatrasferte1: TMenuItem
          Action = actStampaTrasferte
        end
        object N31: TMenuItem
          Caption = '-'
        end
        object Capitolitrasferte1: TMenuItem
          Action = actCapitoliTrasferte
        end
        object Capitolirimborso1: TMenuItem
          Action = actCapitoliRimborso
        end
      end
      object Sindacati1: TMenuItem
        Caption = 'Sindacati'
        object actSindacatiOrganizzazioni1: TMenuItem
          Action = actSindacatiOrganizzazioni
        end
        object Iscrizioniaisindacati1: TMenuItem
          Action = actSindacatiIscrizioni
        end
        object Partecipazioniaisindacati1: TMenuItem
          Action = actSindacatiPartecipazioni
        end
        object Permessisindacali1: TMenuItem
          Action = actSindacatiPermessi
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
        object ProfiliValutazioni1: TMenuItem
          Action = actProfiliAree
        end
        object PunteggiValutazioni1: TMenuItem
          Action = actPunteggiValutazioni
        end
        object Scaglionivalutazioniperincentivi1: TMenuItem
          Action = actFScaglioniIncentivi
        end
        object ParametrizzazioneProtocollazione1: TMenuItem
          Action = actParProtocollo
        end
        object Elaborazioneschededivalutazione1: TMenuItem
          Action = actStampaValutazioni
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
        object Calcoloconsumimensilifondi1: TMenuItem
          Action = actCalcoloFondi
        end
        object Monitoraggiofondi1: TMenuItem
          Action = actMonitoraggioFondi
        end
        object Stampafondi1: TMenuItem
          Action = actStampaFondi
        end
      end
      object mnuGestionedocumentale1: TMenuItem
        Caption = 'Gestione documentale'
        object mnuGestioneDocumentale: TMenuItem
          Tag = 76
          Action = actGestioneDocumentale
        end
        object mnuRicercaDocumentale: TMenuItem
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
        object N35: TMenuItem
          Caption = '-'
        end
        object Pubblicazionedocumenti1: TMenuItem
          Tag = 210
          Action = actPubblicazioneDocumenti
        end
      end
    end
  end
end
