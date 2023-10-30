unit A043UDialogStampa;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  A000UMessaggi,
  A000USessione,
  A043UStampaRepMW,
  A083UMsgElaborazioni,
  C001StampaLib,
  C004UParamForm,
  C005UDatiAnagrafici,
  C180FunzioniGenerali,
  C700USelezioneAnagrafe,
  FunzioniGenerali,
  Dialogs, Forms, ComCtrls, StdCtrls, ExtCtrls, Controls,
  DBCtrls, Spin, Buttons, Classes, Windows, SysUtils, DB, Variants, StrUtils,
  SelAnagrafe, QueryStorico, Vcl.Mask, System.DateUtils, System.Diagnostics, InputPeriodo;

type
  TA043FDialogStampa = class(TForm)
    btnPrinterSetUp: TBitBtn;
    btnStampa: TBitBtn;
    btnClose: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    chkSpezzoniMese: TCheckBox;
    chkSalva: TCheckBox;
    chkCumula: TCheckBox;
    lblRaggr: TLabel;
    dcmbCampo: TDBLookupComboBox;
    rgpTipoStampa: TRadioGroup;
    StatusBar: TStatusBar;
    ProgressBar: TProgressBar;
    frmSelAnagrafe: TfrmSelAnagrafe;
    chkSaltoPagina: TCheckBox;
    btnAnomalie: TBitBtn;
    btnSoloAggiornamento: TBitBtn;
    btnAnteprima: TBitBtn;
    chkSoloAnomalie: TCheckBox;
    chkIgnoraAnomalie: TCheckBox;
    frmInputPeriodo: TfrmInputPeriodo;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure chkSalvaClick(Sender: TObject);
    procedure rgpTipoStampaClick(Sender: TObject);
    procedure dcmbCampoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnPrinterSetUpClick(Sender: TObject);
    procedure btnStampaClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure frmInputPeriodoedtInizioExit(Sender: TObject);
    procedure frmInputPeriodoedtFineExit(Sender: TObject);
    procedure frmInputPeriodobtnDataInizioClick(Sender: TObject);
    procedure frmInputPeriodobtnDataFineClick(Sender: TObject);
    procedure frmInputPeriodobtnIndietroClick(Sender: TObject);
    procedure frmInputPeriodobtnAvantiClick(Sender: TObject);
  private
    FCampoRagg: string;
    FNomeCampo:String;
    FTipoStampa: Integer;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ScorriQueryAnagrafica;
    procedure OnPeriodoModificato; {$IFNDEF DEBUG} inline; {$ENDIF !DEBUG}
    function IsMesiInteri(const PDataInizio, PDataFine: TDateTime): Boolean; {$IFNDEF DEBUG} inline; {$ENDIF !DEBUG}

    { Metodi Property }
    function _GetFDataInizio: TDateTime;
    procedure _PutFDataInizio(const Value: TDateTime);
    function _GetFDataFine: TDateTime;
    procedure _PutFDataFine(const Value: TDateTime);

    { Property }
    property FDataInizio:TDateTime read _GetFDataInizio write _PutFDataInizio;
    property FDataFine:TDateTime read _GetFDataFine write _PutFDataFine;
  public
    A043MW: TA043FStampaRepMW;
    SoloAgg: string; // usato dal B028 per richiamo da WA043
  end;

var
  A043FDialogStampa: TA043FDialogStampa;

procedure OpenA043StampaRep(Prog:LongInt);

implementation

uses A043UStampa;

{$R *.DFM}

procedure OpenA043StampaRep(Prog:LongInt);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA043StampaRep') of
    'N':begin
          ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
          Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A043FDialogStampa:=TA043FDialogStampa.Create(nil);
  with A043FDialogStampa do
    try
      C700Progressivo:=Prog;
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      Free;
    end;
end;

procedure TA043FDialogStampa.FormCreate(Sender: TObject);
begin
  A043MW:=TA043FStampaRepMW.Create(Self);
  btnAnomalie.Enabled:=False;
end;

procedure TA043FDialogStampa.FormShow(Sender: TObject);
begin
  A043MW.CodForm:=IfThen(A043MW.TipoModulo = TTipoModuloRec.ClientServer,'A043','WA043');
  A043FStampa:=TA043FStampa.Create(nil);
  CreaC004(SessioneOracle,A043MW.CodForm,Parametri.ProgOper);
  FTipoStampa:=rgpTipoStampa.ItemIndex;

  // il periodo iniziale comprende il mese della data di lavoro
  frmInputPeriodo.DataInizio:=R180InizioMese(Parametri.DataLavoro);
  frmInputPeriodo.DataFine:=R180FineMese(Parametri.DataLavoro);

  GetParametriFunzione;
  OnPeriodoModificato;
  A043MW.A043ProgressBar:=ProgressBar;

  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  C700DataDal:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(A043MW,SessioneOracle,StatusBar,0,False);
  frmSelAnagrafe.SelezionePeriodica:=True;
  chkIgnoraAnomalie.Enabled:=chkSalva.Checked;
end;

procedure TA043FDialogStampa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TA043FDialogStampa.FormDestroy(Sender: TObject);
begin
  A043FStampa.Release;
  frmSelAnagrafe.DistruggiSelAnagrafe;
  A043MW.Free;
end;

procedure TA043FDialogStampa.GetParametriFunzione;
{Leggo i parametri della form}
begin
  rgpTipoStampa.ItemIndex:=StrToInt(C004FParamForm.GetParametro('TIPOSTAMPA','0'));
  chkSpezzoniMese.Checked:=C004FParamForm.GetParametro('SOMMASPEZZONI','N') = 'S';
  chkCumula.Checked:=C004FParamForm.GetParametro('CUMULA','N') = 'S';
  chkSoloAnomalie.Checked:=C004FParamForm.GetParametro('SOLOANOMALIE','N') = 'S';
  dcmbCampo.KeyValue:=C004FParamForm.GetParametro('RAGGRUPPAMENTO',dcmbCampo.Text);
  chkIgnoraAnomalie.Checked:=C004FParamForm.GetParametro('IGNORAANOMALIE','N') = 'S';
  if dcmbCampo.Text = '' then
    dcmbCampo.KeyValue:=null;
  chkSalvaClick(nil);
end;

procedure TA043FDialogStampa.PutParametriFunzione;
{Scrivo i parametri della forma}
begin
  C004FParamForm.Cancella001;
  with A043FDialogStampa do
  begin
    C004FParamForm.PutParametro('TIPOSTAMPA',IntToStr(rgpTipoStampa.ItemIndex));
    if chkSpezzoniMese.Checked then
      C004FParamForm.PutParametro('SOMMASPEZZONI','S')
    else
      C004FParamForm.PutParametro('SOMMASPEZZONI','N');
    if chkCumula.Checked then
      C004FParamForm.PutParametro('CUMULA','S')
    else
      C004FParamForm.PutParametro('CUMULA','N');
    if chkSoloAnomalie.Checked then
      C004FParamForm.PutParametro('SOLOANOMALIE','S')
    else
      C004FParamForm.PutParametro('SOLOANOMALIE','N');
    if chkIgnoraAnomalie.Checked then
      C004FParamForm.PutParametro('IGNORAANOMALIE','S')
    else
      C004FParamForm.PutParametro('IGNORAANOMALIE','N');
    C004FParamForm.PutParametro('RAGGRUPPAMENTO',VarToStr(dcmbCampo.KeyValue));
  end;
  try SessioneOracle.Commit; except end;
end;

procedure TA043FDialogStampa.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  C005DataVisualizzazione:=FDataFine;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA043FDialogStampa.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C700DataDal:=FDataInizio;
  C700DataLavoro:=FDataFine;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;


function TA043FDialogStampa.IsMesiInteri(const PDataInizio, PDataFine: TDateTime): Boolean;
begin
  Result:=(PDataInizio = R180InizioMese(PDataInizio)) and
          (PDataFine = R180FineMese(PDataFine));
end;

procedure TA043FDialogStampa.OnPeriodoModificato;
var
  LDataDa: TDateTime;
  LDataA: TDateTime;
  LMesiInteri: Boolean;
  LPeriodoMese: Boolean;
begin
  LDataDa := FDataInizio;
  LDataA := FDataFine;
  // se le date sono valide verifica che il periodo di elaborazione comprenda mesi interi
  if (LDataDa > 0) and
     (LDataA > 0) then
  begin
    LMesiInteri:=IsMesiInteri(LDataDa,LDataA);
    LPeriodoMese:=R180Between(LDataA,R180InizioMese(LDataDa),R180FineMese(LDataDa));
  end
  else
  begin
    LMesiInteri:=False;
    LPeriodoMese:=False;
  end;

  // anteprima e stampa abilitate se il periodo è inferiore o uguale a un mese
  btnAnteprima.Enabled:=LPeriodoMese;
  btnStampa.Enabled:=LPeriodoMese;

  // aggiornamento riepilogo abilitato se il periodo è di mesi interi
  chkSalva.Enabled:=(not SolaLettura) and LMesiInteri;
  if not chkSalva.Enabled then
    chkSalva.Checked:=False;

  chkSalvaClick(nil);
end;

procedure TA043FDialogStampa.chkSalvaClick(Sender: TObject);
begin
  btnSoloAggiornamento.Enabled:=chkSalva.Enabled and chkSalva.Checked;
  chkIgnoraAnomalie.Enabled:=chkSalva.Checked;
end;

procedure TA043FDialogStampa.rgpTipoStampaClick(Sender: TObject);
begin
  FTipoStampa:=rgpTipoStampa.ItemIndex;
  chkSoloAnomalie.Enabled:=(FTipoStampa = 0);
  if not chkSoloAnomalie.Enabled then
    chkSoloAnomalie.Checked:=False;
end;

procedure TA043FDialogStampa.dcmbCampoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA043FDialogStampa.btnPrinterSetUpClick(Sender: TObject);
begin
  if PrinterSetUpDialog1.Execute then
    C001SettaQuickReport(A043FStampa.RepR);
end;

procedure TA043FDialogStampa.btnStampaClick(Sender: TObject);
var
  S: String;
  LMesiInteri: Boolean;
  LData: TDateTime;
  LFinePeriodo: TDateTime;
  LStopwatch: TStopwatch;
begin
  // selezione anagrafica
  if A043MW.TipoModulo = TTipoModuloRec.COM then
  begin
    // se la stampa è da B028 apre la selezione anagrafica
    if not C700SelAnagrafe.Active then
      C700SelAnagrafe.Open;
  end
  else
  begin
    // verifica selezione anagrafica
    if C700SelAnagrafe.RecordCount = 0 then
    begin
      R180MessageBox(A000MSG_ERR_NO_DIP, ESCLAMA);
      Exit;
    end;
  end;

  // in caso di elaborazione win verifica il periodo
  if A043MW.TipoModulo = TTipoModuloRec.ClientServer then
  begin
    if FDataInizio > FDataFine then
    begin
      R180MessageBox(A000MSG_ERR_DATE_INVERTITE, ESCLAMA);
      Exit;
    end;
  end;

  // indica se il periodo comprende mesi interi (1+)
  LMesiInteri:=IsMesiInteri(FDataInizio,FDataFine);

  // inizializzazioni
  if A043MW.TipoModulo = TTipoModuloRec.ClientServer then
  begin
    Screen.Cursor:=crHourGlass;
    Self.Enabled:=False;
    btnAnomalie.Enabled:=False;
    // imposta la progressbar
    // NOTA:
    //   in caso di più mesi il valore è indicativo, perché il numero di dipendenti può variare
    ProgressBar.Position:=0;
    ProgressBar.Max:=Trunc(FDataFine - FDataInizio + 1) * C700SelAnagrafe.RecordCount;
    // reset statusbar
    StatusBar.Panels[1].Text:='';
    StatusBar.Repaint;
  end;

  // avvia il timer di precisione
  LStopwatch:=TStopwatch.StartNew;

  try
    RegistraMsg.IniziaMessaggio(A043MW.CodForm);
    RegistraMsg.InserisciMessaggio('I',Format('Inizio elaborazione cartolina reperibilità%s',[IfThen(chkSalva.Checked, ' con aggiornamento del riepilogo')]),Parametri.Azienda);

    // gestione di diversi tipi di periodo:
    // - inferiore al mese
    // - mese intero
    // - n > 1 mesi interi
    LData:=FDataInizio;
    while LData <= FDataFine do
    begin
      A043MW.AzzeraContatori;

      // aggiorna
      StatusBar.Panels[1].Text:=Format('Elaborazione di %s in corso...',[LData.ToString('mmmm yyyy')]);
      StatusBar.Repaint;

      // determina la data di fine periodo
      if LMesiInteri then
        LFinePeriodo:=R180FineMese(LData)
      else
        LFinePeriodo:=FDataFine;

      // chiude dataset per verifica blocco riepiloghi
      A043MW.selDatiBloccati.Close;

      // impostazioni della selezione anagrafica
      if frmSelAnagrafe.SettaPeriodoSelAnagrafe(LData,LFinePeriodo) then // FDataInizio, FDataFine
        C700SelAnagrafe.CloseAll;
      //Caratto 04/03/2014 mail nando oggetto R: Erorre su IrisCloud del 04/032014
      //Se arrivo da B028 con campo non impostato keyvalue ='' e non null
      if (dcmbCampo.KeyValue <> Null) and (dcmbCampo.KeyValue <> '') then
      begin
        FCampoRagg:=dcmbCampo.KeyValue;
        FNomeCampo:=dcmbCampo.Text;
        S:=C700SelAnagrafe.SQL.Text;
        if R180InserisciColonna(S,AliasTabella(A043MW.selI010.FieldByName('Nome_Campo').AsString)+'.'+dcmbCampo.KeyValue) then
        begin
          C700SelAnagrafe.CloseAll;
          C700SelAnagrafe.SQL.Text:=S;
        end;
      end
      else
      begin
        FCampoRagg:='';
        FNomeCampo:='';
      end;

      // imposta variabili middleware
      A043MW.A043chkCumula:=chkCumula.Checked;
      A043MW.A043chkSpezzoniMese:=chkSpezzoniMese.Checked;
      A043MW.A043ChkIgnoraAnomalie:=chkIgnoraAnomalie.Checked;
      A043MW.A043DataI:=LData; //FDataInizio;
      A043MW.A043DataF:=LFinePeriodo; //FDataFine;
      A043MW.A043CampoRagg:=FCampoRagg;
      if SolaLettura then
        chkSalva.Checked:=False;
      A043MW.SalvaDatiTurni:=chkSalva.Checked and chkSalva.Enabled;

      // prepara il dataset per la stampa e aggiunge i record dei dipendenti per il periodo
      A043MW.CreaTabellaStampa;
      C700SelAnagrafe.Open;
      ScorriQueryAnagrafica;

      // se l'elaborazione è stata interrotta esce dal ciclo
      if frmSelAnagrafe.ElaborazioneInterrotta then
        Break;

      // verifica se è necessario aggiornare i riepiloghi su database
      if A043MW.SalvaDatiTurni or chkSoloAnomalie.Checked then
        A043MW.CalcolaRiepiloghi;

      // passa al mese successivo
      LData:=R180AddMesi(LData, 1);
    end;

    // ferma il timer di precisione
    LStopwatch.Stop;

    if A043MW.TipoModulo = TTipoModuloRec.ClientServer then
    begin
      // porta la progressbar al 100%
      ProgressBar.Position:=ProgressBar.Max;
      ProgressBar.Repaint;
      // pulisce il pannello di info della statusbar
      StatusBar.Panels[1].Text:='';
      StatusBar.Repaint;

      // verifica esito elaborazione
      btnAnomalie.Enabled:=RegistraMsg.ContieneAnomalie;

      if frmSelAnagrafe.ElaborazioneInterrotta then
      begin
        R180MessageBox(A000MSG_MSG_ELABORAZIONE_INTERROTTA, ESCLAMA);
      end
      else
      begin
        if RegistraMsg.ContieneAnomalie then
        begin
          if (R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,DOMANDA) = mrYes) then
            btnAnomalieClick(nil);
        end
        else if Sender = btnSoloAggiornamento then
        begin
          R180MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA,INFORMA);
        end;
      end;
    end;

    // generazione del report
    if Sender <> btnSoloAggiornamento then
    begin
      Screen.Cursor:=crDefault;

      // effettua la stampa
      A043FStampa.CampoRagg:=FCampoRagg;
      A043FStampa.NomeCampo:=FNomeCampo;
      A043FStampa.TipoStampa:=FTipoStampa;
      A043FStampa.CreaReport(Sender = btnAnteprima);
    end;
  finally
    RegistraMsg.InserisciMessaggio('I','Fine elaborazione',Parametri.Azienda);

    if A043MW.TipoModulo = TTipoModuloRec.ClientServer then
    begin
      Self.Enabled:=True;

      // reimposta progressbar
      ProgressBar.Position:=0;
      ProgressBar.Repaint;

      // riposizionamento su prima anagrafica
      C700SelAnagrafe.First;

      // ferma il timer di precisione
      LStopwatch.Stop;
      StatusBar.Panels[1].Text:='Tempo di esecuzione: ' + FormatDateTime(FMT_DURATA_ELABORAZIONE,LStopWatch.ElapsedMilliseconds / MSecsPerDay);
      StatusBar.Repaint;

      Screen.Cursor:=crDefault;
    end;
  end;
end;

procedure TA043FDialogStampa.ScorriQueryAnagrafica;
// ciclo sulla selezione anagrafica per calcolare il riepilogo del mese corrente
begin
  C700SelAnagrafe.First;
  frmSelAnagrafe.ElaborazioneInterrompibile:=True;
  try
    while not C700SelAnagrafe.Eof  do
    begin
      // riporta il nominativo nella barra delle anagrafiche
      frmSelAnagrafe.VisualizzaDipendente;

      // elabora il progressivo corrente
      A043MW.ElaboraElemento(C700Progressivo);

      // gestione anagrafica successiva
      C700SelAnagrafe.Next;
    end;
  finally
    frmSelAnagrafe.ElaborazioneInterrompibile:=False;
    frmSelAnagrafe.VisualizzaDipendente;
  end;
end;

procedure TA043FDialogStampa.btnAnomalieClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,A043MW.CodForm,'');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A043MW);

  //Ricreo la form di stampa, altrimenti vengono persi i filtri di esportazione
  FreeAndNil(A043FStampa);
  A043FStampa:=TA043FStampa.Create(nil);
end;

{ FDataFine }
function TA043FDialogStampa._GetFDataFine: TDateTime;
begin
  Result := frmInputPeriodo.DataFine;
end;

procedure TA043FDialogStampa._PutFDataFine(const Value: TDateTime);
begin
  frmInputPeriodo.DataFine := Value;
end;
{ ---- FDataFine }

{ FDataInizio }
function TA043FDialogStampa._GetFDataInizio: TDateTime;
begin
  Result := frmInputPeriodo.DataInizio;
end;

procedure TA043FDialogStampa._PutFDataInizio(const Value: TDateTime);
begin
  frmInputPeriodo.DataInizio := Value;
end;
{ ---- FDataInizio }

procedure TA043FDialogStampa.frmInputPeriodobtnAvantiClick(Sender: TObject);
begin
  frmInputPeriodo.btnAvantiClick(Sender);
  OnPeriodoModificato;
end;

procedure TA043FDialogStampa.frmInputPeriodobtnDataFineClick(Sender: TObject);
begin
  frmInputPeriodo.btnDataFineClick(Sender);
  OnPeriodoModificato;
end;

procedure TA043FDialogStampa.frmInputPeriodobtnDataInizioClick(Sender: TObject);
begin
  frmInputPeriodo.btnDataInizioClick(Sender);
  OnPeriodoModificato;
end;

procedure TA043FDialogStampa.frmInputPeriodobtnIndietroClick(Sender: TObject);
begin
  frmInputPeriodo.btnIndietroClick(Sender);
  OnPeriodoModificato;
end;

procedure TA043FDialogStampa.frmInputPeriodoedtFineExit(Sender: TObject);
begin
  // gestione modifica periodo
  OnPeriodoModificato;
end;

procedure TA043FDialogStampa.frmInputPeriodoedtInizioExit(Sender: TObject);
begin
  frmInputPeriodo.edtInizioExit(Sender);

  // gestione modifica periodo
  OnPeriodoModificato;
end;

end.
