unit B025UPubblDoc2GestDocDM;

interface

uses
 {$IFDEF DEBUG} OracleMonitor, {$ENDIF DEBUG}
  A000UCostanti,
  A000UInterfaccia,
  A000USessione,
  A118UPubblicazioneDocumentiMW,
  FunzioniGenerali,
  C180FunzioniGenerali,
  R004UGestStoricoDTM,
  System.Classes,
  System.DateUtils,
  System.SysUtils,
  System.Variants,
  System.StrUtils,
  System.IOUtils,
  Data.DB,
  OracleData,
  Oracle;

type
  TB025FPubblDoc2GestDocDM = class(TR004FGestStoricoDtM)
    selT962Lookup: TOracleDataSet;
    selCountT960: TOracleQuery;
    insT960: TOracleQuery;
    selT030: TOracleQuery;
    updI200: TOracleQuery;
    delT960: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selCountT960ThreadExecuted(Sender: TOracleQuery);

  public
    A118MW: TA118FPubblicazioneDocumentiMW;
    function InserisciT960(PLivObj: TLivello): TResCtrl;
    procedure ImpostaSorgenteDocumentale(const PCodStruttura: String; const PCodTipologia: String);
    procedure AnnullaIndicizzazioneStruttura(const PCodStruttura: String; const PCodTipologia: String);
  end;

var
  B025FPubblDoc2GestDocDM: TB025FPubblDoc2GestDocDM;

implementation

uses
  B025UPubblDoc2GestDoc;

{$R *.dfm}

procedure TB025FPubblDoc2GestDocDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
selT962Lookup.Open;
  A118MW:=TA118FPubblicazioneDocumentiMW.Create(nil);
end;

procedure TB025FPubblDoc2GestDocDM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A118MW);
  inherited;
end;

procedure TB025FPubblDoc2GestDocDM.selCountT960ThreadExecuted( Sender: TOracleQuery);
begin
  if selCountT960.RowCount > 0 then
    B025FPubblDoc2GestDoc.NotificaCountT960(VarToStr(selCountT960.GetVariable('TIPOLOGIA')),selCountT960.FieldAsInteger(0));
end;

procedure TB025FPubblDoc2GestDocDM.ImpostaSorgenteDocumentale(const PCodStruttura, PCodTipologia: String);
// imposta come sorgente della struttura la gestione documentale
// tutta la struttura precedente su file viene mantenuta per eventuali controlli / rollback
begin
  updI200.SetVariable('CODICE',PCodStruttura);
  updI200.SetVariable('SORGENTE_DOCUMENTI',SORGENTE_T960);
  updI200.SetVariable('TIPOLOGIA',PCodTipologia);
  updI200.Execute;
  updI200.Session.Commit;
end;

procedure TB025FPubblDoc2GestDocDM.AnnullaIndicizzazioneStruttura(const PCodStruttura, PCodTipologia: String);
begin
  try
    // elimina i documenti della tipologia selezionata dalla T960
    delT960.SetVariable('TIPOLOGIA',PCodTipologia);
    delT960.Execute;

    // annulla la tipologia sulla struttura e reimposta la sorgente su cartella esterna
    updI200.SetVariable('CODICE',PCodStruttura);
    updI200.SetVariable('SORGENTE_DOCUMENTI',SORGENTE_FS_EXT);
    updI200.SetVariable('TIPOLOGIA',null);
    updI200.Execute;

    SessioneOracle.Commit;
  except
    on E: Exception do
    begin
      SessioneOracle.Rollback;
      R180MessageBox(Format('Si è verificato un errore durante l''operazione:'#13#10'%s',[]),ESCLAMA);
    end;
  end;
end;

function TB025FPubblDoc2GestDocDM.InserisciT960(PLivObj: TLivello): TResCtrl;
var
  LFiltroDipendente: String;
  LFiltro: String;
  LTipologia: String;
  LUfficio: String;
  i: Integer;
  LNomeVar: String;
  LProgressivo: Integer;
  LDimensioneFile: Int64;
  LPeriodoDal: TDateTime;
  LPeriodoAl: TDateTime;
  LData: TDateTime;
  LAnno: Integer;
  LMese: Integer;
  LGiorno: Integer;
const
  NOME_METODO = 'TB025FPubblDoc2GestDocDM.InserisciT960';
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  TLogger.EnterMethod(NOME_METODO);
  try
    TLogger.Debug('Dati livello',PLivObj.ToString);

    // tipologia documento
    LTipologia:=B025FPubblDoc2GestDoc.cmbTipologie.Text;

    // ufficio di riferimento
    LUfficio:='*';

    // determina i valori delle variabili di interesse in base al nome del file
    A118MW.ImpostaVariabiliDaFileCorrente;

    // inizializza variabili
    LFiltroDipendente:='';
    LAnno:=0;
    LMese:=0;
    LGiorno:=0;
    LData:=DATE_NULL;

    // estrae informazioni utili dai valori delle variabili
    for i:=Low(A118MW.Variabili) to High(A118MW.Variabili) do
    begin
      LNomeVar:=A118MW.Variabili[i].Nome;

      if A118MW.Variabili[i].RifAnag then
      begin
        if (LNomeVar = VAR_PROGRESSIVO) and (A118MW.Variabili[i].ValoreInt <> 0) then
          LFiltro:=Format('(T030.%s = %d)',[LNomeVar,A118MW.Variabili[i].ValoreInt])
        else if (R180In(LNomeVar,[VAR_MATRICOLA,VAR_CODFISCALE])) and (A118MW.Variabili[i].ValoreStr <> '') then
          LFiltro:=Format('(T030.%s = %s)',[LNomeVar,A118MW.Variabili[i].ValoreStr.QuotedString])
        else if (LNomeVar = VAR_NOME_UTENTE) and (A118MW.Variabili[i].ValoreStr <> '') then
          LFiltro:=Format('(I060.%s = %s)',[LNomeVar,A118MW.Variabili[i].ValoreStr.QuotedString])
        else
          LFiltro:='';
        if LFiltro <> '' then
          LFiltroDipendente:=LFiltroDipendente + IfThen(LFiltroDipendente <> '',' and ') + LFiltro;
      end
      else if A118MW.Variabili[i].RifData then
      begin
        if LNomeVar = VAR_ANNO then
          LAnno:=A118MW.Variabili[i].ValoreInt
        else if LNomeVar = VAR_MESE then
          LMese:=A118MW.Variabili[i].ValoreInt
        else if LNomeVar = VAR_GIORNO then
          LGiorno:=A118MW.Variabili[i].ValoreInt
        else if LNomeVar = VAR_DATA then
          LData:=A118MW.Variabili[i].ValoreDate;
      end;
    end;

    // log
    TLogger.Debug('Filtro dipendente',LFiltroDipendente);
    TLogger.Debug('Anno',LAnno);
    TLogger.Debug('Mese',LMese);
    TLogger.Debug('Giorno',LGiorno);
    TLogger.Debug('Data',LData);

    // determina il progressivo di riferimento in base ai valori delle variabili anagrafiche
    LProgressivo:=0;
    try
      selT030.SetVariable('AZIENDA',Parametri.Azienda);
      selT030.SetVariable('FILTRO_DIPENDENTE',LFiltroDipendente);
      selT030.Execute;
      case selT030.RowCount of
        0: // errore: nessun progressivo
          begin
            Result.Messaggio:=Format('Nessun progressivo trovato con il filtro dipendente [%s]',[LFiltroDipendente]);
            TLogger.Error(Result.Messaggio);
          end;
        1: // ok
          begin
            LProgressivo:=selT030.FieldAsInteger(0);
          end
        else
        begin
          // errore: progressivi multipli
          Result.Messaggio:=Format('Trovati %d progressivi con il filtro dipendente [%s]',[selT030.RowCount,LFiltroDipendente]);
          TLogger.Error(Result.Messaggio);
        end;
      end;
    except
      on E: Exception do
      begin
        // errore ricerca progressivo
        Result.Messaggio:=Format('Errore ricerca progressivo con filtro dipendente [%s]',[LFiltroDipendente]);
        TLogger.Error(Result.Messaggio,E);
      end;
    end;

    // esce se non identifica il progressivo
    if LProgressivo = 0 then
    begin
      Result.Messaggio:=Format('File non indicizzato: %s'#13#10,[PLivObj.GetNomeFileCompleto]) + Result.Messaggio;
      Exit;
    end;

    // determina il periodo di riferimento in base ai valori delle variabili con riferimenti a periodo
    LPeriodoDal:=0;
    LPeriodoAl:=0;
    if LData <> 0 then
    begin
      // periodo: data specifica
      LPeriodoDal:=LData;
      LPeriodoAl:=LData;
    end
    else
    begin
      // periodo: data indicata come anno e/o mese e/o giorno
      if LAnno <> 0 then
      begin
        if LMese <> 0 then
        begin
          if LGiorno <> 0 then
          begin
            // periodo: giorno singolo
            LPeriodoDal:=EncodeDate(LAnno,LMese,LGiorno);
            LPeriodoAl:=LPeriodoDal;
          end
          else
          begin
            // periodo: mese intero
            LPeriodoDal:=EncodeDate(LAnno,LMese,1);
            LPeriodoAl:=LPeriodoDal.EndOfMonth.Date;
          end;
        end
        else
        begin
          // periodo: anno intero
          LPeriodoDal:=EncodeDate(LAnno,1,1);
          LPeriodoAl:=LPeriodoAl.EndOfYear.Date;
        end;
      end;
    end;

    // dimensione file
    LDimensioneFile:=R180GetFileSize(PLivObj.GetNomeFileCompleto);

    // imposta le variabili per l'inserimento ed inserisce il record
    try
      insT960.ClearVariables;
      insT960.SetVariable('OPERATORE',Parametri.Operatore);
      insT960.SetVariable('PROGRESSIVO',LProgressivo);
      insT960.SetVariable('TIPOLOGIA',LTipologia);
      insT960.SetVariable('UFFICIO',LUfficio);
      insT960.SetVariable('PATH_STORAGE',PLivObj.PathFile);
      insT960.SetVariable('NOME_FILE',PLivObj.NomeFile);
      insT960.SetVariable('EXT_FILE',PLivObj.ExtFile);
      insT960.SetVariable('DIMENSIONE_FILE',LDimensioneFile);
      if LPeriodoDal <> 0 then
        insT960.SetVariable('PERIODO_DAL',LPeriodoDal);
      if LPeriodoAl <> 0 then
        insT960.SetVariable('PERIODO_AL',LPeriodoAl);

      // esegue l'inserimento
      insT960.Execute;
      insT960.Session.Commit;
    except
      on E: Exception do
      begin
        // errore ricerca progressivo
        insT960.Session.Rollback;
        Result.Messaggio:=Format('Errore inserimento file su T960',[E.Message]);
        TLogger.Error(Result.Messaggio,E);
      end;
    end;

    // operazione eseguita correttamente
    Result.Ok:=True;
  finally
    TLogger.ExitMethod(NOME_METODO);
  end;
end;

end.
