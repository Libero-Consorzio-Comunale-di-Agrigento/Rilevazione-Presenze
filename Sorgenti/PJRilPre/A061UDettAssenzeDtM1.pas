unit A061UDettAssenzeDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, Oracle, OracleData,  StrUtils,
  Crtl, DBClient, Variants, USelI010, C180FunzioniGenerali;

type
  TA061FDettAssenzeDtM1 = class(TDataModule)
    D010: TDataSource;
    QGiustificativiAssenza: TOracleDataSet;
    Q265: TOracleDataSet;
    TabellaStampa: TClientDataSet;
    GetCalendario: TOracleQuery;
    selT255: TOracleDataSet;
    selT255DESCRIZIONE: TStringField;
    D255: TDataSource;
    selT256: TOracleDataSet;
    selT255COD_TIPOACCORPCAUSALI: TStringField;
    procedure A061FDettAssenzeDtM1Create(Sender: TObject);
    procedure A061FDettAssenzeDtM1Destroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    selI010:TselI010;
    procedure CreaTabellaStampa;
  end;

var
  A061FDettAssenzeDtM1: TA061FDettAssenzeDtM1;

implementation

uses  A061UDettAssenze;

{$R *.DFM}

procedure TA061FDettAssenzeDtM1.A061FDettAssenzeDtM1Create(Sender: TObject);
{Preparo le query Mensili}
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
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','','NOME_LOGICO');
  D010.DataSet:=selI010;
  selT255.Open;
  Q265.SetVariable('COD_ACC','''''');
  Q265.Open;
end;

procedure TA061FDettAssenzeDtM1.CreaTabellaStampa;
begin
  TabellaStampa.Close;
  TabellaStampa.FieldDefs.Clear;
  TabellaStampa.FieldDefs.Add('Gruppo',ftString,90,False);
  TabellaStampa.FieldDefs.Add('Cognome',ftString,60,False);
  TabellaStampa.FieldDefs.Add('Badge',ftString,8,False);
  TabellaStampa.FieldDefs.Add('Data',ftDateTime,0,False);
  TabellaStampa.FieldDefs.Add('Prog',ftAutoInc,0,False);
  TabellaStampa.FieldDefs.Add('DataAl',ftDateTime,0,False);
  TabellaStampa.FieldDefs.Add('Operazione',ftString,4,False);
  TabellaStampa.FieldDefs.Add('Matricola',ftString,8,False);
  TabellaStampa.FieldDefs.Add('Causale',ftString,10,False);
  TabellaStampa.FieldDefs.Add('DataNas',ftDate);  //Lorena 26/07/2005
  TabellaStampa.FieldDefs.Add('GradoPar',ftString,2);  //Alberto 14/11/2010
  TabellaStampa.FieldDefs.Add('Descrizione',ftString,40,False);
  TabellaStampa.FieldDefs.Add('Giorni',ftFloat,0,False);
  TabellaStampa.FieldDefs.Add('Minuti',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('Riduz',ftString,1,False);
  TabellaStampa.FieldDefs.Add('UM',ftString,1,False);
  TabellaStampa.FieldDefs.Add('Percent',ftString,30,False);
  TabellaStampa.FieldDefs.Add('Fruito',ftString,40,False);
  TabellaStampa.FieldDefs.Add('ValGio',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('MinutiCont',ftInteger,0,False); //Lorena 31/08/2011
  TabellaStampa.FieldDefs.Add('Inizio',ftDateTime,0,False);
  TabellaStampa.FieldDefs.Add('Fine',ftDateTime,0,False);
  TabellaStampa.IndexDefs.Clear;
  TabellaStampa.IndexDefs.Add('Primario',('Gruppo;Cognome;Badge;Operazione;Data;Prog'),[ixUnique]);
  TabellaStampa.IndexDefs.Add('Secondario',('Gruppo;Cognome;Badge;Operazione;Causale;Data;Prog'),[ixUnique]);
  TabellaStampa.IndexName:=IfThen(A061FDettAssenze.rgpOrdinamento.ItemIndex = 1,'Secondario','Primario');
  TabellaStampa.CreateDataSet;
  TabellaStampa.LogChanges:=False;
end;

procedure TA061FDettAssenzeDtM1.A061FDettAssenzeDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).Close;
  FreeAndNil(selI010);
end;

end.
