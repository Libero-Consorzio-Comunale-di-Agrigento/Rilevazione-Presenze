unit A102UParScaricoGiustDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, RegistrazioneLog, A000UCostanti, A000USessione,A000UInterfaccia, OracleData, Oracle,
  C180FunzioniGenerali, Variants;

type
  TA102FParScaricoGiustDtM1 = class(TDataModule)
    QI150: TOracleDataSet;
    QI150CODICE: TStringField;
    QI150NOMEFILE: TStringField;
    QI150CORRENTE: TStringField;
    QI150MATRICOLA: TStringField;
    QI150BADGE: TStringField;
    QI150ANNODA: TStringField;
    QI150MESEDA: TStringField;
    QI150GIORNODA: TStringField;
    QI150ANNOA: TStringField;
    QI150MESEA: TStringField;
    QI150GIORNOA: TStringField;
    QI150ORADA: TStringField;
    QI150MINDA: TStringField;
    QI150ORAA: TStringField;
    QI150MINA: TStringField;
    QI150CAUSALE: TStringField;
    QI150TIPO: TStringField;
    QI150CODICE_TIPOI: TStringField;
    QI150CODICE_TIPOM: TStringField;
    QI150CODICE_TIPOD: TStringField;
    QI150CODICE_TIPON: TStringField;
    procedure A031FParScaricoDtM1Create(Sender: TObject);
    procedure QI150NewRecord(DataSet: TDataSet);
    procedure QI150AfterPost(DataSet: TDataSet);
    procedure QI150AfterCancel(DataSet: TDataSet);
    procedure QI150AfterDelete(DataSet: TDataSet);
    procedure QI150BeforePost(DataSet: TDataSet);
    procedure QI150BeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A102FParScaricoGiustDtM1: TA102FParScaricoGiustDtM1;

implementation

uses A031UParScarico, A102UParScaricoGiust;

{$R *.DFM}

procedure TA102FParScaricoGiustDtM1.A031FParScaricoDtM1Create(Sender: TObject);
var i:Integer;
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
  QI150.Open;
end;

procedure TA102FParScaricoGiustDtM1.QI150NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('CODICE_TIPOI').AsString:='I';
  DataSet.FieldByName('CODICE_TIPOM').AsString:='M';
  DataSet.FieldByName('CODICE_TIPOD').AsString:='D';
  DataSet.FieldByName('CODICE_TIPON').AsString:='N';
  DataSet.FieldByName('CORRENTE').AsString:='N';
  DataSet.FieldByName('MATRICOLA').AsString:='0,0';
  DataSet.FieldByName('BADGE').AsString:='0,0';
  DataSet.FieldByName('ANNODA').AsString:='0,0';
  DataSet.FieldByName('MESEDA').AsString:='0,0';
  DataSet.FieldByName('GIORNODA').AsString:='0,0';
  DataSet.FieldByName('ANNOA').AsString:='0,0';
  DataSet.FieldByName('MESEA').AsString:='0,0';
  DataSet.FieldByName('GIORNOA').AsString:='0,0';
  DataSet.FieldByName('ORADA').AsString:='0,0';
  DataSet.FieldByName('MINDA').AsString:='0,0';
  DataSet.FieldByName('ORAA').AsString:='0,0';
  DataSet.FieldByName('MINA').AsString:='0,0';
  DataSet.FieldByName('CAUSALE').AsString:='0,0';
  DataSet.FieldByName('TIPO').AsString:='0,0';
end;

procedure TA102FParScaricoGiustDtM1.QI150BeforePost(DataSet: TDataSet);
{Copio i dati della griglia nei campi corrispondenti prima di confermare le modifiche}
var i:Byte;
    P,L:Word;
begin
  if QueryPK1.EsisteChiave('MONDOEDP.I150_PARSCARICOGIUST',QI150.RowId,QI150.State,['CODICE'],[QI150Codice.AsString]) then
    raise Exception.Create('Codice già esistente!');
  with A102FParScaricoGiust do
    for i:=3 to 16 do
    begin
      P:=StrToIntDef(StringGrid1.Cells[i-2,1],0);
      L:=StrToIntDef(StringGrid1.Cells[i-2,2],0);
      QI150.Fields[i].AsString:=IntToStr(P) + ',' + IntToStr(L);
    end;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA102FParScaricoGiustDtM1.QI150AfterPost(DataSet: TDataSet);
var S:String;
begin
  S:=QI150Codice.AsString;
  SessioneOracle.ApplyUpdates([QI150],True);
  RegistraLog.RegistraOperazione;
  QI150.Close;
  QI150.Open;
  QI150.Locate('Codice',S,[]);
end;

procedure TA102FParScaricoGiustDtM1.QI150AfterCancel(DataSet: TDataSet);
begin
  QI150.CancelUpdates;
end;

procedure TA102FParScaricoGiustDtM1.QI150AfterDelete(DataSet: TDataSet);
begin
  SessioneOracle.ApplyUpdates([QI150],True);
  RegistraLog.RegistraOperazione;
end;

procedure TA102FParScaricoGiustDtM1.QI150BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

end.
