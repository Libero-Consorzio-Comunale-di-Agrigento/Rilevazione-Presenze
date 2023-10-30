unit WA166UAcquisizioneFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompExtCtrls,
  meIWImageFile, medpIWImageButton, WR102UGestTabella, A000UInterfaccia, A000UCostanti,
  IWCompLabel, meIWLabel, IWApplication, medpIWMessageDlg,A000UMessaggi,
  IWCompEdit, medpIWMultiColumnComboBox, WA166UQuoteIndividualiDM,
  IWCompFileUploader, meIWFileUploader;

type
  TWA166FAcquisizioneFM = class(TWR200FBaseFM)
    btnAnomalie: TmedpIWImageButton;
    btnEsegui: TmedpIWImageButton;
    btnChiudi: TmeIWButton;
    btnUpload: TmedpIWImageButton;
    btnVisualizzaFile: TmedpIWImageButton;
    lbFileScelto: TmeIWLabel;
    lblFileSceltoDescr: TmeIWLabel;
    lblTipoQuota: TmeIWLabel;
    cmbTipoQuota: TMedpIWMultiColumnComboBox;
    lblDescTipoQuota: TmeIWLabel;
    btnSendFile: TmeIWButton;
    fileUpload: TmeIWFileUploader;
    procedure btnChiudiClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure btnUploadClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure cmbTipoQuotaAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure btnSendFileClick(Sender: TObject);
    procedure btnVisualizzaFileClick(Sender: TObject);
  private
    PathFileUploaded: String;
    procedure RecuperaFile;
    procedure ResultConfermaAggiornamento(Sender: TObject; R: TmeIWModalResult;
      KI: String);
    procedure CaricaComboTipoQuota;
  public
    ResultEvent: TProc<TWA166FAcquisizioneFM>;
    procedure Visualizza;
  end;

implementation

{$R *.dfm}

procedure TWA166FAcquisizioneFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  PathFileUploaded:='';
  lblDescTipoQuota.Caption:='';
  lblFileSceltoDescr.Caption:='';
  CaricaComboTipoQuota;
end;

procedure TWA166FAcquisizioneFM.btnAnomalieClick(Sender: TObject);
var
  sParam: String;
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

procedure TWA166FAcquisizioneFM.Visualizza;
begin
  TWR102FGestTabella(Self.Parent).VisualizzaJQMessaggio(jQuery,600,-1,260, 'Acquisizione quote individuali da file','#' + Self.Name,False,True);
end;

procedure TWA166FAcquisizioneFM.btnUploadClick(Sender: TObject);
begin
  inherited;
  RecuperaFile;
end;

procedure TWA166FAcquisizioneFM.btnVisualizzaFileClick(Sender: TObject);
begin
  inherited;
  //Serve questo workaround altrimenti il component per file upload sparisce...
  (Self.Parent as TWR102FGestTabella).AddToInitProc(Format('SubmitClick("%s","",true); ',[btnSendFile.HTMLName]));
end;

procedure TWA166FAcquisizioneFM.cmbTipoQuotaAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  if cmbTipoQuota.ItemIndex = -1 then
    lblDescTipoQuota.Caption:=''
  else
    lblDescTipoQuota.Caption:=cmbTipoQuota.Items[cmbTipoQuota.ItemIndex].RowData[1];
end;

procedure TWA166FAcquisizioneFM.CaricaComboTipoQuota;
begin
  with (WR302DM as TWA166FQuoteIndividualiDM).A166FQuoteIndividualiMW do
  begin
    cmbTipoQuota.Items.Clear;
    selT765.First;
    while not selT765.Eof do
    begin
      cmbTipoQuota.AddRow(Format('%s;%s;%s',[selT765.FieldByName('CODICE').AsString,selT765.FieldByName('DESCRIZIONE').AsString,selT765.FieldByName('TIPOQUOTA').AsString]));
      selT765.Next;
    end;
  end;
end;

procedure TWA166FAcquisizioneFM.RecuperaFile;
var nomeFile: String;
begin
  { DONE : TEST IW 14 OK }
  if not fileUpload.IsPresenteFileUploadato then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_FILE_INESISTENTE,mtError,[mbOk],nil,'');
    exit;
  end;

  nomeFile:=fileUpload.NomeFile;
  try
    // path e nome per il salvataggio su file system
    PathFileUploaded:=GGetWebApplicationThreadVar.UserCacheDir + nomeFile;
    // se esiste già un file con lo stesso nome lo cancella
    if FileExists(PathFileUploaded) then
      DeleteFile(PathFileUploaded);
    fileUpload.SalvaSuFile(PathFileUploaded);
    fileUpload.Ripristina;
    btnVisualizzaFile.Enabled:=True;
    lblFileSceltoDescr.Caption:=ExtractFileName(PathFileUploaded);
  except
    begin
      fileUpload.Ripristina;
      btnVisualizzaFile.Enabled:=False;
      PathFileUploaded:='';
      lblFileSceltoDescr.Caption:='';
      MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_ERRORE,['upload fallito']),mtError,[mbOk],nil,'');
    end;
  end;
end;

procedure TWA166FAcquisizioneFM.btnChiudiClick(Sender: TObject);
begin
  inherited;
  if Assigned(ResultEvent) then
    ResultEvent(Self);

  ReleaseOggetti;
  Free;
end;

procedure TWA166FAcquisizioneFM.btnEseguiClick(Sender: TObject);
begin
  inherited;
  if PathFileUploaded = '' then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_FILE_INESISTENTE,mtError,[mbOk],nil,'');
    Exit;
  end;

  if cmbTipoQuota.Text = '' then
  begin
    MsgBox.WebMessageDlg(A000MSG_A166_ERR_TIPO_QUOTA,mtError,[mbOk],nil,'');
    Exit;
  end;

  if not FileExists(PathFileUploaded) then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_FILE_INESISTENTE,mtError,[mbOk],nil,'');
    Exit;
  end;

  MsgBox.WebMessageDlg(Format(A000MSG_A166_DLG_FMT_ACQUISIZIONE,[cmbTipoQuota.Text,lblDescTipoQuota.Caption,(Self.Parent as TWR102FGestTabella).grdC700.selAnagrafe.RecordCount.ToString]),mtConfirmation,[mbYes, mbNo],ResultConfermaAggiornamento,'');
  Exit;
end;

procedure TWA166FAcquisizioneFM.btnSendFileClick(Sender: TObject);
begin
  inherited;
  if FileExists(PathFileUploaded) then
    GGetWebApplicationThreadVar.SendFile(PathFileUploaded,true,'application/x-download',ExtractFileName(PathFileUploaded))
  else
    MsgBox.WebMessageDlg(A000MSG_ERR_FILE_INESISTENTE,mtInformation,[mbOk],nil,'');
end;

procedure TWA166FAcquisizioneFM.ResultConfermaAggiornamento(Sender: TObject; R: TmeIWModalResult; KI: String);
var
  lstFile: TStringList;
  s: String;
begin
  if R = mrYes then
  begin
    try
      lstFile:=TStringList.Create;
      lstFile.LoadFromFile(PathFileUploaded);
    except
      FreeAndNil(lstFile);
      MsgBox.WebMessageDlg(A000MSG_ERR_FILE_INESISTENTE,mtError,[mbOk],nil,'');
      Exit;
    end;

    with (WR302DM as TWA166FQuoteIndividualiDM).A166FQuoteIndividualiMW do
    begin
      try
        AcquisizioneDaFileInizio;
        if not RegistraMsg.ContieneTipoA then
          for s in lstFile do
          begin
            Acquisisci(s,cmbTipoQuota.Text);
          end;
      finally
        FreeAndNil(lstFile);
        AcquisizioneDaFileFine;
      end;
    end;

    btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA;
    if RegistraMsg.ContieneTipoA then
      MsgBox.WebMessageDlg(A000MSG_MSG_ELABORAZIONE_ANOMALIE,mtInformation,[mbOk],nil,'')
    else
      MsgBox.WebMessageDlg(A000MSG_MSG_ELABORAZIONE_TERMINATA,mtInformation,[mbOk],nil,'');

    (Self.Parent as TWR102FGestTabella).actAggiornaExecute(nil);
  end;
end;

end.
