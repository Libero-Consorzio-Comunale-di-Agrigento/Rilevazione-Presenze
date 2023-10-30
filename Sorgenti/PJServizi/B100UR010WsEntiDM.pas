unit B100UR010WsEntiDM;

interface

uses
  DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} A000UCostanti, A000USessione, C180FunzioniGenerali, B021UUtils,
  System.SysUtils, System.Classes, R014URestDM, Oracle, Data.DB, OracleData;

type
  TB100FR010WsEntiDM = class(TR014FRestDM)
    selR010: TOracleDataSet;
  private
    FData:      TDateTime;
    FUtente:    String;
    FPassword:  String;
    FIDAzienda: String;
    function B021DateToStr(const PData: TDateTime): String; inline;
    function B021DateTimeToStr(const PData: TDateTime): String; inline;
    function B021TryStrToDate(const PDataStr: String; var RData: TDateTime): Boolean; inline;
    function GetWSEnte: TJSONObject;
  protected
    function ControlloParametri(var RErrMsg: String): Boolean; override;
    function ControlloAutenticazione(var RErrAuth: String): TInfoAutenticazione; override;
    function GetResultOnError(PException: Exception): TJSONObject; override;
  public
    SessioneMEDP:TOracleSession;
    function GetDato: TJSONObject; override;
  end;

const
  NOME_WS = 'GetWS';
  // esito richiamo
  ESITO_OK                 = 'OK';                // metodo eseguito correttamente
  ESITO_AUTH_ERR           = 'AUTH-ERR';          // errore di autenticazione
  ESITO_DATA_ERR           = 'DATA-ERR';          // impossibile estrarre i dati richiesti

  // nomi dei parametri utilizzati
  PAR_ID_AZIENDA           = 'id_azienda';
  PAR_DATA                 = 'data';
  PAR_UTENTE               = 'utente';
  PAR_PASSWORD             = 'password';

implementation

{$R *.dfm}

// metodi interni

function TB100FR010WsEntiDM.B021DateToStr(const PData: TDateTime): String;
begin
  Result:=DateToStr(PData,CreateFormatSettingsMonzaHSGerardo);
end;

function TB100FR010WsEntiDM.B021DateTimeToStr(const PData: TDateTime): String;
begin
  Result:=DateTimeToStr(PData,CreateFormatSettingsMonzaHSGerardo);
end;

function TB100FR010WsEntiDM.B021TryStrToDate(const PDataStr: String; var RData: TDateTime): Boolean;
begin
  Result:=TryStrToDate(PDataStr,RData,CreateFormatSettingsMonzaHSGerardo);
end;

function TB100FR010WsEntiDM.GetWSEnte: TJSONObject;
// servizio giornaliero
var
  ResArr: TJSONArray;
  LElement: TJSONObject;
  LEsitoStr: TJSONString;
  LTimestampPair: TJSONPair;
  //LDataPair: TJSONPair;
const
  NOME_PROC = 'GetWSEnte';
begin
  Result:=TJSONObject.Create;

  // info generiche
  LTimestampPair:=TJSONPair.Create('timestamp',TJSONString.Create(B021DateTimeToStr(Now)));
  //LDataPair:=TJSONPair.Create('data',TJSONString.Create(B021DateToStr(FData)));

  // array dei dipendenti
  LElement:=TJSONObject.Create;

  Log(NOME_PROC,Format('Ricerca ID: %s',[FIDAzienda]));
  if DatiAuth.Autenticato then
  begin
    with selR010 do
    try
      Session:=SessioneMEDP;
      Open;
      if SearchRecord('ID',FIDAzienda,[srFrombeginning]) then
      begin
        Log(NOME_PROC,Format('ID %s trovato: %s - url: %s',[FIDAzienda,FieldByName('AZIENDA').AsString,FieldByName('URL').AsString]));
        //LElement:=TJSONObject.Create;
        LElement.AddPair('azienda',TJSONString.Create(FieldByName('AZIENDA').AsString));
        LElement.AddPair('url',TJSONString.Create(FieldByName('URL').AsString));
      end
      else
        raise Exception.Create(Format('ID %s non trovato',[FIDAzienda]));
      LEsitoStr:=TJSONString.Create(ESITO_OK);
    except
      on E: Exception do
      begin
        Log(NOME_PROC,Format('  errore durante l''estrazione del ws: %s',[E.Message]));
        LEsitoStr:=TJSONString.Create(ESITO_DATA_ERR);
      end;
    end;
  end
  else
  begin
    // errore di autenticazione
    LEsitoStr:=TJSONString.Create(ESITO_AUTH_ERR);
  end;

  // crea il risultato
  Result.AddPair(LTimestampPair);
  Result.AddPair('esito',LEsitoStr);
  //Result.AddPair(LDataPair);
  Result.AddPair(NOME_WS,LElement);
end;

// metodi ridefiniti

function TB100FR010WsEntiDM.ControlloParametri(var RErrMsg: String): Boolean;
var
  LDataStr: String;
const
  NOME_PROC = 'ControlloParametri';
begin
  RErrMsg:='';
  Result:=False;

  FIDAzienda:=GetParam(PAR_ID_AZIENDA);
  Log(NOME_PROC,Format('Parametro [%s] = [%s]',[PAR_ID_AZIENDA,FIDAzienda]));

  (*
  // 1. data di riferimento
  LDataStr:=GetParam(PAR_DATA);
  Log(NOME_PROC,Format('Parametro [%s] = [%s]',[PAR_DATA,LDataStr]));

  if LDataStr.Trim = '' then
  begin
    RErrMsg:=Format('Parametro [%s] non indicato',[PAR_DATA]);
    Exit;
  end;

  if not B021TryStrToDate(LDataStr,FData) then
  begin
    RErrMsg:=Format('Parametro [%s] non valido',[PAR_DATA]);
    Exit;
  end;

  // 2. dati di autenticazione
  // 2a. utente
  FUtente:=GetParam(PAR_UTENTE);
  Log(NOME_PROC,Format('Parametro [%s] = [%s]',[PAR_UTENTE,FUtente]));

  if FUtente.Trim = '' then
  begin
    RErrMsg:=Format('Parametro [%s] non indicato',[PAR_UTENTE]);
    Exit;
  end;

  if FUtente.Length > MAX_LEN_UTENTE THEN
  begin
    RErrMsg:=Format('Parametro [%s] errato: lunghezza superiore a %d caratteri',[PAR_UTENTE,MAX_LEN_UTENTE]);
    Exit;
  end;

  // 2b. password
  FPassword:=GetParam(PAR_PASSWORD);
  Log(NOME_PROC,Format('Parametro [%s] = [%s]',[PAR_PASSWORD,FPassword]));

  if FPassword.Trim = '' then
  begin
    RErrMsg:=Format('Parametro [%s] non indicato',[PAR_PASSWORD]);
    Exit;
  end;

  if FPassword.Length > MAX_LEN_PASSWORD THEN
  begin
    RErrMsg:=Format('Parametro [%s] errato: lunghezza superiore a %d caratteri',[PAR_PASSWORD,MAX_LEN_PASSWORD]);
    Exit;
  end;
  *)

  Result:=True;
end;

function TB100FR010WsEntiDM.ControlloAutenticazione(var RErrAuth: String): TInfoAutenticazione;
var
  LOk: Boolean;
const
  NOME_PROC = 'ControlloAutenticazione';
begin
  RErrAuth:='';

  // crea oggetto con dati di autenticazione
  Result:=TInfoAutenticazione.Create;
  Result.Autenticato:=True;
  (*
  // verifica utente e password fissi
  LOk:=(FUtente = UTENTE) and (FPassword = PASSWORD);
  if not LOk then
  begin
    RErrAuth:='utente e/o password non validi!';
    Log(NOME_PROC,Format('utente e/o password non validi',[]));
    Exit;
  end;

  // imposta i dati di autenticazione
  Result.Autenticato:=True;
  Result.Utente:=FUtente;
  Result.Ruolo:='';
  *)
end;

function TB100FR010WsEntiDM.GetResultOnError(PException: Exception): TJSONObject;
// risultato in caso di errore
var
  LTimestampPair, LDataPair: TJSONPair;
  LEsitoStr: TJSONString;
begin
  Result:=TJSONObject.Create;

  // info generiche
  LTimestampPair:=TJSONPair.Create('timestamp',TJSONString.Create(B021DateTimeToStr(Now)));
  LDataPair:=TJSONPair.Create('data',TJSONString.Create(B021DateToStr(FData)));

  // distingue l'esito in base all'eccezione
  if PException is EB021AuthError then
  begin
    // esito: errore di autenticazione
    LEsitoStr:=TJSONString.Create(ESITO_AUTH_ERR);
  end
  else
  begin
    // esito: impossibile estrarre i dati
    LEsitoStr:=TJSONString.Create(ESITO_DATA_ERR);
  end;

  // crea il risultato
  Result.AddPair(LTimestampPair);
  Result.AddPair('esito',LEsitoStr);
  Result.AddPair(LDataPair);
  Result.AddPair(NOME_WS,TJSONArray.Create);
end;

function TB100FR010WsEntiDM.GetDato: TJSONObject;
begin
  Result:=GetWSEnte;
end;

end.
