unit A088URegoleIterMissioniDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, A000UInterfaccia, Oracle,
  QueryPK, C180FunzioniGenerali;

type
  TA088FRegoleIterMissioniDtM = class(TR004FGestStoricoDtM)
    selM012: TOracleDataSet;
    selM012REGOLA: TStringField;
    selM012ESTERO: TStringField;
    selM012ISPETTIVA: TStringField;
    selM012TIPO_MISSIONE: TStringField;
    selM010: TOracleDataSet;
    selM011: TOracleDataSet;
    selM012D_TIPO_MISSIONE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selM012ESTEROValidate(Sender: TField);
    procedure selM012ISPETTIVAValidate(Sender: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A088FRegoleIterMissioniDtM: TA088FRegoleIterMissioniDtM;

implementation

{$R *.dfm}

procedure TA088FRegoleIterMissioniDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selM012,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  selM012.Open;
end;

procedure TA088FRegoleIterMissioniDtM.selM012ESTEROValidate(Sender: TField);
begin
  if not R180In(Sender.Value,['S','N']) then
    raise Exception.Create('Specificare S oppure N!');
end;

procedure TA088FRegoleIterMissioniDtM.selM012ISPETTIVAValidate(Sender: TField);
begin
  if not R180In(Sender.Value,['S','N']) then
    raise Exception.Create('Specificare S oppure N!');
end;

procedure TA088FRegoleIterMissioniDtM.BeforeDelete(DataSet: TDataSet);
// Controlli per cancellazione record
var
  Q: TOracleQuery;
begin
  inherited;

  // verifica che il codice non sia utilizzato
  Q:=TOracleQuery.Create(nil);
  try
    Q.Session:=SessioneOracle;
    Q.SQL.Add('select count(*) from M140_RICHIESTE_MISSIONI');
    Q.SQL.Add('where  TIPOREGISTRAZIONE = ''' + selM012.FieldByName('TIPO_MISSIONE').AsString + '''');
    Q.Execute;
    if Q.FieldAsInteger(0) > 0 then
      raise Exception.Create('Il codice è utilizzato nelle richieste di trasferta' + CRLF +
                             'effettuate dall''applicativo IrisWeb.' + CRLF +
                             'Cancellazione impossibile!');
  finally
    Q.Free;
  end;
end;

procedure TA088FRegoleIterMissioniDtM.BeforePostNoStorico(DataSet: TDataSet);
begin
  // codice deve essere valorizzato
  if (selM012.FieldByName('REGOLA').IsNull) or
     (Trim(selM012.FieldByName('REGOLA').AsString) = '') then
    raise Exception.Create('Il codice della regola non può essere nullo!');

  // tipo missione deve essere valorizzato
  if (selM012.FieldByName('TIPO_MISSIONE').IsNull) or
     (Trim(selM012.FieldByName('TIPO_MISSIONE').AsString) = '') then
    raise Exception.Create(Format('Il codice del tipo missione da associare alla regola %s non può essere nullo!',[selM012.FieldByName('REGOLA').AsString]));

  inherited;
end;

end.
