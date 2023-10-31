unit A159UArchiviazioneCartellini;

interface

uses
  Oracle, StrUtils,
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Actions, Vcl.ActnList, OracleData, Data.DB,
  Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin, Vcl.ExtCtrls, Vcl.Menus, Vcl.StdCtrls, Vcl.ImgList,
  System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, FileCtrl, Vcl.Mask,
  Vcl.CheckLst, Vcl.DBCtrls, TABELLE99, R500Lin,
  A000UMessaggi, A000UInterfaccia, A000USessione,
  A159UArchiviazioneCartelliniMW, A083UMsgElaborazioni,
  C004UParamForm, C020UVisualizzaDataSet, C180FunzioniGenerali,
  C600USelAnagrafe, C600USelezioneAnagrafe, InputPeriodo, System.ImageList;

type
  TA159FArchiviazioneCartellini = class(TFrmTabelle99)
    ActionList1: TActionList;
    actAvvio: TAction;
    actLeggiLog: TAction;
    ImageList1: TImageList;
    pnl1: TPanel;
    tlb1: TToolBar;
    btnStart: TToolButton;
    btn8: TToolButton;
    btnLeggiLog: TToolButton;
    dsrV430: TDataSource;
    rgpGenerazionePDF: TRadioGroup;
    grpPeriodo: TGroupBox;
    Label4: TLabel;
    edtPathPDF: TEdit;
    Label5: TLabel;
    edtFilePDF: TEdit;
    chkSovrascrivi: TCheckBox;
    lblAnomalie: TLabel;
    C600frmSelAnagrafe: TC600frmSelAnagrafe;
    grpParametrizzazione: TGroupBox;
    dlblParametrizzazione: TDBText;
    dcmbParametrizzazione: TDBLookupComboBox;
    pmnAnomalie: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    chkParametrizzazioniTipoCartellino: TCheckBox;
    lstAnomalie: TCheckListBox;
    chkAggSchedaRiep: TCheckBox;
    ProgressBar1: TProgressBar;
    btnImpostazioniAziendali: TButton;
    frmInputPeriodo: TfrmInputPeriodo;
    chkInviaRegistro: TCheckBox;
    dcmbElencoRegistri: TDBLookupComboBox;
    lblElencoRegistri: TLabel;
    procedure actLeggiLogExecute(Sender: TObject);
    procedure actAvvioExecute(Sender: TObject);
    procedure actEsciExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TC600frmSelAnagrafe1btnSelezioneClick(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Annullatutto1Click(Sender: TObject);
    procedure C600frmSelAnagrafebtnEreditaSelezioneClick(Sender: TObject);
    procedure btnImpostazioniAziendaliClick(Sender: TObject);
    procedure chkInviaRegistroClick(Sender: TObject);
  private
    procedure ResettaProgressBar;
    procedure IncrementaProgressBar;
    procedure MaxProgressBar(Max:Integer);
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure EseguiOperazione;
    { Metodi Property }
    function _GetDataI: TDateTime;
    procedure _PutDataI(const Value: TDateTime);
    function _GetDataF: TDateTime;
    procedure _PutDataF(const Value: TDateTime);
  public
    A159MW: TA159FArchiviazioneCartelliniMW;

    { Property }
    property DataI:TDateTime read _GetDataI write _PutDataI;
    property DataF:TDateTime read _GetDataF write _PutDataF;
  end;

var
  A159FArchiviazioneCartellini: TA159FArchiviazioneCartellini;

procedure OpenA159ArchiviazioneCartellini(PeriodoDal, PeriodoAl: TDateTime);

implementation

{$R *.dfm}

procedure OpenA159ArchiviazioneCartellini(PeriodoDal, PeriodoAl: TDateTime);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA159ArchiviazioneCartellini') of
    'N':begin
          ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
          Exit;
        end;
    'R':SolaLettura:=True;
  end;
  try
    Application.CreateForm(TA159FArchiviazioneCartellini, A159FArchiviazioneCartellini);
    A159FArchiviazioneCartellini.DataI:=PeriodoDal;
    A159FArchiviazioneCartellini.DataF:=PeriodoAl;
    A159FArchiviazioneCartellini.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    Screen.Cursor:=crDefault;
    FreeAndNil(A159FArchiviazioneCartellini);
  end;
end;

procedure TA159FArchiviazioneCartellini.FormCreate(Sender: TObject);
begin
  A000SettaVariabiliAmbiente;
  A159MW:=TA159FArchiviazioneCartelliniMW.Create(nil);
  A159MW.ResettaProgressBar:=ResettaProgressBar;
  A159MW.IncrementaProgressBar:=IncrementaProgressBar;
  A159MW.MaxProgressBar:=MaxProgressBar;
  DataI:=R180InizioMese(Parametri.DataLavoro);
  DataF:=R180FineMese(Parametri.DataLavoro);
end;

procedure TA159FArchiviazioneCartellini.FormShow(Sender: TObject);
var
  Alias: String;
  i: Integer;
begin
  Alias:=Parametri.Database;

  //caricamento checklistbox
  lstAnomalie.Items.Clear;
  for i:=low(tdescanom2) to High(tdescanom2) do
  begin
    if A000FiltroDizionario('ANOMALIE DEI CONTEGGI','A2_' + IntToStr(tdescanom2[i].N)) then
      lstAnomalie.Items.Add(R180DimLung('2_' + IntToStr(tdescanom2[i].N),6) + ' ' + tdescanom2[i].D);
  end;
  for i:=low(tdescanom3) to High(tdescanom3) do
  begin
    if A000FiltroDizionario('ANOMALIE DEI CONTEGGI','A3_' + IntToStr(tdescanom3[i].N)) then
      lstAnomalie.Items.Add(R180DimLung('3_' + IntToStr(tdescanom3[i].N),6) + ' ' + tdescanom3[i].D);
  end;

  try
    CreaC004(SessioneOracle,Copy(Self.Name,1,4),Parametri.ProgOper);
    GetParametriFunzione;
  except
  end;

  // inizializzazione frame
  C600frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,1,False);
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.OpenC600SelAnagrafe:=True;//False;
  C600frmSelAnagrafe.C600DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.C600DatiSelezionati:=C600CampiBase + ',CODFISCALE';
  C600frmSelAnagrafe.SelezionePeriodica:=True;
  A159MW.SelAnagrafe:=C600frmSelAnagrafe.C600SelAnagrafe;
  dsrV430.DataSet:=C600frmSelAnagrafe.C600SelAnagrafe;

  chkInviaRegistro.Enabled:=A159MW.InviareRegistro;
  chkInviaRegistro.Checked:=chkInviaRegistro.Enabled;
  dcmbElencoRegistri.Enabled:=chkInviaRegistro.Checked;
  lblElencoRegistri.Enabled:=chkInviaRegistro.Checked;

  chkSovrascrivi.Enabled:=not A159MW.Versionabile; //se la tipologia è versionabile, il chkSovrascrivi è ininfluente
  chkSovrascrivi.Checked:=not A159MW.Versionabile and chkSovrascrivi.Checked;

  if not R180In(Parametri.Operatore,['MONDOEDP','SYSMAN']) then
  begin
    edtPathPDF.Enabled:=False;
    edtFilePDF.Enabled:=False;
    btnImpostazioniAziendali.Enabled:=False;
    chkSovrascrivi.Enabled:=False;
    rgpGenerazionePDF.Enabled:=False;
    chkAggSchedaRiep.Enabled:=False;
  end;
end;

procedure TA159FArchiviazioneCartellini.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PutParametriFunzione;
end;

procedure TA159FArchiviazioneCartellini.FormDestroy(Sender: TObject);
begin
  C600frmSelAnagrafe.DistruggiSelAnagrafe;
  C004FParamForm.Free;
  FreeAndNil(A159MW);
end;

// ########################################################################## //

procedure TA159FArchiviazioneCartellini.MaxProgressBar(Max:Integer);
begin
  ProgressBar1.Max:=Max;
  ProgressBar1.Position:=0;
end;

procedure TA159FArchiviazioneCartellini.IncrementaProgressBar;
begin
  ProgressBar1.StepBy(1);
  C600frmSelAnagrafe.VisualizzaDipendente;
end;

procedure TA159FArchiviazioneCartellini.ResettaProgressBar;
begin
  ProgressBar1.Position:=0;
  C600frmSelAnagrafe.VisualizzaDipendente;
end;

procedure TA159FArchiviazioneCartellini.actAvvioExecute(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;
  try
    EseguiOperazione;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA159FArchiviazioneCartellini.actLeggiLogExecute(Sender: TObject);
// lettura dei messaggi di log da I005 / I006
begin
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A159','');
end;

procedure TA159FArchiviazioneCartellini.Annullatutto1Click(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  for i:=0 to lstAnomalie.Items.Count - 1 do
    lstAnomalie.Checked[i]:=False;
end;

procedure TA159FArchiviazioneCartellini.btnImpostazioniAziendaliClick(Sender: TObject);
begin
  inherited;
  edtPathPDF.Text:=A159MW.selI210.FieldByName('PATH_FILE').AsString;
  edtFilePDF.Text:=A159MW.selI210.FieldByName('FILE_PDF').AsString;
  chkSovrascrivi.Checked:=not A159MW.Versionabile and (A159MW.selI210.FieldByName('SOSTITUZIONE_FILE').AsString = 'S');
end;

procedure TA159FArchiviazioneCartellini.C600frmSelAnagrafebtnEreditaSelezioneClick(Sender: TObject);
begin
  inherited;
  C600frmSelAnagrafe.btnEreditaSelezioneClick(Sender);
end;

procedure TA159FArchiviazioneCartellini.chkInviaRegistroClick(Sender: TObject);
begin
  inherited;
  dcmbElencoRegistri.KeyValue:='';
  dcmbElencoRegistri.Enabled:=chkInviaRegistro.Checked;
  lblElencoRegistri.Enabled:=chkInviaRegistro.Checked;
end;

procedure TA159FArchiviazioneCartellini.actEsciExecute(Sender: TObject);
begin
  Close;
end;

procedure TA159FArchiviazioneCartellini.GetParametriFunzione;
// estrae i parametri della maschera su database
begin
  if R180In(Parametri.Operatore,['MONDOEDP','SYSMAN']) and (A159MW.selI210.FieldByName('PATH_FILE').AsString <> 'DB') then
  begin
    edtPathPDF.Text:=C004FParamForm.GetParametro('PATH_PDF',A159MW.selI210.FieldByName('PATH_FILE').AsString);
    edtFilePDF.Text:=C004FParamForm.GetParametro('FILE_PDF',A159MW.selI210.FieldByName('FILE_PDF').AsString);
    chkSovrascrivi.Checked:=C004FParamForm.GetParametro('SOSTITUZIONE_FILE',A159MW.selI210.FieldByName('SOSTITUZIONE_FILE').AsString) = 'S';
  end
  else
  begin
    edtPathPDF.Text:=A159MW.selI210.FieldByName('PATH_FILE').AsString;
    edtFilePDF.Text:=A159MW.selI210.FieldByName('FILE_PDF').AsString;
    chkSovrascrivi.Checked:=A159MW.selI210.FieldByName('SOSTITUZIONE_FILE').AsString = 'S';
  end;

  edtPathPDF.Enabled:=edtPathPDF.Text <> 'DB';
  edtFilePDF.Enabled:=edtPathPDF.Enabled;
  btnImpostazioniAziendali.Enabled:=edtPathPDF.Enabled;

  R180PutCheckList(C004FParamForm.GetParametro('ANOMALIE',''), LUNG_COD_ANOM, lstAnomalie);
  dcmbParametrizzazione.KeyValue:=C004FParamForm.GetParametro('PAR_CARTELLINO','STD');
  chkParametrizzazioniTipoCartellino.Checked:=C004FParamForm.GetParametro('PAR_TIPOCARTELLINO','N') = 'S';
  chkInviaRegistro.Checked:=C004FParamForm.GetParametro('PAR_INVIAREGISTRO','N') = 'S';
end;

procedure TA159FArchiviazioneCartellini.PutParametriFunzione;
// salva i parametri della maschera su database
begin
  try
    C004FParamForm.Cancella001;
    if R180In(Parametri.Operatore,['MONDOEDP','SYSMAN']) then
    begin
      if Trim(edtPathPdf.Text) <> '' then
        C004FParamForm.PutParametro('PATH_PDF',edtPathPdf.Text);
      if Trim(edtFilePdf.Text) <> '' then
        C004FParamForm.PutParametro('FILE_PDF',edtFilePdf.Text);
      C004FParamForm.PutParametro('SOSTITUZIONE_FILE',IfThen(chkSovrascrivi.Checked,'S','N'));
    end;
    C004FParamForm.PutParametro('ANOMALIE',R180GetCheckList(LUNG_COD_ANOM, lstAnomalie));
    C004FParamForm.PutParametro('PAR_CARTELLINO',dcmbParametrizzazione.KeyValue);
    C004FParamForm.PutParametro('PAR_TIPOCARTELLINO',IfThen(chkParametrizzazioniTipoCartellino.Checked,'S','N'));
    C004FParamForm.PutParametro('PAR_INVIAREGISTRO',IfThen(chkInviaRegistro.Checked,'S','N'));
    SessioneOracle.Commit;
  except
    SessioneOracle.Rollback;
  end;
end;

procedure TA159FArchiviazioneCartellini.Selezionatutto1Click(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  for i:=0 to lstAnomalie.Items.Count - 1 do
    lstAnomalie.Checked[i]:=True;
end;

procedure TA159FArchiviazioneCartellini.TC600frmSelAnagrafe1btnSelezioneClick(Sender: TObject);
var S, MioFiltro:String;
begin
  if (DataI > 0) and (DataF > 0) then
  begin
    C600frmSelAnagrafe.C600DataLavoro:=DataF;
    C600frmSelAnagrafe.C600DataDal:=DataI;
  end
  else
  begin
    C600frmSelAnagrafe.C600DataLavoro:=R180FineMese(Date);
    C600frmSelAnagrafe.C600DataDal:=R180InizioMese(Date);
  end;
  C600frmSelAnagrafe.btnSelezioneClick(Sender);
  if C600frmSelAnagrafe.C600ModalResult = mrOK then
  begin
    S:=Trim(C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text);
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    MioFiltro:=MioFiltro + S;
  end;
end;

procedure TA159FArchiviazioneCartellini.EseguiOperazione;
// procedura di gestione: controlla pianificazione ed esegue l'elaborazione
var
  ok, numFile: Integer;
begin
  //se è richiesto solamente l'invio di un registro salvato su db
  if chkInviaRegistro.Checked and (dcmbElencoRegistri.Text <> '') and (not A159MW.isService) then
  begin
    if MessageDlg(A000MSG_A159_DLG_INVIA_REGISTRO, mtConfirmation, mbOKCancel, 0) = mrOK then
    begin
      A159MW.InviaRegistroSalvato;

      if RegistraMsg.ContieneTipoA then //gestisco la presenza di anomalie per il solo invio del registro
      begin
        if R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,DOMANDA) = mrYes then
          actLeggiLogExecute(nil);
      end
      else
        ShowMessage(A000MSG_MSG_ELABORAZIONE_TERMINATA);
    end;

    Exit;
  end;

  if dsrV430.DataSet.RecordCount < 1 then
    raise Exception.Create('Non è stato selezionato nessun dipendente');
  //controllo filtri periodo
  if (DataI > 0) and (DataF > 0) then
  begin
    if DataI > DataF then
      raise Exception.Create('Le date di inizio e di fine sono invertite');
  end
  else
  begin
    if DataI > 0 then
    begin
      if A159MW.isService then
        raise Exception.Create('Data fine periodo non corretta')
      else
      begin
        ShowMessage('Data fine periodo non corretta');
        frmInputPeriodo.edtFine.SetFocus; //edtPeriodoAl.Text:='''  /  /    ';
      end;
    end
    else if DataF > 0 then
    begin
      if A159MW.isService then
        raise Exception.Create('Data inizio periodo non corretta')
      else
      begin
        ShowMessage('Data inizio periodo non corretta');
        frmInputPeriodo.edtInizio.SetFocus; //edtPeriodoDal.Text:='''  /  /    ';
      end;
    end
    else
      raise Exception.Create('Nessuna delle due date è corretta');
  end;
  //modifica del periodo su c600
  if C600frmSelAnagrafe.SettaPeriodoSelAnagrafe(DataI, DataF) then
    C600frmSelAnagrafe.C600SelAnagrafe.Close;
  C600frmSelAnagrafe.C600SelAnagrafe.Open;
  //inizializzazione variabili pubbliche MW
  A159MW.PeriodoDal:=DataI;
  A159MW.PeriodoAl:=DataF;
  A159MW.SingoloMese:=rgpGenerazionePDF.Items[rgpGenerazionePDF.ItemIndex] = 'File mensile';
  A159MW.Parametrizzazione:=dcmbParametrizzazione.Text;
  A159MW.Anomalie:=R180GetCheckList(LUNG_COD_ANOM, lstanomalie);
  A159MW.Sovrascrivi:=chkSovrascrivi.Checked;
  A159MW.AggiornamentoSchedaRiep:=chkAggSchedaRiep.Checked;
  A159MW.TipoCartellino:=chkParametrizzazioniTipoCartellino.Checked;
  //salvataggio su MW di path e file del pdf
  A159MW.LParAziendali.PathPdf:=edtPathPdf.Text;
  A159MW.LParAziendali.FilePdf:=edtFilePdf.Text;

  if A159MW.isService then
  begin
    //se avviato come servizio, creo nuove versioni solo se è esplicitamente richiesto ed è attiva la verifica della validazione
    A159MW.CreaNuovaVersione:=A159MW.Versionabile and A159MW.VerificaValidazione;
    //se avviato come servizio, non sovrascrivo
    A159MW.Sovrascrivi:=False;
  end
  else
  begin
    numFile:=0;
    if A159MW.Sovrascrivi or A159MW.Versionabile then
      numFile:=A159MW.VerificaFileEsistenti;

    if A159MW.SalvaSuDocumentale and A159MW.Versionabile and (numFile > 0) then
    begin
      ok:=MessageDlg(Format(A000MSG_A159_DLG_FMT_NUOVA_VERSIONE, [numFile.ToString, IfThen(numFile = 1, 'o', 'i')]), mtWarning, mbYesNoCancel, 0);

      if ok = mrCancel then
        raise Exception.Create('Operazione annullata');

      A159MW.CreaNuovaVersione:=ok = mrYes;
      A159MW.Sovrascrivi:=False;
    end
    else if A159MW.Sovrascrivi and (numFile > 0) then
    begin
      ok:=MessageDlg(Format(A000MSG_A159_DLG_FMT_SOVRASCRIVI, [numFile.ToString, IfThen(numFile = 1, 'o', 'i')]), mtWarning, mbYesNoCancel, 0);

      if ok = mrCancel then
        raise Exception.Create('Operazione annullata');

      A159MW.Sovrascrivi:=ok = mrYes;
      A159MW.CreaNuovaVersione:=False;
    end
    else
    begin
      ok:=MessageDlg(Format(A000MSG_A159_DLG_FMT_CONFERMA_ELAB, [IntToStr(dsrV430.DataSet.RecordCount), IfThen(dsrV430.DataSet.RecordCount = 1, 'e', 'i')]), mtWarning, mbOKCancel, 0);

      if ok <> mrOK then
        raise Exception.Create('Operazione annullata');
    end;
  end;

  A159MW.InviareRegistro:=chkInviaRegistro.Checked; //invio il registro in automatico solo se è effettivamente richiesto

  //generazione pdf
  try
    Screen.Cursor:=crHourGlass;
    //A159MW.GeneraPdf;
    //21/12/2016: adeguamento elaborazione ad applicativo iriscloud(inserimento progressbar)
    A159MW.InizioElaborazione;
    while not A159MW.SelAnagrafe.Eof do
    begin
      A159MW.ElaboraElemento;
      A159MW.ElementoSuccessivo;
    end;
    A159MW.FineCicloElaborazione;
  finally
    Screen.Cursor:=crDefault;
  end;

  if not A159MW.isService then
  begin
    if RegistraMsg.ContieneTipoA then
    begin
      if R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,DOMANDA) = mrYes then
        actLeggiLogExecute(nil);
    end
    else
      ShowMessage(A000MSG_MSG_ELABORAZIONE_TERMINATA);
  end;
end;

{ DataInizio }
function TA159FArchiviazioneCartellini._GetDataI: TDateTime;
begin
  Result:=frmInputPeriodo.DataInizio;
end;
procedure TA159FArchiviazioneCartellini._PutDataI(const Value: TDateTime);
begin
  frmInputPeriodo.DataInizio:=Value;
end;
{ DataInizio----}

{ DataFine }
function TA159FArchiviazioneCartellini._GetDataF: TDateTime;
begin
  Result:=frmInputPeriodo.DataFine;
end;
procedure TA159FArchiviazioneCartellini._PutDataF(const Value: TDateTime);
begin
  frmInputPeriodo.DataFine:=Value;
end;
{ DataFine---- }
end.
