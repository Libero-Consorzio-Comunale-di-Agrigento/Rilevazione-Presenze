unit P430UAnagraficoMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, OracleData,
  A000UMessaggi,Variants, C180FunzioniGenerali, P239UANFDtm, A000UInterfaccia,
  Math, Oracle, P999UGenerale, A000UCostanti;

type
  TSQLAppoggio = record
    Colonna:String;
    DecIni:TDateTime;
    OQ:TOracleQuery;
  end;

  TP430FAnagraficoMW = class(TR005FDataModuleMW)
    Q210: TOracleDataSet;
    Q210COD_CONTRATTO: TStringField;
    Q210DESCRIZIONE: TStringField;
    D210: TDataSource;
    Q212: TOracleDataSet;
    Q212COD_PARAMETRISTIPENDI: TStringField;
    Q212DESCRIZIONE: TStringField;
    D212: TDataSource;
    Q030: TOracleDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    D030: TDataSource;
    Q240: TOracleDataSet;
    D240: TDataSource;
    Q220: TOracleDataSet;
    Q220COD_POSIZIONE_ECONOMICA: TStringField;
    Q220DESCRIZIONE: TStringField;
    D220: TDataSource;
    Q040: TOracleDataSet;
    Q040COD_PARTTIME: TStringField;
    Q040DESCRIZIONE: TStringField;
    D040: TDataSource;
    selT030: TOracleDataSet;
    D010: TDataSource;
    Q010: TOracleDataSet;
    Q010COD_BANCA: TStringField;
    Q010ABI: TStringField;
    Q010CAB: TStringField;
    Q010DESCRIZIONE: TStringField;
    Q010COD_NAZIONE: TStringField;
    selP010: TOracleDataSet;
    Q130: TOracleDataSet;
    Q130COD_PAGAMENTO: TStringField;
    Q130DESCRIZIONE: TStringField;
    D130: TDataSource;
    Q020: TOracleDataSet;
    Q020COD_STATOCIVILE: TStringField;
    Q020DESCRIZIONE: TStringField;
    D020: TDataSource;
    D120: TDataSource;
    Q120: TOracleDataSet;
    Q120COD_NAZIONALITA: TStringField;
    Q120DESCRIZIONE: TStringField;
    Q080: TOracleDataSet;
    Q080COD_CAUSALEIRPEF: TStringField;
    Q080DESCRIZIONE: TStringField;
    D080: TDataSource;
    selT482: TOracleDataSet;
    DselT482: TDataSource;
    Q236: TOracleDataSet;
    Q236COD_TABELLAANF: TStringField;
    Q236DESCRIZIONE: TStringField;
    D236: TDataSource;
    Q090: TOracleDataSet;
    D090: TDataSource;
    D096: TDataSource;
    Q096: TOracleDataSet;
    dsrP004TipoAss: TDataSource;
    selP004TipoAss: TOracleDataSet;
    dsrP004TipoCess: TDataSource;
    selP004TipoCess: TOracleDataSet;
    dsrP004TipoRapp: TDataSource;
    selP004TipoRapp: TOracleDataSet;
    dsrP004TipoAtt: TDataSource;
    selP004TipoAtt: TOracleDataSet;
    dsrP004AltreAssic: TDataSource;
    selP004AltreAssic: TOracleDataSet;
    Q094: TOracleDataSet;
    Q094COD_INQUADRINPDAP: TStringField;
    Q094DESCRIZIONE: TStringField;
    D094: TDataSource;
    dsrP004CausaCess: TDataSource;
    selP004CausaCess: TOracleDataSet;
    dsrP004CategConvenz: TDataSource;
    selP004CategConvenz: TOracleDataSet;
    dsrP004TipoServAltraAmm: TDataSource;
    selP004TipoServAltraAmm: TOracleDataSet;
    Q092: TOracleDataSet;
    D092: TDataSource;
    dsrP004QualifInail: TDataSource;
    selP004QualifInail: TOracleDataSet;
    T480_COMUNI: TOracleDataSet;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    StringField7: TStringField;
    dsrT480: TDataSource;
    dsrP004CatPart770: TDataSource;
    selP004CatPart770: TOracleDataSet;
    selP004CausPag770: TOracleDataSet;
    dsrP004CausPag770: TDataSource;
    dsrP004TipoPagOnaosi: TDataSource;
    selP004TipoPagOnaosi: TOracleDataSet;
    dsrP004TipoAssOnaosi: TDataSource;
    selP004TipoAssOnaosi: TOracleDataSet;
    dsrP004TipoCessOnaosi: TDataSource;
    selP004TipoCessOnaosi: TOracleDataSet;
    selT430: TOracleDataSet;
    dsrP004SospFPC: TDataSource;
    selP004SospFPC: TOracleDataSet;
    dsrP004CessFPC: TDataSource;
    selP004CessFPC: TOracleDataSet;
    selP026: TOracleDataSet;
    dsrP026: TDataSource;
    selI030: TOracleDataSet;
    selI035: TOracleDataSet;
    selCOLS: TOracleDataSet;
    selP430: TOracleDataSet;
    selP150: TOracleDataSet;
    selbT430: TOracleDataSet;
    selP500: TOracleDataSet;
    scrP430: TOracleQuery;
    scrT430: TOracleQuery;
    updP430: TOracleQuery;
    selaT430: TOracleDataSet;
    Q015: TOracleDataSet;
    D015: TDataSource;
    Q015COD_ENTE_APPARTENENZA: TStringField;
    Q015DESCRIZIONE: TStringField;
    selP430a: TOracleDataSet;
    GetCatena: TOracleQuery;
    selP430TP: TOracleDataSet;
    selSQL: TOracleQuery;
    selP442: TOracleDataSet;
    dsrT480S: TDataSource;
    selT480S: TOracleDataSet;
    StringField8: TStringField;
    StringField9: TStringField;
    StringField10: TStringField;
    StringField11: TStringField;
    StringField12: TStringField;
    selT030Lock: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure Q240AfterOpen(DataSet: TDataSet);
    procedure selI030FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FselP430_Funzioni: TOracleDataset;
    procedure setCalcFieldLookup(CodField, DescField: String;
      lookupDS: TOracleDataSet; keyField: String);
    procedure CompletaSQLRelazione(var RelSQL: String);
    function EseguiSQLRelazione(SqlRelazione: String): TOracleQuery;
    function AggiornaPeriodiStorici: String;
    procedure CreaFieldDefsP430;
    procedure ImpostaFieldDefP430(NomeCampo: String);
    procedure CercaBanca(CodBanca,ABI,CAB,CodNazione:String);
  public
    VSQLAppoggio:array of TSQLAppoggio;
    sQ010SQLTextOrig:String;
    IBANIniziale: String; //fare private
    procedure RefreshLookupCache(ds: TDataSet);
    procedure AllineaDati(var MsgInforma: String; var MsgErr: String);
    procedure ControlliNonBloccanti(var LstErrori: TStringList);
    function VerificaCedAntePrimoStoricoStip(): Boolean;
    function MessaggioInquadrInpdap: String;
    function MessaggioErede: String;
    function MessaggioIban(Iban: String): String;
    procedure VerificaCodInps;
    procedure VerificaCodInpdapAltraAmm;
    procedure VerificaCodBanca;
    procedure VerificaCittaEstera;
    procedure VerificaCodFiscaleAltraAmm;
    procedure VerificaTipoServAltraAmm;
    procedure VerificaAreaContrat;
    procedure VerificaPercEredita;
    procedure VerificaModuloCP;
    procedure VerificaContrattoVoci;
    procedure VerificaTipoAdesioneFPC;
    procedure VerificaDataInfSilAssFPC;
    procedure VerificaCodFPC;
    procedure VerificaDataDomandaFPC;
    procedure VerificaLavPrimaOccupFPC;
    procedure VerificaPercTotDipFPC;
    procedure VerificaMotivoSosp;
    procedure VerificaPercIrpefRegimiSpeciali;
    procedure VerificaCausaleIRPEF;
    procedure VerificaDetrazRedditiMin;
    procedure VerificaDecorrenzaInizioMese(bStoricizzazione: boolean);
    procedure VerificaTipoRetribuzione;
    procedure VerificaCodStatoEsteroRegimiSpeciali;
    function MessaggioVerificaDecorrenzaAnte(bStoricizzazione: boolean): String;
    procedure P430NewRecord(bStoricizzazione: boolean);
    procedure P430BeforeDelete;
    procedure ApriElencoDipendenti(SoloFieldDefs:Boolean = False);
    procedure CopiaDaDipendente;
    function ImpostaValoreRelazione: Boolean;
    function CreaSQLRelazione(bData: boolean): String;
    procedure RefreshVSQLAppoggio;
    procedure Q430SCADENZA_ANFGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure Q430SCADENZA_ANFSetText(Sender: TField; const Text: string);
    function CalcoloANF: TDatiOutP239;
    function TotaleANF: String;
    procedure ImpostaCinItalia;
    procedure ImpostaCinEuropa;
    function NormalizzaCC(Valore: String): String;
    procedure NormalizzaCinEuropa;
    function CaricaMascheraIBAN: String;
    procedure ScomponiIban(Iban: String);
    procedure P430CalcField;
    function IsDipendenteERoLA: Boolean;
    function IsDipendenteCP: Boolean;
    function IsDipendenteCO: Boolean;
    function IsDipendenteCOoLA: Boolean;
    procedure SvuotaCampiErede;
    procedure SvuotaCampiInps;
    function IsAltraAmmO_I: Boolean;
    procedure SvuotaCampiAltraAmm;
    procedure SvuotaCampiLavAut;
    function IsAltraAmmNessuna: Boolean;
    function TryLockRecordT030(const PProgressivo: Integer): Boolean;
    procedure UnlockRecordT030Rollback;
    property selP430_Funzioni: TOracleDataset read FselP430_Funzioni write FselP430_Funzioni;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TP430FAnagraficoMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  sQ010SQLTextOrig:=Q010.SQL.Text;
  Q010.SetVariable('ORDERBY','ORDER BY COD_BANCA');
  CercaBanca('','','','');
  Q015.Open;
  Q020.Open;
  Q030.Open;
  Q040.Open;
  Q080.Open;
  Q096.Open;
  Q096.Open;
  Q120.Open;
  Q130.Open;
  Q210.Open;
  Q212.Open;
  Q236.Open;
  Q240.Open;
  T480_COMUNI.Open;
  selT480S.Open;
  selI030.Open;
  selI035.Open;
  selCOLS.Open;
  RefreshVSQLAppoggio;
  selP500.SetVariable('COD_AZIENDA_BASE',T440AZIENDA_BASE);
  selP500.Open;
end;

function TP430FAnagraficoMW.AggiornaPeriodiStorici : String;
//Compatta ed espande i periodi storici considerando anche gli storici dei dati liberi
begin
  Result:='';
  scrP430.SetVariable('Progressivo',FselP430_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
  scrP430.Execute;
  //Segnalazione errore di dipendente occupato
  if VarToStr(scrP430.GetVariable('Errore')) = 'OC' then
    Result:=A000MSG_P430_ERR_DIP_IN_USO
  else
  begin
    scrT430.SetVariable('Progressivo',FselP430_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
    scrT430.Execute;
    //Segnalazione errore di dipendente occupato
    if VarToStr(scrT430.GetVariable('Errore')) = 'OC' then
      Result:=A000MSG_P430_ERR_DIP_IN_USO;
  end;
end;

procedure TP430FAnagraficoMW.AllineaDati(var MsgInforma: String; var MsgErr: String);
begin
  MsgInforma:='';
  MsgErr:='';
  {scrP430Decorrenza_Fine.SetVariable('PROGRESSIVO',C700Progressivo);
  scrP430Decorrenza_Fine.Execute;}
  //Verifico se devo aggiornare la prima decorrenza al primo del mese
  updP430.SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  updP430.Execute;
  if updP430.RowsProcessed > 0 then
    MsgInforma:=A000MSG_P430_MSG_PRIMA_ASSUNZ_INIZIO_MESE;
  MsgErr:=AggiornaPeriodiStorici;

  SessioneOracle.Commit;
end;

procedure TP430FAnagraficoMW.CompletaSQLRelazione(var RelSQL:String);
var
  NewCampo,OldCampo:String;
begin
  RelSQL:=Trim(RelSQL);
  while Pos('<#>',RelSQL) <> 0 do
  begin
    OldCampo:=Copy(RelSQL,Pos('<#>',RelSQL)+3,Pos('<#>',Copy(RelSQL,Pos('<#>',RelSQL)+3))-1);
    if OldCampo = 'DECORRENZA' then
      NewCampo:='DATADECORRENZA'
    else if OldCampo = 'DECORRENZA_FINE' then
      NewCampo:='DATAFINE'
    else if OldCampo = ';' then
      NewCampo:=' UNION SELECT '
    else if OldCampo = 'W' then
      NewCampo:=' FROM DUAL WHERE '
    else if OldCampo = 'D' then
      NewCampo:=' FROM DUAL '
    else
      NewCampo:=OldCampo;
    if (OldCampo <> ';') and (OldCampo <> 'W') and (OldCampo <> 'D') then
      RelSQL:=StringReplace(RelSQL,'<#>'+OldCampo+'<#>',''''+StringReplace(FselP430_Funzioni.FieldByName(NewCampo).AsString,'''','''''',[rfReplaceAll])+'''',[rfReplaceAll,rfIgnoreCase])
    else
      RelSQL:=StringReplace(RelSQL,'<#>'+OldCampo+'<#>',NewCampo,[rfReplaceAll,rfIgnoreCase]);
  end;
  if Copy(RelSQL,Length(RelSQL)-13,14) = ' UNION SELECT ' then
    RelSQL:=Copy(RelSQL,1,Length(RelSQL)-14);
  if Length(RelSQL) > 0 then
  begin
    if Copy(RelSQL,1,6) <> 'SELECT' then
      RelSQL:='SELECT '+RelSQL;
    if Pos(' FROM ',RelSQL) = 0 then
      RelSQL:=RelSQL+' FROM DUAL';
  end;
  RelSQL:=Trim(RelSQL);
end;

function TP430FAnagraficoMW.CreaSQLRelazione(bData: boolean): String;
var
  SqlRelazione, OldColonna: String;
  OldDecorrenza:TDateTime;
begin
  with selI035 do
  begin
    SqlRelazione:='';
    if SearchRecord('TABELLA;COLONNA;DECORRENZA',VarArrayOf([selI030.FieldByName('TABELLA').AsString,selI030.FieldByName('COLONNA').AsString,selI030.FieldByName('DECORRENZA').AsDateTime]),[srFromBeginning]) then
    begin
      OldColonna:=FieldByName('COLONNA').AsString;
      OldDecorrenza:=FieldByName('DECORRENZA').AsDateTime;
      while not Eof do
      begin
        if (OldColonna = FieldByName('COLONNA').AsString) and
           (OldDecorrenza = FieldByName('DECORRENZA').AsDateTime) then
        begin
          SqlRelazione:=SqlRelazione + ' ' + FieldByName('RELAZIONE').AsString;
          if (bData) and (Pos('ORDER BY',FieldByName('RELAZIONE').AsString) = 0) then
            SqlRelazione:=SqlRelazione + ' AND :DATA BETWEEN DECORRENZA AND DECORRENZA_FINE';
        end
        else
          Break;
        OldColonna:=FieldByName('COLONNA').AsString;
        OldDecorrenza:=FieldByName('DECORRENZA').AsDateTime;
        Next;
      end;
    end;
  end;
  if SqlRelazione <> '' then
    CompletaSQLRelazione(SqlRelazione);
  Result:=SqlRelazione;
end;

procedure TP430FAnagraficoMW.RefreshVSQLAppoggio;
var
  i: Integer;
begin
  selI030.First;
  for i:=High(VSQLAppoggio) downto 0 do
    VSQLAppoggio[i].OQ.Free;
  SetLength(VSQLAppoggio,0);
  while not selI030.Eof do
  begin
    SetLength(VSQLAppoggio,Length(VSQLAppoggio) + 1);
    i:=High(VSQLAppoggio);
    VSQLAppoggio[i].Colonna:=selI030.FieldByName('COLONNA').AsString;
    VSQLAppoggio[i].DecIni:=selI030.FieldByName('DECORRENZA').AsDateTime;
    VSQLAppoggio[i].OQ:=TOracleQuery.Create(nil);
    VSQLAppoggio[i].OQ.ReadBuffer:=2;
    VSQLAppoggio[i].OQ.Scrollable:=True;
    VSQLAppoggio[i].OQ.Session:=SessioneOracle;
    selI030.Next;
  end;
  selI030.First;
end;

procedure TP430FAnagraficoMW.Q430SCADENZA_ANFGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  if Sender.IsNull then Text:=''
  else Text:=FormatDateTime('mm/yyyy',Sender.AsDateTime);
end;

procedure TP430FAnagraficoMW.Q430SCADENZA_ANFSetText(Sender: TField;
  const Text: string);
begin
  inherited;
  if Text = '' then Sender.Clear
  else Sender.AsDateTime:=R180FineMese(StrToDate('01/' + Text));
end;

procedure TP430FAnagraficoMW.selI030FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  if (FselP430_Funzioni <> nil) and (FselP430_Funzioni.Active) then
    if FselP430_Funzioni.FieldByName('DECORRENZA_FINE').IsNull then
      Accept:=selI030.FieldByName('DECORRENZA_FINE').AsDateTime = EncodeDate(3999,12,31)
    else
      Accept:=(selI030.FieldByName('DECORRENZA').AsDateTime <= FselP430_Funzioni.FieldByName('DECORRENZA_FINE').AsDateTime) and
              (selI030.FieldByName('DECORRENZA_FINE').AsDateTime >= FselP430_Funzioni.FieldByName('DECORRENZA_FINE').AsDateTime);
end;

procedure TP430FAnagraficoMW.setCalcFieldLookup(CodField,DescField:String;lookupDS:TOracleDataSet; keyField: String );
begin
  FselP430_Funzioni.FieldByName(DescField).AsString:='';

  if not FselP430_Funzioni.FieldByName(CodField).IsNull then
    if FselP430_Funzioni.FieldByName(CodField).AsString <> lookupDS.FieldByName(keyField).AsString then
    begin
      if lookupDS.SearchRecord(keyField,FselP430_Funzioni.FieldByName(CodField).AsString,[srFromBeginning]) then
        FselP430_Funzioni.FieldByName(DescField).AsString:=lookupDS.FieldByName('DESCRIZIONE').AsString;
    end
    else
      FselP430_Funzioni.FieldByName(DescField).AsString:=lookupDS.FieldByName('DESCRIZIONE').AsString;
end;

procedure TP430FAnagraficoMW.P430CalcField;
var
  bOpen: Boolean;
  Anno: Integer;
begin
  if SelAnagrafe = nil then Exit;
  
  if Q030.GetVariable('Decorrenza') <> FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime then
  begin
    Q030.Close;
    Q030.SetVariable('Decorrenza',FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime);
    Q030.Open;
    //Tutti i dataset impostano la stessa decorrenza. se fatto per uno va fatto per tutti ed è inutile ripetere il test
    Q090.Close;
    Q090.SetVariable('Decorrenza',FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime);
    Q090.Open;
    Q092.Close;
    Q092.SetVariable('Decorrenza',FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime);
    Q092.Open;
    Q094.Close;
    Q094.SetVariable('Decorrenza',FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime);
    Q094.Open;
    Q096.Close;
    Q096.SetVariable('Decorrenza',FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime);
    Q096.Open;
    Q210.Close;
    Q210.Open;
    Q212.Close;
    Q212.SetVariable('Decorrenza',FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime);
    Q212.Open;
    Q236.Close;
    Q236.SetVariable('Decorrenza',FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime);
    Q236.Open;
    selP026.Close;
    selP026.SetVariable('Decorrenza',FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime);
    selP026.Open;
  end;
  if (Q220.GetVariable('Decorrenza') <> FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime) or
     (Q220.GetVariable('CodContratto') <> FselP430_Funzioni.FieldByName('COD_CONTRATTO').AsString) then
  begin
    Q220.Close;
    Q220.SetVariable('Decorrenza',FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime);
    Q220.SetVariable('CodContratto',FselP430_Funzioni.FieldByName('COD_CONTRATTO').AsString);
    Q220.Open;
  end;
  if (Q240.GetVariable('Decorrenza') <> FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime) or
     (Q240.GetVariable('CodContratto') <> FselP430_Funzioni.FieldByName('COD_CONTRATTO').AsString) then
  begin
    Q240.Close;
    Q240.SetVariable('Decorrenza',FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime);
    Q240.SetVariable('CodContratto',FselP430_Funzioni.FieldByName('COD_CONTRATTO').AsString);
    Q240.Open;
  end;
  //Tipo assunzione INPS
  bOpen:=False;
  if R180SetVariable(selP004TipoAss,'Anno',R180Anno(FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime)) then
    bOpen:=True;
  if R180SetVariable(selP004TipoAss,'Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger) then
    bOpen:=True;
  if bOpen then
  begin
    selP004TipoAss.Open;
    //Tutti i dataset impostano la stessa decorrenza e progressivo. se fatto per uno va fatto per tutti ed è inutile ripetere il test
    R180SetVariable(selP004TipoRapp,'Anno',R180Anno(FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime));
    R180SetVariable(selP004TipoRapp,'Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selP004TipoRapp.Open;

    R180SetVariable(selP004TipoAtt,'Anno',R180Anno(FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime));
    R180SetVariable(selP004TipoAtt,'Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selP004TipoAtt.Open;

    R180SetVariable(selP004AltreAssic,'Anno',R180Anno(FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime));
    R180SetVariable(selP004AltreAssic,'Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selP004AltreAssic.Open;

    R180SetVariable(selP004CategConvenz,'Anno',R180Anno(FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime));
    R180SetVariable(selP004CategConvenz,'Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selP004CategConvenz.Open;

    R180SetVariable(selP004TipoServAltraAmm,'Anno',R180Anno(FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime));
    R180SetVariable(selP004TipoServAltraAmm,'Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selP004TipoServAltraAmm.Open;

    R180SetVariable(selP004QualifInail,'Anno',R180Anno(FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime));
    R180SetVariable(selP004QualifInail,'Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selP004QualifInail.Open;

    R180SetVariable(selP004CatPart770,'Anno',R180Anno(FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime));
    R180SetVariable(selP004CatPart770,'Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selP004CatPart770.Open;

    R180SetVariable(selP004CausPag770,'Anno',R180Anno(FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime));
    R180SetVariable(selP004CausPag770,'Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selP004CausPag770.Open;

    R180SetVariable(selP004TipoPagOnaosi,'Anno',R180Anno(FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime));
    R180SetVariable(selP004TipoPagOnaosi,'Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selP004TipoPagOnaosi.Open;

    R180SetVariable(selP004TipoAssOnaosi,'Anno',R180Anno(FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime));
    R180SetVariable(selP004TipoAssOnaosi,'Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selP004TipoAssOnaosi.Open;

    R180SetVariable(selP004SospFPC,'Anno',R180Anno(FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime));
    R180SetVariable(selP004SospFPC,'Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selP004SospFPC.Open;

    R180SetVariable(selP004CessFPC,'Anno',R180Anno(FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime));
    R180SetVariable(selP004CessFPC,'Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selP004CessFPC.Open;
  end;

  //------- Anno = anno cessazione se dip. cessato else anno decorrenza
  if (selT430.GetVariable('Progressivo') <> SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger) or
     (selT430.GetVariable('Decorrenza') <> FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime) then
  begin
    selT430.Close;
    selT430.SetVariable('Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selT430.SetVariable('Decorrenza',FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime);
    selT430.Open;
  end;
  if selT430.Eof or (selT430.FieldByName('ANNO_FINE').AsInteger = 0) then
    Anno:=R180Anno(FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime)
  else
    Anno:=selT430.FieldByName('ANNO_FINE').AsInteger;

  //PER QUESTE ANNO PRESO DA ANNO_FINE  (NON DA DECORRENZA COME LE ALTRE...)
  bOpen:=False;
  if R180SetVariable(selP004TipoCess,'Anno',Anno) then
    bOpen:=True;
  if R180SetVariable(selP004TipoCess,'Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger) then
    bOpen:=True;
  if bOpen then
  begin
    selP004TipoCess.Open;
    R180SetVariable(selP004CausaCess,'Anno',Anno);
    R180SetVariable(selP004CausaCess,'Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selP004CausaCess.Open;

    R180SetVariable(selP004TipoCessOnaosi,'Anno',Anno);
    R180SetVariable(selP004TipoCessOnaosi,'Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selP004TipoCessOnaosi.Open;
  end;

  setCalcFieldLookup('COD_FPC','D_FPC', selP026, 'COD_FPC');
  setCalcFieldLookup('COD_INPDAPTIPOCESS_FPC','D_INPDAPTIPOCESS_FPC', selP004CessFPC, 'COD_CODICITABANNUALI');
  setCalcFieldLookup('COD_INPDAPMOTIVOSOSP_FPC','D_INPDAPMOTIVOSOSP_FPC', selP004SospFPC, 'COD_CODICITABANNUALI');
  setCalcFieldLookup('COD_ONAOSITIPOCESS','D_ONAOSITIPOCESS', selP004TipoCessOnaosi, 'COD_CODICITABANNUALI');
  setCalcFieldLookup('COD_ONAOSITIPOASS','D_ONAOSITIPOASS', selP004TipoAssOnaosi, 'COD_CODICITABANNUALI');
  setCalcFieldLookup('COD_ONAOSITIPOPAG','D_ONAOSITIPOPAG', selP004TipoPagOnaosi, 'COD_CODICITABANNUALI');
  setCalcFieldLookup('COD_CAUSALELA','D_CAUSALELA', selP004CausPag770, 'COD_CODICITABANNUALI');
  setCalcFieldLookup('COD_CATEGPARTICOLARE','D_CATEGPARTICOLARE', selP004CatPart770, 'COD_CODICITABANNUALI');
  setCalcFieldLookup('COD_QUALIFICA_INAIL','D_QUALIFICA_INAIL', selP004QualifInail, 'COD_CODICITABANNUALI');
  setCalcFieldLookup('COD_CODICEINAIL','D_CODICEINAIL', Q092, 'COD_CODICEINAIL');
  setCalcFieldLookup('COD_INPDAPTIPOLS_ALTRA_AMM','D_INPDAPTIPOLS_ALTRA_AMM', selP004TipoServAltraAmm, 'COD_CODICITABANNUALI');
  setCalcFieldLookup('COD_CATEG_CONVENZ','D_CATEG_CONVENZ', selP004CategConvenz, 'COD_CODICITABANNUALI');
  setCalcFieldLookup('COD_CUDINPDAPCAUSACESS','D_CUDINPDAPCAUSACESS', selP004CausaCess, 'COD_CODICITABANNUALI');
  setCalcFieldLookup('COD_ALTRAASS_COCOCO','D_ALTRAASS_COCOCO', selP004AltreAssic, 'COD_CODICITABANNUALI');
  setCalcFieldLookup('COD_TIPOATT_COCOCO','D_TIPOATT_COCOCO', selP004TipoAtt, 'COD_CODICITABANNUALI');
  setCalcFieldLookup('COD_TIPORAPP_COCOCO','D_TIPORAPP_COCOCO', selP004TipoRapp, 'COD_CODICITABANNUALI');
  setCalcFieldLookup('COD_EMENSTIPOASS','D_EMENSTIPOASS', selP004TipoAss, 'COD_CODICITABANNUALI');
  setCalcFieldLookup('COD_EMENSTIPOCESS','D_EMENSTIPOCESS', selP004TipoCess, 'COD_CODICITABANNUALI');
  setCalcFieldLookup('COD_VALUTA_STAMPA','D_VALUTA', Q030, 'COD_VALUTA');
  setCalcFieldLookup('COD_VALUTA_BASE','D_COD_VALUTA_BASE', Q030, 'COD_VALUTA');
  setCalcFieldLookup('COD_CONTRATTO','D_CONTRATTO', Q210, 'COD_CONTRATTO');
  setCalcFieldLookup('COD_PARAMETRISTIPENDI','D_PARAMETRISTIPENDI', Q212, 'COD_PARAMETRISTIPENDI');
  setCalcFieldLookup('COD_TIPOASSOGGETTAMENTO','D_TIPOASSOGGETTAMENTO', Q240, 'COD_TIPOASSOGGETTAMENTO');
  setCalcFieldLookup('COD_POSIZIONE_ECONOMICA','D_POSIZIONE_ECONOMICA', Q220, 'COD_POSIZIONE_ECONOMICA');
  setCalcFieldLookup('COD_TABELLAANF','D_TABELLAANF', Q236, 'COD_TABELLAANF');
  setCalcFieldLookup('COD_CODICEINPS','D_CODICEINPS', Q090, 'COD_CODICEINPS');
  setCalcFieldLookup('COD_INQUADRINPS','D_INQUADRINPS', Q096, 'COD_INQUADRINPS');
  setCalcFieldLookup('COD_INQUADRINPDAP','D_INQUADRINPDAP', Q094, 'COD_INQUADRINPDAP');

  CercaBanca(FselP430_Funzioni.FieldByName('COD_BANCA').AsString,'','','');
  FselP430_Funzioni.FieldByName('D_BANCA').AsString:=Q010.FieldByName('DESCRIZIONE').AsString;

  FselP430_Funzioni.FieldByName('D_NOMINATIVO_EREDE').AsString:='';
  if IsDipendenteERoLA or IsDipendenteCP then
  begin
    if selT030.GetVariable('PROGRESSIVO') <> FselP430_Funzioni.FieldByName('PROGRESSIVO_EREDE_DI').AsInteger then
    begin
      selT030.SetVariable('PROGRESSIVO',FselP430_Funzioni.FieldByName('PROGRESSIVO_EREDE_DI').AsInteger);
      selT030.Close;
      selT030.Open;
    end;
    FselP430_Funzioni.FieldByName('D_NOMINATIVO_EREDE').AsString:=selT030.FieldByName('NOMINATIVO').AsString;
  end;
end;

procedure TP430FAnagraficoMW.Q240AfterOpen(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('COD_TIPOASSOGGETTAMENTO').DisplayWidth:=14;
end;

procedure TP430FAnagraficoMW.CercaBanca(CodBanca,ABI,CAB,CodNazione:String);
begin
  R180SetVariable(Q010,'COD_BANCA',CodBanca);
  R180SetVariable(Q010,'ABI',ABI);
  R180SetVariable(Q010,'CAB',CAB);
  R180SetVariable(Q010,'COD_NAZIONE',CodNazione);
  Q010.Open;
end;

function TP430FAnagraficoMW.IsDipendenteERoLA:Boolean;
begin
  Result:=(FselP430_Funzioni.FieldByName('TIPO_DIPENDENTE').AsString = 'ER') or (FselP430_Funzioni.FieldByName('TIPO_DIPENDENTE').AsString = 'LA');
end;

function TP430FAnagraficoMW.IsDipendenteCP:Boolean;
begin
  Result:=FselP430_Funzioni.FieldByName('TIPO_DIPENDENTE').AsString = 'CP';
end;

function TP430FAnagraficoMW.IsDipendenteCOoLA:Boolean;
begin
  Result:=(FselP430_Funzioni.FieldByName('TIPO_DIPENDENTE').AsString = 'CO') or (FselP430_Funzioni.FieldByName('TIPO_DIPENDENTE').AsString = 'LA');
end;

function TP430FAnagraficoMW.IsDipendenteCO:Boolean;
begin
  Result:=FselP430_Funzioni.FieldByName('TIPO_DIPENDENTE').AsString = 'CO';
end;

function TP430FAnagraficoMW.IsAltraAmmNessuna:Boolean;
begin
  Result:=FselP430_Funzioni.FieldByName('ALTRA_AMM').AsString = 'N';
end;

function TP430FAnagraficoMW.IsAltraAmmO_I:Boolean;
begin
  Result:=(FselP430_Funzioni.FieldByName('ALTRA_AMM').AsString = 'O') or
          (FselP430_Funzioni.FieldByName('ALTRA_AMM').AsString = 'I');
end;

procedure TP430FAnagraficoMW.SvuotaCampiLavAut;
begin
  if not IsDipendenteCOoLA then
  begin
    FselP430_Funzioni.FieldByName('COD_CAUSALELA').Clear;
  end;
end;

procedure TP430FAnagraficoMW.SvuotaCampiInps;
begin
  if IsDipendenteCO then
  begin
    FselP430_Funzioni.FieldByName('COD_CODICEINPS').Clear;
    FselP430_Funzioni.FieldByName('COD_INQUADRINPS').Clear;
    FselP430_Funzioni.FieldByName('COD_EMENSQUALPROF').Clear;
    FselP430_Funzioni.FieldByName('COD_EMENSTIPOASS').Clear;
    FselP430_Funzioni.FieldByName('COD_EMENSTIPOCESS').Clear;
  end
  else
  begin
    FselP430_Funzioni.FieldByName('COD_TIPORAPP_COCOCO').Clear;
    FselP430_Funzioni.FieldByName('COD_TIPOATT_COCOCO').Clear;
    FselP430_Funzioni.FieldByName('COD_ALTRAASS_COCOCO').Clear;
  end;
end;

procedure TP430FAnagraficoMW.SvuotaCampiErede;
begin
  if not (IsDipendenteERoLA or IsDipendenteCP) then
  begin
    FselP430_Funzioni.FieldByName('D_NOMINATIVO_EREDE').Clear;
    FselP430_Funzioni.FieldByName('PROGRESSIVO_EREDE_DI').Clear;
  end;
  if not IsDipendenteERoLA then
    FselP430_Funzioni.FieldByName('PERC_EREDITA').Clear;
end;

procedure TP430FAnagraficoMW.SvuotaCampiAltraAmm;
begin
  if FselP430_Funzioni.FieldByName('ALTRA_AMM').AsString = 'N' then
  begin
    FselP430_Funzioni.FieldByName('COD_INPDAPTIPOLS_ALTRA_AMM').AsString:='';
    FselP430_Funzioni.FieldByName('COD_FISCALE_ALTRA_AMM').AsString:='';
    FselP430_Funzioni.FieldByName('CODICE_INPDAP_ALTRA_AMM').AsString:='';
  end
  else if FselP430_Funzioni.FieldByName('ALTRA_AMM').AsString = 'D' then
    FselP430_Funzioni.FieldByName('COD_INPDAPTIPOLS_ALTRA_AMM').AsString:='';
end;

procedure TP430FAnagraficoMW.ScomponiIban(Iban: String);
begin
  //Per cloud iban arriva senza spazi finali ( controllo lunghezza)
  if (Pos(' ',Iban) > 0)  or (Length(Iban) <> 32) then
    raise Exception.Create(A000MSG_P430_ERR_IBAN);

  //ABI (pos. 9-13)
  //CAB (pos. 15-19)
  //Codice Paese (pos. 1-2)
  CercaBanca('',Copy(Iban,9,5),Copy(Iban,15,5),Copy(Iban,1,2));
  if Q010.RecordCount = 0 then
    raise exception.Create(A000MSG_P430_ERR_BANCA);

  FselP430_Funzioni.FieldByName('COD_BANCA').AsString:=Trim(Q010.FieldByName('COD_BANCA').AsString);
  FselP430_Funzioni.FieldByName('D_BANCA').AsString:=Q010.FieldByName('DESCRIZIONE').AsString;

  FselP430_Funzioni.FieldByName('COD_PAGAMENTO').AsString:='1';
  //Codice di Controllo o CIN Europa (pos. 4-5)
  FselP430_Funzioni.FieldByName('CIN_EUROPA').AsString:=Trim(Copy(Iban,4,2));
  //CIN o CIN Italia (pos. 7)
  FselP430_Funzioni.FieldByName('CIN_ITALIA').AsString:=Trim(Copy(Iban,7,1));
  //Numero di conto (pos. 21-32)
  FselP430_Funzioni.FieldByName('CONTO_CORRENTE').AsString:=Trim(Copy(Iban,21,12));
end;

function TP430FAnagraficoMW.CaricaMascheraIBAN:String;
var
  S: String;
begin
  CercaBanca(FselP430_Funzioni.FieldByName('COD_BANCA').AsString,'','','');
  if Q010.RecordCount > 0 then
    S:=Format('%-2.2s',[Q010.FieldByName('COD_NAZIONE').AsString])
  else
    S:='__';
  S:=S + '-';
  if FselP430_Funzioni.FieldByName('CIN_EUROPA').AsString <> '' then
    S:=S + Format('%-2.2s',[FselP430_Funzioni.FieldByName('CIN_EUROPA').AsString])
  else
    S:=S + '__';
  S:=S + '-';
  if FselP430_Funzioni.FieldByName('CIN_ITALIA').AsString <> '' then
    S:=S + Format('%-1.1s',[FselP430_Funzioni.FieldByName('CIN_ITALIA').AsString])
  else
    S:=S + '_';
  S:=S + '-';
  if Q010.RecordCount > 0 then
  begin
    S:=S + Format('%-5.5s',[Q010.FieldByName('ABI').AsString]);
    S:=S + '-';
    S:=S + Format('%-5.5s',[Q010.FieldByName('CAB').AsString]);
  end
  else
    S:=S + '_____-_____';
  S:=S + '-';
  if FselP430_Funzioni.FieldByName('CONTO_CORRENTE').AsString <> '' then
    S:=S + Format('%-12.12s',[FselP430_Funzioni.FieldByName('CONTO_CORRENTE').AsString])
  else
    S:=S + '____________';
  Result:=S;
  IBANIniziale:=S;
end;

procedure TP430FAnagraficoMW.ImpostaCinItalia;
begin
  if FselP430_Funzioni.State in [dsEdit,dsInsert] then
    if FselP430_Funzioni.FieldByName('CIN_ITALIA').AsString = '' then
      FselP430_Funzioni.FieldByName('CIN_ITALIA').AsString:=R180CalcolaCIN(copy(FselP430_Funzioni.FieldByName('COD_BANCA').AsString,0,pos('_',FselP430_Funzioni.FieldByName('COD_BANCA').AsString)-1),
                                                                          copy(FselP430_Funzioni.FieldByName('COD_BANCA').AsString,pos('_',FselP430_Funzioni.FieldByName('COD_BANCA').AsString)+1,Length(FselP430_Funzioni.FieldByName('COD_BANCA').AsString)),
                                                                          FselP430_Funzioni.FieldByName('CONTO_CORRENTE').AsString);
end;

procedure TP430FAnagraficoMW.ImpostaCinEuropa;
begin
  if FselP430_Funzioni.State in [dsEdit,dsInsert] then
    if FselP430_Funzioni.FieldByName('CIN_EUROPA').AsString = '' then
    begin
      selP010.Close;
      selP010.SetVariable('COD_BANCA',FselP430_Funzioni.FieldByName('COD_BANCA').AsString);
      selP010.Open;
      FselP430_Funzioni.FieldByName('CIN_EUROPA').AsString:=R180CalcolaCINEuropa(copy(FselP430_Funzioni.FieldByName('COD_BANCA').AsString,0,pos('_',FselP430_Funzioni.FieldByName('COD_BANCA').AsString)-1),
                                                                                copy(FselP430_Funzioni.FieldByName('COD_BANCA').AsString,pos('_',FselP430_Funzioni.FieldByName('COD_BANCA').AsString)+1,Length(FselP430_Funzioni.FieldByName('COD_BANCA').AsString)),
                                                                                FselP430_Funzioni.FieldByName('CONTO_CORRENTE').AsString,
                                                                                FselP430_Funzioni.FieldByName('CIN_ITALIA').AsString,
                                                                                selP010.FieldByName('COD_NAZIONE').AsString);
    end;
end;

procedure TP430FAnagraficoMW.NormalizzaCinEuropa;
begin
  if FselP430_Funzioni.State in [dsEdit,dsInsert] then
    with FselP430_Funzioni do
      if Length(FieldByName('CIN_EUROPA').AsString) = 1 then
        FieldByName('CIN_EUROPA').AsString:='0'+FieldByName('CIN_EUROPA').AsString;
end;

function TP430FAnagraficoMW.NormalizzaCC(Valore:String):String;
var i:Integer;
    Zeri:String;
begin
  if (Length(Valore) < 12) and (Valore <> '') then
  begin
    Zeri:='';
    for i:=Length(Valore)+1 to 12 do
      Zeri:=Zeri + '0';
    Valore:=Zeri + Valore;
  end;
  Result:=Valore;
end;

function TP430FAnagraficoMW.TotaleANF:String;
begin
  Result:=FloatToStr(FselP430_Funzioni.FieldByName('REDDITO_ANF').AsFloat + FselP430_Funzioni.FieldByName('REDDITO_ALTRO_ANF').AsFloat);
end;

function TP430FAnagraficoMW.CalcoloANF: TDatiOutP239;
var
  P239FANFDtm: TP239FANFDtm;
begin
  P239FANFDtm:=TP239FANFDtm.Create(nil);
  try
    Result:=P239FANFDtm.CalcoloANF('Calcolo',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,R180FineMese(Parametri.DataLavoro));
  finally
    P239FANFDtm.Free;
  end;

end;

function TP430FAnagraficoMW.EseguiSQLRelazione(SqlRelazione: String): TOracleQuery;
var
  TrovRel: Boolean;
  i: Integer;
  SqlOriginale: String;
begin
  TrovRel:=False;
  Result:=nil;
  for i:=0 to High(VSQLAppoggio) do
    if  (VSQLAppoggio[i].Colonna = selI030.FieldByName('COLONNA').AsString)
         and (VSQLAppoggio[i].DecIni  = selI030.FieldByName('DECORRENZA').AsDateTime) then
    begin
      TrovRel:=True;
      Break;
    end;
    if TrovRel then
    begin
      with VSQLAppoggio[i].OQ do
      begin
        if (Trim(SqlRelazione) <> Trim(Sql.Text)) then
        begin
          SqlOriginale:=Sql.Text;
          Sql.Text:=SqlRelazione;
          try
            Execute;
          except
            Sql.Text:=SqlOriginale;
            Execute;
          end;
        end;
        Result:=VSQLAppoggio[i].OQ;
      end;
    end;
end;

function TP430FAnagraficoMW.ImpostaValoreRelazione: Boolean;
var
  ValoreDefault,SqlRelazione: String;
  OQ: TOracleQuery;
begin
  Result:=False;
  if (selI030.FieldByName('TIPO').AsString = 'S')
     or (
       (selI030.FieldByName('TIPO').AsString = 'L')
       and (
         (FselP430_Funzioni.FieldByName(selI030.FieldByName('COLONNA').AsString).AsString = '')
          or (FselP430_Funzioni.State in [dsInsert])
       )
     ) then
  begin
    SqlRelazione:=CreaSQLRelazione(False);
    if Trim(SqlRelazione) <> '' then
    begin
      //Cerco la relazione salvata
      OQ:=EseguiSQLRelazione(SqlRelazione);
      if OQ <> nil then
      begin
        Result:=True;
        if OQ.RowCount = 0 then
          FselP430_Funzioni.FieldByName(selI030.FieldByName('COLONNA').AsString).AsString:=''
        else
        begin
          OQ.First;
          if (OQ.FieldAsString(0) = '') and (OQ.RowsProcessed > 1) then
            OQ.Next;
          FselP430_Funzioni.FieldByName(selI030.FieldByName('COLONNA').AsString).AsString:=OQ.FieldAsString(0);
        end;

        if FselP430_Funzioni.FieldByName(selI030.FieldByName('COLONNA').AsString).AsString = '' then
          if selCOLS.SearchRecord('COLUMN_NAME',VarArrayOf([selI030.FieldByName('COLONNA').AsString]),[srFromBeginning]) then
          begin
            ValoreDefault:=Trim(selCOLS.FieldByName('DATA_DEFAULT').AsString);
            if (Copy(ValoreDefault,1,1) = '''') and (Copy(ValoreDefault,Length(ValoreDefault),1) = '''') then
              ValoreDefault:=Copy(ValoreDefault,2,Length(ValoreDefault)-2);
            FselP430_Funzioni.FieldByName(selI030.FieldByName('COLONNA').AsString).AsString:=ValoreDefault;
          end;
      end;
    end;
  end;
end;

procedure TP430FAnagraficoMW.P430NewRecord(bStoricizzazione: boolean);
begin
  inherited;
  FselP430_Funzioni.FieldByName('PROGRESSIVO').AsInteger:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime:=R180InizioMese(Parametri.DataLavoro);
  if not bStoricizzazione then
  //Se nuovo dipendente leggo setup alla data di lavoro per impostare comune Inail
  begin
    if selP150.GetVariable('Decorrenza') <> Parametri.DataLavoro then
    begin
      selP150.Close;
      selP150.SetVariable('Decorrenza',Parametri.DataLavoro);
      selP150.Open;
    end;
    FselP430_Funzioni.FieldByName('COD_COMUNE_INAIL').AsString:=selP150.FieldByName('COD_COMUNE_INAIL').AsString;
  end;
end;

procedure TP430FAnagraficoMW.P430BeforeDelete;
begin
  if FselP430_Funzioni.RecordCount = 1 then
  begin
    selP442.Close;
    selP442.SetVariable('Progressivo',FselP430_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
    selP442.Open;
    if selP442.RecordCount > 0 then
      raise exception.Create(A000MSG_P430_ERR_DEL_ESISTE_CEDOLINO);
  end;
end;

procedure TP430FAnagraficoMW.ApriElencoDipendenti(SoloFieldDefs:Boolean = False);
begin
  selP430.Close;
  selP430.SetVariable('DATALAVORO',Parametri.DataLavoro);
  if Trim(Parametri.Inibizioni.Text) <> '' then
  begin
    selP430.SetVariable('SEL_STORICO','T430QUALIFICAMINIST, T430D_QUALIFICAMINIST DESC_QUALMIN');
    selP430.SetVariable('TAB_STORICO','V430_STORICO V430');
    selP430.SetVariable('WHERE_STORICO','T430PROGRESSIVO = T030.PROGRESSIVO AND :DATALAVORO BETWEEN T430DATADECORRENZA AND T430DATAFINE');
    selP430.SetVariable('FILTROANAGRAFE',' AND ' + Parametri.Inibizioni.Text);
  end
  else
  begin
    selP430.SetVariable('SEL_STORICO','T430.QUALIFICAMINIST T430QUALIFICAMINIST, T470.DESCRIZIONE DESC_QUALMIN');
    selP430.SetVariable('TAB_STORICO','T430_STORICO T430, T470_QUALIFICAMINIST T470');
    selP430.SetVariable('WHERE_STORICO','T430.PROGRESSIVO = T030.PROGRESSIVO AND :DATALAVORO BETWEEN T430.DATADECORRENZA AND T430.DATAFINE AND T430.QUALIFICAMINIST = T470.CODICE(+) AND :DATALAVORO BETWEEN T470.DECORRENZA(+) AND T470.DECORRENZA_FINE(+)');
    selP430.SetVariable('FILTROANAGRAFE',' ');
  end;
  selP430.SetVariable('ORDERBY','ORDER BY MATRICOLA, COGNOME, NOME, P430.COD_POSIZIONE_ECONOMICA');
  selP430.FieldDefs.Update;
  CreaFieldDefsP430;
  if not SoloFieldDefs then
    selP430.Open;
end;

procedure TP430FAnagraficoMW.CreaFieldDefsP430;
var i: Integer;
begin
  selP430.Fields.Clear;
  for i:=0 to selP430.FieldDefs.Count - 1 do
  begin
    selP430.FieldDefs[i].CreateField(selP430);
    ImpostaFieldDefP430(selP430.FieldDefs[i].Name);
  end;
end;

procedure TP430FAnagraficoMW.ImpostaFieldDefP430(NomeCampo: String);
begin
  if UpperCase(NomeCampo) = 'MATRICOLA' then
  begin
    selP430.FieldByName(NomeCampo).Visible:=true;
    selP430.FieldByName(NomeCampo).DisplayLabel:='Matricola';
  end
  else if UpperCase(NomeCampo) = 'COGNOME' then
  begin
    selP430.FieldByName(NomeCampo).Visible:=true;
    selP430.FieldByName(NomeCampo).DisplayLabel:='Cognome';
  end
  else if UpperCase(NomeCampo) = 'NOME' then
  begin
    selP430.FieldByName(NomeCampo).Visible:=true;
    selP430.FieldByName(NomeCampo).DisplayLabel:='Nome';
  end
  else if UpperCase(NomeCampo) = 'DESC_TIPODIP' then
  begin
    selP430.FieldByName(NomeCampo).Visible:=true;
    selP430.FieldByName(NomeCampo).DisplayLabel:='Tipo dip.';
  end
  else if UpperCase(NomeCampo) = 'T430QUALIFICAMINIST' then
  begin
    selP430.FieldByName(NomeCampo).Visible:=true;
    selP430.FieldByName(NomeCampo).DisplayLabel:='Qualif. minist.';
  end
  else if UpperCase(NomeCampo) = 'DESC_QUALMIN' then
  begin
    selP430.FieldByName(NomeCampo).Visible:=true;
    selP430.FieldByName(NomeCampo).DisplayLabel:=' ';
  end
  else if UpperCase(NomeCampo) = 'COD_POSIZIONE_ECONOMICA' then
  begin
    selP430.FieldByName(NomeCampo).Visible:=true;
    selP430.FieldByName(NomeCampo).DisplayLabel:='Posiz. economica';
  end
  else if UpperCase(NomeCampo) = 'DESC_POSECON' then
  begin
    selP430.FieldByName(NomeCampo).Visible:=true;
    selP430.FieldByName(NomeCampo).DisplayLabel:=' ';
  end
  else if UpperCase(NomeCampo) = 'COD_TIPOASSOGGETTAMENTO' then
  begin
    selP430.FieldByName(NomeCampo).Visible:=true;
    selP430.FieldByName(NomeCampo).DisplayLabel:='Tipo assogg.';
  end
  else if UpperCase(NomeCampo) = 'DESC_ASSOGGETTAMENTO' then
  begin
    selP430.FieldByName(NomeCampo).Visible:=true;
    selP430.FieldByName(NomeCampo).DisplayLabel:=' ';
  end
  else
  begin
    selP430.FieldByName(NomeCampo).Visible:=false;
  end;
end;

procedure TP430FAnagraficoMW.CopiaDaDipendente;
begin
  selP430a.Close;
  selP430a.SetVariable('PROGRESSIVO',selP430.FieldByName('progressivo').AsInteger);
  selP430a.SetVariable('DATALAVORO',Parametri.DataLavoro);
  selP430a.Open;
  //Copio i dati dal dipendente selezionato
  FselP430_Funzioni.FieldByName('cod_contratto').AsString:=selP430a.FieldByName('cod_contratto').AsString;
  FselP430_Funzioni.FieldByName('cod_posizione_economica').AsString:=selP430a.FieldByName('cod_posizione_economica').AsString;
  FselP430_Funzioni.FieldByName('cod_parttime').AsString:=selP430a.FieldByName('cod_parttime').AsString;
  FselP430_Funzioni.FieldByName('no_cedolino_normale').AsString:=selP430a.FieldByName('no_cedolino_normale').AsString;
  if not selP430a.FieldByName('perc_irpef_manuale').IsNull then
    FselP430_Funzioni.FieldByName('perc_irpef_manuale').AsFloat:=selP430a.FieldByName('perc_irpef_manuale').AsFloat;
  FselP430_Funzioni.FieldByName('conguaglio').AsString:=selP430a.FieldByName('conguaglio').AsString;
  FselP430_Funzioni.FieldByName('tredicesima').AsString:=selP430a.FieldByName('tredicesima').AsString;
  FselP430_Funzioni.FieldByName('cod_valuta_base').AsString:=selP430a.FieldByName('cod_valuta_base').AsString;
  FselP430_Funzioni.FieldByName('cod_valuta_stampa').AsString:=selP430a.FieldByName('cod_valuta_stampa').AsString;
  FselP430_Funzioni.FieldByName('cod_parametristipendi').AsString:=selP430a.FieldByName('cod_parametristipendi').AsString;
  if not selP430a.FieldByName('perc_irpef_tfr').IsNull then
    FselP430_Funzioni.FieldByName('perc_irpef_tfr').AsFloat:=selP430a.FieldByName('perc_irpef_tfr').AsFloat;
  FselP430_Funzioni.FieldByName('tipo_calcolo_importo13a').AsString:=selP430a.FieldByName('tipo_calcolo_importo13a').AsString;
  FselP430_Funzioni.FieldByName('cod_codiceinps').AsString:=selP430a.FieldByName('cod_codiceinps').AsString;
  FselP430_Funzioni.FieldByName('cod_codiceinail').AsString:=selP430a.FieldByName('cod_codiceinail').AsString;
  FselP430_Funzioni.FieldByName('stato_dipendente').AsString:=selP430a.FieldByName('stato_dipendente').AsString;
  FselP430_Funzioni.FieldByName('tipo_dipendente').AsString:=selP430a.FieldByName('tipo_dipendente').AsString;
  if selP430a.FieldByName('tipo_dipendente').AsString = 'LA' then
  begin
    FselP430_Funzioni.FieldByName('detraz_lavdip').AsString:='N';
    FselP430_Funzioni.FieldByName('bonus_riduz_cuneo_fisc').AsString:='N';
  end;
  FselP430_Funzioni.FieldByName('cod_causaleirpef').AsString:=selP430a.FieldByName('cod_causaleirpef').AsString;
  FselP430_Funzioni.FieldByName('cod_tipoassoggettamento').AsString:=selP430a.FieldByName('cod_tipoassoggettamento').AsString;
  FselP430_Funzioni.FieldByName('cod_inquadrinpdap').AsString:=selP430a.FieldByName('cod_inquadrinpdap').AsString;
  FselP430_Funzioni.FieldByName('cod_inquadrinps').AsString:=selP430a.FieldByName('cod_inquadrinps').AsString;
  FselP430_Funzioni.FieldByName('livello_inps').AsString:=selP430a.FieldByName('livello_inps').AsString;
  if not selP430a.FieldByName('progressivo_erede_di').IsNull then
    FselP430_Funzioni.FieldByName('progressivo_erede_di').AsFloat:=selP430a.FieldByName('progressivo_erede_di').AsFloat;
  if not selP430a.FieldByName('perc_eredita').IsNull then
    FselP430_Funzioni.FieldByName('perc_eredita').AsFloat:=selP430a.FieldByName('perc_eredita').AsFloat;
  FselP430_Funzioni.FieldByName('cod_categparticolare').AsString:=selP430a.FieldByName('cod_categparticolare').AsString;
  FselP430_Funzioni.FieldByName('cod_qualifica_inail').AsString:=selP430a.FieldByName('cod_qualifica_inail').AsString;
  FselP430_Funzioni.FieldByName('cod_comune_inail').AsString:=selP430a.FieldByName('cod_comune_inail').AsString;
  FselP430_Funzioni.FieldByName('cod_causalela').AsString:=selP430a.FieldByName('cod_causalela').AsString;
  if not selP430a.FieldByName('perc_irpef_extra27').IsNull then
    FselP430_Funzioni.FieldByName('perc_irpef_extra27').AsFloat:=selP430a.FieldByName('perc_irpef_extra27').AsFloat;
  FselP430_Funzioni.FieldByName('perc_irpef_massima_extra27').AsString:=selP430a.FieldByName('perc_irpef_massima_extra27').AsString;
  FselP430_Funzioni.FieldByName('professione_onaosi').AsString:=selP430a.FieldByName('professione_onaosi').AsString;
  FselP430_Funzioni.FieldByName('cod_emenstipoass').AsString:=selP430a.FieldByName('cod_emenstipoass').AsString;
  FselP430_Funzioni.FieldByName('cod_emenstipocess').AsString:=selP430a.FieldByName('cod_emenstipocess').AsString;
  FselP430_Funzioni.FieldByName('cod_tiporapp_cococo').AsString:=selP430a.FieldByName('cod_tiporapp_cococo').AsString;
  FselP430_Funzioni.FieldByName('cod_tipoatt_cococo').AsString:=selP430a.FieldByName('cod_tipoatt_cococo').AsString;
  FselP430_Funzioni.FieldByName('cod_altraass_cococo').AsString:=selP430a.FieldByName('cod_altraass_cococo').AsString;
  FselP430_Funzioni.FieldByName('cod_onaositipoass').AsString:=selP430a.FieldByName('cod_onaositipoass').AsString;
  FselP430_Funzioni.FieldByName('cod_onaositipopag').AsString:=selP430a.FieldByName('cod_onaositipopag').AsString;
  FselP430_Funzioni.FieldByName('tipo_massimale_contr').AsString:=selP430a.FieldByName('tipo_massimale_contr').AsString;
  FselP430_Funzioni.FieldByName('retrib_mese_prec').AsString:=selP430a.FieldByName('retrib_mese_prec').AsString;
  FselP430_Funzioni.FieldByName('cod_categ_convenz').AsString:=selP430a.FieldByName('cod_categ_convenz').AsString;
  selaT430.Close;
  selaT430.SetVariable('PROGRESSIVO',FselP430_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
  selaT430.Open;
  FselP430_Funzioni.FieldByName('decorrenza').AsDateTime:=R180InizioMese(selaT430.FieldByName('max_ini').AsDateTime);
end;

function TP430FAnagraficoMW.MessaggioVerificaDecorrenzaAnte(bStoricizzazione: boolean) : String;
begin
  Result:='';
  if  (bStoricizzazione)
  and (FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime > (FselP430_Funzioni.FieldByName('DECORRENZA_FINE').AsDateTime + 1)) then
    Result:=A000MSG_P430_DLG_DECOR_ANTE;
end;

procedure TP430FAnagraficoMW.VerificaDecorrenzaInizioMese(bStoricizzazione: boolean);
begin
  if (bStoricizzazione)
  and (FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime <> R180InizioMese(FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime)) then
  begin
    selbT430.Close;
    selbT430.SetVariable('PROGRESSIVO',FselP430_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
    selbT430.SetVariable('DECORRENZA',FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime);
    selbT430.Open;
    //Se alla data di decorrenza il dipendente è in servizio
    //ma nei giorni precedenti dello stesso mese non lo è mai
    //e non ci sono altre decorrenze in tale periodo, segnalo...
    if selbT430.FieldByName('N_PERIODI').AsInteger > 0 then
      raise exception.Create(A000MSG_P430_ERR_DECOR_INIZIO_MESE);
  end;
end;

procedure TP430FAnagraficoMW.VerificaDetrazRedditiMin;
begin
  if (FselP430_Funzioni.FieldByName('DETRAZ_REDDITI_MIN_INDET').AsString = 'S') and
     (FselP430_Funzioni.FieldByName('DETRAZ_REDDITI_MIN_DET').AsString = 'S') then
  begin
    raise exception.Create(A000MSG_P430_ERR_DETRAZ_REDD_MIN);
  end;
end;

procedure TP430FAnagraficoMW.VerificaCausaleIRPEF;
begin
  if Copy(FselP430_Funzioni.FieldByName('COD_CAUSALEIRPEF').AsString,1,3) = 'F24' then
  begin
    raise exception.Create(A000MSG_P430_ERR_CAUSALE_F24);
  end;
end;

procedure TP430FAnagraficoMW.VerificaTipoAdesioneFPC;
begin
  if ((FselP430_Funzioni.FieldByName('TIPO_ADESIONE_FPC').AsString = 'N')
      or (FselP430_Funzioni.FieldByName('TIPO_ADESIONE_FPC').AsString = 'I')
      or (FselP430_Funzioni.FieldByName('TIPO_ADESIONE_FPC').AsString = 'R'))
     and (Trim(FselP430_Funzioni.FieldByName('COD_FPC').AsString) <> '') then
    raise exception.Create(A000MSG_P430_ERR_SI_TIPO_ADES_COD_FPC);
  if ((FselP430_Funzioni.FieldByName('TIPO_ADESIONE_FPC').AsString = 'V')
      or (FselP430_Funzioni.FieldByName('TIPO_ADESIONE_FPC').AsString = 'S'))
     and (Trim(FselP430_Funzioni.FieldByName('COD_FPC').AsString) = '') then
    raise exception.Create(A000MSG_P430_ERR_NO_TIPO_ADES_COD_FPC);
end;

procedure TP430FAnagraficoMW.VerificaDataInfSilAssFPC;
begin
  if ((FselP430_Funzioni.FieldByName('TIPO_ADESIONE_FPC').AsString = 'I')
      or (FselP430_Funzioni.FieldByName('TIPO_ADESIONE_FPC').AsString = 'R'))
     and (FselP430_Funzioni.FieldByName('DATA_INF_SIL_ASS_FPC').IsNull) then
    raise exception.Create(A000MSG_P430_ERR_NO_DATA_INF_SIL_ASS_FPC);
  if (FselP430_Funzioni.FieldByName('TIPO_ADESIONE_FPC').AsString = 'N') and (not FselP430_Funzioni.FieldByName('DATA_INF_SIL_ASS_FPC').IsNull) then
    raise exception.Create(A000MSG_P430_ERR_SI_DATA_INF_SIL_ASS_FPC);
end;

procedure TP430FAnagraficoMW.VerificaCodFPC;
begin
  if (Trim(FselP430_Funzioni.FieldByName('COD_FPC').AsString) = '')
  and (   not FselP430_Funzioni.FieldByName('DATA_DOMANDA_FPC').IsNull
       or (FselP430_Funzioni.FieldByName('LAV_PRIMA_OCCUP_FPC').AsString <> 'N')
       or not FselP430_Funzioni.FieldByName('PERC_TOT_DIP_FPC').IsNull
       or not FselP430_Funzioni.FieldByName('DATA_SOSP_CESS_FPC').IsNull
       or (Trim(FselP430_Funzioni.FieldByName('COD_INPDAPMOTIVOSOSP_FPC').AsString) <> '')
       or (Trim(FselP430_Funzioni.FieldByName('COD_INPDAPTIPOCESS_FPC').AsString) <> '')) then
    raise exception.Create(A000MSG_P430_ERR_NO_COD_FPC);
end;

procedure TP430FAnagraficoMW.VerificaDataDomandaFPC;
begin
  if (Trim(FselP430_Funzioni.FieldByName('COD_FPC').AsString) <> '') and FselP430_Funzioni.FieldByName('DATA_DOMANDA_FPC').IsNull then
    raise exception.Create(A000MSG_P430_ERR_NO_DATA_DOMANDA_FPC);
end;

procedure TP430FAnagraficoMW.VerificaLavPrimaOccupFPC;
begin
  if (FselP430_Funzioni.FieldByName('DATA_DOMANDA_FPC').AsDateTime < EncodeDate(2018,1,1)) and (FselP430_Funzioni.FieldByName('LAV_PRIMA_OCCUP_FPC').AsString <> 'N') then
    raise exception.Create(A000MSG_P430_ERR_LAV_PRIMA_OCCUP_FPC);
end;

procedure TP430FAnagraficoMW.VerificaPercTotDipFPC;
begin
  if (Trim(FselP430_Funzioni.FieldByName('COD_FPC').AsString) <> '') and (FselP430_Funzioni.FieldByName('PERC_TOT_DIP_FPC').AsFloat <= 0) then
    raise exception.Create(A000MSG_P430_ERR_NO_PERC_TOT_DIP_FPC);
end;

procedure TP430FAnagraficoMW.VerificaMotivoSosp;
begin
  if (Trim(FselP430_Funzioni.FieldByName('COD_INPDAPMOTIVOSOSP_FPC').AsString) <> '') and (Trim(FselP430_Funzioni.FieldByName('COD_INPDAPTIPOCESS_FPC').AsString) <> '') then
  begin
    raise exception.Create(A000MSG_P430_ERR_MOTIVO_SOSP);
  end;
end;

procedure TP430FAnagraficoMW.VerificaPercIrpefRegimiSpeciali;
begin
  if (FselP430_Funzioni.FieldByName('PERC_IRPEF_REGIMI_SPECIALI').AsString <> '') and
     ((FselP430_Funzioni.FieldByName('PERC_IRPEF_REGIMI_SPECIALI').AsFloat < 10) or (FselP430_Funzioni.FieldByName('PERC_IRPEF_REGIMI_SPECIALI').AsFloat > 50)) then
    raise exception.Create(A000MSG_P430_ERR_PERC_IRPEF_REGIMI_SPEC);
end;

procedure TP430FAnagraficoMW.VerificaContrattoVoci;
begin
  if Trim(FselP430_Funzioni.FieldByName('COD_CONTRATTO').AsString) = '' then
  begin
    raise Exception.Create(A000MSG_P430_ERR_NO_CONTRATTO_VOCI);
  end;
end;

procedure TP430FAnagraficoMW.VerificaAreaContrat;
begin
  if Trim(FselP430_Funzioni.FieldByName('COD_PARAMETRISTIPENDI').AsString) = '' then
  begin
    raise Exception.Create(A000MSG_P430_ERR_NO_AREA_CONTRAT);
  end;
  if Trim(FselP430_Funzioni.FieldByName('COD_CONTRATTO').AsString) <> Trim(FselP430_Funzioni.FieldByName('COD_PARAMETRISTIPENDI').AsString) then
  begin
    raise Exception.Create(A000MSG_P430_ERR_AREA_CONTRAT);
  end;
end;

procedure TP430FAnagraficoMW.VerificaPercEredita;
begin
  if FselP430_Funzioni.FieldByName('TIPO_DIPENDENTE').AsString = 'ER' then
  begin
    if FselP430_Funzioni.FieldByName('PERC_EREDITA').asFloat > 100 then
      raise Exception.Create(A000MSG_P430_ERR_PERC_EREDITA);
  end;
end;

procedure TP430FAnagraficoMW.VerificaModuloCP;
begin
  if IsDipendenteCP and not Parametri.ModuloInstallato['CREDITORI_PIGNORATIZI'] then
    raise Exception.Create(A000MSG_P430_ERR_CREDITORI_PIGNORATIZI);
end;

procedure TP430FAnagraficoMW.VerificaTipoRetribuzione;
begin
  if FselP430_Funzioni.FieldByName('RETRIB_MESE_PREC').AsString = 'P' then
  begin
    if not ((FselP430_Funzioni.FieldByName('COD_CONTRATTO').AsString = 'EDPSC') and
       (FselP430_Funzioni.FieldByName('COD_POSIZIONE_ECONOMICA').AsString.StartsWith('MG') or FselP430_Funzioni.FieldByName('COD_POSIZIONE_ECONOMICA').AsString.StartsWith('MP'))) then
    begin
      raise Exception.Create(A000MSG_P430_ERR_TIPO_RETRIBUZIONE);
    end;
  end;
end;

procedure TP430FAnagraficoMW.VerificaTipoServAltraAmm;
begin
  if FselP430_Funzioni.FieldByName('ALTRA_AMM').AsString <> 'N' then
  begin
    if (FselP430_Funzioni.FieldByName('COD_INPDAPTIPOLS_ALTRA_AMM').AsString = '') and (FselP430_Funzioni.FieldByName('ALTRA_AMM').AsString <> 'D') then
    begin
      raise Exception.Create(A000MSG_P430_ERR_NO_TIPO_SERV_ALTRA_AMM);
    end;
  end;
end;

procedure TP430FAnagraficoMW.VerificaCodFiscaleAltraAmm;
begin
  if FselP430_Funzioni.FieldByName('ALTRA_AMM').AsString <> 'N' then
  begin
    if FselP430_Funzioni.FieldByName('COD_FISCALE_ALTRA_AMM').AsString = '' then
    begin
      raise Exception.Create(A000MSG_P430_ERR_NO_COD_FISC_ALTRA_AMM);
    end;
  end;
end;

procedure TP430FAnagraficoMW.VerificaCodInps;
begin
  if not ((FselP430_Funzioni.FieldByName('TIPO_DIPENDENTE').AsString = 'ER') or IsDipendenteCP) then
    if FselP430_Funzioni.FieldByName('COD_CODICEINPS').IsNull and (not FselP430_Funzioni.FieldByName('COD_INQUADRINPS').IsNull) then
      raise exception.create(A000MSG_P430_MSG_INQUADR_INPS);
end;

procedure TP430FAnagraficoMW.VerificaCodInpdapAltraAmm;
begin
  if FselP430_Funzioni.FieldByName('ALTRA_AMM').AsString <> 'N' then
  begin
    if FselP430_Funzioni.FieldByName('CODICE_INPDAP_ALTRA_AMM').AsString = '' then
    begin
      raise Exception.Create(A000MSG_P430_ERR_PROG_ALTRA_AMM);
    end;
  end;
end;

procedure TP430FAnagraficoMW.VerificaCodBanca;
begin
  if not FselP430_Funzioni.FieldByName('COD_BANCA').IsNull then
  begin
    Q010.Close;//Forzo la chiusura per evitare che la banca sia stata cancellata nel frattempo
    CercaBanca(FselP430_Funzioni.FieldByName('COD_BANCA').AsString,'','','');
    if Q010.RecordCount <= 0 then
      raise Exception.Create(A000MSG_P430_ERR_COD_BANCA);
    if (Trim(FselP430_Funzioni.FieldByName('IBAN_ESTERO').AsString) <> '') and (Trim(Q010.FieldByName('COD_NAZIONE').AsString) = 'IT') then
      raise Exception.Create(A000MSG_P430_ERR_COD_BANCA_ESTERA);
  end;
end;

procedure TP430FAnagraficoMW.VerificaCittaEstera;
begin
  if (Trim(FselP430_Funzioni.FieldByName('IBAN_ESTERO').AsString) <> '') and (Trim(FselP430_Funzioni.FieldByName('IBAN_ESTERO_CITTA').AsString) = '') then
    raise Exception.Create(A000MSG_P430_ERR_CITTA_ESTERA);
end;

procedure TP430FAnagraficoMW.VerificaCodStatoEsteroRegimiSpeciali;
begin
  if FselP430_Funzioni.FieldByName('COD_STATO_EST_REG_SPEC').AsString <> '' then
  begin
    if FselP430_Funzioni.FieldByName('PERC_IRPEF_REGIMI_SPECIALI').AsString = '' then
    begin
      raise Exception.Create(A000MSG_P430_ERR_NO_COD_STATO_REG_SPEC);
    end;
  end;
end;

function TP430FAnagraficoMW.MessaggioIban(Iban: String): String;
begin
  Result:='';
  if (Trim(FselP430_Funzioni.FieldByName('IBAN_ESTERO').AsString) = '') and (IBANIniziale <> Iban) then
    Result:=A000MSG_P430_DLG_IBAN_DISALLINEATO;
end;

function TP430FAnagraficoMW.MessaggioErede: String;
begin
  Result:='';
  if (FselP430_Funzioni.FieldByName('TIPO_DIPENDENTE').AsString = 'LA') and (Trim(FselP430_Funzioni.FieldByName('D_NOMINATIVO_EREDE').AsString) <> '') then
  begin
    Result:=A000MSG_P430_DLG_EREDE;
  end;
end;

function TP430FAnagraficoMW.MessaggioInquadrInpdap: String;
begin
  Result:='';
  if not ((FselP430_Funzioni.FieldByName('TIPO_DIPENDENTE').AsString = 'ER') or IsDipendenteCP) then
  begin
    if ((pos('CPS',FselP430_Funzioni.FieldByName('D_TIPOASSOGGETTAMENTO').AsString) <> 0) or (pos('CPDEL',FselP430_Funzioni.FieldByName('D_TIPOASSOGGETTAMENTO').AsString) <> 0)) and (FselP430_Funzioni.FieldByName('COD_INQUADRINPDAP').IsNull) then
    begin
      Result:=A000MSG_P430_DLG_NO_INQUADR_INPDAP;
    end;
  end;
end;

procedure TP430FAnagraficoMW.ControlliNonBloccanti(var LstErrori: TStringList);
var
  DataAdesioneFPC,DataAdesioneTeoricaFPC:TDateTime;
begin
  //--------------------------------------------------------------------------------------------------------------------------------------------
  // Controlli non bloccanti
  //--------------------------------------------------------------------------------------------------------------------------------------------
  if FselP430_Funzioni.FieldByName('REDDITO_DETRAZ_FIGLI_ALTRI').AsString <> '' then
    LstErrori.Add(A000MSG_P430_MSG_REDD_COMPLE);

  if FselP430_Funzioni.FieldByName('REDDITO_DETRAZ_LAVDIP').AsString <> '' then
    LstErrori.Add(A000MSG_P430_MSG_REDD_ABITAZIONE_PRINC);

  if FselP430_Funzioni.FieldByName('TIPO_DIPENDENTE').AsString = 'ER' then
  begin
    if FselP430_Funzioni.FieldByName('STATO_DIPENDENTE').AsString <> '0' then
      LstErrori.Add(A000MSG_P430_MSG_EREDE_NONDIP);
    if FselP430_Funzioni.FieldByName('NO_CEDOLINO_NORMALE').AsString <> 'S' then
      LstErrori.Add(A000MSG_P430_MSG_EREDE_VOCI_VARIABILI);
    selSQL.SQL.Clear;
    selSQL.SQL.Text:='SELECT P430.TIPO_DIPENDENTE FROM P430_ANAGRAFICO P430 WHERE P430.PROGRESSIVO = ' + FselP430_Funzioni.FieldByName('PROGRESSIVO_EREDE_DI').AsString +
                        'AND SYSDATE BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE';
    selSQL.Execute;
    if (selSQL.RowCount > 0) and (VarToStr(selSQL.Field(0)) <> 'LA') then
    begin
      if FselP430_Funzioni.FieldByName('COD_TIPOASSOGGETTAMENTO').AsString <> 'IRAP' then
        LstErrori.Add(A000MSG_P430_MSG_EREDE_IRAP);
      if FselP430_Funzioni.FieldByName('COD_CAUSALEIRPEF').AsString <> '1001' then
        LstErrori.Add(A000MSG_P430_MSG_EREDE_CAUS_VERS);
    end;
    if Trim(FselP430_Funzioni.FieldByName('D_NOMINATIVO_EREDE').AsString) = '' then
      LstErrori.Add(A000MSG_P430_MSG_EREDE_SENZA_EREDE_DI);
    if Trim(FselP430_Funzioni.FieldByName('PERC_EREDITA').AsString) = '' then
      LstErrori.Add(A000MSG_P430_MSG_EREDE_PCT_EREDITA);
    if StrToFloatDef(Trim(FselP430_Funzioni.FieldByName('PERC_EREDITA').AsString),0) <= 0 then
      LstErrori.Add(A000MSG_P430_MSG_EREDE_PCT_EREDITA_ERR);
    if FselP430_Funzioni.FieldByName('CONGUAGLIO').AsString <> 'N' then
      LstErrori.Add(A000MSG_P430_MSG_EREDE_CONGUAGLIO_IRPEF);
    if FselP430_Funzioni.FieldByName('DETRAZ_LAVDIP').AsString <> 'N' then
      LstErrori.Add(A000MSG_P430_MSG_EREDE_DETRAZ_LAVDIP);
    if FselP430_Funzioni.FieldByName('BONUS_RIDUZ_CUNEO_FISC').AsString <> 'N' then
      LstErrori.Add(A000MSG_P430_MSG_EREDE_BONUS_RIDUZ_FISC);
  end
  else if IsDipendenteCP then
  begin
    if FselP430_Funzioni.FieldByName('STATO_DIPENDENTE').AsString <> '1' then
      LstErrori.Add(A000MSG_P430_MSG_CRPIG_DIP_RETRIBUITO);
    if FselP430_Funzioni.FieldByName('NO_CEDOLINO_NORMALE').AsString <> 'N' then
      LstErrori.Add(A000MSG_P430_MSG_CRPIG_CEDOL_COMPLETO);
    if FselP430_Funzioni.FieldByName('COD_TIPOASSOGGETTAMENTO').AsString <> 'IRPEF' then
      LstErrori.Add(A000MSG_P430_MSG_CRPIG_IRPEF);
    if Trim(FselP430_Funzioni.FieldByName('D_NOMINATIVO_EREDE').AsString) = '' then
      LstErrori.Add(A000MSG_P430_MSG_CRPIG_SENZA_CREDITORE_DI);
    if FselP430_Funzioni.FieldByName('TREDICESIMA').AsString <> 'N' then
      LstErrori.Add(A000MSG_P430_MSG_CRPIG_TREDICESIMA);
    if FselP430_Funzioni.FieldByName('CONGUAGLIO').AsString <> 'N' then
      LstErrori.Add(A000MSG_P430_MSG_CRPIG_CONGUAGLIO_IRPEF);
    if FselP430_Funzioni.FieldByName('DETRAZ_LAVDIP').AsString <> 'N' then
      LstErrori.Add(A000MSG_P430_MSG_CRPIG_DETRAZ_LAVDIP);
    if FselP430_Funzioni.FieldByName('BONUS_RIDUZ_CUNEO_FISC').AsString <> 'N' then
      LstErrori.Add(A000MSG_P430_MSG_CRPIG_BONUS_RIDUZ_FISC);
  end
  else
  begin
    if FselP430_Funzioni.FieldByName('COD_CAUSALEIRPEF').IsNull then
      LstErrori.Add(A000MSG_P430_MSG_NO_CAUS_VERS_IRPEF);
    if (pos('CPS',FselP430_Funzioni.FieldByName('D_TIPOASSOGGETTAMENTO').AsString) <> 0) and FselP430_Funzioni.FieldByName('PROFESSIONE_ONAOSI').IsNull then
      LstErrori.Add(A000MSG_P430_MSG_NO_PROF_ONAOSI);
    if (FselP430_Funzioni.FieldByName('TIPO_DIPENDENTE').AsString <> 'AS') and (FselP430_Funzioni.FieldByName('TIPO_DIPENDENTE').AsString <> 'LA') and
       (FselP430_Funzioni.FieldByName('TIPO_DIPENDENTE').AsString <> 'SR') and (FselP430_Funzioni.FieldByName('TIPO_DIPENDENTE').AsString <> 'SI') and
       (FselP430_Funzioni.FieldByName('COD_CODICEINAIL').IsNull) then
      LstErrori.Add(A000MSG_P430_MSG_NO_COD_INAIL);
    if FselP430_Funzioni.FieldByName('BONUS_RIDUZ_CUNEO_FISC').AsString = 'Z' then
      LstErrori.Add(A000MSG_P430_MSG_BONUS_RIDUZ_FISC);
  end;
  if (FselP430_Funzioni.FieldByName('TIPO_DIPENDENTE').AsString = 'LA') and FselP430_Funzioni.FieldByName('COD_CAUSALELA').IsNull then
    LstErrori.Add(A000MSG_P430_MSG_NO_CAUS_LAV_AUTO);
  if (FselP430_Funzioni.FieldByName('TIPO_DIPENDENTE').AsString = 'CO') and not FselP430_Funzioni.FieldByName('COD_CAUSALELA').IsNull then
    LstErrori.Add(A000MSG_P430_MSG_SI_CAUS_LAV_AUTO);

  if (FselP430_Funzioni.FieldByName('TIPO_DIPENDENTE').AsString = 'LA') and (FselP430_Funzioni.FieldByName('CONGUAGLIO').AsString <> 'N') then
  begin
    LstErrori.Add(A000MSG_P430_MSG_LAV_AUTO_CONG_IRPEF);
  end;
  if (FselP430_Funzioni.FieldByName('TIPO_DIPENDENTE').AsString = 'IN') and FselP430_Funzioni.FieldByName('COD_CODICEINPS').IsNull then
    LstErrori.Add(A000MSG_P430_MSG_NO_COD_INPS);
  if (not FselP430_Funzioni.FieldByName('COD_CODICEINPS').IsNull) and FselP430_Funzioni.FieldByName('COD_NAZIONALITA').IsNull then
    LstErrori.Add(A000MSG_P430_MSG_NO_NAZ);
  if (FselP430_Funzioni.FieldByName('TIPO_DIPENDENTE').AsString <> 'IN') and (not FselP430_Funzioni.FieldByName('COD_CODICEINPS').IsNull) then
    LstErrori.Add(A000MSG_P430_MSG_COD_INPS_NO_VUOTO);
  if (not FselP430_Funzioni.FieldByName('COD_CODICEINPS').IsNull) and (FselP430_Funzioni.FieldByName('TIPO_MASSIMALE_CONTR').AsString <> 'I') then
    LstErrori.Add(A000MSG_P430_MSG_MASSIMALE_NO_NUOVO_ISCR);
  if Trim(FselP430_Funzioni.FieldByName('COD_TABELLAANF').AsString) <> '' then
    LstErrori.Add(A000MSG_P430_MSG_TABELLA_ANF);
  if FselP430_Funzioni.FieldByName('COD_BANCA').IsNull then
    LstErrori.Add(A000MSG_P430_MSG_NO_COD_BANCA);
  if (FselP430_Funzioni.FieldByName('COD_PAGAMENTO').AsString = '1') and (Trim(FselP430_Funzioni.FieldByName('IBAN_ESTERO').AsString) = '') and (Trim(FselP430_Funzioni.FieldByName('CIN_ITALIA').AsString) = '') then
    LstErrori.Add(A000MSG_P430_MSG_NO_CIN_ITALIA);
  if (FselP430_Funzioni.FieldByName('COD_PAGAMENTO').AsString = '1') and (Trim(FselP430_Funzioni.FieldByName('IBAN_ESTERO').AsString) = '') and (Trim(FselP430_Funzioni.FieldByName('CIN_EUROPA').AsString) = '') then
    LstErrori.Add(A000MSG_P430_MSG_NO_CIN_EUROPA);
  if (FselP430_Funzioni.FieldByName('COD_PAGAMENTO').AsString = '') then
    LstErrori.Add(A000MSG_P430_MSG_NO_MOD_PAG);

  if (Trim(FselP430_Funzioni.FieldByName('COD_FPC').AsString) <> '') and (VarToStr(selP026.Lookup('COD_FPC',FselP430_Funzioni.FieldByName('COD_FPC').AsString,'COD_INPDAP_FPC')) = '2142') and
     (selP500.FieldByName('PROVINCIA').AsString <> 'AO') then
    LstErrori.Add(A000MSG_P430_MSG_FONDO_AOSTA);
  if (Trim(FselP430_Funzioni.FieldByName('COD_FPC').AsString) <> '') and (VarToStr(selP026.Lookup('COD_FPC',FselP430_Funzioni.FieldByName('COD_FPC').AsString,'COD_INPDAP_FPC')) <> '2142') and
     (selP500.FieldByName('PROVINCIA').AsString = 'AO') then
    LstErrori.Add(A000MSG_P430_MSG_NO_FONDO_AOSTA);

  //Verifico se contratto=EDP e posizione economica inizia con DR, allora il codice inquadramento INPDAP deve essere CPDEL1PD o CPDEL1PDE
  if (FselP430_Funzioni.FieldByName('COD_CONTRATTO').AsString = 'EDP') and (Copy(FselP430_Funzioni.FieldByName('COD_POSIZIONE_ECONOMICA').AsString,1,2) = 'DR') and
     (FselP430_Funzioni.FieldByName('COD_INQUADRINPDAP').AsString <> 'CPDEL1PD') and (FselP430_Funzioni.FieldByName('COD_INQUADRINPDAP').AsString <> 'CPDEL1PDE') then
    LstErrori.Add(A000MSG_P430_MSG_INQUADR_INPDAP);

  //Se presente almeno un P430 con codice inquadramento INPDAP = CPDEL1TP/CPDEL1TPE eseguire i due seguenti controlli
  selSQL.SQL.Clear;
  selSQL.SQL.Text:='SELECT COUNT(*) FROM P430_ANAGRAFICO WHERE COD_INQUADRINPDAP IN (''CPDEL1TP'',''CPDEL1TPE'')';
  selSQL.Execute;
  if (selSQL.RowCount > 0) and (StrToIntDef(VarToStr(selSQL.Field(0)),0) > 0) then
  begin
    selP430TP.Close;
    selP430TP.SetVariable('PROGRESSIVO',FselP430_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
    if FselP430_Funzioni.State = dsInsert then
      selP430TP.SetVariable('RIGA','')
    else
      selP430TP.SetVariable('RIGA',' AND ROWID <> ''' + FselP430_Funzioni.RowId + '''');
    selP430TP.Open;
    //Verifico se contratto=EDP e posizione economica non inizia con DR/MV,
    if (FselP430_Funzioni.FieldByName('COD_CONTRATTO').AsString = 'EDP') and (Trim(FselP430_Funzioni.FieldByName('COD_POSIZIONE_ECONOMICA').AsString) <> '') and
       (Copy(FselP430_Funzioni.FieldByName('COD_POSIZIONE_ECONOMICA').AsString,1,2) <> 'DR') and (Copy(FselP430_Funzioni.FieldByName('COD_POSIZIONE_ECONOMICA').AsString,1,2) <> 'MV') then
    begin
      if FselP430_Funzioni.FieldByName('COD_PARTTIME').AsString <> '' then
      begin
        //Se presenza di almeno un periodo a tempo pieno dopo l'assunzione allora il codice inquadramento INPDAP deve essere CPDEL1TP/CPDEL1TPE
        if (selP430TP.RecordCount > 0) and
           (FselP430_Funzioni.FieldByName('COD_INQUADRINPDAP').AsString <> 'CPDEL1TP') and (FselP430_Funzioni.FieldByName('COD_INQUADRINPDAP').AsString <> 'CPDEL1TPE') then
          LstErrori.Add(A000MSG_P430_MSG_INQUADR_INPDAP_TP);
        //Se assenza di almeno un periodo a tempo pieno dopo l'assunzione allora il codice inquadramento INPDAP deve essere CPDEL1/CPDEL1E
        if (selP430TP.RecordCount <= 0) and
          (FselP430_Funzioni.FieldByName('COD_INQUADRINPDAP').AsString <> 'CPDEL1') and (FselP430_Funzioni.FieldByName('COD_INQUADRINPDAP').AsString <> 'CPDEL1E') then
          LstErrori.Add(A000MSG_P430_MSG_INQUADR_INPDAP_PARTTIME);
      end
      else
      begin
        if (FselP430_Funzioni.FieldByName('COD_INQUADRINPDAP').AsString <> 'CPDEL1TP') and (FselP430_Funzioni.FieldByName('COD_INQUADRINPDAP').AsString <> 'CPDEL1TPE') then
          LstErrori.Add(A000MSG_P430_MSG_INQUADR_INPDAP_TP);
      end;
    end;
  end;
  //Verifico se dipendente con presenza di voci convenzionati senza codice categoria ENPAM
  if (FselP430_Funzioni.FieldByName('PROGRESSIVO_EREDE_DI').IsNull) and (Trim(FselP430_Funzioni.FieldByName('COD_CATEG_CONVENZ').AsString) = '') and (P999ContrattoPresente(FselP430_Funzioni.FieldByName('COD_CONTRATTO').AsString,VFPremioOperositaIRPEFTFR.CodContratto)) then
    LstErrori.Add(A000MSG_P430_MSG_NO_CATEG_ENPAM);
  //Verifico decorrenza adesione F.P.C. con modalità silenzio-assenso
  if FselP430_Funzioni.FieldByName('TIPO_ADESIONE_FPC').AsString = 'S' then
  begin
    selSQL.SQL.Clear;
    selSQL.SQL.Text:='SELECT NVL(MIN(P430.DECORRENZA),TO_DATE(''31123999'',''DDMMYYYY'')) FROM P430_ANAGRAFICO P430 WHERE P430.PROGRESSIVO = ' + FselP430_Funzioni.FieldByName('PROGRESSIVO').AsString +
                        'AND TIPO_ADESIONE_FPC = ''S''';
    if selP430_Funzioni.State = dsEdit then
      selSQL.SQL.Text:=selSQL.SQL.Text + ' AND P430.DECORRENZA <> TO_DATE(''' + FormatDateTime('ddmmyyyy',FselP430_Funzioni.FieldByName('DECORRENZA').OldValue) + ''',''DDMMYYYY'')';
    selSQL.Execute;
    DataAdesioneFPC:=Min(VarToDateTime(selSQL.Field(0)),FselP430_Funzioni.FieldByName('DECORRENZA').AsDateTime);
    if R180Giorno(DataAdesioneFPC) <> 1 then
      LstErrori.Add(A000MSG_P430_MSG_DEC_SIL_ASS_FPC_GG_01)
    else if not FselP430_Funzioni.FieldByName('DATA_INF_SIL_ASS_FPC').IsNull then
      begin
        DataAdesioneTeoricaFPC:=R180AddMesi(FselP430_Funzioni.FieldByName('DATA_INF_SIL_ASS_FPC').AsDateTime, 6, True);
        DataAdesioneTeoricaFPC:=R180FineMese(DataAdesioneTeoricaFPC) + 1;
        if DataAdesioneFPC <> DataAdesioneTeoricaFPC then
          LstErrori.Add(A000MSG_P430_MSG_DEC_SIL_ASS_FPC_SEI_MM)
      end;
  end;
  //Verifico se presenti cedolini antecedenti la minima decorrenza di P430
  if not VerificaCedAntePrimoStoricoStip then
    LstErrori.Add(A000MSG_P430_ERR_CED_ANTE_PRIMO_STORICO);
end;

function TP430FAnagraficoMW.VerificaCedAntePrimoStoricoStip(): Boolean;
begin
  Result:=True;
  selSQL.SQL.Clear;
  selSQL.SQL.Text:='SELECT COUNT(*) FROM P441_CEDOLINO P441 WHERE P441.PROGRESSIVO = ' + FselP430_Funzioni.FieldByName('PROGRESSIVO').AsString +
                        ' AND NOT EXISTS (SELECT 1 FROM P430_ANAGRAFICO P430 WHERE P430.PROGRESSIVO = P441.PROGRESSIVO' +
                        ' AND P430.DECORRENZA <=P441.DATA_CEDOLINO)';
  selSQL.Execute;
  if (selSQL.RowCount > 0) and (StrToIntDef(VarToStr(selSQL.Field(0)),0) > 0) then
    Result:=False;
end;

procedure TP430FAnagraficoMW.RefreshLookupCache(ds:TDataSet);
var i:Integer;
begin
  for i:=0 to FselP430_Funzioni.FieldCount - 1 do
    if (FselP430_Funzioni.Fields[i].FieldKind = fkLookup) and (FselP430_Funzioni.Fields[i].LookupDataSet = ds) then
      FselP430_Funzioni.Fields[i].RefreshLookupList;
end;

procedure TP430FAnagraficoMW.DataModuleDestroy(Sender: TObject);
var
  i: Integer;
begin
  for i:=High(VSQLAppoggio) downto 0 do
    VSQLAppoggio[i].OQ.Free;
  SetLength(VSQLAppoggio,0);
  inherited;
end;

function TP430FAnagraficoMW.TryLockRecordT030(const PProgressivo: Integer): Boolean;
// tenta di acquisire il lock del record di T030 relativo al progressivo indicato
// restituisce:
// - true  se il lock viene acquisito
// - false se il record è già in lock
begin
  selT030Lock.SetVariable('PROGRESSIVO', PProgressivo);
  try
    selT030Lock.Execute;
    Result:=True;
  except
    on E: Exception do
    begin
      Result:=False;
      Exit;
    end;
  end;
end;

procedure TP430FAnagraficoMW.UnlockRecordT030Rollback;
// rimuove il lock effettuando una rollback
begin
  selT030Lock.Session.Rollback;
end;

end.
