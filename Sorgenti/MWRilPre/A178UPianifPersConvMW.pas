unit A178UPianifPersConvMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, OracleData, Data.DB, StrUtils,
  A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi, Oracle, C180FunzioniGenerali;

type
  TA178FPianifPersConvMW = class(TR005FDataModuleMW)
    selI095: TOracleDataSet;
    insT421: TOracleQuery;
    selT421a: TOracleDataSet;
    selCdcPersConv: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    IDStoricizzato:Integer;
    selT420: TOracleDataSet;
    selT421: TOracleDataSet;
    procedure selT420AfterScroll;
    procedure selT420NewRecord;
    procedure selT420AfterPost;
    procedure selT421NewRecord;
    procedure selT421BeforePost;
    procedure selT421CalcFields;
    procedure selT421BeforeInsert;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA178FPianifPersConvMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  IDStoricizzato:=0;
  selI095.SetVariable('AZIENDA',Parametri.Azienda);
  selI095.Open;

  if Parametri.CampiRiferimento.C13_CdcPersConv <> '' then
  begin
    A000LookupTabella(Parametri.CampiRiferimento.C13_CdcPersConv,selCdcPersConv);
    selCdcPersConv.Open;
  end;
end;

procedure TA178FPianifPersConvMW.selT420AfterPost;
begin
  if IDStoricizzato <> 0 then
  begin
    insT421.SetVariable('IDOLD',IDStoricizzato);
    insT421.SetVariable('IDNEW',selT420.FieldByName('ID').AsInteger);
    insT421.Execute;
    SessioneOracle.Commit;
    IDStoricizzato:=0;
  end;
end;

procedure TA178FPianifPersConvMW.selT420AfterScroll;
begin
  selT421.Close;
  selT421.SetVariable('ID',selT420.FieldByName('ID').AsInteger);
  selT421.Open;
end;

procedure TA178FPianifPersConvMW.selT420NewRecord;
begin
  selT420.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafe.FieldByName('Progressivo').AsInteger;
end;

procedure TA178FPianifPersConvMW.selT421NewRecord;
begin
  selT421.FieldByName('ID').AsInteger:=selT420.FieldByName('ID').AsInteger;
end;

procedure TA178FPianifPersConvMW.selT421BeforeInsert;
begin
  if selT420.FieldByName('ID').IsNull then
    Abort;
  if selT420.State <> dsBrowse then
    Abort;
end;

procedure TA178FPianifPersConvMW.selT421BeforePost;
begin
  //Controlli sul dettaglio - li eseguo solo se i dati required non sono nulli
  if selT421.FieldByName('GIORNO').IsNull or selT421.FieldByName('DALLE').IsNull or selT421.FieldByName('ALLE').IsNull or selT421.FieldByName('RESPONSABILE').IsNull then
    Exit;

  R180OraValidate(selT421.FieldByName('TOLL_DALLE').AsString);
  R180OraValidate(selT421.FieldByName('DALLE').AsString);
  R180OraValidate(selT421.FieldByName('ALLE').AsString);
  R180OraValidate(selT421.FieldByName('TOLL_ALLE').AsString);
  if R180OreMinuti(selT421.FieldByName('ALLE').AsString) <= R180OreMinuti(selT421.FieldByName('DALLE').AsString) then
    raise Exception.Create(A000MSG_A178_ERR_DALLE_ALLE);
  if (selT421.FieldByName('GIORNO').AsInteger < 1) or (selT421.FieldByName('GIORNO').AsInteger > 7) then
    raise Exception.Create(A000MSG_A178_ERR_GIORNO_SETTIMANA);
  if not selI095.SearchRecord('COD_ITER',selT421.FieldByName('RESPONSABILE').AsString,[srFromBeginning]) then
    raise Exception.Create(A000MSG_A178_ERR_RESPONSABILE);

  selT421a.Close;
  selT421a.SetVariable('ID',selT421.FieldByName('ID').AsInteger);
  selT421a.SetVariable('GIORNO',selT421.FieldByName('GIORNO').AsInteger);
  selT421a.SetVariable('MODIFICA',IfThen(selT421.State = dsEdit,'S','N'));
  selT421a.SetVariable('RIGA',IfThen(selT421.State = dsEdit,selT421.RowId,''));
  selT421a.Open;
  while not selT421a.Eof do
  begin
    if ((R180OreMinuti(selT421.FieldByName('DALLE').AsString) < R180OreMinuti(selT421a.FieldByName('ALLE').AsString)) and
        (R180OreMinuti(selT421.FieldByName('DALLE').AsString) >= R180OreMinuti(selT421a.FieldByName('DALLE').AsString))) or
       ((R180OreMinuti(selT421.FieldByName('ALLE').AsString) <= R180OreMinuti(selT421a.FieldByName('ALLE').AsString)) and
        (R180OreMinuti(selT421.FieldByName('ALLE').AsString) > R180OreMinuti(selT421a.FieldByName('DALLE').AsString))) then
      raise Exception.Create(A000MSG_A178_ERR_INTERVALLO);
    selT421a.Next;
  end;
end;

procedure TA178FPianifPersConvMW.selT421CalcFields;
begin
  selT421.FieldByName('D_GIORNO').AsString:=R180NomeGiornoSett(selT421.FieldByName('GIORNO').AsInteger);
end;

end.
