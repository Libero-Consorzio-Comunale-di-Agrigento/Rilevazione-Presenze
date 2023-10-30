unit P288UElaborazioneUnjspf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, P999UGenerale,
  Dialogs, A000UCostanti, A000USessione, A000UInterfaccia, C700USelezioneAnagrafe, SelAnagrafe,
  C180FunzioniGenerali, StdCtrls, CheckLst, Spin, Buttons, ExtCtrls, ComCtrls, A003UDataLavoroBis,
  A083UMsgElaborazioni, Oracle, OracleData, Math, StrUtils, Vcl.Mask, C006UStoriaDati;

type
  TTabelle = record
    TipoFlusso:String;
    NomeLogico:String;
    NomeFisicoEDP:String;
    NomeFisicoILO:String;
  end;

  TStoria = record
    Inizio:TDateTime;
    Fine:TDateTime;
    Valore:String;
  end;

  TPeriodiPayment = record
    InizioPeriodo:TDateTime;
    FinePeriodo:TDateTime;
    Parttime:Real;
    Category,Grade,Step:String;
    LangAllow:String;
    PensionNumber:String;
    DutyStation:String;
    CurrencyCode:String;
    LWOP:Boolean;
    TransactionType:String;
    Exchange_rate:Real;
    Prrate_local_amount:Real;
    Language_allowancelocal_amount:Real;
    Proratedratio:Real;
    Contribution_local_amountsm:Real;
    Contribution_local_amountorg:Real;
    Adjustment_local_amountsm:Real;
    Adjustment_local_amountorg:Real;
    Adjustment_local_amountfullsm:Real;
    Adjustment_local_amountfullorg:Real;
    Validation_amountsm:Real;
    Validation_amountorg:Real;
    Restoration_amountsm:Real;
    Restoration_amountorg:Real;
    Actuarial_costssm:Real;
    Actuarial_costsorg:Real;
    Interest_contributionsm:Real;
    Interest_contributionorg:Real;
    Misc_adjustmentsm:Real;
    Misc_adjustmentorg:Real;
  end;

  TP288FElaborazioneUnjspf = class(TForm)
    frmSelAnagrafe: TfrmSelAnagrafe;
    StatusBar: TStatusBar;
    ProgressBar1: TProgressBar;
    pnlPulsanti: TPanel;
    BChiudi: TBitBtn;
    Panel1: TPanel;
    chkCalcola: TCheckBox;
    chklstTabelle: TCheckListBox;
    chkAnnulla: TCheckBox;
    chkChiusura: TCheckBox;
    Label2: TLabel;
    btnEsegui: TBitBtn;
    btnAnomalie: TBitBtn;
    chkPulisci: TCheckBox;
    chkEsportazione: TCheckBox;
    edtMeseElaborazione: TMaskEdit;
    sbtMeseElaborazione: TSpeedButton;
    lblMeseElaborazione: TLabel;
    sbtDataChiusura: TSpeedButton;
    edtDataChiusura: TMaskEdit;
    lblDataChiusura: TLabel;
    lblDataEsportazione: TLabel;
    edtDataEsportazione: TMaskEdit;
    sbtDataEsportazione: TSpeedButton;
    lblDataInizioEstraz: TLabel;
    edtDataInizioEstraz: TMaskEdit;
    sbtDataInizioEstraz: TSpeedButton;
    rgpStatoCedolini: TRadioGroup;
    edtDataElaborazione: TMaskEdit;
    lblDataElaborazione: TLabel;
    sbtDataElaborazione: TSpeedButton;
    btnInformazioni: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chkCalcolaClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure sbtDataChiusuraClick(Sender: TObject);
    procedure sbtDataEsportazioneClick(Sender: TObject);
    procedure sbtMeseElaborazioneClick(Sender: TObject);
    procedure sbtDataElaborazioneClick(Sender: TObject);
    procedure sbtDataInizioEstrazClick(Sender: TObject);
  private
    { Private declarations }
    ElaborazioneInterrotta:Boolean;
    TipoFlusso:String;
    Id_UNJSPF_Aperto:Integer;
    StartDate,EndDate:TDateTime;
    lstStoria: array of TStoria;
    lstStoriaContract: array of TStoria;
    lstPeriodiPay: array of TPeriodiPayment;
    QueryCambio:TQueryCambio;
    function TestataUNJSPF:Integer;
    function PeriodoValido(InizioPeriodo,FinePeriodo:TDateTime):Boolean;
    procedure AnnullaFornitura;
    procedure ChiusuraFornitura;
    procedure CalcoloFornitura;
    procedure PulisciFornitura;
    procedure EsportaFornitura;
    procedure CaricaStaffMember;
    procedure CaricaContract;
    procedure CaricaPartTime;
    procedure CaricaDutyStation;
    procedure CaricaSalary;
    procedure CaricaLeaveWithoutPay;
    procedure CaricaAddress;
    procedure CaricaEmail;
    procedure CaricaPhone;
    procedure CaricaLanguageAllowance;
    procedure CaricaChild;
    procedure CaricaDependent;
    procedure CaricaSeparation;
    procedure CaricaPayment;
  public
    { Public declarations }
  end;

var
  P288FElaborazioneUnjspf: TP288FElaborazioneUnjspf;

const
  lstTabelle:array [0..13] of TTabelle = (
    (TipoFlusso:'HR';  NomeLogico:'Staff member';        NomeFisicoEDP:'U120_UNJSPF_STAFF_MEMBER';  NomeFisicoILO:'INT_UNJSPF.XXILO_UNJSPF_STAFF_MEMBER_ITC'),
    (TipoFlusso:'HR';  NomeLogico:'Language allowance';  NomeFisicoEDP:'U125_UNJSPF_LANG_ALLWNCS';  NomeFisicoILO:'INT_UNJSPF.XXILO_UNJSPF_LANG_ALLWNCS_ITC'),
    (TipoFlusso:'HR';  NomeLogico:'Part time';           NomeFisicoEDP:'U130_UNJSPF_PARTTIMES';     NomeFisicoILO:'INT_UNJSPF.XXILO_UNJSPF_PARTTIMES_ITC'),
    (TipoFlusso:'HR';  NomeLogico:'Duty station';        NomeFisicoEDP:'U135_UNJSPF_DUTY_STTNS';    NomeFisicoILO:'INT_UNJSPF.XXILO_UNJSPF_DUTY_STTNS_ITC'),
    (TipoFlusso:'HR';  NomeLogico:'Salary';              NomeFisicoEDP:'U140_UNJSPF_SALARIES';      NomeFisicoILO:'INT_UNJSPF.XXILO_UNJSPF_SALARIES_ITC'),
    (TipoFlusso:'HR';  NomeLogico:'Contract';            NomeFisicoEDP:'U145_UNJSPF_CONTRACTS';     NomeFisicoILO:'INT_UNJSPF.XXILO_UNJSPF_CONTRACTS_ITC'),
    (TipoFlusso:'HR';  NomeLogico:'Separation';          NomeFisicoEDP:'U150_UNJSPF_SEPARATIONS';   NomeFisicoILO:'INT_UNJSPF.XXILO_UNJSPF_SEPARATIONS_ITC'),
    (TipoFlusso:'HR';  NomeLogico:'Dependent';           NomeFisicoEDP:'U155_UNJSPF_DEPENDANTS';    NomeFisicoILO:'INT_UNJSPF.XXILO_UNJSPF_DEPENDANTS_ITC'),
    (TipoFlusso:'HR';  NomeLogico:'Child';               NomeFisicoEDP:'U160_UNJSPF_CHILDS';        NomeFisicoILO:'INT_UNJSPF.XXILO_UNJSPF_CHILDS_ITC'),
    (TipoFlusso:'HR';  NomeLogico:'Leave without pay';   NomeFisicoEDP:'U165_UNJSPF_LWOP';          NomeFisicoILO:'INT_UNJSPF.XXILO_UNJSPF_LWOP_ITC'),
    (TipoFlusso:'HR';  NomeLogico:'Address';             NomeFisicoEDP:'U170_UNJSPF_ADDRESS';       NomeFisicoILO:'INT_UNJSPF.XXILO_UNJSPF_ADDRESS_ITC'),
    (TipoFlusso:'HR';  NomeLogico:'Phone';               NomeFisicoEDP:'U175_UNJSPF_PHONES';        NomeFisicoILO:'INT_UNJSPF.XXILO_UNJSPF_PHONES_ITC'),
    (TipoFlusso:'HR';  NomeLogico:'Email';               NomeFisicoEDP:'U180_UNJSPF_EMAILS';        NomeFisicoILO:'INT_UNJSPF.XXILO_UNJSPF_EMAILS_ITC'),
    (TipoFlusso:'FIN'; NomeLogico:'Payment';             NomeFisicoEDP:'U190_UNJSPF_PAY_TRAN';      NomeFisicoILO:'INT_UNJSPF.XXILO_UNJSPF_PAY_TRAN_ITC')
    );

procedure OpenP288ElaborazioneUnjspf(Prog:LongInt);

implementation

uses P288UElaborazioneUnjspfDtM;

{$R *.dfm}

procedure OpenP288ElaborazioneUnjspf(Prog:LongInt);
var sTipo:String;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  sTipo:=IfThen(Parametri.Applicazione = 'STAGIU','HR','FIN');
  case A000GetInibizioni('Funzione','OpenP288ElaborazioneUnjspf' + sTipo) of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TP288FElaborazioneUnjspf, P288FElaborazioneUnjspf);
  C700Progressivo:=Prog;
  Application.CreateForm(TP288FElaborazioneUnjspfDtM, P288FElaborazioneUnjspfDtM);
  try
    Screen.Cursor:=crDefault;
    P288FElaborazioneUnjspf.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    P288FElaborazioneUnjspf.Free;
    P288FElaborazioneUnjspfDtM.Free;
  end;
end;

procedure TP288FElaborazioneUnjspf.btnAnomalieClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  if Sender = btnAnomalie then
    OpenA083MsgElaborazioni(Parametri.Azienda, Parametri.Operatore, 'P288', 'A')
  else if Sender = btnInformazioni then
    OpenA083MsgElaborazioni(Parametri.Azienda, Parametri.Operatore, 'P288', 'I')
  else
    OpenA083MsgElaborazioni(Parametri.Azienda, Parametri.Operatore, 'P288', '');
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase + ',DATANAS,RTRIM(CONVERT(TRANSLATE(T030.COGNOME,''ñ'',''n''),''US7ASCII'')) COGNOME_PULITO,RTRIM(CONVERT(TRANSLATE(T030.NOME,''ñ'',''n''),''US7ASCII'')) NOME_PULITO';
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe;
end;

function TP288FElaborazioneUnjspf.TestataUNJSPF: Integer;
// Creo testata della fornitura mensile UNJSPF o ne estraggo ID se già esiste
begin
  Result:=0;
  with P288FElaborazioneUnjspfDtM do
  begin
    // Lettura di eventuale UNJSPF aperta o chiusa
    R180SetVariable(selU100, 'TipoFlusso', TipoFlusso);
    R180SetVariable(selU100, 'MeseElaborazione', R180FineMese(StrToDate('01/' + edtMeseElaborazione.Text)));
    selU100.Open;
    selU100.Refresh;
    if not selU100.Eof then
    begin
      if selU100.RecordCount > 1 then
        raise Exception.Create('Esiste più di una fornitura relativa al mese di elaborazione: rimuovere quelle non valide');
      if selU100.FieldByName('CHIUSO').AsString = 'N' then
      begin
        Result:=selU100.FieldByName('ID_UNJSPF').AsInteger;
        //Nel caso di Calcola dati, se esiste già, si aggiorna la Data elaborazione testata
        if chkCalcola.Checked then
        begin
          selU100.Edit;
          selU100.FieldByName('DATA_ELABORAZIONE').AsDateTime:=StrToDate(edtDataElaborazione.Text);
          selU100.Post;
          SessioneOracle.Commit;
        end;
      end
      else
        if chkEsportazione.Checked then  //In caso di esportazione posso considerare anche ID chiuso
          Result:=selU100.FieldByName('ID_UNJSPF').AsInteger
        else
          Result:=-1;
    end
    else
    begin
      // Nel caso di Calcola dati, se non esiste, si genera la testata
      if chkCalcola.Checked then
      begin
        // Generazione della sequenza ID_UNJSPF
        selU100_ID.Close;
        selU100_ID.Open;
        Result:=selU100_ID.FieldByName('NEXTVAL').AsInteger;
        insU100.SetVariable('TipoFlusso', TipoFlusso);
        insU100.SetVariable('MeseElaborazione', R180FineMese(StrToDate('01/' + edtMeseElaborazione.Text)));
        insU100.SetVariable('DataElaborazione', StrToDate(edtDataElaborazione.Text));
        insU100.SetVariable('IdUNJSPF', Result);
        insU100.Execute;
        SessioneOracle.Commit;
      end;
    end;
  end;
end;

procedure TP288FElaborazioneUnjspf.btnEseguiClick(Sender: TObject);
var Selez:Boolean;
  i:Integer;
begin
  if (C700Progressivo = 0) and (chkCalcola.Checked or chkAnnulla.Checked) then
    raise Exception.Create('Nessun dipendente selezionato!');
  if chkCalcola.Checked then
    if (StrToDate(edtDataElaborazione.Text) < StrToDate('01/' + edtMeseElaborazione.Text)) or
       (StrToDate(edtDataElaborazione.Text) > R180FineMese(StrToDate('01/' + edtMeseElaborazione.Text))) then
      raise Exception.Create('La data elaborazione deve essere compresa nel mese elaborazione!');
  Selez:=False;
  for i:=0 to chklstTabelle.Count - 1 do
    if chklstTabelle.Checked[i] then
      Selez:=True;
  if not Selez then
    raise exception.Create('Selezionare almeno una tabella da elaborare!');
  if frmSelAnagrafe.SettaPeriodoSelAnagrafe(StrToDate(edtDataElaborazione.Text),StrToDate(edtDataElaborazione.Text)) then
    C700SelAnagrafe.Close;
  C700SelAnagrafe.Open;
  //Verificare che il mese non sia già chiuso altrimenti blocco
  btnAnomalie.Enabled:=False;
  btnInformazioni.Enabled:=False;
  RegistraMsg.IniziaMessaggio('P288');
  Id_UNJSPF_Aperto:=TestataUNJSPF;
  if chkChiusura.Checked or chkPulisci.Checked or chkAnnulla.Checked or chkCalcola.Checked then
  begin
    if Id_UNJSPF_Aperto < 0 then
      raise Exception.Create('Esiste già una fornitura chiusa riferita al mese! ' + chr(13) +
          'Impossibile proseguire con l''elaborazione')
    else if Id_UNJSPF_Aperto = 0 then
      raise Exception.Create('Non esiste fornitura aperta del mese! ' + chr(13)
          + 'Impossibile proseguire con l''elaborazione');
  end;

  //In base all'operazione scelta elaboro le tabelle
  if chkChiusura.Checked then
  begin
    if (R180MessageBox('Confermi l''operazione di chiusura UNJSPF per il mese indicato?',DOMANDA) = mrYes) then
      ChiusuraFornitura
    else
      Exit;
  end
  else if chkPulisci.Checked then
  begin
    if (R180MessageBox('Confermi l''operazione di annullamento totale di tutti i dati per il mese indicato per le tabelle selezionate?',DOMANDA) = mrYes) then
      PulisciFornitura
    else
      Exit;
  end
  else if chkAnnulla.Checked then
  begin
    if (R180MessageBox('Confermi l''operazione di annullamento UNJSPF per il mese indicato, per le tabelle selezionate, per tutti i dipendenti selezionati?',DOMANDA) = mrYes) then
      AnnullaFornitura
    else
      Exit;
  end
  else if chkCalcola.Checked then
  begin
    if (R180MessageBox('L''operazione annulla le precedenti elaborazioni e calcola i dati UNJSPF per il mese indicato, per le tabelle selezionate, per i dipendenti selezionati. Confermi l''operazione?',DOMANDA) = mrYes) then
      CalcoloFornitura
    else
      Exit;
  end
  else if chkEsportazione.Checked then
    EsportaFornitura;
  //Verifico se cancellare testate UNJSPF che non hanno dati di dettaglio
  with P288FElaborazioneUnjspfDtM do
  begin
    delU100.SetVariable('IDUNJSPF',Id_UNJSPF_Aperto);
    try
      delU100.Execute;
    except
      on E:Exception do
        RegistraMsg.InserisciMessaggio('A','Cancellazione U100_UNJSPF_TESTATE fallita. ' + E.Message,'',0);
    end;
    SessioneOracle.Commit;
  end;
  btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA;
  btnInformazioni.Enabled:=RegistraMsg.ContieneTipoI;
  if RegistraMsg.ContieneTipoA then
  begin
    if RegistraMsg.ContieneTipoI then
    begin
      if R180MessageBox('Elaborazione terminata con anomalie e informazioni. Si desidera visualizzarle?',DOMANDA) = mrYes then
        btnAnomalieClick(nil);
    end
    else
      if R180MessageBox('Elaborazione terminata con anomalie. Si desidera visualizzarle?',DOMANDA) = mrYes then
        btnAnomalieClick(btnAnomalie);
  end
  else
  begin
    if RegistraMsg.ContieneTipoI then
    begin
      if R180MessageBox('Elaborazione terminata con informazioni. Si desidera visualizzarle?',DOMANDA) = mrYes then
        btnAnomalieClick(btnInformazioni);
    end
    else if not chkEsportazione.Checked then
      R180MessageBox('Elaborazione terminata correttamente.',INFORMA);
  end;
end;

procedure TP288FElaborazioneUnjspf.CalcoloFornitura;
var lstAppoggio: array of TStoria;
  i:Integer;
begin
  //Annullo-cancello i dati dei dipendenti che hanno COD_UNJSPF valorizzato
  AnnullaFornitura;
  Screen.Cursor:=crHourGlass;
  StatusBar.Panels[1].Text:='Elaborazione tabelle in corso...premere Esc per interrompere';
  ElaborazioneInterrotta:=False;
  ProgressBar1.Position:=0;
  ProgressBar1.Max:=C700SelAnagrafe.RecordCount;
  with P288FElaborazioneUnjspfDtM do
  begin
    //Leggo tutti i dati di V430 alla data elaborazione - selV430 diventa il 'dataset principale'
    selV430.Close;
    selV430.SetVariable('DATARIFERIMENTO',StrToDate(edtDataElaborazione.Text));
    selV430.Open;
    C700SelAnagrafe.First;
    while not C700SelAnagrafe.Eof do
    begin
      if ElaborazioneInterrotta then
      begin
        StatusBar.Panels[1].Text:='';
        ElaborazioneInterrotta:=False;
        R180MessageBox('Elaborazione interrotta su richiesta dell''operatore.',INFORMA);
        Break;
      end;
      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar1.StepBy(1);
      selSQL.SQL.Clear;
      selSQL.SQL.Add('SELECT MIN(START_DATE_HR) INIZIO FROM T430_STORICO T430 WHERE T430.PROGRESSIVO = ' + C700SelAnagrafe.FieldByName('PROGRESSIVO').AsString);
      selSQL.Execute;
      //Elaboro solo i dipendenti con UN_EXTRACT = 'Y' a data elaborazione
      if (selV430.SearchRecord('T430PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsString,[srFromBeginning])) and
         (selV430.FieldByName('T430UN_EXTRACT').AsString = 'Y') and
         (selSQL.RowsProcessed > 0) and (StrToDate(edtDataElaborazione.Text) >= StrToDate(selSQL.FieldAsString(0))) then
      begin
        CaricaContract;
        if TipoFlusso = 'HR' then
        begin
          if chklstTabelle.Checked[0] then
            CaricaStaffMember;
          if chklstTabelle.Checked[1] then
            CaricaLanguageAllowance;
          if chklstTabelle.Checked[2] then
            CaricaPartTime;
          if chklstTabelle.Checked[3] then
            CaricaDutyStation;
          if chklstTabelle.Checked[4] then
            CaricaSalary;
          if chklstTabelle.Checked[6] then
            CaricaSeparation;
          if chklstTabelle.Checked[7] then
            CaricaDependent;
          if chklstTabelle.Checked[8] then
            CaricaChild;
          if chklstTabelle.Checked[9] then
            CaricaLeaveWithoutPay;
          if chklstTabelle.Checked[10] then
            CaricaAddress;
          if chklstTabelle.Checked[11] then
            CaricaPhone;
          if chklstTabelle.Checked[12] then
            CaricaEmail;
          //Segnalare i dipendenti inseriti nel flusso senza cedolino con voce 11600 (Contribution to UNJSPF official), sia aperto che chiuso,
          //nel mese di estrazione o mese precedente e senza record afferenti al mese di estrazione stesso nella tabella LWOP di FIN
          selSQL.SQL.Clear;
          selSQL.SQL.Add('SELECT * FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442 WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO');
          selSQL.SQL.Add('   AND P441.PROGRESSIVO = ' + C700SelAnagrafe.FieldByName('PROGRESSIVO').AsString);
          selSQL.SQL.Add('   AND P442.COD_VOCE = ''11600'' AND P442.TIPO_RECORD = ''M''');
          selSQL.SQL.Add('   AND (P441.DATA_CEDOLINO = TO_DATE(''' + DateToStr(R180FineMese(StrToDate('01/' + edtMeseElaborazione.Text))) + ''',''DD/MM/YYYY'') ');
          selSQL.SQL.Add('     OR P441.DATA_CEDOLINO = TO_DATE(''' + DateToStr(R180FineMese(R180AddMesi(StrToDate('01/' + edtMeseElaborazione.Text),-1))) + ''',''DD/MM/YYYY''))');
          selSQL.Execute;
          if selSQL.RowsProcessed <= 0 then
          begin
            selU110.Close;
            selU110.SetVariable('Progressivo',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
            selU110.SetVariable('InizioPeriodo',StrToDate('01/' + edtMeseElaborazione.Text));
            selU110.SetVariable('FinePeriodo',R180FineMese(StrToDate('01/' + edtMeseElaborazione.Text)));
            selU110.Open;
            if selU110.RecordCount <= 0 then
              RegistraMsg.InserisciMessaggio('I','Dipendente inserito nel flusso in assenza di cedolino nel mese di elaborazione o mese precedente con voce 11600 e non in LWOP nella tabella di FIN','',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          end;
        end
        else  //TipoFlusso = 'FIN'
        begin
          if chklstTabelle.Checked[0] then
            CaricaPayment;
        end;
      end
      else
      begin
        selT430.Close;
        selT430.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        selT430.SetVariable('DATI','START_DATE_HR, CESS_DATE_HR');
        selT430.SetVariable('FILTRO',' AND START_DATE_HR <= TO_DATE(''' + edtDataElaborazione.Text + ''',''DD/MM/YYYY'')');
        selT430.Open;
        SetLength(lstAppoggio,0);
        //Carico nel vettore tutti i periodi StartDate-EndDate
        while not selT430.Eof do
        begin
          if not selT430.FieldByName('START_DATE_HR').IsNull then
          begin
            SetLength(lstAppoggio,Length(lstAppoggio)+1);
            lstAppoggio[High(lstAppoggio)].Inizio:=selT430.FieldByName('START_DATE_HR').AsDateTime;
            if selT430.FieldByName('CESS_DATE_HR').IsNull then
              lstAppoggio[High(lstAppoggio)].Fine:=StrToDate('31/12/3999')
            else
              lstAppoggio[High(lstAppoggio)].Fine:=selT430.FieldByName('CESS_DATE_HR').AsDateTime;
          end;
          selT430.Next;
        end;
        //Scorro sul vettore e appiattisco
        SetLength(lstStoria,0);
        for i:=0 to Length(lstAppoggio) - 1 do
        begin
          if (i > 0) and (lstAppoggio[i].Inizio <= lstAppoggio[i-1].Fine + 1) then
            lstStoria[High(lstStoria)].Fine:=lstAppoggio[i].Fine
          else
          begin
            SetLength(lstStoria,Length(lstStoria)+1);
            lstStoria[High(lstStoria)].Inizio:=lstAppoggio[i].Inizio;
            lstStoria[High(lstStoria)].Fine:=lstAppoggio[i].Fine;
          end;
        end;
        //Carico nel vettore tutti i periodi StartDate-EndDate appiattiti che intersecano il periodo Inizio storico - Data elaborazione
        SetLength(lstAppoggio,0);
        for i:=0 to Length(lstStoria) - 1 do
        begin
          if (lstStoria[i].Inizio <= StrToDate(edtDataElaborazione.Text)) and
             (lstStoria[i].Fine >= StrToDate(edtDataInizioEstraz.Text)) then
          begin
            SetLength(lstAppoggio,Length(lstAppoggio)+1);
            lstAppoggio[High(lstAppoggio)].Inizio:=lstStoria[i].Inizio;
            lstAppoggio[High(lstAppoggio)].Fine:=lstStoria[i].Fine;
          end;
        end;
        //Segnalo anomalia se UN_EXTRACT non è valorizzato con dipendente in servizio alla data elaborazione considerando StartDate-EndDate
        if Trim(selV430.FieldByName('T430UN_EXTRACT').AsString) = '' then
        begin
          for i:=0 to Length(lstAppoggio) - 1 do
          begin
            if (StrToDate(edtDataElaborazione.Text) >= lstAppoggio[i].Inizio) and
               (StrToDate(edtDataElaborazione.Text) <= lstAppoggio[i].Fine) then
            begin
              RegistraMsg.InserisciMessaggio('A','Il dato T430UN_EXTRACT non è valorizzato','',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
              Break;
            end;
          end;
        end;
        if TipoFlusso = 'HR' then
        begin
          //Segnalo anomalia per il dipendente escluso dal flusso con almeno un giorno di servizio nel mese con assoggettamento diverso da INPSH ed il contratto supera i sei mesi continuativi alla data elaborazione
          for i:=0 to Length(lstAppoggio) - 1 do
          begin
            if (lstAppoggio[i].Inizio <= R180FineMese(StrToDate(edtDataElaborazione.Text))) and
               (lstAppoggio[i].Fine >= R180InizioMese(StrToDate(edtDataElaborazione.Text))) and
               (selV430.FieldByName('P430COD_TIPOASSOGGETTAMENTO').AsString <> 'INPSH') then
            begin
              if Min(lstAppoggio[i].Fine,StrToDate(edtDataElaborazione.Text)) > R180AddMesi(lstAppoggio[i].Inizio,6,True) then
              begin
                RegistraMsg.InserisciMessaggio('A','Dipendente escluso dal flusso con almeno un giorno di servizio nel mese ed il contratto supera i sei mesi continuativi','',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
                Break;
              end;
            end;
          end;
        end
        else
        begin
          //Segnalo anomalia se dipendente escluso dal flusso ma con voce 11600 sul cedolino
          selP442.Close;
          selP442.SetVariable('Progressivo',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          selP442.SetVariable('MeseElaborazione',' = TO_DATE(''' + DateToStr(R180FineMese(StrToDate('01/' + edtMeseElaborazione.Text))) + ''',''DD/MM/YYYY'')');
          case rgpStatoCedolini.ItemIndex of
            0:selP442.SetVariable('StatoCedolini','''S''');
            1:selP442.SetVariable('StatoCedolini','''S'',''N''');
            2:selP442.SetVariable('StatoCedolini','''N''');
          end;
          selP442.SetVariable('Voci','''11600''');
          selP442.Open;
          if selP442.RecordCount > 0 then
            RegistraMsg.InserisciMessaggio('A','Dipendente escluso dal flusso ma con voce 11600 sul cedolino','',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        end;
      end;
      C700SelAnagrafe.Next;
    end;
  end;
  ProgressBar1.Position:=0;
  Screen.Cursor:=crDefault;
  StatusBar.Panels[1].Text:='';
end;

procedure TP288FElaborazioneUnjspf.CaricaContract;
var i:Integer;
begin
  with P288FElaborazioneUnjspfDtM do
  begin
    selT430.Close;
    selT430.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selT430.SetVariable('DATI','START_DATE_HR, CESS_DATE_HR');
    selT430.SetVariable('FILTRO',' AND UN_EXTRACT = ''Y'' AND START_DATE_HR <= TO_DATE(''' + edtDataElaborazione.Text + ''',''DD/MM/YYYY'')');
    selT430.Open;
    SetLength(lstStoriaContract,0);
    //Carico nel vettore tutti i periodi StartDate-EndDate che hanno UN_EXTRACT = 'Y'
    while not selT430.Eof do
    begin
      if not selT430.FieldByName('START_DATE_HR').IsNull then
      begin
        SetLength(lstStoriaContract,Length(lstStoriaContract)+1);
        lstStoriaContract[High(lstStoriaContract)].Inizio:=selT430.FieldByName('START_DATE_HR').AsDateTime;
        if selT430.FieldByName('CESS_DATE_HR').IsNull then
          lstStoriaContract[High(lstStoriaContract)].Fine:=StrToDate('31/12/3999')
        else
          lstStoriaContract[High(lstStoriaContract)].Fine:=selT430.FieldByName('CESS_DATE_HR').AsDateTime;
      end;
      selT430.Next;
    end;
    //Scorro sul vettore e appiattisco
    SetLength(lstStoria,0);
    for i:=0 to Length(lstStoriaContract) - 1 do
    begin
      if (i > 0) and (lstStoriaContract[i].Inizio > lstStoriaContract[i-1].Inizio) and
         (lstStoriaContract[i].Fine < lstStoriaContract[i-1].Fine) then
        RegistraMsg.InserisciMessaggio('A','Periodo Start date - End date contrattuale interamente contenuto in uno precedente','',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      if (i > 0) and (lstStoriaContract[i].Inizio <= lstStoriaContract[i-1].Fine + 1) then
        lstStoria[High(lstStoria)].Fine:=lstStoriaContract[i].Fine
      else
      begin
        SetLength(lstStoria,Length(lstStoria)+1);
        lstStoria[High(lstStoria)].Inizio:=lstStoriaContract[i].Inizio;
        lstStoria[High(lstStoria)].Fine:=lstStoriaContract[i].Fine;
      end;
    end;
    //Carico nel vettore tutti i periodi StartDate-EndDate appiattiti che intersecano il periodo Inizio storico - Data elaborazione
    SetLength(lstStoriaContract,0);
    for i:=0 to Length(lstStoria) - 1 do
    begin
      if (lstStoria[i].Inizio <= StrToDate(edtDataElaborazione.Text)) and
         (lstStoria[i].Fine >= StrToDate(edtDataInizioEstraz.Text)) then
      begin
        SetLength(lstStoriaContract,Length(lstStoriaContract)+1);
        lstStoriaContract[High(lstStoriaContract)].Inizio:=lstStoria[i].Inizio;
        lstStoriaContract[High(lstStoriaContract)].Fine:=lstStoria[i].Fine;
      end;
    end;
    if TipoFlusso = 'HR' then  //Registro solo se HR
    begin
      //Verifica corretta sequenza cronologica delle date StartDate
      selT430.Close;
      selT430.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      selT430.SetVariable('DATI','PROGRESSIVO');
      selT430.SetVariable('FILTRO',' AND UN_EXTRACT = ''Y'' AND EXISTS ' +
                                   '(SELECT ''X'' FROM T430_STORICO V WHERE V.PROGRESSIVO = T.PROGRESSIVO AND V.UN_EXTRACT = T.UN_EXTRACT ' +
                                   'AND V.DATADECORRENZA > T.DATADECORRENZA AND V.START_DATE_HR < T.START_DATE_HR)');
      selT430.Open;
      if not selT430.Eof then
        RegistraMsg.InserisciMessaggio('A','Errata sequenza cronologica delle date Start date contrattuali','',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      //Verifica corretta sequenza cronologica delle date EndDate
      selT430.Close;
      selT430.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      selT430.SetVariable('DATI','PROGRESSIVO');
      selT430.SetVariable('FILTRO',' AND UN_EXTRACT = ''Y'' AND EXISTS ' +
                                   '(SELECT ''X'' FROM T430_STORICO V WHERE V.PROGRESSIVO = T.PROGRESSIVO AND V.UN_EXTRACT = T.UN_EXTRACT ' +
                                   'AND V.DATADECORRENZA > T.DATADECORRENZA AND V.CESS_DATE_HR < T.CESS_DATE_HR)');
      selT430.Open;
      if not selT430.Eof then
        RegistraMsg.InserisciMessaggio('A','Errata sequenza cronologica delle date End date contrattuali','',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      for i:=0 to Length(lstStoriaContract) - 1 do
      begin
        insU145.SetVariable('ID_UNJSPF',Id_UNJSPF_Aperto);
        insU145.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        insU145.SetVariable('EMPLOYEE_NUMBER','7' + C700SelAnagrafe.FieldByName('MATRICOLA').AsString);
        insU145.SetVariable('STARTDATE',lstStoriaContract[i].Inizio);
        if lstStoriaContract[i].Fine = StrToDate('31/12/3999') then
          insU145.SetVariable('ENDDATE',null)
        else
          insU145.SetVariable('ENDDATE',lstStoriaContract[i].Fine);
        //Registro REAPPOINTINDICATOR alla data STARTDATE
        selSQL.SQL.Clear;
        selSQL.SQL.Add('SELECT T430D_UN_REAPP FROM V430_STORICO WHERE T430PROGRESSIVO = ' + C700SelAnagrafe.FieldByName('PROGRESSIVO').AsString);
        selSQL.SQL.Add('   AND TO_DATE(''' + DateToStr(lstStoriaContract[i].Inizio) + ''',''DD/MM/YYYY'') BETWEEN T430DATADECORRENZA AND T430DATAFINE');
        selSQL.Execute;
        if selSQL.RowsProcessed > 0 then
          insU145.SetVariable('REAPPOINTINDICATOR',selSQL.FieldAsString(0));
        insU145.SetVariable('LASTUPDATED',StrToDate('01/' + edtMeseElaborazione.Text));
        try
          insU145.Execute;
        except
          on E:Exception do
            RegistraMsg.InserisciMessaggio('A','Inserimento in U145_UNJSPF_CONTRACTS fallito. ' + E.Message,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        end;
        SessioneOracle.Commit;
      end;
    end;
  end;
end;

procedure TP288FElaborazioneUnjspf.CaricaStaffMember;
begin
  with P288FElaborazioneUnjspfDtM do
  begin
    //Carico il dipendente leggendo i dati alla data elaborazione da selV430
    insU120.SetVariable('ID_UNJSPF',Id_UNJSPF_Aperto);
    insU120.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    insU120.SetVariable('EMPLOYEE_NUMBER','7' + C700SelAnagrafe.FieldByName('MATRICOLA').AsString);
    insU120.SetVariable('PENSIONNUMBER',selV430.FieldByName('T430COD_UNJSPF').AsString);
    if not selV430.FieldByName('T430UN_ENTRY_DATE').IsNull then
      insU120.SetVariable('ENTRYTOFUNDDATE',selV430.FieldByName('T430UN_ENTRY_DATE').AsDateTime)
    else
      insU120.SetVariable('ENTRYTOFUNDDATE',null);
    insU120.SetVariable('FIRSTNAME',selV430.FieldByName('NOME_PULITO').AsString);
    insU120.SetVariable('LASTNAME',selV430.FieldByName('COGNOME_PULITO').AsString);
    if not selV430.FieldByName('DATANAS').IsNull then
      insU120.SetVariable('BIRTHDATE',selV430.FieldByName('DATANAS').AsDateTime)
    else
      insU120.SetVariable('BIRTHDATE',null);
    if Trim(selV430.FieldByName('T430NATIONALITY').AsString) = '' then
      insU120.SetVariable('NATIONALITY','XXX')
    else
      insU120.SetVariable('NATIONALITY',selV430.FieldByName('T430NATIONALITY').AsString);
    insU120.SetVariable('COUNTRYOFBIRTH','XXX');
    insU120.SetVariable('GENDER',IfThen(selV430.FieldByName('SESSO').AsString = 'M','Male','Female'));
    if selV430.FieldByName('T430CIVIL_STATUS').AsString = '1' then
      insU120.SetVariable('MARITALSTATUS','Single')
    else if selV430.FieldByName('T430CIVIL_STATUS').AsString = '2' then
      insU120.SetVariable('MARITALSTATUS','Married')
    else if selV430.FieldByName('T430CIVIL_STATUS').AsString = '3' then
      insU120.SetVariable('MARITALSTATUS','Married')
    else if selV430.FieldByName('T430CIVIL_STATUS').AsString = '4' then
      insU120.SetVariable('MARITALSTATUS','Non-Traditional Union')
    else if selV430.FieldByName('T430CIVIL_STATUS').AsString = '5' then
      insU120.SetVariable('MARITALSTATUS','Divorced')
    else if selV430.FieldByName('T430CIVIL_STATUS').AsString = '6' then
      insU120.SetVariable('MARITALSTATUS','Single');
    insU120.SetVariable('LASTUPDATED',StrToDate('01/' + edtMeseElaborazione.Text));
    try
      insU120.Execute;
    except
      on E:Exception do
        RegistraMsg.InserisciMessaggio('A','Inserimento in U120_UNJSPF_STAFF_MEMBER fallito. ' + E.Message,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    end;
    SessioneOracle.Commit;
  end;
end;

procedure TP288FElaborazioneUnjspf.CaricaSeparation;
var i:Integer;
  MancaProroga,InsSeparation:Boolean;
begin
  with P288FElaborazioneUnjspfDtM do
  begin
    for i:=0 to Length(lstStoriaContract) - 1 do
    begin
      if lstStoriaContract[i].Fine <= StrToDate(edtDataElaborazione.Text) then
      begin
        MancaProroga:=True;
        if lstStoriaContract[i].Fine = StrToDate(edtDataElaborazione.Text) then
        begin
          selT430.Close;
          selT430.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          selT430.SetVariable('DATI','START_DATE_HR');
          selT430.SetVariable('FILTRO',' AND UN_EXTRACT = ''Y'' AND START_DATE_HR = TO_DATE(''' + edtDataElaborazione.Text + ''',''DD/MM/YYYY'') + 1');
          selT430.Open;
          MancaProroga:=selT430.Eof;
        end;
        if MancaProroga then
        begin
          insU150.SetVariable('ID_UNJSPF',Id_UNJSPF_Aperto);
          insU150.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          insU150.SetVariable('EMPLOYEE_NUMBER','7' + C700SelAnagrafe.FieldByName('MATRICOLA').AsString);
          insU150.SetVariable('EFFECTIVEDATE',lstStoriaContract[i].Fine);
          selSQL.SQL.Clear;
          selSQL.SQL.Add('SELECT T430D_UN_SEP_REASON, T430PENSION_FUND_AF FROM V430_STORICO WHERE T430PROGRESSIVO = ' + C700SelAnagrafe.FieldByName('PROGRESSIVO').AsString);
          selSQL.SQL.Add(' AND TO_DATE(''' + DateToStr(lstStoriaContract[i].Fine) + ''',''DD/MM/YYYY'') BETWEEN T430DATADECORRENZA AND T430DATAFINE');
          selSQL.Execute;
          insU150.SetVariable('REASON',null);
          insU150.SetVariable('DEATHDATE',null);
          if selSQL.RowsProcessed > 0 then
          begin
            insU150.SetVariable('REASON',selSQL.FieldAsString(0));
            if UpperCase(selSQL.FieldAsString(0)) = 'DEATH' then
              insU150.SetVariable('DEATHDATE',lstStoriaContract[i].Fine);
          end;
          insU150.SetVariable('LASTUPDATED',StrToDate('01/' + edtMeseElaborazione.Text));
          InsSeparation:=True;
          if selSQL.RowsProcessed > 0 then
            if ((UpperCase(selSQL.FieldAsString(0)) = 'NOT REQUIRED') or
               ((selSQL.FieldAsString(0) = '') and (R180Anno(lstStoriaContract[i].Fine) < 2016)) or
               ((selSQL.FieldAsString(0) = '') and (R180Anno(lstStoriaContract[i].Fine) >= 2016)) and (selSQL.FieldAsString(1) <> '1')) then
              InsSeparation:=False;
          if InsSeparation then
          begin
            try
              insU150.Execute;
            except
              on E:Exception do
                RegistraMsg.InserisciMessaggio('A','Inserimento in U150_UNJSPF_SEPARATIONS fallito. ' + E.Message,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
            end;
            SessioneOracle.Commit;
          end;
        end;
      end;
    end;
  end;
end;

procedure TP288FElaborazioneUnjspf.CaricaDependent;
begin
  with P288FElaborazioneUnjspfDtM do
  begin
    //Leggo i dati di SG101 alla data elaborazione per estrarre i familiari non figli
    selSG101.Close;
    selSG101.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selSG101.SetVariable('DATARIFERIMENTO',StrToDate(edtDataElaborazione.Text));
    selSG101.SetVariable('GRADOPAR','AND GRADOPAR <> ''FG''');
    selSG101.Open;
    while not selSG101.Eof do
    begin
      if (selSG101.FieldByName('GRADOPAR').AsString <> 'CG') and
         (selSG101.FieldByName('GRADOPAR').AsString <> 'GT') and
         (selSG101.FieldByName('GRADOPAR').AsString <> 'FR') then
         RegistraMsg.InserisciMessaggio('A','Familiare ' + selSG101.FieldByName('COGNOME').AsString + ' ' + selSG101.FieldByName('NOME').AsString + ' con grado di parentela diverso da Coniuge/Genitore/Fratello/Sorella','',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger)
      else
      begin
        //Carico il dipendente leggendo i dati alla fine mese da selSG101
        insU155.SetVariable('ID_UNJSPF',Id_UNJSPF_Aperto);
        insU155.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        insU155.SetVariable('EMPLOYEE_NUMBER','7' + C700SelAnagrafe.FieldByName('MATRICOLA').AsString);
        insU155.SetVariable('ORGDEPENDENTID',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger * 100000 + selSG101.FieldByName('NUMORD').AsInteger);
        insU155.SetVariable('LASTNAME',selSG101.FieldByName('COGNOME_PULITO').AsString);
        insU155.SetVariable('FIRSTNAME',selSG101.FieldByName('NOME_PULITO').AsString);
        if not selSG101.FieldByName('DATANAS').IsNull then
          insU155.SetVariable('BIRTHDATE',selSG101.FieldByName('DATANAS').AsDateTime)
        else
          insU155.SetVariable('BIRTHDATE',null);
        insU155.SetVariable('GENDER',IfThen(selSG101.FieldByName('SESSO').AsString = 'M','Male','Female'));
        if selSG101.FieldByName('GRADOPAR').AsString = 'CG' then
          insU155.SetVariable('RELATIONSHIP','Spouse')
        else if selSG101.FieldByName('GRADOPAR').AsString = 'GT' then
          insU155.SetVariable('RELATIONSHIP','Parent')
        else if selSG101.FieldByName('GRADOPAR').AsString = 'FR' then
          insU155.SetVariable('RELATIONSHIP','Sibling');
        if Trim(selSG101.FieldByName('NAZIONE').AsString) = '' then
          insU155.SetVariable('NATIONALITY','XXX')
        else
          insU155.SetVariable('NATIONALITY',selSG101.FieldByName('NAZIONE').AsString);
        if not selSG101.FieldByName('DATAMAT').IsNull then
          insU155.SetVariable('MARRIAGEDATE',selSG101.FieldByName('DATAMAT').AsDateTime)
        else
          insU155.SetVariable('MARRIAGEDATE',null);
        if not selSG101.FieldByName('DATASEP').IsNull then
        begin
          if selSG101.FieldByName('MOTIVO_ESCLUSIONE').AsString = '2' then
          begin
            insU155.SetVariable('DIVORCEDATE',selSG101.FieldByName('DATASEP').AsDateTime);
            insU155.SetVariable('DEATHDATE',null);
          end
          else if selSG101.FieldByName('MOTIVO_ESCLUSIONE').AsString = '1' then
          begin
            insU155.SetVariable('DIVORCEDATE',null);
            insU155.SetVariable('DEATHDATE',selSG101.FieldByName('DATASEP').AsDateTime)
          end
          else
          begin
            insU155.SetVariable('DIVORCEDATE',null);
            insU155.SetVariable('DEATHDATE',null);
          end;
        end
        else
        begin
          insU155.SetVariable('DIVORCEDATE',null);
          insU155.SetVariable('DEATHDATE',null);
        end;
        insU155.SetVariable('LASTUPDATED',StrToDate('01/' + edtMeseElaborazione.Text));
        try
          insU155.Execute;
        except
          on E:Exception do
            RegistraMsg.InserisciMessaggio('A','Inserimento in U155_UNJSPF_DEPENDANTS fallito. ' + E.Message,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        end;
        SessioneOracle.Commit;
      end;
      selSG101.Next;
    end;
  end;
end;

procedure TP288FElaborazioneUnjspf.CaricaChild;
begin
  with P288FElaborazioneUnjspfDtM do
  begin
    //Leggo i dati di SG101 alla data fine mese per estrarre i figli
    selSG101.Close;
    selSG101.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selSG101.SetVariable('DATARIFERIMENTO',StrToDate(edtDataElaborazione.Text));
    selSG101.SetVariable('GRADOPAR','AND GRADOPAR = ''FG''');
    selSG101.Open;
    while not selSG101.Eof do
    begin
      insU160.SetVariable('ID_UNJSPF',Id_UNJSPF_Aperto);
      insU160.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      insU160.SetVariable('EMPLOYEE_NUMBER','7' + C700SelAnagrafe.FieldByName('MATRICOLA').AsString);
      insU160.SetVariable('ORGCHILDID',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger * 100000 + selSG101.FieldByName('NUMORD').AsInteger);
      insU160.SetVariable('LASTNAME',selSG101.FieldByName('COGNOME_PULITO').AsString);
      insU160.SetVariable('FIRSTNAME',selSG101.FieldByName('NOME_PULITO').AsString);
      if not selSG101.FieldByName('DATANAS').IsNull then
        insU160.SetVariable('BIRTHDATE',selSG101.FieldByName('DATANAS').AsDateTime)
      else
        insU160.SetVariable('BIRTHDATE',null);
      insU160.SetVariable('GENDER',IfThen(selSG101.FieldByName('SESSO').AsString = 'M','Male','Female'));
      if Trim(selSG101.FieldByName('NAZIONE').AsString) = '' then
        insU160.SetVariable('NATIONALITY','XXX')
      else
        insU160.SetVariable('NATIONALITY',selSG101.FieldByName('NAZIONE').AsString);
      if not selSG101.FieldByName('DATASEP').IsNull then
      begin
        if selSG101.FieldByName('MOTIVO_ESCLUSIONE').AsString = '1' then
          insU160.SetVariable('DEATHDATE',selSG101.FieldByName('DATASEP').AsDateTime)
        else
          insU160.SetVariable('DEATHDATE',null);
      end
      else
        insU160.SetVariable('DEATHDATE',null);
      //DISABILITYDATE = estrarre la data di inizio disabilità dell’ultimo periodo antecedente la data di elaborazione
      selSG101a.Close;
      selSG101a.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      selSG101a.SetVariable('NUMORD',selSG101.FieldByName('NUMORD').AsInteger);
      selSG101a.SetVariable('DATARIFERIMENTO',StrToDate(edtDataElaborazione.Text));
      selSG101a.Open;
      if not selSG101a.FieldByName('DECORRENZA').IsNull then
      begin
        insU160.SetVariable('DISABILITYDATE',selSG101a.FieldByName('DECORRENZA').AsDateTime);
        //DISABILITYENDDATE = MIN(SG101.DECORRENZA)-1 in cui INABILE_ANF=N dei periodi storici successivi a DISABILITYDATE
        selSG101b.Close;
        selSG101b.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        selSG101b.SetVariable('NUMORD',selSG101.FieldByName('NUMORD').AsInteger);
        selSG101b.SetVariable('DATARIFERIMENTO',selSG101a.FieldByName('DECORRENZA').AsDateTime);
        selSG101b.Open;
        if not selSG101b.FieldByName('DECORRENZA').IsNull then
          insU160.SetVariable('DISABILITYENDDATE',selSG101b.FieldByName('DECORRENZA').AsDateTime)
        else
          insU160.SetVariable('DISABILITYENDDATE',null);
      end
      else
      begin
        insU160.SetVariable('DISABILITYDATE',null);
        insU160.SetVariable('DISABILITYENDDATE',null);
      end;
      insU160.SetVariable('LASTUPDATED',StrToDate('01/' + edtMeseElaborazione.Text));
      try
        insU160.Execute;
      except
        on E:Exception do
          RegistraMsg.InserisciMessaggio('A','Inserimento in U160_UNJSPF_CHILDS fallito. ' + E.Message,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      end;
      SessioneOracle.Commit;
      selSG101.Next;
    end;
  end;
end;

function TP288FElaborazioneUnjspf.PeriodoValido(InizioPeriodo,FinePeriodo:TDateTime):Boolean;
var i:Integer;
begin
  //Considero i periodi che intersecano i periodi di servizio contrattuali e
  //intersecano il periodo Inizio storico - Data elaborazione
  Result:=False;
  if FinePeriodo = null then
    FinePeriodo:=StrToDate('31/12/3999');
  for i:=0 to Length(lstStoriaContract) - 1 do
  begin
    if (InizioPeriodo <= StrToDate(edtDataElaborazione.Text)) and
       (FinePeriodo >= StrToDate(edtDataInizioEstraz.Text)) and
       (InizioPeriodo <= lstStoriaContract[i].Fine) and
       (FinePeriodo >= lstStoriaContract[i].Inizio) then
    begin
      StartDate:=lstStoriaContract[i].Inizio;
      EndDate:=lstStoriaContract[i].Fine;
      Result:=True;
      Break;
    end;
  end;
end;

procedure TP288FElaborazioneUnjspf.CaricaLanguageAllowance;
var i:Integer;
  OldFirst,OldSecond:String;
begin
  with P288FElaborazioneUnjspfDtM do
  begin
    selT430.Close;
    selT430.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selT430.SetVariable('DATI','DATADECORRENZA, DATAFINE, FIRST_LAN_ALL, SECOND_LANG_ALL');
    selT430.SetVariable('FILTRO',' ');
    selT430.Open;
    SetLength(lstStoria,0);
    OldFirst:='';
    OldSecond:='';
    //Carico nel vettore tutti i periodi di language per creare la 'storia dei dati'
    while not selT430.Eof do
    begin
      if Trim(selT430.FieldByName('FIRST_LAN_ALL').AsString) <> '' then
      begin
        //Scrivo solo al variare dei dati language
        if (selT430.FieldByName('FIRST_LAN_ALL').AsString <> OldFirst) or
           (selT430.FieldByName('SECOND_LANG_ALL').AsString <> OldSecond) then
        begin
          SetLength(lstStoria,Length(lstStoria)+1);
          lstStoria[High(lstStoria)].Inizio:=selT430.FieldByName('DATADECORRENZA').AsDateTime;
          lstStoria[High(lstStoria)].Fine:=selT430.FieldByName('DATAFINE').AsDateTime;
          if Trim(selT430.FieldByName('SECOND_LANG_ALL').AsString) = '' then
            lstStoria[High(lstStoria)].Valore:='1'
          else
            lstStoria[High(lstStoria)].Valore:='2';
        end
        else  //Se non cambiano aggiorno l'ultima datafine
          lstStoria[High(lstStoria)].Fine:=selT430.FieldByName('DATAFINE').AsDateTime;
        OldFirst:=selT430.FieldByName('FIRST_LAN_ALL').AsString;
        OldSecond:=selT430.FieldByName('SECOND_LANG_ALL').AsString;
      end;
      selT430.Next;
    end;
    //Carico i periodi validi
    for i:=0 to High(lstStoria) do
    begin
      if PeriodoValido(lstStoria[i].Inizio,lstStoria[i].Fine) then
      begin
        insU125.SetVariable('ID_UNJSPF',Id_UNJSPF_Aperto);
        insU125.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        insU125.SetVariable('EMPLOYEE_NUMBER','7' + C700SelAnagrafe.FieldByName('MATRICOLA').AsString);
        //L'inizio non può essere antecedente la StartDate di contract
        if lstStoria[i].Inizio < StartDate then
          insU125.SetVariable('START_DATE',StartDate)
        else
          insU125.SetVariable('START_DATE',lstStoria[i].Inizio);
        insU125.SetVariable('COUNT',StrToInt(lstStoria[i].Valore));
        insU125.SetVariable('LASTUPDATED',StrToDate('01/' + edtMeseElaborazione.Text));
        try
          insU125.Execute;
        except
          on E:Exception do
            RegistraMsg.InserisciMessaggio('A','Inserimento in U125_UNJSPF_LANG_ALLWNCS fallito. ' + E.Message,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        end;
        SessioneOracle.Commit;
      end;
    end;
  end;
end;

procedure TP288FElaborazioneUnjspf.CaricaPartTime;
var i:Integer;
  Anom:Boolean;
  OldPT:String;
begin
  C006FStoriaDati:=TC006FStoriaDati.Create(nil);
  C006FStoriaDati.GetStoriaDatoP430(C700Progressivo,'COD_PARTTIME',0,'N');
  with P288FElaborazioneUnjspfDtM, C006FStoriaDati do
  begin
    OldPT:='#'; //Inizializzo ad un valore fittizio perchè il vuoto equivale a 1
    for i:=0 to StoriaDipendente.Count -1 do
    begin
      //Verifico la validità del periodo
      if PeriodoValido(RecStoria(StoriaDipendente[i]).Decorrenza,RecStoria(StoriaDipendente[i]).Fine) then
      begin
        //Scrivo solo al variare del pt perchè hanno 'Considera Inizio-Fine' su Storia dato Anagrafico = 'S'
        if RecStoria(StoriaDipendente[i]).Valore <> OldPT then
        begin
          Anom:=False;
          insU130.SetVariable('ID_UNJSPF',Id_UNJSPF_Aperto);
          insU130.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          insU130.SetVariable('EMPLOYEE_NUMBER','7' + C700SelAnagrafe.FieldByName('MATRICOLA').AsString);
          //La decorrenza non può essere antecedente la StartDate
          if RecStoria(StoriaDipendente[i]).Decorrenza < StartDate then
            insU130.SetVariable('EFFECTIVEDATE',StartDate)
          else
            insU130.SetVariable('EFFECTIVEDATE',RecStoria(StoriaDipendente[i]).Decorrenza);
          //Se tempo pieno metto 1, altrimenti % pt
          //Se il codice pt non esiste non registro nulla
          if Trim(RecStoria(StoriaDipendente[i]).Valore) = '' then
            insU130.SetVariable('PARTTIMEPERCENTAGE',1)
          else if selP040.SearchRecord('COD_PARTTIME',RecStoria(StoriaDipendente[i]).Valore,[srFromBeginning]) then
            insU130.SetVariable('PARTTIMEPERCENTAGE',selP040.FieldByName('PERCENTUALE').AsFloat / 100)
          else
          begin
            Anom:=True;
            RegistraMsg.InserisciMessaggio('A','Inserimento in U130_UNJSPF_PARTTIMES fallito. Codice parttime ' + RecStoria(StoriaDipendente[i]).Valore + 'inesistente','',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          end;
          insU130.SetVariable('LASTUPDATED',StrToDate('01/' + edtMeseElaborazione.Text));
          if not Anom then
          try
            insU130.Execute;
          except
            on E:Exception do
              RegistraMsg.InserisciMessaggio('A','Inserimento in U130_UNJSPF_PARTTIMES fallito. ' + E.Message,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          end;
          SessioneOracle.Commit;
        end;
        OldPT:=RecStoria(StoriaDipendente[i]).Valore;
      end;
    end;
  end;
  FreeAndNil(C006FStoriaDati);
end;

procedure TP288FElaborazioneUnjspf.CaricaDutyStation;
var i:Integer;
  Anom:Boolean;
  OldDuty:String;
begin
  C006FStoriaDati:=TC006FStoriaDati.Create(nil);
  C006FStoriaDati.GetStoriaDato(C700Progressivo,'UN_DUTY_STATION',0,'N');
  with P288FElaborazioneUnjspfDtM, C006FStoriaDati do
  begin
    Anom:=True;
    OldDuty:='';
    for i:=0 to StoriaDipendente.Count -1 do
    begin
      //Verifico la validità del periodo
      if PeriodoValido(RecStoria(StoriaDipendente[i]).Decorrenza,RecStoria(StoriaDipendente[i]).Fine) then
      begin
        //Scrivo solo al variare del Duty station perchè hanno 'Considera Inizio-Fine' su Storia dato Anagrafico = 'S'
        if RecStoria(StoriaDipendente[i]).Valore <> OldDuty then
        begin
          Anom:=False;
          insU135.SetVariable('ID_UNJSPF',Id_UNJSPF_Aperto);
          insU135.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          insU135.SetVariable('EMPLOYEE_NUMBER','7' + C700SelAnagrafe.FieldByName('MATRICOLA').AsString);
          //La decorrenza non può essere antecedente la StartDate
          if RecStoria(StoriaDipendente[i]).Decorrenza < StartDate then
            insU135.SetVariable('EFFECTIVEDATE',StartDate)
          else
            insU135.SetVariable('EFFECTIVEDATE',RecStoria(StoriaDipendente[i]).Decorrenza);
          insU135.SetVariable('DUTYSTATIONCODE',RecStoria(StoriaDipendente[i]).Valore);
          insU135.SetVariable('LOCATION_CODE',RecStoria(StoriaDipendente[i]).Descrizione);
          selT430a.Close;
          selT430a.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          selT430a.SetVariable('DATARIF',RecStoria(StoriaDipendente[i]).Fine);
          selT430a.Open;
          if selT430a.RecordCount > 0 then
            insU135.SetVariable('DUTYSTATIONCOUNTRY',selT430a.FieldByName('UN_DS_COUNTRY').AsString);
          insU135.SetVariable('LASTUPDATED',StrToDate('01/' + edtMeseElaborazione.Text));
          try
            insU135.Execute;
          except
            on E:Exception do
              RegistraMsg.InserisciMessaggio('A','Inserimento in U135_UNJSPF_DUTY_STTNS fallito. ' + E.Message,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          end;
          SessioneOracle.Commit;
        end;
        OldDuty:=RecStoria(StoriaDipendente[i]).Valore;
      end;
    end;
    //Se non ho caricato nulla e quindi duty station è vuoto segnalo anomalia
    if Anom then
      RegistraMsg.InserisciMessaggio('A','Inserimento in U135_UNJSPF_DUTY_STTNS fallito. Il luogo di lavoro è assente','',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  end;
  FreeAndNil(C006FStoriaDati);
end;

procedure TP288FElaborazioneUnjspf.CaricaSalary;
var i:Integer;
  OldPosiz:String;
begin
  C006FStoriaDati:=TC006FStoriaDati.Create(nil);
  C006FStoriaDati.GetStoriaDatoP430(C700Progressivo,'COD_POSIZIONE_ECONOMICA',0,'N');
  with P288FElaborazioneUnjspfDtM, C006FStoriaDati do
  begin
    OldPosiz:='';
    for i:=0 to StoriaDipendente.Count -1 do
    begin
      //Verifico la validità del periodo
      if PeriodoValido(RecStoria(StoriaDipendente[i]).Decorrenza,RecStoria(StoriaDipendente[i]).Fine) then
      begin
        //Considero i primi 4 caratteri della posizione economica e scrivo solo al variare di questi
        if Copy(RecStoria(StoriaDipendente[i]).Valore,1,4) <> OldPosiz then
        begin
          insU140.SetVariable('ID_UNJSPF',Id_UNJSPF_Aperto);
          insU140.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          insU140.SetVariable('EMPLOYEE_NUMBER','7' + C700SelAnagrafe.FieldByName('MATRICOLA').AsString);
          //La decorrenza non può essere antecedente la StartDate
          if RecStoria(StoriaDipendente[i]).Decorrenza < StartDate then
            insU140.SetVariable('EFFECTIVEDATE',StartDate)
          else
            insU140.SetVariable('EFFECTIVEDATE',RecStoria(StoriaDipendente[i]).Decorrenza);
          insU140.SetVariable('CATEGORY',Copy(RecStoria(StoriaDipendente[i]).Valore,1,1));
          insU140.SetVariable('GRADE',Copy(RecStoria(StoriaDipendente[i]).Valore,2,1));
          insU140.SetVariable('STEP',IntToStr(StrToIntDef(Copy(RecStoria(StoriaDipendente[i]).Valore,3,2),0)));
          insU140.SetVariable('LASTUPDATED',StrToDate('01/' + edtMeseElaborazione.Text));
          try
            insU140.Execute;
          except
            on E:Exception do
              RegistraMsg.InserisciMessaggio('A','Inserimento in U140_UNJSPF_SALARIES fallito. ' + E.Message,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          end;
          SessioneOracle.Commit;
        end;
        OldPosiz:=Copy(RecStoria(StoriaDipendente[i]).Valore,1,4);
      end;
    end;
  end;
  FreeAndNil(C006FStoriaDati);
end;

procedure TP288FElaborazioneUnjspf.CaricaLeaveWithoutPay;
var i:Integer;
  Anom:Boolean;
  OldInizio,OldFine:TDateTime;
begin
  with P288FElaborazioneUnjspfDtM do
  begin
    insU165.SetVariable('ID_UNJSPF',Id_UNJSPF_Aperto);
    insU165.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    insU165.SetVariable('EMPLOYEE_NUMBER','7' + C700SelAnagrafe.FieldByName('MATRICOLA').AsString);
    selT430.Close;
    selT430.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selT430.SetVariable('DATI','SL_START, SL_END');
    selT430.SetVariable('FILTRO','AND SPECIAL_LEAVE = ''SLWOP''');
    selT430.Open;
    SetLength(lstStoria,0);
    //Carico nel vettore tutti i periodi StartDate-EndDate significativi
    while not selT430.Eof do
    begin
      if (not selT430.FieldByName('SL_START').IsNull) and
         (PeriodoValido(selT430.FieldByName('SL_START').AsDateTime,selT430.FieldByName('SL_END').AsDateTime)) then
      begin
        SetLength(lstStoria,Length(lstStoria)+1);
        //L'inizio non può essere antecedente la StartDate di contract
        if selT430.FieldByName('SL_START').AsDateTime < StartDate then
          lstStoria[High(lstStoria)].Inizio:=StartDate
        else
          lstStoria[High(lstStoria)].Inizio:=selT430.FieldByName('SL_START').AsDateTime;
        //La fine non può essere successiva a EndDate di contract
        if selT430.FieldByName('SL_END').IsNull then
        begin
          if EndDate < StrToDate('31/12/3999') then
            lstStoria[High(lstStoria)].Fine:=EndDate
          else
            lstStoria[High(lstStoria)].Fine:=StrToDate('31/12/3999');
        end
        else
        begin
          if selT430.FieldByName('SL_END').AsDateTime > EndDate then
            lstStoria[High(lstStoria)].Fine:=EndDate
          else
            lstStoria[High(lstStoria)].Fine:=selT430.FieldByName('SL_END').AsDateTime;
        end;
      end;
      selT430.Next;
    end;
    //Se ho più di un periodo, scorro sul vettore per segnalare eventuali periodi intersecanti
    Anom:=False;
    if Length(lstStoria) > 1 then
    begin
      OldInizio:=0;
      OldFine:=0;
      for i:=0 to High(lstStoria) do
      begin
        if (lstStoria[i].Inizio <= OldFine) and
           (lstStoria[i].Fine >= OldInizio) then
        begin
          Anom:=True;
          RegistraMsg.InserisciMessaggio('A','Inserimento in U165_UNJSPF_LWOP fallito. Periodi intersecanti (SL_START-SL_END)','',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          Break;
        end;
        OldInizio:=lstStoria[i].Inizio;
        OldFine:=lstStoria[i].Fine;
      end;
    end;
    //Se non ho anomalie scorro sul vettore per caricare
    if not Anom then
      for i:=0 to High(lstStoria) do
      begin
        //Registro come StartDate la prima data del periodo continuativo
        insU165.SetVariable('STARTDATE',lstStoria[i].Inizio);
        //Registro come EndDate quella valida alla data fine mese
        if lstStoria[i].Fine = StrToDate('31/12/3999') then
          insU165.SetVariable('ENDDATE',null)
        else
          insU165.SetVariable('ENDDATE',lstStoria[i].Fine);
        insU165.SetVariable('LASTUPDATED',StrToDate('01/' + edtMeseElaborazione.Text));
        try
          insU165.Execute;
        except
          on E:Exception do
            RegistraMsg.InserisciMessaggio('A','Inserimento in U165_UNJSPF_LWOP fallito. ' + E.Message,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        end;
        SessioneOracle.Commit;
      end;
    end;
end;

procedure TP288FElaborazioneUnjspf.CaricaAddress;
var i:Integer;
  OldAddress, OldCity, OldCap, OldCountry:String;
  Anom:Boolean;
begin
  with P288FElaborazioneUnjspfDtM do
  begin
    Anom:=True;
    selT430.Close;
    selT430.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selT430.SetVariable('DATI','DATADECORRENZA, DATAFINE, ADDRESS, CITY_RESIDENCE, CAP, UN_RES_COUNTRY');
    selT430.SetVariable('FILTRO',' ');
    selT430.Open;
    SetLength(lstStoria,0);
    OldAddress:='';
    OldCity:='';
    OldCap:='';
    OldCountry:='';
    //Carico nel vettore tutti i periodi di address per creare la 'storia dei dati'
    while not selT430.Eof do
    begin
      if (Trim(selT430.FieldByName('ADDRESS').AsString) <> '') or
         (Trim(selT430.FieldByName('CITY_RESIDENCE').AsString) <> '') or
         (Trim(selT430.FieldByName('CAP').AsString) <> '') or
         (Trim(selT430.FieldByName('UN_RES_COUNTRY').AsString) <> '') then
      begin
        //Scrivo solo al variare dei dati address
        if (selT430.FieldByName('ADDRESS').AsString <> OldAddress) or
           (selT430.FieldByName('CITY_RESIDENCE').AsString <> OldCity) or
           (selT430.FieldByName('CAP').AsString <> OldCap) or
           (selT430.FieldByName('UN_RES_COUNTRY').AsString <> OldCountry) then
        begin
          SetLength(lstStoria,Length(lstStoria)+1);
          lstStoria[High(lstStoria)].Inizio:=selT430.FieldByName('DATADECORRENZA').AsDateTime;
          lstStoria[High(lstStoria)].Fine:=selT430.FieldByName('DATAFINE').AsDateTime;
        end
        else  //Se non cambiano aggiorno l'ultima datafine
          lstStoria[High(lstStoria)].Fine:=selT430.FieldByName('DATAFINE').AsDateTime;
        OldAddress:=selT430.FieldByName('ADDRESS').AsString;
        OldCity:=selT430.FieldByName('CITY_RESIDENCE').AsString;
        OldCap:=selT430.FieldByName('CAP').AsString;
        OldCountry:=selT430.FieldByName('UN_RES_COUNTRY').AsString;
      end;
      selT430.Next;
    end;
    //Carico il periodo valido alla data elaborazione leggendo i dati dal dataset principale selV430
    for i:=0 to High(lstStoria) do
    begin
      Anom:=False;
      if (PeriodoValido(lstStoria[i].Inizio,lstStoria[i].Fine)) and
         (StrToDate(edtDataElaborazione.Text) >= lstStoria[i].Inizio) and
         (StrToDate(edtDataElaborazione.Text) <= lstStoria[i].Fine) then
      begin
        insU170.SetVariable('ID_UNJSPF',Id_UNJSPF_Aperto);
        insU170.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        insU170.SetVariable('EMPLOYEE_NUMBER','7' + C700SelAnagrafe.FieldByName('MATRICOLA').AsString);
        insU170.SetVariable('ADDRESS_TYPE','Home');
        //L'inizio non può essere antecedente la StartDate di contract
        if lstStoria[i].Inizio < StartDate then
          insU170.SetVariable('EFFECTIVEDATE',StartDate)
        else
          insU170.SetVariable('EFFECTIVEDATE',lstStoria[i].Inizio);
        insU170.SetVariable('LINE1',selV430.FieldByName('T430ADDRESS').AsString);
        insU170.SetVariable('CITY',selV430.FieldByName('T430D_CITY_RESIDENCE').AsString);
        insU170.SetVariable('POSTALCODE',selV430.FieldByName('T430CAP').AsString);
        insU170.SetVariable('COUNTRY',selV430.FieldByName('T430D_UN_RES_COUNTRY').AsString);
        insU170.SetVariable('COUNTRYISOCODE',selV430.FieldByName('T430UN_RES_COUNTRY').AsString);
        try
          insU170.Execute;
        except
          on E:Exception do
            RegistraMsg.InserisciMessaggio('A','Inserimento in U170_UNJSPF_ADDRESS fallito. ' + E.Message,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        end;
        SessioneOracle.Commit;
      end;
    end;
    //Se non ho caricato nulla e quindi address è vuoto segnalo anomalia
    if Anom then
      RegistraMsg.InserisciMessaggio('A','Inserimento in U170_UNJSPF_ADDRESS fallito. L''indirizzo è assente','',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  end;
end;

procedure TP288FElaborazioneUnjspf.CaricaPhone;
begin
  with P288FElaborazioneUnjspfDtM do
  begin
    //Carico il dipendente leggendo i dati alla fine mese da selV430
    insU175.SetVariable('ID_UNJSPF',Id_UNJSPF_Aperto);
    insU175.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    insU175.SetVariable('EMPLOYEE_NUMBER','7' + C700SelAnagrafe.FieldByName('MATRICOLA').AsString);
    if Trim(selV430.FieldByName('T430TELEFONO').AsString) = '' then
    begin
      insU175.SetVariable('PHONE_TYPE','Office');
      insU175.SetVariable('PHONE_NUMBER','+390116936111');
    end
    else
    begin
      insU175.SetVariable('PHONE_TYPE','Home');
      insU175.SetVariable('PHONE_NUMBER',selV430.FieldByName('T430TELEFONO').AsString);
    end;
    try
      insU175.Execute;
    except
      on E:Exception do
        RegistraMsg.InserisciMessaggio('A','Inserimento in U175_UNJSPF_PHONES fallito. ' + E.Message,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    end;
    SessioneOracle.Commit;
  end;
end;

procedure TP288FElaborazioneUnjspf.CaricaEmail;
begin
  with P288FElaborazioneUnjspfDtM do
  begin
    //Carico il dipendente leggendo i dati alla fine mese da selV430
    if Trim(selV430.FieldByName('T430UN_EMAIL').AsString) <> '' then
    begin
      insU180.SetVariable('ID_UNJSPF',Id_UNJSPF_Aperto);
      insU180.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      insU180.SetVariable('EMPLOYEE_NUMBER','7' + C700SelAnagrafe.FieldByName('MATRICOLA').AsString);
      if Pos('@itcilo.org',selV430.FieldByName('T430UN_EMAIL').AsString) > 0 then
        insU180.SetVariable('TYPE','Work')
      else
        insU180.SetVariable('TYPE','Private');
      insU180.SetVariable('EMAILADDRESS',selV430.FieldByName('T430UN_EMAIL').AsString);
      try
        insU180.Execute;
      except
        on E:Exception do
          RegistraMsg.InserisciMessaggio('A','Inserimento in U180_UNJSPF_EMAILS fallito. ' + E.Message,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      end;
      SessioneOracle.Commit;
    end;
  end;
end;

procedure TP288FElaborazioneUnjspf.CaricaPayment;
var lstAppoggio: array of TPeriodiPayment;
  lstOrdinamento: array of TPeriodiPayment;
  i,j,GiorniPeriodo, TotGGMese:Integer;
  ImpUnitario,Importo,CoeffCambio,Proratedratio,Totale:Real;
  DataCambioValuta, DataCorrente, OldMese:TDateTime;
  procedure Carico(lstPartenza: String; Ind:Integer);
  begin
    if lstPartenza = 'lstPeriodiPay' then
    begin
      lstOrdinamento[High(lstOrdinamento)].InizioPeriodo:=lstPeriodiPay[Ind].InizioPeriodo;
      lstOrdinamento[High(lstOrdinamento)].FinePeriodo:=lstPeriodiPay[Ind].FinePeriodo;
      lstOrdinamento[High(lstOrdinamento)].PensionNumber:=lstPeriodiPay[Ind].PensionNumber;
      lstOrdinamento[High(lstOrdinamento)].Category:=lstPeriodiPay[Ind].Category;
      lstOrdinamento[High(lstOrdinamento)].Grade:=lstPeriodiPay[Ind].Grade;
      lstOrdinamento[High(lstOrdinamento)].Step:=lstPeriodiPay[Ind].Step;
      lstOrdinamento[High(lstOrdinamento)].DutyStation:=lstPeriodiPay[Ind].DutyStation;
      lstOrdinamento[High(lstOrdinamento)].Parttime:=lstPeriodiPay[Ind].Parttime;
      lstOrdinamento[High(lstOrdinamento)].CurrencyCode:=lstPeriodiPay[Ind].CurrencyCode;
      lstOrdinamento[High(lstOrdinamento)].LangAllow:=lstPeriodiPay[Ind].LangAllow;
      lstOrdinamento[High(lstOrdinamento)].LWOP:=lstPeriodiPay[Ind].LWOP;
      lstOrdinamento[High(lstOrdinamento)].TransactionType:=lstPeriodiPay[Ind].TransactionType;
      lstOrdinamento[High(lstOrdinamento)].Exchange_rate:=lstPeriodiPay[Ind].Exchange_rate;
      lstOrdinamento[High(lstOrdinamento)].Prrate_local_amount:=lstPeriodiPay[Ind].Prrate_local_amount;
      lstOrdinamento[High(lstOrdinamento)].Language_allowancelocal_amount:=lstPeriodiPay[Ind].Language_allowancelocal_amount;
      lstOrdinamento[High(lstOrdinamento)].Proratedratio:=lstPeriodiPay[Ind].Proratedratio;
      lstOrdinamento[High(lstOrdinamento)].Contribution_local_amountsm:=lstPeriodiPay[Ind].Contribution_local_amountsm;
      lstOrdinamento[High(lstOrdinamento)].Contribution_local_amountorg:=lstPeriodiPay[Ind].Contribution_local_amountorg;
      lstOrdinamento[High(lstOrdinamento)].Adjustment_local_amountsm:=lstPeriodiPay[Ind].Adjustment_local_amountsm;
      lstOrdinamento[High(lstOrdinamento)].Adjustment_local_amountorg:=lstPeriodiPay[Ind].Adjustment_local_amountorg;
      lstOrdinamento[High(lstOrdinamento)].Adjustment_local_amountfullsm:=lstPeriodiPay[Ind].Adjustment_local_amountfullsm;
      lstOrdinamento[High(lstOrdinamento)].Adjustment_local_amountfullorg:=lstPeriodiPay[Ind].Adjustment_local_amountfullorg;
      lstOrdinamento[High(lstOrdinamento)].Validation_amountsm:=lstPeriodiPay[Ind].Validation_amountsm;
      lstOrdinamento[High(lstOrdinamento)].Validation_amountorg:=lstPeriodiPay[Ind].Validation_amountorg;
      lstOrdinamento[High(lstOrdinamento)].Restoration_amountsm:=lstPeriodiPay[Ind].Restoration_amountsm;
      lstOrdinamento[High(lstOrdinamento)].Restoration_amountorg:=lstPeriodiPay[Ind].Restoration_amountorg;
      lstOrdinamento[High(lstOrdinamento)].Actuarial_costssm:=lstPeriodiPay[Ind].Actuarial_costssm;
      lstOrdinamento[High(lstOrdinamento)].Actuarial_costsorg:=lstPeriodiPay[Ind].Actuarial_costsorg;
      lstOrdinamento[High(lstOrdinamento)].Interest_contributionsm:=lstPeriodiPay[Ind].Interest_contributionsm;
      lstOrdinamento[High(lstOrdinamento)].Interest_contributionorg:=lstPeriodiPay[Ind].Interest_contributionorg;
      lstOrdinamento[High(lstOrdinamento)].Misc_adjustmentsm:=lstPeriodiPay[Ind].Misc_adjustmentsm;
      lstOrdinamento[High(lstOrdinamento)].Misc_adjustmentorg:=lstPeriodiPay[Ind].Misc_adjustmentorg;
    end
    else
    begin
      lstOrdinamento[High(lstOrdinamento)].InizioPeriodo:=lstAppoggio[Ind].InizioPeriodo;
      lstOrdinamento[High(lstOrdinamento)].FinePeriodo:=lstAppoggio[Ind].FinePeriodo;
      lstOrdinamento[High(lstOrdinamento)].PensionNumber:=lstAppoggio[Ind].PensionNumber;
      lstOrdinamento[High(lstOrdinamento)].Category:=lstAppoggio[Ind].Category;
      lstOrdinamento[High(lstOrdinamento)].Grade:=lstAppoggio[Ind].Grade;
      lstOrdinamento[High(lstOrdinamento)].Step:=lstAppoggio[Ind].Step;
      lstOrdinamento[High(lstOrdinamento)].DutyStation:=lstAppoggio[Ind].DutyStation;
      lstOrdinamento[High(lstOrdinamento)].Parttime:=lstAppoggio[Ind].Parttime;
      lstOrdinamento[High(lstOrdinamento)].CurrencyCode:=lstAppoggio[Ind].CurrencyCode;
      lstOrdinamento[High(lstOrdinamento)].LangAllow:=lstAppoggio[Ind].LangAllow;
      lstOrdinamento[High(lstOrdinamento)].LWOP:=lstAppoggio[Ind].LWOP;
      lstOrdinamento[High(lstOrdinamento)].TransactionType:=lstAppoggio[Ind].TransactionType;
      lstOrdinamento[High(lstOrdinamento)].Exchange_rate:=lstAppoggio[Ind].Exchange_rate;
      lstOrdinamento[High(lstOrdinamento)].Prrate_local_amount:=lstAppoggio[Ind].Prrate_local_amount;
      lstOrdinamento[High(lstOrdinamento)].Language_allowancelocal_amount:=lstAppoggio[Ind].Language_allowancelocal_amount;
      lstOrdinamento[High(lstOrdinamento)].Proratedratio:=lstAppoggio[Ind].Proratedratio;
      lstOrdinamento[High(lstOrdinamento)].Contribution_local_amountsm:=lstAppoggio[Ind].Contribution_local_amountsm;
      lstOrdinamento[High(lstOrdinamento)].Contribution_local_amountorg:=lstAppoggio[Ind].Contribution_local_amountorg;
      lstOrdinamento[High(lstOrdinamento)].Adjustment_local_amountsm:=lstAppoggio[Ind].Adjustment_local_amountsm;
      lstOrdinamento[High(lstOrdinamento)].Adjustment_local_amountorg:=lstAppoggio[Ind].Adjustment_local_amountorg;
      lstOrdinamento[High(lstOrdinamento)].Adjustment_local_amountfullsm:=lstAppoggio[Ind].Adjustment_local_amountfullsm;
      lstOrdinamento[High(lstOrdinamento)].Adjustment_local_amountfullorg:=lstAppoggio[Ind].Adjustment_local_amountfullorg;
      lstOrdinamento[High(lstOrdinamento)].Validation_amountsm:=lstAppoggio[Ind].Validation_amountsm;
      lstOrdinamento[High(lstOrdinamento)].Validation_amountorg:=lstAppoggio[Ind].Validation_amountorg;
      lstOrdinamento[High(lstOrdinamento)].Restoration_amountsm:=lstAppoggio[Ind].Restoration_amountsm;
      lstOrdinamento[High(lstOrdinamento)].Restoration_amountorg:=lstAppoggio[Ind].Restoration_amountorg;
      lstOrdinamento[High(lstOrdinamento)].Actuarial_costssm:=lstAppoggio[Ind].Actuarial_costssm;
      lstOrdinamento[High(lstOrdinamento)].Actuarial_costsorg:=lstAppoggio[Ind].Actuarial_costsorg;
      lstOrdinamento[High(lstOrdinamento)].Interest_contributionsm:=lstAppoggio[Ind].Interest_contributionsm;
      lstOrdinamento[High(lstOrdinamento)].Interest_contributionorg:=lstAppoggio[Ind].Interest_contributionorg;
      lstOrdinamento[High(lstOrdinamento)].Misc_adjustmentsm:=lstAppoggio[Ind].Misc_adjustmentsm;
      lstOrdinamento[High(lstOrdinamento)].Misc_adjustmentorg:=lstAppoggio[Ind].Misc_adjustmentorg;
    end;
  end;
begin
  with P288FElaborazioneUnjspfDtM do
  begin
    //----------------------------------------------------------------------------------------------
    //Leggo tutti i record dei CEDOLINI contenenti le voci 11600 con data cedolino uguale a quella dell’estrazione
    //----------------------------------------------------------------------------------------------
    selP442.Close;
    selP442.SetVariable('Progressivo',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selP442.SetVariable('MeseElaborazione',' = TO_DATE(''' + DateToStr(R180FineMese(StrToDate('01/' + edtMeseElaborazione.Text))) + ''',''DD/MM/YYYY'')');
    case rgpStatoCedolini.ItemIndex of
      0:selP442.SetVariable('StatoCedolini','''S''');
      1:selP442.SetVariable('StatoCedolini','''S'',''N''');
      2:selP442.SetVariable('StatoCedolini','''N''');
    end;
    selP442.SetVariable('Voci','''11600''');
    selP442.Open;
    SetLength(lstPeriodiPay,0);
    SetLength(lstAppoggio,0);
    while not selP442.Eof do
    begin
      SetLength(lstPeriodiPay,Length(lstPeriodiPay)+1);
      lstPeriodiPay[High(lstPeriodiPay)].InizioPeriodo:=selP442.FieldByName('DATA_COMPETENZA_DA').AsDateTime;
      lstPeriodiPay[High(lstPeriodiPay)].FinePeriodo:=selP442.FieldByName('DATA_COMPETENZA_A').AsDateTime;
      selP442.Next;
    end;
    //Controllo che non ci siano intersezioni e nel caso spezzo
    for i:=0 to High(lstPeriodiPay) do
    begin
      if i = 0 then
      begin
        SetLength(lstAppoggio,Length(lstAppoggio)+1);
        lstAppoggio[High(lstAppoggio)].InizioPeriodo:=lstPeriodiPay[i].InizioPeriodo;
        lstAppoggio[High(lstAppoggio)].FinePeriodo:=lstPeriodiPay[i].FinePeriodo;
      end
      else
      begin
        if (lstPeriodiPay[i].InizioPeriodo >= lstPeriodiPay[i-1].InizioPeriodo) and
           (lstPeriodiPay[i].InizioPeriodo <= lstPeriodiPay[i-1].FinePeriodo) then
        begin
          RegistraMsg.InserisciMessaggio('I','E'' stato necessario spezzare dei periodi di competenza relativi ai contributi pensionistici trattenuti, eventualmente poi riunificati: verificare la corretta distribuzione degli stessi','',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          if lstPeriodiPay[i].InizioPeriodo > lstPeriodiPay[i-1].InizioPeriodo then
          begin
            lstAppoggio[High(lstAppoggio)].FinePeriodo:=lstPeriodiPay[i].InizioPeriodo-1;
            if (lstPeriodiPay[i].FinePeriodo >= lstPeriodiPay[i-1].FinePeriodo) then
            begin
              SetLength(lstAppoggio,Length(lstAppoggio)+1);
              lstAppoggio[High(lstAppoggio)].InizioPeriodo:=lstPeriodiPay[i].InizioPeriodo;
              lstAppoggio[High(lstAppoggio)].FinePeriodo:=lstPeriodiPay[i-1].FinePeriodo;
              if (lstPeriodiPay[i].FinePeriodo > lstPeriodiPay[i-1].FinePeriodo) then
              begin
                SetLength(lstAppoggio,Length(lstAppoggio)+1);
                lstAppoggio[High(lstAppoggio)].InizioPeriodo:=lstPeriodiPay[i-1].FinePeriodo+1;
                lstAppoggio[High(lstAppoggio)].FinePeriodo:=lstPeriodiPay[i].FinePeriodo;
              end;
            end
            else
            begin
              SetLength(lstAppoggio,Length(lstAppoggio)+1);
              lstAppoggio[High(lstAppoggio)].InizioPeriodo:=lstPeriodiPay[i].InizioPeriodo;
              lstAppoggio[High(lstAppoggio)].FinePeriodo:=lstPeriodiPay[i].FinePeriodo;
              SetLength(lstAppoggio,Length(lstAppoggio)+1);
              lstAppoggio[High(lstAppoggio)].InizioPeriodo:=lstPeriodiPay[i].FinePeriodo+1;
              lstAppoggio[High(lstAppoggio)].FinePeriodo:=lstPeriodiPay[i-1].FinePeriodo;
            end;
          end
          else
          begin
            if lstPeriodiPay[i].FinePeriodo > lstPeriodiPay[i-1].FinePeriodo then
            begin
              SetLength(lstAppoggio,Length(lstAppoggio)+1);
              lstAppoggio[High(lstAppoggio)].InizioPeriodo:=lstPeriodiPay[i-1].FinePeriodo+1;
              lstAppoggio[High(lstAppoggio)].FinePeriodo:=lstPeriodiPay[i].FinePeriodo;
             end;
          end;
        end
        else
        begin
          SetLength(lstAppoggio,Length(lstAppoggio)+1);
          lstAppoggio[High(lstAppoggio)].InizioPeriodo:=lstPeriodiPay[i].InizioPeriodo;
          lstAppoggio[High(lstAppoggio)].FinePeriodo:=lstPeriodiPay[i].FinePeriodo;
        end;
      end;
    end;
    //I periodi ottenuti vanno spezzati se all’interno di essi si è verificata una o più variazioni di part-time/full time
    //o di posizione economica sull’anagrafica stipendiale
    SetLength(lstPeriodiPay,0);
    for i:=0 to High(lstAppoggio) do
    begin
      selP430.Close;
      selP430.SetVariable('Progressivo',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      selP430.SetVariable('InizioPeriodo',lstAppoggio[i].InizioPeriodo);
      selP430.SetVariable('FinePeriodo',lstAppoggio[i].FinePeriodo);
      selP430.Open;
      while not selP430.Eof do
      begin
        if selP430.FieldByName('T430DATADECORRENZA').AsDateTime > lstAppoggio[i].InizioPeriodo then
        begin
          if (selP430.FieldByName('PARTTIME').AsFloat <> lstPeriodiPay[High(lstPeriodiPay)].Parttime) or
             (selP430.FieldByName('CATEGORY').AsString <> lstPeriodiPay[High(lstPeriodiPay)].Category) or
             (selP430.FieldByName('GRADE').AsString <> lstPeriodiPay[High(lstPeriodiPay)].Grade) or
             (selP430.FieldByName('STEP').AsString <> lstPeriodiPay[High(lstPeriodiPay)].Step) or
             (selP430.FieldByName('LANG_ALLOW').AsString <> lstPeriodiPay[High(lstPeriodiPay)].LangAllow) then
          begin
            RegistraMsg.InserisciMessaggio('I','E'' stato necessario spezzare dei periodi di competenza relativi ai contributi pensionistici trattenuti: verificare la corretta distribuzione degli stessi','',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
            lstPeriodiPay[High(lstPeriodiPay)].FinePeriodo:=selP430.FieldByName('T430DATADECORRENZA').AsDateTime-1;
            if selP430.FieldByName('T430DATAFINE').AsDateTime >= lstAppoggio[i].FinePeriodo then
            begin
              SetLength(lstPeriodiPay,Length(lstPeriodiPay)+1);
              lstPeriodiPay[High(lstPeriodiPay)].InizioPeriodo:=selP430.FieldByName('T430DATADECORRENZA').AsDateTime;
              lstPeriodiPay[High(lstPeriodiPay)].FinePeriodo:=lstAppoggio[i].FinePeriodo;
            end
            else
            begin
              SetLength(lstPeriodiPay,Length(lstPeriodiPay)+1);
              lstPeriodiPay[High(lstPeriodiPay)].InizioPeriodo:=selP430.FieldByName('T430DATADECORRENZA').AsDateTime;
              lstPeriodiPay[High(lstPeriodiPay)].FinePeriodo:=selP430.FieldByName('T430DATAFINE').AsDateTime;
            end;
          end
          else
          begin
            if selP430.FieldByName('T430DATAFINE').AsDateTime >= lstAppoggio[i].FinePeriodo then
              lstPeriodiPay[High(lstPeriodiPay)].FinePeriodo:=lstAppoggio[i].FinePeriodo
            else
              lstPeriodiPay[High(lstPeriodiPay)].FinePeriodo:=selP430.FieldByName('T430DATAFINE').AsDateTime;
          end;
        end
        else
        begin
          SetLength(lstPeriodiPay,Length(lstPeriodiPay)+1);
          lstPeriodiPay[High(lstPeriodiPay)].InizioPeriodo:=lstAppoggio[i].InizioPeriodo;
          lstPeriodiPay[High(lstPeriodiPay)].FinePeriodo:=lstAppoggio[i].FinePeriodo;
        end;
        lstPeriodiPay[High(lstPeriodiPay)].PensionNumber:=selP430.FieldByName('PENSION_NUMBER').AsString;
        lstPeriodiPay[High(lstPeriodiPay)].Category:=selP430.FieldByName('CATEGORY').AsString;
        lstPeriodiPay[High(lstPeriodiPay)].Grade:=selP430.FieldByName('GRADE').AsString;
        lstPeriodiPay[High(lstPeriodiPay)].Step:=selP430.FieldByName('STEP').AsString;
        lstPeriodiPay[High(lstPeriodiPay)].DutyStation:=selP430.FieldByName('DUTY_STATION').AsString;
        lstPeriodiPay[High(lstPeriodiPay)].Parttime:=selP430.FieldByName('PARTTIME').AsFloat;
        lstPeriodiPay[High(lstPeriodiPay)].CurrencyCode:=selP430.FieldByName('CURRENCY_CODE').AsString;
        lstPeriodiPay[High(lstPeriodiPay)].LangAllow:=selP430.FieldByName('LANG_ALLOW').AsString;
        lstPeriodiPay[High(lstPeriodiPay)].LWOP:=False;
        if (lstPeriodiPay[High(lstPeriodiPay)].InizioPeriodo >= StrToDate('01/' + edtMeseElaborazione.Text)) and
           (lstPeriodiPay[High(lstPeriodiPay)].InizioPeriodo <= R180FineMese(StrToDate('01/' + edtMeseElaborazione.Text))) then
          lstPeriodiPay[High(lstPeriodiPay)].TransactionType:='Contribution'
        else
          lstPeriodiPay[High(lstPeriodiPay)].TransactionType:='Adjustment';
        //Azzerare tutti i campi da CONTRIBUTION_LOCAL_AMOUNTSM a RESTORATION_AMOUNTORG
        lstPeriodiPay[High(lstPeriodiPay)].Contribution_local_amountsm:=0;
        lstPeriodiPay[High(lstPeriodiPay)].Contribution_local_amountorg:=0;
        lstPeriodiPay[High(lstPeriodiPay)].Adjustment_local_amountsm:=0;
        lstPeriodiPay[High(lstPeriodiPay)].Adjustment_local_amountorg:=0;
        lstPeriodiPay[High(lstPeriodiPay)].Adjustment_local_amountfullsm:=0;
        lstPeriodiPay[High(lstPeriodiPay)].Adjustment_local_amountfullorg:=0;
        lstPeriodiPay[High(lstPeriodiPay)].Validation_amountsm:=0;
        lstPeriodiPay[High(lstPeriodiPay)].Validation_amountorg:=0;
        lstPeriodiPay[High(lstPeriodiPay)].Restoration_amountsm:=0;
        lstPeriodiPay[High(lstPeriodiPay)].Restoration_amountorg:=0;
        lstPeriodiPay[High(lstPeriodiPay)].Actuarial_costssm:=0;
        lstPeriodiPay[High(lstPeriodiPay)].Actuarial_costsorg:=0;
        lstPeriodiPay[High(lstPeriodiPay)].Interest_contributionsm:=0;
        lstPeriodiPay[High(lstPeriodiPay)].Interest_contributionorg:=0;
        lstPeriodiPay[High(lstPeriodiPay)].Misc_adjustmentsm:=0;
        lstPeriodiPay[High(lstPeriodiPay)].Misc_adjustmentorg:=0;
        selP430.Next;
      end;
    end;
    //----------------------------------------------------------------------------------------------
    //Aggiungo gli eventuali periodi della tabella LWOP intersecanti il mese dell’estrazione
    //----------------------------------------------------------------------------------------------
    SetLength(lstAppoggio,0);
    selU110.Close;
    selU110.SetVariable('Progressivo',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selU110.SetVariable('InizioPeriodo',StrToDate('01/' + edtMeseElaborazione.Text));
    selU110.SetVariable('FinePeriodo',R180FineMese(StrToDate('01/' + edtMeseElaborazione.Text)));
    selU110.Open;
    while not selU110.Eof do
    begin
      SetLength(lstAppoggio,Length(lstAppoggio)+1);
      lstAppoggio[High(lstAppoggio)].InizioPeriodo:=Max(StrToDate('01/' + edtMeseElaborazione.Text),selU110.FieldByName('DECORRENZA_INIZIO').AsDateTime);
      lstAppoggio[High(lstAppoggio)].FinePeriodo:=Min(R180FineMese(StrToDate('01/' + edtMeseElaborazione.Text)),selU110.FieldByName('DECORRENZA_FINE').AsDateTime);
      selP430.Close;
      selP430.SetVariable('Progressivo',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      selP430.SetVariable('InizioPeriodo',lstAppoggio[High(lstAppoggio)].FinePeriodo);
      selP430.SetVariable('FinePeriodo',lstAppoggio[High(lstAppoggio)].FinePeriodo);
      selP430.Open;
      if selP430.RecordCount > 0 then
      begin
        lstAppoggio[High(lstAppoggio)].PensionNumber:=selP430.FieldByName('PENSION_NUMBER').AsString;
        lstAppoggio[High(lstAppoggio)].Category:=selP430.FieldByName('CATEGORY').AsString;
        lstAppoggio[High(lstAppoggio)].Grade:=selP430.FieldByName('GRADE').AsString;
        lstAppoggio[High(lstAppoggio)].Step:=selP430.FieldByName('STEP').AsString;
        lstAppoggio[High(lstAppoggio)].DutyStation:=selP430.FieldByName('DUTY_STATION').AsString;
        lstAppoggio[High(lstAppoggio)].Parttime:=selP430.FieldByName('PARTTIME').AsFloat;
        lstAppoggio[High(lstAppoggio)].CurrencyCode:=selP430.FieldByName('CURRENCY_CODE').AsString;
      end;
      lstAppoggio[High(lstAppoggio)].LWOP:=True;
      lstAppoggio[High(lstAppoggio)].TransactionType:='Contribution';
      lstAppoggio[High(lstAppoggio)].Prrate_local_amount:=selU110.FieldByName('PRRATE_AMOUNT').AsFloat;
      lstAppoggio[High(lstAppoggio)].Language_allowancelocal_amount:=selU110.FieldByName('LANGUAGE_ALLOWANCE_AMOUNT').AsFloat;
      lstAppoggio[High(lstAppoggio)].Proratedratio:=selU110.FieldByName('PRORATEDRATIO').AsFloat;
      lstAppoggio[High(lstAppoggio)].Contribution_local_amountsm:=selU110.FieldByName('CONTRIBUTION_AMOUNTSM').AsFloat;
      lstAppoggio[High(lstAppoggio)].Contribution_local_amountorg:=selU110.FieldByName('CONTRIBUTION_AMOUNTORG').AsFloat;
      //Azzerare tutti i campi da ADJUSTMENT_LOCAL_AMOUNTSM a RESTORATION_AMOUNTORG
      lstAppoggio[High(lstAppoggio)].Adjustment_local_amountsm:=0;
      lstAppoggio[High(lstAppoggio)].Adjustment_local_amountorg:=0;
      lstAppoggio[High(lstAppoggio)].Adjustment_local_amountfullsm:=0;
      lstAppoggio[High(lstAppoggio)].Adjustment_local_amountfullorg:=0;
      lstAppoggio[High(lstAppoggio)].Validation_amountsm:=0;
      lstAppoggio[High(lstAppoggio)].Validation_amountorg:=0;
      lstAppoggio[High(lstAppoggio)].Restoration_amountsm:=0;
      lstAppoggio[High(lstAppoggio)].Restoration_amountorg:=0;
      lstAppoggio[High(lstAppoggio)].Actuarial_costssm:=0;
      lstAppoggio[High(lstAppoggio)].Actuarial_costsorg:=0;
      lstAppoggio[High(lstAppoggio)].Interest_contributionsm:=0;
      lstAppoggio[High(lstAppoggio)].Interest_contributionorg:=0;
      lstAppoggio[High(lstAppoggio)].Misc_adjustmentsm:=0;
      lstAppoggio[High(lstAppoggio)].Misc_adjustmentorg:=0;
      selU110.Next;
    end;
    //----------------------------------------------------------------------------------------------
    //Aggiungo gli eventuali periodi mensili della tabella LWOP antecedenti il mese dell’estrazione con CONGUAGLIO_MESI_PREC=’S’
    //----------------------------------------------------------------------------------------------
    selU110Prec.Close;
    selU110Prec.SetVariable('Progressivo',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selU110Prec.SetVariable('InizioPeriodo',StrToDate('01/' + edtMeseElaborazione.Text));
    selU110Prec.Open;
    while not selU110Prec.Eof do
    begin
      //Ciclo per ogni mese tra inizio periodo e fine periodo
      DataCorrente:=R180InizioMese(selU110Prec.FieldByName('DECORRENZA_INIZIO').AsDateTime);
      while DataCorrente <= Min(R180AddMesi(StrToDate('01/' + edtMeseElaborazione.Text),-1),R180InizioMese(selU110Prec.FieldByName('DECORRENZA_FINE').AsDateTime)) do
      begin
        SetLength(lstAppoggio,Length(lstAppoggio)+1);
        lstAppoggio[High(lstAppoggio)].InizioPeriodo:=Max(DataCorrente,selU110Prec.FieldByName('DECORRENZA_INIZIO').AsDateTime);
        lstAppoggio[High(lstAppoggio)].FinePeriodo:=Min(R180FineMese(DataCorrente),selU110Prec.FieldByName('DECORRENZA_FINE').AsDateTime);
        selP430.Close;
        selP430.SetVariable('Progressivo',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        selP430.SetVariable('InizioPeriodo',lstAppoggio[High(lstAppoggio)].FinePeriodo);
        selP430.SetVariable('FinePeriodo',lstAppoggio[High(lstAppoggio)].FinePeriodo);
        selP430.Open;
        if selP430.RecordCount > 0 then
        begin
          lstAppoggio[High(lstAppoggio)].PensionNumber:=selP430.FieldByName('PENSION_NUMBER').AsString;
          lstAppoggio[High(lstAppoggio)].Category:=selP430.FieldByName('CATEGORY').AsString;
          lstAppoggio[High(lstAppoggio)].Grade:=selP430.FieldByName('GRADE').AsString;
          lstAppoggio[High(lstAppoggio)].Step:=selP430.FieldByName('STEP').AsString;
          lstAppoggio[High(lstAppoggio)].DutyStation:=selP430.FieldByName('DUTY_STATION').AsString;
          lstAppoggio[High(lstAppoggio)].Parttime:=selP430.FieldByName('PARTTIME').AsFloat;
          lstAppoggio[High(lstAppoggio)].CurrencyCode:=selP430.FieldByName('CURRENCY_CODE').AsString;
        end;
        lstAppoggio[High(lstAppoggio)].LWOP:=True;
        lstAppoggio[High(lstAppoggio)].TransactionType:='Adjustment';
        lstAppoggio[High(lstAppoggio)].Prrate_local_amount:=selU110Prec.FieldByName('PRRATE_AMOUNT').AsFloat;
        lstAppoggio[High(lstAppoggio)].Language_allowancelocal_amount:=selU110Prec.FieldByName('LANGUAGE_ALLOWANCE_AMOUNT').AsFloat;
        lstAppoggio[High(lstAppoggio)].Proratedratio:=selU110Prec.FieldByName('PRORATEDRATIO').AsFloat;
        lstAppoggio[High(lstAppoggio)].Adjustment_local_amountfullsm:=selU110Prec.FieldByName('CONTRIBUTION_AMOUNTSM').AsFloat;
        lstAppoggio[High(lstAppoggio)].Adjustment_local_amountfullorg:=selU110Prec.FieldByName('CONTRIBUTION_AMOUNTORG').AsFloat;
        if (lstAppoggio[High(lstAppoggio)].Adjustment_local_amountfullsm = 0) and (lstAppoggio[High(lstAppoggio)].Adjustment_local_amountfullorg = 0) then
        begin
          lstAppoggio[High(lstAppoggio)].Adjustment_local_amountsm:=0;
          lstAppoggio[High(lstAppoggio)].Adjustment_local_amountorg:=0;
        end
        else
        begin
          //Calcolare CONTRIBUTISM=CONTRIBUTION_LOCAL_AMOUNTSM+ADJUSTMENT_LOCAL_AMOUNTSM e CONTRIBUTIORG=CONTRIBUTION_LOCAL_AMOUNTORG+ADJUSTMENT_LOCAL_AMOUNTORG
          //sommando tutti i flussi antecedenti al mese dell’estrazione in corso con LWOP_CONTRIB_FLAG a true
          selU190Prec.Close;
          selU190Prec.SetVariable('Progressivo',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          selU190Prec.SetVariable('FinePeriodo',lstAppoggio[High(lstAppoggio)].FinePeriodo);
          selU190Prec.SetVariable('MeseElaborazione',StrToDate('01/' + edtMeseElaborazione.Text));
          selU190Prec.Open;
          //Impostare ADJUSTMENT_LOCAL_AMOUNTSM=ADJUSTMENT_LOCAL_AMOUNTFULLSM-CONTRIBUTISM e ADJUSTMENT_LOCAL_AMOUNTORG=ADJUSTMENT_LOCAL_AMOUNTFULLORG-CONTRIBUTIORG
          if selU190Prec.Eof then
          begin
            lstAppoggio[High(lstAppoggio)].Adjustment_local_amountsm:=lstAppoggio[High(lstAppoggio)].Adjustment_local_amountfullsm;
            lstAppoggio[High(lstAppoggio)].Adjustment_local_amountorg:=lstAppoggio[High(lstAppoggio)].Adjustment_local_amountfullorg;
          end
          else
          begin
            lstAppoggio[High(lstAppoggio)].Adjustment_local_amountsm:=lstAppoggio[High(lstAppoggio)].Adjustment_local_amountfullsm-selU190Prec.FieldByName('CONTRIBUTISM').AsFloat;
            lstAppoggio[High(lstAppoggio)].Adjustment_local_amountorg:=lstAppoggio[High(lstAppoggio)].Adjustment_local_amountfullorg-selU190Prec.FieldByName('CONTRIBUTIORG').AsFloat;
          end;
          //Se ADJUSTMENT_LOCAL_AMOUNTSM=0 e ADJUSTMENT_LOCAL_AMOUNTORG=0 cancellare il periodo
          if (lstAppoggio[High(lstAppoggio)].Adjustment_local_amountsm = 0) and (lstAppoggio[High(lstAppoggio)].Adjustment_local_amountorg = 0) then
            lstAppoggio[High(lstAppoggio)].TransactionType:='ZZZ'
          else
          begin  //Se ADJUSTMENT_LOCAL_AMOUNTSM<0 oppure ADJUSTMENT_LOCAL_AMOUNTORG<0 segnalare l’anomalia bloccante “Esistono periodi di LWOP a true con conguaglio negativo”
            if (lstAppoggio[High(lstAppoggio)].Adjustment_local_amountsm < 0) or (lstAppoggio[High(lstAppoggio)].Adjustment_local_amountorg < 0) then
              RegistraMsg.InserisciMessaggio('A','Esistono periodi di LWOP a True con conguaglio negativo','',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          end;
        end;
        //Azzerare tutti i campi da CONTRIBUTION_LOCAL_AMOUNTSM a RESTORATION_AMOUNTORG
        lstAppoggio[High(lstAppoggio)].Contribution_local_amountsm:=0;
        lstAppoggio[High(lstAppoggio)].Contribution_local_amountorg:=0;
        lstAppoggio[High(lstAppoggio)].Validation_amountsm:=0;
        lstAppoggio[High(lstAppoggio)].Validation_amountorg:=0;
        lstAppoggio[High(lstAppoggio)].Restoration_amountsm:=0;
        lstAppoggio[High(lstAppoggio)].Restoration_amountorg:=0;
        lstAppoggio[High(lstAppoggio)].Actuarial_costssm:=0;
        lstAppoggio[High(lstAppoggio)].Actuarial_costsorg:=0;
        lstAppoggio[High(lstAppoggio)].Interest_contributionsm:=0;
        lstAppoggio[High(lstAppoggio)].Interest_contributionorg:=0;
        lstAppoggio[High(lstAppoggio)].Misc_adjustmentsm:=0;
        lstAppoggio[High(lstAppoggio)].Misc_adjustmentorg:=0;
        DataCorrente:=R180AddMesi(DataCorrente,1);
      end;
      selU110Prec.Next;
    end;
    //Riporto su lstOrdinamento tutti i periodi ordinandoli
    i:=0;
    j:=0;
    SetLength(lstOrdinamento,0);
    while (i <= High(lstAppoggio)) and (j <= High(lstPeriodiPay)) do
    begin
      if lstPeriodiPay[j].TransactionType = lstAppoggio[i].TransactionType then
      begin
        if lstPeriodiPay[j].InizioPeriodo < lstAppoggio[i].InizioPeriodo then
        begin
          SetLength(lstOrdinamento,Length(lstOrdinamento)+1);
          Carico('lstPeriodiPay',j);
          inc(j);
        end
        else if lstPeriodiPay[j].InizioPeriodo = lstAppoggio[i].InizioPeriodo then
        begin
          if lstPeriodiPay[j].FinePeriodo <= lstAppoggio[i].FinePeriodo then
          begin
            SetLength(lstOrdinamento,Length(lstOrdinamento)+1);
            Carico('lstPeriodiPay',j);
            inc(j);
            SetLength(lstOrdinamento,Length(lstOrdinamento)+1);
            Carico('lstAppoggio',i);
            inc(i);
          end
          else
          begin
            SetLength(lstOrdinamento,Length(lstOrdinamento)+1);
            Carico('lstAppoggio',i);
            inc(i);
            SetLength(lstOrdinamento,Length(lstOrdinamento)+1);
            Carico('lstPeriodiPay',j);
            inc(j);
          end;
        end
        else if lstPeriodiPay[j].InizioPeriodo > lstAppoggio[i].InizioPeriodo then
        begin
          SetLength(lstOrdinamento,Length(lstOrdinamento)+1);
          Carico('lstAppoggio',i);
          inc(i);
        end;
      end
      else
      begin
        if lstPeriodiPay[j].TransactionType < lstAppoggio[i].TransactionType then
        begin
          SetLength(lstOrdinamento,Length(lstOrdinamento)+1);
          Carico('lstPeriodiPay',j);
          inc(j);
        end
        else
        begin
          if lstAppoggio[i].TransactionType <> 'ZZZ' then
          begin
            SetLength(lstOrdinamento,Length(lstOrdinamento)+1);
            Carico('lstAppoggio',i);
          end;
          inc(i);
        end;
      end;
    end;
    while i <= High(lstAppoggio) do  //Carico i record restanti di lstAppoggio
    begin
      if lstAppoggio[i].TransactionType <> 'ZZZ' then
      begin
        SetLength(lstOrdinamento,Length(lstOrdinamento)+1);
        Carico('lstAppoggio',i);
      end;
      inc(i);
    end;
    while j <= High(lstPeriodiPay) do  //Carico i record restanti di lstPeriodiPay
    begin
      SetLength(lstOrdinamento,Length(lstOrdinamento)+1);
      Carico('lstPeriodiPay',j);
      inc(j);
    end;
    //Riporto sul lstPeriodiPay tutti i periodi
    SetLength(lstPeriodiPay,0);
    for i:=0 to High(lstOrdinamento) do
    begin
      SetLength(lstPeriodiPay,Length(lstPeriodiPay)+1);
      lstPeriodiPay[High(lstPeriodiPay)].InizioPeriodo:=lstOrdinamento[i].InizioPeriodo;
      lstPeriodiPay[High(lstPeriodiPay)].FinePeriodo:=lstOrdinamento[i].FinePeriodo;
      lstPeriodiPay[High(lstPeriodiPay)].PensionNumber:=lstOrdinamento[i].PensionNumber;
      lstPeriodiPay[High(lstPeriodiPay)].Category:=lstOrdinamento[i].Category;
      lstPeriodiPay[High(lstPeriodiPay)].Grade:=lstOrdinamento[i].Grade;
      lstPeriodiPay[High(lstPeriodiPay)].Step:=lstOrdinamento[i].Step;
      lstPeriodiPay[High(lstPeriodiPay)].DutyStation:=lstOrdinamento[i].DutyStation;
      lstPeriodiPay[High(lstPeriodiPay)].Parttime:=lstOrdinamento[i].Parttime;
      lstPeriodiPay[High(lstPeriodiPay)].CurrencyCode:=lstOrdinamento[i].CurrencyCode;
      lstPeriodiPay[High(lstPeriodiPay)].LangAllow:=lstOrdinamento[i].LangAllow;
      lstPeriodiPay[High(lstPeriodiPay)].LWOP:=lstOrdinamento[i].LWOP;
      lstPeriodiPay[High(lstPeriodiPay)].TransactionType:=lstOrdinamento[i].TransactionType;
      lstPeriodiPay[High(lstPeriodiPay)].Exchange_rate:=lstOrdinamento[i].Exchange_rate;
      lstPeriodiPay[High(lstPeriodiPay)].Prrate_local_amount:=lstOrdinamento[i].Prrate_local_amount;
      lstPeriodiPay[High(lstPeriodiPay)].Language_allowancelocal_amount:=lstOrdinamento[i].Language_allowancelocal_amount;
      lstPeriodiPay[High(lstPeriodiPay)].Proratedratio:=lstOrdinamento[i].Proratedratio;
      lstPeriodiPay[High(lstPeriodiPay)].Contribution_local_amountsm:=lstOrdinamento[i].Contribution_local_amountsm;
      lstPeriodiPay[High(lstPeriodiPay)].Contribution_local_amountorg:=lstOrdinamento[i].Contribution_local_amountorg;
      lstPeriodiPay[High(lstPeriodiPay)].Adjustment_local_amountsm:=lstOrdinamento[i].Adjustment_local_amountsm;
      lstPeriodiPay[High(lstPeriodiPay)].Adjustment_local_amountorg:=lstOrdinamento[i].Adjustment_local_amountorg;
      lstPeriodiPay[High(lstPeriodiPay)].Adjustment_local_amountfullsm:=lstOrdinamento[i].Adjustment_local_amountfullsm;
      lstPeriodiPay[High(lstPeriodiPay)].Adjustment_local_amountfullorg:=lstOrdinamento[i].Adjustment_local_amountfullorg;
      lstPeriodiPay[High(lstPeriodiPay)].Validation_amountsm:=lstOrdinamento[i].Validation_amountsm;
      lstPeriodiPay[High(lstPeriodiPay)].Validation_amountorg:=lstOrdinamento[i].Validation_amountorg;
      lstPeriodiPay[High(lstPeriodiPay)].Restoration_amountsm:=lstOrdinamento[i].Restoration_amountsm;
      lstPeriodiPay[High(lstPeriodiPay)].Restoration_amountorg:=lstOrdinamento[i].Restoration_amountorg;
      lstPeriodiPay[High(lstPeriodiPay)].Actuarial_costssm:=lstOrdinamento[i].Actuarial_costssm;
      lstPeriodiPay[High(lstPeriodiPay)].Actuarial_costsorg:=lstOrdinamento[i].Actuarial_costsorg;
      lstPeriodiPay[High(lstPeriodiPay)].Interest_contributionsm:=lstOrdinamento[i].Interest_contributionsm;
      lstPeriodiPay[High(lstPeriodiPay)].Interest_contributionorg:=lstOrdinamento[i].Interest_contributionorg;
      lstPeriodiPay[High(lstPeriodiPay)].Misc_adjustmentsm:=lstOrdinamento[i].Misc_adjustmentsm;
      lstPeriodiPay[High(lstPeriodiPay)].Misc_adjustmentorg:=lstOrdinamento[i].Misc_adjustmentorg;
    end;
    //----------------------------------------------------------------------------------------------
    //Aggiungo gli eventuali periodi della tabella MISCELLANEUS intersecanti il mese dell’estrazione
    //----------------------------------------------------------------------------------------------
    SetLength(lstAppoggio,0);
    selU112.Close;
    selU112.SetVariable('Progressivo',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selU112.SetVariable('InizioPeriodo',StrToDate('01/' + edtMeseElaborazione.Text));
    selU112.SetVariable('FinePeriodo',R180FineMese(StrToDate('01/' + edtMeseElaborazione.Text)));
    selU112.Open;
    while not selU112.Eof do
    begin
      SetLength(lstAppoggio,Length(lstAppoggio)+1);
      lstAppoggio[High(lstAppoggio)].InizioPeriodo:=Max(StrToDate('01/' + edtMeseElaborazione.Text),selU112.FieldByName('DECORRENZA_INIZIO').AsDateTime);
      lstAppoggio[High(lstAppoggio)].FinePeriodo:=Min(R180FineMese(StrToDate('01/' + edtMeseElaborazione.Text)),selU112.FieldByName('DECORRENZA_FINE').AsDateTime);
      selP430.Close;
      selP430.SetVariable('Progressivo',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      selP430.SetVariable('InizioPeriodo',lstAppoggio[High(lstAppoggio)].FinePeriodo);
      selP430.SetVariable('FinePeriodo',lstAppoggio[High(lstAppoggio)].FinePeriodo);
      selP430.Open;
      if selP430.RecordCount > 0 then
      begin
        lstAppoggio[High(lstAppoggio)].PensionNumber:=selP430.FieldByName('PENSION_NUMBER').AsString;
        lstAppoggio[High(lstAppoggio)].Category:=selP430.FieldByName('CATEGORY').AsString;
        lstAppoggio[High(lstAppoggio)].Grade:=selP430.FieldByName('GRADE').AsString;
        lstAppoggio[High(lstAppoggio)].Step:=selP430.FieldByName('STEP').AsString;
        lstAppoggio[High(lstAppoggio)].DutyStation:=selP430.FieldByName('DUTY_STATION').AsString;
        lstAppoggio[High(lstAppoggio)].Parttime:=selP430.FieldByName('PARTTIME').AsFloat;
        lstAppoggio[High(lstAppoggio)].CurrencyCode:=selP430.FieldByName('CURRENCY_CODE').AsString;
      end;
      lstAppoggio[High(lstAppoggio)].LWOP:=False;
      lstAppoggio[High(lstAppoggio)].TransactionType:='Miscellaneous';
      lstAppoggio[High(lstAppoggio)].Validation_amountsm:=selU112.FieldByName('VALIDATION_AMOUNT_SM').AsFloat;
      lstAppoggio[High(lstAppoggio)].Validation_amountorg:=selU112.FieldByName('VALIDATION_AMOUNT_ORG').AsFloat;
      lstAppoggio[High(lstAppoggio)].Restoration_amountsm:=selU112.FieldByName('RESTORATION_AMOUNT_SM').AsFloat;
      lstAppoggio[High(lstAppoggio)].Restoration_amountorg:=selU112.FieldByName('RESTORATION_AMOUNT_ORG').AsFloat;
      lstAppoggio[High(lstAppoggio)].Actuarial_costssm:=selU112.FieldByName('ACTUARIAL_COSTSSM').AsFloat;
      lstAppoggio[High(lstAppoggio)].Actuarial_costsorg:=selU112.FieldByName('ACTUARIAL_COSTSORG').AsFloat;
      lstAppoggio[High(lstAppoggio)].Interest_contributionsm:=selU112.FieldByName('INTEREST_CONTRIBUTIONSM').AsFloat;
      lstAppoggio[High(lstAppoggio)].Interest_contributionorg:=selU112.FieldByName('INTEREST_CONTRIBUTIONORG').AsFloat;
      lstAppoggio[High(lstAppoggio)].Misc_adjustmentsm:=selU112.FieldByName('MISC_ADJUSTMENTSM').AsFloat;
      lstAppoggio[High(lstAppoggio)].Misc_adjustmentorg:=selU112.FieldByName('MISC_ADJUSTMENTORG').AsFloat;
      lstAppoggio[High(lstAppoggio)].Proratedratio:=1;
      //Azzerare tutti i campi da PRRATE_LOCAL_AMOUNT a ADJUSTMENT_BASE_AMOUNTFULLORG
      lstAppoggio[High(lstAppoggio)].Prrate_local_amount:=0;
      lstAppoggio[High(lstAppoggio)].Language_allowancelocal_amount:=0;
      lstAppoggio[High(lstAppoggio)].Contribution_local_amountsm:=0;
      lstAppoggio[High(lstAppoggio)].Contribution_local_amountorg:=0;
      lstAppoggio[High(lstAppoggio)].Adjustment_local_amountsm:=0;
      lstAppoggio[High(lstAppoggio)].Adjustment_local_amountorg:=0;
      lstAppoggio[High(lstAppoggio)].Adjustment_local_amountfullsm:=0;
      lstAppoggio[High(lstAppoggio)].Adjustment_local_amountfullorg:=0;
      selU112.Next;
    end;
    //Riporto su lstOrdinamento tutti i periodi ordinandoli
    i:=0;
    j:=0;
    SetLength(lstOrdinamento,0);
    while (i <= High(lstAppoggio)) and (j <= High(lstPeriodiPay)) do
    begin
      if lstPeriodiPay[j].TransactionType = lstAppoggio[i].TransactionType then
      begin
        if lstPeriodiPay[j].InizioPeriodo < lstAppoggio[i].InizioPeriodo then
        begin
          SetLength(lstOrdinamento,Length(lstOrdinamento)+1);
          Carico('lstPeriodiPay',j);
          inc(j);
        end
        else if lstPeriodiPay[j].InizioPeriodo = lstAppoggio[i].InizioPeriodo then
        begin
          if lstPeriodiPay[j].FinePeriodo <= lstAppoggio[i].FinePeriodo then
          begin
            SetLength(lstOrdinamento,Length(lstOrdinamento)+1);
            Carico('lstPeriodiPay',j);
            inc(j);
            SetLength(lstOrdinamento,Length(lstOrdinamento)+1);
            Carico('lstAppoggio',i);
            inc(i);
          end
          else
          begin
            SetLength(lstOrdinamento,Length(lstOrdinamento)+1);
            Carico('lstAppoggio',i);
            inc(i);
            SetLength(lstOrdinamento,Length(lstOrdinamento)+1);
            Carico('lstPeriodiPay',j);
            inc(j);
          end;
        end
        else if lstPeriodiPay[j].InizioPeriodo > lstAppoggio[i].InizioPeriodo then
        begin
          SetLength(lstOrdinamento,Length(lstOrdinamento)+1);
          Carico('lstAppoggio',i);
          inc(i);
        end;
      end
      else
      begin
        if lstPeriodiPay[j].TransactionType < lstAppoggio[i].TransactionType then
        begin
          SetLength(lstOrdinamento,Length(lstOrdinamento)+1);
          Carico('lstPeriodiPay',j);
          inc(j);
        end
        else
        begin
          SetLength(lstOrdinamento,Length(lstOrdinamento)+1);
          Carico('lstAppoggio',i);
          inc(i);
        end;
      end;
    end;
    while i <= High(lstAppoggio) do  //Carico i record restanti di lstAppoggio
    begin
      SetLength(lstOrdinamento,Length(lstOrdinamento)+1);
      Carico('lstAppoggio',i);
      inc(i);
    end;
    while j <= High(lstPeriodiPay) do  //Carico i record restanti di lstPeriodiPay
    begin
      SetLength(lstOrdinamento,Length(lstOrdinamento)+1);
      Carico('lstPeriodiPay',j);
      inc(j);
    end;
    //Riporto sul lstAppoggio tutti i periodi
    SetLength(lstAppoggio,0);
    for i:=0 to High(lstOrdinamento) do
    begin
      SetLength(lstAppoggio,Length(lstAppoggio)+1);
      lstAppoggio[High(lstAppoggio)].InizioPeriodo:=lstOrdinamento[i].InizioPeriodo;
      lstAppoggio[High(lstAppoggio)].FinePeriodo:=lstOrdinamento[i].FinePeriodo;
      lstAppoggio[High(lstAppoggio)].PensionNumber:=lstOrdinamento[i].PensionNumber;
      lstAppoggio[High(lstAppoggio)].Category:=lstOrdinamento[i].Category;
      lstAppoggio[High(lstAppoggio)].Grade:=lstOrdinamento[i].Grade;
      lstAppoggio[High(lstAppoggio)].Step:=lstOrdinamento[i].Step;
      lstAppoggio[High(lstAppoggio)].DutyStation:=lstOrdinamento[i].DutyStation;
      lstAppoggio[High(lstAppoggio)].Parttime:=lstOrdinamento[i].Parttime;
      lstAppoggio[High(lstAppoggio)].CurrencyCode:=lstOrdinamento[i].CurrencyCode;
      lstAppoggio[High(lstAppoggio)].LangAllow:=lstOrdinamento[i].LangAllow;
      lstAppoggio[High(lstAppoggio)].LWOP:=lstOrdinamento[i].LWOP;
      lstAppoggio[High(lstAppoggio)].TransactionType:=lstOrdinamento[i].TransactionType;
      lstAppoggio[High(lstAppoggio)].Exchange_rate:=lstOrdinamento[i].Exchange_rate;
      lstAppoggio[High(lstAppoggio)].Prrate_local_amount:=lstOrdinamento[i].Prrate_local_amount;
      lstAppoggio[High(lstAppoggio)].Language_allowancelocal_amount:=lstOrdinamento[i].Language_allowancelocal_amount;
      lstAppoggio[High(lstAppoggio)].Proratedratio:=lstOrdinamento[i].Proratedratio;
      lstAppoggio[High(lstAppoggio)].Contribution_local_amountsm:=lstOrdinamento[i].Contribution_local_amountsm;
      lstAppoggio[High(lstAppoggio)].Contribution_local_amountorg:=lstOrdinamento[i].Contribution_local_amountorg;
      lstAppoggio[High(lstAppoggio)].Adjustment_local_amountsm:=lstOrdinamento[i].Adjustment_local_amountsm;
      lstAppoggio[High(lstAppoggio)].Adjustment_local_amountorg:=lstOrdinamento[i].Adjustment_local_amountorg;
      lstAppoggio[High(lstAppoggio)].Adjustment_local_amountfullsm:=lstOrdinamento[i].Adjustment_local_amountfullsm;
      lstAppoggio[High(lstAppoggio)].Adjustment_local_amountfullorg:=lstOrdinamento[i].Adjustment_local_amountfullorg;
      lstAppoggio[High(lstAppoggio)].Validation_amountsm:=lstOrdinamento[i].Validation_amountsm;
      lstAppoggio[High(lstAppoggio)].Validation_amountorg:=lstOrdinamento[i].Validation_amountorg;
      lstAppoggio[High(lstAppoggio)].Restoration_amountsm:=lstOrdinamento[i].Restoration_amountsm;
      lstAppoggio[High(lstAppoggio)].Restoration_amountorg:=lstOrdinamento[i].Restoration_amountorg;
      lstAppoggio[High(lstAppoggio)].Actuarial_costssm:=lstOrdinamento[i].Actuarial_costssm;
      lstAppoggio[High(lstAppoggio)].Actuarial_costsorg:=lstOrdinamento[i].Actuarial_costsorg;
      lstAppoggio[High(lstAppoggio)].Interest_contributionsm:=lstOrdinamento[i].Interest_contributionsm;
      lstAppoggio[High(lstAppoggio)].Interest_contributionorg:=lstOrdinamento[i].Interest_contributionorg;
      lstAppoggio[High(lstAppoggio)].Misc_adjustmentsm:=lstOrdinamento[i].Misc_adjustmentsm;
      lstAppoggio[High(lstAppoggio)].Misc_adjustmentorg:=lstOrdinamento[i].Misc_adjustmentorg;
    end;
    //----------------------------------------------------------------------------------------------
    //Unificare gli eventuali periodi consecutivi afferenti allo stesso mese con stessi valori in
    //PENSION_NUMBER, TRANSACTION_TYPE, LWOP_CONTRIB_FLAG, CATEGORY, GRADE, STEP, DUTY_STATION, PARTTIME_PERCENT, CURRENCY_CODE, LANG_ALLOW.
    //Valorizzo Exchange rate in base a Currency code, PRRATE_LOCAL_AMOUNT
    //----------------------------------------------------------------------------------------------
    SetLength(lstPeriodiPay,0);
    for i:=0 to High(lstAppoggio) do
    begin
      if (i > 0) and
         (R180Anno(lstAppoggio[i].InizioPeriodo) = R180Anno(lstAppoggio[i-1].InizioPeriodo)) and
         (R180Mese(lstAppoggio[i].InizioPeriodo) = R180Mese(lstAppoggio[i-1].InizioPeriodo)) and
         ((lstAppoggio[i].InizioPeriodo = lstAppoggio[i-1].FinePeriodo+1) or
          ((lstAppoggio[i].InizioPeriodo = lstAppoggio[i-1].FinePeriodo) and (lstAppoggio[i].InizioPeriodo = lstAppoggio[i-1].InizioPeriodo))) and
         (lstAppoggio[i].PensionNumber = lstAppoggio[i-1].PensionNumber) and
         (lstAppoggio[i].TransactionType = lstAppoggio[i-1].TransactionType) and
         (lstAppoggio[i].LWOP = lstAppoggio[i-1].LWOP) and
         (lstAppoggio[i].Category = lstAppoggio[i-1].Category) and
         (lstAppoggio[i].Grade = lstAppoggio[i-1].Grade) and
         (lstAppoggio[i].Step = lstAppoggio[i-1].Step) and
         (lstAppoggio[i].DutyStation = lstAppoggio[i-1].DutyStation) and
         (lstAppoggio[i].Parttime = lstAppoggio[i-1].Parttime) and
         (lstAppoggio[i].CurrencyCode = lstAppoggio[i-1].CurrencyCode) and
         (lstAppoggio[i].LangAllow = lstAppoggio[i-1].LangAllow) then
      begin
        lstPeriodiPay[High(lstPeriodiPay)].FinePeriodo:=lstAppoggio[i].FinePeriodo;
      end
      else
      begin
        SetLength(lstPeriodiPay,Length(lstPeriodiPay)+1);
        lstPeriodiPay[High(lstPeriodiPay)].InizioPeriodo:=lstAppoggio[i].InizioPeriodo;
        lstPeriodiPay[High(lstPeriodiPay)].FinePeriodo:=lstAppoggio[i].FinePeriodo;
        lstPeriodiPay[High(lstPeriodiPay)].PensionNumber:=lstAppoggio[i].PensionNumber;
        lstPeriodiPay[High(lstPeriodiPay)].Category:=lstAppoggio[i].Category;
        lstPeriodiPay[High(lstPeriodiPay)].Grade:=lstAppoggio[i].Grade;
        lstPeriodiPay[High(lstPeriodiPay)].Step:=lstAppoggio[i].Step;
        lstPeriodiPay[High(lstPeriodiPay)].DutyStation:=lstAppoggio[i].DutyStation;
        lstPeriodiPay[High(lstPeriodiPay)].Parttime:=lstAppoggio[i].Parttime;
        lstPeriodiPay[High(lstPeriodiPay)].CurrencyCode:=lstAppoggio[i].CurrencyCode;
        lstPeriodiPay[High(lstPeriodiPay)].LangAllow:=lstAppoggio[i].LangAllow;
        lstPeriodiPay[High(lstPeriodiPay)].LWOP:=lstAppoggio[i].LWOP;
        lstPeriodiPay[High(lstPeriodiPay)].TransactionType:=lstAppoggio[i].TransactionType;
        lstPeriodiPay[High(lstPeriodiPay)].Exchange_rate:=lstAppoggio[i].Exchange_rate;
        lstPeriodiPay[High(lstPeriodiPay)].Prrate_local_amount:=lstAppoggio[i].Prrate_local_amount;
        lstPeriodiPay[High(lstPeriodiPay)].Language_allowancelocal_amount:=lstAppoggio[i].Language_allowancelocal_amount;
        lstPeriodiPay[High(lstPeriodiPay)].Proratedratio:=lstAppoggio[i].Proratedratio;
        lstPeriodiPay[High(lstPeriodiPay)].Contribution_local_amountsm:=lstAppoggio[i].Contribution_local_amountsm;
        lstPeriodiPay[High(lstPeriodiPay)].Contribution_local_amountorg:=lstAppoggio[i].Contribution_local_amountorg;
        lstPeriodiPay[High(lstPeriodiPay)].Adjustment_local_amountsm:=lstAppoggio[i].Adjustment_local_amountsm;
        lstPeriodiPay[High(lstPeriodiPay)].Adjustment_local_amountorg:=lstAppoggio[i].Adjustment_local_amountorg;
        lstPeriodiPay[High(lstPeriodiPay)].Adjustment_local_amountfullsm:=lstAppoggio[i].Adjustment_local_amountfullsm;
        lstPeriodiPay[High(lstPeriodiPay)].Adjustment_local_amountfullorg:=lstAppoggio[i].Adjustment_local_amountfullorg;
        lstPeriodiPay[High(lstPeriodiPay)].Validation_amountsm:=lstAppoggio[i].Validation_amountsm;
        lstPeriodiPay[High(lstPeriodiPay)].Validation_amountorg:=lstAppoggio[i].Validation_amountorg;
        lstPeriodiPay[High(lstPeriodiPay)].Restoration_amountsm:=lstAppoggio[i].Restoration_amountsm;
        lstPeriodiPay[High(lstPeriodiPay)].Restoration_amountorg:=lstAppoggio[i].Restoration_amountorg;
        lstPeriodiPay[High(lstPeriodiPay)].Actuarial_costssm:=lstAppoggio[i].Actuarial_costssm;
        lstPeriodiPay[High(lstPeriodiPay)].Actuarial_costsorg:=lstAppoggio[i].Actuarial_costsorg;
        lstPeriodiPay[High(lstPeriodiPay)].Interest_contributionsm:=lstAppoggio[i].Interest_contributionsm;
        lstPeriodiPay[High(lstPeriodiPay)].Interest_contributionorg:=lstAppoggio[i].Interest_contributionorg;
        lstPeriodiPay[High(lstPeriodiPay)].Misc_adjustmentsm:=lstAppoggio[i].Misc_adjustmentsm;
        lstPeriodiPay[High(lstPeriodiPay)].Misc_adjustmentorg:=lstAppoggio[i].Misc_adjustmentorg;
        //Per ogni periodo impostare EXCHANGE_RATE
        if lstPeriodiPay[High(lstPeriodiPay)].CurrencyCode = 'USD' then
          lstPeriodiPay[High(lstPeriodiPay)].Exchange_rate:=1
        else
        begin
          //Contiene il tasso di cambio utilizzato per convertire l'importo locale previsto in CURRENCY_CODE in importo base, cioè USD.
          //Per ricavare la data del cambio, utilizzare P441.DATA_CAMBIO_VALUTA se esiste il cedolino normale nel mese di fine periodo
          selDataCambio.SetVariable('Progressivo',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          selDataCambio.SetVariable('DataRetribuzione',R180FineMese(lstPeriodiPay[High(lstPeriodiPay)].FinePeriodo));
          selDataCambio.Execute;
          if (selDataCambio.RowsProcessed > 0) and (not selDataCambio.FieldIsNull(0)) then
            DataCambioValuta:=selDataCambio.FieldAsDate(0)
          else
            //altrimenti utilizzare il 15 del mese di fine periodo stesso
            DataCambioValuta:=StrToDate('15/' + Copy(DateToStr(lstPeriodiPay[High(lstPeriodiPay)].FinePeriodo),4,7));
          if lstPeriodiPay[High(lstPeriodiPay)].CurrencyCode = 'EUR' then
            lstPeriodiPay[High(lstPeriodiPay)].Exchange_rate:=QueryCambio.CambioValuta('EURO','USD',DataCambioValuta)
          else
            lstPeriodiPay[High(lstPeriodiPay)].Exchange_rate:=QueryCambio.CambioValuta(lstPeriodiPay[High(lstPeriodiPay)].CurrencyCode,'USD',DataCambioValuta);
        end;
        //Per ogni periodo, se TRANSACTION_TYPE impostato a Contribution/Adjustment e LWOP_CONTRIB_FLAG=false
        //Calcolare PRRATE_LOCAL_AMOUNT
        if ((lstPeriodiPay[High(lstPeriodiPay)].TransactionType = 'Contribution') or (lstPeriodiPay[High(lstPeriodiPay)].TransactionType = 'Adjustment')) and
            (lstPeriodiPay[High(lstPeriodiPay)].LWOP = False) then
        begin
          selP442Prrate.SetVariable('Progressivo',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          selP442Prrate.SetVariable('Competenza',R180FineMese(lstPeriodiPay[High(lstPeriodiPay)].FinePeriodo));
          selP442Prrate.SetVariable('DataCedolino',R180FineMese(StrToDate('01/' + edtMeseElaborazione.Text)));
          case rgpStatoCedolini.ItemIndex of
            0:selP442Prrate.SetVariable('StatoCedolini','''S''');
            1:selP442Prrate.SetVariable('StatoCedolini','''S'',''N''');
            2:selP442Prrate.SetVariable('StatoCedolini','''N''');
          end;
          selP442Prrate.Execute;
          if (selP442Prrate.RowsProcessed > 0) and (not selP442Prrate.FieldIsNull(0)) then
            lstPeriodiPay[High(lstPeriodiPay)].Prrate_local_amount:=selP442Prrate.FieldAsFloat(0);
        end;
      end;
    end;
    //----------------------------------------------------------------------------------------------
    //CONTRIBUTION: Spalmare voci 11600 e 11605 afferenti al mese di estrazione, sui periodi con TRANSACTION_TYPE impostato a Contribution e LWOP_CONTRIB_FLAG=false
    //----------------------------------------------------------------------------------------------
    selP442.Close;
    selP442.SetVariable('Progressivo',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selP442.SetVariable('MeseElaborazione',' = TO_DATE(''' + DateToStr(R180FineMese(StrToDate('01/' + edtMeseElaborazione.Text))) + ''',''DD/MM/YYYY'')');
    case rgpStatoCedolini.ItemIndex of
      0:selP442.SetVariable('StatoCedolini','''S''');
      1:selP442.SetVariable('StatoCedolini','''S'',''N''');
      2:selP442.SetVariable('StatoCedolini','''N''');
    end;
    selP442.SetVariable('Voci','''11600'',''11605''');
    selP442.SetVariable('FiltroCompetenza','AND P442.DATA_COMPETENZA_A BETWEEN TO_DATE(''01/' + edtMeseElaborazione.Text + ''',''DD/MM/YYYY'') AND TO_DATE(''' + DateToStr(R180FineMese(StrToDate('01/' + edtMeseElaborazione.Text))) + ''',''DD/MM/YYYY'')');
    selP442.Open;
    selP442.First;
    while not selP442.Eof do
    begin
      //Ogni giorno della voce vale IMPORTO diviso per (DATA_COMPETENZA_A - DATA_COMPETENZA_DA + 1)
      if (selP442.FieldByName('DATA_COMPETENZA_A').AsDateTime - selP442.FieldByName('DATA_COMPETENZA_DA').AsDateTime) + 1 <> R180GiorniMese(selP442.FieldByName('DATA_COMPETENZA_A').AsDateTime) then
        ImpUnitario:=selP442.FieldByName('IMPORTO').AsFloat / (selP442.FieldByName('DATA_COMPETENZA_A').AsDateTime - selP442.FieldByName('DATA_COMPETENZA_DA').AsDateTime + 1)
      else   //Ogni giorno della voce vale IMPORTO*12/365
        ImpUnitario:=selP442.FieldByName('IMPORTO').AsFloat * 12 / 365;
      Totale:=0;
      for i:=0 to High(lstPeriodiPay) do
      begin
        if (selP442.FieldByName('DATA_COMPETENZA_DA').AsDateTime <= lstPeriodiPay[i].FinePeriodo) and
           (selP442.FieldByName('DATA_COMPETENZA_A').AsDateTime >= lstPeriodiPay[i].InizioPeriodo) and
           (lstPeriodiPay[i].TransactionType = 'Contribution') and (lstPeriodiPay[i].LWOP = False) then
        begin
          //Se il periodo di competenza è interno considero tutto l'importo
          if (selP442.FieldByName('DATA_COMPETENZA_DA').AsDateTime >= lstPeriodiPay[i].InizioPeriodo) and
             (selP442.FieldByName('DATA_COMPETENZA_A').AsDateTime <= lstPeriodiPay[i].FinePeriodo) then
            Importo:=selP442.FieldByName('IMPORTO').AsFloat
          else
          begin //Proporziono in base ai giorni che intersecano il periodo
            GiorniPeriodo:=Trunc(Min(selP442.FieldByName('DATA_COMPETENZA_A').AsDateTime,lstPeriodiPay[i].FinePeriodo)) -
                           Trunc(Max(selP442.FieldByName('DATA_COMPETENZA_DA').AsDateTime,lstPeriodiPay[i].InizioPeriodo)) + 1;
            Importo:=R180Arrotonda(ImpUnitario * GiorniPeriodo,0.01,'P');
            if lstPeriodiPay[i].FinePeriodo = R180FineMese(lstPeriodiPay[i].FinePeriodo) then  //Sull'ultimo periodo carico il residuo
              Importo:=selP442.FieldByName('IMPORTO').AsFloat - Totale;
            Totale:=Totale + Importo;
          end;
          //Sommo all'importo esistente
          if selP442.FieldByName('COD_VOCE').AsString = '11600' then
            lstPeriodiPay[i].Contribution_local_amountsm:=lstPeriodiPay[i].Contribution_local_amountsm + Importo;
          if selP442.FieldByName('COD_VOCE').AsString = '11605' then
            lstPeriodiPay[i].Contribution_local_amountorg:=lstPeriodiPay[i].Contribution_local_amountorg + Importo;
        end;
      end;
      selP442.Next;
    end;
    //----------------------------------------------------------------------------------------------
    //ADJUSTMENT: Spalmare voci 11600 e 11605 antecedenti al mese di estrazione, sui periodi con TRANSACTION_TYPE impostato a Adjustment e LWOP_CONTRIB_FLAG=false
    //----------------------------------------------------------------------------------------------
    selP442.Close;
    selP442.SetVariable('Progressivo',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selP442.SetVariable('MeseElaborazione',' = TO_DATE(''' + DateToStr(R180FineMese(StrToDate('01/' + edtMeseElaborazione.Text))) + ''',''DD/MM/YYYY'')');
    case rgpStatoCedolini.ItemIndex of
      0:selP442.SetVariable('StatoCedolini','''S''');
      1:selP442.SetVariable('StatoCedolini','''S'',''N''');
      2:selP442.SetVariable('StatoCedolini','''N''');
    end;
    selP442.SetVariable('Voci','''11600'',''11605''');
    selP442.SetVariable('FiltroCompetenza','AND P442.DATA_COMPETENZA_A < TO_DATE(''01/' + edtMeseElaborazione.Text + ''',''DD/MM/YYYY'')');
    selP442.Open;
    selP442.First;
    OldMese:=0;
    while not selP442.Eof do
    begin
      //Per ogni singolo mese arretrato sommare i giorni dei periodi del mese stesso con TRANSACTION_TYPE impostato a Adjustment e LWOP_CONTRIB_FLAG=false nel dato TotGGMese
      if OldMese <> R180FineMese(selP442.FieldByName('DATA_COMPETENZA_A').AsDateTime) then
      begin
        TotGGMese:=0;
        for i:=0 to High(lstPeriodiPay) do
        begin
          if (R180InizioMese(selP442.FieldByName('DATA_COMPETENZA_A').AsDateTime) <= lstPeriodiPay[i].FinePeriodo) and
             (R180FineMese(selP442.FieldByName('DATA_COMPETENZA_A').AsDateTime) >= lstPeriodiPay[i].InizioPeriodo) and
             (lstPeriodiPay[i].TransactionType = 'Adjustment') and (lstPeriodiPay[i].LWOP = False) then
            TotGGMese:=TotGGMese + Trunc(lstPeriodiPay[i].FinePeriodo) - Trunc(lstPeriodiPay[i].InizioPeriodo) + 1;
        end;
      end;
      Totale:=0;
      for i:=0 to High(lstPeriodiPay) do
      begin
        if (R180InizioMese(selP442.FieldByName('DATA_COMPETENZA_A').AsDateTime) <= lstPeriodiPay[i].FinePeriodo) and
           (R180FineMese(selP442.FieldByName('DATA_COMPETENZA_A').AsDateTime) >= lstPeriodiPay[i].InizioPeriodo) and
           (lstPeriodiPay[i].TransactionType = 'Adjustment') and (lstPeriodiPay[i].LWOP = False) then
        begin
          //Scorrere i periodi del mese arretrato con TRANSACTION_TYPE impostato a Adjustment e LWOP_CONTRIB_FLAG=false e su ognuno sommare TotImpMese / TotGGMese * (EFFECTIVE_END_DATE - EFFECTIVE_START_DATE + 1)
          GiorniPeriodo:=Trunc(lstPeriodiPay[i].FinePeriodo) - Trunc(lstPeriodiPay[i].InizioPeriodo) + 1;
          Importo:=selP442.FieldByName('IMPORTO').AsFloat / TotGGMese * GiorniPeriodo;
          //Sommo all'importo esistente
          if selP442.FieldByName('COD_VOCE').AsString = '11600' then
            lstPeriodiPay[i].Adjustment_local_amountsm:=lstPeriodiPay[i].Adjustment_local_amountsm + Importo;
          if selP442.FieldByName('COD_VOCE').AsString = '11605' then
            lstPeriodiPay[i].Adjustment_local_amountorg:=lstPeriodiPay[i].Adjustment_local_amountorg + Importo;
        end;
      end;
      OldMese:=R180FineMese(selP442.FieldByName('DATA_COMPETENZA_A').AsDateTime);
      selP442.Next;
    end;
    //----------------------------------------------------------------------------------------------
    //FULL: Spalmare le voci 11600 e 11605 sui periodi con TRANSACTION_TYPE impostato a Adjustment e LWOP_CONTRIB_FLAG=false
    //----------------------------------------------------------------------------------------------
    selP442.Close;
    selP442.SetVariable('Progressivo',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selP442.SetVariable('MeseElaborazione',' <= TO_DATE(''' + DateToStr(R180FineMese(StrToDate('01/' + edtMeseElaborazione.Text))) + ''',''DD/MM/YYYY'')');
    case rgpStatoCedolini.ItemIndex of
      0:selP442.SetVariable('StatoCedolini','''S''');
      1:selP442.SetVariable('StatoCedolini','''S'',''N''');
      2:selP442.SetVariable('StatoCedolini','''N''');
    end;
    selP442.SetVariable('Voci','''11600'',''11605''');
    selP442.SetVariable('FiltroCompetenza',' ');
    selP442.Open;
    selP442.First;
    while not selP442.Eof do
    begin
      //Ogni giorno della voce vale IMPORTO diviso per (DATA_COMPETENZA_A - DATA_COMPETENZA_DA + 1)
      if (selP442.FieldByName('DATA_COMPETENZA_A').AsDateTime - selP442.FieldByName('DATA_COMPETENZA_DA').AsDateTime) + 1 <> R180GiorniMese(selP442.FieldByName('DATA_COMPETENZA_A').AsDateTime) then
        ImpUnitario:=selP442.FieldByName('IMPORTO').AsFloat / (selP442.FieldByName('DATA_COMPETENZA_A').AsDateTime - selP442.FieldByName('DATA_COMPETENZA_DA').AsDateTime + 1)
      else   //Ogni giorno della voce vale IMPORTO*12/365
        ImpUnitario:=selP442.FieldByName('IMPORTO').AsFloat * 12 / 365;
      Totale:=0;
      for i:=0 to High(lstPeriodiPay) do
      begin
        if (selP442.FieldByName('DATA_COMPETENZA_DA').AsDateTime <= lstPeriodiPay[i].FinePeriodo) and
           (selP442.FieldByName('DATA_COMPETENZA_A').AsDateTime >= lstPeriodiPay[i].InizioPeriodo) and
           (lstPeriodiPay[i].TransactionType = 'Adjustment') and (lstPeriodiPay[i].LWOP = False) then
        begin
          //Se il periodo di competenza è interno considero tutto l'importo
          if (selP442.FieldByName('DATA_COMPETENZA_DA').AsDateTime >= lstPeriodiPay[i].InizioPeriodo) and
             (selP442.FieldByName('DATA_COMPETENZA_A').AsDateTime <= lstPeriodiPay[i].FinePeriodo) then
            Importo:=selP442.FieldByName('IMPORTO').AsFloat
          else
          begin //Proporziono in base ai giorni che intersecano il periodo
            GiorniPeriodo:=Trunc(Min(selP442.FieldByName('DATA_COMPETENZA_A').AsDateTime,lstPeriodiPay[i].FinePeriodo)) -
                           Trunc(Max(selP442.FieldByName('DATA_COMPETENZA_DA').AsDateTime,lstPeriodiPay[i].InizioPeriodo)) + 1;
            Importo:=R180Arrotonda(ImpUnitario * GiorniPeriodo,0.01,'P');
            if lstPeriodiPay[i].FinePeriodo = R180FineMese(lstPeriodiPay[i].FinePeriodo) then  //Sull'ultimo periodo carico il residuo
              Importo:=selP442.FieldByName('IMPORTO').AsFloat - Totale;
            Totale:=Totale + Importo;
          end;
          //Sommo all'importo esistente
          if selP442.FieldByName('COD_VOCE').AsString = '11600' then
            lstPeriodiPay[i].Adjustment_local_amountfullsm:=lstPeriodiPay[i].Adjustment_local_amountfullsm + Importo;
          if selP442.FieldByName('COD_VOCE').AsString = '11605' then
            lstPeriodiPay[i].Adjustment_local_amountfullorg:=lstPeriodiPay[i].Adjustment_local_amountfullorg + Importo;
        end;
      end;
      selP442.Next;
    end;
    //----------------------------------------------------------------------------------------------
    //LANGUAGE: Spalmare la voce 00040 sui periodi con TRANSACTION_TYPE impostato a Contribution/Adjustment e LWOP_CONTRIB_FLAG=false
    //----------------------------------------------------------------------------------------------
    selP442.Close;
    selP442.SetVariable('Progressivo',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selP442.SetVariable('MeseElaborazione',' <= TO_DATE(''' + DateToStr(R180FineMese(StrToDate('01/' + edtMeseElaborazione.Text))) + ''',''DD/MM/YYYY'')');
    case rgpStatoCedolini.ItemIndex of
      0:selP442.SetVariable('StatoCedolini','''S''');
      1:selP442.SetVariable('StatoCedolini','''S'',''N''');
      2:selP442.SetVariable('StatoCedolini','''N''');
    end;
    selP442.SetVariable('Voci','''00040''');
    selP442.SetVariable('FiltroCompetenza',' ');
    selP442.Open;
    selP442.First;
    while not selP442.Eof do
    begin
      //Ogni giorno della voce vale IMPORTO diviso per (DATA_COMPETENZA_A - DATA_COMPETENZA_DA + 1)
      if (selP442.FieldByName('DATA_COMPETENZA_A').AsDateTime - selP442.FieldByName('DATA_COMPETENZA_DA').AsDateTime) + 1 <> R180GiorniMese(selP442.FieldByName('DATA_COMPETENZA_A').AsDateTime) then
        ImpUnitario:=selP442.FieldByName('IMPORTO').AsFloat / (selP442.FieldByName('DATA_COMPETENZA_A').AsDateTime - selP442.FieldByName('DATA_COMPETENZA_DA').AsDateTime + 1)
      else   //Ogni giorno della voce vale IMPORTO*12/365
        ImpUnitario:=selP442.FieldByName('IMPORTO').AsFloat * 12 / 365;
      Totale:=0;
      for i:=0 to High(lstPeriodiPay) do
      begin
        if (selP442.FieldByName('DATA_COMPETENZA_DA').AsDateTime <= lstPeriodiPay[i].FinePeriodo) and
           (selP442.FieldByName('DATA_COMPETENZA_A').AsDateTime >= lstPeriodiPay[i].InizioPeriodo) and
          ((lstPeriodiPay[i].TransactionType = 'Contribution') or (lstPeriodiPay[i].TransactionType = 'Adjustment')) and
           (lstPeriodiPay[i].LWOP = False) then
        begin
          //Se il periodo di competenza è interno considero tutto l'importo
          if (selP442.FieldByName('DATA_COMPETENZA_DA').AsDateTime >= lstPeriodiPay[i].InizioPeriodo) and
             (selP442.FieldByName('DATA_COMPETENZA_A').AsDateTime <= lstPeriodiPay[i].FinePeriodo) then
            Importo:=selP442.FieldByName('IMPORTO').AsFloat
          else
          begin //Proporziono in base ai giorni che intersecano il periodo
            GiorniPeriodo:=Trunc(Min(selP442.FieldByName('DATA_COMPETENZA_A').AsDateTime,lstPeriodiPay[i].FinePeriodo)) -
                           Trunc(Max(selP442.FieldByName('DATA_COMPETENZA_DA').AsDateTime,lstPeriodiPay[i].InizioPeriodo)) + 1;
            Importo:=R180Arrotonda(ImpUnitario * GiorniPeriodo,0.01,'P');
            if lstPeriodiPay[i].FinePeriodo = R180FineMese(lstPeriodiPay[i].FinePeriodo) then  //Sull'ultimo periodo carico il residuo
              Importo:=selP442.FieldByName('IMPORTO').AsFloat - Totale;
            Totale:=Totale + Importo;
          end;
          //Sommo all'importo esistente
          lstPeriodiPay[i].Language_allowancelocal_amount:=lstPeriodiPay[i].Language_allowancelocal_amount + Importo;
        end;
      end;
      selP442.Next;
    end;
    //----------------------------------------------------------------------------------------------
    //Per ogni periodo, se TRANSACTION_TYPE impostato a Contribution/Adjustment e LWOP_CONTRIB_FLAG=false
    //Calcolare la minima P430.DECORRENZA dei record di P430 con P430.DECORRENZA_FINE>=EFFECTIVE_START_DATE e P430.COD_TIPOASSOGGETTAMENTO IN(UNJSH, UNJSP)
    //Se P430.DECORRENZA<=EFFECTIVE_START_DATE non fare nulla
    //Viceversa, se P430.DECORRENZA compresa tra EFFECTIVE_START_DATE e EFFECTIVE_END_DATE, impostare EFFECTIVE_START_DATE=P430.DECORRENZA
    //----------------------------------------------------------------------------------------------
    for i:=0 to High(lstPeriodiPay) do
    begin
    if ((lstPeriodiPay[i].TransactionType = 'Contribution') or (lstPeriodiPay[i].TransactionType = 'Adjustment')) and
       (lstPeriodiPay[i].LWOP = False) then
      begin
        selP430a.SetVariable('Progressivo',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        selP430a.SetVariable('InizioPeriodo',lstPeriodiPay[i].InizioPeriodo);
        selP430a.Close;
        selP430a.Open;
        if selP430a.FieldByName('DECORRENZA_UNJSPF').AsString <> '' then
        begin
          if (selP430a.FieldByName('DECORRENZA_UNJSPF').AsDateTime > lstPeriodiPay[i].InizioPeriodo) and
             (selP430a.FieldByName('DECORRENZA_UNJSPF').AsDateTime <= lstPeriodiPay[i].FinePeriodo) then
          begin
            RegistraMsg.InserisciMessaggio('I','E'' stata posticipata la Effective start date dal ' +
              FormatDateTime('dd/mm/yyyy',lstPeriodiPay[i].InizioPeriodo) + ' al ' +
              FormatDateTime('dd/mm/yyyy',selP430a.FieldByName('DECORRENZA_UNJSPF').AsDateTime) +
              ': verificare la corretta decorrenza del tipo assoggettamento stipendiale a UNJSPF',
              '',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
            lstPeriodiPay[i].InizioPeriodo:=selP430a.FieldByName('DECORRENZA_UNJSPF').AsDateTime;
          end;
        end;
      end;
    end;
    //----------------------------------------------------------------------------------------------
    //Alla fine, leggo il vettore, arrotondo e carico in tabella effettiva
    //----------------------------------------------------------------------------------------------
    for i:=0 to High(lstPeriodiPay) do
    begin
      lstPeriodiPay[i].Contribution_local_amountsm:=R180Arrotonda(lstPeriodiPay[i].Contribution_local_amountsm,0.01,'P');
      lstPeriodiPay[i].Contribution_local_amountorg:=R180Arrotonda(lstPeriodiPay[i].Contribution_local_amountorg,0.01,'P');
      lstPeriodiPay[i].Adjustment_local_amountsm:=R180Arrotonda(lstPeriodiPay[i].Adjustment_local_amountsm,0.01,'P');
      lstPeriodiPay[i].Adjustment_local_amountorg:=R180Arrotonda(lstPeriodiPay[i].Adjustment_local_amountorg,0.01,'P');
      insU190.SetVariable('ID_UNJSPF',Id_UNJSPF_Aperto);
      insU190.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      insU190.SetVariable('EMPLOYEE_NUMBER','7' + C700SelAnagrafe.FieldByName('MATRICOLA').AsString);
      insU190.SetVariable('PENSION_NUMBER',lstPeriodiPay[i].PensionNumber);
      insU190.SetVariable('DATE_EARNED',lstPeriodiPay[i].InizioPeriodo);
      insU190.SetVariable('DATE_PAYMENT',StrToDate(edtDataElaborazione.Text));
      insU190.SetVariable('FIRST_NAME',C700SelAnagrafe.FieldByName('NOME_PULITO').AsString);
      insU190.SetVariable('LAST_NAME',C700SelAnagrafe.FieldByName('COGNOME_PULITO').AsString);
      insU190.SetVariable('DATE_OF_BIRTH',C700SelAnagrafe.FieldByName('DATANAS').AsDateTime);
      insU190.SetVariable('TRANSACTION_TYPE',lstPeriodiPay[i].TransactionType);
      insU190.SetVariable('EFFECTIVE_START_DATE',lstPeriodiPay[i].InizioPeriodo);
      insU190.SetVariable('EFFECTIVE_END_DATE',lstPeriodiPay[i].FinePeriodo);
      insU190.SetVariable('LWOP_CONTRIB_FLAG',IfThen(lstPeriodiPay[i].LWOP,'Y','N'));
      insU190.SetVariable('CATEGORY',lstPeriodiPay[i].Category);
      insU190.SetVariable('GRADE',lstPeriodiPay[i].Grade);
      insU190.SetVariable('STEP',lstPeriodiPay[i].Step);
      insU190.SetVariable('DUTY_STATION',lstPeriodiPay[i].DutyStation);
      insU190.SetVariable('PARTTIME_PERCENT',lstPeriodiPay[i].Parttime);
      insU190.SetVariable('CURRENCY_CODE',lstPeriodiPay[i].CurrencyCode);
      insU190.SetVariable('EXCHANGE_RATE',lstPeriodiPay[i].Exchange_rate);
      insU190.SetVariable('PRRATE_LOCAL_AMOUNT',lstPeriodiPay[i].Prrate_local_amount);
      insU190.SetVariable('PRRATE_BASE_AMOUNT',R180Arrotonda(lstPeriodiPay[i].Prrate_local_amount * lstPeriodiPay[i].Exchange_rate,1,'P'));
      insU190.SetVariable('LANGUAGE_ALLOWANCELOCAL_AMOUNT',lstPeriodiPay[i].Language_allowancelocal_amount);
      insU190.SetVariable('LANGUAGE_ALLOWANCEBASE_AMOUNT',R180Arrotonda(lstPeriodiPay[i].Language_allowancelocal_amount * lstPeriodiPay[i].Exchange_rate,0.01,'P'));
      //Per ogni periodo, se TRANSACTION_TYPE impostato a Contribution/Adjustment e LWOP_CONTRIB_FLAG=false calcolare PRORATEDRATIO
      //utilizzando CONTRIBUTION_LOCAL_AMOUNTSM se TRANSACTION_TYPE=Contribution altrimenti ADJUSTMENTLOCALAMOUNTFULLSM.
      Proratedratio:=lstPeriodiPay[i].Proratedratio;
      if (lstPeriodiPay[i].LWOP = False) and
        ((lstPeriodiPay[i].TransactionType = 'Contribution') or (lstPeriodiPay[i].TransactionType = 'Adjustment')) then
      begin
        if lstPeriodiPay[i].Prrate_local_amount = 0 then
          Proratedratio:=0
        else
        begin
          selP200.Close;
          selP200.SetVariable('MeseElaborazione',R180FineMese(StrToDate('01/' + edtMeseElaborazione.Text)));
          selP200.Open;
          if lstPeriodiPay[i].TransactionType = 'Contribution' then
            Proratedratio:=lstPeriodiPay[i].Contribution_local_amountsm;
          if lstPeriodiPay[i].TransactionType = 'Adjustment' then
            Proratedratio:=lstPeriodiPay[i].Adjustment_local_amountfullsm;
          Proratedratio:=R180Arrotonda(Proratedratio / (lstPeriodiPay[i].Prrate_local_amount * lstPeriodiPay[i].Parttime / 12 * selP200.FieldByName('RITENUTA_PERC').AsFloat / 100),0.0001,'P');
        end;
      end;
      insU190.SetVariable('PRORATEDRATIO',Proratedratio);
      insU190.SetVariable('CONTRIBUTION_LOCAL_AMOUNTSM',lstPeriodiPay[i].Contribution_local_amountsm);
      insU190.SetVariable('CONTRIBUTION_BASE_AMOUNTSM',R180Arrotonda(lstPeriodiPay[i].Contribution_local_amountsm * lstPeriodiPay[i].Exchange_rate,0.01,'P'));
      insU190.SetVariable('CONTRIBUTION_LOCAL_AMOUNTORG',lstPeriodiPay[i].Contribution_local_amountorg);
      insU190.SetVariable('CONTRIBUTION_BASE_AMOUNTORG',R180Arrotonda(lstPeriodiPay[i].Contribution_local_amountorg * lstPeriodiPay[i].Exchange_rate,0.01,'P'));
      insU190.SetVariable('ADJUSTMENT_LOCAL_AMOUNTSM',lstPeriodiPay[i].Adjustment_local_amountsm);
      insU190.SetVariable('ADJUSTMENT_BASE_AMOUNTSM',R180Arrotonda(lstPeriodiPay[i].Adjustment_local_amountsm * lstPeriodiPay[i].Exchange_rate,0.01,'P'));
      insU190.SetVariable('ADJUSTMENT_LOCAL_AMOUNTORG',lstPeriodiPay[i].Adjustment_local_amountorg);
      insU190.SetVariable('ADJUSTMENT_BASE_AMOUNTORG',R180Arrotonda(lstPeriodiPay[i].Adjustment_local_amountorg * lstPeriodiPay[i].Exchange_rate,0.01,'P'));
      insU190.SetVariable('ADJUSTMENT_LOCAL_AMOUNTFULLSM',lstPeriodiPay[i].Adjustment_local_amountfullsm);
      insU190.SetVariable('ADJUSTMENT_BASE_AMOUNTFULLSM',R180Arrotonda(lstPeriodiPay[i].Adjustment_local_amountfullsm * lstPeriodiPay[i].Exchange_rate,0.01,'P'));
      insU190.SetVariable('ADJUSTMENT_LOCAL_AMOUNTFULLORG',lstPeriodiPay[i].Adjustment_local_amountfullorg);
      insU190.SetVariable('ADJUSTMENT_BASE_AMOUNTFULLORG',R180Arrotonda(lstPeriodiPay[i].Adjustment_local_amountfullorg * lstPeriodiPay[i].Exchange_rate,0.01,'P'));
      insU190.SetVariable('VALIDATION_AMOUNTSM',lstPeriodiPay[i].Validation_amountsm);
      insU190.SetVariable('VALIDATION_AMOUNTORG',lstPeriodiPay[i].Validation_amountorg);
      insU190.SetVariable('RESTORATION_AMOUNTSM',lstPeriodiPay[i].Restoration_amountsm);
      insU190.SetVariable('RESTORATION_AMOUNTORG',lstPeriodiPay[i].Restoration_amountorg);
      insU190.SetVariable('ACTUARIAL_COSTSSM',lstPeriodiPay[i].Actuarial_costssm);
      insU190.SetVariable('ACTUARIAL_COSTSORG',lstPeriodiPay[i].Actuarial_costsorg);
      insU190.SetVariable('INTEREST_CONTRIBUTIONSM',lstPeriodiPay[i].Interest_contributionsm);
      insU190.SetVariable('INTEREST_CONTRIBUTIONORG',lstPeriodiPay[i].Interest_contributionorg);
      insU190.SetVariable('MISC_ADJUSTMENTSM',lstPeriodiPay[i].Misc_adjustmentsm);
      insU190.SetVariable('MISC_ADJUSTMENTORG',lstPeriodiPay[i].Misc_adjustmentorg);
      try
        insU190.Execute;
      except
        on E:Exception do
          RegistraMsg.InserisciMessaggio('A','Inserimento in U190_UNJSPF_PAY_TRAN fallito. ' + E.Message,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      end;
      SessioneOracle.Commit;
    end;
    //Segnalo anomalia se esistono periodi EFFECTIVE_START_DATE/EFFECTIVE_END_DATE dei record con TRANSACTION_TYPE = Contribution/Adjustment che si intersecano
    selSQL.SQL.Clear;
    selSQL.SQL.Add('SELECT U190.PROGRESSIVO, U190.EFFECTIVE_START_DATE, U190.EFFECTIVE_END_DATE');
    selSQL.SQL.Add('  FROM U190_UNJSPF_PAY_TRAN U190');
    selSQL.SQL.Add(' WHERE U190.ID_UNJSPF = ' + IntToStr(Id_UNJSPF_Aperto));
    selSQL.SQL.Add('   AND U190.PROGRESSIVO = ' + C700SelAnagrafe.FieldByName('PROGRESSIVO').AsString);
    selSQL.SQL.Add('   AND U190.TRANSACTION_TYPE IN (''Contribution'',''Adjustment'')');
    selSQL.SQL.Add('   AND EXISTS (SELECT ''X'' FROM U190_UNJSPF_PAY_TRAN T');
    selSQL.SQL.Add('                WHERE T.ID_UNJSPF = U190.ID_UNJSPF');
    selSQL.SQL.Add('                  AND T.PROGRESSIVO = U190.PROGRESSIVO');
    selSQL.SQL.Add('                  AND T.TRANSACTION_TYPE IN (''Contribution'',''Adjustment'')');
    selSQL.SQL.Add('                  AND T.ROWID <> U190.ROWID');
    selSQL.SQL.Add('                  AND T.EFFECTIVE_START_DATE <= U190.EFFECTIVE_END_DATE');
    selSQL.SQL.Add('                  AND T.EFFECTIVE_END_DATE >= U190.EFFECTIVE_START_DATE)');
    selSQL.Execute;
    if (selSQL.RowsProcessed > 0) then
      RegistraMsg.InserisciMessaggio('A','Presenza di periodi Contribution/Adjustment intersecanti','',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    //Segnalo anomalia se esistono periodi EFFECTIVE_START_DATE/EFFECTIVE_END_DATE dei record con TRANSACTION_TYPE = Contribution/Adjustment che non sono interamente coperti dai periodi di servizio indicati in XXILO_UNJSPF_CONTRACTS
    selSQL.SQL.Clear;
    selSQL.SQL.Add('SELECT DISTINCT U190.PROGRESSIVO, U190.EFFECTIVE_START_DATE, U190.EFFECTIVE_END_DATE');
    selSQL.SQL.Add('  FROM U190_UNJSPF_PAY_TRAN U190, U100_UNJSPF_TESTATE A');
    selSQL.SQL.Add(' WHERE A.TIPO_FLUSSO = ''FIN''');
    selSQL.SQL.Add('   AND U190.ID_UNJSPF = A.ID_UNJSPF');
    selSQL.SQL.Add('   AND U190.ID_UNJSPF = ' + IntToStr(Id_UNJSPF_Aperto));
    selSQL.SQL.Add('   AND U190.PROGRESSIVO = ' + C700SelAnagrafe.FieldByName('PROGRESSIVO').AsString);
    selSQL.SQL.Add('   AND U190.TRANSACTION_TYPE IN (''Contribution'',''Adjustment'')');
    selSQL.SQL.Add('   AND NOT EXISTS (SELECT ''X'' FROM U145_UNJSPF_CONTRACTS U145, U100_UNJSPF_TESTATE B');
    selSQL.SQL.Add('     WHERE B.TIPO_FLUSSO = ''HR''');
    selSQL.SQL.Add('       AND B.DATA_FINE_PERIODO = A.DATA_FINE_PERIODO');
    selSQL.SQL.Add('       AND U145.ID_UNJSPF = B.ID_UNJSPF');
    selSQL.SQL.Add('       AND U145.PROGRESSIVO = U190.PROGRESSIVO');
    selSQL.SQL.Add('       AND U190.EFFECTIVE_START_DATE >= U145.STARTDATE');
    selSQL.SQL.Add('       AND U190.EFFECTIVE_END_DATE <= U145.ENDDATE)');
    selSQL.Execute;
    if (selSQL.RowsProcessed > 0) then
      RegistraMsg.InserisciMessaggio('I','Presenza di periodi Contribution/Adjustment non interamente coperti dal periodo di servizio indicato in XXILO_UNJSPF_CONTRACTS','',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    //Segnalo anomalia se esistono periodi EFFECTIVE_START_DATE/EFFECTIVE_END_DATE dei record con LWOP_CONTRIB_FLAG = True che non sono interamente coperti dai periodi di LWOP indicati in XXILO_UNJSPF_LWOP
    selSQL.SQL.Clear;
    selSQL.SQL.Add('SELECT DISTINCT U190.PROGRESSIVO, U190.EFFECTIVE_START_DATE, U190.EFFECTIVE_END_DATE');
    selSQL.SQL.Add('  FROM U190_UNJSPF_PAY_TRAN U190, U100_UNJSPF_TESTATE A');
    selSQL.SQL.Add(' WHERE A.TIPO_FLUSSO = ''FIN''');
    selSQL.SQL.Add('   AND U190.ID_UNJSPF = A.ID_UNJSPF');
    selSQL.SQL.Add('   AND U190.ID_UNJSPF = ' + IntToStr(Id_UNJSPF_Aperto));
    selSQL.SQL.Add('   AND U190.PROGRESSIVO = ' + C700SelAnagrafe.FieldByName('PROGRESSIVO').AsString);
    selSQL.SQL.Add('   AND U190.LWOP_CONTRIB_FLAG = ''Y''');
    selSQL.SQL.Add('   AND NOT EXISTS (SELECT ''X'' FROM U165_UNJSPF_LWOP U165, U100_UNJSPF_TESTATE B');
    selSQL.SQL.Add('     WHERE B.TIPO_FLUSSO = ''HR''');
    selSQL.SQL.Add('       AND B.DATA_FINE_PERIODO = A.DATA_FINE_PERIODO');
    selSQL.SQL.Add('       AND U165.ID_UNJSPF = B.ID_UNJSPF');
    selSQL.SQL.Add('       AND U165.PROGRESSIVO = U190.PROGRESSIVO');
    selSQL.SQL.Add('       AND U190.EFFECTIVE_START_DATE >= U165.STARTDATE');
    selSQL.SQL.Add('       AND U190.EFFECTIVE_END_DATE <= U165.ENDDATE)');
    selSQL.Execute;
    if (selSQL.RowsProcessed > 0) then
      RegistraMsg.InserisciMessaggio('A','Presenza di periodi con LWOP Contrib. = True non interamente coperti dai periodi indicati in XXILO_UNJSPF_LWOP','',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    //Segnalo anomalia se PRORATEDRATIO totale di un mese è maggiore di 1
    selSQL.SQL.Clear;
    selSQL.SQL.Add('SELECT U190.PROGRESSIVO, TO_CHAR(U190.EFFECTIVE_END_DATE,''YYYYMM'') EFFECTIVE_END_DATE, SUM(U190.PRORATEDRATIO) PRORATEDRATIO');
    selSQL.SQL.Add('  FROM U190_UNJSPF_PAY_TRAN U190');
    selSQL.SQL.Add(' WHERE U190.ID_UNJSPF = ' + IntToStr(Id_UNJSPF_Aperto));
    selSQL.SQL.Add('   AND U190.PROGRESSIVO = ' + C700SelAnagrafe.FieldByName('PROGRESSIVO').AsString);
    selSQL.SQL.Add('   AND U190.TRANSACTION_TYPE IN (''Contribution'',''Adjustment'')');
    selSQL.SQL.Add('   AND U190.LWOP_CONTRIB_FLAG = ''N''');
    selSQL.SQL.Add(' GROUP BY U190.PROGRESSIVO, TO_CHAR(U190.EFFECTIVE_END_DATE,''YYYYMM'')');
    selSQL.SQL.Add('HAVING SUM(U190.PRORATEDRATIO) > 1');
    selSQL.Execute;
    if (selSQL.RowsProcessed > 0) then
      RegistraMsg.InserisciMessaggio('A','Presenza di mesi con ProratedRatio totali maggiori di 1','',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    //Segnalo anomalia se esistono due o più periodi con EFFECTIVE_START_DATE afferente allo stesso mese mm/aaaa
    selSQL.SQL.Clear;
    selSQL.SQL.Add('SELECT TO_CHAR(U190.EFFECTIVE_START_DATE,''MM/YYYY'') EFFECTIVE_START_DATE');
    selSQL.SQL.Add('  FROM U190_UNJSPF_PAY_TRAN U190');
    selSQL.SQL.Add(' WHERE U190.ID_UNJSPF = ' + IntToStr(Id_UNJSPF_Aperto));
    selSQL.SQL.Add('   AND U190.PROGRESSIVO = ' + C700SelAnagrafe.FieldByName('PROGRESSIVO').AsString);
    selSQL.SQL.Add('   AND U190.TRANSACTION_TYPE IN (''Contribution'',''Adjustment'')');
    selSQL.SQL.Add('   AND U190.LWOP_CONTRIB_FLAG = ''N''');
    selSQL.SQL.Add(' GROUP BY TO_CHAR(U190.EFFECTIVE_START_DATE,''MM/YYYY'')');
    selSQL.SQL.Add('HAVING COUNT(*) > 1');
    selSQL.Execute;
    if (selSQL.RowsProcessed > 0) then
      while not selSQL.Eof do
      begin
        RegistraMsg.InserisciMessaggio('A','E'' stato necessario spezzare il mese ' + VarToStr(selSQL.Field(0)) + ' in più periodi: verificare i dati in essi contenuti, eventualmente correggendo i valori di Prrate local/base amount e Prorated ratio','',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        selSQL.Next;
      end;
    //Segnalo anomalia se la sommatoria di CONTRIBUTION_LOCAL_AMOUNTSM e ADJUSTMENT_LOCAL_AMOUNTSM dei periodi con LWOP_CONTRIB_FLAG=False è diversa dalla sommatoria della voce 11600
    selSQL.SQL.Clear;
    selSQL.SQL.Add('SELECT * FROM (');
    selSQL.SQL.Add('SELECT PROGRESSIVO, SUM(CONTRIBUTION_LOCAL_AMOUNTSM) TOT_CONTRIBUTION, SUM(ADJUSTMENT_LOCAL_AMOUNTSM) TOT_ADJUSTMENT,');
    selSQL.SQL.Add('  (SELECT SUM(P442.IMPORTO)');
    selSQL.SQL.Add('     FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442');
    selSQL.SQL.Add('    WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO');
    selSQL.SQL.Add('      AND P441.DATA_CEDOLINO = TO_DATE(''' + DateToStr(R180FineMese(StrToDate('01/' + edtMeseElaborazione.Text))) + ''',''DD/MM/YYYY'')');
    case rgpStatoCedolini.ItemIndex of
      0:selSQL.SQL.Add('  AND P441.CHIUSO = ''S''');
      1:selSQL.SQL.Add('  AND P441.CHIUSO IN (''S'',''N'')');
      2:selSQL.SQL.Add('  AND P441.CHIUSO = ''N''');
    end;
    selSQL.SQL.Add('      AND P441.PROGRESSIVO = U190.PROGRESSIVO');
    selSQL.SQL.Add('      AND P442.TIPO_RECORD = ''M''');
    selSQL.SQL.Add('      AND P442.COD_CONTRATTO = ''EDPON''');
    selSQL.SQL.Add('      AND P442.COD_VOCE = ''11600''');
    selSQL.SQL.Add('      AND P442.DATA_COMPETENZA_A BETWEEN TRUNC(P441.DATA_CEDOLINO,''MM'') AND P441.DATA_CEDOLINO) TOT_CORRENTE,');
    selSQL.SQL.Add('  (SELECT SUM(P442.IMPORTO)');
    selSQL.SQL.Add('     FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442');
    selSQL.SQL.Add('    WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO');
    selSQL.SQL.Add('      AND P441.DATA_CEDOLINO = TO_DATE(''' + DateToStr(R180FineMese(StrToDate('01/' + edtMeseElaborazione.Text))) + ''',''DD/MM/YYYY'')');
    case rgpStatoCedolini.ItemIndex of
      0:selSQL.SQL.Add('  AND P441.CHIUSO = ''S''');
      1:selSQL.SQL.Add('  AND P441.CHIUSO IN (''S'',''N'')');
      2:selSQL.SQL.Add('  AND P441.CHIUSO = ''N''');
    end;
    selSQL.SQL.Add('      AND P441.PROGRESSIVO = U190.PROGRESSIVO');
    selSQL.SQL.Add('      AND P442.TIPO_RECORD = ''M''');
    selSQL.SQL.Add('      AND P442.COD_CONTRATTO = ''EDPON''');
    selSQL.SQL.Add('      AND P442.COD_VOCE = ''11600''');
    selSQL.SQL.Add('      AND P442.DATA_COMPETENZA_A < TRUNC(P441.DATA_CEDOLINO,''MM'')) TOT_PRECEDENTE');
    selSQL.SQL.Add('  FROM U190_UNJSPF_PAY_TRAN U190');
    selSQL.SQL.Add(' WHERE U190.ID_UNJSPF = ' + IntToStr(Id_UNJSPF_Aperto));
    selSQL.SQL.Add('   AND U190.PROGRESSIVO = ' + C700SelAnagrafe.FieldByName('PROGRESSIVO').AsString);
    selSQL.SQL.Add('   AND U190.LWOP_CONTRIB_FLAG = ''N''');
    selSQL.SQL.Add(' GROUP BY PROGRESSIVO)');
    selSQL.SQL.Add(' WHERE TOT_CONTRIBUTION <> TOT_CORRENTE OR TOT_ADJUSTMENT <> TOT_PRECEDENTE');
    selSQL.Execute;
    if (selSQL.RowsProcessed > 0) then
      RegistraMsg.InserisciMessaggio('A','La sommatoria di CONTRIBUTION_LOCAL_AMOUNTSM e ADJUSTMENT_LOCAL_AMOUNTSM dei periodi è diversa dalla sommatoria della voce 11600','',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    //Segnalo anomalia se la sommatoria di CONTRIBUTION_LOCAL_AMOUNTORG e ADJUSTMENT_LOCAL_AMOUNTORG con LWOP_CONTRIB_FLAG=False è diversa dalla sommatoria della voce 11605
    selSQL.SQL.Clear;
    selSQL.SQL.Add('SELECT * FROM (');
    selSQL.SQL.Add('SELECT PROGRESSIVO, SUM(CONTRIBUTION_LOCAL_AMOUNTORG) TOT_CONTRIBUTION, SUM(ADJUSTMENT_LOCAL_AMOUNTORG) TOT_ADJUSTMENT,');
    selSQL.SQL.Add('  (SELECT SUM(P442.IMPORTO)');
    selSQL.SQL.Add('     FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442');
    selSQL.SQL.Add('    WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO');
    selSQL.SQL.Add('      AND P441.DATA_CEDOLINO = TO_DATE(''' + DateToStr(R180FineMese(StrToDate('01/' + edtMeseElaborazione.Text))) + ''',''DD/MM/YYYY'')');
    case rgpStatoCedolini.ItemIndex of
      0:selSQL.SQL.Add('  AND P441.CHIUSO = ''S''');
      1:selSQL.SQL.Add('  AND P441.CHIUSO IN (''S'',''N'')');
      2:selSQL.SQL.Add('  AND P441.CHIUSO = ''N''');
    end;
    selSQL.SQL.Add('      AND P441.PROGRESSIVO = U190.PROGRESSIVO');
    selSQL.SQL.Add('      AND P442.TIPO_RECORD = ''M''');
    selSQL.SQL.Add('      AND P442.COD_CONTRATTO = ''EDPON''');
    selSQL.SQL.Add('      AND P442.COD_VOCE = ''11605''');
    selSQL.SQL.Add('      AND P442.DATA_COMPETENZA_A BETWEEN TRUNC(P441.DATA_CEDOLINO,''MM'') AND P441.DATA_CEDOLINO) TOT_CORRENTE,');
    selSQL.SQL.Add('  (SELECT SUM(P442.IMPORTO)');
    selSQL.SQL.Add('     FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442');
    selSQL.SQL.Add('    WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO');
    selSQL.SQL.Add('      AND P441.DATA_CEDOLINO = TO_DATE(''' + DateToStr(R180FineMese(StrToDate('01/' + edtMeseElaborazione.Text))) + ''',''DD/MM/YYYY'')');
    case rgpStatoCedolini.ItemIndex of
      0:selSQL.SQL.Add('  AND P441.CHIUSO = ''S''');
      1:selSQL.SQL.Add('  AND P441.CHIUSO IN (''S'',''N'')');
      2:selSQL.SQL.Add('  AND P441.CHIUSO = ''N''');
    end;
    selSQL.SQL.Add('      AND P441.PROGRESSIVO = U190.PROGRESSIVO');
    selSQL.SQL.Add('      AND P442.TIPO_RECORD = ''M''');
    selSQL.SQL.Add('      AND P442.COD_CONTRATTO = ''EDPON''');
    selSQL.SQL.Add('      AND P442.COD_VOCE = ''11605''');
    selSQL.SQL.Add('      AND P442.DATA_COMPETENZA_A < TRUNC(P441.DATA_CEDOLINO,''MM'')) TOT_PRECEDENTE');
    selSQL.SQL.Add('  FROM U190_UNJSPF_PAY_TRAN U190');
    selSQL.SQL.Add(' WHERE U190.ID_UNJSPF = ' + IntToStr(Id_UNJSPF_Aperto));
    selSQL.SQL.Add('   AND U190.PROGRESSIVO = ' + C700SelAnagrafe.FieldByName('PROGRESSIVO').AsString);
    selSQL.SQL.Add('   AND U190.LWOP_CONTRIB_FLAG = ''N''');
    selSQL.SQL.Add(' GROUP BY PROGRESSIVO)');
    selSQL.SQL.Add(' WHERE TOT_CONTRIBUTION <> TOT_CORRENTE OR TOT_ADJUSTMENT <> TOT_PRECEDENTE');
    selSQL.Execute;
    if (selSQL.RowsProcessed > 0) then
      RegistraMsg.InserisciMessaggio('A','La sommatoria di CONTRIBUTION_LOCAL_AMOUNTORG e ADJUSTMENT_LOCAL_AMOUNTORG dei periodi è diversa dalla sommatoria della voce 11605','',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  end;
end;

procedure TP288FElaborazioneUnjspf.PulisciFornitura;
  procedure SvuotaDati(Tabella:String);
  begin
    with P288FElaborazioneUnjspfDtM do
    begin
      //Cancello tutti i dati
      delTab2.SetVariable('TABELLA',Tabella);
      delTab2.SetVariable('ID',Id_UNJSPF_Aperto);
      try
        delTab2.Execute;
      except
        on E:Exception do
          RegistraMsg.InserisciMessaggio('A','Cancellazione ' + Tabella + ' fallita. ' + E.Message,'',0);
      end;
      SessioneOracle.Commit;
    end;
  end;
begin
  if TipoFlusso = 'HR' then
  begin
    if chklstTabelle.Checked[0] then
      SvuotaDati(lstTabelle[0].NomeFisicoEDP);
    if chklstTabelle.Checked[1] then
      SvuotaDati(lstTabelle[1].NomeFisicoEDP);
    if chklstTabelle.Checked[2] then
      SvuotaDati(lstTabelle[2].NomeFisicoEDP);
    if chklstTabelle.Checked[3] then
      SvuotaDati(lstTabelle[3].NomeFisicoEDP);
    if chklstTabelle.Checked[4] then
      SvuotaDati(lstTabelle[4].NomeFisicoEDP);
    if chklstTabelle.Checked[5] then
      SvuotaDati(lstTabelle[5].NomeFisicoEDP);
    if chklstTabelle.Checked[6] then
      SvuotaDati(lstTabelle[6].NomeFisicoEDP);
    if chklstTabelle.Checked[7] then
      SvuotaDati(lstTabelle[7].NomeFisicoEDP);
    if chklstTabelle.Checked[8] then
      SvuotaDati(lstTabelle[8].NomeFisicoEDP);
    if chklstTabelle.Checked[9] then
      SvuotaDati(lstTabelle[9].NomeFisicoEDP);
    if chklstTabelle.Checked[10] then
      SvuotaDati(lstTabelle[10].NomeFisicoEDP);
    if chklstTabelle.Checked[11] then
      SvuotaDati(lstTabelle[11].NomeFisicoEDP);
    if chklstTabelle.Checked[12] then
      SvuotaDati(lstTabelle[12].NomeFisicoEDP);
  end
  else
  begin
    if chklstTabelle.Checked[0] then
      SvuotaDati(lstTabelle[13].NomeFisicoEDP);
  end;
end;

procedure TP288FElaborazioneUnjspf.sbtDataChiusuraClick(Sender: TObject);
begin
  edtDataChiusura.Text:=FormatDateTime('dd/mm/yyyy', DataOut(StrToDate(edtDataChiusura.Text), 'Data chiusura', 'G'));
end;

procedure TP288FElaborazioneUnjspf.sbtDataElaborazioneClick(Sender: TObject);
begin
  edtDataElaborazione.Text:=FormatDateTime('dd/mm/yyyy', DataOut(StrToDate(edtDataElaborazione.Text), 'Data elaborazione', 'G'));
end;

procedure TP288FElaborazioneUnjspf.sbtDataEsportazioneClick(Sender: TObject);
begin
  edtDataEsportazione.Text:=FormatDateTime('dd/mm/yyyy', DataOut(StrToDate(edtDataEsportazione.Text), 'Data esportazione', 'G'));
end;

procedure TP288FElaborazioneUnjspf.sbtDataInizioEstrazClick(Sender: TObject);
begin
  edtDataInizioEstraz.Text:=FormatDateTime('dd/mm/yyyy', DataOut(StrToDate(edtDataInizioEstraz.Text), 'Data inizio storico', 'G'));
end;

procedure TP288FElaborazioneUnjspf.sbtMeseElaborazioneClick(Sender: TObject);
begin
  edtMeseElaborazione.Text:=FormatDateTime('mm/yyyy', DataOut(StrToDate('01/' + edtMeseElaborazione.Text), 'Mese elaborazione', 'M'));
end;

procedure TP288FElaborazioneUnjspf.AnnullaFornitura;
  procedure CancellaDati(Tabella:String);
  begin
    with P288FElaborazioneUnjspfDtM do
    begin
      delTab.SetVariable('TABELLA',Tabella);
      delTab.SetVariable('PROGRESSIVO',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      delTab.SetVariable('ID',Id_UNJSPF_Aperto);
      try
        delTab.Execute;
      except
        on E:Exception do
          RegistraMsg.InserisciMessaggio('A','Cancellazione ' + Tabella + ' fallita. ' + E.Message,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      end;
      SessioneOracle.Commit;
    end;
  end;
begin
  Screen.Cursor:=crHourGlass;
  StatusBar.Panels[1].Text:='Cancellazione tabelle in corso...premere Esc per interrompere';
  StatusBar.Repaint;
  ElaborazioneInterrotta:=False;
  ProgressBar1.Position:=0;
  ProgressBar1.Max:=C700SelAnagrafe.RecordCount;
  C700SelAnagrafe.First;
  while not C700SelAnagrafe.Eof do
  begin
    if ElaborazioneInterrotta then
    begin
      StatusBar.Panels[1].Text:='';
      ElaborazioneInterrotta:=False;
      R180MessageBox('Elaborazione interrotta su richiesta dell''operatore.',INFORMA);
      Break;
    end;
//    frmSelAnagrafe.VisualizzaDipendente;
    ProgressBar1.StepBy(1);
    if TipoFlusso = 'HR' then
    begin
      if chklstTabelle.Checked[0] then
        CancellaDati(lstTabelle[0].NomeFisicoEDP);
      if chklstTabelle.Checked[1] then
        CancellaDati(lstTabelle[1].NomeFisicoEDP);
      if chklstTabelle.Checked[2] then
        CancellaDati(lstTabelle[2].NomeFisicoEDP);
      if chklstTabelle.Checked[3] then
        CancellaDati(lstTabelle[3].NomeFisicoEDP);
      if chklstTabelle.Checked[4] then
        CancellaDati(lstTabelle[4].NomeFisicoEDP);
      if chklstTabelle.Checked[5] then
        CancellaDati(lstTabelle[5].NomeFisicoEDP);
      if chklstTabelle.Checked[6] then
        CancellaDati(lstTabelle[6].NomeFisicoEDP);
      if chklstTabelle.Checked[7] then
        CancellaDati(lstTabelle[7].NomeFisicoEDP);
      if chklstTabelle.Checked[8] then
        CancellaDati(lstTabelle[8].NomeFisicoEDP);
      if chklstTabelle.Checked[9] then
        CancellaDati(lstTabelle[9].NomeFisicoEDP);
      if chklstTabelle.Checked[10] then
        CancellaDati(lstTabelle[10].NomeFisicoEDP);
      if chklstTabelle.Checked[11] then
        CancellaDati(lstTabelle[11].NomeFisicoEDP);
      if chklstTabelle.Checked[12] then
        CancellaDati(lstTabelle[12].NomeFisicoEDP);
    end
    else
    begin
      if chklstTabelle.Checked[0] then
        CancellaDati(lstTabelle[13].NomeFisicoEDP);
    end;
    C700SelAnagrafe.Next;
  end;
  ProgressBar1.Position:=0;
  Screen.Cursor:=crDefault;
  StatusBar.Panels[1].Text:='';
end;

procedure TP288FElaborazioneUnjspf.EsportaFornitura;
var Conta:Integer;
  procedure EliminaDati(Tabella:String);
  begin
    with P288FElaborazioneUnjspfDtM do
    begin
      delTab3.SetVariable('TABELLA',Tabella);
      try
        delTab3.Execute;
      except
        on E:Exception do
          RegistraMsg.InserisciMessaggio('A','Cancellazione ' + Tabella + ' fallita. ' + E.Message,'',C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      end;
      SessioneOracle.Commit;
    end;
  end;
begin
  Screen.Cursor:=crHourGlass;
  StatusBar.Panels[1].Text:='Esportazione tabelle in corso...';
  StatusBar.Repaint;
  with P288FElaborazioneUnjspfDtM do
  begin
    Conta:=-1;
    if TipoFlusso = 'HR' then
    begin
      if chklstTabelle.Checked[0] then
      begin
        EliminaDati(lstTabelle[0].NomeFisicoILO);
        expU120.SetVariable('TABELLA',lstTabelle[0].NomeFisicoILO);
        expU120.SetVariable('ID_UNJSPF',Id_UNJSPF_Aperto);
        try
          expU120.Execute;
          Conta:=expU120.RowsProcessed;
        except
          on E:Exception do
            RegistraMsg.InserisciMessaggio('A','Esportazione ' + lstTabelle[0].NomeFisicoILO + ' fallita. ' + E.Message,'',0);
        end;
        SessioneOracle.Commit;
      end;
      if chklstTabelle.Checked[1] then
      begin
        EliminaDati(lstTabelle[1].NomeFisicoILO);
        expU125.SetVariable('TABELLA',lstTabelle[1].NomeFisicoILO);
        expU125.SetVariable('ID_UNJSPF',Id_UNJSPF_Aperto);
        try
          expU125.Execute;
        except
          on E:Exception do
            RegistraMsg.InserisciMessaggio('A','Esportazione ' + lstTabelle[1].NomeFisicoILO + ' fallita. ' + E.Message,'',0);
        end;
        SessioneOracle.Commit;
      end;
      if chklstTabelle.Checked[2] then
      begin
        EliminaDati(lstTabelle[2].NomeFisicoILO);
        expU130.SetVariable('TABELLA',lstTabelle[2].NomeFisicoILO);
        expU130.SetVariable('ID_UNJSPF',Id_UNJSPF_Aperto);
        try
          expU130.Execute;
        except
          on E:Exception do
            RegistraMsg.InserisciMessaggio('A','Esportazione ' + lstTabelle[2].NomeFisicoILO + ' fallita. ' + E.Message,'',0);
        end;
        SessioneOracle.Commit;
      end;
      if chklstTabelle.Checked[3] then
      begin
        EliminaDati(lstTabelle[3].NomeFisicoILO);
        expU135.SetVariable('TABELLA',lstTabelle[3].NomeFisicoILO);
        expU135.SetVariable('ID_UNJSPF',Id_UNJSPF_Aperto);
        try
          expU135.Execute;
        except
          on E:Exception do
            RegistraMsg.InserisciMessaggio('A','Esportazione ' + lstTabelle[3].NomeFisicoILO + ' fallita. ' + E.Message,'',0);
        end;
        SessioneOracle.Commit;
      end;
      if chklstTabelle.Checked[4] then
      begin
        EliminaDati(lstTabelle[4].NomeFisicoILO);
        expU140.SetVariable('TABELLA',lstTabelle[4].NomeFisicoILO);
        expU140.SetVariable('ID_UNJSPF',Id_UNJSPF_Aperto);
        try
          expU140.Execute;
        except
          on E:Exception do
            RegistraMsg.InserisciMessaggio('A','Esportazione ' + lstTabelle[4].NomeFisicoILO + ' fallita. ' + E.Message,'',0);
        end;
        SessioneOracle.Commit;
      end;
      if chklstTabelle.Checked[5] then
      begin
        EliminaDati(lstTabelle[5].NomeFisicoILO);
        expU145.SetVariable('TABELLA',lstTabelle[5].NomeFisicoILO);
        expU145.SetVariable('ID_UNJSPF',Id_UNJSPF_Aperto);
        try
          expU145.Execute;
        except
          on E:Exception do
            RegistraMsg.InserisciMessaggio('A','Esportazione ' + lstTabelle[5].NomeFisicoILO + ' fallita. ' + E.Message,'',0);
        end;
        SessioneOracle.Commit;
      end;
      if chklstTabelle.Checked[6] then
      begin
        EliminaDati(lstTabelle[6].NomeFisicoILO);
        expU150.SetVariable('TABELLA',lstTabelle[6].NomeFisicoILO);
        expU150.SetVariable('ID_UNJSPF',Id_UNJSPF_Aperto);
        try
          expU150.Execute;
        except
          on E:Exception do
            RegistraMsg.InserisciMessaggio('A','Esportazione ' + lstTabelle[6].NomeFisicoILO + ' fallita. ' + E.Message,'',0);
        end;
        SessioneOracle.Commit;
      end;
      if chklstTabelle.Checked[7] then
      begin
        EliminaDati(lstTabelle[7].NomeFisicoILO);
        expU155.SetVariable('TABELLA',lstTabelle[7].NomeFisicoILO);
        expU155.SetVariable('ID_UNJSPF',Id_UNJSPF_Aperto);
        try
          expU155.Execute;
        except
          on E:Exception do
            RegistraMsg.InserisciMessaggio('A','Esportazione ' + lstTabelle[7].NomeFisicoILO + ' fallita. ' + E.Message,'',0);
        end;
        SessioneOracle.Commit;
      end;
      if chklstTabelle.Checked[8] then
      begin
        EliminaDati(lstTabelle[8].NomeFisicoILO);
        expU160.SetVariable('TABELLA',lstTabelle[8].NomeFisicoILO);
        expU160.SetVariable('ID_UNJSPF',Id_UNJSPF_Aperto);
        try
          expU160.Execute;
        except
          on E:Exception do
            RegistraMsg.InserisciMessaggio('A','Esportazione ' + lstTabelle[8].NomeFisicoILO + ' fallita. ' + E.Message,'',0);
        end;
        SessioneOracle.Commit;
      end;
      if chklstTabelle.Checked[9] then
      begin
        EliminaDati(lstTabelle[9].NomeFisicoILO);
        expU165.SetVariable('TABELLA',lstTabelle[9].NomeFisicoILO);
        expU165.SetVariable('ID_UNJSPF',Id_UNJSPF_Aperto);
        try
          expU165.Execute;
        except
          on E:Exception do
            RegistraMsg.InserisciMessaggio('A','Esportazione ' + lstTabelle[9].NomeFisicoILO + ' fallita. ' + E.Message,'',0);
        end;
        SessioneOracle.Commit;
      end;
      if chklstTabelle.Checked[10] then
      begin
        EliminaDati(lstTabelle[10].NomeFisicoILO);
        expU170.SetVariable('TABELLA',lstTabelle[10].NomeFisicoILO);
        expU170.SetVariable('ID_UNJSPF',Id_UNJSPF_Aperto);
        try
          expU170.Execute;
        except
          on E:Exception do
            RegistraMsg.InserisciMessaggio('A','Esportazione ' + lstTabelle[10].NomeFisicoILO + ' fallita. ' + E.Message,'',0);
        end;
        SessioneOracle.Commit;
      end;
      if chklstTabelle.Checked[11] then
      begin
        EliminaDati(lstTabelle[11].NomeFisicoILO);
        expU175.SetVariable('TABELLA',lstTabelle[11].NomeFisicoILO);
        expU175.SetVariable('ID_UNJSPF',Id_UNJSPF_Aperto);
        try
          expU175.Execute;
        except
          on E:Exception do
            RegistraMsg.InserisciMessaggio('A','Esportazione ' + lstTabelle[11].NomeFisicoILO + ' fallita. ' + E.Message,'',0);
        end;
        SessioneOracle.Commit;
      end;
      if chklstTabelle.Checked[12] then
      begin
        EliminaDati(lstTabelle[12].NomeFisicoILO);
        expU180.SetVariable('TABELLA',lstTabelle[12].NomeFisicoILO);
        expU180.SetVariable('ID_UNJSPF',Id_UNJSPF_Aperto);
        try
          expU180.Execute;
        except
          on E:Exception do
            RegistraMsg.InserisciMessaggio('A','Esportazione ' + lstTabelle[12].NomeFisicoILO + ' fallita. ' + E.Message,'',0);
        end;
        SessioneOracle.Commit;
      end;
    end
    else
    begin
      if chklstTabelle.Checked[0] then
      begin
        EliminaDati(lstTabelle[13].NomeFisicoILO);
        expU190.SetVariable('TABELLA',lstTabelle[13].NomeFisicoILO);
        expU190.SetVariable('ID_UNJSPF',Id_UNJSPF_Aperto);
        try
          expU190.Execute;
          Conta:=expU190.RowsProcessed;
        except
          on E:Exception do
            RegistraMsg.InserisciMessaggio('A','Esportazione ' + lstTabelle[13].NomeFisicoILO + ' fallita. ' + E.Message,'',0);
        end;
        SessioneOracle.Commit;
      end;
    end;
    selU100.Edit;
    selU100.FieldByName('DATA_ESPORTAZIONE').AsDateTime:=StrToDate(edtDataEsportazione.Text);
    selU100.Post;
    SessioneOracle.Commit;
  end;
  Screen.Cursor:=crDefault;
  StatusBar.Panels[1].Text:='';
  if Conta <> -1 then
    R180MessageBox('Elaborazione terminata correttamente. Sono state esportate ' + IntToStr(Conta) + ' righe di ' + IfThen(TipoFlusso = 'HR','Staff member.','Payment.'),INFORMA);
end;

procedure TP288FElaborazioneUnjspf.ChiusuraFornitura;
begin
  Screen.Cursor:=crHourGlass;
  //Chiusura tabelle per i dipendenti selezionati
  with P288FElaborazioneUnjspfDtM do
  begin
    selU100.Edit;
    selU100.FieldByName('CHIUSO').AsString:='S';
    selU100.FieldByName('DATA_CHIUSURA').AsDateTime:=StrToDate(edtDataChiusura.Text);
    selU100.Post;
    SessioneOracle.Commit;
  end;
  Screen.Cursor:=crDefault;
end;

procedure TP288FElaborazioneUnjspf.chkCalcolaClick(Sender: TObject);
var i:Integer;
begin
  chkAnnulla.Enabled:=not chkCalcola.Checked and not chkChiusura.Checked and not chkPulisci.Checked and not chkEsportazione.Checked;
  if not chkAnnulla.Enabled then
    chkAnnulla.Checked:=False;
  chkPulisci.Enabled:=not chkCalcola.Checked and not chkChiusura.Checked and not chkAnnulla.Checked and not chkEsportazione.Checked;
  if not chkPulisci.Enabled then
    chkPulisci.Checked:=False;
  chkChiusura.Enabled:=not chkCalcola.Checked and not chkAnnulla.Checked and not chkPulisci.Checked and not chkEsportazione.Checked;
  if not chkChiusura.Enabled then
    chkChiusura.Checked:=False;
  chkCalcola.Enabled:=not chkAnnulla.Checked and not chkChiusura.Checked and not chkPulisci.Checked and not chkEsportazione.Checked;
  if not chkCalcola.Enabled then
    chkCalcola.Checked:=False;
  chkEsportazione.Enabled:=not chkAnnulla.Checked and not chkChiusura.Checked and not chkPulisci.Checked and not chkCalcola.Checked;
  if not chkEsportazione.Enabled then
    chkEsportazione.Checked:=False;
  lblDataElaborazione.Enabled:=chkCalcola.Checked;
  edtDataElaborazione.Enabled:=chkCalcola.Checked;
  sbtDataElaborazione.Enabled:=chkCalcola.Checked;
  lblDataInizioEstraz.Enabled:=chkCalcola.Checked;
  edtDataInizioEstraz.Enabled:=chkCalcola.Checked;
  sbtDataInizioEstraz.Enabled:=chkCalcola.Checked;
  lblDataChiusura.Enabled:=chkChiusura.Checked;
  edtDataChiusura.Enabled:=chkChiusura.Checked;
  sbtDataChiusura.Enabled:=chkChiusura.Checked;
  lblDataEsportazione.Enabled:=chkEsportazione.Checked;
  edtDataEsportazione.Enabled:=chkEsportazione.Checked;
  sbtDataEsportazione.Enabled:=chkEsportazione.Checked;
  for i:=0 to chklstTabelle.Count - 1 do
    chklstTabelle.Checked[i]:=True;
  chklstTabelle.Enabled:=False;
  btnEsegui.Enabled:=(chkCalcola.Checked or chkAnnulla.Checked or chkChiusura.Checked or chkPulisci.Checked or chkEsportazione.Checked) and (not SolaLettura);
  frmSelAnagrafe.Visible:=chkCalcola.Checked or chkAnnulla.Checked;
end;

procedure TP288FElaborazioneUnjspf.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
  QueryCambio.Free;
end;

procedure TP288FElaborazioneUnjspf.FormShow(Sender: TObject);
var i:Integer;
begin
  if edtMeseElaborazione.Text = '  /    ' then
    edtMeseElaborazione.Text:=FormatDateTime('mm/yyyy', Parametri.DataLavoro);
  if edtDataChiusura.Text = '  /  /    ' then
    edtDataChiusura.Text:=FormatDateTime('dd/mm/yyyy', Parametri.DataLavoro);
  if edtDataEsportazione.Text = '  /  /    ' then
    edtDataEsportazione.Text:=FormatDateTime('dd/mm/yyyy', Parametri.DataLavoro);
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase + ',DATANAS,RTRIM(CONVERT(TRANSLATE(T030.COGNOME,''ñ'',''n''),''US7ASCII'')) COGNOME_PULITO,RTRIM(CONVERT(TRANSLATE(T030.NOME,''ñ'',''n''),''US7ASCII'')) NOME_PULITO';
  C700DataLavoro:=R180FineMese(Parametri.DataLavoro);
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,0,True);
  //Per testare
//  Parametri.Applicazione:='STAGIU';
  TipoFlusso:=IfThen(Parametri.Applicazione = 'STAGIU','HR','FIN');
  chklstTabelle.Clear;
  for i:=0 to High(lstTabelle) do
  begin
    if lstTabelle[i].TipoFlusso = TipoFlusso then
      chklstTabelle.Items.Add(lstTabelle[i].NomeLogico);
  end;
  edtDataInizioEstraz.Text:='01/04/2015';
  edtDataElaborazione.Text:=DateToStr(Parametri.DataLavoro);
  rgpStatoCedolini.Visible:=TipoFlusso = 'FIN';
  chkCalcolaClick(nil);
  QueryCambio:=TQueryCambio.Create(nil);
  QueryCambio.Session:=SessioneOracle;
end;

procedure TP288FElaborazioneUnjspf.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  try
    C700DataLavoro:=StrToDate(edtDataElaborazione.Text);
  except
    C700DataLavoro:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

end.
