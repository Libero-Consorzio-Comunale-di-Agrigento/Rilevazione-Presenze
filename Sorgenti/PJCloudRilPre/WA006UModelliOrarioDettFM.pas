unit WA006UModelliOrarioDettFM;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms, DB, OracleData,
  Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, R500Lin,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel, meIWRegion, IWCompGrids, meIWGrid,
  medpIWTabControl, IWCompListbox, meIWDBComboBox, C180FunzioniGenerali, IWCompExtCtrls, IWDBExtCtrls,
  meIWDBRadioGroup, IWCompCheckbox, meIWDBCheckBox, medpIWMultiColumnComboBox, IWDBGrids, medpIWDBGrid,
  meIWDBGrid, IWCompButton, meIWButton, C190FunzioniGeneraliWeb, WC013UCheckListFM, meIWDBLabel,
  meIWComboBox, meIWImageFile, A000UInterfaccia, Menus, meIWCheckBox, A000UCostanti;

type
  TWA006FModelliOrarioDettFM = class(TWR205FDettTabellaFM)
    lblCodice: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    grdTabDetail: TmedpIWTabControl;
    WA006PuntiTimbraturaRG: TmeIWRegion;
    lblTipoOrario: TmeIWLabel;
    dcmbTipoOra: TmeIWDBComboBox;
    lblPerLav: TmeIWLabel;
    dcmbPerLav: TmeIWDBComboBox;
    TemplatePuntiTimbraturaRG: TIWTemplateProcessorHTML;
    drgpObblFac: TmeIWDBRadioGroup;
    lblObblFac: TmeIWLabel;
    dedtOreTeor: TmeIWDBEdit;
    lblOreTeor: TmeIWLabel;
    lblOreMin: TmeIWLabel;
    dedtOreMin: TmeIWDBEdit;
    lblOreMax: TmeIWLabel;
    dedtOreMax: TmeIWDBEdit;
    dchkCoperturaCarenza: TmeIWDBCheckBox;
    dchkRegoleProfilo: TmeIWDBCheckBox;
    dchkFrazDeb: TmeIWDBCheckBox;
    dchkNotteEntrata: TmeIWDBCheckBox;
    dchkFlexDopoMezanotte: TmeIWDBCheckBox;
    lblMinUscitaNotte: TmeIWLabel;
    dedtMinUscitaNotte: TmeIWDBEdit;
    dchkCompDetr: TmeIWDBCheckBox;
    dcmbTipoFle: TmeIWDBComboBox;
    lblTipoFle: TmeIWLabel;
    dchkRicalcoloDebitoGG: TmeIWDBCheckBox;
    dchkRicalcoloSpostaPN: TmeIWDBCheckBox;
    dchkRicalcoloOffNoTimb: TmeIWDBCheckBox;
    lblRicalcoloMin: TmeIWLabel;
    dedtRicalcoloMin: TmeIWDBEdit;
    dedtRicalcoloMax: TmeIWDBEdit;
    lblRicalcoloMax: TmeIWLabel;
    lblRicalcoloDebMin: TmeIWLabel;
    dedtRicalcoloDebMin: TmeIWDBEdit;
    dedtRicalcoloDebMax: TmeIWDBEdit;
    lblRicalcoloDebMax: TmeIWLabel;
    lblRicalcoloCausNeg: TmeIWLabel;
    dlckRicalcoloCausNeg: TMedpIWMultiColumnComboBox;
    dlckRicalcoloCausPos: TMedpIWMultiColumnComboBox;
    lblRicalcoloCausPos: TmeIWLabel;
    grdTimbrature: TmedpIWDBGrid;
    WA006IndennitaRG: TmeIWRegion;
    WA006PausaMensaRG: TmeIWRegion;
    WA006CausalizzAutomRG: TmeIWRegion;
    WA006StraordinarioRG: TmeIWRegion;
    TemplateIndennitaRG: TIWTemplateProcessorHTML;
    TemplatePausaMensaRG: TIWTemplateProcessorHTML;
    TemplateStraordinarioRG: TIWTemplateProcessorHTML;
    TemplateCausalizzAutomRG: TIWTemplateProcessorHTML;
    lblIndPresenza: TmeIWLabel;
    lblTolleranza: TmeIWLabel;
    P2E05: TmeIWDBEdit;
    drgpCompNot: TmeIWDBRadioGroup;
    lblCompNot: TmeIWLabel;
    lblIndIntera: TmeIWLabel;
    lblOreMinManutenz: TmeIWLabel;
    dedtMMIndPres: TmeIWDBEdit;
    lblFlagPres: TmeIWLabel;
    drgpFlagPres: TmeIWDBRadioGroup;
    lblMezzaInd: TmeIWLabel;
    dchkFlagMPres: TmeIWDBCheckBox;
    dedtMMIndMPres: TmeIWDBEdit;
    P2E12: TmeIWDBCheckBox;
    dchkRientroPomeridiano: TmeIWDBCheckBox;
    lblIndFestiva: TmeIWLabel;
    drgpIndFestiva: TmeIWDBRadioGroup;
    lblOreIndFest: TmeIWLabel;
    dedtOreIndFest: TmeIWDBEdit;
    lblRiposoCompensativo: TmeIWLabel;
    drgpRiposoCompensativo: TmeIWDBRadioGroup;
    lblDebitoRipCom: TmeIWLabel;
    dedtDebitoRipCom: TmeIWDBEdit;
    dchkRipcomGGNonLav: TmeIWDBCheckBox;
    dchkArrTimbInterne: TmeIWDBCheckBox;
    lblArrotFuoriOrario: TmeIWLabel;
    lblSuEntrata: TmeIWLabel;
    P2E01: TmeIWDBEdit;
    lblSuUscita: TmeIWLabel;
    P2E02: TmeIWDBEdit;
    lblArrotGiornaliero: TmeIWLabel;
    lblP2E03: TmeIWLabel;
    P2E03: TmeIWDBEdit;
    lblArrNeg: TmeIWLabel;
    P2E04: TmeIWDBEdit;
    lblArrEccedLiq: TmeIWLabel;
    dedtArrEccedLiq: TmeIWDBEdit;
    lblArrEccedFasce: TmeIWLabel;
    dedtArrEccedFasce: TmeIWDBEdit;
    dchkArrEccFasceComp: TmeIWDBCheckBox;
    drgpIndPresStr: TmeIWDBRadioGroup;
    lblIndPresStr: TmeIWLabel;
    drgpIndFestStr: TmeIWDBRadioGroup;
    lblIndFestStr: TmeIWLabel;
    drgpIndNotStr: TmeIWDBRadioGroup;
    lblIndNotStr: TmeIWLabel;
    dchkIntersezAutoGiust: TmeIWDBCheckBox;
    lblTipoMensa: TmeIWLabel;
    dcmbTipoMensa: TmeIWDBComboBox;
    lblMMMinimi: TmeIWLabel;
    dedtMMMinimi: TmeIWDBEdit;
    dedtMinPercorr: TmeIWDBEdit;
    lblMinPercorr: TmeIWLabel;
    dedtPMTTolleranza: TmeIWDBEdit;
    lblPMTTolleranza: TmeIWLabel;
    lblPMStaccoInf: TmeIWLabel;
    dedtPMStaccoInf: TmeIWDBEdit;
    lblPMOreMinimeInf: TmeIWLabel;
    dedtPMOreMinimeInf: TmeIWDBEdit;
    lblPausaMensaTimbrata: TmeIWLabel;
    dchkCausaleObbl: TmeIWDBCheckBox;
    dchkTimbratureUE: TmeIWDBCheckBox;
    dchkPMTTIMBAUTORIZZATE: TmeIWDBCheckBox;
    dchkPMTLimiteFlex: TmeIWDBCheckBox;
    dchkPMTTimbMaturaMensa: TmeIWDBCheckBox;
    dchkPMTUscitaRit: TmeIWDBCheckBox;
    lblTollFuoriOrario: TmeIWLabel;
    dedtTollFuoriOrario: TmeIWDBEdit;
    lblPMRecupUscita: TmeIWLabel;
    dedtPMRecupUscita: TmeIWDBEdit;
    lblMensaAutomatica: TmeIWLabel;
    dchkPMAutoURit: TmeIWDBCheckBox;
    dchkDetrAutCont: TmeIWDBCheckBox;
    dchkPMAPreservaTimbInFascia: TmeIWDBCheckBox;
    lblPausaMensaAutomatica: TmeIWLabel;
    dedetPausaMensaAutomatica: TmeIWDBEdit;
    lblRientroMinimo: TmeIWLabel;
    dedtRientroMinimo: TmeIWDBEdit;
    lblTimbraturaMensa: TmeIWLabel;
    lblTimbraturaMensaInterna: TmeIWLabel;
    drgpTimbraturaMensaInterna: TmeIWDBRadioGroup;
    dchkPmtSoloTimbMensa: TmeIWDBCheckBox;
    dchkTimbraturaMensa: TmeIWDBCheckBox;
    dchkTimbraturaMensaDetrTot: TmeIWDBCheckBox;
    lblTimbraturaMensaDetrazione: TmeIWLabel;
    dedtTimbraturaMensaDetrazione: TmeIWDBEdit;
    dchkTimbraturaMensaFlex: TmeIWDBCheckBox;
    dcmbTipoStraordinario: TmeIWDBComboBox;
    lblTipoStraordinario: TmeIWLabel;
    dchkStrRipFasce: TmeIWDBCheckBox;
    lblEccedenzeLiqComp: TmeIWLabel;
    dchkSoloComp: TmeIWDBCheckBox;
    lblP4E13: TmeIWLabel;
    dedtP4E13: TmeIWDBEdit;
    lblScostGGMinSoglia: TmeIWLabel;
    dedtScostGGMinSoglia: TmeIWDBEdit;
    lblOraMaxComp: TmeIWLabel;
    dedtOraMaxComp: TmeIWDBEdit;
    lblArrotondamentoSottoSoglia: TmeIWLabel;
    dedtArrotondamentoSottoSoglia: TmeIWDBEdit;
    lblArrotondDopoSoglia: TmeIWLabel;
    dedtP4E14: TmeIWDBEdit;
    dchkArrotComp: TmeIWDBCheckBox;
    lblEccedenzeSottoSoglia: TmeIWLabel;
    drgpEComp2: TmeIWDBRadioGroup;
    drgpEComp1: TmeIWDBRadioGroup;
    lblEccCompCausalizzata: TmeIWLabel;
    dcmbEccCompCausalizzata: TmeIWDBComboBox;
    lblCarenzaObbNoLiq: TmeIWLabel;
    dchkCarenzaObbNoLiq: TmeIWDBCheckBox;
    lblStraordFuoriFascia: TmeIWLabel;
    lblP4E01: TmeIWLabel;
    dedtP4E01: TmeIWDBEdit;
    dChkCompseInf: TmeIWDBCheckBox;
    lblP4E03: TmeIWLabel;
    dedtP4E03: TmeIWDBEdit;
    dedtP4E04: TmeIWDBEdit;
    lblP4E04: TmeIWLabel;
    dedtP4E05: TmeIWDBEdit;
    lblP4E05: TmeIWLabel;
    dedtP4E06: TmeIWDBEdit;
    lblP4E06: TmeIWLabel;
    dchkArrotComp2: TmeIWDBCheckBox;
    dchkSpezzNonCausScartoEcc: TmeIWDBCheckBox;
    lblVincoliFruizStr: TmeIWLabel;
    lblP4E07: TmeIWLabel;
    dedtP4E07: TmeIWDBEdit;
    chkDopoOreMax: TmeIWDBCheckBox;
    lblFestLav: TmeIWLabel;
    cmbFestLavLiq: TMedpIWMultiColumnComboBox;
    lblFestLavLiq: TmeIWLabel;
    lblFestLavCmpLiq: TmeIWLabel;
    cmbFestLavCmpLiq: TMedpIWMultiColumnComboBox;
    lblFestLavCmpLiqTurn: TmeIWLabel;
    cmbFestLavCmpLiqTurn: TMedpIWMultiColumnComboBox;
    lblCausaliEccedenza: TmeIWLabel;
    dedtCausaliEccedenza: TmeIWDBEdit;
    btnCausaliEccedenza: TmeIWButton;
    lblDistrOreOrdFasce: TmeIWLabel;
    cmbDistrOreOrdFasce: TMedpIWMultiColumnComboBox;
    grdPausaMensa: TmedpIWDBGrid;
    grdStraordinario: TmedpIWDBGrid;
    lblDescFestLavLiq: TmeIWDBLabel;
    lblDescFestLavCmpLiq: TmeIWDBLabel;
    lblDescFestLavCmpLiqTurn: TmeIWDBLabel;
    lblDescDistrOreOrdFasce: TmeIWDBLabel;
    pmnCausali: TPopupMenu;
    mnuAccedi: TMenuItem;
    dchkCausaleDisabilBloccante: TmeIWDBCheckBox;
    lblMinutiCausInizioOrario: TmeIWLabel;
    cmbCausaleInizioOrario: TMedpIWMultiColumnComboBox;
    lblCausaleInizioOrario: TmeIWLabel;
    dedtMinutiCausInizioOrario: TmeIWDBEdit;
    lblMinutiCausFineOrario: TmeIWLabel;
    dedtMinutiCausFineOrario: TmeIWDBEdit;
    lblCausaleFineOrario: TmeIWLabel;
    cmbCausaleFineOrario: TMedpIWMultiColumnComboBox;
    lblPMTStaccoMin: TmeIWLabel;
    dedtPMTStaccoMin: TmeIWDBEdit;
    dchkRipcomDebitoGG: TmeIWDBCheckBox;
    lblIndMaggiorata: TmeIWLabel;
    lblMMIndPresMag: TmeIWLabel;
    lblCoeffIndPresMag: TmeIWLabel;
    dedtMMIndPresMag: TmeIWDBEdit;
    dedtCoeffIndPresMag: TmeIWDBEdit;
    dedtOreTeorGGAss: TmeIWDBEdit;
    lblOreTeorGGAss: TmeIWLabel;
    dchkForzaTurnoPianificato: TmeIWCheckBox;
    dchkFrazDebNoTurnista: TmeIWCheckBox;
    lblFestLavGGSett: TmeIWLabel;
    drgpFestLavGGSett: TmeIWDBRadioGroup;
    dchkPMTTimbraturaMensa: TmeIWDBCheckBox;
    dchkPMTNoOreMinTimbMensa: TmeIWDBCheckBox;
    dchkFasciaNotteFestCompleta: TmeIWDBCheckBox;
    dchkIndFestivaUsaNotteCompleta: TmeIWDBCheckBox;
    lblLegendCausRiduzPN: TmeIWLabel;
    dedtCausRiduzPN: TmeIWDBEdit;
    btnCausRiduzPN: TmeIWButton;
    dcmbDetrazRiepprNorm: TmeIWDBComboBox;
    lblDetrazRiepprNorm: TmeIWLabel;
    lblXParam: TmeIWLabel;
    dedtXParam: TmeIWDBEdit;
    lblXParamOldVers: TmeIWLabel;
    dedtXParamOldVers: TmeIWDBEdit;
    lblOrariScambio: TmeIWLabel;
    dedtOrariScambio: TmeIWDBEdit;
    btnOrariScambio: TmeIWButton;
    dchkStrNotteSpezzato: TmeIWDBCheckBox;
    dchkDetrazParzStaccoInf: TmeIWDBCheckBox;
    lblCausRiduzPN: TmeIWLabel;
    lblCausRiduzPNCheckPMT: TmeIWLabel;
    dedtCausRiduzPNCheckPMT: TmeIWDBEdit;
    btnCausRiduzPNCheckPMT: TmeIWButton;
    lblTurniInizioOrario: TmeIWLabel;
    dedtTurniInizioOrario: TmeIWDBEdit;
    lblTurniFineOrario: TmeIWLabel;
    dedtTurniFineOrario: TmeIWDBEdit;
    lblAnomalieBloccanti: TmeIWLabel;
    dedtAnomalieBloccanti: TmeIWDBEdit;
    btnAnomalieBloccanti: TmeIWButton;
    dchkMinutiCausPrioritari: TmeIWDBCheckBox;
    WA006XParamRG: TmeIWRegion;
    grdXParam: TmedpIWDBGrid;
    grdXParamComp: TmedpIWDBGrid;
    TemplateXParamRG: TIWTemplateProcessorHTML;
    lblTableXParam: TmeIWLabel;
    lblTableXParamComp: TmeIWLabel;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure dcmbTipoOraChange(Sender: TObject);
    procedure gridRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure dcmbTipoMensaChange(Sender: TObject);
    procedure dcmbTipoStraordinarioChange(Sender: TObject);
    procedure dchkTimbraturaMensaAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure PulisciValoreAsync(Sender: TObject; EventParams: TStringList);
    procedure dchkRicalcoloDebitoGGAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure dchkFrazDebAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure dchkNotteEntrataAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure dchkFlagMPresAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure drgpRiposoCompensativoClick(Sender: TObject);
    procedure drgpIndFestivaClick(Sender: TObject);
    procedure dchkSoloCompAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure cmbFestLavLiqAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbFestLavCmpLiqAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbFestLavCmpLiqTurnAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbDistrOreOrdFasceAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure btnCausaliEccedenzaClick(Sender: TObject);
    procedure grdStraordinarioComponenti2DataSet(Row: Integer);
    procedure grdStraordinarioDataSet2Componenti(Row: Integer);
    procedure dchkPMAutoURitAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure grdPausaMensaComponenti2DataSet(Row: Integer);
    procedure grdPausaMensaDataSet2Componenti(Row: Integer);
    function grdPausaMensaBeforeModifica(Sender: TObject): Boolean;
    function grdPausaMensaBeforeInserisci(Sender: TObject): Boolean;
    procedure grdPausaMensaConferma(Sender: TObject);
    procedure grdTimbratureDataSet2Componenti(Row: Integer);
    procedure dcmbPerLavChange(Sender: TObject);
    procedure mnuAccediClick(Sender: TObject);
    procedure cmbCausaleInizioOrarioAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbCausaleFineOrarioAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure btnAnomalieBloccantiClick(Sender: TObject);
  private
    WC013: TWC013FCheckListFM;
    procedure evtDataChange;
    procedure ItemsPeriodoLav;
    procedure AbilitaComponenti; override;
    procedure VisualizzaDatiSelT021;
    procedure VisualizzaPaginaOpzioni;
    procedure PulisciValore(Sender: TObject);
    procedure CaricaMultiColumnComboBox; override;
    procedure ReleaseOggetti; override;
    procedure ckCausaliResult(Sender: TObject; Result: Boolean);
    procedure ckCodiciResult(Sender: TObject; Result: Boolean);
    procedure ckCodiciCausRiduzPNResult(Sender: TObject; Result: Boolean);
    procedure ckCodiciCausRiduzPNCheckPMTResult(Sender: TObject; Result: Boolean);
    procedure ckOrariScambioResult(Sender: TObject; Result: Boolean);
    procedure AssegnaCodiciSelezionati(Campo:String;Result:Boolean);
    procedure AbilitazioneGrpEccedenze(Abilita: boolean);
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure AbilitaGrpPausaMensaTimbrata(Abilitato: Boolean);
    procedure AbilitaGrpMensaAutomatica(Abilitato: Boolean);
    procedure AbilitaGrpTimbraturaMensa(Abilitato: Boolean);
    procedure AbilitaGrpPMIntermedia(Abilitato: Boolean);
    procedure grdPausaMensaPreparaComponenti;
    procedure grdPausaMensaNascondiColonne(Condizione1, Condizione2: Boolean);
    procedure PreparaComponentiGrdTimbrature;
    function SettaOrario: boolean;
    procedure CmbXParamAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure CmbXParamCompAsyncChange(Sender: TObject; EventParams: TStringList);
  protected
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
  public
    procedure evtStateChange;
    procedure ModificaXParam(AbilitaEdit: Boolean);
    procedure ModificaXParamComp(AbilitaEdit: Boolean);
  end;

implementation

uses WA006UModelliOrario, WA006UModelliOrarioDM, A006UModelliOrarioMW;

{$R *.dfm}

procedure TWA006FModelliOrarioDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  R180SetComboItemsValues(dcmbTipoOra.Items,(WR302DM as TWA006FModelliOrarioDM).A006MW.D_TipoOrario,'IV');
  R180SetComboItemsValues(dcmbTipoFle.Items,(WR302DM as TWA006FModelliOrarioDM).A006MW.D_Flessibilita,'IV');
  R180SetComboItemsValues(dcmbTipoMensa.Items,(WR302DM as TWA006FModelliOrarioDM).A006MW.D_PausaMensa,'IV');
  R180SetComboItemsValues(dcmbTipoStraordinario.Items,(WR302DM as TWA006FModelliOrarioDM).A006MW.D_TipoStraordinario,'IV');
  R180SetComboItemsValues(dcmbEccCompCausalizzata.Items,(WR302DM as TWA006FModelliOrarioDM).A006MW.D_EccCompCausalizzata,'IV');
  R180SetComboItemsValues(dcmbDetrazRiepprNorm.Items,(WR302DM as TWA006FModelliOrarioDM).A006MW.D_DetrazRiepPrNorm,'IV');
  inherited;
  grdTabDetail.AggiungiTab('Punti timbratura',WA006PuntiTimbraturaRG);
  grdTabDetail.AggiungiTab('Indennità/Arrotondamenti',WA006IndennitaRG);
  grdTabDetail.AggiungiTab('Pausa mensa',WA006PausaMensaRG);
  grdTabDetail.AggiungiTab('Straordinario',WA006StraordinarioRG);
  grdTabDetail.AggiungiTab('Causalizzazioni automatiche',WA006CausalizzAutomRG);
  if R180In(Parametri.Operatore,['SYSMAN','MONDOEDP','TESTR']) then
    grdTabDetail.AggiungiTab('XParam/Retrocompatibilità',WA006XParamRG)
  else
    WA006XParamRG.Visible:=False;
  grdTabDetail.ActiveTab:=WA006PuntiTimbraturaRG;
  ItemsPeriodoLav;
  dchkRicalcoloDebitoGGAsyncClick(nil,nil);
  dchkSpezzNonCausScartoEcc.Visible:=(Pos('TORINO',UpperCase(Parametri.RagioneSociale)) > 0) and (Parametri.CodiceIntegrazione = 'TO');
end;

procedure TWA006FModelliOrarioDettFM.mnuAccediClick(Sender: TObject);
var
  Accedi: Boolean;
  Codice: String;
  p: Integer;
  LComp: TComponent;
  LDBEditComp:TmeIWDBEdit;
  LCmb: TMedpIWMultiColumnComboBox;
begin
  Accedi:=False;
  Codice:='';
  LDBEditComp:=nil;

  if (Sender as TMenuItem).GetParentMenu = pmnCausali then
  begin
    LComp:=(pmnCausali.PopupComponent as TComponent);
    if LComp is TMedpIWMultiColumnComboBox then
    begin
      // dblookupcombobox
      if (LComp = cmbFestLavLiq) or
         (LComp = cmbFestLavCmpLiq) or
         (LComp = cmbFestLavCmpLiqTurn) then
      begin
        // causali del festivo lavorato
        Codice:=VarToStr((LComp as TMedpIWMultiColumnComboBox).Text);
        Accedi:=True;
      end;
    end
    else if LComp is TmeIWDBEdit then
    begin
      // edit
      if (LComp = dedtCausaliEccedenza) then
        LDBEditComp:=dedtCausaliEccedenza as TmeIWDBEdit
      else if (LComp = dedtCausRiduzPN) then
        LDBEditComp:=dedtCausRiduzPN as TmeIWDBEdit;
      if LDBEditComp <> nil then
      begin
        // accede selezionando la prima causale nella lista
        if LDBEditComp.Text = '' then
          Codice:=''
        else
        begin
          p:=Pos(',',LDBEditComp.Text);
          if p = 0 then
            Codice:=LDBEditComp.Text
          else
            Codice:=Copy(LDBEditComp.Text,1,p - 1);
        end;
        Accedi:=True;
      end;
    end;
    // accesso alla funzione "causali di presenza"
    if Accedi then
    begin
      //OpenA020CausPresenze(Codice);
      (Self.Owner as TWA006FModelliOrario).AccediForm(107,'CODICE='+Codice);
      (WR302DM as TWA006FModelliOrarioDM).A006MW.selT275.Refresh;
    end;
  end;
end;

procedure TWA006FModelliOrarioDettFM.Notification(AComponent: TComponent;  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent is TWC013FCheckListFM) and (AComponent = WC013) then
      WC013:=nil
    (*else if (AComponent is TWC015FSelEditGridFM) and (AComponent = WC015FSelEditGridFM) then
      WC015FSelEditGridFM:=nil
    *)
    ;
  end;
end;

procedure TWA006FModelliOrarioDettFM.ReleaseOggetti;
begin
  inherited;
  if WC013 <> nil then
  begin
    try FreeAndNil(WC013); except end;
  end;
end;

procedure TWA006FModelliOrarioDettFM.DataSet2Componenti;
begin
  inherited;
  //Massimo: vedi commento sul DataModulo alla procedure dsrTabellaDataChange.
  evtDataChange;
  with (WR302DM as TWA006FModelliOrarioDM) do
  begin
    cmbFestLavLiq.Text:=SelTabella.FieldByName('FESTLAV_LIQ').AsString;
    cmbFestLavCmpLiq.Text:=SelTabella.FieldByName('FESTLAV_CMP_LIQ').AsString;
    cmbFestLavCmpLiqTurn.Text:=SelTabella.FieldByName('FESTLAV_CMP_LIQ_TURN').AsString;
    cmbDistrOreOrdFasce.Text:=SelTabella.FieldByName('CAUSALE_FASCE').AsString;
    cmbCausaleInizioOrario.Text:=SelTabella.FieldByName('CAUSALE_INIZIOORARIO').AsString;
    cmbCausaleFineOrario.Text:=SelTabella.FieldByName('CAUSALE_FINEORARIO').AsString;
  end;
  dcmbTipoStraordinarioChange(nil);
end;

procedure TWA006FModelliOrarioDettFM.Componenti2DataSet;
begin
  inherited;
  with (WR302DM as TWA006FModelliOrarioDM) do
  begin
    selTabella.FieldByName('FESTLAV_LIQ').AsString:=cmbFestLavLiq.Text;
    selTabella.FieldByName('FESTLAV_CMP_LIQ').AsString:=cmbFestLavCmpLiq.Text;
    selTabella.FieldByName('FESTLAV_CMP_LIQ_TURN').AsString:=cmbFestLavCmpLiqTurn.Text;
    selTabella.FieldByName('CAUSALE_FASCE').AsString:=cmbDistrOreOrdFasce.Text;
    selTabella.FieldByName('CAUSALE_INIZIOORARIO').AsString:=cmbCausaleInizioOrario.Text;
    selTabella.FieldByName('CAUSALE_FINEORARIO').AsString:=cmbCausaleFineOrario.Text;
  end;
end;

procedure TWA006FModelliOrarioDettFM.evtStateChange;
var
  IsAdmin: Boolean;
begin
  IsAdmin:=R180In(Parametri.Operatore,['SYSMAN','MONDOEDP','TESTR']);
  //Massimo: Spostato su 'evtDataChange' perchè se no la prima volta che accedo alla form non passa di qua
  //actModificaXParam.Visible:=R180In(Parametri.Operatore,VarArrayOf(['MONDOEDP','SYSMAN'])) and ((WR302DM as TWA006FModelliOrarioDM).SelTabella.State = dsEdit);
  with (WR302DM as TWA006FModelliOrarioDM) do
  begin
    A006MW.selT021PN.ReadOnly:=SelTabella.State = dsBrowse;
    A006MW.selT021PM.ReadOnly:=SelTabella.State = dsBrowse;
    A006MW.selT021STR.ReadOnly:=SelTabella.State = dsBrowse;
    //Massimo: Funzione non riportata su IrisCloud
    //actCercaDuplicati.Enabled:=SelTabella.State = dsBrowse;
    btnCausaliEccedenza.Enabled:=SelTabella.State in [dsInsert,dsEdit];
    btnCausRiduzPN.Enabled:=(selTabella.State in [dsInsert,dsEdit]) and IsAdmin;
    btnOrariScambio.Enabled:=selTabella.State in [dsInsert,dsEdit];
  end;
  if (WR302DM as TWA006FModelliOrarioDM).selTabella.State in [dsInsert,dsEdit,dsBrowse] then
    ItemsPeriodoLav;
  with (WR302DM as TWA006FModelliOrarioDM) do
  begin
    ModificaXParam((selTabella.State = dsEdit) and IsAdmin);
    ModificaXParamComp((selTabella.State = dsEdit) and IsAdmin);
  end;
  //Massimo: vedi commento sul DataModulo alla procedure dsrTabellaDataChange.
  evtDataChange;
end;

procedure TWA006FModelliOrarioDettFM.dcmbTipoOraChange(Sender: TObject);
{Cambio Tipo Orario con conseguente modifica delle videate}
var SO,SPL:Boolean;
begin
  {Se TipoOrario o PeriodoLav sono cambiati, allora cambio le pagine}
  SO:=SettaOrario;
  SPL:=(WR302DM as TWA006FModelliOrarioDM).A006MW.SettaPeriodoLav((WR302DM as TWA006FModelliOrarioDM).SelTabella.FieldByName('PerLav').AsString);
  if (SO) or (SPL) then
  begin
    VisualizzaDatiSelT021;
    VisualizzaPaginaOpzioni;
  end;
end;

procedure TWA006FModelliOrarioDettFM.dcmbTipoStraordinarioChange(Sender: TObject);
var i:Integer;
    TipoStraordinario: String;
begin
  inherited;
  TipoStraordinario:=(WR302DM as TWA006FModelliOrarioDM).SelTabella.FieldByName('COMPFASCIA').AsString;
  dChkCompseInf.Enabled:=(TipoStraordinario = '3') or (TipoStraordinario = '4');
  dchkArrotComp2.Enabled:=(TipoStraordinario = '3') or (TipoStraordinario = '4');
  AbilitazioneGrpEccedenze((TipoStraordinario = '1') or (TipoStraordinario = '2'));
end;

procedure TWA006FModelliOrarioDettFM.AbilitazioneGrpEccedenze(Abilita: boolean);
begin
  dchkSoloComp.Enabled:=Abilita;
  dedtP4E13.Enabled:=Abilita;
  dedtScostGGMinSoglia.Enabled:=Abilita;
  dedtOraMaxComp.Enabled:=Abilita;
  dedtArrotondamentoSottoSoglia.Enabled:=Abilita;
  dedtP4E14.Enabled:=Abilita;
  dchkArrotComp.Enabled:=Abilita;
  drgpEComp1.Enabled:=Abilita;
  drgpEComp2.Enabled:=Abilita;
  drgpEComp1.Visible:=not ((WR302DM as TWA006FModelliOrarioDM).SelTabella.FieldByName('TUTTOCOMP').AsString='S');
  drgpEComp2.Visible:=(WR302DM as TWA006FModelliOrarioDM).SelTabella.FieldByName('TUTTOCOMP').AsString='S';
  dcmbEccCompCausalizzata.Enabled:=Abilita;
end;

procedure TWA006FModelliOrarioDettFM.drgpIndFestivaClick(Sender: TObject);
begin
  if (drgpIndFestiva.ItemIndex = 0) and ((WR302DM as TWA006FModelliOrarioDM).SelTabella.State in [dsInsert,dsEdit]) then
    (WR302DM as TWA006FModelliOrarioDM).SelTabella.FieldByName(dedtOreIndFest.DataField).Clear;
  dedtOreIndFest.Enabled:=drgpIndFestiva.ItemIndex > 0;
  lblOreIndFest.Enabled:=drgpIndFestiva.ItemIndex > 0;
end;

procedure TWA006FModelliOrarioDettFM.drgpRiposoCompensativoClick(Sender: TObject);
begin
  lblDebitoRipCom.Caption:='Ore massime';
  if drgpRiposoCompensativo.ItemIndex = 1 then
    lblDebitoRipCom.Caption:='Debito teorico';
  lblDebitoRipCom.Enabled:=drgpRiposoCompensativo.ItemIndex > 0;
  dedtDebitoRipCom.Enabled:=drgpRiposoCompensativo.ItemIndex > 0;
  dchkRipcomGGNonLav.Enabled:=drgpRiposoCompensativo.ItemIndex = 2;
  dchkRipcomDebitoGG.Enabled:=drgpRiposoCompensativo.ItemIndex = 2;
end;

procedure TWA006FModelliOrarioDettFM.PulisciValoreAsync(Sender: TObject; EventParams: TStringList);
begin
  PulisciValore(Sender);
  if (Sender = dedtPMStaccoInf) or (Sender = dedtPMOreMinimeInf) then
    dcmbTipoMensaChange(Sender);
end;

procedure TWA006FModelliOrarioDettFM.VisualizzaPaginaOpzioni;
{Gestione visualizzazione dati nella pagina Opzioni}
begin
  {Visualizzazione label}
  with (WR302DM as TWA006FModelliOrarioDM).A006MW do
  begin
    lblOreTeor.Enabled:=FTipoOrario in [toA,toB,toC,toD];
    dedtOreTeor.Enabled:= (WR302DM as TWA006FModelliOrarioDM).A006MW.FTipoOrario in [toA,toB,toC,toD];
    lblOreMax.Visible:=FTipoOrario in [toC];
    dedtOreMax.Visible:=FTipoOrario in [toC];
    dchkFrazDeb.Visible:=(FTipoOrario in [toE]) and (FPeriodoLav in [plT1]);
    dchkFrazDebNoTurnista.Visible:=(FTipoOrario in [toE]) and (FPeriodoLav in [plT1]);
    dchkNotteEntrata.Visible:=(FTipoOrario in [toE]) and (FPeriodoLav in [plT1]);
    dchkFlexDopoMezanotte.Visible:=(FTipoOrario in [toE]) and (FPeriodoLav in [plT1]);
    lblMinUscitaNotte.Visible:=(FTipoOrario in [toE]) and (FPeriodoLav in [plT1]);
    dedtMinUscitaNotte.Visible:=(FTipoOrario in [toE]) and (FPeriodoLav in [plT1]);
    lblTipoFle.Visible:=FTipoOrario in [toA];
    dcmbTipoFle.Visible:=FTipoOrario in [toA];
    dchkCompDetr.Visible:=FTipoOrario in [toC];
    chkDopoOreMax.Enabled:=FTipoOrario in [toC];
    dcmbTipoFle.Enabled:=(FTipoOrario in [toA]) and (FPeriodoLav in [plS]);
    if ((WR302DM as TWA006FModelliOrarioDM).selTabella.State in [dsInsert,dsEdit]) and (FTipoOrario in [toA]) and (FPeriodoLav in [plC]) then
      (WR302DM as TWA006FModelliOrarioDM).selTabella.FieldByName('TipoFle').AsString:='A';
    C190VisualizzaElemento(JQuery,'pnlTurni',(FTipoOrario in [toE]));
    {Competenza turno notturno}
    drgpFlagPres.Enabled:=Trim(dedtMMIndPres.Text) = '.';
    dedtMMIndMPres.Enabled:=dchkFlagMPres.Checked;
    //Caratto 18/04/2014 cambiato da visible a enabled
    drgpCompNot.Enabled:=(FTipoOrario in [toE]) and (FPeriodoLav in [plT1]);
    dedtOreIndFest.Enabled:=drgpIndFestiva.ItemIndex > 0;
    lblOreIndFest.Enabled:=drgpIndFestiva.ItemIndex > 0;
    {Pausa mensa abilitata}
    if ((WR302DM as TWA006FModelliOrarioDM).selTabella.State in [dsInsert,dsEdit]) and (FPeriodoLav in [plS]) and (not (FTipoOrario in [toC])) then
      selT020.FieldByName('TipoMensa').AsString:='Z';
    //GC 20/11/2019 Implementato nuovo campo
    dchkStrNotteSpezzato.Enabled:=(FTipoOrario in [toE]) and (FPeriodoLav in [plT1]) and dchkNotteEntrata.Checked;
  end;
end;

procedure TWA006FModelliOrarioDettFM.evtDataChange;
{Richiama le procedure di cambio videate allo scorrimento dei record}
var SO,SPL:Boolean;
begin
  inherited;
  //Massimo: vedi commento su state change del perchè questa gestione è stata messa qua
  //if Field <> nil then exit; Controllo inserito in dsrDataChange, prima che questa procedure venga chiamata
  {Se TipoOrario o sono cambiati, allora cambio le pagine}
  SO:=SettaOrario;
  SPL:=(WR302DM as TWA006FModelliOrarioDM).A006MW.SettaPeriodoLav((WR302DM as TWA006FModelliOrarioDM).SelTabella.FieldByName('PerLav').AsString);
  if (SO) or (SPL) then
    VisualizzaDatiSelT021;
  VisualizzaPaginaOpzioni;
  dcmbTipoMensaChange(nil); {Aggiorno pagina Pausa Mensa}
  //Disabilito il parametro "Ore continuative" se "Forzata se uscita dopo ore max"
  if dchkPMAutoURit.Checked then
    dchkDetrAutCont.Enabled:=False;
  dcmbTipoStraordinarioChange(nil); {Visualizzo dati straordinario}
  dchkTimbraturaMensaAsyncClick(nil,nil);
  PulisciValore(dedtMinPercorr);
  with (WR302DM as TWA006FModelliOrarioDM) do
  begin
    A006MW.cdsXParam.ImpostaParametri(XParamList, SelTabella.FieldByName('XPARAM').AsString);
    A006MW.cdsXParamComp.ImpostaParametri(XParamCompList, SelTabella.FieldByName('XPARAM_COMP_OLDVERS').AsString);
  end;
end;

procedure TWA006FModelliOrarioDettFM.VisualizzaDatiSelT021;
{Visualizzazione dati di selT021 nelle griglie, in base al Tipo orario e alla pausa mensa}
var
  i:Integer;
  selT021PN,SelTabellaPrinc:TOracleDataSet;
  InModifica:Boolean;
begin
  if (grdTabDetail.ActiveTab <> WA006PuntiTimbraturaRG) then exit;
  {Ripristino tutti i dati}
  selT021PN:=(WR302DM as TWA006FModelliOrarioDM).A006MW.selT021PN;
  SelTabellaPrinc:=(WR302DM as TWA006FModelliOrarioDM).selTabella;
  with selT021PN do
    for i:=0 to FieldCount - 1 do
      Fields[i].Visible:=(Fields[i].FieldName <> 'CODICE') and (Fields[i].FieldName <> 'DECORRENZA');
  (WR302DM as TWA006FModelliOrarioDM).A006MW.VisualizzaDatiTimbrature(dchkFrazDeb.Checked);

  (WR302DM as TWA006FModelliOrarioDM).A006MW.selT021PN.FieldByName('INDTURNO').Visible:=((WR302DM as TWA006FModelliOrarioDM).A006MW.selT021PN.FieldByName('INDTURNO').Visible) and ((WR302DM as TWA006FModelliOrarioDM).A006MW.FTipoOrario = toE);
  (WR302DM as TWA006FModelliOrarioDM).A006MW.selT021PN.FieldByName('INDFESTIVA').Visible:=((WR302DM as TWA006FModelliOrarioDM).A006MW.selT021PN.FieldByName('INDFESTIVA').Visible) and ((WR302DM as TWA006FModelliOrarioDM).A006MW.FTipoOrario = toE);

  // Riattiviamo la griglia dei punti nominali in modo da inzializzare i componenti per la modifica
  // in base alle colonne
  InModifica:=SelTabellaPrinc.State in [dsEdit,dsInsert];
  grdTimbrature.medpAttivaGrid((WR302DM as TWA006FModelliOrarioDM).A006MW.selT021PN,InModifica,InModifica);
  PreparaComponentiGrdTimbrature;
end;

function TWA006FModelliOrarioDettFM.SettaOrario:boolean;
{Setta FTipoOrario a seconda dell'input}
begin
  Result:=(WR302DM as TWA006FModelliOrarioDM).A006MW.SettaTipoOrario((WR302DM as TWA006FModelliOrarioDM).seltabella.fieldbyname('TipoOra').asstring);
  if ((WR302DM as TWA006FModelliOrarioDM).seltabella.State in [dsInsert,dsEdit]) and (Result) then
  begin
    ItemsPeriodoLav;
    dcmbPerLav.ItemIndex:=0;
    (WR302DM as TWA006FModelliOrarioDM).selTabella.FieldByName('PerLav').AsString:=(WR302DM as TWA006FModelliOrarioDM).A006MW.D_PerLav[0].Value;
  end;
end;

procedure TWA006FModelliOrarioDettFM.ItemsPeriodoLav;
{Cambia gli items di PeriodoLav a seconda di TipoOrario}
var i: Integer;
begin
  i:=(WR302DM as TWA006FModelliOrarioDM).A006MW.AggiornaItemsPerLav(dcmbPerLav.Items);
  R180SetComboItemsValues(dcmbPerLav.Items,(WR302DM as TWA006FModelliOrarioDM).A006MW.D_PerLav,'IV');
  if i > -2 then
    dcmbPerLav.ItemIndex:=i;
  grdTimbrature.medpAggiornaCDS(True);
  grdPausaMensa.medpAggiornaCDS(True);
end;

procedure TWA006FModelliOrarioDettFM.AbilitaComponenti;
var
  StatoSelTabella:Boolean;
begin
  StatoSelTabella:=(WR302DM as TWA006FModelliOrarioDM).selTabella.State in [dsEdit,dsInsert];
  with (WR302DM as TWA006FModelliOrarioDM) do
  begin
    grdTimbrature.medpAttivaGrid(A006MW.selT021PN,StatoSelTabella,StatoSelTabella);
    //grdPausaMensa.medpAttivaGrid(A006MW.selT021PM,(selTabella.State in [dsEdit,dsInsert]),(selTabella.State in [dsEdit,dsInsert]));
    grdStraordinario.medpAttivaGrid(A006MW.selT021STR,StatoSelTabella,StatoSelTabella);
    grdXParam.medpAttivaGrid(A006MW.cdsXParam,False,False,False);
    grdXParamComp.medpAttivaGrid(A006MW.cdsXParamComp,False,False,False);
  end;
  //PreparaComponenti grdTimbrature
  PreparaComponentiGrdTimbrature;
  //PreparaComponenti grdStraordinario
  grdStraordinario.medpCancellaRigaWR102;
  grdStraordinario.medpPreparaComponentiDefault;
  grdStraordinario.medpPreparaComponenteGenerico('WR102',grdStraordinario.medpIndexColonna('TIPO_FASCIA'),0,DBG_CMB,'5','','','','S');
  //PreparaComponenti grdPausaMensa
  grdPausaMensaPreparaComponenti;
  //Abilitazioni punti timbratura
  dchkFrazDebNoTurnista.Enabled:=dchkFrazDeb.Checked and StatoSelTabella;
  dchkFrazDebNoTurnista.Enabled:=(not dchkNotteEntrata.Checked) and dchkFrazDeb.Checked and StatoSelTabella;

  drgpRiposoCompensativoClick(nil);
end;

procedure TWA006FModelliOrarioDettFM.grdPausaMensaPreparaComponenti;
begin
  grdPausaMensa.medpCancellaRigaWR102;
  grdPausaMensa.medpPreparaComponentiDefault;
  grdPausaMensa.medpPreparaComponenteGenerico('WR102',grdPausaMensa.medpIndexColonna('TIPO_FASCIA'),0,DBG_CMB,'5','','','','S');
end;

function TWA006FModelliOrarioDettFM.grdPausaMensaBeforeInserisci(Sender: TObject): Boolean;
begin
  inherited;
  grdPausaMensaNascondiColonne(False,False);
  grdPausaMensaPreparaComponenti;
  Result:=True;
end;

function TWA006FModelliOrarioDettFM.grdPausaMensaBeforeModifica(Sender: TObject): Boolean;
begin
  inherited;
  grdPausaMensaPreparaComponenti;
  Result:=True;
end;

procedure TWA006FModelliOrarioDettFM.grdPausaMensaComponenti2DataSet(Row: Integer);
begin
  inherited;
  with grdPausaMensa.medpDataSet do
  begin
    FieldByName('TIPO_FASCIA').AsString:=TmeIWComboBox(grdPausaMensa.medpCompCella(Row,grdPausaMensa.medpIndexColonna('TIPO_FASCIA'),0)).Text;
    FieldByName('MMRITARDO').AsString:=IfThen(FieldByName('MMRITARDO').ReadOnly,'',FieldByName('MMRITARDO').AsString);
    FieldByName('MMANTICIPOU').AsString:=IfThen(FieldByName('MMANTICIPOU').ReadOnly,'',FieldByName('MMANTICIPOU').AsString);
    FieldByName('MMARROTOND').AsString:=IfThen(FieldByName('MMARROTOND').ReadOnly,'',FieldByName('MMARROTOND').AsString);
    FieldByName('MMARROTONDU').AsString:=IfThen(FieldByName('MMARROTONDU').ReadOnly,'',FieldByName('MMARROTONDU').AsString);
    FieldByName('OREMINIME').AsString:=IfThen(FieldByName('OREMINIME').ReadOnly,'',FieldByName('OREMINIME').AsString);
    FieldByName('MMFLEX').AsString:=IfThen(FieldByName('MMFLEX').ReadOnly,'',FieldByName('MMFLEX').AsString);
  end;
end;

procedure TWA006FModelliOrarioDettFM.grdPausaMensaConferma(Sender: TObject);
var TipoFascia: String;
    row: Integer;
begin
  inherited;
  TipoFascia:=TmeIWComboBox(grdPausaMensa.medpCompCella(grdPausaMensa.medpClientDataSet.RecNo-1,grdPausaMensa.medpIndexColonna('TIPO_FASCIA'),0)).Text;
  grdPausaMensaNascondiColonne((TipoFascia = 'PMA'),(((WR302DM as TWA006FModelliOrarioDM).SelTabella.FieldByName('PM_AUTO_URIT').AsString = 'S')));
  row:=grdPausaMensa.medpRigaDiCompGriglia((Sender as TmeIWImageFile).FriendlyName);
  grdPausaMensa.medpConferma(row);
end;

procedure TWA006FModelliOrarioDettFM.grdPausaMensaNascondiColonne(Condizione1,Condizione2: Boolean);
begin
  with (WR302DM as TWA006FModelliOrarioDM).A006MW.selT021PM do
  begin
    FieldByName('MMRITARDO').ReadOnly:=Condizione1;
    FieldByName('MMANTICIPOU').ReadOnly:=Condizione1;
    FieldByName('MMARROTOND').ReadOnly:=Condizione1;
    FieldByName('MMARROTONDU').ReadOnly:=Condizione1;
    FieldByName('OREMINIME').ReadOnly:=Condizione1 and Condizione2;
    FieldByName('MMFLEX').ReadOnly:=Condizione1;
  end;
end;

procedure TWA006FModelliOrarioDettFM.grdPausaMensaDataSet2Componenti(Row: Integer);
begin
  inherited;
  with TmeIWComboBox(grdPausaMensa.medpCompCella(Row,grdPausaMensa.medpIndexColonna('TIPO_FASCIA'),0)) do
  begin
    Items.Clear;
    RequireSelection:=True;
    R180SetComboItemsValues(Items,(WR302DM as TWA006FModelliOrarioDM).A006MW.D_TipoFasciaPausaMensa,'V');
    ItemIndex:=StrToInt(ifthen(Row>0,IntToStr(Items.IndexOf(grdPausaMensa.medpValoreColonna(Row,'TIPO_FASCIA'))),'1'));
  end;
end;

procedure TWA006FModelliOrarioDettFM.grdStraordinarioComponenti2DataSet(Row: Integer);
begin
  inherited;
  grdStraordinario.medpDataSet.FieldByName('TIPO_FASCIA').AsString:=TmeIWComboBox(grdStraordinario.medpCompCella(Row,grdStraordinario.medpIndexColonna('TIPO_FASCIA'),0)).Text;
end;

procedure TWA006FModelliOrarioDettFM.grdStraordinarioDataSet2Componenti(Row: Integer);
begin
  inherited;
  with TmeIWComboBox(grdStraordinario.medpCompCella(Row,grdStraordinario.medpIndexColonna('TIPO_FASCIA'),0)) do
  begin
    Items.Clear;
    NoSelectionText:= ' ';
    RequireSelection:=True;
    R180SetComboItemsValues(Items,(WR302DM as TWA006FModelliOrarioDM).A006MW.D_TipoFasciaStraordinario,'V');
    ItemIndex:=StrToInt(ifthen(Row>0,IntToStr(Items.IndexOf(grdStraordinario.medpValoreColonna(Row,'TIPO_FASCIA'))),'-1'));
  end;
end;

procedure TWA006FModelliOrarioDettFM.grdTimbratureDataSet2Componenti(Row: Integer);
procedure PreparaCmbIndennita(pCampo: string);
  begin
    if not Assigned(TMedpIWMultiColumnComboBox(grdTimbrature.medpCompCella(Row,pCampo,0))) then
      exit;
    with TMedpIWMultiColumnComboBox(grdTimbrature.medpCompCella(Row,pCampo,0)) do
    begin
      ColumnSeparator:=';';
      ColCount:=2;
      Items.Clear;
      AddRow('O;da orario');
      AddRow('N;non maturata');
      Text:=grdTimbrature.medpValoreColonna(Row,pCampo);
      if Text = '' then
        ItemIndex:=0;
    end;
  end;
begin
  inherited;
  (grdTimbrature.medpCompCella(Row,grdTimbrature.medpIndexColonna('TIPO_FASCIA'),0) as TmeIWLabel).Caption:=grdTimbrature.medpDataSet.FieldByName('TIPO_FASCIA').AsString;
  if (grdTimbrature.medpCompCella(Row,grdTimbrature.medpIndexColonna('ROWNUM'),0) as TmeIWLabel) <> nil then
    (grdTimbrature.medpCompCella(Row,grdTimbrature.medpIndexColonna('ROWNUM'),0) as TmeIWLabel).Caption:=grdTimbrature.medpDataSet.FieldByName('ROWNUM').AsString;

  PreparaCmbIndennita('INDTURNO');
  PreparaCmbIndennita('INDFESTIVA');

  // forza css specifico
  grdTimbrature.medpCompCella(Row,'VALENZA_GGASS',0).Css:='input_num_nddddd_neg width6chr';
end;

procedure TWA006FModelliOrarioDettFM.gridRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  LNumColonna: Integer;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  LNumColonna:=TmedpIWDBGrid(ACell.Grid).medpNumColonna(AColumn);

  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(TmedpIWDBGrid(ACell.Grid).medpCompGriglia) + 1) and (TmedpIWDBGrid(ACell.Grid).medpCompGriglia[ARow - 1].CompColonne[LNumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=TmedpIWDBGrid(ACell.Grid).medpCompGriglia[ARow - 1].CompColonne[LNumColonna];
  end;
end;

procedure TWA006FModelliOrarioDettFM.dchkRicalcoloDebitoGGAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  lblRicalcoloMin.Enabled:=dchkRicalcoloDebitoGG.Checked;
  dedtRicalcoloMin.Enabled:=dchkRicalcoloDebitoGG.Checked;
  lblRicalcoloMax.Enabled:=dchkRicalcoloDebitoGG.Checked;
  dedtRicalcoloMax.Enabled:=dchkRicalcoloDebitoGG.Checked;
  lblRicalcoloDebMin.Enabled:=dchkRicalcoloDebitoGG.Checked;
  dedtRicalcoloDebMin.Enabled:=dchkRicalcoloDebitoGG.Checked;
  lblRicalcoloDebMax.Enabled:=dchkRicalcoloDebitoGG.Checked;
  dedtRicalcoloDebMax.Enabled:=dchkRicalcoloDebitoGG.Checked;
  dchkRicalcoloSpostaPN.Enabled:=dchkRicalcoloDebitoGG.Checked;
  dchkRicalcoloOffNoTimb.Enabled:=dchkRicalcoloDebitoGG.Checked;
  lblRicalcoloCausNeg.Enabled:=dchkRicalcoloDebitoGG.Checked;
  dlckRicalcoloCausNeg.Enabled:=dchkRicalcoloDebitoGG.Checked;
  lblRicalcoloCausPos.Enabled:=dchkRicalcoloDebitoGG.Checked;
  dlckRicalcoloCausPos.Enabled:=dchkRicalcoloDebitoGG.Checked;
end;

procedure TWA006FModelliOrarioDettFM.dchkSoloCompAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  drgpEComp1.Visible:=not dchkSoloComp.Checked;
  drgpEComp2.Visible:=dchkSoloComp.Checked;
  with (WR302DM as TWA006FModelliOrarioDM).SelTabella do
    if dchkSoloComp.Checked and (State in [dsEdit,dsInsert]) then
      if (FieldByName(drgpEComp2.DataField).AsString <> 'N') and (FieldByName(drgpEComp2.DataField).AsString <> 'P') then
        FieldByName(drgpEComp2.DataField).AsString:='N';
end;

procedure TWA006FModelliOrarioDettFM.dchkFlagMPresAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  if (not dchkFlagMPres.Checked) and ((WR302DM as TWA006FModelliOrarioDM).SelTabella.State in [dsInsert,dsEdit]) then
    (WR302DM as TWA006FModelliOrarioDM).SelTabella.FieldByName(dedtMMIndMPres.DataField).Clear;
  dedtMMIndMPres.Enabled:=dchkFlagMPres.Checked;
end;

procedure TWA006FModelliOrarioDettFM.dchkFrazDebAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  (WR302DM as TWA006FModelliOrarioDM).A006MW.selT021PNORETEOTUR2.Visible:=((WR302DM as TWA006FModelliOrarioDM).A006MW.FTipoOrario in [toE]) and ((WR302DM as TWA006FModelliOrarioDM).A006MW.FPeriodoLav in [plT1]) and (dchkFrazDeb.Checked);
  dchkFrazDebNoTurnista.Enabled:=dchkFrazDeb.Checked;
  dchkNotteEntrata.Enabled:=not dchkFrazDeb.Checked;
  if (not dchkNotteEntrata.Enabled) and ((WR302DM as TWA006FModelliOrarioDM).SelTabella.State in [dsInsert,dsEdit]) then
    (WR302DM as TWA006FModelliOrarioDM).SelTabella.FieldByName(dchkNotteEntrata.DataField).AsString:='N';
end;

procedure TWA006FModelliOrarioDettFM.dchkNotteEntrataAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  dchkFrazDeb.Enabled:=not(dchkNotteEntrata.Checked);
  dchkFrazDebNoTurnista.Enabled:=not(dchkNotteEntrata.Checked) and dchkFrazDeb.Checked;
  dchkFlexDopoMezanotte.Enabled:=dchkNotteEntrata.Checked;
  dchkStrNotteSpezzato.Enabled:=dchkNotteEntrata.Checked;
  if (not dchkFrazDeb.Enabled) and ((WR302DM as TWA006FModelliOrarioDM).SelTabella.State in [dsInsert,dsEdit]) then
    (WR302DM as TWA006FModelliOrarioDM).SelTabella.FieldByName(dchkFrazDeb.DataField).AsString:='N';
end;

procedure TWA006FModelliOrarioDettFM.dchkPMAutoURitAsyncClick(Sender: TObject; EventParams: TStringList);
var TipoMensa: String;
begin
  TipoMensa:=(WR302DM as TWA006FModelliOrarioDM).SelTabella.FieldByName('TipoMensa').AsString;
  //Disabilito il parametro "Ore continuative" se "Forzata se uscita dopo ore max"
  if (dchkPMAutoURit.Checked) and ((WR302DM as TWA006FModelliOrarioDM).SelTabella.State in [dsEdit,dsInsert])then
    (WR302DM as TWA006FModelliOrarioDM).A006MW.selT020.FieldByName('DETRAUTCONT').AsString:='N';
  dchkDetrAutCont.Enabled:=not dchkPMAutoURit.Checked;
  dchkPMTUscitaRit.Enabled:=dchkPMAutoURit.Checked;
  //Commento già presente prima di MW
  //A006FModelliOrarioDtM1.selT021PM.FieldByName('OREMINIME').Required:=not dchkPMAutoURit.Checked;
  if (dchkPMAutoURit.Checked) and ((WR302DM as TWA006FModelliOrarioDM).SelTabella.State in [dsEdit,dsInsert]) and ((WR302DM as TWA006FModelliOrarioDM).A006MW.selT021PM.State = dsBrowse) then
    (WR302DM as TWA006FModelliOrarioDM).A006MW.PulisciTipoFasciaPMA;
  lblRientroMinimo.Enabled:=(not dchkPMAutoURit.Checked) and (TipoMensa = 'F');
  dedtRientroMinimo.Enabled:=(not dchkPMAutoURit.Checked) and (TipoMensa = 'F');
end;

procedure TWA006FModelliOrarioDettFM.dchkTimbraturaMensaAsyncClick(Sender: TObject; EventParams: TStringList);
var TipoMensa: String;
begin
  inherited;
  TipoMensa:=(WR302DM as TWA006FModelliOrarioDM).SelTabella.FieldByName('TipoMensa').AsString;
  dchkTimbraturaMensaDetrTot.Enabled:=dchkTimbraturaMensa.Checked and ((TipoMensa = 'E') or (TipoMensa = 'F'));
  dchkTimbraturaMensaFlex.Enabled:=dchkTimbraturaMensa.Checked and (TipoMensa = 'C');
  (* Commento già presente prima dell'inserimento del MW
  drgpTimbraturaMensaInterna.Enabled:=dchkTimbraturaMensa.Checked or dchkPmtSoloTimbMensa.Checked;
  dedtTimbraturaMensaDetrazione.Enabled:=dchkTimbraturaMensa.Checked or dchkPmtSoloTimbMensa.Checked;
  lblTimbraturaMensaDetrazione.Enabled:=dchkTimbraturaMensa.Checked or dchkPmtSoloTimbMensa.Checked;
  dchkTimbraturaMensaDetParziale.Enabled:=dchkTimbraturaMensa.Checked or dchkPmtSoloTimbMensa.Checked;
  if (DButton.State in [dsEdit,dsInsert]) and not(dchkTimbraturaMensa.Checked or dchkPmtSoloTimbMensa.Checked) then
    drgpTimbraturaMensaInterna.Field.AsString:='N';
  *)
end;

procedure TWA006FModelliOrarioDettFM.dcmbPerLavChange(Sender: TObject);
{Cambio di periodo lavorativo}
begin
  if (WR302DM as TWA006FModelliOrarioDM).A006MW.SettaPeriodoLav((WR302DM as TWA006FModelliOrarioDM).SelTabella.FieldByName('PerLav').AsString) then
  begin
    VisualizzaDatiSelT021;
    VisualizzaPaginaOpzioni;
  end;
end;

procedure TWA006FModelliOrarioDettFM.dcmbTipoMensaChange(Sender: TObject);
{Visualizza dati mensa a seconda del tipo}
var i:Integer;
    Condiz: Boolean;
    TipoMensa: String;
begin
  TipoMensa:=(WR302DM as TWA006FModelliOrarioDM).SelTabella.FieldByName('TipoMensa').AsString;
  AbilitaGrpPausaMensaTimbrata(TipoMensa <> 'Z');
  AbilitaGrpMensaAutomatica(TipoMensa <> 'Z');
  AbilitaGrpTimbraturaMensa(TipoMensa <> 'Z');
  AbilitaGrpPMIntermedia(TipoMensa <> 'Z');
  dedtMMMinimi.Enabled:=TipoMensa <> 'Z';
  lblMMMinimi.Enabled:=TipoMensa <> 'Z';
  lblMinPercorr.Enabled:=TipoMensa <> 'Z';
  dedtMinPercorr.Enabled:=TipoMensa <> 'Z';
  lblPMTTolleranza.Enabled:=TipoMensa <> 'Z';
  dedtPMTTolleranza.Enabled:=TipoMensa <> 'Z';
  //Massimo: per disabilitare la griglia è necessario rifare attivaGrid
  //grdPausamensa.Enabled:=dcmbTipoMensa.Text <> 'Z';
  Condiz:=(TipoMensa <> 'Z') and ((WR302DM as TWA006FModelliOrarioDM).SelTabella.State in [dsInsert,dsEdit]);
  grdPausaMensa.medpAttivaGrid((WR302DM as TWA006FModelliOrarioDM).A006MW.selT021PM,Condiz,Condiz);
  grdPausaMensaPreparaComponenti;
  if TipoMensa = 'Z' then
    exit;
  (WR302DM as TWA006FModelliOrarioDM).A006MW.selT021PM.FieldByName('MMFlex').Visible:=R180In(TipoMensa,['B','D','E','F']);
  dchkPMTLimiteFlex.Enabled:=R180In(TipoMensa,['B','D','E','F']);
  //Gestito in AbilitaGrpMensaAutomatica
  //for i:=0 to grpMensaAutomatica.ControlCount - 1 do
    //grpMensaAutomatica.Controls[i].Enabled:=dcmbTipoMensa.Text > 'B';
  AbilitaGrpMensaAutomatica(R180In(TipoMensa,['C','D','E','F']));
  lblPMRecupUscita.Enabled:=R180In(TipoMensa,['D','E','F']);
  dedtPMRecupUscita.Enabled:=R180In(TipoMensa,['D','E','F']);
  dedtRientroMinimo.Enabled:=dedtRientroMinimo.Enabled and (TipoMensa = 'F');
  lblRientroMinimo.Enabled:=dedtRientroMinimo.Enabled and (TipoMensa = 'F');
  dchkPMAutoURit.Enabled:=dchkPMAutoURit.Enabled and (TipoMensa <> 'F');
  dchkPMTUscitaRit.Enabled:=dchkPMAutoURit.Enabled and dchkPMAutoURit.Checked;
  dchkPMAPreservaTimbInFascia.Enabled:=R180In(TipoMensa,['E','F']);
  if (TipoMensa = 'F') and ((WR302DM as TWA006FModelliOrarioDM).SelTabella.State in [dsEdit,dsInsert]) then
  begin
    (WR302DM as TWA006FModelliOrarioDM).SelTabella.FieldByName(dchkPMAutoURit.DataField).AsString:='N';
    (WR302DM as TWA006FModelliOrarioDM).SelTabella.FieldByName(dchkPMTUscitaRit.DataField).AsString
  end;
  dchkDetrazParzStaccoInf.Enabled:=R180In(TipoMensa,['E','F']) and (R180OreMinuti(dedtPMOreMinimeInf.Text) > 0) and (R180OreMinuti(dedtPMStaccoInf.Text) > 0);
  //Timbratura Mensa
  dchkTimbraturaMensaDetrTot.Enabled:=dchkTimbraturaMensa.Checked and R180In(TipoMensa,['E','F']);
  dchkTimbraturaMensaFlex.Enabled:=dchkTimbraturaMensa.Checked and (TipoMensa = 'C');
end;

procedure TWA006FModelliOrarioDettFM.PreparaComponentiGrdTimbrature;
begin
  grdTimbrature.medpCancellaRigaWR102;
  grdTimbrature.medpPreparaComponentiDefault;
  grdTimbrature.medpPreparaComponenteGenerico('WR102',grdTimbrature.medpIndexColonna('TIPO_FASCIA'),0,DBG_LBL,'10','','null','','S');
  grdTimbrature.medpPreparaComponenteGenerico('WR102',grdTimbrature.medpIndexColonna('ROWNUM'),0,DBG_LBL,'10','','null','','S');
  grdTimbrature.medpPreparaComponenteGenerico('WR102',grdTimbrature.medpIndexColonna('INDTURNO'),0,DBG_MECMB,'1','1','null','','S');
  grdTimbrature.medpPreparaComponenteGenerico('WR102',grdTimbrature.medpIndexColonna('INDFESTIVA'),0,DBG_MECMB,'1','1','null','','S');
end;

procedure TWA006FModelliOrarioDettFM.PulisciValore(Sender: TObject);
begin
  if not((WR302DM as TWA006FModelliOrarioDM).SelTabella.State in [dsInsert,dsEdit]) then exit;
  if (Sender as TIWDBEdit).Text = '  .  ' then
    (WR302DM as TWA006FModelliOrarioDM).SelTabella.FieldByName((Sender as TIWDBEdit).DataField).Clear;
  if Sender = dedtMMIndPres then
    begin
    drgpFlagPres.Enabled:=dedtMMIndPres.Text = '  .  ';
    if (dedtMMIndPres.Text <> '  .  ') and (not (WR302DM as TWA006FModelliOrarioDM).SelTabella.FieldByName(drgpFlagPres.DataField).IsNull) then
      (WR302DM as TWA006FModelliOrarioDM).SelTabella.FieldByName(drgpFlagPres.DataField).AsString:=' ';
    if dedtMMIndPres.Text = '  .  ' then
      (WR302DM as TWA006FModelliOrarioDM).SelTabella.FieldByName(drgpFlagPres.DataField).AsString:='N';
    end;
end;

procedure TWA006FModelliOrarioDettFM.btnAnomalieBloccantiClick(Sender: TObject);
var
  LstCodiciValue, LstCodiciDesc, LstAnomalieSel: TStringList;
  i: integer;
begin
  inherited;
  LstCodiciValue:=TStringList.Create;
  LstCodiciDesc:=TStringList.Create;

  for i:=low(tdescanom2) to High(tdescanom2) do
  begin
    LstCodiciValue.Add('2_' + IntToStr(tdescanom2[i].N));
    LstCodiciDesc.Add(R180DimLung('2_' + IntToStr(tdescanom2[i].N),6) + ' ' + tdescanom2[i].D);
  end;
  for i:=low(tdescanom3) to High(tdescanom3) do
  begin
    LstCodiciValue.Add('3_' + IntToStr(tdescanom3[i].N));
    LstCodiciDesc.Add(R180DimLung('3_' + IntToStr(tdescanom3[i].N),6) + ' ' + tdescanom3[i].D);
  end;
  LstAnomalieSel:=TStringList.Create;
  LstAnomalieSel.CommaText:=dedtAnomalieBloccanti.Text;

  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  with WC013 do
  begin
    CaricaLista(LstCodiciDesc, LstCodiciValue);
    ImpostaValoriSelezionati(LstAnomalieSel);
    ResultEvent:=ckCausaliResult;
    Visualizza(0,0,'<WC013> Filtro Dati');
  end;
  FreeAndNil(LstCodiciDesc);
  FreeAndNil(LstCodiciValue);
  FreeAndNil(LstAnomalieSel);
end;

procedure TWA006FModelliOrarioDettFM.btnCausaliEccedenzaClick(Sender: TObject);
var LstCodiciValue, LstCodiciDesc, LstCausaliSelezionate : TStringList;
begin
  inherited;
  LstCodiciValue:=TStringList.Create;
  LstCodiciDesc:=TStringList.Create;
  LstCausaliSelezionate:=TStringList.Create;
  if (Sender as TmeIWButton) = btnOrariScambio then
    LstCausaliSelezionate.CommaText:=dedtOrariScambio.Text
  else if (Sender as TmeIWButton) = btnCausaliEccedenza then
    LstCausaliSelezionate.CommaText:=dedtCausaliEccedenza.Text
  else if (Sender as TmeIWButton) = btnCausRiduzPN then
    LstCausaliSelezionate.CommaText:=dedtCausRiduzPN.Text
  else if (Sender as TmeIWButton) = btnCausRiduzPNCheckPMT then
    LstCausaliSelezionate.CommaText:=dedtCausRiduzPNCheckPMT.Text;
  with (WR302DM as TWA006FModelliOrarioDM).A006MW do
  begin
    if (Sender as TmeIWButton) = btnOrariScambio then
    begin
      selaT020.Close;
      selaT020.SetVariable('DATA',(WR302DM as TWA006FModelliOrarioDM).selTabella.FieldByName('DECORRENZA').AsDateTime);
      selaT020.Open;
      while not selaT020.Eof do
      begin
        LstCodiciValue.Add(selaT020.FieldByName('CODICE').AsString);
        LstCodiciDesc.Add(selaT020.FieldByName('CODICE').AsString + ' ' + selaT020.FieldByName('DESCRIZIONE').AsString);
        selaT020.Next;
      end;
    end
    else
    begin
      selT275.Close;
      selT275.Open;
      while not selT275.Eof do
      begin
        LstCodiciValue.Add(selT275.FieldByName('CODICE').AsString);
        LstCodiciDesc.Add(selT275.FieldByName('CODICE').AsString + ' ' + selT275.FieldByName('DESCRIZIONE').AsString);
        selT275.Next;
      end;
    end;
  end;
  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  with WC013 do
  begin
    CaricaLista(LstCodiciDesc, LstCodiciValue);
    ImpostaValoriSelezionati(LstCausaliSelezionate);
    if (Sender as TmeIWButton) = btnOrariScambio then
      ResultEvent:=ckOrariScambioResult
    else if (Sender as TmeIWButton) = btnCausaliEccedenza then
      ResultEvent:=ckCodiciResult
    else if (Sender as TmeIWButton) = btnCausRiduzPN then
      ResultEvent:=ckCodiciCausRiduzPNResult
    else if (Sender as TmeIWButton) = btnCausRiduzPNCheckPMT then
      ResultEvent:=ckCodiciCausRiduzPNCheckPMTResult;
    Visualizza(0,0,'<WC013> Filtro Dati');
  end;
  FreeAndNil(LstCodiciDesc);
  FreeAndNil(LstCodiciValue);
  FreeAndNil(LstCausaliSelezionate);
end;

procedure TWA006FModelliOrarioDettFM.ckCodiciResult(Sender: TObject; Result: Boolean);
begin
  AssegnaCodiciSelezionati('CAUSALI_ECCEDENZA',Result);
end;

procedure TWA006FModelliOrarioDettFM.ckCodiciCausRiduzPNResult(Sender: TObject; Result: Boolean);
begin
  AssegnaCodiciSelezionati('CAUS_RIDUZPN',Result);
end;

procedure TWA006FModelliOrarioDettFM.ckCausaliResult(Sender: TObject; Result: Boolean);
begin
  AssegnaCodiciSelezionati('ANOM_BLOCC_23LIV',Result);
end;

procedure TWA006FModelliOrarioDettFM.ckCodiciCausRiduzPNCheckPMTResult(Sender: TObject; Result: Boolean);
begin
  AssegnaCodiciSelezionati('CAUS_RIDUZPN_CHECKPMT',Result);
end;

procedure TWA006FModelliOrarioDettFM.ckOrariScambioResult(Sender: TObject; Result: Boolean);
begin
  AssegnaCodiciSelezionati('ORARI_SCAMBIO',Result);
end;

procedure TWA006FModelliOrarioDettFM.AssegnaCodiciSelezionati(Campo:String;Result:Boolean);
var lstTmp: TStringList;
begin
  if Result then
    if (WR302DM as TWA006FModelliOrarioDM).SelTabella.State in [dsEdit,dsInsert] then
    begin
      lstTmp:=WC013.LeggiValoriSelezionati;
      (WR302DM as TWA006FModelliOrarioDM).SelTabella.FieldByName(Campo).AsString:=lstTmp.CommaText;
      FreeAndNil(lstTmp);
    end;
end;

procedure TWA006FModelliOrarioDettFM.CaricaMultiColumnComboBox;
begin
  inherited;
  with (WR302DM as TWA006FModelliOrarioDM).A006MW.selT275 do
  begin
    First;
    while not Eof do
    begin
      cmbFestLavLiq.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      cmbFestLavCmpLiq.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      cmbFestLavCmpLiqTurn.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      cmbCausaleInizioOrario.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      cmbCausaleFineOrario.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
  with (WR302DM as TWA006FModelliOrarioDM).A006MW.selT276 do
  begin
    First;
    while not Eof do
    begin
      cmbDistrOreOrdFasce.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
end;

procedure TWA006FModelliOrarioDettFM.cmbCausaleFineOrarioAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  (WR302DM as TWA006FModelliOrarioDM).SelTabella.FieldByName('CAUSALE_FINEORARIO').AsString:=cmbCausaleFineOrario.Text;
end;

procedure TWA006FModelliOrarioDettFM.cmbCausaleInizioOrarioAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  (WR302DM as TWA006FModelliOrarioDM).SelTabella.FieldByName('CAUSALE_INIZIOORARIO').AsString:=cmbCausaleInizioOrario.Text;
end;

procedure TWA006FModelliOrarioDettFM.cmbDistrOreOrdFasceAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  (WR302DM as TWA006FModelliOrarioDM).SelTabella.FieldByName('CAUSALE_FASCE').AsString:=cmbDistrOreOrdFasce.Text;
end;

procedure TWA006FModelliOrarioDettFM.cmbFestLavCmpLiqAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  (WR302DM as TWA006FModelliOrarioDM).SelTabella.FieldByName('FESTLAV_CMP_LIQ').AsString:=cmbFestLavCmpLiq.Text;
end;

procedure TWA006FModelliOrarioDettFM.cmbFestLavCmpLiqTurnAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
 (WR302DM as TWA006FModelliOrarioDM).SelTabella.FieldByName('FESTLAV_CMP_LIQ_TURN').AsString:=cmbFestLavCmpLiqTurn.Text;
end;

procedure TWA006FModelliOrarioDettFM.cmbFestLavLiqAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  (WR302DM as TWA006FModelliOrarioDM).SelTabella.FieldByName('FESTLAV_LIQ').AsString:=cmbFestLavLiq.Text;
end;

procedure TWA006FModelliOrarioDettFM.AbilitaGrpPMIntermedia(Abilitato: Boolean);
begin
  lblPMStaccoInf.Enabled:=Abilitato;
  dedtPMStaccoInf.Enabled:=Abilitato;
  lblPMOreMinimeInf.Enabled:=Abilitato;
  dedtPMOreMinimeInf.Enabled:=Abilitato;
end;

procedure TWA006FModelliOrarioDettFM.AbilitaGrpTimbraturaMensa(Abilitato: Boolean);
begin
  drgpTimbraturaMensaInterna.Enabled:=Abilitato;
  lblTimbraturaMensaInterna.Enabled:=Abilitato;
  dchkPmtSoloTimbMensa.Enabled:=Abilitato;
  dchkTimbraturaMensa.Enabled:=Abilitato;
  dchkTimbraturaMensaDetrTot.Enabled:=Abilitato;
  dchkTimbraturaMensaFlex.Enabled:=Abilitato;
  lblTimbraturaMensaDetrazione.Enabled:=Abilitato;
  dedtTimbraturaMensaDetrazione.Enabled:=Abilitato;
  lblPausaMensaAutomatica.Enabled:=Abilitato;
  lblRientroMinimo.Enabled:=Abilitato;
end;

procedure TWA006FModelliOrarioDettFM.AbilitaGrpPausaMensaTimbrata(Abilitato: Boolean);
begin
  dchkCausaleObbl.Enabled:=Abilitato;
  dchkTimbratureUE.Enabled:=Abilitato;
  dchkPMTTIMBAUTORIZZATE.Enabled:=Abilitato;
  dchkPMTTimbMaturaMensa.Enabled:=Abilitato;
  dchkPMTLimiteFlex.Enabled:=Abilitato;
  dchkPMTUscitaRit.Enabled:=Abilitato;
  dedtTollFuoriOrario.Enabled:=Abilitato;
  dedtPMTStaccoMin.Enabled:=Abilitato;
  dedtPMRecupUscita.Enabled:=Abilitato;
  lblTollFuoriOrario.Enabled:=Abilitato;
  lblPMTStaccoMin.Enabled:=Abilitato;
  lblPMRecupUscita.Enabled:=Abilitato;
end;

procedure TWA006FModelliOrarioDettFM.AbilitaGrpMensaAutomatica(Abilitato: Boolean);
begin
  dchkPMAutoURit.Enabled:=Abilitato;
  dchkDetrAutCont.Enabled:=Abilitato;
  dchkPMAPreservaTimbInFascia.Enabled:=Abilitato;
  dchkDetrazParzStaccoInf.Enabled:=Abilitato;
  dedetPausaMensaAutomatica.Enabled:=Abilitato;
  dedtRientroMinimo.Enabled:=Abilitato;
end;

procedure TWA006FModelliOrarioDettFM.ModificaXParam(AbilitaEdit: Boolean);
var
  i:Integer;
begin
  TXParamClientDataSet((WR302DM as TWA006FModelliOrarioDM).A006MW.cdsXParam).SolaLettura(not(AbilitaEdit));
  if AbilitaEdit then
  begin
    grdXParam.medpBrowse:=False;
    for i:=0 to High(grdXParam.medpCompGriglia) do
    begin
      grdXParam.medpPreparaComponenteGenerico('C',0,0,DBG_LBL,'0','','','');
      grdXParam.medpCreaComponenteGenerico(i,0,grdXParam.Componenti);
      with TmeIWLabel(grdXParam.medpCompCella(i,0,0)) do
      begin
        Text:=grdXParam.medpValoreColonna(i,'NOME');
      end;
      grdXParam.medpPreparaComponenteGenerico('C',0,0,DBG_CMB,'1','','','');
      grdXParam.medpCreaComponenteGenerico(i,1,grdXParam.Componenti);
      with TmeIWComboBox(grdXParam.medpCompCella(i,1,0)) do
      begin
        Items.Clear;
        Items.Add('S');
        Items.Add('N');
        ItemIndex:=Items.IndexOf(grdXParam.medpValoreColonna(i,'VALORE'));
        OnAsyncChange:=CmbXParamAsyncChange;
      end;
    end;
  end
  else
  begin
    grdXParam.medpBrowse:=True;
    for i:=0 to High(grdXParam.medpCompGriglia) do
    begin
      FreeAndNil(grdXParam.medpCompgriglia[i].CompColonne[0]);
      FreeAndNil(grdXParam.medpCompgriglia[i].CompColonne[1]);
    end;
    grdXParam.medpAggiornaCDS(True);
  end;
end;

procedure TWA006FModelliOrarioDettFM.ModificaXParamComp(AbilitaEdit: Boolean);
var
  i:Integer;
begin
  TXParamClientDataSet((WR302DM as TWA006FModelliOrarioDM).A006MW.cdsXParamComp).SolaLettura(not(AbilitaEdit));
  if AbilitaEdit then
  begin
    grdXParamComp.medpBrowse:=False;
    for i:=0 to High(grdXParamComp.medpCompGriglia) do
    begin
      grdXParamComp.medpPreparaComponenteGenerico('C',0,0,DBG_LBL,'0','','','');
      grdXParamComp.medpCreaComponenteGenerico(i,0,grdXParamComp.Componenti);
      with TmeIWLabel(grdXParamComp.medpCompCella(i,0,0)) do
      begin
        Text:=grdXParamComp.medpValoreColonna(i,'NOME');
      end;
      grdXParamComp.medpPreparaComponenteGenerico('C',0,0,DBG_CMB,'1','','','');
      grdXParamComp.medpCreaComponenteGenerico(i,1,grdXParamComp.Componenti);
      with TmeIWComboBox(grdXParamComp.medpCompCella(i,1,0)) do
      begin
        Items.Clear;
        Items.Add('S');
        Items.Add('N');
        ItemIndex:=Items.IndexOf(grdXParamComp.medpValoreColonna(i,'VALORE'));
        OnAsyncChange:=CmbXParamCompAsyncChange;
      end;
    end;
  end
  else
  begin
    grdXParamComp.medpBrowse:=True;
    for i:=0 to High(grdXParamComp.medpCompGriglia) do
    begin
      FreeAndNil(grdXParamComp.medpCompgriglia[i].CompColonne[0]);
      FreeAndNil(grdXParamComp.medpCompgriglia[i].CompColonne[1]);
    end;
    grdXParamComp.medpAggiornaCDS(True);
  end;
end;

procedure TWA006FModelliOrarioDettFM.CmbXParamAsyncChange(Sender: TObject; EventParams: TStringList);
var
  i:Integer;
  str: String;
begin
  str:='';
  for i:=0 to High(grdXParam.medpCompGriglia) do
  begin
    if TmeIWComboBox(grdXParam.medpCompCella(i,1,0)).ItemIndex = TmeIWComboBox(grdXParam.medpCompCella(i,1,0)).Items.IndexOf('S') then
    begin
      str:=str + TmeIWLabel(grdXParam.medpCompCella(i,0,0)).Text;
    end;
  end;
  with (WR302DM as TWA006FModelliOrarioDM) do
  begin
    A006MW.cdsXParam.ImpostaParametri(XParamList, str);
  end;
end;

procedure TWA006FModelliOrarioDettFM.CmbXParamCompAsyncChange(Sender: TObject; EventParams: TStringList);
var
  i:Integer;
  str: String;
begin
  str:='';
  for i:=0 to High(grdXParamComp.medpCompGriglia) do
  begin
    if TmeIWComboBox(grdXParamComp.medpCompCella(i,1,0)).ItemIndex = TmeIWComboBox(grdXParamComp.medpCompCella(i,1,0)).Items.IndexOf('S') then
    begin
      str:=str + TmeIWLabel(grdXParamComp.medpCompCella(i,0,0)).Text;
    end;
  end;
  with (WR302DM as TWA006FModelliOrarioDM) do
  begin
    A006MW.cdsXParamComp.ImpostaParametri(XParamCompList, str);
  end;
end;

end.
