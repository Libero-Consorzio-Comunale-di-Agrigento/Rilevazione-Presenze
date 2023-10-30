unit S030UProvvedimentiMW;

interface

uses
  System.SysUtils, System.Classes, OracleData, Oracle, Variants, Data.DB, StrUtils,
  R005UDataModuleMW, C006UStoriaDati, A000UInterfaccia, R600, USelI010, A000USessione,
  C180FunzioniGenerali, Vcl.ComCtrls, A000UMessaggi, Windows, ekrtf;

type
  T030Dlg = procedure(msg,Chiave:String) of object;

  TS030FProvvedimentiMW = class(TR005FDataModuleMW)
    insSG100: TOracleQuery;
    delSG100: TOracleQuery;
    selMaxNum: TOracleQuery;
    dsrI010: TDataSource;
    selV430: TOracleDataSet;
    selFam: TOracleDataSet;
    selSG100Atto: TOracleDataSet;
    selSG100Aut: TOracleDataSet;
    selSede: TOracleDataSet;
    dsrSede: TDataSource;
    selT265: TOracleDataSet;
    selT265CODICE: TStringField;
    selT265DESCRIZIONE: TStringField;
    dsrT265: TDataSource;
    selSG104: TOracleDataSet;
    selSG104CODICE: TStringField;
    selSG104DESCRIZIONE: TStringField;
    selSG104DESCRIZIONE_AGG: TStringField;
    selSG104STAMPA_FAMILIARI: TStringField;
    selSG104ELENCO_NUMERI_PREC: TStringField;
    selSG104ELENCO_NUMERI_SUCC: TStringField;
    dsrSG104: TDataSource;
    selSQL: TOracleQuery;
    selNum: TOracleQuery;
    insSQL: TOracleQuery;
    selSG095: TOracleDataSet;
    selSG095PROGRESSIVO: TFloatField;
    selSG095NOMECAMPO: TStringField;
    selSG095DATADECOR: TDateTimeField;
    selSG095DATAREGISTR: TDateTimeField;
    selSG095NUMERO: TStringField;
    selSG095DescNum: TStringField;
    selSG095VALORE_PREC: TStringField;
    selSG095VALORE_SUCC: TStringField;
    selP660: TOracleDataSet;
    selP660NUMERO: TStringField;
    selP660DESCRIZIONE: TStringField;
    selP660REGOLA_CALCOLO_MANUALE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT265FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
    NPA:Boolean;
    CampoOld,CampoNew:String;
    DecorrenzaOld,DecorrenzaNew,DataRegistrOld,DataRegistrNew:TDateTime;
    procedure CambiaCodiceDecorrenza;
    procedure CercaRegolaNPA;
    procedure PreparaVar;
    function ValorizzaVar(NomeVar:String):String;
  public
    { Public declarations }
    selSG100: TOracleDataSet;
    selI010:TselI010;
    R600DtM:TR600DtM1;
    lstTipoAtto,lstAutorita:TStringList;
    lstNumeriPrec,lstNumeriSucc,lstVariabili:TStringList;
    NomeModello,NomeFileGen:String;
    evtRichiesta:T030Dlg;
    procedure ApriDataSetSede;
    procedure CambiaProgressivo(CampoProvv:String);
    procedure FiltroProvvedimenti(iVisualizza:Integer);
    function RecuperaTestoDomandaCollettiva(Azione:String):String;
    procedure Inserimento;
    procedure Cancellazione;
    procedure CaricaListaTipoAtto;
    function NuovoNumeroAtto: String;
    procedure CaricaListaAutorita;
    procedure selSG100AfterScroll;
    function VisualizzaDettaglio: Boolean;
    procedure selSG100NewRecord(iVisualizza:Integer);
    procedure selSG100BeforePost(iTipo:Integer);
    procedure selSG100AfterPost;
    function selSG100DataRegistrGetText: String;
    procedure ApriDettaglioProvvedimento;
    function CercaMotivazione:Boolean;
    procedure Elaborazione_Cancella;
    procedure Elaborazione_InserisciPrec(sNumero:String);
    procedure Elaborazione_InserisciSucc(sNumero:String);
    procedure CreaStampaRTF;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TS030FProvvedimentiMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  lstTipoAtto:=TStringList.Create;
  lstAutorita:=TStringList.Create;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,'',Parametri.Applicazione,
      'REPLACE(NOME_CAMPO,''T430'','''') CODICE, NOME_LOGICO DESCRIZIONE, PROVVEDIMENTO',
      'TABLE_NAME = ''V430_STORICO'' AND SUBSTR(NOME_CAMPO,5,2) <> ''D_'' AND SUBSTR(NOME_CAMPO,1,4) = ''T430''' +
        ' AND REPLACE(NOME_CAMPO,''T430'','''') <> ''PROGRESSIVO'' AND PROVVEDIMENTO = ''S''',
      'NOME_CAMPO');
  dsrI010.DataSet:=selI010;
  R600DtM:=TR600Dtm1.Create(Self);
  selT265.Open;
  selSG104.Open;
  lstNumeriPrec:=TStringList.Create;
  lstNumeriSucc:=TStringList.Create;
  lstVariabili:=TStringList.Create;
end;

procedure TS030FProvvedimentiMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(lstVariabili);
  FreeAndNil(lstNumeriPrec);
  FreeAndNil(lstNumeriSucc);
  FreeAndNil(R600DtM);
  FreeAndNil(selI010);
  FreeAndNil(lstAutorita);
  FreeAndNil(lstTipoAtto);
end;

procedure TS030FProvvedimentiMW.selT265FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=A000FiltroDizionario('CAUSALI ASSENZA',DataSet.FieldByName('CODICE').AsString);
end;

procedure TS030FProvvedimentiMW.ApriDataSetSede;
begin
  if Parametri.CampiRiferimento.C14_ProvvSede <> '' then
  begin
    selSede.SQL.Clear;
    if A000LookupTabella(Parametri.CampiRiferimento.C14_ProvvSede,selSede) then
    begin
      if selSede.VariableIndex('DECORRENZA') >= 0 then
        selSede.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
      selSede.Open;
    end;
  end;
end;

procedure TS030FProvvedimentiMW.CambiaProgressivo(CampoProvv:String);
begin
  selSG100.Close;
  selSG100.SetVariable('Progressivo',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  selSG100.Open;
  if CampoProvv <> '' then
    if not selSG100.SearchRecord('NOMECAMPO',CampoProvv,[srFromBeginning]) then
    begin
      selSG100.Append;
      selSG100.FieldByName('NomeCampo').AsString:=CampoProvv;
    end;
end;

procedure TS030FProvvedimentiMW.FiltroProvvedimenti(iVisualizza:Integer);
begin
  with selSG100 do
    if iVisualizza = 0 then
    begin
      Filter:='TIPO_PROVV = ''S''';
      Filtered:=True;
    end
    else if iVisualizza = 1 then
    begin
      Filter:='TIPO_PROVV = ''A''';
      Filtered:=True;
    end
    else
    begin
      Filter:='';
      Filtered:=False;
    end;
end;

function TS030FProvvedimentiMW.RecuperaTestoDomandaCollettiva(Azione:String):String;
begin
  Result:=IfThen(Azione = 'I',IfThen(SelAnagrafe.RecordCount = 1,
                                     A000MSG_S030_DLG_INS_DIP_UNO,
                                     Format(A000MSG_S030_DLG_FMT_INS_DIP,[IntToStr(SelAnagrafe.RecordCount)])),
          IfThen(Azione = 'C',IfThen(SelAnagrafe.RecordCount = 1,
                                     A000MSG_S030_DLG_DEL_DIP_UNO,
                                     Format(A000MSG_S030_DLG_FMT_DEL_DIP,[IntToStr(SelAnagrafe.RecordCount)])),
          ''));
end;

procedure TS030FProvvedimentiMW.Inserimento;
var i:Integer;
    DecorrenzaOK:Boolean;
    SalvaProg:Integer;
    C006FStoriaDatiS030: TC006FStoriaDati;
begin
  RegistraMsg.IniziaMessaggio(NomeOwner);
  SalvaProg:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  C006FStoriaDatiS030:=TC006FStoriaDati.Create(nil);
  try
    selAnagrafe.First;
    while not selAnagrafe.Eof do
    begin
      if selSG100.FieldByName('TIPO_PROVV').AsString = 'S' then
      begin
        //Verifico che il dipendente abbia una decorrenza per quel campo uguale a quella selezionata
        DecorrenzaOK:=False;
        C006FStoriaDatiS030.GetStoriaDato(selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,selSG100.FieldByName('NomeCampo').AsString);
        for i:=0 to C006FStoriaDatiS030.StoriaDipendente.Count - 1 do
          if RecStoria(C006FStoriaDatiS030.StoriaDipendente[i]).Decorrenza = selSG100.FieldByName('DATADECOR').AsDateTime then
          begin
            DecorrenzaOK:=True;
            Break;
          end;
        if not DecorrenzaOK then
        begin
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_S030_ERR_FMT_NO_DECORRENZA,[selAnagrafe.FieldByName('MATRICOLA').AsString,selAnagrafe.FieldByName('COGNOME').AsString,selAnagrafe.FieldByName('NOME').AsString]),'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          Exit;
        end;
      end;
      insSG100.SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      insSG100.SetVariable('TIPO_PROVV',selSG100.FieldByName('TIPO_PROVV').AsString);
      insSG100.SetVariable('NOMECAMPO',selSG100.FieldByName('NOMECAMPO').AsString);
      insSG100.SetVariable('DATADECOR',selSG100.FieldByName('DATADECOR').AsDateTime);
      insSG100.SetVariable('DATAFINE',selSG100.FieldByName('DATAFINE').AsDateTime);
      insSG100.SetVariable('DATAREGISTR',selSG100.FieldByName('DATAREGISTR').AsDateTime);
      insSG100.SetVariable('CAUSALE',selSG100.FieldByName('CAUSALE').AsString);
      insSG100.SetVariable('SEDE',selSG100.FieldByName('SEDE').AsString);
      insSG100.SetVariable('AUTORITA',Copy(selSG100.FieldByName('AUTORITA').AsString,1,40));
      insSG100.SetVariable('TIPOATTO',selSG100.FieldByName('TIPOATTO').AsString);
      insSG100.SetVariable('NUMATTO',selSG100.FieldByName('NUMATTO').AsString);
      if selSG100.FieldByName('DATAATTO').IsNull then
        insSG100.SetVariable('DATAATTO',null)
      else
        insSG100.SetVariable('DATAATTO',selSG100.FieldByName('DATAATTO').AsDateTime);
      if selSG100.FieldByName('DATAESEC').IsNull then
        insSG100.SetVariable('DATAESEC',null)
      else
        insSG100.SetVariable('DATAESEC',selSG100.FieldByName('DATAESEC').AsDateTime);
      insSG100.SetVariable('NOTE',selSG100.FieldByName('NOTE').AsString);
      insSG100.SetVariable('TESTOVAR',selSG100.FieldByName('TESTOVAR').AsString);
      try
        insSG100.Execute;
      except
        on E: Exception do
          begin
            RegistraMsg.InserisciMessaggio('A',Format(A000MSG_S030_ERR_FMT_INSERIMENTO_KO,[selAnagrafe.FieldByName('MATRICOLA').AsString,selAnagrafe.FieldByName('COGNOME').AsString,selAnagrafe.FieldByName('NOME').AsString]),'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
            RegistraMsg.InserisciMessaggio('A','  --> ' + E.Message,'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          end;
      end;
      selAnagrafe.Next;
    end;
    selSG100.Cancel;
    SessioneOracle.Commit;
    selSG100.Refresh;
  finally
    FreeAndNil(C006FStoriaDatiS030);
    SelAnagrafe.SearchRecord('PROGRESSIVO',SalvaProg,[srFromBeginning]);
  end;
end;

procedure TS030FProvvedimentiMW.Cancellazione;
var SalvaProg:Integer;
begin
  RegistraMsg.IniziaMessaggio(NomeOwner);
  SalvaProg:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  SelAnagrafe.First;
  while not SelAnagrafe.Eof do
  begin
    delSG100.SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    delSG100.SetVariable('TIPO_PROVV',selSG100.FieldByName('TIPO_PROVV').AsString);
    delSG100.SetVariable('NOMECAMPO',selSG100.FieldByName('NOMECAMPO').AsString);
    delSG100.SetVariable('DATADECOR',selSG100.FieldByName('DATADECOR').AsDateTime);
    delSG100.SetVariable('DATAFINE',selSG100.FieldByName('DATAFINE').AsDateTime);
    delSG100.SetVariable('DATAREGISTR',selSG100.FieldByName('DATAREGISTR').AsDateTime);
    delSG100.SetVariable('CAUSALE',selSG100.FieldByName('CAUSALE').AsString);
    delSG100.SetVariable('SEDE',selSG100.FieldByName('SEDE').AsString);
    delSG100.SetVariable('AUTORITA',selSG100.FieldByName('AUTORITA').AsString);
    delSG100.SetVariable('TIPOATTO',selSG100.FieldByName('TIPOATTO').AsString);
    delSG100.SetVariable('NUMATTO',selSG100.FieldByName('NUMATTO').AsString);
    if selSG100.FieldByName('DATAATTO').IsNull then
      delSG100.SetVariable('DATAATTO',null)
    else
      delSG100.SetVariable('DATAATTO',selSG100.FieldByName('DATAATTO').AsDateTime);
    if selSG100.FieldByName('DATAESEC').IsNull then
      delSG100.SetVariable('DATAESEC',null)
    else
      delSG100.SetVariable('DATAESEC',selSG100.FieldByName('DATAESEC').AsDateTime);
    delSG100.SetVariable('NOTE',selSG100.FieldByName('NOTE').AsString);
    delSG100.SetVariable('TESTOVAR',selSG100.FieldByName('TESTOVAR').AsString);
    try
      delSG100.Execute;
    except
      on E: Exception do
      begin
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_S030_ERR_FMT_CANCELLAZIONE_KO,[SelAnagrafe.FieldByName('MATRICOLA').AsString,SelAnagrafe.FieldByName('COGNOME').AsString,SelAnagrafe.FieldByName('NOME').AsString]),'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        RegistraMsg.InserisciMessaggio('A','  --> ' + E.Message,'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      end;
    end;
    if delSG100.RowsProcessed = 0 then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_S030_ERR_FMT_NO_PROVVEDIMENTO,[SelAnagrafe.FieldByName('MATRICOLA').AsString,SelAnagrafe.FieldByName('COGNOME').AsString,SelAnagrafe.FieldByName('NOME').AsString]),'',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    SelAnagrafe.Next;
  end;
  SessioneOracle.Commit;
  selSG100.Refresh;
  SelAnagrafe.SearchRecord('PROGRESSIVO',SalvaProg,[srFromBeginning]);
end;

procedure TS030FProvvedimentiMW.CaricaListaTipoAtto;
begin
  lstTipoAtto.Clear;
  selSG100Atto.Close;
  selSG100Atto.Open;
  while not selSG100Atto.Eof do
  begin
    lstTipoAtto.Add(selSG100Atto.FieldByName('TIPOATTO').AsString);
    selSG100Atto.Next;
  end;
end;

function TS030FProvvedimentiMW.NuovoNumeroAtto: String;
begin
  Result:='';
  //Propongo il nuovo numero atto
  selMaxNum.Execute;
  Result:=VarToStr(selMaxNum.GetVariable('MAXNUM'));
end;

procedure TS030FProvvedimentiMW.CaricaListaAutorita;
begin
  inherited;
  lstAutorita.Clear;
  selSG100Aut.Close;
  selSG100Aut.Open;
  while not selSG100Aut.Eof do
  begin
    if selSG100Aut.FieldByName('AUTORITA').AsString <> '' then
      lstAutorita.Add(selSG100Aut.FieldByName('AUTORITA').AsString);
    selSG100Aut.Next;
  end;
end;

procedure TS030FProvvedimentiMW.selSG100AfterScroll;
begin
  CercaRegolaNPA;
end;

procedure TS030FProvvedimentiMW.CercaRegolaNPA;
begin
  selP660.Close;
  selP660.SetVariable('DEC',selSG100.FieldByName('DATADECOR').AsDateTime);
  selP660.Open;
  NPA:=selP660.RecordCount > 0;
end;

function TS030FProvvedimentiMW.VisualizzaDettaglio: Boolean;
begin
  Result:=(selSG100.FieldByName('TIPO_PROVV').AsString = 'S') and (selP660.RecordCount > 0);
end;

procedure TS030FProvvedimentiMW.selSG100NewRecord(iVisualizza:Integer);
begin
  selSG100.FieldByName('Progressivo').AsInteger:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  selSG100.FieldByName('DataRegistr').AsDateTime:=Now;
  selSG100.FieldByName('Tipo_Provv').AsString:=IfThen(iVisualizza = 1,'A','S');
end;

procedure TS030FProvvedimentiMW.selSG100BeforePost(iTipo:Integer);
begin
  inherited;
  if Trim(selSG100.FieldByName('NOMECAMPO').AsString) = '' then
    raise Exception.Create(IfThen(iTipo = 0,A000MSG_S030_ERR_NO_DATO,A000MSG_S030_ERR_NO_CAUSALE));
  if selSG100.FieldByName('DATAREGISTR').IsNull then
    raise Exception.Create(A000MSG_S030_ERR_NO_DATA_REGISTRAZIONE);
  if selSG100.FieldByName('DATADECOR').IsNull then
    raise Exception.Create(A000MSG_S030_ERR_NO_DATA_DECORRENZA);
  if selSG100.FieldByName('DATAFINE').IsNull then
    raise Exception.Create(A000MSG_S030_ERR_NO_DATA_FINE);
  selSG100.FieldByName('TIPOATTO').AsString:=UpperCase(Copy(selSG100.FieldByName('TIPOATTO').AsString,1,1)) + LowerCase(Copy(selSG100.FieldByName('TIPOATTO').AsString,2,Length(selSG100.FieldByName('TIPOATTO').AsString)-1));
  CercaRegolaNPA;
  if NPA then
  begin
    selNum.SetVariable('TIPO',selSG100.FieldByName('TIPOATTO').AsString);
    selNum.SetVariable('NUMERO',selSG100.FieldByName('NUMATTO').AsString);
    selNum.Execute;
    if ((selSG100.State = dsInsert) and (selNum.Field(0) > 0)) or
       ((selSG100.State = dsEdit) and (selNum.Field(0) > 1)) then
      if Assigned(evtRichiesta) then
        evtRichiesta(A000MSG_S030_DLG_NUM_ATTO_ESISTENTE,'BeforePostNumAtto');
    //Gestione del cambio codice/decorrenza per salvaguardare la foreign key (SG095 alimentato solo da NPA)
    CampoOld:='';
    CampoNew:='';
    DecorrenzaOld:=DATE_NULL;
    DecorrenzaNew:=DATE_NULL;
    DataRegistrOld:=DATE_NULL;
    DataRegistrNew:=DATE_NULL;
    if (selSG100.State = dsEdit) and
       ((selSG100.FieldByName('NOMECAMPO').Value <> selSG100.FieldByName('NOMECAMPO').medpOldValue) or
        (selSG100.FieldByName('DATADECOR').Value <> selSG100.FieldByName('DATADECOR').medpOldValue) or
        (selSG100.FieldByName('DATAREGISTR').Value <> selSG100.FieldByName('DATAREGISTR').medpOldValue)) then
    begin
      CampoOld:=selSG100.FieldByName('NOMECAMPO').medpOldValue;
      CampoNew:=selSG100.FieldByName('NOMECAMPO').Value;
      DecorrenzaOld:=selSG100.FieldByName('DATADECOR').medpOldValue;
      DecorrenzaNew:=selSG100.FieldByName('DATADECOR').Value;
      DataRegistrOld:=selSG100.FieldByName('DATAREGISTR').medpOldValue;
      DataRegistrNew:=selSG100.FieldByName('DATAREGISTR').Value;
      selSG100.FieldByName('NOMECAMPO').Value:=selSG100.FieldByName('NOMECAMPO').medpOldValue;
      selSG100.FieldByName('DATADECOR').Value:=selSG100.FieldByName('DATADECOR').medpOldValue;
      selSG100.FieldByName('DATAREGISTR').Value:=selSG100.FieldByName('DATAREGISTR').medpOldValue;
    end;
  end;
end;

procedure TS030FProvvedimentiMW.selSG100AfterPost;
begin
  if NPA then
    //Gestione del cambio codice/decorrenza per salvaguardare la foreign key (SG095 alimentato solo da NPA)
    if (CampoOld <> CampoNew) or (DecorrenzaOld <> DecorrenzaNew) or (DataRegistrOld <> DataRegistrNew) then
      CambiaCodiceDecorrenza;
end;

function TS030FProvvedimentiMW.selSG100DataRegistrGetText: String;
begin
  Result:='';
  if not selSG100.FieldByName('DATAREGISTR').IsNull then
    Result:=FormatDateTime('dd/mm/yyyy hh:nn',selSG100.FieldByName('DATAREGISTR').AsDateTime);
end;

procedure TS030FProvvedimentiMW.CambiaCodiceDecorrenza;
begin
  //Inserimento della nuova chiave nella testata
  insSQL.SQL.Clear;
  insSQL.SQL.Add('INSERT INTO SG100_PROVVEDIMENTO');
  insSQL.SQL.Add('SELECT PROGRESSIVO, ''' + CampoNew + ''', TO_DATE(''' + DateToStr(DecorrenzaNew) + ''',''DD/MM/YYYY''), TO_DATE(''' + DateTimeToStr(DataRegistrNew) + ''',''DD/MM/YYYY HH24.MI.SS''), ');
  insSQL.SQL.Add('       CAUSALE, AUTORITA, TIPOATTO, NUMATTO, DATAATTO, DATAESEC, NOTE, TIPO_PROVV, DATAFINE, SEDE, TESTOVAR');
  insSQL.SQL.Add('   FROM SG100_PROVVEDIMENTO ');
  insSQL.SQL.Add(' WHERE PROGRESSIVO = ' + selSG100.FieldByName('PROGRESSIVO').AsString);
  insSQL.SQL.Add('   AND NOMECAMPO = ''' + CampoOld + '''');
  insSQL.SQL.Add('   AND DATADECOR = TO_DATE(''' + DateToStr(DecorrenzaOld) + ''',''DD/MM/YYYY'')');
  insSQL.SQL.Add('   AND DATAREGISTR = TO_DATE(''' + DateTimeToStr(DataRegistrOld) + ''',''DD/MM/YYYY HH24.MI.SS'')');
  insSQL.Execute;
  SessioneOracle.Commit;
  //Modifica della chiave sul dettaglio
  insSQL.SQL.Clear;
  insSQL.SQL.Add('UPDATE SG095_PROVVEDIMENTODETT');
  insSQL.SQL.Add('   SET NOMECAMPO = ''' + CampoNew + ''',');
  insSQL.SQL.Add('       DATADECOR = TO_DATE(''' + DateToStr(DecorrenzaNew) + ''',''DD/MM/YYYY''),');
  insSQL.SQL.Add('       DATAREGISTR = TO_DATE(''' + DateTimeToStr(DataRegistrNew) + ''',''DD/MM/YYYY HH24.MI.SS'')');
  insSQL.SQL.Add(' WHERE PROGRESSIVO = ' + selSG100.FieldByName('PROGRESSIVO').AsString);
  insSQL.SQL.Add('   AND NOMECAMPO = ''' + CampoOld + '''');
  insSQL.SQL.Add('   AND DATADECOR = TO_DATE(''' + DateToStr(DecorrenzaOld) + ''',''DD/MM/YYYY'')');
  insSQL.SQL.Add('   AND DATAREGISTR = TO_DATE(''' + DateTimeToStr(DataRegistrOld) + ''',''DD/MM/YYYY HH24.MI.SS'')');
  insSQL.Execute;
  SessioneOracle.Commit;
  //Eliminazione della vecchia chiave su testata
  insSQL.SQL.Clear;
  insSQL.SQL.Add('DELETE FROM SG100_PROVVEDIMENTO ');
  insSQL.SQL.Add(' WHERE PROGRESSIVO = ' + selSG100.FieldByName('PROGRESSIVO').AsString);
  insSQL.SQL.Add('   AND NOMECAMPO = ''' + CampoOld + '''');
  insSQL.SQL.Add('   AND DATADECOR = TO_DATE(''' + DateToStr(DecorrenzaOld) + ''',''DD/MM/YYYY'')');
  insSQL.SQL.Add('   AND DATAREGISTR = TO_DATE(''' + DateTimeToStr(DataRegistrOld) + ''',''DD/MM/YYYY HH24.MI.SS'')');
  insSQL.Execute;
  SessioneOracle.Commit;
  selSG100.Refresh;
end;

procedure TS030FProvvedimentiMW.ApriDettaglioProvvedimento;
begin
  selSG095.Close;
  selSG095.SetVariable('PROG',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  selSG095.SetVariable('CAMPO',selSG100.FieldByName('NOMECAMPO').AsString);
  selSG095.SetVariable('DATADEC',selSG100.FieldByName('DATADECOR').AsDateTime);
  selSG095.SetVariable('DATAREG',selSG100.FieldByName('DATAREGISTR').AsDateTime);
  selSG095.Open;
end;

function TS030FProvvedimentiMW.CercaMotivazione:Boolean;
begin
  Result:=False;
  lstNumeriPrec.Clear;
  lstNumeriSucc.Clear;
  if selSG104.SearchRecord('CODICE',selSG100.FieldByName('CAUSALE').AsString,[srFromBeginning]) then
  begin
    lstNumeriPrec.CommaText:=selSG104.FieldByName('ELENCO_NUMERI_PREC').AsString;
    lstNumeriSucc.CommaText:=selSG104.FieldByName('ELENCO_NUMERI_SUCC').AsString;
    Result:=True;
  end;
end;

procedure TS030FProvvedimentiMW.Elaborazione_Cancella;
begin
  selSG095.First;
  while not selSG095.Eof do
    selSG095.Delete;
  SessioneOracle.Commit;
end;

procedure TS030FProvvedimentiMW.Elaborazione_InserisciPrec(sNumero:String);
begin
  selSQL.SQL.Clear;
  if selP660.SearchRecord('NUMERO',sNumero,[srFromBeginning]) then
    selSQL.SQL.Add(selP660.FieldByName('REGOLA_CALCOLO_MANUALE').AsString)
  else
    raise Exception.Create(Format(A000MSG_S030_ERR_FMT_NUM_PREC,[sNumero]));
  if Trim(selSQL.SQL.Text) <> '' then
  begin
    selSQL.SetVariable('Progressivo',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selSQL.SetVariable('DataDecorrenza',selSG100.FieldByName('DATADECOR').AsDateTime - 1);
    try
      selSQL.Execute;
    except
      raise Exception.Create(Format(A000MSG_S030_ERR_FMT_QUERY_KO,[sNumero]));
    end;
  end;
  selSG095.Insert;
  selSG095.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  selSG095.FieldByName('NOMECAMPO').AsString:=selSG100.FieldByName('NOMECAMPO').AsString;
  selSG095.FieldByName('DATADECOR').AsDateTime:=selSG100.FieldByName('DATADECOR').AsDateTime;
  selSG095.FieldByName('DATAREGISTR').AsDateTime:=selSG100.FieldByName('DATAREGISTR').AsDateTime;
  selSG095.FieldByName('NUMERO').AsString:=sNumero;
  if (Trim(selSQL.SQL.Text) <> '') and (selSQL.RowsProcessed > 0) then
    selSG095.FieldByName('VALORE_PREC').AsString:=VarToStr(selSQL.Field(0));
  selSG095.Post;
end;

procedure TS030FProvvedimentiMW.Elaborazione_InserisciSucc(sNumero:String);
begin
  selSQL.SQL.Clear;
  if selP660.SearchRecord('NUMERO',sNumero,[srFromBeginning]) then
    selSQL.SQL.Add(selP660.FieldByName('REGOLA_CALCOLO_MANUALE').AsString)
  else
    raise Exception.Create(Format(A000MSG_S030_ERR_FMT_NUM_SUCC,[sNumero]));
  if Trim(selSQL.SQL.Text) <> '' then
  begin
    selSQL.SetVariable('Progressivo',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    selSQL.SetVariable('DataDecorrenza',selSG100.FieldByName('DATADECOR').AsDateTime);
    try
      selSQL.Execute;
    except
      raise Exception.Create(Format(A000MSG_S030_ERR_FMT_QUERY_KO,[sNumero]));
    end;
  end;
  //Se il record esiste già lo carico solo se il valore è diverso dal precedente
  if selSG095.SearchRecord('NUMERO',sNumero,[srFromBeginning]) then
  begin
    if (Trim(selSQL.SQL.Text) <> '') and (selSQL.RowsProcessed > 0) and
       (selSG095.FieldByName('VALORE_PREC').AsString <> VarToStr(selSQL.Field(0))) then
    begin
      selSG095.Edit;
      selSG095.FieldByName('VALORE_SUCC').AsString:=VarToStr(selSQL.Field(0));
      selSG095.Post;
    end;
  end
  else
  begin
    selSG095.Insert;
    selSG095.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
    selSG095.FieldByName('NOMECAMPO').AsString:=selSG100.FieldByName('NOMECAMPO').AsString;
    selSG095.FieldByName('DATADECOR').AsDateTime:=selSG100.FieldByName('DATADECOR').AsDateTime;
    selSG095.FieldByName('DATAREGISTR').AsDateTime:=selSG100.FieldByName('DATAREGISTR').AsDateTime;
    selSG095.FieldByName('NUMERO').AsString:=sNumero;
    if (Trim(selSQL.SQL.Text) <> '') and (selSQL.RowsProcessed > 0) then
      selSG095.FieldByName('VALORE_SUCC').AsString:=VarToStr(selSQL.Field(0));
    selSG095.Post;
  end;
end;

procedure TS030FProvvedimentiMW.CreaStampaRTF;
var ModuloRtf: TEKRtf;
  j:Integer;
  (*TempPath,*)NomeFile:String;
  ElencoDataset: array of TDataSet;
begin
  inherited;
  if Length(NomeModello) <= 0 then
    raise exception.Create(A000MSG_S030_ERR_NO_RTF);
  PreparaVar;
  try
    ModuloRtf:=TEkRtf.Create(nil);
    ModuloRtf.InFile:=NomeModello;
    ModuloRtf.ClearVars;
    for j:=0 to lstVariabili.Count - 1 do
      if R180IndexOf(ModuloRtf.VarList,lstVariabili[j],Length(lstVariabili[j])) = -1 then
        ModuloRtf.CreateVar(lstVariabili[j],ValorizzaVar(lstVariabili[j]));
    NomeFile:=selSG100.FieldByName('NUMATTO').AsString + '_' + selAnagrafe.FieldByName('COGNOME').AsString + '_' + selSG100.FieldByName('CAUSALE').AsString + '_' + FormatDateTime('ddmmyyyy',selSG100.FieldByName('DATADECOR').AsDateTime) + '.doc';
    (*TempPath:=ExtractFilePath(Application.ExeName) + 'Archivi\Temp\';*)
    NomeFileGen:=R180GetFilePath(NomeModello) + '\' + NomeFile;
    ModuloRtf.OutFile:=NomeFileGen;
    SetLength(ElencoDataset,0);
    {$IFNDEF IRISWEB}
    ModuloRtf.ExecuteOpen(ElencoDataset,SW_SHOW);
    {$ELSE}
    ModuloRtf.Execute(ElencoDataset);
    {$ENDIF}
    (*Da vedere per generazione automatica pdf (TORINO_ITC)
    ModuloRtf.Execute(ElencoDataset);
    CopyFile(pchar(ModuloRtf.OutFile),pchar(TempPath + NomeFile),False);
    //NomeFile:=StringReplace(NomeFile,'.doc','.pdf',[]);
    //ShellExecute(0,'open',pchar('OfficeToPDF.exe'),pchar(ModuloRtf.OutFile + ' ' + NomeFile),pchar(ExtractFilePath(Application.ExeName)),SW_SHOWNORMAL);
    ShellExecute(0,'open',pchar('"C:\Program Files (x86)\LibreOffice 5\program\soffice.exe"'),pchar('--convert-to pdf ' + NomeFile),pchar(TempPath),SW_SHOWNORMAL);
    //"C:\Program Files (x86)\LibreOffice 5\program\soffice" --convert-to pdf E:\TEMP\FileProva.doc --outdir e:\temp\pdf
    ShellExecute(0,'open',pchar(StringReplace(NomeFile,'.doc','.pdf',[])),nil,pchar(TempPath),SW_SHOWNORMAL);
    *)
  finally
    FreeAndNil(ModuloRtf);
  end;
end;

procedure TS030FProvvedimentiMW.PreparaVar;
var i,Posiz_1:Integer;
  Appoggio,NomeVar:String;
  Memo1:TRichEdit;
begin
  try
    //La RichEdit interpreta bene il testo di un .rtf, a differenza della StringList,
    //ma si deve usare il metodo CreateParented, altrimenti in Cloud non funziona perché manca il Parent
    Memo1:=TRichEdit.CreateParented(HWND_MESSAGE);
    Memo1.WordWrap:=False;
    //Caricamento della lista lstVariabili con l'elenco di tutte le variabili del modello
    lstVariabili.Clear;
    Memo1.Lines.Clear;
    try
      Memo1.Lines.LoadFromFile(NomeModello);
    except
      on E:Exception do
        raise Exception.Create(Format(A000MSG_ERR_FMT_APRI_FILE + ' ' + E.Message,[NomeModello]));
    end;
    Appoggio:='';
    NomeVar:='';
    //Ciclo su tutte le righe dell'attestato
    for i:=0 to Memo1.Lines.Count - 1 do
    begin
      Appoggio:=Memo1.Lines.Strings[i];
      Posiz_1:=Pos('\',Appoggio);
      //Ciclo le righe che contengono il carattere '\'
      while Posiz_1 > 0 do
      begin
        NomeVar:=Copy(Appoggio,Posiz_1 + 1,Length(Appoggio) - Posiz_1);
        NomeVar:=Copy(NomeVar,1,Pos('\',NomeVar)-1);
        if (Trim(NomeVar) <> '') and (lstVariabili.IndexOf(NomeVar) < 0) and
           (Pos('scan',NomeVar) <= 0) and (Pos('selSG101',NomeVar) <= 0) then
          lstVariabili.Add(NomeVar);
        Appoggio:=Copy(Appoggio,Posiz_1 + Length(NomeVar) + 2, Length(Appoggio) - Posiz_1 - Length(NomeVar));
        Posiz_1:=Pos('\',Appoggio);
      end;
    end;

    //Apro i dataset di riferimento in base alle variabili presenti nel modello
    Appoggio:='';
    for i:=0 to lstVariabili.Count - 1 do
      if (Copy(lstVariabili.Strings[i],1,4) = 'T030')
      or (Copy(lstVariabili.Strings[i],1,4) = 'T430')
      or (Copy(lstVariabili.Strings[i],1,4) = 'P430') then
      begin
        if Trim(Appoggio) <> '' then
          Appoggio:=Appoggio + ',';
        Appoggio:=Appoggio + StringReplace(lstVariabili.Strings[i],'T030','',[rfReplaceAll]);
      end;
    if Trim(Appoggio) <> '' then
    begin
      selV430.Close;
      selV430.SetVariable('DATI',Appoggio);
      selV430.SetVariable('PROG',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      selV430.SetVariable('DEC',selSG100.FieldByName('DATADECOR').AsDateTime);
      selV430.Open;
    end;
  finally
    FreeAndNil(Memo1);
  end;
end;

function TS030FProvvedimentiMW.ValorizzaVar(NomeVar:String):String;
var s,Dato:String;
  n:Integer;
begin
  Result:='';
  Dato:='';
  if (Copy(NomeVar,1,4) = 'T030')
  or (Copy(NomeVar,1,4) = 'T430')
  or (Copy(NomeVar,1,4) = 'P430') then
  begin
    Dato:=StringReplace(NomeVar,'T030','',[rfReplaceAll]);
    Result:=selV430.FieldByName(Dato).AsString;
  end;
  if (Copy(NomeVar,1,4) = 'NPA_') then
  begin
    Dato:=StringReplace(NomeVar,'NPA_','',[rfReplaceAll]);
    n:=-1;
    try
      n:=StrToInt(Copy(Dato,1,3));
    except
    end;
    if Dato = 'DESC_MOTIVAZIONE' then
      Result:=VarToStr(selSG104.Lookup('CODICE',selSG100.FieldByName('CAUSALE').AsString,'DESCRIZIONE'))
    else if Dato = 'DESCAGG_MOTIVAZIONE' then
      Result:=VarToStr(selSG104.Lookup('CODICE',selSG100.FieldByName('CAUSALE').AsString,'DESCRIZIONE_AGG'))
    else if Dato = 'FAMILIARI' then
    begin
      if (VarToStr(selSG104.Lookup('CODICE',selSG100.FieldByName('CAUSALE').AsString,'STAMPA_FAMILIARI')) = 'S') then
      begin
        //Considerare i familiari a decorrere dal primo giorno del mese successivo alla data di adozione, se significativa, altrimenti dalla data di nascita.
        //Se la data di adozione/nascita è il giorno 1, inserirlo nel mese stesso.
        selFam.Close;
        selFam.SetVariable('Prog',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
        selFam.SetVariable('Dec',selSG100.FieldByName('DATADECOR').AsDateTime);
        selFam.Open;
        s:='';
        while not selFam.Eof do
        begin
          s:=s + selFam.FieldByName('COGNOME').AsString + ' ' +
             selFam.FieldByName('NOME').AsString + '; DOB: ' +
             selFam.FieldByName('DATANAS').AsString + '; ' +
             selFam.FieldByName('GRADOPAR').AsString + #$D#$A;
          selFam.Next;
        end;
        Result:=s;
      end;
    end
    else if n <> -1 then
    begin
      if Copy(Dato,5,4) = 'PREC' then
        Result:=VarToStr(selSG095.Lookup('NUMERO',Copy(Dato,1,3),'VALORE_PREC'))
      else if Copy(Dato,5,4) = 'SUCC' then
        Result:=VarToStr(selSG095.Lookup('NUMERO',Copy(Dato,1,3),'VALORE_SUCC'))
    end
    else if Dato = 'DATAREGISTR' then  //tronco l'ora
      Result:=FormatDateTime('dd/mm/yyyy',selSG100.FieldByName('DATAREGISTR').AsDateTime)
    else
      Result:=selSG100.FieldByName(Dato).AsString;
  end;
end;

end.
