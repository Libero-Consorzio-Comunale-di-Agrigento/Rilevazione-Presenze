unit A204UModelliCertificazioneDtM;

interface

uses
  System.SysUtils, System.Classes, R004UGestStoricoDTM, Data.DB, OracleData,
  A204UModelliCertificazioneMW;

type
  TA204FModelliCertificazioneDtM = class(TR004FGestStoricoDtM)
    selSG235: TOracleDataSet;
    selSG235CODICE: TStringField;
    selSG235DESCRIZIONE: TStringField;
    selSG236: TOracleDataSet;
    selSG236CODICE: TStringField;
    selSG236DESCRIZIONE: TStringField;
    dsrSG236: TDataSource;
    selSG237: TOracleDataSet;
    selSG237CODICE: TStringField;
    selSG237DESCRIZIONE: TStringField;
    selSG237CATEGORIA: TStringField;
    selSG237ORDINE: TIntegerField;
    selSG237OBBLIGATORIO: TStringField;
    selSG237RIGHE: TIntegerField;
    selSG237FORMATO: TStringField;
    selSG237LUNG_MAX: TIntegerField;
    selSG237ELENCO_FISSO: TStringField;
    selSG237VALORI: TStringField;
    selSG237DATO_ANAGRAFICO: TStringField;
    selSG237QUERY_VALORE: TStringField;
    selSG237VALORE_DEFAULT: TStringField;
    dsrSG237: TDataSource;
    selSG235AUTOCERTIFICAZIONE: TStringField;
    selSG235PERIODO: TStringField;
    selSG235UM: TStringField;
    selSG235QUANTITA: TIntegerField;
    selSG236ORDINE: TIntegerField;
    selSG235ID: TFloatField;
    selSG236ID: TFloatField;
    selSG237HINT: TStringField;
    selSG235SELEZIONE_ANAGRAFE: TStringField;
    selSG235INIZIO_VALIDITA: TDateTimeField;
    selSG235FINE_VALIDITA: TDateTimeField;
    selSG237ID: TFloatField;
    selSG235PERIODO_MODIFICABILE: TStringField;
    selSG235ORDINE: TIntegerField;
    selSG237VALIDAZIONE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure PopolaListeValori;
    procedure selSG235AfterScroll(DataSet: TDataSet);
    procedure selSG236AfterScroll(DataSet: TDataSet);
    procedure selSG235BeforePost(DataSet: TDataSet);
    procedure selSG236BeforePost(DataSet: TDataSet);
    procedure selSG237BeforePost(DataSet: TDataSet);
    procedure selSG236NewRecord(DataSet: TDataSet);
    procedure selSG237NewRecord(DataSet: TDataSet);
  private
    { Private declarations }
    A204MW: TA204FModelliCertificazioneMW;
  public
    { Public declarations }
  end;

implementation

uses A204UModelliCertificazione;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA204FModelliCertificazioneDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selSG235,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);

  selSG235.Open;
  selSG235.First;
  A204MW:=TA204FModelliCertificazioneMW.Create(Self);
  A204MW.selSG235:=selSG235;
  A204MW.selSG236:=selSG236;
  A204MW.selSG237:=selSG237;
end;

procedure TA204FModelliCertificazioneDtM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A204MW);
  inherited;
end;

procedure TA204FModelliCertificazioneDtM.PopolaListeValori;
// popola le picklist per alcuni dati nella grid dei dati liberi (detail)
begin
  // popola picklist di DATO_ANAGRAFICO
  with A204MW.selT430Colonne do
  begin
    Open;
    First;
    while not Eof do
    begin
      A204FModelliCertificazione.dgrdDati.Columns[9].PickList.Add(FieldByName('COLUMN_NAME').AsString);
      Next;
    end;
  end;

  // popola picklist di QUERY_VALORE
  with A204MW.selT002 do
  begin
    Open;
    First;
    while not Eof do
    begin
      A204FModelliCertificazione.dgrdDati.Columns[10].PickList.Add(FieldByName('NOME').AsString);
      Next;
    end;
  end;
end;

procedure TA204FModelliCertificazioneDtM.selSG235AfterScroll(DataSet: TDataSet);
begin
  inherited;
  with selSG236 do
  begin
    Close;
    SetVariable('ID',selSG235.FieldByName('ID').AsFloat);
    Open;
    if RecordCount = 0 then
    begin
      selSG237.Close;
      selSG237.SetVariable('ID',selSG235.FieldByName('ID').AsFloat);
      selSG237.SetVariable('CATEGORIA','');
      Open;
    end;
  end;
end;

procedure TA204FModelliCertificazioneDtM.selSG236AfterScroll(DataSet: TDataSet);
begin
  inherited;
  with selSG237 do
  begin
    Close;
    SetVariable('ID',selSG235.FieldByName('ID').AsFloat);
    SetVariable('CATEGORIA',selSG236.FieldByName('CODICE').AsString);
    Open;
  end;
end;

procedure TA204FModelliCertificazioneDtM.selSG235BeforePost(DataSet: TDataSet);
begin
  inherited;
  A204MW.selSG235BeforePost;
end;

procedure TA204FModelliCertificazioneDtM.selSG236BeforePost(DataSet: TDataSet);
begin
  inherited;
  A204MW.selSG236BeforePost;
end;

procedure TA204FModelliCertificazioneDtM.selSG237BeforePost(DataSet: TDataSet);
begin
  inherited;
  A204MW.selSG237BeforePost;
end;

procedure TA204FModelliCertificazioneDtM.selSG236NewRecord(DataSet: TDataSet);
begin
  inherited;
  A204MW.selSG236NewRecord(selSG235.FieldByName('ID').AsFloat);
end;

procedure TA204FModelliCertificazioneDtM.selSG237NewRecord(DataSet: TDataSet);
begin
  inherited;
  A204MW.selSG237NewRecord(selSG236.FieldByName('ID').AsFloat, selSG236.FieldByName('CODICE').AsString);
end;

end.
