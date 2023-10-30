unit WP555UContoAnnuale;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR103UGestMasterDetail, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, WP555UContoAnnualeDM, WP555UContoAnnualeBrowseFM,
  WP555UDettaglioContoAnnualeFM, OracleData, A000UInterfaccia, A000UMessaggi, medpIWMessagedlg,
  WC020UInputDataOreFM;

type
  TWP555FContoAnnuale = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
    procedure actEliminaExecute(Sender: TObject);
  private
    procedure ResultConfermaElimina(Sender: TObject; Res: TmeIWModalResult;
      KeyID: String);
    procedure ResultInputCancellazione(Sender: TObject; Result: Boolean;
      Valore: String);
  protected
    procedure WC700AperturaSelezione(Sender: TObject);   override;
  public
    Detail: TWP555FDettaglioContoAnnualeFM;
    procedure WC700CambioProgressivo(Sender: TObject); override;
  end;
implementation

{$R *.dfm}

procedure TWP555FContoAnnuale.IWAppFormCreate(Sender: TObject);
begin
  actModifica.Visible:=False;
  actNuovo.Visible:=False;
  actCopiaSu.Visible:=False;
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWP555FContoAnnualeDM.Create(Self);
  AttivaGestioneC700;
  (WR302DM as TWP555FContoAnnualeDM).P555FContoAnnualeMW.SelAnagrafe:=grdC700.selAnagrafe;
  WBrowseFM:=TWP555FContoAnnualeBrowseFM.Create(Self);
  Detail:=TWP555FDettaglioContoAnnualeFM.Create(Self);
  (WR302DM as TWP555FContoAnnualeDM).P555FContoAnnualeMW.PosizionaSelP554(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  Detail.CaricaDettaglio((WR302DM as TWP555FContoAnnualeDM).P555FContoAnnualeMW.selP555,(WR302DM as TWP555FContoAnnualeDM).P555FContoAnnualeMW.dsrP555);
  AggiungiDetail(Detail);
  CreaTabDefault;
end;

procedure TWP555FContoAnnuale.actEliminaExecute(Sender: TObject);
begin
  MsgBox.WebMessageDlg((WR302DM as TWP555FContoAnnualeDM).P555FContoAnnualeMW.MessaggioCancellazione,mtConfirmation,[mbYes,mbNo],ResultConfermaElimina,'');
end;

procedure TWP555FContoAnnuale.ResultConfermaElimina(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
var
  WC020FInputDataOreFM: TWC020FInputDataOreFM;
begin
  if Res = mrYes then
  begin
    WC020FInputDataOreFM:=TWC020FInputDataOreFM.Create(Self);
    WC020FInputDataOreFM.ImpostaCampiText('Inserire il numero di dipendenti che verranno cancellati:','0');
    WC020FInputDataOreFM.ResultEvent:=ResultInputCancellazione;
    WC020FInputDataOreFM.Visualizza('Cancellazione di ' + (WR302DM as TWP555FContoAnnualeDM).P555FContoAnnualeMW.selP555canc.FieldByName('NUMDIP').AsString + ' dip.');
  end;
end;

procedure TWP555FContoAnnuale.ResultInputCancellazione(Sender: TObject; Result: Boolean; Valore: String);
begin
  if Result then
  begin
    if (Valore <> (WR302DM as TWP555FContoAnnualeDM).P555FContoAnnualeMW.selP555canc.FieldByName('NUMDIP').AsString) then
    begin
      MsgBox.WebMessageDlg(A000MSG_MSG_OPERAZIONE_ANNULLATA,mtInformation,[mbOk],nil,'');
      Exit;
    end;
    EseguiDelete;
  end;
end;

procedure TWP555FContoAnnuale.WC700CambioProgressivo(Sender: TObject);
begin
  if (WR302DM as TWP555FContoAnnualeDM).P555FContoAnnualeMW.SelAnagrafe = nil then
    Exit;
  inherited;
  WR302DM.selTabella.SearchRecord('ANNO;COD_TABELLA',
    VarArrayOf([WR302DM.selTabella.FieldByName('ANNO').AsInteger,WR302DM.selTabella.FieldByName('COD_TABELLA').AsString]),[srFromBeginning]);
  Detail.AggiornaDettaglio;
end;

procedure TWP555FContoAnnuale.WC700AperturaSelezione(Sender: TObject);
begin
  try
    grdC700.WC700FM.C700DataLavoro:=StrToDate('31/12/'+WR302DM.selTabella.FieldByName('ANNO').AsString);
  except
    grdC700.WC700FM.C700DataLavoro:=Parametri.DataLavoro;
  end;
  grdC700.WC700FM.C700DataDal:=grdC700.WC700FM.C700DataLavoro;
end;

end.
