unit WA109UImmagini;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes,
  IWControl, Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWCompEdit, IWHTMLControls, meIWLink, ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompMenu, IWCompLabel,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  IWCompButton, IWDBStdCtrls, meIWLabel, meIWButton, meIWDBNavigator, meIWGrid,
  IWCompGrids, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, OracleData, System.Actions, IWDBExtCtrls, meIWImage, meIWDBImage,
  medpIWMessageDlg, medpIWTabControl, medpIWStatusBar,
  A000UInterfaccia, A000UCostanti, A000UMessaggi, A000USessione, C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  WR100UBase, WR102UGestTabella, WR302UGestTabellaDM, WA109UImmaginiBrowseFM, WA109UImmaginiDM,
  meIWEdit, WC025UUploadFile;

type
  TWA109FImmagini = class(TWR102FGestTabella)
    dimgImmagine: TmeIWDBImage;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
  private
    WC025FUploadFile:TWC025FUploadFileFM;
    procedure TestoStatus;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    function InizializzaAccesso: Boolean; override;
    procedure VisualizzaDialogFileUpload(ResultEvent:TProc<TObject,Boolean,String>);
  end;

implementation

{$R *.dfm}

function TWA109FImmagini.InizializzaAccesso: Boolean;
var Cod: String;
begin
  Result:=False;
  Cod:=GetParam('CODICE');
  if Cod <> '' then
  begin
    WR302DM.selTabella.SearchRecord('CODICE',Cod,[srFromBeginning]);
    WBrowseFM.grdTabella.medpAggiornaCDS(True);
    AggiornaRecord;
  end;
  Result:=True;
end;

procedure TWA109FImmagini.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.GestioneStoricizzata:=True;
  InterfacciaWR102.OttimizzaStorico:=False;
  InterfacciaWR102.DettaglioFM:=False;

  WR302DM:=TWA109FImmaginiDM.Create(Self);
  WBrowseFM:=TWA109FImmaginiBrowseFM.Create(Self);
  dimgImmagine.DataSource:=(WR302DM as TWA109FImmaginiDM).dsrTabella;
  WC025FUploadFile:=nil;

  CreaTabDefault;
end;

procedure TWA109FImmagini.IWAppFormDestroy(Sender: TObject);
begin
  inherited;
  if WC025FUploadFile <> nil then  
    try FreeAndNil(WC025FUploadFile); except end; // Per sicurezza
end;

procedure TWA109FImmagini.TestoStatus;
{ Imposta il testo della statusbar }
begin
  MessaggioStatus(INFORMA,'Nessuna immagine');
  (*
  try
    if imgAzienda.Picture.Graphic.Empty then
      MessaggioStatus(INFORMA,'Nessuna immagine')
    else
    begin
      if imgAzienda.Picture.Width + imgAzienda.Picture.Height > 0 then
        MessaggioStatus(INFORMA,'Risoluzione immagine: ' + IntToStr(imgAzienda.Picture.Width) + ' x ' + IntToStr(imgAzienda.Picture.Height))
      else
        MessaggioStatus(INFORMA,'');
    end;
  except
    MessaggioStatus(INFORMA,'Nessuna immagine')
  end;
  *)
end;

procedure TWA109FImmagini.VisualizzaDialogFileUpload(ResultEvent:TProc<TObject,Boolean,String>);
begin
  if WC025FUploadFile <> nil then
    FreeAndNil(WC025FUploadFile);
  WC025FUploadFile:=TWC025FUploadFileFM.Create(Self);
  WC025FUploadFile.ResultEvent:=ResultEvent;
  WC025FUploadFile.FreeNotification(Self);
  WC025FUploadFile.Visualizza('Carica immagine','Scegliere l''immagine da caricare, quindi fare click su Conferma per proseguire.');
end;

procedure TWA109FImmagini.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = WC025FUploadFile) and (Operation = TOperation.opRemove) then
    WC025FUploadFile:=nil;
end;

end.
