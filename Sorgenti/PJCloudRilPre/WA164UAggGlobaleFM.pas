unit WA164UAggGlobaleFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, WR100UBase, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompButton, meIWButton,
  IWCompLabel, meIWLabel, IWCompEdit, meIWEdit, medpIWMultiColumnComboBox,
  WA164UQuoteIncentiviDM, IWCompExtCtrls, meIWRadioGroup, A000UInterfaccia,
  A000UMessaggi, medpIWMessageDlg, A164UQuoteIncentiviMW, WR102UGestTabella,
  meIWImageFile, medpIWImageButton, A000UCostanti;

type
  TWA164FAggGlobaleFM = class(TWR200FBaseFM)
    btnChiudi: TmeIWButton;
    edtDecorrenza: TmeIWEdit;
    lblDecorrenza: TmeIWLabel;
    lblTipoQuota: TmeIWLabel;
    cmbTipoQuota: TMedpIWMultiColumnComboBox;
    lblDescTipoQuota: TmeIWLabel;
    rgpVariazione: TmeIWRadioGroup;
    lblVariazione: TmeIWLabel;
    lblPercentuale: TmeIWLabel;
    lblImporto: TmeIWLabel;
    edtPercentuale: TmeIWEdit;
    edtImporto: TmeIWEdit;
    btnAnomalie: TmedpIWImageButton;
    btnEsegui: TmedpIWImageButton;
    procedure btnChiudiClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure cmbTipoQuotaAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure edtPercentualeAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure edtImportoAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnAnomalieClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
  private
    procedure ResultConfermaAggiornamento(Sender: TObject; R: TmeIWModalResult;KI: String);
  public
    ResultEvent: TProc<TWA164FAggGlobaleFM>;
    procedure Visualizza;
  end;

implementation

{$R *.dfm}

{ TWA164FAggGlobaleFM }

procedure TWA164FAggGlobaleFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  cmbTipoQuota.items.clear;
  with (WR302DM as TWA164FQuoteIncentiviDM).A164FQuoteIncentiviMW do
  begin
    selT765.First;
    while not selT765.Eof do
    begin
      cmbTipoQuota.AddRow(Format('%s;%s',[selT765.FieldByName('CODICE').AsString,selT765.FieldByName('DESCRIZIONE').AsString]));
      selT765.Next;
    end;
  end;
  cmbTipoQuota.Text:='';
  lblDescTipoQuota.Caption:='';
  edtPercentuale.Text:='';
  edtImporto.Text:='';
end;

procedure TWA164FAggGlobaleFM.btnAnomalieClick(Sender: TObject);
var
  sParam: string;
begin
  inherited;
  with (self.Parent as TWR102FGestTabella) do
  begin
    sParam:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
            'OPERATORE=' + Parametri.Operatore + ParamDelimiter +
            'MASCHERA=' + medpCodiceForm + ParamDelimiter +
            'ID=' + IntToStr(RegistraMsg.ID) + ParamDelimiter +
            'TIPO=A,B';
    accediForm(201,sParam,False);
  end;
  btnChiudiClick(nil);
end;

procedure TWA164FAggGlobaleFM.btnChiudiClick(Sender: TObject);
begin
  inherited;
  if Assigned(ResultEvent) then
    ResultEvent(Self);

  ReleaseOggetti;
  Free;
end;

procedure TWA164FAggGlobaleFM.btnEseguiClick(Sender: TObject);
var
  sAumDim: string;
begin
  inherited;
  if (Trim(edtPercentuale.Text) = '') and (Trim(edtImporto.Text) = '') then
  begin
    MsgBox.WebMessageDlg(A000MSG_A164_ERR_PCT_O_IMP,mtError,[mbOk],nil,'');
    Exit;
  end;

  if rgpVariazione.ItemIndex  = 0 then
    sAumDim:='l''aumento'
  else
    sAumDim:='la diminuzione';

  if edtPercentuale.Text = '' then
    sAumDim:=sAumDim + ' di ' + edtImporto.Text + '€'
  else
    sAumDim:=sAumDim + ' del ' + edtPercentuale.Text + '%';

  MsgBox.WebMessageDlg(Format(A000MSG_A164_MSG_FMT_AGG_GLOBALE,[cmbTipoQuota.Text,lblDescTipoQuota.Caption,edtDecorrenza.Text,sAumDim ]),mtConfirmation,[mbYes, mbNo],ResultConfermaAggiornamento,'');
  Exit;
end;

procedure TWA164FAggGlobaleFM.ResultConfermaAggiornamento(Sender: TObject; R: TmeIWModalResult; KI: String);
var
  AggGlobale: TAggGlobale;
  bOk: Boolean;
begin
  if R = mrYes then
  begin
    AggGlobale.sDecorrenza:=edtDecorrenza.Text;
    AggGlobale.sTipoQuota:=CmbTipoQuota.Text;
    AggGlobale.TipoVariazione:=rgpVariazione.ItemIndex;
    AggGlobale.sPercentuale:=edtPercentuale.Text;
    AggGlobale.sImporto:=edtImporto.Text;

    with (WR302DM as TWA164FQuoteIncentiviDM).A164FQuoteIncentiviMW do
    begin
      bOk:=AggGlobaleStep1;
      if bOk then
        bOk:=AggGlobaleStep2(AggGlobale);

      if bOk then
        bOk:=AggGlobaleStep3(AggGlobale);

      if bOk then
        bOk:=AggGlobaleStep4(AggGlobale);

      if bOk then
        AggGlobaleStep5;
    end;

    btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA;
    if RegistraMsg.ContieneTipoA then
      MsgBox.WebMessageDlg(A000MSG_MSG_ELABORAZIONE_ANOMALIE,mtInformation,[mbOk],nil,'')
    else
      MsgBox.WebMessageDlg(A000MSG_MSG_ELABORAZIONE_TERMINATA,mtInformation,[mbOk],nil,'');

    (Self.Parent as TWR102FGestTabella).actAggiornaExecute(nil);
  end;
end;

procedure TWA164FAggGlobaleFM.cmbTipoQuotaAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  if cmbTipoQuota.ItemIndex > -1 then
    lblDescTipoQuota.Caption:=cmbTipoQuota.Items[cmbTipoQuota.ItemIndex].RowData[1]
  else
    lblDescTipoQuota.Caption:='';
end;

procedure TWA164FAggGlobaleFM.edtImportoAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  edtPercentuale.Enabled:=(edtImporto.Text = '');
end;

procedure TWA164FAggGlobaleFM.edtPercentualeAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  edtImporto.Enabled:=(edtPercentuale.Text = '');
end;

procedure TWA164FAggGlobaleFM.Visualizza;
begin
  TWR100FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,450,-1,260, 'Aggiornamento globale','#' + Self.Name,False,True);
end;

end.
