unit WM018UMessaggisticaMW;

interface

uses
  System.SysUtils, System.Classes, WM000UDataModuleBaseDM, Generics.Collections, A000UCostanti,
  WM018UMessaggisticaDM, A000USessione, Generics.Defaults;

type
  TWM018FMessaggisticaMW = class(TWM000FDataModuleBaseDM)
  private
    WM018DM: TWM018FMessaggisticaDM;
    FProgressivo: Integer;
    FModalita: TModalitaMessaggi;
    FIdxMessaggio: Integer;
    FListaMessaggi: TObjectList<TMessaggio>;
    FListaMittenti: TList<TPair<String, String>>;
    FListaSelAnagrafica: TList<String>;

    function GetFiltroMessaggiRicevuti(PDataDal, PDataAl: TDateTime; PDaLeggere, PLetti, PCancellati: Boolean; PMittente, PRicerca: String): TFiltroMessaggiRicevuti;
    function GetFiltroMessaggiInviati(PDataDal, PDataAl: TDateTime; PSospesi, PInviati, PCancellati: Boolean; PSelAnagrafica, PRicerca: String): TFiltroMessaggiInviati;
    procedure AggiornaListaMittenti;
    procedure AggiornaListaSelAnagrafica;
    function GetMessaggioSelezionato: TMessaggio;
  public
    property IdxMessaggio: Integer read FIdxMessaggio;
    property Modalita: TModalitaMessaggi read FModalita write FModalita;
    property MessaggioSelezionato: TMessaggio read GetMessaggioSelezionato;
    property ListaMessaggi: TObjectList<TMessaggio> read FListaMessaggi;
    property ListaMittenti: TList<TPair<String, String>> read FListaMittenti;
    property ListaSelAnagrafica: TList<String> read FListaSelAnagrafica;

    constructor Create(PSessioneIrisWin: TSessioneIrisWin); overload;
    destructor Destroy; override;

    function AggiornaListaMessaggiRicevuti(PDataDal, PDataAl: TDateTime; PDaLeggere, PLetti, PCancellati: Boolean; PMittente, PRicerca: String): TResCtrl;
    function AggiornaListaMessaggiInviati(PDataDal, PDataAl: TDateTime; PSospesi, PInviati, PCancellati: Boolean; PSelAnagrafica, PRicerca: String): TResCtrl;
    function AggiornaStatoRicezione: TResCtrl;
    function AggiornaStatoLettura(PLetto: Boolean): TResCtrl;
    function AggiornaDestMessaggioSelezionato(PFiltro: TFiltroDestinatari): TResCtrl;
    function ObbligatoriDaLeggerePresenti: Boolean;
    function ObbligatoriDaLeggerePresentiAgg: Boolean;
    function GetNumMessaggiDaLeggere: Integer;
    function SelezionaMessaggioById(PId: Integer): TMessaggio;
    function AggiornaAllegatiMessaggio(PMessaggio: TMessaggio): TResCtrl;
    function DownloadAllegato(PId: Integer; PNome, PPath: String): TResCtrl;
    function Prior: Boolean;
    function Next: Boolean;
    function Eof: Boolean;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TWM018FMessaggisticaMW }

constructor TWM018FMessaggisticaMW.Create(PSessioneIrisWin: TSessioneIrisWin);
begin
  inherited Create(PSessioneIrisWin);

  FProgressivo:=PSessioneIrisWin.Parametri.ProgressivoOper;
  FIdxMessaggio:=-1;
  FListaMessaggi:=nil;
  FListaMittenti:=nil;
  FListaSelAnagrafica:=nil;

  WM018DM:=TWM018FMessaggisticaDM.Create(PSessioneIrisWin);
end;

destructor TWM018FMessaggisticaMW.Destroy;
begin
  FreeAndNil(FListaMessaggi);
  FreeAndNil(FListaMittenti);
  FreeAndNil(FListaSelAnagrafica);
  FreeAndNil(WM018DM);
  inherited;
end;

function TWM018FMessaggisticaMW.GetFiltroMessaggiRicevuti(PDataDal, PDataAl: TDateTime; PDaLeggere, PLetti, PCancellati: Boolean; PMittente, PRicerca: String): TFiltroMessaggiRicevuti;
begin
  Result:=TFiltroMessaggiRicevuti.Create;

  with Result do
  begin
    if PDataDal = DATE_NULL then
      Inizio:=DATE_MIN
    else
      Inizio:=PDataDal;

    if PDataAl = DATE_NULL then
      Fine:=DATE_MAX
    else
      Fine:=PDataAl;

    DaLeggere:=PDaLeggere;
    Letti:=PLetti;
    Cancellati:=PCancellati;
    CodMittente:=PMittente;
    Ricerca:=Trim(PRicerca);
  end;
end;

function TWM018FMessaggisticaMW.GetNumMessaggiDaLeggere: Integer;
var LFiltro: TFiltroMessaggiRicevuti;
begin
  Result:=0;
  try
    FModalita:=TModalitaMessaggi.MMRicevuti;
    LFiltro:=GetFiltroMessaggiRicevuti(DATE_NULL, DATE_NULL, True, False, False, '', '');

    if Assigned(FListaMessaggi) then
      FreeAndNil(FListaMessaggi);

    FListaMessaggi:=WM018DM.GetListaMessaggi(FModalita, LFiltro);
    Result:=FListaMessaggi.Count;
  finally
    FreeAndNil(LFiltro);
  end;
end;

function TWM018FMessaggisticaMW.ObbligatoriDaLeggerePresenti: Boolean;
var i: Integer;
begin
  Result:=False;

  if Assigned(FListaMessaggi) then
  begin
    for i:=0 to FListaMessaggi.Count-1 do
    begin
      if FListaMessaggi[i].LetturaObbligatoria then
      begin
        Result:=True;
        Exit;
      end;
    end;
  end;
end;

function TWM018FMessaggisticaMW.ObbligatoriDaLeggerePresentiAgg: Boolean;
var LFiltro: TFiltroMessaggiRicevuti;
begin
  Result:=False;
  try
    FModalita:=TModalitaMessaggi.MMRicevuti;
    LFiltro:=GetFiltroMessaggiRicevuti(DATE_NULL, DATE_NULL, True, False, False, '', '');

    if Assigned(FListaMessaggi) then
      FreeAndNil(FListaMessaggi);

    try
      FListaMessaggi:=WM018DM.GetListaMessaggi(FModalita, LFiltro);

      Result:=ObbligatoriDaLeggerePresenti;
    except
      on E: Exception do
      begin
        Result:=False;
        Exit;
      end;
    end;
  finally
    FreeAndNil(LFiltro);
  end;
end;

function TWM018FMessaggisticaMW.GetFiltroMessaggiInviati(PDataDal, PDataAl: TDateTime; PSospesi, PInviati, PCancellati: Boolean; PSelAnagrafica, PRicerca: String): TFiltroMessaggiInviati;
begin
  Result:=TFiltroMessaggiInviati.Create;

  with Result do
  begin
    if PDataDal = DATE_NULL then
      Inizio:=DATE_MIN
    else
      Inizio:=PDataDal;

    if PDataAl = DATE_NULL then
      Fine:=DATE_MAX
    else
      Fine:=PDataAl;

    Sospesi:=PSospesi;
    Inviati:=PInviati;
    Cancellati:=PCancellati;
    SelAnagrafica:=PSelAnagrafica;
    Ricerca:=Trim(PRicerca);
  end;
end;

function TWM018FMessaggisticaMW.AggiornaDestMessaggioSelezionato(PFiltro: TFiltroDestinatari): TResCtrl;
var temp: TObjectList<TDestinatario>;
begin
  Result.Clear;
  try
    if Assigned(FListaMessaggi) and (FIdxMessaggio >= 0) and (FListaMessaggi[FIdxMessaggio] is TMessaggioInviato) then
    begin
      with (FListaMessaggi[FIdxMessaggio] as TMessaggioInviato) do
      begin
        if Assigned(ListaDestinatari) then
        begin
          temp:=ListaDestinatari;
          FreeAndNil(temp);
          ListaDestinatari:=nil;
        end;

        ListaDestinatari:=WM018DM.GetListaDestinatari(FListaMessaggi[FIdxMessaggio].Id, PFiltro);
        Result.Ok:=True;
      end;
    end
    else
      Result.Messaggio:='Stato oggetto non valido';
  except
    on E: Exception do
      Result.Messaggio:=E.Message;
  end;
end;

function TWM018FMessaggisticaMW.AggiornaListaMessaggiInviati(PDataDal, PDataAl: TDateTime; PSospesi, PInviati, PCancellati: Boolean; PSelAnagrafica, PRicerca: String): TResCtrl;
var LFiltro: TFiltroMessaggiInviati;
begin
  Result.Clear;
  try
    LFiltro:=GetFiltroMessaggiInviati(PDataDal, PDataAl, PSospesi, PInviati, PCancellati, PSelAnagrafica, PRicerca);

    if Assigned(FListaMessaggi) then
      FreeAndNil(FListaMessaggi);

    try
      FListaMessaggi:=WM018DM.GetListaMessaggi(FModalita, LFiltro);
      AggiornaListaSelAnagrafica;

      Result.Ok:=True;
    except
      on E: Exception do
      begin
        Result.Messaggio:='Errore durante l''aggiornamento della lista dei messagi inviati: ' + E.Message;
      end;
    end;
  finally
    FreeAndNil(LFiltro);
  end;
end;

function TWM018FMessaggisticaMW.AggiornaListaMessaggiRicevuti(PDataDal, PDataAl: TDateTime; PDaLeggere, PLetti, PCancellati: Boolean; PMittente, PRicerca: String): TResCtrl;
var LFiltro: TFiltroMessaggiRicevuti;
begin
  Result.Clear;
  try
    LFiltro:=GetFiltroMessaggiRicevuti(PDataDal, PDataAl, PDaLeggere, PLetti, PCancellati, PMittente, PRicerca);

    if Assigned(FListaMessaggi) then
      FreeAndNil(FListaMessaggi);

    try
      FListaMessaggi:=WM018DM.GetListaMessaggi(FModalita, LFiltro);
      AggiornaListaMittenti;

      Result.Ok:=True;
    except
      on E: Exception do
      begin
        Result.Messaggio:='Errore durante l''aggiornamento della lista dei messagi ricevuti: ' + E.Message;
      end;
    end;
  finally
    FreeAndNil(LFiltro);
  end;
end;

function TWM018FMessaggisticaMW.AggiornaAllegatiMessaggio(PMessaggio: TMessaggio): TResCtrl;
var tempList: TObjectList<TAllegatoMessaggio>;
begin
  Result.Clear;

  tempList:=PMessaggio.ListaAllegati;
  if Assigned(tempList) then
  begin
    FreeAndNil(tempList);
    PMessaggio.ListaAllegati:=nil;
  end;

  try
    PMessaggio.ListaAllegati:=WM018DM.GetListaAllegati(PMessaggio.Id);
    Result.Ok:=True;
  except
    on E: Exception do
      Result.Messaggio:=E.Message;
  end;
end;

procedure TWM018FMessaggisticaMW.AggiornaListaMittenti;
var temp: TPair<String, String>;
    i: Integer;
begin
  if Assigned(FListaMittenti) then
    FreeAndNil(FListaMittenti);

  FListaMittenti:=TList<TPair<String, String>>.Create(TComparer<TPair<String, String>>.Construct
                                                        (function (const Left, Right: TPair<String, String>): Integer
                                                         begin
                                                           Result:=CompareStr(Left.Key, Right.Key);
                                                         end));

  for i:=0 to FListaMessaggi.Count-1 do
  begin
    temp:=TPair<String, String>.Create(FListaMessaggi[i].CodMittente, FListaMessaggi[i].DescrMittente);
    if not FListaMittenti.Contains(temp) then
      FListaMittenti.Add(temp);
  end;
end;

procedure TWM018FMessaggisticaMW.AggiornaListaSelAnagrafica;
var i: Integer;
begin
  if Assigned(FListaSelAnagrafica) then
    FreeAndNil(FListaSelAnagrafica);

  FListaSelAnagrafica:=TList<String>.Create(TComparer<String>.Construct
                                                        (function (const Left, Right: String): Integer
                                                         begin
                                                           Result:=CompareStr(Left, Right);
                                                         end));

  for i:=0 to FListaMessaggi.Count-1 do
  begin
    if (FListaMessaggi[i].SelAnagrafica.Trim <> '') and not FListaSelAnagrafica.Contains(FListaMessaggi[i].SelAnagrafica) then
      FListaSelAnagrafica.Add(FListaMessaggi[i].SelAnagrafica);
  end;
end;

function TWM018FMessaggisticaMW.AggiornaStatoLettura(PLetto: Boolean): TResCtrl;
var LDataLettura: TDateTime;
    LMessaggio: TMessaggio;
begin
  Result.Clear;
  if MessaggioSelezionato is TMessaggioRicevuto then
  begin
    LMessaggio:=MessaggioSelezionato;

    try
      if Assigned(LMessaggio) then  //se è presente un messaggio selezionato
      begin
        if PLetto  then
          LDataLettura:=Now
        else
          LDataLettura:=DATE_NULL;

        WM018DM.AggiornaStatoLettura(FProgressivo, LMessaggio.Id, LDataLettura);
        (LMessaggio as TMessaggioRicevuto).DataLettura:=LDataLettura;
      end;

      Result.Ok:=True;
    except
      on E: Exception do
        Result.Messaggio:=E.Message;
    end;
  end
  else
    Result.Messaggio:='Tipo messaggio non corretto';
end;

function TWM018FMessaggisticaMW.AggiornaStatoRicezione: TResCtrl;
var LDataRicezione: TDateTime;
    LMessaggio: TMessaggio;
begin
  Result.Clear;
  if MessaggioSelezionato is TMessaggioRicevuto then
  begin
    LMessaggio:=MessaggioSelezionato;

    try
      if Assigned(LMessaggio) then  //se è presente un messaggio selezionato
      begin
        if (LMessaggio as TMessaggioRicevuto).DataRicezione = DATE_NULL then
        begin
          LDataRicezione:=Now;
          WM018DM.AggiornaStatoRicezione(FProgressivo, LMessaggio.Id, LDataRicezione);
          (LMessaggio as TMessaggioRicevuto).DataRicezione:=LDataRicezione;
        end;
      end;

      Result.Ok:=True;
    except
      on E: Exception do
        Result.Messaggio:=E.Message;
    end;
  end
  else
    Result.Messaggio:='Tipo messaggio non corretto';
end;

function TWM018FMessaggisticaMW.SelezionaMessaggioById(PId: Integer): TMessaggio;
var i: integer;
begin
  Result:=nil;
  if Assigned(FListaMessaggi) then
  begin
    for i:=0 to FListaMessaggi.Count-1 do
    begin
      if FListaMessaggi[i].Id = PId then
      begin
        FIdxMessaggio:=i;
        Result:=FListaMessaggi[i];
        Exit;
      end;
    end;
  end;
end;

function TWM018FMessaggisticaMW.GetMessaggioSelezionato: TMessaggio;
begin
  Result:=nil;
  if Assigned(FListaMessaggi) then
  begin
    if (FListaMessaggi.Count > 0) and (FIdxMessaggio >= 0) and (FIdxMessaggio < FListaMessaggi.Count) then
      Result:=FListaMessaggi[FIdxMessaggio];
  end;
end;

function TWM018FMessaggisticaMW.DownloadAllegato(PId: Integer; PNome, PPath: String): TResCtrl;
begin
  Result.Clear;

  try
    WM018DM.GetFileAllegato(PId, PNome, PPath);
    Result.Ok:=True;
  except
    on E: Exception do
      Result.Messaggio:=E.Message;
  end;
end;

function TWM018FMessaggisticaMW.Next: Boolean;
begin
  Result:=False;
  if Assigned(FListaMessaggi) then
  begin
    if (FListaMessaggi.Count > 0) and (FIdxMessaggio < FListaMessaggi.Count-1) then
    begin
      FIdxMessaggio:=FIdxMessaggio+1;
      Result:=True;
    end;
  end;
end;

function TWM018FMessaggisticaMW.Prior: Boolean;
begin
  Result:=False;
  if Assigned(FListaMessaggi) then
  begin
    if (FListaMessaggi.Count > 0) and (FIdxMessaggio > 0) then
    begin
      FIdxMessaggio:=FIdxMessaggio-1;
      Result:=True;
    end;
  end;
end;

function TWM018FMessaggisticaMW.Eof: Boolean;
begin
  Result:=False;
  if Assigned(FListaMessaggi) then
  begin
    if (FListaMessaggi.Count > 0) and (FIdxMessaggio >= FListaMessaggi.Count-1) then
      Result:=True;
  end;
end;

end.
