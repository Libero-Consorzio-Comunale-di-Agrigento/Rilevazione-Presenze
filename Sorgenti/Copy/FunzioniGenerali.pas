unit FunzioniGenerali;

interface

uses
  A000UCostanti,
  A000UMessaggi,
  {$IFDEF MSWINDOWS}
  CodeSiteLogging,
  {$ENDIF MSWINDOWS}
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Math,
  System.DateUtils,
  System.StrUtils,
  System.UITypes,
  System.TypInfo,
  System.Types,
  System.IOUtils,
  System.Character,
  Data.DB,
  IdCoderMIME,
  IdGlobal,
  IdHashMessageDigest;
type

  TDateTimeHelper = record helper for TDateTime
  private
    function GetIsNull: Boolean; inline;
    function GetDay: Word; inline;
    function GetDate: TDateTime; inline;
    function GetDayOfWeek: Word; inline;
    function GetDayOfYear: Word; inline;
    function GetHour: Word; inline;
    function GetMillisecond: Word; inline;
    function GetMinute: Word; inline;
    function GetMonth: Word; inline;
    function GetSecond: Word; inline;
    function GetTime: TDateTime; inline;
    function GetYear: Word; inline;
    class function GetNow: TDateTime; static; inline;
    class function GetToday: TDateTime; static; inline;
    class function GetTomorrow: TDateTime; static; inline;
    class function GetYesterDay: TDateTime; static; inline;
  public
    class function Create(const aYear, aMonth, aDay: Word): TDateTime; overload; static; inline;
    class function Create(const aYear, aMonth, aDay, aHour, aMinute, aSecond, aMillisecond: Word): TDateTime; overload; static; inline;

    class property Now: TDateTime read GetNow;
    class property Today: TDateTime read GetToday;
    class property Yesterday: TDateTime read GetYesterDay;
    class property Tomorrow: TDateTime read GetTomorrow;

    property IsNull: Boolean read GetIsNull;

    property Date: TDateTime read GetDate;
    property Time: TDateTime read GetTime;

    property DayOfWeek: Word read GetDayOfWeek;
    property DayOfYear: Word read GetDayOfYear;

    property Year: Word read GetYear;
    property Month: Word read GetMonth;
    property Day: Word read GetDay;
    property Hour: Word read GetHour;
    property Minute: Word read GetMinute;
    property Second: Word read GetSecond;
    property Millisecond: Word read GetMillisecond;

    function ToString(const aFormatStr: String = ''): String; overload; inline;
    function ToString(const aFmtSettings: TFormatSettings; const aFormatStr: String = ''): String; overload; inline;

    function StartOfYear: TDateTime; inline;
    function EndOfYear: TDateTime; inline;
    function StartOfMonth: TDateTime; inline;
    function EndOfMonth: TDateTime; inline;
    function StartOfWeek: TDateTime; inline;
    function EndOfWeek: TDateTime; inline;
    function StartOfDay: TDateTime; inline;
    function EndOfDay: TDateTime; inline;

    function AddYears(const aNumberOfYears: Integer = 1): TDateTime; inline;
    function AddMonths(const aNumberOfMonths: Integer = 1): TDateTime; inline;
    function AddWeeks(const aNumberOfWeeks: Integer = 1): TDateTime; inline;
    function AddDays(const aNumberOfDays: Integer = 1): TDateTime; inline;
    function AddHours(const aNumberOfHours: Int64 = 1): TDateTime; inline;
    function AddMinutes(const aNumberOfMinutes: Int64 = 1): TDateTime; inline;
    function AddSeconds(const aNumberOfSeconds: Int64 = 1): TDateTime; inline;
    function AddMilliseconds(const aNumberOfMilliseconds: Int64 = 1): TDateTime; inline;

    function Equals(const aDateTime: TDateTime): Boolean; inline;
    function IsSameDay(const aDateTime: TDateTime): Boolean; inline;
    function InRange(const aStartDateTime, aEndDateTime: TDateTime; const aInclusive: Boolean = True): Boolean; inline;
    function IsInLeapYear: Boolean; inline;
    function IsToday: Boolean; inline;
    function IsAM: Boolean; inline;
    function IsPM: Boolean; inline;

    function YearsBetween(const aDateTime: TDateTime): Integer; inline;
    function MonthsBetween(const aDateTime: TDateTime): Integer; inline;
    function WeeksBetween(const aDateTime: TDateTime): Integer; inline;
    function DaysBetween(const aDateTime: TDateTime): Integer; inline;
    function HoursBetween(const aDateTime: TDateTime): Int64; inline;
    function MinutesBetween(const aDateTime: TDateTime): Int64; inline;
    function SecondsBetween(const aDateTime: TDateTime): Int64; inline;
    function MilliSecondsBetween(const aDateTime: TDateTime): Int64; inline;
  end;

  TProcObject = procedure of object;

  TNotifyEventWrapper = class(TComponent)
  private
    FProc: TProc<TObject>;
  public
    constructor Create(Owner: TComponent; Proc: TProc<TObject>); reintroduce;
  published
    procedure Event(Sender: TObject);
  end;

  // gestione log
  TLogOptions = record
    LogDescription: String;
    LogOnFile: Boolean;
    LogOnLiveView: Boolean;
    FilePath: String;
    FileName: String;
    constructor Create(PLogDescription: String; PLogOnFile: Boolean;
      PLogOnLiveView: Boolean; const PFilePath: String; const PFileName: String = '');
  end;

  // classe per gestione dei log
  TLogger = class
  private
    class var FFilePath: String;
    class var FFileName: String;
    {$IFDEF MSWINDOWS}
    class var FDestination: TCodeSiteDestination;
    {$ENDIF MSWINDOWS}
  public
    class constructor Create;
    class destructor Destroy;
    class procedure Configure(const POptions: TLogOptions);
    class procedure SetLiveView(const PActive: Boolean);
    class procedure SetCategory(const PCategory: String);
    class procedure Debug(const PMsg: String); overload;
    class procedure Debug(const PMsg: String; const PObj: TObject); overload;
    class procedure Debug(const PMsg: String; const PValue: String); overload;
    class procedure Debug(const PMsg: String; const PValue: Char); overload;
    class procedure Debug(const PMsg: String; const PValue: Integer); overload;
    class procedure Debug(const PMsg: String; const PValue: Int64); overload;
    class procedure Debug(const PMsg: String; const PValue: TDateTime); overload;
    class procedure Warning(const PMsg: String);
    class procedure Error(const PMsg: String); overload;
    class procedure Error(const PMsg: String; PException: Exception); overload;
    class procedure EnterMethod(const PMethodName: String; const PObj: TObject = nil);
    class procedure ExitMethod(const PMethodName: String; const PObj: TObject = nil); overload;
    class property PathLog: String read FFilePath;
    class property LogFile: String read FFileName;
  end;

  TOffsetPeriodo = record
    Tipo: Char;
    Valore: Integer;
    function ToString: String;
  end;

  TPeriodo = record
    Inizio: TDateTime;
    Fine: TDateTime;
    function GetPatternPeriodo: TOffsetPeriodo; inline;
    function ShiftPeriodo(PSpostaAvanti, PPeriodoContiguo: Boolean): TPeriodo; inline;
  end;

  TFunzioniGenerali = class
  public
    class function _In(const Valore: String; lstValori: array of String): Boolean; overload; static;
    class function _In(const Valore: Integer; lstValori:array of Integer): Boolean; overload; static;
    class function _In(const Valore: TObject; lstValori:array of TObject): Boolean; overload; static;
    //class procedure SettaVariabiliAmbiente(Parametri_Lingua:String); static;
    class function _VarToDateTime(V:Variant):TDateTime;
    class function AddMesi(Data: TDateTime; Mesi: Integer; MantieniFineMese: Boolean = False): TDateTime; static;
    class function AggiungiApice(Value: String): String; static;
    class function Anno(Data: TDateTime): Word; static;
    class procedure AppendFile(const NomeFile, Testo: String); static;
    class procedure AppendFileNoCR(const NomeFile, Testo: String); static;
    class function Arrotonda(Dato, Valore: Real; Tipo: String): Real; static;
    class function ArrotondaMinuti(Valore, Arrotondamento: Integer): Integer; static;
    class function AttivaHintSQL(SQL: String; VersioneOracle: Integer): String; static;
    class function AzzeraPrecisione(Dato: Real; NumDec: Integer): Real; static;
    class function Between(const Valore, Da, A: String): Boolean; overload; static;
    class function Between(const Valore, Da, A: Integer): Boolean; overload; static;
    class function Between(const Valore, Da, A: TDateTime): Boolean; overload; static;
    class procedure ByteArrayToFile(const PByteArr: TByteDynArray; const PFileName: String); static;
    class function CalcolaCIN(ABI,CAB,CC: String): String; static;
    class function CalcolaCINEuropa(ABI,CAB,CC,CinItalia,CodNazione: String): String; static;
    class function ControllaIBAN(IBAN:String;var MsgErr:String):Boolean; static;
    class function CalcolaPasqua(Anno: Integer): TDateTime;
    class function CalcoloCodiceFiscale(Cognome, Nome, Sesso, CodCat: String; DataNas: TDateTime): String; static;
    class function Capitalize(const PTesto: String): String; static;
    class function CarattereDef(const S: String; N: Word = 1; D: Char = #0): Char; static;
    class function Centesimi(Minuti: Integer): String; static;
    class function CercaParolaIntera(const Parola, Stringa, CaratteriSeparazione: String): Integer; static;
    class function CifreDecimali(Dato: Real): Integer; static;
    class function ControllaPeriodo(const PDataInizio, PDataFine: String; var RDataInizio, RDataFine: TDateTime; var RErrMsg: String): Boolean; overload; static;
    class function ControllaPeriodo(const PDataInizio: String; const PNumeroGiorni: Integer; var RDataInizio, RDataFine: TDateTime; var RErrMsg: String): Boolean; overload; static;
    class function ControllaPeriodo(const PDataInizio, PDataFine: TDateTime; var RErrMsg: String): Boolean; overload; static;
    class function Cripta(S: String; Key: Integer): String; static;
    class function CriptaI070(Password: String): String; static;
    class function Decripta(S: String; Key: Integer): String; static;
    class function DecriptaI070(Password: String): String; static;
    class function DimLung(S: String; D: Integer): String; static;
    class function DimLungR(S: String; D: Integer): String; static;
    class function ElencoGiorni(Inizio, Fine: TDateTime; Formato: String): String; static;
    class function ElencoMesi(Inizio, Fine: TDateTime; Formato: String): String; static;
    class function EliminaRitornoACapo(Testo: String): String;
    class function EliminaSpaziMultipli(const Val: String): String; static;
    class function EliminaZeriASinistra(S: String): String; static;
    class function EstraiExtFile(S: String): String; static;
    class function EstraiNomeTabella(SqlText: String): String; static;
    class function Festivo(Giorno, Mese, Anno: Integer): Boolean; static;
    class function FileToByteArray(const PFileName: String): TByteDynArray; static;
    class function FineMese(Data: TDateTime): TDateTime; static;
    class function FineMeseSettimanale(Data: TDateTime; UltimaSettInterna: Boolean): TDateTime;
    class function FormatiCodificati(Dato, Formato: String; Lung: Integer = 0): String; static;
    class function FormattaNumero(PNumero, PFormato: String): String; static;
    class function GetCampiConcatenati(D: TDataSet; C: TStringList; BUsaOldValues: Boolean = False): String; static;
    class function GetCaptionTipologia(TipoQuota: String): String; static;
    class function GetCsvIntersect(const PElenco1, PElenco2: String): String; static;
    class function GetFileName(S: String): String; static;
    class function GetFilePath(S: String; EndSlash: Boolean = False): String; static;
    class function GetFileSizeStr(const PSizeInBytes: Int64): String; static;
    class function GetInstallationPath: String; static;
    class function GetPropValue(PObject: TObject; PropertyName: String): Variant; static;
    class function GetStringList(DataSet: TDataSet; Colonne: String): String; static;
    class function GetValore(PStringa, PDelim1, PDelim2: String; var Valore: String): Boolean; static;
    class function GiorniOreToStr(Valore: Real; UM: String; Formato: String = ''): String; static;
    class function Giorno(Data: TDateTime): Word; static;
    class function GiorniMese(Data: TDateTime): Byte; static;
    class function Identificatore(const Nome: String): String; static;
    class function InConcat(const Parola, Stringa: String): Boolean; static;
    class function Indenta(const PTesto: String; const PIndentazione: Integer): String; static;
    class function IndexFromValue(L: TStrings; Value: String): Integer; static;
    class function IndexOf(L: TStrings; S: String; NC: Word): Integer; static;
    class procedure InizializzaArray(var Vettore: array of Integer; Valore: Integer = 0); overload; static;
    class procedure InizializzaArray(var Vettore: array of Real; Valore: Real = 0); overload; static;
    class function InizioMese(Data: TDateTime): TDateTime; static;
    class function InizioMeseSettimanale(Data: TDateTime; UltimaSettInterna: Boolean): TDateTime; static;
    class function InserisciAliasT030(const StrSql: String): String; static;
    class function InserisciColonna(var PStrSQL: String; const PNomeColonna: String): Boolean; static;
    class function IsDigit(const PStr: String; PIndex: Integer): Boolean; overload; static;
    class function IsDigit(const PChr: Char): Boolean; overload; static;
    class function IsNumeric(S: String): Boolean; static;
    class function IsSpecialChar(const PChr: Char): Boolean; static;
    class function IsNewSpecialChar(const PChr: Char): Boolean; static;
    class function TestoInSetCaratteri(Testo,CharSet:String):Boolean; static;
    class function LPad(const PStr: String; PNumCaratteri: Integer; PCarattere: Char): string; static;
    class function LunghezzaCampo(F: TField): Integer; static;
    class function Mese(Data: TDateTime): Word; static;
    class function MinutiOre(Minuti: LongInt; const PTimeSeparator: Char = '.'): String; static;
    class function NomeFileDatato(NomeFile, Formato: String; Data: TDateTime): String; static;
    class function NomeGiorno(Anno, Mese, Giorno: Word): String; overload; static;
    class function NomeGiorno(D: TDateTime): String; overload; static;
    class function NomeGiornoSett(GiornoSettimana: Word): String; static;
    class function NomeMese(PNumeroMese: Byte): String; static;
    class function NumeroMese(const PMeseInLettere: String): Integer; static;
    class function NomeMeseAnno(D: TDateTime): String; static;
    class function NumOccorrenzeCar(S: String; C: Char): Integer; static;
    class function NumOccorrenzeString(const Substring, Text: string): Integer; static;
    class procedure OraValidate(S: String); static;
    class function OreMinuti(Ora:Variant): Word; overload; static;
    class function OreMinuti(Ora: TDateTime): Word; overload; static;
    class function OreMinuti(Ora: String): LongInt; overload; static;
    class function OreMinutiValidate(Valore: String): Boolean; static;
    class function RPad(const PStr: String; PNumCaratteri: Integer; PCarattere: Char): string; static;
    class procedure SetComboItemsValues(lst: TStrings; ItemsValues: array of TItemsValues; TipoLista: String); static;
    class function SetPropValue(PObject: TObject; PropertyName: String; PropertyValue: Variant): Boolean; static;
    class function SettimanaAnno(Data: TDateTime; IniziaDomenica: Boolean = True): Integer; static;
    class function SommaArray(Vettore: array of Integer): Integer; overload; static;
    class function SommaArray(Vettore: array of Real): Real; overload; static;
    class function SostituisciCaratteriSpeciali(Testo: String): String; static;
    class function Spaces(PStr: String; PNumSpazi: Word): String; static;
    {$WARN SYMBOL_DEPRECATED OFF}
    class procedure SplitLines(PList: TStrings; PBreakSet: TSysCharSet = [' ',',']; PMaxItemLength: Integer = 2000); static;
    {$WARN SYMBOL_DEPRECATED ON}
    class function SSO_TokenUsr(Utente, Mask: String): String; static;
    class procedure StringListIntersect(PList1, PList2: TStringList; var RListIntersect: TStringList); static;
    class function StrToGiorniOre(Valore, UM: String): Real; static;
    class procedure Tokenize(const PList: TStrings; const PStr: String; const PDelimiter: String = ','); static;
    class function AnonMethod2NotifyEvent(Owner: TComponent; Proc: TProc<TObject>): TNotifyEvent; static;
    // class function AnonMethod2Proc(Owner: TComponent; Proc: TProcObject): TProc; static;
    class function CreateDefaultFormatSettings: TFormatSettings; static; inline;
    class function GetDistanceFromCoords(PLat1, PLong1, PLat2, PLong2: Double): Double;
  end;

const
  // informazioni per formattazione data/ora default
  DEFAULT_DATE_SEPARATOR: Char     = '/';
  DEFAULT_SHORT_DATE_FMT           = 'dd/mm/yyyy';
  DEFAULT_TIME_SEPARATOR: Char     = '.';
  DEFAULT_SHORT_TIME_FMT           = 'hh.nn.ss';
  DEFAULT_LONG_TIME_FMT            = 'hh.nn.ss';

  PERIODO_ANNI  = 'A';
  PERIODO_MESI   = 'M';
  PERIODO_SETTIMANE = 'W';
  PERIODO_GIORNI = 'G';

implementation

{$IFDEF IRISWEB}{$IFNDEF WEBSVC}
uses
  IWApplication;
{$ENDIF}{$ENDIF}
{$IFDEF iOS}
uses
  Macapi.CoreFoundation;
{$ENDIF iOS}

{ TNotifyEventWrapper }

constructor TNotifyEventWrapper.Create(Owner: TComponent; Proc: TProc<TObject>);
begin
  inherited Create(Owner);
  FProc:=Proc;
end;

procedure TNotifyEventWrapper.Event(Sender: TObject);
begin
  FProc(Sender);
end;

{ TFunzioniGenerali }

class function TFunzioniGenerali.GetCaptionTipologia(TipoQuota: String): String;
begin
  Result:='';
  if TipoQuota = 'A' then
    Result:='Acconto'
  else if TipoQuota = 'S' then
    Result:='Saldo'
  else if TipoQuota = 'T' then
    Result:='Saldo Totale'
  else if TipoQuota = 'I' then
    Result:='Saldo Individuale'
  else if TipoQuota = 'V' then
    Result:='Saldo Valutativo'
  else if TipoQuota = 'C' then
    Result:='Saldo Collettivo'
  else if TipoQuota = 'D' then
    Result:='Saldo Collettivo Valutativo'
  else if TipoQuota = 'N' then
    Result:='Saldo Coll. val. non obbl.'
  else if TipoQuota = 'Q' then
    Result:='Quota quantitativa'
  else if TipoQuota = 'P' then
    Result:='Penalizzazione';
end;

class function TFunzioniGenerali.CalcolaCIN(ABI,CAB,CC: String): String;
// Dato un ABI, CAB e conto corrente, calcola il CIN Italia
const
  Numeri: String = '0123456789';
  Lettere: String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  LisPari: array[0..25] of Integer =
    (0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);
  LisDisp: array[0..25] of Integer =
      (1,0,5,7,9,13,15,17,19,21,2,4,18,20,11,3,6,8,12,14,16,10,22,25,24,23);
var
  BBAN,Ret: String;
  Aus: Char;
  i,j,Sum: Integer;
  Errore: Boolean;
  function Normalizza(Val: String;Dim: Integer): String;
  var i: Integer;
      Ret: String;
  begin
    Val:=Val.Trim;
    for i:=Val.Length + 1 to Dim do
      Ret:=Ret + '0';
    Result:=Ret + Val;
  end;
begin
  Errore:=False;

  if (ABI = '') or (CAB = '') or (CC = '') then
    Errore:=True;

  ABI:=Normalizza(ABI,5);
  CAB:=Normalizza(CAB,5);
  CC:=Normalizza(UpperCase(CC),12);
  BBAN:=CC + ABI + CAB;

  if BBAN.Length > 22 then
    Errore:=True;

  Sum:=0;
  for i:=0 to BBAN.Length - 1 do
  begin
    Aus:=BBAN.Chars[i];

    j:=Numeri.IndexOf(Aus);
    if j = -1 then
      j:=Lettere.IndexOf(Aus);
    if j > -1 then
      if ((i + 1) mod 2) = 0 then
        Sum:=Sum + LisPari[j]
      else
        Sum:=Sum + LisDisp[j]
    else
      Errore:=True;
  end;
  if not Errore then
    Ret:=Lettere.Substring((Sum mod 26),1)
  else
    Ret:='';
  Result:=Ret;
end;

class function TFunzioniGenerali.CalcolaCINEuropa(ABI,CAB,CC,CinItalia,CodNazione: String): String;
const
  ValoreOriginale:array[0..35] of char =
    ('0','1','2','3','4','5','6','7','8','9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');
  ValoreDecodificato:array[0..35] of String =
    ('0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35');
var
  IBANInvertito,IBANNumerico,S: String;
  I,J,Resto: Integer;
  TrovatoValore,Errore: Boolean;
  function Normalizza(Val: String;Dim: Integer): String;
  var i: Integer;
      Ret: String;
  begin
    Val:=Val.Trim;
    for i:=Val.Length + 1 to Dim do
      Ret:=Ret + '0';
    Result:=Ret + Val;
  end;
begin
  Errore:=False;

  if (ABI = '') or (CAB = '') or (CC = '') or (CinItalia = '') or (CodNazione = '') then
    Errore:=True;

  ABI:=Normalizza(ABI,5);
  CAB:=Normalizza(CAB,5);
  CC:=Normalizza(CC.ToUpper,12);
  IBANInvertito:=CinItalia + ABI + CAB + CC + CodNazione + '00';

  TrovatoValore:=False;
  for I:=0 to IBANInvertito.Length - 1 do
  begin
    TrovatoValore:=False;
    for J:=Low(ValoreOriginale) to High(ValoreOriginale) do
    begin
      if IBANInvertito.Chars[I] = ValoreOriginale[J] then
      begin
        IBANNumerico:=IBANNumerico + ValoreDecodificato[J];
        TrovatoValore:=True;
        break;
      end;
    end;
    if not TrovatoValore then
      break;
  end;

  if (TrovatoValore) and (not Errore) then
  begin
    S:=IBANNumerico;
    Resto:=0;
    while S.Length > 0 do
    begin
      Resto:=S.Substring(0,8).ToInteger mod 97;
      if S.Length > 8 then
        S:=Resto.ToString + S.Substring(8)
      else
        S:='';
    end;
    Result:=Format('%.2d',[(98 - Resto) mod 97]);
  end
  else
    Result:='';
end;

class function TFunzioniGenerali.ControllaIBAN(IBAN:String;var MsgErr:String):Boolean;
(*Vedi: http://alexandrerodichevski.chiappani.it/doc.php?n=219&lang=it#chk-algo
L'IBAN deve essere una stringa costituita di almeno 5 caratteri.
Deve contenere solo lettere maiuscole dell'alfabeto latino da A a Z e cifre da 0 a 9. Inoltre, le posizioni 0 e 1 possono essere occupate esclusivamente da una sigla valida ISO del paese, mentre le posizioni 2 e 3 da un numero.
I primi quattro caratteri della stringa originale vengono scambiati con il resto.
Ogni carattere � convertito in un codice da 0 a 35 secondo la seguente regola. La cifra � trasformata nel numero corrispondente, ad esempio 7 in 7. La lettera A si converte in 10, B in 11, ecc., Z si converte in 35. Dai numeri cos� ottenuti viene composta una nuova stringa numerica.
La stringa numerica viene interpretata ora come un numero. Dividendolo per 97, si dovrebbe ottenere come resto 1. Per facilitare la divisione dei numeri eccessivamente lunghi, � possibile spezzare la stringa numerica in parti pi� piccole e calcolare il resto della divisione della prima parte per 97, poi comporre nuova stringa numerica dal resto della divisione e dal secondo pezzo e dividere questo numero per 97, etc.
Esempio di controllo dell'IBAN:
Prendiamo in esame la stringa IT60Q0123412345000000753XYZ. Si seguano i passi dell'algoritmo:
� una stringa di 27 caratteri.
Contiene solo lettere maiuscole e cifre. Le posizioni 0 e 1 sono occupate dalle lettere IT, mentre le posizioni 2 e 3 sono costituite dal numero 60.
Scambiando i primi quattro caratteri con il resto, si ottiene Q0123412345000000753XYZIT60.
Convertendo nella stringa numerica, a Q corrisponde 26, a 0 corrisponde 0, a 1 corrisponde 1, ecc. Il risultato finale � 260123412345000000753333435182960.
Spezziamo la stringa numerica in cinque parti da almeno otto caratteri: 26012341, 23450000, 00753333, 43518296 e 0. Il resto della divisione di 26012341 per 97 � 45. Il resto della divisione di 4523450000 per 97 � 15. Il resto della divisione di 1500753333 per 97 � 82. Il resto della divisione di 8243518296 per 97 � 68. Il resto della divisione di 680 per 97 � 1.
Quindi il resto della divisione � 1. Questo codice IBAN � corretto.*)
var sIBAN,sCtrlIBAN,sCtrlIBANApp:String;
    i,Resto:Integer;
const
  Numeri: String = '0123456789';
  Lettere: String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
begin
  Result:=False;
  MsgErr:='';
  sIBAN:=IBAN;
  sIBAN:=StringReplace(sIBAN,'-','',[rfReplaceAll]);
  sIBAN:=StringReplace(sIBAN,' ','',[rfReplaceAll]);
  //CONTROLLI FORMALI
  if Length(sIBAN) <> 27 then
  begin
    MsgErr:='L''IBAN deve contenere 27 caratteri!';
    exit;
  end;
  if not TestoInSetCaratteri(sIBAN,Numeri + Lettere) then
  begin
    MsgErr:='L''IBAN pu� contenere soltanto numeri e lettere maiuscole!';
    exit;
  end;
  if Copy(sIBAN,1,2) <> 'IT' then
  begin
    MsgErr:='I caratteri dell''IBAN in posizione 1 e 2 devono identificare il sistema bancario italiano! Atteso: IT. Trovato: ' + Copy(sIBAN,1,2);
    exit;
  end;
  if not TestoInSetCaratteri(Copy(sIBAN,3,2),Numeri) then
  begin
    MsgErr:='I caratteri dell''IBAN in posizione 3 e 4 devono essere numerici! Trovato: ' + Copy(sIBAN,3,2);
    exit;
  end;
  if not TestoInSetCaratteri(Copy(sIBAN,5,1),Lettere) then
  begin
    MsgErr:='Il carattere dell''IBAN in posizione 5 deve essere una lettera maiuscola! Trovato: ' + Copy(sIBAN,5,1);
    exit;
  end;
  if not TestoInSetCaratteri(Copy(sIBAN,6,5),Numeri) then
  begin
    MsgErr:='I caratteri dell''IBAN in posizione da 6 a 10 devono essere numerici! Trovato: ' + Copy(sIBAN,6,5);
    exit;
  end;
  if not TestoInSetCaratteri(Copy(sIBAN,11,5),Numeri) then
  begin
    MsgErr:='I caratteri dell''IBAN in posizione da 11 a 15 devono essere numerici! Trovato: ' + Copy(sIBAN,11,5);
    exit;
  end;
  if not TestoInSetCaratteri(Copy(sIBAN,16,12),Numeri + Lettere) then
  begin
    MsgErr:='I caratteri dell''IBAN in posizione da 16 a 27 possono essere soltanto numeri e lettere maiuscole! Trovato: ' + Copy(sIBAN,16,12);
    exit;
  end;
  //ALGORITMO DI CONTROLLO
  //Sposto in fondo i primi quattro caratteri
  sCtrlIBAN:=Copy(sIBAN,5) + Copy(sIBAN,1,4);
  //I numeri rimangono tali, mentre le lettere vanno trasformate in numeri a partire dal 10
  sCtrlIBANApp:='';
  for i:=0 to Length(sCtrlIBAN) - 1 do
  begin
    if Lettere.IndexOf(sCtrlIBAN.Chars[i]) >= 0 then
      sCtrlIBANApp:=sCtrlIBANApp + IntToStr(Lettere.IndexOf(sCtrlIBAN.Chars[i]) + Length(Numeri))
    else
      sCtrlIBANApp:=sCtrlIBANApp + sCtrlIBAN.Chars[i];
  end;
  sCtrlIBAN:=sCtrlIBANApp;
  //Suddivido il numero in gruppi di 5 cifre da dividere per 97. Il resto diventa l'inizio del gruppo successivo finch� non ho terminato le cifre originali del numero
  Resto:=0;
  while sCtrlIBAN <> '' do
  begin
    sCtrlIBANApp:=IntToStr(Resto) + Copy(sCtrlIBAN,1,5);
    Resto:=StrToInt(sCtrlIBANApp) mod 97;
    sCtrlIBAN:=Copy(sCtrlIBAN,6);
  end;
  //Se il resto vale 1, allora il controllo � andato a buon fine
  Result:=Resto = 1;
end;

class function TFunzioniGenerali.ControllaPeriodo(const PDataInizio, PDataFine: String; var RDataInizio, RDataFine: TDateTime; var RErrMsg: String): Boolean;
// function che effettua i controlli standard su un periodo indicato con date in formato stringa
// nota: entrambe le date del periodo devono essere indicate
// restituisce
//   True  se il periodo � valido
//   False se il periodo non � valido (valorizza Err con il dettaglio dell'errore)
// valorizza
//   RDataInizio e RDataFine
//     con le date convertite se il periodo � valido
//     con date vuote se il periodo non � valido
// esempio
//   R180ControllaPeriodo('02/08/2014','31/09/2014')
//   -> controlla la validit� delle date espresse in stringa e la correttezza del periodo
//      in questo caso restituisce False (la data finale � errata)
var
  LInizio, LFine: TDateTime;
begin
  // 1. determina le date del periodo in base ai parametri
  // inizializzazione variabili
  Result:=False;
  RErrMsg:='';
  RDataInizio:=DATE_NULL;
  RDataFine:=DATE_NULL;

  // data inizio periodo
  if PDataInizio.Trim = '' then
  begin
    // data inizio vuota
    LInizio:=DATE_MIN;
  end
  else
  begin
    // data inizio indicata: verifica formato
    if not TryStrToDate(PDataInizio,LInizio) then
    begin
      RErrMsg:=A000MSG_ERR_DATA_INIZIO_PERIODO;
      Exit;
    end;
  end;

  // data fine periodo
  if PDataFine.Trim = '' then
  begin
    // data fine vuota
    LFine:=DATE_MAX;
  end
  else
  begin
    // data fine indicata: verifica formato
    if not TryStrToDate(PDataFine,LFine) then
    begin
      RErrMsg:=A000MSG_ERR_DATA_FINE_PERIODO;
      Exit;
    end;
  end;

  // 2. controlla il periodo
  Result:=TFunzioniGenerali.ControllaPeriodo(LInizio,LFine,RErrMsg);
  if Result then
  begin
    RDataInizio:=LInizio;
    RDataFine:=LFine;
  end;
end;

class function TFunzioniGenerali.ControllaPeriodo(const PDataInizio: String; const PNumeroGiorni: Integer; var RDataInizio, RDataFine: TDateTime; var RErrMsg: String): Boolean;
// function che effettua i controlli standard su un periodo indicato con data iniziale
// in formato stringa e numero di giorni
// restituisce
//   True  se il periodo � valido
//   False se il periodo non � valido (valorizza Err con il dettaglio dell'errore)
// valorizza
//   RDataInizio e RDataFine
//     con le date convertite se il periodo � valido
//     con date vuote se il periodo non � valido
// esempio
//   R180ControllaPeriodo('10/04/2014',18)
//   -> controlla la correttezza del periodo 10/04/2014 - 27/04/2014
//      in questo caso restituisce True
var
  LInizio, LFine: TDateTime;
begin
  // 1. determina le date del periodo in base ai parametri
  // inizializzazione variabili
  Result:=False;
  RErrMsg:='';
  RDataInizio:=DATE_NULL;
  RDataFine:=DATE_NULL;

  // data inizio periodo
  if PDataInizio.Trim = '' then
  begin
    // data inizio vuota
    LInizio:=DATE_MIN;
  end
  else
  begin
    // data inizio indicata: verifica formato
    if not TryStrToDate(PDataInizio,LInizio) then
    begin
      RErrMsg:=A000MSG_ERR_DATA_INIZIO_PERIODO;
      Exit;
    end;
  end;

  // il numero di giorni deve essere almeno pari a 1 (1 giorno totale)
  if PNumeroGiorni < 1 then
  begin
    RErrMsg:=A000MSG_ERR_PERIODO_ERRATO;
    Exit;
  end;

  // calcola data fine periodo
  LFine:=LInizio + (PNumeroGiorni - 1);

  // 2. controlla il periodo
  Result:=TFunzioniGenerali.ControllaPeriodo(LInizio,LFine,RErrMsg);
  if Result then
  begin
    RDataInizio:=LInizio;
    RDataFine:=LFine;
  end;
end;

class function TFunzioniGenerali.ControllaPeriodo(const PDataInizio, PDataFine: TDateTime; var RErrMsg: String): Boolean;
// function che effettua i controlli standard su un periodo indicato
// nota: la funzione controlla che le date siano entrambe indicate
begin
  Result:=False;
  RErrMsg:='';

  // 1. data inizio periodo
  // controlla validit� nel range convenzionale
  if (PDataInizio < DATE_MIN) or (PDataInizio > DATE_MAX) then
  begin
    RErrMsg:=A000MSG_ERR_DATA_INIZIO_PERIODO;
    Exit;
  end;
  // controlla indicazione data
  // la data inizio � considerata "vuota" se � uguale a DATE_NULL oppure a DATE_MIN
  if (PDataInizio = DATE_NULL) or (PDataInizio = DATE_MIN) then
  begin
    RErrMsg:=A000MSG_ERR_DATA_INIZIO_PERIODO_VUOTA;
    Exit;
  end;

  // 2. data fine periodo
  // controlla validit� nel range convenzionale
  if (PDataFine < DATE_MIN) or (PDataFine > DATE_MAX) then
  begin
    RErrMsg:=A000MSG_ERR_DATA_FINE_PERIODO;
    Exit;
  end;
  // controlla indicazione data
  // la data fine � considerata "vuota" se � uguale a DATE_NULL oppure a DATE_MAX
  if (PDataFine = DATE_NULL) or (PDataFine = DATE_MAX) then
  begin
    RErrMsg:=A000MSG_ERR_DATA_FINE_PERIODO_VUOTA;
    Exit;
  end;

  // 3. controlla consecutivit� periodo
  if PDataInizio > PDataFine then
  begin
    RErrMsg:=A000MSG_ERR_PERIODO_ERRATO;
    Exit;
  end;

  // periodo ok
  Result:=True;
end;

class function TFunzioniGenerali.IndexOf(L: TStrings; S: String; NC: Word): Integer;
var
  i: Integer;
begin
  Result:=-1;
  S:=S.Trim;
  for i:=0 to L.Count - 1 do
  begin
    if L[i].Substring(0,NC).Trim = S then
    begin
      Result:=i;
      Break;
    end;
  end;
end;

class function TFunzioniGenerali.IndexFromValue(L: TStrings; Value: String): Integer;
var
  i: Integer;
begin
  Result:=-1;
  for i:=0 to L.Count - 1 do
  begin
    if L.ValueFromIndex[i] = Value then
    begin
      Result:=i;
      Break;
    end;
  end;
end;

class function TFunzioniGenerali.AggiungiApice(Value: String): String;
begin
  Result:=StringReplace(Value,'''','''''',[rfReplaceAll]);
end;

class function TFunzioniGenerali.Centesimi(Minuti: Integer): String;
// Dati i minuti, restituisce la stringa nel formato hh:mm
// con i minuti espressi in centesimi.
var
  LOre: Integer;
  LMin: Integer;
begin
  LOre:=Abs(Minuti) div 60;
  LMin:=Abs(Minuti) mod 60;
  LMin:=round((LMin * 100) / 60);

  // pre: LOre < 60, LMin < 100
  Result:=Format('%s.%s',[LOre.ToString.PadLeft(2,'0'),LMin.ToString.PadLeft(2,'0')]);

  if Minuti < 0 then
    Result:='-' + Result;
end;

class function TFunzioniGenerali.MinutiOre(Minuti: LongInt; const PTimeSeparator: Char = '.'):String;
var
  LOre: Integer;
  LMin: Integer;
begin
  LOre:=Abs(Minuti) div 60;
  LMin:=Abs(Minuti) mod 60;

  // pre: LOre < 60, LMin < 60
  Result:=Format('%s%s%s',[LOre.ToString.PadLeft(2,'0'),PTimeSeparator,LMin.ToString.PadLeft(2,'0')]);

  if Minuti < 0 then
    Result:='-' + Result;
end;

class function TFunzioniGenerali.OreMinuti(Ora: Variant): Word;
begin
  if VarIsStr(Ora) then
    Result:=TFunzioniGenerali.OreMinuti(VarToStr(Ora))
  else
    Result:=TFunzioniGenerali.OreMinuti(TFunzioniGenerali._VarToDateTime(Ora));
end;

class function TFunzioniGenerali.OreMinuti(Ora: TDateTime): Word;
// Data un'ora del giorno in TDateTime, la converte in Minuti
var Hour,Min,Sec,MSec: Word;
begin
  DecodeTime(Ora, Hour, Min, Sec, MSec);
  Result:=Hour * 60  + Min;
end;

class function TFunzioniGenerali.OreMinuti(Ora: String): LongInt;
var
  Hour,Min: LongInt;
  LNegativo: Boolean;
  LElem: Char;
  LSeparatore: Char;
  LOraArr: TArray<String>;
begin
  Ora:=Ora.Trim;

  // determina se il valore orario � negativo (carattere "-" a inizio stringa)
  LNegativo:=Ora.StartsWith('-');

  // determina eventuale separatore ore - minuti
  LSeparatore:=#0;
  for LElem in TArray<Char>.Create('.',':',',') do
  begin
    if Ora.Contains(LElem) then
    begin
      LSeparatore:=LElem;
      Break;
    end;
  end;

  // se l'orario indicato non contiene un separatore, assume che il valore indicato sia un numero di ore
  if LSeparatore = #0 then
  begin
    Hour:=StrToIntDef(Ora,0);
    Min:=0;
  end
  else
  begin
    // divide l'orario nelle sue parti in base al separatore
    // (accetta anche i valori orari comprensivi di secondi (es. 23.59.15), troncando per� questi ultimi)
    LOraArr:=Ora.Split([LSeparatore]);
    Hour:=StrToIntDef(LOraArr[0],0);
    if Length(LOraArr) > 1 then
      Min:=StrToIntDef(LOraArr[1],0)
    else
      Min:=0;
  end;

  // converte il valore orario in minuti e modifica il segno se necessario
  Result:=Abs(Hour) * 60 + Min;
  if LNegativo then
    Result:=-Result;
end;

class function TFunzioniGenerali.GiorniMese(Data: TDateTime): Byte;
// Restituisce il numero di giorni del mese indicato dalla data
var
  Anno,Mese,Giorno: Word;
begin
  Result:=0;
  DecodeDate(Data,Anno,Mese,Giorno);
  case Mese of
     1: Result:=31;
     2: Result:=IfThen(IsLeapYear(Anno),29,28);
     3: Result:=31;
     4: Result:=30;
     5: Result:=31;
     6: Result:=30;
     7: Result:=31;
     8: Result:=31;
     9: Result:=30;
    10: Result:=31;
    11: Result:=30;
    12: Result:=31;
  end;
end;

class function TFunzioniGenerali.InizioMese(Data: TDateTime): TDateTime;
var
  A,M,G: Word;
begin
  DecodeDate(Data,A,M,G);
  Result:=EncodeDate(A,M,1);
end;

class function TFunzioniGenerali.FineMese(Data: TDateTime): TDateTime;
var
  A,M,G: Word;
begin
  DecodeDate(Data,A,M,G);
  Result:=EncodeDate(A,M,TFunzioniGenerali.GiorniMese(Data));
end;

class function TFunzioniGenerali.InizioMeseSettimanale(Data: TDateTime; UltimaSettInterna: Boolean): TDateTime;
// Restituisce l'inizio del mese nell'ambito del conteggio settimanale:
// il mese comincia sempre di luned� e finisce sempre di domenica}
begin
  Result:=TFunzioniGenerali.InizioMese(Data);
  if UltimaSettInterna then
    //luned� della prima settimana che interseca il mese e ultima settimana interna al mese
    Result:=Result - DayOfWeek(Result - 1) + 1
  else
    //luned� della prima settimana compresa nel mese e ultima settimana interseca mese succ.
    Result:=Result + ((8 - DayOfWeek(Result - 1)) mod 7);
end;

class function TFunzioniGenerali.FineMeseSettimanale(Data: TDateTime; UltimaSettInterna: Boolean): TDateTime;
{Restituisce la fine del mese nell'ambito del conteggio settimanale:
  il mese comincia sempre di luned� e finisce sempre di domenica}
begin
  Result:=TFunzioniGenerali.FineMese(Data);
  if DayOfWeek(Result - 1) < 7 then
  begin
    if UltimaSettInterna then
      //domenica dell'ultima settimana compresa nel mese
      Result:=Result - DayOfWeek(Result - 1)
    else
      //domenica dell'ultima settimana che interseca il mese
      Result:=Result + 7 - DayOfWeek(Result - 1);
  end;
end;

class function TFunzioniGenerali._VarToDateTime(V:Variant):TDateTime;
var S:String;
    TS:Char;
begin
  Result:=0;
  if not VarIsNull(V) then
  try
    if VarIsType(V,varDate) then
      Result:=VarToDateTime(V)
    else
    begin
      //Utilizza di preferenza TryStrToDateTime perch� VarToDateTime usa le impostazioni locali della macchina, anche se ridefinite dai FormatSettings
      S:=VarToStr(V);
      TS:={$IFNDEF VER210}FormatSettings.{$ENDIF}TimeSeparator;
      //Converto il separatore delle ore in quello previsto da FormatSettings.TimeSeparator in modo che la funzione TryStrToDateTime lavori orettamente
      //questo perch� VarToStr usa le impostazioni locali, mentre TryStrToDateTime le impostazioni di FormatSettings
      if Pos(TS,S) = 0 then
        S:=StringReplace(S,IfThen(TS = '.',':','.'),IfThen(TS = '.','.',':'),[rfReplaceAll]);
      if not TryStrToDateTime(S,Result) then
        Result:=VarToDateTime(V);
    end;
  except
    try
      Result:=VarToDateTime(V);
    except
      Result:=0;
    end;
  end;
end;

class function TFunzioniGenerali.AddMesi(Data: TDateTime; Mesi: Integer; MantieniFineMese: Boolean = False): TDateTime;
var
  A,M,G: Word;
  i: Integer;
  InizioMese: TDateTime;
begin
  DecodeDate(Data,A,M,G);
  if Mesi > 0 then
    for i:=1 to Abs(Mesi) do
    begin
      inc(M);
      if M > 12 then
      begin
        M:=1;
        inc(A);
      end;
    end
  else
    for i:=1 to Abs(Mesi) do
    begin
      dec(M);
      if M < 1 then
      begin
        M:=12;
        dec(A);
      end;
    end;
  InizioMese:=EncodeDate(A,M,1);
  if (G > TFunzioniGenerali.GiorniMese(InizioMese)) or
     ((Data = TFunzioniGenerali.FineMese(Data)) and MantieniFineMese) then
    Result:=TFunzioniGenerali.FineMese(InizioMese)
  else
  begin
    try
      Result:=EncodeDate(A,M,G);
    except
      Result:=TFunzioniGenerali.FineMese(InizioMese);
    end;
  end;
end;

class function TFunzioniGenerali.CarattereDef(const S: String; N: Word = 1; D: Char = #0): Char;
// Restituisce il carattere in posizione N della stringa S
// Gestisce la non esistenza di quella posizione nella stringa
begin
  Result:=#0;
  if N = 0 then
    exit;

  if S.Length >= N then
    Result:=S.Chars[N - 1]
  else
    Result:=D;
end;

class function TFunzioniGenerali.Spaces(PStr: String; PNumSpazi: Word): String;
// pad right di PNumSpazi alla stringa PStr
begin
  Result:=PStr.PadRight(PNumSpazi,' ');
end;

class function TFunzioniGenerali.EliminaSpaziMultipli(const Val: String): String;
begin
  // sostituisce CR e LF con spazio
  Result:=Val.Replace(#13,' ',[rfReplaceAll]).Replace(#10,' ',[rfReplaceAll]);

  // elimina spazi ripetuti
  while Result.IndexOf('  ') > -1 do
  begin
    Result:=Result.Replace('  ',' ',[rfReplaceAll]);
  end;

  // trim degli spazi a destra
  Result:=Result.TrimRight;
end;

class function TFunzioniGenerali.GetValore(PStringa,PDelim1,PDelim2: String; var Valore: String): Boolean;
// data una stringa PStringa e due delimitatori PDelim1 e PDelim2,
// restituisce:
// - True se esiste il PDelim1
//   valorizza Valore con la parte di stringa delimitata:
//   - a sx da PDelim1
//   - a dx da PDelim2 oppure dal fine stringa se PDelim2 � inesistente o non indicato
// - False se non esiste PDelim1
//
// es.
//   PStringa = '[C]0[F]Freestyle Script[S]8[ST]0000'
//   PDelim1  = '[F]'
//   PDelim2  = '[S]'
// Result = True
//   Valore = 'Freestyle Script'
var
  i,j: Integer;
begin
  Result:=False;

  // determina indice del primo carattere dopo il delimitatore 1
  i:=PStringa.IndexOf(PDelim1);
  if i < 0 then
    Exit;
  i:=i + PDelim1.Length;

  // determina indice del primo carattere prima del delimitatore 2
  if PDelim2 = '' then
    j:=PStringa.Length
  else
  begin
    j:=PStringa.IndexOf(PDelim2);
    if j < 0 then
      j:=PStringa.Length;
  end;

  // determina il contenuto fra il delimitatore 1 e 2 esclusi
  Valore:=PStringa.Substring(i,j - i);

  Result:=True;
end;

class function TFunzioniGenerali.DimLung(S: String; D: Integer): String;
// Aggiungo n spazi in coda ad S in modo da ottenere la lunghezza = D
var
  L: Integer;
begin
  if D = 0 then
    D:=S.Length;
  Result:=S.Substring(0,D);
  L:=Result.Length;
  if D > L then
    Result:=Result + StringOfChar(' ',D - L);
end;

class function TFunzioniGenerali.DimLungR(S: String; D: Integer): String;
// Aggiungo n spazi in testa ad S in modo da ottenere la lunghezza = D
var
  L: Integer;
begin
  if D = 0 then
    D:=S.Length;
  Result:=S.Substring(0,D);
  L:=Result.Length;
  if D > L then
    Result:=StringOfChar(' ',D - L) + Result;
end;

class function TFunzioniGenerali.LPad(const PStr: String; PNumCaratteri: Integer; PCarattere: Char): string;
// left pad
begin
  Result:=StringOfChar(PCarattere,PNumCaratteri - PStr.Length) + PStr;
end;

class function TFunzioniGenerali.RPad(const PStr: String; PNumCaratteri: Integer; PCarattere: Char): string;
// right pad
begin
  Result:=PStr + StringOfChar(PCarattere,PNumCaratteri - PStr.Length);
end;

class function TFunzioniGenerali.ElencoGiorni(Inizio,Fine: TDateTime; Formato: String): String;
// Restituisce una stringa contenente tutte le date da inizio a fine nel formato specificato
var Corr: TDateTime;
begin
  Result:='';
  Corr:=Inizio;
  while Corr <= Fine do
  begin
    Result:=Result + FormatDateTime(Formato,Corr);
    Corr:=Corr + 1;
  end;
end;

class function TFunzioniGenerali.ElencoMesi(Inizio,Fine: TDateTime; Formato: String): String;
// Restituisce una stringa contenente il numero del mese solo
var Corr: TDateTime;
    M: String;
begin
  Result:='';
  Corr:=Inizio;
  M:='';
  while Corr <= Fine do
  begin
    if M <> FormatDateTime('mm',Corr) then
    begin
      Result:=Result + TFunzioniGenerali.DimLung(FormatDateTime('mm',Corr),Formato.Length);
      M:=FormatDateTime('mm',Corr);
    end
    else
      Result:=Result + TFunzioniGenerali.DimLung('',Formato.Length);
    Corr:=Corr + 1;
  end;
end;

class function TFunzioniGenerali.NomeMese(PNumeroMese: Byte): String;
// restituisce il nome del mese indicato dal numero
//   1 = gennaio
//   2 = febbraio
//   ...
var
  LFmt: TFormatSettings;
begin
  Result:='';
  if PNumeroMese in [1..12] then
  begin
    LFmt:=TFunzioniGenerali.CreateDefaultFormatSettings;
    Result:=LFmt.LongMonthNames[PNumeroMese];
  end;
end;

class function TFunzioniGenerali.NumeroMese(const PMeseInLettere: String): Integer;
// restituisce il numero del mese indicato in lettere
// se il mese indicato non � valido restituisce convenzionalmente -1
var
  LFmt: TFormatSettings;
  LMeseStr: String;
  i: Integer;
begin
  Result:=-1;

  LMeseStr:=PMeseInLettere.Trim.ToUpper;
  if LMeseStr = '' then
    Exit;

  LFmt:=TFunzioniGenerali.CreateDefaultFormatSettings;

  // verifica se il nome del mese � espresso in formato lungo
  // (es. gennaio, febbraio, marzo, ...)
  for i:=1 to High(LFmt.LongMonthNames) do
  begin
    if LMeseStr = LFmt.LongMonthNames[i].ToUpper then
    begin
      Result:=i;
      Break;
    end;
  end;

  // verifica se il nome del mese � espresso in formato corto
  // (es. gen, feb, mar, ...)
  if Result = -1 then
  begin
    // nome del mese in formato corto: gen, feb, mar, ...
    for i:=1 to High(LFmt.ShortMonthNames) do
    begin
      if LMeseStr = LFmt.ShortMonthNames[i].ToUpper then
      begin
        Result:=i;
        Break;
      end;
    end;
  end;
end;

class function TFunzioniGenerali.NomeMeseAnno(D: TDateTime): String;
// restituisce mese in lettere e anno della data indicati
// es. R180NomeMeseAnno(05/04/2014) = 'Aprile 2014'
begin
  Result:=Format('%s %d',[TFunzioniGenerali.NomeMese(TFunzioniGenerali.Mese(D)),TFunzioniGenerali.Anno(D)]);
end;

class function TFunzioniGenerali.NomeGiorno(Anno,Mese,Giorno: Word): String;
begin
  try
    Result:=FormatSettings.LongDayNames[DayOfWeek(EncodeDate(Anno,Mese,Giorno))];
  except
    Result:='';
  end;
end;

class function TFunzioniGenerali.NomeGiorno(D: TDateTime): String;
begin
  Result:=FormatSettings.LongDayNames[DayOfWeek(D)];
end;

class function TFunzioniGenerali.NomeGiornoSett(GiornoSettimana: Word): String;
//Non si pu� fare un overload di R180NomeGiorno
//perch� non viene fatta distinzione sul parametro in ingresso tra Word e TDateTime,
//con l'effetto collaterale di richiamare sempre la stessa function
begin
  Result:='';
  if (GiornoSettimana >= 1) and (GiornoSettimana <= 6) then
    Result:=FormatSettings.LongDayNames[GiornoSettimana + 1]
  else if GiornoSettimana = 7 then
    Result:=FormatSettings.LongDayNames[1];
end;

// -----------------------   G E S T I O N E   F I L E   -----------------------
class procedure TFunzioniGenerali.AppendFile(const NomeFile,Testo: String);
// Appende il testo specificato al file NomeFile (usato per i file di log)
var
  F: TextFile;
begin
  AssignFile(F,NomeFile);
  if FileExists(NomeFile) then
    Append(F)
  else
    Rewrite(F);
  Writeln(F,Testo);
  CloseFile(F);
end;

class procedure TFunzioniGenerali.AppendFileNoCR(const NomeFile,Testo: String);
// Appende il testo specificato al file NomeFile (usato per i file di log)
var
  F: TextFile;
begin
  AssignFile(F,NomeFile);
  if FileExists(NomeFile) then
    Append(F)
  else
    Rewrite(F);
  Write(F,Testo);
  CloseFile(F);
end;

class function TFunzioniGenerali.Identificatore(const Nome: String): String;
var
  i: Integer;
begin
  Result:=Nome;

  i:=0;
  while i <= Result.Length - 1 do
  begin
    {$WARN WIDECHAR_REDUCED OFF}
    if not (Result.Chars[i] in ['A'..'Z', 'a'..'z', '0'..'9', '_']) then
    {$WARN WIDECHAR_REDUCED ON}
      Result:=Result.Remove(i,1)
    else
      inc(i);
  end;
end;

class function TFunzioniGenerali.EliminaRitornoACapo(Testo: String): String;
// sostituisce ogni occorrenza di CRLF presente nella stringa con uno spazio
begin
  Result:=Testo.Replace(#$D#$A,' ',[rfReplaceAll,rfIgnoreCase]);
end;

class function TFunzioniGenerali.CalcolaPasqua(Anno: Integer): TDateTime;
var
  SAnno,DAnno,VarCal,VarCal1,VarCal2,Anno1,Anno2,Anno3,Anno4,Ope,Ope1,Erre,Erre1: Integer;
  GP,MP: Integer;
begin
  SAnno:=Anno.ToString.Substring(0,2).ToInteger;
  DAnno:=Anno.ToString.Substring(2,2).ToInteger;
  VarCal:=Trunc(Anno / 19);
  Anno1:=Anno - VarCal * 19;
  VarCal:=Trunc(SAnno / 30);
  Anno2:=SAnno - Varcal * 30;
  VarCal:=Trunc((SAnno - 15) / 25);
  Anno3:=(SAnno - 15) - VarCal * 25;
  VarCal:=Trunc(SAnno / 4);
  VarCal1:=Trunc(Anno3 / 3);
  VarCal2:=Trunc((SAnno - 15) / 25);
  Ope1:=30 + Anno1 * 11 - Anno2 + VarCal + VarCal2 * 8 + VarCal1;
  VarCal:=Trunc(Ope1 / 30);
  Ope:=Ope1 - VarCal * 30;
  if Ope <> 11 then
  begin
    if Ope > 11 then
    begin
      VarCal:=TRUNC(Anno / 19);
      Anno4:=VarCal * 19;
      if (Ope = 12) and (Anno4 > 10) then
        Ope:=13;
    end
    else
      Ope:=Ope + 30;
  end
  else
    Ope:=12;
  VarCal:=Trunc(SAnno / 4);
  Anno4:=SAnno - VarCal * 4;
  VarCal:=Trunc(DAnno / 4);
  Erre1:=DAnno + VarCal + Anno4 * 5 + Ope * 6;
  VarCal:=Trunc(Erre1 / 7);
  Erre:=Erre1 - VarCal * 7;
  GP:=68 - Ope - Erre;
  MP:=3;
  if GP > 31 then
  begin
    GP:=GP - 31;
    MP:=4;
  end;
  Result:=StrToDateTime(GP.ToString + '/' + MP.ToString + '/' + Anno.ToString);
end;

class function TFunzioniGenerali.Festivo(Giorno,Mese,Anno: Integer): Boolean;
begin
  Result:=False;
  case Mese of
    1:Result:=(giorno = 1) or (giorno = 6);
    4:Result:=giorno = 25;
    5:Result:=giorno = 1;
    6:Result:=(giorno = 2) and (anno >= 2001);
    8:Result:=giorno = 15;
    11:Result:=giorno = 1;
    12:Result:=(giorno = 8) or (giorno = 25) or (giorno = 26);
  end;
end;

class function TFunzioniGenerali.ArrotondaMinuti(Valore, Arrotondamento: Integer): Integer;
// Arrotondamento Valore come routine z892_arrotondaP su Rp502Pro
var ArrAbs: Integer;
begin
  Result:=Valore;
  if Arrotondamento = 0 then exit;
  ArrAbs:=Abs(Arrotondamento);
  if Valore mod ArrAbs = 0 then exit;
  Result:=(Valore div ArrAbs) * ArrAbs;
  if Arrotondamento < 0 then
    inc(Result,ArrAbs);
end;


// ------------------   G E S T I O N E   P A S S W O R D    -------------------
class function TFunzioniGenerali.Cripta(S: String; Key: Integer): String;
// Usata per criptare la password dell'utente Oracle MONDOEDP
// I caratteri utilizzati vanno dal codice 32 al 126
var
  i,k,OS: Integer;
  SKey: String;
begin
  Result:='';
  SKey:=Key.ToString;

  k:=-1;
  for i:=0 to S.Length - 1 do
  begin
    inc(k);
    if k >= SKey.Length then
      k:=0;
    OS:=StrToInt(SKey.Chars[k]);

    inc(k);
    if k >= SKey.Length then
      k:=0;
    OS:=OS + StrToInt(SKey.Chars[k]);

    dec(k);
    if Ord(S.Chars[i]) + OS > 126 then
      Result:=Result + Chr(31 + Ord(S.Chars[i]) + OS - 126)
    else
      Result:=Result + Chr(Ord(S.Chars[i]) + OS);
  end;
end;

class function TFunzioniGenerali.Decripta(S: String; Key: Integer): String;
// Usata per decriptare la password dell'utente Oracle MONDOEDP
// I caratteri utilizzati vanno dal codice 32 al 126
var
  i,k,OS: Integer;
  SKey: String;
begin
  Result:='';
  SKey:=Key.ToString;

  k:=-1;
  for i:=0 to S.Length - 1 do
  begin
    inc(k);
    if k >= SKey.Length then
      k:=0;
    OS:=StrToInt(SKey.Chars[k]);

    inc(k);
    if k >= SKey.Length then
      k:=0;
    OS:=OS + StrToInt(SKey.Chars[k]);

    dec(k);
    if Ord(S.Chars[i]) - OS < 32 then
      Result:=Result + Chr(126 - (31 - (Ord(S.Chars[i]) - OS)))
    else
      Result:=Result + Chr(Ord(S.Chars[i]) - OS);
  end;
end;

class function TFunzioniGenerali.CriptaI070(Password: String): String;
// Restituisce la stringa crittografata per la password riferita a I070_UTENTI
var
  Criptato: String;
  i: Integer;
begin
  if Password.Trim = '' then
  begin
    result:='';
    exit;
  end;

  Criptato:='';
  for i:=Password.Length - 1 downto 0 do
  begin
    Criptato:=Criptato + IntToHex(158 - Ord(Password.Chars[i]),2);
  end;
  Result:=Criptato;
end;

class function TFunzioniGenerali.DecriptaI070(Password: String): String;
// Rende leggibile la stringa crittografata per la password riferita a I070_UTENTI
var
  Criptato,EsaDec: String;
  i: Integer;
begin
  if Password.Trim = '' then
  begin
    result:='';
    exit;
  end;

  Criptato:='';
  i:=Password.Length;
  while i > 0 do
  begin
    EsaDec:='$' + Password.Substring(i - 2,2);
    try
      Criptato:=Criptato + Chr(158 - EsaDec.ToInteger);
    except
    end;
    i:=i - 2;
  end;
  Result:=Criptato;
end;

class function TFunzioniGenerali.InserisciColonna(var PStrSQL: String; const PNomeColonna: String): Boolean;
// Ricerca la stringa C in S
//   S � la query anagrafica restituita da C700
// Se C non esiste viene inserita
var
  CampiSel,SUpper: String;
begin
  Result:=False;

  // verifica che ci siano colonne da aggiungere
  if PNomeColonna = '' then
    exit;

  SUpper:=PStrSQL.ToUpper;

  // verifica che la stringa sql contenga le keyword "SELECT" e "FROM"
  if (not SUpper.Contains('SELECT')) or
     (not SUpper.Contains('FROM')) then
    Exit;

  // estrae il testo contenuto fra le keyword "SELECT" e "FROM"
  if not TFunzioniGenerali.GetValore(SUpper,'SELECT','FROM',CampiSel) then
    Exit;

  if TFunzioniGenerali.CercaParolaIntera(PNomeColonna.ToUpper,CampiSel.ToUpper,'.,;') = 0 then
  begin
    // inserisce la colonna prima della keyword "FROM"
    PStrSQL:=PStrSQL.Insert(SUpper.IndexOf('FROM'),Format(',%s ',[PNomeColonna]));
    Result:=True;
  end;
end;

class function TFunzioniGenerali.InserisciAliasT030(const StrSql: String): String;
// Verifica nella stringa SQL indicata la presenza di campi della T030_ANAGRAFICO
// privi dell'alias "T030" e lo inserisce automaticamente
var
  i, Offset: Integer;
  SearchStr, OldCampo, NewCampo, NewStr: string;
const
  ALIAS_T030: String = 'T030.';
begin
  Result:=StrSql;
  for i:=Low(CampiT030) to High(CampiT030) do
  begin
    SearchStr:=Result.ToUpper;
    OldCampo:=CampiT030[i].ToUpper;
    NewCampo:=ALIAS_T030 + OldCampo;

    NewStr:=Result;
    Result:='';
    while SearchStr <> '' do
    begin
      Offset:=TFunzioniGenerali.CercaParolaIntera(OldCampo,SearchStr,',()=<>|!/+-*');
      if Offset = 0 then
      begin
        Result:=Result + NewStr;
        Break;
      end;
      Result:=Result + NewStr.Substring(0,Offset - 1) + NewCampo;
      NewStr:=NewStr.Substring(Offset + OldCampo.Length - 1);
      SearchStr:=SearchStr.SubString(Offset + OldCampo.Length - 1);
    end;
  end;
end;

class function TFunzioniGenerali.InConcat(const Parola,Stringa: String): Boolean;
// Restituisce True se Parola esiste in Stringa che contiene valori separati da Virgola
var
  LStr: String;
  LSubStr: String;
begin
  LStr:=Format(',%s,',[Stringa]);
  LSubStr:=Format(',%s,',[Parola]);
  Result:=LStr.IndexOf(LSubStr) >= 0;
end;

class function TFunzioniGenerali.CercaParolaIntera(const Parola,Stringa,CaratteriSeparazione: String): Integer;
// Funzione ricorsiva per cercare Parola dentro Stringa se � limitata da spazi
// o da caratteri contenuti in CaratteriSeparazione
var
  x,y: Integer;
  LCharPrec: Char;
  LCharSucc: Char;
  LPosLastChar: Integer;
  LStartIdx: Integer;
  LInizioStringa: Boolean;
  LFineStringa: Boolean;
  LCharPrecOk: Boolean;
  LCharSuccOk: Boolean;
  LOk: Boolean;
  LStr: string;
begin
  Result:=0;

  // se la parola non � specificata esce subito
  if Parola = '' then
    exit;

  // se la parola da cercare � pi� lunga della stringa esce subito
  if Parola.Length > Stringa.Length then
    Exit;

  // cerca la parola nella stringa
  x:=Stringa.IndexOf(Parola);
  if x > -1 then
  begin
    LInizioStringa:=x = 0;
    LPosLastChar:=(x + Parola.Length - 1);
    LFineStringa:=LPosLastChar + 1 >= Stringa.Length;

    // verifica se il carattere precedente � un delimitatore
    if LInizioStringa then
    begin
      LCharPrecOk:=True;
    end
    else
    begin
      LCharPrec:=Stringa.Chars[x - 1];
      {$WARN WIDECHAR_REDUCED OFF}
      LCharPrecOk:=(LCharPrec in [' ',#$D,#$A]) or (CaratteriSeparazione.IndexOf(LCharPrec) > -1);
      {$WARN WIDECHAR_REDUCED ON}
    end;

    LOk:=LCharPrecOk;

    // se il carattere precedente � ok,
    // verifica se il carattere successivo � un delimitatore
    if LOk then
    begin
      if LFineStringa then
      begin
        LCharSuccOk:=True;
      end
      else
      begin
        LCharSucc:=Stringa.Chars[LPosLastChar + 1];
        {$WARN WIDECHAR_REDUCED OFF}
        LCharSuccOk:=(LCharSucc in [' ',#$D,#$A]) or (CaratteriSeparazione.IndexOf(LCharSucc) > -1);
        {$WARN WIDECHAR_REDUCED ON}
      end;

      LOk:=LCharSuccOk;
    end;

    // determina posizione
    if LOk then
    begin
      // la parola intera (delimitata dai caratteri specificati) � stata trovata
      Result:=x + 1;
    end
    else
    begin
      // la parola intera non � stata trovata
      // se non si � arrivati a fine stringa cerca nella porzione successiva
      if not LFineStringa then
      begin
        // ricerca nella porzione successiva di stringa
        LStartIdx:=LPosLastChar + 2;
        LStr:=Stringa.Substring(LStartIdx);
        y:=TFunzioniGenerali.CercaParolaIntera(Parola,LStr,CaratteriSeparazione);
        if y > 0 then
          Result:=LStartIdx + y;
      end;
    end;
  end;
end;

class function TFunzioniGenerali.NumOccorrenzeCar(S: String; C: Char): Integer;
// restituisce il numero di occorrenze del carattere C nella stringa S
begin
  Result:=S.CountChar(C);
end;

class procedure TFunzioniGenerali.OraValidate(S: String);
begin
  if S = '' then
    exit;
  if S.Length <> 5 then
    raise Exception.Create('Il formato del dato � HH.MM');
  if S.IndexOf(' ') >= 0 then
    raise Exception.Create('Il formato del dato � HH.MM');
  if S.Substring(0,2).ToInteger > 23 then
    raise Exception.Create('Le ore devono essere comprese tra 00 e 23');
  if S.SubString(3,2).ToInteger > 59 then
    raise Exception.Create('I minuti devono essere compresi tra 00 e 59');
end;

class function TFunzioniGenerali.OreMinutiValidate(Valore: String): Boolean;
// verifica se il valore � un dato di tipo ore minuti valido
var
  Posiz,Minuti : Integer;
  SOre, SMin : String;
begin
  Result:=False;

  if Valore.Trim.IndexOf(' ') > 0 then
    raise Exception.Create('Dato non valido!');

  // cerca delimitatore
  Posiz:=Valore.IndexOf('.');
  if Posiz = -1 then
    Posiz:=Valore.IndexOf(':');
  if Posiz = -1 then
    Exit;

  // parte relativa ai minuti
  SMin:=Valore.Substring(Posiz + 1,2).Trim;
  if SMin.Length < 2 then
    raise Exception.Create('Indicare 2 cifre per i minuti');

  // parte relativa alle ore
  SOre:=Valore.Substring(0,Posiz).Trim;
  if SOre.Length < 2 then
    raise Exception.Create('Indicare almeno 2 cifre per le ore');

  // controllo minuti validi e < 60
  Minuti:=StrToInt(SMin);
  if Minuti > 59 then
    raise Exception.Create('I minuti devono essere minori di 60!');

  // controlli ok
  Result:=True;
end;

class function TFunzioniGenerali.StrToGiorniOre(Valore,UM: String): Real;
begin
  Result:=0;
  try
    if UM = 'G' then
    begin
      Valore:=StringReplace(Valore,' ','0',[rfReplaceAll]);
      Valore:=StringReplace(Valore,'.',FormatSettings.DecimalSeparator,[rfReplaceAll]);
      Result:=StrToFloat(Valore);
    end
    else if UM = 'O' then
    begin
      Result:=TFunzioniGenerali.OreMinuti(Valore);
    end;
  except
  end;
end;

class function TFunzioniGenerali.GiorniOreToStr(Valore: Real; UM: String; Formato: String = ''): String;
begin
  Result:='';
  try
    if UM = 'G' then
    begin
      if Formato = '' then
        Result:=FloatToStr(Valore)
      else
        Result:=Format(Formato,[Valore]);
    end
    else if UM = 'O' then
      Result:=TFunzioniGenerali.MinutiOre(Trunc(Valore));
  except
  end;
end;

class function TFunzioniGenerali.GetFilePath(S: String; EndSlash: Boolean = False): String;
begin
  Result:=ExtractFilePath(S);
  if Result = '' then
    exit;
  if EndSlash then
    Result:=IncludeTrailingPathDelimiter(Result)
  else
    Result:=ExcludeTrailingPathDelimiter(Result);
end;

class function TFunzioniGenerali.GetFileName(S: String): String;
begin
  Result:=TPath.GetFileName(S);
end;

class function TFunzioniGenerali.GetFileSizeStr(const PSizeInBytes: Int64): String;
// converte la dimensione del file espressa in byte in un formato stringa human-readable
const
  SOGLIA_KB = 1024 - 1;                 // soglia oltre la quale la dimensione � espressa in Kb
  SOGLIA_MB = (1024 * 1024) - 1;        // soglia oltre la quale la dimensione � espressa in Mb
  SOGLIA_GB = (1024 * 1024 * 1024) - 1; // soglia oltre la quale la dimensione � espressa in Gb
begin
  if PSizeInBytes > SOGLIA_GB then
    Result:=FormatFloat('#,##0.## GB',(PSizeInBytes / BYTES_GB))
  else if PSizeInBytes > SOGLIA_MB then
    Result:=FormatFloat('#,##0.# MB',(PSizeInBytes / BYTES_MB))
  else if PSizeInBytes > SOGLIA_KB then
    Result:=FormatFloat('#,##0 KB',Trunc(PSizeInBytes / BYTES_KB))
  else
    Result:=FormatFloat('#,##0 bytes',PSizeInBytes);
end;

class function TFunzioniGenerali.GetInstallationPath: String;
begin
 Result:=
   {$IF DEFINED(IRISWEB) and not DEFINED(WEBSVC)}
   GGetWebApplicationThreadVar.ApplicationPath
   {$ELSE}
   TPath.GetDirectoryName(GetModuleName(HInstance));
   {$ENDIF};
end;

class function TFunzioniGenerali.FileToByteArray(const PFileName: String): TByteDynArray;
const
  BLOCK_SIZE = 1024;
var
  BytesRead,BytesToWrite,Count: Integer;
  F: File of Byte;
  pTemp:Pointer;
begin
  AssignFile(F,PFileName);
  Reset(F);
  try
   Count:=FileSize(F);
   SetLength(Result,Count);
   pTemp:=@Result[0];
   BytesRead:=BLOCK_SIZE;
   while (BytesRead = BLOCK_SIZE) do
   begin
     BytesToWrite:=Min(Count,BLOCK_SIZE);
     BlockRead(F,pTemp^,BytesToWrite,BytesRead);
     pTemp:=Pointer(LongInt(pTemp) + BLOCK_SIZE);
     Count:=Count - BytesRead;
   end;
  finally
    CloseFile(F);
  end;
end;

class procedure TFunzioniGenerali.ByteArrayToFile(const PByteArr: TByteDynArray; const PFileName: String);
var
  stream: TMemoryStream;
begin
  stream:=TMemoryStream.Create;
  try
    if length(PByteArr) > 0 then
      stream.WriteBuffer(PByteArr[0], length(PByteArr));
    stream.SaveToFile(PFileName);
  finally
    stream.Free;
  end;
end;

class function TFunzioniGenerali.GetCampiConcatenati(D: TDataSet; C:TStringList; BUsaOldValues: Boolean = False): String;
var i: Integer;
begin
  Result:='';
  for i:=0 to C.Count - 1 do
  begin
    try
      if BUsaOldValues then
        Result:=Result + VarToStr(D.FieldByName(C[i]).OldValue)
      else
        Result:=Result + D.FieldByName(C[i]).AsString;
      if i < C.Count - 1 then
        Result:=Result + ' ';
    except
    end;
  end;
end;

class function TFunzioniGenerali.EstraiNomeTabella(SqlText: String): String;
// estrae da una frase Sql il nome della prima tabella dopo la clausola FROM
var
  i,Posiz,LungSqlText: Integer;
const
  FROM_CLAUSE = 'FROM';
begin
  Result:='';
  Posiz:=SqlText.ToUpper.IndexOf(FROM_CLAUSE);
  if Posiz = -1 then
    Exit;

  // cerca posizione della clausola "FROM"
  i:=Posiz + FROM_CLAUSE.Length;
  LungSqlText:=SqlText.Length;

  // cerca posizione inizio nome tabella
  {$WARN WIDECHAR_REDUCED OFF}
  while (i < LungSqlText) and (not (SqlText.Chars[i].ToUpper in ['A'..'Z'])) do
  {$WARN WIDECHAR_REDUCED ON}
    inc(i);

  // determina nome tabella
  {$WARN WIDECHAR_REDUCED OFF}
  while (i < LungSqlText) and (not (SqlText.Chars[i] in [#10,#13,#0,' ',',','"',''''])) do
  {$WARN WIDECHAR_REDUCED ON}
  begin
    Result:=Result + SqlText.Chars[i];
    inc(i);
  end;
end;

class function TFunzioniGenerali.Anno(Data: TDateTime): Word;
begin
  Result:=StrToInt(FormatDateTime('yyyy',Data));
end;

class function TFunzioniGenerali.Mese(Data: TDateTime): Word;
begin
  Result:=StrToInt(FormatDateTime('mm',Data));
end;

class function TFunzioniGenerali.Giorno(Data: TDateTime): Word;
begin
  Result:=StrToInt(FormatDateTime('dd',Data));
end;

class function TFunzioniGenerali.SettimanaAnno(Data: TDateTime; IniziaDomenica: Boolean = True): Integer;
begin
  if IniziaDomenica then
    //num settimana cconsiderando Domenica come primo giorno
    Result:=Trunc(TFunzioniGenerali.Arrotonda((Trunc(Data + 7 - DayOfWeek(Data) - EncodeDate(TFunzioniGenerali.Anno(Data),1,1) + 1)/7),1,'E'))
  else
    //num settimana cconsiderando Luned� come primo giorno
    Result:=Trunc(TFunzioniGenerali.Arrotonda((Trunc(Data + 7 - DayOfWeek(Data - 1) - EncodeDate(TFunzioniGenerali.Anno(Data),1,1) + 1)/7),1,'E'));
end;

class function TFunzioniGenerali.Arrotonda(Dato,Valore: Real; Tipo: String): Real;
// Arrotondamento
var
  Delta: Real;
begin
  if Valore = 0 then
  begin
    Result:=Dato;
    Exit;
  end;
  try
    Result:=Dato / Valore;
  except
    Result:=Dato;
    exit;
  end;
  Delta:=Power(10, -8);
  if Dato < 0 then
    Delta:=-Delta;
  if Abs(Result - Trunc(Result + Delta)) < Power(10, -8) then
    Result:=Round(Result) * Valore
  else
  begin
    if Dato > 0 then
    begin
      //Dato da arrotondare positivo
      if Tipo = 'E' then
        //Eccesso
        Result:=Trunc(Result + 1)
      else if Tipo = 'D' then
        //Difetto
        Result:=Trunc(Result)
      else if Tipo = 'P' then
        //Puro
        Result:=Trunc(Result + 0.5 + Delta)
      else if Tipo = 'P-' then
        //Puro ma per difetto sul .5
        if Result - Trunc(Result) = 0.5 then
          Result:=Trunc(Result)
        else
          Result:=Trunc(Result + 0.5);
    end
    else
    begin
      //Dato da arrotondare negativo
      if Tipo = 'E' then
        //Eccesso
        Result:=Trunc(Result)
      else if Tipo = 'D' then
        //Difetto
        Result:=Trunc(Result - 1)
      else if Tipo = 'P' then
        //Puro
        Result:=Trunc(Result - 0.5 + Delta)
      else if Tipo = 'P-' then
        //Puro ma per difetto sul .5
        if Abs(Result) - Trunc(Abs(Result)) = 0.5 then
          Result:=Trunc(Result)
        else
          Result:=Trunc(Result - 0.5);
    end;
    Result:=Result * Valore;
  end;
end;

class function TFunzioniGenerali.AzzeraPrecisione(Dato: Real; NumDec: Integer): Real;
// Azzera il dato se minore della precisione
var
  Precisione: Real;
begin
  Precisione:=Power(10, -NumDec);
  if Abs(Dato) < Precisione then
    Result:=0
  else
    Result:=Dato;
end;

class function TFunzioniGenerali.CifreDecimali(Dato: Real): Integer;
var
  LDatoStr: String;
begin
  LDatoStr:=FloatToStr(Dato);
  Result:=LDatoStr.IndexOf(FormatSettings.DecimalSeparator) + 1;
  if Result > 0 then
    Result:=LDatoStr.Length - Result;
end;

class function TFunzioniGenerali.FormattaNumero(PNumero,PFormato: String): String;
// restituisce il numero indicato formattato secondo i criteri specificati
// PNumero
//   numero da formattare
// PFormato
//   elenco separato da virgola e formattato in questo modo:
//   "M=[S|N],D=n,0=[S|N][,SD=s]"
//   - M:  indica se includere il separatore di migliaia
//         valori possibili: S oppure N
//   - D:  indica il numero di cifre decimali da riportare
//         valori possibili: intero >= 0
//   - 0:  indica se stampare il valore 0
//         valori possibili: S oppure N
//   - SD: indica quale � il separatore decimale
//         valori possibili . oppure ,
var
  C:Currency;
  SD: String;
const
  TEMP_SUBST_CHAR: Char = Chr(255);
begin
  if PFormato = '' then
  begin
    Result:=PNumero;
    exit;
  end;
  if PNumero = '' then
    PNumero:='0';
  C:=StrToFloat(PNumero);
  with TStringList.Create do
  try
    CommaText:=PFormato.ToUpper;
    //Decido se stampare il valore Zero o meno
    if (Values['0'] = 'N') and (C = 0) then
    begin
      Result:='';
      exit;
    end;
    //Separatore di migliaia
    if Values['M'] = 'S' then
      PFormato:='n'
    else
      PFormato:='f';
    //Precisione (numero di decimali)
    if Values['D'] <> '' then
      PFormato:='.' + Values['D'] + PFormato;
    Result:=Format('%' + PFormato,[C]);
    SD:=Values['SD'];
    if SD <> '' then
    begin
      if SD <> FormatSettings.DecimalSeparator then
      begin
        Result:=Result
                  .Replace(FormatSettings.DecimalSeparator,TEMP_SUBST_CHAR,[rfReplaceAll])
                  .Replace(FormatSettings.ThousandSeparator,FormatSettings.DecimalSeparator,[rfReplaceAll])
                  .Replace(TEMP_SUBST_CHAR,FormatSettings.ThousandSeparator,[rfReplaceAll]);
      end;
    end;
  finally
    Free;
  end;
end;

class function TFunzioniGenerali.IsDigit(const PStr: String; PIndex: Integer): Boolean;
// restituisce True se il carattere PIndex-esimo della stringa PStr � una cifra
begin
  Result:=TFunzioniGenerali.IsDigit(TFunzioniGenerali.CarattereDef(PStr,PIndex));
end;

class function TFunzioniGenerali.IsDigit(const PChr: Char): Boolean;
// restituisce True se il carattere specificato � una cifra
begin
  Result:=PChr.IsDigit;
end;

{$HINTS OFF} // l'hint sulla variabile "nr" � trascurabile
class function TFunzioniGenerali.IsNumeric(S: String): Boolean;
var
  nr: Real;
  c: Integer;
begin
  S:=StringReplace(S,',','.',[rfReplaceAll]).Trim;
  val(S,nr,c);
  Result:=c = 0;
end;
{$HINTS ON}

class function TFunzioniGenerali.IsSpecialChar(const PChr: Char): Boolean;
begin
  Result:=SPECIAL_CHAR.IndexOf(PChr) > -1;
end;

class function TFunzioniGenerali.IsNewSpecialChar(const PChr: Char): Boolean;
begin
  Result:=NEW_SPECIAL_CHAR.IndexOf(PChr) > -1;
end;

class function TFunzioniGenerali.TestoInSetCaratteri(Testo,CharSet:String):Boolean;
// restituisce True se tutti i caratteri della stringa Testo sono presenti nell'elenco di caratteri contenuto in CharSet
var i:Integer;
begin
  Result:=False;
  for i:=0 to Length(Testo) - 1 do
  begin
    Result:=CharSet.IndexOf(Testo.Chars[i]) >= 0;
    if not Result then
      Break;
  end;
end;

class function TFunzioniGenerali.EliminaZeriASinistra(S: String): String;
// elimina gli zeri a sinistra di una stringa
var
  i: Integer;
begin
  Result:=S;
  for i:=0 to S.Length - 2 do
  begin
    if S.Chars[i] <> '0' then
      Break
    else
      Result:=Result.Substring(1);
  end;
end;

class function TFunzioniGenerali.NomeFileDatato(NomeFile,Formato: String; Data: TDateTime): String;
var
  Path,FN,LDateStr: String;
  i: Integer;
begin
  if Formato.Trim = '' then
  begin
    Result:=NomeFile;
    exit;
  end;
  Path:=ExtractFilePath(NomeFile);
  FN:=ExtractFileName(NomeFile);

  LDateStr:=FormatDateTime(Formato,Data);

  // imposta il nome del file con l'informazione della data
  i:=FN.IndexOf('.');
  if i = -1 then
    FN:=FN + LDateStr
  else
    FN:=FN.Insert(i,LDateStr);

  // concatena path e nome file
  Result:=Path + FN;
end;

class function TFunzioniGenerali.EstraiExtFile(S: String): String;
// estrae l'estensione del file, considerando il delimitatore .
// non viene estratto il punto come primo carattere
// es.
//   EstraiExtFile("c:\test\cedolino.pdf") = "pdf"
var
  i: Integer;
begin
  Result:='';
  for i:=S.Length - 1 downto 0 do
  begin
    if S.Chars[i] = '.' then
      Break
    else
      Result:=S.Chars[i] + Result;
  end;
end;

class procedure TFunzioniGenerali.InizializzaArray(var Vettore: array of Integer; Valore: Integer = 0);
var
  i: Integer;
begin
  for i:=0 to High(Vettore) do
    Vettore[i]:=Valore;
end;

class procedure TFunzioniGenerali.InizializzaArray(var Vettore: array of Real; Valore: Real = 0);
var
  i: Integer;
begin
  for i:=0 to High(Vettore) do
    Vettore[i]:=Valore;
end;

class function TFunzioniGenerali.SommaArray(Vettore: array of Integer): Integer;
var
  i: Integer;
begin
  Result:=0;
  for i:=0 to High(Vettore) do
    Result:=Result + Vettore[i];
end;

class function TFunzioniGenerali.SommaArray(Vettore: array of Real): Real;
var
  i: Integer;
begin
  Result:=0;
  for i:=0 to High(Vettore) do
    Result:=Result + Vettore[i];
end;

class function TFunzioniGenerali.AttivaHintSQL(SQL: String; VersioneOracle: Integer): String;
// Attiva/disattiva gli hint delle query in base alla versione del db
var i: Integer;
begin
  Result:=SQL;
  if VersioneOracle = 0 then
    exit;
  for i:=1 to 99 do
  begin
    if VersioneOracle < i then
      SQL:=StringReplace(SQL,'/*NOHINT' + IntToStr(i) + ' ','/*+ ',[rfReplaceAll,rfIgnoreCase])
    else
      SQL:=StringReplace(SQL,'/*SIHINT' + IntToStr(i) + ' ','/*+ ',[rfReplaceAll,rfIgnoreCase]);
  end;
  Result:=SQL;
end;

class function TFunzioniGenerali.LunghezzaCampo(F: TField): Integer;
begin
  if F is TStringField then
    Result:=F.Size
  else
    Result:=F.DisplayWidth;
  if F.Index < F.DataSet.FieldCount - 1 then
    inc(Result);
end;

class function TFunzioniGenerali.FormatiCodificati(Dato,Formato: String; Lung: Integer = 0): String;
begin
  Result:=Dato.Trim;
  Formato:=Formato.Trim.ToUpper;
  if Formato = 'D10' then  //Data di 10 inps
  begin
    if Result = '' then
      Result:='          '
    else if Result <> '*' then
      try
        Result:=FormatDateTime('yyyy-mm-dd',StrToDate(Dato));
      except
      end;
  end
  else if Formato = 'D7' then //Data di 7 inps
  begin
    if Result = '' then
      Result:='       '
    else if Length(Result) = 10 then    // Arriva 'DD/MM/AAAA'
    begin
      try
        Result:=FormatDateTime('yyyy-mm',StrToDate(Dato));
      except
      end;
    end
    else if Length(Result) = 7 then       //Arriva 'MM/AAAA'
    begin
      try
        Result:=FormatDateTime('yyyy-mm',StrToDate('01/' + Dato));
      except
      end;
    end
    else if Length(Result) = 6 then       //Arriva 'MMAAAA'
    begin
      try
        Result:=FormatDateTime('yyyy-mm',StrToDate('01/' + Dato.Substring(0,2) + '/' + Dato.Substring(2,4)));
      except
      end;
    end;
  end
  else if Formato = 'DTA' then //Data di 8 fluper
  begin
    if Result = '' then
      Result:='        '
    else
      Result:=FormatDateTime('YYYYMMDD',StrToDate(Dato));
  end
  else if Formato = 'DTB' then //Data di 6 fluper
  begin
    if Result = '' then
      Result:='      '
    else
      Result:=FormatDateTime('YYYYMM',StrToDate(Dato));
  end
  else if Formato = 'AN' then //Alfanumerico fluper
  begin
    Result:=Format('%-' + Lung.ToString + '.' + Lung.ToString + 's',[Dato]);
  end
  else if Formato = 'CF' then //Codice fiscale fluper
  begin
    Result:=Format('%-16.16s',[Dato]);
  end
  else if Formato = 'NU' then //Numerico intero positivo e negativo fluper
  begin
    //Gestisco il valore negativo...
    if Dato.ToInteger < 0 then
    begin
      if Lung > 1 then
        Lung:=Lung - 1;
    end;
    Result:=Format('%' + Lung.ToString + '.' + Lung.ToString + 'd',[Dato.ToInteger]);
  end
  else if Formato = 'NP' then //Numerico intero positivo fluper
  begin
    if Dato.ToInteger < 0 then
      Dato:='0';
    Result:=Format('%' + Lung.ToString + '.' + Lung.ToString + 'd',[Dato.ToInteger]);
  end
  else if Formato = 'VP' then //Numerico positivo con 2 decimali fluper
  begin
    if StrToFloat(Dato) < 0 then
      Dato:='0';
    Result:=Format('%' + Lung.ToString + '.2f',[StrToFloat(Dato)]);
    Result:=StringReplace(Result,',','',[rfReplaceAll]);
    Result:=StringReplace(Result,'.','',[rfReplaceAll]);
    Result:=Format('%' + Lung.ToString + '.' + Lung.ToString + 'd',[Result.ToInteger]);
  end
  else if Formato = 'VN' then //Numerico positivo e negativo con 2 decimali fluper
  begin
    //Gestisco il valore negativo...
    if StrToFloat(Dato) < 0 then
      if Lung > 1 then
        Lung:=Lung - 1;
    Result:=Format('%' + Lung.ToString + '.2f',[StrToFloat(Dato)]);
    Result:=StringReplace(Result,',','',[rfReplaceAll]);
    Result:=StringReplace(Result,'.','',[rfReplaceAll]);
    Result:=Format('%' + Lung.ToString + '.' + Lung.ToString + 'd',[Result.ToInteger]);
  end
  else if Formato = 'VP1' then //Numerico positivo con 1 decimale fluper
  begin
    if StrToFloat(Dato) < 0 then
      Dato:='0';
    Result:=Format('%' + Lung.ToString + '.1f',[StrToFloat(Dato)]);
    Result:=StringReplace(Result,',','',[rfReplaceAll]);
    Result:=StringReplace(Result,'.','',[rfReplaceAll]);
    Result:=Format('%' + Lung.ToString + '.' + Lung.ToString + 'd',[Result.ToInteger]);
  end
  else if Formato = 'VN1' then //Numerico positivo e negativo con 1 decimale fluper
  begin
    //Gestisco il valore negativo...
    if StrToFloat(Dato) < 0 then
      if Lung > 1 then
        Lung:=Lung - 1;
    Result:=Format('%' + Lung.ToString + '.1f',[StrToFloat(Dato)]);
    Result:=StringReplace(Result,',','',[RfReplaceAll]);
    Result:=StringReplace(Result,'.','',[RfReplaceAll]);
    Result:=Format('%' + Lung.ToString + '.' + Lung.ToString + 'd',[Result.ToInteger]);
  end
  else if Formato.Substring(0,1) = 'L' then //inps
  begin
    if Lung = 0 then
      Lung:=StrToIntDef(Formato.Substring(1,Formato.Length),Result.Length);
    Result:=Result.Substring(0,Lung);
  end;
end;

class function TFunzioniGenerali.SSO_TokenUsr(Utente,Mask: String): String;
var
  sep,FmtTS, LDateStr: String;
  posusr: Integer;
const
  MASK_USER = 'user';
begin
  Result:=Utente;
  Mask:=Mask.ToLower;

  //verifico che mask contenga 'user' e qualcos'altro
  if (Mask = '') or
     (Mask = MASK_USER) or
     (Mask.IndexOf(MASK_USER) = -1) then
    exit;

  //estraggo il separatore tra user e il formato data
  posusr:=Mask.IndexOf(MASK_USER);
  if posusr = 0 then
  begin
    sep:=Mask.Substring(MASK_USER.Length,1);
    FmtTS:=Mask.Substring(Mask.IndexOf(sep) + 1);
  end
  else
  begin
    sep:=Mask.Substring(posusr - 1,1);
    FmtTS:=Mask.Substring(0,Mask.IndexOf(sep));
  end;

  LDateStr:=FormatDateTime(FmtTS,Now);

  if posusr = 0 then
    Result:=Result + sep + LDateStr
  else
    Result:=LDateStr + sep + Result;
end;

class function TFunzioniGenerali.GetStringList(DataSet: TDataSet; Colonne: String): String;
var i,lung: Integer;
    S: String;
begin
  Result:='';
  with DataSet do
  try
    DisableControls;
    First;
    while not Eof do
    begin
      S:='';
      for i:=0 to FieldCount - 1 do
      begin
        if TFunzioniGenerali.CercaParolaIntera(Fields[i].FieldName,Colonne,',') > 0 then
        begin
          lung:=Fields[i].Size;
          if lung = 0 then
            lung:=Fields[i].DisplayWidth;
          if lung > 0 then
            S:=S + IfThen(S <> '',' ') + Format('%-*s',[lung,Fields[i].AsString]);
        end;
      end;
      if S <> '' then
        Result:=Result + S + CRLF;
      Next;
    end;
  finally
    EnableCOntrols;
  end;
  Result:=Result.Trim;
end;

class function TFunzioniGenerali._In(const Valore: String; lstValori:array of String): Boolean;
var
  i: Integer;
begin
  Result:=False;
  for i:=Low(lstValori) to High(lstValori) do
  begin
    if Valore = lstValori[i] then
    begin
      Result:=True;
      Break;
    end;
  end;
end;

class function TFunzioniGenerali._In(const Valore: Integer; lstValori:array of Integer): Boolean;
var
  i: Integer;
begin
  Result:=False;
  for i:=Low(lstValori) to High(lstValori) do
  begin
    if Valore = lstValori[i] then
    begin
      Result:=True;
      Break;
    end;
  end;
end;

class function TFunzioniGenerali._In(const Valore: TObject; lstValori:array of TObject): Boolean;
var
  i: Integer;
begin
  Result:=False;
  for i:=Low(lstValori) to High(lstValori) do
  begin
    if Valore = lstValori[i] then
    begin
      Result:=True;
      Break;
    end;
  end;
end;

class function TFunzioniGenerali.Between(const Valore,Da,A: String): Boolean;
begin
  Result:=(Valore >= Da) and (Valore <= A);
end;

class function TFunzioniGenerali.Between(const Valore,Da,A: Integer): Boolean;
begin
  Result:=(Valore >= Da) and (Valore <= A);
end;

class function TFunzioniGenerali.Between(const Valore,Da,A: TDateTime): Boolean;
begin
  Result:=(Valore >= Da) and (Valore <= A);
end;

class function TFunzioniGenerali.Indenta(const PTesto: String; const PIndentazione: Integer): String;
// indenta il testo contenuto in PTesto di PIndentazione caratteri
// es.
//   PTesto = 'alfa'#13#10'beta'#13#10'gamma'
//   R180Indenta(PTesto,2) = '  alfa'#13#10'  beta'#13#10'  gamma'
//
var
  L: TStringList;
  Indentazione: String;
  i: Integer;
begin
  Result:='';
  if PTesto = '' then
    Exit;

  // spazi di indentazione
  Indentazione:=StringOfChar(' ',PIndentazione);

  // utilizza una stringlist di appoggio perch� consente una migliore gestione
  // dei ritorni a capo di una semplice replace di CRLF
  L:=TStringList.Create;
  try
    L.Text:=PTesto;
    for i:=0 to L.Count - 1 do
      L[i]:=Indentazione + L[i];
    Result:=L.Text;
  finally
    FreeAndNil(L);
  end;
end;

// G E S T I O N E   S T R I N G
class function TFunzioniGenerali.Capitalize(const PTesto: String): String;
// Restituisce la stringa data con l'iniziale maiuscola
begin
  Result:=PTesto.Substring(0,1).ToUpper +  PTesto.Substring(1).ToLower;
end;

class procedure TFunzioniGenerali.Tokenize(const PList: TStrings; const PStr: String; const PDelimiter: String = ',');
// Data una stringa ed un delimitatore, restituisce una stringlist i cui elementi
//  sono rappresentati dai singoli token delimitati.
//  Rappresenta un'alternativa all'uso di commatext, in quanto pi� flessibile.
//  Il delimitatore � di tipo string e pu� contenere pi� caratteri.
//  Esempi:
//    Input1  -> Value = 'aaa|bbb|ccc', Delimiter = '|'
//    Output1 -> Lista[0] = 'aaa', Lista[1] = 'bbb', Lista[2] = 'ccc'
//    Input2  -> Value = 'aaa+++ddd+++eee', Delimiter = '+++'
//    Output2 -> Lista[0] = 'aaa', Lista[1] = 'ddd', Lista[2] = 'eee'
//  Nota: la gestione della StringList (creazione/distruzione) � delegata all'utilizzatore }
var
  LDx,LDelta: Integer;
  LTesto,LToken: string;
begin
  if PList = nil then
    raise Exception.Create('Lista non inizializzata!');
  if PStr = '' then
  begin
    // valore vuoto: la stringlist viene pulita
    PList.Clear;
    Exit;
  end;
  if PDelimiter = '' then
  begin
    // delimitatore vuoto: la stringlist viene caricata con un solo elemento
    PList.Clear;
    PList.Add(PStr);
    Exit;
  end;

  LDelta:=PDelimiter.Length;
  LTesto:=PStr + PDelimiter;

  PList.BeginUpdate;
  PList.Clear;
  // ciclo di estrazione dei token
  try
    while LTesto.Length > 0 do
    begin
      LDx:=LTesto.IndexOf(PDelimiter);
      LToken:=LTesto.Substring(0,LDx);
      PList.Add(LToken);

      LTesto:=LTesto.Substring(LDx + LDelta);
    end;
  finally
    PList.EndUpdate;
  end;
end;

{$WARN SYMBOL_DEPRECATED OFF}
class procedure TFunzioniGenerali.SplitLines(PList: TStrings; PBreakSet: TSysCharSet = [' ',',']; PMaxItemLength: Integer = 2000);
//  Suddivide le righe dell'oggetto TStrings indicato, mandando a capo
//  il testo di ogni riga al numero di caratteri specificato in PMaxItemLength;
//  una riga potr� quindi essere divisa in 2 o pi�.
//  Il BreakSet rappresenta il set di caratteri considerati separatori di parole,
//  ovvero dove la riga pu� essere troncata in modo sicuro.
//  es. per codice SQL si consiglia di mantenere il default: spazio e virgola.
//  Attenzione!! La funzione modifica l'oggetto TStrings indicato, suddividendo
//  ogni riga "lunga" in pi� righe (aggiungendo quindi elementi alla lista).
//
//  Es.
//    // input
//    SQLCreato.Count = 2
//    SQLCreato[0] = 'select A, B, C from T1'
//    SQLCreato[1] = 'where B in (10,20,30,40,50) order by A'
//
//    // richiamo la funzione con limite a 15 caratteri
//    BreakSet:=[' ',','];
//    R180SplitLines(SQLCreato,BreakSet,15);
//
//    // output
//    SQLCreato.Count = 5
//    SQLCreato[0] = 'select A, B, C'
//    SQLCreato[1] = 'from T1'
//    SQLCreato[2] = 'where B in (10,'
//    SQLCreato[3] = '20,30,40,50)
//    SQLCreato[4] = 'order by A'
var
  RigheList: TStringList;
  TempStr: String;
  i,j: Integer;
begin
  if PList = nil then
    Exit;

  if PList.Count = 0 then
    Exit;

  // creazione stringlist di appoggio
  RigheList:=TStringList.Create;
  try
    i:=0;
    while i < PList.Count do
    begin
      if PList[i].Length > PMaxItemLength then
      begin
        // wrap del testo a N caratteri
        TempStr:=WrapText(PList[i],#13#10,PBreakSet,PMaxItemLength);

        // tokenize della riga splittata
        TFunzioniGenerali.Tokenize(RigheList,TempStr,#13#10);

        // reimposta la stringlist originale
        PList[i]:=RigheList[0];
        for j:=1 to RigheList.Count - 1 do
          PList.Insert(i + j,RigheList[j]);

        i:=i + RigheList.Count - 1;
      end;
      i:=i + 1;
    end;
  finally
    FreeAndNil(RigheList);
  end;
end;
{$WARN SYMBOL_DEPRECATED ON}

class function TFunzioniGenerali.CalcoloCodiceFiscale(Cognome,Nome,Sesso,CodCat: String; DataNas: TDateTime): String;
// Routine di calcolo del codice fiscale
type
  TPari = Array [1..36] of Byte;
  TDispari = Array [1..36] of Byte;
const
  Vocali = 'AEIOU';
  Consonanti = 'BCDFGHJKLMNPQRSTVWXYZ';
  Controllo = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Mesi = 'ABCDEHLMPRST';
  Pari:TPari = ( 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,
                18, 19, 20, 21, 22, 23, 24, 25, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9);
  Dispari:TDispari = ( 1, 0, 5, 7, 9, 13, 15, 17, 19, 21, 2, 4, 18, 20, 11, 3, 6, 8,
                      12, 14, 16, 10, 22, 25, 24, 23, 1, 0, 5, 7, 9, 13, 15, 17, 19, 21);
var
  cod_fisc, c_contr: String;
  LChar: Char;
  tmp_voc:array [1..2] of char; // contiene le prime due vocali
  tmp_cons:array [1..4] of char; // contiene le prime 4 consonanti
  Valido:boolean;
  n_voc, n_cons,k,A,M,G: Word;
function Calc_Chk(Cod_Fisc: String): String; inline;
// calcola il carattere di controllo del codice fiscale
// ritorna 'errore' se trovato carattere non consentito
var
  tmp, k, posiz: Integer;
begin
  if Cod_Fisc.Trim.Length < 15 then
  begin
    Result:='errore';
    exit;
  end;
  tmp:=0;

  // caratteri in posizione dispari
  k:=0;
  repeat
    posiz:=Controllo.IndexOf(Cod_Fisc.Substring(k,1));
    if posiz > -1 then
      tmp:=tmp + Dispari[posiz + 1];
    k:=k + 2;
  until k > 15;

  // caratteri in posizione pari
  k:=1;
  repeat
    posiz:=Controllo.IndexOf(Cod_Fisc.Substring(k,1));
    tmp:=tmp + Pari[posiz + 1];
    k:=k + 2;
  until k > 14;
  tmp:=(tmp mod 26);
  Result:=Controllo.Substring(tmp,1);
end;
begin
  Tmp_Voc[1]:=#0;
  Tmp_Voc[2]:=#0;
  Tmp_Cons[1]:=#0;
  Tmp_Cons[2]:=#0;
  Tmp_Cons[3]:=#0;
  Tmp_Cons[4]:=#0;

  Result:='';
  if (Cognome.Trim = '') or (Nome.Trim = '') or (DataNas = 0) or (CodCat.Trim = '') then
    exit;

  // calcola le lettere del cognome
  Cognome:=Cognome.Trim.ToUpper;
  n_voc:=0;
  n_cons:=0;
  for k:=0 to Cognome.Length - 1 do
  begin
    LChar:=Cognome.Chars[k];
    if (Vocali.IndexOf(LChar) > -1) and (n_voc < 2) then
    begin
      Inc(n_voc);
      Tmp_Voc[n_voc]:=LChar;
    end;
    if (Consonanti.IndexOf(LChar) > -1) and (n_cons < 4) then
    begin
      Inc(n_cons);
      Tmp_Cons[n_cons]:=LChar;
    end;
    if (n_cons = 4) and (n_voc = 2) then
      Break;
  end;

  // ora conosco le prime vocali e consonanti
  Valido:=True;
  case n_cons of
    3,4:cod_fisc:=tmp_cons[1] + tmp_cons[2] + tmp_cons[3];
    2:if n_voc >= 1 then
        cod_fisc:=tmp_cons[1] + tmp_cons[2] + tmp_voc[1]
      else
        Valido:=False;
    1:if n_voc >= 2 then
        cod_fisc:=tmp_cons[1] + tmp_voc[1] + tmp_voc[2]
      else
        if n_voc = 1 then
          cod_fisc:=tmp_cons[1] + tmp_voc[1] + 'X'
        else
          Valido:=False;
    0:if n_voc = 2 then
        cod_fisc:=tmp_voc[1] + tmp_voc[2] + 'X'
      else
        Valido:=False;
    else
      Valido:=False;
  end;
  if not Valido then
    exit;

  // calcola le lettere del nome
  Nome:=Nome.Trim.ToUpper;
  n_voc:=0;
  n_cons:=0;
  for k:=0 to Nome.Length - 1 do
  begin
    LChar:=Nome.Chars[k];
    if (Vocali.IndexOf(LChar) > -1) and (n_voc < 2) then
    begin
      Inc(n_voc);
      Tmp_Voc[n_voc]:=LChar;
    end;
    if (Consonanti.IndexOf(LChar) > -1) and (n_cons < 4) then
    begin
      Inc(n_cons);
      Tmp_Cons[n_cons]:=LChar;
    end;
    if (n_cons = 4) and (n_voc = 2) then
      Break;
  end;

  // ora conosco le prime vocali e consonanti
  case n_cons of
    4:cod_fisc:=cod_fisc + tmp_cons[1] + tmp_cons[3] + tmp_cons[4];
    3:cod_fisc:=cod_fisc + tmp_cons[1] + tmp_cons[2] + tmp_cons[3];
    2:if n_voc >= 1 then
        cod_fisc:=cod_fisc + tmp_cons[1] + tmp_cons[2] + tmp_voc[1]
      else
        Valido:=False;
    1:if n_voc >= 2 then
        cod_fisc:=cod_fisc + tmp_cons[1] + tmp_voc[1] + tmp_voc[2]
      else
        if n_voc = 1 then
          cod_fisc:=cod_fisc + tmp_cons[1] + tmp_voc[1] + 'X'
        else
          Valido:=False;
    0:if n_voc = 2 then
        cod_fisc:=cod_fisc + tmp_voc[1] + tmp_voc[2] + 'X'
      else
        Valido:=False;
    else
      Valido:=False;
  end;
  if not Valido then
    exit;

  // calcola la parte relativa alla data di nascita
  DecodeDate(DataNas,A,M,G);
  Cod_Fisc:=Cod_Fisc + A.ToString.Substring(2,2);
  Cod_Fisc:=Cod_Fisc + Mesi.Chars[M - 1];
  if Sesso = 'F' then
    G:=G + 40;
  Cod_Fisc:=Cod_Fisc + G.ToString.PadLeft(2,'0');

  // aggiunge codice catastale
  Cod_Fisc:=Cod_Fisc + CodCat;

  // calcola il carattere di controllo
  c_contr:=calc_chk(Cod_Fisc);
  if c_contr = 'errore' then
    exit
  else
  begin
    Cod_Fisc:=Cod_Fisc + c_contr;
    Result:=Cod_Fisc;
  end;
end;

class function TFunzioniGenerali.SostituisciCaratteriSpeciali(Testo: String): String;
begin
  //Tabella caratteri ascii: http://cloford.com/resources/charcodes/symbols.htm
  //Primi 32 caratteri: http://www.robelle.com/smugbook/ascii.html
  Result:=Testo;
  Result:=StringReplace(Result,#145,#39,[rfReplaceAll]);// � -> '
  Result:=StringReplace(Result,#146,#39,[rfReplaceAll]);// � -> '
  Result:=StringReplace(Result,#147,#34,[rfReplaceAll]);// � -> "
  Result:=StringReplace(Result,#148,#34,[rfReplaceAll]);// � -> "
  Result:=StringReplace(Result,#9,#32#32,[rfReplaceAll]);// TAB -> 2 spazi
end;

class procedure TFunzioniGenerali.SetComboItemsValues(lst:TStrings; ItemsValues: array of TItemsValues; TipoLista: String);
// TipoLista: I=Item, V=Value
var
  i,c: Integer;
  S: String;
begin
  lst.Clear;
  for i:=0 to High(ItemsValues) do
  begin
    S:='';
    for c:=0 to TipoLista.Length - 1 do
    begin
      if c > 0 then
        S:=S + '=';
      if TipoLista.Chars[c] = 'I' then
        S:=S + ItemsValues[i].Item
      else if TipoLista.Chars[c] = 'V' then
        S:=S + ItemsValues[i].Value;
    end;
    lst.Add(S);
  end;
end;

class function TFunzioniGenerali.GetCsvIntersect(const PElenco1, PElenco2: String): String;
// questa function calcola l'intersezione insiemistica di due liste di valori
// separati da virgola e la restituisce come stringa di valori separati da virgola
// parametri:
//   PElenco1:
//     la prima stringa di valori separati da virgola
//   PElenco2:
//     la seconda stringa di valori separati da virgola
// restituisce:
//   una stringa contenente l'elenco dei valori facenti parte dell'intersezione separati da virgola
// esempio di utilizzo:
//   PElenco1 = 'Fonzie,Pippo,Paperino,Pluto'
//   PElenco2 = 'Paperino,Pippo,Gargamella';
//   R180GetCsvIntersect(PElenco1,PElenco2) = 'Paperino,Pippo'
var
  LElenco1,LElenco2: String;
  L1, L2, LIntersect: TStringList;
begin
  // inizializza variabili
  Result:='';
  L1:=nil;
  L2:=nil;
  LIntersect:=nil;

  // trim della stringa con l'elenco 1
  // rimuove eventuale virgola finale nella stringa
  LElenco1:=PElenco1.Trim;
  if LElenco1.EndsWith(',') then
    LElenco1:=LElenco1.Substring(0,LElenco1.Length - 1);

  // trim della stringa con l'elenco 2
  // rimuove eventuale virgola finale nella stringa
  LElenco2:=PElenco2.Trim;
  if LElenco2.EndsWith(',') then
    LElenco2:=LElenco2.Substring(0,LElenco2.Length - 1);

  // esce subito se una delle due liste � vuota
  if (LElenco1 = '') or (LElenco2 = '') then
    Exit;

  // se le liste sono uguali restituisce subito la lista stessa
  if LElenco1 = LElenco2 then
  begin
    Result:=LElenco1;
    Exit;
  end;

  // determina l'intersezione utilizzando delle stringlist di appoggio
  try
    try
      // crea stringlist di appoggio
      L1:=TStringList.Create;
      L2:=TStringList.Create;
      LIntersect:=TStringList.Create;

      L1.CommaText:=LElenco1;
      L2.CommaText:=LElenco2;

      // determina stringlist con intersezione
      TFunzioniGenerali.StringListIntersect(L1,L2,LIntersect);

      Result:=LIntersect.CommaText;
    except
    end;
  finally
    FreeAndNil(L1);
    FreeAndNil(L2);
    FreeAndNil(LIntersect);
  end;
end;

class function TFunzioniGenerali.GetDistanceFromCoords(PLat1, PLong1, PLat2, PLong2: double): double;
// restituisce la distanza in metri approssimata fra due punti - espressi come coordinate (lat/lng) -
// utilizzando la formula dell'emisenoverso
// cfr. https://it.wikipedia.org/wiki/Formula_dell%27emisenoverso
const
  EARTH_DIAMETER = 2 * 6372.8;
var
  dx, dy, dz: double;
begin
  PLong1:=degtorad(PLong1 - PLong2);
  PLat1:=degtorad(PLat1);
  PLat2:=degtorad(PLat2);

  dz:=sin(PLat1) - sin(PLat2);
  dx:=cos(PLong1) * cos(PLat1) - cos(PLat2);
  dy:= sin(PLong1) * cos(PLat1);
  Result:=arcsin(sqrt(sqr(dx) + sqr(dy) + sqr(dz)) / 2) * EARTH_DIAMETER * 1000;
end;

class procedure TFunzioniGenerali.StringListIntersect(PList1, PList2: TStringList; var RListIntersect: TStringList);
// questa procedure determina l'intersezione insiemistica di due stringlist e
// la carica in una stringlist di destinazione
// parametri:
//   PList1:
//     la prima stringlist
//   PList2:
//     la seconda stringlist
// parametri restituiti
//   RListIntersect:
//     la stringlist calcolata come intersezione fra le due stringlist di input
var
  L: TStringList;
  i: Integer;
begin
  // controlla i parametri
  if not Assigned(PList1) then
    raise Exception.Create('StringList di input #1 nulla');
  if not Assigned(PList2) then
    raise Exception.Create('StringList di input #2 nulla');
  if not Assigned(RListIntersect) then
    raise Exception.Create('StringList di destinazione nulla');

  // pulisce stringlist di destinazione
  RListIntersect.Clear;

  // esce subito se una delle due liste � vuota
  if (PList1.Count = 0) or (PList2.Count = 0) then
    Exit;

  // l'IndexOf deve distinguere tra maiuscole e minuscole
  PList1.CaseSensitive:=True;
  PList2.CaseSensitive:=True;

  // crea una nuova stringlist di appoggio
  L:=TStringList.Create;
  try
    // tratta la stringlist come fosse un insieme
    L.CaseSensitive:=True;
    L.Duplicates:=dupIgnore;
    L.Sorted:=True;
    L.AddStrings(PList1);

    // rimuove gli elementi della lista 2 non presenti nella lista 1
    for i:=L.Count - 1 downto 0 do
    begin
      if PList2.IndexOf(L[i]) = -1 then
        L.Delete(i);
    end;

    // assegna gli elementi della stringlist risultante nella variabile del risultato
    RListIntersect.AddStrings(L);
  finally
    FreeAndNil(L);
  end;
end;

class function TFunzioniGenerali.NumOccorrenzeString(const Substring, Text: string): Integer;
var
  offset: Integer;
begin
  result:=0;
  offset:=PosEx(Substring, Text, 1);
  while offset <> 0 do
  begin
    inc(result);
    offset:=PosEx(Substring, Text, offset + length(Substring));
  end;
end;

// RTTI

class function TFunzioniGenerali.SetPropValue(PObject: TObject; PropertyName: String; PropertyValue: Variant): Boolean;
var
  PropInfo: PPropInfo;
begin
  Result:=False;

  PropInfo:=System.TypInfo.GetPropInfo(PObject,PropertyName);
  if PropInfo <> nil then
  begin
    try
      System.TypInfo.SetPropValue(PObject,PropertyName,PropertyValue);
      Result:=True;
    except
    end;
  end;
end;

class function TFunzioniGenerali.GetPropValue(PObject: TObject; PropertyName: String): Variant;
var
  PropInfo: PPropInfo;
begin
  Result:=null;

  PropInfo:=System.TypInfo.GetPropInfo(PObject,PropertyName);
  if PropInfo <> nil then
  begin
    try
      Result:=System.TypInfo.GetPropValue(PObject,PropertyName);
    except
    end;
  end;
end;

class function TFunzioniGenerali.AnonMethod2NotifyEvent(Owner: TComponent; Proc: TProc<TObject>): TNotifyEvent;
begin
  Result:=TNotifyEventWrapper.Create(Owner,Proc).Event;
end;

class function TFunzioniGenerali.CreateDefaultFormatSettings: TFormatSettings;
// crea un oggetto TFormatSettings con le impostazioni standard
// IMPORTANTE
//   la distruzione dell'oggetto non � necessaria
begin
  Result:=TFormatSettings.Create('it-IT');
  Result.DateSeparator:=DEFAULT_DATE_SEPARATOR;
  Result.ShortDateFormat:=DEFAULT_SHORT_DATE_FMT;
  Result.TimeSeparator:=DEFAULT_TIME_SEPARATOR;
  Result.ShortTimeFormat:=DEFAULT_SHORT_TIME_FMT;
  Result.LongTimeFormat:=DEFAULT_LONG_TIME_FMT;
end;

{$REGION 'Class e record helper'}

{ TDateTimeHelper }

function TDateTimeHelper.AddDays(const aNumberOfDays: Integer): TDateTime;
begin
  Result:=IncDay(Self, aNumberOfDays);
end;

function TDateTimeHelper.AddHours(const aNumberOfHours: Int64): TDateTime;
begin
  Result:=IncHour(Self, aNumberOfHours);
end;

function TDateTimeHelper.AddMilliseconds(const aNumberOfMilliseconds: Int64): TDateTime;
begin
  Result:=IncMilliSecond(Self, aNumberOfMilliseconds);
end;

function TDateTimeHelper.AddMinutes(const aNumberOfMinutes: Int64): TDateTime;
begin
  Result:=IncMinute(Self, aNumberOfMinutes);
end;

function TDateTimeHelper.AddMonths(const aNumberOfMonths: Integer): TDateTime;
begin
  Result:=IncMonth(Self, aNumberOfMonths);
end;

function TDateTimeHelper.AddSeconds(const aNumberOfSeconds: Int64): TDateTime;
begin
  Result:=IncSecond(Self, aNumberOfSeconds);
end;

function TDateTimeHelper.AddWeeks(const aNumberOfWeeks: Integer): TDateTime;
begin
  Result:=IncWeek(Self, aNumberOfWeeks);
end;

function TDateTimeHelper.AddYears(const aNumberOfYears: Integer): TDateTime;
begin
  Result:=IncYear(Self, aNumberOfYears);
end;

class function TDateTimeHelper.Create(const aYear, aMonth,
  aDay: Word): TDateTime;
begin
  Result:=EncodeDate(aYear, aMonth, aDay);
end;

class function TDateTimeHelper.Create(const aYear, aMonth, aDay, aHour, aMinute,
  aSecond, aMillisecond: Word): TDateTime;
begin
  Result:=EncodeDateTime(aYear, aMonth, aDay, aHour, aMinute, aSecond, aMillisecond);
end;

function TDateTimeHelper.DaysBetween(const aDateTime: TDateTime): Integer;
begin
  Result:=System.DateUtils.DaysBetween(Self, aDateTime);
end;

function TDateTimeHelper.EndOfDay: TDateTime;
begin
  Result:=EndOfTheDay(Self);
end;

function TDateTimeHelper.EndOfMonth: TDateTime;
begin
  Result:=EndOfTheMonth(Self);
end;

function TDateTimeHelper.EndOfWeek: TDateTime;
begin
  Result:=EndOfTheWeek(Self);
end;

function TDateTimeHelper.EndOfYear: TDateTime;
begin
  Result:=EndOfTheYear(Self);
end;

function TDateTimeHelper.Equals(const aDateTime: TDateTime): Boolean;
begin
  Result:=SameDateTime(Self, aDateTime);
end;

function TDateTimeHelper.GetDate: TDateTime;
begin
  Result:=DateOf(Self);
end;

function TDateTimeHelper.GetDay: Word;
begin
  Result:=DayOf(Self);
end;

function TDateTimeHelper.GetDayOfWeek: Word;
begin
  Result:=DayOfTheWeek(Self);
end;

function TDateTimeHelper.GetDayOfYear: Word;
begin
  Result:=DayOfTheYear(Self);
end;

function TDateTimeHelper.GetHour: Word;
begin
  Result:=HourOf(Self);
end;

function TDateTimeHelper.GetIsNull: Boolean;
begin
  Result:=(Self = DATE_NULL);
end;

function TDateTimeHelper.GetMillisecond: Word;
begin
  Result:=MilliSecondOf(Self);
end;

function TDateTimeHelper.GetMinute: Word;
begin
  Result:=MinuteOf(Self);
end;

function TDateTimeHelper.GetMonth: Word;
begin
  Result:=MonthOf(Self);
end;

class function TDateTimeHelper.GetNow: TDateTime;
begin
  Result:=System.SysUtils.Now;
end;

function TDateTimeHelper.GetSecond: Word;
begin
  Result:=SecondOf(Self);
end;

function TDateTimeHelper.GetTime: TDateTime;
begin
  Result:=TimeOf(Self);
end;

class function TDateTimeHelper.GetToday: TDateTime;
begin
  Result:=System.SysUtils.Date;
end;

class function TDateTimeHelper.GetTomorrow: TDateTime;
begin
  Result:=System.SysUtils.Date + 1;
end;

function TDateTimeHelper.GetYear: Word;
begin
  Result:=YearOf(Self);
end;

class function TDateTimeHelper.GetYesterDay: TDateTime;
begin
  Result:=System.SysUtils.Date - 1;
end;

function TDateTimeHelper.HoursBetween(const aDateTime: TDateTime): Int64;
begin
  Result:=System.DateUtils.HoursBetween(Self, aDateTime);
end;

function TDateTimeHelper.InRange(const aStartDateTime, aEndDateTime: TDateTime; const aInclusive: Boolean): Boolean;
begin
  Result:=DateTimeInRange(Self, aStartDateTime, aEndDateTime, aInclusive);
end;

function TDateTimeHelper.IsAM: Boolean;
begin
  Result:=System.DateUtils.IsAM(Self);
end;

function TDateTimeHelper.IsInLeapYear: Boolean;
begin
  Result:=System.DateUtils.IsInLeapYear(Self);
end;

function TDateTimeHelper.IsPM: Boolean;
begin
  Result:=System.DateUtils.IsPM(Self);
end;

function TDateTimeHelper.IsSameDay(const aDateTime: TDateTime): Boolean;
begin
  Result:=System.DateUtils.IsSameDay(Self, aDateTime);
end;

function TDateTimeHelper.IsToday: Boolean;
begin
  Result:=System.DateUtils.IsToday(Self);
end;

function TDateTimeHelper.MilliSecondsBetween(const aDateTime: TDateTime): Int64;
begin
  Result:=System.DateUtils.MilliSecondsBetween(Self, aDateTime);
end;

function TDateTimeHelper.MinutesBetween(const aDateTime: TDateTime): Int64;
begin
  Result:=System.DateUtils.MinutesBetween(Self, aDateTime);
end;

function TDateTimeHelper.MonthsBetween(const aDateTime: TDateTime): Integer;
begin
  Result:=System.DateUtils.MonthsBetween(Self, aDateTime);
end;

function TDateTimeHelper.SecondsBetween(const aDateTime: TDateTime): Int64;
begin
  Result:=System.DateUtils.SecondsBetween(Self, aDateTime);
end;

function TDateTimeHelper.StartOfDay: TDateTime;
begin
  Result:=StartOfTheDay(Self);
end;

function TDateTimeHelper.StartOfMonth: TDateTime;
begin
  Result:=StartOfTheMonth(Self);
end;

function TDateTimeHelper.StartOfWeek: TDateTime;
begin
  Result:=StartOfTheWeek(Self);
end;

function TDateTimeHelper.StartOfYear: TDateTime;
begin
  Result:=StartOfTheYear(Self);
end;

function TDateTimeHelper.ToString(const aFormatStr: String = ''): String;
begin
  Result:=ToString(TFunzioniGenerali.CreateDefaultFormatSettings,aFormatStr);
end;

function TDateTimeHelper.ToString(const aFmtSettings: TFormatSettings; const aFormatStr: String = ''): String;
begin
  if aFormatStr = '' then
    Result:=DateTimeToStr(Self,aFmtSettings)
  else
    Result:=FormatDateTime(aFormatStr,Self,aFmtSettings);
end;

function TDateTimeHelper.WeeksBetween(const aDateTime: TDateTime): Integer;
begin
  Result:=System.DateUtils.WeeksBetween(Self, aDateTime);
end;

function TDateTimeHelper.YearsBetween(const aDateTime: TDateTime): Integer;
begin
  Result:=System.DateUtils.YearsBetween(Self, aDateTime);
end;

{$ENDREGION 'Class e record helper'}

{$REGION 'Logger'}

{ TLogOptions }

constructor TLogOptions.Create(PLogDescription: String; PLogOnFile,
  PLogOnLiveView: Boolean; const PFilePath: String; const PFileName: String = '');
begin
  LogDescription:=PLogDescription;
  LogOnFile:=PLogOnFile;
  LogOnLiveView:=PLogOnLiveView;
  FilePath:=PFilePath;
  FileName:=PFileName;
end;

{ TLogger }

class constructor TLogger.Create;
begin
  {$IFDEF MSWINDOWS}
  CodeSiteManager.ConnectUsingTcp;

  // configurazione del logger
  //   cfr. http://www.drbob42.com/examines/examinD2.htm
  CodeSite.Enabled:=True;
  CodeSite.Enabled:=CodeSite.Installed;
  {$ENDIF MSWINDOWS}
end;

class procedure TLogger.Configure(const POptions: TLogOptions);
begin
  {$IFDEF MSWINDOWS}
  //CodeSiteManager.ConnectUsingTcp;

  // determina il path e il nome del file di log
  FFilePath:=POptions.FilePath;
  if POptions.FileName = '' then
    FFileName:=TPath.GetFileName(TPath.ChangeExtension(GetModuleName(HInstance),'.csl'))
  else
    FFileName:=POptions.FileName;

  // verifica la presenza della directory di log e se necessario la crea
  if not TDirectory.Exists(FFilePath) then
    TDirectory.CreateDirectory(FFilePath);

  if CodeSite.Enabled then
  begin
    FDestination:=TCodeSiteDestination.Create(CodeSite);

    // log su file
    FDestination.LogFile.Active:=POptions.LogOnFile;
    FDestination.LogFile.FilePath:=FFilePath;
    FDestination.LogFile.FileName:=FFileName;

    // live view
    FDestination.Viewer.Active:=POptions.LogOnLiveView;

    CodeSite.Destination:=FDestination;

    //CodeSite.AddResetSeparator;
    CodeSite.Clear;

    // traccia alcune informazioni
    CodeSite.SendFmtMsg('Inizio log %s',[POptions.LogDescription]);
    if Assigned(CodeSite.Destination) then
    begin
      if CodeSite.Destination.LogFile.Active then
        CodeSite.Send('Log disponibile su file',TPath.Combine(CodeSite.Destination.LogFile.FilePath,CodeSite.Destination.LogFile.FileName));
      if CodeSite.Destination.Viewer.Active then
        CodeSite.Send('Log disponibile in LiveView');
    end;
    CodeSite.AddSeparator;
  end;
  {$ENDIF MSWINDOWS}
end;

class destructor TLogger.Destroy;
begin
  {$IFDEF MSWINDOWS}
  FreeAndNil(FDestination);
  {$ENDIF MSWINDOWS}
end;

class procedure TLogger.SetLiveView(const PActive: Boolean);
begin
  {$IFDEF MSWINDOWS}
  if Assigned(CodeSite.Destination) and Assigned(CodeSite.Destination.Viewer) then
    CodeSite.Destination.Viewer.Active:=PActive;
  {$ENDIF MSWINDOWS}
end;

class procedure TLogger.SetCategory(const PCategory: String);
begin
  {$IFDEF MSWINDOWS}
  CodeSite.Category:=PCategory;
  {$ENDIF MSWINDOWS}
end;

class procedure TLogger.Debug(const PMsg: String);
begin
  {$IFDEF MSWINDOWS}
  CodeSite.SendMsg(PMsg);
  {$ENDIF MSWINDOWS}
end;

class procedure TLogger.Debug(const PMsg: String; const PValue: Char);
begin
  {$IFDEF MSWINDOWS}
  CodeSite.Send(PMsg,PValue);
  {$ENDIF MSWINDOWS}
end;

class procedure TLogger.Debug(const PMsg: String; const PObj: TObject);
begin
  {$IFDEF MSWINDOWS}
  CodeSite.Send(PMsg,PObj);
  {$ENDIF MSWINDOWS}
end;

class procedure TLogger.Debug(const PMsg, PValue: String);
begin
  {$IFDEF MSWINDOWS}
  CodeSite.Send(PMsg,PValue);
  {$ENDIF MSWINDOWS}
end;

class procedure TLogger.Debug(const PMsg: String; const PValue: TDateTime);
begin
  {$IFDEF MSWINDOWS}
  CodeSite.Send(PMsg,PValue);
  {$ENDIF MSWINDOWS}
end;

class procedure TLogger.Debug(const PMsg: String; const PValue: Integer);
begin
  {$IFDEF MSWINDOWS}
  CodeSite.Send(PMsg,PValue);
  {$ENDIF MSWINDOWS}
end;

class procedure TLogger.Debug(const PMsg: String; const PValue: Int64);
begin
  {$IFDEF MSWINDOWS}
  CodeSite.Send(PMsg,PValue);
  {$ENDIF MSWINDOWS}
end;

class procedure TLogger.Warning(const PMsg: String);
begin
  {$IFDEF MSWINDOWS}
  CodeSite.SendWarning(PMsg);
  {$ENDIF MSWINDOWS}
end;

class procedure TLogger.Error(const PMsg: String);
begin
  {$IFDEF MSWINDOWS}
  CodeSite.SendError(PMsg);
  {$ENDIF MSWINDOWS}
end;

class procedure TLogger.Error(const PMsg: String; PException: Exception);
begin
  {$IFDEF MSWINDOWS}
  CodeSite.SendException(PMsg,PException);
  {$ENDIF MSWINDOWS}
end;

class procedure TLogger.EnterMethod(const PMethodName: String; const PObj: TObject);
begin
  {$IFDEF MSWINDOWS}
  CodeSite.EnterMethod(PObj,PMethodName);
  {$ENDIF MSWINDOWS}
end;

class procedure TLogger.ExitMethod(const PMethodName: String; const PObj: TObject);
begin
  {$IFDEF MSWINDOWS}
  CodeSite.ExitMethod(PObj,PMethodName);
  {$ENDIF MSWINDOWS}
end;

{$ENDREGION 'Logger'}

{ TOffsetPeriodo }

function TOffsetPeriodo.ToString: String;
// restituisce la descrizione dell'offset
begin
  case Tipo of
    PERIODO_ANNI:
      begin
        if Valore = 1 then
          Result:='Anno'
        else
          Result:=Format('%d anni',[Valore]);
      end;
    PERIODO_MESI:
      begin
        if Valore = 1 then
          Result:='Mese'
        else
          Result:=Format('%d mesi',[Valore]);
      end;
    PERIODO_SETTIMANE:
      begin
        if Valore = 1 then
          Result:='Settimana'
        else
          Result:=Format('%d settimane',[Valore]);
      end;
    PERIODO_GIORNI:
      begin
        if Valore = 1 then
          Result:='Giorno'
        else
          Result:=Format('%d giorni',[Valore]);
      end;
  end;
end;

{ TPeriodo }

function TPeriodo.GetPatternPeriodo: TOffsetPeriodo;
var
  LInizioAnno: TDateTime;
  LFineAnno: TDateTime;
  LInizioMese: TDateTime;
  LFineMese: TDateTime;
  LInizioSettimana: TDateTime;
  LFineSettimana: TDateTime;
  LAADiff: Integer;
  LMMDiff: Integer;
begin
  LInizioAnno:=Inizio.StartOfYear.GetDate;
  LFineAnno:=Fine.EndOfYear.GetDate;
  LInizioMese:=Inizio.StartOfMonth.GetDate;
  LFineMese:=Fine.EndOfMonth.GetDate;
  LInizioSettimana:=Inizio.StartOfWeek.GetDate;
  LFineSettimana:=Fine.EndOfWeek.GetDate;

  if (Inizio = LInizioAnno) and
     (Fine = LFineAnno) then
  begin
    // anni interi
    Result.Tipo:=PERIODO_ANNI;
    Result.Valore:=LFineAnno.Year - LInizioAnno.Year + 1;
  end
  else if (Inizio = LInizioMese) and
          (Fine = LFineMese) then
  begin
    // mesi interi
    Result.Tipo:=PERIODO_MESI;

    LAADiff:=Fine.Year - Inizio.Year;
    LMMDiff:=Fine.Month - Inizio.Month + (12 * LAADiff) + 1;
    Result.Valore:=LMMDiff;
  end
  else if (Inizio = LInizioSettimana) and
          (Fine = LFineSettimana) then
  begin
    // settimane intere
    Result.Tipo:=PERIODO_SETTIMANE;
    Result.Valore:=Abs(LFineSettimana.AddDays.WeeksBetween(LInizioSettimana));
  end
  else
  begin
    // giorni interi
    Result.Tipo:=PERIODO_GIORNI;
    Result.Valore:=Fine.AddDays.DaysBetween(Inizio);
  end;
end;

function TPeriodo.ShiftPeriodo(PSpostaAvanti, PPeriodoContiguo: Boolean): TPeriodo;
var
  //LGGDiff: Integer;
  LMMDiff: Integer;
  //LAADiff: Integer;
  LMolt: Integer;
  LOffset: TOffsetPeriodo;
begin
  LMolt:=IfThen(PSpostaAvanti,1,-1);
  if PPeriodoContiguo then //periodo immediatamente precedente o successivo
  begin
    LOffset:=GetPatternPeriodo;

    // determina nuova data inizio o fine a seconda della direzione di spostamento
    case LOffset.Tipo of
      PERIODO_ANNI:
        begin
          Result.Inizio:=Inizio.AddYears(LOffset.Valore * LMolt);
          Result.Fine:=Fine.AddYears(LOffset.Valore * LMolt).EndOfYear.GetDate;
        end;
      PERIODO_MESI:
        begin
          Result.Inizio:=Inizio.AddMonths(LOffset.Valore * LMolt);
          Result.Fine:=Fine.AddMonths(LOffset.Valore * LMolt).EndOfMonth.GetDate;
        end;
      PERIODO_SETTIMANE:
        begin
          Result.Inizio:=Inizio.AddWeeks(LOffset.Valore * LMolt);
          Result.Fine:=Fine.AddWeeks(LOffset.Valore * LMolt).EndOfWeek.GetDate;
        end;
      PERIODO_GIORNI:
        begin
          Result.Inizio:=Inizio.AddDays(LOffset.Valore * LMolt);
          Result.Fine:=Fine.AddDays(LOffset.Valore * LMolt);
        end;
    end;
  end
  else //periodo precedente o successivo specificato
  begin
    LMMDiff:=1;//per ora fisso
    if PSpostaAvanti then
    begin
      Result.Fine:=TFunzioniGenerali.FineMese(TFunzioniGenerali.AddMesi(Fine,LMMDiff * LMolt));
      Result.Inizio:=TFunzioniGenerali.InizioMese(Result.Fine);
    end
    else
    begin
      Result.Inizio:=TFunzioniGenerali.InizioMese(TFunzioniGenerali.AddMesi(Inizio,LMMDiff * LMolt));
      Result.Fine:=TfunzioniGenerali.FineMese(Result.Inizio);
    end
  end;
end;

end.


