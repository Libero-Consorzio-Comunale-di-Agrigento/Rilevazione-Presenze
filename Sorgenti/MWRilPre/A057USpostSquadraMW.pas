unit A057USpostSquadraMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, OracleData, Variants,
  A000UInterfaccia, A000UMessaggi, C180FunzioniGenerali;

type
  TA057FSpostSquadraMW = class(TR005FDataModuleMW)
    selT603: TOracleDataSet;
    selT603CODICE: TStringField;
    selT603DESCRIZIONE: TStringField;
    dsrT603: TDataSource;
    selT020: TOracleDataSet;
    selT020CODICE: TStringField;
    selT020DESCRIZIONE: TStringField;
    dsrT020: TDataSource;
    selT021: TOracleDataSet;
    selT021SIGLATURNI: TStringField;
    dsrT021: TDataSource;
    selT430: TOracleDataSet;
    selT430TIPOOPE: TStringField;
    dsrT430: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    selT630: TOracleDataSet;
    procedure RefreshDataSet;
    procedure selT630AfterScroll;
    procedure selT630CalcFields;
    procedure selT630NewRecord;
    procedure selT630BeforePost;
    procedure PulisciValori;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA057FSpostSquadraMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT603.SetVariable('DATA',Parametri.DataLavoro);
  selT603.Open;
  selT430.SetVariable('DECORRENZA',EncodeDate(1900,1,1));
  selT430.SetVariable('DECORRENZA_FINE',EncodeDate(3999,12,31));
  selT430.Open;
  selT020.SetVariable('DATA',Parametri.DataLavoro);
  selT020.SetVariable('COD_SQUADRA',selT603.FieldByName('CODICE').AsString);
  selT020.Open;
  selT021.SetVariable('CODICE',selT020.FieldByName('CODICE').AsString);
  selT021.Open;
end;

procedure TA057FSpostSquadraMW.RefreshDataSet;
begin
  if selT630 = nil then exit;
  R180SetVariable(selT603,'DATA',selT630.FieldByName('DATA').AsDateTime);
  selT603.Open;
  R180SetVariable(selT430,'DECORRENZA',R180InizioMese(selT630.FieldByName('DATA').AsDateTime));
  R180SetVariable(selT430,'DECORRENZA_FINE',R180FineMese(selT630.FieldByName('DATA').AsDateTime));
  selT430.Open;
  R180SetVariable(selT020,'DATA',selT630.FieldByName('DATA').AsDateTime);
  R180SetVariable(selT020,'COD_SQUADRA',selT630.FieldByName('SQUADRA').AsString);
  selT020.Open;
  R180SetVariable(selT021,'CODICE',selT630.FieldByName('ORARIO').AsString);
  selT021.Open;
end;

procedure TA057FSpostSquadraMW.selT630AfterScroll;
begin
  RefreshDataSet;
end;

procedure TA057FSpostSquadraMW.selT630CalcFields;
begin
  if selT630 = nil then exit;
  RefreshDataSet;
  selT630.FieldByName('DESC_SQUADRA').AsString:=VarToStr(selT603.Lookup('CODICE',selT630.FieldByName('SQUADRA').AsString,'DESCRIZIONE'));
  selT630.FieldByName('DESC_ORARIO').AsString:=VarToStr(selT020.Lookup('CODICE',selT630.FieldByName('ORARIO').AsString,'DESCRIZIONE'));
end;

procedure TA057FSpostSquadraMW.selT630NewRecord;
begin
  selT630.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  selT630.FieldByName('DATA').AsDateTime:=Parametri.DataLavoro;
end;

procedure TA057FSpostSquadraMW.selT630BeforePost;
begin
  PulisciValori;
  if Trim(selT630.FieldByName('SQUADRA').AsString) = '' then
    raise Exception.Create(A000MSG_A057_ERR_SQUADRA_NON_SPECIFICATA);
  if Trim(selT630.FieldByName('COD_TIPOOPE').AsString) = '' then
    raise Exception.Create(A000MSG_A057_ERR_TIPOOPE_NON_SPECIF);
  if Trim(selT630.FieldByName('ORARIO').AsString) = '' then
    raise Exception.Create(A000MSG_A057_ERR_ORARIO_NON_SPECIF);
  //Non permetto i due turni uguali
  if (selT630.FieldByName('TURNO1').AsString <> '') and (selT630.FieldByName('TURNO1').AsString = selT630.FieldByName('TURNO2').AsString) then
    raise Exception.Create(A000MSG_A057_ERR_PIANIF_TURNO_DOPPIO);
  //Non permetto di pianificare il secondo turno senza aver pianificato il primo
  if (selT630.FieldByName('TURNO1').AsString = '') and (selT630.FieldByName('TURNO2').AsString <> '') then
    raise Exception.Create(A000MSG_A057_ERR_PIANIF_SEC_TURNO);
end;

procedure TA057FSpostSquadraMW.PulisciValori;
begin
  if selT630 = nil then exit;
  if selT630.State in [dsEdit,dsInsert] then
  begin
    if (selT630.FieldByName('SQUADRA').AsString <> '')
    and (VarToStr(selT603.Lookup('CODICE',selT630.FieldByName('SQUADRA').AsString,'CODICE')) = '') then
      selT630.FieldByName('SQUADRA').AsString:='';
    if (selT630.FieldByName('COD_TIPOOPE').AsString <> '')
    and (VarToStr(selT430.Lookup('TIPOOPE',selT630.FieldByName('COD_TIPOOPE').AsString,'TIPOOPE')) = '') then
      selT630.FieldByName('COD_TIPOOPE').AsString:='';
    if (selT630.FieldByName('ORARIO').AsString <> '')
    and (VarToStr(selT020.Lookup('CODICE',selT630.FieldByName('ORARIO').AsString,'CODICE')) = '') then
      selT630.FieldByName('ORARIO').AsString:='';
    if (selT630.FieldByName('TURNO1').AsString <> '')
    and (VarToStr(selT021.Lookup('SIGLATURNI',selT630.FieldByName('TURNO1').AsString,'SIGLATURNI')) = '') then
      selT630.FieldByName('TURNO1').AsString:='';
    if (selT630.FieldByName('TURNO2').AsString <> '')
    and (VarToStr(selT021.Lookup('SIGLATURNI',selT630.FieldByName('TURNO2').AsString,'SIGLATURNI')) = '') then
      selT630.FieldByName('TURNO2').AsString:='';
  end;
end;

end.
