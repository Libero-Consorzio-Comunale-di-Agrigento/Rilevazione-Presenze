unit WA097UImportazioneFileFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent, Math,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompEdit, medpIWMultiColumnComboBox, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, IWCompCheckbox,
  meIWCheckBox, A000UInterfaccia, A000UCostanti, IWCompExtCtrls, meIWImageFile,
  medpIWImageButton, WR100UBase, A000UMessaggi, C180FunzioniGenerali, StrUtils,
  medpIWMessageDlg, IWApplication, OracleData, IWCompFileUploader,
  meIWFileUploader;

type
  TWA097FImportazioneFileFM = class(TWR200FBaseFM)
    btnImportazioneFile: TmeIWButton;
    lblNomeFileInput: TmeIWLabel;
    lblFileScelto: TmeIWLabel;
    lblFileSceltoDescr: TmeIWLabel;
    fileUpload: TmeIWFileUploader;
    btnHdnPostUpload: TmeIWButton;
    procedure btnImportazioneFileClick(Sender: TObject);
    procedure btnHdnPostUploadClick(Sender: TObject);
  private
    procedure RecuperaFileInput;
    procedure evtRichiesta(Msg,Chiave:String);
    procedure ResultEvtRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
  end;

implementation

uses WA097UPianifLibProf, WA097UPianifLibProfDM;

{$R *.dfm}

procedure TWA097FImportazioneFileFM.btnHdnPostUploadClick(Sender: TObject);
begin
  RecuperaFileInput;
end;

procedure TWA097FImportazioneFileFM.btnImportazioneFileClick(Sender: TObject);
begin
  with (WR302DM as TWA097FPianifLibProfDM).A097MW do
  begin
    if selAnagrafe.RecordCount = 0 then
      raise exception.Create(A000MSG_ERR_NO_DIP);
    ControlliImportazione;
    (Self.Parent as TWA097FPianifLibProf).ProceduraChiamante:=2;
    evtRichiesta(Format(A000MSG_A097_DLG_FMT_CONFERMA_IMPORT,[ExtractFileName(NomeFile),IntToStr(SelAnagrafe.RecordCount),DateToStr(Dal),DateToStr(Al)]),'RichiestaConfermaImportazione');
  end;
  (Self.Parent as TWR100FBase).StartElaborazioneServer((Sender as TmeIWButton).HTMLName);
end;

procedure TWA097FImportazioneFileFM.RecuperaFileInput;
var
  nFile,pathCompletoFile: String;
begin
  { DONE : TEST IW 14 OK }
  nFile:=fileUpload.NomeFile;
  if not fileUpload.IsPresenteFileUploadato then
    if (WR302DM as TWA097FPianifLibProfDM).A097MW.NomeFile = '' then
      raise Exception.Create(A000MSG_ERR_FILE_INESISTENTE_IMP)
    else
      nFile:=ExtractFileName((WR302DM as TWA097FPianifLibProfDM).A097MW.NomeFile);
  try
    // path e nome per il salvataggio su file system
    pathCompletoFile:=GGetWebApplicationThreadVar.UserCacheDir + nFile;
    (WR302DM as TWA097FPianifLibProfDM).A097MW.NomeFile:=pathCompletoFile;
    // se esiste già un file con lo stesso nome lo cancella
    if FileExists(pathCompletoFile) then
      DeleteFile(pathCompletoFile);
    fileUpload.SalvaSuFile(pathCompletoFile);
    fileUpload.Ripristina;
  except
    on E:Exception do
    begin
      fileUpload.Ripristina;
      raise Exception.Create(Format(A000MSG_ERR_FMT_ERRORE,['upload fallito']));
    end;
  end;
end;

procedure TWA097FImportazioneFileFM.evtRichiesta(Msg,Chiave:String);
begin
  if not MsgBox.KeyExists(Chiave) then
  begin
    MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultEvtRichiesta,Chiave);
    Abort;
  end;
end;

procedure TWA097FImportazioneFileFM.ResultEvtRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    btnImportazioneFileClick(btnImportazioneFile)
  else
    MsgBox.ClearKeys;
end;

end.
