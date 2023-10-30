unit A157UCapitoliTrasferteMW;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R005UDataModuleMW, Data.DB, OracleData;

type
  TA157FCapitoliTrasferteMW = class(TR005FDataModuleMW)
    selM011: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetLstTipiMissione:TStringList;
  end;

var
  A157FCapitoliTrasferteMW: TA157FCapitoliTrasferteMW;

implementation

{$R *.dfm}

procedure TA157FCapitoliTrasferteMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selM011.Open;
end;

function TA157FCapitoliTrasferteMW.GetLstTipiMissione:TStringList;
begin
  Result:=TStringList.Create;
  with selM011 do
  begin
    First;
    while not Eof do
    begin
      Result.Add(Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
  end;
end;

end.
