unit A062UQueryServizioMW;

interface

uses
  Windows, Messages, SysUtils,StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, DB, DBClient, OracleData, Oracle, Generics.Collections, System.Math,
  A000UCostanti, A000UMessaggi, A000USessione, A000UInterfaccia, C180FunzioniGenerali, USelI010
  {$IFDEF ISO},LDBInterno{$ENDIF}
  ;

type
  TC700MergeSelAnagrafe = procedure(ODS:TComponent; RicreaVariabili:Boolean = False) of object;
  TW041MergeSelAnagrafe = procedure(ODS:TOracleDataSet) of object;
  TGC700MergeSelAnagrafe = procedure(ODS:TComponent; RicreaVariabili:Boolean = False);


  TA062FQueryServizioMW = class(TR005FDataModuleMW)
    cdsValori: TClientDataSet;
    cdsValoriVARIABILE: TStringField;
    cdsValoriTIPO: TStringField;
    cdsValoriVALORE: TStringField;
    selT002Riga: TOracleDataSet;
    S1: TOracleScript;
    selI090: TOracleDataSet;
    CreateTab: TOracleDataSet;
    delT002: TOracleQuery;
    insT002: TOracleQuery;
    Q1: TOracleDataSet;
    DS1: TDataSource;
    dsrValori: TDataSource;
    selT002TrovaQuery: TOracleQuery;
    selT005: TOracleDataSet;
    delT006: TOracleQuery;
    selQ104: TOracleDataSet;
    selQ104CLIENTE: TStringField;
    selQ104SEDE: TStringField;
    selQ104NOMINATIVO: TStringField;
    selQ104CODQUAL: TStringField;
    selQ104UFFICIO: TStringField;
    selQ104NUMTEL: TStringField;
    selQ104NUMFAX: TStringField;
    selQ104EMAIL: TStringField;
    selQ104FLAGATTIVO: TStringField;
    selQ104PROGRESSIVO: TFloatField;
    selQ104FLAGJOLLY: TStringField;
    selQ104FLAGDEFAULT: TStringField;
    selQ104FLAGEMAILAGG: TStringField;
    selQ104Esterni: TOracleDataSet;
    selQ104EsterniCLIENTE: TStringField;
    selQ104EsterniSEDE: TStringField;
    selQ104EsterniNOMINATIVO: TStringField;
    selQ104EsterniCODQUAL: TStringField;
    selQ104EsterniUFFICIO: TStringField;
    selQ104EsterniNUMTEL: TStringField;
    selQ104EsterniNUMFAX: TStringField;
    selQ104EsterniEMAIL: TStringField;
    selQ104EsterniFLAGATTIVO: TStringField;
    selQ104EsterniPROGRESSIVO: TFloatField;
    selQ104EsterniFLAGJOLLY: TStringField;
    selQ104EsterniFLAGDEFAULT: TStringField;
    selQ104EsterniFLAGEMAILAGG: TStringField;
    selT002RigaProtetta: TOracleDataSet;
    selQ003: TOracleDataSet;
    procedure cdsValoriBeforeDelete(DataSet: TDataSet);
    procedure cdsValoriBeforeInsert(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure delT002BeforeQuery(Sender: TOracleQuery);
    procedure insT002AfterQuery(Sender: TOracleQuery);
    procedure DataModuleDestroy(Sender: TObject);
  private
    Elenco:TStringList;
    FSqlVariabili: string;
    FSqlTipi: string;
    procedure SetSessioneOracle(POracleSession: TOracleSession);
    procedure SalvaVarImp;
  public
    SalvataggioIncorso:Boolean;//Variabile di stato per aggiornamento delle variabili della c700
    SoloValoriVariabiliOperatore:Boolean;//Variabile attiva se richiamo da IrisWeb: valore variabili solo da operatore (T001), non valori di default
    SqlSelezioneList:TStringList;
    SqlNome,SqlNomeTabella,ChkIntestazioneName,ChkNoRitornoACapoName,UserName,
    CreateTableNewName,CodRaggr:String;
    SelT002:TOracleDataSet;
    SenderIsBtnCreaTab,ChkIntestazioneChecked,ChkNoRitornoACapoChecked,
    ChkMWProtetta, BtnCartellinoEnabled,BtnCartellinoVisible,ActSalvaEnabled,
    ChiediPswAccessoDB, CreateTabEsitoPositivo:boolean;
    Contatore:integer;
    EsisteC700:Boolean;
    C700MergeSelAnagrafe:TC700MergeSelAnagrafe;
    GC700MergeSelAnagrafe:TGC700MergeSelAnagrafe;
    W041MergeSelAnagrafe:TW041MergeSelAnagrafe;
    SelAnagrafe:TOracleDataSet;
    selI010:TselI010;
    procedure OpenSelT002(var MyDataSet:TOracleDataSet; Filtro:string = ''; FiltroProt:string = '');
    procedure CaricaCmbRaggruppamenti(lstRaggr:TStrings);
    procedure TrovaVariabili;
    procedure CaricaVariabili;
    procedure RefreshVariabili;
    procedure GestioneVariabili(Script: Boolean);
    procedure ElaboraVariabili(Script: Boolean);
    procedure ImpostaVariabile(pNome, pTipo:String;pValore:Variant);
    function SalvaVariabili: Boolean;
    procedure PreparaScript;
    function  EsisteTabella:Boolean;
    function SalvaSql:Boolean;
    procedure CaricaQuery;
    procedure EseguiQuery;
    procedure ValidaQuery;
    procedure DelQueryRaggr(Codice:String);
    procedure DropTableT921;
    function  CreaTestoFile(NomeFile:String): TStream;
    function  StringToCsv(Stringa:String): String;
    procedure CreateTableT921(NewName: String);
    procedure SelT002FiltraRecord(DataSet: TDataSet; var Accept: Boolean);
  end;

implementation

{$R *.dfm}

procedure TA062FQueryServizioMW.SetSessioneOracle(POracleSession: TOracleSession);
// assegna la sessione oracle indicata agli oggetti di tipo
// - TOracleDataset
// - TOracleQuery
// - TOracleScript
var
  i: Integer;
begin
{$IFNDEF ISO}
  exit;
{$ENDIF}
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleDataSet then
    begin
      // dataset: assegna sessione oracle
      (Components[i] as TOracleDataSet).Session:=POracleSession;
    end
    else if Components[i] is TOracleQuery then
    begin
      // oracle query
      // assegna sessione oracle
     (Components[i] as TOracleQuery).Session:=POracleSession;
    end
    else if Components[i] is TOracleScript then
    begin
      // oracle script
      // assegna sessione oracle
     (Components[i] as TOracleScript).Session:=POracleSession;
    end;
  end;
end;

procedure TA062FQueryServizioMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
{$IFDEF ISO}
  SessioneOracleR005:=DBInterno;
  SetSessioneOracle(SessioneOracleR005);
{$ENDIF}
  if Parametri.Applicazione = '' then
    Parametri.Applicazione:={$IFNDEF ISO}'RILPRE'{$ELSE}'ISO'{$ENDIF};
  selT002Riga.SetVariable('APPLICAZIONE',Parametri.Applicazione);
  insT002.SetVariable('Applicazione',Parametri.Applicazione);
  delT002.SetVariable('Applicazione',Parametri.Applicazione);
  SqlSelezioneList:=TStringList.Create;
  Elenco:=TStringList.Create;
  FSqlVariabili:='';
  FSqlTipi:='';
{$IFNDEF ISO}
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,'',Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO','','NOME_LOGICO');
{$ENDIF}
  selT002TrovaQuery.SetVariable('APPLICAZIONE',Parametri.Applicazione);
  selT005.SetVariable('APPLICAZIONE',Parametri.Applicazione);
  selT005.Open;
  EsisteC700:=False;
  SoloValoriVariabiliOperatore:=False;
end;

procedure TA062FQueryServizioMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(SqlSelezioneList);
  FreeAndNil(Elenco);
  FreeAndNil(selI010);
end;

procedure TA062FQueryServizioMW.DelQueryRaggr(Codice: String);
begin
  delT006.SetVariable('COD_QUERY',Codice);
  delT006.Execute;
end;

procedure TA062FQueryServizioMW.OpenSelT002(var MyDataSet:TOracleDataSet; Filtro:string = ''; FiltroProt:string = '');
begin
  MyDataSet.Close;
  MyDataSet.SQL.Clear;
  MyDataSet.DeleteVariables;
  MyDataSet.ClearVariables;
  MyDataSet.SQL.Add('select distinct T002.NOME');
  //http://www.freeformatter.com/string-escaper.html tool utilizzato per formattare correttamente
  MyDataSet.SQL.Add(', concatena_testo(''select T005.DESCRIZIONE from T005_RAGGRQUERYPERS T005, T006_ASSOCIA_QUERYPERS_RAGGR T006 where T006.ID = T005.ID and T006.COD_QUERY = ''''''||replace(T002.NOME,'''''''','''''''''''')||'''''''','','') RAGGRUPPAMENTO');
  if Filtro.IsEmpty then
    MyDataSet.SQL.Add('  from T002_QUERYPERSONALIZZATE T002')
  else
    MyDataSet.SQL.Add('  from T002_QUERYPERSONALIZZATE T002, T006_ASSOCIA_QUERYPERS_RAGGR T006, T005_RAGGRQUERYPERS T005');
  MyDataSet.SQL.Add(' where T002.APPLICAZIONE = :APPLICAZIONE');
  if not Filtro.IsEmpty then
  begin
    MyDataSet.SQL.Add('   and upper(T002.NOME) = upper(T006.COD_QUERY)');
    MyDataSet.SQL.Add('   and T006.ID = T005.ID');
    MyDataSet.SQL.Add('   and T005.DESCRIZIONE = :COD_RAGGR');
    MyDataSet.DeclareAndSet('COD_RAGGR',otString,Filtro);
  end;
  if not FiltroProt.IsEmpty then
    MyDataSet.SQL.Add('   and ' + FiltroProt);

  MyDataSet.SQL.Add(' order by upper(T002.NOME)');
  MyDataSet.DeclareAndSet('APPLICAZIONE',otString,Parametri.Applicazione);
  MyDataSet.Open;
end;

procedure TA062FQueryServizioMW.CaricaCmbRaggruppamenti(lstRaggr:TStrings);
begin
  lstRaggr.Add('Tutte le interrogazioni');
  selT005.First;
  while not selT005.Eof do
  begin
    lstRaggr.Add(selT005.FieldByName('DESCRIZIONE').AsString);
    selT005.Next;
  end;
end;

procedure TA062FQueryServizioMW.CaricaQuery;
  //Legge un valore generico salvato su riga 4
  function GetVariabile(Nome:String):String;
  var
    Val:String;
  begin
    Nome:=UpperCase(Nome);
    Val:=Trim(VarToStr(selT002Riga.Lookup('POSIZ',-4,'RIGA')));
    if Val = '' then
      Val:='CHKINTESTAZIONE(S)CHKNORITORNOACAPO(N)';
    Result:=Copy(Val,pos(Nome + '(',Val) + Length(Nome + '('), PosEx(')',Val,pos(Nome + '(',Val)) - (pos(Nome + '(',Val) + Length(Nome + '(')));
  end;

begin
  if SqlNome = '' then
    exit;
  selT002Riga.Close;
  selT002Riga.SetVariable('Nome',SqlNome);
  selT002Riga.Open;
  selT002Riga.First;
  SqlSelezioneList.BeginUpdate;
  while not selT002Riga.EOF do
  begin
    if selT002Riga.FieldByName('POSIZ').AsInteger >= 0 then
      SqlSelezioneList.Add(selT002Riga.FieldByName('Riga').AsString);
    selT002Riga.Next;
  end;
  SqlSelezioneList.EndUpdate;
  FSqlVariabili:=VarToStr(selT002Riga.Lookup('POSIZ',-1,'RIGA')).Trim;
  FSqlTipi:=VarToStr(selT002Riga.Lookup('POSIZ',-2,'RIGA')).Trim;
  SqlNomeTabella:=Trim(VarToStr(selT002Riga.Lookup('POSIZ',-3,'RIGA')));
  chkIntestazioneChecked:=GetVariabile(chkIntestazioneName) = 'S';
  chkNoRitornoACapoChecked:=GetVariabile(chkNoRitornoACapoName) = 'S';
  ChkMWProtetta:=VarToStr(selT002Riga.Lookup('POSIZ',-9,'RIGA')) = 'S';
  if SqlSelezioneList.Text <> '' then
    CaricaVariabili;
  {$IFDEF ISO}
  selQ003.Close;
  selQ003.SetVariable('NOMEQUERY',SqlNome);
  selQ003.Open;
  {$ENDIF}
end;

procedure TA062FQueryServizioMW.CaricaVariabili;
var i,j:Integer;
    Valori,Tipo:TStringList;
    loc_cdsValoriFiltered:Boolean;
begin
  TrovaVariabili;
  // Leggo i valori
  Valori:=TStringList.Create;
  Valori.Clear;
  Valori.CommaText:=VarToStr(selT002Riga.Lookup('POSIZ',-1,'RIGA'));
  // Leggo il tipo
  Tipo:=TStringList.Create;
  Tipo.Clear;
  Tipo.CommaText:=VarToStr(selT002Riga.Lookup('POSIZ',-2,'RIGA'));

  if (Elenco.Count <> Valori.Count) or (Elenco.Count <> Tipo.Count) then
  try
    //Sono state aggiunte variabili -> eseguo la procedura di salvataggio che riallinea le variabili con i Valori e Tipo salvati
    //SessioneOracle.Commit;
    loc_cdsValoriFiltered:=cdsValori.Filtered;
    with cdsValori do
    begin
      Close;
      Filtered:=False;
      CreateDataset;
      Open;
      LogChanges:=False;
      BeforeInsert:=nil;
      FieldByName('VARIABILE').ReadOnly:=False;
      j:=0;
      for i:=0 to Elenco.Count - 1 do
      begin
        if (UpperCase(Elenco[i]) <> 'DATALAVORO') and (UpperCase(Elenco[i]) <> 'C700DATADAL') then
        begin
          Insert;
          //Imposto la variabile
          FieldByName('VARIABILE').AsString:=Elenco[i];
          //Imposto i valori
          if j < Valori.Count then
            if Valori[j] = '*' then
              FieldByName('VALORE').AsString:=''
            else
              FieldByName('VALORE').AsString:=Valori[j];
          //Imposto il tipo
          if (UpperCase(Elenco[i]) = 'C700SELANAGRAFE') then
            FieldByName('TIPO').AsString:='Sostituzione'
          else if j < Tipo.Count then
            FieldByName('TIPO').AsString:=Tipo[j]
          else
            FieldByName('TIPO').AsString:='Stringa';
          Post;
          j:=j+1;
        end;
      end;
      BeforeInsert:=cdsValoriBeforeInsert;
      FieldByName('VARIABILE').ReadOnly:=True;
    end;

    SalvaSql;
    SqlSelezioneList.BeginUpdate;
    SqlSelezioneList.Clear;
    SqlSelezioneList.EndUpdate;
    CaricaQuery;
    exit;
  finally
    cdsValori.Filtered:=loc_cdsValoriFiltered;
  end;

  C004DM_MW.selT001.Refresh;
  with cdsValori do
  begin
    Close;
    CreateDataset;
    Open;
    LogChanges:=False;
    BeforeInsert:=nil;
    FieldByName('VARIABILE').ReadOnly:=False;
    for i:=0 to Elenco.Count - 1 do
    begin
      Insert;
      //Imposto la variabile
      FieldByName('VARIABILE').AsString:=Elenco[i];
      //Imposto i valori
      if i < Valori.Count then
        if UpperCase(Tipo[i]) = UpperCase('FineMese_DataLavoro') then
          FieldByName('VALORE').AsString:=DateToStr(R180FineMese(Parametri.DataLavoro))
        else
        begin
          FieldByName('VALORE').AsString:=C004DM_MW.GetParametro(UpperCase(SqlNome) + '.' + UpperCase(Elenco[i]),IfThen(SoloValoriVariabiliOperatore,'',Valori[i]));
          if (FieldByName('VALORE').AsString = '*') or (UpperCase(Tipo[i]) = UpperCase('Nome_Utente')) then
            FieldByName('VALORE').AsString:='';
        end;
      //Imposto il tipo
      if i < Tipo.Count then
        FieldByName('TIPO').AsString:=Tipo[i]
      else
        FieldByName('TIPO').AsString:='Stringa';
      Post;
    end;
    BeforeInsert:=cdsValoriBeforeInsert;
    FieldByName('VARIABILE').ReadOnly:=True;
  end;

  SessioneOracle.Commit;

  FreeAndNil(Valori);
  FreeAndNil(Tipo);
end;

procedure TA062FQueryServizioMW.RefreshVariabili;
var i:Integer;
    EsisteVar:Boolean;
begin
  TrovaVariabili;
  with cdsValori do
  begin
    BeforeInsert:=nil;
    BeforeDelete:=nil;
    try
      FieldByName('VARIABILE').ReadOnly:=False;
      for i:=0 to Elenco.Count - 1 do
      begin
        if not Locate('VARIABILE',Elenco[i],[loCaseInsensitive]) then
        begin
          Insert;
          //Imposto la variabile
          FieldByName('VARIABILE').AsString:=Elenco[i];
          FieldByName('TIPO').AsString:='Stringa';
          Post;
        end;
      end;
      First;
      while not Eof do
      begin
        EsisteVar:=False;
        for i:=0 to Elenco.Count - 1 do
          if UpperCase(FieldByName('VARIABILE').AsString) = UpperCase(Elenco[i]) then
          begin
            EsisteVar:=True;
            Break;
          end;
        if EsisteVar then
          Next
        else
          Delete;
      end;
    finally
      BeforeInsert:=cdsValoriBeforeInsert;
      BeforeDelete:=cdsValoriBeforeDelete;
      FieldByName('VARIABILE').ReadOnly:=True;
    end;
  end;
end;

procedure TA062FQueryServizioMW.cdsValoriBeforeDelete(DataSet: TDataSet);
begin
  Abort;
end;

procedure TA062FQueryServizioMW.cdsValoriBeforeInsert(DataSet: TDataSet);
begin
  Abort;
end;

procedure TA062FQueryServizioMW.delT002BeforeQuery(Sender: TOracleQuery);
begin
  {$IFNDEF ISO}A000AggiornaFiltroDizionario('INTERROGAZIONI DI SERVIZIO',selT002.FieldByName('NOME').AsString,'');{$ENDIF}
end;

procedure TA062FQueryServizioMW.ImpostaVariabile(pNome, pTipo:String;pValore:Variant);
var D:TDateTime;
begin
  if Uppercase(pTipo) = Uppercase('Data') then
  begin
    if not TryStrToDate(VarToStr(pValore),D) then
      exit;
    if Q1.VariableIndex(pNome) < 0 then
      Q1.DeclareVariable(pNome, otDate);
    Q1.SetVariable(pNome, R180VarToDateTime(pValore));
  end
  else if UpperCase(pTipo) = UpperCase('FineMese_DataLavoro') then
  begin
    if not TryStrToDate(VarToStr(pValore),D) then
      exit;
    if Q1.VariableIndex(pNome) < 0 then
      Q1.DeclareVariable(pNome, otDate);
    Q1.SetVariable(pNome, R180VarToDateTime(pValore));
  end
  else if Uppercase(pTipo) = Uppercase('Nome_Utente') then
  begin
    if Q1.VariableIndex(pNome) < 0 then
      Q1.DeclareVariable(pNome, otString);
    Q1.SetVariable(pNome, Parametri.Operatore.ToUpper);
  end
  else if Uppercase(pTipo) = Uppercase('Stringa') then
  begin
    if Q1.VariableIndex(pNome) < 0 then
      Q1.DeclareVariable(pNome, otString);
    Q1.SetVariable(pNome, VarToStr(pValore));
  end
  else if Uppercase(pTipo) = Uppercase('Numero') then
  begin
    if Q1.VariableIndex(pNome) < 0 then
      Q1.DeclareVariable(pNome, otFloat);
    Q1.SetVariable(pNome, pValore);
  end
  else if Uppercase(pTipo) = Uppercase('Sostituzione') then
  begin
    if Q1.VariableIndex(pNome) < 0 then
      Q1.DeclareVariable(pNome, otSubst);
    Q1.SetVariable(pNome, VarToStr(pValore));
  end;
end;

procedure TA062FQueryServizioMW.ElaboraVariabili(Script: Boolean);
begin
  if not Script then
    Q1.DeleteVariables;
  if cdsValori.RecordCount = 0 then
    Exit;
  cdsValori.First;
  while not cdsValori.Eof do
  begin
    if not Script then
      ImpostaVariabile(cdsValori.FieldByName('VARIABILE').AsString,
                       cdsValori.FieldByName('TIPO').AsString,
                       cdsValori.FieldByName('VALORE').AsVariant)
    else
      if Uppercase(cdsValori.FieldByName('TIPO').AsString) = Uppercase('Sostituzione') then
        S1.SetVariable(cdsValori.FieldByName('VARIABILE').AsString,cdsValori.FieldByName('VALORE').AsString);
    cdsValori.Next;
  end;
  if not Script then
    SalvaVarImp;
end;

procedure TA062FQueryServizioMW.SalvaVarImp;
var
  Canc001:TOracleQuery;
begin
  Canc001:=TOracleQuery.Create(nil);
  try
    Canc001.Session:=C004DM_MW.DelT001.Session;
    Canc001.SQL.Add('DELETE FROM T001_PARAMETRIFUNZIONI');
    Canc001.SQL.Add('WHERE PROG = ''' + C004DM_MW.DelT001.GetVariable('PROG') + '''');
    Canc001.SQL.Add('AND UTENTE = ''' + C004DM_MW.DelT001.GetVariable('UTENTE') + '''');
    Canc001.SQL.Add('AND NOME LIKE ''' + UpperCase(SqlNome) + '.%''');
    Canc001.Execute;
  finally
    FreeAndNil(Canc001);
  end;
  cdsValori.First;
  while not cdsValori.Eof do
  begin
    C004DM_MW.PutParametro(UpperCase(SqlNome) + '.' + UpperCase(cdsValori.FieldByName('VARIABILE').AsString),cdsValori.FieldByName('VALORE').AsString);
    cdsValori.Next;
  end;
  try C004DM_MW.DelT001.Session.Commit; except end;
end;

procedure TA062FQueryServizioMW.PreparaScript;
var i:integer;
    s, UserNameAppoggio:String;
    D: TDateTime;
begin
  if UpperCase(Copy(Trim(SqlSelezioneList.Text) + ' ',1,5)) <> 'EXEC ' then
    exit;
  ChiediPswAccessoDB:=False;
  with S1 do
  begin
    Output.Clear;
    Lines.Clear;
    TrovaVariabili;
    if Elenco.Count <> cdsValori.RecordCount then
      raise Exception.Create('Istruzione non valida!' + #13#10 + 'Variabili non definite: salvare lo script prima di eseguirlo');
    Lines.Assign(SqlSelezioneList);
    for i:=0 to Lines.Count - 1 do
    begin
      UserNameAppoggio:='';
      //Tolgo gli spazi esterni
      Lines[i]:=StringReplace(Trim(Lines[i]),':','&',[rfReplaceAll]);
      //Tolgo EXEC
      if Copy(UpperCase(Lines[i]) + ' ',1,5) = 'EXEC ' then
        Lines[i]:=Copy(Lines[i],6);
      //Aggiungo il punto e virgola a fine istruzione
      if (Lines[i] <> '') and (Pos(';',Lines[i]) <> Length(Lines[i])) then
        Lines[i]:=Lines[i] + ';';
      //Prelevo l'utente Oracle
      if Pos('.',Lines[i]) > 0 then
        //indicato
        UserNameAppoggio:=UpperCase(Trim(Copy(Lines[i],1,Pos('.',Lines[i]) - 1)))
      else if Pos(';',Lines[i]) > 0 then
        //sottointeso
        UserNameAppoggio:=Parametri.Username;
      if UserNameAppoggio <> '' then
      begin
        if (UserName <> '') and (UserName <> UserNameAppoggio) then
          raise Exception.Create('Script non valido! Si fa riferimento a più di un utente Oracle!')
        else
          UserName:=UserNameAppoggio;
      end;
    end;
    Lines.Insert(0,'BEGIN');
    Lines.Append('END;');
    Lines.Append('/');
    ElaboraVariabili(True);
    if cdsValori.Locate('VARIABILE;TIPO',VarArrayOf(['C700SelAnagrafe','Sostituzione']),[loCaseInsensitive]) then
    begin
      if Assigned(C700MergeSelAnagrafe) then
        C700MergeSelAnagrafe(S1,False)
      else if Assigned(GC700MergeSelAnagrafe) then
        GC700MergeSelAnagrafe(S1,False);
      S1.SetVariable('C700SelAnagrafe','''' + S1.GetVariable('C700SelAnagrafe').Replace('''','''''',[rfreplaceAll]) + '''');

      if cdsValori.Locate('VARIABILE;TIPO',VarArrayOf(['DataLavoro','Data']),[loCaseInsensitive]) and
         (not cdsValori.FieldByName('VALORE').IsNull) and
         TryStrToDate(cdsValori.FieldByName('VALORE').AsString,D) then
        S1.SetVariable('DataLavoro',cdsValori.FieldByName('VALORE').AsString);
    end;

    RegistraMsg.InserisciMessaggio('I','Query ' + SqlNome + ' = ' + SqlSelezioneList.Text,'',0);
    cdsValori.First;
    s:='';
    while not cdsValori.Eof do
    begin
      if Trim(s) <> '' then
        s:=s + '; ';
      s:=s + 'Variabile ' + cdsValori.FieldByName('VARIABILE').AsString + ' = ' + cdsValori.FieldByName('VALORE').AsString;
      cdsValori.Next;
    end;
    RegistraMsg.InserisciMessaggio('I',s,'',0);

    try
      BtnCartellinoEnabled:=False;
      BtnCartellinoVisible:=btnCartellinoEnabled;
      ActSalvaEnabled:=False;
      selI090.Close;
      selI090.SetVariable('UTENTE',UserName);
      selI090.Open;
      ChiediPswAccessoDB:=True;
    except
      on E:Exception do
        raise Exception.Create('Script non valido!' + #1310 + E.Message);
    end;
  end;
end;

function TA062FQueryServizioMW.EsisteTabella:Boolean;
var i,j:integer;
    NomeTabella,ChrNonValidi:String;
    ChrNum:array of string;
    FindIT:Boolean;
begin
  Result:=False;
  ChrNum:=VarArrayOf(['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O',
                      'P','Q','R','S','T','U','V','W','X','Y','Z','_','0','1','2',
                      '3','4','5','6','7','8','9']);

  if not SenderIsBtnCreaTab then
    exit;
  //Controllo nome Tabella
  NomeTabella:=SqlNomeTabella.ToUpper;
  ChrNonValidi:='';
  for i:=1 to Length(NomeTabella) do
  begin
    FindIT:=False;
    j:=Low(ChrNum);
    while j <= High(ChrNum) do
    begin
      if UpperCase(NomeTabella[i]) = ChrNum[j] then
        FindIT:=True;
      inc(j);
    end;
    if Not FindIT then
      ChrNonValidi:=ChrNonValidi + IfThen(NomeTabella[i] = ' ','Spazio bianco',NomeTabella[i]);
  end;
  if ChrNonValidi <> '' then
    Raise Exception.Create('Carattere [' + ChrNonValidi + '] non valido nel nome tabella.');
  //Pulizia tabelle
  CreateTab.DeleteVariables;
  CreateTab.Close;
  CreateTab.SQL.Clear;
  CreateTab.SQL.Add('SELECT * FROM TABS WHERE TABLE_NAME = ''T921' + NomeTabella + '''');
  CreateTab.Open;
  Result:=CreateTab.RecordCount > 0;
end;

procedure TA062FQueryServizioMW.EseguiQuery;
var D:TDateTime;
begin
  Q1.Close;
  Q1.SQL.Clear;
  Q1.SQL.Assign(SqlSelezioneList);
  TrovaVariabili;
  if cdsValori.state = dsInactive then
  begin
    cdsValori.Close;
    cdsValori.CreateDataSet;
    cdsValori.Open;
  end;

  if Elenco.Count <> cdsValori.RecordCount then
    raise Exception.Create('Selezione non valida!' + #13#10 + 'Variabili non definite: salvare la query prima di eseguirla');
  ElaboraVariabili(False);
  if cdsValori.Locate('VARIABILE;TIPO',VarArrayOf(['C700SelAnagrafe','Sostituzione']),[loCaseInsensitive]) then
  begin
    if Assigned(C700MergeSelAnagrafe) then
      C700MergeSelAnagrafe(Q1,False)
    else if Assigned(GC700MergeSelAnagrafe) then
      GC700MergeSelAnagrafe(Q1,False)
    else if Assigned(W041MergeSelAnagrafe) then
      W041MergeSelAnagrafe(Q1);

   	//DC-bugfix per IrisWEB: la selezione anagrafica non può essere periodica, per cui la variabile C700DataDal non esiste
    //(se esiste una variabile omonima viene comunque ricreata successivamente)
    if Assigned(W041MergeSelAnagrafe) and (Q1.VariableIndex('C700DataDal') >= 0) then
      Q1.DeleteVariable('C700DataDal'); //

    if cdsValori.Locate('VARIABILE;TIPO',VarArrayOf(['DataLavoro','Data']),[loCaseInsensitive]) and
       (not cdsValori.FieldByName('VALORE').IsNull) and
       TryStrToDate(cdsValori.FieldByName('VALORE').AsString,D) then
      Q1.SetVariable('DataLavoro',cdsValori.FieldByName('VALORE').AsDateTime);

    if cdsValori.Locate('VARIABILE;TIPO',VarArrayOf(['C700DataDal','Data']),[loCaseInsensitive]) and
       (not cdsValori.FieldByName('VALORE').IsNull) and
       TryStrToDate(cdsValori.FieldByName('VALORE').AsString,D) and
       (Q1.VariableIndex('C700DataDal') >= 0) then
      Q1.SetVariable('C700DataDal',cdsValori.FieldByName('VALORE').AsDateTime)

    //Caso in cui esiste una variabile C700DataDal ma non è gestita dalla C700
    //-> controlla se esiste nel testo della SQL oltre che nel dataset
    else if (UpperCase(Q1.SQL.Text).IndexOf(UpperCase(':C700DataDal')) >= 0) and (cdsValori.Locate('VARIABILE',VarArrayOf(['C700DataDal']),[loCaseInsensitive])) then
       ImpostaVariabile(cdsValori.FieldByName('VARIABILE').AsString,
                        cdsValori.FieldByName('TIPO').AsString,
                        cdsValori.FieldByName('VALORE').AsVariant);
  end;

  try
    BtnCartellinoEnabled:=False;
    BtnCartellinoVisible:=btnCartellinoEnabled;
    ActSalvaEnabled:=False;
    Q1.Open;
  except
    on E:Exception do
      raise Exception.Create('Selezione non valida!' + #13#10 + E.Message);
  end;

  if (Q1.RecordCount = 0) and cdsValori.Locate('VARIABILE;TIPO',VarArrayOf(['C700SelAnagrafe','Sostituzione']),[loCaseInsensitive]) then
    if (SelAnagrafe <> nil) and (SelAnagrafe.RecordCount = 0) then
      raise Exception.Create(A000MSG_ERR_NO_DIP);
end;

procedure TA062FQueryServizioMW.GestioneVariabili(Script: Boolean);
var i,j:Integer;
    Trovato:Boolean;
begin
  TrovaVariabili;
  with cdsValori do
  begin
    BeforeInsert:=nil;
    BeforeDelete:=nil;
    FieldByName('VARIABILE').ReadOnly:=False;
    // Aggiungo le eventuali variabili in più
    for i:=0 to Elenco.Count - 1 do
    begin
      if not Locate('VARIABILE',Elenco[i],[loCaseInsensitive]) then
      begin
        Insert;
        FieldByName('VARIABILE').AsString:=Elenco[i];
        if (UpperCase(Elenco[i]) = 'C700SELANAGRAFE') or Script then
          FieldByName('TIPO').AsString:='Sostituzione'
        else if (UpperCase(Elenco[i]) = 'DATALAVORO') then
          FieldByName('TIPO').AsString:='Data'
        else if (UpperCase(Elenco[i]) = 'C700DATADAL') then
          FieldByName('TIPO').AsString:='Data'
        else
          FieldByName('TIPO').AsString:='Stringa';
        Post;
      end;
    end;
    // Elimino le eventuali variabili in meno
    First;
    while not Eof do
    begin
      Trovato:=False;
      for j:=0 to Elenco.Count - 1 do
        if UpperCase(FieldByName('VARIABILE').AsString) = UpperCase(Elenco[j]) then
        begin
          Trovato:=True;
          Break;
        end;
      if not Trovato then
        Delete
      else
        Next;
    end;
    BeforeInsert:=cdsValoriBeforeInsert;
    BeforeDelete:=cdsValoriBeforeDelete;
    FieldByName('VARIABILE').ReadOnly:=True;
  end;
end;

procedure TA062FQueryServizioMW.insT002AfterQuery(Sender: TOracleQuery);
begin
  {$IFNDEF ISO}A000AggiornaFiltroDizionario('INTERROGAZIONI DI SERVIZIO','',selT002.FieldByName('NOME').AsString);{$ENDIF}
end;

function TA062FQueryServizioMW.SalvaSql:Boolean;
var
  i:integer;
  s:string;
begin
  Result:=False;
  selT002TrovaQuery.SetVariable('QRY_NOME',SqlNome);
  selT002TrovaQuery.Execute;
  if (VarToStr(selT002Riga.GetVariable('NOME')) <> SqlNome) and
     (selT002TrovaQuery.FieldAsInteger('NUM_REC') > 0) then
    Exit;

  selT002Riga.Close;
  selT002Riga.SetVariable('Nome',SqlNome);
  selT002Riga.Open;
  selT002Riga.First;

  if not selT002Riga.EOF then
  begin
    delT002.Close;
    delT002.SetVariable('Nome',SqlNome);
    delT002.Execute;
  end;

  GestioneVariabili(UpperCase(Copy(Trim(EliminaRitornoACapo(SqlSelezioneList.Text)) + ' ',1,5)) = 'EXEC ');
  SalvaVariabili;

  //Salvo se stampa è protetta
  insT002.SetVariable('Nome',SqlNome);
  insT002.SetVariable('Posiz',-9);
  insT002.SetVariable('Riga',IfThen(ChkMWProtetta,'S','N'));
  insT002.Execute;

  //Inserisco eventuale nome tabella
  if Trim(SqlNomeTabella) <> '' then
  begin
    insT002.SetVariable('Nome',SqlNome);
    insT002.SetVariable('Posiz',-3);
    insT002.SetVariable('Riga',SqlNomeTabella);
    insT002.Execute;
  end;
  //Salvataggio variabili generiche
  s:=UpperCase(chkIntestazioneName);
  if chkIntestazioneChecked then
    s:=s + '(S)'
  else
    s:=s + '(N)';
  s:=s + UpperCase(chkNoRitornoACapoName);
  if chkNoRitornoACapoChecked then
    s:=s + '(S)'
  else
    s:=s + '(N)';
  insT002.SetVariable('Nome',SqlNome);
  insT002.SetVariable('Posiz',-4);
  insT002.SetVariable('Riga',s);
  insT002.Execute;

  // Inserisco la query
  R180SplitLines(SqlSelezioneList,[' ',','],2000);
  for i:=0 to SqlSelezioneList.Count - 1 do
  begin
    insT002.SetVariable('Nome',SqlNome);
    insT002.SetVariable('Posiz',i);
    insT002.SetVariable('Riga',SqlSelezioneList[i]);
    insT002.Execute;
  end;

  SessioneOracle.Commit;

  Result:=True;
end;

function TA062FQueryServizioMW.SalvaVariabili: Boolean;
var
  s,Tipo:String;
begin
  cdsValori.First;
  s:='';
  Tipo:='';
  while not cdsValori.Eof do
  begin
    // Prelevo i valori delle variabili
    if s <> '' then
      s:=s + ',';
    if (cdsValori.FieldByName('VALORE').AsString <> '') and (cdsValori.FieldByName('TIPO').AsString.ToUpper <> 'Nome_Utente'.ToUpper) then
      s:=s + '"' + cdsValori.FieldByName('VALORE').AsString + '"'
    else
      s:=s + '*';
    // Prelevo i tipi delle variabili
    if Tipo <> '' then
      Tipo:=Tipo + ',';
    if cdsValori.FieldByName('TIPO').AsString <> '' then
      Tipo:=Tipo + cdsValori.FieldByName('TIPO').AsString
    else
      Tipo:=Tipo + 'Stringa';
    cdsValori.Next;
  end;

  //Cancello eventuali righe preeesistenti, se sto gestendo solo le variabili
  delT002.SetVariable('Nome',SqlNome);
  delT002.SetVariable('Filtro','and POSIZ in (-1,-2)');
  delT002.Execute;
  delT002.SetVariable('Filtro',null);

  // Inserisco i valori delle variabili
  if s <> '' then
  begin
    insT002.SetVariable('Nome',SqlNome);
    insT002.SetVariable('Posiz',-1);
    insT002.SetVariable('Riga',s);
    insT002.Execute;
  end;
  // Inserisco i tipi delle variabili
  if Tipo <> '' then
  begin
    insT002.SetVariable('Nome',SqlNome);
    insT002.SetVariable('Posiz',-2);
    insT002.SetVariable('Riga',Tipo);
    insT002.Execute;
  end;

  // verificare se i dati sono stati modificati e invalidare i risultati
  Result:=(FSqlVariabili <> s) or (FSqlTipi <> Tipo);
end;

procedure TA062FQueryServizioMW.selT002FiltraRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('INTERROGAZIONI DI SERVIZIO',DataSet.FieldByName('NOME').AsString);
end;

procedure TA062FQueryServizioMW.dropTableT921;
begin
  CreateTab.Close;
  CreateTab.SQL.Clear;
  CreateTab.SQL.Insert(0,'DROP TABLE T921' + SqlNomeTabella);
  CreateTab.ExecSQL;
end;

procedure TA062FQueryServizioMW.TrovaVariabili;
var
  Stringa,S:String;
  i,x:Integer;
begin
  EsisteC700:=False;
  FreeAndNil(Elenco);
  Stringa:=SqlSelezioneList.Text;
  Elenco:=FindVariables(Stringa, False);
  for i:=0 to Elenco.Count - 1 do
  begin
    if UpperCase(Elenco[i]) = 'C700SELANAGRAFE' then
      EsisteC700:=True;
    x:=R180CercaParolaIntera(':' + UpperCase(Elenco[i]),UpperCase(Stringa),'()=<>|!/+-*.,');
    if x > 0 then
    begin
      S:=Copy(Stringa,x + 1,Length(Elenco[i]));
      Elenco[i]:=S;
    end;
  end;

  if (*SalvataggioInCorso and*) EsisteC700 then
  begin
    if Elenco.IndexOf('DataLavoro') < 0 then
      Elenco.Add('DataLavoro');
    if Elenco.IndexOf('C700DataDal') < 0 then
      Elenco.Add('C700DataDal');
  end;
  Elenco.Sort;
end;

procedure TA062FQueryServizioMW.ValidaQuery;
var s:String;
    i:integer;
begin
  s:='';
  for i:=0 to SqlSelezioneList.Count - 1 do
    if (Trim(SqlSelezioneList[i]) <> '') and (Copy(Trim(SqlSelezioneList[i]),1,2) <> '--') then
    begin
      s:=SqlSelezioneList[i];
      Break;
    end;
  if SenderIsBtnCreaTab and (UpperCase(Copy(Trim(s),1,6)) <> 'SELECT') then
    raise Exception.Create('Non è consentito eseguire una query diversa dal tipo SELECT!');
  if (not SenderIsBtnCreaTab) and (UpperCase(Copy(Trim(s),1,6)) <> 'SELECT')
  and (not (UpperCase(Copy(Trim(SqlSelezioneList.Text) + ' ',1,5)) = 'EXEC ')) then
    raise Exception.Create('Non è consentito eseguire un''istruzione diversa dal tipo SELECT o EXEC!');
end;

function TA062FQueryServizioMW.CreaTestoFile(NomeFile:String): TStream;
var i,j:Integer;
    S,S1:String;
    Filecvs:Boolean;
begin
  //Gestione file csv,txt e altri
  Result:=TStringStream.Create;
  try
    Filecvs:=False;
    if NomeFile.Length > 4 then
      if LowerCase(Copy(NomeFile,NomeFile.Length - 3,4)) = '.csv' then
        Filecvs:=True;
    with Q1 do
    begin
      for j:=FieldCount - 1 downto 0 do
        if Fields[j].Visible then
          Break;
      First;
      DisableControls;
      if chkIntestazioneChecked then
      begin
        S:='';
        for i:=0 to FieldCount - 1 do
          if Fields[i].Visible then
          begin
            if (i < j) and not Filecvs then
              S1:=Format('%-*s',[R180Lunghezzacampo(Fields[i]),Copy(Fields[i].FieldName,1,R180Lunghezzacampo(Fields[i]))])
            else
              S1:=Format('%-s',[Fields[i].FieldName]);
            S:=S + IfThen(Filecvs,StringToCsv(S1),S1);
          end;
          if (S.Length > 0) and (Filecvs) then
            //Rimozione separatore finale
            SetLength(S,S.Length - 1);
        if not chkNoRitornoACapoChecked then
          S:=S + #13#10;
      end;
      while not Eof do
      begin
        for i:=0 to FieldCount - 1 do
          if Fields[i].Visible then
          begin
            if (i < j) and not Filecvs then
              S1:=Format('%-*s',[R180Lunghezzacampo(Fields[i]),Copy(Fields[i].AsString,1,R180Lunghezzacampo(Fields[i]))])
            else
              S1:=Format('%-s',[Fields[i].AsString]);
            S:=S + IfThen(Filecvs,StringToCsv(S1),S1);
          end;
          if (S.Length > 0) and (Filecvs) then
            //Rimozione separatore finale
            SetLength(S,S.Length - 1);
        if not chkNoRitornoACapoChecked then
          S:=S + #13#10;
        Next;
      end;
      First;
      EnableControls;
    end;
    (Result as TStringStream).WriteString(S);
  except
    on E: Exception do
    begin
      FreeAndNil(Result);
      raise;
    end;
  end;
end;

function TA062FQueryServizioMW.StringToCsv(Stringa:String): String;
const
    COL_SEPARATOR = ';';
begin
  Result:='"' + Trim(StringReplace(Stringa,'"','""',[rfReplaceAll])) + '"' + COL_SEPARATOR;
end;

procedure TA062FQueryServizioMW.CreateTableT921(NewName: String);
var i:Integer;
    S:String;
begin
  if not Q1.Active then
    Exit;
  CreateTab.DeleteVariables;
  CreateTab.Close;
  CreateTab.SQL.Clear;
  CreateTab.SQL.Add('create table T921' + NewName + ' as ' + CRLF + Q1.SQL.Text);
  for i:=0 to Q1.VariableCount - 1 do
  begin
    CreateTab.DeclareVariable(Q1.VariableName(i),otSubst);
    if Q1.VariableType(i) = otString then
      CreateTab.SetVariable(Q1.VariableName(i),'''' + AggiungiApice(Q1.GetVariable(Q1.VariableName(i))) + '''')
    else if Q1.VariableType(i) = otDate then
      CreateTab.SetVariable(Q1.VariableName(i),Format('to_date(''%s'',''dd/mm/yyyy'')',[DateToStr(Q1.GetVariable(Q1.VariableName(i)))]))
    else
      CreateTab.SetVariable(Q1.VariableName(i),Q1.GetVariable(Q1.VariableName(i)));
  end;
  i:=CreateTab.VariableIndex('C700SELANAGRAFE');
  if i >= 0 then
  begin
    S:=CreateTab.GetVariable('C700SELANAGRAFE');
    if Q1.VariableIndex('DataLavoro') >= 0 then
      S:=StringReplace(S,':DataLavoro','''' + DateToStr(Q1.GetVariable('DataLavoro')) + '''',[rfReplaceAll,rfIgnoreCase]);
    if Q1.VariableIndex('C700DataDal') >= 0 then
      S:=StringReplace(S,':C700DataDal','''' + DateToStr(Q1.GetVariable('C700DataDal')) + '''',[rfReplaceAll,rfIgnoreCase]);
    CreateTab.SetVariable('C700SELANAGRAFE',S);
  end;

  CreateTab.ExecSQL;
  Q1.Session.Commit;
end;

end.
