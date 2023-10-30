unit WP430UAnagraficoDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompGrids, meIWGrid, medpIWTabControl,
  meIWRegion, IWCompLabel, meIWLabel, IWCompEdit, medpIWMultiColumnComboBox,
  IWHTMLControls, meIWLink,WP430UAnagraficoDM, IWDBStdCtrls, meIWDBLabel,
  OracleData, IWCompListbox, meIWDBComboBox, A000UCostanti, meIWDBEdit,
  IWCompButton, meIWButton, WC015USelEditGridFM, IWCompExtCtrls, IWDBExtCtrls,
  meIWDBRadioGroup, IWCompCheckbox, meIWDBCheckBox, meIWEdit, meIWImageFile,
  medpIWImageButton, A000UInterfaccia, medpIWMessageDlg,
  Data.DB, WR100UBase, System.Actions, Vcl.ActnList, StrUtils,
  C190FunzioniGeneraliWeb, P239UANFDtM, A000UMessaggi, UIntfWebT480, Vcl.Menus,
  WC006UStoriaDipFM,C006UStoriaDati,C180FunzioniGenerali;

type
  TSchedaAnagrafica = record
    NomeCampo:String;
    Componente:TControl;
    lblComponente:TControl; //opzionale: componente aggiuntivo a cui associare lo stesso menù contestuale
  end;

  TWP430FAnagraficoDettFM = class(TWR205FDettTabellaFM)
    grdTabDetail: TmedpIWTabControl;
    WP430PosizioneRG: TmeIWRegion;
    TemplatePosizioneRG: TIWTemplateProcessorHTML;
    cmbCodContratto: TMedpIWMultiColumnComboBox;
    lnkCodContratto: TmeIWLink;
    dlblContratto: TmeIWDBLabel;
    lnkCodParametriStipendi: TmeIWLink;
    cmbCodParametriStipendi: TMedpIWMultiColumnComboBox;
    dlblParametriStipendi: TmeIWDBLabel;
    lnkCodTipoAssog: TmeIWLink;
    cmbCodTipoAssog: TMedpIWMultiColumnComboBox;
    dlblTipoAssoggettamento: TmeIWDBLabel;
    lnkPosEconomica: TmeIWLink;
    cmbPosEconomica: TMedpIWMultiColumnComboBox;
    dlblPosEconomica: TmeIWDBLabel;
    cmbCodPartTime: TMedpIWMultiColumnComboBox;
    lnkCodiPartTime: TmeIWLink;
    dlblPartTime: TmeIWDBLabel;
    dcmbTipoDipendente: TmeIWDBComboBox;
    lblTipoDipendente: TmeIWLabel;
    lblProgressivoEredeDi: TmeIWLabel;
    dedtDNominativoErede: TmeIWDBEdit;
    btnErede: TmeIWButton;
    lblPercEredita: TmeIWLabel;
    dedtPercEredita: TmeIWDBEdit;
    drgpStatoDipendente: TmeIWDBRadioGroup;
    lblStatoDipendente: TmeIWLabel;
    drgpNoCedolinoNormale: TmeIWDBRadioGroup;
    lblNoCedolinoNormale: TmeIWLabel;
    WP430DatiAggiuntiviRG: TmeIWRegion;
    TemplateDatiAggiuntiviRG: TIWTemplateProcessorHTML;
    edtIban: TmeIWEdit;
    lblIban: TmeIWLabel;
    btnImpostaIBAN: TmedpIWImageButton;
    dlblDBanca: TmeIWDBLabel;
    dedtCodBanca: TmeIWDBEdit;
    btnCodBanca: TmeIWButton;
    lblContoCorrente: TmeIWLabel;
    dedtContoCorrente: TmeIWDBEdit;
    lblCinItalia: TmeIWLabel;
    dedtCinItalia: TmeIWDBEdit;
    lblCinEuropa: TmeIWLabel;
    dedtCinEuropa: TmeIWDBEdit;
    lnkPagamento: TmeIWLink;
    cmbPagamento: TMedpIWMultiColumnComboBox;
    dlblDescPagamento: TmeIWDBLabel;
    cmbValutaCalcolo: TMedpIWMultiColumnComboBox;
    dlblDescValutaCalcolo: TmeIWDBLabel;
    lnkValutaCalcolo: TmeIWLink;
    cmbValuta: TMedpIWMultiColumnComboBox;
    dlblDescValuta: TmeIWDBLabel;
    lnkValuta: TmeIWLink;
    cmbStatoCivile: TMedpIWMultiColumnComboBox;
    dlblDescStatoCivile: TmeIWDBLabel;
    lnkStatoCivile: TmeIWLink;
    cmbNazionalita: TMedpIWMultiColumnComboBox;
    dlblDescNazionalita: TmeIWDBLabel;
    lnkNazionalita: TmeIWLink;
    WP430ParametriCalcoloRG: TmeIWRegion;
    TemplateParametriCalcoloRG: TIWTemplateProcessorHTML;
    drgpTredicesima: TmeIWDBRadioGroup;
    lblPrevista: TmeIWLabel;
    drgpTipoCalcoloImporto13A: TmeIWDBRadioGroup;
    lblTipoCalcoloImporto: TmeIWLabel;
    lblTredicesima: TmeIWLabel;
    lblIrpef: TmeIWLabel;
    lblConguaglio: TmeIWLabel;
    drgpConguaglio: TmeIWDBRadioGroup;
    lblCedoliniNormali: TmeIWLabel;
    lblPercIrpefManuale: TmeIWLabel;
    dedtPercIRPEFManuale: TmeIWDBEdit;
    lblCedoliniExtra27: TmeIWLabel;
    lblPercIrpefExtra27: TmeIWLabel;
    dedtPercIrpefExtra27: TmeIWDBEdit;
    dchkPercIRPEFmaxExtra27: TmeIWDBCheckBox;
    dedtPercIrpefTfr: TmeIWDBEdit;
    cmbCodCausaleIrpef: TMedpIWMultiColumnComboBox;
    lnkCodCausaleIrpef: TmeIWLink;
    dlblDescCausaleIrpef: TmeIWDBLabel;
    cmbCodRegioneIRPEF: TMedpIWMultiColumnComboBox;
    lnkCodRegioneIRPEF: TmeIWLink;
    dlblDescRegioneIRPEF: TmeIWDBLabel;
    btnRedditiAnnuali: TmeIWButton;
    WP430DetrazioniRG: TmeIWRegion;
    TemplateDetrazioniRG: TIWTemplateProcessorHTML;
    lblAltriRedditiDetrazioni: TmeIWLabel;
    dedtRedditoDetrazFigliAltri: TmeIWDBEdit;
    lblRedditoDetrazFigliAltri: TmeIWLabel;
    dedtRedditoDetrazLavDip: TmeIWDBEdit;
    lblRedditoDetrazLavDip: TmeIWLabel;
    lblAltreDetrazioni: TmeIWLabel;
    drgpTipoDetrazioni: TmeIWDBRadioGroup;
    lblTipoDetrazioni: TmeIWLabel;
    dchkDetrazRedditiMinIndet: TmeIWDBCheckBox;
    dchkDetrazRedditiMinDet: TmeIWDBCheckBox;
    lblFamiglieNumerose: TmeIWLabel;
    dchkPercDetraz: TmeIWDBCheckBox;
    dchkCreditoFamNumerose: TmeIWDBCheckBox;
    lblBonusRiduzCuneoFisc: TmeIWLabel;
    lblTipoBonus: TmeIWLabel;
    drgpTipoBonus: TmeIWDBRadioGroup;
    WP430AnfRG: TmeIWRegion;
    TemplateAnfRG: TIWTemplateProcessorHTML;
    lblAnf: TmeIWLabel;
    cmbCodTabellaANF: TMedpIWMultiColumnComboBox;
    dlblDescTabellaANF: TmeIWDBLabel;
    lblScadenzaANF: TmeIWLabel;
    dedtScadenzaANF: TmeIWDBEdit;
    lblRedditoANF: TmeIWLabel;
    dedtRedditoANF: TmeIWDBEdit;
    lblRedditoAltroANF: TmeIWLabel;
    dedtRedditoAltroANF: TmeIWDBEdit;
    lblTotaleANF: TmeIWLabel;
    edtTotaleANF: TmeIWEdit;
    dchkInabileANF: TmeIWDBCheckBox;
    imgCalcolo: TmeIWImageFile;
    actlstCalcolo: TActionList;
    actCalcolo: TAction;
    lblCalcolo: TmeIWLabel;
    lblDataCalcoloAnf: TmeIWLabel;
    edtDataCalcoloAnf: TmeIWEdit;
    lblBloccaAnf: TmeIWLabel;
    lblNucleoCalcoloAnf: TmeIWLabel;
    edtNucleoCalcoloAnf: TmeIWEdit;
    lblRedditoCalcoloAnf: TmeIWLabel;
    edtRedditoCalcoloAnf: TmeIWEdit;
    lblAltriRedditiCalcoloAnf: TmeIWLabel;
    edtAltriRedditiCalcoloAnf: TmeIWEdit;
    lblTotaleCalcoloAnf: TmeIWLabel;
    edtTotaleCalcoloAnf: TmeIWEdit;
    lblCodTabellaCalcoloAnf: TmeIWLabel;
    edtTabellaCalcoloAnf: TmeIWEdit;
    lblTabellaCalcoloAnf: TmeIWLabel;
    lblImportoCalcoloAnf: TmeIWLabel;
    edtImportoCalcoloAnf: TmeIWEdit;
    grdDettaglioCalcoloAnf: TmeIWGrid;
    imgFamiliari: TmeIWImageFile;
    Wp430PrevidenzaRG: TmeIWRegion;
    TemplatePrevidenzaRG: TIWTemplateProcessorHTML;
    lblInps: TmeIWLabel;
    lnkCodiceInps: TmeIWLink;
    cmbCodiceInps: TMedpIWMultiColumnComboBox;
    dlblDescCodiceInps: TmeIWDBLabel;
    cmbCodInquadrINPS: TMedpIWMultiColumnComboBox;
    dlblDescInquadrInps: TmeIWDBLabel;
    lnkCodInquadrINPS: TmeIWLink;
    cmbTipoAss: TMedpIWMultiColumnComboBox;
    dlblDescTipoAss: TmeIWDBLabel;
    lblTipoAss: TmeIWLabel;
    cmbTipoCess: TMedpIWMultiColumnComboBox;
    dlblDescTipoCess: TmeIWDBLabel;
    lblTipoCess: TmeIWLabel;
    cmbTipoRappCoCoCo: TMedpIWMultiColumnComboBox;
    lblTipoRappCoCoCo: TmeIWLabel;
    dlblDescTipoRappCoCoCo: TmeIWDBLabel;
    cmbTipoAttCoCoCo: TMedpIWMultiColumnComboBox;
    dlblDescTipoAttCoCoCo: TmeIWDBLabel;
    lblTipoAttCoCoCo: TmeIWLabel;
    cmbAltreAssCoCoCo: TMedpIWMultiColumnComboBox;
    dlblDescAltreAssCoCoCo: TmeIWDBLabel;
    lblAltreAssCoCoCo: TmeIWLabel;
    lblINPDAP: TmeIWLabel;
    cmbCodInquadrINPDAP: TMedpIWMultiColumnComboBox;
    dlblDescInquadrINPDAP: TmeIWDBLabel;
    lnkCodInquadrINPDAP: TmeIWLink;
    cmbCodCudINPDAPCausaCess: TMedpIWMultiColumnComboBox;
    dlblDescCudINPDAPCausaCess: TmeIWDBLabel;
    lblCodCudINPDAPCausaCess: TmeIWLabel;
    lblENPAM: TmeIWLabel;
    cmbCategEnpam: TMedpIWMultiColumnComboBox;
    dlblDescCategEnpam: TmeIWDBLabel;
    lblCategEnpam: TmeIWLabel;
    dedtMatrPensionistica: TmeIWDBEdit;
    lblMatrPensionistica: TmeIWLabel;
    drgpMassimaleContr: TmeIWDBRadioGroup;
    lblMassimaleContr: TmeIWLabel;
    WP430AltraAmmRG: TmeIWRegion;
    TemplateAltraAmmRG: TIWTemplateProcessorHTML;
    lblAltraAmm: TmeIWLabel;
    drgpAltraAmm: TmeIWDBRadioGroup;
    cmbTipoServAltraAmm: TMedpIWMultiColumnComboBox;
    dlblDescTipoServAltraAmm: TmeIWDBLabel;
    lblTipoServAltraAmm: TmeIWLabel;
    dedtCodFiscaleAltraAmm: TmeIWDBEdit;
    lblCodFiscaleAltraAmm: TmeIWLabel;
    dedtProgAziendaAltraAmm: TmeIWDBEdit;
    lblProgAziendaAltraAmm: TmeIWLabel;
    WP430InailCu770RG: TmeIWRegion;
    TemplateINAILCU770RG: TIWTemplateProcessorHTML;
    lblINAIL: TmeIWLabel;
    cmbCodiceInail: TMedpIWMultiColumnComboBox;
    dlblDescCodiceInail: TmeIWDBLabel;
    lnkCodiceInail: TmeIWLink;
    cmbCodQualificaInail: TMedpIWMultiColumnComboBox;
    dlblDescQualificaInail: TmeIWDBLabel;
    lblCodQualificaInail: TmeIWLabel;
    lnkCodComuneInail: TmeIWLink;
    edtDescComuneInail: TmeIWEdit;
    dedtCodComuneInail: TmeIWDBEdit;
    btnComuneInail: TmeIWButton;
    lblCu770: TmeIWLabel;
    cmbCodCategParticolare: TMedpIWMultiColumnComboBox;
    dlblDescCategParticolare: TmeIWDBLabel;
    lblCodCategParticolare: TmeIWLabel;
    cmbCodCausaleLA: TMedpIWMultiColumnComboBox;
    dlblDescCausaleLA: TmeIWDBLabel;
    lblCausaleLA: TmeIWLabel;
    WP430ONAOSIRG: TmeIWRegion;
    TemplateONAOSIRG: TIWTemplateProcessorHTML;
    dcmbProfessioneONAOSI: TmeIWDBComboBox;
    lblProfessioneONAOSI: TmeIWLabel;
    cmbTipoPagOnaosi: TMedpIWMultiColumnComboBox;
    dlblDescTipoPagOnaosi: TmeIWDBLabel;
    lblTipoPagOnaosi: TmeIWLabel;
    lblTipoAssOnaosi: TmeIWLabel;
    cmbTipoAssOnaosi: TMedpIWMultiColumnComboBox;
    dlblDescTipoAssOnaosi: TmeIWDBLabel;
    cmbTipoCessOnaosi: TMedpIWMultiColumnComboBox;
    lblTipoCessOnaosi: TmeIWLabel;
    dlblDescTipoCessOnaosi: TmeIWDBLabel;
    dedtDataIscrAlbo: TmeIWDBEdit;
    lblDataIscrAlbo: TmeIWLabel;
    dedtNumIscrAlbo: TmeIWDBEdit;
    lblNumIscrAlbo: TmeIWLabel;
    dedtProvinciaAlbo: TmeIWDBEdit;
    lblProvinciaAlbo: TmeIWLabel;
    WP430FPCRG: TmeIWRegion;
    TemplateFPCRG: TIWTemplateProcessorHTML;
    cmbFpc: TMedpIWMultiColumnComboBox;
    dlblDescFpc: TmeIWDBLabel;
    lblIntestazioneFpc: TmeIWLabel;
    dedtDataFpc: TmeIWDBEdit;
    lblDataFpc: TmeIWLabel;
    dedtPercTotDipFpc: TmeIWDBEdit;
    lblPercTotDipFPC: TmeIWLabel;
    dedtDataSospCessFpc: TmeIWDBEdit;
    lblDataSospCessFpc: TmeIWLabel;
    lblMotivoSospFpc: TmeIWLabel;
    cmbMotivoSospFpc: TMedpIWMultiColumnComboBox;
    dlblDescMotivoSospFpc: TmeIWDBLabel;
    lblTipoCessFpc: TmeIWLabel;
    cmbTipoCessFpc: TMedpIWMultiColumnComboBox;
    dlblDescTipoCessFpc: TmeIWDBLabel;
    dedtRedditoDetrazConiuge: TmeIWDBEdit;
    dedtVariazioneImportoANF: TmeIWDBEdit;
    dedtComponentiANF: TmeIWDBEdit;
    dedtLivelloInps: TmeIWDBEdit;
    pmnStorico: TPopupMenu;
    mnuStoriaDipendente1: TMenuItem;
    mnuStoricizCorr1: TMenuItem;
    mnuStoriaDato1: TMenuItem;
    pmnStoricoRelaz: TPopupMenu;
    mnuStoriaDipendente2: TMenuItem;
    mnuStoricizCorr2: TMenuItem;
    mnuStoriaDato2: TMenuItem;
    MenuItem5: TMenuItem;
    mnuRelazioni: TMenuItem;
    lnkCodBanca: TmeIWLink;
    lnkCodiceTabellaANF: TmeIWLink;
    lnkFpc: TmeIWLink;
    lblAltraAmministrazione: TmeIWLabel;
    lblEnteAppartenenza: TmeIWLabel;
    lnkCodEnteAppartenenza: TmeIWLink;
    cmbCodEnteAppartenenza: TMedpIWMultiColumnComboBox;
    dlblDEnteAppartenenza: TmeIWDBLabel;
    dchkLavPrimaOccupFPC: TmeIWDBCheckBox;
    lblIbanEstero: TmeIWLabel;
    dedtIbanEstero: TmeIWDBEdit;
    lnkCodComuneIRPEF: TmeIWLink;
    edtDescComuneIRPEF: TmeIWEdit;
    btnComuneIRPEF: TmeIWButton;
    dedtCodComuneIRPEF: TmeIWDBEdit;
    dedtCittaEstera: TmeIWDBEdit;
    lblCittaEstera: TmeIWLabel;
    dedtQualProfInps: TmeIWDBEdit;
    lblQualProfInps: TmeIWLabel;
    dedtPercIrpefRegimiSpeciali: TmeIWDBEdit;
    lblPercIrpefTfr: TmeIWLabel;
    lblPercIrpefRegimiSpeciali: TmeIWLabel;
    lblTipoRetribuzione: TmeIWLabel;
    drgpTipoRetribuzione: TmeIWDBRadioGroup;
    lblTipoAdesioneFPC: TmeIWLabel;
    drgpTipoAdesioneFPC: TmeIWDBRadioGroup;
    lblDataInfSilAssFPC: TmeIWLabel;
    dedtDataInfSilAssFPC: TmeIWDBEdit;
    lblCodStatoEsteroRegimiSpeciali: TmeIWLabel;
    dedtCodStatoEsteroRegimiSpeciali: TmeIWDBEdit;
    lblRegimiSpeciali: TmeIWLabel;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure cmbCodContrattoAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbCodParametriStipendiAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbCodTipoAssogAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbPosEconomicaAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbStatoCivileAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbCodPartTimeAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure btnEredeClick(Sender: TObject);
    procedure dcmbTipoDipendenteChange(Sender: TObject);
    procedure btnImpostaIBANClick(Sender: TObject);
    procedure btnCodBancaClick(Sender: TObject);
    procedure dedtContoCorrenteAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure dedtCinItaliaAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure dedtCinEuropaAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure cmbPagamentoAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure cmbValutaCalcoloAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbValutaAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure cmbNazionalitaAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure dedtPercIrpefExtra27AsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure dchkPercIRPEFmaxExtra27AsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure cmbCodCausaleIrpefAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbCodRegioneIRPEFAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure btnRedditiAnnualiClick(Sender: TObject);
    procedure drgpTipoDetrazioniClick(Sender: TObject);
    procedure cmbCodTabellaANFAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure redditoANFAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure imgCalcoloClick(Sender: TObject);
    procedure grdDettaglioCalcoloAnfRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure imgFamiliariClick(Sender: TObject);
    procedure cmbCodiceInpsAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbCodInquadrINPSAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbTipoAssAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure cmbTipoCessAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure cmbTipoRappCoCoCoAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbTipoAttCoCoCoAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbAltreAssCoCoCoAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbCodInquadrINPDAPAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbCodCudINPDAPCausaCessAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbCategEnpamAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbTipoServAltraAmmAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure drgpAltraAmmClick(Sender: TObject);
    procedure cmbCodiceInailAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbCodQualificaInailAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure dedtCodComuneInailAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure cmbCodCategParticolareAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbCodCausaleLAAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbTipoPagOnaosiAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbTipoAssOnaosiAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbTipoCessOnaosiAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbFpcAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure cmbMotivoSospFpcAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbTipoCessFpcAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure edtAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure rgpClick(Sender: TObject);
    procedure dcmbProfessioneONAOSIAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure StoriaClick(Sender: TObject);
    procedure mnuRelazioniClick(Sender: TObject);
    procedure lnkCodContrattoClick(Sender: TObject);
    procedure lnkCodParametriStipendiClick(Sender: TObject);
    procedure lnkCodTipoAssogClick(Sender: TObject);
    procedure lnkPosEconomicaClick(Sender: TObject);
    procedure lnkCodiPartTimeClick(Sender: TObject);
    procedure lnkCodiceInpsClick(Sender: TObject);
    procedure lnkCodiceInailClick(Sender: TObject);
    procedure lnkStatoCivileClick(Sender: TObject);
    procedure lnkNazionalitaClick(Sender: TObject);
    procedure lnkPagamentoClick(Sender: TObject);
    procedure lnkCodBancaClick(Sender: TObject);
    procedure lnkValutaClick(Sender: TObject);
    procedure lnkValutaCalcoloClick(Sender: TObject);
    procedure lnkCodCausaleIrpefClick(Sender: TObject);
    procedure lnkCodComuneInailClick(Sender: TObject);
    procedure lnkCodRegioneIRPEFClick(Sender: TObject);
    procedure lnkCodiceTabellaANFClick(Sender: TObject);
    procedure lnkCodInquadrINPSClick(Sender: TObject);
    procedure lnkCodInquadrINPDAPClick(Sender: TObject);
    procedure lnkFpcClick(Sender: TObject);
    procedure lnkCodEnteAppartenenzaClick(Sender: TObject);
    procedure cmbCodEnteAppartenenzaAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure dedtCodBancaAsyncExit(Sender: TObject; EventParams: TStringList);
    procedure dedtIbanEsteroAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure lnkCodComuneIRPEFClick(Sender: TObject);
    procedure dedtCodComuneIRPEFAsyncChange(Sender: TObject;
      EventParams: TStringList);
  private
    IntfWebT480: TIntfWebT480;
    IntfWebT480S: TIntfWebT480;
    SchedaAnagrafica: Array of TSchedaAnagrafica;
    procedure CaricaCombo(cmb: TmedpIWMulticolumnCombobox; ods: TOracleDataset);
    procedure ResultElencoEredi(Sender: TObject; Result: Boolean);
    procedure ImpostaComponentiVisible;
    procedure ResultElencoBanche(Sender: TObject; Result: Boolean);
    procedure ImpostaSchedaAnagrafica;
    function CampoRelazione(i: Integer): Boolean;
    procedure ImpostaEnabled(Componente: TControl; Val: Boolean);
    function IndiceComponente(Campo: String): Integer;
    function IndiceComponenteByNomeComp(NomeComponente: String): Integer;
    procedure ResultComune;
    procedure ResultComuneSoppresso;
    procedure ImpostaContextMenu(Componente: TControl; Val: TPopupMenu);
    procedure ImpostaContextMenuComponenti;
    procedure SpostaStoricoResultEvent(Sender: TObject; ResultDec,ResultFine: TDateTime);
    function CampoAccessoRelazioni(i: Integer): String;
  public
    procedure EseguiRelazioni(sNomeCampo:String);
    procedure VisualizzaDatiCalcoloAnf;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnCombobox; override;
    procedure AbilitaComponenti; override;
  end;

implementation

uses
  WP430UAnagrafico;

{$R *.dfm}
procedure TWP430FAnagraficoDettFM.IWFrameRegionCreate(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  //campi sempre nascoscti. creato soli perchè presenti in SchedaAnagrafica e possono essere oggetto di relazioni
  dedtRedditoDetrazConiuge.Visible:=False;
  dedtVariazioneImportoANF.Visible:=False;
  dedtComponentiANF.Visible:=False;
  dedtLivelloInps.Visible:=False;

  dcmbTipoDipendente.Items.Clear;
  for i:=Low(D_TipoDipendente) to High(D_TipoDipendente) do
  begin
    dcmbTipoDipendente.Items.Add(D_TipoDipendente[i].item + '=' + D_TipoDipendente[i].Value);
  end;

  dcmbProfessioneONAOSI.Items.Clear;
  for i:=Low(D_ProfessioneONAOSI) to High(D_ProfessioneONAOSI) do
  begin
    dcmbProfessioneONAOSI.Items.Add(D_ProfessioneONAOSI[i].item + '=' + D_ProfessioneONAOSI[i].Value);
  end;

  grdTabDetail.AggiungiTab('Posizione',WP430PosizioneRG);
  grdTabDetail.AggiungiTab('Dati aggiuntivi',WP430DatiAggiuntiviRG);
  grdTabDetail.AggiungiTab('Parametri calcolo',WP430ParametriCalcoloRG);
  grdTabDetail.AggiungiTab('Detrazioni',WP430DetrazioniRG);
  grdTabDetail.AggiungiTab('A.N.F.',WP430AnfRG);
  grdTabDetail.AggiungiTab('Previdenza',WP430PrevidenzaRG);
  grdTabDetail.AggiungiTab('Altra amm.',WP430AltraAmmRG);
  grdTabDetail.AggiungiTab('INAIL/CU',WP430InailCu770RG);
  if Parametri.CodContrattoSanita = 'S' then
    grdTabDetail.AggiungiTab('O.N.A.O.S.I.',WP430ONAOSIRG)
  else
    WP430ONAOSIRG.Visible:=False;
  grdTabDetail.AggiungiTab('F.P.C.',WP430FPCRG);

  grdTabDetail.ActiveTab:=WP430PosizioneRG;
  C190VisualizzaElemento(JQuery,'divCalcoloAnf',actCalcolo.Checked);

  IntfWebT480:=TIntfWebT480.Create(Self.Parent);
  with IntfWebT480 do
  begin
    Chiave:='CODCATASTALE';
    DataSource:=(WR302DM as TWP430FAnagraficoDM).P430FAnagraficoMW.dsrT480;
    edtCitta:=edtDescComuneInail;
    dedtCodice:=dedtCodComuneInail;
    btnLookup:=btnComuneInail;
    CustomResultLookup:=ResultComune;
  end;
  IntfWebT480S:=TIntfWebT480.Create(Self.Parent);
  with IntfWebT480S do
  begin
    Chiave:='CODICE';
    DataSource:=(WR302DM as TWP430FAnagraficoDM).P430FAnagraficoMW.dsrT480S;
    edtCitta:=edtDescComuneIRPEF;
    dedtCodice:=dedtCodComuneIRPEF;
    btnLookup:=btnComuneIRPEF;
    CustomResultLookup:=ResultComuneSoppresso;
  end;
  ImpostaSchedaAnagrafica;
end;

procedure TWP430FAnagraficoDettFM.lnkCodBancaClick(Sender: TObject);
var
  Params: string;
begin
  Params:='COD_BANCA=' + dedtCodBanca.Text;
  TWR100FBase(Self.Parent).AccediForm(515,Params);
end;

procedure TWP430FAnagraficoDettFM.lnkCodCausaleIrpefClick(Sender: TObject);
var
  Params: String;
begin
  Params:='COD_CAUSALEIRPEF=' + cmbCodCausaleIrpef.Text;
  TWR100FBase(Self.Parent).AccediForm(522,Params);
end;

procedure TWP430FAnagraficoDettFM.lnkCodComuneInailClick(Sender: TObject);
var
  CodComune, Params: String;
begin
  inherited;
  CodComune:=VarToStr((WR302DM as TWP430FAnagraficoDM).P430FAnagraficoMW.T480_COMUNI.Lookup('CODCATASTALE',dedtCodComuneInail.Text,'CODICE'));

  Params:='CODICE=' + codComune + ParamDelimiter +
          'TIPOARCHIVIO=C' + ParamDelimiter + 'TIPOCOMUNE=T';

  TWR100FBase(Self.Parent).AccediForm(530,Params);
end;

procedure TWP430FAnagraficoDettFM.lnkCodComuneIRPEFClick(Sender: TObject);
var Params: String;
begin
  inherited;
  Params:='CODICE=' + dedtCodComuneIRPEF.Text + ParamDelimiter +
          'TIPOARCHIVIO=C' + ParamDelimiter + 'TIPOCOMUNE=T';

  TWR100FBase(Self.Parent).AccediForm(530,Params);
end;

procedure TWP430FAnagraficoDettFM.lnkCodContrattoClick(Sender: TObject);
var
  Params: String;
begin
  Params:='COD_CONTRATTO=' + cmbCodContratto.Text;
  TWR100FBase(Self.Parent).AccediForm(507,Params);
end;

procedure TWP430FAnagraficoDettFM.lnkCodEnteAppartenenzaClick(Sender: TObject);
var
  Params: String;
begin
  Params:='COD_ENTE_APPARTENENZA=' + cmbCodEnteAppartenenza.Text;
  TWR100FBase(Self.Parent).AccediForm(637,Params);
end;

procedure TWP430FAnagraficoDettFM.lnkCodiceInailClick(Sender: TObject);
var
  Params: String;
begin
  Params:='COD_CODICEINAIL=' + cmbCodiceInail.Text;
  TWR100FBase(Self.Parent).AccediForm(529,Params);
end;

procedure TWP430FAnagraficoDettFM.lnkCodiceInpsClick(Sender: TObject);
var
  Params: String;
begin
  Params:='COD_CODICEINPS=' + cmbCodiceInps.Text;
  TWR100FBase(Self.Parent).AccediForm(528,Params);
end;

procedure TWP430FAnagraficoDettFM.lnkCodiceTabellaANFClick(Sender: TObject);
var
  Params: String;
begin
  Params:='COD_TABELLAANF=' + cmbCodTabellaANF.Text;
  TWR100FBase(Self.Parent).AccediForm(513,Params);
end;

procedure TWP430FAnagraficoDettFM.lnkCodInquadrINPDAPClick(Sender: TObject);
var
  Params: String;
begin
  Params:='COD_INQUADRINPDAP=' + cmbCodInquadrINPDAP.Text;
  TWR100FBase(Self.Parent).AccediForm(541,Params);
end;

procedure TWP430FAnagraficoDettFM.lnkCodInquadrINPSClick(Sender: TObject);
var
  Params: String;
begin
  Params:='COD_INQUADRINPS=' + cmbCodInquadrINPS.Text;
  TWR100FBase(Self.Parent).AccediForm(540,Params);
end;

procedure TWP430FAnagraficoDettFM.lnkCodiPartTimeClick(Sender: TObject);
var
  Params: String;
begin
  Params:='COD_PARTTIME=' + cmbCodPartTime.Text;
  TWR100FBase(Self.Parent).AccediForm(512,Params);
end;

procedure TWP430FAnagraficoDettFM.lnkCodParametriStipendiClick(Sender: TObject);
var
  Params: String;
begin
  Params:='COD_PARAMETRISTIPENDI=' + cmbCodParametriStipendi.Text;
  TWR100FBase(Self.Parent).AccediForm(508,Params);
end;

procedure TWP430FAnagraficoDettFM.lnkCodRegioneIRPEFClick(Sender: TObject);
var
  Params: string;
begin
  Params:='CODICE=' + cmbCodRegioneIRPEF.Text + ParamDelimiter +
          'TIPOARCHIVIO=R' ;

  TWR100FBase(Self.Parent).AccediForm(530,Params);

end;

procedure TWP430FAnagraficoDettFM.lnkCodTipoAssogClick(Sender: TObject);
var
  Params: String;
begin
  Params:='COD_CONTRATTO=' +  cmbCodContratto.Text + ParamDelimiter +
          'COD_TIPOASSOGGETTAMENTO=' +  cmbCodTipoAssog.Text;
  TWR100FBase(Self.Parent).AccediForm(534,Params);
end;

procedure TWP430FAnagraficoDettFM.lnkFpcClick(Sender: TObject);
var
  Params: String;
begin
  Params:='COD_FPC=' + cmbFpc.Text;
  TWR100FBase(Self.Parent).AccediForm(613,Params);
end;

procedure TWP430FAnagraficoDettFM.lnkNazionalitaClick(Sender: TObject);
var
  Params: String;
begin
  Params:='COD_NAZIONALITA=' + cmbNazionalita.Text;
  TWR100FBase(Self.Parent).AccediForm(549,Params);
end;

procedure TWP430FAnagraficoDettFM.lnkPagamentoClick(Sender: TObject);
var
  Params: String;
begin
  Params:='COD_PAGAMENTO=' + cmbPagamento.Text;
  TWR100FBase(Self.Parent).AccediForm(514,Params);
end;

procedure TWP430FAnagraficoDettFM.lnkPosEconomicaClick(Sender: TObject);
var
  Params: String;
begin
  Params:='COD_CONTRATTO=' + cmbCodContratto.Text + ParamDelimiter +
          'COD_POSIZIONE_ECONOMICA=' + cmbPosEconomica.Text;
  TWR100FBase(Self.Parent).AccediForm(509,Params);
end;

procedure TWP430FAnagraficoDettFM.lnkStatoCivileClick(Sender: TObject);
var
  Params: String;
begin
  Params:='COD_STATOCIVILE=' + cmbStatoCivile.Text;
  TWR100FBase(Self.Parent).AccediForm(548,Params);
end;

procedure TWP430FAnagraficoDettFM.lnkValutaCalcoloClick(Sender: TObject);
var
  Params: String;
begin
  Params:='COD_VALUTA=' + cmbValutaCalcolo.Text;
  TWR100FBase(Self.Parent).AccediForm(517,Params);
end;

procedure TWP430FAnagraficoDettFM.lnkValutaClick(Sender: TObject);
var
  Params: String;
begin
  Params:='COD_VALUTA=' + cmbValuta.Text;
  TWR100FBase(Self.Parent).AccediForm(517,Params);
end;

procedure TWP430FAnagraficoDettFM.mnuRelazioniClick(Sender: TObject);
var
  Params: String;
begin
  Params:='TABELLA=P430_ANAGRAFICO' + ParamDelimiter +
          'COLONNA=' +  CampoAccessoRelazioni(IndiceComponenteByNomeComp(pmnStoricoRelaz.PopupComponent.Name)) + ParamDelimiter +
          'DATA=' + DateToStr(WR302DM.selTabella.FieldByName('DECORRENZA').AsDateTime);
  TWR100FBase(Self.Parent).AccediForm(190,Params);
end;

function TWP430FAnagraficoDettFM.CampoAccessoRelazioni(i: Integer): String;
begin
  Result:=SchedaAnagrafica[i].NomeCampo;
end;

procedure TWP430FAnagraficoDettFM.ResultComune;
begin
  EseguiRelazioni('COD_COMUNE_INAIL');
end;

procedure TWP430FAnagraficoDettFM.ResultComuneSoppresso;
begin
  EseguiRelazioni('COD_COMUNE_IRPEF');
end;

procedure TWP430FAnagraficoDettFM.ImpostaSchedaAnagrafica;
var
  i: Integer;
begin
  SetLength(SchedaAnagrafica,92);
  i:=0;
  SchedaAnagrafica[i].NomeCampo:='COD_CONTRATTO';
  SchedaAnagrafica[i].Componente:=cmbCodContratto;
  //SchedaAnagrafica[i].lblComponente:=dlblContratto;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_PARAMETRISTIPENDI';
  SchedaAnagrafica[i].Componente:=cmbCodParametriStipendi;
  //SchedaAnagrafica[i].lblComponente:=dlblParametriStipendi;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_TIPOASSOGGETTAMENTO';
  SchedaAnagrafica[i].Componente:=cmbCodTipoAssog;
  //SchedaAnagrafica[i].lblComponente:=dlblTipoAssoggettamento;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_POSIZIONE_ECONOMICA';
  SchedaAnagrafica[i].Componente:=cmbPosEconomica;
  //SchedaAnagrafica[i].lblComponente:=dlblPosEconomica;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_PARTTIME';
  SchedaAnagrafica[i].Componente:=cmbCodPartTime;
  //SchedaAnagrafica[i].lblComponente:=dlblPartTime;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='TIPO_DIPENDENTE';
  SchedaAnagrafica[i].Componente:=dcmbTipoDipendente;
  SchedaAnagrafica[i].lblComponente:=lblTipoDipendente;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='D_NOMINATIVO_EREDE';
  SchedaAnagrafica[i].Componente:=dedtDNominativoErede;
  SchedaAnagrafica[i].lblComponente:=lblProgressivoEredeDi;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='PERC_EREDITA';
  SchedaAnagrafica[i].Componente:=dedtPercEredita;
  SchedaAnagrafica[i].lblComponente:=lblPercEredita;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='STATO_DIPENDENTE';
  SchedaAnagrafica[i].Componente:=drgpStatoDipendente;
  SchedaAnagrafica[i].lblComponente:=lblStatoDipendente;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='NO_CEDOLINO_NORMALE';
  SchedaAnagrafica[i].Componente:=drgpNoCedolinoNormale;
  SchedaAnagrafica[i].lblComponente:=lblNoCedolinoNormale;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='RETRIB_MESE_PREC';
  SchedaAnagrafica[i].Componente:=drgpTipoRetribuzione;
  SchedaAnagrafica[i].lblComponente:=lblTipoRetribuzione;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_BANCA';
  SchedaAnagrafica[i].Componente:=dedtCodBanca;
  //SchedaAnagrafica[i].lblComponente:=dlblDBanca;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='CONTO_CORRENTE';
  SchedaAnagrafica[i].Componente:=dedtContoCorrente;
  SchedaAnagrafica[i].lblComponente:=lblContoCorrente;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='CIN_ITALIA';
  SchedaAnagrafica[i].Componente:=dedtCinItalia;
  SchedaAnagrafica[i].lblComponente:=lblCinItalia;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='CIN_EUROPA';
  SchedaAnagrafica[i].Componente:=dedtCinEuropa;
  SchedaAnagrafica[i].lblComponente:=lblCinEuropa;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_PAGAMENTO';
  SchedaAnagrafica[i].Componente:=cmbPagamento;
  //SchedaAnagrafica[i].lblComponente:=dlblDescPagamento;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_VALUTA_BASE';
  SchedaAnagrafica[i].Componente:=cmbValutaCalcolo;
  //SchedaAnagrafica[i].lblComponente:=dlblDescValutaCalcolo;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_VALUTA_STAMPA';
  SchedaAnagrafica[i].Componente:=cmbValuta;
  //SchedaAnagrafica[i].lblComponente:=dlblDescValuta;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_STATOCIVILE';
  SchedaAnagrafica[i].Componente:=cmbStatoCivile;
  //SchedaAnagrafica[i].lblComponente:=dlblDescStatoCivile;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_NAZIONALITA';
  SchedaAnagrafica[i].Componente:=cmbNazionalita;
  //SchedaAnagrafica[i].lblComponente:=dlblDescNazionalita;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='TREDICESIMA';
  SchedaAnagrafica[i].Componente:=drgpTredicesima;
  SchedaAnagrafica[i].lblComponente:=lblPrevista;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='TIPO_CALCOLO_IMPORTO13A';
  SchedaAnagrafica[i].Componente:=drgpTipoCalcoloImporto13A;
  SchedaAnagrafica[i].lblComponente:=lblTipoCalcoloImporto;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='CONGUAGLIO';
  SchedaAnagrafica[i].Componente:=drgpConguaglio;
  SchedaAnagrafica[i].lblComponente:=lblConguaglio;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='PERC_IRPEF_MANUALE';
  SchedaAnagrafica[i].Componente:=dedtPercIRPEFManuale;
  SchedaAnagrafica[i].lblComponente:=lblPercIrpefManuale;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='PERC_IRPEF_EXTRA27';
  SchedaAnagrafica[i].Componente:=dedtPercIrpefExtra27;
  SchedaAnagrafica[i].lblComponente:=lblPercIrpefExtra27;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='PERC_IRPEF_MASSIMA_EXTRA27';
  SchedaAnagrafica[i].Componente:=dchkPercIRPEFmaxExtra27;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='PERC_IRPEF_TFR';
  SchedaAnagrafica[i].Componente:=dedtPercIrpefTfr;
  SchedaAnagrafica[i].lblComponente:=lblPercIrpefTfr;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_CAUSALEIRPEF';
  SchedaAnagrafica[i].Componente:=cmbCodCausaleIRPEF;
  //SchedaAnagrafica[i].lblComponente:=dlblDescCausaleIrpef;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_REGIONE_IRPEF';
  SchedaAnagrafica[i].Componente:=cmbCodRegioneIRPEF;
  //SchedaAnagrafica[i].lblComponente:=dlblDescCausaleIrpef;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='D_COMUNE_IRPEF';
  SchedaAnagrafica[i].Componente:=edtDescComuneIRPEF;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_COMUNE_IRPEF';
  SchedaAnagrafica[i].Componente:=dedtCodComuneIRPEF;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='REDDITO_DETRAZ_FIGLI_ALTRI';
  SchedaAnagrafica[i].Componente:=dedtRedditoDetrazFigliAltri;
  SchedaAnagrafica[i].lblComponente:=lblRedditoDetrazFigliAltri;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='REDDITO_DETRAZ_CONIUGE';
  SchedaAnagrafica[i].Componente:=dedtRedditoDetrazConiuge;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='REDDITO_DETRAZ_LAVDIP';
  SchedaAnagrafica[i].Componente:=dedtRedditoDetrazLavDip;
  SchedaAnagrafica[i].lblComponente:=lblRedditoDetrazLavDip;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='DETRAZ_LAVDIP';
  SchedaAnagrafica[i].Componente:=drgpTipoDetrazioni;
  SchedaAnagrafica[i].lblComponente:=lblTipoDetrazioni;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='DETRAZ_REDDITI_MIN_INDET';
  SchedaAnagrafica[i].Componente:=dchkDetrazRedditiMinIndet;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='DETRAZ_REDDITI_MIN_DET';
  SchedaAnagrafica[i].Componente:=dchkDetrazRedditiMinDet;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='PERC_DETRAZ_FAM_NUMEROSE';
  SchedaAnagrafica[i].Componente:=dchkPercDetraz;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='CREDITO_FAM_NUMEROSE';
  SchedaAnagrafica[i].Componente:=dchkCreditoFamNumerose;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='BONUS_RIDUZ_CUNEO_FISC';
  SchedaAnagrafica[i].Componente:=drgpTipoBonus;
  SchedaAnagrafica[i].lblComponente:=lblTipoBonus;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_TABELLAANF';
  SchedaAnagrafica[i].Componente:=cmbCodTabellaANF;
  //SchedaAnagrafica[i].lblComponente:=dlblDescTabellaANF;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='SCADENZA_ANF';
  SchedaAnagrafica[i].Componente:=dedtScadenzaANF;
  SchedaAnagrafica[i].lblComponente:=lblScadenzaANF;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='REDDITO_ANF';
  SchedaAnagrafica[i].Componente:=dedtRedditoANF;
  SchedaAnagrafica[i].lblComponente:=lblRedditoANF;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='REDDITO_ALTRO_ANF';
  SchedaAnagrafica[i].Componente:=dedtRedditoAltroANF;
  SchedaAnagrafica[i].lblComponente:=lblRedditoAltroANF;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='INABILE_ANF';
  SchedaAnagrafica[i].Componente:=dchkInabileANF;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='VARIAZIONE_IMPORTO_ANF';
  SchedaAnagrafica[i].Componente:=dedtVariazioneImportoANF;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COMPONENTI_ANF';
  SchedaAnagrafica[i].Componente:=dedtComponentiANF;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_CODICEINPS';
  SchedaAnagrafica[i].Componente:=cmbCodiceINPS;
  //SchedaAnagrafica[i].lblComponente:=dlblDescCodiceInps;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='LIVELLO_INPS';
  SchedaAnagrafica[i].Componente:=dedtLivelloInps;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_INQUADRINPS';
  SchedaAnagrafica[i].Componente:=cmbCodInquadrINPS;
  //SchedaAnagrafica[i].lblComponente:=dlblDescInquadrInps;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_EMENSQUALPROF';
  SchedaAnagrafica[i].Componente:=dedtQualProfInps;
  SchedaAnagrafica[i].lblComponente:=lblQualProfInps;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_EMENSTIPOASS';
  SchedaAnagrafica[i].Componente:=cmbTipoAss;
  SchedaAnagrafica[i].lblComponente:=lblTipoAss; //dlblDescTipoAss
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_EMENSTIPOCESS';
  SchedaAnagrafica[i].Componente:=cmbTipoCess;
  SchedaAnagrafica[i].lblComponente:=lblTipoCess; //dlblDescTipoCess
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_TIPORAPP_COCOCO';
  SchedaAnagrafica[i].Componente:=cmbTipoRappCoCoCo;
  SchedaAnagrafica[i].lblComponente:=lblTipoRappCoCoCo; //dlblDescTipoRappCoCoCo
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_TIPOATT_COCOCO';
  SchedaAnagrafica[i].Componente:=cmbTipoAttCoCoCo;
  SchedaAnagrafica[i].lblComponente:=lblTipoAttCoCoCo; //dlblDescTipoAttCoCoCo
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_ALTRAASS_COCOCO';
  SchedaAnagrafica[i].Componente:=cmbAltreAssCoCoCo;
  SchedaAnagrafica[i].lblComponente:=lblAltreAssCoCoCo; //dlblDescAltreAssCoCoCo
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_INQUADRINPDAP';
  SchedaAnagrafica[i].Componente:=cmbCodInquadrINPDAP;
  //SchedaAnagrafica[i].lblComponente:=dlblDescInquadrINPDAP;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_CUDINPDAPCAUSACESS';
  SchedaAnagrafica[i].Componente:=cmbCodCudINPDAPCausaCess;
  SchedaAnagrafica[i].lblComponente:=lblInps; //dlblDescCudINPDAPCausaCess
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_CATEG_CONVENZ';
  SchedaAnagrafica[i].Componente:=cmbCategEnpam;
  SchedaAnagrafica[i].lblComponente:=lblCategEnpam; //dlblDescCategEnpam;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='TIPO_MASSIMALE_CONTR';
  SchedaAnagrafica[i].Componente:=drgpMassimaleContr;
  SchedaAnagrafica[i].lblComponente:=lblMassimaleContr;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='MATR_PENSIONISTICA';
  SchedaAnagrafica[i].Componente:=dedtMatrPensionistica;
  SchedaAnagrafica[i].lblComponente:=lblMatrPensionistica;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='ALTRA_AMM';
  SchedaAnagrafica[i].Componente:=drgpAltraAmm;
  SchedaAnagrafica[i].lblComponente:=lblAltraAmm;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_INPDAPTIPOLS_ALTRA_AMM';
  SchedaAnagrafica[i].Componente:=cmbTipoServAltraAmm;
  SchedaAnagrafica[i].lblComponente:=lblTipoServAltraAmm; //dlblDescTipoServAltraAmm
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_FISCALE_ALTRA_AMM';
  SchedaAnagrafica[i].Componente:=dedtCodFiscaleAltraAmm;
  SchedaAnagrafica[i].lblComponente:=lblCodFiscaleAltraAmm;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='CODICE_INPDAP_ALTRA_AMM';
  SchedaAnagrafica[i].Componente:=dedtProgAziendaAltraAmm;
  SchedaAnagrafica[i].lblComponente:=lblProgAziendaAltraAmm;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_CODICEINAIL';
  SchedaAnagrafica[i].Componente:=cmbCodiceINAIL;
  //SchedaAnagrafica[i].lblComponente:=dlblDescCodiceInail;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_QUALIFICA_INAIL';
  SchedaAnagrafica[i].Componente:=cmbCodQualificaINAIL;
  SchedaAnagrafica[i].lblComponente:=lblCodQualificaInail; //dlblDescCodiceInail
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='D_COMUNE_INAIL';
  SchedaAnagrafica[i].Componente:=edtDescComuneInail;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_COMUNE_INAIL';
  SchedaAnagrafica[i].Componente:=dedtCodComuneINAIL;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_CATEGPARTICOLARE';
  SchedaAnagrafica[i].Componente:=cmbCodCategParticolare;
  SchedaAnagrafica[i].lblComponente:=lblCodCategParticolare; //dlblDescCategParticolare
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_CAUSALELA';
  SchedaAnagrafica[i].Componente:=cmbCodCausaleLA;
  SchedaAnagrafica[i].lblComponente:=lblCausaleLA; //dlblDescCausaleLA
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='PROFESSIONE_ONAOSI';
  SchedaAnagrafica[i].Componente:=dcmbProfessioneONAOSI;
  SchedaAnagrafica[i].lblComponente:=lblProfessioneONAOSI;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_ONAOSITIPOPAG';
  SchedaAnagrafica[i].Componente:=cmbTipoPagOnaosi;
  SchedaAnagrafica[i].lblComponente:=lblTipoPagOnaosi; //dlblDescTipoPagOnaosi
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_ONAOSITIPOASS';
  SchedaAnagrafica[i].Componente:=cmbTipoAssOnaosi;
  SchedaAnagrafica[i].lblComponente:=lblTipoAssOnaosi; //dlblDescTipoAssOnaosi
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_ONAOSITIPOCESS';
  SchedaAnagrafica[i].Componente:=cmbTipoCessOnaosi;
  SchedaAnagrafica[i].lblComponente:=lblTipoCessOnaosi; //dlblDescTipoCessOnaosi
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='DATA_ISCRIZIONE_ALBO';
  SchedaAnagrafica[i].Componente:=dedtDataIscrAlbo;
  SchedaAnagrafica[i].lblComponente:=lblDataIscrAlbo;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='NUMERO_ISCRIZIONE_ALBO';
  SchedaAnagrafica[i].Componente:=dedtNumIscrAlbo;
  SchedaAnagrafica[i].lblComponente:=lblNumIscrAlbo;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='PROVINCIA_ALBO';
  SchedaAnagrafica[i].Componente:=dedtProvinciaAlbo;
  SchedaAnagrafica[i].lblComponente:=lblProvinciaAlbo;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_FPC';
  SchedaAnagrafica[i].Componente:=cmbFPC;
  //SchedaAnagrafica[i].lblComponente:=dlblDescFpc;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='DATA_DOMANDA_FPC';
  SchedaAnagrafica[i].Componente:=dedtDataFPC;
  SchedaAnagrafica[i].lblComponente:=lblDataFpc;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='LAV_PRIMA_OCCUP_FPC';
  SchedaAnagrafica[i].Componente:=dchkLavPrimaOccupFPC;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='PERC_TOT_DIP_FPC';
  SchedaAnagrafica[i].Componente:=dedtPercTotDipFPC;
  SchedaAnagrafica[i].lblComponente:=lblPercTotDipFPC;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='DATA_SOSP_CESS_FPC';
  SchedaAnagrafica[i].Componente:=dedtDataSospCessFPC;
  SchedaAnagrafica[i].lblComponente:=lblDataSospCessFpc;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_INPDAPMOTIVOSOSP_FPC';
  SchedaAnagrafica[i].Componente:=cmbMotivoSospFPC;
  SchedaAnagrafica[i].lblComponente:=lblMotivoSospFpc; //dlblDescMotivoSospFpc
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_INPDAPTIPOCESS_FPC';
  SchedaAnagrafica[i].Componente:=cmbTipoCessFPC;
  SchedaAnagrafica[i].lblComponente:=lblTipoCessFpc; //dlblDescTipoCessFpc
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_ENTE_APPARTENENZA';
  SchedaAnagrafica[i].Componente:=cmbCodEnteAppartenenza;
  //SchedaAnagrafica[i].lblComponente:=dlblDEnteAppartenenza;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='IBAN_ESTERO';
  SchedaAnagrafica[i].Componente:=dedtIbanEstero;
  SchedaAnagrafica[i].lblComponente:=lblIbanEstero;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='IBAN_ESTERO_CITTA';
  SchedaAnagrafica[i].Componente:=dedtCittaEstera;
  SchedaAnagrafica[i].lblComponente:=lblCittaEstera;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='PERC_IRPEF_REGIMI_SPECIALI';
  SchedaAnagrafica[i].Componente:=dedtPercIrpefRegimiSpeciali;
  SchedaAnagrafica[i].lblComponente:=lblPercIrpefRegimiSpeciali;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='TIPO_ADESIONE_FPC';
  SchedaAnagrafica[i].Componente:=drgpTipoAdesioneFPC;
  SchedaAnagrafica[i].lblComponente:=lblTipoAdesioneFPC;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='DATA_INF_SIL_ASS_FPC';
  SchedaAnagrafica[i].Componente:=dedtDataInfSilAssFPC;
  SchedaAnagrafica[i].lblComponente:=lblDataInfSilAssFPC;
  inc(i);
  SchedaAnagrafica[i].NomeCampo:='COD_STATO_EST_REG_SPEC';
  SchedaAnagrafica[i].Componente:=dedtCodStatoEsteroRegimiSpeciali;
  SchedaAnagrafica[i].lblComponente:=lblCodStatoEsteroRegimiSpeciali;

  ImpostaContextMenuComponenti;
end;

procedure TWP430FAnagraficoDettFM.CaricaMultiColumnCombobox;
begin
  inherited;
  with (WR302DM as TWP430FAnagraficoDM).P430FAnagraficoMW do
  begin
    //Contratto voci
    CaricaCombo(cmbCodContratto,q210);
    CaricaCombo(cmbCodParametriStipendi,q212);
    CaricaCombo(cmbCodTipoAssog,Q240);
    CaricaCombo(cmbPosEconomica,Q220);
    CaricaCombo(cmbCodPartTime,Q040);
    CaricaCombo(cmbPagamento,Q130);
    CaricaCombo(cmbValutaCalcolo,Q030);
    CaricaCombo(cmbValuta,Q030);
    CaricaCombo(cmbStatoCivile,Q020);
    CaricaCombo(cmbNazionalita,Q120);
    CaricaCombo(cmbCodCausaleIrpef,Q080);
    CaricaCombo(cmbCodRegioneIRPEF,selT482);
    CaricaCombo(cmbCodTabellaANF,Q236);
    CaricaCombo(cmbCodiceInps,Q090);
    CaricaCombo(cmbCodInquadrINPS,Q096);
    CaricaCombo(cmbTipoAss,selP004TipoAss);
    CaricaCombo(cmbTipoCess,selP004TipoCess);
    CaricaCombo(cmbTipoRappCoCoCo,selP004TipoRapp);
    CaricaCombo(cmbTipoAttCoCoCo,selP004TipoAtt);
    CaricaCombo(cmbAltreAssCoCoCo,selP004AltreAssic);
    CaricaCombo(cmbCodInquadrINPDAP,Q094);
    CaricaCombo(cmbCodCudINPDAPCausaCess,selP004CausaCess);
    CaricaCombo(cmbCategEnpam,selP004CategConvenz);
    CaricaCombo(cmbTipoServAltraAmm,selP004TipoServAltraAmm);
    CaricaCombo(cmbCodiceInail,Q092);
    CaricaCombo(cmbCodQualificaInail,selP004QualifInail);
    CaricaCombo(cmbCodCategParticolare,selP004CatPart770);
    CaricaCombo(cmbCodCausaleLA,selP004CausPag770);
    CaricaCombo(cmbTipoPagOnaosi,selP004TipoPagOnaosi);
    CaricaCombo(cmbTipoAssOnaosi,selP004TipoAssOnaosi);
    CaricaCombo(cmbTipoCessOnaosi,selP004TipoCessOnaosi);
    CaricaCombo(cmbFpc,selP026);
    CaricaCombo(cmbMotivoSospFpc,selP004SospFPC);
    CaricaCombo(cmbTipoCessFpc,selP004CessFPC);
    CaricaCombo(cmbCodEnteAppartenenza,Q015);
  end;
end;

function TWP430FAnagraficoDettFM.CampoRelazione(i: Integer): Boolean;
begin
  Result:=False;
  if TWP430FAnagraficoDM(WR302DM).P430FAnagraficoMW.selI030.SearchRecord('COLONNA;TIPO',VarArrayOf([SchedaAnagrafica[i].NomeCampo,'S']),[srFromBeginning]) then
    Result:=True;
end;

function TWP430FAnagraficoDettFM.IndiceComponente(Campo: String): Integer;
var
  i: Integer;
begin
  Result:=-1;
  for i:=0 to Length(SchedaAnagrafica) - 1 do
    if UpperCase(SchedaAnagrafica[i].NomeCampo) = UpperCase(Campo) then
    begin
      Result:=i;
      Break;
    end;
end;

function TWP430FAnagraficoDettFM.IndiceComponenteByNomeComp(NomeComponente: String): Integer;
var
  i: Integer;
begin
  Result:=-1;
  for i:=0 to Length(SchedaAnagrafica) - 1 do
    if (UpperCase(NomeComponente) = UpperCase(SchedaAnagrafica[i].Componente.Name)) then
    begin
      Result:=i;
      Exit;
    end;
  for i:=0 to Length(SchedaAnagrafica) - 1 do
    begin
      if not Assigned(SchedaAnagrafica[i].lblComponente) then
        Continue;
      if (UpperCase(NomeComponente) = UpperCase(SchedaAnagrafica[i].lblComponente.Name)) then
      begin
        Result:=i;
        Break;
      end;
    end;
end;

procedure TWP430FAnagraficoDettFM.EseguiRelazioni(sNomeCampo:String);
var
  idx: Integer;
  queryLookup: TOracleDataSet;
  SqlRelazione,SqlOriginale,CatenaRelazioni: String;
begin
  if not(TWP430FAnagraficoDM(WR302DM).selTabella.State in [dsEdit,dsInsert]) then exit;

  if sNomeCampo <> '' then
  begin
    with TWP430FAnagraficoDM(WR302DM).P430FAnagraficoMW.GetCatena do
    begin
      if VarToStr(GetVariable('sColonna')) <> sNomeCampo then
      begin
        SetVariable('sColonna',sNomeCampo);
        SetVariable('sChain','');
        Execute;
      end;
      CatenaRelazioni:=VarToStr(GetVariable('sChain'));
      CatenaRelazioni:=StringReplace(CatenaRelazioni,'''' + sNomeCampo + ''',','',[rfReplaceAll]);//tolgo sè stesso
      CatenaRelazioni:=StringReplace(Copy(CatenaRelazioni,1,Length(CatenaRelazioni) - 1),'''','',[rfReplaceAll]);//tolgo la virgola in fondo e gli apici
    end;
  end;

  with TWP430FAnagraficoDM(WR302DM).P430FAnagraficoMW do
  begin
    selI030.Filtered:=True;
    //Scorrimento su selI030 ordinato per ORDINE
    selI030.First;
    while not selI030.Eof do
    begin
      //eseguo le relazioni solo se la procedura è richiamata a causa della variazione della data fine decorrenza o di un dato pilota in una catena di relazioni o se è volutamente richiamata per tutti
      if (sNomeCampo = '') or (sNomeCampo = 'DECORRENZA_FINE') or R180InConcat(selI030.FieldByName('COLONNA').AsString,CatenaRelazioni) then
      begin
        if selI030.FieldByName('TIPO').AsString = 'F' then
        begin
          idx:=IndiceComponente(selI030.FieldByName('COLONNA').AsString);
          if (idx >= 0) and
             (SchedaAnagrafica[idx].Componente is TMedpIWMultiColumnComboBox) then
          begin
            queryLookup:=TWP430FAnagraficoDM(WR302DM).QueryLookupCampo(SchedaAnagrafica[idx].NomeCampo);
            if queryLookup <> nil then
            begin
              SqlRelazione:=CreaSQLRelazione(queryLookUp.VariableIndex('DATA') >= 0);
              if Trim(SqlRelazione) <> '' then
              begin
                with queryLookup do
                  if Trim(SqlRelazione) <> Trim(Sql.Text) then
                  begin
                    Close;
                    SqlOriginale:=Sql.Text;
                    Sql.Text:=SqlRelazione;
                    try
                      if VariableIndex('DATA') >= 0 then
                        SetVariable('DATA',WR302DM.selTabella.FieldByName('DATAFINE').AsDateTime);
                      Open;
                      CaricaCombo((SchedaAnagrafica[idx].Componente as TMedpIWMultiColumnComboBox),queryLookup);
                    except
                      Sql.Text:=SqlOriginale;
                      Open;
                    end;
                  end;
              end;
            end;
          end;
        end
        else if ((selI030.FieldByName('TIPO').AsString = 'S') or (selI030.FieldByName('TIPO').AsString = 'L')) and
                 (WR302DM.selTabella.State in [dsEdit,dsInsert]) and
                 (selI030.FieldByName('TABELLA').AsString = selI030.FieldByName('TAB_ORIGINE').AsString) then
        begin
          if ImpostaValoreRelazione then
          begin
            idx:=IndiceComponente(selI030.FieldByName('COLONNA').AsString);
            if (SchedaAnagrafica[idx].Componente is TMedpIWMultiColumnComboBox) then
            begin
              //impostare anche ItemIndex altrimenti non si aggiorna Combo
  //            TMedpIWMultiColumnComboBox(ComponentiLayout[idx].Componenti[0]).ItemIndex:=-1;
              (SchedaAnagrafica[idx].Componente as TMedpIWMultiColumnComboBox).Text:=WR302DM.selTabella.FieldByName(SchedaAnagrafica[idx].NomeCampo).AsString;

              queryLookup:=TWP430FAnagraficoDM(WR302DM).QueryLookupCampo(SchedaAnagrafica[idx].NomeCampo);
              //Le descrizioni delle multicolumn fatte con DBlabel; quindi si aggiornano in autoamtico al variare del campo del dataset
            end
            else if (SchedaAnagrafica[idx].Componente is TmeIWEdit) then
              TmeIWEdit(SchedaAnagrafica[idx].Componente).Text:=WR302DM.selTabella.FieldByName(SchedaAnagrafica[idx].NomeCampo).AsString;
          end;
        end;
      end;
      selI030.Next;
    end;
    selI030.Filtered:=False;
  end;
end;

procedure TWP430FAnagraficoDettFM.ImpostaEnabled(Componente: TControl; Val: Boolean);
begin
  if Componente is TmeIWLabel then
    TmeIWLabel(Componente).Enabled:=val
  else if Componente is TmeIWDBEdit then
    TmeIWDBEdit(Componente).Enabled:=val
  else if Componente is TmeIWEdit then
    TmeIWEdit(Componente).Enabled:=val
  else if Componente is TmeIWDBRadioGroup then
    TmeIWDBRadioGroup(Componente).Enabled:=val
  else if Componente is TMedpIWMultiColumnComboBox then
    (Componente as TMedpIWMultiColumnComboBox).Enabled:=val
  else if Componente is TmeIWDBCheckBox then
    TmeIWDBCheckBox(Componente).Enabled:=val
  else if Componente is TmeIWButton then
    TmeIWButton(Componente).Enabled:=val
  else if Componente is TmeIWLink then
    TmeIWLink(Componente).Enabled:=val
  else
   raise Exception.Create('Tipo componente non censito in ImpostaEnabled ' + Componente.Name);
end;

procedure TWP430FAnagraficoDettFM.AbilitaComponenti;
var
  bEdit: Boolean;
  bPercMaxCheched: Boolean;
  i: Integer;
begin
  inherited;
  lblCausaleLA.Enabled:=True; //pe riabilitare la label altrimenti rimane disabled
  bEdit:=WR302DM.selTabella.State in [dsEdit,dsInsert];
  with (WR302DM as TWP430FAnagraficoDM) do
  begin
    if bEdit then
    begin
      EseguiRelazioni(''); //POTREBBERO essere cambiate le relazioni mentre la pagina era in browse e quindi il metodo non sarebbe rieseguito
      if (selTabella.FieldByName('PERC_IRPEF_EXTRA27').AsString = '') and not (selTabella.FieldByName('PERC_IRPEF_MASSIMA_EXTRA27').AsString = 'S') then
      begin
        lblPercIrpefExtra27.Enabled:=True;
        dedtPercIrpefExtra27.Enabled:=True;
        dchkPercIRPEFmaxExtra27.Enabled:=True;
      end
      else
      begin
        bPercMaxCheched:=selTabella.FieldByName('PERC_IRPEF_MASSIMA_EXTRA27').AsString = 'S';
        dchkPercIRPEFmaxExtra27.Enabled:=bPercMaxCheched;
        lblPercIrpefExtra27.Enabled:=not bPercMaxCheched;
        dedtPercIrpefExtra27.Enabled:=not bPercMaxCheched;
      end;

      lblCausaleLA.Enabled:=P430FAnagraficoMW.IsDipendenteCOoLA;
      cmbCodCausaleLA.Enabled:=lblCausaleLA.Enabled;
      dlblDescCausaleLA.Enabled:=lblCausaleLA.Enabled;
      //Disabilita campi oggetto di relazioni
      P430FAnagraficoMW.selI030.Filtered:=True;
      for i:=0 to High(SchedaAnagrafica) do
      begin
        if CampoRelazione(i) then
        begin
          ImpostaEnabled(SchedaAnagrafica[i].Componente,False);
        end;
      end;
      P430FAnagraficoMW.selI030.Filtered:=False;
    end;

    //Abilitazioni campi IBAN
    lblIBAN.Enabled:=Trim(selTabella.FieldByName('IBAN_ESTERO').AsString) = '';
    edtIBAN.Enabled:=bEdit and (Trim(selTabella.FieldByName('IBAN_ESTERO').AsString) = '');
    btnImpostaIBAN.Enabled:=bEdit and (Trim(selTabella.FieldByName('IBAN_ESTERO').AsString) = '');
    if bEdit and (not edtIBAN.Enabled) then
      edtIBAN.Text:='';
    lblContoCorrente.Enabled:=Trim(selTabella.FieldByName('IBAN_ESTERO').AsString) = '';
    dedtContoCorrente.Enabled:=bEdit and (Trim(selTabella.FieldByName('IBAN_ESTERO').AsString) = '');
    if bEdit and (not dedtContoCorrente.Enabled) then
      selTabella.FieldByName('CONTO_CORRENTE').AsString:='';
    lblCinItalia.Enabled:=Trim(selTabella.FieldByName('IBAN_ESTERO').AsString) = '';
    dedtCinItalia.Enabled:=bEdit and (Trim(selTabella.FieldByName('IBAN_ESTERO').AsString) = '');
    if bEdit and (not dedtCinItalia.Enabled) then
      selTabella.FieldByName('CIN_ITALIA').AsString:='';
    lblCinEuropa.Enabled:=Trim(selTabella.FieldByName('IBAN_ESTERO').AsString) = '';
    dedtCinEuropa.Enabled:=bEdit and (Trim(selTabella.FieldByName('IBAN_ESTERO').AsString) = '');
    if bEdit and (not dedtCinEuropa.Enabled) then
      selTabella.FieldByName('CIN_EUROPA').AsString:='';
    lblCittaEstera.Enabled:=Trim(selTabella.FieldByName('IBAN_ESTERO').AsString) <> '';
    dedtCittaEstera.Enabled:=bEdit and (Trim(selTabella.FieldByName('IBAN_ESTERO').AsString) <> '');
    if bEdit and (not dedtCittaEstera.Enabled) then
      selTabella.FieldByName('IBAN_ESTERO_CITTA').AsString:='';
  end;
  edtTotaleANF.ReadOnly:=True;
  imgCalcolo.Enabled:=True;
  imgFamiliari.Enabled:=True;
  //ANF
  cmbCodTabellaANF.Enabled:=False;
  edtDataCalcoloAnf.ReadOnly:=True;
  edtNucleoCalcoloAnf.ReadOnly:=True;
  edtRedditoCalcoloAnf.ReadOnly:=True;
  edtAltriRedditiCalcoloAnf.ReadOnly:=True;
  edtTotaleCalcoloAnf.ReadOnly:=True;
  edtTabellaCalcoloAnf.ReadOnly:=True;
  edtImportoCalcoloAnf.ReadOnly:=True;
end;

procedure TWP430FAnagraficoDettFM.btnCodBancaClick(Sender: TObject);
var s:String;
  WC015: TWC015FSelEditGridFM;
begin
  inherited;
  //Rieseguo senza COD_BANCA
  with (WR302DM as TWP430FAnagraficoDM).P430FAnagraficoMW do
  begin
    Q010.Close;
    if Trim(dedtIbanEstero.Text) <> '' then
      s:='SELECT COD_BANCA,ABI,CAB,DESCRIZIONE || '' Ag: '' || AGENZIA DESCRIZIONE,COD_NAZIONE FROM P010_BANCHE ' +
         'WHERE (NVL(:COD_BANCA,''X'') = NVL(:COD_BANCA,''X'') OR NVL(:ABI,''X'') = NVL(:ABI,''X'') OR NVL(:CAB,''X'') = NVL(:CAB,''X'') OR NVL(:COD_NAZIONE,''X'') = NVL(:COD_NAZIONE,''X'')) AND COD_NAZIONE <> ''IT''' +
         ':ORDERBY'
    else
      s:='SELECT COD_BANCA,ABI,CAB,DESCRIZIONE || '' Ag: '' || AGENZIA DESCRIZIONE,COD_NAZIONE FROM P010_BANCHE ' +
         'WHERE (NVL(:COD_BANCA,''X'') = NVL(:COD_BANCA,''X'') OR NVL(:ABI,''X'') = NVL(:ABI,''X'') OR NVL(:CAB,''X'') = NVL(:CAB,''X'') OR NVL(:COD_NAZIONE,''X'') = NVL(:COD_NAZIONE,''X'')) AND COD_NAZIONE = ''IT''' +
         ':ORDERBY';
    Q010.SQL.Text:=s;
    Q010.Open;
  end;
  WC015:=TWC015FSelEditGridFM.Create(Self.Parent);
  with (WR302DM AS TWP430FAnagraficoDM) do
  begin
    WC015.medpCurrRecord:=P430FAnagraficoMW.Q010.SearchRecord('COD_BANCA',VarArrayOf([selTabella.FieldByName('COD_BANCA').AsString]),[srFromBeginning]);
    WC015.medpSearchKind:=skContent;
    WC015.medpSearchField:='DESCRIZIONE';
    WC015.medpSearchFilter:=Format('%s=''%s*''',['COD_BANCA',dedtCodBanca.Text]);
    WC015.ResultEvent:=ResultElencoBanche;
    WC015.Visualizza('Elenco banche',P430FAnagraficoMW.Q010,False,False,True);
  end;
end;

procedure TWP430FAnagraficoDettFM.btnEredeClick(Sender: TObject);
var
  WC015: TWC015FSelEditGridFM;
  strSQL:String;
begin
  inherited;
  WC015:=TWC015FSelEditGridFM.Create(Self.Parent);
  with (WR302DM AS TWP430FAnagraficoDM) do
  begin
    strSQL:='SELECT T030.COGNOME, T030.NOME, TRIM(T030.COGNOME)||'' ''|| TRIM(T030.NOME) AS NOMINATIVO, T030.MATRICOLA, T030.PROGRESSIVO ' +
            'FROM T030_ANAGRAFICO T030 /*I072*/ ' +
            ':ORDERBY';
    if Trim(Parametri.Inibizioni.Text) <> '' then
      strSQL:=strSQL.Replace('/*I072*/',', V430_STORICO V430 where T030.PROGRESSIVO = V430.T430PROGRESSIVO and trunc(sysdate) between V430.T430DATADECORRENZA and V430.T430DATAFINE and ' + Parametri.Inibizioni.Text);
    selT030Elenco.SQL.Text:=strSQL;
    selT030Elenco.Open;
    WC015.medpCurrRecord:=selT030Elenco.SearchRecord('PROGRESSIVO',VarArrayOf([selTabella.FieldByName('PROGRESSIVO_EREDE_DI').AsInteger]),[srFromBeginning]);
    WC015.medpSearchKind:=skInitial;
    WC015.medpSearchField:='COGNOME';
    WC015.ResultEvent:=ResultElencoEredi;
    WC015.Visualizza('Elenco dati',selT030Elenco,False,False,True);
  end;
end;

procedure TWP430FAnagraficoDettFM.ResultElencoEredi(Sender: TObject; Result: Boolean);
begin
  if Result then
  begin
    with (WR302DM AS TWP430FAnagraficoDM) do
    begin
      //imposto anche il dataset in modo che venga aggiornato il campo d_descrizione (calcolato)
      selTabella.FieldByName('PROGRESSIVO_EREDE_DI').AsInteger:=selT030Elenco.FieldByName('PROGRESSIVO').AsInteger;
      //scatena datachange che esegue relazioni....
    end;
  end;
  (WR302DM AS TWP430FAnagraficoDM).selT030Elenco.Close;
  EseguiRelazioni('PROGRESSIVO_EREDE_DI');
end;

procedure TWP430FAnagraficoDettFM.drgpTipoDetrazioniClick(Sender: TObject);
begin
  inherited;
  with WR302DM do
  begin
    if selTabella.FieldByName('DETRAZ_LAVDIP').AsString <> 'S' then
    begin
      selTabella.FieldByName('DETRAZ_REDDITI_MIN_INDET').AsString:='N';
      selTabella.FieldByName('DETRAZ_REDDITI_MIN_DET').AsString:='N';
    end;
  end;
  ImpostaComponentiVisible;
  EseguiRelazioni((Sender as TmeIWDBRadioGroup).DataField);
end;

procedure TWP430FAnagraficoDettFM.ResultElencoBanche(Sender: TObject; Result: Boolean);
var CodBanca:String;
begin
  CodBanca:=(WR302DM as TWP430FAnagraficoDM).selTabella.FieldByName('COD_BANCA').AsString;
  if Result then
    CodBanca:=(WR302DM as TWP430FAnagraficoDM).P430FAnagraficoMW.Q010.FieldByName('COD_BANCA').AsString;
  //Rieseguo con COD_BANCA
  with (WR302DM as TWP430FAnagraficoDM).P430FAnagraficoMW do
  begin
    Q010.Close;
    Q010.SQL.Text:=sQ010SQLTextOrig;
    Q010.SetVariable('COD_BANCA',CodBanca);
    Q010.Open;
  end;
  if Result then
  begin
    with (WR302DM AS TWP430FAnagraficoDM) do
    begin
      //imposto anche il dataset in modo che venga aggiornato il campo d_descrizione (calcolato)
      selTabella.FieldByName('COD_BANCA').AsString:=P430FAnagraficoMW.Q010.FieldByName('COD_BANCA').AsString;
      P430FAnagraficoMW.ImpostaCinItalia;
      P430FAnagraficoMW.ImpostaCinEuropa;
      //scatena datachange
      EseguiRelazioni('COD_BANCA');
    end;
  end;
end;

procedure TWP430FAnagraficoDettFM.btnImpostaIBANClick(Sender: TObject);
var MsgErr:String;
begin
  inherited;
  if not R180ControllaIBAN(edtIban.Text,MsgErr) then
  begin
    if MsgErr <> '' then
      raise exception.Create(Format(A000MSG_P430_ERR_FMT_CONTROLLO_IBAN,[MsgErr]))
    else
      MsgBox.WebMessageDlg(Format(A000MSG_P430_ERR_FMT_CONTROLLO_IBAN,[A000MSG_P000_MSG_DATO_UTILIZZATO]),mtInformation,[mbOk],nil,'');
  end;
  (WR302DM as TWP430FAnagraficoDM).P430FAnagraficoMW.ScomponiIban(edtIban.Text);
  edtIBAN.Text:=(WR302DM as TWP430FAnagraficoDM).P430FAnagraficoMW.CaricaMascheraIBAN;
  EseguiRelazioni('COD_BANCA');
  EseguiRelazioni('COD_PAGAMENTO');
  EseguiRelazioni('CIN_EUROPA');
  EseguiRelazioni('CIN_ITALIA');
  EseguiRelazioni('CONTO_CORRENTE');
end;

procedure TWP430FAnagraficoDettFM.btnRedditiAnnualiClick(Sender: TObject);
var
  Progressivo: String;
begin
  Progressivo:=(Self.Parent as TWR100FBase).grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsString;
  (Self.Parent as TWR100FBase).AccediForm(554,'PROGRESSIVO='+Progressivo,True);
end;

procedure TWP430FAnagraficoDettFM.CaricaCombo(cmb: TmedpIWMulticolumnCombobox;ods: TOracleDataset);
var
  Codice,Descrizione: String;
  procAC: procedure(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string) of object;
begin
  procAC:=cmb.OnAsyncChange;
  cmb.OnAsyncChange:=nil;
  Codice:=(WR302DM as TWP430FAnagraficoDM).getNomeCampoCodice(ods);
  Descrizione:='DESCRIZIONE';
  ods.Refresh;
  ods.First;
  cmb.Items.Clear;
  while not ods.Eof do
  begin
    cmb.AddRow(Format('%s;%s',[ods.FieldByName(Codice).AsString,ods.FieldByName(Descrizione).AsString]));
    ods.Next;
  end;
  //RefreshData di multicolumn per quando la lista elementi è aggiornata
  cmb.RefreshData;
  cmb.OnAsyncChange:=procAC;
end;

procedure TWP430FAnagraficoDettFM.cmbAltreAssCoCoCoAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  with WR302DM.selTabella do
  begin
    FieldByName('COD_ALTRAASS_COCOCO').AsString:=cmbAltreAssCoCoCo.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_ALTRAASS_COCOCO');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbCategEnpamAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  with WR302DM.selTabella do
  begin
    FieldByName('COD_CATEG_CONVENZ').AsString:=cmbCategEnpam.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_CATEG_CONVENZ');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbCodCategParticolareAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  with WR302DM.selTabella do
  begin
    FieldByName('COD_CATEGPARTICOLARE').AsString:=cmbCodCategParticolare.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_CATEGPARTICOLARE');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbCodCausaleIrpefAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  with WR302DM.selTabella do
  begin
    FieldByName('COD_CAUSALEIRPEF').AsString:=cmbCodCausaleIrpef.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_CAUSALEIRPEF');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbCodCausaleLAAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  with WR302DM.selTabella do
  begin
    FieldByName('COD_CAUSALELA').AsString:=cmbCodCausaleLA.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_CAUSALELA');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbCodContrattoAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  with (WR302DM as TWP430FAnagraficoDM) do
  begin
    selTabella.FieldByName('COD_CONTRATTO').AsString:=cmbCodContratto.Text;
    //Il cambio di codContratto fa variare Q240; viene fatto nel calcFields che si scatena settando il campo
    //Ricarico le multicolumnCombobox perchè la lista Q220 e Q240 cambiano
    CaricaCombo(cmbCodTipoAssog,P430FAnagraficoMW.Q240);
    CaricaCombo(cmbPosEconomica,P430FAnagraficoMW.Q220);
    EseguiRelazioni('COD_CONTRATTO');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbCodCudINPDAPCausaCessAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  with WR302DM.selTabella do
  begin
    FieldByName('COD_CUDINPDAPCAUSACESS').AsString:=cmbCodCudINPDAPCausaCess.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_CUDINPDAPCAUSACESS');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbCodEnteAppartenenzaAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with WR302DM.selTabella do
  begin
    FieldByName('COD_ENTE_APPARTENENZA').AsString:=cmbCodEnteAppartenenza.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_ENTE_APPARTENENZA');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbCodiceInailAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  with WR302DM.selTabella do
  begin
    FieldByName('COD_CODICEINAIL').AsString:=cmbCodiceInail.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_CODICEINAIL');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbCodiceInpsAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  with WR302DM.selTabella do
  begin
    FieldByName('COD_CODICEINPS').AsString:=cmbCodiceInps.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_CODICEINPS');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbCodInquadrINPDAPAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  with WR302DM.selTabella do
  begin
    FieldByName('COD_INQUADRINPDAP').AsString:=cmbCodInquadrINPDAP.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_INQUADRINPDAP');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbCodInquadrINPSAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  with WR302DM.selTabella do
  begin
    FieldByName('COD_INQUADRINPS').AsString:=cmbCodInquadrINPS.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_INQUADRINPS');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbCodParametriStipendiAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with WR302DM.selTabella do
  begin
    FieldByName('COD_PARAMETRISTIPENDI').AsString:=cmbCodParametriStipendi.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_PARAMETRISTIPENDI');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbCodPartTimeAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  with WR302DM.selTabella do
  begin
    FieldByName('COD_PARTTIME').AsString:=cmbCodPartTime.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_PARTTIME');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbCodQualificaInailAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  with WR302DM.selTabella do
  begin
    FieldByName('COD_QUALIFICA_INAIL').AsString:=cmbCodQualificaInail.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_QUALIFICA_INAIL');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbCodRegioneIRPEFAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  with WR302DM.selTabella do
  begin
    FieldByName('COD_REGIONE_IRPEF').AsString:=cmbCodRegioneIRPEF.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_REGIONE_IRPEF');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbCodTabellaANFAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  with WR302DM.selTabella do
  begin
    FieldByName('COD_TABELLAANF').AsString:=cmbCodTabellaANF.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_TABELLAANF');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbCodTipoAssogAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with WR302DM.selTabella do
  begin
    FieldByName('COD_TIPOASSOGGETTAMENTO').AsString:=cmbCodTipoAssog.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_TIPOASSOGGETTAMENTO');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbFpcAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  with WR302DM.selTabella do
  begin
    FieldByName('COD_FPC').AsString:=cmbFpc.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_FPC');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbMotivoSospFpcAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  with WR302DM.selTabella do
  begin
    FieldByName('COD_INPDAPMOTIVOSOSP_FPC').AsString:=cmbMotivoSospFpc.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_INPDAPMOTIVOSOSP_FPC');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbNazionalitaAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  with WR302DM.selTabella do
  begin
    FieldByName('COD_NAZIONALITA').AsString:=cmbNazionalita.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_NAZIONALITA');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbPagamentoAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with WR302DM.selTabella do
  begin
    FieldByName('COD_PAGAMENTO').AsString:=cmbPagamento.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_PAGAMENTO');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbPosEconomicaAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with WR302DM.selTabella do
  begin
    FieldByName('COD_POSIZIONE_ECONOMICA').AsString:=cmbPosEconomica.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_POSIZIONE_ECONOMICA');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbStatoCivileAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with WR302DM.selTabella do
  begin
    FieldByName('COD_STATOCIVILE').AsString:=cmbStatoCivile.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_STATOCIVILE');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbTipoAssAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with WR302DM.selTabella do
  begin
    FieldByName('COD_EMENSTIPOASS').AsString:=cmbTipoAss.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_EMENSTIPOASS');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbTipoAssOnaosiAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  with WR302DM.selTabella do
  begin
    FieldByName('COD_ONAOSITIPOASS').AsString:=cmbTipoAssOnaosi.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_ONAOSITIPOASS');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbTipoAttCoCoCoAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  with WR302DM.selTabella do
  begin
    FieldByName('COD_TIPOATT_COCOCO').AsString:=cmbTipoAttCoCoCo.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_TIPOATT_COCOCO');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbTipoCessAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with WR302DM.selTabella do
  begin
    FieldByName('COD_EMENSTIPOCESS').AsString:=cmbTipoCess.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_EMENSTIPOCESS');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbTipoCessFpcAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  with WR302DM.selTabella do
  begin
    FieldByName('COD_INPDAPTIPOCESS_FPC').AsString:=cmbTipoCessFpc.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_INPDAPTIPOCESS_FPC');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbTipoCessOnaosiAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  with WR302DM.selTabella do
  begin
    FieldByName('COD_ONAOSITIPOCESS').AsString:=cmbTipoCessOnaosi.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_ONAOSITIPOCESS');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbTipoPagOnaosiAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  with WR302DM.selTabella do
  begin
    FieldByName('COD_ONAOSITIPOPAG').AsString:=cmbTipoPagOnaosi.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_ONAOSITIPOPAG');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbTipoRappCoCoCoAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  with WR302DM.selTabella do
  begin
    FieldByName('COD_TIPORAPP_COCOCO').AsString:=cmbTipoRappCoCoCo.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_TIPORAPP_COCOCO');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbTipoServAltraAmmAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  with WR302DM.selTabella do
  begin
    FieldByName('COD_INPDAPTIPOLS_ALTRA_AMM').AsString:=cmbTipoServAltraAmm.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_INPDAPTIPOLS_ALTRA_AMM');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbValutaAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  with WR302DM.selTabella do
  begin
    FieldByName('COD_VALUTA_STAMPA').AsString:=cmbValuta.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_VALUTA_STAMPA');
  end;
end;

procedure TWP430FAnagraficoDettFM.cmbValutaCalcoloAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with WR302DM.selTabella do
  begin
    FieldByName('COD_VALUTA_BASE').AsString:=cmbValutaCalcolo.Text;
    //Il cambio scatena calcField e aggiorna la dblabel
    EseguiRelazioni('COD_VALUTA_BASE');
  end;
end;

procedure TWP430FAnagraficoDettFM.Componenti2DataSet;
begin
  inherited;
  with WR302DM.selTabella do
  begin
    FieldByName('COD_CONTRATTO').AsString:=cmbCodContratto.Text;
    FieldByName('COD_PARAMETRISTIPENDI').AsString:=cmbCodParametriStipendi.Text;
    FieldByName('COD_TIPOASSOGGETTAMENTO').AsString:=cmbCodTipoAssog.Text;
    FieldByName('COD_POSIZIONE_ECONOMICA').AsString:=cmbPosEconomica.Text;
    FieldByName('COD_PARTTIME').AsString:=cmbCodPartTime.Text;
    FieldByName('COD_PAGAMENTO').AsString:=cmbPagamento.Text;
    FieldByName('COD_VALUTA_BASE').AsString:=cmbValutaCalcolo.Text;
    FieldByName('COD_VALUTA_STAMPA').AsString:=cmbValuta.Text;
    FieldByName('COD_STATOCIVILE').AsString:=cmbStatoCivile.Text;
    FieldByName('COD_NAZIONALITA').AsString:=cmbNazionalita.Text;
    FieldByName('COD_CAUSALEIRPEF').AsString:=cmbCodCausaleIrpef.Text;
    FieldByName('COD_REGIONE_IRPEF').AsString:=cmbCodRegioneIRPEF.Text;
    FieldByName('COD_TABELLAANF').AsString:=cmbCodTabellaANF.Text;
    FieldByName('COD_CODICEINPS').AsString:=cmbCodiceInps.Text;
    FieldByName('COD_INQUADRINPS').AsString:=cmbCodInquadrINPS.Text;
    FieldByName('COD_EMENSTIPOASS').AsString:=cmbTipoAss.Text;
    FieldByName('COD_EMENSTIPOCESS').AsString:=cmbTipoCess.Text;
    FieldByName('COD_TIPORAPP_COCOCO').AsString:=cmbTipoRappCoCoCo.Text;
    FieldByName('COD_TIPOATT_COCOCO').AsString:=cmbTipoAttCoCoCo.Text;
    FieldByName('COD_ALTRAASS_COCOCO').AsString:=cmbAltreAssCoCoCo.Text;
    FieldByName('COD_INQUADRINPDAP').AsString:=cmbCodInquadrINPDAP.Text;
    FieldByName('COD_CUDINPDAPCAUSACESS').AsString:=cmbCodCudINPDAPCausaCess.Text;
    FieldByName('COD_CATEG_CONVENZ').AsString:=cmbCategEnpam.Text;
    FieldByName('COD_INPDAPTIPOLS_ALTRA_AMM').AsString:=cmbTipoServAltraAmm.Text;
    FieldByName('COD_CODICEINAIL').AsString:=cmbCodiceInail.Text;
    FieldByName('COD_QUALIFICA_INAIL').AsString:=cmbCodQualificaInail.Text;
    FieldByName('COD_CATEGPARTICOLARE').AsString:=cmbCodCategParticolare.Text;
    FieldByName('COD_CAUSALELA').AsString:=cmbCodCausaleLA.Text;
    FieldByName('COD_ONAOSITIPOPAG').AsString:=cmbTipoPagOnaosi.Text;
    FieldByName('COD_ONAOSITIPOASS').AsString:=cmbTipoAssOnaosi.Text;
    FieldByName('COD_ONAOSITIPOCESS').AsString:=cmbTipoCessOnaosi.Text;
    FieldByName('COD_FPC').AsString:=cmbFpc.Text;
    FieldByName('COD_INPDAPMOTIVOSOSP_FPC').AsString:=cmbMotivoSospFpc.Text;
    FieldByName('COD_INPDAPTIPOCESS_FPC').AsString:=cmbTipoCessFpc.Text;
    FieldByName('COD_ENTE_APPARTENENZA').AsString:=cmbCodEnteAppartenenza.Text;
  end;
end;

procedure TWP430FAnagraficoDettFM.DataSet2Componenti;
begin
  inherited;
  with (WR302DM as TWP430FAnagraficoDM) do
  begin
    cmbCodContratto.Text:=selTabella.FieldByName('COD_CONTRATTO').AsString;
    cmbCodParametriStipendi.Text:=selTabella.FieldByName('COD_PARAMETRISTIPENDI').AsString;
    cmbCodTipoAssog.Text:=selTabella.FieldByName('COD_TIPOASSOGGETTAMENTO').AsString;
    cmbPosEconomica.Text:=selTabella.FieldByName('COD_POSIZIONE_ECONOMICA').AsString;
    cmbCodPartTime.Text:=selTabella.FieldByName('COD_PARTTIME').AsString;
    edtIban.Text:='';
    if Trim(selTabella.FieldByName('IBAN_ESTERO').AsString) = '' then
      edtIban.Text:=P430FAnagraficoMW.CaricaMascheraIBAN;
    cmbPagamento.Text:=selTabella.FieldByName('COD_PAGAMENTO').AsString;
    cmbValutaCalcolo.Text:=selTabella.FieldByName('COD_VALUTA_BASE').AsString;
    cmbValuta.Text:=selTabella.FieldByName('COD_VALUTA_STAMPA').AsString;
    cmbStatoCivile.Text:=selTabella.FieldByName('COD_STATOCIVILE').AsString;
    cmbNazionalita.Text:=selTabella.FieldByName('COD_NAZIONALITA').AsString;
    cmbCodCausaleIrpef.Text:=selTabella.FieldByName('COD_CAUSALEIRPEF').AsString;
    cmbCodRegioneIRPEF.Text:=selTabella.FieldByName('COD_REGIONE_IRPEF').AsString;
    edtDescComuneIRPEF.Text:=selTabella.FieldByName('D_COMUNE_IRPEF').AsString;
    cmbCodTabellaANF.Text:=selTabella.FieldByName('COD_TABELLAANF').AsString;
    cmbCodiceInps.Text:=selTabella.FieldByName('COD_CODICEINPS').AsString;
    cmbCodInquadrINPS.Text:=selTabella.FieldByName('COD_INQUADRINPS').AsString;
    cmbTipoAss.Text:=selTabella.FieldByName('COD_EMENSTIPOASS').AsString;
    cmbTipoCess.Text:=selTabella.FieldByName('COD_EMENSTIPOCESS').AsString;
    cmbTipoRappCoCoCo.Text:=selTabella.FieldByName('COD_TIPORAPP_COCOCO').AsString;
    cmbTipoAttCoCoCo.Text:=selTabella.FieldByName('COD_TIPOATT_COCOCO').AsString;
    cmbAltreAssCoCoCo.Text:=selTabella.FieldByName('COD_ALTRAASS_COCOCO').AsString;
    cmbCodInquadrINPDAP.Text:=selTabella.FieldByName('COD_INQUADRINPDAP').AsString;
    cmbCodCudINPDAPCausaCess.Text:=selTabella.FieldByName('COD_CUDINPDAPCAUSACESS').AsString;
    cmbCategEnpam.Text:=selTabella.FieldByName('COD_CATEG_CONVENZ').AsString;
    cmbTipoServAltraAmm.Text:=selTabella.FieldByName('COD_INPDAPTIPOLS_ALTRA_AMM').AsString;
    cmbCodiceInail.Text:=selTabella.FieldByName('COD_CODICEINAIL').AsString;
    cmbCodQualificaInail.Text:=selTabella.FieldByName('COD_QUALIFICA_INAIL').AsString;
    cmbCodCategParticolare.Text:=selTabella.FieldByName('COD_CATEGPARTICOLARE').AsString;
    cmbCodCausaleLA.Text:=selTabella.FieldByName('COD_CAUSALELA').AsString;
    cmbTipoPagOnaosi.Text:=selTabella.FieldByName('COD_ONAOSITIPOPAG').AsString;
    cmbTipoAssOnaosi.Text:=selTabella.FieldByName('COD_ONAOSITIPOASS').AsString;
    cmbTipoCessOnaosi.Text:=selTabella.FieldByName('COD_ONAOSITIPOCESS').AsString;
    cmbMotivoSospFpc.Text:=selTabella.FieldByName('COD_INPDAPMOTIVOSOSP_FPC').AsString;
    cmbTipoCessFpc.Text:=selTabella.FieldByName('COD_INPDAPTIPOCESS_FPC').AsString;
    cmbFpc.Text:=selTabella.FieldByName('COD_FPC').AsString;
    edtTotaleANF.Text:=P430FAnagraficoMW.TotaleANF;
    edtDescComuneInail.Text:=selTabella.FieldByName('D_COMUNE_INAIL').AsString;
    cmbCodEnteAppartenenza.Text:=selTabella.FieldByName('COD_ENTE_APPARTENENZA').AsString;
  end;
  VisualizzaDatiCalcoloAnf;
  ImpostaComponentiVisible;
end;

procedure TWP430FAnagraficoDettFM.ImpostaComponentiVisible;
begin
  with (WR302DM as TWP430FAnagraficoDM) do
  begin
    lblProgressivoEredeDi.Caption:=IfThen(P430FAnagraficoMW.IsDipendenteCP,'Creditore di','Erede di');
    lblProgressivoEredeDi.Visible:=P430FAnagraficoMW.IsDipendenteERoLA or P430FAnagraficoMW.IsDipendenteCP;
    dedtDNominativoErede.Visible:=lblProgressivoEredeDi.Visible;
    btnErede.Visible:=lblProgressivoEredeDi.Visible;
    lblPercEredita.Visible:=P430FAnagraficoMW.IsDipendenteERoLA;
    dedtPercEredita.Visible:=lblPercEredita.Visible;

    dchkDetrazRedditiMinIndet.Visible:=selTabella.FieldByName('DETRAZ_LAVDIP').AsString = 'S';
    dchkDetrazRedditiMinDet.Visible:=dchkDetrazRedditiMinIndet.Visible;

    lnkCodiceINPS.Visible:=(not P430FAnagraficoMW.IsDipendenteCO);
    cmbCodiceINPS.Visible:=lnkCodiceINPS.Visible;
    dlblDescCodiceInps.Visible:=lnkCodiceINPS.Visible;
    lnkCodInquadrINPS.Visible:=lnkCodiceINPS.Visible;
    cmbCodInquadrINPS.Visible:=lnkCodiceINPS.Visible;
    dlblDescInquadrINPS.Visible:=lnkCodiceINPS.Visible;
    lblQualProfINPS.Visible:=lnkCodiceINPS.Visible;
    dedtQualProfINPS.Visible:=lnkCodiceINPS.Visible;
    lblTipoAss.Visible:=lnkCodiceINPS.Visible;
    cmbTipoAss.Visible:=lnkCodiceINPS.Visible;
    dlblDescTipoAss.Visible:=lnkCodiceINPS.Visible;
    lblTipoCess.Visible:=lnkCodiceINPS.Visible;
    cmbTipoCess.Visible:=lnkCodiceINPS.Visible;
    dlblDescTipoCess.Visible:=lnkCodiceINPS.Visible;
    lblTipoRappCoCoCo.Visible:=P430FAnagraficoMW.IsDipendenteCO;
    cmbTipoRappCoCoCo.Visible:=lblTipoRappCoCoCo.Visible;
    dlblDescTipoRappCoCoCo.Visible:=lblTipoRappCoCoCo.Visible;
    lblTipoAttCoCoCo.Visible:=lblTipoRappCoCoCo.Visible;
    cmbTipoAttCoCoCo.Visible:=lblTipoRappCoCoCo.Visible;
    dlblDescTipoAttCoCoCo.Visible:=lblTipoRappCoCoCo.Visible;
    lblAltreAssCoCoCo.Visible:=lblTipoRappCoCoCo.Visible;
    cmbAltreAssCoCoCo.Visible:=lblTipoRappCoCoCo.Visible;
    dlblDescAltreAssCoCoCo.Visible:=lblTipoRappCoCoCo.Visible;

    //altra amm
    lblTipoServAltraAmm.Visible:=P430FAnagraficoMW.IsAltraAmmO_I;
    cmbTipoServAltraAmm.Visible:=lblTipoServAltraAmm.Visible;
    dlblDescTipoServAltraAmm.Visible:=lblTipoServAltraAmm.Visible;
    lblCodFiscaleAltraAmm.Visible:=not P430FAnagraficoMW.IsAltraAmmNessuna;
    dedtCodFiscaleAltraAmm.Visible:=lblCodFiscaleAltraAmm.Visible;
    lblProgAziendaAltraAmm.Visible:=lblCodFiscaleAltraAmm.Visible;
    dedtProgAziendaAltraAmm.Visible:=lblCodFiscaleAltraAmm.Visible;
  end;
end;

procedure TWP430FAnagraficoDettFM.dchkPercIRPEFmaxExtra27AsyncChange(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  if dchkPercIRPEFmaxExtra27.Checked then
  begin
    WR302DM.selTabella.FieldByName('PERC_IRPEF_EXTRA27').Clear;
  end;
  AbilitaComponenti;
  EseguiRelazioni((Sender as TmeIWDBCheckBox).DataField);
end;

procedure TWP430FAnagraficoDettFM.dcmbProfessioneONAOSIAsyncChange(
  Sender: TObject; EventParams: TStringList);
begin
  EseguiRelazioni((Sender as TmeIWDBComboBox).DataField);
end;

procedure TWP430FAnagraficoDettFM.dcmbTipoDipendenteChange(Sender: TObject);
begin
  inherited;
  with (WR302DM as TWP430FAnagraficoDM).P430FAnagraficoMW do
  begin
    SvuotaCampiErede;
    SvuotaCampiInps;
    SvuotaCampiLavAut;
  end;
  ImpostaComponentiVisible;
  //alcuni componenti vengono resi invisibili in base al tipo dipendente, altri invece
  //disabiliti..giusto per non farci mancare niente...
  AbilitaComponenti;
  EseguiRelazioni((Sender as TmeIWDBComboBox).DataField);
end;

procedure TWP430FAnagraficoDettFM.dedtCinEuropaAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  (WR302DM as TWP430FAnagraficoDM).P430FAnagraficoMW.NormalizzaCinEuropa;
  EseguiRelazioni((Sender as TmeIWDBEdit).DataField);
end;

procedure TWP430FAnagraficoDettFM.dedtCinItaliaAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  (WR302DM as TWP430FAnagraficoDM).P430FAnagraficoMW.ImpostaCinEuropa;
  EseguiRelazioni((Sender as TmeIWDBEdit).DataField);
end;

procedure TWP430FAnagraficoDettFM.dedtCodBancaAsyncExit(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  if WR302DM.selTabella.State in [dsEdit,dsInsert] then
    WR302DM.selTabella.FieldByName('COD_BANCA').AsString:=dedtCodBanca.Text;
  EseguiRelazioni((Sender as TmeIWDBEdit).DataField);
end;

procedure TWP430FAnagraficoDettFM.dedtCodComuneInailAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  //impostando COD_COMUNE_INAIL si reimposta il campo di lookup
  edtDescComuneInail.Text:=WR302DM.selTabella.FieldByName('D_COMUNE_INAIL').AsString;
  EseguiRelazioni((Sender as TmeIWDBEdit).DataField);
end;

procedure TWP430FAnagraficoDettFM.dedtCodComuneIRPEFAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  //impostando COD_COMUNE_IRPEF si reimposta il campo di lookup
  edtDescComuneIRPEF.Text:=WR302DM.selTabella.FieldByName('D_COMUNE_IRPEF').AsString;
  EseguiRelazioni((Sender as TmeIWDBEdit).DataField);
end;

procedure TWP430FAnagraficoDettFM.dedtContoCorrenteAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  with (WR302DM as TWP430FAnagraficoDM).P430FAnagraficoMW do
  begin
    ImpostaCinItalia;
    ImpostaCinEuropa;
    EseguiRelazioni((Sender as TmeIWDBEdit).DataField);
  end;
end;

procedure TWP430FAnagraficoDettFM.dedtIbanEsteroAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TWP430FAnagraficoDettFM.edtAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  if Sender is TmeIWDBEdit then
    EseguiRelazioni((Sender as TmeIWDBEdit).DataField)
  else if Sender is TmeIWDBCheckBox then
    EseguiRelazioni((Sender as TmeIWDBCheckBox).DataField);
end;

procedure TWP430FAnagraficoDettFM.dedtPercIrpefExtra27AsyncChange(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  AbilitaComponenti;
  EseguiRelazioni((Sender as TmeIWDBEdit).DataField);
end;

procedure TWP430FAnagraficoDettFM.drgpAltraAmmClick(Sender: TObject);
begin
  inherited;
  (WR302DM as TWP430FAnagraficoDM).P430FAnagraficoMW.SvuotaCampiAltraAmm;
  cmbTipoServAltraAmm.Text:=WR302DM.selTabella.FieldByName('COD_INPDAPTIPOLS_ALTRA_AMM').AsString;
  ImpostaComponentiVisible;
  EseguiRelazioni((Sender as TmeIWDBRadioGroup).DataField);
end;

procedure TWP430FAnagraficoDettFM.rgpClick(Sender: TObject);
begin
  EseguiRelazioni((Sender as TmeIWDBRadioGroup).DataField);
end;

procedure TWP430FAnagraficoDettFM.grdDettaglioCalcoloAnfRenderCell(
  ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  inherited;
  C190RenderCell(ACell,aRow,AColumn,True,False,False);
  if AColumn = 0  then
  begin
    ACell.Header:=True;
    ACell.Css:=StringReplace(ACell.Css,'riga_intestazione','',[rfReplaceAll]);
    ACell.Css:=ACell.Css + ' riga_intestazione'
  end;
end;

procedure TWP430FAnagraficoDettFM.imgCalcoloClick(Sender: TObject);
begin
  inherited;
  actCalcolo.Checked:=not actCalcolo.Checked;
  if actCalcolo.Checked then
  begin
    imgCalcolo.ImageFile.Filename:='img/btnCalcolatrice_Checked.png';
  end
  else
    imgCalcolo.ImageFile.Filename:='img/btnCalcolatrice.png';
  C190VisualizzaElemento(JQuery,'divCalcoloAnf',actCalcolo.Checked);
  VisualizzaDatiCalcoloAnf;
end;

procedure TWP430FAnagraficoDettFM.imgFamiliariClick(Sender: TObject);
var
  Progressivo: String;
begin
  inherited;
  Progressivo:=(Self.Parent as TWR100FBase).grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsString;
  (Self.Parent as TWR100FBase).AccediForm(303,'PROGRESSIVO='+Progressivo,True);
end;

procedure TWP430FAnagraficoDettFM.VisualizzaDatiCalcoloAnf;
var
  DatiOutP239: TDatiOutP239;
  row,col: Integer;
begin
  if actCalcolo.Checked then
  begin
    DatiOutP239:=(WR302DM as TWP430FAnagraficoDM).P430FAnagraficoMW.CalcoloANF;
    edtDataCalcoloAnf.Text:=Copy(DateToStr(DatiOutP239.DataCalc),4,7);
    lblBloccaAnf.Caption:=DatiOutP239.Messaggio;
    if (DatiOutP239.Messaggio = '') and (not DatiOutP239.DipInServizio) then
      lblBloccaAnf.Caption:='Dipendente non in servizio nel mese';
    lblNucleoCalcoloAnf.Visible:=DatiOutP239.DipInServizio;
    edtNucleoCalcoloAnf.Visible:=DatiOutP239.DipInServizio;
    lblCodTabellaCalcoloAnf.Visible:=DatiOutP239.DipInServizio;
    lblTabellaCalcoloAnf.Visible:=DatiOutP239.DipInServizio;
    edtTabellaCalcoloAnf.Visible:=DatiOutP239.DipInServizio;
    lblImportoCalcoloAnf.Visible:=DatiOutP239.DipInServizio;
    edtImportoCalcoloAnf.Visible:=DatiOutP239.DipInServizio;
    lblRedditoCalcoloAnf.Visible:=DatiOutP239.DipInServizio;
    edtRedditoCalcoloAnf.Visible:=DatiOutP239.DipInServizio;
    lblAltriRedditiCalcoloAnf.Visible:=DatiOutP239.DipInServizio;
    edtAltriRedditiCalcoloAnf.Visible:=DatiOutP239.DipInServizio;
    lblTotaleCalcoloAnf.Visible:=DatiOutP239.DipInServizio;
    edtTotaleCalcoloAnf.Visible:=DatiOutP239.DipInServizio;
    grdDettaglioCalcoloAnf.Visible:=DatiOutP239.DipInServizio;

    if DatiOutP239.DipInServizio then
    begin
      if DatiOutP239.NucleoPiuTreFigli then
        edtNucleoCalcoloAnf.Text:=A000MSG_MSG_SI
      else
        edtNucleoCalcoloAnf.Text:=A000MSG_MSG_NO;
      edtTabellaCalcoloAnf.Text:=DatiOutP239.CodTabella;
      lblTabellaCalcoloAnf.Caption:=DatiOutP239.DescTabella;
      edtImportoCalcoloAnf.Text:=FloatToStr(DatiOutP239.Importo);
      edtRedditoCalcoloAnf.Text:=FloatToStr(DatiOutP239.RedditoLavDip);
      edtAltriRedditiCalcoloAnf.Text:=FloatToStr(DatiOutP239.RedditoAltro);
      edtTotaleCalcoloAnf.Text:=FloatToStr(DatiOutP239.RedditoLavDip + DatiOutP239.RedditoAltro);
    end;
    if grdDettaglioCalcoloAnf.Visible then
    begin
      grdDettaglioCalcoloAnf.ColumnCount:=7;
      grdDettaglioCalcoloAnf.RowCount:=3;
      for row:=0 to grdDettaglioCalcoloAnf.RowCount - 1 do
        for col:=0 to grdDettaglioCalcoloAnf.ColumnCount - 1 do
          grdDettaglioCalcoloAnf.Cell[row,col].Text:='';
      row:=0;
      col:=0;
      inc(col);
      grdDettaglioCalcoloAnf.Cell[row,col].Text:='Richiedente';
      inc(col);
      grdDettaglioCalcoloAnf.Cell[row,col].Text:='Coniuge';
      inc(col);
      grdDettaglioCalcoloAnf.Cell[row,col].Text:='Figli minorenni';
      inc(col);
      grdDettaglioCalcoloAnf.Cell[row,col].Text:='Figli maggiorenni';
      inc(col);
      grdDettaglioCalcoloAnf.Cell[row,col].Text:='Frat./Sor./Nipoti';
      inc(col);
      grdDettaglioCalcoloAnf.Cell[row,col].Text:='Totali';

      col:=0;
      inc(row);
      grdDettaglioCalcoloAnf.Cell[row,col].Text:='Num.componenti';
      inc(row);
      grdDettaglioCalcoloAnf.Cell[row,col].Text:='Inabili';
      row:=1;
      col:=1;
      grdDettaglioCalcoloAnf.Cell[row,col].Text:='1';

      if DatiOutP239.CodTabella <> '' then
      begin
        row:=1;
        col:=2;
        if DatiOutP239.Coniuge <> 0 then
          grdDettaglioCalcoloAnf.Cell[row,col].Text:=IntToStr(DatiOutP239.Coniuge);
        inc(col);
        if DatiOutP239.FigliMin <> 0 then
          grdDettaglioCalcoloAnf.Cell[row,col].Text:=IntToStr(DatiOutP239.FigliMin);
        inc(col);
        if DatiOutP239.FigliMagInabili <> 0 then
          grdDettaglioCalcoloAnf.Cell[row,col].Text:=IntToStr(DatiOutP239.FigliMagInabili);
        inc(col);
        if DatiOutP239.FratSorNip <> 0 then
          grdDettaglioCalcoloAnf.Cell[row,col].Text:=IntToStr(DatiOutP239.FratSorNip);
        inc(col);
        if DatiOutP239.NumComponenti <> 0 then
          grdDettaglioCalcoloAnf.Cell[row,col].Text:=IntToStr(DatiOutP239.NumComponenti);
        col:=1;
        inc(row);
        if DatiOutP239.RichiedenteInabile > 0 then
          grdDettaglioCalcoloAnf.Cell[row,col].Text:=A000MSG_MSG_SI;
        inc(col);
        if DatiOutP239.ConiugeInabile > 0 then
          grdDettaglioCalcoloAnf.Cell[row,col].Text:=A000MSG_MSG_SI;
        inc(col);
        if DatiOutP239.FigliMinInabili <> 0 then
          grdDettaglioCalcoloAnf.Cell[row,col].Text:=IntToStr(DatiOutP239.FigliMinInabili);
        inc(col);
        if DatiOutP239.FigliMagInabili <> 0 then
          grdDettaglioCalcoloAnf.Cell[row,col].Text:=IntToStr(DatiOutP239.FigliMagInabili);
        inc(col);
        if DatiOutP239.FratSorNipInabili <> 0 then
          grdDettaglioCalcoloAnf.Cell[row,col].Text:=IntToStr(DatiOutP239.FratSorNipInabili);
        inc(col);
        if DatiOutP239.NumComponentiInabili <> 0 then
          grdDettaglioCalcoloAnf.Cell[row,col].Text:=IntToStr(DatiOutP239.NumComponentiInabili);
      end;
    end;
  end;
end;

procedure TWP430FAnagraficoDettFM.redditoANFAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  edtTotaleANF.Text:=(WR302DM as TWP430FAnagraficoDM).P430FAnagraficoMW.TotaleANF;
  EseguiRelazioni((Sender as TmeIWDBEdit).DataField);
end;

procedure TWP430FAnagraficoDettFM.ImpostaContextMenu(Componente: TControl;
  Val: TPopupMenu);
begin
  if Componente is TmeIWDBEdit then
    TmeIWDBEdit(Componente).medpContextMenu:=val
  else if Componente is TmeIWEdit then
    TmeIWEdit(Componente).medpContextMenu:=val
  else if Componente is TmeIWDBRadioGroup then
    TmeIWDBRadioGroup(Componente).medpContextMenu:=val
  else if Componente is TMedpIWMultiColumnComboBox then
    (Componente as TMedpIWMultiColumnComboBox).medpContextMenu:=val
  else if Componente is TmeIWDBCheckBox then
    TmeIWDBCheckBox(Componente).medpContextMenu:=val
  else if Componente is TmeIWDBComboBox then
    TmeIWDBComboBox(Componente).medpContextMenu:=val
  else if Componente is TmeIWLabel then
    TmeIWLabel(Componente).medpContextMenu:=val
  else
   raise Exception.Create('Tipo componente non censito in ImpostaContextMenu ' + Componente.Name);
end;

procedure TWP430FAnagraficoDettFM.ImpostaContextMenuComponenti;
var
  i: Integer;
  Campo: String;
begin
  for i:=0 to Length(SchedaAnagrafica) - 1 do
  begin
    // campo di T430 -> context menu con elemento "Storia del dato"
    Campo:=SchedaAnagrafica[i].NomeCampo;
    if VarToStr((WR302DM as TWP430FAnagraficoDM).P430FAnagraficoMW.selI030.Lookup('COLONNA',Campo,'COLONNA')) = Campo then
    begin
      // context menu con elemento "Relazioni"
      ImpostaContextMenu(SchedaAnagrafica[i].Componente, pmnStoricoRelaz);
      if Assigned(SchedaAnagrafica[i].lblComponente) then
        ImpostaContextMenu(SchedaAnagrafica[i].lblComponente, pmnStoricoRelaz);
    end
    else
    begin
      // context menu senza elemento "Relazioni"
      ImpostaContextMenu(SchedaAnagrafica[i].Componente, pmnStorico);
      if Assigned(SchedaAnagrafica[i].lblComponente) then
        ImpostaContextMenu(SchedaAnagrafica[i].lblComponente, pmnStorico);
    end;
  end;
end;

procedure TWP430FAnagraficoDettFM.StoriaClick(Sender: TObject);
var
  lastDato,Dato: String;
  i: Integer;
  WC006FStoriaDipFM: TWC006FStoriaDipFM;
  C006FStoriaDati: TC006FStoriaDati;
  rigaColorata: Boolean;
begin
  inherited;

  C006FStoriaDati:=TC006FStoriaDati.Create(nil);
  i:=-1;
  Dato:='';
  if pmnStorico.PopupComponent <> nil then
    i:=IndiceComponenteByNomeComp(pmnStorico.PopupComponent.Name)
  else if pmnStoricoRelaz.PopupComponent <> nil then
    i:=IndiceComponenteByNomeComp(pmnStoricoRelaz.PopupComponent.Name);
  if i >= 0  then
  begin
    Dato:=SchedaAnagrafica[i].NomeCampo;
    if Dato = 'D_COMUNE_INAIL' then
      Dato:='COD_COMUNE_INAIL'
    else if Dato = 'D_NOMINATIVO_EREDE' then
      Dato:='PROGRESSIVO_EREDE_DI';
  end;
  try
    with (WR302DM as TWP430FAnagraficoDM) do
    begin
      if (Sender = mnuStoriaDipendente1) or (Sender = mnuStoriaDipendente2) then
      begin
        C006FStoriaDati.GetStoriaDatoP430(selTabella.FieldByName('Progressivo').AsInteger,'*');
      end
      else if (Sender = mnuStoricizCorr1) or (Sender = mnuStoricizCorr2) then
        C006FStoriaDati.GetStoriaDatoP430(selTabella.FieldByName('Progressivo').AsInteger,'*',selTabella.FieldByName('DECORRENZA').AsDateTime)
      else
        C006FStoriaDati.GetStoriaDatoP430(selTabella.FieldByName('Progressivo').AsInteger,Dato);

      cdsStoriaDato.EmptyDataSet;
      rigaColorata:=False;
      lastDato:='';
      for i:=0 to C006FStoriaDati.StoriaDipendente.Count - 1 do
      begin
        //Dalla visualizzazione di tutti gli storici escludo data decorrenza e datafine
        if (RecStoria(C006FStoriaDati.StoriaDipendente[i]).NomeCampo <> 'DECORRENZA') and
          (RecStoria(C006FStoriaDati.StoriaDipendente[i]).NomeCampo <> 'DECORRENZA_FINE') then
        begin
          cdsStoriaDato.Append;
          cdsStoriaDato.FieldByName('KEY').AsString:=IntToStr(cdsStoriaDato.RecordCount);
          cdsStoriaDato.FieldByName('DATO').AsString:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).TipoDato;
          cdsStoriaDato.FieldByName('DATADEC').AsString:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).DataDec;
          //Se la data fine = 31/12/3999 scrivo 'Corrente'
          if RecStoria(C006FStoriaDati.StoriaDipendente[i]).DataFine = '31/12/3999' then
            cdsStoriaDato.FieldByName('DATAFINE').AsString:='Corrente'
          else
            cdsStoriaDato.FieldByName('DATAFINE').AsString:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).DataFine;

          cdsStoriaDato.FieldByName('VALORE').AsString:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).Valore;
          cdsStoriaDato.FieldByName('DESCRIZIONE').AsString:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).Descrizione;

          if cdsStoriaDato.FieldByName('DATO').AsString <> lastDato then
          begin
            lastDato:=cdsStoriaDato.FieldByName('DATO').AsString;
            rigaColorata:=not rigaColorata;
          end;
          cdsStoriaDato.FieldByName('RIGACOLORATA').AsBoolean:=rigaColorata;

          cdsStoriaDato.Post;
        end;
      end;
      cdsStoriaDato.First;
      WC006FStoriaDipFM:=TWC006FStoriaDipFM.Create(Self.Owner);
      WC006FStoriaDipFM.CampoColoreRiga:='RIGACOLORATA';
      if (selTabella.State = dsBrowse) then
        WC006FStoriaDipFM.Visualizza(cdsrStoriaDato,SpostaStoricoResultEvent)
      else
        WC006FStoriaDipFM.Visualizza(cdsrStoriaDato,nil);
    end;
  finally
    C006FStoriaDati.Free;
  end;
end;

procedure TWP430FAnagraficoDettFM.SpostaStoricoResultEvent(Sender: TObject; ResultDec,ResultFine: TDateTime);
begin
  (Self.Owner as TWP430FAnagrafico).SpostaStorico(ResultDec);
end;

end.
