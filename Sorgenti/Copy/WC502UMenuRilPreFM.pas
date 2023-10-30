unit WC502UMenuRilPreFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, IWAppForm,
  Dialogs, IWVCLComponent, IWBaseLayoutComponent, OracleData, Jpeg, pngimage, IWApplication,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompMenu, meIWMenu, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, Menus, IWCompButton,
  meIWButton, ActnList, ImgList, meIWImageList, meIWImageFile, IWImageList, A000UInterfaccia,
  IWCompJQueryWidget, meIWLink, WR207UMenuWebPJFM, WR100UBase, System.Actions,
  A000UCostanti;
type
  TWC502FMenuRilPreFM = class(TWR207FMenuWebPJFM)
    Rilpre1: TMenuItem;
    actPartTime: TAction;
    actQualificheMinisteriali: TAction;
    Qualificheministeriali1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Buonipastoticket1: TMenuItem;
    Regole1: TMenuItem;
    actRegoleBuoni: TAction;
    N7: TMenuItem;
    Profiliassenze1: TMenuItem;
    actCompAsseInd: TAction;
    actCarMen: TAction;
    Elaborazioni1: TMenuItem;
    Stampacartellino1: TMenuItem;
    Profiliorario1: TMenuItem;
    actProfiliOrari: TAction;
    Debitiaggiuntivi1: TMenuItem;
    actDebitiAggiuntivi: TAction;
    actProfiliAssenzeAnn: TAction;
    ProfiliAssenzeAnn: TMenuItem;
    actCalendari: TAction;
    actCalendari1: TMenuItem;
    actRaggrAssenze: TAction;
    Causali1: TMenuItem;
    Raggruppamentidiassenza1: TMenuItem;
    actRaggrPres: TAction;
    N10: TMenuItem;
    actRaggrPres1: TMenuItem;
    actRaggrGiustif: TAction;
    N11: TMenuItem;
    actRaggrGiustif1: TMenuItem;
    actCausaliGiustif: TAction;
    actCausaliGiustif1: TMenuItem;
    N12: TMenuItem;
    actContratti: TAction;
    actContratti1: TMenuItem;
    actIndPresenza: TAction;
    actIndPresenza1: TMenuItem;
    actParScarico: TAction;
    imbrature1: TMenuItem;
    actParScarico1: TMenuItem;
    actParScaricoPaghe: TAction;
    Scaricopaghe1: TMenuItem;
    actParScaricoPaghe1: TMenuItem;
    actOrologi: TAction;
    actOrologi1: TMenuItem;
    actTipologieCartellini: TAction;
    actTipologieCartellini1: TMenuItem;
    ipidiRapporto1: TMenuItem;
    actTipoRapporto: TAction;
    Giustificativiassenza1: TMenuItem;
    actParScaricoGiustif: TAction;
    Parametrizzazioneacquisizione1: TMenuItem;
    actRegoleRiposi: TAction;
    Regoleinserimentoriposi1: TMenuItem;
    actRegIndPresenza: TAction;
    actSchedaAnagrafica: TAction;
    Action11: TMenuItem;
    Schedaanagrafica1: TMenuItem;
    VisiteFiscali1: TMenuItem;
    mnuMedicineLegali: TMenuItem;
    actMedicineLegali: TAction;
    actSquadre: TAction;
    Pianificazione1: TMenuItem;
    Squadre1: TMenuItem;
    actCdcPercent: TAction;
    Centridicostopercentualizzati1: TMenuItem;
    actCartolinaMensa: TAction;
    Conteggiopasti1: TMenuItem;
    Cartolina1: TMenuItem;
    actRiepilogoBuoni: TAction;
    Cartolina2: TMenuItem;
    Regole2: TMenuItem;
    actRegoleAccessiMensa: TAction;
    actRiepilogoMensileAM: TAction;
    RiepilogoMensile1: TMenuItem;
    actRiepilogoMensileBM: TAction;
    RiepilogoMensile2: TMenuItem;
    actGestioneMagazzino: TAction;
    Gestionemagazzino1: TMenuItem;
    actScaricoPaghe: TAction;
    Scaricopaghe2: TMenuItem;
    actGestioneAcquisto: TAction;
    actGestioneAcquisto1: TMenuItem;
    actAttivazioneVociVariabili: TAction;
    Attivazionevocivariabili1: TMenuItem;
    N5: TMenuItem;
    actInterrogazioniServizio: TAction;
    Interrogazionidiservizio1: TMenuItem;
    actRidefinizioneCampiAnagrafici: TAction;
    Ridefinizionecampianagrafici1: TMenuItem;
    actPassaggioAnno: TAction;
    Passaggiodianno1: TMenuItem;
    N6: TMenuItem;
    actResiduiAnnoPrecedente: TAction;
    Residuiannoprecedente1: TMenuItem;
    N13: TMenuItem;
    actVociVariabiliScaricate: TAction;
    VociVariabiliScaricate1: TMenuItem;
    actStampaAnomalie: TAction;
    N14: TMenuItem;
    Stampaanomalie1: TMenuItem;
    N15: TMenuItem;
    actCalendarioIndividuale: TAction;
    Calendarioindividuale1: TMenuItem;
    actPlusOrarioIndividuale: TAction;
    Debitiaggiuntiviindividuali1: TMenuItem;
    N16: TMenuItem;
    actTimbratureIrregolari: TAction;
    imbratureirregolari1: TMenuItem;
    actBadgeServizio: TAction;
    Badgediservizio1: TMenuItem;
    actTimbratureScartate: TAction;
    imbratureScartate1: TMenuItem;
    actSicurezzaRiepiloghi: TAction;
    Sicurezzariepiloghi1: TMenuItem;
    actCambioOraLegaleSolare: TAction;
    cambiooralegalesolare1: TMenuItem;
    actGestioneImmagini: TAction;
    Gestioneimmagini1: TMenuItem;
    N17: TMenuItem;
    actIndennitaGruppi: TAction;
    IndennitdipresenzaAssociazioni1: TMenuItem;
    actAcquisizioneTimbrature: TAction;
    Acquisizionetimbrature1: TMenuItem;
    actInserimentoRiposi: TAction;
    Inserimentoautomaticoriposi1: TMenuItem;
    actSchedaRiepilogativa: TAction;
    Schedariepilogativa1: TMenuItem;
    actFamiliari: TAction;
    Familiari1: TMenuItem;
    actCausaliAssenza: TAction;
    Causalidiassenza1: TMenuItem;
    actAcquisizioneGiustificativi: TAction;
    Acquisizionegiustificativi1: TMenuItem;
    N18: TMenuItem;
    actCausaliPresenza: TAction;
    Causalidipresenza1: TMenuItem;
    actCodiciAccorpCausali: TAction;
    actAccorpamentiCausali: TAction;
    Accorpamenticausalidiassenza1: TMenuItem;
    actOreLiquidateAnniPrec: TAction;
    Assestamentooreanniprecedenti1: TMenuItem;
    actLimitiMensili: TAction;
    BudgetStraordinario1: TMenuItem;
    Limitimensilidelleeccedenzeorarie1: TMenuItem;
    actCampiRaggr: TAction;
    Definizionecampiraggruppamento1: TMenuItem;    actPianificazione: TAction;
    Pianificazionigiornaliere1: TMenuItem;
    actLimitiEccLiq: TAction;
    Limitieccedenzaliquidabile1: TMenuItem;
    actLimitiEccRes: TAction;
    Limitieccedenzaresiduabile1: TMenuItem;
    actLiqOreCau: TAction;
    Liquidazioneorecausalizzate1: TMenuItem;
    actModelliOrario: TAction;
    Modelliorario1: TMenuItem;
    actAssenzeIndividuali: TAction;
    Elencoassenzeindividuali1: TMenuItem;
    actStatisticaMinisterialeAssenze: TAction;
    Statisticaministerialeassenze1: TMenuItem;
    N21: TMenuItem;
    actLiquidazioneAutomaticaStr: TAction;
    Liquidazioneautomatica1: TMenuItem;
    actGiustifAssPres: TAction;
    actInserimentoGiust: TAction;
    Giustificativiasspres1: TMenuItem;
    Inserimentogiustificativi1: TMenuItem;
    actRegoleTurniRep: TAction;
    Reperibilit1: TMenuItem;
    Regoleturni1: TMenuItem;
    actVincoliReperibilita: TAction;
    actVincoliGuardia: TAction;
    Vincolipianificazionereperibilit1: TMenuItem;
    Vincolipianificazioneguardia1: TMenuItem;
    actPianificazioneTurniGuardia: TAction;
    actPianificazioneTurniRep: TAction;
    Pianificazioneturniguardia1: TMenuItem;
    Pianificazioneturnireperibilit1: TMenuItem;
    actTurniRepSostitutivi: TAction;
    Gestioneturnisostitutivi1: TMenuItem;
    actRiepilogoReperibilita: TAction;
    Riepilogomensile3: TMenuItem;
    actImpAttestatiMal: TAction;
    IndennitdipresenzaAssociazioni2: TMenuItem;
    N22: TMenuItem;
    actCartellino: TAction;
    Cartellinointerattivo1: TMenuItem;
    actElaboraOmesseTimbrature: TAction;
    actCartellinoReperibilita: TAction;
    Cartolinareperibilit1: TMenuItem;
    actDefinizioneProfiliLP: TAction;
    Liberaprofessione1: TMenuItem;
    Definizioneprofili1: TMenuItem;
    Elaboraomessetimbrature1: TMenuItem;
    actPianificazioneAttivitaLP: TAction;
    Pianificazioneattivit1: TMenuItem;
    actElencoPresentiAssenti: TAction;
    Stampeanalitichepresenzeassenze1: TMenuItem;
    actConteggiServizio: TAction;
    actRegoleTurniPrestAgg: TAction;
    Prestazioniaggiuntive1: TMenuItem;
    Regoleturni2: TMenuItem;
    actElencoStorici: TAction;
    Elencomovimentistorici1: TMenuItem;
    actPrenotazionePasti: TAction;
    Elencotimbraturecausalizzate1: TMenuItem;
    actStampaTimbratureOriginali: TAction;
    Stampatimbratureoriginali1: TMenuItem;
    actSchedaAnnualeAssenze: TAction;
    Schedaannualeassenze1: TMenuItem;
    actPianifPrestAgg: TAction;
    ImportazionePianificazioneturni1: TMenuItem;
    Datieconomici1: TMenuItem;
    actImportazioneAssestamentoOre: TAction;
    Importazioneassestamentoore1: TMenuItem;
    actInserimentoAutomaticoAssenze: TAction;
    N23: TMenuItem;
    Inserimentoautomaticoassenze1: TMenuItem;
    actSetupValute: TAction;
    Configurazionedatieconomici1: TMenuItem;
    actValute: TAction;
    Valute1: TMenuItem;
    actArrotondamentiValute: TAction;
    Arrotondamentivalute1: TMenuItem;
    actCambiValute: TAction;
    Cambivalute1: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    actRegoleMissioni: TAction;
    Gestionetrasferte1: TMenuItem;
    Regole3: TMenuItem;
    actGeneratoreStampe: TAction;
    Generatoredistampe1: TMenuItem;
    actLiqOreAnniPrec: TAction;
    Liquidazioneoreanniprecedenti1: TMenuItem;
    actCompensazioneAutomaticaRegole: TAction;
    Regolecompensazionegiornaliera1: TMenuItem;
    actTipiRimborso: TAction;
    ipirimborsi1: TMenuItem;
    actCompensazioneAutomatica: TAction;
    N20: TMenuItem;
    Compensazionegiornalieraautomatica1: TMenuItem;
    actCaricaGiustRich: TAction;
    actIndennitaKM: TAction;
    Indennitchilometriche1: TMenuItem;
    actCicli: TAction;
    Cicli1: TMenuItem;
    actTariffeTrasferte: TAction;
    ariffetrasferte1: TMenuItem;
    actTurnazioni: TAction;
    urnazionideicicli1: TMenuItem;
    actTurnazioniIndividuali: TAction;
    Assegnazioneturnazioni1: TMenuItem;
    actDistanzeChilometriche: TAction;
    Elaboraomessetimbrature2: TMenuItem;
    actSpostamentiSquadra: TAction;
    Spostamentidisquadra1: TMenuItem;
    actParPianifTurni: TAction;
    Profilidipianificazione1: TMenuItem;
    actControlloPianificazione: TAction;
    Controllopianificazione1: TMenuItem;
    actSituazioneGiornaliera: TAction;
    Situazionegiornalieradeiturni1: TMenuItem;
    actGestioneAnticipi: TAction;
    Gestioneanticipi1: TMenuItem;
    actPianificazioneTI: TAction;
    Pianificazionetabellone1: TMenuItem;
    actStoricoGiustificativi: TAction;
    Storicogiustificativi1: TMenuItem;
    actCalcoloSpeseAccesso: TAction;
    Calcolospesediaccesso1: TMenuItem;
    Messaggisticaorologi1: TMenuItem;
    actMsgOrologiStrutture: TAction;
    Parametrizzazioneinterfaccemessaggi1: TMenuItem;
    actMsgOrologiCreazione: TAction;
    Generazionemessaggi1: TMenuItem;
    actRecapitiSindacali: TAction;
    actSindacatiOrganizzazioni: TAction;
    Sindacati1: TMenuItem;
    actSindacatiOrganizzazioni1: TMenuItem;
    actSindacatiIscrizioni: TAction;
    Iscrizioniaisindacati1: TMenuItem;
    actSindacatiPartecipazioni: TAction;
    Partecipazioniaisindacati1: TMenuItem;
    actProfiliAttestatiMal: TAction;
    ProfiliimportazionecertificatiINPS1: TMenuItem;
    actImpRichRimb: TAction;
    actTipiPagamento: TAction;
    ipidipagamento1: TMenuItem;
    actRegistrazioneTrasferte: TAction;
    Registrazionetrasferte1: TMenuItem;
    actStampaTrasferte: TAction;
    Stampatrasferte1: TMenuItem;
    actAssenteismo: TAction;
    actParametrizzazioneStampaCartellino: TAction;
    Parametrizzazionestampadelcartellino1: TMenuItem;
    actDatiLiberiIterMissioni: TAction;
    Datiliberiitermissioni1: TMenuItem;
    N27: TMenuItem;
    ActTimbratureMensa: TAction;
    imbraturedimensa1: TMenuItem;
    actLayoutSchedaAnagrafica: TAction;
    Layoutschedaanagrafica1: TMenuItem;
    actSindacatiPermessi: TAction;
    Permessisindacali1: TMenuItem;
    actPartecipazioneScioperi: TAction;
    AssenteismoScioperi1: TMenuItem;
    AssenteismoeForzaLavoro1: TMenuItem;
    Partecipazionescioperi1: TMenuItem;
    actComuniMedLegali: TAction;
    Associazionecomunimedicinelegali1: TMenuItem;
    actTipoAbbattimenti: TAction;
    Incentivi1: TMenuItem;
    ipologiediabbattimentoincentivi1: TMenuItem;
    actValutaStr: TAction;
    Monetizzazioneoredistraordinario1: TMenuItem;
    actFPunteggiFasceIncentivi: TAction;
    Scaglioniggeffettiviincentivi1: TMenuItem;
    actScaglioniPT: TAction;
    actScaglioniGGEffettivi: TAction;
    actFScaglioniIncentivi: TAction;
    Scaglioniggeffettiviincentivi2: TMenuItem;
    Valutazioni1: TMenuItem;
    Scaglionivalutazioniperincentivi1: TMenuItem;
    actTipoQuote: TAction;
    ipologiequote1: TMenuItem;
    actCartolinaIncentivi: TAction;
    Cartolinaincentivi1: TMenuItem;
    N19: TMenuItem;
    actIncentiviMaturati: TAction;
    RiepilogoIncentivi1: TMenuItem;
    actQuoteIncentivazione: TAction;
    Quotediincentivazione1: TMenuItem;
    N28: TMenuItem;
    actIncentiviAssenze: TAction;
    Abbattimentoincentiviperassenze1: TMenuItem;
    actRegoleIncentivi: TAction;
    Regoleincentivi1: TMenuItem;
    actQuoteIndividuali: TAction;
    Quoteindividuali1: TMenuItem;
    actPunteggiValutazioni: TAction;
    PunteggiValutazioni1: TMenuItem;
    actGruppiIncentivi: TAction;
    Gruppipesatureschede1: TMenuItem;
    actAllineamentoBudget: TAction;
    Allineamentodelbudget1: TMenuItem;
    N29: TMenuItem;
    actParProtocollo: TAction;
    ParametrizzazioneProtocollazione1: TMenuItem;
    actSchedeQuantitativeIndividuali: TAction;
    Schedequantitativeindividuali1: TMenuItem;
    N30: TMenuItem;
    actComVisiteFiscali: TAction;
    Comunicazionevisitefiscali1: TMenuItem;
    actPesatureIndividuali: TAction;
    PesatureIndividuali1: TMenuItem;
    actStampaValutazioni: TAction;
    Elaborazioneschededivalutazione1: TMenuItem;
    actRegoleFluper: TAction;
    Flussistatistici1: TMenuItem;
    RegolefornituraFLUPER1: TMenuItem;
    actFornituraFluper: TAction;
    FornituraFLUPER1: TMenuItem;
    actStatiAvanzamento: TAction;
    Statiavanzamentovalutazioni1: TMenuItem;
    ElaborazionefornituraFLUPER1: TMenuItem;
    actMotivazioniRichieste: TAction;
    IrisWeb1: TMenuItem;
    Causaliperiterautorizzativi1: TMenuItem;
    actRegoleValutazioni: TAction;
    Regolevalutazioni1: TMenuItem;
    Contoannuale1: TMenuItem;
    actContoAnnRegole: TAction;
    actContoAnnRisRes: TAction;
    actContoAnnuale: TAction;
    actCalcolaContoAnnuale: TAction;
    Regolecontoannuale1: TMenuItem;
    Elaborazionecontoannuale1: TMenuItem;
    Risorseresiduecontoannuale1: TMenuItem;
    actProfiliAree: TAction;
    ProfiliValutazioni1: TMenuItem;
    actAreeValutazioni: TAction;
    Areeedelementidivalutazione1: TMenuItem;
    Contoannuale2: TMenuItem;
    actStampaSituazioneBudget: TAction;
    Stampasituazionedelbudget1: TMenuItem;
    actRaggrInterrogazioni: TAction;
    actRaggrInterrogazioni1: TMenuItem;
    actGestioneDocumentale: TAction;
    actRicercaDocumentale: TAction;
    mnuGestionedocumentale1: TMenuItem;
    mnuGestioneDocumentale: TMenuItem;
    mnuRicercaDocumentale: TMenuItem;
    actCalendarioOraLegaleSolare: TAction;
    CalendariooraLegaleSolare1: TMenuItem;
    actRelazioniTabelle: TAction;
    actRelazioniTabelle1: TMenuItem;
    actCategorieRimborsi: TAction;
    actCapitoliTrasferte: TAction;
    actCapitoliRimborso: TAction;
    N31: TMenuItem;
    Categorierimborsi1: TMenuItem;
    Capitolitrasferte1: TMenuItem;
    Capitolirimborso1: TMenuItem;
    actArchiviazioneCartellini: TAction;
    Archiviazionecartellini1: TMenuItem;
    actRegoleArchiviazioneDoc: TAction;
    N32: TMenuItem;
    Regolearchiviazionedocumenti1: TMenuItem;
    actRiepilogoIterAutorizzativi: TAction;
    Riepilogoiterautorizzativi1: TMenuItem;
    actMotivazioniProvvedimento: TAction;
    actSGProvvedimenti: TAction;
    N33: TMenuItem;
    Motivazioniprovvedimento1: TMenuItem;
    N34: TMenuItem;
    Gestioneprovvedimenti1: TMenuItem;
    actContoAnnRelTab: TAction;
    Relazionitabellecontoannuale1: TMenuItem;
    actNotificheIrisWEB: TAction;
    NotificheIrisWEB1: TMenuItem;
    actXMLVisiteFiscali: TAction;
    XMLvisitefiscali1: TMenuItem;
    actDatiAziendali: TAction;
    Configurazionedatiaziendali1: TMenuItem;
    actPubblicazioneDocumenti: TAction;
    N35: TMenuItem;
    Pubblicazionedocumenti1: TMenuItem;
    actFerieSolidali: TAction;
    Feriesolidali1: TMenuItem;
    actPianifPersConv: TAction;
    Pianificazionepersonaleconvenzionato1: TMenuItem;
    actImportazioneMassivaDocumenti: TAction;
    Importazionemassivadocumenti1: TMenuItem;
    actGestioneOrdiniProf: TAction;
    GestioneOrdiniprofessionali1: TMenuItem;
    actAreeTurni: TAction;
    Areeturni1: TMenuItem;
    actRiepilogoRapportiLavoro: TAction;
    Riepilogorapportidilavoro1: TMenuItem;
    actDatiAtipici: TAction;
    Datiatipici1: TMenuItem;
    actValidazionePeriodiGiuridici: TAction;
    Validazioneperiodigiuridiciautocertificati1: TMenuItem;
    actModelliCertificazione: TAction;
    Modellidicertificazione1: TMenuItem;
    actProfiliStampeRep: TAction;
    actCondizioniTurni: TAction;
    Condizioni1: TMenuItem;
    actGestioneBudget: TAction;
    Gestionedelbudget1: TMenuItem;
    Fondi1: TMenuItem;
    actMacrocategorieFondi: TAction;
    actRaggruppamentiFondi: TAction;
    actDefinizioneFondi: TAction;
    actCalcoloFondi: TAction;
    actMonitoraggioFondi: TAction;
    actStampaFondi: TAction;
    Macrocategoriefondi1: TMenuItem;
    Raggruppamentifondi1: TMenuItem;
    Definizionefondi1: TMenuItem;
    Calcoloconsumimensilifondi1: TMenuItem;
    Monitoraggiofondi1: TMenuItem;
    Stampafondi1: TMenuItem;
    actIterAutorizzativi: TAction;
    Iterautorizzativi1: TMenuItem;
    N36: TMenuItem;
  private
    //procedure CreaIconeMenuSceltaRapida;
  protected
    function CreaForm(PTag: Integer): TWR100FBase; override;
  end;

implementation

// includere qui tutte le unit utilizzate nel menu
uses
  WA002UAnagrafe, WA004UGiustifAssPres, WA006UModelliOrario, WA007UProfiliOrari,
  WA009UProfAsseAnn, WA010UProfAsseInd, WA012UCalendari, WA013UCalendIndiv,
  WA014UDebitiAggiuntivi, WA015UPlusOraIndiv, WA016UCausAssenze, WA017URaggrAsse,
  WA018URaggrPres, WA019URaggrGiustif, WA020UCausPresenze, WA021UCausGiustif,
  WA022UContratti, WA023UTimbrature, WA024UIndPresenza, WA025UPianif,
  WA027UCarMen, WA028USc, WA029USchedaRiepil, WA030UResidui, WA031UParScarico,
  WA032UScarico, WA033UStampaAnomalie, WA034UIntPaghe, WA035UParScaricoPaghe,
  WA036UTurniRep, WA037UScaricoPaghe, WA038UVociVariabili, WA039URegReperib,
  WA040UPianifRep, WA041UInsRiposi, WA042UStampaPreAss, WA043UStampaRep,
  WA045UStatAssenze, WA046UTerMensa, WA047UTimbMensa, WA048UPastiMese,
  WA049UStampaPasti, WA050UOrologi, WA051UTimbOrig, WA052UParCar,
  WA054UCicliTurni, WA055UTurnazioni, WA056UTurnazInd, WA057USpostSquadra,
  WA058UPianifTurni, WA059UContSquadre, WA060UTimbIrregolari, WA061UDettAssenze,
  WA062UQueryServizio, WA063UBudgetGenerazione, WA064UBudgetStraordinario, WA065UStampaBudget, WA066UValutaStr, WA067URepSostB,
  WA068UTurniGior, WA071URegoleBuoni, WA072UBuoniMese, WA073UAcquistoBuoni,
  WA074URiepilogoBuoni, WA075UFineAnno, WA076UIndGruppo, WA077UGeneratoreStampe,
  WA079UAssenzeAuto, WA080UTipologieCartellini, WA081UTimbCaus, WA082UCdcPercent,
  WA084UTipoRapporto, WA085UPartTime, WA086UMotivazioniRichieste,
  WA087UImpAttestatiMal, WA088UDatiLiberiIterMissioni , WA089URegIndPresenza,
  WA090UAssenzeAnno, WA091ULiquidPresenze, WA092UStampaStorico,
  WA094USkLimitiStraord, WA095UStRiasStr, WA096UProfiliLibProf,
  WA097UPianifLibProf, WA098UCalendarioOraLegaleSolare, WA100UMissioni,
  WA101URaggrInterrogazioni, WA102UParScaricoGiustif,
  WA103UScaricoGiust, WA104UStampaMissioni,WA105UStoricoGiustificativi,
  WA106UDistanzeTrasferta, WA107UInsAssAutoRegole, WA108UInsAssAuto,
  WA109UImmagini, WA110UParametriConteggio, WA111UParMessaggi,
  WA112UInvioMessaggi, WA115UIterAutorizzativi, WA116ULiquidazioneOreAnniPrec, WA117UOreLiquidateAnniPrec,
  WA118UPubblicazioneDocumenti,
  WA119UPartecipazioneScioperi, WA120UTipiRimborsi, WA121UOrganizzSindacali,
  WA122UIscrizioniSindacati, WA123UPartecipazioniSindacati, WA124UPermessiSindacali, WA125UBadgeServizio,
  WA126UBloccoRiepiloghi, WA127UTurniPrestazioniAggiuntive,
  WA128UPianPrestazioniAggiuntive, WA129UIndennitaKm, WA130UOraLegaleSolare,
  WA131UGestioneAnticipi, WA132UMagazzinoBuoniPasto, WA133UTariffeMissioni, WA138UAreeTurni,
  WA149UCategRimborsi, WA135UTimbratureScartate, WA137UCalcoloSpeseAccesso, WA141URegoleRiposi,
  WA142UQualifMInisteriali, WA143UMedicineLegali, WA144UComuniMedLegali,
  WA145UComVisiteFiscali, WA147URepVincoliIndividuali,
  WA148UProfiliImportazioneCertificatiINPS, WA150UAccorpamentoCausali,
  WA150UCodiciAccorpamentoCausali, WA151UAssenteismo, WA154UGestioneDocumentale,
  WA155URicercaDocumentale, WA156UNotificheIrisWEB, WA157UCapitoliTrasferte, WA158UCapitoliRimborso,
  WA159UArchiviazioneCartellini,
  WA160URegoleIncentivi, WA161UTipoAbbattimenti, WA162UIncentiviAssenze, WA163UTipoQuote, WA164UQuoteIncentivi, WA166UQuoteIndividuali, WA167URegistraIncentivi, WA168UIncentiviMaturati, WA169UPesatureIndividuali,
  WA171UXMLVisiteFiscali,
  WA170UGestioneGruppi, WA172USchedeQuantIndividuali, WA173UImportAssestamento,
  WA174UParPianifTurni, WA176URiepilogoIterAutorizzativi, WA177UFerieSolidali, WA178UPianifPersConv, WA188UCampiAnagrafe, WA189ULimitiEccedenzaLiq,
  WA190ULimitiEccedenzaRes, WA191UCampiRaggr, WA192UCaricaTimbRich,
  WA193UCaricaGiustRich, WA194URecapitiSindacali, WA195UImpRichRimborso,
  WA196UTipiPagamento, WA197ULayoutSchedaAnagr, WA199UCheckRimborsi,
  WA200UImportazioneMassivaDocumenti, WA202URapportiLavoro, WA203UDatiMensiliPersonalizzati, WA204UModelliCertificazione, WA205USquadre, WA206UCondizioniTurni, WA207UProfiliStampeRep,
  WA210URegoleArchiviazioneDoc,
  WP030UValute, WP032UCambi, WP050UArrotondamenti, WP150USetup, WP501UCudSetup,
  WP552URegoleContoAnnuale, WP553URisorseResidueContoAnnuale, WP554UElaborazioneContoAnnuale, WP555UContoAnnuale,
  WP651URelazioniTabelle, WP652UINPDAPMMRegole, WP655UDatiINPDAPMM,
  WP680UMacrocategorieFondi, WP682URaggruppamentiFondi, WP684UDefinizioneFondi, WP686UCalcoloFondi, WP688UMonitoraggioFondi,
  WP690UStampaFondi,
  L021Call, WR010UBase, IWGlobal,
  WS028UMotivazioni, WS030UProvvedimenti, WS031UFamiliari, WS130UOrdiniProfessionali,
  WS700UAreeValutazioni, WS715UStampaValutazioni, WS720UProfiliAree, WS730UPunteggiValutazioni, WS735UPunteggiFasceIncentivi, WS740URegoleValutazioni, WS746UStatiAvanzamento, WS750UParProtocollo;

{$R *.dfm}

function TWC502FMenuRilPreFM.CreaForm(PTag: Integer): TWR100FBase;
begin
  //(Self.Parent as TWR100FBase).Log('Traccia',Format('CreaForm %d',[FTag]));
  Result:=inherited;

  if Result <> nil then
  begin
  end
  else
  if PTag = actProfiliOrari.Tag then
    Result:=TWA007FProfiliOrari.Create(A000App)
  else if PTag = actProfiliAssenzeAnn.Tag then
    Result:=TWA009FProfAsseAnn.Create(A000App)
  else if PTag = actCompAsseInd.Tag then
    Result:=TWA010FProfAsseInd.Create(A000App)
  else if PTag = actCalendari.Tag then
    Result:=TWA012FCalendari.Create(A000App)
  else if PTag = actCalendarioOraLegaleSolare.Tag then
    Result:=TWA098FCalendarioOraLegaleSolare.Create(A000App)
  else if PTag = actDebitiAggiuntivi.Tag then
    Result:=TWA014FDebitiAggiuntivi.Create(A000App)
  else if PTag = actRaggrAssenze.Tag then
    Result:=TWA017FRaggrAsse.Create(A000App)
  else if PTag = actRaggrPres.Tag then
    Result:=TWA018FRaggrPres.Create(A000App)
  else if PTag = actRaggrGiustif.Tag then
    Result:=TWA019FRaggrGiustif.Create(A000App)
  else if PTag = actCausaliGiustif.Tag then
    Result:=TWA021FCausGiustif.Create(A000App)
  else if PTag = actContratti.Tag then
    Result:=TWA022FContratti.Create(A000App)
  else if PTag = actIndPresenza.Tag then
    Result:=TWA024FIndPresenza.Create(A000App)
  else if PTag = actCarMen.Tag then
    Result:=TWA027FCarMen.Create(A000App)
  else if PTag = actParScarico.Tag then
    Result:=TWA031FParScarico.Create(A000App)
  else if PTag = actParScaricoPaghe.Tag then
  begin
    (Self.Owner as TWR100FBase).SetParam('TIPOPAR',cParPaghe);
    Result:=TWA035FParScaricoPaghe.Create(A000App)
  end
  else if PTag = actOrologi.Tag then
    Result:=TWA050FOrologi.Create(A000App)
  else if PTag = actSquadre.Tag then
    Result:=TWA205FSquadre.Create(A000App)
  else if PTag = actCondizioniTurni.Tag then
    Result:=TWA206FCondizioniTurni.Create(A000App)
  else if PTag = actAreeTurni.Tag then
    Result:=TWA138FAreeTurni.Create(A000App)
  else if PTag = actRegoleBuoni.Tag then
    Result:=TWA071FRegoleBuoni.Create(A000App)
  else if PTag = actTipologieCartellini.Tag then
    Result:=TWA080FTipologieCartellini.Create(A000App)
  else if PTag = actTipoRapporto.Tag then
    Result:=TWA084FTipoRapporto.Create(A000App)
  else if PTag = actPartTime.Tag then
    Result:=TWA085FPartTime.Create(A000App)
  else if PTag = actParScaricoGiustif.Tag then
    Result:=TWA102FParScaricoGiustif.Create(A000App)
  else if PTag = actRegoleRiposi.Tag then
    Result:=TWA141FRegoleRiposi.Create(A000App)
  else if PTag = actQualificheMinisteriali.Tag then
    Result:=TWA142FQualifMinisteriali.Create(A000App)
  else if PTag = actMedicineLegali.Tag then
    Result:=TWA143FMedicineLegali.Create(A000App)
  else if PTag = actComVisiteFiscali.Tag then
    Result:=TWA145FComVisiteFiscali.Create(A000App)
  else if PTag = actRegIndPresenza.Tag then
    Result:=TWA089FRegIndPresenza.Create(A000App)
  else if PTag = actSchedaAnagrafica.Tag then
    Result:=TWA002FAnagrafe.Create(A000App)
  else if PTag = actCdcPercent.Tag then
    Result:=TWA082FCdcPercent.Create(A000App)
  else if PTag = actCartolinaMensa.Tag then
    Result:=TWA049FStampaPasti.Create(A000App)
  else if PTag = actRiepilogoBuoni.Tag then
    Result:=TWA074FRiepilogoBuoni.Create(A000App)
  else if PTag = actRegoleAccessiMensa.Tag then
    Result:=TWA046FTerMensa.Create(A000App)
  else if PTag = actRiepilogoMensileAM.Tag then
    Result:=TWA048FPastiMese.Create(A000App)
  else if PTag = actRiepilogoMensileBM.Tag then
    Result:=TWA072FBuoniMese.Create(A000App)
  else if PTag = actGestioneMagazzino.Tag then
    Result:=TWA132FMagazzinoBuoniPasto.Create(A000App)
  else if PTag = actScaricoPaghe.Tag then
    Result:=TWA037FScaricoPaghe.Create(A000App)
  else if PTag = actGestioneAcquisto.Tag then
    Result:=TWA073FAcquistoBuoni.Create(A000App)
  else if PTag = actAttivazioneVociVariabili.Tag then
    Result:=TWA034FIntPaghe.Create(A000App)
  else if PTag = actInterrogazioniServizio.Tag then
    Result:=TWA062FQueryServizio.Create(A000App)
  else if PTag = actRidefinizioneCampiAnagrafici.Tag then
    Result:=TWA188FCampiAnagrafe.Create(A000App)
  else if PTag = actPassaggioAnno.Tag then
    Result:=TWA075FFineAnno.Create(A000App)
  else if PTag = actResiduiAnnoPrecedente.Tag then
    Result:=TWA030FResidui.Create(A000App)
  else if PTag = actVociVariabiliScaricate.Tag then
    Result:=TWA038FVociVariabili.Create(A000App)
  else if PTag = actStampaAnomalie.Tag then
    Result:=TWA033FStampaAnomalie.Create(A000App)
  else if PTag = actCalendarioIndividuale.Tag then
    Result:=TWA013FCalendIndiv.Create(A000App)
  else if PTag = actPlusOrarioIndividuale.Tag then
    Result:=TWA015FPlusOraIndiv.Create(A000App)
  else if PTag = actTimbratureIrregolari.Tag then
    Result:=TWA060FTimbIrregolari.Create(A000App)
  else if PTag = actBadgeServizio.Tag then
    Result:=TWA125FBadgeServizio.Create(A000App)
  else if PTag = actTimbratureScartate.Tag then
    Result:=TWA135FTimbratureScartate.Create(A000App)
  else if PTag = actSicurezzaRiepiloghi.Tag then
    Result:=TWA126FBloccoRiepiloghi.Create(A000App)
  else if PTag = actCambioOraLegaleSolare.Tag then
    Result:=TWA130FOraLegaleSolare.Create(A000App)
  else if PTag = actGestioneImmagini.Tag then
    Result:=TWA109FImmagini.Create(A000App)
  else if PTag = actIndennitaGruppi.Tag then
    Result:=TWA076FIndGruppo.Create(A000App)
  else if PTag = actAcquisizioneTimbrature.Tag then
    Result:=TWA032FScarico.Create(A000App)
  else if PTag = actInserimentoRiposi.Tag then
    Result:=TWA041FInsRiposi.Create(A000App)
  else if PTag = actSchedaRiepilogativa.Tag then
    Result:=TWA029FSchedaRiepil.Create(A000App)
  else if PTag = actFamiliari.Tag then
    Result:=TWS031FFamiliari.Create(A000App)
  else if PTag = actCausaliAssenza.Tag then
    Result:=TWA016FCausAssenze.Create(A000App)
  else if PTag = actAcquisizioneGiustificativi.Tag then
    Result:=TWA103FScaricoGiust.Create(A000App)
  else if PTag = actCausaliPresenza.Tag then
    Result:=TWA020FCausPresenze.Create(A000App)
  else if PTag = actCodiciAccorpCausali.Tag then
    Result:=TWA150FCodiciAccorpamentoCausali.Create(A000App)
  else if PTag = actAccorpamentiCausali.Tag then
    Result:=TWA150FAccorpamentoCausali.Create(A000App)
  else if PTag = actOreLiquidateAnniPrec.Tag then
    Result:=TWA117FOreLiquidateAnniPrec.Create(A000App)
  else if PTag = actLimitiMensili.Tag then
    Result:=TWA094FSkLimitiStraord.Create(A000App)
  else if PTag = actCampiRaggr.Tag then
    Result:=TWA191FCampiRaggr.Create(A000App)
  else if PTag = actLimitiEccLiq.Tag then
    Result:=TWA189FLimitiEccedenzaLiq.Create(A000App)
  else if PTag = actLimitiEccRes.Tag then
    Result:=TWA190FLimitiEccedenzaRes.Create(A000App)
  else if PTag = actPianificazione.Tag then
    Result:=TWA025FPianif.Create(A000App)
  else if PTag = actLiqOreCau.Tag then
    Result:=TWA091FLiquidPresenze.Create(A000App)
  else if PTag = actModelliOrario.Tag then
    Result:=TWA006FModelliOrario.Create(A000App)
  else if PTag = actAssenzeIndividuali.Tag then
    Result:=TWA061FDettAssenze.Create(A000App)
  else if PTag = actStatisticaMinisterialeAssenze.Tag then
    Result:=TWA045FStatAssenze.Create(A000App)
  else if PTag = actLiquidazioneAutomaticaStr.Tag then
    Result:=TWA095FStRiasStr.Create(A000App)
  else if PTag = actGiustifAssPres.Tag then
  begin
    Result:=TWA004FGiustifAssPres.Create(A000App);
    Result.SetParam('GESTIONESINGOLA','S');
  end
  else if PTag = actInserimentoGiust.Tag then
  begin
    Result:=TWA004FGiustifAssPres.Create(A000App);
    Result.SetParam('GESTIONESINGOLA','N');
  end
  else if PTag = actRegoleTurniRep.Tag then
    Result:=TWA039FRegReperib.Create(A000App)
  else if PTag = actVincoliReperibilita.Tag then
  begin
    Result:=TWA147FRepVincoliIndividuali.Create(A000App);
    Result.SetParam('Tipologia','REPERIB');
  end
  else if PTag = actVincoliGuardia.Tag then
  begin
    Result:=TWA147FRepVincoliIndividuali.Create(A000App);
    Result.SetParam('Tipologia','GUARDIA');
  end
  else if PTag = actPianificazioneTurniRep.Tag then
  begin
    Result:=TWA040FPianifRep.Create(A000App);
    Result.SetParam('Tipologia','REPERIB');
  end
  else if PTag = actPianificazioneTurniGuardia.Tag then
  begin
    Result:=TWA040FPianifRep.Create(A000App);
    Result.SetParam('Tipologia','GUARDIA');
  end
  else if PTag = actProfiliStampeRep .Tag then
    Result:=TWA207FProfiliStampeRep.Create(A000App)
  else if PTag = actCartellinoReperibilita.Tag then
    Result:=TWA043FStampaRep.Create(A000App)
  else if PTag = actRiepilogoReperibilita.Tag then
    Result:=TWA036FTurniRep.Create(A000App)
  else if PTag = actTurniRepSostitutivi.Tag then
    Result:=TWA067FRepSostB.Create(A000App)
  else if PTag = actImpAttestatiMal.Tag then
    Result:=TWA087FImpAttestatiMal.Create(A000App)
  else if PTag = actXMLVisiteFiscali.Tag then
    Result:=TWA171FXMLVisiteFiscali.Create(A000App)
  else if PTag = actCartellino.Tag then
    Result:=TWA023FTimbrature.Create(A000App)
  else if PTag = actElaboraOmesseTimbrature.Tag then
    Result:=TWA192FCaricaTimbRich.Create(A000App)
  else if PTag = actDefinizioneProfiliLP.Tag then
    Result:=TWA096FProfiliLibProf.Create(A000App)
  else if PTag = actPianificazioneAttivitaLP.Tag then
    Result:=TWA097FPianifLibProf.Create(A000App)
  else if PTag = actElencoPresentiAssenti.Tag then
    Result:=TWA042FStampaPreAss.Create(A000App)
  else if PTag = actConteggiServizio.Tag then
    Result:=TWA028FSc.Create(A000App)
  else if PTag = actRegoleTurniPrestAgg.Tag then
    Result:=TWA127FTurniPrestazioniAggiuntive.Create(A000App)
  else if PTag = actPianifPrestAgg.Tag then
    Result:=TWA128FPianPrestazioniAggiuntive.Create(A000App)
  else if PTag = actElencoStorici.Tag then
    Result:=TWA092FStampaStorico.Create(A000App)
  else if PTag = actStampaTimbratureOriginali.Tag then
    Result:=TWA051FTimbOrig.Create(A000App)
  else if PTag = actSchedaAnnualeAssenze.Tag then
    Result:=TWA090FAssenzeAnno.Create(A000App)
  else if PTag = actPrenotazionePasti.Tag then
    Result:=TWA081FTimbCaus.Create(A000App)
  else if PTag = actImportazioneAssestamentoOre.Tag then
    Result:=TWA173FImportAssestamento.Create(A000App)
  else if pTag = actDatiAziendali.Tag then
    Result:=TWP501FCudSetup.Create(A000App)
  else if PTag = actSetupValute.Tag then
    Result:=TWP150FSetup.Create(A000App)
  else if PTag = actValute.Tag then
    Result:=TWP030FValute.Create(A000App)
  else if PTag = actInserimentoAutomaticoAssenze.Tag then
    Result:=TWA079FAssenzeAuto.Create(A000App)
  else if PTag = actArrotondamentiValute.Tag then
    Result:=TWP050FArrotondamenti.Create(A000App)
  else if PTag = actCambiValute.Tag then
    Result:=TWP032FCambi.Create(A000App)
  else if PTag = actRegoleMissioni.Tag then
    Result:=TWA110FParametriConteggio.Create(A000App)
  else if PTag = actGeneratoreStampe.Tag then
    Result:=TWA077FGeneratoreStampe.Create(A000App)
  else if PTag = actLiqOreAnniPrec.Tag then
    Result:=TWA116FLiquidazioneOreAnniPrec.Create(A000App)
  else if PTag = actCompensazioneAutomaticaRegole.Tag then
    Result:=TWA107FInsAssAutoRegole.Create(A000App)
  else if PTag = actTipiRimborso.Tag then
    Result:=TWA120FTipiRimborsi.Create(A000App)
  else if PTag = actCompensazioneAutomatica.Tag then
    Result:=TWA108FInsAssAuto.Create(A000App)
  else if PTag = actCaricaGiustRich.Tag then
    Result:=TWA193FCaricaGiustRich.Create(A000App)
  else if PTag = actCompensazioneAutomatica.Tag then
    Result:=TWA108FInsAssAuto.Create(A000App)
  else if PTag = actIndennitaKM.Tag then
    Result:=TWA129FIndennitaKm.Create(A000App)
  else if PTag = actCicli.Tag then
    Result:=TWA054FCicliTurni.Create(A000App)
  else if PTag = actTariffeTrasferte.Tag then
    Result:=TWA133FTariffeMissioni.Create(A000App)
  else if PTag = actCategorieRimborsi.Tag then
    Result:=TWA149FCategRimborsi.Create(A000App)
  else if PTag = actTurnazioni.Tag then
    Result:=TWA055FTurnazioni.Create(A000App)
  else if PTag = actTurnazioniIndividuali.Tag then
    Result:=TWA056FTurnazInd.Create(A000App)
  else if PTag = actDistanzeChilometriche.Tag then
    Result:=TWA106FDistanzeTrasferta.Create(A000App)
  else if PTag = actSpostamentiSquadra.Tag then
    Result:=TWA057FSpostSquadra.Create(A000App)
  else if PTag = actParPianifTurni.Tag then
    Result:=TWA174FParPianifTurni.Create(A000App)
  else if PTag = actControlloPianificazione.Tag then
    Result:=TWA059FContSquadre.Create(A000App)
  else if PTag = actSituazioneGiornaliera.Tag then
    Result:=TWA068FTurniGior.Create(A000App)
  else if PTag = actGestioneAnticipi.Tag then
    Result:=TWA131FGestioneAnticipi.Create(A000App)
  else if PTag = actPianificazioneTI.Tag then
    Result:=TWA058FPianifTurni.Create(A000App)
  else if PTag = actStoricoGiustificativi.Tag then
    Result:=TWA105FStoricoGiustificativi.Create(A000App)
  else if PTag = actCalcoloSpeseAccesso.Tag then
    Result:=TWA137FCalcoloSpeseAccesso.Create(A000App)
  else if PTag = actMsgOrologiStrutture.Tag then
    Result:=TWA111FParMessaggi.Create(A000App)
  else if PTag = actMsgOrologiCreazione.Tag then
    Result:=TWA112FInvioMessaggi.Create(A000App)
  else if PTag = actRecapitiSindacali.Tag then
    Result:=TWA194FRecapitiSindacali.Create(A000App)
  else if PTag = actSindacatiOrganizzazioni.Tag then
    Result:=TWA121FOrganizzSindacali.Create(A000App)
  else if PTag = actSindacatiIscrizioni.Tag then
    Result:=TWA122FIscrizioniSindacati.Create(A000App)
  else if PTag = actSindacatiPartecipazioni.Tag then
    Result:=TWA123FPartecipazioniSindacati.Create(A000App)
  else if PTag = actProfiliAttestatiMal.Tag then
    Result:=TWA148FProfiliImportazioneCertificatiINPS.Create(A000App)
  else if PTag = actImpRichRimb.Tag then
    Result:=TWA195FImpRichRimborso.Create(A000App)
  else if PTag = actTipiPagamento.Tag then
    Result:=TWA196FTipiPagamento.Create(A000App)
  else if PTag = actRegistrazioneTrasferte.Tag then
    Result:=TWA100FMissioni.Create(A000App)
  else if PTag = actStampaTrasferte.Tag then
    Result:=TWA104FStampaMissioni.Create(A000App)
  else if PTag = actCapitoliTrasferte.Tag then
    Result:=TWA157FCapitoliTrasferte.Create(A000App)
  else if PTag = actCapitoliRimborso.Tag then
    Result:=TWA158FCapitoliRimborso.Create(A000App)
  else if PTag = actAssenteismo.Tag then
    Result:=TWA151FAssenteismo.Create(A000App)
  else if PTag = actParametrizzazioneStampaCartellino.Tag then
    Result:=TWA052FParCar.Create(A000App)
  else if PTag = actRaggrInterrogazioni.Tag then
    Result:=TWA101FRaggrInterrogazioni.Create(A000App)
  else if PTag = actDatiLiberiIterMissioni.Tag then
    Result:=TWA088FDatiLiberiIterMissioni.Create(A000App)
  else if PTag = actPartecipazioneScioperi.Tag then
    Result:=TWA119FPartecipazioneScioperi.Create(A000App)
  else if PTag = ActTimbratureMensa.Tag then
    Result:=TWA047FTimbMensa.Create(A000App)
  else if PTag = actLayoutSchedaAnagrafica.Tag then
    Result:=TWA197FLayoutSchedaAnagr.Create(A000App)
  else if PTag = actSindacatiPermessi.Tag then
    Result:=TWA124FPermessiSindacali.Create(A000App)
  else if PTag = actCheckRimborsi.Tag then
    Result:=TWA199FCheckRimborsi.Create(A000App)
  else if PTag = actComuniMedLegali.Tag then
    Result:=TWA144FComuniMedLegali.Create(A000App)
  else if PTag = actTipoAbbattimenti.Tag then
    Result:=TWA161FTipoAbbattimenti.Create(A000App)
  else if PTag = actAllineamentoBudget.Tag then
    Result:=TWA063FBudgetGenerazione.Create(A000App)
  else if PTag = actStampaSituazioneBudget.Tag then
    Result:=TWA065FStampaBudget.Create(A000App)
  else if PTag = actValutaStr.Tag then
    Result:=TWA066FValutaStr.Create(A000App)
  else if PTag = actScaglioniPT.Tag then
  begin
    Result:=TWS735FPunteggiFasceIncentivi.Create(A000App);
    Result.Tag:=PTag;
    Result.SetParam('Tipo','I');//Tag=205
  end
  else if PTag = actScaglioniGGEffettivi.Tag then
  begin
    Result:=TWS735FPunteggiFasceIncentivi.Create(A000App);
    Result.Tag:=PTag;
    Result.SetParam('Tipo','G');//Tag=211
  end
  else if PTag = actFScaglioniIncentivi.Tag then
  begin
    Result:=TWS735FPunteggiFasceIncentivi.Create(A000App);
    Result.Tag:=PTag;
    Result.SetParam('Tipo','V');//Tag=353
  end
  else if PTag = actTipoQuote.Tag then
    Result:=TWA163FTipoQuote.Create(A000App)
  else if PTag = actCartolinaIncentivi.Tag then
    Result:=TWA167FRegistraIncentivi.Create(A000App)
  else if PTag = actIncentiviMaturati.Tag then
    Result:=TWA168FIncentiviMaturati.Create(A000App)
  else if PTag = actQuoteIncentivazione.Tag then
    Result:=TWA164FQuoteIncentivi.Create(A000App)
  else if PTag = actIncentiviAssenze.Tag then
    Result:=TWA162FIncentiviAssenze.Create(A000App)
  else if PTag = actRegoleIncentivi.Tag then
    Result:=TWA160FRegoleIncentivi.Create(A000App)
  { DONE : TEST IW 14 OK }
  else if PTag = actQuoteIndividuali.Tag then
    Result:=TWA166FQuoteIndividuali.Create(A000App)
  else if PTag = actPunteggiValutazioni.Tag then
    Result:=TWS730FPunteggiValutazioni.Create(A000App)
  else if PTag = actGruppiIncentivi.Tag then
    Result:=TWA170FGestioneGruppi.Create(A000App)
  else if PTag = actParProtocollo.Tag then
    Result:=TWS750FParProtocollo.Create(A000App)
  else if PTag = actSchedeQuantitativeIndividuali.Tag then
    Result:=TWA172FSchedeQuantIndividuali.Create(A000App)
  else if PTag = actPesatureIndividuali.Tag then
    Result:=TWA169FPesatureIndividuali.Create(A000App)
  else if PTag = actStatiAvanzamento.Tag then
    Result:=TWS746FStatiAvanzamento.Create(A000App)
  else if PTag = actStampaValutazioni.Tag then
    Result:=TWS715FStampaValutazioni.Create(A000App)
  else if PTag = actMacrocategorieFondi.Tag then
    Result:=TWP680FMacrocategorieFondi.Create(A000App)
  else if PTag = actRaggruppamentiFondi.Tag then
    Result:=TWP682FRaggruppamentiFondi.Create(A000App)
  else if PTag = actDefinizioneFondi.Tag then
    Result:=TWP684FDefinizioneFondi.Create(A000App)
  else if PTag = actCalcoloFondi.Tag then
    Result:=TWP686FCalcoloFondi.Create(A000App)
  else if PTag = actMonitoraggioFondi.Tag then
    Result:=TWP688FMonitoraggioFondi.Create(A000App)
  else if PTag = actStampaFondi.Tag then
    Result:=TWP690FStampaFondi.Create(A000App)
  else if PTag = actRelazioniTabelle.Tag then
  begin
    Result:=TWP651FRelazioniTabelle.Create(A000App);
    Result.Tag:=PTag;
    Result.SetParam('TIPOFLUSSO','FL');
  end
  else if PTag = actRegoleFluper.Tag then
  begin
    Result:=TWP652FINPDAPMMRegole.Create(A000App);
    Result.SetParam('TAG',IntToStr(actRegoleFluper.Tag));
    Result.SetParam('FLUSSO',FLUSSO_FLUPER);
  end
  else if PTag = actFornituraFluper.Tag then
  begin
    Result:=TWP655FDatiINPDAPMM.Create(A000App);
    Result.SetParam('TAG',IntToStr(actFornituraFluper.Tag));
    Result.SetParam('FLUSSO',FLUSSO_FLUPER);
  end
  else if PTag = actMotivazioniRichieste.Tag then
    Result:=TWA086FMotivazioniRichieste.Create(A000App)
  else if PTag = actRegoleValutazioni.Tag then
    Result:=TWS740FRegoleValutazioni.Create(A000App)
  else if PTag = actContoAnnRelTab.Tag then
  begin
    Result:=TWP651FRelazioniTabelle.Create(A000App);
    Result.Tag:=PTag;
    Result.SetParam('TIPOFLUSSO','CA');
  end
  else if PTag = actContoAnnRegole.Tag then
  begin
    Result:=TWP552FRegoleContoAnnuale.Create(A000App);
  end
  else if PTag = actContoAnnRisRes.Tag then
  begin
    Result:=TWP553FRisorseResidueContoAnnuale.Create(A000App);
  end
  else if PTAg = actContoAnnuale.Tag then
  begin
    Result:=TWP555FContoAnnuale.Create(A000App);
  end  
  { DONE : TEST IW 14 OK }
  else if PTag = actCalcolaContoAnnuale.Tag then
  begin
    Result:=TWP554FElaborazioneContoAnnuale.Create(A000App);
    //Result.SetParam('',...);
  end
  else if PTag = actProfiliAree.Tag then
    Result:=TWS720FProfiliAree.Create(A000App)
  else if PTag = actAreeValutazioni.Tag then
    Result:=TWS700FAreeValutazioni.Create(A000App)
  else if PTag = actGestioneDocumentale.Tag then
    Result:=TWA154FGestioneDocumentale.Create(A000App)
  else if PTag = actRicercaDocumentale.Tag then
    Result:=TWA155FRicercaDocumentale.Create(A000App)
  else if PTag = actArchiviazioneCartellini.Tag then
    Result:=TWA159FArchiviazioneCartellini.Create(A000App)
  else if PTag = actRegoleArchiviazioneDoc.Tag then
    Result:=TWA210FRegoleArchiviazioneDoc.Create(A000App)
  else if PTag = actRiepilogoIterAutorizzativi.Tag then
    Result:=TWA176FRiepilogoIterAutorizzativi.Create(A000App)
  else if PTag = actIterAutorizzativi.Tag then
    Result:=TWA115FIterAutorizzativi.Create(A000App)
  else if PTag = actFerieSolidali.Tag then
    Result:=TWA177FFerieSolidali.Create(A000App)
  else if PTag = actPianifPersConv.Tag then
    Result:=TWA178FPianifPersConv.Create(A000App)
  else if PTag = actMotivazioniProvvedimento.Tag then
    Result:=TWS028FMotivazioni.Create(A000App)
  else if PTag = actSGProvvedimenti.Tag then
    Result:=TWS030FProvvedimenti.Create(A000App)
  else if PTag = actNotificheIrisWEB.Tag then
    Result:=TWA156FNotificheIrisWEB.Create(A000App)
  else if PTag = actPubblicazioneDocumenti.Tag then
    Result:=TWA118FPubblicazioneDocumenti.Create(A000App)
  else if PTag = actImportazioneMassivaDocumenti.Tag then
    Result:=TWA200FImportazioneMassivaDocumenti.Create(A000App)
  else if PTag = actGestioneOrdiniProf.Tag then
    Result:=TWS130FOrdiniProfessionali.Create(A000App)
  else if PTag = actRiepilogoRapportiLavoro.Tag then
  begin
    Result:=TWA202FRapportiLavoro.Create(A000App);
    Result.SetParam('MODALITA', '0'); //TA202Modalita: PASSENZE
  end
  else if PTag = actValidazionePeriodiGiuridici.Tag then
  begin
    Result:=TWA202FRapportiLavoro.Create(A000App);
    Result.SetParam('MODALITA', '1'); //TA202Modalita: VALIDAZIONE
  end
  else if PTag = actDatiAtipici.Tag then
    Result:=TWA203FDatiMensiliPersonalizzati.Create(A000App)
  else if PTag = actModelliCertificazione.Tag then
    Result:=TWA204FModelliCertificazione.Create(A000App)
  else if PTag = actGestioneBudget.Tag then
    Result:=TWA064FBudgetStraordinario.Create(A000App);

  if Result = nil then
    (Self.Parent as TWR100FBase).Log('Traccia',Format('ERRORE CreaForm %d',[PTag]));
end;

end.
