unit WA056UTurnazInd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions, OracleData, StrUtils,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, medpIWMessageDlg,
  meIWLink, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, WC015USelEditGridFM,
  IWRegion, meIWRegion, IWCompCheckbox, meIWCheckBox, IWCompEdit, medpIWC700NavigatorBar, A000UMessaggi,
  WC700USelezioneAnagrafeFM, medpIWMultiColumnComboBox, meIWEdit, meIWRadioGroup, A000UInterfaccia,
  C180FunzioniGenerali, meIWImageFile, Oracle;

type
  TWA056FTurnazInd = class(TWR102FGestTabella)
    WA056AssegnaTurniRG: TmeIWRegion;
    TemplateAssegnaTurniRG: TIWTemplateProcessorHTML;
    chkDipendenteCorrente: TmeIWCheckBox;
    cmbTurnazione: TMedpIWMultiColumnComboBox;
    lblDescrTurnazione: TmeIWLabel;
    lblDataPartenza: TmeIWLabel;
    edtDataPartenza: TmeIWEdit;
    lblPuntoPartenza: TmeIWLabel;
    EdtPuntoPartenza: TmeIWEdit;
    btnPuntoPartenza: TmeIWButton;
    lblParInserimento: TmeIWLabel;
    ChkPianifDaCalendario: TmeIWCheckBox;
    chkGGLav: TmeIWCheckBox;
    chkRiposi: TmeIWCheckBox;
    chkInsAutomatico: TmeIWCheckBox;
    chkPregresso: TmeIWCheckBox;
    lnkTurnazione: TmeIWLink;
    actAssegnaTurno: TAction;
    procedure IWAppFormCreate(Sender: TObject);
    procedure lnkTurnazioneClick(Sender: TObject);
    procedure cmbTurnazioneAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure edtDataPartenzaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnPuntoPartenzaClick(Sender: TObject);
    procedure chkDipendenteCorrenteAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure chkInsAutomaticoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure actNuovoExecute(Sender: TObject);override;
    procedure actEliminaExecute(Sender: TObject);override;
    procedure actAssegnaTurnoExecute(Sender: TObject);
  private
    WC015: TWC015FSelEditGridFM;
    SelectedAction: TAction;
    procedure InizializzaComponenti;
    procedure CaricaElencoTurnazioni;
    procedure WC700CambioProgressivo(Sender: TObject); override;
    procedure PartenzaTurnoSelezionato(Sender: TObject;Result: Boolean);
    procedure EseguiAzione(Sender: TObject);
    procedure ResultInserisci(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ResultElimina(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    //Gestione ProgressBar ini
    procedure InizioElaborazione; override;
    function TotalRecordsElaborazione: Integer; override;
    function CurrentRecordElaborazione: Integer; override;
    procedure ElaboraElemento; override;
    function ElementoSuccessivo: Boolean; override;
    procedure FineCicloElaborazione; override;
  protected
    procedure ImpostazioniWC700; override;
    procedure WC700AperturaSelezione(Sender: TObject); override;
  public
    { Public declarations }
    procedure AggiornaComponenti;
  end;


implementation

uses WA056UTurnazIndDM, WA056UTurnazIndBrowseFM;

{$R *.dfm}

procedure TWA056FTurnazInd.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  InterfacciaWR102.TemplateAutomatico:=False;
  WR302DM:=TWA056FTurnazIndDM.Create(Self);
  //creato grdC700 prima di AttivaGestioneC700 per impostare le altre proprietà non standard
  grdC700:=TmedpIWC700NavigatorBar.Create(Self);
  (WR302DM as TWA056FTurnazIndDM).A056MW.SelAnagrafe:=grdC700.selAnagrafe;
  AttivaGestioneC700;
  WBrowseFM:=TWA056FTurnazIndBrowseFM.Create(Self);
  InizializzaComponenti;
end;

procedure TWA056FTurnazInd.InizializzaComponenti;
begin
  CaricaElencoTurnazioni;
  chkDipendenteCorrente.Checked:=False;
  chkDipendenteCorrenteAsyncClick(nil,nil);
  chkInsAutomaticoAsyncClick(nil,nil);
  chkGGLav.Checked:=True;
  chkRiposi.Checked:=True;
  edtDataPartenza.Text:=DateToStr(Parametri.DataLavoro);
end;

procedure TWA056FTurnazInd.CaricaElencoTurnazioni;
begin
  cmbTurnazione.Text:='';
  lblDescrTurnazione.Caption:='';
  cmbTurnazione.Items.Clear;
  with (WR302DM as TWA056FTurnazIndDM).A056MW.Q640 do
  begin
    First;
    while not Eof do
    begin
      cmbTurnazione.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
    First;
  end;
end;

procedure TWA056FTurnazInd.AggiornaComponenti;
begin
  (*
  cmbTurnazione.Text:='';
  lblDescrTurnazione.Caption:='';
  if (WR302DM as TWA056FTurnazIndDM).selTabella.FieldByName('TURNAZIONE').AsString <> '' then
  begin
    cmbTurnazione.Text:=(WR302DM as TWA056FTurnazIndDM).selTabella.FieldByName('TURNAZIONE').AsString;
    lblDescrTurnazione.Caption:=VarToStr((WR302DM as TWA056FTurnazIndDM).A056MW.Q640.Lookup('CODICE',cmbTurnazione.Text,'DESCRIZIONE'));
  end;*)
  if cmbTurnazione.Text <> '' then
    with (WR302DM as TWA056FTurnazIndDM) do
      A056MW.CalcolaSviluppo(cmbTurnazione.Text);
  (*
  edtDataPartenza.Text:=(WR302DM as TWA056FTurnazIndDM).selTabella.FieldByName('DATA').AsString;
  edtPuntoPartenza.Text:=(WR302DM as TWA056FTurnazIndDM).selTabella.FieldByName('PARTENZA').AsString;*)
end;

procedure TWA056FTurnazInd.ImpostazioniWC700;
begin
  inherited;
  with grdC700.WC700FM do
  begin
    C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
    C700DatiSelezionati:=C700CampiBase + ',T430SQUADRA, T430TIPOOPE, T430CALENDARIO';
    C700DataLavoro:=Parametri.DataLavoro;
  end;
end;

procedure TWA056FTurnazInd.WC700AperturaSelezione(Sender: TObject);
begin
  grdC700.WC700FM.C700DataLavoro:=(WR302DM as TWA056FTurnazIndDM).A056MW.Data;
end;

procedure TWA056FTurnazInd.WC700CambioProgressivo(Sender: TObject);
begin
  inherited;
  //Combo ETurnazione elenca solo i codici di T640 che sono riportati in T603, per la squadra corrispondente a quella su T430.
  //Propone il codice usato su T620 alla data specificata. Se non trovato, quello alla data più recente. Altrimenti, il primo della lista.
  (WR302DM as TWA056FTurnazIndDM).A056MW.LeggiSquadraStorico;
  CaricaElencoTurnazioni;
  (WR302DM as TWA056FTurnazIndDM).SelTabella.Close;
  (WR302DM as TWA056FTurnazIndDM).SelTabella.SetVariable('Progressivo',grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  (WR302DM as TWA056FTurnazIndDM).SelTabella.Open;
  (WR302DM as TWA056FTurnazIndDM).SelTabella.SearchRecord('DATA',(WR302DM as TWA056FTurnazIndDM).A056MW.Data,[srFromBeginning]);
  if (WR302DM as TWA056FTurnazIndDM).SelTabella.RecordCount > 0 then
    cmbTurnazione.Text:=(WR302DM as TWA056FTurnazIndDM).SelTabella.FieldByName('Turnazione').AsString
  else
    cmbTurnazione.Text:=(WR302DM as TWA056FTurnazIndDM).A056MW.Q640.FieldByName('Codice').AsString;
  lblDescrTurnazione.Caption:=VarToStr((WR302DM as TWA056FTurnazIndDM).A056MW.Q640.Lookup('CODICE',cmbTurnazione.Text,'DESCRIZIONE'));
  if (WR302DM as TWA056FTurnazIndDM).SelTabella.FieldByName('PIANIF_DA_CALENDARIO').AsString = 'S' then
    ChkPianifDaCalendario.Checked:=True
  else
    ChkPianifDaCalendario.Checked:=False;
end;

procedure TWA056FTurnazInd.lnkTurnazioneClick(Sender: TObject);
begin
  //OpenA055Turnazioni(ETurnazione.Text);
  AccediForm(127,'CODICE='+cmbTurnazione.Text);
end;

procedure TWA056FTurnazInd.cmbTurnazioneAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  lblDescrTurnazione.Caption:='';
  if cmbTurnazione.Text <> '' then
    with (WR302DM as TWA056FTurnazIndDM).A056MW do
    begin
      if Q640.SearchRecord('CODICE',cmbTurnazione.Text,[srFromBeginning]) then
        lblDescrTurnazione.Caption:=Q640.FieldByName('DESCRIZIONE').AsString;
      CalcolaSviluppo(cmbTurnazione.Text);
    end;
end;

procedure TWA056FTurnazInd.edtDataPartenzaAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  try
    (WR302DM as TWA056FTurnazIndDM).A056MW.Data:=StrToDate(edtDataPartenza.Text);
  except
    edtDataPartenza.Text:='';
    edtDataPartenza.SetFocus;
    Exit;
  end;
end;

procedure TWA056FTurnazInd.btnPuntoPartenzaClick(Sender: TObject);
begin
  inherited;
  (WR302DM as TWA056FTurnazIndDM).CaricaCdsSviluppoTurnaz;
  WC015:=TWC015FSelEditGridFM.Create(Self);
  WC015.ResultEvent:=PartenzaTurnoSelezionato;
  WC015.ConfermaAutomatica:=True;
  WC015.Visualizza('Scelta punto di partenza turnazione ' + cmbTurnazione.Text,(WR302DM as TWA056FTurnazIndDM).cdsSviluppoTurnaz,False,False,True);
end;

procedure TWA056FTurnazInd.PartenzaTurnoSelezionato(Sender: TObject;Result: Boolean);
begin
  if Result then
    edtPuntoPartenza.Text:=(WR302DM as TWA056FTurnazIndDM).cdsSviluppoTurnaz.FieldByName('NUM_GIORNO').AsString;
end;

procedure TWA056FTurnazInd.chkDipendenteCorrenteAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  chkInsAutomatico.Enabled:=chkDipendenteCorrente.Checked;
  if not chkInsAutomatico.Enabled then
    chkInsAutomatico.Checked:=False;
  chkInsAutomaticoAsyncClick(nil,nil);
end;

procedure TWA056FTurnazInd.chkInsAutomaticoAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  chkPregresso.Enabled:=chkInsAutomatico.Checked;
  if not chkPregresso.Enabled then
    chkPregresso.Checked:=False;
end;

procedure TWA056FTurnazInd.actNuovoExecute(Sender: TObject);
begin
  EseguiAzione(Sender);
end;

procedure TWA056FTurnazInd.actEliminaExecute(Sender: TObject);
begin
  EseguiAzione(Sender);
end;

procedure TWA056FTurnazInd.actAssegnaTurnoExecute(Sender: TObject);
begin
  with (WR302DM as TWA056FTurnazIndDM) do
  begin
    A056MW.A056PCKT080TURNO.CalcolaDatiADATA(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,A056MW.Data);
    edtPuntoPartenza.Text:=IntToStr(A056MW.A056PCKT080TURNO.GetPartenza);
    cmbTurnazione.Text:=selTabella.FieldByName('TURNAZIONE').AsString;
    lblDescrTurnazione.Caption:=VarToStr(A056MW.Q640.Lookup('CODICE',cmbTurnazione.Text,'DESCRIZIONE'));
  end;
end;

procedure TWA056FTurnazInd.EseguiAzione(Sender: TObject);
{Inserisco la turnazione specificata cancellando eventualmente una già esistente
 nella stessa data}
var ProgOld:Integer;
begin
  edtDataPartenzaAsyncChange(nil,nil);
  ProgOld:=grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  if grdC700.WC700FM.C700SettaPeriodoSelAnagrafe((WR302DM as TWA056FTurnazIndDM).A056MW.Data,(WR302DM as TWA056FTurnazIndDM).A056MW.Data) then
    grdC700.selAnagrafe.CloseAll;
  grdC700.selAnagrafe.Open;
  if not grdC700.selAnagrafe.SearchRecord('PROGRESSIVO',ProgOld,[srFromBeginning]) then
    raise exception.Create(A000MSG_A056_ERR_NO_DIP);
  if grdC700.selAnagrafe.RecordCount = 0 then
    raise Exception.create(A000MSG_ERR_NO_DIP);
  SelectedAction:=(Sender as TAction);
  if cmbTurnazione.Text = ''then
    raise Exception.create(A000MSG_A056_ERR_TURNAZIONE);
  if (Trim(edtPuntoPartenza.Text) = '') or ((WR302DM as TWA056FTurnazIndDM).A056MW.Turno1.Count = 0) then
    raise Exception.create(A000MSG_A056_ERR_TURNAZ_INESISTENTE);
  if Sender = actElimina then
    if not MsgBox.KeyExists('KEY_ELIMINA') then
    begin
      MsgBox.WebMessageDlg(IfThen(chkDipendenteCorrente.Checked,A000MSG_A056_DLG_CANCELLAZIONE,A000MSG_DLG_CANCELLAZIONE),mtConfirmation,[mbYes, mbNo],ResultElimina,'KEY_ELIMINA');
      Abort;
    end;
  if (Sender = actNuovo) and chkDipendenteCorrente.Checked then
    if not MsgBox.KeyExists('KEY_INSERISCI') then
    begin
      MsgBox.WebMessageDlg(A000MSG_A056_DLG_INSERIMENTO,mtConfirmation,[mbYes, mbNo],ResultInserisci,'KEY_INSERISCI');
      Abort;
    end;

  MsgBox.ClearKeys;
  if (Sender = actElimina) or (Not chkInsAutomatico.Checked) then
    StartElaborazioneCiclo(btnSendFile.HTMLName)
  else
    (WR302DM as TWA056FTurnazIndDM).AssegnazioneAutomatica;
end;

procedure TWA056FTurnazInd.ResultInserisci(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
    EseguiAzione(actNuovo)
  else
    MsgBox.ClearKeys;
end;

procedure TWA056FTurnazInd.ResultElimina(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
    EseguiAzione(actElimina)
  else
    MsgBox.ClearKeys;
end;

//Gestione ProgressBar ini
procedure TWA056FTurnazInd.InizioElaborazione;
begin
  if chkDipendenteCorrente.Checked then
    grdC700.SelAnagrafe.First;
end;

function TWA056FTurnazInd.TotalRecordsElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecordCount;
end;

function TWA056FTurnazInd.CurrentRecordElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecNO;
end;

procedure TWA056FTurnazInd.ElaboraElemento;
begin
  with (WR302DM as TWA056FTurnazIndDM) do
  begin
    if SelectedAction = actNuovo then
      A056MW.InserisciTurnazInd(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger)
    else
      A056MW.CancellaTurnazInd(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  end;
end;

function TWA056FTurnazInd.ElementoSuccessivo: Boolean;
begin
  Result:=False;
  if not chkDipendenteCorrente.Checked then
    Result:=False
  else
  begin
    grdC700.selAnagrafe.Next;
    if not grdC700.selAnagrafe.EOF then
      Result:=True;
  end;
end;

procedure TWA056FTurnazInd.FineCicloElaborazione;
begin
  actAggiornaExecute(nil);
end;
//Gestione ProgressBar fine

end.
