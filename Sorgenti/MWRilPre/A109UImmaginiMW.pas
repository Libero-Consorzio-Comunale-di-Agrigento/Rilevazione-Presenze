unit A109UImmaginiMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, A000UInterfaccia, Oracle, OracleData, DB;

type
  TA109FimmaginiMW = class(TR005FDataModuleMW)
    scrT004References: TOracleQuery;
  private
    function GetImmagineUsata(Codice:String):Boolean;
  public
    { Public declarations }
    procedure BeforeDelete(DataSet:TDataSet);
    property ImmagineUsata[Codice:String]:Boolean read GetImmagineUsata;
  end;

implementation

{$R *.dfm}

{ TA109FimmaginiMW }

function TA109FimmaginiMW.GetImmagineUsata(Codice: String): Boolean;
begin
  Result:=False;
  with scrT004References do
  begin
    SetVariable('CODICE',Codice);
    Execute;
    if GetVariable('RESULT') <> null then
    begin
      Result:=True;
    end;
  end;
end;

procedure TA109FimmaginiMW.BeforeDelete(DataSet:TDataSet);
begin
  if ImmagineUsata[DataSet.FieldByName('CODICE').AsString] then
    raise Exception.Create('Immagine utilizzata dall''applicativo: impossibile eliminarla');
end;

end.
