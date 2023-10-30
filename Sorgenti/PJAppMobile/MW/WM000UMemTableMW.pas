unit WM000UMemTableMW;

interface

uses
  A000UCostanti,
  B110UClientModule,
  B110USharedTypes,
  Data.FireDACJSONReflect,
  FireDAC.Comp.Client,
  System.Generics.Collections,
  System.Sensors, C200UWebServicesTypes, C200UWebServicesUtils, System.SysUtils, System.Classes,
  System.StrUtils, FunzioniGenerali, System.Math, WM000UConstants, Data.DB;

type

  TWM000FMemTableMW = class(TObject)
    private
      function GetRecordCount: Integer;
      function GetPrecEnabled: Boolean;
      function GetSuccEnabled: Boolean;
      function GetEof: Boolean;
      function GetRecNo: Integer;
      procedure SetRecNo(const Value: Integer);


      function GetEofField: Boolean;
    protected
      FDMemTable: TFDMemTable;
      FieldIndex: Integer;

      function GetFieldLabel: String; virtual;
      function GetFieldText: String; virtual;
    public
      constructor Create;
      destructor Destroy; override;

      property FieldLabel: String read GetFieldLabel;
      property FieldText: String read GetFieldText;

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

  end;

implementation

constructor TWM000FMemTableMW.Create;
begin
  inherited Create;

  FDMemTable:=TFDMemTable.Create(nil);
  FieldIndex:=0;
end;

destructor TWM000FMemTableMW.Destroy;
begin
  if FDMemTable.Active then
    FDMemTable.Close;

  FreeAndNil(FDMemTable);
  inherited;
end;

function TWM000FMemTableMW.First: Boolean;
begin
  if FDMemTable.Active then
  begin
    FDMemTable.First;
    Result:=True;
  end
  else
    Result:=False;
end;

function TWM000FMemTableMW.Next: Boolean;
begin
  if not FDMemTable.Active then
    Result:=False
  else if FDMemTable.Eof then
    Result:=False
  else
  begin
    FDMemTable.Next;
    Result:=True;
  end;
end;

function TWM000FMemTableMW.Prior: Boolean;
begin
  if not FDMemTable.Active then
    Result:=False
  else if FDMemTable.RecNo = 0 then
    Result:=False
  else
  begin
    FDMemTable.Prior;
    Result:=True;
  end;
end;

function TWM000FMemTableMW.Last: Boolean;
begin
  if not FDMemTable.Active then
    Result:=False
  else if FDMemTable.RecNo = 0 then
    Result:=False
  else
  begin
    FDMemTable.Last;
    Result:=True;
  end;
end;

function TWM000FMemTableMW.GetEof: Boolean;
begin
  if not FDMemTable.Active then
    Result:=True
  else
    Result:=FDMemTable.Eof;
end;

function TWM000FMemTableMW.FirstField: Boolean;
begin
  if not FDMemTable.Active then
    Result:=False
  else if FDMemTable.FieldCount = 0 then
    Result:=False
  else
  begin
    FieldIndex:=0;
    Result:=True;
  end;
end;

function TWM000FMemTableMW.NextField: Boolean;
begin
  if not FDMemTable.Active then
    Result:=False
  else if FDMemTable.FieldCount = 0 then
    Result:=False
  else if FieldIndex = FDMemTable.FieldCount - 1 then
    Result:=False
  else
  begin
    FieldIndex:=FieldIndex+1;
    Result:=True;
  end;
end;

function TWM000FMemTableMW.PriorField: Boolean;
begin
  if not FDMemTable.Active then
    Result:=False
  else if FDMemTable.FieldCount = 0 then
    Result:=False
  else if FieldIndex = 0 then
    Result:=False
  else
  begin
    FieldIndex:=FieldIndex-1;
    Result:=True;
  end;
end;

function TWM000FMemTableMW.LastField: Boolean;
begin
  if not FDMemTable.Active then
    Result:=False
  else if FDMemTable.FieldCount = 0 then
    Result:=False
  else
  begin
    FieldIndex:=FDMemTable.FieldCount-1;
    Result:=True;
  end;
end;

function TWM000FMemTableMW.GetEofField: Boolean;
begin
  if not FDMemTable.Active then
    Result:=True
  else if FDMemTable.RecordCount = 0 then
    Result:=True
  else if FieldIndex = FDMemTable.FieldCount - 1 then
    Result:=True
  else
    Result:=False;
end;

function TWM000FMemTableMW.GetRecNo: Integer;
begin
  if not FDMemTable.Active then
    Result:=-1
  else
    Result:=FDMemTable.RecNo;
end;

procedure TWM000FMemTableMW.SetRecNo(const Value: Integer);
begin
  if FDMemTable.Active then
    FDMemTable.RecNo:=Value;
end;


function TWM000FMemTableMW.GetRecordCount: Integer;
begin
  if not FDMemTable.Active then
    Result:=0
  else
    Result:=FDMemTable.RecordCount;
end;

function TWM000FMemTableMW.GetPrecEnabled: Boolean;
begin
  if not FDMemTable.Active then
    Result:=False
  else if FDMemTable.RecordCount = 0 then
    Result:=False
  else
    Result:=FDMemTable.RecNo > 1;
end;

function TWM000FMemTableMW.GetSuccEnabled: Boolean;
begin
  if not FDMemTable.Active then
    Result:=False
  else if FDMemTable.RecordCount = 0 then
    Result:=False
  else
    Result:=FDMemTable.RecNo < FDMemTable.RecordCount;
end;

function TWM000FMemTableMW.GetFieldLabel: String;
begin
  if FDMemTable.Active then
    Result:=FDMemTable.Fields[FieldIndex].DisplayLabel
  else
    Result:='';
end;

function TWM000FMemTableMW.GetFieldText: String;
begin
  if not FDMemTable.Active then
    Result:=''
  else if FDMemTable.RecordCount = 0 then
    Result:=''
  else
    Result:=FDMemTable.Fields[FieldIndex].DisplayText;
end;

function TWM000FMemTableMW.Locate(AKeyField: String; AKeyValues: Variant; AOptions: TLocateOptions): Boolean;
begin
  if FDMemTable.Active then
    Result:=FDMemTable.Locate(AKeyField, AKeyValues, AOptions)
  else
    Result:=False;
end;

end.
