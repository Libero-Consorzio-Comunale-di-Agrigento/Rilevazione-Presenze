unit A162UIncentiviAssenzeMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, OracleData, A000UInterfaccia,
  A000USessione, A000UCostanti, A000UMessaggi, StrUtils, Variants, Oracle;

type
  TA162FIncentiviAssenzeMW = class(TR005FDataModuleMW)
    selDato1: TOracleDataSet;
    selDato2: TOracleDataSet;
    selDato3: TOracleDataSet;
    selT255: TOracleDataSet;
    selT255COD_TIPOACCORPCAUSALI: TStringField;
    selT255DESCRIZIONE: TStringField;
    selT256: TOracleDataSet;
    selT256COD_CODICIACCORPCAUSALI: TStringField;
    selT256DESCRIZIONE: TStringField;
    selT265: TOracleDataSet;
    selT265CODICE: TStringField;
    selT265DESCRIZIONE: TStringField;
    selT766: TOracleDataSet;
    selT766CODICE: TStringField;
    selT766DESCRIZIONE: TStringField;
    selT766RISPARMIO_BILANCIO: TStringField;
    selT265A: TOracleDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    selT765: TOracleDataSet;
    selT765CODICE: TStringField;
    selT765DESCRIZIONE: TStringField;
    selT769Quote: TOracleDataSet;
    updT769: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    FSelT769_Funzioni: TOracleDataset;
    procedure ImpostaDecorrenza(Query: TOracleDataSet; Decorrenza: TDateTime);
  public
    procedure CaricamentoDati(Query: TOracleDataSet; ParametriDato: String; Decorrenza: TDateTime);
    procedure ImpostaDecorrenzaDatasetLookup;
    procedure ImpostaDecorrenzaFineDatasetLookup;
    procedure ImpostaTipoSelT256(Tipo: String);
    function ListAssenzeAggiuntive(TipoAccorpCausali, CodAccorpCausali: String): TElencoValoriChecklist;
    procedure SelT769AfterScroll;
    procedure SelT769BeforePost;
    property selT769_Funzioni: TOracleDataset read FSelT769_Funzioni write FSelT769_Funzioni;
    procedure CambiaCodTipoQuota(CodTipoQuota:String);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}
procedure TA162FIncentiviAssenzeMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT255.Open;
  selT265.Open;
  selT766.Open;
end;

procedure TA162FIncentiviAssenzeMW.SelT769AfterScroll;
begin
  //Caratto 13/11/2014 carico dati storici alla data del record corrente
  if not FSelT769_Funzioni.Eof then //refreshrecord resetterebbe EOF e i cicli vanno in loop
  begin
    ImpostaDecorrenzaDatasetLookup;
    ImpostaDecorrenzaFineDatasetLookup;
    FSelT769_Funzioni.RefreshRecord;
  end;
end;

procedure TA162FIncentiviAssenzeMW.SelT769BeforePost;
begin
  if (FSelT769_Funzioni.FieldByName('PERC_ABB_FRANCHIGIA').AsFloat > 100) or (FSelT769_Funzioni.FieldByName('PERC_ABBATTIMENTO').AsFloat > 100) then
    raise Exception.Create(A000MSG_A162_ERR_PCT_ABBATT);
  if FSelT769_Funzioni.FieldByName('DATO1').AsString = '' then
    FSelT769_Funzioni.FieldByName('DATO1').AsString:=' ';
  if FSelT769_Funzioni.FieldByName('DATO2').AsString = '' then
    FSelT769_Funzioni.FieldByName('DATO2').AsString:=' ';
  if FSelT769_Funzioni.FieldByName('DATO3').AsString = '' then
    FSelT769_Funzioni.FieldByName('DATO3').AsString:=' ';

  selT769Quote.Close;
  selT769Quote.SetVariable('OPERATORE',IfThen(FSelT769_Funzioni.FieldByName('CODTIPOQUOTA').AsString = '*','<>','='));
  selT769Quote.SetVariable('DATO1',FSelT769_Funzioni.FieldByName('DATO1').AsString);
  selT769Quote.SetVariable('DATO2',FSelT769_Funzioni.FieldByName('DATO2').AsString);
  selT769Quote.SetVariable('DATO3',FSelT769_Funzioni.FieldByName('DATO3').AsString);
  selT769Quote.Open;
  if selT769Quote.FieldByName('N_QUOTE').AsInteger > 0 then
    raise Exception.Create(A000MSG_A162_ERR_TUTTE_LE_QUOTE);

  if FSelT769_Funzioni.FieldByName('COD_TIPOACCORPCAUSALI').AsString = '' then
    FSelT769_Funzioni.FieldByName('COD_TIPOACCORPCAUSALI').AsString:=' ';
  if FSelT769_Funzioni.FieldByName('COD_CODICIACCORPCAUSALI').AsString = '' then
    FSelT769_Funzioni.FieldByName('COD_CODICIACCORPCAUSALI').AsString:=' ';

  if (FSelT769_Funzioni.FieldByName('CAUSALE').IsNull) or
     (FSelT769_Funzioni.FieldByName('CAUSALE').AsString = '') then
    FSelT769_Funzioni.FieldByName('CAUSALE').AsString:=' ';

  if FSelT769_Funzioni.FieldByName('FRANCHIGIA_ASSENZE').IsNull then
    FSelT769_Funzioni.FieldByName('FRANCHIGIA_ASSENZE').AsInteger:=0;

  if FSelT769_Funzioni.FieldByName('FRANCHIGIA_ASSENZE').AsInteger > 999 then
    raise Exception.Create(Format(A000MSG_ERR_FMT_VALORE_TROPPO_GRANDE,['GG. franchigia']));


  if (FSelT769_Funzioni.FieldByName('FRANCHIGIA_ASSENZE').AsInteger <> 0) and (FSelT769_Funzioni.FieldByName('GESTIONE_FRANCHIGIA').AsString = 'R') then
    FSelT769_Funzioni.FieldByName('TIPO_ABBATTIMENTO').AsString:='';
end;

procedure TA162FIncentiviAssenzeMW.ImpostaDecorrenzaDatasetLookup;
begin
  //Caratto 13/11/2014 carico dati storici alla data del record corrente
  if Parametri.CampiRiferimento.C7_Dato1 <> '' then
    ImpostaDecorrenza(selDato1,FSelT769_Funzioni.FieldByName('DECORRENZA').AsDateTime);
  if Parametri.CampiRiferimento.C7_Dato2 <> '' then
    ImpostaDecorrenza(selDato2,FSelT769_Funzioni.FieldByName('DECORRENZA').AsDateTime);
  if Parametri.CampiRiferimento.C7_Dato3 <> '' then
    ImpostaDecorrenza(selDato3,FSelT769_Funzioni.FieldByName('DECORRENZA').AsDateTime);
end;

procedure TA162FIncentiviAssenzeMW.ImpostaDecorrenzaFineDatasetLookup;
begin
  selT765.Close;
  if FSelT769_Funzioni.FieldByName('DECORRENZA_FINE').IsNull then
    selT765.SetVariable('DECORRENZA_FINE',EncodeDate(3999,12,31))
  else
    selT765.SetVariable('DECORRENZA_FINE',FSelT769_Funzioni.FieldByName('DECORRENZA_FINE').AsDateTime);
  selT765.Open;
end;

procedure TA162FIncentiviAssenzeMW.CaricamentoDati(Query: TOracleDataSet; ParametriDato:String; Decorrenza: TDateTime);
begin
  if A000LookupTabella(ParametriDato,Query) then
  begin
    ImpostaDecorrenza(Query,Decorrenza);
  end;
end;

procedure TA162FIncentiviAssenzeMW.ImpostaDecorrenza(Query: TOracleDataSet; Decorrenza: TDateTime);
begin
  if Query.VariableIndex('DECORRENZA') >= 0 then
    Query.SetVariable('DECORRENZA',Decorrenza);
  Query.Close;
  Query.Open;
end;

procedure TA162FIncentiviAssenzeMW.ImpostaTipoSelT256(Tipo:String);
begin
  selT256.Close;
  selT256.SetVariable('TIPO',Tipo);
  selT256.Open;
end;

function TA162FIncentiviAssenzeMW.ListAssenzeAggiuntive(TipoAccorpCausali:String; CodAccorpCausali:String): TElencoValoriChecklist;
var
  codice: String;
begin
  Result:=TElencoValoriChecklist.Create;

  with selT265A do
  begin
    Close;
    SetVariable('TipoAccorpCausali',TipoAccorpCausali);
    SetVariable('CodiciAccorpCausali',CodAccorpCausali);
    Open;
    First;
    while not Eof do
    begin
      codice:=FieldByName('Codice').AsString;
      Result.lstCodice.Add(codice);
      Result.lstDescrizione.Add(Format('%-5s %s',[codice, FieldByName('Descrizione').AsString]));
      Next;
    end;
  end;
end;

procedure TA162FIncentiviAssenzeMW.CambiaCodTipoQuota(CodTipoQuota:String);
begin
  if (Trim(CodTipoQuota) = '')
  or (CodTipoQuota = '*')
  or (VarToStr(selT765.Lookup('CODICE',CodTipoQuota,'CODICE')) = '') then
    raise Exception.Create(A000MSG_A162_ERR_CODTIPOQUOTA);
  updT769.SetVariable('DATO1',FSelT769_Funzioni.FieldByName('DATO1').AsString);
  updT769.SetVariable('DATO2',FSelT769_Funzioni.FieldByName('DATO2').AsString);
  updT769.SetVariable('DATO3',FSelT769_Funzioni.FieldByName('DATO3').AsString);
  updT769.SetVariable('CODTIPOQUOTA',CodTipoQuota);
  updT769.Execute;
  SessioneOracle.Commit;
  FSelT769_Funzioni.Refresh;
end;

end.
