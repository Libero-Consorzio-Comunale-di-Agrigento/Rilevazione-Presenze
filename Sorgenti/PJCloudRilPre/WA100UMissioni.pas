unit WA100UMissioni;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR103UGestMasterDetail, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink,WA100UMissioniDM, WA100UMissioniBrowseFM, WA100UMissioniDettFM,
  WA100UIndennitaKMFM, A000UMessaggi, A000UInterfaccia, medpIWMessageDlg,
  WA100URimborsiFM, WA100UDettaglioGGFM, WA100UAllegatiFM,
  WC020UInputDataOreFM, A000UCostanti, DB, meIWImageFile, C180FunzioniGenerali;

type
  TWA100FMissioni = class(TWR103FGestMasterDetail)
    actRicalcolaIndKM: TAction;
    actGestioneAnticipi: TAction;
    actImpRichRimb: TAction;
    actCheckRimborsi: TAction;
    actRiapriRichiestaMissione: TAction;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure actRicalcolaIndKMExecute(Sender: TObject);
    procedure actGestioneAnticipiExecute(Sender: TObject);
    procedure actImpRichRimbExecute(Sender: TObject);
    procedure actCheckRimborsiExecute(Sender: TObject);
    procedure actRiapriRichiestaMissioneExecute(Sender: TObject);
  private
    DataRicalcoloInizio, DataRicalcoloFine: TDateTime;
    GestTabAllegati: Boolean;
    procedure ResultRicalcolaIndennitaKM(Sender: TObject; Result: Boolean;Valore: String);
    procedure ResultMsgRicalcolo(Sender: TObject; Res: TmeIWModalResult;KeyID: String);
    procedure OnConfermaRiapriRichiesta(Sender: TObject; Res: TmeIWModalResult;
      KeyID: String);
  protected
    procedure RefreshPage; override;
    function  ActionForDownload(action : TAction): Boolean; override;
  public
    WA100FIndennitaKMFM: TWA100FIndennitaKMFM;
    WA100FRimborsiFM: TWA100FRimborsiFM;
    WA100FDettaglioGGFM: TWA100FDettaglioGGFM;
    WA100FAllegatiFM: TWA100FAllegatiFM;
    function  InizializzaAccesso:Boolean; override;
    procedure WC700CambioProgressivo(Sender: TObject); override;
  end;

implementation

{$R *.dfm}

procedure TWA100FMissioni.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  if Parametri.CampiRiferimento.C8_Missione = '' then
    raise Exception.Create('Regole non definite a livello aziendale!');
  WR302DM:=TWA100FMissioniDM.Create(Self);
  AttivaGestioneC700;
  (WR302DM as TWA100FMissioniDM).A100FMissioniMW.SelAnagrafe:=grdC700.selAnagrafe;
  WBrowseFM:=TWA100FMissioniBrowseFM.Create(Self);
  WDettaglioFM:=TWA100FMissioniDettFM.Create(Self);
  //Fare qui perchè prima frame di dettaglio non ancora creata
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    Q010Scroll:=(WDettaglioFM as TWA100FMissioniDettFM).GestioneCampi;
    ImpostaCampiElaboraMissione:=(WDettaglioFM as TWA100FMissioniDettFM).ImpostaCampiElaboraMissione;

    WA100FIndennitaKMFM:=TWA100FIndennitaKMFM.Create(Self);
    AggiungiDetail(WA100FIndennitaKMFM,'Indennità chilometriche');
    WA100FIndennitaKMFM.CaricaDettaglio(QM052,d052);

    WA100FRimborsiFM:=TWA100FRimborsiFM.Create(Self);
    AggiungiDetail(WA100FRimborsiFM,'Rimborsi');
    WA100FRimborsiFM.CaricaDettaglio(Q050,(WR302DM as TWA100FMissioniDM).dsrM050);

    WA100FDettaglioGGFM:=TWA100FDettaglioGGFM.Create(Self);
    AggiungiDetail(WA100FDettaglioGGFM,'Dettaglio gg');
    WA100FDettaglioGGFM.CaricaDettaglio(selM043,dsrM043);

    // MONDOEDP - commessa MAN/02 SVILUPPO#129.ini
    // gestione del tab "Allegati alle richieste"
    if GestioneAllegatiRichieste then
    begin
      WA100FAllegatiFM:=TWA100FAllegatiFM.Create(Self);
      AggiungiDetail(WA100FAllegatiFM,'Allegati alle richieste');
      WA100FAllegatiFM.CaricaDettaglio(selT960,dsrT960);
    end;
    // MONDOEDP - commessa MAN/02 SVILUPPO#129.fine
  end;
  CreaTabDefault;
end;

function TWA100FMissioni.InizializzaAccesso: Boolean;
begin
  Result:=False;
  if Parametri.CampiRiferimento.C8_Missione = '' then
  begin
    //Non usare Msgbox perchè la function restituirebbe quella dell'active form che non è ancora questa form
    FMsgBox.WebMessageDlg(A000MSG_A100_ERR_REGOLE_TRASFERTA,mtError,[mbOk],nil,'');
  end;
  WR302DM.selTabella.Last;
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  Result:=True;
end;

procedure TWA100FMissioni.actCheckRimborsiExecute(Sender: TObject);
begin
  inherited;
  AccediForm(74,'',True);
end;

procedure TWA100FMissioni.actGestioneAnticipiExecute(Sender: TObject);
var Params: String;
begin
  inherited;
  with (WR302DM as TWA100FMissioniDM) do
  begin
    Params:='PROGRESSIVO=' + grdC700.WC700DM.selAnagrafe.FieldByName('PROGRESSIVO').AsString + ParamDelimiter +
            'ID_MISSIONE=' + selTabella.FieldByName('ID_MISSIONE').AsString;
  end;
  AccediForm(177,Params,True);
end;

procedure TWA100FMissioni.actImpRichRimbExecute(Sender: TObject);
begin
  inherited;
  AccediForm(98,'',True);
end;

function TWA100FMissioni.ActionForDownload(action: TAction): Boolean;
begin
  if Action.Name = 'actFileDownload' then
    Result:=True
  else
    Result:=inherited;
end;

procedure TWA100FMissioni.actRicalcolaIndKMExecute(Sender: TObject);
var WC020FInputDataOreFM: TWC020FInputDataOreFM;
  Data: TDateTime;
begin
  inherited;
  if grdC700.SelAnagrafe.RecordCount = 0 then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_NO_DIP,mtError,[mbOk],nil,'');
    Exit;
  end;

  WC020FInputDataOreFM:=TWC020FInputDataOreFM.Create(Self);
  Data:=WR302DM.selTabella.FieldByName('MESESCARICO').AsDateTime;
  WC020FInputDataOreFM.ImpostaCampiPeriodo('Mese di scarico da: ','Mese di scarico a: ',Data, Data, 'mm/yyyy');
  WC020FInputDataOreFM.Visualizza('Ricalcolo indennità chilometriche');
  WC020FInputDataOreFM.ResultEvent:=ResultRicalcolaIndennitaKM;
end;

// TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.ini
procedure TWA100FMissioni.actRiapriRichiestaMissioneExecute(Sender: TObject);
begin
  MsgBox.WebMessageDlg('Confermi la riapertura della richiesta web?',mtConfirmation,[mbYes,mbNo],OnConfermaRiapriRichiesta,'','Conferma riapertura richiesta',mbNo);
end;

procedure TWA100FMissioni.OnConfermaRiapriRichiesta(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
var
  BM: TBookmark;
begin
  if Res = mrYes then
  begin
    // effettua riapertura richiesta
    (WR302DM as TWA100FMissioniDM).A100FMissioniMW.RiapriRichiestaMissione;

    // aggiorna dataset
    BM:=WR302DM.selTabella.GetBookmark;
    try
      WR302DM.selTabella.Refresh;
      if WR302DM.selTabella.BookmarkValid(BM) then
        WR302DM.selTabella.GotoBookmark(BM);
      WBrowseFM.grdTabella.medpAggiornaCDS(True);
    finally
      WR302DM.selTabella.FreeBookmark(BM);
    end;

    MsgBox.MessageBox('La richiesta web è stata riaperta.',INFORMA);
  end;
end;
// TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.fine

procedure TWA100FMissioni.IWAppFormRender(Sender: TObject);
var
  sMessaggio: String;
  i: Integer;
begin
  if WR302DM = nil then
    Exit;
  with (WR302DM as TWA100FMissioniDM) do
  begin
    if lstMessaggiAvviso = nil then
      Exit;
    sMessaggio:='';
    for i:=0 to lstMessaggiAvviso.Count - 1 do
      sMessaggio:=sMessaggio + lstMessaggiAvviso[i] + #13#10;
    lstMessaggiAvviso.Clear;
  end;
  if sMessaggio <> '' then
    MsgBox.WebMessageDlg(sMessaggio,mtError,[mbOk],nil,'');

  inherited;
end;

procedure TWA100FMissioni.ResultRicalcolaIndennitaKM(Sender: TObject; Result: Boolean; Valore: String);
var lstValori: TStringList;
begin
  if Result then
  begin
    try
      try
        lstValori:=TStringList.Create;
        lstValori.CommaText:=Valore;
        DataRicalcoloInizio:=StrToDate(lstValori[0]);
        DataRicalcoloFine:=StrToDate(lstValori[1]);
      except
        raise Exception.Create(A000MSG_ERR_DATA_ERRATA);
      end;
    finally
      FreeAndNil(lstValori);
    end;

    MsgBox.WebMessageDlg(Format(A000MSG_A100_MSG_FMT_RICALCOLO,[FormatDateTime('mm/yyyy',DataRicalcoloInizio),FormatDateTime('mm/yyyy',DataRicalcoloFine)]),mtConfirmation,[mbYes,mbNo],ResultMsgRicalcolo,'');
    Abort;
  end;
end;

procedure TWA100FMissioni.RefreshPage;
begin
  inherited;
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    //rimborsi
    if (Q050.State = dsBrowse) and (not Q050.UpdatesPending) then
    begin
      Q050.Refresh;
      WA100FRimborsiFM.grdTabella.medpAggiornaCDS(true);
    end;
    Q020.refresh;
    if (Q050.State in [dsInsert,dsEdit]) then
    begin
      //ricarico combo tipi rimborso
      WA100FRimborsiFM.CaricaComboTipiRimborso;
    end;
    if QM021.Active then
      QM021.Refresh;
    if (QM052.State in [dsInsert,dsEdit]) then
    begin
      //ricarico combo tipi Indennita
      WA100FIndennitaKMFM.CaricaComboTipoIndennita;
    end;
    selM065.Refresh;
    selM066.Refresh;
    if WR302DM.selTabella.state in [dsInsert, dsEdit] then
    begin
      (WDettaglioFM as TWA100FMissioniDettFM).CaricaComboCodiceTariffa;
      (WDettaglioFM as TWA100FMissioniDettFM).CaricaComboCodiceRiduzione;
    end;
  end;
end;

procedure TWA100FMissioni.ResultMsgRicalcolo(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
  begin
    with (WR302DM as TWA100FMissioniDM) do
    begin
      //Ricerco tutte le indennità chilometriche che cadono nel periodo indicato...
      A100FMissioniMW.SelM052.Close;
      A100FMissioniMW.SelM052.SetVariable('datada', DataRicalcoloInizio);
      A100FMissioniMW.SelM052.SetVariable('dataa', DataRicalcoloFine);
      grdC700.WC700FM.C700MergeSelAnagrafe(A100FMissioniMW.SelM052);
      grdC700.WC700FM.C700MergeSettaPeriodo(A100FMissioniMW.SelM052,Parametri.DataLavoro,Parametri.DataLavoro);
      A100FMissioniMW.RicalcolaIndennitaKM;
      WA100FIndennitaKMFM.AggiornaDettaglio;
    end;
  end;
end;

procedure TWA100FMissioni.WC700CambioProgressivo(Sender: TObject);
begin
  inherited;
  (WR302DM as TWA100FMissioniDM).A100FMissioniMW.AggiornaDati;
end;

end.
