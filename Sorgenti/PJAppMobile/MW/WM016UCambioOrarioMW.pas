unit WM016UCambioOrarioMW;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  A000USessione,
  B110UClientModule,
  B110USharedTypes,
  C018UIterAutDM,
  WR002URichiesteMW,
  System.Generics.Collections,
  System.Sensors, C200UWebServicesTypes, C200UWebServicesUtils, System.SysUtils, System.Classes,
  System.StrUtils, FunzioniGenerali, System.Math, WM000UConstants, Data.DB, WM016UCambioOrarioDM, WM000UTypes,
  WM000UDataSetMW, Generics.Defaults, DatiBloccati, C180FunzioniGenerali;

type
  TWM016FCambioOrarioMW = class(TWR002FRichiesteMW)
    private
      WM016DM: TWM016FCambioOrarioDM;
      FSelDatiBloccati: TDatiBloccati;

      FC90_WebTipoCambioOrario: String;
      FC90_WebSettCambioOrario: String;
      FC90_IterOrdinaDataRichiesta: String;

      FModalitaRichiesta: TModalitaRichiesta;
      FListaOrari: TList<TPair<String, String>>;
      FNuovaRichiesta: TRichiestaCambioOrario;  //nuova richiesta da inserire

      function GetDataInver: TDateTime;
      function GetOrario: TPair<String, String>;
      function GetOrarioInver: TPair<String, String>;
      function GetSoloNote: String;
    public
      property C90_WebTipoCambioOrario: String read FC90_WebTipoCambioOrario;
      property C90_WebSettCambioOrario: String read FC90_WebSettCambioOrario;
      property ModalitaRichiesta: TModalitaRichiesta read FModalitaRichiesta write FModalitaRichiesta;
      property ListaOrario:TList<TPair<String, String>> read FListaOrari;
      property DataInver: TDateTime read GetDataInver;
      property Orario: TPair<String, String> read GetOrario;
      property OrarioInver: TPair<String, String> read GetOrarioInver;
      property SoloNote: String read GetSoloNote;
      property Richiesta: TRichiestaCambioOrario read FNuovaRichiesta write FNuovaRichiesta;

      constructor Create(PSessioneIrisWin: TSessioneIrisWin; PAutorizzatore: Boolean);
      destructor Destroy; override;

      function ControllaRichiesta: TResCtrl;
      function ControllaOrario: String;
      function ControllaOrarioInver: String;

      function GetGiorniDisponibiliInversione(PData: TDateTime): TList<TDateTime>;
      function GetOrarioValido(PData: TDateTime): TPair<String, String>;
      function GetTipoGiorno(PProgressivo:Integer; PData: TDateTime): String;
      function GetTipoGiornoEsteso(PProgressivo:Integer; PData: TDateTime): String;
      function AggiornaListaOrari(PData: TDateTime; POrarioOriginale: TPair<String, String>): TResCtrl;

      function AutorizzaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PAut: String): TResCtrl; override;
      function InserisciRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl; override;

      //non implementato
      function RevocaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl; override;

      function ConfermaInserimentoRichiesta: TResCtrl;
  end;

implementation

{ TWM016FCambioOrarioTestMW }

constructor TWM016FCambioOrarioMW.Create(PSessioneIrisWin: TSessioneIrisWin; PAutorizzatore: Boolean);
begin
  inherited Create(tdOracleDataSet);

  if not PSessioneIrisWin.SessioneOracle.Connected then
    raise Exception.Create('Sessione Oracle non connessa');

  C018:=TC018FIterAutDM.Create(nil);
  FSelDatiBloccati:=TDatiBloccati.Create(nil);

  WM016DM:=TWM016FCambioOrarioDM.Create(PSessioneIrisWin);
  WR002DM:=WM016DM;

  OracleDataSet:=WM016DM.selT085;

  //comparer necessario per TList.Contains
  FListaOrari:=TList<TPair<String, String>>.Create(TComparer<TPair<String, String>>.Construct
                                                        (function (const Left, Right: TPair<String, String>): Integer
                                                         begin
                                                           Result := CompareStr(Left.Key, Right.Key);
                                                         end));

  FProgressivo:=PSessioneIrisWin.Parametri.ProgressivoOper;
  FOperatore:=PSessioneIrisWin.Parametri.Operatore;

  FFiltroAnag:=PSessioneIrisWin.Parametri.Inibizioni.Text;
  if FFiltroAnag <> '' then
    FFiltroAnag:=Format('and (%s)',[FFiltroAnag]);

  FAutorizzatore:=PAutorizzatore;
  FC90_WebTipoCambioOrario:=PSessioneIrisWin.Parametri.CampiRiferimento.C90_WebTipoCambioOrario;
  FC90_WebSettCambioOrario:=PSessioneIrisWin.Parametri.CampiRiferimento.C90_WebSettCambioOrario;
  FC90_IterOrdinaDataRichiesta:=PSessioneIrisWin.Parametri.CampiRiferimento.C90_IterOrdinaDataRichiesta;
  FNuovaRichiesta:=nil;

  if (FC90_WebTipoCambioOrario = 'C') or (FC90_WebTipoCambioOrario = 'E') then
    FModalitaRichiesta:=mrCambioOrario
  else if FC90_WebTipoCambioOrario = 'I' then
    FModalitaRichiesta:=mrInversioneGiorno;

  if FAutorizzatore then
    FTipoIter:=tiAutorizzazione
  else
    FTipoIter:=tiRichiesta;

  //preparazione C018
  C018.Responsabile:=FAutorizzatore;
  C018.AccessoReadOnly:=False;
  C018.Iter:=ITER_ORARIGG;
  C018.PreparaDataSetIter(WM016DM.selT085, FTipoIter);
end;

destructor TWM016FCambioOrarioMW.Destroy;
begin
  FreeAndNil(FNuovaRichiesta);
  FreeAndNil(FListaOrari);
  FreeAndNil(FSelDatiBloccati);
  FreeAndNil(WM016DM);
  FreeAndNil(C018);
  inherited;
end;

function TWM016FCambioOrarioMW.ControllaOrario: String;
var LOrarioTemp: TPair<String, String>;
begin
  if (Autorizzazione = '') and (SoloNote = 'N') then
  begin
    LOrarioTemp:=WM016DM.GetOrarioValido(Progressivo, Data);

    if LOrarioTemp.Key <> Orario.Key then
      Result:='Orario ' + IfThen(Trunc(Data) = Trunc(DataInver),'originale','del primo giorno') + ' attuale (' + LOrarioTemp.Key + ') differente da quello presente in fase di richiesta (' + Orario.Key + ')';
  end;
end;

function TWM016FCambioOrarioMW.ControllaOrarioInver: String;
var LOrarioTemp: TPair<String, String>;
begin
  if (DataInver <> DATE_NULL) and (TipoRichiesta = 'I') then
  begin
    LOrarioTemp:=WM016DM.GetOrarioValido(Progressivo, DataInver);

    if LOrarioTemp.Key <> OrarioInver.Key then
      Result:='Orario richiesto attuale' + IfThen(OrarioInver.Key = '', '', ' (' + OrarioInver.Key + ')')  + ' differente da quello presente in fase di richiesta' + IfThen(LOrarioTemp.Key = '', '', ' (' + LOrarioTemp.Key + ')');
  end;
end;

function TWM016FCambioOrarioMW.ControllaRichiesta: TResCtrl;
var LTipoGiorno, LTipoGiornoInver: String;
begin
  Result.Clear;

  if FSelDatiBloccati.DatoBloccato(FNuovaRichiesta.Progressivo, R180InizioMese(FNuovaRichiesta.Data),'T080') then
  begin
    Result.Messaggio:=FSelDatiBloccati.MessaggioLog;
    Exit;
  end;

  if WM016DM.EsisteRichiesta(FNuovaRichiesta.Progressivo, FNuovaRichiesta.Data) then
  begin
    Result.Messaggio:='Esiste già una richiesta in attesa di autorizzazione relativa al ' + IfThen(FModalitaRichiesta = mrInversioneGiorno,'primo ') + 'giorno indicato!';
    Exit;
  end;

  if not FNuovaRichiesta.SoloNote then
  begin
    if FModalitaRichiesta = mrInversioneGiorno then
    begin
      if FSelDatiBloccati.DatoBloccato(FNuovaRichiesta.Progressivo, R180InizioMese(FNuovaRichiesta.DataInver),'T080') then
      begin
        Result.Messaggio:=FSelDatiBloccati.MessaggioLog;
        Exit;
      end;

      if WM016DM.EsisteRichiesta(FNuovaRichiesta.Progressivo, FNuovaRichiesta.Data) then
      begin
        Result.Messaggio:='Esiste già una richiesta in attesa di autorizzazione relativa al secondo giorno indicato!';
        Exit;
      end;
    end;

    LTipoGiorno:=WM016DM.GetGiornoLavorativo(FNuovaRichiesta.Progressivo, FNuovaRichiesta.Data);
    LTipoGiornoInver:=WM016DM.GetGiornoLavorativo(FNuovaRichiesta.Progressivo, FNuovaRichiesta.DataInver);

    if (FNuovaRichiesta.CodOrario = FNuovaRichiesta.CodOrarioInver) and ((FModalitaRichiesta = mrCambioOrario) or (LTipoGiorno = LTipoGiornoInver)) then
    begin
      Result.Messaggio:='L''orario ' + IfThen(FModalitaRichiesta = mrCambioOrario,'originale','del primo giorno')
                        + ' e l''orario ' + IfThen(FModalitaRichiesta = mrCambioOrario,'richiesto','del secondo giorno')
                        + ' corrispondono' + IfThen(FModalitaRichiesta = mrInversioneGiorno,' e i giorni indicati sono entrambi ' + IfThen(LTipoGiorno = 'N','non ','') + 'lavorativi','') + '!';
      Exit;
    end;
  end;

  Result.Ok:=True;
end;

function TWM016FCambioOrarioMW.GetGiorniDisponibiliInversione(PData: TDateTime): TList<TDateTime>;
var
  d: TDateTime;
  i,Sett: Integer;
begin
  Result:=TList<TDateTime>.Create;

  Sett:=Max(StrToIntDef(C90_WebSettCambioOrario,1),1);
  if (DayOfWeek(PData - 1) = 7) and (Sett = 1) then
    Exit;
  d:=PData + 1;
  for i:=1 to (7 * Sett) do
    if i >= DayOfWeek(d - 1) then
    begin
      Result.Add(d);
      d:=d + 1;
    end;
end;

function TWM016FCambioOrarioMW.GetOrarioValido(PData: TDateTime): TPair<String, String>;
begin
  Result:=WM016DM.GetOrarioValido(FProgressivo, PData);
end;

function TWM016FCambioOrarioMW.GetTipoGiorno(PProgressivo: Integer; PData: TDateTime): String;
var LTipoGiorno: String;
begin
  LTipoGiorno:=WM016DM.GetTipoGiorno(PProgressivo, PData);
  Result:=IfThen(LTipoGiorno = 'T','T',IfThen(LTipoGiorno = 'F','F',IfThen(LTipoGiorno = 'N','N','L')))
end;

function TWM016FCambioOrarioMW.GetTipoGiornoEsteso(PProgressivo: Integer; PData: TDateTime): String;
var LTipoGiorno: String;
begin
  LTipoGiorno:=GetTipoGiorno(PProgressivo, PData);
  if LTipoGiorno = 'T' then
    Result:='festivo non lavorativo'
  else if LTipoGiorno = 'F' then
    Result:='festivo'
  else if LTipoGiorno = 'N' then
    Result:='non lavorativo'
  else
    Result:='lavorativo'
end;

function TWM016FCambioOrarioMW.AggiornaListaOrari(PData: TDateTime; POrarioOriginale: TPair<String, String>): TResCtrl;
var LOrarioPianificato: TPair<String, String>;
begin
  Result.Clear;

  FListaOrari.Clear;
  try
    if FModalitaRichiesta = mrCambioOrario then
    begin
      WM016DM.AddOrariCambioOrario(POrarioOriginale.Key, PData, FListaOrari);

      if FListaOrari.Count <> 0 then
      begin
        Result.Ok:=True;
        Exit;
      end;
    end;

    WM016DM.AddOrariProfilo(FProgressivo, PData, FListaOrari);
    WM016DM.AddOrariAbilitati(POrarioOriginale.Key, PData, FListaOrari);
    LOrarioPianificato:=WM016DM.GetOrarioPianificato(FProgressivo, PData);

    if (LOrarioPianificato.Key <> '') and (FListaOrari.Contains(LOrarioPianificato)) then
      FListaOrari.Add(LOrarioPianificato);

    if (POrarioOriginale.Key <> '') and (FListaOrari.Contains(POrarioOriginale)) then
      FListaOrari.Add(POrarioOriginale);

    Result.Ok:=True;
  except
    on e: Exception do
    begin
      Result.Messaggio:='Errore nell''aggiornamento della lista degli orari disponibili: ' + e.Message;
    end;
  end;
end;

function TWM016FCambioOrarioMW.InserisciRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl;
begin
  Result.Clear;
  try
    WM016DM.InserisciRichiesta(FNuovaRichiesta, FModalitaRichiesta);
  except
    on E: Exception do
    begin
      Result.Messaggio:=E.Message;
      Exit;
    end;
  end;

  C018.Note:=FNuovaRichiesta.Note;

  if not C018.WarningRichiesta then
    Result.Messaggio:=C018.MessaggioOperazione
  else
    Result.Ok:=True;
end;

function TWM016FCambioOrarioMW.ConfermaInserimentoRichiesta: TResCtrl;
var Liv:Integer;
begin
  Result.Clear;
  try
    Liv:=C018.InsRichiesta(FC90_WebTipoCambioOrario, FNuovaRichiesta.Note,'');
    if C018.MessaggioOperazione <> '' then
    begin
      Cancel;
      Result.Messaggio:=C018.MessaggioOperazione;
      Exit;
    end
    else if (Liv = C018.LivMaxObb) and (not FNuovaRichiesta.SoloNote) then
    begin
      WM016DM.AggiornamentoCalendarioIndividuale(Progressivo, Data, DataInver);
      WM016DM.AggiornamentoPianificazioneOrari(Progressivo, Data, DataInver, Orario.Key, OrarioInver.Key);
    end;

    Commit;
    Result.Ok:=True;
  except
    on E:Exception do
    begin
      Commit;
      Result.Messaggio:='Inserimento della richiesta fallito! Motivo: ' + E.Message;
    end;
  end;
end;

function TWM016FCambioOrarioMW.AutorizzaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PAut: String): TResCtrl;
var Liv: Integer;
begin
  Result.Clear;
  //salva i dati di autorizzazione
  try
    C018.CodIter:=CodIter;
    C018.Id:=Id;
    Liv:=C018.InsAutorizzazione(LivelloAutorizzazione, PAut, FOperatore,'','',True);

    if C018.MessaggioOperazione <> '' then
    begin
      Result.Messaggio:=C018.MessaggioOperazione;
      Result.Ok:=False;
      Exit;
    end;

    WM016DM.RegistraMsg.IniziaMessaggio('WM017');
    WM016DM.RegistraMsg.InserisciMessaggio('I','ID richiesta: ' + C018.Id.ToString + ' ' + IfThen(PAut = 'S','Autorizzato da ','Non autorizzato da ') + NominativoResp, '',  Progressivo);

    if (Liv = C018.LivMaxObb) and (PAut = 'S') and (SoloNote = 'N') then
    begin
      WM016DM.AggiornamentoCalendarioIndividuale(Progressivo, Data, DataInver);
      WM016DM.AggiornamentoPianificazioneOrari(Progressivo, Data, DataInver, Orario.Key, OrarioInver.Key);
    end;

    Commit;
    Result.Ok:=True;
  except
    on E: exception do
    begin
      Commit;
      Result.Messaggio:='Impostazione dell''autorizzazione fallita! Motivo: ' + E.Message;
      Result.Ok:=False;
    end;
  end;
end;

function TWM016FCambioOrarioMW.RevocaRichiestaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; var PRisposteMsg: TRisposteMsg): TResCtrl;
begin
  raise Exception.Create('Funzione RevocaRichiesta non implementata');
end;

{$region 'Getter/Setter'}
function TWM016FCambioOrarioMW.GetDataInver: TDateTime;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('DATA_INVER') <> nil then
    begin
      if FDataSet.FieldByName('DATA_INVER').IsNull then
        Result:=DATE_NULL
      else
        Result:=FDataSet.FieldByName('DATA_INVER').AsDateTime;
    end
    else
      raise Exception.Create('Campo DATA_INVER non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWM016FCambioOrarioMW.GetOrario: TPair<String, String>;
begin
  if FDataSet.Active then
  begin
    if (FDataSet.FindField('ORARIO') <> nil) and (FDataSet.FindField('D_ORARIO') <> nil) then
      Result:=TPair<String, String>.Create(FDataSet.FieldByName('ORARIO').AsString, FDataSet.FieldByName('D_ORARIO').AsString)
    else
      raise Exception.Create('Campi ORARIO e/o D_ORARIO non trovati');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;

function TWM016FCambioOrarioMW.GetOrarioInver: TPair<String, String>;
begin
  if FDataSet.Active then
  begin
    if (FDataSet.FindField('ORARIO_INVER') <> nil) and (FDataSet.FindField('D_ORARIO_INVER') <> nil) then
      Result:=TPair<String, String>.Create(FDataSet.FieldByName('ORARIO_INVER').AsString, FDataSet.FieldByName('D_ORARIO_INVER').AsString)
    else
      raise Exception.Create('Campi ORARIO_INVER e/o D_ORARIO_INVER non trovati');
  end;
end;

function TWM016FCambioOrarioMW.GetSoloNote: String;
begin
  if FDataSet.Active then
  begin
    if FDataSet.FindField('SOLO_NOTE') <> nil then
      Result:=FDataSet.FieldByName('SOLO_NOTE').AsString
    else
      raise Exception.Create('Campo SOLO_NOTE non trovato');
  end
  else
    raise Exception.Create('Dataset Richieste non attivo');
end;
{$endregion}
end.
