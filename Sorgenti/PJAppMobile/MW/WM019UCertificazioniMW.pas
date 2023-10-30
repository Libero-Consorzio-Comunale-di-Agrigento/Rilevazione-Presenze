unit WM019UCertificazioniMW;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  A000USessione,
  B110USharedTypes,
  C018UIterAutDM,
  WM000UDataSetMW,
  WR002URichiesteMW,
  WM019UCertificazioniDM,
  System.SysUtils,
  System.Classes,
  System.Math,
  StrUtils,
  OracleData,
  C180FunzioniGenerali,
  Generics.Collections,
  B110UClientModule;

type
  //interfaccia x mantenere MW indipendente da UniGUI
  IWM019FModelloCertificazioneMW = interface
    function AggiornaPanelModello(PId: Integer; PCodModello, POperazione: String; PProgressivo: Integer; DSRichieste: TOracleDataset; SolaLettura: Boolean): TResCtrl;
    function CtrlDatiModello: TResCtrl;
    function InserisciDatiModello(PIdRichiesta: Integer): TResCtrl;
    function AggiornaDatiModello(PIdRichiesta: Integer): TResCtrl;
  end;

  TWM019FCertificazioniMW = class(TWR002FRichiesteMW)
  private
    WM019DM: TWM019FCertificazioniDM;
    WM019ModelloMW: IWM019FModelloCertificazioneMW;

    FListaModelli: TObjectList<TModelloCertificazione>;
    FListaModelliDisponibili: TObjectList<TModelloCertificazione>;

    FRichiesta: TRichiestaCertificazione; //richiesta da inserire/modificare
    function GetCodModello: String;
    function GetDescrizione: String;
    function GetPeriodo: String;
    function GetDefinitiva: Boolean;
    function GetStatoRichiesta: String;
    function GetCertValida: Boolean;

    function GetAl: TDateTime;
    function GetDal: TDateTime;
    function GetModello(CodModello: String): TModelloCertificazione;
    function ValidaAutocertificazione: TResCtrl;
  public
    property CodModello: String read GetCodModello;
    property Descrizione: String read GetDescrizione;
    property Periodo: String read GetPeriodo;
    property Dal: TDateTime read GetDal;
    property Al: TDateTime read GetAl;
    property Definitiva: Boolean read GetDefinitiva;
    property StatoRichiesta: String read GetStatoRichiesta;
    property CertValida: Boolean read GetCertValida;

    property Richiesta: TRichiestaCertificazione read FRichiesta write FRichiesta;
    property ListaModelli: TObjectList<TModelloCertificazione> read FListaModelli;
    property Modelli[CodModello: String]: TModelloCertificazione read GetModello;
    property ListaModelliDisponibili: TObjectList<TModelloCertificazione> read FListaModelliDisponibili;

    constructor Create(PSessioneIrisWin: TSessioneIrisWin; PAutorizzatore: Boolean; PWM019ModelloMW: IWM019FModelloCertificazioneMW);
    destructor Destroy; override;

    function ApplicaFiltroCodModello(PCodModello: String): TResCtrl;
    function AggiornaModelliDisponibili: TResCtrl;
    function AggiornaModello(POperazione, PCodModello: String): TResCtrl;
    function GetPeriodoDefault(PPeriodo: String; var Default: TPair<TDateTime, TDateTime>): TResCtrl;
    function GetInputPresenti(PId: Integer = -1): Boolean;

    function CtrlDatiModello: TResCtrl;

    function ControllaRichiesta: TResCtrl;
    function ConfermaInserimentoRichiesta: TResCtrl;
    function ConfermaModificaRichiesta: TResCtrl;

    function AutorizzaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PAut: String): TResCtrl; override;
    function InserisciRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl; override;
    function ModificaRichiestaSRV: TResCtrl; override;

    //non implementato
    function RevocaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl; override;
  end;

implementation

{ TWM019FCertificazioniMW }

constructor TWM019FCertificazioniMW.Create(PSessioneIrisWin: TSessioneIrisWin; PAutorizzatore: Boolean; PWM019ModelloMW: IWM019FModelloCertificazioneMW);
begin
  inherited Create(tdOracleDataSet);

  if not PSessioneIrisWin.SessioneOracle.Connected then
    raise Exception.Create('Sessione Oracle non connessa');

  FIter:=ITER_CERTIFICAZIONI;

  C018:=TC018FIterAutDM.Create(nil);

  WM019DM:=TWM019FCertificazioniDM.Create(PSessioneIrisWin);
  WR002DM:=WM019DM;

  if Assigned(PWM019ModelloMW) then
    WM019ModelloMW:=PWM019ModelloMW
  else
    WM019ModelloMW:=nil;

  OracleDataSet:=WM019DM.selSG230;

  FProgressivo:=PSessioneIrisWin.Parametri.ProgressivoOper;
  FOperatore:=PSessioneIrisWin.Parametri.Operatore;

  FFiltroAnag:=PSessioneIrisWin.Parametri.Inibizioni.Text;
  if FFiltroAnag <> '' then
    FFiltroAnag:=Format('and (%s)',[FFiltroAnag]);

  FAutorizzatore:=PAutorizzatore;

  if FAutorizzatore then
    FTipoIter:=tiAutorizzazione
  else
    FTipoIter:=tiRichiesta;

  //preparazione C018
  C018.Responsabile:=FAutorizzatore;
  C018.AccessoReadOnly:=False;
  C018.Iter:=ITER_CERTIFICAZIONI;
  C018.PreparaDataSetIter(WM019DM.selSG230, FTipoIter);

  FListaModelli:=WM019DM.GetListaModelli;
  FListaModelliDisponibili:=nil;
  FRichiesta:=nil;
end;

function TWM019FCertificazioniMW.CtrlDatiModello: TResCtrl;
begin
  Result.Clear;

  if Assigned(WM019ModelloMW) then
    Result:=WM019ModelloMW.CtrlDatiModello
  else
    Result.Messaggio:='Controllo dei dati del modello fallito: WM019ModelloMW non inizializzato';
end;

destructor TWM019FCertificazioniMW.Destroy;
begin
  FreeAndNil(FRichiesta);
  FreeAndNil(WM019DM);
  FreeAndNil(C018);
  FreeAndNil(FListaModelli);
  FreeAndNil(FListaModelliDisponibili);
  inherited;
end;

function TWM019FCertificazioniMW.ControllaRichiesta: TResCtrl;
var LModello: TModelloCertificazione;
begin
  Result.Clear;

  //Data DAL
  if FRichiesta.Dal = 0 then
  begin
    Result.Messaggio:='Indicare una data di inizio valida!';
    Exit;
  end;

  //Data AL
  if FRichiesta.Al = 0 then
  begin
    Result.Messaggio:='Indicare una data di fine valida!';
    Exit;
  end;

  //Date incomplete
  if ((FRichiesta.Al > 0) and (FRichiesta.Dal <= 0)) or
     ((FRichiesta.Al <= 0) and (FRichiesta.Dal > 0)) then
  begin
    Result.Messaggio:='Indicare un periodo completo o nessuna data';
    Exit;
  end;

  //Intervallo non valido
  if FRichiesta.Al < FRichiesta.Dal then
  begin
    Result.Messaggio:='La data di inizio deve essere precedente alla data di fine';
    Exit;
  end;

  LModello:=Modelli[FRichiesta.CodModello];
  if (R180CarattereDef(LModello.UM) in ['D','W','M','Y']) and (LModello.Quantita > 0) then
  begin
    Result.Ok:=WM019DM.ControlliPeriodo(FRichiesta, RowId, LModello.Quantita, R180CarattereDef(LModello.UM), Result.Messaggio);
    if not Result.Ok then
      Exit;
  end;

  Result:=WM019ModelloMW.CtrlDatiModello;
  if not Result.Ok then
    Exit;

  // controlli ok
  Result.Ok:=True;
end;

function TWM019FCertificazioniMW.AggiornaModello(POperazione, PCodModello: String): TResCtrl;
begin
  Result.Clear;
  if Assigned(WM019ModelloMW) then
  begin
    Result:=WM019ModelloMW.AggiornaPanelModello(IfThen(POperazione = 'I', 0, Id), PCodModello, POperazione, Progressivo, WM019DM.selSG230, (POperazione = '') or ((POperazione = 'M') and (TipoRichiesta = 'D')))
  end
  else
    Result.Messaggio:='Impossibile aggiornare il modello, WM019ModelloMW non assegnato';
end;

function TWM019FCertificazioniMW.InserisciRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl;
begin
  Result.Clear;
  try
    WM019DM.InserisciRichiesta(FRichiesta);
  except
    on E: Exception do
    begin
      Result.Messaggio:=E.Message;
      Exit;
    end;
  end;

  Result.Ok:=True;

  if not C018.WarningRichiesta then
    Result.Messaggio:=C018.MessaggioOperazione;
end;

function TWM019FCertificazioniMW.ConfermaInserimentoRichiesta: TResCtrl;
var Liv:Integer;
begin
  Result.Clear;
  try
    Liv:=C018.InsRichiesta(IfThen(FRichiesta.Definitiva,'D',''),'','');
    if C018.MessaggioOperazione <> '' then
    begin
      Cancel;
      Result.Messaggio:=C018.MessaggioOperazione;
      Exit;
    end;

    Result:=WM019ModelloMW.InserisciDatiModello(Id);
    if not Result.Ok then
     raise Exception.Create(Result.Messaggio);

    //autorizzazione automatica se autocertificazione
    if (Modelli[FRichiesta.CodModello].Autocertificazione = 'S') and
      FRichiesta.Definitiva and
      (Liv < C018.LivMaxObb) then
    begin
      Result:=ValidaAutocertificazione;
      if not Result.Ok then
        raise Exception.Create(Result.Messaggio);
    end;

    Commit;
    Result.Ok:=True;
  except
    on E:Exception do
    begin
      Rollback;
      Result.Messaggio:='Inserimento della richiesta fallito! Motivo: ' + E.Message;
    end;
  end;
end;

function TWM019FCertificazioniMW.ModificaRichiestaSRV: TResCtrl;
begin
  Result.Clear;
  try
    WM019DM.ModificaRichiesta(FRichiesta);

    C018.Id:=Id;
    C018.CodIter:=CodIter;
    C018.SetTipoRichiesta(IfThen(FRichiesta.Definitiva,'D',''));

    if not C018.ValiditaRichiesta then
    begin
      Result.Messaggio:='Inserimento delle modifiche fallito! Motivo: ' + C018.MessaggioOperazione;
      Exit;
    end;

    Result.Ok:=True;
    if not C018.WarningRichiesta then
      Result.Messaggio:=C018.MessaggioOperazione;
  except
    on E: Exception do
    begin
      Result.Messaggio:=E.Message;
      Exit;
    end;
  end;
end;

function TWM019FCertificazioniMW.ConfermaModificaRichiesta: TResCtrl;
begin
  Result.Clear;
  try
    Post;

    Result:=WM019ModelloMW.AggiornaDatiModello(Id);
    if not Result.Ok then
      raise Exception.Create(Result.Messaggio);

    Commit;
    Result.Ok:=True;
  except
    on E:Exception do
    begin
      Rollback;
      Result.Messaggio:='Modifica della richiesta fallita! Motivo: ' + E.Message;
    end;
  end;
end;

function TWM019FCertificazioniMW.AggiornaModelliDisponibili: TResCtrl;
begin
  Result.Clear;
  try
    if Assigned(FListaModelliDisponibili) then
      FreeAndNil(FListaModelliDisponibili);

    FListaModelliDisponibili:=WM019DM.GetListaModelliDisponibili(FProgressivo);
    Result.Ok:=True;
  except
    on E: Exception do
      Result.Messaggio:=E.Message;
  end;
end;

function TWM019FCertificazioniMW.ApplicaFiltroCodModello(PCodModello: String): TResCtrl;
begin
  Result.Clear;
  try
    if PCodModello = '' then
      ApplicaFiltroDataSet('')
    else
      ApplicaFiltroDataSet(Format('COD_MODELLO=''%s''', [PCodModello]));
    Result.Ok:=True;
  except
    on E: Exception do
      Result.Messaggio:=E.Message;
  end;
end;

function TWM019FCertificazioniMW.AutorizzaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PAut: String): TResCtrl;
begin
  Result.Clear;
  //salva i dati di autorizzazione
  try
    C018.CodIter:=CodIter;
    C018.Id:=Id;
    C018.InsAutorizzazione(LivelloAutorizzazione, PAut, FOperatore,'','',True);

    if C018.MessaggioOperazione <> '' then
    begin
      Result.Messaggio:=C018.MessaggioOperazione;
      Result.Ok:=False;
      Exit;
    end;

    Commit;
    Result.Ok:=True;
  except
    on E: exception do
    begin
      Commit;
      Result.Messaggio:='Impostazione della validazione fallita! Motivo: ' + E.Message;
      Result.Ok:=False;
    end;
  end;
end;

function TWM019FCertificazioniMW.RevocaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl;
begin
  raise Exception.Create('Funzione RevocaRichiesta non implementata');
end;

function TWM019FCertificazioniMW.GetPeriodoDefault(PPeriodo: String; var Default: TPair<TDateTime, TDateTime>): TResCtrl;
begin
  Result.Clear;
  try
    Default:=WM019DM.GetPeriodoDefault(PPeriodo);
    Result.Ok:=True;
  except
    on E: Exception do
    begin
      Result.Messaggio:=E.Message;
      Exit;
    end;
  end;
end;

function TWM019FCertificazioniMW.ValidaAutocertificazione: TResCtrl;
begin
  Result.Clear;
  try
    C018.InsAutorizzazione(C018.LivMaxObb,C018SI,C018AUTOMATICO,'N','Autocertificazione');
    Commit;
    if C018.MessaggioOperazione <> '' then
    begin
      Result.Messaggio:=C018.MessaggioOperazione;
      Exit;
    end;
    Result.Ok:=True;
  except
    on E: Exception do
    begin
      SessioneOracle.Commit;
      Result.Messaggio:='Impostazione della validazione fallita! Motivo: ' + E.Message;
    end;
  end;
end;

{$region 'Getter/Setter'}

function TWM019FCertificazioniMW.GetCodModello: String;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('COD_MODELLO') <> nil then
      Result:=FDataSet.FieldByName('COD_MODELLO').AsString
    else
      raise Exception.Create('Campo COD_MODELLO non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWM019FCertificazioniMW.GetDescrizione: String;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('DESCRIZIONE') <> nil then
      Result:=FDataSet.FieldByName('DESCRIZIONE').AsString
    else
      raise Exception.Create('Campo DESCRIZIONE non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWM019FCertificazioniMW.GetPeriodo: String;
var
  LDal: TDateTime;
  LAl: TDateTime;
begin
  if FDataSet.Active then
  begin
    if (FDataSet.FindField('DAL') <> nil) or (FDataSet.FindField('AL') <> nil) then
    begin
      LDal:=FDataSet.FieldByName('DAL').AsDateTime;
      LAl:=FDataSet.FieldByName('AL').AsDateTime;

      Result:=FormatDateTime('dd/mm/yyyy',LDal);
      if LAl <> LDal then
        Result:=Format('%s - %s',[Result,FormatDateTime('dd/mm/yyyy',LAl)])
      else if Result = '30/12/1899' then
        Result:='';
    end
    else
      raise Exception.Create('Campi DAL/AL non trovati');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWM019FCertificazioniMW.GetStatoRichiesta: String;
begin
    if FDataSet.Active then
  begin
    if FDataSet.FindField('D_TIPO_RICHIESTA') <> nil then
      Result:=FDataSet.FieldByName('D_TIPO_RICHIESTA').AsString
    else
      raise Exception.Create('Campo D_TIPO_RICHIESTA non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWM019FCertificazioniMW.GetDefinitiva: Boolean;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('TIPO_RICHIESTA') <> nil then
      Result:=FDataSet.FieldByName('TIPO_RICHIESTA').AsString = 'D'
    else
      raise Exception.Create('Campo TIPO_RICHIESTA non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWM019FCertificazioniMW.GetDal: TDateTime;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('DAL') <> nil then
      Result:=FDataSet.FieldByName('DAL').AsDateTime
    else
      raise Exception.Create('Campo DAL non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWM019FCertificazioniMW.GetAl: TDateTime;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('AL') <> nil then
      Result:=FDataSet.FieldByName('AL').AsDateTime
    else
      raise Exception.Create('Campo AL non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWM019FCertificazioniMW.GetCertValida: Boolean;
begin
  Result:=WM019DM.VerificaCertificazioneValida(FProgressivo, GetCodModello);
end;

function TWM019FCertificazioniMW.GetInputPresenti(PId: Integer = -1): Boolean;
begin
  Result:=WM019DM.VerificaInputPresenti(PId, GetCodModello);
end;

function TWM019FCertificazioniMW.GetModello(CodModello: String): TModelloCertificazione;
var i: Integer;
begin
  Result:=nil;

  if Assigned(FListaModelli) then
  begin
    for i:=0 to FListaModelli.Count-1 do
    begin
      if FListaModelli[i].Codice = CodModello then
        Result:=FListaModelli[i];
    end;
  end;
end;

{$endregion}

end.
