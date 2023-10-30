unit W049UAutocertificazioneDatiGiuridiciDM;

interface

uses
  System.SysUtils, System.Classes, Oracle, OracleData, A000UInterfaccia, Data.DB,
  Variants, StrUtils, C180FunzioniGenerali, W000UMessaggi,
  A000USessione, A202URapportiLavoroMW;

type
  TW049FAutocertificazioneDatiGiuridiciDM = class(TDataModule)
    selT055Copy: TOracleDataSet;
    DateTimeField1: TDateTimeField;
    DateTimeField2: TDateTimeField;
    StringField3: TStringField;
    selT040: TOracleDataSet;
    selT040DATA: TDateField;
    selT425T430Durata: TOracleDataSet;
    selT425T430DurataGG_SERVIZIO2: TFloatField;
    selT425T430DurataGG_ASPETTATIVA: TFloatField;
    selPeriodo: TOracleQuery;
    selT040T055Durata: TOracleDataSet;
    selT040T055DurataGG_ASPETTATIVA: TFloatField;
    selT425: TOracleDataSet;
    selT425PROGRESSIVO: TFloatField;
    selT425VALIDAZIONE: TStringField;
    selT425INIZIO: TDateTimeField;
    selT425FINE: TDateTimeField;
    selT425ENTE: TStringField;
    selT425d_ENTE: TStringField;
    selT425TIPORAPPORTO: TStringField;
    selT425d_TIPORAPPORTO: TStringField;
    selT425d_TIPO: TStringField;
    selT425PARTTIME: TStringField;
    selT425d_PARTTIME: TStringField;
    selT425d_INDPRESPT: TFloatField;
    selT425d_TIPOPT: TStringField;
    selT425QUALIFICA: TStringField;
    selT425d_QUALIFICA: TStringField;
    selT425DISCIPLINA: TStringField;
    selT425d_DISCIPLINA: TStringField;
    selT425NOTE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT425CalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    selAnagrafeW: TOracleDataSet;
    A202MW:TA202FRapportiLavoroMW;
    //function GetGiorniServizio(pSoloTI: Boolean): integer;
  end;

var
  W049FAutocertificazioneDatiGiuridiciDM: TW049FAutocertificazioneDatiGiuridiciDM;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TW049FAutocertificazioneDatiGiuridiciDM.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle
    else if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;

  A202MW:=TA202FRapportiLavoroMW.Create(nil);
  A202MW.ModalitaA202:=PASSENZE;

  A202MW.SetVariabiliGiuridico;

  A202MW.ImpostaCampiLookupT425(selT425);
  A202MW.ImpostaCampiLookup(A202MW.selT430);

  With A202MW.selT430 do
  begin
    FieldByName('DAL').Visible:=True;
    FieldByName('AL').Visible:=True;
    FieldByName('INIZIO').Visible:=False;
    FieldByName('FINE').Visible:=False;
    FieldByName('INIZIO_RAPGIUR').Visible:=False;
    FieldByName('FINE_RAPGIUR').Visible:=False;
  end;

  A202MW.selT425:=selT425;
end;

procedure TW049FAutocertificazioneDatiGiuridiciDM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A202MW);
  inherited;
end;

procedure TW049FAutocertificazioneDatiGiuridiciDM.selT425CalcFields(DataSet: TDataSet);
begin
  A202MW.selT425CalcFields(Dataset);
end;

end.
