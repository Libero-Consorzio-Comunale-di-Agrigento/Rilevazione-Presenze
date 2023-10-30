unit A091ULiquidPresenze;

interface

uses
  A000UCostanti,
  A000UMessaggi,
  A000USessione,
  A000UInterfaccia,
  A083UMsgElaborazioni,
  A091ULiquidPresenzeMW,
  DatiBloccati,
  FunzioniGenerali,
  C001StampaLib,
  C004UParamForm,
  C005UDatiAnagrafici,
  C013UCheckList,
  C180FunzioniGenerali,
  C700USelezioneAnagrafe,
  QueryStorico,
  R450,
  SelAnagrafe,
  Oracle,
  OracleData,
  USelI010,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, DBCtrls, StdCtrls, Spin, Grids, DBGrids, ExtCtrls, DB,
  ComCtrls, Mask, RegistrazioneLog, Menus, Variants, Math, StrUtils,
  Vcl.CheckLst, System.DateUtils, System.Diagnostics, Datasnap.DBClient;

type
  TA091FLiquidPresenze = class(TForm)
    StatusBar: TStatusBar;
    ProgressBar: TProgressBar;
    Panel1: TPanel;
    PrinterSetupDialog1: TPrinterSetupDialog;
    Panel2: TPanel;
    grpDettaglio: TGroupBox;
    grpIntestazione: TGroupBox;
    Intestazione: TCheckListBox;
    Dettaglio: TCheckListBox;
    Label1: TLabel;
    sedtAnno: TSpinEdit;
    grpLiquidazione: TGroupBox;
    Label3: TLabel;
    edtArrotLiq: TMaskEdit;
    Label4: TLabel;
    edtMaxLiq: TMaskEdit;
    grpCompensazione: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    edtArrotComp: TMaskEdit;
    edtMaxComp: TMaskEdit;
    lblCausale: TLabel;
    frmSelAnagrafe: TfrmSelAnagrafe;
    rgpDisponibilita: TRadioGroup;
    btnCausale: TBitBtn;
    edtCausale: TEdit;
    lblMeseDa: TLabel;
    cmbMeseDa: TComboBox;
    lblMeseA: TLabel;
    cmbMeseA: TComboBox;
    lblMessaggio: TLabel;
    chkAggiornamento: TCheckBox;
    chkLiquidazioni: TCheckBox;
    chkCompensazioni: TCheckBox;
    chkSaltoPagina: TCheckBox;
    chkTotaliRaggr: TCheckBox;
    chkTotaliGenerali: TCheckBox;
    chkAnnullaLiquidazione: TCheckBox;
    btnPrinterSetUp: TBitBtn;
    btnAnteprima: TBitBtn;
    btnStampa: TBitBtn;
    btnSoloAggiornamento: TBitBtn;
    btnAnomalie: TBitBtn;
    btnChiudi: TBitBtn;
    procedure btnCausaleClick(Sender: TObject);
    procedure dcmbCausaleKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnPrinterSetUpClick(Sender: TObject);
    procedure btnStampaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure chkAggiornamentoClick(Sender: TObject);
    procedure IntestazioneMouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
    procedure IntestazioneMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DettaglioMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DettaglioMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure edtMaxLiqExit(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure cmbMeseDaChange(Sender: TObject);
    procedure cmbMeseAChange(Sender: TObject);
    procedure sedtAnnoChange(Sender: TObject);
    procedure chkAnnullaLiquidazioneClick(Sender: TObject);
    procedure chkLiquidazioniClick(Sender: TObject);
    procedure chkCompensazioniClick(Sender: TObject);
  private
    FItemCB:Integer;
    FLstCausali: TStringList;
    FDataUltimaLiquidazione: TDateTime;

    FMeseInizio: TDateTime;
    FMeseFine: TDateTime;
    FElencoCausali: string;

    procedure SetDataUltimaLiquidazione(const Value: TDateTime);
    procedure AggiungiCampiIntestazioneDettaglioSelAnag;
    procedure ScorriQueryAnagrafica(const PMese: TDateTime);
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure OnCambiaProgressivo;
    procedure OnImpostazioniModificate; {$IFNDEF DEBUG} inline; {$ENDIF !DEBUG}
    procedure OnPeriodoModificato; {$IFNDEF DEBUG} inline; {$ENDIF !DEBUG}
    function IsAnnullaLiq: Boolean; inline;
  public
    A091MW: TA091FLiquidPresenzeMW;
    SolaLettura: Boolean;
    property MeseInizio: TDateTime read FMeseInizio;
    property DataUltimaLiquidazione: TDateTime read FDataUltimaLiquidazione write SetDataUltimaLiquidazione;
  end;

var
  A091FLiquidPresenze: TA091FLiquidPresenze;

procedure OpenA091LiquidPresenze(Prog:LongInt);

implementation

uses
  A029UBudgetDtM1,
  A029ULiquidazione,
  A091UStampa,
  A091ULiquidPresenzeDtM1;

{$R *.DFM}

procedure OpenA091LiquidPresenze(Prog:LongInt);
{Liquidazione/Compensazione ore causalizzate escluse dalle normali}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA091LiquidPresenze') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A091FLiquidPresenze:=TA091FLiquidPresenze.Create(nil);
  A091FLiquidPresenze.SolaLettura:=SolaLettura;
  with A091FLiquidPresenze do
    try
      C700Progressivo:=Prog;
      A091FLiquidPresenzeDtM1:=TA091FLiquidPresenzeDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A091FLiquidPresenzeDtM1.Free;
      Free;
    end;
end;

procedure TA091FLiquidPresenze.FormCreate(Sender: TObject);
begin
  //caratto 07/05/2013 rimozione variabili globali. A029FBudgetDtM1:=TA029FBudgetDtM1.Create(nil);
  A091FStampa:=TA091FStampa.Create(nil);
  SolaLettura:=False;
  FItemCB:=-1;
  Constraints.MinWidth:=Width;
  Constraints.MaxWidth:=Width;

  btnAnomalie.Enabled:=False;
end;

procedure TA091FLiquidPresenze.FormShow(Sender: TObject);
var
  i: Integer;
  LMese: Integer;
  LDS: TDataSet;
begin
  // imposta un riferimento al middleware per comodità
  A091MW:=A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW;

  CreaC004(SessioneOracle,'A091',Parametri.ProgOper);
  GetParametriFunzione;

  // imposta come periodo di riferimento il mese della data lavoro
  sedtAnno.OnChange:=nil;
  try
    sedtAnno.Value:=Parametri.DataLavoro.Year;
  finally
    sedtAnno.OnChange:=sedtAnnoChange;
  end;

  LMese:=Parametri.DataLavoro.Month;
  cmbMeseDa.OnChange:=nil;
  try
    cmbMeseDa.ItemIndex:=LMese - 1;
  finally
    cmbMeseDa.OnChange:=cmbMeseDaChange;
  end;

  cmbMeseA.OnChange:=nil;
  try
    cmbMeseA.ItemIndex:=LMese - 1;
  finally
    cmbMeseA.OnChange:=cmbMeseAChange;
  end;

  // impostazioni iniziali interfaccia
  chkAggiornamento.Enabled:=not SolaLettura;
  btnSoloAggiornamento.Enabled:=chkAggiornamento.Checked;

  // prepara selezione anagrafica
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  C700DataDal:=Parametri.DataLavoro;

// Assert(A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW = A091MW,'Middleware non corretto');

  frmSelAnagrafe.OnCambiaProgressivo:=OnCambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(A091MW,SessioneOracle,StatusBar,0,False);
  frmSelAnagrafe.SelezionePeriodica:=True;

  // imposta l'oggetto C700SelAnagrafe sul middleware
  A091MW.SelAnagrafe:=C700SelAnagrafe;

  // carica elementi per stampa: intestazione e dettaglio
  for i:=0 to A091MW.LstCampiAnagrafe.Count - 1 do
  begin
    Intestazione.Items.Add(A091MW.LstCampiAnagrafe[i]);
    Dettaglio.Items.Add(A091MW.LstCampiAnagrafe[i]);
  end;
  A091FStampa.SettaDataset;

  // Carico la lista delle causali da elaborare
  LDS:=A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.selT275;
  FLstCausali:=TStringList.Create;
  C013FCheckList:=TC013FCheckList.Create(nil);
  try
    LDS.First;
    C013FCheckList.clbListaDati.Items.Clear;
    while not LDS.Eof do
    begin
      C013FCheckList.clbListaDati.Items.Add(LDS.FieldByName('CODICE').AsString);
      LDS.Next;
    end;
    R180PutCheckList(edtCausale.Text,5,C013FCheckList.clbListaDati);
    edtCausale.Text:=R180GetCheckList(5,C013FCheckList.clbListaDati);
    FLstCausali.CommaText:=edtCausale.Text;
    FElencoCausali:=FLstCausali.CommaText;
  finally
    FreeAndNil(C013FCheckList);
  end;

  // forza impostazioni form
  OnPeriodoModificato;
end;

procedure TA091FLiquidPresenze.OnPeriodoModificato;
begin
  // determina i mesi di riferimento
  FMeseInizio:=EncodeDate(sedtAnno.Value,cmbMeseDa.ItemIndex + 1,1);
  FMeseFine:=EncodeDate(sedtAnno.Value,cmbMeseA.ItemIndex + 1,1);

  // gestione modifica impostazioni
  OnImpostazioniModificate;
end;

procedure TA091FLiquidPresenze.OnCambiaProgressivo;
begin
  OnImpostazioniModificate;
end;

procedure TA091FLiquidPresenze.OnImpostazioniModificate;
var
  LIsMeseSingolo: Boolean;
  LAnnullaLiq: Boolean;
  LAnnullamentoConsentito: Boolean;
begin
  // determina se il periodo è di un singolo mese
  LIsMeseSingolo:=(FMeseInizio = FMeseFine);

  // impostazioni opzioni
  chkAggiornamento.Enabled:=not SolaLettura;
  if not chkAggiornamento.Enabled then
    chkAggiornamento.Checked:=False;

  // annullamento liquidazione
  chkAnnullaLiquidazione.Enabled:=not SolaLettura;
  if not chkAnnullaLiquidazione.Enabled then
    chkAnnullaLiquidazione.Checked:=False;

  // abilita l'opzione di annullamento liquidazioni
  chkLiquidazioni.Enabled:=chkAnnullaLiquidazione.Checked;
  if not chkLiquidazioni.Enabled then
    chkLiquidazioni.Checked:=False;
  // abilita l'opzione di annullamento compensazioni
  chkCompensazioni.Enabled:=chkAnnullaLiquidazione.Checked;
  if not chkCompensazioni.Enabled then
    chkCompensazioni.Checked:=False;

  if IsAnnullaLiq then
  begin
    // determina la data dell'ultimo mese da annullare
    Screen.Cursor:=crHourGlass;
    try
      FDataUltimaLiquidazione:=A091MW.GetDataUltimaLiquidazioneAnno(FMeseInizio,FElencoCausali,chkLiquidazioni.Checked,chkCompensazioni.Checked);
    finally
      Screen.Cursor:=crDefault;
    end;
  end
  else
    FDataUltimaLiquidazione:=DATE_NULL;

  // visualizza data ultima liquidazione
  LAnnullaLiq:=IsAnnullaLiq;
  LAnnullamentoConsentito:=LAnnullaLiq and (R180Between(FDataUltimaLiquidazione,FMeseInizio,FMeseFine));
  lblMessaggio.Visible:=LAnnullaLiq;
  if lblMessaggio.Visible then
  begin
    // messaggio in base al caso
    if FDataUltimaLiquidazione = DATE_NULL then
      lblMessaggio.Caption:=Format(A000MSG_A091_DLG_FMT_NO_LIQ_ANNO,[FMeseInizio.Year])
    else if R180Between(FDataUltimaLiquidazione,FMeseInizio,FMeseFine) then
      lblMessaggio.Caption:=Format(A000MSG_A091_DLG_FMT_ULTIMA_LIQ_PERIODO,[FDataUltimaLiquidazione.ToString('mmmm yyyy')])
    else
      lblMessaggio.Caption:=Format(A000MSG_A091_DLG_FMT_ULTIMA_LIQ_ANNO,[FDataUltimaLiquidazione.ToString('mmmm yyyy')])
  end;

  // abilitazione pulsante "solo aggiornamento"
  btnSoloAggiornamento.Enabled:=(chkAggiornamento.Checked or LAnnullamentoConsentito);
  if chkAnnullaLiquidazione.Checked then
  begin
    btnSoloAggiornamento.Caption:='Esegui';
    //btnSoloAggiornamento.Glyph....
  end
  else
  begin
    btnSoloAggiornamento.Caption:='Solo aggiornamento';
    //btnSoloAggiornamento.Glyph....
  end;

  // anteprima e stampa abilitate se non si tratta di annullamento ed il periodo è inferiore o uguale a un mese
  btnAnteprima.Enabled:=not chkAnnullaLiquidazione.Checked and LIsMeseSingolo;
  btnStampa.Enabled:=not chkAnnullaLiquidazione.Checked and LIsMeseSingolo;
end;

procedure TA091FLiquidPresenze.btnPrinterSetUpClick(Sender: TObject);
begin
  if PrinterSetUpDialog1.Execute then
    C001SettaQuickReport(A091FStampa.RepR);
end;

procedure TA091FLiquidPresenze.sedtAnnoChange(Sender: TObject);
begin
  OnPeriodoModificato;
end;

procedure TA091FLiquidPresenze.SetDataUltimaLiquidazione(const Value: TDateTime);
begin
  FDataUltimaLiquidazione:=Value;
end;

procedure TA091FLiquidPresenze.AggiungiCampiIntestazioneDettaglioSelAnag;
// modifica selezione anagrafica per includere campi di intestazione e dettaglio
var
  LstIntestazione: TStringList;
  LstDettaglio: TStringList;
  S: string;
  i: Integer;
begin
  LstIntestazione:=TStringList.Create;
  LstDettaglio:=TStringList.Create;
  try
    for i:=0 to Intestazione.Items.Count - 1 do
      if Intestazione.Checked[i] then
        LstIntestazione.Add(Intestazione.Items[i]);

    for i:=0 to Dettaglio.Items.Count - 1 do
      if Dettaglio.Checked[i] then
        LstDettaglio.Add(Dettaglio.Items[i]);

    S:=A091MW.SettaIntestazioneDettaglio(C700SelAnagrafe.SQL.Text, LstIntestazione, LstDettaglio);
    if S <> '' then
    begin
      C700SelAnagrafe.CloseAll;
      C700SelAnagrafe.SQL.Text:=S;
    end;
  finally
    FreeAndNil(LstIntestazione);
    FreeAndNil(LstDettaglio);
  end;
end;

function TA091FLiquidPresenze.IsAnnullaLiq: Boolean;
begin
  Result:=(chkAnnullaLiquidazione.Checked and (chkLiquidazioni.Checked or chkCompensazioni.Checked));
end;

procedure TA091FLiquidPresenze.ScorriQueryAnagrafica(const PMese: TDateTime);
begin
  // conteggi in caso di stampa o aggiornamento riepilogo
  if not IsAnnullaLiq then
  begin
    //Alberto 24/02/2006: Inizializzo i conteggi
    A091MW.R450DtM1.ConteggiMese('Generico', PMese.Year, PMese.Month, 0);
  end;

  C700SelAnagrafe.First;
  frmSelAnagrafe.ElaborazioneInterrompibile:=(A091MW.TipoModulo = TTipoModuloRec.ClientServer);
  try
    while not C700SelAnagrafe.Eof do
    begin
      if A091MW.TipoModulo = TTipoModuloRec.ClientServer then
      begin
        frmSelAnagrafe.VisualizzaDipendente;
        ProgressBar.StepIt;
        ProgressBar.Repaint;
      end;

      // elabora il singolo dipendente
      if IsAnnullaLiq then
      begin
        // annulla la liquidazione del mese per le causali selezionate
        A091MW.AnnullaLiquidazione(PMese, FElencoCausali);
      end
      else
      begin
        // calcola e/o aggiorna il riepilogo del mese per le causali selezionate
        A091MW.ElaboraDipendente(FLstCausali,
          PMese.Year,
          PMese.Month,
          R180OreMinutiExt(edtMaxLiq.Text),
          StrToIntDef(Trim(edtArrotLiq.Text),0),
          R180OreMinutiExt(edtMaxComp.Text),
          StrToIntDef(Trim(edtArrotComp.Text),0),
          rgpDisponibilita.ItemIndex,
          chkAggiornamento.Checked
        );
      end;

      C700SelAnagrafe.Next;
    end;
  finally
    if A091MW.TipoModulo = TTipoModuloRec.ClientServer then
    begin
      frmSelAnagrafe.ElaborazioneInterrompibile:=False;
      frmSelAnagrafe.VisualizzaDipendente;
    end;
  end;
end;

procedure TA091FLiquidPresenze.btnStampaClick(Sender: TObject);
var
  i,L: Integer;
  LMese: TDateTime;
  S: String;
  LUltimoMese: TDateTime;
  LAnnullaLiq: Boolean;
  LMsg: string;
  LStopwatch: TStopwatch;
begin
  // se la stampa è da B028 forza l'allineamento dei dati con quanto presente nella UI
  if A091MW.TipoModulo = TTipoModuloRec.COM then
  begin
    OnImpostazioniModificate;
  end;

  // determina se l'operazione richiesta è quella di annullamento delle liquidazioni
  LAnnullaLiq:=IsAnnullaLiq;

  // selezione anagrafica
  if A091MW.TipoModulo = TTipoModuloRec.COM then
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

    // verifica indicazione causale
    if edtCausale.Text = '' then
    begin
      R180MessageBox(A000MSG_A091_ERR_NO_CAUSALE, ESCLAMA);
      Exit;
    end;

    // conferma in caso di annullamento
    if LAnnullaLiq then
    begin
      if FMeseInizio = FDataUltimaLiquidazione then
        LMsg:=Format(A000MSG_A091_DLG_FMT_CONF_ANNULLA_LIQ_1,[FDataUltimaLiquidazione.ToString('mmmm yyyy')])
      else
        LMsg:=Format(A000MSG_A091_DLG_FMT_CONF_ANNULLA_LIQ_N,[FMeseInizio.ToString('mmmm'),FDataUltimaLiquidazione.ToString('mmmm yyyy')]);
      if R180MessageBox(LMsg, DOMANDA) = mrNo then
        Exit;
    end;
  end;

  // inizializzazioni
  if A091MW.TipoModulo = TTipoModuloRec.ClientServer then
  begin
    Screen.Cursor:=crHourGlass;
    Self.Enabled:=False;
    btnAnomalie.Enabled:=False;
    // imposta la progressbar
    // PRE: date appartenenti allo stesso anno
    ProgressBar.Position:=0;
    ProgressBar.Max:=(FMeseFine.Month - FMeseInizio.Month + 1) * C700SelAnagrafe.RecordCount;
    // reset statusbar
    StatusBar.Panels[1].Text:='';
    StatusBar.Repaint;
  end;

  // avvia il timer di precisione
  LStopwatch:=TStopwatch.StartNew;

  try
    RegistraMsg.IniziaMessaggio('A091');

    if LAnnullaLiq then
    begin
      LMsg:=Format('Inizio annullamento liquidazioni nel periodo %s - %s',[FMeseInizio.ToString('mmmm yyyy'),FDataUltimaLiquidazione.ToString('mmmm yyyy')]);
      RegistraMsg.InserisciMessaggio('I',LMsg,Parametri.Azienda);

      // ciclo di elaborazione per ogni liquidazione presente nel periodo
      LMese:=FDataUltimaLiquidazione;
      while (LMese <> DATE_NULL) and (LMese >= FMeseInizio) do
      begin
        if A091MW.TipoModulo = TTipoModuloRec.ClientServer then
        begin
          StatusBar.Panels[1].Text:=Format('Annullamento di %s...',[LMese.ToString('mmmm yyyy')]);
          StatusBar.Repaint;
        end;

        // imposta le strutture dati per l'annullamento delle liquidazioni
        A091MW.ImpostaVarAnnulla(LMese, FElencoCausali, chkLiquidazioni.Checked, chkCompensazioni.Checked);

        // chiude dataset per verifica blocco riepiloghi
        A091MW.InizializzaDatiBloccati;

        // impostazioni della selezione anagrafica
        if frmSelAnagrafe.SettaPeriodoSelAnagrafe(R180InizioMese(LMese),R180FineMese(LMese)) then
          C700SelAnagrafe.CloseAll;
        C700SelAnagrafe.Open;

        // effettua ciclo sui dipendenti per l'elaborazione
        ScorriQueryAnagrafica(LMese);

        // se l'elaborazione è stata interrotta esce dal ciclo
        if frmSelAnagrafe.ElaborazioneInterrotta then
          Break;

        // calcola il fruito e aggiorna il budget per il mese
        A091MW.PreparaAggiornaFruitoBudget(LMese);

        // cerca l'ultima liquidazione dell'anno
        LMese:=A091MW.GetDataUltimaLiquidazioneAnno(FMeseInizio,FElencoCausali,chkLiquidazioni.Checked,chkCompensazioni.Checked);
      end;
    end
    else
    begin
      LMsg:=Format('Inizio elaborazione liquidazione %s(disponibilità %s) nel periodo %s - %s',
                   [IfThen(chkAggiornamento.Checked, 'con aggiornamento del riepilogo '),
                    IfThen(rgpDisponibilita.ItemIndex = 0, 'mensile', 'annuale'),
                    FMeseInizio.ToString('mmmm yyyy'),
                    FMeseFine.ToString('mmmm yyyy')]);
      RegistraMsg.InserisciMessaggio('I',LMsg,Parametri.Azienda);

      // modifica selezione anagrafica per includere campi di intestazione e dettaglio (per la stampa)
      AggiungiCampiIntestazioneDettaglioSelAnag;

      // imposta i mesi di riferimento
      LMese:=FMeseInizio;
      LUltimoMese:=FMeseFine;

      // ciclo di elaborazione per ogni mese
      while LMese <= LUltimoMese do
      begin
        if A091MW.TipoModulo = TTipoModuloRec.ClientServer then
        begin
          StatusBar.Panels[1].Text:=Format('Elaborazione di %s...',[LMese.ToString('mmmm yyyy')]);
          StatusBar.Repaint;
        end;

        // chiude dataset per verifica blocco riepiloghi
        A091MW.InizializzaDatiBloccati;

        // impostazioni della selezione anagrafica
        if frmSelAnagrafe.SettaPeriodoSelAnagrafe(R180InizioMese(LMese),R180FineMese(LMese)) then
          C700SelAnagrafe.CloseAll;
        C700SelAnagrafe.Open;

        // prepara il clientdataset per la stampa
        A091MW.CreaTabellaStampa;

        // effettua ciclo sui dipendenti per l'elaborazione
        ScorriQueryAnagrafica(LMese);

        // se l'elaborazione è stata interrotta esce dal ciclo
        if frmSelAnagrafe.ElaborazioneInterrotta then
          Break;

        // calcola il fruito e aggiorna il budget per il mese
        A091MW.PreparaAggiornaFruitoBudget(LMese);

        // passa al mese successivo
        LMese:=R180AddMesi(LMese, 1);
      end;
    end;

    // ferma il timer di precisione
    LStopwatch.Stop;

    // esito elaborazione
    if A091MW.TipoModulo = TTipoModuloRec.ClientServer then
    begin
      // porta la progressbar al 100%
      ProgressBar.Position:=ProgressBar.Max;
      ProgressBar.Repaint;
      // pulisce il pannello di info della statusbar
      StatusBar.Panels[1].Text:='';
      StatusBar.Repaint;

      // abilita il pulsante delle anomalie
      btnAnomalie.Enabled:=RegistraMsg.ContieneAnomalie;

      // segnala esito elaborazione con messaggio in caso di solo aggiornamento
      if Sender = btnSoloAggiornamento then
      begin
        if frmSelAnagrafe.ElaborazioneInterrotta then
        begin
          R180MessageBox(A000MSG_MSG_ELABORAZIONE_INTERROTTA, ESCLAMA);
        end
        else
        begin
          if btnAnomalie.Enabled then
          begin
            if R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,DOMANDA) = mrYes then
              btnAnomalieClick(nil);
          end
          else
            R180MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA,INFORMA);
        end;
      end;
    end;

    // generazione del report
    if Sender <> btnSoloAggiornamento then
    begin
      RegistraMsg.InserisciMessaggio('I','Inizio generazione del report',Parametri.Azienda);

      // avvia il timer di precisione
      LStopwatch.Start;

      A091FStampa.QRGroup1.Expression:='';
      A091FStampa.QRGroup1.Enabled:=False;

      for i:=0 to A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.INomeCampo.Count - 1 do
      begin
        if A091FStampa.QRGroup1.Expression <> '' then
        begin
          A091FStampa.QRGroup1.Expression:=A091FStampa.QRGroup1.Expression + '+';
        end;
        A091FStampa.QRGroup1.Expression:=A091FStampa.QRGroup1.Expression + A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.INomeCampo[i];
        A091FStampa.QRGroup1.Enabled:=True;
      end;

      A091FStampa.QRFoot1.Enabled:=(chkTotaliRaggr.Checked) and (A091FStampa.QRGroup1.Enabled);
      A091FStampa.ChildBand1.Enabled:=(A091FStampa.QRGroup1.Enabled) and (chkSaltoPagina.Checked);
      A091FStampa.QRBIntestazione.Enabled:=not A091FStampa.ChildBand1.Enabled;
      // abilita gli eventuali totali generali
      A091FStampa.QRBand2.Enabled:=chkTotaliGenerali.Checked;
      // abilita il salto pagina
      A091FStampa.QRGroup1.ForceNewPage:=chkSaltoPagina.Checked;
      //Definizione della label di intestazione NomiDettaglio
      A091FStampa.NomiDettaglio.Caption:='';
      for i:=0 to A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.DNomeCampo.Count - 1 do
      begin
        if i > 0 then
          A091FStampa.NomiDettaglio.Caption:=A091FStampa.NomiDettaglio.Caption + ' ';
        if Length(A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.DNomeLogico[i]) > C700SelAnagrafe.FieldByName(A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.DNomeCampo[i]).Size then
          L:=Length(A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.DNomeLogico[i])
        else
          L:=C700SelAnagrafe.FieldByName(A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.DNomeCampo[i]).Size;
        S:=Format('%-*s',[L,A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.DNomeLogico[i]]);
        S:=Copy(S,1,L);
        A091FStampa.NomiDettaglio.Caption:=A091FStampa.NomiDettaglio.Caption + S;
      end;

      RegistraMsg.InserisciMessaggio('I','Generazione del report completata',Parametri.Azienda);

      Screen.Cursor:=crDefault;
      // ferma il timer di precisione
      LStopwatch.Stop;

      // crea la stampa
      A091FStampa.CreaReport(Sender = btnAnteprima);
      A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.TabellaStampa.Close;
    end;
  finally
    RegistraMsg.InserisciMessaggio('I','Fine elaborazione',Parametri.Azienda);

    if A091MW.TipoModulo = TTipoModuloRec.ClientServer then
    begin
      // ripristina interfaccia
      OnImpostazioniModificate;
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

procedure TA091FLiquidPresenze.btnAnomalieClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A091','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW);
end;

procedure TA091FLiquidPresenze.GetParametriFunzione;
{Leggo i parametri della form}
var i,P:Integer;
    L:TStringList;
    S,S1:String;
begin
  edtCausale.Text:=C004FParamForm.GetParametro('CAUSALE','');
  edtMaxLiq.Text:=C004FParamForm.GetParametro('MAXLIQ','00.00');
  edtArrotLiq.Text:=C004FParamForm.GetParametro('ARROTLIQ','0');
  edtMaxComp.Text:=C004FParamForm.GetParametro('MAXCOMP','00.00');
  edtArrotComp.Text:=C004FParamForm.GetParametro('ARROTCOMP','0');
  rgpDisponibilita.ItemIndex:=StrToIntDef(C004FParamForm.GetParametro('DISPONIBILITA','1'),1);
  chkSaltoPagina.Checked:=C004FParamForm.GetParametro('SALTOPAGINA','N') = 'S';
  chkTotaliRaggr.Checked:=C004FParamForm.GetParametro('TOTALIPARZIALI','N') = 'S';
  chkTotaliGenerali.Checked:=C004FParamForm.GetParametro('TOTALIGENERALI','N') = 'S';
  L:=TStringList.Create;
  S1:='';
  S:=C004FParamForm.GetParametro('INTESTAZIONE','');
  for i:=1 to Length(S) do
  begin
    if S[i] = ',' then
    begin
      L.Add(S1);
      S1:='';
    end
    else
      S1:=S1 + S[i];
  end;
  if Trim(S1) <> '' then
    L.Add(S1);
  for i:=L.Count - 1 downto 0 do
  begin
    P:=Intestazione.Items.IndexOf(L[i]);
    if P >= 0 then
      Intestazione.Items.Delete(P);
    Intestazione.Items.Insert(0,L[i]);
    Intestazione.Checked[0]:=True;
  end;
  L.Clear;
  S1:='';
  S:=C004FParamForm.GetParametro('DETTAGLIO','');
  for i:=1 to Length(S) do
  begin
    if S[i] = ',' then
    begin
      L.Add(S1);
      S1:='';
    end
    else
      S1:=S1 + S[i];
  end;
  if Trim(S1) <> '' then
    L.Add(S1);
  for i:=L.Count - 1 downto 0 do
  begin
    P:=Dettaglio.Items.IndexOf(L[i]);
    if P >= 0 then
      Dettaglio.Items.Delete(P);
    Dettaglio.Items.Insert(0,L[i]);
    Dettaglio.Checked[0]:=True;
  end;
  FreeAndNil(L);
end;

procedure TA091FLiquidPresenze.PutParametriFunzione;
{Scrivo i parametri della form}
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('CAUSALE',edtCausale.Text);
  C004FParamForm.PutParametro('MAXLIQ',edtMaxLiq.Text);
  C004FParamForm.PutParametro('ARROTLIQ',edtArrotLiq.Text);
  C004FParamForm.PutParametro('MAXCOMP',edtMaxComp.Text);
  C004FParamForm.PutParametro('ARROTCOMP',edtArrotComp.Text);
  C004FParamForm.PutParametro('DISPONIBILITA',IntToStr(rgpDisponibilita.ItemIndex));
  C004FParamForm.PutParametro('SALTOPAGINA',IfThen(chkSaltoPagina.Checked,'S','N'));
  C004FParamForm.PutParametro('TOTALIPARZIALI',IfThen(chkTotaliRaggr.Checked,'S','N'));
  C004FParamForm.PutParametro('TOTALIGENERALI',IfThen(chkTotaliGenerali.Checked,'S','N'));
  C004FParamForm.PutParametro('INTESTAZIONE',R180GetCheckList(99,Intestazione));
  C004FParamForm.PutParametro('DETTAGLIO',R180GetCheckList(99,Dettaglio));
  try SessioneOracle.Commit; except end;
end;

procedure TA091FLiquidPresenze.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TA091FLiquidPresenze.chkAggiornamentoClick(Sender: TObject);
begin
  // i checkbox "effettua liquidazione" ed "annulla liquidazione" sono mutuamente esclusivi
  if chkAggiornamento.Checked and
     chkAnnullaLiquidazione.Enabled then
  begin
    chkAnnullaLiquidazione.Checked:=False;
  end;

  OnImpostazioniModificate;
end;

procedure TA091FLiquidPresenze.chkAnnullaLiquidazioneClick(Sender: TObject);
begin
  // i checkbox "effettua liquidazione" ed "annulla liquidazione" sono mutuamente esclusivi
  if chkAnnullaLiquidazione.Checked and
     chkAggiornamento.Enabled then
  begin
    chkAggiornamento.Checked:=False;
  end;

  OnImpostazioniModificate;
end;

procedure TA091FLiquidPresenze.chkCompensazioniClick(Sender: TObject);
begin
  OnImpostazioniModificate;
end;

procedure TA091FLiquidPresenze.chkLiquidazioniClick(Sender: TObject);
begin
  OnImpostazioniModificate;
end;

procedure TA091FLiquidPresenze.cmbMeseDaChange(Sender: TObject);
begin
  // sposta il mese finale se il periodo non è corretto
  if cmbMeseDa.ItemIndex > cmbMeseA.ItemIndex then
    cmbMeseA.ItemIndex:=cmbMeseDa.ItemIndex;

  OnPeriodoModificato;
end;

procedure TA091FLiquidPresenze.cmbMeseAChange(Sender: TObject);
begin
  // sposta il mese iniziale se il periodo non è corretto
  if cmbMeseDa.ItemIndex > cmbMeseA.ItemIndex then
    cmbMeseDa.ItemIndex:=cmbMeseA.ItemIndex;

  OnPeriodoModificato;
end;

procedure TA091FLiquidPresenze.IntestazioneMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FItemCB:=Intestazione.ItemIndex;
end;

procedure TA091FLiquidPresenze.IntestazioneMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var C1,C2:Boolean;
begin
  if (FItemCB <> -1) and (FItemCB <> Intestazione.ItemIndex) then
  begin
    C1:=Intestazione.Checked[FItemCB];
    C2:=Intestazione.Checked[Intestazione.ItemIndex];
    Intestazione.Items.Exchange(FItemCB,Intestazione.ItemIndex);
    Intestazione.Checked[FItemCB]:=C2;
    Intestazione.Checked[Intestazione.ItemIndex]:=C1;
  end;
  FItemCB:= - 1;
end;

procedure TA091FLiquidPresenze.DettaglioMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FItemCB:=Dettaglio.ItemIndex;
end;

procedure TA091FLiquidPresenze.DettaglioMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var C1,C2:Boolean;
begin
  if (FItemCB <> -1) and (FItemCB <> Dettaglio.ItemIndex) then
  begin
    C1:=Dettaglio.Checked[FItemCB];
    C2:=Dettaglio.Checked[Dettaglio.ItemIndex];
    Dettaglio.Items.Exchange(FItemCB,Dettaglio.ItemIndex);
    Dettaglio.Checked[FItemCB]:=C2;
    Dettaglio.Checked[Dettaglio.ItemIndex]:=C1;
  end;
  FItemCB:= - 1;
end;

procedure TA091FLiquidPresenze.edtMaxLiqExit(Sender: TObject);
begin
  try
    OreMinutiValidate(TMaskEdit(Sender).Text);
  except
    TWinControl(Sender).SetFocus;
    raise;
  end;
end;

procedure TA091FLiquidPresenze.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  C005DataVisualizzazione:=R180FineMese(EncodeDate(sedtAnno.Value, cmbMeseA.ItemIndex + 1, 1));
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA091FLiquidPresenze.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C700DataDal:=R180InizioMese(EncodeDate(sedtAnno.Value,cmbMeseDa.ItemIndex + 1,1));
  C700DataLavoro:=R180FineMese(EncodeDate(sedtAnno.Value,cmbMeseA.ItemIndex + 1,1));
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA091FLiquidPresenze.FormDestroy(Sender: TObject);
begin
  FreeAndNil(A091FStampa);
  FreeAndNil(FLstCausali);
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA091FLiquidPresenze.dcmbCausaleKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null; 
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA091FLiquidPresenze.btnCausaleClick(Sender: TObject);
var
  LDS: TDataSet;
begin
  // imposta il dataset di riferimento
  LDS:=A091FLiquidPresenzeDtM1.A091FLiquidPresenzeMW.selT275;

  // richiamo C013 per esplodere lista
  C013FCheckList:=TC013FCheckList.Create(nil);
  try
    C013FCheckList.Caption:='Elenco causali presenza';
    LDS.First;
    C013FCheckList.clbListaDati.Items.Clear;
    while not LDS.Eof do
    begin
      C013FCheckList.clbListaDati.Items.Add(Format('%-5s',[LDS.FieldByName('CODICE').AsString]) + ' - ' + LDS.FieldByName('DESCRIZIONE').AsString);
      LDS.Next;
    end;
    R180PutCheckList(edtCausale.Text,5,C013FCheckList.clbListaDati);
    if C013FCheckList.ShowModal = mrOK then
    begin
      edtCausale.Text:=R180GetCheckList(5,C013FCheckList.clbListaDati);
      FLstCausali.CommaText:=edtCausale.Text;

      FElencoCausali:=FLstCausali.CommaText;

      // gestione modifica impostazioni
      OnImpostazioniModificate;
    end;
  finally
    FreeAndNil(C013FCheckList);
  end;
end;

end.
