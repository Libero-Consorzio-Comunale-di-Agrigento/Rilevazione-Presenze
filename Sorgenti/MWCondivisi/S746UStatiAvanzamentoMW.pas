unit S746UStatiAvanzamentoMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, OracleData, Data.DB, C180FunzioniGenerali,
  A000UMessaggi, medpBackupOldValue;

type
  TS746FStatiAvanzamentoMW = class(TR005FDataModuleMW)
    selSG741: TOracleDataSet;
    dSG741: TDataSource;
    selSG746: TOracleDataSet;
    dSG746: TDataSource;
    selSG746b: TOracleDataSet;
    selSG746a: TOracleDataSet;
    selSG746c: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private

  public
    SG746: TOracleDataSet;
    SG746OldValues: TmedpBackupOldValue;
    function BeforePost(Modifica:Boolean):String;
    procedure RecuperaListaRegole;
    procedure RecuperaListaStampa;
    procedure SG746CODICEValidate;
    procedure SG746DECORRENZAValidate;
    procedure SG746NewRecord;
    procedure SG746BeforeDelete;
    procedure ResetPeriodoRegistraPresaVisione;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TS746FStatiAvanzamentoMW.BeforePost(Modifica:Boolean):String;
begin
  Result:='';
  if SG746.FieldByName('CODICE').AsInteger <= 0 then
    raise exception.Create(A000MSG_S746_ERR_CODICE);
  //Evito che si creino buchi temporali nella catena degli stati
  if SG746.FieldByName('CODICE').AsInteger > 1 then
  begin
    selSG746a.Close;
    selSG746a.SetVariable('CodRegola',SG746.FieldByName('CODREGOLA').AsString);
    selSG746a.SetVariable('Decorrenza',SG746.FieldByName('DECORRENZA').AsDateTime);
    selSG746a.SetVariable('Decorrenza_Fine',SG746.FieldByName('DECORRENZA_FINE').AsDateTime);
    selSG746a.SetVariable('Codice',SG746.FieldByName('CODICE').AsInteger - 1);
    selSG746a.Open;
    if selSG746a.RecordCount = 0 then
      raise exception.Create(A000MSG_S746_ERR_PERIODO_INF_LIV_PREC);
  end;
  if Modifica then
  begin
    selSG746b.SetVariable('CodRegola',SG746.FieldByName('CODREGOLA').AsString);
    selSG746b.SetVariable('Codice',SG746.FieldByName('CODICE').AsInteger + 1);
    if SG746.FieldByName('DECORRENZA').AsDateTime > SG746OldValues.FieldByName('DECORRENZA').Value then
    begin
      selSG746b.Close;
      selSG746b.SetVariable('DataRif',SG746.FieldByName('DECORRENZA').AsDateTime - 1);
      selSG746b.Open;
      if selSG746b.RecordCount > 0 then
        raise exception.Create(A000MSG_S746_ERR_PERIODO_MAGG_LIV_SUCC);
    end;
    if SG746.FieldByName('DECORRENZA_FINE').AsDateTime < SG746OldValues.FieldByName('DECORRENZA_FINE').Value then
    begin
      selSG746b.Close;
      selSG746b.SetVariable('DataRif',SG746.FieldByName('DECORRENZA_FINE').AsDateTime + 1);
      selSG746b.Open;
      if selSG746b.RecordCount > 0 then
        raise exception.Create(A000MSG_S746_ERR_PERIODO_MAGG_LIV_SUCC);
    end;
  end;
  //Periodo di compilazione
  if (SG746.FieldByName('DATA_DA').AsString = '')
  or (SG746.FieldByName('DATA_A').AsString = '') then
    raise exception.Create(A000MSG_S746_ERR_DATE_DA_VALORIZZARE);
  if SG746.FieldByName('DATA_DA').AsDateTime > SG746.FieldByName('DATA_A').AsDateTime then
    raise exception.Create(A000MSG_S746_ERR_ORDINE_DATE_COMP);
  if ((SG746.FieldByName('DATA_DA_RICHIESTA_VISIONE').AsString = '') and (SG746.FieldByName('DATA_A_RICHIESTA_VISIONE').AsString <> ''))
  or ((SG746.FieldByName('DATA_A_RICHIESTA_VISIONE').AsString = '') and (SG746.FieldByName('DATA_DA_RICHIESTA_VISIONE').AsString <> '')) then
    raise exception.Create(A000MSG_S746_ERR_DATE_VAL_O_SVUO);
  if SG746.FieldByName('DATA_DA_RICHIESTA_VISIONE').AsDateTime > SG746.FieldByName('DATA_A_RICHIESTA_VISIONE').AsDateTime then
    raise exception.Create(A000MSG_S746_ERR_ORDINE_DATE_RICH);
  if ((R180Anno(SG746.FieldByName('DATA_DA').AsDateTime) <> (R180Anno(SG746.FieldByName('DECORRENZA').AsDateTime) + 1))
      or (R180Anno(SG746.FieldByName('DATA_A').AsDateTime) <> (R180Anno(SG746.FieldByName('DECORRENZA').AsDateTime) + 1)))
  and ((SG746.FieldByName('DATA_DA').AsDateTime <> SG746OldValues.FieldByName('DATA_DA').Value)
      or (SG746.FieldByName('DATA_A').AsDateTime <> SG746OldValues.FieldByName('DATA_A').Value)) then
    Result:=Format(A000MSG_S746_ERR_FMT_PERIODO_INTERNO,[IntToStr(R180Anno(SG746.FieldByName('DECORRENZA').AsDateTime) + 1)]);
  if (SG746.FieldByName('VAL_INTERM_MODIFICABILE').AsString = 'N') then
    SG746.FieldByName('VAL_INTERM_OBBLIGATORIA').AsString:='N';
end;

procedure TS746FStatiAvanzamentoMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  SG746OldValues:=TmedpBackupOldValue.Create(Self);
end;

procedure TS746FStatiAvanzamentoMW.RecuperaListaRegole;
begin
  R180SetVariable(selSG741,'DATA',SG746.FieldByName('DECORRENZA').AsDateTime);
  selSG741.Open;
end;

procedure TS746FStatiAvanzamentoMW.RecuperaListaStampa;
begin
  R180SetVariable(selSG746,'DATA',SG746.FieldByName('DECORRENZA').AsDateTime);
  R180SetVariable(selSG746,'CODICE',SG746.FieldByName('CODICE').AsInteger);
  R180SetVariable(selSG746,'CODREGOLA',SG746.FieldByName('CODREGOLA').AsString);
  R180SetVariable(selSG746,'DESCRIZIONE',SG746.FieldByName('DESCRIZIONE').AsString);
  selSG746.Open;
end;

procedure TS746FStatiAvanzamentoMW.SG746CODICEValidate;
begin
  inherited;
  RecuperaListaStampa;
  if SG746.FieldByName('CODICE').AsInteger = 1 then
    SG746.FieldByName('MODIFICABILE').AsString:='S';
end;

procedure TS746FStatiAvanzamentoMW.SG746DECORRENZAValidate;
begin
  inherited;
  RecuperaListaRegole;
  RecuperaListaStampa;
end;

procedure TS746FStatiAvanzamentoMW.SG746NewRecord;
begin
  SG746.FieldByName('DECORRENZA_FINE').AsDateTime:=DATE_MAX;
  ResetPeriodoRegistraPresaVisione;
end;

procedure TS746FStatiAvanzamentoMW.SG746BeforeDelete;
begin
  selSG746c.Close;
  selSG746c.SetVariable('CodRegola',SG746.FieldByName('CODREGOLA').AsString);
  selSG746c.SetVariable('Decorrenza',SG746.FieldByName('DECORRENZA').AsDateTime);
  selSG746c.SetVariable('Decorrenza_Fine',SG746.FieldByName('DECORRENZA_FINE').AsDateTime);
  selSG746c.SetVariable('Codice',SG746.FieldByName('CODICE').AsInteger + 1);
  selSG746c.Open;
  if selSG746c.RecordCount > 0 then
    raise exception.Create(A000MSG_S746_ERR_ESISTE_LIV_SUCC);
end;

procedure TS746FStatiAvanzamentoMW.ResetPeriodoRegistraPresaVisione;
begin
  SG746.FieldByName('DATA_DA_RICHIESTA_VISIONE').AsDateTime:=DATE_MIN;
  SG746.FieldByName('DATA_A_RICHIESTA_VISIONE').AsDateTime:=DATE_MAX;
end;

end.
