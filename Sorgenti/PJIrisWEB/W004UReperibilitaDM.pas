unit W004UReperibilitaDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient, OracleData, Vcl.Controls,
  Oracle, medpIWMessageDlg, A000USessione, A000UInterfaccia, A040UPianifRepMW, StrUtils,
  A000UMessaggi, C180FunzioniGenerali, QueryStorico;

type
  TW004FReperibilitaDM = class(TDataModule)
    cdsListaTimb: TClientDataSet;
    cdsLista: TClientDataSet;
    cdsListaPag: TClientDataSet;
    selT040: TOracleDataSet;
    selT100: TOracleDataSet;
    T010F_GGLAVORATIVO: TOracleQuery;
    cdsListaTurni: TClientDataSet;
    selT380: TOracleDataSet;
    dsrT380Tab: TDataSource;
    cdsT380Tab: TClientDataSet;
    selT385: TOracleDataSet;
    selT380a: TOracleDataSet;
    selT350Opposto: TOracleDataSet;
    insT380: TOracleQuery;
    selT040Assenza: TOracleDataSet;
    selT430Contratto: TOracleDataSet;
    selT270: TOracleDataSet;
    selT011: TOracleDataSet;
    selT180: TOracleDataSet;
    cdsListaGG: TClientDataSet;
    selT380GestMesile: TOracleDataSet;
    selT200: TOracleQuery;
    selSQL: TOracleDataSet;
    selT651: TOracleDataSet;
    delT380: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure evtMessaggio(Msg:String);
    procedure evtRichiesta(Msg,Chiave:String);
    procedure ResultEvtRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure evtRichiestaRefresh(Msg,Chiave:String);
    procedure ResultEvtRichiestaRefresh(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultEvtTurnoNonInserito(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure evtRaggrAbilitati(Msg,Chiave:String);
    procedure ResultEvtRaggrAbilitati(Sender: TObject; R: TmeIWModalResult; KI: String);
    function evtGiornataAssenza(Msg:String):Boolean;
    procedure ResultEvtGiornataAssenza(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure evtClearKeys;
    procedure evtMergeSelAnagrafe(ODS:TOracleDataSet);
    procedure evtT380MergeSelAnagrafe(ODS:TOracleDataSet);
  public
    { Public declarations }
    A040MW:TA040FPianifRepMW;
    QSDatiAgg:TQueryStorico;
    function AggiornaFiltroRicerca(pFiltro: string): string;
    function evtTurnoNonInserito(Msg:String):Boolean;
    procedure GetAreeAfferenza(Squadra,Operatore:String);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses W004UReperibilita;

{$R *.dfm}

function TW004FReperibilitaDM.AggiornaFiltroRicerca(pFiltro: string): string;
begin
  if (Parametri.T380_AutoPianificazione = 'S') and
     (not Parametri.InibizioneIndividuale) and
     (WR000DM.TipoUtente = 'Dipendente')  then
  begin
    pFiltro:=pFiltro.Replace('/*I072*/', '((/*I072*/');
    pFiltro:=pFiltro.Replace('/*\I072*/','/*\I072*/) OR T030.PROGRESSIVO = ' + parametri.ProgressivoOper.ToString + ')');
    result:=pFiltro;
  end
  else
    result:=pFiltro;
end;

procedure TW004FReperibilitaDM.DataModuleCreate(Sender: TObject);
var
  i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle
    else if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;
  end;
  QSDatiAgg:=TQueryStorico.Create(nil);
  QSDatiAgg.Session:=SessioneOracle;
  A040MW:=TA040FPianifRepMW.Create(nil);
  A040MW.evtMessaggio:=evtMessaggio;
  A040MW.evtRichiesta:=evtRichiesta;
  A040MW.evtRichiestaRefresh:=evtRichiestaRefresh;
  A040MW.evtClearKeys:=evtClearKeys;
  A040MW.evtTurnoNonInserito:=evtTurnoNonInserito;
  A040MW.evtGiornataAssenza:=evtGiornataAssenza;
  A040MW.evtMergeSelAnagrafe:=evtMergeSelAnagrafe;
  A040MW.evtRaggrAbilitati:=evtRaggrAbilitati;
  A040MW.evtT380MergeSelAnagrafe:=evtT380MergeSelAnagrafe;
  selT380.SetVariable('QVISTAORACLE',StringReplace(QVistaOracle,':DataLavoro','T380.DATA',[rfReplaceAll, rfIgnoreCase]));
  selT651.Open;
end;

procedure TW004FReperibilitaDM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(QSDatiAgg);
  FreeAndNil(A040MW);
end;

procedure TW004FReperibilitaDM.evtMessaggio(Msg:String);
begin
  MsgBox.WebMessageDlg(Msg,mtInformation,[mbYes],nil,'');
end;

function TW004FReperibilitaDM.evtTurnoNonInserito(Msg:String):Boolean;
begin
  MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultEvtTurnoNonInserito,'');
  Abort;
end;

procedure TW004FReperibilitaDM.GetAreeAfferenza(Squadra, Operatore: String);
var FiltroT651:String;
begin
  //Filtro DataSet con Aree previste per Squadra / Operatore
  FiltroT651:='((CODICE_SQUADRA = ''' + Squadra + ''')';
  FiltroT651:=FiltroT651 + ' AND (CODICE_OPERATORE = ''' + Operatore + '''))';
  FiltroT651:=FiltroT651 + ' OR ((CODICE_SQUADRA = ''' + Squadra + ''')';
  FiltroT651:=FiltroT651 + ' AND (CODICE_OPERATORE = ''<*>''))';
  selT651.Filtered:=False;
  selT651.Filter:=FiltroT651;
  selT651.Filtered:=True;
end;

procedure TW004FReperibilitaDM.ResultEvtTurnoNonInserito(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  A040MW.sTurnoNonInserito:=IfThen(R = mrYes,'S','N');
  case A040MW.ProceduraChiamante of
    1: A040MW.InserisciGestioneMensile;
    2: A040MW.CancellaGestioneMensile;
  end
end;

procedure TW004FReperibilitaDM.evtRichiesta(Msg,Chiave:String);
begin
  if not MsgBox.KeyExists(Chiave) then
  begin
    MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultEvtRichiesta,Chiave);
    Abort;
  end;
end;

procedure TW004FReperibilitaDM.ResultEvtRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    case A040MW.ProceduraChiamante of
      1: A040MW.InserisciGestioneMensile;
      2: A040MW.CancellaGestioneMensile;
      3: (Self.Owner as TW004FReperibilita).EseguiStampa;
      4: (Self.Owner as TW004FReperibilita).InserimentoSingolo;
    end
  else
    A040MW.PulisciVariabili;
end;

procedure TW004FReperibilitaDM.evtRichiestaRefresh(Msg,Chiave:String);
begin
  if not MsgBox.KeyExists(Chiave) then
  begin
    MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultEvtRichiestaRefresh,Chiave);
    Abort;
  end;
end;

procedure TW004FReperibilitaDM.ResultEvtRichiestaRefresh(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    case A040MW.ProceduraChiamante of
      1: A040MW.InserisciGestioneMensile;
      2: A040MW.CancellaGestioneMensile;
    end
  else
  begin
    A040MW.PulisciVariabili;
  end;
end;

function TW004FReperibilitaDM.evtGiornataAssenza(Msg:String):Boolean;
begin
  MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultEvtGiornataAssenza,'');
  Abort;
end;

procedure TW004FReperibilitaDM.ResultEvtGiornataAssenza(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  A040MW.sGiornataAssenza:=IfThen(R = mrYes,'S','N');
  case A040MW.ProceduraChiamante of
    1: A040MW.InserisciGestioneMensile;
    2: A040MW.CancellaGestioneMensile;
  end
end;

procedure TW004FReperibilitaDM.evtRaggrAbilitati(Msg,Chiave:String);
begin
  if not MsgBox.KeyExists(Chiave) then
  begin
    MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultEvtRaggrAbilitati,Chiave);
    Abort;
  end;
end;

procedure TW004FReperibilitaDM.ResultEvtRaggrAbilitati(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    case A040MW.ProceduraChiamante of
      1: A040MW.InserisciGestioneMensile;
      2: A040MW.CancellaGestioneMensile;
    end
  else
  begin
    A040MW.PulisciVariabili;
    raise exception.Create(A000MSG_MSG_ELABORAZIONE_INTERROTTA);
  end;
end;

procedure TW004FReperibilitaDM.evtClearKeys;
begin
  MsgBox.ClearKeys;
end;

procedure TW004FReperibilitaDM.evtT380MergeSelAnagrafe(ODS:TOracleDataSet);
begin
  ODS.SetVariable('C700SelAnagrafe',QVistaOracle + ' and T380.PROGRESSIVO = T030.PROGRESSIVO ' + AggiornaFiltroRicerca(WR000DM.FiltroRicerca));
  if ODS.VariableIndex('DataLavoro') = -1 then
    ODS.DeclareAndSet('DataLavoro',otDate,Parametri.DataLavoro);
end;

procedure TW004FReperibilitaDM.evtMergeSelAnagrafe(ODS:TOracleDataSet);
begin
  ODS.SetVariable('C700SelAnagrafe',QVistaOracle + ' ' + AggiornaFiltroRicerca(WR000DM.FiltroRicerca));
  if ODS.VariableIndex('DataLavoro') = -1 then
    ODS.DeclareAndSet('DataLavoro',otDate,Parametri.DataLavoro);
end;

end.
