unit WM018UMessaggisticaDM;

interface

uses
  System.SysUtils, System.Classes, WM000UDataModuleBaseDM, Data.DB, OracleData, Generics.Collections, Generics.Defaults, System.IOUtils,
  Oracle, A000UInterfaccia, A000UCostanti, StrUtils, C180FunzioniGenerali, System.Math, Variants, OracleMonitor;

type
  TModalitaMessaggi = (MMRicevuti, MMInviati);
  TFiltroDestinatari = (FDTutti, FDRicevuto, FDNonRicevuto);

  TFiltroMessaggi = class
  public
    Inizio: TDateTime;
    Fine: TDateTime;
    Ricerca: String;
  end;

  TFiltroMessaggiRicevuti = class(TFiltroMessaggi)
  public
    DaLeggere: Boolean;
    Letti: Boolean;
    Cancellati: Boolean;
    CodMittente: String;
    constructor Create;
  end;

  TFiltroMessaggiInviati = class(TFiltroMessaggi)
  public
    Sospesi: Boolean;
    Inviati: Boolean;
    Cancellati: Boolean;
    SelAnagrafica: String;
    constructor Create;
  end;

  TAllegatoMessaggio = class(TObject)
  private
    FNome: String;
    FDimensione: Integer;
  public
    property Nome: String read FNome write FNome;
    property Dimensione: Integer read FDimensione write FDimensione;

    constructor Create(PNome: String; PDimensione: Integer);
  end;

  TDestinatario = class(TObject)
  public
    DataLettura: TDateTime;
    DataRicezione: TDateTime;
  end;

  TDestinatarioWeb = class(TDestinatario)
  public
    Progressivo: Integer;
    Matricola: String;
    Cognome: String;
    Nome: String;
  end;

  TDestinatarioWin = class(TDestinatario)
  public
    Utente: String;
  end;

  TMessaggio = class(TObject)
  private
    FId: Integer;
    FStato: String;
    FCodMittente: String;
    FDescrMittente: String;
    FSelAnagrafica: String;
    FOggetto: String;
    FDataInvio: TDateTime;
    FTesto: String;
    FAllegati: Boolean;
    FListaAllegati: TObjectList<TAllegatoMessaggio>;
    FLetturaObbligatoria: Boolean;
  public
    property Id: Integer read FId write FId;
    property Stato: String read FStato write FStato;
    property CodMittente: String read FCodMittente write FCodMittente;
    property DescrMittente: String read FDescrMittente write FDescrMittente;
    property SelAnagrafica: String read FSelAnagrafica write FSelAnagrafica;
    property Oggetto: String read FOggetto write FOggetto;
    property DataInvio: TDateTime read FDataInvio write FDataInvio;
    property Testo: String read FTesto write FTesto;
    property Allegati: Boolean read FAllegati write FAllegati;
    property ListaAllegati: TObjectList<TAllegatoMessaggio> read FListaAllegati write FListaAllegati;
    property LetturaObbligatoria: Boolean read FLetturaObbligatoria write FLetturaObbligatoria;

    destructor Destroy; override;
  end;

  TMessaggioRicevuto = class(TMessaggio)
  private
    FDataLettura: TDateTime;
    FDataRicezione: TDateTime;
  public
    property DataLettura: TDateTime read FDataLettura write FDataLettura;
    property DataRicezione: TDateTime read FDataRicezione write FDataRicezione;
  end;

  TMessaggioInviato = class(TMessaggio)
  private
    FDestinatari: String;
    FDestLetti: Integer;
    FDestRicevuti: Integer;
    FDestTotali: Integer;
    FListaDestinatari: TObjectList<TDestinatario>;
  public
    property Destinatari: String read FDestinatari write FDestinatari;
    property DestLetti: Integer read FDestLetti write FDestLetti;
    property DestRicevuti: Integer read FDestRicevuti write FDestRicevuti;
    property DestTotali: Integer read FDestTotali write FDestTotali;
    property ListaDestinatari: TObjectList<TDestinatario> read FListaDestinatari write FListaDestinatari;

    constructor Create;
    destructor Destroy; override;
  end;

  TWM018FMessaggisticaDM = class(TWM000FDataModuleBaseDM)
    selElencoMsg: TOracleDataSet;
    selElencoMsgLEVEL: TFloatField;
    selElencoMsgID: TFloatField;
    selElencoMsgID_ORIGINALE: TFloatField;
    selElencoMsgOGGETTO: TStringField;
    selElencoMsgDATA_INVIO: TDateTimeField;
    selElencoMsgSTATO: TStringField;
    selElencoMsgMITTENTE: TStringField;
    selElencoMsgD_MITTENTE: TStringField;
    selElencoMsgD_DESTINATARI: TStringField;
    selElencoMsgTESTO: TStringField;
    updT284Ricezione: TOracleQuery;
    selT282Inviati: TOracleDataSet;
    selT282InviatiD_MITTENTE: TStringField;
    selT282InviatiD_STATO: TStringField;
    selT282InviatiLETTURA_OBBLIGATORIA: TStringField;
    selT282InviatiRICEVENTE: TStringField;
    selT282InviatiDATA_INVIO: TDateTimeField;
    selT282InviatiOGGETTO: TStringField;
    selT282InviatiTESTO: TStringField;
    selT282InviatiD_PERC_LETTURA: TFloatField;
    selT282InviatiD_PERC_RICEZIONE: TFloatField;
    selT282InviatiD_ALLEGATI: TFloatField;
    selT282InviatiSELEZIONE_ANAGRAFICA: TStringField;
    selT282InviatiD_DESTINATARI: TStringField;
    selT282InviatiD_STATO_LETTURA: TStringField;
    selT282InviatiD_STATO_RICEZIONE: TStringField;
    selT282InviatiD_DEST_LETTI: TFloatField;
    selT282InviatiD_DEST_RICEVUTI: TFloatField;
    selT282InviatiD_DEST_TOT: TFloatField;
    selT282InviatiID2: TFloatField;
    selT282InviatiSTATO: TStringField;
    selT282InviatiMITTENTE: TStringField;
    selT282InviatiID_ORIGINALE: TFloatField;
    selT282InviatiD_RISPOSTE_TOT: TFloatField;
    selT283DimAllegati: TOracleQuery;
    updT284Lettura: TOracleQuery;
    selT282Ricevuti: TOracleDataSet;
    selT282RicevutiDATA_LETTURA: TDateTimeField;
    selT282RicevutiLETTURA_OBBLIGATORIA: TStringField;
    selT282RicevutiD_MITTENTE: TStringField;
    selT282RicevutiD_STATO: TStringField;
    selT282RicevutiRICEVENTE: TStringField;
    selT282RicevutiDATA_INVIO: TDateTimeField;
    selT282RicevutiOGGETTO: TStringField;
    selT282RicevutiTESTO: TStringField;
    selT282RicevutiPROGRESSIVO: TIntegerField;
    selT282RicevutiD_ALLEGATI: TFloatField;
    selT282RicevutiSELEZIONE_ANAGRAFICA: TStringField;
    selT282RicevutiID: TFloatField;
    selT282RicevutiSTATO: TStringField;
    selT282RicevutiMITTENTE: TStringField;
    selT282RicevutiDATA_RICEZIONE: TDateTimeField;
    selT282RicevutiID_ORIGINALE: TFloatField;
    selT282RicevutiD_RISPOSTE_TOT: TFloatField;
    selT283: TOracleDataSet;
    selT283Allegato: TOracleQuery;
    selT284: TOracleDataSet;
    selT285: TOracleDataSet;
  private
    selTabella: TOracleDataset;  // selT282Ricevuti o selT282Inviati
    function GetFiltroMessaggiRicevuti(PFiltro: TFiltroMessaggiRicevuti): String;
    function GetFiltroMessaggiInviati(PFiltro: TFiltroMessaggiInviati): String;

    function GetFiltroPeriodo(PInizio, PFine: TDateTime): String;
    //procedure AggiornaMessaggi(PFiltro: TFiltroMessaggi);
  public
    procedure SetModalita(const Value: TModalitaMessaggi; PFiltro: TFiltroMessaggi);
    function GetListaMessaggi(const PModalita: TModalitaMessaggi; PFiltro: TFiltroMessaggi): TObjectList<TMessaggio>;
    function GetListaAllegati(PId: Integer): TObjectList<TAllegatoMessaggio>;
    function GetFileAllegato(PId: Integer; PNomeFile, PPath: String): String;
    function GetListaDestinatari(PId: Integer; PFiltro: TFiltroDestinatari): TObjectList<TDestinatario>;
    procedure AggiornaStatoRicezione(PProgressivo, PId: Integer; PDataRicezione: TDateTime);
    procedure AggiornaStatoLettura(PProgressivo, PId: Integer; PDataLettura: TDateTime);
  end;

const
  // stati del messaggio (dominio di valori da tabella db)
  STATO_MSG_SOSPESO                 = 'S';
  STATO_MSG_CANCELLATO              = 'C';
  STATO_MSG_INVIATO                 = 'I';

  LIMITE_DESTINATARI_VISUALIZZATI   = 2;      // limite di destinatari visualizzati in modo esplicito

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TWM018FMessaggisticaDM.SetModalita(const Value: TModalitaMessaggi; PFiltro: TFiltroMessaggi);
begin
  if Value = TModalitaMessaggi.MMRicevuti then
  begin
    // messaggi destinati all'operatore web
    selTabella:=selT282Ricevuti;
    selTabella.Close;
    selTabella.SetVariable('PROGRESSIVO', Parametri.ProgressivoOper);

    selTabella.SetVariable('FILTRO_VIS', GetFiltroMessaggiRicevuti(PFiltro as TFiltroMessaggiRicevuti));
  end
  else
  begin
    // messaggi inviati dall'operatore web
    selTabella:=selT282Inviati;
    selTabella.Close;
    selTabella.SetVariable('MITTENTE',Parametri.Operatore);
    selTabella.SetVariable('LIMITE_DEST',LIMITE_DESTINATARI_VISUALIZZATI);

    selTabella.SetVariable('FILTRO_VIS', GetFiltroMessaggiInviati(PFiltro as TFiltroMessaggiInviati));
  end;

  // apre dataset
  selTabella.Open;
end;

function TWM018FMessaggisticaDM.GetFiltroMessaggiInviati(PFiltro: TFiltroMessaggiInviati): String;
var
    Filtro, FiltroPeriodo, FiltroStato, FiltroAnagrafica, FiltroRicerca: String;
begin
  Result:='';

  FiltroPeriodo:='';
  if PFiltro.Inviati then
    FiltroPeriodo:=GetFiltroPeriodo(PFiltro.Inizio, PFiltro.Fine);

  // filtro stato
  // filtro stato (e periodo invio)
  FiltroStato:='';
  // sospesi
  if PFiltro.Sospesi then
    FiltroStato:=Format('(T282.STATO = ''%s'')',[STATO_MSG_SOSPESO]);
  // inviati
  if PFiltro.Inviati then
  begin
    Filtro:=Format('(T282.STATO = ''%s'')',[STATO_MSG_INVIATO]);
    if FiltroPeriodo <> '' then
      Filtro:=Format('(%s and %s)',[Filtro,FiltroPeriodo]);
    FiltroStato:=FiltroStato + IfThen(FiltroStato <> '',' or ') + Filtro;
  end;
  // cancellati
  if PFiltro.Cancellati then
  begin
    Filtro:=Format('(T282.STATO = ''%s'')',[STATO_MSG_CANCELLATO]);
    FiltroStato:=FiltroStato + IfThen(FiltroStato <> '',' or ') + Filtro;
  end;

  FiltroStato:=Format('(%s)',[FiltroStato]);
  Result:=' and ' + FiltroStato;

  // filtro selezione anagrafica
  if PFiltro.SelAnagrafica <> '' then
  begin
    FiltroAnagrafica:=Format(' and (T282.SELEZIONE_ANAGRAFICA = ''%s'')', [PFiltro.SelAnagrafica]);
    Result:=Result + FiltroAnagrafica;
  end;

  // filtro per oggetto / testo (case-insensitive)
  if PFiltro.Ricerca.Trim <> '' then
  begin
    FiltroRicerca:=UpperCase(AggiungiApice(PFiltro.Ricerca.Trim));
    FiltroRicerca:=Format(' and ((UPPER(T282.OGGETTO) like ''%%%s%%'') or (UPPER(T282.TESTO) like ''%%%s%%''))',[FiltroRicerca, FiltroRicerca]);
    Result:=Result + FiltroRicerca;
  end;
end;

function TWM018FMessaggisticaDM.GetFiltroMessaggiRicevuti(PFiltro: TFiltroMessaggiRicevuti): String;
// restituisce una stringa sql che rappresenta la parte di "where" valorizzata
// in base ai filtri attualmente indicati nell'interfaccia
var
  FiltroPeriodo, FiltroStato, FiltroLettura, FiltroMittente, FiltroRicerca: String;
  LInviati: Boolean;
begin
  Result:='';

  if (PFiltro.DaLeggere) or (PFiltro.Letti) then
    LInviati:=True
  else if (PFiltro.Cancellati) then
    LInviati:=False;

  FiltroStato:='';
  FiltroPeriodo:='';
  if LInviati then //inviati
  begin
    FiltroPeriodo:=GetFiltroPeriodo(PFiltro.Inizio, PFiltro.Fine);

    FiltroStato:=Format('(T282.STATO = ''%s'')',[STATO_MSG_INVIATO]);
    if FiltroPeriodo <> '' then
      FiltroStato:=Format('(%s and %s)',[FiltroStato, FiltroPeriodo]);
  end
  else //cancellati
    FiltroStato:=Format('(T282.STATO = ''%s'')',[STATO_MSG_CANCELLATO]);

  Result:=' and ' + FiltroStato;

  if LInviati then
  begin
    // filtro da leggere / letti
    if (PFiltro.DaLeggere) and (PFiltro.Letti) then
      FiltroLettura:=''
    else if PFiltro.DaLeggere then
      FiltroLettura:=' and (T_DEST.DATA_LETTURA is null)'
    else if PFiltro.Letti then
      FiltroLettura:=' and (T_DEST.DATA_LETTURA is not null)';

    Result:=Result + FiltroLettura;
  end;

  // filtro mittente
  if PFiltro.CodMittente.Trim <> '' then
  begin
    FiltroMittente:=Format(' and (T282.MITTENTE = ''%s'')', [AggiungiApice(PFiltro.CodMittente.Trim)]);
    Result:=Result + FiltroMittente;
  end;

  // filtro per oggetto / testo (case-insensitive)
  if PFiltro.Ricerca.Trim <> '' then
  begin
    FiltroRicerca:=UpperCase(AggiungiApice(PFiltro.Ricerca.Trim));
    FiltroRicerca:=Format(' and ((UPPER(T282.OGGETTO) like ''%%%s%%'') or (UPPER(T282.TESTO) like ''%%%s%%''))',[FiltroRicerca, FiltroRicerca]);
    Result:=Result + FiltroRicerca;
  end;
end;

function TWM018FMessaggisticaDM.GetFiltroPeriodo(PInizio, PFine: TDateTime): String;
begin
  Result:='';
  // filtro periodo di invio
  if PInizio > PFine then
    raise Exception.Create('Il periodo di invio non è valido!');

  // impostazione filtro
  if (PInizio = DATE_MIN) and (PFine = DATE_MAX) then
    // periodo non indicato
    Exit
  else if PInizio = PFine then
    // periodo di un solo giorno
    Result:=Format('(trunc(T282.DATA_INVIO) = to_date(''%s'',''dd/mm/yyyy''))',[FormatDateTime('dd/mm/yyyy',PInizio)])
  else if PInizio = DATE_MIN then
    // periodo <= di una data
    Result:=Format('(trunc(T282.DATA_INVIO) <= to_date(''%s'',''dd/mm/yyyy''))',[FormatDateTime('dd/mm/yyyy',PFine)])
  else if PFine = DATE_MAX then
    // periodo >= di una data
    Result:=Format('(trunc(T282.DATA_INVIO) >= to_date(''%s'',''dd/mm/yyyy''))',[FormatDateTime('dd/mm/yyyy',PInizio)])
  else
    // periodo di più giorni compreso fra due date
    Result:=Format('(trunc(T282.DATA_INVIO) >= to_date(''%s'',''dd/mm/yyyy'') and trunc(T282.DATA_INVIO) <= to_date(''%s'',''dd/mm/yyyy''))',[FormatDateTime('dd/mm/yyyy',PInizio),FormatDateTime('dd/mm/yyyy',PFine)]);
end;

{procedure TWM018FMessaggisticaDM.AggiornaMessaggi(PFiltro: TFiltroMessaggi);
// aggiornamento visualizzazione tabella messaggi
begin
  // reimposta filtro visualizzazione
  selTabella.Close;

  if PFiltro is TFiltroMessaggiRicevuti then
    selTabella.SetVariable('FILTRO_VIS', GetFiltroMessaggiRicevuti(PFiltro as TFiltroMessaggiRicevuti));
  selTabella.Open;
end;}

function TWM018FMessaggisticaDM.GetListaAllegati(PId: Integer): TObjectList<TAllegatoMessaggio>;
begin
  Result:=TObjectList<TAllegatoMessaggio>.Create(True);

  selT283.Close;
  selT283.SetVariable('ID', PId);
  selT283.Open;

  with selT283 do
  begin
    while not Eof do
    begin
      Result.Add(TAllegatoMessaggio.Create(FieldByName('NOME').AsString, FieldByName('DIMENSIONE').AsInteger));
      Next;
    end;
  end;
end;

function TWM018FMessaggisticaDM.GetListaDestinatari(PId: Integer; PFiltro: TFiltroDestinatari): TObjectList<TDestinatario>;
var temp: TDestinatario;
    LFiltro: String;
begin
  if PFiltro = TFiltroDestinatari.FDRicevuto then
    LFiltro:='and DATA_RICEZIONE is not null'
  else if PFiltro = TFiltroDestinatari.FDNonRicevuto then
    LFiltro:='and DATA_RICEZIONE is null'
  else
    LFiltro:='';

  selT284.Close;
  selT284.SetVariable('ID', PId);
  selT284.SetVariable('FILTRO', LFiltro);
  selT284.Open;

  selT285.Close;
  selT285.SetVariable('ID', PId);
  selT285.SetVariable('FILTRO', LFiltro);
  selT285.Open;

  Result:=TObjectList<TDestinatario>.Create(True);

  while not selT284.Eof do
  begin
    temp:=TDestinatarioWeb.Create;

    with (temp as TDestinatarioWeb) do
    begin
      DataLettura:=selT284.FieldByName('DATA_LETTURA').AsDateTime;
      DataRicezione:=selT284.FieldByName('DATA_RICEZIONE').AsDateTime;
      Progressivo:=selT284.FieldByName('PROGRESSIVO').AsInteger;
      Matricola:=selT284.FieldByName('MATRICOLA').AsString;
      Cognome:=selT284.FieldByName('COGNOME').AsString;
      Nome:=selT284.FieldByName('NOME').AsString;
    end;

    Result.Add(temp);
    selT284.Next;
  end;

  while not selT285.Eof do
  begin
    temp:=TDestinatarioWin.Create;

    with (temp as TDestinatarioWin) do
    begin
      DataLettura:=selT285.FieldByName('DATA_LETTURA').AsDateTime;
      DataRicezione:=selT285.FieldByName('DATA_RICEZIONE').AsDateTime;
      Utente:=selT285.FieldByName('UTENTE').AsString;
    end;

    Result.Add(temp);
    selT285.Next;
  end;
end;

function TWM018FMessaggisticaDM.GetListaMessaggi(const PModalita: TModalitaMessaggi; PFiltro: TFiltroMessaggi): TObjectList<TMessaggio>;
var LMessaggio: TMessaggio;
begin
  SetModalita(PModalita, PFiltro);
  Result:=TObjectList<TMessaggio>.Create(True);

  selTabella.First;
  with selTabella do
  begin
    while not Eof do
    begin
      if PModalita = TModalitaMessaggi.MMRicevuti then
        LMessaggio:=TMessaggioRicevuto.Create
      else
        LMessaggio:=TMessaggioInviato.Create;

      try
        LMessaggio.Id:=FieldByName('ID').AsInteger;
        LMessaggio.Stato:=FieldByName('STATO').AsString;
        LMessaggio.CodMittente:=FieldByName('MITTENTE').AsString;
        LMessaggio.DescrMittente:=FieldByName('D_MITTENTE').AsString;
        LMessaggio.SelAnagrafica:=FieldByName('SELEZIONE_ANAGRAFICA').AsString;
        LMessaggio.Oggetto:=FieldByName('OGGETTO').AsString;
        LMessaggio.DataInvio:=FieldByName('DATA_INVIO').AsDateTime;
        LMessaggio.Testo:=FieldByName('TESTO').AsString;
        LMessaggio.Allegati:=FieldByName('D_ALLEGATI').AsInteger <> 0;
        LMessaggio.ListaAllegati:=TObjectList<TAllegatoMessaggio>.Create;
        LMessaggio.LetturaObbligatoria:=FieldByName('LETTURA_OBBLIGATORIA').AsString = 'S';

        if LMessaggio is TMessaggioRicevuto then
        begin
          (LMessaggio as TMessaggioRicevuto).DataLettura:=FieldByName('DATA_LETTURA').AsDateTime;
          (LMessaggio as TMessaggioRicevuto).DataRicezione:=FieldByName('DATA_RICEZIONE').AsDateTime;
        end
        else
        begin
          (LMessaggio as TMessaggioInviato).Destinatari:=FieldByName('D_DESTINATARI').AsString;
          (LMessaggio as TMessaggioInviato).DestTotali:=FieldByName('D_DEST_TOT').AsInteger;
          (LMessaggio as TMessaggioInviato).DestRicevuti:=FieldByName('D_DEST_RICEVUTI').AsInteger;
          (LMessaggio as TMessaggioInviato).DestLetti:=FieldByName('D_DEST_LETTI').AsInteger;
        end;

      except
        on E: Exception do
        begin
          FreeAndNil(LMessaggio);
          raise;
        end;
      end;
      Result.Add(LMessaggio);
      Next;
    end;
  end;
end;

function TWM018FMessaggisticaDM.GetFileAllegato(PId: Integer; PNomeFile, PPath: String): String;
var Blob: TLOBLocator;
begin
  Result:='';

  selT283Allegato.SetVariable('ID', PId);
  selT283Allegato.SetVariable('NOME', PNomeFile);
  selT283Allegato.Execute;
  Blob:=selT283Allegato.LOBField('ALLEGATO');

  if Blob.IsNull then
    raise Exception.Create(Format('Il file "%s" non è presente nel database', [PNomeFile]))
  else
  begin
    // salva il blob in un file
    // se un file con lo stesso nome esiste già, lo elimina
    if not TDirectory.Exists(PPath) then
        TDirectory.CreateDirectory(PPath);

    PPath:=TPath.Combine(PPath, PNomeFile);
    if FileExists(PPath) then
      DeleteFile(PPath);
    Blob.SaveToFile(PPath);

    Result:=PPath;
  end;
end;

procedure TWM018FMessaggisticaDM.AggiornaStatoLettura(PProgressivo, PId: Integer; PDataLettura: TDateTime);
begin
  // aggiorna la data di lettura
  updT284Lettura.SetVariable('PROGRESSIVO', PProgressivo);
  updT284Lettura.SetVariable('ID', PId);

  if PDataLettura <> DATE_NULL then
    updT284Lettura.SetVariable('DATA_LETTURA', PDataLettura)
  else
    updT284Lettura.SetVariable('DATA_LETTURA', null);
  try
    updT284Lettura.Execute;
    SessioneOracle.Commit;
  except
    on E: Exception do
    begin
      SessioneOracle.Rollback;
      raise;
    end;
  end;
end;

procedure TWM018FMessaggisticaDM.AggiornaStatoRicezione(PProgressivo, PId: Integer; PDataRicezione: TDateTime);
// imposta lo stato di ricezione del messaggio a "ricevuto"
begin
  // aggiorna data ricezione
  updT284Ricezione.SetVariable('PROGRESSIVO', PProgressivo);
  updT284Ricezione.SetVariable('ID', PId);
  updT284Ricezione.SetVariable('DATA_RICEZIONE', PDataRicezione);
  try
    updT284Ricezione.Execute;
    SessioneOracle.Commit;
  except
    on E: Exception do
    begin
      SessioneOracle.Rollback;
      raise;
    end;
  end;
end;

{ TAllegatoMessaggio }

constructor TAllegatoMessaggio.Create(PNome: String; PDimensione: Integer);
begin
  FNome:=PNome;
  FDimensione:=PDimensione;
end;

{ TMessaggio }

destructor TMessaggio.Destroy;
begin
  FreeAndNil(FListaAllegati);
  inherited;
end;

{ TFiltroMessaggiRicevuti }

constructor TFiltroMessaggiRicevuti.Create;
begin
  inherited;

  DaLeggere:=False;
  Letti:=False;
  Cancellati:=False;
  CodMittente:='';
end;

{ TFiltroMessaggiInviati }

constructor TFiltroMessaggiInviati.Create;
begin
  inherited;

  Sospesi:=False;
  Inviati:=False;
  Cancellati:=False;
  SelAnagrafica:='';
end;

{ TMessaggioInviato }

constructor TMessaggioInviato.Create;
begin
  FListaDestinatari:=nil;
end;

destructor TMessaggioInviato.Destroy;
begin
  FreeAndNil(FListaDestinatari);
  inherited;
end;

end.
