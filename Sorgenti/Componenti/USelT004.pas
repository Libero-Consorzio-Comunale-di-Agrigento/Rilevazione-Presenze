unit USelT004;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, OracleData, Oracle, Variants, A000UCostanti;

type
  TselT004 = class(TOracleDataSet)
  private
    FAzienda: String;
    FData: TDateTime;
    procedure SetAzienda(const Value: String);
    procedure SetData(const Value: TDateTime);
    function GetImmagine: TBlobField;
    function GetEsisteImmagine: Boolean;
    function GetLarghezzaCedolino: Integer;
    function GetLarghezzaCartellino: Integer;
  public
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    property Azienda:String read FAzienda write SetAzienda;
    property Data:TDateTime read FData write SetData;
    property EsisteImmagine:Boolean read GetEsisteImmagine;
    property Immagine:TBlobField read GetImmagine;
    property LarghezzaCedolino:Integer read GetLarghezzaCedolino;
    property LarghezzaCartellino:Integer read GetLarghezzaCartellino;
  end;


implementation

constructor TselT004.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  ReadBuffer:=2;
  SQL.Text:='select T004.IMMAGINE,T004.LARGHEZZA_CEDOLINO from T004_IMMAGINI T004, T440_AZIENDE_BASE T440 where T440.CODICE = :AZIENDA and T440.LOGO = T004.CODICE and :DATA between T004.DECORRENZA and T004.DECORRENZA_FINE';
  DeclareVariable('AZIENDA',otString);
  DeclareVariable('DATA',otDate);
  FAzienda:='';
  FData:=0;
  Azienda:=T440AZIENDA_BASE;
  Data:=Date;
end;

destructor TselT004.Destroy;
begin
  Close;
  inherited Destroy;
end;

procedure TselT004.SetAzienda(const Value: String);
begin
  if Value <> FAzienda then
  begin
    FAzienda:=Value;
    SetVariable('AZIENDA',Value);
    Close;
  end;
end;

procedure TselT004.SetData(const Value: TDateTime);
begin
  if Value <> FData then
  begin
    FData:=Value;
    SetVariable('DATA',Value);
    Close;
  end;
end;

function TselT004.GetEsisteImmagine: Boolean;
begin
  Open;
  Result:=(RecordCount > 0) and (not FieldByName('IMMAGINE').IsNull);
end;

function TselT004.GetImmagine: TBlobField;
begin
  Open;
  Result:=TBlobField(FieldByName('IMMAGINE'));
end;

function TselT004.GetLarghezzaCedolino: Integer;
begin
  Open;
  Result:=FieldByName('LARGHEZZA_CEDOLINO').AsInteger;
end;

function TselT004.GetLarghezzaCartellino: Integer;
begin
  Open;
  Result:=FieldByName('LARGHEZZA_CEDOLINO').AsInteger;
end;

end.
