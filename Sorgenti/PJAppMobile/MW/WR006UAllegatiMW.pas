unit WR006UAllegatiMW;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Generics.Collections, A000USessione, A000UCostanti, C180FunzioniGenerali,
  C021UDocumentiManagerDM, C018UIterAutDM, System.IOUtils, WM000UDataModuleBaseDM;

type
  TAllegato = class(TObject)
  public
    IdRichiesta: Integer;
    IdT960: Integer;
    NomeFile: String;
    ExtFile: String;
    Dimensione: Integer;
    Note: String;
  end;

  TWR006FAllegatiMW = class(TWM000FDataModuleBaseDM)
  private
    C018DM: TC018FIterAutDM;
    C021DM: TC021FDocumentiManagerDM;

    //FModuloIterAutorizzativi: Boolean;
    FMaxAllegati: Integer;
    FMaxDimAllegatoMB: Integer;
    FListaAllegati: TObjectList<TAllegato>;
  public
    //property ModuloIterAutoriz: Boolean read FModuloIterAutorizzativi;
    property MaxAllegati: Integer read FMaxAllegati;
    property ListaAllegati: TObjectList<TAllegato> read FListaAllegati;

    constructor Create(PSessioneIrisWin: TSessioneIrisWin; PSelTabellaIter: TDataSet; PIter: String; PAutorizzatore: Boolean); overload;
    destructor Destroy; override;

    function SalvaAllegatoDaDB(IdT960: Integer; Path: String; var NomeFile: String): TResCtrl;
    function InserisciAllegato(IdRichiesta: Integer; PNomeFile, PTempFile, PNote: String): TResCtrl;
    function ModificaAllegato(IdT960: Integer; PNote: String): TResCtrl;
    function EliminaAllegato(IdRichiesta, IdT960: Integer): TResCtrl;
    function AggiornaListaAllegati(IdRichiesta: Integer): TResCtrl;
    function MaxAllegatiSuperato: Boolean;
    function GetCondizioneAllegati: String;
    function GetNumeroAllegati(IdRichiesta: Integer): Integer;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

constructor TWR006FAllegatiMW.Create(PSessioneIrisWin: TSessioneIrisWin; PSelTabellaIter: TDataSet; PIter: String; PAutorizzatore: Boolean);
var LTipoIter: TC018TipoIter;
begin
  inherited Create(PSessioneIrisWin);

  C018DM:=nil;
  C021DM:=nil;

  //FModuloIterAutorizzativi:=SessioneIrisWin.Parametri.ModuloInstallato['ITER_AUTORIZZATIVI'];

  //if not FModuloIterAutorizzativi then //se non è presente il modulo ITER_AUTORIZZATIVI non posso usare la funzionalità
  //  Exit;

  C021DM:=TC021FDocumentiManagerDM.Create(Self);
  C021DM.CancellaFileTemp:=False;
  C018DM:=TC018FIterAutDM.Create(Self);

  if PAutorizzatore then
    LTipoIter:=tiAutorizzazione
  else
    LTipoIter:=tiRichiesta;

  C018DM.Responsabile:=PAutorizzatore;
  C018DM.AccessoReadOnly:=False;
  C018DM.Iter:=PIter;
  C018DM.PreparaDataSetIter(PSelTabellaIter, LTipoIter);

  FMaxAllegati:=StrToIntDef(SessioneIrisWin.Parametri.CampiRiferimento.C90_IterMaxAllegati,999);
  if FMaxAllegati < 0 then
    FMaxAllegati:=999;
  FMaxDimAllegatoMB:=StrToIntDef(SessioneIrisWin.Parametri.CampiRiferimento.C90_IterMaxDimAllegatoMB,5);

  FListaAllegati:=TObjectList<TAllegato>.Create(True);
end;

destructor TWR006FAllegatiMW.Destroy;
begin
  FreeAndNil(FListaAllegati);
  inherited;
end;

function TWR006FAllegatiMW.AggiornaListaAllegati(IdRichiesta: Integer): TResCtrl;
var LAllegato: TAllegato;
begin
  try
    Result.Clear;
    FListaAllegati.Clear;
    C018DM.Id:=IdRichiesta;
    C018DM.LeggiAllegati(False);

    C018DM.selT853_T960.First;
    while not C018DM.selT853_T960.Eof do
    begin
      LAllegato:=TAllegato.Create;

      LAllegato.IdRichiesta:=C018DM.selT853_T960.FieldByName('ID').AsInteger;
      LAllegato.IdT960:=C018DM.selT853_T960.FieldByName('ID_T960').AsInteger;
      LAllegato.NomeFile:=C018DM.selT853_T960.FieldByName('NOME_FILE').AsString;
      LAllegato.ExtFile:=C018DM.selT853_T960.FieldByName('EXT_FILE').AsString;
      LAllegato.Dimensione:=C018DM.selT853_T960.FieldByName('DIMENSIONE').AsInteger;
      LAllegato.Note:=C018DM.selT853_T960.FieldByName('NOTE').AsString;

      FListaAllegati.Add(LAllegato);

      C018DM.selT853_T960.Next;
    end;
    Result.Ok:=True;
  except
    on E: Exception do
      Result.Messaggio:=E.Message;
  end;
end;

function TWR006FAllegatiMW.SalvaAllegatoDaDB(IdT960: Integer; Path: String; var NomeFile: String): TResCtrl;
var LDoc: TDocumento;
begin
  try
    try
      Result:=C021DM.GetById(IdT960,True,LDoc);
      if not Result.Ok then
        Exit;

      NomeFile:=LDoc.GetNomeFileCompleto;

      if not TDirectory.Exists(Path) then
        TDirectory.CreateDirectory(Path);

      TFile.Copy(Ldoc.FilePath, TPath.Combine(Path, NomeFile));
    finally
      FreeAndNil(LDoc);
    end;
  except
    on E: Exception do
    begin
      Result.Ok:=False;
      Result.Messaggio:=E.Message;
    end;
  end;
end;

function TWR006FAllegatiMW.InserisciAllegato(IdRichiesta: Integer; PNomeFile, PTempFile, PNote: String): TResCtrl;
var LDoc: TDocumento;
    LDimMB: Double;
begin
  Result.Clear;
  try
    if not C018DM.selTabellaIter.Locate('ID', IdRichiesta, []) then
    begin
      Result.Messaggio:='Richiesta associata all''allegato selezionato non trovata';
      Exit;
    end;

    // crea oggetto documento
    LDoc:=TDocumento.Create;
    try
      LDoc.SetNomeFileCompleto(PNomeFile); //inserire il nome del file caricato
      LDoc.Progressivo:=C018DM.selTabellaIter.FieldByName('PROGRESSIVO').AsInteger;;
      LDoc.Tipologia:=DOC_TIPOL_ITER;
      LDoc.Ufficio:=DOC_UFFICIO_PREDEF;
      LDoc.PeriodoDal:=C018DM.selTabellaIter.FieldByName(C018DM.Periodo.ColonnaDal.Replace('T_ITER.','',[rfIgnoreCase])).AsDateTime;
      LDoc.PeriodoAl:=C018DM.selTabellaIter.FieldByName(C018DM.Periodo.ColonnaAl.Replace('T_ITER.','',[rfIgnoreCase])).AsDateTime;
      LDoc.PathStorage:=SessioneIrisWin.Parametri.CampiRiferimento.C90_PathAllegati;
      LDoc.Provenienza:=DOC_PROVENIENZA_INTERNA;
      LDoc.TempFile:=PTempFile;
      LDoc.Dimensione:=R180GetFileSize(LDoc.TempFile);
      LDoc.Note:=Trim(PNote);

      // controllo dimensione file
      LDimMB:=LDoc.Dimensione/BYTES_MB;
      if LDimMB > FMaxDimAllegatoMB then
      begin
        Result.Messaggio:=Format('La dimensione dell''allegato non può superare il limite di %d MB! (il file selezionato è di %f MB)',[FMaxDimAllegatoMB,LDimMB]);
        Exit;
      end;

      LDoc.CFFamiliare:='';
      if C018DM.Iter = ITER_GIUSTIF then
        if not C018DM.selTabellaIter.FieldByName('DATANAS').IsNull then
          LDoc.CFFamiliare:=C018DM.GetCFFamiliare(LDoc.Progressivo, C018DM.selTabellaIter.FieldByName('DATANAS').AsDateTime);

      try
        // salvataggio del documento
        Result:=C021DM.Save(LDoc);
        if not Result.Ok then
          Exit;

        // inserisce il riferimento all'allegato su T853
        C018DM.insT853.SetVariable('ID', IdRichiesta);
        C018DM.insT853.SetVariable('ID_T960', LDoc.Id);
        C018DM.insT853.Execute;

        // commit operazione
        SessioneOracle.Commit;
        Result.Ok:=True;
      except
        on E: Exception do
        begin
          SessioneOracle.Rollback;
          raise;
        end;
      end;
    finally
      FreeAndNil(LDoc);
    end;
  except
    on E: Exception do
    begin
      Result.Messaggio:=E.Message;
    end;
  end;
end;

function TWR006FAllegatiMW.MaxAllegatiSuperato: Boolean;
begin
  Result:=ListaAllegati.Count >= FMaxAllegati;
end;

function TWR006FAllegatiMW.ModificaAllegato(IdT960: Integer; PNote: String): TResCtrl;
var LDoc: TDocumento;
begin
  Result.Clear;
  LDoc:=nil;
  try
    try
      Result:=C021DM.GetById(IdT960, False, LDoc);
      if not Result.Ok then
        Exit;

      LDoc.Note:=Trim(PNote);
      // salvataggio del documento
      Result:=C021DM.Save(LDoc);
      if not Result.Ok then
        SessioneOracle.Rollback;
      // commit operazione
      SessioneOracle.Commit;
      Result.Ok:=True;
    finally
      FreeAndNil(LDoc);
    end;
  except
    on E: Exception do
    begin
      Result.Ok:=False;
      Result.Messaggio:=E.Message;
    end;
  end;
end;

function TWR006FAllegatiMW.EliminaAllegato(IdRichiesta, IdT960: Integer): TResCtrl;
begin
  Result.Clear;
  try
    // elimina il riferimento all'allegato dalla tabella T853
    C018DM.delT853.SetVariable('ID',IdRichiesta);
    C018DM.delT853.SetVariable('ID_T960',IdT960);
    C018DM.delT853.Execute;

    // elimina il documento da db
    Result:=C021DM.Delete(IdT960);

    if Result.Ok then
      SessioneOracle.Commit
    else
      SessioneOracle.Rollback;
  except
    on E: Exception do
      Result.Messaggio:=E.Message;
  end;
end;

function TWR006FAllegatiMW.GetCondizioneAllegati: String;
begin
  Result:=C018DM.GetCondizioneAllegati;
end;

function TWR006FAllegatiMW.GetNumeroAllegati(IdRichiesta: Integer): Integer;
begin
  try
    C018DM.Id:=IdRichiesta;
    C018DM.LeggiAllegati(False);

    Result:=C018DM.selT853_T960.RecordCount;
  except
    on E: Exception do
      Result:=0;
  end;
end;

end.
