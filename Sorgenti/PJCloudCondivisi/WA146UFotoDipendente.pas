unit WA146UFotoDipendente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, medpIWStatusBar, IWCompEdit, meIWEdit, IWCompGrids, meIWGrid,
  IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, WC025UUploadFile, A000UInterfaccia, A000UMessaggi, medpIWMessageDlg, Oracle, OracleData, Db,
  IWApplication, JPeg, C180FunzioniGenerali;

type
  TWA146FFotoDipendente = class(TWR102FGestTabella)
    actApri: TAction;
    actScaricaDaDB: TAction;
    meIWButton1: TmeIWButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);override;
    procedure actAnnullaExecute(Sender: TObject);override;
    procedure actConfermaExecute(Sender: TObject);override;
    procedure actEliminaExecute(Sender: TObject);override;
    procedure actApriExecute(Sender: TObject);
    procedure actScaricaDaDBExecute(Sender: TObject);
  private
    { Private declarations }
    WC025FUploadFile: TWC025FUploadFileFM;
    procedure ResultDelete(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure AggiornaTutto;
    function  ActionForDownload(action: TAction): Boolean; override;
    procedure VisualizzaDialogFileUpload(ResultEvent:TProc<TObject,Boolean,String>);
  public
    { Public declarations }
    procedure WC700CambioProgressivo(Sender: TObject); override;
    procedure ResultWC700(Sender: TObject; Result: Boolean);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function InizializzaAccesso: Boolean; override;
  end;

implementation

uses WA146UFotoDipendenteDM, WA146UFotoDipendenteDettFM, WA146UFotoDipendenteBrowseFM;

{$R *.dfm}

function TWA146FFotoDipendente.InizializzaAccesso: Boolean;
var
  Progressivo: Integer;
begin
  Result:=False;
  Progressivo:=StrToIntDef(GetParam('PROGRESSIVO'),0);
  if Progressivo > 0 then
  begin
    grdC700.WC700FM.C700Progressivo:=Progressivo;
    grdC700.WC700FM.actConfermaExecute(nil);
  end;
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  Result:=True;
end;

procedure TWA146FFotoDipendente.IWAppFormCreate(Sender: TObject);
begin
  inherited;

  actNuovo.Visible:=False;
  actCopiaSu.Visible:=False;
  actPrimo.Visible:=False;
  actPrecedente.Visible:=False;
  actSuccessivo.Visible:=False;
  actUltimo.Visible:=False;
  actRicerca.Visible:=False;
  actEstrai.Visible:=False;
  actAggiorna.Visible:=False;

  WR302DM:=TWA146FFotoDipendenteDM.Create(Self);
  WBrowseFM:=TWA146FFotoDipendenteBrowseFM.Create(Self);
  WDettaglioFM:=TWA146FFotoDipendenteDettFM.Create(Self);

  AttivaGestioneC700;
  grdC700.WC700FM.ResultEvent:=ResultWC700;

  CreaTabDefault;
  //grdTabControl.TabByIndex(0).Enabled:=False;
end;

procedure TWA146FFotoDipendente.IWAppFormDestroy(Sender: TObject);
begin
  inherited;
  if WC025FUploadFile <> nil then
    try FreeAndNil(WC025FUploadFile); except end;
end;

procedure TWA146FFotoDipendente.actModificaExecute(Sender: TObject);
begin
  actApri.Enabled:=(WDettaglioFM as TWA146FFotoDipendenteDettFM).rgpRisorsa.ItemIndex = 0;
  inherited actModificaExecute(Sender);
end;

procedure TWA146FFotoDipendente.actAnnullaExecute(Sender: TObject);
begin
  inherited actAnnullaExecute(Sender);
  actApri.Enabled:=False;
  AggiornaTutto;
end;

procedure TWA146FFotoDipendente.actConfermaExecute(Sender: TObject);
var esiste: Boolean;
    estensione: String;
begin
  if (WDettaglioFM as TWA146FFotoDipendenteDettFM).rgpRisorsa.ItemIndex=1 then
  begin
    esiste:=FileExists((WDettaglioFM as TWA146FFotoDipendenteDettFM).edtPercorso.Text);
    estensione:=R180EstraiExtFile((WDettaglioFM as TWA146FFotoDipendenteDettFM).edtPercorso.Text);

    if esiste and R180In(estensione,['jpg','bmp']) then
    begin
      (WR302DM as TWA146FFotoDipendenteDM).selTabellaPROGRESSIVO.AsInteger:=grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
      (WR302DM as TWA146FFotoDipendenteDM).selTabellaFILE_FOTO.AsString:=(WDettaglioFM as TWA146FFotoDipendenteDettFM).edtPercorso.Text;
      (WR302DM as TWA146FFotoDipendenteDM).selTabellaFOTO.Clear;
    end
    else
    begin
      raise Exception.Create('Immagine non valida!');
    end;
  end;

  inherited actConfermaExecute(Sender);
  actApri.Enabled:=False;
  AggiornaTutto;
end;

procedure TWA146FFotoDipendente.actEliminaExecute(Sender: TObject);
begin
  InterfacciaWR102.ConfermaCancellazione:=False;
  MsgBox.WebMessageDlg(A000MSG_DLG_CANCELLAZIONE,mtConfirmation,[mbYes,mbNo],ResultDelete,'');
end;

procedure TWA146FFotoDipendente.ResultDelete(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    inherited actEliminaExecute(Sender);
    (WDettaglioFM as TWA146FFotoDipendenteDettFM).Image1.Picture.Assign(nil);
    (WDettaglioFM as TWA146FFotoDipendenteDettFM).AggiornaDimensione;
  end;
end;

procedure TWA146FFotoDipendente.actApriExecute(Sender: TObject);
begin
  inherited;
  VisualizzaDialogFileUpload((WDettaglioFM as TWA146FFotoDipendenteDettFM).OnFileUploadDialogResult);
end;

procedure TWA146FFotoDipendente.VisualizzaDialogFileUpload(ResultEvent:TProc<TObject,Boolean,String>);
begin
  if WC025FUploadFile <> nil then
    FreeAndNil(WC025FUploadFile);
  WC025FUploadFile:=TWC025FUploadFileFM.Create(Self);
  WC025FUploadFile.ResultEvent:=ResultEvent;
  WC025FUploadFile.FreeNotification(Self);
  WC025FUploadFile.Visualizza('Carica immagine','Scegliere l''immagine da caricare, quindi fare click su Conferma per proseguire.');
end;

procedure TWA146FFotoDipendente.actScaricaDaDBExecute(Sender: TObject);
var nomeFile: String;
begin
  inherited;
  nomeFile:= grdC700.selAnagrafe.FieldByName('MATRICOLA').AsString + '_' +
             grdC700.selAnagrafe.FieldByName('COGNOME').AsString + '_' +
             grdC700.selAnagrafe.FieldByName('NOME').AsString;
  (WDettaglioFM as TWA146FFotoDipendenteDettFM).ScaricaDaDB(nomeFile);
end;

procedure TWA146FFotoDipendente.AggiornaTutto;
begin
  (WDettaglioFM as TWA146FFotoDipendenteDettFM).SetRadioGroup;
  (WDettaglioFM as TWA146FFotoDipendenteDettFM).CaricaImmagine;
  (WDettaglioFM as TWA146FFotoDipendenteDettFM).AggiornaDimensione;

  actScaricadaDB.Enabled:=(WDettaglioFM as TWA146FFotoDipendenteDettFM).lblDimensione.Text <> '';
  AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
end;

function TWA146FFotoDipendente.ActionForDownload(action: TAction): Boolean;
begin
  if Action.Name = 'actScaricaDaDB' then
    Result:=True
  else
    Result:=inherited;
end;

procedure TWA146FFotoDipendente.ResultWC700(Sender: TObject; Result: Boolean);
begin
  AggiornaTutto;
end;

procedure TWA146FFotoDipendente.WC700CambioProgressivo(Sender: TObject);
begin
  inherited WC700CambioProgressivo(Sender);
  AggiornaTutto;
end;

procedure TWA146FFotoDipendente.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = WC025FUploadFile) and (Operation = TOperation.opRemove) then
    WC025FUploadFile:=nil;
end;

end.


