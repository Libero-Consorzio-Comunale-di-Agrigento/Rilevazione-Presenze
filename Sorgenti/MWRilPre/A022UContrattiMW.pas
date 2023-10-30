unit A022UContrattiMW;

interface

uses
  SysUtils, StrUtils, Variants, Classes, 
  R005UDataModuleMW, Oracle, DB, OracleData, DBClient, A000UMessaggi, A000UCostanti,
  A000UInterfaccia, A000USessione, C180FunzioniGenerali, DatiBloccati;

type
  TRecordT203 = record
    PT_Dal,PT_Al:Real;
    Ore_Suppl:String;
  end;

  TA022FContrattiMW = class(TR005FDataModuleMW)
    selT203: TOracleDataSet;
    StringField1: TStringField;
    dsrT203: TDataSource;
    selT203DECORRENZA: TDateTimeField;
    selT203DECORRENZA_FINE: TDateTimeField;
    selT203PT_DAL: TFloatField;
    selT203PT_AL: TFloatField;
    selT203ORE_SUPPL: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT203FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT203NewRecord(DataSet: TDataSet);
    procedure selT203BeforePost(DataSet: TDataSet);
  private
    FDecorrenza,FDecorrenzaCorrente:TDateTime;
    lstRecordT203:array of TRecordT203;
    procedure GetT203Decorrenze;
    procedure SetDecorrenza(Value:TDateTime);
  public
    T200:TOracleDataSet;
    lstT203Decorrenze:TStringList;
    Intf_T200AfterScroll:TProcNone;
    procedure T200AfterScroll;
    procedure T200AfterPost;
    function CheckT203Decorrenza(D:TDateTime):Boolean;
    procedure AddT203Decorrenza(D:TDateTime);
    property Decorrenza:TDateTime read FDecorrenza write SetDecorrenza;
    property DecorrenzaCorrente:TDateTime read FDecorrenzaCorrente;
  end;

implementation

{$R *.dfm}

procedure TA022FContrattiMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  lstT203Decorrenze:=TStringList.Create;
end;

procedure TA022FContrattiMW.selT203FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=selT203.FieldByName('DECORRENZA').AsDateTime = FDecorrenza;
end;

procedure TA022FContrattiMW.SetDecorrenza(Value: TDateTime);
begin
  FDecorrenza:=Value;
  with selT203 do
  try
    DisableControls;
    Filtered:=False;
  finally
    Filtered:=True;
    EnableControls;
  end;
end;

procedure TA022FContrattiMW.T200AfterScroll;
begin
  with selT203 do
  begin
    Close;
    SetVariable('Codice',T200.FieldByname('Codice').AsString);
    Open;
  end;
  GetT203Decorrenze;
  if Assigned(Intf_T200AfterScroll) then
    Intf_T200AfterScroll;
end;

procedure TA022FContrattiMW.selT203NewRecord(DataSet: TDataSet);
begin
  inherited;
  selT203.FieldByName('CODICE').AsString:=T200.FieldByName('CODICE').AsString;
  selT203.FieldByName('DECORRENZA').AsDateTime:=Decorrenza;
end;

procedure TA022FContrattiMW.selT203BeforePost(DataSet: TDataSet);
begin
  inherited;
  with selT203 do
  begin
    //if FieldByName('PT_DAL').AsFloat > FieldByName('PT_AL').AsFloat then
    //  raise Exception.Create('La fascia del part-time non è corretta!');
    OreMinutiValidate(FieldByName('ORE_SUPPL').AsString);
  end;
end;

procedure TA022FContrattiMW.T200AfterPost;
var i:Integer;
    lstPT:TStringList;
  function DecorrenzaFine(D:TDateTime):TDateTime;
  var DSucc:TDateTime;
      i:Integer;
  begin
    DSucc:=EncodeDate(4000,1,1);
    for i:=0 to lstT203Decorrenze.Count - 1 do
      if (StrToDate(lstT203Decorrenze[i]) > D) and (StrToDate(lstT203Decorrenze[i]) < DSucc) then
        DSucc:=StrToDate(lstT203Decorrenze[i]);
    Result:=DSucc - 1;
  end;
  procedure GetInizioFasciaPT(D:TDateTime);
  begin
    lstPT.Clear;
    with selT203 do
    begin
      First;
      while not Eof do
      begin
        if (FieldByName('DECORRENZA').AsDateTime = D) and (lstPT.IndexOf(FieldByName('PT_DAL').AsString) = -1) then
          lstPT.Add(FieldByName('PT_DAL').AsString);
        Next;
      end;
    end;
  end;
  function FineFasciaPT(InizioFascia:Real):Real;
  var PTSucc:Real;
      i:Integer;
  begin
    PTSucc:=100;
    for i:=0 to lstPT.Count - 1 do
      if (StrToFloat(lstPT[i]) > InizioFascia) and (StrToFloat(lstPT[i]) < PTSucc) then
        PTSucc:=StrToFloat(lstPT[i]);
    Result:=PTSucc - 0.01;
  end;
begin
  //leggo le decorrenze esistenti
  GetT203Decorrenze;
  with selT203 do
  try
    DisableControls;
    Filtered:=False;
    ReadOnly:=False;

    //allineo la decorrenza fine
    First;
    while not Eof do
    begin
      Edit;
      FieldByName('DECORRENZA_FINE').AsDateTime:=DecorrenzaFine(FieldByName('DECORRENZA').AsDateTime);
      Post;
      Next;
    end;

    //per ogni decorrenza allineo la fine fascia part-time
    lstPT:=TStringList.Create;
    for i:=0 to lstT203Decorrenze.Count - 1 do
    begin
      GetInizioFasciaPT(StrToDate(lstT203Decorrenze[i]));
      First;
      while not Eof do
      begin
        if FieldByName('DECORRENZA').AsDateTime = StrToDate(lstT203Decorrenze[i]) then
        begin
          Edit;
          FieldByName('PT_AL').AsFloat:=FineFasciaPT(FieldByName('PT_DAL').AsFloat);
          Post;
        end;
        Next;
      end;
    end;
  finally
    FreeAndNil(lstPT);
    Filtered:=True;
    EnableControls;
    ReadOnly:=True;
  end;

  SessioneOracle.ApplyUpdates([selT203],True);
  //Rileggo le decorrenze aggiornate e calcolo la decorrenza corrente
  GetT203Decorrenze;
  if Assigned(Intf_T200AfterScroll) then
    Intf_T200AfterScroll;
end;

procedure TA022FContrattiMW.GetT203Decorrenze;
begin
  FDecorrenzaCorrente:=0;
  with selT203 do
  try
    DisableControls;
    Filtered:=False;
    lstT203Decorrenze.Clear;
    while not Eof do
    begin
      if lstT203Decorrenze.IndexOf(FieldByName('DECORRENZA').AsString) = -1 then
      begin
        lstT203Decorrenze.Add(FieldByName('DECORRENZA').AsString);
        if R180Between(Parametri.DataLavoro,FieldByName('DECORRENZA').AsDateTime,FieldByName('DECORRENZA_FINE').AsDateTime) then
          FDecorrenzaCorrente:=FieldByName('DECORRENZA').AsDateTime;
      end;
      Next;
    end;
    First;
  finally
    Filtered:=True;
    EnableControls;
  end;
end;

function TA022FContrattiMW.CheckT203Decorrenza(D:TDateTime):Boolean;
begin
  Result:=True;
  if lstT203Decorrenze.IndexOf(DateToStr(D)) >= 0 then
    Result:=False;
end;

procedure TA022FContrattiMW.AddT203Decorrenza(D:TDateTime);
var i:Integer;
begin
  for i:=0 to lstT203Decorrenze.Count - 1 do
  begin
    if D < StrToDate(lstT203Decorrenze[i]) then
    begin
      lstT203Decorrenze.Insert(i,DateToStr(D));
      Break;
    end;
  end;
  if lstT203Decorrenze.IndexOf(DateToStr(D)) = -1 then
    lstT203Decorrenze.Add(DateToStr(D));

  //Riporto i valori dell'attuale decorrenza su quella nuova
  with selT203 do
  try
    SetLength(lstRecordT203,RecordCount);
    i:=0;
    DisableControls;
    First;
    while not Eof do
    begin
      lstRecordT203[i].PT_Dal:=FieldByName('PT_DAL').AsFloat;
      lstRecordT203[i].PT_Al:=FieldByName('PT_AL').AsFloat;
      lstRecordT203[i].Ore_Suppl:=FieldByName('ORE_SUPPL').AsString;
      inc(i);
      Next;
    end;

    for i:=0 to High(lstRecordT203) do
    begin
      Append;
      FieldByName('DECORRENZA').AsDateTime:=D;
      FieldByName('PT_DAL').AsFloat:=lstRecordT203[i].PT_Dal;
      FieldByName('PT_AL').AsFloat:=lstRecordT203[i].PT_Al;
      FieldByName('ORE_SUPPL').AsString:=lstRecordT203[i].Ore_Suppl;
      Post;
    end;

  finally
    First;
    EnableControls;
  end;

  FDecorrenzaCorrente:=D;
end;

procedure TA022FContrattiMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(lstT203Decorrenze);
  inherited;
end;

end.
