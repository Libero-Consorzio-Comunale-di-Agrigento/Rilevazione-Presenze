unit A181UAziendeMW;

interface

uses
  SysUtils, Classes, Oracle, DB, OracleData, Math, StrUtils, Variants,
  A000UInterfaccia, A000UCostanti, A000USessione, R005UDataModuleMW,
  C180FunzioniGenerali, DBClient, C018UIterAutDM, Datasnap.Provider,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdSMTP, IdMessage,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  RegistrazioneLog, R500Lin, R600;

type

  TA181MW_QI091AfterScroll = procedure(DataSet:TOracleDataSet) of object;

  TI091DatiEnteItems = class
  public
    MultiSelect:Boolean; //False:Selezione singola A008 - True:Selezione Multipla C013
    DimCodice:integer; //Dimensione Codice (solo selezione multipla) -default = 2000, tutto il contenuto della stringa
    ListaSelezione:TStringList; //Elenco dei valori
    procedure BeginUpdate;
    procedure EndUpDate;
    procedure AddItem(Value:string);
    procedure Clear_DatiEnteItems;
    constructor Create;
    destructor Destroy; override;
  end;

  TA181FAziendeMW = class(TR005FDataModuleMW)
    insI091: TOracleQuery;
    scrdelI090: TOracleQuery;
    scrupdI090: TOracleQuery;
    IdSMTP: TIdSMTP;
    IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    IdMessage: TIdMessage;
    QI091: TOracleDataSet;
    QI091AZIENDA: TStringField;
    QI091TIPO: TStringField;
    QI091DATO: TStringField;
    QI091D_Tipo: TStringField;
    QI091Gruppo: TStringField;
    QCOLS: TOracleDataSet;
    selDizionario: TOracleDataSet;
    DBMondoedp: TOracleSession;
    scrI092: TOracleQuery;
    selI091Dato: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure QI091AfterScroll(DataSet: TDataSet);
    procedure QI091AfterDelete(DataSet: TDataSet);
    procedure QI091AfterPost(DataSet: TDataSet);
    procedure QI091BeforeDelete(DataSet: TDataSet);
    procedure QI091BeforePost(DataSet: TDataSet);
    procedure QI091CalcFields(DataSet: TDataSet);
    procedure QI091DATOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure QI091FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure QI091DATOSetText(Sender: TField; const Text: string);
    procedure selDizionarioBeforeOpen(DataSet: TDataSet);
  const
    NON_ASSEGNATO = 'Non assegnato';
  private
    FLinkI070T030:String;
    function GetI091Gruppo(CodI091:String):String;
  public
    GruppoFiltroI091:String;
    QI090:TOracleDataSet;
    A181MW_QI091AfterScroll:TA181MW_QI091AfterScroll;
    I091DatiEnteItems:TI091DatiEnteItems;
    RegistraLogSecondario:TRegistraLog;
    procedure PutElenco(S:String);
    procedure JobArchiviazioneLOG;
    procedure SendEMail(Indirizzo:string);
    function  GetDatoEnte(const PAzienda, PTipo:String):String;
    procedure PutDatiEnte(Azienda:String);
    procedure AggiornaDatiEnte;
    procedure PutParametri;
    property LinkI070T030: String read FLinkI070T030 write FLinkI070T030;
  end;

implementation

{$R *.dfm}

//Begin TI091Elementi
constructor TI091DatiEnteItems.create;
begin
  ListaSelezione:=TstringList.Create;
  DimCodice:=2000;
  MultiSelect:=False;
end;

destructor TI091DatiEnteItems.Destroy;
begin
  FreeAndNil(ListaSelezione);
  inherited;
end;

procedure TI091DatiEnteItems.Clear_DatiEnteItems;
begin
  ListaSelezione.Clear;
  DimCodice:=2000;
  MultiSelect:=False;
end;

procedure TI091DatiEnteItems.BeginUpdate;
begin
  ListaSelezione.BeginUpdate;
end;

procedure TI091DatiEnteItems.EndUpDate;
begin
  ListaSelezione.EndUpdate;
end;

procedure TI091DatiEnteItems.AddItem(Value:string);
begin
  ListaSelezione.Add(Value);
end;

//End TI091Elementi

procedure TA181FAziendeMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  I091DatiEnteItems:=TI091DatiEnteItems.create;
  RegistraLogSecondario:=TRegistraLog.Create(nil);
  RegistraLogSecondario.Session:=SessioneOracle;
end;

procedure TA181FAziendeMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(I091DatiEnteItems);
  FreeAndNil(RegistraLogSecondario);
  inherited;
end;

procedure TA181FAziendeMW.JobArchiviazioneLOG;
var
  ScriptJob:TOracleQuery;
begin
  ScriptJob:=TOracleQuery.Create(nil);
  try
    try
      //Sessione Oracle dedicata all'utente MONDOEDP per la compilazione del job
      DBMondoedp.LogonDatabase:=Parametri.Database;
      A000LogonDBOracle(DBMondoedp);
      ScriptJob.Session:=DBMondoedp;
      ScriptJob.SQL.Add('select count(*) NUMREC');
      ScriptJob.SQL.Add('  from MONDOEDP.I091_DATIENTE I091');
      ScriptJob.SQL.Add(' where I091.TIPO = ''C28_CANCELLA_ANNO_LOG''');
      ScriptJob.SQL.Add('  and nvl(I091.DATO,''99'') <> ''99''');
      ScriptJob.Execute;
      if ScriptJob.FieldAsInteger('NUMREC') > 0 then
      begin
        ScriptJob.SQL.Clear;
        //Se il periodo di cancellazione è diverso da null o da 99 creo il job
        //e pianifico la schedulazione ogni mese alle 2 di notte
        ScriptJob.DeclareVariable('jobno',otInteger);
        ScriptJob.SQL.Add('declare');
        ScriptJob.SQL.Add(' IDJob integer;');
        ScriptJob.SQL.Add('begin');
        ScriptJob.SQL.Add('  IDJob:=-1;');
        //Cerco se è già presente il job
        ScriptJob.SQL.Add('  begin');
        ScriptJob.SQL.Add('    select nvl(J.JOB,99) into IDJob');
        ScriptJob.SQL.Add('      from USER_JOBS J');
        ScriptJob.SQL.Add('     where J.WHAT like (''%I000P_ELIMINAVECCHILOG%'');');
        ScriptJob.SQL.Add('  exception');
        ScriptJob.SQL.Add('    when NO_DATA_FOUND then');
        ScriptJob.SQL.Add('      IDJob:=-1;');
        ScriptJob.SQL.Add('  end;');
        //se non trovo il job lo creo
        ScriptJob.SQL.Add('  if IDJob < 0 then');
        ScriptJob.SQL.Add('    sys.dbms_job.submit (');
        ScriptJob.SQL.Add('    job => :jobno,');
        ScriptJob.SQL.Add('    what => ''declare');
        ScriptJob.SQL.Add('                ECCEZIONE varchar2(2000);');
        ScriptJob.SQL.Add('              cursor c1 is');
        ScriptJob.SQL.Add('                select I090.UTENTE, I090.AZIENDA');
        ScriptJob.SQL.Add('                  from I090_ENTI I090;');
        ScriptJob.SQL.Add('            begin');
        ScriptJob.SQL.Add('              for t1 in c1 loop');
        ScriptJob.SQL.Add('                begin');
        ScriptJob.SQL.Add('                  execute immediate ''''begin ''''||T1.UTENTE||''''.I000P_ELIMINAVECCHILOG; end;'''';');
        ScriptJob.SQL.Add('                exception');
        ScriptJob.SQL.Add('                  when OTHERS then');
        ScriptJob.SQL.Add('                    ECCEZIONE:=substr(SQLERRM,1,2000);');
        ScriptJob.SQL.Add('                    insert into MONDOEDP.I021_LOG_JOB (DATAORA, MESSAGGIO, AZIENDA, TIPO) values (sysdate, ECCEZIONE, T1.AZIENDA,''''I000P_ELIMINAVECCHILOG'''');');
        ScriptJob.SQL.Add('                end;');
        ScriptJob.SQL.Add('              end loop;');
        ScriptJob.SQL.Add('              end;'',');
        ScriptJob.SQL.Add('    next_date => TRUNC(SYSDATE) + 1 + (2/24) /*prima esecuzione alle 02.00*/,');
        ScriptJob.SQL.Add('    interval => ''add_MONTHS(TRUNC(SYSDATE) + 1 + (2/24),1)'') /*prossima esecuzione ogni mese alle 02.00*/;');
        ScriptJob.SQL.Add('    commit;');
        ScriptJob.SQL.Add('  else');
        //se lo trovo resetto la prossima data di esecuzione la notte
        ScriptJob.SQL.Add('    dbms_job.next_date(IDJob, trunc(SYSDATE) + 1 + (2/24));');
        ScriptJob.SQL.Add('    commit;');
        ScriptJob.SQL.Add('  end if;');
        ScriptJob.SQL.Add('end;');
        ScriptJob.Execute;
      end
      else
      begin
        //Se il periodo di cancellazione è uguale a null o a 99 cancello il job
        ScriptJob.SQL.Clear;
        ScriptJob.SQL.Add('declare');
        ScriptJob.SQL.Add('  IDJob integer;');
        ScriptJob.SQL.Add('begin');
        ScriptJob.SQL.Add('  IDJob:=-1;');
        ScriptJob.SQL.Add('  begin');
        ScriptJob.SQL.Add('    select J.JOB into IDJob');
        ScriptJob.SQL.Add('      from USER_JOBS J');
        ScriptJob.SQL.Add('     where J.WHAT like (''%I000P_ELIMINAVECCHILOG%'');');
        ScriptJob.SQL.Add('  exception');
        ScriptJob.SQL.Add('    when NO_DATA_FOUND then');
        ScriptJob.SQL.Add('      IDJob:=-1;');
        ScriptJob.SQL.Add('  end;');
        ScriptJob.SQL.Add('  if IDJob > 0 then');
        ScriptJob.SQL.Add('    dbms_job.remove(IDJob) /*rimuovo il job dopo averne identificato il l''id*/;');
        ScriptJob.SQL.Add('    commit;');
        ScriptJob.SQL.Add('  end if;');
        ScriptJob.SQL.Add('end;');
        ScriptJob.Execute;
      end;
    finally
      FreeAndNil(ScriptJob);
      DBMondoedp.LogOff;
    end;
  except
    on e:exception do
      R180MessageBox(e.message,ERRORE,'Archiviazione log');
  end;
end;

procedure TA181FAziendeMW.PutElenco(S:String);
var
  i, j:Integer;
  LstDati: TStringList;
begin
  I091DatiEnteItems.BeginUpdate;
  I091DatiEnteItems.Clear_DatiEnteItems;
  for i:=1 to High(DatiEnte) do
  begin
    if S = DatiEnte[i].Nome then
    begin
      if DatiEnte[i].Lista = 'OFFICE' then
      begin
        I091DatiEnteItems.AddItem('MICROSOFT OFFICE');
        I091DatiEnteItems.AddItem('OPEN OFFICE');
      end
      else if DatiEnte[i].Lista = 'W035_NAT' then
      begin
        // W035: modalità di cancellazione dei messaggi inviati e letti
        I091DatiEnteItems.AddItem('N'); // non prevista
        I091DatiEnteItems.AddItem('A'); // cancella solo gli allegati
        I091DatiEnteItems.AddItem('T'); // cancella tutto (messaggio + allegati)
      end
      else if DatiEnte[i].Lista = 'C11_MODORA_PUNTNOM' then
      begin
        I091DatiEnteItems.AddItem('MODELLO ORARIO');
        I091DatiEnteItems.AddItem('PUNTI NOMINALI');
      end
      else if DatiEnte[i].Lista = 'C11_OPE_NOOPE' then
      begin
        {Se il tipo pianificazione è progressiva disabilito la possibilità
        di selezionare la gestione assenze operativa
        {Bruno 07/05/2014 -  if VarToStr(A008FOperatoriDtM1.QI091.Lookup('TIPO','C11_PIANIFORARIPROG','DATO')) = 'N' then}
        I091DatiEnteItems.AddItem('OPERATIVA');
        I091DatiEnteItems.AddItem('NON OPERATIVA');
      end
      else if DatiEnte[i].Lista = 'C11_NO_SOVR_AGG' then
      begin
        I091DatiEnteItems.AddItem('NO');
        I091DatiEnteItems.AddItem('SOVRASCRIVI');
        I091DatiEnteItems.AddItem('AGGIUNGI');
      end
      else if DatiEnte[i].Lista = 'C90_AUTENTICAZIONI' then
      begin
        I091DatiEnteItems.AddItem('No autenticazione');
        I091DatiEnteItems.AddItem('TLSv1');
        I091DatiEnteItems.AddItem('TLSv1_1');
        I091DatiEnteItems.AddItem('TLSv1_2');
        I091DatiEnteItems.AddItem('SSLv2');
        I091DatiEnteItems.AddItem('SSLv23');
        I091DatiEnteItems.AddItem('SSLv3');
      end
      else if DatiEnte[i].Lista = 'C90_USETLS' then
      begin
        I091DatiEnteItems.AddItem('NO');
        I091DatiEnteItems.AddItem('IMPLICIT');
        I091DatiEnteItems.AddItem('EXPLICIT');
        I091DatiEnteItems.AddItem('REQUIRE');
      end
      else if DatiEnte[i].Lista = 'C3_INDPRES' then
        with QI091 do
        begin
          if VarToStr(Lookup('Tipo','C3_INDPRES','Dato')) <> '' then
            I091DatiEnteItems.AddItem(VarToStr(Lookup('Tipo','C3_INDPRES','Dato')));
          if VarToStr(Lookup('Tipo','C3_INDPRES2','Dato')) <> '' then
            I091DatiEnteItems.AddItem(VarToStr(Lookup('Tipo','C3_INDPRES2','Dato')));
        end
      else if (DatiEnte[i].Lista = 'T430') or (DatiEnte[i].Lista = 'T430_MULTI') then
      begin
        QCols.First;
        while not QCols.Eof do
        begin
          I091DatiEnteItems.AddItem(QCols.FieldByName('COLUMN_NAME').AsString);
          QCols.Next;
        end;
        I091DatiEnteItems.MultiSelect:=(DatiEnte[i].Lista = 'T430_MULTI'); // nuovo 27.06.2012
        //A008FListaGriglia.Lista.ExtendedSelect:=A008FListaGriglia.Lista.MultiSelect;
      end
      else if (DatiEnte[i].Lista = 'C29_CHIAMATEREP_DATIVIS') or (DatiEnte[i].Lista = 'C29_CHIAMATEREP_DATIVIS_MULTI') then
      begin
        LstDati:=TStringList.Create;
        selI091Dato.SetVariable('AZIENDA', QI090.FieldByName('AZIENDA').AsString);
        selI091Dato.SetVariable('TIPO',IfThen(DatiEnte[i].Lista.IndexOf('_MULTI') > 0, DatiEnte[i].Lista.Substring(0,DatiEnte[i].Lista.Length-6),DatiEnte[i].Lista));
        selI091Dato.Execute;
        LstDati.CommaText:=selI091Dato.FieldAsString(0);
        for j:=0 to LstDati.Count-1 do
          I091DatiEnteItems.AddItem(LstDati.Strings[j]);
        I091DatiEnteItems.MultiSelect:=(DatiEnte[i].Lista = 'C29_CHIAMATEREP_DATIVIS_MULTI');
        FreeAndNil(LstDati);
      end
      else if DatiEnte[i].Lista = 'T265' then
      begin
        // sfrutta la query selDizionario per estrarre l'elenco delle causali di assenza
        with selDizionario do
        begin
          Filtered:=False;
          Filter:='TABELLA = ''CAUSALI ASSENZA''';
          Filtered:=True;
          First;
          I091DatiEnteItems.AddItem('');
          while not Eof do
          begin
            I091DatiEnteItems.AddItem(FieldByName('CODICE').AsString);
            Next;
          end;
        end;
      end
      else if DatiEnte[i].Lista = 'T275' then
      begin
        // sfrutta la query selDizionario per estrarre l'elenco delle causali di presenza
        with selDizionario do
        begin
          Filtered:=False;
          Filter:='TABELLA = ''CAUSALI PRESENZA''';
          Filtered:=True;
          First;
          I091DatiEnteItems.AddItem('');
          while not Eof do
          begin
            I091DatiEnteItems.AddItem(FieldByName('CODICE').AsString);
            Next;
          end;
        end;
      end
      else if DatiEnte[i].Lista = 'R502ANM' then
      begin
        I091DatiEnteItems.MultiSelect:=True;
        I091DatiEnteItems.DimCodice:=4;
        for j:=Low(R500Lin.tdescanom2) to High(R500Lin.tdescanom2) do
        begin
          I091DatiEnteItems.AddItem(R180DimLung('2_' + IntToStr(R500Lin.tdescanom2[j].N),5) + ' ' + R500Lin.tdescanom2[j].D);
        end;
        for j:=Low(R500Lin.tdescanom3) to High(R500Lin.tdescanom3) do
        begin
          I091DatiEnteItems.AddItem(R180DimLung('3_' + IntToStr(R500Lin.tdescanom3[j].N),5) + ' ' + R500Lin.tdescanom3[j].D);
        end;
      end
      else if DatiEnte[i].Lista = 'R600ANM' then
      begin
        I091DatiEnteItems.MultiSelect:=True;
        I091DatiEnteItems.DimCodice:=5;
        for j:=Low(R600.constMessaggi) to High(R600.constMessaggi) do
        begin
          I091DatiEnteItems.AddItem(Format('%-5s %s',[j.ToString,R600.constMessaggi[j]]));
        end;
      end
      else if DatiEnte[i].Lista = 'NOF' then
      begin
        I091DatiEnteItems.AddItem('N');
        I091DatiEnteItems.AddItem('O');
        I091DatiEnteItems.AddItem('F');
      end
      else if DatiEnte[i].Lista = 'SSO' then
      begin
        I091DatiEnteItems.AddItem('nessuno');
        I091DatiEnteItems.AddItem('MEDP');
        I091DatiEnteItems.AddItem('OAUTH2');
        I091DatiEnteItems.AddItem('RDL');
        I091DatiEnteItems.AddItem('SHA1');
      end
      else if DatiEnte[i].Lista = 'SG220' then
      begin
        I091DatiEnteItems.AddItem('DATA_ISCRIZIONE');
        I091DatiEnteItems.AddItem('EMAIL_PEC');
        I091DatiEnteItems.MultiSelect:=True;
      end
      else if DatiEnte[i].Lista = 'EUT' then
      begin
        I091DatiEnteItems.AddItem('E');
        I091DatiEnteItems.AddItem('U');
        I091DatiEnteItems.AddItem('EU');
        I091DatiEnteItems.AddItem('T');
      end
      else
      begin
        for j:=1 to Length(DatiEnte[i].Lista) do
          I091DatiEnteItems.AddItem(DatiEnte[i].Lista[j]);
      end;
      I091DatiEnteItems.EndUpdate;
      Break;
    end;
  end;
end;

function TA181FAziendeMW.GetDatoEnte(const PAzienda, PTipo:String):String;
// estrae il valore del parametro aziendale indicato per l'azienda specificata
begin
  R180SetVariable(QI091,'AZIENDA',PAzienda);
  QI091.Open;
  Result:=VarToStr(QI091.Lookup('Tipo',PTipo,'Dato'));
end;

procedure TA181FAziendeMW.PutDatiEnte(Azienda:String);
var
  i:Integer;
begin
  for i:=1 to High(DatiEnte) do
  begin
    insI091.SetVariable('AZIENDA',Azienda);
    insI091.SetVariable('ORDINE',i);
    insI091.SetVariable('TIPO',DatiEnte[i].Nome);
    try
      insI091.Execute;
    except
    end;
  end;
  SessioneOracle.Commit;
end;

procedure TA181FAziendeMW.AggiornaDatiEnte;
var i:Integer;
begin
  QI090.DisableControls;
  QI091.Filtered:=False;

  //modifica ordinamento dei dati esistenti
  with TOracleQuery.Create(nil) do
  try
    Session:=SessioneOracle;
    SQL.Add('begin');
    for i:=1 to High(DatiEnte) do
      SQL.Add(Format('update MONDOEDP.I091_DATIENTE set ORDINE = %d where TIPO = ''%s'' and nvl(ORDINE,-1) <> %d;',[i,DatiEnte[i].Nome,i]));
    SQL.Add('end;');
    Execute;
  finally
    Free;
    SessioneOracle.Commit;
  end;

  //inserimento nuovi dati
  QI090.First;
  while not QI090.Eof do
  try
    QI091.Close;
    QI091.SetVariable('AZIENDA',QI090.FieldByName('AZIENDA').AsString);
    QI091.Open;
    for i:=1 to High(DatiEnte) do
    begin
      if not QI091.Locate('TIPO',DatiEnte[i].Nome,[]) then
      begin
        insI091.SetVariable('AZIENDA',QI090.FieldByName('AZIENDA').AsString);
        insI091.SetVariable('ORDINE',i);
        insI091.SetVariable('TIPO',DatiEnte[i].Nome);
        try
          insI091.Execute;
        except
        end;
      end
      //Gestiona particolare della pwd per PerlaPA, dopo l'importazione automatica da T001
      else if (DatiEnte[i].Nome = 'C40_WEBSRV_PWD') then
        if (Pos('<NOCRYPT:>',QI091.FieldByName('DATO').AsString)) > 0 then
        begin
          QI091.Edit;
          QI091.FieldByName('DATO').Text:=StringReplace(QI091.FieldByName('DATO').AsString,'<NOCRYPT:>','',[rfReplaceAll,rfIgnoreCase]);
          QI091.Post;
        end;
    end;
  finally
    SessioneOracle.Commit;
    QI090.Next;
  end;
  QI091.Close;
  QI090.First;
  QI090.EnableControls;
end;

procedure TA181FAziendeMW.PutParametri;
begin
  Parametri.RegolePassword.PasswordI060:=Parametri.ProfiloWEB <> '';
  Parametri.RegolePassword.Lunghezza:=QI090.FieldByName('Lung_Password').AsInteger;
  Parametri.RegolePassword.MesiValidita:=QI090.FieldByName('Valid_Password').AsInteger;
  Parametri.RegolePassword.Cifre:=QI090.FieldByName('Password_Cifre').AsInteger;
  Parametri.RegolePassword.Maiuscole:=QI090.FieldByName('Password_Maiuscole').AsInteger;
  Parametri.RegolePassword.CarSpeciali:=QI090.FieldByName('Password_CarSpeciali').AsInteger;

  Parametri.TimbOrig_Verso:=QI090.FieldByName('TimbOrig_Verso').AsString;
  Parametri.TimbOrig_Causale:=QI090.FieldByName('TimbOrig_Causale').AsString;
  Parametri.LunghezzaPassword:=QI090.FieldByName('Lung_Password').AsInteger;
  Parametri.ValiditaPassword:=QI090.FieldByName('Valid_Password').AsInteger;
  Parametri.ValiditaUtente:=QI090.FieldByName('Valid_Utente').AsInteger;

  Parametri.CampiRiferimento.C1_CedoliniConValuta:=VarToStr(QI091.Lookup('Tipo','C1_CEDOLINICONVALUTA','Dato'));
  Parametri.CampiRiferimento.C2_Budget:=VarToStr(QI091.Lookup('Tipo','C2_BUDGET','Dato'));
  Parametri.CampiRiferimento.C2_Capitolo:=VarToStr(QI091.Lookup('Tipo','C2_CAPITOLO','Dato'));
  Parametri.CampiRiferimento.C2_Articolo:=VarToStr(QI091.Lookup('Tipo','C2_ARTICOLO','Dato'));
  Parametri.CampiRiferimento.C2_Costo_Orario:=VarToStr(QI091.Lookup('Tipo','C2_COSTO_ORARIO','Dato'));
  Parametri.CampiRiferimento.C2_Websrv_Bilancio:=VarToStr(QI091.Lookup('Tipo','C2_WEBSRV_BILANCIO','Dato'));
  Parametri.CampiRiferimento.C2_Livello:=VarToStr(QI091.Lookup('Tipo','C2_LIVELLO','Dato'));
  Parametri.CampiRiferimento.C2_Facoltativo:=VarToStr(QI091.Lookup('Tipo','C2_FACOLTATIVO','Dato'));
  Parametri.CampiRiferimento.C3_IndPres:=VarToStr(QI091.Lookup('Tipo','C3_INDPRES','Dato'));
  Parametri.CampiRiferimento.C3_IndPres2:=VarToStr(QI091.Lookup('Tipo','C3_INDPRES2','Dato'));
  Parametri.CampiRiferimento.C3_DatoPianificabile:=VarToStr(QI091.Lookup('Tipo','C3_DATOPIANIFICABILE','Dato'));
  Parametri.CampiRiferimento.C3_RiepTurni_IndPres:=VarToStr(QI091.Lookup('Tipo','C3_RIEPTURNI_INDPRES','Dato'));
  Parametri.CampiRiferimento.C3_DettGG_TipoI:=VarToStr(QI091.Lookup('Tipo','C3_DETTGG_TIPOI','Dato'));
  Parametri.CampiRiferimento.C4_BuoniMensa:=VarToStr(QI091.Lookup('Tipo','C4_BUONIMENSA','Dato'));
  Parametri.CampiRiferimento.C5_IntegrazAnag:=VarToStr(QI091.Lookup('Tipo','C5_INTEGRAZANAG','Dato'));
  Parametri.CampiRiferimento.C5_Office:=VarToStr(QI091.Lookup('Tipo','C5_OFFICE','Dato'));
  Parametri.CampiRiferimento.C6_InizioProva:=VarToStr(QI091.Lookup('Tipo','C6_INIZIOPROVA','Dato'));
  Parametri.CampiRiferimento.C6_DurataProva:=VarToStr(QI091.Lookup('Tipo','C6_DURATAPROVA','Dato'));
  Parametri.CampiRiferimento.C7_DATO1:=VarToStr(QI091.Lookup('Tipo','C7_DATO1','Dato'));
  Parametri.CampiRiferimento.C7_DATO2:=VarToStr(QI091.Lookup('Tipo','C7_DATO2','Dato'));
  Parametri.CampiRiferimento.C7_DATO3:=VarToStr(QI091.Lookup('Tipo','C7_DATO3','Dato'));
  Parametri.CampiRiferimento.C7_InizioSospensione:=VarToStr(QI091.Lookup('Tipo','C7_INIZIO_SOSPENSIONE','Dato'));
  Parametri.CampiRiferimento.C7_EscludeIncentivo:=VarToStr(QI091.Lookup('Tipo','C7_ESCLUDE_INCENTIVO','Dato'));
  Parametri.CampiRiferimento.C8_Missione:=VarToStr(QI091.Lookup('Tipo','C8_MISSIONE','Dato'));
  Parametri.CampiRiferimento.C8_MissioneCommessa:=VarToStr(QI091.Lookup('Tipo','C8_MISSIONECOMMESSA','Dato'));
  Parametri.CampiRiferimento.C8_Sede:=VarToStr(QI091.Lookup('Tipo','C8_SEDE','Dato'));
  Parametri.CampiRiferimento.C8_GestioneMensile:=VarToStr(QI091.Lookup('Tipo','C8_GESTIONEMENSILE','Dato'));
  Parametri.CampiRiferimento.C8_W032RichiediTipoMissione:=VarToStr(QI091.Lookup('Tipo','C8_W032_RICHIEDI_TIPOMISSIONE','Dato'));
  Parametri.CampiRiferimento.C8_W032DettaglioGG:=VarToStr(QI091.Lookup('Tipo','C8_W032_DETTAGLIOGG','Dato'));
  Parametri.CampiRiferimento.C8_W032DocumentoMissioni:=VarToStr(QI091.Lookup('Tipo','C8_W032_DOCUMENTO_MISSIONI','Dato'));
  Parametri.CampiRiferimento.C8_W032RimborsiDett:=VarToStr(QI091.Lookup('Tipo','C8_W032_RIMBORSIDETT','Dato'));
  Parametri.CampiRiferimento.C8_W032RiapriMissione:=VarToStr(QI091.Lookup('Tipo','C8_W032_RIAPRI_MISSIONE','Dato'));
  Parametri.CampiRiferimento.C8_W032TappeSoloSuDistanziometro:=VarToStr(QI091.Lookup('Tipo','C8_W032_TAPPE_SOLO_SU_DISTANZIOMETRO','Dato'));
  Parametri.CampiRiferimento.C8_W032MessaggioTappeInesistenti:=VarToStr(QI091.Lookup('Tipo','C8_W032_MESSAGGIO_TAPPE_INESISTENTI','Dato'));
  Parametri.CampiRiferimento.C8_W032CheckPercorso:=VarToStr(QI091.Lookup('Tipo','C8_W032_CHECK_PERCORSO','Dato'));
  Parametri.CampiRiferimento.C8_W032BloccaDate:=VarToStr(QI091.Lookup('Tipo','C8_W032_BLOCCA_DATE','Dato'));
  Parametri.CampiRiferimento.C9_ScaricoPaghe:=VarToStr(QI091.Lookup('Tipo','C9_SCARICOPAGHE','Dato'));
  Parametri.CampiRiferimento.C10_FormazioneProfiloCrediti:=VarToStr(QI091.Lookup('Tipo','C10_FORMAZPROFCRED','Dato'));
  Parametri.CampiRiferimento.C10_FormazioneProfiloCorso:=VarToStr(QI091.Lookup('Tipo','C10_FORMAZPROFCORSO','Dato'));
  Parametri.CampiRiferimento.C11_PianifOrariProg:=VarToStr(QI091.Lookup('Tipo','C11_PIANIFORARIPROG','Dato'));
  Parametri.CampiRiferimento.C11_PianifOrari_DebGG:=VarToStr(QI091.Lookup('Tipo','C11_PIANIFORARI_DEBGG','Dato'));
  Parametri.CampiRiferimento.C11_PianifOrari_No_CopiaGiustif:=VarToStr(QI091.Lookup('Tipo','C11_PIANIFORARI_NO_COPIAGIUSTIF','Dato'));
  Parametri.CampiRiferimento.C12_PreferenzeDestinazione:=VarToStr(QI091.Lookup('Tipo','C12_PREFERENZADEST','Dato'));
  Parametri.CampiRiferimento.C12_PreferenzeCompetenza:=VarToStr(QI091.Lookup('Tipo','C12_PREFERENZACOMP','Dato'));
  Parametri.CampiRiferimento.C13_CdcPercentualizzati:=VarToStr(QI091.Lookup('Tipo','C13_CDC_PERCENT','Dato'));
  Parametri.CampiRiferimento.C13_CdcPersConv:=VarToStr(QI091.Lookup('Tipo','C13_CDC_PERSCONV','Dato'));
  Parametri.CampiRiferimento.C14_ProvvSede:=VarToStr(QI091.Lookup('Tipo','C14_PROVVSEDE','Dato'));
  Parametri.CampiRiferimento.C15_LimitiMensCaus:=VarToStr(QI091.Lookup('Tipo','C15_LIMITIMENSCAUS','Dato'));
  Parametri.CampiRiferimento.C16_InsRiposi:=VarToStr(QI091.Lookup('Tipo','C16_INSRIPOSI','Dato'));
  Parametri.CampiRiferimento.C17_PostiLetto:=VarToStr(QI091.Lookup('Tipo','C17_POSTILETTO','Dato'));
  Parametri.CampiRiferimento.C18_AccessiMensa:=VarToStr(QI091.Lookup('Tipo','C18_ACCESSIMENSA','Dato'));
  Parametri.CampiRiferimento.C20_IncaricoUnitaOrg:=VarToStr(QI091.Lookup('Tipo','C20_INCARICOUNITAORG','Dato'));
  Parametri.CampiRiferimento.C21_ValutazioniLiv1:=VarToStr(QI091.Lookup('Tipo','C21_VALUTAZIONI_LIV1','Dato'));
  Parametri.CampiRiferimento.C21_ValutazioniLiv2:=VarToStr(QI091.Lookup('Tipo','C21_VALUTAZIONI_LIV2','Dato'));
  Parametri.CampiRiferimento.C21_ValutazioniLiv3:=VarToStr(QI091.Lookup('Tipo','C21_VALUTAZIONI_LIV3','Dato'));
  Parametri.CampiRiferimento.C21_ValutazioniLiv4:=VarToStr(QI091.Lookup('Tipo','C21_VALUTAZIONI_LIV4','Dato'));
  Parametri.CampiRiferimento.C21_ValutazioniRsp1:=VarToStr(QI091.Lookup('Tipo','C21_VALUTAZIONI_RSP1','Dato'));
  Parametri.CampiRiferimento.C21_ValutazioniRsp2:=VarToStr(QI091.Lookup('Tipo','C21_VALUTAZIONI_RSP2','Dato'));
  Parametri.CampiRiferimento.C21_ValutazioniPnt1:=VarToStr(QI091.Lookup('Tipo','C21_VALUTAZIONI_PNT1','Dato'));
  Parametri.CampiRiferimento.C21_EMailDestIndirizzo:=VarToStr(QI091.Lookup('Tipo','C21_EMAIL_DEST_INDIRIZZO','Dato'));

  Parametri.CampiRiferimento.C22_EnteGiuridico:=VarToStr(QI091.Lookup('Tipo','C22_ENTE_GIURIDICO','Dato'));
  Parametri.CampiRiferimento.C22_InizioRapGiuridico:=VarToStr(QI091.Lookup('Tipo','C22_INIZIO_RAP_GIURIDICO','Dato'));
  Parametri.CampiRiferimento.C22_FineRapGiuridico:=VarToStr(QI091.Lookup('Tipo','C22_FINE_RAP_GIURIDICO','Dato'));
  Parametri.CampiRiferimento.C22_QualificaGiuridico:=VarToStr(QI091.Lookup('Tipo','C22_QUALIFICA_GIURIDICO','Dato'));
  Parametri.CampiRiferimento.C22_DisciplinaGiuridico:=VarToStr(QI091.Lookup('Tipo','C22_DISCIPLINA_GIURIDICO','Dato'));

  Parametri.CampiRiferimento.C23_ContrCompetenze:=VarToStr(QI091.Lookup('Tipo','C23_CONTR_COMPETENZE','Dato'));
  Parametri.CampiRiferimento.C23_InsNegCatena:=VarToStr(QI091.Lookup('Tipo','C23_INSNEG_CATENA','Dato'));
  Parametri.CampiRiferimento.C23_VMHFruizGG:=VarToStr(QI091.Lookup('Tipo','C23_VMH_FRUIZGG','Dato'));
  Parametri.CampiRiferimento.C23_VMHCumuloTriennio:=VarToStr(QI091.Lookup('Tipo','C23_VMH_CUMULO_TRIENNIO','Dato'));
  Parametri.CampiRiferimento.C24_AziendaTipoBudget:=VarToStr(QI091.Lookup('Tipo','C24_AZIENDABUDGET','Dato'));
  Parametri.CampiRiferimento.C25_TimbIrr_Auto:=VarToStr(QI091.Lookup('Tipo','C25_TIMBIRR_AUTO','Dato'));
  Parametri.CampiRiferimento.C26_V430Materializzata:=VarToStr(QI091.Lookup('Tipo','C26_V430MATERIALIZZATA','Dato'));
  Parametri.CampiRiferimento.C27_TablespaceFree:=VarToStr(QI091.Lookup('Tipo','C27_TABLESPACE_FREE','Dato'));
  Parametri.CampiRiferimento.C28_CancellaAnnoLog:=VarToStr(QI091.Lookup('Tipo','C28_CANCELLA_ANNO_LOG','Dato'));
  Parametri.CampiRiferimento.C29_ChiamateRepFiltro1:=VarToStr(QI091.Lookup('Tipo','C29_CHIAMATEREP_FILTRO1','Dato'));
  Parametri.CampiRiferimento.C29_ChiamateRepFiltro2:=VarToStr(QI091.Lookup('Tipo','C29_CHIAMATEREP_FILTRO2','Dato'));
  Parametri.CampiRiferimento.C29_ChiamateRepDatiVis:=VarToStr(QI091.Lookup('Tipo','C29_CHIAMATEREP_DATIVIS','Dato'));
  // dati modificabili solo se esistono dati visualizzati
  if Parametri.CampiRiferimento.C29_ChiamateRepDatiVis <> '' then
    Parametri.CampiRiferimento.C29_ChiamateRepDatiModif:=VarToStr(QI091.Lookup('Tipo','C29_CHIAMATEREP_DATIMODIF','Dato'));
  Parametri.CampiRiferimento.C29_W043_ModReperNumGiorni:=VarToStr(QI091.Lookup('Tipo','C29_W043_MODREPER_NUMGIORNI','Dato'));
  Parametri.CampiRiferimento.C29_W043_ModReperOraCutOff:=VarToStr(QI091.Lookup('Tipo','C29_W043_MODREPER_ORA_CUTOFF','Dato'));
  Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1:=VarToStr(QI091.Lookup('Tipo','C29_CHIAMATEREP_DATOAGG1','Dato'));
  Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2:=VarToStr(QI091.Lookup('Tipo','C29_CHIAMATEREP_DATOAGG2','Dato'));
  Parametri.CampiRiferimento.C29_ChiamateRepDatoMod:=VarToStr(QI091.Lookup('Tipo','C29_CHIAMATEREP_DATOMOD','Dato'));
  Parametri.CampiRiferimento.C30_WebSrv_B021_URL:=VarToStr(QI091.Lookup('Tipo','C30_WEBSRV_B021_URL','Dato'));
  Parametri.CampiRiferimento.C30_WebSrv_A004_URL:=VarToStr(QI091.Lookup('Tipo','C30_WEBSRV_A004_URL','Dato'));
  Parametri.CampiRiferimento.C30_WebSrv_A004_Dati:=VarToStr(QI091.Lookup('Tipo','C30_WEBSRV_A004_DATI','Dato'));
  Parametri.CampiRiferimento.C30_WebSrv_A025_URL_GET:=VarToStr(QI091.Lookup('Tipo','C30_WEBSRV_A025_URL_GET','Dato'));
  Parametri.CampiRiferimento.C30_WebSrv_A025_URL_PUT:=VarToStr(QI091.Lookup('Tipo','C30_WEBSRV_A025_URL_PUT','Dato'));
  Parametri.CampiRiferimento.C30_WebSrv_B021_TOKEN:=VarToStr(QI091.Lookup('Tipo','C30_WEBSRV_B021_TOKEN','Dato'));
  Parametri.CampiRiferimento.C30_WebSrv_B021_PASSPHRASE:=R180Decripta(VarToStr(QI091.Lookup('Tipo','C30_WEBSRV_B021_PASSPHRASE','Dato')),I091CryptKey);
  Parametri.CampiRiferimento.C30_WebSrv_B021_TIMEOUT:=VarToStr(QI091.Lookup('Tipo','C30_WEBSRV_B021_TIMEOUT','Dato'));
  Parametri.CampiRiferimento.C30_WebSrv_X004_URL:=VarToStr(QI091.Lookup('Tipo','C30_WEBSRV_X004_URL','Dato'));
  Parametri.CampiRiferimento.C31_NoteGiustificativi:=VarToStr(QI091.Lookup('Tipo','C31_NOTEGIUSTIFICATIVI','Dato'));
  Parametri.CampiRiferimento.C32_CheckAggSchedaAbil:=VarToStr(QI091.Lookup('Tipo','C32_CHECK_AGGSCHEDA_ABIL','Dato'));
  Parametri.CampiRiferimento.C32_ScriptAggSchedaAfter:=VarToStr(QI091.Lookup('Tipo','C32_SCRIPT_AGGSCHEDA_AFTER','Dato'));
  Parametri.CampiRiferimento.C32_SaldoMeseCompensato:=VarToStr(QI091.Lookup('Tipo','C32_SALDO_MESE_COMPENSATO','Dato'));
  Parametri.CampiRiferimento.C33_Link_I070_T030:=VarToStr(QI091.Lookup('Tipo','C33_LINK_I070_T030','Dato'));
  Parametri.CampiRiferimento.C33_ProxyServer:=VarToStr(QI091.Lookup('Tipo','C33_PROXY_SERVER','Dato'));
  Parametri.CampiRiferimento.C33_ProxyUser:=VarToStr(QI091.Lookup('Tipo','C33_PROXY_USER','Dato'));
  Parametri.CampiRiferimento.C33_ProxyPassword:=R180Decripta(VarToStr(QI091.Lookup('Tipo','C33_PROXY_PASSWORD','Dato')),I091CryptKey);
  Parametri.CampiRiferimento.C34_CriptaSingoliCedolini:=VarToStr(QI091.Lookup('Tipo','C34_CRIPTA_SINGOLI_CEDOLINI','Dato'));
  Parametri.CampiRiferimento.C35_ResiduiTriggerBefore:=VarToStr(QI091.Lookup('Tipo','C35_RESIDUI_TRIGGER_BEFORE','Dato'));
  Parametri.CampiRiferimento.C35_ResiduiTriggerAfter:=VarToStr(QI091.Lookup('Tipo','C35_RESIDUI_TRIGGER_AFTER','Dato'));
  Parametri.CampiRiferimento.C36_OrdProfSanCodice:=VarToStr(QI091.Lookup('Tipo','C36_ORDPROFSAN_CODICE','Dato'));
  Parametri.CampiRiferimento.C36_OrdProfSanEmailVar:=VarToStr(QI091.Lookup('Tipo','C36_ORDPROFSAN_EMAIL_VAR','Dato'));
  Parametri.CampiRiferimento.C40_WebSrv_User:=VarToStr(QI091.Lookup('Tipo','C40_WEBSRV_USER','Dato'));
  Parametri.CampiRiferimento.C40_WebSrv_Pwd:=R180Decripta(VarToStr(QI091.Lookup('Tipo','C40_WEBSRV_PWD','Dato')),I091CryptKey);
  Parametri.CampiRiferimento.C40_EnteL104:=VarToStr(QI091.Lookup('Tipo','C40_ENTEL104','Dato'));
  Parametri.CampiRiferimento.C40_WebSrv_URLL104:=VarToStr(QI091.Lookup('Tipo','C40_WEBSRV_URLL104','Dato'));
  Parametri.CampiRiferimento.C40_EnteGedap:=VarToStr(QI091.Lookup('Tipo','C40_ENTEGEDAP','Dato'));
  Parametri.CampiRiferimento.C40_WebSrv_URLGedap:=VarToStr(QI091.Lookup('Tipo','C40_WEBSRV_URLGEDAP','Dato'));
  Parametri.CampiRiferimento.C40_InvioGedap:=VarToStr(QI091.Lookup('Tipo','C40_INVIOGEDAP','Dato'));
  Parametri.CampiRiferimento.C40_Qualifica:=VarToStr(QI091.Lookup('Tipo','C40_QUALIFICA','Dato'));
  Parametri.CampiRiferimento.C40_DistaccoSede_ComuneDef:=VarToStr(QI091.Lookup('Tipo','C40_DISTACCOSEDE_COMUNEDEF','Dato'));
  Parametri.CampiRiferimento.C40_DistaccoSede_Comune:=VarToStr(QI091.Lookup('Tipo','C40_DISTACCOSEDE_COMUNE','Dato'));
  Parametri.CampiRiferimento.C40_DistaccoSede_Indirizzo:=VarToStr(QI091.Lookup('Tipo','C40_DISTACCOSEDE_INDIRIZZO','Dato'));
  Parametri.CampiRiferimento.C90_WebAutorizCurric:=VarToStr(QI091.Lookup('Tipo','C90_WEBAUTORIZCURRIC','Dato'));
  Parametri.CampiRiferimento.C90_EMailW010Uff:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_W010UFF','Dato'));
  Parametri.CampiRiferimento.C90_EMailW018Uff:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_W018UFF','Dato'));
  Parametri.CampiRiferimento.C90_EMailSMTPHost:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_SMTPHOST','Dato'));
  Parametri.CampiRiferimento.C90_EMailUserName:=VarToStr(QI091.LookUp('Tipo','C90_EMAIL_USERNAME','Dato'));
  Parametri.CampiRiferimento.C90_EMailHeloName:=VarToStr(QI091.LookUp('Tipo','C90_EMAIL_HELONAME','Dato'));
  Parametri.CampiRiferimento.C90_EMailPassWord:=R180Decripta(VarToStr(QI091.LookUp('Tipo','C90_EMAIL_PASSWORD','Dato')),I091CryptKey);
  Parametri.CampiRiferimento.C90_EMailPort:=VarToStr(QI091.LookUp('Tipo','C90_EMAIL_PORT','Dato'));
  Parametri.CampiRiferimento.C90_EMailRespOttimizzata:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_RESP_OTTIMIZZATA','Dato'));
  Parametri.CampiRiferimento.C90_EMailRespGGReinvio:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_RESP_GG_REINVIO','Dato'));
  Parametri.CampiRiferimento.C90_EMailRespOggetto:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_RESP_OGGETTO','Dato'));
  Parametri.CampiRiferimento.C90_EMailRespTesto:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_RESP_TESTO','Dato'));
  Parametri.CampiRiferimento.C90_EMailSenderIndirizzo:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_SENDER_INDIRIZZO','Dato'));
  Parametri.CampiRiferimento.C90_EMailSender:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_SENDER','Dato'));
  Parametri.CampiRiferimento.C90_WebRighePag:=VarToStr(QI091.Lookup('Tipo','C90_WEBRIGHEPAG','Dato'));
  Parametri.CampiRiferimento.C90_WebTipoCambioOrario:=VarToStr(QI091.Lookup('Tipo','C90_WEBTIPOCAMBIOORARIO','Dato'));
  Parametri.CampiRiferimento.C90_WebSettCambioOrario:=VarToStr(QI091.Lookup('Tipo','C90_WEBSETTCAMBIOORARIO','Dato'));
  Parametri.CampiRiferimento.C90_W024MMIndietro:=VarToStr(QI091.Lookup('Tipo','C90_W024MMINDIETRO','Dato'));
  Parametri.CampiRiferimento.C90_W024MMIndietroRitardo:=VarToStr(QI091.Lookup('Tipo','C90_W024MMINDIETRORITARDO','Dato'));
  Parametri.CampiRiferimento.C90_W026CausE:=VarToStr(QI091.Lookup('Tipo','C90_W026CAUS_E','Dato'));
  Parametri.CampiRiferimento.C90_W026CausU:=VarToStr(QI091.Lookup('Tipo','C90_W026CAUS_U','Dato'));
  Parametri.CampiRiferimento.C90_W005Settimane:=VarToStr(QI091.Lookup('Tipo','C90_W005SETTIMANE','Dato'));
  Parametri.CampiRiferimento.C90_W026TipoRichiesta:=VarToStr(QI091.Lookup('Tipo','C90_W026TIPO_RICHIESTA','Dato'));
  Parametri.CampiRiferimento.C90_W026Spezzoni:=VarToStr(QI091.Lookup('Tipo','C90_W026SPEZZONI','Dato'));
  Parametri.CampiRiferimento.C90_W026IncludiSpezzoniFuoriOrario:=VarToStr(QI091.Lookup('Tipo','C90_W026INCLUDISPEZZONIFUORIORARIO','Dato'));
  Parametri.CampiRiferimento.C90_W026TipoAutorizzazione:=VarToStr(QI091.Lookup('Tipo','C90_W026TIPO_AUTORIZZAZIONE','Dato'));
  Parametri.CampiRiferimento.C90_W026TipoStraord:=VarToStr(QI091.Lookup('Tipo','C90_W026TIPO_STRAORD','Dato'));
  Parametri.CampiRiferimento.C90_W026UtilizzoDal:=VarToStr(QI091.Lookup('Tipo','C90_W026UTILIZZO_DAL','Dato'));
  Parametri.CampiRiferimento.C90_W026UtilizzoAl:=VarToStr(QI091.Lookup('Tipo','C90_W026UTILIZZO_AL','Dato'));
  Parametri.CampiRiferimento.C90_W026EccedGGTutta:=VarToStr(QI091.Lookup('Tipo','C90_W026ECCEDGG_TUTTA','Dato'));
  Parametri.CampiRiferimento.C90_W026CheckSaldoDisponibile:=VarToStr(QI091.Lookup('Tipo','C90_W026CHECKSALDODISPONIBILE','Dato'));
  Parametri.CampiRiferimento.C90_W026DatiInvisibili:=VarToStr(QI091.Lookup('Tipo','C90_W026DATIINVISIBILI','Dato'));
  Parametri.CampiRiferimento.C90_W026AutorizzObbl:=VarToStr(QI091.Lookup('Tipo','C90_W026AUTORIZZ_OBBL','Dato'));
  Parametri.CampiRiferimento.C90_W026CausAbbattGiustAss:=VarToStr(QI091.Lookup('Tipo','C90_W026CAUSABBATT_GIUSTASS','Dato'));
  Parametri.CampiRiferimento.C90_W026AccorpaSpezzoni:=VarToStr(QI091.Lookup('Tipo','C90_W026ACCORPA_SPEZZONI','Dato'));
  Parametri.CampiRiferimento.C90_W026PianifForzata:=VarToStr(QI091.Lookup('Tipo','C90_W026PIANIF_FORZATA','Dato'));
  Parametri.CampiRiferimento.C90_W026ConfermaAutorizzazioni:=VarToStr(QI091.Lookup('Tipo','C90_W026CONFERMA_AUTORIZZAZIONI','Dato'));
  Parametri.CampiRiferimento.C90_NomeProfiloDelega:=VarToStr(QI091.Lookup('Tipo','C90_NOMEPROFILODELEGA','Dato'));
  Parametri.CampiRiferimento.C90_EmailThread:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_THREAD','Dato'));
  Parametri.CampiRiferimento.C90_EMailAuthType:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_AUTHTYPE','Dato'));
  Parametri.CampiRiferimento.C90_EMailUseTLS:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_USETLS','Dato'));
  Parametri.CampiRiferimento.C90_Lingua:=VarToStr(QI091.Lookup('Tipo','C90_LINGUA','Dato')); //***
  Parametri.CampiRiferimento.C90_W010AcquisizioneAuto:=VarToStr(QI091.Lookup('Tipo','C90_W010ACQUISIZIONE_AUTO','Dato'));
  Parametri.CampiRiferimento.C90_W018AcquisizioneAuto:=VarToStr(QI091.Lookup('Tipo','C90_W018ACQUISIZIONE_AUTO','Dato'));
  Parametri.CampiRiferimento.C90_FiltroDeleghe:=VarToStr(QI091.Lookup('Tipo','C90_FILTRO_DELEGHE','Dato'));
  Parametri.CampiRiferimento.C90_CronologiaNote:=VarToStr(QI091.Lookup('Tipo','C90_CRONOLOGIA_NOTE','Dato'));
  Parametri.CampiRiferimento.C90_PathAllegati:=VarToStr(QI091.Lookup('Tipo','C90_PATH_ALLEGATI','Dato'));
  if Parametri.CampiRiferimento.C90_PathAllegati = '' then
    Parametri.CampiRiferimento.C90_PathAllegati:='DB';
  Parametri.CampiRiferimento.C90_IterMaxAllegati:=VarToStr(QI091.Lookup('Tipo','C90_ITER_MAX_ALLEGATI','Dato'));
  Parametri.CampiRiferimento.C90_IterMaxDimAllegatoMB:=VarToStr(QI091.Lookup('Tipo','C90_ITER_MAX_DIM_ALLEGATO_MB','Dato'));
  Parametri.CampiRiferimento.C90_IterEstensioneAllegato:=VarToStr(QI091.Lookup('Tipo','C90_ITER_ESTENSIONE_ALLEGATO','Dato'));
  Parametri.CampiRiferimento.C90_IterDimMaxDownloadMassivoMB:=VarToStr(QI091.Lookup('Tipo','C90_ITER_DIM_MAX_ALLEGATI_DOWNLOAD','Dato'));
  Parametri.CampiRiferimento.C90_IterNrMaxDownloadMassivo:=VarToStr(QI091.Lookup('Tipo','C90_ITER_NR_MAX_ALLEGATI_DOWNLOAD','Dato'));
  Parametri.CampiRiferimento.C90_IterOrdinaDataRichiesta:=VarToStr(QI091.Lookup('Tipo','C90_ITER_ORDINA_DATA_RICHIESTA','Dato'));
  Parametri.CampiRiferimento.C90_NotificatoreAttivita:=VarToStr(QI091.Lookup('Tipo','C90_NOTIFICATORE_ATTIVITA','Dato'));
  Parametri.CampiRiferimento.C90_FiltroAnagrafeConsideraRichiesteCessati:=VarToStr(QI091.Lookup('Tipo','C90_FILTROANAG_CONSIDERA_RICH_CESSATI','Dato'));
  Parametri.CampiRiferimento.C90_EmailSincrDominio:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_SINCR_DOMINIO','Dato'));
  Parametri.CampiRiferimento.C90_CellulareLunghMin:=VarToStr(QI091.Lookup('Tipo','C90_CELLULARE_LUNGHMIN','Dato'));
  if Parametri.CampiRiferimento.C90_CellulareLunghMin = '' then
    Parametri.CampiRiferimento.C90_CellulareLunghMin:='10';
  Parametri.CampiRiferimento.C90_W034GiornoMeseDispCedolino:=VarToStr(QI091.Lookup('Tipo','C90_W034GIORNO_MESE_DISP_CEDOLINO','Dato'));
  Parametri.CampiRiferimento.C90_W034WSUser:=VarToStr(QI091.Lookup('Tipo','C90_W034WS_USER','Dato'));
  Parametri.CampiRiferimento.C90_W034WSPassword:=R180Decripta(VarToStr(QI091.Lookup('Tipo','C90_W034WS_PASSWORD','Dato')),I091CryptKey);
  Parametri.CampiRiferimento.C90_W009_WA027_UsaB028:=VarToStr(QI091.Lookup('Tipo','C90_W009_WA027_USA_B028','Dato'));
  Parametri.CampiRiferimento.C90_MessaggisticaReply:=VarToStr(QI091.Lookup('Tipo','C90_MESSAGGISTICA_REPLY','Dato'));
  Parametri.CampiRiferimento.C90_MessaggisticaObbligoLettura:=VarToStr(QI091.Lookup('Tipo','C90_MESSAGGISTICA_OBBLIGOLETTURA','Dato'));
  Parametri.CampiRiferimento.C90_MessaggisticaApriDettaglio:=VarToStr(QI091.Lookup('Tipo','C90_MESSAGGISTICA_APRIDETTAGLIO','Dato'));
  Parametri.CampiRiferimento.C90_MessaggiObbligatoriBloccanti:=VarToStr(QI091.Lookup('Tipo','C90_MESSAGGI_OBBLIGATORI_BLOCCANTI','Dato'));
  Parametri.CampiRiferimento.C90_W035MaxDimAllegatoMB:=VarToStr(QI091.Lookup('Tipo','C90_W035MAX_DIM_ALLEGATO_MB','Dato'));
  Parametri.CampiRiferimento.C90_W035MaxAllegati:=VarToStr(QI091.Lookup('Tipo','C90_W035MAX_ALLEGATI','Dato'));
  Parametri.CampiRiferimento.C90_W035QuotaAllegatiMB:=VarToStr(QI091.Lookup('Tipo','C90_W035QUOTA_ALLEGATI_MB','Dato'));
  Parametri.CampiRiferimento.C90_W035ModalitaCancMessaggiInviati:=VarToStr(QI091.Lookup('Tipo','C90_W035MODALITA_CANC_MESSAGGI_INVIATI','Dato'));
  Parametri.CampiRiferimento.C90_W035MesiDopoInvioCancMessaggi:=VarToStr(QI091.Lookup('Tipo','C90_W035MESI_DOPO_INVIO_CANC_MESSAGGI','Dato'));
  Parametri.CampiRiferimento.C90_W038Tolleranza_E:=VarToStr(QI091.Lookup('Tipo','C90_W038TOLLERANZA_E','Dato'));
  Parametri.CampiRiferimento.C90_W038Tolleranza_U:=VarToStr(QI091.Lookup('Tipo','C90_W038TOLLERANZA_U','Dato'));
  Parametri.CampiRiferimento.C90_W038Rilevatore:=VarToStr(QI091.Lookup('Tipo','C90_W038RILEVATORE','Dato'));
  Parametri.CampiRiferimento.C90_W038RilevatoreMobile:=VarToStr(QI091.Lookup('Tipo','C90_W038RILEVATORE_MOBILE','Dato'));
  Parametri.CampiRiferimento.C90_W038FiltroAnagRilevatoreMobile:=VarToStr(QI091.Lookup('Tipo','C90_W038FILTRO_ANAG_RILEVATORE_MOBILE','Dato'));
  Parametri.CampiRiferimento.C90_W038NumGGVisibili:=VarToStr(QI091.Lookup('Tipo','C90_W038NUMGGVISIBILI','Dato'));
  Parametri.CampiRiferimento.C90_W038TimbCausalizzabile:=VarToStr(QI091.Lookup('Tipo','C90_W038TIMBCAUSALIZZABILE','Dato'));
  Parametri.CampiRiferimento.C90_W038CheckIP:=VarToStr(QI091.Lookup('Tipo','C90_W038CHECKIP','Dato'));
  Parametri.CampiRiferimento.C90_W038TriggerBefore:=VarToStr(QI091.Lookup('Tipo','C90_W038TRIGGERBEFORE','Dato'));
  Parametri.CampiRiferimento.C26_C018_Hint:='N';
  if VarToStr(QI091.Lookup('Tipo','C26_C018_HINT','Dato')) <> '' then
    Parametri.CampiRiferimento.C26_C018_Hint:=VarToStr(QI091.Lookup('Tipo','C26_C018_HINT','Dato'));
  Parametri.CampiRiferimento.C26_C018_Unnest:='N';
  if VarToStr(QI091.Lookup('Tipo','C26_C018_UNNEST','Dato')) <> '' then
    Parametri.CampiRiferimento.C26_C018_Unnest:=VarToStr(QI091.Lookup('Tipo','C26_C018_UNNEST','Dato'));
  Parametri.CampiRiferimento.C90_Email_DatiP430:='N';
  if VarToStr(QI091.Lookup('Tipo','C90_EMAIL_DATIP430','Dato')) <> '' then
    Parametri.CampiRiferimento.C90_Email_DatiP430:=VarToStr(QI091.Lookup('Tipo','C90_EMAIL_DATIP430','Dato'));
  Parametri.CampiRiferimento.C90_W010Cancellazione:='N';
  if VarToStr(QI091.Lookup('Tipo','C90_W010CANCELLAZIONE','Dato')) <> '' then
    Parametri.CampiRiferimento.C90_W010Cancellazione:=VarToStr(QI091.Lookup('Tipo','C90_W010CANCELLAZIONE','Dato'));

  //SSO
  Parametri.CampiRiferimento.C90_SSO_Tipo:=VarToStr(QI091.Lookup('Tipo','C90_SSO_TIPO','Dato'));
  Parametri.CampiRiferimento.C90_SSO_OAUTH2Passphrase:=R180Decripta(VarToStr(QI091.Lookup('Tipo','C90_SSO_OAUTH2_PASSPHRASE','Dato')),I091CryptKey);
  Parametri.CampiRiferimento.C90_SSO_OAUTH2ClientID:=VarToStr(QI091.Lookup('Tipo','C90_SSO_OAUTH2_CLIENTID','Dato'));
  Parametri.CampiRiferimento.C90_SSO_OAUTH2UrlGetToken:=VarToStr(QI091.Lookup('Tipo','C90_SSO_OAUTH2_URLGETTOKEN','Dato'));
  Parametri.CampiRiferimento.C90_SSO_OAUTH2UrlGetUser:=VarToStr(QI091.Lookup('Tipo','C90_SSO_OAUTH2_URLGETUSER','Dato'));
  Parametri.CampiRiferimento.C90_SSO_OAUTH2InfoUser:=VarToStr(QI091.Lookup('Tipo','C90_SSO_OAUTH2_INFOUSER','Dato'));
  Parametri.CampiRiferimento.C90_SSO_SHA1Passphrase:=R180Decripta(VarToStr(QI091.Lookup('Tipo','C90_SSO_SHA1PASSPHRASE','Dato')),I091CryptKey);
  Parametri.CampiRiferimento.C90_SSO_RDLPassphrase:=R180Decripta(VarToStr(QI091.Lookup('Tipo','C90_SSO_RDLPASSPHRASE','Dato')),I091CryptKey);
  Parametri.CampiRiferimento.C90_SSO_UsrMask:=VarToStr(QI091.Lookup('Tipo','C90_SSO_USRMASK','Dato'));
  Parametri.CampiRiferimento.C90_SSO_TimeOut:=VarToStr(QI091.Lookup('Tipo','C90_SSO_TIMEOUT','Dato'));
  //LArchive
  Parametri.CampiRiferimento.C45_LArchive_ProducerId:=VarToStr(QI091.Lookup('Tipo','C45_LARCHIVE_PRODUCERID','Dato'));
  Parametri.CampiRiferimento.C45_LArchive_TokenJWT:=R180Decripta(VarToStr(QI091.Lookup('Tipo','C45_LARCHIVE_TOKENJWT','Dato')),30011945);
  Parametri.CampiRiferimento.C45_LArchive_Scadenza_TokenJWT:=VarToStr(QI091.Lookup('Tipo','C45_LARCHIVE_SCADENZA_TOKENJWT','Dato'));
  Parametri.CampiRiferimento.C45_LArchive_URL_Versamento:=VarToStr(QI091.Lookup('Tipo','C45_LARCHIVE_URL_VERSAMENTO','Dato'));
  Parametri.CampiRiferimento.C45_LArchive_URL_Stato:=VarToStr(QI091.Lookup('Tipo','C45_LARCHIVE_URL_STATO','Dato'));
  Parametri.CampiRiferimento.C90_Contatti_Aziendali:=VarToStr(QI091.Lookup('Tipo','C90_CONTATTI_AZIENDALI','Dato'));
  Parametri.CampiRiferimento.C90_Contatti_Personali:=VarToStr(QI091.Lookup('Tipo','C90_CONTATTI_PERSONALI','Dato'));
end;

procedure TA181FAziendeMW.SendEMail(Indirizzo:string);
begin
  IdSMTP.Host:=Parametri.CampiRiferimento.C90_EMailSMTPHost;
  if Parametri.CampiRiferimento.C90_EMailPort.Trim = '' then
    IdSMTP.Port:=25
  else
    IdSMTP.Port:=Parametri.CampiRiferimento.C90_EMailPort.ToInteger;
  IdSMTP.AuthType:=satDefault;
  IdSMTP.IOHandler:=nil;
  {Assegnazione e valorizzazione oggetto necessario per l'autenticazione TLS\SSL}
  if (Parametri.CampiRiferimento.C90_EMailAuthType.Trim <> '') and
     (Parametri.CampiRiferimento.C90_EMailAuthType.Trim.ToUpper <> 'NO AUTENTICAZIONE') then
  begin
    IdSMTP.IOHandler:=IdSSLIOHandlerSocketOpenSSL;
    with IdSSLIOHandlerSocketOpenSSL do
    begin
      IdSMTP.UseEhlo:=not Parametri.CampiRiferimento.C90_EMailHeloName.Trim.IsEmpty;

      SSLOptions.Method:=sslvTLSv1;
      SSLOptions.SSLVersions:=[sslvTLSv1];
      if Parametri.CampiRiferimento.C90_EMailAuthType.ToUpper = 'TLSV1_1' then
      begin
        SSLOptions.Method:=sslvTLSv1_1;
        SSLOptions.SSLVersions:=[sslvTLSv1_1];
      end
      else if Parametri.CampiRiferimento.C90_EMailAuthType.ToUpper = 'TLSV1_2' then
      begin
        SSLOptions.Method:=sslvTLSv1_2;
        SSLOptions.SSLVersions:=[sslvTLSv1_2];
      end
      else if Parametri.CampiRiferimento.C90_EMailAuthType.ToUpper = 'SSLV2' then
      begin
        SSLOptions.Method:=sslvSSLv2;
        SSLOptions.SSLVersions:=[sslvSSLv2];
      end
      else if Parametri.CampiRiferimento.C90_EMailAuthType.ToUpper = 'SSLV23' then
      begin
        SSLOptions.Method:=sslvSSLv23;
        SSLOptions.SSLVersions:=[sslvSSLv23];
      end
      else if Parametri.CampiRiferimento.C90_EMailAuthType.ToUpper = 'SSLV3' then
      begin
        SSLOptions.Method:=sslvSSLv3;
        SSLOptions.SSLVersions:=[sslvSSLv3];
      end;

      SSLOptions.RootCertFile:='';
      SSLOptions.Mode:=sslmUnassigned;
      SSLOptions.VerifyMode:=[];
      SSLOptions.VerifyDepth:=0;
      ConnectTimeout:=0;
    end;
    IdSMTP.UseTLS:=utUseImplicitTLS;
    if Parametri.CampiRiferimento.C90_EMailUseTLS.ToUpper = 'NO' then
      IdSMTP.UseTLS:=utNoTLSSupport
    else if Parametri.CampiRiferimento.C90_EMailUseTLS.ToUpper = 'IMPLICIT' then
      IdSMTP.UseTLS:=utUseImplicitTLS
    else if Parametri.CampiRiferimento.C90_EMailUseTLS.ToUpper = 'EXPLICIT' then
      IdSMTP.UseTLS:=utUseExplicitTLS
    else if Parametri.CampiRiferimento.C90_EMailUseTLS.ToUpper = 'REQUIRE' then
      IdSMTP.UseTLS:=utUseRequireTLS;
  end;
  try
    try
      IdSMTP.HeloName:=Parametri.CampiRiferimento.C90_EMailHeloName;
      IdSMTP.Connect;
      IdSMTP.Username:=Trim(Parametri.CampiRiferimento.C90_EMailUserName);
      IdSMTP.Password:=Trim(Parametri.CampiRiferimento.C90_EMailPassWord);
      IdMessage.ContentType:='text/plain; charset=ISO-8859-15';
      IdMessage.From.Address:=Parametri.CampiRiferimento.C90_EMailSenderIndirizzo; // 'irisweb@mondoedp.com' è il default
      IdMessage.From.Name:='IrisWEB';
      IdMessage.BccList.Clear;
      IdMessage.Recipients.Clear;
      IdMessage.Recipients.EmailAddresses:=Indirizzo;
      IdMessage.Subject:='Test invio E-Mail';
      IdMessage.MessageParts.Clear;
      IdMessage.Body.Text:='';
      IdSMTP.Send(IdMessage);
    finally
      IdSMTP.Disconnect;
    end;
  except
    on E:Exception do
      raise Exception.Create('Invio email fallito su host ' + IdSMTP.Host + ': ' + E.ClassName + '/' + E.Message);
  end;
end;

procedure TA181FAziendeMW.QI091AfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TA181FAziendeMW.QI091AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TA181FAziendeMW.QI091AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if Assigned(A181MW_QI091AfterScroll) then
    A181MW_QI091AfterScroll(QI091);
end;

procedure TA181FAziendeMW.QI091BeforeDelete(DataSet: TDataSet);
begin
  Abort;
end;

procedure TA181FAziendeMW.QI091BeforePost(DataSet: TDataSet);
var
  i,j,TestInt:integer;
  TestString, ListaNumeri:String;
begin
  //Verifica dei dati numerici della I091 Dati aziendali
  ListaNUmeri:='0123456789';
  i:=1;
  while (DatiEnte[i].Nome <> QI091.FieldByName('TIPO').AsString) do
    inc(i);
  if DatiEnte[i].Nome = QI091.FieldByName('TIPO').AsString then
  begin
    TestString:=QI091.FieldByName('DATO').AsString;
    if DatiEnte[i].Lista = 'NUMERICO' then
    begin
      for j:=1 to Length(TestString) do
        if pos(TestString[j], ListaNUmeri) <= 0 then
          raise Exception.Create('Impossibile inserire un valore non numerico!');
    end
    else if DatiEnte[i].Lista = 'GIORNO_MESE' then
    begin
      if not TryStrToInt(TestString,TestInt) then
        raise Exception.Create('Il valore da inserire deve essere un intero compreso fra 1 e 31!');
      if (TestInt < 1) or (TestInt > 31) then
        raise Exception.Create('Il valore da inserire deve essere compreso fra 1 e 31!');
    end
    else if DatiEnte[i].Lista = 'ORA' then
    begin
      for j:=1 to Length(TestString) do
        case j of
          3: if pos(TestString[j],'.') <= 0 then
               raise Exception.Create('Il formato del dato è HH.MM');
        else if pos(TestString[j], ListaNUmeri) <= 0 then
               raise Exception.Create('Il formato del dato è HH.MM');
        end;
      R180OraValidate(TestString);
    end;
  end;
  case QI091.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(QI091),NomeOwner,QI091,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(QI091),NomeOwner,QI091,True);
  end;
end;

procedure TA181FAziendeMW.QI091CalcFields(DataSet: TDataSet);
{descrizione dei dati disponibili in Gestione Moduli}
begin
  QI091.FieldByName('D_Tipo').AsString:=A000DescDatiEnte(QI091.FieldByName('Tipo').AsString);
  if QI091.FieldByName('D_Tipo').AsString = '' then
    QI091.FieldByName('D_Tipo').AsString:=QI091.FieldByName('Tipo').AsString;
  QI091.FieldByName('GRUPPO').AsString:=GetI091Gruppo(QI091.FieldByName('TIPO').AsString);
end;

procedure TA181FAziendeMW.QI091DATOGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  inherited;
  if A000DatiEnteCrypt(Sender.DataSet.FieldByName('TIPO').AsString) = 'S' then
    Text:=R180Decripta(Sender.AsString,I091CryptKey)
  else
    Text:=Sender.AsString;
end;

procedure TA181FAziendeMW.QI091DATOSetText(Sender: TField; const Text: string);
begin
  inherited;
  if A000DatiEnteCrypt(Sender.DataSet.FieldByName('TIPO').AsString) = 'S' then
    Sender.AsString:=R180Cripta(Text,I091CryptKey)
  else
    Sender.AsString:=Text;
end;

procedure TA181FAziendeMW.QI091FilterRecord(DataSet: TDataSet; var Accept: Boolean);
var
  i:Integer;
begin
  Accept:=True;
  if GruppoFiltroI091 = '' then
    exit;
  Accept:=False;
  if GruppoFiltroI091 <> NON_ASSEGNATO then
  begin
    for i:=Low(DatiEnte) to High(DatiEnte) do
      if (UpperCase(DatiEnte[i].Gruppo) = UpperCase(GruppoFiltroI091)) and
         (UpperCase(QI091.FieldByName('TIPO').AsString) = UpperCase(DatiEnte[i].Nome)) then
      begin
        Accept:=True;
        Break;
      end;
    end
  else
    if GetI091Gruppo(QI091.FieldByName('TIPO').AsString) = NON_ASSEGNATO then
      Accept:=True;
end;

procedure TA181FAziendeMW.selDizionarioBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  selDizionario.SQL.Text:='select * from (' +A000selDizionario + A000selDizionarioDatiAziendali(selDizionario.Session) + A000selDizionarioSicurezzaRiepiloghi;
  selDizionario.SQL.Add(') ORDER BY TABELLA, upper(CODICE)');
  R180SetReadBuffer(selDizionario);
end;

function TA181FAziendeMW.GetI091Gruppo(CodI091:String):String;
var i:Integer;
begin
  for i:=Low(DatiEnte) to High(DatiEnte) do
    if DatiEnte[i].Nome = CodI091 then
    begin
      Result:=DatiEnte[i].Gruppo;
      exit
    end;
  Result:=NON_ASSEGNATO;
end;

end.
