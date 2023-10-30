unit WC503UMenuPagheFM;

interface

{ DONE : TEST IW 14 OK }
{ Alcuni moduli temporaneamente disabilitati }

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, IWAppForm,
  Dialogs, IWVCLComponent, IWBaseLayoutComponent, OracleData, Jpeg, pngimage, IWApplication,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompMenu, meIWMenu, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, Menus, IWCompButton,
  meIWButton, ActnList, ImgList, meIWImageList, meIWImageFile, IWImageList, A000UInterfaccia,
  IWCompJQueryWidget, meIWLink, WR207UMenuWebPJFM, WR100UBase, System.Actions,
  WR010UBase, IWGlobal, L021Call, A000UCostanti;

type
  TWC503FMenuPagheFM = class(TWR207FMenuWebPJFM)
    actRedditiAnnuali: TAction;
    Redditiannuali1: TMenuItem;
    actPartTime: TAction;
    Ta1: TMenuItem;
    mnuParttime: TMenuItem;
    actStatoCivile: TAction;
    mnuStatocivile: TMenuItem;
    actPagamenti: TAction;
    Modalitdipagamento1: TMenuItem;
    N2: TMenuItem;
    abellediconfigurazione1: TMenuItem;
    actNazionalita: TAction;
    Nazionalit1: TMenuItem;
    actModalitaPagamento: TAction;
    actValute: TAction;
    Valute1: TMenuItem;
    Valute2: TMenuItem;
    actCambiValute: TAction;
    Cambivalute1: TMenuItem;
    actConfigDatiEconomici: TAction;
    Configurazionedatieconomici1: TMenuItem;
    N3: TMenuItem;
    actConfigDatiAziendali: TAction;
    Configurazionedatiaziendali1: TMenuItem;
    actBanche: TAction;
    Banche1: TMenuItem;
    actArrotondamenti: TAction;
    Arrotondamentivalute1: TMenuItem;
    actFamiliari: TAction;
    actSchedaAnagrafica: TAction;
    Familiari1: TMenuItem;
    Schedaanagrafica1: TMenuItem;
    N5: TMenuItem;
    Elaborazioni1: TMenuItem;
    N6: TMenuItem;
    actGiustifAssPres: TAction;
    Giustificativiasspres1: TMenuItem;
    actCodiciINPS: TAction;
    CodiciINPS1: TMenuItem;
    actCDCPercent: TAction;
    Centridicostopercentualizzati1: TMenuItem;
    actAssenzeIndividuali: TAction;
    Elencoassenzeindividuali1: TMenuItem;
    actInterrogazioniServizio: TAction;
    Interrogazionidiservizio1: TMenuItem;
    actFPC: TAction;
    Fondiprevidenzacomplementare1: TMenuItem;
    actTabelleANF: TAction;
    abelleANF1: TMenuItem;
    actRidefinizioneCampiAnagrafici: TAction;
    actStoricoGiustificativi: TAction;
    actStatisticaMinisterialeAssenze: TAction;
    actGeneratoreStampe: TAction;
    actElencoStorici: TAction;
    actLayoutSchedaAnagrafica: TAction;
    actQualificheMinisteriali: TAction;
    actTipoRapporto: TAction;
    Ridefinizionecampianagrafici1: TMenuItem;
    Layoutschedaanagrafica1: TMenuItem;
    Generatoredistampe1: TMenuItem;
    Statisticaministerialeassenze1: TMenuItem;
    Storicogiustificativi1: TMenuItem;
    Elencomovimentistorici1: TMenuItem;
    N7: TMenuItem;
    Qualificheministeriali1: TMenuItem;
    Tipidirapporto1: TMenuItem;
    actBeneficiari: TAction;
    abellevoci1: TMenuItem;
    Beneficiari1: TMenuItem;
    N10: TMenuItem;
    actAreeContrattuali: TAction;
    Areecontrattuali1: TMenuItem;
    actContrattiVoci: TAction;
    Contrattivoci1: TMenuItem;
    actGestioneImmagini: TAction;
    Loghiaziendali1: TMenuItem;
    N11: TMenuItem;
    Causalidiassenza1: TMenuItem;
    actCausaliAssenza: TAction;
    actRaggrAssenze: TAction;
    actAccorpamentiCausali: TAction;
    Causalidiassenza2: TMenuItem;
    Raggruppamentidiassenza1: TMenuItem;
    Accorpamenticausalidiassenza1: TMenuItem;
    actCodiciAccorpCausali: TAction;
    actMisureQuantita: TAction;
    Misurequantit1: TMenuItem;
    actCausaliIrpef: TAction;
    CausaliversamentiIrpef1: TMenuItem;
    actRaggruppamentoVoci: TAction;
    Raggruppamentivoci1: TMenuItem;
    actTipiAssoggettamenti: TAction;
    ipiassoggettamenti1: TMenuItem;
    actLivelli: TAction;
    Posizioniretributive1: TMenuItem;
    Posizionieconomiche1: TMenuItem;
    actVociAggiuntive: TAction;
    Vociaggiuntive1: TMenuItem;
    actVociAggiuntiveImporti: TAction;
    Importivociaggiuntive1: TMenuItem;
    actEntiIRPEF: TAction;
    abelleaddizionaliRPEF1: TMenuItem;
    actTipiAccorpamento: TAction;
    actAccorpamentiVoci: TAction;
    N12: TMenuItem;
    Accorpamentivoci1: TMenuItem;
    Tipoaccorpamentovoci1: TMenuItem;
    actCodiciINAIL: TAction;
    PremioINAIL1: TMenuItem;
    CodiciINAIL1: TMenuItem;
    N13: TMenuItem;
    actCAF: TAction;
    Modello7301: TMenuItem;
    CAF1: TMenuItem;
    actInquadramentoINPDAP: TAction;
    ModelloCUD1: TMenuItem;
    InquadramentiINPDAP1: TMenuItem;
    actInquadramentoINPS: TAction;
    InquadramentiINPS1: TMenuItem;
    actTipoImporti: TAction;
    ipiimporti1: TMenuItem;
    actDatiONAOSI: TAction;
    DatiONAOSI1: TMenuItem;
    actAddizionaliIRPEF: TAction;
    AddizionaliIRPEF1: TMenuItem;
    actModello730: TAction;
    Modello7302: TMenuItem;
    actDatiRapportiPrecedenti: TAction;
    Datirapportiprecedenti1: TMenuItem;
    actDatiMensili: TAction;
    Datimensili1: TMenuItem;
    N14: TMenuItem;
    actQuantitaMensili: TAction;
    Quantitmensili1: TMenuItem;
    actRecuperoVoci: TAction;
    Vocidarecuperarerecuperate1: TMenuItem;
    actRegoleFLUPER: TAction;
    Regolefornitureperiodiche1: TMenuItem;
    RegolefornituraFLUPER1: TMenuItem;
    actRegoleINPDAP: TAction;
    RegolefornituraINPDAPDMA1: TMenuItem;
    actFornituraFluper: TAction;
    actFornituraINPDAP: TAction;
    Fornitureperiodiche1: TMenuItem;
    FornituraINPDAPDMA1: TMenuItem;
    FornituraFLUPER1: TMenuItem;
    Fornitureperiodiche2: TMenuItem;
    ElaborazionefornituraFLUPER1: TMenuItem;
    Contoannuale1: TMenuItem;
    actCalcolaContoAnnuale: TAction;
    Elaborazionecontoannuale1: TMenuItem;
    Contoannuale2: TMenuItem;
    actRegoleContoAnnuale: TAction;
    actRisorseContoAnnuale: TAction;
    Regolecontoannuale1: TMenuItem;
    Risorseresiduecontoannuale1: TMenuItem;
    actContoAnnuale: TAction;
    Contoannuale3: TMenuItem;
    actElaborazioneMensileENPAM: TAction;
    ElaborazioneFornituraMensileENPAM1: TMenuItem;
    actElaborazioneENPAP: TAction;
    ElaborazioneFornituraENPAP1: TMenuItem;
    N15: TMenuItem;
    actElaborazioneENPAV: TAction;
    ElaborazionefornituraENPAV1: TMenuItem;
    actVociProgrammate: TAction;
    Vociprogrammate1: TMenuItem;
    N16: TMenuItem;
    actElaborazionePerseo: TAction;
    ElaborazionefornituraPerseo2: TMenuItem;
    actImpostazionePercRimbLuglio: TAction;
    Modello7303: TMenuItem;
    Impostazionepercentualemodello7301: TMenuItem;
    actParcheggioVoci: TAction;
    Parcheggiovoci1: TMenuItem;
    actCalcoloMinimaleMassimaleINAIL: TAction;
    CalcoloParametriINAIL1: TMenuItem;
    actElaborazioneCedolini: TAction;
    Cedolinomensile1: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    Elaborazionecedolini1: TMenuItem;
    actEntiAppartenenza: TAction;
    Entidiappartenenza1: TMenuItem;
    actConguagliRetroattivi: TAction;
    Conguagliretroattivi1: TMenuItem;
    actElaborazioneF24EP: TAction;
    ElaborazionefornituraF24EP1: TMenuItem;
    actControlloTettoAccessorie: TAction;
    Controllotettoaccesorie1: TMenuItem;
    N19: TMenuItem;
    actCalcolaINAIL: TAction;
    PremioINAIL2: TMenuItem;
    CalcoloritenuteINAILente1: TMenuItem;
    actCedolini: TAction;
    Cedolini1: TMenuItem;
    actElaborazioneONAOSI: TAction;
    ModelloONAOSI1: TMenuItem;
    ElaborazionemodelloONAOSI1: TMenuItem;
    actVociVariabili: TAction;
    Vocivariabili1: TMenuItem;
    actCalcoloAddizionaliIRPEF: TAction;
    CalcoloaddizionaliIRPEF1: TMenuItem;
    actRaggrInterrogazioni: TAction;
    Raggruppamentiinterrogazionidiservizio1: TMenuItem;
    actCalcoloTredicesimaVirtuale: TAction;
    Calcolotredicesimavirtuale1: TMenuItem;
    N20: TMenuItem;
    actElaborazioneF24Ord: TAction;
    ElaborazionefornitureF24ordinario1: TMenuItem;
    actStoricoRetribContrattuale: TAction;
    Storicoretribuzionecontrattuale1: TMenuItem;
    Storicoretribuzionecontrattuale2: TMenuItem;
    actStampaStoricoRetribContrattuale: TAction;
    Stampastoricoretribuzionecontrattuale1: TMenuItem;
    actFileSEPA: TAction;
    CreazionefileSEPA1: TMenuItem;
    actElaborazioneContab: TAction;
    Contabilit1: TMenuItem;
    actVoci: TAction;
    Voci1: TMenuItem;
    N21: TMenuItem;
    actStampaInail: TAction;
    StampaINAIL1: TMenuItem;
    actRiepilogoMensileInps: TAction;
    RiepiloghimensiliINPS1: TMenuItem;
    actDatiContabilita: TAction;
    Daticontabilit1: TMenuItem;
    actElaborazioneENPAM: TAction;
    ElaborazionefornituraannualeENPAM1: TMenuItem;
    actRelazioniTabelle: TAction;
    RelazionitabelleFLUPER1: TMenuItem;
    actRegoleContabilita: TAction;
    Contabilita1: TMenuItem;
    Regolecontabilita1: TMenuItem;
    actParametriAcquisizione: TAction;
    Parametriacquisizionefilevoci1: TMenuItem;
    actINPSCalcolo: TAction;
    ElaborazionefornituraINPSuniEMens1: TMenuItem;
    actAcquisizioneFileVoci: TAction;
    Acquisizionefilevoci1: TMenuItem;
    N22: TMenuItem;
    actRegoleArchiviazioneDoc: TAction;
    Regolearchivazionedocumenti1: TMenuItem;
    actContoAnnRelTab: TAction;
    Relazionitabellecontoannuale1: TMenuItem;
    actFileInadempienze: TAction;
    Creazionefileverificainadempienze1: TMenuItem;
    RegolefornituraINPSuniEMens1: TMenuItem;
    actRegoleFornituraINPSUniEmens: TAction;
    RegoleCalcoloCU1: TMenuItem;
    actRegoleCalcoloCU: TAction;
    Modello7701: TMenuItem;
    RegoleCalcolo7701: TMenuItem;
    actRegoleCalcolo770: TAction;
    ModelloCU1: TMenuItem;
    ModelliCUparticolari1: TMenuItem;
    actModelliCUparticolari: TAction;
    ModelliCU1: TMenuItem;
    actModelloCU: TAction;
    ChiusuraANF1: TMenuItem;
    actChiusuraANF: TAction;
    Importazionemodelli730dafile1: TMenuItem;
    actImportazioneModelli730: TAction;
    ModelloCU2: TMenuItem;
    ElaborazionemodelliCU1: TMenuItem;
    actElaborazioneModelliCU: TAction;
    Modello7702: TMenuItem;
    Elaborazionemodelli7701: TMenuItem;
    actElaborazioneModelli770: TAction;
    Modello7703: TMenuItem;
    Modello7704: TMenuItem;
    actModello770: TAction;
    actImportazioneRicevuteModelliCU: TAction;
    ImportazionericevutemodelliCU1: TMenuItem;
    actEntiPrevidenziali: TAction;
    Entiprevidenziali1: TMenuItem;
    actAlberoAssoggettamenti: TAction;
    Alberoassoggettamenti1: TMenuItem;
    actFornituraINPS: TAction;
    FornituraINPSuniEMens1: TMenuItem;
    StampamodelliCU1: TMenuItem;
    actStampaModelliCU: TAction;
    Fondi1: TMenuItem;
    Macrocategoriefondi1: TMenuItem;
    actMacrocategorieFondi: TAction;
    Raggruppamentifondi1: TMenuItem;
    actRaggruppamentiFondi: TAction;
    Definizionefondi1: TMenuItem;
    actDefinizioneFondi: TAction;
    Calcolofondi1: TMenuItem;
    actCalcoloFondi: TAction;
    Monitoraggiofondi1: TMenuItem;
    actMonitoraggioFondi: TAction;
    Premiodioperosit1: TMenuItem;
    Premiodioperositmaturato1: TMenuItem;
    actPremioOperositaMaturato: TAction;
    Premiodioperosit2: TMenuItem;
    actPremioOperosita: TAction;
    Sostituzioniconvenzionati1: TMenuItem;
    actSostituzioniConvenzionati: TAction;
    Acquisizionequantitmensili1: TMenuItem;
    actAcquisizioneQuantitaMensili: TAction;
    actPassaggioAnno: TAction;
    Passaggioanno1: TMenuItem;
    actStampaFondi: TAction;
    Stampafondi1: TMenuItem;
    actRegoleSostituzioniConvenzionati: TAction;
    Regolesostituzioniconvenzionati1: TMenuItem;
    Importazionevociprogrammate1: TMenuItem;
    actImportazioneVociProgrammate: TAction;
    Modulopensioni1: TMenuItem;
    ModelliTFR11: TMenuItem;
    actModelliTFR1: TAction;
    ElaborazionemodelliTFR11: TMenuItem;
    actElaborazioneModelliTFR1: TAction;
    StampamodelliTFR11: TMenuItem;
    actStampaModelliTFR1: TAction;
    Periodipensionisticieprevidenziali1: TMenuItem;
    actPeriodiPensPrev: TAction;
    Periodiretributivi1: TMenuItem;
    actPeriodiRetributivi: TAction;
    N23: TMenuItem;
    Stampaperiodiretributivi1: TMenuItem;
    actStampaPeriodiRetributivi: TAction;
  private
    { Private declarations }
  public
    { Public declarations }
 protected
    function CreaForm(PTag: Integer): TWR100FBase; override;
  end;

var
  WC503FMenuPagheFM: TWC503FMenuPagheFM;

implementation

uses
  WA002UAnagrafe, WA004UGiustifAssPres,
  WA016UCausAssenze, WA017URaggrAsse,
  WA045UStatAssenze,
  WA061UDettAssenze, WA062UQueryServizio,
  WA082UCdcPercent, WA084UTipoRapporto,
  WA092UStampaStorico,
  WA101URaggrInterrogazioni, WA105UStoricoGiustificativi, WA109UImmagini,
  WA142UQualifMinisteriali,
  WA150UAccorpamentoCausali, WA150UCodiciAccorpamentoCausali,
  WA188UCampiAnagrafe,
  WA197ULayoutSchedaAnagr,
  WA210URegoleArchiviazioneDoc,
  WP002UPassaggioAnno,
  WP010UBanche, WP012UBeneficiari, WP015UEntiAppartenenza,
  WP020UStatoCivile, WP022UCAF, WP026UFPC,
  WP030UValute, WP032UCambi,
  WP040UPartTime, WP042UEntiIRPEF,
  WP050UArrotondamenti,
  WP070UMisureQuantita, WP077UGeneratoreStampe,
  WP080UCausaliIrpef,
  WP090UCodiciINPS, WP092UCodiciINAIL, WP094UInquadramentoINPDAP, WP096UInquadramentoINPS,
  WP120UNazionalita,
  WP130UPagamenti,
  WP150USetup,
  { DONE : TEST IW 14 OK }
  WP192UAcquisizioneFileVociInput,
  WP191UParFileVociInput,  WP198URaggruppamentoVoci,
  WP200UVoci, WP202ULetturaAssoggettamenti,
  WP210UContratti, WP212UParametriStipendi, WP214UAccorpamentoVoci, WP215UTipiAccorpamento,
  WP220ULivelli,
  WP236UTabelleAnf, WP239UCalcoloAnf,
  WP240UTipiAssoggettamenti,
  WP250UVociAggiuntive, WP252UVociAggiuntiveImporti, WP228USostituzRegole, WP253UImporta730,
  WP254UVociProgrammate, WP258UAddizionaliIRPEF, WP259UCalcoloAddizionaliIRPEF, WP016UImportProgrammate,
  WP260UMod730TipoImporti, WP261UImpostazionePercRimbLuglio, WP262UDatiMod730, WP265UElaborazioneONAOSI, WP266UMod1ONAOSI, WP268URapportiPrecedenti,
  WP270URedditiAnnuali, WP272UStoricoRetribuzioneContrattuale, WP273UStampaStoricoRetrib,
  WP280UPeriodiPensPrev, WP282UPeriodiRetributivi, WP283UStampaPeriodiRetrib,
  WP310UElaborazioneTFR1, WP312UModelliTFR1, WP314UStampaModelliTFR1,
  WP292UCalcoloMinimaleMassimaleINAIL,
  WP441UDatiCedolino, WP447UParcheggioVoci, WP449UCalcoloINAIL,
  WP450UDatiMensili, WP454URecuperoVoci,
  WP460UQuantitaMensili, WP462USostituzioni,
  WP500UCalcoloCedolino, WP501UCudSetup, WP502UCudRegole, WP505UDatiCUD, WP503UModelliCUParticolari, WP504UCalcoloCUD,
  WP461UImportazioneAssistSanitConvenz, WP464UPremioOperosita, WP466UPremioOperositaMaturato,
  WP507UConguaglioRetroattivo, WP508UContabAnaliticaRatei,
  WP510UFileSEPA, WP511UImportaRicevuteCU, WP512UEntiPrevidenziali, WP513UFileInadempienze,
  WP552URegoleContoAnnuale, WP553URisorseResidueContoAnnuale, WP554UElaborazioneContoAnnuale, WP555UContoAnnuale,
  WP590UContabRegole, WP591UElaborazioneContab, WP592UDatiContab,
  WP602U770Regole, WP604UCalcolo770, WP605UDati770,
  WP651URelazioniTabelle, WP652UINPDAPMMRegole, WP655UDatiINPDAPMM, WP658UElaborazioneF24EP, WP659UElaborazioneF24Ord,
  WP670UXmlINPSRegole, WP671UElaborazioneINPS, WP672UXmlDatiIndividuali,
  WP680UMacrocategorieFondi, WP682URaggruppamentiFondi, WP684UDefinizioneFondi, WP686UCalcoloFondi, WP688UMonitoraggioFondi,
  WP690UStampaFondi,
  WP700URiepilogoMensileInps,
  WP710UStampaINAIL, WP715UStampaCertificazioneUnica, WP719UElaborazioneMensileENPAM,
  WP720UElaborazioneENPAM, WP721UElaborazioneENPAP, WP722UElaborazioneENPAV, WP725UElaborazionePerseo,
  WP842UVociVariabiliDipendente,
  WS031UFamiliari;

{$R *.dfm}

function TWC503FMenuPagheFM.CreaForm(PTag: Integer): TWR100FBase;
begin
  (Self.Parent as TWR100FBase).Log('Traccia',Format('CreaForm %d',[FTag]));

  Result:=inherited;

  //CONDIVISI
  if PTag = actSchedaAnagrafica.Tag then
    Result:=TWA002FAnagrafe.Create(A000App)
  else if PTag = actGiustifAssPres.Tag then
  begin
    Result:=TWA004FGiustifAssPres.Create(A000App);
    Result.SetParam('GESTIONESINGOLA','S');
  end
  else if PTag = actCausaliAssenza.Tag then
    Result:=TWA016FCausAssenze.Create(A000App)
  else if PTag = actRaggrAssenze.Tag then
    Result:=TWA017FRaggrAsse.Create(A000App)
  else if PTag = actStatisticaMinisterialeAssenze.Tag then
    Result:=TWA045FStatAssenze.Create(A000App)
  else if PTag = actAssenzeIndividuali.Tag then
    Result:=TWA061FDettAssenze.Create(A000App)
  else if PTag = actInterrogazioniServizio.Tag then
    Result:=TWA062FQueryServizio.Create(A000App)
  else if PTag = actGeneratoreStampe.Tag then
    Result:=TWP077FGeneratoreStampe.Create(A000App)
  else if PTag = actCdcPercent.Tag then
    Result:=TWA082FCdcPercent.Create(A000App)
  else if PTag = actTipoRapporto.Tag then
    Result:=TWA084FTipoRapporto.Create(A000App)
  else if PTag = actElencoStorici.Tag then
    Result:=TWA092FStampaStorico.Create(A000App)
  else if PTag = actRaggrInterrogazioni.Tag then
    Result:=TWA101FRaggrInterrogazioni.Create(A000App)
  else if PTag = actStoricoGiustificativi.Tag then
    Result:=TWA105FStoricoGiustificativi.Create(A000App)
  else if PTag = actGestioneImmagini.Tag then
    Result:=TWA109FImmagini.Create(A000App)
  else if PTag = actQualificheMinisteriali.Tag then
    Result:=TWA142FQualifMinisteriali.Create(A000App)
  else if PTag = actAccorpamentiCausali.Tag then
    Result:=TWA150FAccorpamentoCausali.Create(A000App)
  else if PTag = actCodiciAccorpCausali.Tag then
    Result:=TWA150FCodiciAccorpamentoCausali.Create(A000App)
  else if PTag = actRidefinizioneCampiAnagrafici.Tag then
    Result:=TWA188FCampiAnagrafe.Create(A000App)
  else if PTag = actLayoutSchedaAnagrafica.Tag then
    Result:=TWA197FLayoutSchedaAnagr.Create(A000App)
  else if PTag = actFamiliari.Tag then
    Result:=TWS031FFamiliari.Create(A000App)
  //AMBIENTE
  else if PTag = actBanche.Tag then
    Result:=TWP010FBanche.Create(A000App)
  else if PTag = actBeneficiari.Tag then
    Result:=TWP012FBeneficiari.Create(A000App)
  else if PTag = actEntiAppartenenza.Tag then
    Result:=TWP015FEntiAppartenenza.Create(A000App)
  else if PTag = actStatoCivile.Tag then
    Result:=TWP020FStatoCivile.Create(A000App)
  else if PTag = actCAF.Tag then
    Result:=TWP022FCAF.Create(A000App)
  else if PTag = actFPC.Tag then
    Result:=TWP026FFPC.Create(A000App)
  else if PTag = actValute.Tag then
    Result:=TWP030FValute.Create(A000App)
  else if PTag = actCambiValute.Tag then
    Result:=TWP032FCambi.Create(A000App)
  else if PTag = actPartTime.Tag then
    Result:=TWP040FPartTime.Create(A000App)
  else if PTag = actEntiIRPEF.Tag then
    Result:=TWP042FEntiIRPEF.Create(A000App)
  else if PTag = actArrotondamenti.Tag then
    Result:=TWP050FArrotondamenti.Create(A000App)
  else if PTag = actMisureQuantita.Tag then
    Result:=TWP070FMisureQuantita.Create(A000App)
  else if PTag = actCausaliIrpef.Tag then
    Result:=TWP080FCausaliIrpef.Create(A000App)
  else if PTag = actCodiciINPS.Tag then
    Result:=TWP090FCodiciINPS.Create(A000App)
  else if PTag = actCodiciINAIL.Tag then
    Result:=TWP092FCodiciINAIL.Create(A000App)
  else if PTag = actRegoleCalcoloCU.Tag then
    Result:=TWP502FCudRegole.Create(A000App)
  else if PTag = actRegoleCalcolo770.Tag then
    Result:=TWP602F770Regole.Create(A000App)
  else if PTag = actInquadramentoINPDAP.Tag then
    Result:=TWP094FInquadramentoINPDAP.Create(A000App)
  else if PTag = actInquadramentoINPS.Tag then
    Result:=TWP096FInquadramentoINPS.Create(A000App)
  else if PTag = actNazionalita.Tag then
    Result:=TWP120FNazionalita.Create(A000App)
  else if PTag = actPagamenti.Tag then
    Result:=TWP130FPagamenti.Create(A000App)
  else if PTag = actConfigDatiEconomici.Tag then
    Result:=TWP150FSetup.Create(A000App)
  else if PTag = actRaggruppamentoVoci.Tag then
    Result:=TWP198FRaggruppamentoVoci.Create(A000App)
  else if PTag = actContrattiVoci.Tag then
    Result:=TWP210FContratti.Create(A000App)
  else if PTag = actAreeContrattuali.Tag then
    Result:=TWP212FParametriStipendi.Create(A000App)
  else if PTag = actTipiAccorpamento.Tag then
    Result:=TWP215FTipiAccorpamento.Create(A000App)
  else if PTag = actAccorpamentiVoci.Tag then
    Result:=TWP214FAccorpamentoVoci.Create(A000App)
  else if PTag = actLivelli.Tag then
    Result:=TWP220FLivelli.Create(A000App)
  else if PTag = actTabelleANF.Tag then
    Result:=TWP236FTabelleANF.Create(A000App)
  else if PTag = actChiusuraANF.Tag then
    Result:=TWP239FCalcoloANF.Create(A000App)
  else if PTag = actTipiAssoggettamenti.Tag then
    Result:=TWP240FTipiAssoggettamenti.Create(A000App)
  else if PTag = actVociAggiuntive.Tag then
    Result:=TWP250FVociAggiuntive.Create(A000App)
  else if PTag = actVociAggiuntiveImporti.Tag then
    Result:=TWP252FVociAggiuntiveImporti.Create(A000App)
  else if PTag = actRegoleSostituzioniConvenzionati.Tag then
    Result:=TWP228FSostituzRegole.Create(A000App)
  else if PTag = actTipoImporti.Tag then
    Result:=TWP260FMod730TipoImporti.Create(A000App)
  else if PTag = actConfigDatiAziendali.Tag then
    Result:=TWP501FCudSetup.Create(A000App)
  else if PTag = actRegoleContabilita.Tag then
    Result:=TWP590FContabRegole.Create(A000App)
  else if PTag = actRegoleFornituraINPSUniEmens.Tag then
    Result:=TWP670FXmlINPSRegole.Create(A000App)
  else if PTag = actVoci.Tag then
    Result:=TWP200FVoci.Create(A000App)
  else if PTag = actAlberoAssoggettamenti.Tag then
    Result:=TWP202FLetturaAssoggettamenti.Create(A000App)
  //PERSONALE
  else if PTag = actAddizionaliIRPEF.Tag then
    Result:=TWP258FAddizionaliIRPEF.Create(A000App)
  else if PTag = actModello730.Tag then
    Result:=TWP262FDatiMod730.Create(A000App)
  else if PTag = actDatiOnaosi.Tag then
    Result:=TWP266FMod1ONAOSI.Create(A000App)
  else if PTag = actDatiRapportiPrecedenti.Tag then
    Result:=TWP268FRapportiPrecedenti.Create(A000App)
  else if PTag = actRedditiAnnuali.Tag then
    Result:=TWP270FRedditiAnnuali.Create(A000App)
  else if PTag = actCedolini.Tag then
    Result:=TWP441FDatiCedolino.Create(A000App)
  else if PTag = actDatiMensili.Tag then
    Result:=TWP450FDatiMensili.Create(A000App)
  else if PTag = actRecuperoVoci.Tag then
    Result:=TWP454FRecuperoVoci.Create(A000App)
  else if PTag = actQuantitaMensili.Tag then
    Result:=TWP460FQuantitaMensili.Create(A000App)
  else if PTag = actSostituzioniConvenzionati.Tag then
    Result:=TWP462FSostituzioni.Create(A000App)
  else if PTag = actDatiContabilita.Tag then
    Result:=TWP592FDatiContab.Create(A000App)
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
  else if PTag = actRegoleINPDAP.Tag then
  begin
    Result:=TWP652FINPDAPMMRegole.Create(A000App);
    Result.SetParam('TAG',IntToStr(actRegoleINPDAP.Tag));
    Result.SetParam('FLUSSO',FLUSSO_INPDAP);
  end
  else if PTag = actFornituraFluper.Tag then
  begin
    Result:=TWP655FDatiINPDAPMM.Create(A000App);
    Result.SetParam('TAG',IntToStr(actFornituraFluper.Tag));
    Result.SetParam('FLUSSO',FLUSSO_FLUPER);
  end
  else if PTag = actFornituraINPDAP.Tag then
  begin
    Result:=TWP655FDatiINPDAPMM.Create(A000App);
    Result.SetParam('TAG',IntToStr(actFornituraINPDAP.Tag));
    Result.SetParam('FLUSSO',FLUSSO_INPDAP);
  end
  else if PTag = actFornituraINPS.Tag then
  begin
    Result:=TWP672FXmlDatiIndividuali.Create(A000App);
  end
  else if PTag = actCalcolaContoAnnuale.Tag then
  begin
    Result:=TWP554FElaborazioneContoAnnuale.Create(A000App);
    //Result.SetParam('',...);
  end
  else if PTag = actModelloCU.Tag then
  begin
    Result:=TWP505FDatiCUD.Create(A000App);
  end
  else if PTag = actModelliCUparticolari.Tag then
  begin
    Result:=TWP503FModelliCUParticolari.Create(A000App);
  end
  else if PTag = actModello770.Tag then
  begin
    Result:=TWP605FDati770.Create(A000App);
  end
  else if PTag = actContoAnnuale.Tag then
  begin
    Result:=TWP555FContoAnnuale.Create(A000App);
  end
  else if PTag = actContoAnnRelTab.Tag then
  begin
    Result:=TWP651FRelazioniTabelle.Create(A000App);
    Result.Tag:=PTag;
    Result.SetParam('TIPOFLUSSO','CA');
  end
  else if PTag = actRegoleContoAnnuale.Tag then
  begin
    Result:=TWP552FRegoleContoAnnuale.Create(A000App);
  end
  else if PTag = actRisorseContoAnnuale.Tag then
  begin
    Result:=TWP553FRisorseResidueContoAnnuale.Create(A000App);
  end
  else if PTag = actMacrocategorieFondi.Tag then
  begin
    Result:=TWP680FMacrocategorieFondi.Create(A000App);
  end
  else if PTag = actRaggruppamentiFondi.Tag then
  begin
    Result:=TWP682FRaggruppamentiFondi.Create(A000App);
  end
  else if PTag = actDefinizioneFondi.Tag then
  begin
    Result:=TWP684FDefinizioneFondi.Create(A000App);
  end
  else if PTag = actCalcoloFondi.Tag then
  begin
    Result:=TWP686FCalcoloFondi.Create(A000App);
  end
  else if PTag = actMonitoraggioFondi.Tag then
  begin
    Result:=TWP688FMonitoraggioFondi.Create(A000App);
  end
  else if PTag = actStampaFondi.Tag then
    Result:=TWP690FStampaFondi.Create(A000App)
  else if PTag = actRiepilogoMensileInps.Tag then
    Result:=TWP700FRiepilogoMensileInps.Create(A000App)
  else if PTag = actStampaINAIL.Tag then
    Result:=TWP710FStampaINAIL.Create(A000App)
  else if PTag = actStampaModelliCU.Tag then
    Result:=TWP715FStampaCertificazioneUnica.Create(A000App)
  else if PTag = actElaborazioneMensileENPAM.Tag then
    Result:=TWP719FElaborazioneMensileENPAM.Create(A000App)
  else if PTag = actElaborazioneENPAM.Tag then
    Result:=TWP720FElaborazioneENPAM.Create(A000App)
  else if PTag = actElaborazioneENPAP.Tag then
    Result:=TWP721FElaborazioneENPAP.Create(A000App)
  else if PTag = actElaborazioneENPAV.Tag then
    Result:=TWP722FElaborazioneENPAV.Create(A000App)
  else if PTag = actVociProgrammate.Tag then
    Result:=TWP254FVociProgrammate.Create(A000App)
  else if PTag = actVociVariabili.Tag then
    Result:=TWP842FVociVariabiliDipendente.Create(A000App)
  else if PTag = actElaborazionePerseo.Tag then
    Result:=TWP725FElaborazionePerseo.Create(A000App)
  else if PTag = actImportazioneModelli730.Tag then
    Result:=TWP253FImporta730.Create(A000App)
  else if PTag = actImpostazionePercRimbLuglio.Tag then
    Result:=TWP261FImpostazionePercRimbLuglio.Create(A000App)
  else if PTag = actElaborazioneModelliCU.Tag then
    Result:=TWP504FCalcoloCUD.Create(A000App)
  else if PTag = actImportazioneRicevuteModelliCU.Tag then
    Result:=TWP511FImportaRicevuteCU.Create(A000App)
  else if PTag = actEntiPrevidenziali.Tag then
    Result:=TWP512FEntiPrevidenziali.Create(A000App)
  else if PTag = actElaborazioneModelli770.Tag then
    Result:=TWP604FCalcolo770.Create(A000App)
  else if PTag = actParcheggioVoci.Tag then
    Result:=TWP447FParcheggioVoci.Create(A000App)
  else if PTag = actCalcoloMinimaleMassimaleINAIL.Tag then
    Result:=TWP292FCalcoloMinimaleMassimaleINAIL.Create(A000App)
  else if PTag = actElaborazioneCedolini.Tag then
    Result:=TWP500FCalcoloCedolino.Create(A000App)
  else if PTag = actConguagliRetroattivi.Tag then
  begin
    Result:=TWP507FConguaglioRetroattivo.Create(A000App);
    Result.SetParam('FUNZIONE','CONG');
  end
  else if PTag = actControlloTettoAccessorie.Tag then
  begin
    Result:=TWP507FConguaglioRetroattivo.Create(A000App);
    Result.SetParam('FUNZIONE','CTRL');
  end
  else if PTag = actAcquisizioneQuantitaMensili.Tag then
    Result:=TWP461FImportazioneAssistSanitConvenz.Create(A000App)
  else if PTag = actPremioOperosita.Tag then
    Result:=TWP464FPremioOperosita.Create(A000App)
  else if PTag = actPremioOperositaMaturato.Tag then
    Result:=TWP466FPremioOperositaMaturato.Create(A000App)
  else if PTag = actINPSCalcolo.Tag then
    Result:=TWP671FElaborazioneINPS.Create(A000App)
  else if PTag = actElaborazioneF24EP.Tag then
    Result:=TWP658FElaborazioneF24EP.Create(A000App)
  else if PTag = actCalcolaINAIL.Tag then
    Result:=TWP449FCalcoloINAIL.Create(A000App)
  else if PTag = actElaborazioneONAOSI.Tag then
    Result:=TWP265FElaborazioneONAOSI.Create(A000App)
  else if PTag = actPassaggioAnno.Tag then
    Result:=TWP002FPassaggioAnno.Create(A000App)
  else if PTag = actCalcoloAddizionaliIRPEF.Tag then
    Result:=TWP259FCalcoloAddizionaliIRPEF.Create(A000App)
  else if PTag = actImportazioneVociProgrammate.Tag then
    Result:=TWP016FImportProgrammate.Create(A000App)
  else if PTag = actCalcoloTredicesimaVirtuale.Tag then
    Result:=TWP508FContabAnaliticaRatei.Create(A000App)
  else if PTag = actElaborazioneF24Ord.Tag then
    Result:=TWP659FElaborazioneF24Ord.Create(A000App)
  else if PTag = actStoricoRetribContrattuale.Tag then
    Result:=TWP272FStoricoRetribuzioneContrattuale.Create(A000App)
  else if PTag = actPeriodiPensPrev.Tag then
    Result:=TWP280FPeriodiPensPrev.Create(A000App)
  else if PTag = actPeriodiRetributivi.Tag then
    Result:=TWP282FPeriodiRetributivi.Create(A000App)
  else if PTag = actStampaPeriodiRetributivi.Tag then
    Result:=TWP283FStampaPeriodiRetrib.Create(A000App)
  else if PTag = actModelliTFR1.Tag then
    Result:=TWP312FModelliTFR1.Create(A000App)
  else if PTag = actStampaModelliTFR1.Tag then
    Result:=TWP314FStampaModelliTFR1.Create(A000App)
  else if PTag = actElaborazioneModelliTFR1.Tag then
    Result:=TWP310FElaborazioneTFR1.Create(A000App)
  else if PTag = actStampaStoricoRetribContrattuale.Tag then
    Result:=TWP273FStampaStoricoRetrib.Create(A000App)
  else if PTag = actFileInadempienze.Tag then
    Result:=TWP513FFileInadempienze.Create(A000App)
  else if PTag = actFileSEPA.Tag then
    Result:=TWP510FFileSEPA.Create(A000App)
  else if PTag = actElaborazioneContab.Tag then
    Result:=TWP591FElaborazioneContab.Create(A000App)
  //INTERFACCE
  else if PTag = actAcquisizioneFileVoci.Tag then
    Result:=TWP192FAcquisizioneFileVociInput.Create(A000App)  
  else if PTag = actParametriAcquisizione.Tag then
    Result:=TWP191FParFileVociInput.Create(A000App)
  else if PTag = actRegoleArchiviazioneDoc.Tag then
    Result:=TWA210FRegoleArchiviazioneDoc.Create(A000App)
  ;

  if Result = nil then
    (Self.Parent as TWR100FBase).Log('Traccia',Format('ERRORE CreaForm %d',[FTag]));
end;

end.
