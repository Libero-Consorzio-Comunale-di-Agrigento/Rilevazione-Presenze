unit W051UBudgetStraordinarioDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, A000UInterfaccia, Oracle, OracleData, StrUtils,
  A064UBudgetStraordinarioMW, C018UIterAutDM;

type
  TW051FBudgetStraordinarioDM = class(TDataModule)
    selT713: TOracleDataSet;
    selT713ANNO: TFloatField;
    selT713CODGRUPPO: TStringField;
    selT713DESCRIZIONE: TStringField;
    selT713FILTRO_ANAGRAFE: TStringField;
    selT713ORE: TStringField;
    selT713IMPORTO: TFloatField;
    selT713DECORRENZA: TDateTimeField;
    selT713DECORRENZA_FINE: TDateTimeField;
    selT713TIPO: TStringField;
    selT714: TOracleDataSet;
    selT714CODGRUPPO: TStringField;
    selT714TIPO: TStringField;
    selT714DECORRENZA: TDateTimeField;
    selT714MESE: TFloatField;
    selT714ORE_AUTO: TStringField;
    selT714ORE: TStringField;
    selT714ORE_FRUITO: TStringField;
    selT714ORE_RESIDUO_AUTO: TStringField;
    selT714ORE_RESIDUO: TStringField;
    selT714IMPORTO_AUTO: TFloatField;
    selT714IMPORTO: TFloatField;
    selT714IMPORTO_FRUITO: TFloatField;
    selT714IMPORTO_RESIDUO_AUTO: TFloatField;
    selT714IMPORTO_RESIDUO: TFloatField;
    selT713CDESCRIZIONE: TStringField;
    selT713RIEPILOGO_ORARIO: TStringField;
    selT713TOT_ORE_F: TStringField;
    selT713TOT_ORE_R: TStringField;
    selT715: TOracleDataSet;
    selT700: TOracleDataSet;
    selT700ID: TFloatField;
    selT700ID_REVOCA: TFloatField;
    selT700ID_REVOCATO: TFloatField;
    selT700COD_ITER: TStringField;
    selT700TIPO_RICHIESTA: TStringField;
    selT700D_TIPO_RICHIESTA: TStringField;
    selT700D_RESPONSABILE: TStringField;
    selT700D_AUTORIZZAZIONE: TStringField;
    selT700D_STATO: TStringField;
    selT700AUTORIZZ_AUTOMATICA: TStringField;
    selT700REVOCABILE: TStringField;
    selT700DATA_RICHIESTA: TDateTimeField;
    selT700LIVELLO_AUTORIZZAZIONE: TFloatField;
    selT700DATA_AUTORIZZAZIONE: TDateTimeField;
    selT700AUTORIZZAZIONE: TStringField;
    selT700NOMINATIVO_RESP: TStringField;
    selT700AUTORIZZ_AUTOM_PREV: TStringField;
    selT700AUTORIZZ_PREV: TStringField;
    selT700RESPONSABILE_PREV: TStringField;
    selT700AUTORIZZ_UTILE: TStringField;
    selT700AUTORIZZ_REVOCA: TStringField;
    selT700MSGAUT_SI: TStringField;
    selT700MSGAUT_NO: TStringField;
    selT700CODGRUPPO: TStringField;
    selT700TIPO: TStringField;
    selT700ORE: TStringField;
    selT700IMPORTO: TFloatField;
    selT700DECORRENZA: TDateTimeField;
    updT713: TOracleQuery;
    selT713BLOCCATO: TStringField;
    selT700D_CODGRUPPO: TStringField;
    selT713lkp: TOracleDataSet;
    selT713lstAnno: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT713BeforePost(DataSet: TDataSet);
    procedure selT714AfterPost(DataSet: TDataSet);
    procedure selT714BeforePost(DataSet: TDataSet);
    procedure selT714CalcFields(DataSet: TDataSet);
    procedure selT713AfterScroll(DataSet: TDataSet);
    procedure selT713CalcFields(DataSet: TDataSet);
    procedure selT713FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT700CalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    procedure evtRichiesta(Msg,Chiave:String);
  public
    { Public declarations }
    A064MW: TA064FBudgetStraordinarioMW;
    C018:TC018FIterAutDM;
  end;

var
  W051FBudgetStraordinarioDM: TW051FBudgetStraordinarioDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
uses
  System.Variants,
  A000USessione, C180FunzioniGenerali, W051UBudgetStraordinario;

{$R *.dfm}

procedure TW051FBudgetStraordinarioDM.DataModuleCreate(Sender: TObject);
var i:Integer;
    FiltroResp: String;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle
    else if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;

  // imposta costante QVistaOracle
  selT700.SetVariable('QVISTAORACLE',QVistaOracle);

  A064MW:=TA064FBudgetStraordinarioMW.Create(self);
  A064MW.selT713:=selT713;
  A064MW.selT714:=selT714;
  A064MW.evtRichiesta:=evtRichiesta;
  selT714ORE.OnValidate:=A064MW.selT714OREValidate;

  if WR000DM.TipoUtente = 'Dipendente' then
  begin
    FiltroResp:='  and exists (select 1 from T715_BUDGETRESPONSABILI T715 where T715.CODGRUPPO = T713.CODGRUPPO and T715.TIPO = T713.TIPO and T715.DECORRENZA = T713.DECORRENZA and T715.RESPONSABILE = ' + Parametri.ProgressivoOper.ToString + ' and AUTORIZZATORE = ''' + IfThen(WR000DM.Responsabile,'S','N') + ''')';
    R180SetVariable(selT713lstAnno,'RESPONSABILE',FiltroResp);
    R180SetVariable(selT713lkp,    'RESPONSABILE',FiltroResp);
    R180SetVariable(selT713,       'RESPONSABILE',FiltroResp);
  end;
  selT713lstAnno.Open;
  selT713lkp.Open;
  selT715.Open;
end;

procedure TW051FBudgetStraordinarioDM.evtRichiesta(Msg,Chiave:String);
begin
  if Chiave = 'Aggiornamenti' then
    A064MW.CaricaAggiornamenti;
end;

procedure TW051FBudgetStraordinarioDM.selT700CalcFields(DataSet: TDataSet);
var
  s: string;
begin
  with selT700 do
  begin
    FieldByName('D_TIPO_RICHIESTA').AsString:='Definitiva';

    if FieldByName('AUTORIZZ_UTILE').AsString = '' then
      S:=''
    else if FieldByName('AUTORIZZ_UTILE').AsString = 'N' then
      S:='No'
    else
      S:='Si';

    FieldByName('D_AUTORIZZAZIONE').AsString:=S;

    FieldByName('D_RESPONSABILE').AsString:=FieldByName('NOMINATIVO_RESP').AsString.Trim;

    FieldByName('D_CODGRUPPO').AsString:=VarToStr(selT713lkp.Lookup('CODGRUPPO',FieldByName('CODGRUPPO').AsString,'DESCRIZIONE'));

    {
    // D_ELABORATO: stato elaborazione
    if FieldByName('ELABORATO').AsString = 'S' then
      FieldByName('D_ELABORATO').AsString:='OK'
    else if FieldByName('ELABORATO').AsString = 'E' then
      FieldByName('D_ELABORATO').AsString:='Err'
    else
      FieldByName('D_ELABORATO').AsString:='';

    // DESC_OPERAZIONE: descrizione tipo operazione richiesta
    if FieldByName('OPERAZIONE').AsString = 'I' then
      FieldByName('DESC_OPERAZIONE').AsString:='INS'
    else if FieldByName('OPERAZIONE').AsString = 'M' then
      FieldByName('DESC_OPERAZIONE').AsString:='MOD'
    else if FieldByName('OPERAZIONE').AsString = 'C' then
      FieldByName('DESC_OPERAZIONE').AsString:='CAN';
    }

    //CAUSALE_UTILE
    {
    FieldByName('CAUSALE_UTILE').AsString:=FieldByName('CAUSALE').AsString;
    if C018.IterModificaValori then
    begin
      C018.Id:=FieldByName('ID').AsInteger;
      C018DatoAutorizzatore:=C018.GetDatoAutorizzatore('CAUSALE');
      if C018DatoAutorizzatore.Esiste then
      begin
        FieldByName('CAUSALE_UTILE').AsString:=C018DatoAutorizzatore.Valore;
        FieldByName('CAUSALE_UTILE_LIV').AsInteger:=C018DatoAutorizzatore.Livello;
      end;
    end;
    }
  end;
end;

procedure TW051FBudgetStraordinarioDM.selT713AfterScroll(DataSet: TDataSet);
begin
  A064MW.selT713AfterScroll;
end;

procedure TW051FBudgetStraordinarioDM.selT713BeforePost(DataSet: TDataSet);
begin
  with A064MW do
  begin
    selT713BeforePostNoStoricoInizio;
    try
      selT713BeforePostNoStoricoSalvaPrima;
      inherited;
      selT713BeforePostNoStoricoSalvaDopo;
    finally

    end;
    selT713BeforePostNoStoricoFine;
  end;
end;

procedure TW051FBudgetStraordinarioDM.selT713CalcFields(DataSet: TDataSet);
begin
  selT713.FieldByName('RIEPILOGO_ORARIO').AsString:=selT713.FieldByName('TOT_ORE_F').AsString;
  selT713.FieldByName('TOT_ORE_R').AsString:=R180MinutiOre(R180OreMinutiExt(selT713.FieldByName('ORE').AsString) - R180OreMinutiExt(selT713.FieldByName('TOT_ORE_F').AsString));
end;

procedure TW051FBudgetStraordinarioDM.selT713FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('GRUPPI BUDGET STRAORDINARIO',DataSet.FieldByName('CODGRUPPO').AsString);
  if not Accept then
    exit;

  if WR000DM.TipoUtente = 'Dipendente' then
  begin
    Accept:=selT715.SearchRecord('CODGRUPPO;TIPO;DECORRENZA;RESPONSABILE;AUTORIZZATORE',
                                 VarArrayOf([
                                   DataSet.FieldByName('CODGRUPPO').AsString,
                                   DataSet.FieldByName('TIPO').AsString,
                                   DataSet.FieldByName('DECORRENZA').AsDateTime,
                                   Parametri.ProgressivoOper,
                                   IfThen(WR000DM.Responsabile,'S','N')
                                 ]),[srFromBeginning]);
  end;
end;

procedure TW051FBudgetStraordinarioDM.selT714AfterPost(DataSet: TDataSet);
begin
  with selT714 do
    try
      AfterPost:=nil;
      BeforePost:=nil;
      A064MW.selT714AfterPost;
      if A064MW.A064MWMsg <> '' then
      begin
        //ShowMessage(A064MW.A064MWMsg);
        A064MW.A064MWMsg:='';
      end;
    finally
      AfterPost:=selT714AfterPost;
      BeforePost:=selT714BeforePost;
    end;
end;

procedure TW051FBudgetStraordinarioDM.selT714BeforePost(DataSet: TDataSet);
begin
  A064MW.selT714BeforePost;
end;

procedure TW051FBudgetStraordinarioDM.selT714CalcFields(DataSet: TDataSet);
begin
  A064MW.selT714CalcFields;
end;

end.
