unit A205USquadreMW;

interface

uses
  System.SysUtils, System.Classes, OracleData, Data.DB, Oracle, Variants,
  R005UDataModuleMW, A000UMessaggi, A000USessione, C180FunzioniGenerali;

type
  TA205ShowMsg = procedure(Msg: String) of object;

  TA205FSquadreMW = class(TR005FDataModuleMW)
    selT651: TOracleDataSet;
    selT651CODICE_OPERATORE: TStringField;
    selT651DESCRIZIONE_AREA: TStringField;
    selT651CODICE_SQUADRA: TStringField;
    selT651CODICE_AREA: TStringField;
    dsrT651: TDataSource;
    selT650: TOracleDataSet;
    selT265: TOracleDataSet;
    dsrT265: TDataSource;
    selT640: TOracleDataSet;
    delT651: TOracleQuery;
    selT430: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT603AfterScroll;
    procedure selT603NewRecord;
    procedure selT603BeforeDelete;
    procedure selT603BeforePost;
    procedure selT603AfterPost;
    procedure selT603FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT651NewRecord(DataSet: TDataSet);
    procedure selT651AfterPost(DataSet: TDataSet);
  private
    VecchioCodiceDizionario:String;
    { Private declarations }
  public
    { Public declarations }
    selT603: TOracleDataSet;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA205FSquadreMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT265.Open;
  selT640.Open;
end;

procedure TA205FSquadreMW.selT603AfterPost;
begin
  A000AggiornaFiltroDizionario('SQUADRE TURNI',VecchioCodiceDizionario,selT603.FieldByName('CODICE').AsString);
end;

procedure TA205FSquadreMW.selT603AfterScroll;
begin
  selT651.Close;
  selT651.SetVariable('CODICE_SQUADRA',selT603.FieldByName('CODICE').AsString);
  selT651.Open;
  //Prelevo elenco dei tipi operatori usati in anagrafica nel periodo di validità
  selT430.Close;
  selT430.SetVariable('COD_SQUADRA',selT603.FieldByName('CODICE').AsString);
  selT430.SetVariable('INIZIO_VALIDITA',selT603.FieldByName('INIZIO_VALIDITA').AsDateTime);
  selT430.SetVariable('FINE_VALIDITA',selT603.FieldByName('FINE_VALIDITA').AsDateTime);
  selT430.Open;
end;

procedure TA205FSquadreMW.selT603NewRecord;
begin
  selT603.FieldByName('INIZIO_VALIDITA').AsDateTime:=EncodeDate(1900,1,1);
  selT603.FieldByName('FINE_VALIDITA').AsDateTime:=EncodeDate(3999,12,31);
end;

procedure TA205FSquadreMW.selT603BeforeDelete;
begin
  delT651.SetVariable('CODICE_SQUADRA',selT603.FieldByName('CODICE').AsString);
  delT651.Execute;
  A000AggiornaFiltroDizionario('SQUADRE TURNI',selT603.FieldByName('CODICE').AsString,'');
end;

procedure TA205FSquadreMW.selT603BeforePost;
begin
  if selT603.State = dsEdit then
    VecchioCodiceDizionario:=VarToStr(selT603.FieldByName('CODICE').medpOldValue)
  else
    VecchioCodiceDizionario:='';
end;

procedure TA205FSquadreMW.selT603FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('SQUADRE TURNI',DataSet.FieldByName('CODICE').AsString);
end;

procedure TA205FSquadreMW.selT651AfterPost(DataSet: TDataSet);
begin
  inherited;
  if not selT430.SearchRecord('TIPOOPE',selT651.FieldByName('CODICE_OPERATORE').AsString,[srFromBeginning]) then
    R180MessageBox(Format(A000MSG_A205_MSG_FMT_TIPOOPE_NON_TROVATO,[selT651.FieldByName('CODICE_OPERATORE').AsString,
                                                                    selT651.FieldByName('CODICE_SQUADRA').AsString,
                                                                    selT603.FieldByName('INIZIO_VALIDITA').AsString,
                                                                    selT603.FieldByName('FINE_VALIDITA').AsString]),INFORMA);
end;

procedure TA205FSquadreMW.selT651NewRecord(DataSet: TDataSet);
begin
  inherited;
  selT651.FieldByName('CODICE_SQUADRA').AsString:=selT603.FieldByName('CODICE').AsString;
end;

end.
