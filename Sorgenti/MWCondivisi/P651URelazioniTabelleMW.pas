unit P651URelazioniTabelleMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, DB, OracleData, A000UMessaggi,
  A000UCostanti, A000USessione, A000UInterfaccia, C180FunzioniGenerali, Variants,
  StrUtils, Oracle;

type
  TP651FRelazioniTabelleMW = class(TR005FDataModuleMW)
    selDato1: TOracleDataSet;
    selDato2: TOracleDataSet;
    selP660: TOracleDataSet;
    selFlussi: TOracleDataSet;
    selCtrlPerc: TOracleDataSet;
    selDato1Cod: TOracleDataSet;
    selDato2Cod: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    selI037: TOracleDataSet;
    TipoFlusso,NomeFlusso,NomeDato:String;
    lstDati1,lstDati2:TStringList;
    LungTipoQuota1, LungTipoQuota2: integer;
    procedure Inizio;
    procedure CaricamentoDati(Query:TOracleDataSet; Dato,ParametriDato:String);
    procedure selI037CalcFields;
    procedure selI037NewRecord;
    procedure selI037BeforePost;
    function Controlli: String;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TP651FRelazioniTabelleMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  lstDati1:=TStringList.Create;
  lstDati2:=TStringList.Create;
end;

procedure TP651FRelazioniTabelleMW.CaricamentoDati(Query: TOracleDataSet; Dato,ParametriDato:String);
begin
  if Dato = 'COD_DATO1' then
    LungTipoQuota1:=0;
  if Dato = 'COD_DATO2' then
    LungTipoQuota2:=0;
  if A000LookupTabella(ParametriDato,Query) then
  begin
    if Query.VariableIndex('DECORRENZA') >= 0 then
      Query.SetVariable('DECORRENZA',Parametri.DataLavoro);
    Query.Close;
    Query.Open;
    with Query do
    begin
      First;
      while not Eof do
      begin
        if (Dato = 'COD_DATO1') and (Length(FieldByName('CODICE').AsString) > LungTipoQuota1) then
          LungTipoQuota1:=Length(FieldByName('CODICE').AsString);
        if (Dato = 'COD_DATO2') and (Length(FieldByName('CODICE').AsString) > LungTipoQuota2) then
          LungTipoQuota2:=Length(FieldByName('CODICE').AsString);
        Next;
      end;
      First;
      if Dato = 'COD_DATO1' then
        lstDati1.Clear;
      if Dato = 'COD_DATO2' then
        lstDati2.Clear;
      while not Eof do
      begin
       if Dato = 'COD_DATO1' then
         lstDati1.Add(Format('%-*s %s',[LungTipoQuota1,FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
       if Dato = 'COD_DATO2' then
         lstDati2.Add(Format('%-*s %s',[LungTipoQuota2,FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
       Next;
      end;
    end;
  end;
end;

procedure TP651FRelazioniTabelleMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(lstDati1);
  FreeAndNil(lstDati2);
end;

procedure TP651FRelazioniTabelleMW.Inizio;
begin
  selI037.FieldByName('DECORRENZA_FINE').Visible:=TipoFlusso <> 'FL';
  selI037.FieldByName('PERCENTUALE').Visible:=TipoFlusso <> 'FL';
  CaricamentoDati(selDato1,'COD_DATO1',Parametri.CampiRiferimento.C13_CdcPercentualizzati);
  A000LookupTabella(Parametri.CampiRiferimento.C13_CdcPercentualizzati,selDato1Cod);
  selDato1Cod.SQL.Text:=StringReplace(selDato1Cod.SQL.Text,'ORDER BY','AND CODICE = :CODICE ORDER BY',[rfReplaceAll]);
  selDato1Cod.DeclareVariable('CODICE',otString);

  R180SetVariable(selFlussi,'OPERATORE_RELAZIONALE',IfThen(TipoFlusso <> 'FL','NOT ') + 'LIKE');
  selFlussi.Open;
  if NomeFlusso = '' then
    NomeFlusso:=selFlussi.FieldByName('NOME_FLUSSO').AsString;
  if TipoFlusso = 'FL' then
  begin
    if NomeFlusso = 'FLUPER_STR' then
    begin
      R180SetVariable(selP660,'NUMERI','''008'',''009'',''092''');
      selP660.Open;
      if selP660.RecordCount <= 0 then
        raise Exception.Create(Format(A000MSG_P651_ERR_FMT_NO_FLUPER,['Struttura di impiego']));
      if selP660.RecordCount > 1 then
        raise Exception.Create(Format(A000MSG_P651_ERR_FMT_FLUPER,['Struttura di impiego']));
    end
    else if NomeFlusso = 'FLUPER_DIP' then
    begin
      R180SetVariable(selP660,'NUMERI','''010'',''011'',''012'',''013''');
      selP660.Open;
      if selP660.RecordCount <= 0 then
        raise Exception.Create(Format(A000MSG_P651_ERR_FMT_NO_FLUPER,['Dipartimento di impiego']));
      if selP660.RecordCount > 1 then
        raise Exception.Create(Format(A000MSG_P651_ERR_FMT_FLUPER,['Dipartimento di impiego']));
    end
    else if NomeFlusso = 'FLUPER_UO' then
    begin
      R180SetVariable(selP660,'NUMERI','''014'',''016'',''018'',''020'',''022'',''024'',''093'',''094'',''095''');
      selP660.Open;
      if selP660.RecordCount <= 0 then
        raise Exception.Create(Format(A000MSG_P651_ERR_FMT_NO_FLUPER,['Unità operativa di impiego']));
      if selP660.RecordCount > 1 then
        raise Exception.Create(Format(A000MSG_P651_ERR_FMT_FLUPER,['Unità operativa di impiego']));
    end;
    if selP660.Active then
      NomeDato:=selP660.FieldByName('NOME_DATO').AsString;
  end
  else if TipoFlusso = 'CA' then
  begin
    if NomeFlusso = 'PIA' then
      NomeDato:='RAGGR_UO_AZIEN';
  end;

  CaricamentoDati(selDato2,'COD_DATO2',NomeDato);
  A000LookupTabella(NomeDato,selDato2Cod);
  selDato2Cod.SQL.Text:=StringReplace(selDato2Cod.SQL.Text,'ORDER BY','AND CODICE = :CODICE ORDER BY',[rfReplaceAll]);
  selDato2Cod.DeclareVariable('CODICE',otString);

  R180SetVariable(selI037,'NOME_FLUSSO',NomeFlusso);
  if NomeOwner = 'P651' then  //Se sono su win
    R180SetVariable(selI037,'ORDERBY',IfThen(TipoFlusso <> 'FL','COD_DATO2, ') + 'DECORRENZA')
  else  //Se sono su cloud
    R180SetVariable(selI037,'ORDERBY','ORDER BY COD_DATO1, ' + IfThen(TipoFlusso <> 'FL','COD_DATO2, ') + 'DECORRENZA');
  selI037.Open;
end;

procedure TP651FRelazioniTabelleMW.selI037BeforePost;
begin
  if selI037.FieldByName('Decorrenza_Fine').IsNull then
    selI037.FieldByName('Decorrenza_Fine').AsString:='31/12/3999';
  if (R180IndexOf(lstDati1,selI037.FieldByName('COD_DATO1').AsString,LungTipoQuota1) = -1) then
    raise Exception.Create(Format(A000MSG_ERR_FMT_DATO_ELEM_LISTA,[Parametri.CampiRiferimento.C13_CdcPercentualizzati]));
  if (R180IndexOf(lstDati2,selI037.FieldByName('COD_DATO2').AsString,LungTipoQuota2) = -1) then
    raise Exception.Create(Format(A000MSG_ERR_FMT_DATO_ELEM_LISTA,[NomeDato]));
  if TipoFlusso <> 'FL' then
  begin
    if selI037.FieldByName('Percentuale').IsNull then
      selI037.FieldByName('Percentuale').AsString:='100';
    if (selI037.FieldByName('Percentuale').AsFloat < 0) or (selI037.FieldByName('Percentuale').AsFloat > 100) then
      raise exception.Create(A000MSG_ERR_PERCENTUALE);
  end;
end;

procedure TP651FRelazioniTabelleMW.selI037CalcFields;
begin
  if selDato1Cod.VariableIndex('DECORRENZA') >= 0 then
    R180SetVariable(selDato1Cod,'DECORRENZA',selI037.FieldByName('DECORRENZA').AsDateTime);
  R180SetVariable(selDato1Cod,'CODICE',selI037.FieldByName('COD_DATO1').AsString);
  selDato1Cod.Open;
  selI037.FieldByName('DESCR_DATO1').AsString:='';
  if selDato1Cod.RecordCount > 0 then
    selI037.FieldByName('DESCR_DATO1').AsString:=selDato1Cod.FieldByName('DESCRIZIONE').AsString;
  if selDato2Cod.VariableIndex('DECORRENZA') >= 0 then
    R180SetVariable(selDato2Cod,'DECORRENZA',selI037.FieldByName('DECORRENZA').AsDateTime);
  R180SetVariable(selDato2Cod,'CODICE',selI037.FieldByName('COD_DATO2').AsString);
  selDato2Cod.Open;
  selI037.FieldByName('DESCR_DATO2').AsString:='';
  if selDato2Cod.RecordCount > 0 then
    selI037.FieldByName('DESCR_DATO2').AsString:=selDato2Cod.FieldByName('DESCRIZIONE').AsString;
end;

procedure TP651FRelazioniTabelleMW.selI037NewRecord;
begin
  if NomeFlusso = '' then
    raise exception.Create(A000MSG_P651_ERR_INS_NO_NOMEFLUSSO);
  selI037.FieldByName('NOME_FLUSSO').AsString:=NomeFlusso;
  selI037.FieldByName('DECORRENZA').AsDateTime:=StrToDate('01/01/1900');
  if TipoFlusso <> 'FL' then
    selI037.FieldByName('PERCENTUALE').AsFloat:=100;
end;

function TP651FRelazioniTabelleMW.Controlli: String;
begin
  Result:='';
  if TipoFlusso = 'FL' then
    exit;
  with selCtrlPerc do
  begin
    Close;
    SetVariable('NOME_FLUSSO',selI037.FieldByName('NOME_FLUSSO').AsString);
    Open;
    if RecordCount > 0 then
      Result:=Result + A000MSG_P651_MSG_ANOMALIE;
    while not Eof do
    begin
      if (RecNo mod 2) > 0 then
        Result:=Result + Format(A000MSG_P651_MSG_FMT_PERCENTUALE_1,[FieldByName('COD_DATO1').AsString,FieldByName('DATARIF').AsString])
      else
        Result:=Result + Format(A000MSG_P651_MSG_FMT_PERCENTUALE_2,[FieldByName('DATARIF').AsString,FieldByName('PERCENTUALE').AsString]);
      Next;
    end;
  end;
end;

end.
