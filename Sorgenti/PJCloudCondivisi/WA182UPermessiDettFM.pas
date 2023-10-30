unit WA182UPermessiDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWDBExtCtrls, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWDBRadioGroup, IWCompListbox, meIWDBLookupComboBox,
  meIWDBComboBox, meIWDBLabel,
  meIWLabel, IWCompCheckbox, meIWDBCheckBox, A000UInterfaccia, Menus,
  meIWCheckBox, C180FunzioniGenerali,
  C190FunzioniGeneraliWeb, IWCompButton, meIWButton,
  IWDBGrids, medpIWDBGrid, DB, DBClient, StdCtrls, WC011UListboxFM,
  WC013UCheckListFM, IWCompExtCtrls, IWCompJQueryWidget;

type
  TWA182FPermessiDettFM = class(TWR205FDettTabellaFM)
    lblPermesso: TmeIWLabel;
    dedtPermesso: TmeIWDBEdit;
    lblAzienda: TmeIWLabel;
    lblAnagrafico: TmeIWLabel;
    lblSchedaAnagr: TmeIWLabel;
    dcmbSchedaAnagr: TmeIWDBLookupComboBox;
    dchkInserimentoMatricole: TmeIWDBCheckBox;
    dchkStoricizzazione: TmeIWDBCheckBox;
    dchkEliminaStorici: TmeIWDBCheckBox;
    dchkModificaPersonaleEsterno: TmeIWDBCheckBox;
    lblDefaultTipoPersonale: TmeIWLabel;
    drgpDefaultTipoPersonale: TmeIWDBRadioGroup;
    lblTimbrature: TmeIWLabel;
    dchkInserisciTimbrature: TmeIWDBCheckBox;
    dchkCancellaTimbrature: TmeIWDBCheckBox;
    dchkRipristinoTimbratureOriginali: TmeIWDBCheckBox;
    dchkModificaOra: TmeIWDBCheckBox;
    dchkModificaRilevatore: TmeIWDBCheckBox;
    dchkModificaCausale: TmeIWDBCheckBox;
    lblSchedaRiepilogativa: TmeIWLabel;
    dchkSaldi: TmeIWDBCheckBox;
    dchkIndennita: TmeIWDBCheckBox;
    dchkStraordinario: TmeIWDBCheckBox;
    dchkRiepilogoPresenze: TmeIWDBCheckBox;
    dchkLiquidazioneOreNonDisponibili: TmeIWDBCheckBox;
    lblVariazioneLimiti: TmeIWLabel;
    dchkLimitiMensili: TmeIWDBCheckBox;
    dchkLimitiAnnuali: TmeIWDBCheckBox;
    dchkLimitiRaggruppamento: TmeIWDBCheckBox;
    lblDatiAnagraficiIntestazione: TmeIWLabel;
    dedtDatiAnagraficiIntestazione: TmeIWDBEdit;
    dchkUtilityAggiornamento: TmeIWDBCheckBox;
    dchkEludiBlocchiRiepiloghi: TmeIWDBCheckBox;
    dchkRicreazioneFilePaghe: TmeIWDBCheckBox;
    dchkEliminaVoci: TmeIWDBCheckBox;
    dchkModificaDatiProtetti: TmeIWDBCheckBox;
    dcmbAzienda: TmeIWDBLookupComboBox;
    btnDatiAnagraficiIntestazione: TmeIWButton;
    lblPianificazioneOrariOperativa: TmeIWLabel;
    drgpPianificazioneOrariOperativa: TmeIWDBRadioGroup;
    drgpPianificazioneOrariNonOperativa: TmeIWDBRadioGroup;
    lblPianificazioneOrariNonOperativa: TmeIWLabel;
    lblPianificazioneServizi: TmeIWLabel;
    dchkSbloccoServizi: TmeIWDBCheckBox;
    dchkBloccoServizi: TmeIWDBCheckBox;
    lblTipiTurnoAccessibili: TmeIWLabel;
    dcmbTipiTurnoAccessibili: TmeIWDBComboBox;
    dchkValidazioneAssenze: TmeIWDBCheckBox;
    dchkSupervisoreValutazioni: TmeIWDBCheckBox;
    lblGestioneTrasferteAnticipi: TmeIWLabel;
    btnGestioneTrasferteAnticipi: TmeIWButton;
    dedtGestioneTrasferteAnticipi: TmeIWDBEdit;
    lblIrisWebStampaCartellino: TmeIWLabel;
    lblDisponibileMeseCartellino: TmeIWLabel;
    dedtDisponibileMeseCartellino: TmeIWDBEdit;
    lblMesiIndietroCartellino: TmeIWLabel;
    dedtMesiIndietroCartellino: TmeIWDBEdit;
    lblMesiSuccessiviCartellino: TmeIWLabel;
    dedtMesiSuccessiviCartellino: TmeIWDBEdit;
    dchkSoloCartelliniRegistrati: TmeIWDBCheckBox;
    lblIrisWebStampaCedolino: TmeIWLabel;
    lblDisponibileMeseCedolino: TmeIWLabel;
    dedtDisponibileMeseCedolino: TmeIWDBEdit;
    lblMesiIndietroCedolino: TmeIWLabel;
    dedtMesiIndietroCedolino: TmeIWDBEdit;
    lblGiorniDopoDataEmissione: TmeIWLabel;
    dedtGiorniDopoDataEmissione: TmeIWDBEdit;
    chkCancTimbOrig: TmeIWDBCheckBox;
    dchkRiassegnazioneValutazioni: TmeIWDBCheckBox;
    lblStatiAvanzamentoVal: TmeIWLabel;
    btnStatiAvanzamentoVal: TmeIWButton;
    dedtStatiAvanzamentoVal: TmeIWDBEdit;
    dchkValidaStato: TmeIWDBCheckBox;
    dchkWebRichiestaConsegnaCed: TmeIWDBCheckBox;
    dchkWebCedoliniFilePDF: TmeIWDBCheckBox;
    lblIrisWebValutazioni: TmeIWLabel;
    lblWebRegistraConsegnaVal: TmeIWLabel;
    drgpWebRegistraConsegnaVal: TmeIWDBRadioGroup;
    lblRegistrazioneSelAnagr: TmeIWLabel;
    drgpRegistrazioneSelAnagr: TmeIWDBRadioGroup;
    dchkPasswordDipendenti: TmeIWDBCheckBox;
    dchkPasswordOperatori: TmeIWDBCheckBox;
    dchkModificaDecorrenza: TmeIWDBCheckBox;
    lblAnag: TmeIWLabel;
    lblAnagP430: TmeIWLabel;
    dchkInserimentoMatricoleP430: TmeIWDBCheckBox;
    dchkStoricizzazioneP430: TmeIWDBCheckBox;
    dchkModificaDecorrenzaP430: TmeIWDBCheckBox;
    dchkEliminaStoriciP430: TmeIWDBCheckBox;
    dchkAccessibilitaNonVedenti: TmeIWDBCheckBox;
    dchkStoriaInizioFine: TmeIWDBCheckBox;
    dChkDownloadMassivo: TmeIWDBCheckBox;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnDatiAnagraficiIntestazioneClick(Sender: TObject);
    procedure ReleaseOggetti; override;
    procedure btnGestioneTrasferteAnticipiClick(Sender: TObject);
    procedure btnStatiAvanzamentoValClick(Sender: TObject);
  private
    WC013:TWC013FCheckListFM;
    procedure cklistDatiAnagrafici(Sender: TObject; Result:Boolean);
    procedure cklistGestioneTrasferteAnticipi(Sender: TObject; Result:Boolean);
    procedure cklistStatiAvanzamentoVal(Sender: TObject; Result:Boolean);
  public
    lstNomeCampo:TStringList;
  end;

implementation

uses WA182UPermessiDM, WA182UPermessi, WR100UBase;

{$R *.dfm}

procedure TWA182FPermessiDettFM.btnDatiAnagraficiIntestazioneClick(
  Sender: TObject);
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Parent);

  with WC013 do
  begin
    //ckList.Sorted:=True;
    ckList.Items.Clear;
    ckList.Items.Assign(lstNomeCampo);
    ResultEvent:=cklistDatiAnagrafici;
    C190PutCheckList(dedtDatiAnagraficiIntestazione.Text,255,ckList);
    WC013.Visualizza;
  end;
end;

procedure TWA182FPermessiDettFM.btnGestioneTrasferteAnticipiClick(Sender: TObject);
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Parent);

  with WC013 do
  begin
    ckList.Items.Add(Format('%-10s %s',['S','Anticipi Sospesi']));
    ckList.Items.Add(Format('%-10s %s',['P','Anticipi Protocollati']));
    ckList.Items.Add(Format('%-10s %s',['L','Anticipi Liquidati']));
    ckList.Items.Add(Format('%-10s %s',['R','Anticipi Recuperati']));
    C190PutCheckList(dedtGestioneTrasferteAnticipi.Text,9,ckList);
    ResultEvent:=cklistGestioneTrasferteAnticipi;
    WC013.Visualizza;
  end;
end;

procedure TWA182FPermessiDettFM.btnStatiAvanzamentoValClick(Sender: TObject);
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  with WC013 do
  begin
     with TWA182FPermessiDM(WR302DM).selSG746 do
      begin
        Open;
        while not Eof do
        begin
           ckList.Items.Add(Format('%-7s %s',[FieldByName('CODREGOLA').AsString + '.' + IntToStr(FieldByName('CODICE').AsInteger),FieldByName('DESCRIZIONE').AsString]));
          Next;
        end;
        Close;
      end;
    C190PutCheckList(dedtStatiAvanzamentoVal.Text,7,ckList);
    ResultEvent:=cklistStatiAvanzamentoVal;
    WC013.Visualizza;
  end;
end;

procedure TWA182FPermessiDettFM.cklistStatiAvanzamentoVal(Sender: TObject; Result:Boolean);
begin
  if Result then
  begin
    TWA182FPermessiDM(WR302DM).selTabella.FieldByName('S710_STATI_ABILITATI').AsString:=Trim(C190GetCheckList(7, WC013.ckList));
  end;
end;

procedure TWA182FPermessiDettFM.cklistGestioneTrasferteAnticipi(Sender: TObject; Result:Boolean);
begin
  if Result then
  begin
    TWA182FPermessiDM(WR302DM).selTabella.FieldByName('A131_ANTICIPIGESTIBILI').AsString:=Trim(C190GetCheckList(9, WC013.ckList));
  end;
end;

procedure TWA182FPermessiDettFM.cklistDatiAnagrafici(Sender: TObject; Result:Boolean);
begin
  if Result then
  begin
    TWA182FPermessiDM(WR302DM).selTabella.FieldByName('DATIC700').AsString:=Trim(C190GetCheckList(255,WC013.ckList));
  end;
end;

procedure TWA182FPermessiDettFM.IWFrameRegionCreate(Sender: TObject);
var
  jQueryTxt:String;
begin
  dcmbAzienda.ListSource:=TWA182FPermessiDM(TWA182FPermessi(Self.Owner).WR302DM).D090;
  dcmbSchedaAnagr.ListSource:=TWA182FPermessiDM(TWA182FPermessi(Self.Owner).WR302DM).dsrT033;
  inherited;

  (* Massimo 22/01/2013 nuova gestione Tab JQuery con propria gestione dei cookie
  JQuery.OnReady.Text:='$("#tabs").tabs({cookie: { expires: 10 } });'  + CRLF +
                       '$("#tabs").tabs("option","cookie",{ expires: 10 });';
  *)
  //attivazione gestione Tab JQuery
  JQuery.OnReady.Text:=Format(W000JQ_Tabs,[Name]);

  lstNomeCampo:=TStringList.Create;
  btnDatiAnagraficiIntestazione.Enabled:=False;
  btnGestioneTrasferteAnticipi.Enabled:=False;
  dcmbTipiTurnoAccessibili.Items.Values['Comandati']:='C';
  dcmbTipiTurnoAccessibili.Items.Values['Normali']:='N';
  dcmbTipiTurnoAccessibili.Items.Values['Tutti']:='T';
end;

procedure TWA182FPermessiDettFM.ReleaseOggetti;
begin
  FreeAndNil(lstNomeCampo);
end;

end.
