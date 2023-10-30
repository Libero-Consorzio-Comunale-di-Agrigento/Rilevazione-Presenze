unit WM000UDataSetMW;

interface

uses
  A000UCostanti,
  B110UClientModule,
  B110USharedTypes,
  Data.FireDACJSONReflect,
  FireDAC.Comp.Client,
  Oracle,
  OracleData,
  System.Generics.Collections,
  System.Sensors, C200UWebServicesTypes, C200UWebServicesUtils, System.SysUtils, System.Classes,
  System.StrUtils, FunzioniGenerali, System.Math, WM000UConstants, Data.DB;

type
  TTipoDataSet = (tdOracleDataSet, tdFDMemTable);

  //incapsula un dataset di tipo TOracleDataset (DM) o TFDMemTable (B110)
  TWM000FDataSetMW = class(TObject)
    private
      FTipoDataSet: TTipoDataSet;

      function GetFDMemTable: TFDMemTable;
      function GetOracleDataSet: TOracleDataSet;
      procedure SetFDMemTable(const Value: TFDMemTable);
      procedure SetOracleDataSet(const Value: TOracleDataSet);

      function GetRowId: String;
      function GetRecordCount: Integer;
      function GetPrecEnabled: Boolean;
      function GetSuccEnabled: Boolean;
      function GetEof: Boolean;
      function GetRecNo: Integer;
      procedure SetRecNo(const Value: Integer);

      function GetEofField: Boolean;
      function GetFieldName: String;
    protected
      FDataSet: TDataSet;
      FieldIndex: Integer;

      function GetFieldLabel: String; virtual;
      function GetFieldText: String; virtual;
    public
      constructor Create(TipoDataSet: TTipoDataSet);
      destructor Destroy; override;

      property DataSet: TDataSet read FDataSet;
      property FDMemTable: TFDMemTable read GetFDMemTable write SetFDMemTable;
      property OracleDataSet: TOracleDataSet read GetOracleDataSet write SetOracleDataSet;

      property RowId: String read GetRowId;

      property FieldLabel: String read GetFieldLabel;
      property FieldText: String read GetFieldText;
      property FieldName: String read GetFieldName;

      property RecNo: Integer read GetRecNo write SetRecNo;
      property RecordCount: Integer read GetRecordCount;

      property PrecEnabled: Boolean read GetPrecEnabled;
      property SuccEnabled: Boolean read GetSuccEnabled;

      property Eof: Boolean read GetEof;
      property EofField: Boolean read GetEofField;

      function First: Boolean;
      function Next: Boolean;
      function Prior: Boolean;
      function Last: Boolean;

      function FirstField: Boolean;
      function NextField: Boolean;
      function PriorField: Boolean;
      function LastField: Boolean;

      function Locate(AKeyField: String; AKeyValues: Variant; AOptions: TLocateOptions): Boolean;

      procedure Commit;
      procedure Rollback;
      procedure Cancel;
      procedure Post;
  end;

implementation

constructor TWM000FDataSetMW.Create(TipoDataSet: TTipoDataSet);
begin
  inherited Create;

  FTipoDataSet:=TipoDataSet;

  if FTipoDataSet = tdFDMemTable then
    FDataSet:=TFDMemTable.Create(nil);

  FieldIndex:=0;
end;

destructor TWM000FDataSetMW.Destroy;
begin
  if FDataSet.Active then
    FDataSet.Close;

  if FTipoDataSet = tdFDMemTable then
    FreeAndNil(FDataSet);
  inherited;
end;

function TWM000FDataSetMW.GetFDMemTable: TFDMemTable;
begin
  if Assigned(FDataSet) then
  begin
    if FDataSet is TFDMemTable then
      Result:=FDataSet as TFDMemTable
    else
      raise Exception.Create('Il dataset non è di tipo TFDMemTable');
  end
  else
    Result:=nil;
end;

procedure TWM000FDataSetMW.SetFDMemTable(const Value: TFDMemTable);
begin
  if Value <> FDataSet then
  begin
    if Assigned(FDataSet) then
      FreeAndNil(FDataSet);

    FDataSet:=Value;
  end;
end;

function TWM000FDataSetMW.GetOracleDataSet: TOracleDataSet;
begin
  if Assigned(FDataSet) then
  begin
    if FDataSet is TOracleDataSet then
      Result:=FDataSet as TOracleDataSet
    else
      raise Exception.Create('Il dataset non è di tipo TOracleDataSet');
  end
  else
    Result:=nil;
end;

procedure TWM000FDataSetMW.SetOracleDataSet(const Value: TOracleDataSet);
begin
  if Value <> FDataSet then
  begin
    if Assigned(FDataSet) then
      FreeAndNil(FDataSet);

    FDataSet:=Value;
  end;
end;

procedure TWM000FDataSetMW.Post;
begin
  if OracleDataSet.State in [dsEdit, dsInsert] then
    OracleDataSet.Post
  else
    raise Exception.Create('Il dataset non è negli stati dsEdit o dsInsert');
end;

procedure TWM000FDataSetMW.Cancel;
begin
  if OracleDataSet.State in [dsEdit, dsInsert] then
    OracleDataSet.Cancel
  else
    raise Exception.Create('Il dataset non è negli stati dsEdit o dsInsert');
end;

procedure TWM000FDataSetMW.Commit;
begin
  if Assigned(OracleDataSet.Session) then
    OracleDataSet.Session.Commit
  else
    raise Exception.Create('Impossibile eseguire il commit su un dataset senza sessione assegnata');
end;

procedure TWM000FDataSetMW.Rollback;
begin
  if Assigned(OracleDataSet.Session) then
    OracleDataSet.Session.Rollback
  else
    raise Exception.Create('Impossibile eseguire il rollback su un dataset senza sessione assegnata');
end;

function TWM000FDataSetMW.GetRowId: String;
begin
  if FDataSet.Active then
  begin
    if FTipoDataSet = tdOracleDataSet then
      OracleDataSet.RowId
    else
      raise Exception.Create('Il dataset non è di tipo TOracleDataSet');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWM000FDataSetMW.First: Boolean;
begin
  if FDataSet.Active then
  begin
    FDataSet.First;
    Result:=True;
  end
  else
    Result:=False;
end;

function TWM000FDataSetMW.Next: Boolean;
begin
  if not FDataSet.Active then
    Result:=False
  else if FDataSet.Eof then
    Result:=False
  else
  begin
    FDataSet.Next;
    Result:=True;
  end;
end;

function TWM000FDataSetMW.Prior: Boolean;
begin
  if not FDataSet.Active then
    Result:=False
  else if FDataSet.RecNo = 0 then
    Result:=False
  else
  begin
    FDataSet.Prior;
    Result:=True;
  end;
end;

function TWM000FDataSetMW.Last: Boolean;
begin
  if not FDataSet.Active then
    Result:=False
  else if FDataSet.RecNo = 0 then
    Result:=False
  else
  begin
    FDataSet.Last;
    Result:=True;
  end;
end;

function TWM000FDataSetMW.GetEof: Boolean;
begin
  if not FDataSet.Active then
    Result:=True
  else
    Result:=FDataSet.Eof;
end;

function TWM000FDataSetMW.FirstField: Boolean;
begin
  if not FDataSet.Active then
    Result:=False
  else if FDataSet.FieldCount = 0 then
    Result:=False
  else
  begin
    FieldIndex:=0;
    Result:=True;
  end;
end;

function TWM000FDataSetMW.NextField: Boolean;
begin
  if not FDataSet.Active then
    Result:=False
  else if FDataSet.FieldCount = 0 then
    Result:=False
  else if FieldIndex = FDataSet.FieldCount - 1 then
    Result:=False
  else
  begin
    FieldIndex:=FieldIndex+1;
    Result:=True;
  end;
end;

function TWM000FDataSetMW.PriorField: Boolean;
begin
  if not FDataSet.Active then
    Result:=False
  else if FDataSet.FieldCount = 0 then
    Result:=False
  else if FieldIndex = 0 then
    Result:=False
  else
  begin
    FieldIndex:=FieldIndex-1;
    Result:=True;
  end;
end;

function TWM000FDataSetMW.LastField: Boolean;
begin
  if not FDataSet.Active then
    Result:=False
  else if FDataSet.FieldCount = 0 then
    Result:=False
  else
  begin
    FieldIndex:=FDataSet.FieldCount-1;
    Result:=True;
  end;
end;

function TWM000FDataSetMW.GetEofField: Boolean;
begin
  if not FDataSet.Active then
    Result:=True
  else if FDataSet.RecordCount = 0 then
    Result:=True
  else if FieldIndex = FDataSet.FieldCount - 1 then
    Result:=True
  else
    Result:=False;
end;

function TWM000FDataSetMW.GetRecNo: Integer;
begin
  if not FDataSet.Active then
    Result:=-1
  else
    Result:=FDataSet.RecNo;
end;

procedure TWM000FDataSetMW.SetRecNo(const Value: Integer);
begin
  if FDataSet.Active then
    FDataSet.RecNo:=Value;
end;


function TWM000FDataSetMW.GetRecordCount: Integer;
begin
  if not FDataSet.Active then
    Result:=0
  else
    Result:=FDataSet.RecordCount;
end;

function TWM000FDataSetMW.GetPrecEnabled: Boolean;
begin
  if not FDataSet.Active then
    Result:=False
  else if FDataSet.RecordCount = 0 then
    Result:=False
  else
    Result:=FDataSet.RecNo > 1;
end;

function TWM000FDataSetMW.GetSuccEnabled: Boolean;
begin
  if not FDataSet.Active then
    Result:=False
  else if FDataSet.RecordCount = 0 then
    Result:=False
  else
    Result:=FDataSet.RecNo < FDataSet.RecordCount;
end;

function TWM000FDataSetMW.GetFieldLabel: String;
begin
  if FDataSet.Active then
    Result:=FDataSet.Fields[FieldIndex].DisplayLabel
  else
    Result:='';
end;

function TWM000FDataSetMW.GetFieldName: String;
begin
  if FDataSet.Active then
    Result:=FDataSet.Fields[FieldIndex].FieldName
  else
    Result:='';
end;

function TWM000FDataSetMW.GetFieldText: String;
begin
  if not FDataSet.Active then
    Result:=''
  else if FDataSet.RecordCount = 0 then
    Result:=''
  else
    Result:=FDataSet.Fields[FieldIndex].DisplayText;
end;

function TWM000FDataSetMW.Locate(AKeyField: String; AKeyValues: Variant; AOptions: TLocateOptions): Boolean;
begin
  if FDataSet.Active then
    Result:=FDataSet.Locate(AKeyField, AKeyValues, AOptions)
  else
    Result:=False;
end;

end.
