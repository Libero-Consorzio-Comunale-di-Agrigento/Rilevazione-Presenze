unit WA172USchedeQuantIndividuali;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR103UGestMasterDetail, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, WA172USchedeQuantIndividualiDM, WA172USchedeQuantIndividualiBrowseFM,
  WA172USchedeQuantIndividualiDettFM, WA172UAnagraficaDetailFM,
  medpIWMEssageDlg, A000UInterfaccia, A000UMessaggi, IWCompEdit, meIWEdit;

type
  TWA172FSchedeQuantIndividuali = class(TWR103FGestMasterDetail)
    btnInsT768: TmeIWButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);
    procedure actEliminaExecute(Sender: TObject);
    procedure btnInsT768Click(Sender: TObject);
  protected
    procedure ElaborazioneServer; override;
    procedure InizializzaMsgElaborazione; override;
  public
    function InizializzaAccesso: Boolean; override;
  end;

implementation

{$R *.dfm}
procedure TWA172FSchedeQuantIndividuali.IWAppFormCreate(Sender: TObject);
var
  Detail: TWA172FAnagraficaDetailFM;
begin
  inherited;
  AddScrollBarManager('anagraficaDiv');

  WR302DM:=TWA172FSchedeQuantIndividualiDM.Create(Self);
  WR100LinkWC700:=False;
  AttivaGestioneC700;
  WBrowseFM:=TWA172FSchedeQuantIndividualiBrowseFM.Create(Self);
  WDettaglioFM:=TWA172FSchedeQuantIndividualiDettFM.Create(Self);

  Detail:=TWA172FAnagraficaDetailFM.Create(Self);
  AggiungiDetail(Detail);
  with (WR302DM as  TWA172FSchedeQuantIndividualiDM).A172FSchedeQuantIndividualiMW do
    Detail.CaricaDettaglio(cdsT768,dsrT768);

  CreaTabDefault;
end;

function TWA172FSchedeQuantIndividuali.InizializzaAccesso: Boolean;
begin
  if Parametri.CampiRiferimento.C7_Dato1 = '' then
  begin
    raise exception.Create('Dato aziendale <INCENTIVI DATO1> non specificato!');
  end;
  Result:=True;
end;

procedure TWA172FSchedeQuantIndividuali.actEliminaExecute(Sender: TObject);
begin
  with (WR302DM as TWA172FSchedeQuantIndividualiDM) do
  begin
    if selTabella.FieldByName('STATO').AsString <> 'A' then
    begin
      MsgBox.WebMessageDlg(A000MSG_A172_MSG_MODIFICA_NON_CONSENTITA,mtInformation,[mbOk],nil,'');
      Exit;
    end;
  end;
  inherited;
end;

procedure TWA172FSchedeQuantIndividuali.actModificaExecute(Sender: TObject);
begin
  with (WR302DM as TWA172FSchedeQuantIndividualiDM) do
  begin
    if selTabella.FieldByName('STATO').AsString <> 'A' then
    begin
      MsgBox.WebMessageDlg(A000MSG_A172_MSG_MODIFICA_NON_CONSENTITA,mtInformation,[mbOk],nil,'');
      Exit;
    end;
  end;
  inherited;
end;

procedure TWA172FSchedeQuantIndividuali.btnInsT768Click(Sender: TObject);
begin
  inherited;
  StartElaborazioneServer(btnInsT768.HTMLName);
end;

procedure TWA172FSchedeQuantIndividuali.ElaborazioneServer;
begin
  inherited;
  (WDettaglioFM as TWA172FSchedeQuantIndividualiDettFM).btnAnomalie.Enabled:=False;
  with (WR302DM as TWA172FSchedeQuantIndividualiDM) do
  begin
    ElaborazioneInsT768;
    selTabella.Locate('ROWID',selTabella.RowID,[]);
  end;

  (WDettaglioFM as TWA172FSchedeQuantIndividualiDettFM).btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA;
  if RegistraMsg.ContieneTipoA then
    DCOMMsg:=A000MSG_MSG_ELABORAZIONE_ANOMALIE;
end;

procedure TWA172FSchedeQuantIndividuali.InizializzaMsgElaborazione;
begin
  with WC022FMsgElaborazioneFM do
  begin
    Messaggio:=A000MSG_MSG_ELABORAZIONE_IN_CORSO;
    Titolo:=A000MSG_MSG_ELABORAZIONE;
    ImgFileName:=IMG_FILENAME_ELABORAZIONE;
  end;
end;

end.
