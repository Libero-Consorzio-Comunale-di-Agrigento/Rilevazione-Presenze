unit WC025UUploadFile;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompButton,
  meIWButton, IWCompLabel, meIWLabel, WR100UBase, A000UMessaggi, IWApplication,
  A000UInterfaccia, medpIWMessageDlg, IWCompFileUploader, meIWFileUploader;

type
  TWC025FUploadFileFM = class(TWR200FBaseFM)
    btnChiudi: TmeIWButton;
    btnConferma: TmeIWButton;
    lblFile: TmeIWLabel;
    fileUpload: TmeIWFileUploader;
    procedure btnChiudiClick(Sender: TObject);
  public
    ResultEvent: TProc<TObject,Boolean,String>;
    procedure Visualizza(Titolo, EtichettaFile: String);
  end;

implementation

{$R *.dfm}

procedure TWC025FUploadFileFM.Visualizza(Titolo,EtichettaFile: String);
begin
  lblFile.Caption:=EtichettaFile;
  TWR100FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,500,180,180, Titolo,'#'+Self.name,False,True);
end;

procedure TWC025FUploadFileFM.btnChiudiClick(Sender: TObject);
var
  Res: Boolean;
  NomeFile: String;
begin
  Res:=Sender = btnConferma;
 
  { DONE : TEST IW 14 OK }
  if Res then
  begin
    if not fileUpload.IsPresenteFileUploadato then
    begin
      MsgBox.WebMessageDlg(A000MSG_ERR_NO_FILE,mtError,[mbOk],nil,'');
      Exit;
    end;
    try
      // path e nome per il salvataggio su file system
      NomeFile:=GGetWebApplicationThreadVar.UserCacheDir + fileUpload.NomeFile;
      // se esiste già un file con lo stesso nome lo cancella
      if FileExists(NomeFile) then
        DeleteFile(NomeFile);
      fileUpload.SalvaSuFile(NomeFile);
      fileUpload.Ripristina;
    except
      MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_ERRORE,[A000MSG_MSG_UPLOAD_FALLITO]),mtError,[mbOk],nil,'');
      Exit;
    end;
  end;

  if Assigned(ResultEvent) then
  try
    ResultEvent(Self,Res,NomeFile);
  except
    on E: EAbort do;
    on E: Exception do
      raise;
  end;
  ReleaseOggetti;
  Free;
end;

end.
