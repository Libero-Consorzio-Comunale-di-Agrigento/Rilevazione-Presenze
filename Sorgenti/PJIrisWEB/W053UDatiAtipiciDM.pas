unit W053UDatiAtipiciDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, OracleData, IWApplication, Oracle,
  A000UInterfaccia, WR010UBase, A000USessione;

type
  TW053FDatiAtipiciDM = class(TDataModule)
    selT077: TOracleDataSet;
    selI011: TOracleDataSet;
    selT077ABILITA: TStringField;
    selT077DATA: TDateTimeField;
    selT077DATO: TStringField;
    selT077VALORE_AUT: TStringField;
    selT077VALORE_MAN: TStringField;
    selT077MATRICOLA: TStringField;
    selT077COGNOME: TStringField;
    selT077NOME: TStringField;
    selT077PROGRESSIVO: TIntegerField;
    selGenera: TOracleDataSet;
    selT077MESSAGGI: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selI011FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT077CalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TW053FDatiAtipiciDM.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
  for i:=0 to ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      try (Components[i] as TOracleQuery).Session:=SessioneOracle; except end
    else if Components[i] is TOracleDataSet then
      try (Components[i] as TOracleDataSet).Session:=SessioneOracle; except end;
  end;
end;

procedure TW053FDatiAtipiciDM.DataModuleDestroy(Sender: TObject);
begin
  if GGetWebApplicationThreadVar = nil then
    exit;
end;

procedure TW053FDatiAtipiciDM.selI011FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('DATI ATIPICI',DataSet.FieldByName('DATO').AsString);
end;

procedure TW053FDatiAtipiciDM.selT077CalcFields(DataSet: TDataSet); //Assegnato a selT077 e a selGenera
var Blocco:Boolean;
begin
  selT077.FieldByName('ABILITA').AsString:='S';
  Blocco:=WR000DM.selDatiBloccati.DatoBloccato(selT077.FieldByName('PROGRESSIVO').AsInteger,selT077.FieldByName('DATA').AsDateTime,'T077');
  if (Self.Owner as TWR010FBase).SolaLettura
  or Blocco then
    selT077.FieldByName('ABILITA').AsString:='N';
  if Blocco then
    selT077.FieldByName('MESSAGGI').AsString:='Riepilogo T077 bloccato';
end;

end.
