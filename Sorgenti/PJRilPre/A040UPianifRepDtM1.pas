unit A040UPianifRepDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi,
  C700USelezioneAnagrafe, Oracle, OracleData,
  C180FunzioniGenerali, Variants, DBClient,
  Math, StrUtils, A040UPianifRepMW;

type
  TA040FPianifRepDtM1 = class(TDataModule)
    selT380: TOracleDataSet;
    selT380DATA: TDateTimeField;
    selT380PROGRESSIVO: TFloatField;
    selT380TURNO1: TStringField;
    selT380TURNO2: TStringField;
    selT380DATOLIBERO: TStringField;
    selT380D_MATRICOLA: TStringField;
    selT380D_NOMINATIVO: TStringField;
    selT380TURNO3: TStringField;
    selT380TIPOLOGIA: TStringField;
    selT380D_BADGE: TFloatField;
    selT380PRIORITA1: TIntegerField;
    selT380PRIORITA2: TIntegerField;
    selT380PRIORITA3: TIntegerField;
    Q380St: TOracleDataSet;
    selT380RECAPITO1: TStringField;
    selT380RECAPITO2: TStringField;
    selT380RECAPITO3: TStringField;
    procedure A040FPianifRepDtM1Create(Sender:TObject);
    procedure A040FPianifRepDtM1Destroy(Sender:TObject);
    procedure selT380AfterPost(DataSet:TDataSet);
    procedure selT380BeforeDelete(DataSet:TDataSet);
    procedure selT380BeforeInsert(DataSet:TDataSet);
    procedure selT380BeforePost(DataSet:TDataSet);
    procedure selT380NewRecord(DataSet:TDataSet);
    procedure TURNOSetText(Sender:TField;const Text:String);
    procedure TURNOValidate(Sender:TField);
    procedure selT380DATAValidate(Sender:TField);
    procedure selT380DATOLIBEROSetText(Sender:TField;const Text:String);
    procedure selT380DATOLIBEROValidate(Sender:TField);
  private
    { Private declarations }
    procedure evtMessaggio(Msg:String);
    procedure evtRichiesta(Msg,Chiave:String);
    procedure evtRichiestaRefresh(Msg,Chiave:String);
    function evtGiornataAssenza(Msg:String):Boolean;
    function evtTurnoNonInserito(Msg:String):Boolean;
    procedure evtRaggrAbilitati(Msg,Chiave:String);
    function evtKeyCtrl(Chiave:String):Boolean;
    procedure evtMergeSelAnagrafe(ODS:TOracleDataSet);
  public
    A040MW: TA040FPianifRepMW;
    RaggrDatiAgg:Boolean;
    CampoGruppo1,NomeLogicoCampoGruppo1,TabellaCampoGruppo1,
    CampoGruppo2,NomeLogicoCampoGruppo2,TabellaCampoGruppo2: String;
  end;

var
  A040FPianifRepDtM1: TA040FPianifRepDtM1;

implementation

uses A040UInserimento, A040UPianifRep, A040UDialogStampa;

{$R *.DFM}

procedure TA040FPianifRepDtM1.A040FPianifRepDtM1Create(Sender:TObject);
{Preparo le query Mensili}
var
  i:Integer;
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
  end;
  A040MW:=TA040FPianifRepMW.Create(Self);
  A040MW.selT380:=selT380;
  if A040FPianifRep.TipoModulo <> 'COM' then
  begin
    A040MW.evtMessaggio:=evtMessaggio;
    A040MW.evtRichiesta:=evtRichiesta;
  end;
  A040MW.evtRichiestaRefresh:=evtRichiestaRefresh;
  A040MW.evtGiornataAssenza:=evtGiornataAssenza;
  A040MW.evtTurnoNonInserito:=evtTurnoNonInserito;
  A040MW.evtRaggrAbilitati:=evtRaggrAbilitati;
  A040MW.evtKeyCtrl:=evtKeyCtrl;
  A040MW.evtMergeSelAnagrafe:=evtMergeSelAnagrafe;
  A040FDialogStampa.dcmbCampoRaggr.ListSource:=A040MW.D010;
  A040FDialogStampa.dcmbCampoDett.ListSource:=A040MW.D010B;
  A040FDialogStampa.dcmbCampoConNom.ListSource:=A040MW.D010C;
  A040FDialogStampa.dCmbLkpProfili.ListSource:=A040MW.drsT355;
end;

procedure TA040FPianifRepDtM1.A040FPianifRepDtM1Destroy(Sender:TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

procedure TA040FPianifRepDtM1.selT380AfterPost(DataSet:TDataSet);
begin
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
  A040MW.AfterPost;
end;

procedure TA040FPianifRepDtM1.selT380BeforeDelete(DataSet:TDataSet);
begin
  A040MW.BeforeDelete;
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA040FPianifRepDtM1.selT380BeforeInsert(DataSet:TDataSet);
begin
  A040MW.BeforeInsert;
end;

procedure TA040FPianifRepDtM1.selT380BeforePost(DataSet:TDataSet);
begin
  Screen.Cursor:=crHourGlass;
  try
    A040MW.NonContDipPian:=A040FPianifRep.chkNonContDipPian.Checked;
    A040MW.BeforePost;
    case DataSet.State of
      dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
      dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA040FPianifRepDtM1.selT380NewRecord(DataSet:TDataSet);
begin
  A040MW.NewRecord(EncodeDate(A040FPianifRep.EAnno.Value,A040FPianifRep.EMese.Value,1));
end;

procedure TA040FPianifRepDtM1.TURNOSetText(Sender:TField;const Text:String);
begin
  A040MW.selT380ImpostaTesto(Sender,Text,5);
end;

procedure TA040FPianifRepDtM1.TURNOValidate(Sender:TField);
begin
  A040MW.selT380ValidaTurno(Sender);
end;

procedure TA040FPianifRepDtM1.selT380DATAValidate(Sender:TField);
begin
  A040MW.selT380ValidaData;
end;

procedure TA040FPianifRepDtM1.selT380DATOLIBEROSetText(Sender:TField;const Text:String);
begin
  A040MW.selT380ImpostaTesto(Sender,Text,20);
end;

procedure TA040FPianifRepDtM1.selT380DATOLIBEROValidate(Sender:TField);
begin
  A040MW.selT380ValidaDatoLibero;
end;

procedure TA040FPianifRepDtM1.evtMessaggio(Msg:String);
begin
  R180MessageBox(Msg,INFORMA);
end;

procedure TA040FPianifRepDtM1.evtRichiesta(Msg,Chiave:String);
begin
  if R180MessageBox(Msg,'DOMANDA') <> mrYes then
    abort;
end;

procedure TA040FPianifRepDtM1.evtRichiestaRefresh(Msg,Chiave:String);
begin
  if R180MessageBox(Msg,'DOMANDA') <> mrYes then
  begin
    A040MW.RefreshT380;
    abort;
  end;
end;

function TA040FPianifRepDtM1.evtGiornataAssenza(Msg:String):Boolean;
begin
  Result:=R180MessageBox(Msg,'DOMANDA') = mrYes;
end;

function TA040FPianifRepDtM1.evtTurnoNonInserito(Msg:String):Boolean;
begin
  Result:=R180MessageBox(Msg,'DOMANDA') = mrYes;
end;

procedure TA040FPianifRepDtM1.evtRaggrAbilitati(Msg,Chiave:String);
begin
  if R180MessageBox(Msg,'DOMANDA') <> mrYes then
    raise exception.create(A000MSG_MSG_ELABORAZIONE_INTERROTTA);
end;

function TA040FPianifRepDtM1.evtKeyCtrl(Chiave:String):Boolean;
begin
  Result:=False;//Serve per il WA040
end;

procedure TA040FPianifRepDtM1.evtMergeSelAnagrafe(ODS:TOracleDataSet);
begin
  C700MergeSelAnagrafe(ODS,False);
  C700MergeSettaPeriodo(ODS,Parametri.DataLavoro,Parametri.DataLavoro);
end;

end.

