unit WP655UDatiINPDAPMM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR103UGestMasterDetail, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, WP655UDatiINPDAPMMDM, WP655UDatiINPDAPMMBrowseFM, A000UCostanti,
  meIWRadioGroup, WP655UFlussiIndividualiFM, medpIWMessageDlg, A000UInterfaccia,
  A000UMessaggi,WC020UInputDataOreFM, OracleData;
type
  TWP655FDatiINPDAPMM = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
    procedure actEliminaExecute(Sender: TObject);
  private
    NumDip: String;
    procedure ResultConfermaCancellazione(Sender: TObject;
      Res: TmeIWModalResult; KeyID: String);
    procedure ResultInputCancellazione(Sender: TObject; Result: Boolean;
      Valore: String);
    { Private declarations }
  public
    NomeFlusso: String;
    Detail: TWP655FFlussiIndividualiFM;
    function InizializzaAccesso: Boolean; override;
    procedure WC700CambioProgressivo(Sender: TObject); override;
  end;

implementation

{$R *.dfm}

procedure TWP655FDatiINPDAPMM.IWAppFormCreate(Sender: TObject);
begin
  actCopiaSu.Visible:=False;
  actNuovo.Visible:=False;
  actModifica.Visible:=False;
  actConferma.Visible:=False;
  actAnnulla.Visible:=False;
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
end;

function TWP655FDatiINPDAPMM.InizializzaAccesso: Boolean;
var
  sTag: String;
begin
  sTag:=GetParam('TAG');
  if sTag <> '' then
    SetTag(StrToInt(sTag))
  else
    SetTag(572); //per test
  Title:=Format('(%s) %s',[medpCodiceForm,medpNomeFunzione]);

  NomeFlusso:=GetParam('FLUSSO');
  if NomeFlusso = '' then
    NomeFlusso:=FLUSSO_FLUPER; //per TEST;

  if NomeFlusso = FLUSSO_INPDAP then
   HelpKeyword:=Format('%sP0',[medpCodiceForm])
  else if NomeFlusso = FLUSSO_FLUPER then
   HelpKeyword:=Format('%sP1',[medpCodiceForm])
  else
    HelpKeyword:=Format('%sP2',[medpCodiceForm]);

  WR302DM:=TWP655FDatiINPDAPMMDM.Create(Self);
  AttivaGestioneC700;
  (WR302DM as TWP655FDatiINPDAPMMDM).P655FDatiINPDAPMMMW.SelAnagrafe:=grdC700.selAnagrafe;
  WBrowseFM:=TWP655FDatiINPDAPMMBrowseFM.Create(Self);
  //Devo riposizionare perchè la creazione di WBrowseFM riporta seltabella sul primo record
  WR302DM.selTabella.Last;
  WR302DM.selTabella.SearchRecord('DATA_FINE_PERIODO',WR302DM.selTabella.FieldByName('DATA_FINE_PERIODO').AsDateTime,[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);

  Detail:=TWP655FFlussiIndividualiFM.Create(Self);
  AggiungiDetail(Detail);
  with (WR302DM as TWP655FDatiINPDAPMMDM).P655FDatiINPDAPMMMW do
  begin
    Detail.CaricaDettaglio(P663,D663);
  end;

  CreaTabDefault;


  Result:=True;
end;

procedure TWP655FDatiINPDAPMM.ResultInputCancellazione(Sender: TObject; Result: Boolean; Valore: String);
begin
  if Result then
  begin
    if (Valore <> NumDip) then
    begin
      MsgBox.WebMessageDlg(A000MSG_MSG_OPERAZIONE_ANNULLATA,mtInformation,[mbOk],nil,'');
      Exit;
    end;
    EseguiDelete;
  end;
end;

procedure TWP655FDatiINPDAPMM.ResultConfermaCancellazione(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
var
  WC020FInputDataOreFM: TWC020FInputDataOreFM;
begin
  if Res = mrYes then
  begin
    WC020FInputDataOreFM:=TWC020FInputDataOreFM.Create(Self);
    WC020FInputDataOreFM.ImpostaCampiText('Inserire il numero di dipendenti che verranno cancellati:','0');
    WC020FInputDataOreFM.ResultEvent:=ResultInputCancellazione;
    WC020FInputDataOreFM.Visualizza('Cancellazione di ' + NumDip + ' dip.');
  end;
end;

procedure TWP655FDatiINPDAPMM.actEliminaExecute(Sender: TObject);
var
  Msg: String;
begin
  Msg:=(WR302DM as TWP655FDatiINPDAPMMDM).P655FDatiINPDAPMMMW.MessaggioCancellazione(NumDip);
  MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultConfermaCancellazione,'');
  Exit;
end;

procedure TWP655FDatiINPDAPMM.WC700CambioProgressivo(Sender: TObject);
begin
  inherited;
  (WR302DM as TWP655FDatiINPDAPMMDM).CaricaFlussiIndividuali;
  AggiornaDetails;
end;

end.
