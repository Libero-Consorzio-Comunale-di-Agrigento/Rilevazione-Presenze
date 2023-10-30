unit B021UUtils;

interface

uses
  A000UCostanti,
  C180FunzioniGenerali,
  C200UWebServicesTypes,
  IdHashSHA,
  SysUtils,
  System.DateUtils,
  System.StrUtils,
  Generics.Collections,
  WinApi.Windows;

type

  TDatiConnessione = record
    Database: String;
    Azienda: String;
    UtenteI070: String;
  end;

  // si voleva utilizzare Web.HTTPApp.TMethodType, ma in XE4 non è completo
  TMetodoRest = (mrGet, mrPut, mrPost, mrDelete);

  // ######################################################################## //
  // ###         E C C E Z I O N I    P E R S O N A L I Z Z A T E         ### //
  // ######################################################################## //

  EB021InvalidStructure = class(EC200Exception)
  protected
    procedure RaisingException(P: System.PExceptionRecord); override;
  end;

  EB021DuplicateDocument = class(EC200Exception)
  protected
    procedure RaisingException(P: System.PExceptionRecord); override;
  end;

  // ######################################################################## //
  // ###               M E T O D I   D I   S U P P O R T O                ### //
  // ######################################################################## //

  TB021FUtils = class
  public
    class function CreateFormatSettingsFirlab: TFormatSettings; static;
    class function CreateFormatSettingsAostaAsl: TFormatSettings; static;
    class function CreateFormatSettingsMonzaHSGerardo: TFormatSettings; static;
    class function GetUnixTimeCorrente: Int64; static;
    class function IsTimeOkAostaAsl(const PUnixTime: Int64): Boolean; static;
    class function GetHashAutenticazioneAostaAsl(const PUnixTime: Int64): String; static;
    class function ConvertiStrDate(const PDataStr: String; var RData: TDateTime): Boolean; static;
    class function ConvertiDateStr(const PData: TDateTime): String; static;
    class function ConvertiStrDateTime(const PDataStr: String; var RData: TDateTime): Boolean; static;
    class function ConvertiDateTimeStr(const PData: TDateTime): String; static;
    class function PulisciStringaJson(const strJson: String): String; static;
    class function GetQuerystringParams(const PQueryString: String): TDictionary<String,String>; static;
    class function GetLogFmt(const PClassName, PProcName, PLogInfo: String): String; static;
    class function GetDatabaseEffettivo(const PDatabase: String): String; static;
    class function GetAziendaEffettiva(const PAzienda: String): String; static;
    class function GetUtenteI070Effettivo(const PUtenteI070: String): String; static;
    class function GetDatiConnessione(const PDatabase, PAzienda, PUtenteI070: String): TDatiConnessione; static;
    class function GetDatiConnessioneEffettivi(const PDatabase, PAzienda, PUtenteI070: String): TDatiConnessione; static;
    class function CreaToken(const PUnixTime: Int64; const PParTokenPassphrase: String): String; static;
    class function VerificaToken(const PToken: String; const PUnixTime: Int64; const PParTokenPassphrase: String; const PParTokenTimeout: Integer): TResCtrl; static;
  end;

const
  // valori di default per parametri da leggere su registro
  DATABASE_DEFAULT                        = '*';
  AZIENDA_DEFAULT                         = '*';
  UTENTE_I070_DEFAULT                     = '*';

  // tipologie di operazione del servizio
  OPER_CREATE                             = 'C';
  OPER_READ                               = 'R';
  OPER_UPDATE                             = 'U';
  OPER_DELETE                             = 'D';

  DESC_OPER_CREATE                        = 'create';
  DESC_OPER_READ                          = 'read';
  DESC_OPER_UPDATE                        = 'update';
  DESC_OPER_DELETE                        = 'delete';

  // nome del file di log
  FILE_LOG                                = 'B021.log';

  // stringhe di errore specifiche
  ERR_EB021INVALID_STRUCTURE              =   1; // 'Errore nella struttura dati';

  // dati personalizzati Firlab
  FIRLAB_DATO_LIBERO_TURNI                = 'ATTIVO_TURNI';            // dato libero anagrafico che identifica i turnisti
  FIRLAB_SHARED_PWD                       = 'pwdIrisRostersha1';       // password condivisa per generazione hash
  FIRLAB_DATE_SEPARATOR: Char             = '-';                       // carattere di separazione data
  FIRLAB_SHORT_DATE_FMT                   = 'dd-mm-yyyy';              // formato data standard
  FIRLAB_DATETIME_FMT                     = 'dd-mm-yyyy hhhh:nn';      // formato data/ora standard
  FIRLAB_TIME_FMT                         = 'hhhh:nn';                 // formato ora standard

  // dati personalizzati per Aosta ASL
  AOSTA_ASL_SHARED_PWD                    = 'm0nD03dP$405tA';          // password condivisa per generazione hash
  AOSTA_ASL_DATE_SEPARATOR: Char          = #0;
  AOSTA_ASL_SHORT_DATE_FMT                = 'yyyymmdd';                // formato data/ora standard
  AOSTA_ASL_VALIDITA_TOKEN                = 60;                        // validità del token espressa in secondi

  // dati personalizzati per Monza_HSGerardo
  MONZA_HSGERARDO_DATE_SEPARATOR: Char    = '-';                       // carattere di separazione data
  MONZA_HSGERARDO_SHORT_DATE_FMT          = 'dd-mm-yyyy';              // formato data standard

  // tipi dati integrazione anagrafica B014
  B014_TIPO_DATO_ALFANUMERICO             = 'A';
  B014_TIPO_DATO_NUMERICO                 = 'N';
  B014_TIPO_DATO_DATA                     = 'D';

  // costanti comuni
  SPAZIO = #32;
  TAB    = #9;
  CR     = #13;
  LF     = #10;

implementation

class function TB021FUtils.CreateFormatSettingsFirlab: TFormatSettings;
// crea un oggetto TFormatSettings con le impostazioni per Firlab
// IMPORTANTE
//   la distruzione dell'oggetto non è necessaria
begin
  Result:=TFormatSettings.Create;
  Result.DateSeparator:=FIRLAB_DATE_SEPARATOR;
  Result.ShortDateFormat:=FIRLAB_SHORT_DATE_FMT;
end;

class function TB021FUtils.CreateFormatSettingsAostaAsl: TFormatSettings;
// crea un oggetto TFormatSettings con le impostazioni per AOSTA_ASL
// IMPORTANTE
//   la distruzione dell'oggetto non è necessaria
begin
  Result:=TFormatSettings.Create;
  Result.DateSeparator:=AOSTA_ASL_DATE_SEPARATOR;
  Result.ShortDateFormat:=AOSTA_ASL_SHORT_DATE_FMT;
end;

class function TB021FUtils.CreateFormatSettingsMonzaHSGerardo: TFormatSettings;
// crea un oggetto TFormatSettings con le impostazioni per MONZA_HSGERARDO
// IMPORTANTE
//   la distruzione dell'oggetto non è necessaria
begin
  Result:=TFormatSettings.Create;

  // DateToStr usa DateSeparator e ShortDateFormat
  Result.DateSeparator:=MONZA_HSGERARDO_DATE_SEPARATOR;
  Result.ShortDateFormat:=MONZA_HSGERARDO_SHORT_DATE_FMT;

  // DateTimeToStr usa TimeSeparator e LongTimeFormat
  // (sì, non ho bevuto, date usa shortdateformat e questo usa longtimeformat)
  // cfr. http://www.delphibasics.co.uk/RTL.asp?Name=DateTimeToStr
  Result.TimeSeparator:='.';
  Result.LongTimeFormat:='hh.mm';
end;

class function TB021FUtils.GetUnixTimeCorrente: Int64;
// restituisce data/ora attuale in formato unix
var
  OraAttuale:TDateTime;
  UTC:TSystemTime;
begin
  GetSystemTime(UTC);
  OraAttuale:=SystemTimeToDateTime(UTC);
  Result:=DateTimeToUnix(OraAttuale);
end;

class function TB021FUtils.IsTimeOkAostaAsl(const PUnixTime: Int64): Boolean;
// restituisce True se fra l'ora corrente e l'ora indicata sono passati
// al max AOSTA_ASL_VALIDITA_TOKEN secondi
var
  LDiff: Integer;
begin
  // differenza in secondi
  LDiff:=GetUnixTimeCorrente - PUnixTime;

  // verifica differenza
  Result:=R180Between(LDiff,0,AOSTA_ASL_VALIDITA_TOKEN);
end;

class function TB021FUtils.GetHashAutenticazioneAostaAsl(const PUnixTime: Int64): String;
// restituisce una chiave sha1 basata sull'ora indicata e su una password condivisa
begin
  Result:=R180Sha1Encrypt(Format('%d%s',[PUnixTime,AOSTA_ASL_SHARED_PWD]));
end;

class function TB021FUtils.ConvertiStrDate(const PDataStr: String; var RData: TDateTime): Boolean; deprecated;
// converte la data indicata come stringa nel formato TDateTime
// formati riconosciuti:
//   yyyy-mm-dd
//   dd-mm-yyyy
// IMPORTANTE
//   evitare l'utilizzo di questa funzione
//   utilizzare invece TryStrToDate(PDataStr,RData,FS)
//   specificando nei formatsettings le impostazioni per la conversione
var
  Anno,Mese,Giorno: String;
begin
  RData:=DATE_NULL;

  if Trim(PDataStr) = '' then
  begin
    Result:=True;
    Exit;
  end;

  if R180IsDigit(PDataStr,5) then
  begin
    // formato dd-mm-yyyy
    Anno:=Copy(PDataStr,7,4);
    Mese:=Copy(PDataStr,4,2);
    Giorno:=Copy(PDataStr,1,2);
  end
  else
  begin
    // formato yyyy-mm-dd
    Anno:=Copy(PDataStr,1,4);
    Mese:=Copy(PDataStr,6,2);
    Giorno:=Copy(PDataStr,9,2);
  end;
  try
    RData:=EncodeDate(StrToInt(Anno),
                      StrToInt(Mese),
                      StrToInt(Giorno));
    Result:=True;
  except
    on E: EConvertError do
    begin
      RData:=DATE_NULL;
      Result:=False;
    end;
  end;
end;

class function TB021FUtils.ConvertiDateStr(const PData: TDateTime): String;
// converte la data indicata nella rappresentazione string
// con formato standard
begin
  Result:=FormatDateTime(FIRLAB_SHORT_DATE_FMT,PData);
end;

class function TB021FUtils.ConvertiStrDateTime(const PDataStr: String; var RData: TDateTime): Boolean; deprecated;
// converte la data/ora indicata in formato stringa nel formato TDateTime
// formato riconosciuti:
//   yyyy-mm-dd hhhh:nn
//   dd-mm-yyyy hhhh:nn
//   evitare l'utilizzo di questa funzione
//   utilizzare invece TryStrToDateTime(PDataStr,RData,FS)
//   specificando nei formatsettings le impostazioni per la conversione
var
  DOra: TDateTime;
  Ore,Minuti: String;
begin
  Result:=False;
  RData:=DATE_NULL;

  if Trim(PDataStr) = '' then
  begin
    Result:=True;
    Exit;
  end;

  if not ConvertiStrDate(Copy(PDataStr,1,10),RData) then
    Exit;

  // parte relativa all'ora
  if Length(PDataStr) > 10 then
  begin
    Ore:=Copy(PDataStr,12,2);
    Minuti:=Copy(PDataStr,15,2);

    try
      DOra:=EncodeTime(StrToInt(Ore),
                       StrToInt(Minuti),
                       0,0);
    except
      on E: EConvertError do
      begin
        RData:=DATE_NULL;
        Exit;
      end;
    end;
    RData:=RData + DOra;
  end;
  Result:=True;
end;

class function TB021FUtils.ConvertiDateTimeStr(const PData: TDateTime): String;
// converte la data/ora indicata nella rappresentazione string
// con formato standard
begin
  Result:=FormatDateTime(FIRLAB_DATETIME_FMT,PData);
end;

class function TB021FUtils.PulisciStringaJson(const strJson: String): String;
// rimuove i caratteri spazio, tab, cr, lf dalla stringa in formato json
// workaround per bug nel parsing di stringhe json (delphi 2010)
var
  P: PChar;
  InTag: Boolean;
begin
  P:=PChar(strJson);
  Result:='';
  if Trim(strJson) = '' then
    exit;

  // rimozione dei tag
  InTag:=False;
  repeat
    case P^ of
      '"': begin
             InTag:=not InTag;
             Result:=Result + P^;
           end;
      SPAZIO, TAB, CR, LF:
           if InTag then
             Result:=Result + P^; // nessuna operazione
      else
        //if not InTag then
        //begin
        //  if (P^ in [#9, #32]) and
        //     ((P + 1)^ in [#10, #13, #32, #9, '"']) then
        //  else
            Result:=Result + P^;
        //end;
    end;
    Inc(P);
  until (P^ = #0);
end;

class function TB021FUtils.GetQuerystringParams(const PQueryString: String): TDictionary<String,String>;
// data una querystring (che può iniziare con il carattere ? o meno)
// estrae un TDictionary contenente le coppie (parametro,valore)
var
  S, ParCoppia: String;
  KeyValueArr: TArray<String>;
const
  PAR_SEPARATOR       = '&';
  PAR_VALUE_SEPARATOR = '=';
begin
  Result:=TDictionary<String,String>.Create;

  // trim degli eventuali spazi
  S:=PQueryString.Trim;

  // elimina eventuale punto interrogativo iniziale in modo da ottenere 
  // solo l'elenco di coppie parametro / valore
  if S.StartsWith('?') then
    S:=S.Substring(1);

  // inoltre vengono riportate le coppie dei parametri in input
  for ParCoppia in S.Split([PAR_SEPARATOR]) do
  begin
    KeyValueArr:=ParCoppia.Split([PAR_VALUE_SEPARATOR]);
    Result.Add(KeyValueArr[0],KeyValueArr[1]);
  end;
end;

class function TB021FUtils.GetLogFmt(const PClassName, PProcName, PLogInfo: String): String;
// formatta le informazioni per il log
begin
  Result:=Format('%s [%s.%s] %s',[FormatDateTime('dd/mm/yyyy hh.mm.ss',Now),PClassName,PProcName,PLogInfo]);
end;

class function TB021FUtils.GetDatabaseEffettivo(const PDatabase: String): String;
begin
  Result:=PDatabase;
  if Result = DATABASE_DEFAULT then
    Result:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B021','DATABASE','')
end;

class function TB021FUtils.GetAziendaEffettiva(const PAzienda: String): String;
begin
  Result:=PAzienda;
  if Result = AZIENDA_DEFAULT then
    Result:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B021','AZIENDA','');
end;

class function TB021FUtils.GetUtenteI070Effettivo(const PUtenteI070: String): String;
begin
  Result:=PUtenteI070;
  if Result = UTENTE_I070_DEFAULT then
    Result:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B021','UTENTE','')
end;

class function TB021FUtils.GetDatiConnessione(const PDatabase, PAzienda, PUtenteI070: String): TDatiConnessione;
begin
  Result.Database:=PDatabase;
  Result.Azienda:=PAzienda;
  Result.UtenteI070:=PUtenteI070;
end;

class function TB021FUtils.GetDatiConnessioneEffettivi(const PDatabase, PAzienda, PUtenteI070: String): TDatiConnessione;
// restituisce il record con i parametri effettivi di connessione
begin
  Result:=GetDatiConnessione(GetDatabaseEffettivo(PDatabase),
                             GetAziendaEffettiva(PAzienda),
                             GetUtenteI070Effettivo(PUtenteI070));
end;

class function TB021FUtils.CreaToken(const PUnixTime: Int64; const PParTokenPassphrase: String): String;
// crea il token di accesso ai servizi cifrato con l'algoritmo SHA-1
var
  LTokenData: String;
begin
  // il token contiene il timestamp e una passphrase
  LTokenData:=Format('%d%s',[PUnixTime, PParTokenPassphrase]);

  // cifra il token con l'algoritmo SHA-1
  Result:=R180Sha1Encrypt(LTokenData);
end;

class function TB021FUtils.VerificaToken(const PToken: String; const PUnixTime: Int64; const PParTokenPassphrase: String; const PParTokenTimeout: Integer): TResCtrl;
var
  LTimestampCorr: Int64;
  LDiff: Int64;
  LTokenCfr: string;
begin
  Result.Clear;

  // controllo parametri in ingresso
  if PToken = '' then
  begin
    Result.Messaggio:='Accesso al metodo non consentito: il token di autenticazione non è stato fornito';
    Exit;
  end;

  if PUnixTime = 0 then
  begin
    Result.Messaggio:='Accesso al metodo non consentito: il timestamp per l''autenticazione non è stato fornito';
    Exit;
  end;

  // salva il timestamp corrente
  LTimeStampCorr:=TB021FUtils.GetUnixTimeCorrente;

  // ricostruisce il token con i parametri ricevuti
  LTokenCfr:=TB021FUtils.CreaToken(PUnixTime,PParTokenPassphrase);

  // confronta il token ricevuto con quello ricostruito
  if PToken.ToUpper <> LTokenCfr.ToUpper then
  begin
    Result.Messaggio:='Accesso al metodo non consentito: il token fornito non è valido';
    Exit;
  end;

  // verifica la scadenza del token

  // differenza in secondi fra il timestamp della richiesta e quello corrente
  LDiff:=LTimeStampCorr - PUnixTime;

  // verifica differenza
  Result.Ok:=Abs(LDiff) <= PParTokenTimeout;
  if not Result.Ok then
  begin
    Result.Messaggio:='Accesso al metodo non consentito: ' +
                      IfThen(LDiff < 0,
                             'il timestamp della richiesta è incongruente',
                             'il token fornito è scaduto');
    Exit;
  end;

  // tutto ok
  Result.Ok:=True;
end;

{ EB021InvalidStructure }

procedure EB021InvalidStructure.RaisingException(P: System.PExceptionRecord);
begin
  inherited;
  //***Code:=ERR_EB021INVALID_STRUCTURE;
end;

{ EB021DuplicateDocument }

procedure EB021DuplicateDocument.RaisingException(P: System.PExceptionRecord);
begin
  inherited;
  //
end;

end.
