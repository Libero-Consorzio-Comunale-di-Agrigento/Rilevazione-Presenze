unit WC504UMenuStagiuFM;

{ DONE : TEST IW 14 OK }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR207UMenuWebPJFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompMenu, meIWMenu, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  ImgList, meIWImageList, IWImageList, Menus, ActnList, System.Actions,
  WR100UBase, A000UCostanti;

type
  TWC504FMenuStagiuFM = class(TWR207FMenuWebPJFM)
    actSchedaAnagrafica: TAction;
    Schedaanagrafica1: TMenuItem;
    actRidefinizioneCampiAnagrafici: TAction;
    Ridefinizionecampianagrafici1: TMenuItem;
    actCausaliAssenza: TAction;
    Causali1: TMenuItem;
    Causalidiassenza1: TMenuItem;
    actRaggrAssenze: TAction;
    Raggruppamentidiassenza1: TMenuItem;
    actTipoRapporto: TAction;
    ipidirapporto1: TMenuItem;
    actQualificheMinisteriali: TAction;
    Qualificheministeriali1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    actAccorpamentiCausali: TAction;
    Accorpamenticausalidiassenza1: TMenuItem;
    actGiustifAssPres: TAction;
    Giustificativiasspres1: TMenuItem;
    actCdcPercent: TAction;
    Centridicostopercentualizzati1: TMenuItem;
    actFamiliari: TAction;
    Familiari1: TMenuItem;
    actStatisticaMinisterialeAssenze: TAction;
    Elaborazioni1: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    Statisticaministerialeassenze1: TMenuItem;
    actAssenzeIndividuali: TAction;
    Elencoassenzeindividuali1: TMenuItem;
    actInterrogazioniServizio: TAction;
    Interrogazionidiservizio1: TMenuItem;
    actRaggrInterrogazioni: TAction;
    Raggruppamentiinterrogazionidiservizio1: TMenuItem;
    actElencoStorici: TAction;
    Elencomovimentistorici1: TMenuItem;
    actStoricoGiustificativi: TAction;
    Storicogiustificativi1: TMenuItem;
    actLayoutSchedaAnagrafica: TAction;
    Layoutschedaanagrafica1: TMenuItem;
    Flussistatistici1: TMenuItem;
    ElaborazionefornituraFLUPER1: TMenuItem;
    actResiduiAnnoPrecedente: TAction;
    Residuiannoprecedente1: TMenuItem;
    actCompAsseInd: TAction;
    Competenzeassenzeindividuali1: TMenuItem;
    actCalendarioIndividuale: TAction;
    Calendarioindividuale1: TMenuItem;
    actInserimentoGiust: TAction;
    Inserimentogiustificativicollettivi1: TMenuItem;
    actSchedaAnnualeAssenze: TAction;
    Schedaannualeassenze1: TMenuItem;
    actPassaggioAnno: TAction;
    Passaggiodianno1: TMenuItem;
    actGeneratoreStampe: TAction;
    Generatoredistampe1: TMenuItem;
    actPartTime: TAction;
    Parttime1: TMenuItem;
    actCalendari: TAction;
    Calendari1: TMenuItem;
    actProfiliAssenzeAnn: TAction;
    Profiliassenzeannuali1: TMenuItem;
    actCausaliPresenza: TAction;
    N16: TMenuItem;
    Causalidipresenza1: TMenuItem;
    actRaggrPres: TAction;
    Raggruppamentidipresenza1: TMenuItem;
    actFornituraFluper: TAction;
    FornituraFLUPER1: TMenuItem;
    actRelazioniTabelle: TAction;
    RelazionitabelleFLUPER1: TMenuItem;
    actRegoleFluper: TAction;
    RegolefornituraFLUPER1: TMenuItem;
    Contoannuale1: TMenuItem;
    actContoAnnuale: TAction;
    Contoannuale2: TMenuItem;
    actCalcolaContoAnnuale: TAction;
    Elaborazionecontoannuale1: TMenuItem;
    actContoAnnRegole: TAction;
    Regolecontoannuale1: TMenuItem;
    actContoAnnRisRes: TAction;
    Risorseresiduecontoannuale1: TMenuItem;
    N17: TMenuItem;
    actAssenteismo: TAction;
    AssenteismoeForzaLavoro1: TMenuItem;
    actRegoleValutazioni: TAction;
    Valutazioni1: TMenuItem;
    Regolevalutazioni1: TMenuItem;
    actStatiAvanzamento: TAction;
    Statiavanzamentovalutazioni1: TMenuItem;
    actAreeValutazioni: TAction;
    Areeedelementidivalutazione1: TMenuItem;
    actProfiliAree: TAction;
    Profilivalutazioni1: TMenuItem;
    actPunteggiValutazioni: TAction;
    Punteggivalutazioni1: TMenuItem;
    actFScaglioniIncentivi: TAction;
    Scaglionivalutazioniperincentivi1: TMenuItem;
    actParProtocollo: TAction;
    Parametrizzazioneprotocollazione1: TMenuItem;
    actStampaValutazioni: TAction;
    Elaborazioneschededivalutazione1: TMenuItem;
    Incarichi1: TMenuItem;
    actVerificheIndennita: TAction;
    Verificheindennita1: TMenuItem;
    actTipologieRischi: TAction;
    Rischieprescrizioni1: TMenuItem;
    Tipologierischievisite1: TMenuItem;
    actTipologiePrescrizioni: TAction;
    Tipologieprescrizioni1: TMenuItem;
    actTipologieAttivita: TAction;
    Tipologieattivit1: TMenuItem;
    actTipologieEsposizione: TAction;
    Tipologieesposizioni1: TMenuItem;
    actCessazioniRischi: TAction;
    Motivazionicessazionerischi1: TMenuItem;
    actGestioneRischi: TAction;
    Gestionerischieprescrizioni1: TMenuItem;
    actStampaRischi: TAction;
    Stampaperiodirischio1: TMenuItem;
    actTipoDocumenti: TAction;
    ipologiedocumenti1: TMenuItem;
    actMotivazioniProvvedimento: TAction;
    Motivazioniprovvedimento1: TMenuItem;
    actTipoEsperienze: TAction;
    Curriculum1: TMenuItem;
    ipologieesperienze1: TMenuItem;
    actDettaglioEsperienze: TAction;
    Dettaglioesperienze1: TMenuItem;
    actDefinizioneVariabili: TAction;
    Certificazione1: TMenuItem;
    Definizionedatiliberi2: TMenuItem;
    actCategorieIncarichi: TAction;
    Incarichi2: TMenuItem;
    actCategorieIncarichi1: TMenuItem;
    actTipiIncarichi: TAction;
    ipiincarichi1: TMenuItem;
    actIncarichiAziendali: TAction;
    Incarichiaziendali1: TMenuItem;
    actTipiVerifiche: TAction;
    N18: TMenuItem;
    ipologieverifiche1: TMenuItem;
    actCommissioni: TAction;
    Commissioni1: TMenuItem;
    actComponentiCommissioni: TAction;
    Componentidellecommissioni1: TMenuItem;
    actGestioneIncarichi: TAction;
    Gestioneincarichi1: TMenuItem;
    N19: TMenuItem;
    actSGProvvedimenti: TAction;
    Gestioneprovvedimenti1: TMenuItem;
    actAllineamentoIncarichi: TAction;
    Allineamentoincarichi1: TMenuItem;
    actContoAnnRelTab: TAction;
    Relazionitabellecontoannuale1: TMenuItem;
    Piantaorganica1: TMenuItem;
    actEstremiStruttura: TAction;
    Estremistrutturaatti1: TMenuItem;
    actRiepilogoIncarichi: TAction;
    Riepilogoincarichi1: TMenuItem;
    actImportazioneMassivaDocumenti: TAction;
    actGestioneDocumentale: TAction;
    actRicercaDocumentale: TAction;
    Gestionedocumentale1: TMenuItem;
    Gestionedocumentale2: TMenuItem;
    Ricercadocumentale1: TMenuItem;
    Importazionemassivadocumenti1: TMenuItem;
    actVisualizzazionePianta: TAction;
    Visualizzazionepiantaorganica1: TMenuItem;
    actStampaSituazioneOrganico: TAction;
    Stampasituazioneorganico1: TMenuItem;
    Distribuzioneorganico1: TMenuItem;
    actSituazioneOrganico: TAction;
    actGestioneOrdiniProf: TAction;
    GestioneOrdiniprofessionali1: TMenuItem;
    actSGStampaCertificati: TAction;
    Stampamodellirtf1: TMenuItem;
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    function CreaForm(PTag: Integer): TWR100FBase; override;
  end;

implementation

uses
  WA002UAnagrafe,
  WA004UGiustifAssPres,
  WA009UProfAsseAnn,
  WA010UProfAsseInd,
  WA012UCalendari,
  WA013UCalendIndiv,
  WA016UCausAssenze,
  WA017URaggrAsse,
  WA018URaggrPres,
  WA020UCausPresenze,
  WA030UResidui,
  WA045UStatAssenze,
  WA061UDettAssenze,
  WA062UQueryServizio,
  WA075UFineAnno,
  WA077UGeneratoreStampe,
  WA082UCdcPercent,
  WA084UTipoRapporto,
  WA085UPartTime,
  WA090UAssenzeAnno,
  WA092UStampaStorico,
  WA101URaggrInterrogazioni,
  WA105UStoricoGiustificativi,
  WA142UQualifMInisteriali,
  WA150UAccorpamentoCausali,
  WA151UAssenteismo,
  WA154UGestioneDocumentale,
  WA155URicercaDocumentale,
  WA188UCampiAnagrafe,
  WA197ULayoutSchedaAnagr,
  WA200UImportazioneMassivaDocumenti,
  WP552URegoleContoAnnuale,
  WP553URisorseResidueContoAnnuale,
  WP554UElaborazioneContoAnnuale,
  WP555UContoAnnuale,
  WP651URelazioniTabelle,
  WP652UINPDAPMMRegole,
  WP655UDatiINPDAPMM,
  WS026UDatiLiberi,
  WS027UTipoDocumenti,
  WS028UMotivazioni,
  WS030UProvvedimenti,
  WS031UFamiliari,
  WS101UStampaCert,
  WS108UTipoEsperienze,
  WS109UDettaglioEsperienze,
  WS130UOrdiniProfessionali,
  WS200UEstremiStruttura,
  WS201UDistribuzioneOrganico,
  WS202UVisualizzazionePianta,
  WS203UStampaPiantaOrganica,
  WS300UCategorieIncarichi,
  WS301UTipiIncarichi,
  WS302UIncarichiAziendali,
  WS303UIncarichiIndividuali,
  WS304URiepilogoIncarichi,
  WS305UCommissioni,
  WS306UComponentiCommissioni,
  WS308UIndennitaInc,
  WS309UTipiVerifiche,
  WS310UAllineamentoIncarichi,
  WS400UTipologieRischi,
  WS401UCessazioniRischi,
  WS402UGestioneRischi,
  WS403UTipologiePrescrizioni,
  WS404UStampaRischi,
  WS405UTipoAttivita,
  WS406UTipoEsposizione,
  WS700UAreeValutazioni,
  WS715UStampaValutazioni,
  WS720UProfiliAree,
  WS730UPunteggiValutazioni,
  WS735UPunteggiFasceIncentivi,
  WS740URegoleValutazioni,
  WS746UStatiAvanzamento,
  WS750UParProtocollo;

{$R *.dfm}

function TWC504FMenuStagiuFM.CreaForm(PTag: Integer): TWR100FBase;
begin
  (Self.Parent as TWR100FBase).Log('Traccia',Format('CreaForm %d',[FTag]));

  Result:=inherited;

  //CONDIVISI
  if PTag = actRidefinizioneCampiAnagrafici.Tag then
    Result:=TWA188FCampiAnagrafe.Create(A000App)
  else if PTag = actCausaliAssenza.Tag then
    Result:=TWA016FCausAssenze.Create(A000App)
  else if PTag = actRaggrAssenze.Tag then
    Result:=TWA017FRaggrAsse.Create(A000App)
  else if PTag = actTipoRapporto.Tag then
    Result:=TWA084FTipoRapporto.Create(A000App)
  else if PTag = actQualificheMinisteriali.Tag then
    Result:=TWA142FQualifMinisteriali.Create(A000App)
  else if PTag = actAccorpamentiCausali.Tag then
    Result:=TWA150FAccorpamentoCausali.Create(A000App)
  else if PTag = actSchedaAnagrafica.Tag then
    Result:=TWA002FAnagrafe.Create(A000App)
  else if PTag = actGiustifAssPres.Tag then
  begin
    Result:=TWA004FGiustifAssPres.Create(A000App);
    Result.SetParam('GESTIONESINGOLA','S');
  end
  else if PTag = actCdcPercent.Tag then
    Result:=TWA082FCdcPercent.Create(A000App)
  else if PTag = actFamiliari.Tag then
    Result:=TWS031FFamiliari.Create(A000App)
  else if PTag = actStatisticaMinisterialeAssenze.Tag then
    Result:=TWA045FStatAssenze.Create(A000App)
  else if PTag = actAssenzeIndividuali.Tag then
    Result:=TWA061FDettAssenze.Create(A000App)
  else if PTag = actInterrogazioniServizio.Tag then
    Result:=TWA062FQueryServizio.Create(A000App)
  else if PTag = actRaggrInterrogazioni.Tag then
    Result:=TWA101FRaggrInterrogazioni.Create(A000App)
  else if PTag = actElencoStorici.Tag then
    Result:=TWA092FStampaStorico.Create(A000App)
  else if PTag = actStoricoGiustificativi.Tag then
    Result:=TWA105FStoricoGiustificativi.Create(A000App)
  else if PTag = actLayoutSchedaAnagrafica.Tag then
    Result:=TWA197FLayoutSchedaAnagr.Create(A000App)
  else if PTag = actResiduiAnnoPrecedente.Tag then
    Result:=TWA030FResidui.Create(A000App)
  else if PTag = actCompAsseInd.Tag then
    Result:=TWA010FProfAsseInd.Create(A000App)
  else if PTag = actCalendarioIndividuale.Tag then
    Result:=TWA013FCalendIndiv.Create(A000App)
  else if PTag = actInserimentoGiust.Tag then
  begin
    Result:=TWA004FGiustifAssPres.Create(A000App);
    Result.SetParam('GESTIONESINGOLA','N');
  end
  else if PTag = actSchedaAnnualeAssenze.Tag then
    Result:=TWA090FAssenzeAnno.Create(A000App)
  else if PTag = actPassaggioAnno.Tag then
    Result:=TWA075FFineAnno.Create(A000App)
  else if PTag = actGeneratoreStampe.Tag then
    Result:=TWA077FGeneratoreStampe.Create(A000App)
  else if PTag = actPartTime.Tag then
    Result:=TWA085FPartTime.Create(A000App)
  else if PTag = actCalendari.Tag then
    Result:=TWA012FCalendari.Create(A000App)
  else if PTag = actProfiliAssenzeAnn.Tag then
    Result:=TWA009FProfAsseAnn.Create(A000App)
  else if PTag = actCausaliPresenza.Tag then
    Result:=TWA020FCausPresenze.Create(A000App)
  else if PTag = actRaggrPres.Tag then
    Result:=TWA018FRaggrPres.Create(A000App)
  else if PTag = actFornituraFluper.Tag then
  begin
    Result:=TWP655FDatiINPDAPMM.Create(A000App);
    Result.SetParam('TAG',IntToStr(actFornituraFluper.Tag));
    Result.SetParam('FLUSSO',FLUSSO_FLUPER);
  end
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
  else if PTag = actContoAnnuale.Tag then
    Result:=TWP555FContoAnnuale.Create(A000App)
  else if PTag = actCalcolaContoAnnuale.Tag then
    Result:=TWP554FElaborazioneContoAnnuale.Create(A000App)
  else if PTag = actContoAnnRelTab.Tag then
  begin
    Result:=TWP651FRelazioniTabelle.Create(A000App);
    Result.Tag:=PTag;
    Result.SetParam('TIPOFLUSSO','CA');
  end
  else if PTag = actContoAnnRegole.Tag then
    Result:=TWP552FRegoleContoAnnuale.Create(A000App)
  else if PTag = actContoAnnRisRes.Tag then
    Result:=TWP553FRisorseResidueContoAnnuale.Create(A000App)
  else if PTag = actAssenteismo.Tag then
    Result:=TWA151FAssenteismo.Create(A000App)
  else if PTag = actVerificheIndennita.Tag then
    Result:=TWS308FIndennitaInc.Create(A000App)
  else if PTag = actTipologieRischi.Tag then
    Result:=TWS400FTipologieRischi.Create(A000App)
  else if PTag = actTipologiePrescrizioni.Tag then
    Result:=TWS403FTipologiePrescrizioni.Create(A000App)
  else if PTag = actTipologieAttivita.Tag then
    Result:=TWS405FTipoAttivita.Create(A000App)
  else if PTag = actTipologieEsposizione.Tag then
    Result:=TWS406FTipoEsposizione.Create(A000App)
  else if PTag = actCessazioniRischi.Tag then
    Result:=TWS401FCessazioniRischi.Create(A000App)
  else if PTag = actGestioneRischi.Tag then
    Result:=TWS402FGestioneRischi.Create(A000App)
  else if PTag = actStampaRischi.Tag then
    Result:=TWS404FStampaRischi.Create(A000App)
  else if PTag = actRegoleValutazioni.Tag then
    Result:=TWS740FRegoleValutazioni.Create(A000App)
  else if PTag = actStatiAvanzamento.Tag then
    Result:=TWS746FStatiAvanzamento.Create(A000App)
  else if PTag = actAreeValutazioni.Tag then
    Result:=TWS700FAreeValutazioni.Create(A000App)
  else if PTag = actProfiliAree.Tag then
    Result:=TWS720FProfiliAree.Create(A000App)
  else if PTag = actPunteggiValutazioni.Tag then
    Result:=TWS730FPunteggiValutazioni.Create(A000App)
  else if PTag = actFScaglioniIncentivi.Tag then
  begin
    Result:=TWS735FPunteggiFasceIncentivi.Create(A000App);
    Result.Tag:=PTag;
    Result.SetParam('Tipo','V');//Tag=353
  end
  else if PTag = actParProtocollo.Tag then
    Result:=TWS750FParProtocollo.Create(A000App)
  else if PTag = actStampaValutazioni.Tag then
    Result:=TWS715FStampaValutazioni.Create(A000App)
  //Progetti STAGIU
  else if PTag = actTipoDocumenti.Tag then
    Result:=TWS027FTipoDocumenti.Create(A000App)
  else if PTag = actMotivazioniProvvedimento.Tag then
    Result:=TWS028FMotivazioni.Create(A000App)
  else if PTag = actTipoEsperienze.Tag then
    Result:=TWS108FTipoEsperienze.Create(A000App)
  else if PTag = actDettaglioEsperienze.Tag then
    Result:=TWS109FDettaglioEsperienze.Create(A000App)
  else if PTag = actGestioneOrdiniProf.Tag then
    Result:=TWS130FOrdiniProfessionali.Create(A000App)
  else if PTag = actDefinizioneVariabili.Tag then
    Result:=TWS026FDatiLiberi.Create(A000App)
  else if PTag = actCategorieIncarichi.Tag then
    Result:=TWS300FCategorieIncarichi.Create(A000App)
  else if PTag = actTipiIncarichi.Tag then
    Result:=TWS301FTipiIncarichi.Create(A000App)
  else if PTag = actIncarichiAziendali.Tag then
    Result:=TWS302FIncarichiAziendali.Create(A000App)
  else if PTag = actGestioneIncarichi.Tag then
    Result:=TWS303FIncarichiIndividuali.Create(A000App)
  else if PTag = actRiepilogoIncarichi.Tag then
    Result:=TWS304FRiepilogoIncarichi.Create(A000App)
  else if PTag = actTipiVerifiche.Tag then
    Result:=TWS309FTipiVerifiche.Create(A000App)
  else if PTag = actAllineamentoIncarichi.Tag then
    Result:=TWS310FAllineamentoIncarichi.Create(A000App)
  else if PTag = actCommissioni.Tag then
    Result:=TWS305FCommissioni.Create(A000App)
  else if PTag = actComponentiCommissioni.Tag then
    Result:=TWS306FComponentiCommissioni.Create(A000App)
  else if PTag = actSGProvvedimenti.Tag then
    Result:=TWS030FProvvedimenti.Create(A000App)
  else if PTag = actEstremiStruttura.Tag then
    Result:=TWS200FEstremiStruttura.Create(A000App)
  else if PTag = actSituazioneOrganico.Tag then
    Result:=TWS201FDistribuzioneOrganico.Create(A000App)
  else if PTag = actVisualizzazionePianta.Tag then
    Result:=TWS202FVisualizzazionePianta.Create(A000App)
  else if PTag = actStampaSituazioneOrganico.Tag then
    Result:=TWS203FStampaPiantaOrganica.Create(A000App)
  else if PTag = actGestioneDocumentale.Tag then
    Result:=TWA154FGestioneDocumentale.Create(A000App)
  else if PTag = actRicercaDocumentale.Tag then
    Result:=TWA155FRicercaDocumentale.Create(A000App)
  else if PTag = actImportazioneMassivaDocumenti.Tag then
    Result:=TWA200FImportazioneMassivaDocumenti.Create(A000App)
  else if PTag = actSGStampaCertificati.Tag then
    Result:=TWS101FStampaCert.Create(A000App);

  if Result = nil then
    (Self.Parent as TWR100FBase).Log('Traccia',Format('ERRORE CreaForm %d',[FTag]));
end;

end.
