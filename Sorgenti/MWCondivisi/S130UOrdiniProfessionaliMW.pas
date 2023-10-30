unit S130UOrdiniProfessionaliMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Oracle, Data.DB,
  OracleData, A000UInterfaccia, A000USessione, A000UCostanti;

type
  TS130StrList = procedure (lista :TStringList) of object;

  TS130FOrdiniProfessionaliMW = class(TR005FDataModuleMW)
    selC36OrdiniProfessionali: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    {$IFDEF IRISWEB}
    SolaLettura:Boolean;
    {$ENDIF}
    Max:Integer;
  public
    selSG221: TOracleDataSet;
    procedure selSG221BeforeOpen;
  end;

implementation

{$R *.dfm}

procedure TS130FOrdiniProfessionaliMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  if A000LookupTabella(Parametri.CampiRiferimento.C36_OrdProfSanCodice,selC36OrdiniProfessionali) then
  begin
    if selC36OrdiniProfessionali.VariableIndex('DECORRENZA') >= 0 then
      selC36OrdiniProfessionali.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
    selC36OrdiniProfessionali.Open;
  end
  else
   SolaLettura:=True;
end;

procedure TS130FOrdiniProfessionaliMW.selSG221BeforeOpen;
begin
  with selC36OrdiniProfessionali do
  begin
    Max:=0;
    while not EOF do
    begin
      if Length(FieldByName('CODICE').AsString) > Max then
        Max:=Max+Length(FieldByName('CODICE').AsString)+1;
      Next;
    end;
    selSG221.FieldByName('QUALIFICHE_COLLEGATE').DisplayWidth:=Max;
  end;
end;

end.
