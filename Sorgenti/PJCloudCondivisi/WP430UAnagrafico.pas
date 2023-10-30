unit WP430UAnagrafico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, WP430UAnagraficoDM, WP430UAnagraficoBrowseFM, OracleData,
  WP430UAnagraficoDettFM, Data.DB, medpIWMessageDlg, A000UInterfaccia, A000UMessaggi,
  WC015USelEditGridFM, IWCompEdit, meIWEdit, Oracle;

type
  TWP430FAnagrafico = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
    procedure actNuovoExecute(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);
  private
    bCopiaDaDip: Boolean;
    procedure ResultNuovo(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultElencoDipendenti(Sender: TObject; Result: Boolean);
    procedure imgNuovaStoricizzazioneClick(Sender: TObject); override;
  protected
    procedure CambioDataDecorrenza; override;
  public
    procedure RefreshPage; override;
    procedure SpostaStorico(Decorrenza: TDateTime);
    procedure WC700CambioProgressivo(Sender: TObject); override;
    function InizializzaAccesso: Boolean; override;
  end;

implementation

{$R *.dfm}

procedure TWP430FAnagrafico.IWAppFormCreate(Sender: TObject);
begin
  actCopiaSu.Visible:=False;
  inherited;
  InterfacciaWR102.GestioneStoricizzata:=True;
  WR302DM:=TWP430FAnagraficoDM.Create(Self);
  WBrowseFM:=TWP430FAnagraficoBrowseFM.Create(Self);
  AttivaGestioneC700;
  (WR302DM as TWP430FAnagraficoDM).P430FAnagraficoMW.SelAnagrafe:=grdC700.selAnagrafe;
  WDettaglioFM:=TWP430FAnagraficoDettFM.Create(Self);

  CreaTabDefault;
  (WR302DM as TWP430FAnagraficoDM).dsrTabellaStateChange(nil);//Abilitazione azioni in base a permessi utente
end;

function TWP430FAnagrafico.InizializzaAccesso: Boolean;
var
  Progressivo: Integer;
begin
  Result:=False;
  //Deve prendere il progressivo selezionato da parametro (passato da WA002)
  //e non il progressivo corrente della WA001
  //Se arriva da menu Progressivo non impostato e quindi posizionamento su progressivo corrente della wa001 (fatto su attivazione wc700)
  Progressivo:=StrToIntDef(GetParam('PROGRESSIVO'),0);
  if Progressivo > 0 then
  begin
    grdC700.WC700FM.C700Progressivo:=Progressivo;
    grdC700.WC700FM.actConfermaExecute(nil);
  end;
  CercaStoricoCorrente(Parametri.DataLavoro);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  Result:=True;
end;

procedure TWP430FAnagrafico.actModificaExecute(Sender: TObject);
begin
  inherited;
  chkStoriciSucc.checked:=True;
end;

procedure TWP430FAnagrafico.actNuovoExecute(Sender: TObject);
var
  WC015: TWC015FSelEditGridFM;
begin
  //Controllo fatto in SelTabellaStateChange, m in questo caso datto subito qui per evitare doppio msgBox
  if not VerificaSelezioneC700 then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_NO_DIP_INS,mtError,[mbOk],nil,'');
    Abort;
  end;

  // tenta di acquisire il lock sul record di T030
  if not (WR302DM AS TWP430FAnagraficoDM).P430FAnagraficoMW.TryLockRecordT030(grdC700.SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger) then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_P430_ERR_SCHEDA_LOCK));
  A000SessioneWEB.RiduciTimeOut;

  if (not MsgBox.KeyExists('PUNTO_1')) then
  begin
    MsgBox.WebMessageDlg(A000MSG_P430_DLG_COPIA_DIP,mtConfirmation,[mbYes,mbNo],ResultNuovo,'PUNTO_1');
    Exit;
  end;
  MsgBox.ClearKeys;

  inherited;

  if bCopiaDaDip then
  begin
    WC015:=TWC015FSelEditGridFM.Create(Self);
    with (WR302DM AS TWP430FAnagraficoDM) do
    begin
      P430FAnagraficoMW.ApriElencoDipendenti(True);
      WC015.medpCurrRecord:=False;//posizionarsi sul primo record ordinato per COGNOME
      WC015.medpSearchKind:=skInitial;
      WC015.medpSearchField:='COGNOME';
      WC015.ResultEvent:=ResultElencoDipendenti;
      WC015.Visualizza('Elenco dipendenti',P430FAnagraficoMW.selP430,False,False,True);
    end;
  end;
end;

procedure TWP430FAnagrafico.ResultElencoDipendenti(Sender: TObject; Result: Boolean);
begin
  if Result then
  begin
    with (WR302DM AS TWP430FAnagraficoDM) do
    begin
      P430FAnagraficoMW.CopiaDaDipendente;
      //Forzo aggiornamento componenti non data-aware
      (WDettaglioFM as TWP430FAnagraficoDettFM).DataSet2Componenti;
      MsgBox.WebMessageDlg(A000MSG_P430_MSG_COPIA_DIPENDENTE,mtInformation,[mbOk],nil,'');
      (WDettaglioFM as TWP430FAnagraficoDettFM).grdTabDetail.ActiveTab:=(WDettaglioFM as TWP430FAnagraficoDettFM).WP430DatiAggiuntiviRG;
    end;
  end;
end;

procedure TWP430FAnagrafico.ResultNuovo(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  bCopiaDaDip:=(R = mrYes);
  actNuovoExecute(actNuovo);
end;

procedure TWP430FAnagrafico.CambioDataDecorrenza;
begin
  inherited;
  //Il cambio di decorrenza fa variare i dataset di origine delle combo; viene fatto nel calcFields che si scatena settando il campo
  //Ricarico le multicolumnCombobox
  WDettaglioFM.CaricaMultiColumnCombobox;
end;

procedure TWP430FAnagrafico.imgNuovaStoricizzazioneClick(Sender: TObject);
begin
  inherited;
  chkStoriciSucc.checked:=True;
end;

procedure TWP430FAnagrafico.SpostaStorico(Decorrenza: TDateTime);
begin
  CercaStoricoCorrente(Decorrenza);
end;

procedure TWP430FAnagrafico.WC700CambioProgressivo(Sender: TObject);
begin
  inherited;
  with (WR302DM as TWP430FAnagraficoDM) do
  begin
    // visualizzazione pulsanti nuovo e modifica in funzione della presenza di record sul progressivo corrente
    actModifica.Visible:=selTabella.RecordCount > 0;
    actNuovo.Visible:=selTabella.RecordCount = 0;

    AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);

    CercaStoricoCorrente(Parametri.DataLavoro);
    WBrowseFM.grdTabella.medpAggiornaCDS(True);
    dsrTabellaStateChange(nil);//Abilitazione azioni in base a permessi utente
  end;
end;

procedure TWP430FAnagrafico.RefreshPage;
begin
  inherited;
  //Refresh relazioni
  with (WR302DM as TWP430FAnagraficoDM) do
  begin
    P430FAnagraficoMW.T480_COMUNI.Refresh;
    P430FAnagraficoMW.RefreshLookupCache(P430FAnagraficoMW.T480_COMUNI);
    //Devo reimpostare in caso descrizione cambiata. non è data-aware
    (WDettaglioFM as TWP430FAnagraficoDettFM).edtDescComuneInail.Text:=selTabella.FieldByName('D_COMUNE_INAIL').AsString;

    P430FAnagraficoMW.selI030.Refresh;
    P430FAnagraficoMW.selI035.Refresh;
    P430FAnagraficoMW.selI030.First;
    P430FAnagraficoMW.selCOLS.Refresh;
    P430FAnagraficoMW.RefreshVSQLAppoggio;

    if selTabella.State in [dsEdit,dsInsert] then
    begin
      //Ricarico combobox per eventuali cambiamenti
      (WDettaglioFM as TWP430FAnagraficoDettFM).CaricaMulticolumnCombobox;
      (WDettaglioFM as TWP430FAnagraficoDettFM).EseguiRelazioni('');
    end;
  end;

  (WDettaglioFM as TWP430FAnagraficoDettFM).VisualizzaDatiCalcoloAnf;
end;

end.
