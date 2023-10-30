unit WA204UModelliCertificazioneDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR303UGestMasterDetailDM, Data.DB, OracleData,
  A204UModelliCertificazioneMW, A000UCostanti;

type
  TMyProc = procedure of object;

  TWA204FModelliCertificazioneDM = class(TWR303FGestMasterDetailDM)
    dsrSG236: TDataSource;
    selSG236: TOracleDataSet;
    selSG236ID: TFloatField;
    selSG236CODICE: TStringField;
    selSG236DESCRIZIONE: TStringField;
    selSG236ORDINE: TIntegerField;
    selTabellaID: TFloatField;
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaAUTOCERTIFICAZIONE: TStringField;
    selTabellaPERIODO: TStringField;
    selTabellaUM: TStringField;
    selTabellaQUANTITA: TIntegerField;
    selTabellaSELEZIONE_ANAGRAFE: TStringField;
    selTabellaINIZIO_VALIDITA: TDateTimeField;
    selTabellaFINE_VALIDITA: TDateTimeField;
    selTabellaPERIODO_MODIFICABILE: TStringField;
    dsrSG237: TDataSource;
    selSG237: TOracleDataSet;
    selSG237ID: TFloatField;
    selSG237CATEGORIA: TStringField;
    selSG237CODICE: TStringField;
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
    selSG237HINT: TStringField;
    selSG237DESCRIZIONE: TStringField;
    selSG237VALORI_CALC: TStringField;
    selSG237DESCRIZIONE_CALC: TStringField;
    selSG237HINT_CALC: TStringField;
    selSG236DESCRIZIONE_CALC: TStringField;
    selSG237VALIDAZIONE: TStringField;
    selSG237VALIDAZIONE_CALC: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selSG236AfterScroll(DataSet: TDataSet);
    procedure selSG236AfterOpen(DataSet: TDataSet);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure selSG237CalcFields(DataSet: TDataSet);
    procedure selSG237BeforePost(DataSet: TDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selSG236BeforePost(DataSet: TDataSet);
    procedure selSG236NewRecord(DataSet: TDataSet);
    procedure selSG237NewRecord(DataSet: TDataSet);
    procedure selSG236CalcFields(DataSet: TDataSet);
  protected
    procedure RelazionaTabelleFiglie; override;
  private
    { Private declarations }
  public
    { Public declarations }
    A204MW: TA204FModelliCertificazioneMW;
    NotificaAfterScroll: TMyProc;
  end;

implementation

{$R *.dfm}

{ TWA204FModelliCertificazioneDM }

procedure TWA204FModelliCertificazioneDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  A204MW:=TA204FModelliCertificazioneMW.Create(nil);
  inherited;

  A204MW.selSG235:=selTabella;
  A204MW.selSG236:=selSG236;
  A204MW.selSG237:=selSG237;
end;

procedure TWA204FModelliCertificazioneDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A204MW);
end;

procedure TWA204FModelliCertificazioneDM.RelazionaTabelleFiglie;
begin
  with selSG236 do
  begin
    Close;
    SetVariable('ID',selTabella.FieldByName('ID').AsFloat);
    Open;
  end;
end;

procedure TWA204FModelliCertificazioneDM.selSG236AfterOpen(DataSet: TDataSet);
begin
  inherited;
  if DataSet.RecordCount = 0 then
    selSG236AfterScroll(DataSet);
end;

procedure TWA204FModelliCertificazioneDM.selSG236AfterScroll(DataSet: TDataSet);
begin
  inherited;
  with selSG237 do
  begin
    Close;
    SetVariable('ID',selTabella.FieldByName('ID').AsFloat);
    SetVariable('CATEGORIA',selSG236.FieldByName('CODICE').AsString);
    Open;
  end;
  if (Assigned(NotificaAfterScroll)) then
    NotificaAfterScroll;
end;

procedure TWA204FModelliCertificazioneDM.selSG237CalcFields(DataSet: TDataSet);
begin
  inherited;
  with selSG237 do
  begin
    FieldByName('VALORI_CALC').AsString:=StringReplace(FieldByName('VALORI').AsString,'<br>',CRLF,[rfReplaceAll]);
    FieldByName('DESCRIZIONE_CALC').AsString:=StringReplace(FieldByName('DESCRIZIONE').AsString,'<br>',CRLF,[rfReplaceAll]);
    FieldByName('VALIDAZIONE_CALC').AsString:=StringReplace(FieldByName('VALIDAZIONE').AsString,'<br>',CRLF,[rfReplaceAll]);
    FieldByName('HINT_CALC').AsString:=StringReplace(FieldByName('HINT').AsString,'<br>',CRLF,[rfReplaceAll]);
  end;
end;

procedure TWA204FModelliCertificazioneDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  selTabella.FieldByName('DESCRIZIONE').AsString:=Trim(selTabella.FieldByName('DESCRIZIONE').AsString);
  A204MW.selSG235BeforePost;
end;

procedure TWA204FModelliCertificazioneDM.selSG236BeforePost(DataSet: TDataSet);
begin
  inherited;
  A204MW.selSG236BeforePost;
end;

procedure TWA204FModelliCertificazioneDM.selSG236CalcFields(DataSet: TDataSet);
begin
  inherited;
  with selSG236 do
  begin
    FieldByName('DESCRIZIONE_CALC').AsString:=StringReplace(FieldByName('DESCRIZIONE').AsString,'<br>',CRLF,[rfReplaceAll]);
  end;
end;

procedure TWA204FModelliCertificazioneDM.selSG236NewRecord(DataSet: TDataSet);
begin
  inherited;
  A204MW.selSG236NewRecord(selTabella.FieldByName('ID').AsFloat);
end;

procedure TWA204FModelliCertificazioneDM.selSG237BeforePost(DataSet: TDataSet);
begin
  inherited;
  A204MW.selSG237BeforePost;
end;

procedure TWA204FModelliCertificazioneDM.selSG237NewRecord(DataSet: TDataSet);
begin
  inherited;
  A204MW.selSG237NewRecord(selSG236.FieldByName('ID').AsFloat, selSG236.FieldByName('CODICE').AsString);
end;

end.
