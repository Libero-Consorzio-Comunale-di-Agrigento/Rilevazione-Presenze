unit WS030UDettaglioFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, meIWEdit,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel,
  meIWLabel, IWCompExtCtrls, meIWImageFile, medpIWImageButton, IWCompGrids,
  IWDBGrids, medpIWDBGrid, Data.DB, A000UInterfaccia, A000UMessaggi, ekrtf, medpIWMessageDlg,
  Vcl.StdCtrls, Vcl.ComCtrls, IWApplication, IWCompFileUploader,
  meIWFileUploader, IWCompButton, meIWButton;

type
  TWS030FDettaglioFM = class(TWR200FBaseFM)
    lblMatricola: TmeIWLabel;
    edtMatricola: TmeIWEdit;
    lblDipendente: TmeIWLabel;
    lblDataDecorrenza: TmeIWLabel;
    edtDataDecorrenza: TmeIWEdit;
    lblMotivazione: TmeIWLabel;
    edtMotivazione: TmeIWEdit;
    lblDescMotivazione: TmeIWLabel;
    lblTipoAtto: TmeIWLabel;
    edtTipoAtto: TmeIWEdit;
    lblNumAtto: TmeIWLabel;
    edtNumAtto: TmeIWEdit;
    dgrdDettProvv: TmedpIWDBGrid;
    btnStampa: TmedpIWImageButton;
    btnElabora: TmedpIWImageButton;
    dsrSG095: TDataSource;
    lblNomeFileInput: TmeIWLabel;
    lblFileScelto: TmeIWLabel;
    lblFileSceltoDescr: TmeIWLabel;
    fileUpload: TmeIWFileUploader;
    btnHdnPostUpload: TmeIWButton;
    procedure btnElaboraClick(Sender: TObject);
    procedure btnStampaClick(Sender: TObject);
    procedure btnHdnPostUploadClick(Sender: TObject);
  private
    { Private declarations }
    procedure RecuperaFileInput;
  public
    { Public declarations }
    procedure Visualizza;
  end;

implementation

uses WS030UProvvedimenti, WS030UProvvedimentiDM;

{$R *.dfm}

procedure TWS030FDettaglioFM.Visualizza;
begin
  inherited;
  with (Self.Owner as TWS030FProvvedimenti),(WR302DM as TWS030FProvvedimentiDM),S030MW do
  begin
    dgrdDettProvv.medpAttivaGrid(selSG095,False,False,False);
    btnElabora.Enabled:=not SolaLettura;
    edtMatricola.Text:=SelAnagrafe.FieldByName('MATRICOLA').AsString;
    lblDipendente.Caption:=SelAnagrafe.FieldByName('COGNOME').AsString + ' ' + SelAnagrafe.FieldByName('NOME').AsString;
    edtMotivazione.Text:=selSG100.FieldByName('CAUSALE').AsString;
    lblDescMotivazione.Caption:=selSG100.FieldByName('D_CAUSALI').AsString;
    edtDataDecorrenza.Text:=selSG100.FieldByName('DATADECOR').AsString;
    edtTipoAtto.Text:=selSG100.FieldByName('TIPOATTO').AsString;
    edtNumAtto.Text:=selSG100.FieldByName('NUMATTO').AsString;
    ApriDettaglioProvvedimento;
    dgrdDettProvv.medpAggiornaCDS;
    if not CercaMotivazione then
      MsgBox.WebMessageDlg(A000MSG_S030_MSG_FMT_MOTIVAZIONE,mtInformation,[mbOK],nil,'');
    NomeModello:='';
  end;
end;

procedure TWS030FDettaglioFM.btnElaboraClick(Sender: TObject);
begin
  inherited;
  with (Self.Owner as TWS030FProvvedimenti),(WR302DM as TWS030FProvvedimentiDM),S030MW do
  begin
    if selSG095.RecordCount > 0 then
      evtRichiesta(A000MSG_S030_DLG_CANCELLA_DETTAGLIO,'DelDett');
    evtRichiesta(Format(A000MSG_S030_DLG_FMT_ELABORA_DETTAGLIO,[SelAnagrafe.FieldByName('COGNOME').AsString + ' ' + SelAnagrafe.FieldByName('NOME').AsString,selSG100.FieldByName('DATADECOR').AsString]),'ElabDett');
    MsgBox.ClearKeys;
    DCOMNomeFile:='';
    StartElaborazioneServer(btnElabora.HTMLName);
  end;
end;

procedure TWS030FDettaglioFM.RecuperaFileInput;
var nFile,lPathFile: String;
begin
{ DONE : TEST IW 14 OK }
  nFile:=fileUpload.NomeFile;
  if not fileUpload.IsPresenteFileUploadato then
  begin
    if ((Self.Owner as TWS030FProvvedimenti).WR302DM as TWS030FProvvedimentiDM).S030MW.NomeModello = '' then
      raise Exception.Create(A000MSG_ERR_FILE_INESISTENTE_IMP)
    else
      nFile:=ExtractFileName(((Self.Owner as TWS030FProvvedimenti).WR302DM as TWS030FProvvedimentiDM).S030MW.NomeModello);
  end
  else
    with (Self.Owner as TWS030FProvvedimenti) do
    begin
      C004DM.Cancella001;
      C004DM.PutParametro('NOMECERT',nFile);
      try SessioneOracle.Commit; except end;
      C004DM.selT001.Refresh;//Serve in caso di un eventuale nuovo lancio della stampa
    end;

  try
    // path e nome per il salvataggio su file system
    lPathFile:=GGetWebApplicationThreadVar.UserCacheDir + nFile;
    ((Self.Owner as TWS030FProvvedimenti).WR302DM as TWS030FProvvedimentiDM).S030MW.NomeModello:=lPathFile;
    // se esiste già un file con lo stesso nome lo cancella
    if FileExists(lPathFile) then
      DeleteFile(lPathFile);
    fileUpload.SalvaSuFile(lPathFile);
    fileUpload.Ripristina;
  except
    begin
      fileUpload.Ripristina;
      raise Exception.Create(Format(A000MSG_ERR_FMT_ERRORE,['upload fallito']));
    end;
  end;
end;

procedure TWS030FDettaglioFM.btnHdnPostUploadClick(Sender: TObject);
begin
  inherited;
  RecuperaFileInput;
end;

procedure TWS030FDettaglioFM.btnStampaClick(Sender: TObject);
begin
  inherited;
  with (Self.Owner as TWS030FProvvedimenti) do
  begin
    (WR302DM as TWS030FProvvedimentiDM).S030MW.CreaStampaRTF;
    DCOMNomeFile:=(WR302DM as TWS030FProvvedimentiDM).S030MW.NomeFileGen;
    btnSendFileClick(btnStampa);
  end;
end;

end.
