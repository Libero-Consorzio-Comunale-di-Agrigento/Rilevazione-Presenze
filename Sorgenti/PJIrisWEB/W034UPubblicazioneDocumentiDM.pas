unit W034UPubblicazioneDocumentiDM;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  A000USessione,
  A118UPubblicazioneDocumentiMW,
  FunzioniGenerali,
  SysUtils,
  Classes,
  Oracle,
  OracleData,
  DBClient,
  DB,
  System.Variants,
  System.DateUtils,
  System.StrUtils,
  System.IOUtils;

type
  TW034FPubblicazioneDocumentiDM = class(TDataModule)
    cdsFile: TClientDataSet;
    selT960: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FLstDettaglio: TStringList;
    procedure ResetDataset; {$IFNDEF DEBUG} inline; {$ENDIF !DEBUG}
    function PreparaStrutturaFile: TResCtrl; {$IFNDEF DEBUG} inline; {$ENDIF !DEBUG}
    function PreparaStrutturaDocumentale: TResCtrl; {$IFNDEF DEBUG} inline; {$ENDIF !DEBUG}
    function PopolaStrutturaFile: TResCtrl;
    function PopolaStrutturaDocumentale: TResCtrl; {$IFNDEF DEBUG} inline; {$ENDIF !DEBUG}
    procedure ScorriPath(const PDirNameCompleto: String; PLiv: Integer);
    procedure AddToDataset(const PLiv: Integer); {$IFNDEF DEBUG} inline; {$ENDIF !DEBUG}
  public
    A118MW: TA118FPubblicazioneDocumentiMW;
    function PreparaDataset(PCodStruttura: String): TResCtrl;
    function PopolaDataset: TResCtrl; inline;
    property LstDettaglio: TStringList read FLstDettaglio;
  end;

const
  // campi di appoggio
  CAMPO_ID             = '_ID';
  CAMPO_NOME_DOCUMENTO = '_NOME_DOCUMENTO';
  CAMPO_PATH_DOCUMENTO = '_PATH_DOCUMENTO';
  CAMPO_EXT_DOCUMENTO  = '_EXT_DOCUMENTO';
  CAMPO_ANNO           = '_ANNO';
  CAMPO_MESE           = '_MESE';
  CAMPO_PERIODO_DAL    = '_PERIODO_DAL';
  CAMPO_PERIODO_AL     = '_PERIODO_AL';


implementation

uses
  IWApplication, System.Diagnostics, WR010UBase;

{$R *.dfm}

procedure TW034FPubblicazioneDocumentiDM.DataModuleCreate(Sender: TObject);
var
  i: Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle
    else if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;

  FLstDettaglio:=TStringList.Create;
end;

procedure TW034FPubblicazioneDocumentiDM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FLstDettaglio);
end;

procedure TW034FPubblicazioneDocumentiDM.ResetDataset;
// resetta il dataset dei documenti
begin
  // chiude dataset
  cdsFile.Close;

  // rimuove filtri
  cdsFile.Filtered:=False;
  cdsFile.Filter:='';

  // pulisce campi persistenti
  cdsFile.FieldDefs.Clear;

  // pulisce indici
  cdsFile.IndexName:='';
  cdsFile.IndexDefs.Clear;
end;

function TW034FPubblicazioneDocumentiDM.PreparaDataset(PCodStruttura: String): TResCtrl;
// prepara la struttura del dataset che contiene i documenti della struttura selezionata
var
  LSorg: String;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  try
    // imposta codice tipologia documento
    A118MW.Codice:=PCodStruttura;

    // resetta il dataset dei documenti
    ResetDataset;

    // in base alla sorgente della struttura prepara il dataset dei documenti da visualizzare
    LSorg:=VarToStr(A118MW.selI200.Lookup('CODICE',A118MW.Codice,'SORGENTE_DOCUMENTI'));
    if LSorg = SORGENTE_FS_EXT then
    begin
      // prepara struttura dataset per documenti su file system
      Result:=PreparaStrutturaFile;
    end
    else if LSorg = SORGENTE_T960 then
      // prepara struttura dataset per documenti indicizzati su T960
      Result:=PreparaStrutturaDocumentale
    else
    begin
      // non prepara nessuna struttura dataset
      // i documenti saranno ottenuti da un webservice
      Result.Ok:=True;
    end;
  except
    on E: Exception do
    begin
      Result.Messaggio:=E.Message;
      Exit;
    end;
  end;
end;

function TW034FPubblicazioneDocumentiDM.PreparaStrutturaFile: TResCtrl;
// prepara il dataset per la tipologia di documenti che risiedono su file system
var
  LCampiIndice,LTipoCampoStr,LNome: String;
  LCampoObj: TCampo;
  i: Integer;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  try
    // imposta la struttura del clientdataset di visualizzazione
    // aggiungendo i campi variabili della tabella I202
    LCampiIndice:='';

    // aggiunge campi persistenti fissi
    cdsFile.FieldDefs.Add(CAMPO_PATH_DOCUMENTO,ftString,500,False);
    cdsFile.FieldDefs.Add(CAMPO_NOME_DOCUMENTO,ftString,100,False);
    cdsFile.FieldDefs.Add(CAMPO_EXT_DOCUMENTO,ftString,10,False);

    // ciclo sui dettagli
    A118MW.selI202.Filtered:=False;
    A118MW.selI202.First;
    while not A118MW.selI202.Eof do
    begin
      // utilizza la struttura dati "campo" per impostare la creazione del field sul clientdataset
      LCampoObj:=TCampo.Create(A118MW);
      try
        LCampoObj.Campo:=A118MW.selI202.FieldByName('CAMPO').AsString;
        LCampoObj.Dal:=A118MW.selI202.FieldByName('DAL').AsInteger;
        LCampoObj.Lung:=A118MW.selI202.FieldByName('LUNG').AsInteger;
        LCampoObj.Visibile:=A118MW.selI202.FieldByName('VISIBILE').AsString;

        // se il campo è variabile valuta se aggiungerlo al clientdataset
        // i campi costanti non vengono aggiunti alla struttura
        if LCampoObj.Variabile then
        begin
          // se il campo è visibile e non è ancora presente nel clientdataset lo aggiunge
          if (LCampoObj.Visibile = 'S') and
             (cdsFile.FieldDefs.IndexOf(LCampoObj.Campo) = -1) then
          begin
            // aggiunge il campo al dataset
            case LCampoObj.TipoCampo of
              ftInteger:   LTipoCampoStr:='integer';
              ftDateTime:  LTipoCampoStr:='datetime';
              ftString:    LTipoCampoStr:=Format('string(%d)',[LCampoObj.SizeCampo]);
            else
              LTipoCampoStr:='';
            end;
            cdsFile.FieldDefs.Add(LCampoObj.Campo,LCampoObj.TipoCampo,LCampoObj.SizeCampo,False);

            // indice per ordinamento campi data
            if (LCampoObj.RifData) and (Pos(LCampoObj.Campo + ';',LCampiIndice) = 0) then
            begin
              LCampiIndice:=LCampiIndice + LCampoObj.Campo + ';';
            end;
          end;
        end;
      finally
        FreeAndNil(LCampoObj);
        A118MW.selI202.Next;
      end;
    end;

    // impostazione indici dataset
    if LCampiIndice <> '' then
    begin
      LCampiIndice:=Copy(LCampiIndice,1,Length(LCampiIndice) - 1);
      cdsFile.IndexDefs.Add('DataDesc',(LCampiIndice),[ixDescending]);
      cdsFile.IndexName:='DataDesc';
    end;

    // creazione dataset
    cdsFile.CreateDataSet;
    cdsFile.LogChanges:=False;

    // imposta le displaylabel dei campi
    for i:=0 to cdsFile.FieldCount - 1 do
    begin
      LNome:=cdsFile.Fields[i].DisplayName;
      if LNome = CAMPO_NOME_DOCUMENTO then
        cdsFile.Fields[i].DisplayLabel:='Nome documento'
      else if LNome = CAMPO_PATH_DOCUMENTO then
        cdsFile.Fields[i].DisplayLabel:='Path documento'
      else if LNome = CAMPO_EXT_DOCUMENTO then
        cdsFile.Fields[i].DisplayLabel:='Tipo file'
      else
        cdsFile.Fields[i].DisplayLabel:=TFunzioniGenerali.Capitalize(LNome.Replace('_',' ',[rfReplaceAll]).Trim);
    end;
  except
    on E: Exception do
    begin
      Result.Messaggio:=Format('La tipologia "%s" contiene errori'#13#10'nella definizione di struttura dei file:'#13#10'%s',[A118MW.Codice,E.Message]);
      Exit;
    end;
  end;

  // tutto ok
  Result.Ok:=True;
end;

function TW034FPubblicazioneDocumentiDM.PreparaStrutturaDocumentale: TResCtrl;
// prepara il dataset per la tipologia di documenti afferenti alla gestione documentale MondoEdp
var
  i: Integer;
  LNome: String;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  try
    // aggiunge campi persistenti fissi
    cdsFile.FieldDefs.Add(CAMPO_ID,ftFloat,0,False);
    cdsFile.FieldDefs.Add(CAMPO_NOME_DOCUMENTO,ftString,100,False);
    cdsFile.FieldDefs.Add(CAMPO_EXT_DOCUMENTO,ftString,10,False);
    cdsFile.FieldDefs.Add(CAMPO_ANNO,ftInteger,0,False);
    cdsFile.FieldDefs.Add(CAMPO_MESE,ftString,30,False);
    cdsFile.FieldDefs.Add(CAMPO_PERIODO_DAL,ftDateTime,0,False);
    cdsFile.FieldDefs.Add(CAMPO_PERIODO_AL,ftDateTime,0,False);

    // impostazione indici dataset
    cdsFile.IndexDefs.Add('PeriodoDalDesc',CAMPO_PERIODO_DAL,[ixDescending]);
    cdsFile.IndexName:='PeriodoDalDesc';

    // creazione dataset
    cdsFile.CreateDataSet;
    cdsFile.LogChanges:=False;

    // imposta le displaylabel dei campi
    for i:=0 to cdsFile.FieldCount - 1 do
    begin
      LNome:=cdsFile.Fields[i].DisplayName;
      if LNome = CAMPO_NOME_DOCUMENTO then
        cdsFile.Fields[i].DisplayLabel:='Nome documento'
      else if LNome = CAMPO_EXT_DOCUMENTO then
        cdsFile.Fields[i].DisplayLabel:='Tipo file'
      else
        cdsFile.Fields[i].DisplayLabel:=TFunzioniGenerali.Capitalize(LNome.Replace('_',' ',[rfReplaceAll]).Trim);
    end;
  except
    on E: Exception do
    begin
      Result.Messaggio:=Format('Si è verificato un errore in fase di creazione della tabella:'#13#10'%s',[E.Message]);
      Exit;
    end;
  end;

  // tutto ok
  Result.Ok:=True;
end;

function TW034FPubblicazioneDocumentiDM.PopolaDataset: TResCtrl;
var
  LSorg: String;
begin
  // PRE: il codice struttura è salvato in A118MW.Codice
  LSorg:=VarToStr(A118MW.selI200.Lookup('CODICE',A118MW.Codice,'SORGENTE_DOCUMENTI'));

  FLstDettaglio.Clear;
  if LSorg = SORGENTE_FS_EXT then
  begin
    // popola dataset per documenti su file system
    Result:=PopolaStrutturaFile;
  end
  else if LSorg = SORGENTE_T960 then
    // popola dataset per documenti indicizzati su T960
    Result:=PopolaStrutturaDocumentale
  else
  begin
    // nessun dataset da popolare
  end;
end;

function TW034FPubblicazioneDocumentiDM.PopolaStrutturaFile: TResCtrl;
// percorre la struttura delle directory per trovare i documenti corrispondenti ai filtri
// la ricerca inizia dalla "root directory" (se non è indicata esplicitamente utilizza la directory predefinita sul webserver)
var
  LRootDir: String;
  LVarAnag: TVariabiliAnagrafiche;
  LStopWatch: TStopWatch;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  LRootDir:=A118MW.RootDir;
  if not TDirectory.Exists(LRootDir) then
  begin
    Result.Messaggio:='Errore durante la ricerca dei documenti:'#13#10'la directory radice è inesistente o non accessibile';
    Exit;
  end;

  // informazioni di dettaglio per debug
  FLstDettaglio.Add('[Informazioni utente]');
  if TFunzioniGenerali._In(Parametri.Operatore,['SYSMAN','MONDOEDP']) then
    FLstDettaglio.Add('(è ridefinito con il dipendente selezionato in Elenco anagrafe)');

  // variabili anagrafiche per sostituzioni
  LVarAnag:=A118MW.VariabiliAnagrafiche;
  FLstDettaglio.Add('Progressivo = ' + LVarAnag.Progressivo.ToString);
  FLstDettaglio.Add('Matricola   = ' + LVarAnag.Matricola);
  FLstDettaglio.Add('Cod.fiscale = ' + LVarAnag.CodFiscale);
  FLstDettaglio.Add('Nome utente = ' + LVarAnag.NomeUtente);
  FLstDettaglio.Add('');

  FLstDettaglio.Add('[Informazioni struttura]');
  FLstDettaglio.Add(Format('Livello di profondità max cartelle =  %d',[A118MW.LivMaxDir]));
  FLstDettaglio.Add(Format('Livello di profondità file         >= %d',[A118MW.LivFile]));
  FLstDettaglio.Add('');

  FLstDettaglio.Add('[Risultati ricerca]');
  FLstDettaglio.Add('Cartella base = ' + LRootDir);
  FLstDettaglio.Add('Liv.  Cartella');

  LStopWatch:=TStopwatch.StartNew;
  try
    try
      ScorriPath(LRootDir,-1);
      Result.Ok:=True;
    except
      on E: Exception do
      begin
        Result.Messaggio:=Format('Errore durante la ricerca dei documenti:'#13#10'%s',[E.Message]);
      end;
    end;
  finally
    // stop timer di precisione
    LStopWatch.Stop;
    FLstDettaglio.Add(Format('Tempo operazione: %d ms',[LStopWatch.ElapsedMilliseconds]));
  end;
end;

function TW034FPubblicazioneDocumentiDM.PopolaStrutturaDocumentale: TResCtrl;
var
  LTipologiaT960: String;
  LPeriodoDal: TDateTime;
  LPeriodoAl: TDateTime;
  LVarAnag: TVariabiliAnagrafiche;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  try
    LVarAnag:=A118MW.VariabiliAnagrafiche;
    LTipologiaT960:=VarToStr(A118MW.selI200.Lookup('CODICE',A118MW.Codice,'TIPOLOGIA_DOCUMENTI'));

    selT960.Close;
    selT960.SetVariable('AZIENDA',Parametri.Azienda);
    selT960.SetVariable('PROGRESSIVO',LVarAnag.Progressivo);
    selT960.SetVariable('TIPOLOGIA',LTipologiaT960);
    selT960.Open;
    while not selT960.Eof do
    begin
      LPeriodoDal:=selT960.FieldByName('PERIODO_DAL').AsDateTime;
      LPeriodoAl:=selT960.FieldByName('PERIODO_AL').AsDateTime;

      // aggiunge record documento
      cdsFile.Append;
      cdsFile.FieldByName(CAMPO_ID).AsInteger:=selT960.FieldByName('ID').AsInteger;
      cdsFile.FieldByName(CAMPO_NOME_DOCUMENTO).AsString:=selT960.FieldByName('NOME_FILE').AsString;
      cdsFile.FieldByName(CAMPO_EXT_DOCUMENTO).AsString:=selT960.FieldByName('EXT_FILE').AsString;
      if LPeriodoDal.IsNull then
      begin
        cdsFile.FieldByName(CAMPO_PERIODO_DAL).Value:=null;
        cdsFile.FieldByName(CAMPO_ANNO).Value:=null;
        cdsFile.FieldByName(CAMPO_MESE).Value:=null;
      end
      else
      begin
        cdsFile.FieldByName(CAMPO_PERIODO_DAL).AsDateTime:=LPeriodoDal;
        cdsFile.FieldByName(CAMPO_ANNO).AsInteger:=LPeriodoDal.Year;
        cdsFile.FieldByName(CAMPO_MESE).AsString:=Format('%.2d - %s',[LPeriodoDal.Month,TFunzioniGenerali.NomeMese(LPeriodoDal.Month)]);
      end;
      if LPeriodoAl.IsNull then
        cdsFile.FieldByName(CAMPO_PERIODO_AL).Value:=null
      else
        cdsFile.FieldByName(CAMPO_PERIODO_AL).AsDateTime:=LPeriodoAl;
      cdsFile.Post;

      selT960.Next;
    end;
  except
    on E: Exception do
    begin
      Result.Messaggio:=Format('Si è verificato un errore durante la lettura dei documenti:'#13#10'%s',[E.Message]);
      Exit;
    end;
  end;

  // operazione ok
  Result.Ok:=True;
end;

procedure TW034FPubblicazioneDocumentiDM.ScorriPath(const PDirNameCompleto: String; PLiv: Integer);
// questa procedura utilizza chiamate ricorsive per attraversare le strutture
// delle directory, per cui vengono utilizzati i puntatori per mantenere
// minimo l'utilizzo dello stack.
{$WARN SYMBOL_PLATFORM OFF}
var
  LSearchRec: ^TSearchRec;
  LFileName: PString;
  LNumFile: Integer;
  LIsFile: Boolean;
  LResCtrlFolder: TResCtrl;
  LResCtrlFile: TResCtrl;
  LSearchPath: String;
  LDirName: String;
  LPrefisso: String;
  LErrFolder: String;
  LErrFile: String;
  LLivObj: TLivello;
begin
  if PDirNameCompleto.Trim = '' then
    Exit;

  cdsFile.Filtered:=False;

  // estrae il nome della directory attuale (senza path completo)
  LDirName:=TPath.GetFileName(PDirNameCompleto);

  // effettua controlli per i livelli definiti sulla struttura

  // verifica cartella
  LResCtrlFolder.Ok:=True;
  LResCtrlFolder.Messaggio:='';
  LErrFolder:='';
  if TFunzioniGenerali.Between(PLiv,0,A118MW.LivMaxDir) then
  begin
    // verifica se la cartella soddisfa i requisiti del nome e l'eventuale filtro
    LLivObj:=A118MW.Livello[PLiv];
    LLivObj.NomeFile:=LDirName;
    LResCtrlFolder:=LLivObj.MatchNome(TTipoTest.Dipendente);
    if LResCtrlFolder.Ok then
    begin
      LResCtrlFolder:=LLivObj.MatchFiltro(TTipoTest.Dipendente);
      if not LResCtrlFolder.Ok then
        LErrFolder:=Format('   >>> ERR_FILTRO >>> %s',[LResCtrlFolder.Messaggio]);
    end
    else
    begin
      LErrFolder:=Format('   >>> ERR_NOME >>> %s',[LResCtrlFolder.Messaggio]);
    end;
  end;

  // dettaglio dell'attraversamento della struttura
  if PLiv = -1 then
    LPrefisso:=Format('%3s   ',['B'])
  else
    LPrefisso:=Format('%3d    ',[PLiv]) + DupeString('|    ',PLiv) + '|-- ';
  FLstDettaglio.Add(LPrefisso + LDirName + LErrFolder);

  // esce se la cartella non è da considerare
  if not LResCtrlFolder.Ok then
    Exit;

  // disabilita input/output checking
  {$I-}

  // alloca un nuovo record (SearchRec) e una nuova string (FileName)
  New(LSearchRec);
  New(LFileName);

  // esamina i file presenti nella cartella
  try
    inc(PLiv);
    if PLiv >= A118MW.LivFile  then
      LSearchPath:='*.' + A118MW.Livello[A118MW.LivFile].ExtI201
    else
      LSearchPath:='*.*';
    LSearchPath:=TPath.Combine(PDirNameCompleto,LSearchPath);
    LNumFile:=SysUtils.FindFirst(LSearchPath,SysUtils.faAnyFile,LSearchRec^);
    while LNumFile = 0 do
    begin
      LFileName^:=TPath.Combine(PDirNameCompleto,LSearchRec^.Name);

      // verifica il tipo di file: directory oppure file
      LIsFile:=((LSearchRec^.Attr and SysUtils.faDirectory) = 0);
      if LIsFile then
      begin
        // tipo: file
        // considera i file a partire dal livello in cui è indicata l'estensione nella struttura
        if PLiv >= A118MW.LivFile then
        begin
          // -> esclude i file di sistema e i volume ID (C:, D:, ecc...)
          if ((LSearchRec^.Attr and SysUtils.faSysFile) = 0) then
          begin
            // IMPORTANTE
            //   anche se il livello è più alto di quello configurato nella struttura considera sempre il livello file
            LErrFile:='';
            LLivObj:=A118MW.Livello[A118MW.LivFile];
            LLivObj.PathFile:=TPath.GetDirectoryName(LFileName^);
            LLivObj.NomeFile:=TPath.GetFileName(LFileName^);
            LResCtrlFile:=LLivObj.MatchNome(TTipoTest.Dipendente);
            if LResCtrlFile.Ok then
            begin
              LResCtrlFile:=LLivObj.MatchFiltro(TTipoTest.Dipendente);
              if LResCtrlFile.Ok then
                AddToDataset(A118MW.LivFile)
              else
                LErrFile:=Format('   >>> ERR_FILTRO >>> %s',[LResCtrlFile.Messaggio]);
            end
            else
            begin
              LErrFile:=Format('   >>> ERR_NOME >>> %s',[LResCtrlFile.Messaggio]);
            end;

            LPrefisso:=Format('%3d    ',[LLivObj.Livello]) + DupeString('|    ',PLiv) + '|-- ';
            FLstDettaglio.Add(LPrefisso + LLivObj.NomeFile + '.' + LLivObj.ExtFile + LErrFile);
          end;
        end;
      end
      else
      begin
        // tipo: directory
        // -> esclude le directory speciali "." e ".."
        if ((LSearchRec^.Name <> '.') and (LSearchRec^.Name <> '..')) then
        begin
          // -> chiamata ricorsiva
          ScorriPath(LFileName^,PLiv);
        end;
      end;
      LNumFile:=SysUtils.FindNext(LSearchRec^);
    end;

    SysUtils.FindClose(LSearchRec^);
  finally
    // rilascia la memoria allocata per le strutture
    System.Dispose(LFileName);
    System.Dispose(LSearchRec);
  end;

  // riabilita input/output checking
  {$I+}
{$WARN SYMBOL_PLATFORM ON}
end;

procedure TW034FPubblicazioneDocumentiDM.AddToDataset(const PLiv: Integer);
// aggiunge un record al clientdataset con le informazioni sul file attualmente considerato
var
  i: Integer;
  LNomeCampo, LValoreCampo: String;
  LLivObj: TLivello;
  LNumeroMese: Integer;
begin
  LLivObj:=A118MW.Livello[PLiv];

  // aggiunge un nuovo record al dataset
  cdsFile.Append;

  // imposta i campi del record
  for i:=0 to cdsFile.FieldDefs.Count - 1 do
  begin
    LNomeCampo:=cdsFile.FieldDefs[i].Name;

    // valutazione campi particolari
    if LNomeCampo = CAMPO_NOME_DOCUMENTO then
    begin
      // campo speciale: nome del documento
      // il nome da visualizzare non deve essere riconducibile al file originale
      LValoreCampo:=Format('%s_%s.%s',[GGetWebApplicationThreadVar.AppId,FormatDateTime('_hhhhnnss',Now),LLivObj.ExtFile]);
    end
    else if LNomeCampo = CAMPO_PATH_DOCUMENTO then
    begin
      // campo speciale: path + nome file
      LValoreCampo:=TPath.Combine(LLivObj.PathFile,Format('%s.%s',[LLivObj.NomeFile,LLivObj.ExtFile]));
    end
    else if LNomeCampo = CAMPO_EXT_DOCUMENTO then
    begin
      // campo speciale: estensione file
      LValoreCampo:=LLivObj.ExtFile;
    end
    else
    begin
      // altri campi
      LValoreCampo:=A118MW.GetValoreCampo(LNomeCampo,PLiv,True);

      // il campo "MESE" viene trattato in modo particolare
      // in quanto può essere un numero oppure una stringa
      if LNomeCampo = VAR_MESE then
      begin
        // formatta il valore in modo standard
        if not TryStrToInt(LValoreCampo,LNumeroMese) then
          LNumeroMese:=TFunzioniGenerali.NumeroMese(LValoreCampo);
        LValoreCampo:=Format('%.2d - %s',[LNumeroMese,TFunzioniGenerali.NomeMese(LNumeroMese)]);
      end;
    end;

    // imposta il valore del campo
    try
      cdsFile.FieldByName(LNomeCampo).AsString:=LValoreCampo;
    except
      //...
    end;
  end;
  cdsFile.Post;
end;

end.
