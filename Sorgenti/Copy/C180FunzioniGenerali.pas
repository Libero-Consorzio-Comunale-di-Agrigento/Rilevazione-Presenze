unit C180FunzioniGenerali;

interface

uses
  FunzioniGenerali,
  A000UCostanti,
  //A001UActiveDs_TLB,
  Windows,
  WinSvc,
  Registry,
  Classes,
  DB,
  Oracle,
  OracleData,
  SysUtils,
  StrUtils,
  Generics.Collections,
  DateUtils,
  System.Math,
  Variants,
  DCPcrypt2,
  DCPsha1,
  DCPsha256,
  DCPrijndael,
  uUtilsCrypto,
  IdCoderMIME,
  IdGlobal,
  IdHashMessageDigest,
  DBXJSON,
  System.JSON,
  System.NetEncoding,
  System.IOUtils,
  System.Types,
  Soap.EncdDecd,
  Vcl.Graphics, Vcl.Controls, Vcl.CheckLst, Vcl.Forms, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCtrls, Vcl.Clipbrd, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.Mask, Vcl.Dialogs, Vcl.ExtCtrls{$IFDEF IRISWEB}, System.RegularExpressions{$ENDIF IRISWEB};

type
  TAnnoInt   = 1900..3999;
  TMeseInt   = 1..12;
  TGiornoInt = 1..31;

  T180SyncProcessExecResults = record
    CodiceUscita:DWORD;
    DatiStdOut, DatiStdErr:String;
  end;

  T180StatoServizio = record
    CurrentState: DWord;
    DescrizioneCurrentState: String;
    EsitoQuery: Integer; // -1: errore generico, 0 = OK, 1 = errore connessione SCM,
                         // 2 = errore apertura servizio, 3 = errore query servizio
    Errore: DWord; // DWORD WINAPI GetLastError(void);
    DescrizioneErrore: String;
  end;

  T180SyncProcessExecNotifyProcedure = procedure(DettagliEsecuzione:T180SyncProcessExecResults) of object;

function  AggiungiApice(Value:String):String;
function  CalcolaPasqua(Anno: Integer):TDateTime;
function  EliminaRitornoACapo(Testo : String) : String;
function  Festivo(Giorno,Mese,Anno: Integer):Boolean;
function  Identificatore(const Nome:String):String;
function  OreMinutiValidate(Valore:String): Boolean;

procedure R180AbilitaOggetti(C:TWinControl; Abilitato:Boolean);
procedure R180VisualizzaOggetti(C:TWinControl; Visibile:Boolean);
function  R180VarToDateTime(V:Variant):TDateTime;
function  R180AddMesi(Data:TDateTime; Mesi: Integer; MantieniFineMese:Boolean = False):TDateTime;
function  R180DiffMesi(Inizio,Fine:TDateTime):Real;
function  R180Anno(Data:TDateTime):Word;
procedure R180AppendFile(const NomeFile,Testo:String);
procedure R180AppendFileNoCR(const NomeFile,Testo:String);
function  R180Arrotonda(Dato,Valore:Real; Tipo:String): Real;
function  R180ArrotondaMinuti(Valore,Arrotondamento: Integer): Integer;
function  R180AttivaHintSQL(SQL:String; VersioneOracle: Integer):String;
function  R180AzzeraPrecisione(Dato:Real; NumDec: Integer): Real;
function  R180Between(const Valore,Da,A:String):Boolean; overload;
function  R180Between(const Valore,Da,A: Integer):Boolean; overload;
function  R180Between(const Valore,Da,A:TDateTime):Boolean; overload;
procedure R180ByteArrayToFile(const PByteArr: TByteDynArray; const PFileName: String);
function  R180CalcolaCIN(ABI,CAB,CC: String):String;
function  R180CalcolaCINEuropa(ABI,CAB,CC,CinItalia,CodNazione: String):String;
function  R180ControllaIBAN(IBAN:String;var MsgErr:String):Boolean;
function  R180CalcoloCodiceFiscale(Cognome,Nome,Sesso,CodCat:String; DataNas:TDateTime):String;
function  R180CarattereDef(const S:String; N:Word = 1; D:Char = #0):Char;
function  R180Centesimi(Minuti: Integer): String;
function  R180CercaParolaIntera(const Parola,Stringa,CaratteriSeparazione:String): Integer;
function  R180CifreDecimali(Dato:Real): Integer;
function  R180Capitalize(const PTesto: String): String;
procedure R180ClearDBEditDateTime(Sender:TObject);
function  R180CloseDataSetTag0(DS: TDataset; const DistruggiFields: Boolean = False): Boolean;
function  R180ControllaPeriodo(const PDataInizio, PDataFine: String; var RDataInizio, RDataFine: TDateTime; var RErrMsg: String): Boolean; overload;
function  R180ControllaPeriodo(const PDataInizio: String; const PNumeroGiorni: Integer; var RDataInizio, RDataFine: TDateTime; var RErrMsg: String): Boolean; overload;
function  R180ControllaPeriodo(const PDataInizio, PDataFine: TDateTime; var RErrMsg: String): Boolean; overload;
function  R180PreparaFileHelpTemp(NomeFileHelp:String): String;
function  R180Cripta(S:String; Key:LongInt):String;
function  R180CriptaI070(Password:string):string;
procedure R180DBGridCopyToClipboard(DBGrid:TDBGrid; CopyToExcel:Boolean; RigheSelezionate:Boolean = True; Intestazione:Boolean = True; NoACapo:Boolean = False);
procedure R180DBGridSelezionaRighe(DBGrid:TDBGrid; Modo:Char);
procedure R180DBGridSetDrawingStyle(Sender:TComponent);
procedure R180DecodeFileB64(const PStringaB64,PFileName: string);
function  R180Decripta(S:String; Key:LongInt):String;
function  R180DecriptaI070(Password:string):string;
function  R180DimLung(S:String; D: Integer):String;
function  R180DimLungR(S:String; D: Integer):String;
function  R180ElencoGiorni(Inizio,Fine:TDateTime; Formato:String):String;
function  R180ElencoMesi(Inizio,Fine:TDateTime; Formato:String):String;
function  R180EliminaSpaziMultipli(const Val: String): String;
function  R180EliminaZeriASinistra(S:String):String;
function  R180EncodeFileB64(const PFileName: string): String;
function  R180EstraiExtFile(S:String):String;
function  R180EstraiNomeTabella(SqlText:string):string;
function  R180FileToByteArray(const PFileName: String): TByteDynArray;
function  R180FineMese(Data: TDateTime): TDateTime;
function  R180FineMeseSettimanale(Data:TDateTime; UltimaSettInterna:Boolean):TDateTime;
function  R180FormatiCodificati(Dato,Formato:String;Lung: Integer=0):String;
function  R180Formatta(Dato:Real; NumCrt,NumDec: Integer):String;
function  R180FormattaNumero(S,F:String):String;
function  R180GetCampiConcatenati(D:TDataSet; C:TStringList; BUsaOldValues: Boolean = False):String;
function  R180GetCaptionTipologia(TipoQuota: String): String;
function  R180GetCheckList(L:Word; CL:TCheckListBox; Separator:char=','; ValoriDaSelezionare:Boolean=True):String;
function  R180GetColonnaDBGrid(DBGrid:TDBGrid; Campo:String): Integer;
function  R180GetCsvIntersect(const PElenco1, PElenco2: String): String;
function  R180GetEnvVarValue(const VarName: string): string;
function  R180GetFileName(S:String):String;
function  R180GetFilePath(S:String; EndSlash:Boolean = False):String;
function  R180GetFileSize(const PFileName:String): Int64;
function  R180GetFileSizeStr(const PSizeInBytes: Int64): String; overload;
function  R180GetFileSizeStr(const PFileName:String): String; overload;
function  R180GetFontStyle(FS:String):TFontStyles;
function  R180GetInstallationPath: String;
function  R180GetIPFromHost(var HostName, IPaddr, WSAErr: String): Boolean;
function  R180GetOracleRelease(ss:TOracleSession):String;
function  R180GetOSTempDir: String;
function  R180GetPropValue(PObject: TObject; PropertyName: String): Variant;
function  R180GetRegistro(Root:HKEY; const Chiave,Dato,Def:String):String;
function  R180GetServicePath(strServiceName: string; strMachine: string = ''): String;
function  R180GetServiceStatus(strServiceName: string; strMachine: string = ''): T180StatoServizio;
function  R180GetStringList(DataSet:TDataSet; Colonne:String):String;
function  R180GetValore(S,P,A:String; var Valore:String):Boolean;
function  R180GiorniMese(Data: TDateTime): Byte;
function  R180GiorniOreToStr(Valore:Real; UM:String; Formato:String=''):String;
function  R180Giorno(Data:TDateTime):Word;
function  R180In(const Valore:String; lstValori:array of String):Boolean; overload;
function  R180In(const Valore: Integer; lstValori:array of Integer):Boolean; overload;
function  R180In(const Valore:TObject; lstValori:array of TObject):Boolean; overload;
function  R180IncollaTestoDaClipboard(Testo:String;InizioSelezione,LunghezzaSelezione: Integer):String;
function  R180InConcat(const Parola,Stringa:String):Boolean;
function  R180Indenta(const PTesto: String; const PIndentazione: Integer): String;
function  R180IndexFromValue(L: TStrings; Value: String): Integer;
function  R180IndexOf(L:TStrings; S:String; NC:Word): Integer;
procedure R180InizializzaArray(var Vettore:array of Integer; Valore: Integer = 0); overload;
procedure R180InizializzaArray(var Vettore:array of Real; Valore:Real = 0); overload;
function  R180InizioMese(Data: TDateTime): TDateTime;
function  R180InizioMeseSettimanale(Data: TDateTime; UltimaSettInterna: Boolean): TDateTime;
function  R180InserisciAliasT030(const StrSql: String): String;
function  R180InserisciColonna(var S:String; const C:String):Boolean;
procedure R180InvertiSelezioneCheckList(MyCheckListBox:TCheckListBox);
function  R180IsDigit(const PStr: String; PIndex: Integer): Boolean; overload;
function  R180IsDigit(const PChr: Char): Boolean; overload;
function  R180IsDirectoryWritable(const PDirName: String): Boolean;
function  R180IsNumeric(S:String):Boolean;
function  R180IsSpecialChar(const PChr: Char): Boolean;
function  R180TestoInSetCaratteri(Testo,CharSet:String):Boolean;
procedure R180JsonString2Comp(Sender: TComponent; JsonPair: TJSONPair);
function  R180LPad(const PStr:String; PNumCaratteri: Integer; PCarattere:char):String;
function  R180LunghezzaCampo(F:TField): Integer;
function  R180Mese(Data:TDateTime):Word;
function  R180MessageBox(const Messaggio, Tipo: String; const Titolo: String = ''; const KeyID: String = ''): Integer;
function  R180MinutiOre(Minuti: LongInt; const PTimeSeparator: Char = '.'): String;
function  R180NomeFileDatato(NomeFile,Formato:String; Data:TDateTime):String;
function  R180NomeGiorno(Anno,Mese,Giorno:Word):String; overload;
function  R180NomeGiorno(D:TDateTime):String; overload;
function  R180NomeGiornoSett(GiornoSettimana:Word):String;
function  R180NomeMese(Num:Byte):String;
function  R180NumeroMese(const PMeseInLettere: String): Integer;
function  R180NomeMeseAnno(D: TDateTime): String;
function  R180NumeroInLettere(Sessione:TOracleSession; Numero:Real):String;
function  R180NumOccorrenzeCar(S:String; C:Char): Integer;
function  R180NumOccorrenzeString(const Substring, Text: string): integer;
procedure R180OraValidate(S:String);
function  R180OreMinuti(Ora: Variant): Word; overload;
function  R180OreMinuti(Ora: TDateTime): Word; overload;
function  R180OreMinuti(Ora: String): LongInt; overload;
function  R180OreMinutiExt(Ora: String): LongInt;
procedure R180PutCheckList(S:String; L:Word; CL:TCheckListBox; Separator:char=',');
procedure R180PutRegistro(Root:HKEY; const Chiave,Dato,Valore:String);
function  R180Query2NomeTabella(DS: TDataSet):string;
function  R180RadioGroupButton(RG: TRadioGroup; I: Integer): TRadioButton;
function  R180RDL_ECB_Decrypt(const PStr,PPassPhrase: String): String;
function  R180RDL_ECB_Encrypt(const PStr,PPassPhrase: String): String;
procedure R180RemoveDir(const DirName: string);
function  R180RPad(const PStr:String; PNumCaratteri: Integer; PCarattere:char):String;
function  R180GetPathLog: String;
function  R180ScriviMsgLog(const FileLog,Msg:String):Boolean;
function  R180SetEnvVarValue(const VarName, VarValue: string): Integer;
procedure R180SetOracleInstantClient;
function  R180SettimanaAnno(Data:TDateTime; IniziaDomenica:Boolean = True): Integer;
procedure R180SetComboItemsValues(lst:TStrings; ItemsValues:array of TItemsValues; TipoLista:String);
function  R180SetPropValue(PObject: TObject; PropertyName: String; PropertyValue: Variant): Boolean;
function  R180SetVariable(ODS:TOracleDataset; Variabile:String; Valore:Variant):Boolean;
procedure R180SetReadBuffer(ODS:TDataSet);
function  R180Sha1Encrypt(const PStr: String): String;
procedure R180FileEncryptAES(Encrypt:Boolean;SourceFileName,DestFileName,Passphrase,TipoHash:String);
function  R180SommaArray(Vettore:array of Integer): Integer; overload;
function  R180SommaArray(Vettore:array of Real):Real; overload;
function  R180SyncProcessExec(PathProgramma,DirProgramma,Argomenti:String; ProceduraNotify:T180SyncProcessExecNotifyProcedure=nil):T180SyncProcessExecResults;
function  R180SostituisciCaratteriSpeciali(Testo:String):String;
function  R180Spaces(S:String; L:Word):String;
procedure R180SplitLines(Lista: TStrings; BreakSet: TSysCharSet = [' ',',']; MaxCol: Integer = 2000);
function  R180SSO_TokenUsr(Utente,Mask:String):String;
procedure R180DBGridToCsv(PDBGrid: TDBGrid;PFileName: String = '');
procedure R180DatasetToCsv(DataSet:TDataset;PFileName: String = '');
procedure R180DBGridToXlsx(PSessioneOracle:TOracleSession; PDBGrid: TDBGrid; PFileName:String = ''; PUsaDisplayLabel:Boolean = True);
procedure R180DatasetToXlsxFile(PSessioneOracle:TOracleSession; Intestazione:Boolean; DataSet:TDataset; PFileName:String = ''; ListaColonne:TList<TPair<String,String>> = nil; UsaDisplayLabel:Boolean = True);
function  R180DatasetToXlsx(PSessioneOracle:TOracleSession; Intestazione:Boolean; DataSet:TDataset; ListaColonne:TList<TPair<String,String>> = nil; UsaDisplayLabel:Boolean = False): TMemoryStream;
procedure R180StringGridCopyToClipboard(StringGrid:TStringGrid);
procedure R180StringListIntersect(PList1, PList2: TStringList; var RListIntersect: TStringList);
function  R180StrToGiorniOre(Valore,UM:String):Real;
function  R180SysDate(Sessione:TOracleSession):TDateTime;
procedure R180Tokenize(const Lista: TStrings; const Value: String; const Delimiter: String = ',');
procedure R180ToolBarHandleNeeded(Sender: TWinControl);
function  R180AnonMethod2NotifyEvent(Owner: TComponent; Proc: TProc<TObject>): TNotifyEvent;
// header shlobj_core.h, esposto da shell32.dll, WinXP+
function  R180WinApiIsUserAnAdmin():BOOL; stdcall; // https://docs.microsoft.com/en-us/windows/desktop/api/shlobj_core/nf-shlobj_core-isuseranadmin
function  R180IsUserAnAdmin():Boolean; // wrapper per R180WinApiIsUserAnAdmin(), che chiama IsUserAnAdmin() da shell32.dll
//function  R180AnonMethod2Proc(Owner: TComponent; Proc: TProc): TProcObject;
//function  R180GetActiveDirectoryUserInfo(const PDomain: string; const PUserAccountName: string; out RADUserInfo: TActiveDirectoryUserInfo): TResCtrl;
procedure R180OracleObjectSource(const PObjName: String; POracleSession: TOracleSession; var RResultList: TStringList);
{$IFDEF IRISWEB}{$IFNDEF WEBSVC}
function  R180VerificaStringaPerInjection(Stringa:String; InjTypes: TStringFilterType = injXSS; SendExcept:Boolean = False):Boolean;
function  R180PulisciStringaPerInjection(Stringa:String; InjTypes: TStringFilterType = injXSS; Sostituzione:String = ''):String;
{$ENDIF WEBSVC}{$ENDIF IRISWEB}

const
  CR                     = #13;
  LF                     = #10;
  CRLF                   = #13#10;
  TAB                    = #9;
  SPACE                  = #32;
  SPAZI_SET              = [LF,CR,SPACE];
  DATE_NULL: TDateTime   = 0;                   // 30/12/1899
  DATE_MIN : TDateTime   = 2;                   // 01/01/1900
  DATE_MAX : TDateTime   = 767010;              // 31/12/3999
  ORACLE_MAX_IN_VALUES   = 1000;
  C700NEO_ASSUNTO        = $0055AA00;

  // messagebox
  INFORMA                = 'INFORMA';           // icona info     + pulsante OK
  DOMANDA                = 'DOMANDA';           // icona question + pulsanti Si, No
  DOMANDA_ESCI           = 'DOMANDA_ESCI';      // icona question + pulsanti Si, No, Annulla
  ERR_ELAB_CONTINUA      = 'ERR_ELAB_CONTINUA'; // icona warning  + pulsanti Si, No, Termina
  ERR_ELAB_STOP          = 'ERR_ELAB_STOP';     // icona warning  + pulsanti Ignora, Termina
  ERR_ELAB_TERMINA       = 'ERR_ELAB_TERMINA';  // icona warning  + pulsante Termina
  ESCLAMA                = 'ESCLAMA';           // icona warning  + pulsante OK
  ERRORE                 = 'ERRORE';            // icona error    + pulsante OK

  // win admin
  SECURITY_NT_AUTHORITY: TSIDIdentifierAuthority = (Value: (0, 0, 0, 0, 0, 5)) ;
  SECURITY_BUILTIN_DOMAIN_RID                    = $00000020;
  DOMAIN_ALIAS_RID_ADMINS                        = $00000220;

implementation

uses
  System.TypInfo,
  {$IFNDEF WEBSVC}
  {$IFDEF IRISWEB}
  A000UInterfaccia,   // necessaria per ThreadElaborazione
  medpIWMessageDlg,   // necessaria per R180MessageBox su web
  {$ENDIF IRISWEB}
  {$ENDIF WEBSVC}
  Winsock;            // necessaria per ip address

function R180GetCaptionTipologia(TipoQuota: String): String;
begin
  Result:=TFunzioniGenerali.GetCaptionTipologia(TipoQuota);
end;

function R180GetOracleRelease(ss:TOracleSession):String;
begin
  try
    Result:=trim(copy(ss.ServerVersion,Pos('release',LowerCase(ss.ServerVersion)) + Length('Release')));
    Result:=Copy(StringReplace(Result,'.','',[RFREPLACEALL]),1);
  except
    Result:='';
  end;
end;

function R180GetServicePath(strServiceName: string; strMachine: string = ''): String;
var
  hSCManager,hSCService: SC_Handle;
  lpServiceConfig: {$IFNDEF VER210}LPQuery_Service_ConfigW{$ELSE}PQueryServiceConfigW{$ENDIF};
  NSIZE, nBytesNeeded: DWord;
begin
  Result := '';
  hSCManager := OpenSCManager(PChar(strMachine), nil, SC_MANAGER_CONNECT);
  if (hSCManager > 0) then
  begin
    hSCService := OpenService(hSCManager, PChar(strServiceName), SERVICE_QUERY_CONFIG);
    if (hSCService > 0) then
    begin
      QueryServiceConfig(hSCService, nil, 0, nSize);
      lpServiceConfig := AllocMem(nSize);
      try
        if not QueryServiceConfig(hSCService, lpServiceConfig, nSize, nBytesNeeded) Then
          Exit;
        Result := lpServiceConfig^.lpBinaryPathName;
      finally
        Dispose(lpServiceConfig);
      end;
      CloseServiceHandle(hSCService);
    end;
  end;
end;

function R180GetServiceStatus(strServiceName: string; strMachine: string = ''): T180StatoServizio;
var
  SCManHandle,SvcHandle:SC_Handle;
  ServiceStatus:TServiceStatus;
begin
  Result.CurrentState:=0;
  Result.DescrizioneCurrentState:='-';
  Result.EsitoQuery:=-1;
  Result.Errore:=0;
  Result.DescrizioneErrore:='-';

  // Apro il service manager
  SCManHandle:=OpenSCManager(PChar(strMachine),nil,SC_MANAGER_CONNECT);
  if SCManHandle = 0 then
  begin
    // Se OpenSCManager ritorna 0 significa la connessione al service control manager è fallita. Perchè?
    Result.EsitoQuery:=1;
    Result.Errore:=GetLastError;
    case Result.Errore of
      ERROR_ACCESS_DENIED:
        Result.DescrizioneErrore:='Accesso negato al SCM';
      ERROR_DATABASE_DOES_NOT_EXIST:
        Result.DescrizioneErrore:='Database inesistente';
      else
        Result.DescrizioneErrore:='Errore indefinito durante la connessione al SCM';
    end;
    Exit;
  end;
  try
    SvcHandle:=OpenService(SCManHandle,PChar(strServiceName),SERVICE_QUERY_STATUS);
    if SvcHandle = 0 then
    begin
      // Se OpenService ritorna 0 significa che non siamo riusciti ad ottenere l'handle al servizio
      Result.EsitoQuery:=2;
      Result.Errore:=GetLastError;
      case Result.Errore of
        ERROR_ACCESS_DENIED:
          Result.DescrizioneErrore:='Accesso negato durante l''apertura del servizio';
        ERROR_INVALID_HANDLE:
          Result.DescrizioneErrore:='Handle servizio non valido';
        ERROR_INVALID_NAME:
          Result.DescrizioneErrore:='Nome del servizio non valido';
        ERROR_SERVICE_DOES_NOT_EXIST:
          Result.DescrizioneErrore:='Il servizio non esiste';
        else
          Result.DescrizioneErrore:='Errore indefinito durante l''apertura del servizio';
      end;
      Exit;
    end;
    try
      // Apertura del servizio riuscita. Interrogo lo stato.
      if not QueryServiceStatus(SvcHandle,ServiceStatus) then
      begin
        Result.EsitoQuery:=3;
        Result.Errore:=GetLastError;
        case Result.Errore of
          ERROR_ACCESS_DENIED:
            Result.DescrizioneErrore:='Accesso negato durante la query per lo stato del servizio';
          ERROR_INVALID_HANDLE:
            Result.DescrizioneErrore:='Handle servizio non valido (query)';
          else
            Result.DescrizioneErrore:='Errore indefinito durante la query per lo stato del servizio';
        end;
        Exit;
      end;
      // Tutto ok
      Result.EsitoQuery:=0;
      Result.CurrentState:=ServiceStatus.dwCurrentState;
      case Result.CurrentState of
        SERVICE_CONTINUE_PENDING:
          Result.DescrizioneCurrentState:='In fase di ripresa';
        SERVICE_PAUSE_PENDING:
          Result.DescrizioneCurrentState:='In fase di messa in pausa';
        SERVICE_PAUSED:
          Result.DescrizioneCurrentState:='In pausa';
        SERVICE_RUNNING:
          Result.DescrizioneCurrentState:='In esecuzione';
        SERVICE_START_PENDING:
          Result.DescrizioneCurrentState:='In fase di avvio';
        SERVICE_STOP_PENDING:
          Result.DescrizioneCurrentState:='In fase di arresto';
        SERVICE_STOPPED:
          Result.DescrizioneCurrentState:='Arrestato';
        0:
          Result.DescrizioneCurrentState:='Impossibile ottenere lo stato';
        else
          Result.DescrizioneCurrentState:='Stato indefinito (' + IntToStr(Result.CurrentState) + ')';
      end;
    finally
      CloseServiceHandle(SvcHandle);
    end;
  finally
    CloseServiceHandle(SCManHandle);
  end;
end;

// G E S T I O N E   I B A N
function R180CalcolaCIN(ABI,CAB,CC:String):String;
// Dato un ABI, CAB e conto corrente, calcola il CIN Italia
begin
  Result:=TFunzioniGenerali.CalcolaCIN(ABI,CAB,CC);
end;

function R180CalcolaCINEuropa(ABI,CAB,CC,CinItalia,CodNazione:String):String;
begin
  Result:=TFunzioniGenerali.CalcolaCINEuropa(ABI,CAB,CC,CinItalia,CodNazione);
end;

function R180ControllaIBAN(IBAN:String;var MsgErr:String):Boolean;
begin
  Result:=TFunzioniGenerali.ControllaIBAN(IBAN,MsgErr);
end;

function R180ControllaPeriodo(const PDataInizio, PDataFine: String; var RDataInizio, RDataFine: TDateTime; var RErrMsg: String): Boolean;
// effettua i controlli standard su un periodo indicato con date in formato stringa
begin
  Result:=TFunzioniGenerali.ControllaPeriodo(PDataInizio,PDataFine,RDataInizio,RDataFine,RErrMsg);
end;

function R180ControllaPeriodo(const PDataInizio: String; const PNumeroGiorni: Integer; var RDataInizio, RDataFine: TDateTime; var RErrMsg: String): Boolean;
// effettua i controlli standard su un periodo indicato con data iniziale
begin
  Result:=TFunzioniGenerali.ControllaPeriodo(PDataInizio,PNumeroGiorni,RDataInizio,RDataFine,RErrMsg);
end;

function R180ControllaPeriodo(const PDataInizio, PDataFine: TDateTime; var RErrMsg: String): Boolean;
// effettua i controlli standard su un periodo indicato
begin
  Result:=TFunzioniGenerali.ControllaPeriodo(PDataInizio,PDataFine,RErrMsg);
end;


{ Copia il file di help indicato nella directory temporanea di Windows (In XP+ è quella dell'utente).
  Necessario perchè le nuove versioni del visualizzatore dell'help di Windows non aprono file
  che non risiedono sulla macchina locale.
  Ritorna il percorso del nuovo file di help o '' se la copia fallisce. }
function R180PreparaFileHelpTemp(NomeFileHelp:String): String;
var
  OriginaleCHMPath,TempCHMDir,TempCHMPath:String;
begin
  Result:='';
  if FileExists(NomeFileHelp) then
    OriginaleCHMPath:=NomeFileHelp
  else
    OriginaleCHMPath:=IncludeTrailingPathDelimiter(GetCurrentDir) + 'Help\' + NomeFileHelp;
  // Verifichiamo che il file di help originale esista
  if FileExists(OriginaleCHMPath) then
  begin
    // Ricaviamo il path del CHM temporaneo
    TempCHMDir:=IncludeTrailingPathDelimiter(TPath.GetTempPath) + 'IrisWin';
    if not DirectoryExists(TempCHMDir) then
    begin
      if not ForceDirectories(TempCHMDir) then
      begin
        // Creazione della directory temporanea fallita. Non dovrebbe mai accadere.
        Exit;
      end;
    end;
    TempCHMPath:=TempCHMDir + '\' + ExtractFileName(NomeFileHelp);
    // Tento di copiare il file nella directory temporanea dell'utente, sovrascrivendolo se già esiste
    try
      TFile.Copy(OriginaleCHMPath,TempCHMPath,True);
      Result:=TempCHMPath; // Copia riuscita
    except
      on E:EInOutError do
      begin
        // Copia fallita, probabilmente esiste già un file in temp ed è in lock.
        // E' lo stesso che vogliamo copiare?
        if FileExists(TempCHMPath) and (TFile.GetLastWriteTimeUtc(OriginaleCHMPath) = TFile.GetLastWriteTimeUtc(TempCHMPath)) then
          Result:=TempCHMPath; // Potenzialmente sì.
      end;
    end;
  end;
end;

function R180MessageBox(const Messaggio, Tipo: String; const Titolo: String = ''; const KeyID: String = ''): Integer;
// questa funzione opera sia in ambito win che in ambito web
// (in modo sostanzialmente differente) ...
{$IFNDEF WEBSVC}
var
  // dettagli dialog
  LDlgType: {$IFDEF IRISWEB}medpIWMessageDlg.TmeIWMsgDlgType{$ELSE}Vcl.Dialogs.TMsgDlgType{$ENDIF IRISWEB};
  LButtons: {$IFDEF IRISWEB}medpIWMessageDlg.TmeIWMsgDlgBtns{$ELSE}Vcl.Dialogs.TMsgDlgButtons{$ENDIF IRISWEB};
  LDefaultBtn: {$IFDEF IRISWEB}medpIWMessageDlg.TmeIWMsgDlgBtn{$ELSE}Vcl.Dialogs.TMsgDlgBtn{$ENDIF IRISWEB};
  {$IFDEF IRISWEB}
  // variabili di supporto per controllo messaggio web
  Element: medpIWMessageDlg.TmeIWMsgDlgBtn;
  NumBtn: Integer;
  {$ENDIF IRISWEB}
{$ENDIF WEBSVC}
begin
  {$IFNDEF WEBSVC}
    if Tipo = INFORMA then
    begin
      // icona info + pulsante OK
      LDlgType:=mtInformation;
      LButtons:=[mbOK];
      LDefaultBtn:=mbOK;
    end
    else if Tipo = ESCLAMA then
    begin
      // icona warning + pulsante OK
      LDlgType:=mtWarning;
      LButtons:=[mbOK];
      LDefaultBtn:=mbOK;
    end
    else if Tipo = ERRORE then
    begin
      // icona errore + pulsante OK
      LDlgType:=mtError;
      LButtons:=[mbOK];
      LDefaultBtn:=mbOK;
    end
    else if Tipo = DOMANDA then
    begin
      // icona question + pulsanti Si, No
      LDlgType:=mtConfirmation;
      LButtons:=[mbYes,mbNo];
      LDefaultBtn:=mbYes;
    end
    else if Tipo = DOMANDA_ESCI then
    begin
      // icona question + pulsanti Si, No, Annulla
      LDlgType:=mtConfirmation;
      LButtons:=[mbYes,mbNo,mbCancel];
      LDefaultBtn:=mbYes;
    end
    else if Tipo = ERR_ELAB_CONTINUA then
    begin
      // icona warning  + pulsanti Si, No, Termina
      LDlgType:=mtWarning;
      LButtons:=[mbYes,mbNo,mbAbort];
      LDefaultBtn:=mbYes;
    end
    else if Tipo = ERR_ELAB_STOP then
    begin
      // icona warning  + pulsanti Ignora, Termina then
      LDlgType:=mtWarning;
      LButtons:=[mbIgnore,mbAbort];
      LDefaultBtn:=mbIgnore;
    end
    else if Tipo = ERR_ELAB_TERMINA then
    begin
      // icona warning  + pulsante Termina then
      LDlgType:=mtWarning;
      LButtons:=[mbAbort];
      LDefaultBtn:=mbAbort;
    end
    else
      raise Exception.Create('C180FunzioniGenerali: parametri errati per la funzione R180MessageBox.');

    {$IFDEF IRISWEB}
    // 1. web
    // se l'elaborazione non è su thread separato ma l'interazione prevede
    // scelte multiple solleva un'eccezione
    // (non sarebbe gestibile)
    if ThreadElaborazione = nil then
    begin
      NumBtn:=0;
      for Element:=Low(TmeIWMsgDlgBtn) to High(TmeIWMsgDlgBtn) do
      begin
        if Element in LButtons then
        begin
          inc(NumBtn);
          // la discriminante è che i pulsanti siano 1 oppure > 1
          if NumBtn > 1 then
            Break;
        end;
      end;
      if NumBtn > 1 then
        raise Exception.Create(Format('R180MessageBox non utilizzabile con scelte multiple fuori dal contesto del thread di elaborazione separato',[Tipo]));
    end;

    // messagebox bloccante per web
    Result:=MsgBox.WebMessageDlg(Messaggio,LDlgType,LButtons,nil,KeyID,Titolo,LDefaultBtn);
    {$ELSE}
    // 2. win
    // creo e utilizzo messagedlg
    with CreateMessageDialog(Messaggio,LDlgType,LButtons,LDefaultBtn) do
    try
      BorderIcons:=[];
      BorderStyle:=bsSingle;
      Result:=ShowModal;
    finally
      Free;
    end;
    {$ENDIF IRISWEB}
  {$ELSE}
  // in ambito webservice questa funzione non ha senso
  Result:=0;
  {$ENDIF WEBSVC}
end;

procedure R180InvertiSelezioneCheckList(MyCheckListBox: TCheckListBox);
var
  i: Integer;
begin
  if MyCheckListBox.Count <= 0 then
    Exit;
  for i:=0 to MyCheckListBox.Count - 1 do
    MyCheckListBox.Checked[i]:=Not MyCheckListBox.Checked[i];
end;

procedure R180PutCheckList(S:String; L:Word; CL:TCheckListBox; Separator:char=',');
var
  Lista:TStringList;
  i,j,indice: Integer;
begin
  for i:=0 to CL.Items.Count - 1 do
    CL.Checked[i]:=False;
  Lista:=TStringList.Create;
  try
    if Separator = ',' then
    begin
      Lista.StrictDelimiter:=True;
      Lista.CommaText:=S
    end
    else
    begin
      if s <> '' then
      begin
        while Pos(Separator,s) > 0 do
        begin
          Lista.Add(Copy(s,1,Pos(Separator,s) - 1));
          s:=Copy(s,Pos(Separator,s) + 1,Length(s));
        end;
        Lista.Add(s);
      end;
    end;
    indice:=-1;
    for i:=0 to Lista.Count - 1 do
      for j:=0 to CL.Items.Count - 1 do
        if Lista[i] = Trim(Copy(CL.Items[j],1,L)) then
          begin
          CL.Checked[j]:=True;
          if indice = -1 then
            indice:=j;
          Break;
          end;
    if indice > -1 then
      CL.ItemIndex:=indice;
  finally
    Lista.Free;
  end;
end;

function R180GetCheckList(L:Word; CL:TCheckListBox; Separator:char=','; ValoriDaSelezionare:Boolean=True):String;
var i: Integer;
begin
  Result:='';
  for i:=0 to CL.Items.Count - 1 do
    if CL.Checked[i] = ValoriDaSelezionare then
    begin
      if Result <> '' then
        Result:=Result + Separator;
      Result:=Result + Trim(Copy(CL.Items[i],1,L));
    end;
end;

function R180RadioGroupButton(RG: TRadioGroup; I: Integer): TRadioButton;
begin
  if (I < 0) or (I >= RG.Items.Count) then
  begin
    Result:=nil;
    Exit;
  end;
  Result:=(RG.Controls[I] as TRadioButton);
end;

function R180IndexOf(L: TStrings; S: String; NC: Word): Integer;
begin
  Result:=TFunzioniGenerali.IndexOf(L,S,NC);
end;

function R180IndexFromValue(L: TStrings; Value: String): Integer;
begin
  Result:=TFunzioniGenerali.IndexFromValue(L,Value);
end;

function AggiungiApice(Value:String):String;
begin
  Result:=TFunzioniGenerali.AggiungiApice(Value);
end;

// ----------   F U N Z I O N I   P E R   O R E / M I N U T I   ----------------
function R180Centesimi(Minuti: Integer): String;
// restituisce la stringa nel formato hh:mm con i minuti espressi in centesimi.
begin
  Result:=TFunzioniGenerali.Centesimi(Minuti);
end;

function R180OreMinuti(Ora: TDateTime): Word;
// Data un 'ora del giorno in TDateTime, la converte in Minuti
begin
  Result:=TFunzioniGenerali.OreMinuti(Ora);
end;

function R180OreMinuti(Ora: String): LongInt;
// Data un 'ora del giorno in TDateTime, la converte in Minuti
begin
  Result:=TFunzioniGenerali.OreMinuti(Ora);
end;

function R180OreMinuti(Ora: Variant): Word;
// Data un'ora del giorno in Variant (Data o Stringa), la converte in Minuti
begin
  Result:=TFunzioniGenerali.OreMinuti(Ora);
end;

function R180OreMinutiExt(Ora:String): LongInt;
begin
  Result:=TFunzioniGenerali.OreMinuti(Ora);
end;

function R180MinutiOre(Minuti:LongInt; const PTimeSeparator: Char = '.'): String;
// Dati i minuti, restituisce la stringa nel formato hh:mm
begin
  Result:=TFunzioniGenerali.MinutiOre(Minuti,PTimeSeparator);
end;

function R180GiorniMese(Data: TDateTime): Byte;
// restituisce il numero di giorni del mese indicato dalla data
begin
  Result:=TFunzioniGenerali.GiorniMese(Data);
end;

function R180InizioMese(Data: TDateTime): TDateTime;
// restituisce la data di inizio del mese indicato dalla data
begin
  Result:=TFunzioniGenerali.InizioMese(Data);
end;

function R180FineMese(Data: TDateTime): TDateTime;
// restituisce la data di fine del mese indicato dalla data
begin
  Result:=TFunzioniGenerali.FineMese(Data);
end;

function R180InizioMeseSettimanale(Data:TDateTime; UltimaSettInterna: Boolean): TDateTime;
// Restituisce l'inizio del mese nell'ambito del conteggio settimanale:
// il mese comincia sempre di lunedì e finisce sempre di domenica
begin
  Result:=TFunzioniGenerali.InizioMeseSettimanale(Data,UltimaSettInterna);
end;

function R180FineMeseSettimanale(Data:TDateTime; UltimaSettInterna:Boolean):TDateTime;
// Restituisce la fine del mese nell'ambito del conteggio settimanale:
// il mese comincia sempre di lunedì e finisce sempre di domenica}
begin
  Result:=TFunzioniGenerali.FineMeseSettimanale(Data,UltimaSettInterna);
end;

function R180VarToDateTime(V:Variant):TDateTime;
begin
  Result:=TFunzioniGenerali._VarToDateTime(V);
end;

function R180AddMesi(Data:TDateTime; Mesi: Integer; MantieniFineMese:Boolean = False):TDateTime;
begin
  Result:=TFunzioniGenerali.AddMesi(Data,Mesi,MantieniFineMese);
end;

function R180DiffMesi(Inizio,Fine:TDateTime):Real;
// Restituisce il numero di mesi compresi tra due date
// Se il mese iniziale e/o il mese finale non sono interi i giorni compresi vengono rapportati al numero di giorni dei mesi stessi
begin
  Result:=0;
  if R180InizioMese(Inizio) = R180InizioMese(Fine) then
    Result:=(Fine - Inizio + 1) / R180GiorniMese(Inizio)
  else
  begin
    Result:=R180Arrotonda(MonthSpan(R180InizioMese(Fine) - 1 ,R180FineMese(Inizio) + 1),1,'P');
    if Inizio <> R180InizioMese(Inizio) then
      Result:=Result + (R180FineMese(Inizio) - Inizio + 1) / R180GiorniMese(Inizio)
    else
      Result:=Result + 1;
    if Fine <> R180FineMese(Fine) then
      Result:=Result + (Fine - R180InizioMese(Fine) + 1) / R180GiorniMese(Fine)
    else
      Result:=Result + 1;
  end;
  Result:=R180Arrotonda(Result,0.001,'P');
end;

function R180CarattereDef(const S:String; N:Word = 1; D:Char = #0):Char;
// restituisce il carattere in posizione N della stringa S
begin
  Result:=TFunzioniGenerali.CarattereDef(S,N,D);
end;

function R180Spaces(S: String; L: Word):String;
// aggiunge L spazi alla stringa S
begin
  Result:=TFunzioniGenerali.Spaces(S,L);
end;

function R180EliminaSpaziMultipli(const Val: String): String;
begin
  Result:=TFunzioniGenerali.EliminaSpaziMultipli(Val);
end;

function R180GetValore(S,P,A:String; var Valore:String):Boolean;
begin
  Result:=TFunzioniGenerali.GetValore(S,P,A,Valore);
end;

function R180GetFontStyle(FS: String): TFontStyles;
// restituisce il FontStyle partendo dal formato stringa precedentemente salvato
begin
  Result:=[];
  if R180CarattereDef(FS,1,'0') = '1' then
    Result:=Result + [fsBold];
  if R180CarattereDef(FS,2,'0') = '1' then
    Result:=Result + [fsItalic];
  if R180CarattereDef(FS,3,'0') = '1' then
    Result:=Result + [fsUnderline];
  if R180CarattereDef(FS,4,'0') = '1' then
    Result:=Result + [fsStrikeOut];
end;

function R180GetInstallationPath: String;
begin
  Result:=TFunzioniGenerali.GetInstallationPath;
end;

function R180DimLung(S:String; D: Integer):String;
// aggiunge n spazi in coda ad S in modo da ottenere la lunghezza = D
begin
  Result:=TFunzioniGenerali.DimLung(S,D);
end;

function R180DimLungR(S:String; D: Integer):String;
// Aggiungo n spazi in testa ad S in modo da ottenere la lunghezza = D
begin
  Result:=TFunzioniGenerali.DimLungR(S,D);
end;

function R180LPad(const PStr:string; PNumCaratteri: Integer; PCarattere:char): string;
// left pad
begin
  Result:=TFunzioniGenerali.LPad(PStr,PNumCaratteri,PCarattere);
end;

function R180RPad(const PStr:string; PNumCaratteri: Integer; PCarattere:char): string;
// right pad
begin
  Result:=TFunzioniGenerali.RPad(PStr,PNumCaratteri,PCarattere);
end;

function R180ElencoGiorni(Inizio,Fine:TDateTime; Formato:String):String;
// restituisce una stringa contenente tutte le date da inizio a fine nel formato specificato
begin
  Result:=TFunzioniGenerali.ElencoGiorni(Inizio,Fine,Formato);
end;

function R180ElencoMesi(Inizio,Fine:TDateTime; Formato:String):String;
// restituisce una stringa contenente il numero del mese solo
begin
  Result:=TFunzioniGenerali.ElencoMesi(Inizio,Fine,Formato);
end;

function R180NomeMese(Num:Byte):String;
// restituisce il nome del mese indicato dal numero
//   1 = gennaio
//   2 = febbraio
//   ...
begin
  Result:=TFunzioniGenerali.NomeMese(Num);
end;

function R180NumeroMese(const PMeseInLettere: String): Integer;
// restituisce il numero del mese indicato in lettere
// se il mese indicato non è valido restituisce convenzionalmente -1
begin
  Result:=TFunzioniGenerali.NumeroMese(PMeseInLettere);
end;

function R180NomeMeseAnno(D: TDateTime): String;
// restituisce mese in lettere e anno della data indicati
// es. R180NomeMeseAnno(05/04/2014) = 'Aprile 2014'
begin
  Result:=TFunzioniGenerali.NomeMeseAnno(D);
end;

function R180NomeGiorno(Anno,Mese,Giorno:Word):String;
begin
  Result:=TFunzioniGenerali.NomeGiorno(Anno,Mese,Giorno);
end;

function R180NomeGiorno(D:TDateTime):String;
begin
  Result:=TFunzioniGenerali.NomeGiorno(D);
end;

function R180NomeGiornoSett(GiornoSettimana:Word):String;
//Non si può fare un overload di R180NomeGiorno
//perché non viene fatta distinzione sul parametro in ingresso tra Word e TDateTime,
//con l'effetto collaterale di richiamare sempre la stessa function
begin
  Result:=TFunzioniGenerali.NomeGiornoSett(GiornoSettimana);
end;

// -----------------------   G E S T I O N E   F I L E   -----------------------
procedure R180AppendFile(const NomeFile,Testo:String);
// Appende il testo specificato al file NomeFile (usato per i file di log)
begin
  TFunzioniGenerali.AppendFile(NomeFile,Testo);
end;

procedure R180AppendFileNoCR(const NomeFile,Testo:String);
// Appende il testo specificato al file NomeFile (usato per i file di log)
begin
  TFunzioniGenerali.AppendFileNoCR(NomeFile,Testo);
end;

function Identificatore(const Nome:String):String;
begin
  Result:=TFunzioniGenerali.Identificatore(Nome);
end;

function EliminaRitornoACapo(Testo:String):String;
begin
  Result:=TFunzioniGenerali.EliminaRitornoACapo(Testo);
end;

function CalcolaPasqua(Anno: Integer):TDateTime;
begin
  Result:=TFunzioniGenerali.CalcolaPasqua(Anno);
end;

function Festivo(Giorno,Mese,Anno: Integer):Boolean;
begin
  Result:=TFunzioniGenerali.Festivo(Giorno,Mese,Anno);
end;

function R180ArrotondaMinuti(Valore,Arrotondamento: Integer): Integer;
// arrotondamento Valore come routine z892_arrotondaP su Rp502Pro
begin
  Result:=TFunzioniGenerali.ArrotondaMinuti(Valore,Arrotondamento);
end;

// ------------------   G E S T I O N E   P A S S W O R D    -------------------
function R180Decripta(S:String; Key:LongInt):String;
// Usata per decriptare la password dell'utente Oracle MONDOEDP
// I caratteri utilizzati vanno dal codice 32 al 126}
begin
  Result:=TFunzioniGenerali.Decripta(S,Key);
end;

function R180Cripta(S:String; Key:LongInt):String;
//Usata per criptare la password dell'utente Oracle MONDOEDP
// I caratteri utilizzati vanno dal codice 32 al 126
begin
  Result:=TFunzioniGenerali.Cripta(S,Key);
end;

function R180CriptaI070(Password:string):string;
// restituisce la stringa crittografata per la password riferita a I070_UTENTI
begin
  Result:=TFunzioniGenerali.CriptaI070(Password);
end;

function R180DecriptaI070(Password:string):string;
// Rende leggibile la stringa crittografata per la password riferita a I070_UTENTI
begin
  Result:=TFunzioniGenerali.DecriptaI070(Password);
end;

function R180InserisciColonna(var S:String; const C:String): Boolean;
begin
  Result:=TFunzioniGenerali.InserisciColonna(S,C);
end;

function R180InserisciAliasT030(const StrSql: String): String;
// Verifica nella stringa SQL indicata la presenza di campi della T030_ANAGRAFICO
// privi dell'alias "T030" e lo inserisce automaticamente
begin
  Result:=TFunzioniGenerali.InserisciAliasT030(StrSql);
end;

function R180InConcat(const Parola,Stringa:String):Boolean;
// Restituisce True se Parola esiste in Stringa che contiene valori separati da Virgola
begin
  Result:=TFunzioniGenerali.InConcat(Parola,Stringa);
end;

function R180CercaParolaIntera(const Parola,Stringa,CaratteriSeparazione:String): Integer;
// Funzione ricorsiva per cercare Parola dentro Stringa se è limitata da spazi
// o da caratteri contenuti in CaratteriSeparazione
begin
  Result:=TFunzioniGenerali.CercaParolaIntera(Parola,Stringa,CaratteriSeparazione);
end;

function R180NumOccorrenzeCar(S:String; C:Char): Integer;
// Conta il numero di occorrenze del carattere C nella stringa S
begin
  Result:=TFunzioniGenerali.NumOccorrenzeCar(S,C);
end;

// G E S T I O N E   R E G I S T R O   W I N D O W S
procedure R180PutRegistro(Root:HKEY; const Chiave,Dato,Valore:String);
var
  Registro: TRegistry;
begin
  Registro:=TRegistry.Create;
  try
    Registro.RootKey:=Root;
    if Registro.OpenKey('Software\IrisWIN\' + Chiave,True) then
    begin
      try
        Registro.WriteString(Dato,Valore);
      except
        Registro.CloseKey;
        raise;
      end;
      Registro.CloseKey;
    end;
  finally
    FreeAndNil(Registro);
  end;
end;

function R180GetRegistro(Root:HKEY; const Chiave,Dato,Def:String):String;
var
  Registro: TRegistry;
begin
  Result:=Def;
  Registro:=TRegistry.Create;
  try
    Registro.RootKey:=Root;
    if Registro.OpenKeyReadOnly('Software\IrisWIN\' + Chiave) then
    begin
      try
        if Registro.ValueExists(Dato) then
          Result:=Registro.ReadString(Dato)
      except
        Registro.CloseKey;
        raise;
      end;
      Registro.CloseKey;
    end;
  finally
    FreeAndNil(Registro);
  end;
end;

function R180GetPathLog: String;
// estrae il path di log salvato nel registro di windows
const
  PATH_LOG_REG_KEY = '';
  PATH_LOG_REG_NAME = 'PATH_LOG';
  PATH_LOG_DEFAULT = 'C:\IrisWIN\Archivi';
begin
  Result:=R180GetRegistro(HKEY_LOCAL_MACHINE,PATH_LOG_REG_KEY,PATH_LOG_REG_NAME,PATH_LOG_DEFAULT).Trim;
end;

function R180ScriviMsgLog(const FileLog,Msg:String):Boolean;
//var sPath:String;
begin
  Result:=TRUE;
  EXIT;
  (*
  try
    sPath:=Trim(R180GetRegistro(HKEY_LOCAL_MACHINE,'','PATH_LOG','c:\IrisWIN\Archivi'));
    if sPath = '' then
      exit;
    if Copy(sPath,Length(sPath),1) <> '\' then
      sPath:=sPath + '\';
    if ForceDirectories(sPath) then
    begin
      R180AppendFile(sPath + FileLog,Msg);
      Result:=True;
    end;
  except
  end;
  *)
end;

// G E S T I O N E   V A R I A B I L I   D I   A M B I E N T E
function R180GetEnvVarValue(const VarName: string): string;
var
  BufSize: Integer;  // buffer size required for value
begin
  // Get required buffer size (inc. terminal #0)
  BufSize := GetEnvironmentVariable(PChar(VarName), nil, 0);
  if BufSize > 0 then
  begin
    // Read env var value into result string
    SetLength(Result, BufSize - 1);
    GetEnvironmentVariable(PChar(VarName), PChar(Result), BufSize);
  end
  else
    // No such environment variable
    Result := '';
end;

function R180SetEnvVarValue(const VarName, VarValue: string): Integer;
begin
  // Simply call API function
  if SetEnvironmentVariable(PChar(VarName), PChar(VarValue)) then
    Result:=0
  else
    Result:=GetLastError;
end;

procedure R180SetOracleInstantClient;
var
  Registro:TRegistry;
  PathOIC,PathHome,PathAppl:String;
  locTNSNames:String;
  function UsaOIC:Boolean;
  var S:String;
      B012ini:String;
  begin
    Result:=False;
    B012ini:='B012PAllineamentoClient.ini';
    if not FileExists(B012ini) then
      B012ini:=IncludeTrailingPathDelimiter(PathHome) + B012ini;
    if not FileExists(B012ini) then
      exit;
    with TStringList.Create do
    try
      LoadFromFile(B012Ini);
      S:=Values['#PathOIC'];
    finally
      Free;
    end;
    if S <> '' then
    begin
      if DirectoryExists(IncludeTrailingPathDelimiter(PathAppl) + S) then
      begin
        PathOIC:=IncludeTrailingPathDelimiter(PathAppl) + S;
        Result:=True;
      end
      else if DirectoryExists(IncludeTrailingPathDelimiter(PathHome) + S) then
      begin
        PathOIC:=IncludeTrailingPathDelimiter(PathHome) + S;
        Result:=True;
      end
      else if DirectoryExists(S) then
      begin
        PathOIC:=S;
        Result:=True;
      end
    end;
  end;
begin
  PathHome:=R180GetRegistro(HKEY_LOCAL_MACHINE,'','HOME','C:\IrisWIN').Trim;
  PathAppl:=ExtractFilePath(Application.ExeName);
  try
    Registro:=TRegistry.Create;
    try
      Registro.RootKey:=HKEY_LOCAL_MACHINE;
      Registro.OpenKeyReadOnly('Software');
      PathOIC:=IncludeTrailingPathDelimiter(PathAppl) + 'OIC';
      if not TDirectory.Exists(PathOIC) then
        PathOIC:=IncludeTrailingPathDelimiter(PathHome) + 'OIC';
      if not TDirectory.Exists(PathOIC) then
        PathOIC:='';
      //Verifico se è definito il tnsnames, altrimenti provo ad usare la OIC
      locTNSNames:='';
      if not UsaOIC and (Registro.KeyExists('oracle')) then
      try
        locTNSNames:=TNSNames;
      except
      end;
      if (PathOIC <> '') and (UsaOIC or (not Registro.KeyExists('oracle')) or (Trim(locTNSNames) = '')) then
      begin
        R180SetEnvVarValue('TNS_ADMIN',PathOIC);
        R180SetEnvVarValue('LD_LIBRARY_PATH',PathOIC);
        R180SetEnvVarValue('PATH',PathOIC + ';%PATH%');
        R180SetEnvVarValue('NLS_LANG','ITALIAN_ITALY.WE8MSWIN1252');
      end;
    finally
      FreeAndNil(Registro);
    end;
  except
  end;
end;

procedure R180OraValidate(S:String);
begin
  TFunzioniGenerali.OraValidate(S);
end;

function OreMinutiValidate(Valore: String):Boolean;
// verifica se il campo contiene un valore ore minuti valido
begin
  Result:=TFunzioniGenerali.OreMinutiValidate(Valore);
end;

procedure R180ClearDBEditDateTime(Sender:TObject);
begin
  if Sender is TDBEdit then
    with TDBEdit(Sender) do
    begin
      if DataSource = nil then exit;
      if DataSource.DataSet = nil then exit;
      if not(DataSource.DataSet.State in [dsEdit,dsInsert]) then exit;
      if DataField = '' then exit;
      if not(Field is TDateTimeField) then exit;
      if (StringReplace(Text,' ','',[rfReplaceAll]) = '//') or (StringReplace(Text,' ','',[rfReplaceAll]) = '/') then
        Field.Clear;
    end;
end;

function R180StrToGiorniOre(Valore,UM:String):Real;
begin
  Result:=TFunzioniGenerali.StrToGiorniOre(Valore,UM);
end;

function R180GiorniOreToStr(Valore:Real; UM:String; Formato:String=''):String;
begin
  Result:=TFunzioniGenerali.GiorniOreToStr(Valore,UM,Formato);
end;

function R180GetFilePath(S:String; EndSlash:Boolean = False):String;
begin
  Result:=TFunzioniGenerali.GetFilePath(S,EndSlash);
end;

function R180GetFileName(S:String):String;
begin
  Result:=TFunzioniGenerali.GetFileName(S);
end;

function R180GetFileSize(const PFileName:String): Int64;
// determina la dimensione del file specificato espressa in byte
{$WARN SYMBOL_PLATFORM OFF}
var
  sr:TSearchRec;
begin
  Result:=-1;
  try
    if FindFirst(PFileName, faAnyFile, sr ) = 0 then
      Result:=Int64(sr.FindData.nFileSizeHigh) shl Int64(32) + Int64(sr.FindData.nFileSizeLow);
  finally
    SysUtils.FindClose(sr) ;
  end;
{$WARN SYMBOL_PLATFORM ON}
end;

function R180GetFileSizeStr(const PSizeInBytes: Int64): String;
begin
  Result:=TFunzioniGenerali.GetFileSizeStr(PSizeInBytes);
end;

function R180GetFileSizeStr(const PFileName:String): String;
// determina la dimensione del file specificato e la restituisce in un formato stringa human-readable
begin
  Result:=R180GetFileSizeStr(R180GetFileSize(PFileName));
end;

function R180FileToByteArray(const PFileName: String): TByteDynArray;
const
  BLOCK_SIZE = 1024;
var
  BytesRead,BytesToWrite,Count: Integer;
  F:File of Byte;
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

procedure R180ByteArrayToFile(const PByteArr: TByteDynArray; const PFileName: String);
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

function R180EncodeFileB64(const PFileName: string): String;
var
  stream: TMemoryStream;
begin
  stream:=TMemoryStream.Create;
  try
    stream.LoadFromFile(PFileName);
    {$WARN IMPLICIT_STRING_CAST OFF}
    result:=EncodeBase64(stream.Memory, stream.Size);
    {$WARN IMPLICIT_STRING_CAST ON}
  finally
    stream.Free;
  end;
end;

procedure R180DecodeFileB64(const PStringaB64, PFileName: string);
var
  stream: TBytesStream;
begin
  {$WARN IMPLICIT_STRING_CAST_LOSS OFF}
  stream:=TBytesStream.Create(DecodeBase64(PStringaB64));
  {$WARN IMPLICIT_STRING_CAST_LOSS ON}
  try
    stream.SaveToFile(PFileName);
  finally
    stream.Free;
  end;
end;

function R180GetCampiConcatenati(D:TDataSet; C:TStringList; BUsaOldValues: Boolean = False):String;
begin
  Result:=TFunzioniGenerali.GetCampiConcatenati(D,C,BUsaOldValues);
end;

function R180EstraiNomeTabella(SqlText:String):String;
// estrae da una frase Sql il nome della prima tabella dopo la clausola FROM
begin
  Result:=TFunzioniGenerali.EstraiNomeTabella(SqlText);
end;

function R180Query2NomeTabella(DS: TDataSet):string;
begin
  Result:='';
  if DS is TOracleDataSet then
    Result:=R180EstraiNomeTabella(TOracleDataSet(DS).SQL.Text);
end;

function R180Anno(Data:TDateTime):Word;
begin
  Result:=TFunzioniGenerali.Anno(Data);
end;

function R180Mese(Data:TDateTime):Word;
begin
  Result:=TFunzioniGenerali.Mese(Data);
end;

function R180Giorno(Data:TDateTime):Word;
begin
  Result:=TFunzioniGenerali.Giorno(Data);
end;

function R180SettimanaAnno(Data:TDateTime; IniziaDomenica:Boolean = True): Integer;
begin
  Result:=TFunzioniGenerali.SettimanaAnno(Data,IniziaDomenica);
end;

function R180Arrotonda(Dato,Valore:Real; Tipo:String): Real;
begin
  Result:=TFunzioniGenerali.Arrotonda(Dato,Valore,Tipo);
end;

function R180AzzeraPrecisione(Dato:Real; NumDec: Integer): Real;
//Azzera il dato se minore della precisione
begin
  Result:=TFunzioniGenerali.AzzeraPrecisione(Dato,NumDec);
end;

function R180Formatta(Dato:Real; NumCrt,NumDec: Integer):String;
// formattazione dato numerico in stringa
var
  FS: TFormatSettings;
begin
  //Alberto 09/05/2013: forzo il separatore delle migliaia
  {$WARN SYMBOL_PLATFORM OFF}
  FS:=TFormatSettings.Create(LOCALE_SYSTEM_DEFAULT);  //non serve fare il free
  {$WARN SYMBOL_PLATFORM OFF}
  FS.ThousandSeparator:='.';
  FS.DecimalSeparator:=',';
  Result:=Format('%*.*n',[NumCrt,NumDec,Dato],FS);
end;

function R180CifreDecimali(Dato:Real): Integer;
begin
  Result:=TFunzioniGenerali.CifreDecimali(Dato);
end;

function R180FormattaNumero(S,F:String):String;
begin
  Result:=TFunzioniGenerali.FormattaNumero(S,F);
end;

function R180IsDigit(const PStr: String; PIndex: Integer): Boolean;
// restituisce True se il carattere PIndex-esimo della stringa PStr è una cifra
begin
  Result:=TFunzioniGenerali.IsDigit(PStr,PIndex);
end;

function R180IsDigit(const PChr: Char): Boolean;
// restituisce True se il carattere specificato è una cifra
begin
  Result:=TFunzioniGenerali.IsDigit(PChr);
end;

function R180IsNumeric(S:String):Boolean;
begin
  Result:=TFunzioniGenerali.IsNumeric(S);
end;

function R180IsSpecialChar(const PChr: Char): Boolean;
begin
  Result:=TFunzioniGenerali.IsSpecialChar(PChr);
end;

function R180TestoInSetCaratteri(Testo,CharSet:String):Boolean;
// restituisce True se tutti i caratteri della stringa Testo sono presenti nell'elenco di caratteri contenuto in CharSet
begin
  Result:=TFunzioniGenerali.TestoInSetCaratteri(Testo,CharSet);
end;

function R180EliminaZeriASinistra(S:String):String;
// elimina gli zeri a sinistra di una stringa
begin
 Result:=TFunzioniGenerali.EliminaZeriASinistra(S);
end;

function R180NomeFileDatato(NomeFile,Formato:String; Data:TDateTime):String;
begin
  Result:=TFunzioniGenerali.NomeFileDatato(NomeFile,Formato,Data);
end;

function R180EstraiExtFile(S:String):String;
// Estrae l'estensione del file, delimitata da '.'
begin
  Result:=TFunzioniGenerali.EstraiExtFile(S);
end;

procedure R180InizializzaArray(var Vettore:array of Integer; Valore: Integer = 0); overload;
begin
  TFunzioniGenerali.InizializzaArray(Vettore,Valore);
end;

procedure R180InizializzaArray(var Vettore:array of Real; Valore:Real = 0); overload;
begin
  TFunzioniGenerali.InizializzaArray(Vettore,Valore);
end;

function R180SommaArray(Vettore:array of Integer): Integer;
begin
  Result:=TFunzioniGenerali.SommaArray(Vettore);
end;

function R180SommaArray(Vettore:array of Real):Real;
begin
  Result:=TFunzioniGenerali.SommaArray(Vettore);
end;

function R180SyncProcessExec(PathProgramma,DirProgramma,Argomenti:String; ProceduraNotify:T180SyncProcessExecNotifyProcedure):T180SyncProcessExecResults;
var
  saSecurityAttributes:TSecurityAttributes;
  hStdOutReadHandle,hStdOutWriteHandle: THandle;
  hStdErrReadHandle,hStdErrWriteHandle: THandle;
  bStdOutHandleInit,bStdErrHandleInit,bProcessCreated: Boolean;
  siStartupInfo:TStartupInfo;
  piProcessInformation:TProcessInformation;
  sProcCommandLine:String;
  pcDirProgramma:PChar;
  sperSyncProcessExecResults:T180SyncProcessExecResults;

  function ReadFromPipe(hReadHandle:THandle):String;
  var
    cByteDisponibili, cByteLetti:Cardinal;
    aBuffer:array[0..4096] of AnsiChar;
    sResult:String; //=UnicodeString, compatibile con AnsiChar
  begin
    sResult:='';
    // Verifico che sul pipe siano presenti dei dati
    PeekNamedPipe(hReadHandle,nil,0,nil,@cByteDisponibili,nil);
    while (cByteDisponibili > 0) do
    begin
      FillChar(aBuffer,SizeOf(aBuffer),0); //Svuoto il buffer (in teoria si potrebbe evitare grazie a #0);
      ReadFile(hReadHandle,aBuffer,4096,cByteLetti,nil); // Leggo fino a 4096 byte
      aBuffer[cByteLetti]:=#0; // Terminatore di stringa. aBuffer è lungo 4097 caratteri, non si rischia overflow.
      sResult:=sResult + String(aBuffer);
      PeekNamedPipe(hReadHandle,nil,0,nil,@cByteDisponibili,nil);
    end;
    Result:=sResult;
  end;

begin
  if Trim(PathProgramma) = '' then
    raise Exception.Create('Percorso del file da eseguire vuoto!');
  (*
  if Trim(DirProgramma) = '' then
    raise Exception.Create('Directory di esecuzione vuota!');
  *)

  sProcCommandLine:=PathProgramma;
  if Trim(Argomenti) = '' then
    sProcCommandLine:=PathProgramma
  else
    sProcCommandLine:=PathProgramma + ' ' + Argomenti;

  if DirProgramma = '' then
    pcDirProgramma:=nil
  else
    pcDirProgramma:=PChar(WideString(DirProgramma));
  bStdOutHandleInit:=false;
  bStdErrHandleInit:=false;;
  bProcessCreated:=false;
  try
    try
      saSecurityAttributes.nLength:=SizeOf(TSecurityAttributes);
      saSecurityAttributes.lpSecurityDescriptor:=nil;
      saSecurityAttributes.bInheritHandle:=true;

      // Creazione pipe per redirezione stdout e stderr
      if not CreatePipe(hStdOutReadHandle, hStdOutWriteHandle, @saSecurityAttributes, 0)then
        raise Exception.Create('Creazione pipe per STDOUT fallita:' + CRLF + SysErrorMessage(GetLastError));
      bStdOutHandleInit:=true;

      if not CreatePipe(hStdErrReadHandle, hStdErrWriteHandle, @saSecurityAttributes, 0) then
        raise Exception.Create('Creazione pipe per STDERR fallita:' + CRLF + SysErrorMessage(GetLastError));
      bStdErrHandleInit:=true;

      FillChar(siStartupInfo,SizeOf(siStartupInfo),0);  //Svuoto il record _STARTUPINFOW
      siStartupInfo.cb:=SizeOf(TStartupInfo);  // cb deve contenere la dimensione del record
      siStartupInfo.hStdInput:=GetStdHandle(STD_INPUT_HANDLE); // handle di default per stdin
      siStartupInfo.hStdOutput:=hStdOutWriteHandle;  // il processo dovrà scrivere su hStdOutWriteHandle anzichè su stdout
      siStartupInfo.hStdError:=hStdErrWriteHandle;   // stessa cosa per stderr
      siStartupInfo.dwFlags:=STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
      siStartupInfo.wShowWindow:=SW_HIDE;

      FillChar(piProcessInformation,SizeOf(TProcessInformation),0); // Probabilmente non serve

      FillChar(sperSyncProcessExecResults,SizeOf(T180SyncProcessExecResults),0);

      if CreateProcess(nil, // lpApplicationName
        PChar(WideString(sProcCommandLine)), // lpCommandLine
        @saSecurityAttributes, // lpProcessAttributes
        @saSecurityAttributes, // lpThreadAttributes
        true, // bInheritHandles
        NORMAL_PRIORITY_CLASS, // dwCreationFlags
        nil, // lpEnvironment
        pcDirProgramma, // lpCurrentDirectory
        //PChar(WideString(DirProgramma)), // lpCurrentDirectory
        siStartupInfo, // lpStartupInfo
        piProcessInformation)  // lpProcessInformation
        then
      begin
        bProcessCreated:=true;
        (* Resta in attesa al massimo 50 ms per verificare se il processo è terminato.
           Ritorna valori > 0 (WAIT_ABANDONED, WAIT_TIMEOUT o WAIT_FAILED) se il processo è
           ancora attivo o 0 (WAIT_OBJECT_0) se il processo è terminato. *)
        while WaitForSingleObject(piProcessInformation.hProcess, 50) > 0 do
          begin
            sperSyncProcessExecResults.DatiStdOut:=sperSyncProcessExecResults.DatiStdOut +
              ReadFromPipe(hStdOutReadHandle);
            sperSyncProcessExecResults.DatiStdErr:=sperSyncProcessExecResults.DatiStdErr +
              ReadFromPipe(hStdErrReadHandle);
            if @ProceduraNotify <> nil then
              ProceduraNotify(sperSyncProcessExecResults);
            Application.ProcessMessages;
          end;
          // Leggo i pipe per leggere gli eventuali dati residui.
          sperSyncProcessExecResults.DatiStdOut:=sperSyncProcessExecResults.DatiStdOut +
            ReadFromPipe(hStdOutReadHandle);
          sperSyncProcessExecResults.DatiStdErr:=sperSyncProcessExecResults.DatiStdErr +
            ReadFromPipe(hStdErrReadHandle);
          if @ProceduraNotify <> nil then // Per fornire al chiamante eventuali dati dell'ultimo minuto
            ProceduraNotify(sperSyncProcessExecResults);
          Application.ProcessMessages;
          // Leggo il codice di ritorno
          GetExitCodeProcess(piProcessInformation.hProcess,sperSyncProcessExecResults.CodiceUscita);
      end
      else
        raise Exception.Create('Errore durante la creazione del processo:'  + CRLF + SysErrorMessage(GetLastError));
    except
      on E:Exception do
      begin
        raise Exception.Create('R180SyncProcessExec(): ' + E.Message);
      end;
    end;
  finally
    // Libero le risorse allocate.
    // Devo assicurarmi che CreatePipe() sia stato eseguito, o CloseHandle() andrà in errore.
    if bStdOutHandleInit then
    begin
      CloseHandle(hStdOutReadHandle);
      CloseHandle(hStdOutWriteHandle);
    end;
    if bStdErrHandleInit then
    begin
      CloseHandle(hStdErrReadHandle);
      CloseHandle(hStdErrWriteHandle);
    end;
    // Stessa cosa per gli handle del processo e del thread, solo se CreateProcess li ha valorizzati
    if bProcessCreated then
    begin
      CloseHandle(piProcessInformation.hProcess);
      CloseHandle(piProcessInformation.hThread);
    end;
  end;
  Result:=sperSyncProcessExecResults;
end;

function R180SysDate(Sessione:TOracleSession):TDateTime;
begin
  with TOracleQuery.Create(nil) do
  try
    Session:=Sessione;
    SQL.Add('SELECT SYSDATE FROM DUAL');
    Execute;
    Result:=FieldAsDate(0);
  finally
    Free;
  end;
end;

function R180AttivaHintSQL(SQL:String; VersioneOracle: Integer):String;
// Attiva/disattiva gli hint delle query in base alla versione del db
begin
  Result:=TFunzioniGenerali.AttivaHintSQL(SQL,VersioneOracle);
end;

function R180NumeroInLettere(Sessione:TOracleSession; Numero:Real):String;
begin
  Result:='';
  with TOracleQuery.Create(nil) do
  try
    Session:=Sessione;
    SQL.Add('SELECT NUMERO_IN_LETTERE(:NUMERO) FROM DUAL');
    DeclareVariable('NUMERO',otFloat);
    SetVariable('NUMERO',Numero);
    try
      Execute;
      Result:=FieldAsString(0);
    except
    end;
  finally
    Free;
  end;
end;

function R180LunghezzaCampo(F: TField): Integer;
begin
  Result:=TFunzioniGenerali.LunghezzaCampo(F);
end;

procedure R180DBGridCopyToClipboard(DBGrid:TDBGrid; CopyToExcel:Boolean; RigheSelezionate:Boolean = True; Intestazione:Boolean = True; NoACapo:Boolean = False);
var
  S:String;
  i,j: Integer;
begin
  with DbGrid, DataSource.DataSet do
  begin
    if not Active then
      exit;
    S:='';
    Clipboard.Clear;
    DisableControls;
    Screen.Cursor:=crHourGlass;

    // determina l'indice dell'ultimo campo visibile
    for j:=Columns.Count - 1 downto 0 do
    begin
      if Columns[j].Visible then
        Break;
    end;

    First;
    try
      // esporta campi di intestazione
      if Intestazione then
      begin
        if not Eof then
        begin
          for i:=0 to j do
          begin
            if Columns[i].Visible then
            begin
              if CopyToExcel then
              begin
                // accoda carattere di tabulazione (separatore di colonna excel)
                // eccetto per l'ultimo campo visibile
                S:=S + Columns[i].Title.Caption + IfThen(i < j,TAB);
              end
              else
              begin
                if i < j then
                  S:=S + Format('%-*s',[R180Lunghezzacampo(Columns[i].Field),Copy(Columns[i].Title.Caption,1,R180Lunghezzacampo(Columns[i].Field))])
                else
                  S:=S + Format('%-s',[Columns[i].Title.Caption]);
              end;
            end;
          end;

          // accoda caratteri di ritorno a capo
          if (Not NoACapo) or CopyToExcel then
            S:=S + CRLF;
        end;
      end;

      // esporta righe dati
      while not EOF do
      begin
        if DbGrid.SelectedRows.CurrentRowSelected or (not RigheSelezionate) then
        begin
          for i:=0 to j do
          begin
            if Columns[i].Visible then
            begin
              if CopyToExcel then
              begin
                // accoda carattere di tabulazione (separatore di colonna excel)
                // eccetto per l'ultimo campo visibile
                //Alberto 06/02/2017: se il campo contiene dei ritorni a capo, viene racchiuso tra virgolette in modo che su excel non vaa a capo su un'altra riga
                S:=S + IfThen(Pos(CRLF,Columns[i].Field.AsString) > 0,'"') +
                       Columns[i].Field.AsString +
                       IfThen(Pos(CRLF,Columns[i].Field.AsString) > 0,'"') +
                       IfThen(i < j,TAB);
              end
              else
              begin
                if i < j then
                  S:=S + Format('%-*s',[R180Lunghezzacampo(Columns[i].Field),Copy(Columns[i].Field.AsString,1,R180Lunghezzacampo(Columns[i].Field))])
                else
                  S:=S + Format('%-s',[Columns[i].Field.AsString]);
              end;
            end;
          end;

          // accoda caratteri di ritorno a capo
          if (Not NoACapo) or CopyToExcel then
            S:=S + CRLF;
        end;
        Next;
      end;
    finally
      First;
      EnableControls;
      Screen.Cursor:=crDefault;
    end;
  end;

  // copia il testo negli appunti di windows
  Clipboard.AsText:=S;
end;

procedure R180DBGridToCsv(PDBGrid: TDBGrid;PFileName: String = '');
begin
  if (not Assigned(PDBGrid)) or
     (not Assigned(PDBGrid.DataSource)) then
    raise Exception.Create('Impossibile esportare questa tabella!');
  R180DatasetToCsv(PDBGrid.DataSource.DataSet, PFileName);
end;

procedure R180DatasetToCsv(DataSet:TDataset;PFileName: String = '');
var
  LStream: TFileStream;
  i: Integer;
  LOutLine: string;
  LTemp: string;
  LSaveDlg: TSaveDialog;
  LOldAfterScroll: TDataSetNotifyEvent;
const
  COL_SEPARATOR         = ';';
  LINE_SEPARATOR        = CRLF;
  LENGTH_LINE_SEPARATOR = Length(LINE_SEPARATOR);
begin
  if (not Assigned(DataSet)) then
    raise Exception.Create('Impossibile esportare questa tabella!');

  if not DataSet.Active then
    raise Exception.Create('Impossibile esportare questa tabella!');

  if PFileName = '' then
  begin
    // dialog richiesta nome file
    LSaveDlg:=TSaveDialog.Create(nil);
    try
      LSaveDlg.DefaultExt:='.csv';
      LSaveDlg.Filter:='File CSV (*.csv)|*.csv';
      LSaveDlg.InitialDir:=TFunzioniGenerali.GetInstallationPath;
      if LSaveDlg.Execute then
        PFileName:=LSaveDlg.FileName
      else
       Exit;
    finally
      FreeAndNil(LSaveDlg);
    end;
  end;

  // esportazione
  Screen.Cursor:=crHourGlass;
  DataSet.DisableControls;
  LOldAfterScroll:=DataSet.AfterScroll;
  DataSet.AfterScroll:=nil;
  DataSet.First;
  try
    LStream:=TFileStream.Create(PFileName, fmCreate);
    try
      // riga di intestazione con nomi dei campi
      if not DataSet.Eof then
      begin
        LOutLine:='';
        for i:=0 to DataSet.FieldCount - 1 do
        begin
          if DataSet.Fields[i].Visible then
          begin
            LTemp:=DataSet.Fields[i].FieldName;
            // gestione del dato...
            // accoda separatore di colonna
            LOutLine:=LOutLine + LTemp + COL_SEPARATOR;
          end;
        end;
        // rimuove separatore finale
        SetLength(LOutLine,LOutLine.Length - 1);
        // scrive riga su file
        LStream.Write(LOutLine[1], LOutLine.Length * SizeOf(Char));
        // scrive fine riga
        LStream.Write(LINE_SEPARATOR,LENGTH_LINE_SEPARATOR);
      end;

      // righe di dettaglio
      while not DataSet.Eof do
      begin
        LOutLine:='';
        for i:=0 to DataSet.FieldCount - 1 do
        begin
          if DataSet.Fields[i].Visible then
          begin
            LTemp:=DataSet.Fields[i].AsString;
            // gestione del dato...
            LTemp:=Format('"%s"',[LTemp]);
            // accoda separatore di colonna
            LOutLine:=LOutLine + LTemp + COL_SEPARATOR;
          end;
        end;
        // rimuove separatore finale
        SetLength(LOutLine,LOutLine.Length - 1);
        // scrive riga su file
        LStream.Write(LOutLine[1], LOutLine.Length * SizeOf(Char));
        // scrive fine riga
        LStream.Write(LINE_SEPARATOR,LENGTH_LINE_SEPARATOR);

        DataSet.Next;
      end;
    finally
      // salva il file
      LStream.Free;
    end;
  finally
    DataSet.AfterScroll:=LOldAfterScroll;
    DataSet.First;
    DataSet.EnableControls;
    Screen.Cursor:=crDefault;
  end;
end;

procedure R180DBGridToXlsx(PSessioneOracle:TOracleSession; PDBGrid: TDBGrid; PFileName:String = ''; PUsaDisplayLabel:Boolean = True);
begin
  if (not Assigned(PDBGrid)) or
     (not Assigned(PDBGrid.DataSource)) then
    raise Exception.Create('Impossibile esportare questa tabella!');
  R180DatasetToXlsxFile(PSessioneOracle, True, PDBGrid.DataSource.DataSet, PFileName, nil, PUsaDisplayLabel);
end;

procedure R180DatasetToXlsxFile(PSessioneOracle:TOracleSession; Intestazione:Boolean; DataSet:TDataset; PFileName:String = ''; ListaColonne:TList<TPair<String,String>> = nil; UsaDisplayLabel:Boolean = True);
var FileXls: TStream;
    FileStream: TFileStream;
    LSaveDlg: TSaveDialog;
begin
  // dialog richiesta nome file
  if PFileName = '' then
  begin
    LSaveDlg:=TSaveDialog.Create(nil);
    try
      LSaveDlg.DefaultExt:='.xlsx';
      LSaveDlg.Filter:='File XLSX (*.xlsx)|*.xlsx';
      LSaveDlg.InitialDir:=TFunzioniGenerali.GetInstallationPath;
      if LSaveDlg.Execute then
        PFileName:=LSaveDlg.FileName
      else
        Exit;
    finally
      FreeAndNil(LSaveDlg);
    end;
  end;

  if not Assigned(DataSet) then
    raise Exception.Create('Il dataset di lavoro deve essere assegnato per la creazione del file xlsx');

  if not Assigned(PSessioneOracle) then
    raise Exception.Create('La sessione Oracle deve essere assegnata per la creazione del file xlsx');

  try
    FileXls:=R180DatasetToXlsx(PSessioneOracle,Intestazione,DataSet, ListaColonne, UsaDisplayLabel);
    try
      FileStream:=TFileStream.Create(PFileName, fmCreate);
      try
        FileStream.CopyFrom(FileXls, 0);
      finally
        FreeAndNil(FileStream);
      end;
    finally
      FreeAndNil(FileXls);
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

function R180DatasetToXlsx(PSessioneOracle:TOracleSession; Intestazione:Boolean; DataSet:TDataset; ListaColonne:TList<TPair<String,String>> = nil; UsaDisplayLabel:Boolean = False): TMemoryStream;
(*
  Ritorna il file in formato xlsx creato come TMemoryStream.
  Parametri:
  PSessioneOracle -> sessione oracle da usare
  Intestazione    -> True/False, indica se inserire l'intestazione delle colonne nel file
  Dataset         -> dataset contenente i dati
  ListaColonne    -> opzionale, se indicato specifica quali colonne del dataset inserire nel file e con quale intestazione
                     Attenzione!! L'oggetto viene distrutto in automatico dalla funzione

  In assenza del parametro ListaColonne vengono considerati tutti i campi del dataset con Visible = True.
  Durante lo scorrimento del dataset disabilita temporaneamente l'evento AfterScroll.
  Inserisce sempre nel file prodotto una prima colonna numerica usata come contatore per gestire l'ordinamento delle righe

  Per creare ListaColonne:

  ListaColonne:=TList<TPair<String,String>>.Create;
  ListaColonne.Add(TPair<String,String>.Create(AAA, BBB));

  dove AAA = nome del campo presente nel dataset (String)
       BBB = intestazione usata nel file di excel per il campo AAA (String)
*)
var tempQuery: TOracleQuery;
    LOB: TLOBLocator;
    i,j,k: Integer;
    NumRiga,NumColonna: Integer;
    ListaValori: TStringList;
    SQLColonne,SQLValori,NomeTabella,NomeColonna,TipoColonna: String;
    LFmtSettings:TFormatSettings;
    AfterScroll: TDataSetNotifyEvent;
begin
  if not Assigned(DataSet) then
    raise Exception.Create('Il dataset di lavoro deve essere assegnato per la creazione del file xlsx');

  if not Assigned(PSessioneOracle) then
    raise Exception.Create('La sessione Oracle deve essere assegnata per la creazione del file xlsx');

  Result:=nil;
  LFmtSettings:=TFormatSettings.Create;
  LFmtSettings.DecimalSeparator:='.';
  //disabilito l'afterscroll sul dataset
  AfterScroll:=DataSet.AfterScroll;
  DataSet.AfterScroll:=nil;
  tempQuery:=TOracleQuery.Create(nil);
  try
    tempQuery.Session:=PSessioneOracle;

    //nome random della tabella temporanea
    Randomize;
    NomeTabella:='TMP_' + Random(MaxInt).ToString; //max 2147483647

    //se non specificato nel parametro, trovo il nome delle colonne da creare (solo le colonne visible del dataset)
    if not Assigned(ListaColonne) then
    begin
      ListaColonne:=TList<TPair<String,String>>.Create;
      for i:=0 to DataSet.FieldCount - 1 do
      begin
        if DataSet.Fields[i].Visible then
          ListaColonne.Add(TPair<String,String>.Create(DataSet.Fields[i].FieldName, IfThen(UsaDisplayLabel, DataSet.Fields[i].DisplayLabel, DataSet.Fields[i].FieldName))); // gestire DisplayLabel??
      end;
    end;

    //creo la tabella (e quindi il file) solo se ho delle colonne da creare
    if ListaColonne.Count > 0 then
    begin
      ListaColonne.Insert(0, TPair<String,String>.Create('#', '#')); //inserisco il numero di riga in prima posizione

      //i nomi delle colonne non devono essere più lunghi di 30 caratteri, devo raddoppiare gli apici
      //e non devo avere intestazioni vuote
      for j:=0 to ListaColonne.Count-1 do
      begin
        if ListaColonne[j].Value = '' then
        begin
          ListaColonne.Insert(j, TPair<String,String>.Create(ListaColonne[j].Key, '-'));
          ListaColonne.Delete(j+1);
          Continue;
        end;

        if ListaColonne[j].Value.Length > 30 then
        begin
          ListaColonne.Insert(j, TPair<String,String>.Create(ListaColonne[j].Key, Copy(ListaColonne[j].Value,1,30)));
          ListaColonne.Delete(j+1);
        end;

        ListaColonne.Insert(j, TPair<String,String>.Create(ListaColonne[j].Key, ListaColonne[j].Value.Replace('''', '''''')));
        ListaColonne.Delete(j+1);
      end;

      //non devo avere 2 colonne con lo stesso nome
      for i:=0 to ListaColonne.Count-1 do
      begin
        NumColonna:=1;
        for j:=i+1 to ListaColonne.Count-1 do
        begin
          if ListaColonne[i].Value = ListaColonne[j].Value then
          begin
            Inc(NumColonna);
            //trovo il nuovo nome da assegnare alla colonna
            NomeColonna:=Copy(ListaColonne[j].Value, 1, IfThen(NumColonna < 10, 29, 28)); //nome lungo max 30 caratteri
            NomeColonna:=NomeColonna + NumColonna.ToString;
            ListaColonne.Insert(j, TPair<String,String>.Create(ListaColonne[j].Key, NomeColonna));
            ListaColonne.Delete(j+1);
          end;
        end;
      end;
    end
    else
      Exit;

    //preparazione stringa SQL delle colonne per la creazione della tabella
    SQLColonne:='';
    for i:=0 to ListaColonne.Count-1 do
    begin
      if i <> 0 then
        SQLColonne:=SQLColonne + ',';

      if ListaColonne[i].Key = '#' then //colonna del contatore delle righe
        TipoColonna:='NUMBER'
      else
      begin
        NomeColonna:=ListaColonne[i].Key;
        TipoColonna:='';

        if (DataSet.FieldByName(NomeColonna) is TDateTimeField)
            or (DataSet.FieldByName(NomeColonna) is TDateField)
        then
          TipoColonna:='DATE'
        else if (DataSet.FieldByName(NomeColonna) is TIntegerField)
                 or (DataSet.FieldByName(NomeColonna) is TLargeIntField)
                 or (DataSet.FieldByName(NomeColonna) is TWordField)
                 or (DataSet.FieldByName(NomeColonna) is TFloatField)
                 or (DataSet.FieldByName(NomeColonna) is TSmallIntField)
        then
          TipoColonna:='NUMBER'
        else if (DataSet.FieldByName(NomeColonna) is TMemoField)
                 or (DataSet.FieldByName(NomeColonna) is TBlobField)
        then
          TipoColonna:='VARCHAR2(4000 char)'
        else
          TipoColonna:='VARCHAR2(' + Max(Min(DataSet.FieldByName(NomeColonna).Size, 4000), 1).ToString + ' char)';
      end;
      SQLColonne:=SQLColonne + ' "' + ListaColonne[i].Value + '" ' + TipoColonna;
    end;

    //creo la tabella temporanea
    tempQuery.SQL.Text:='CREATE GLOBAL TEMPORARY TABLE ' + NomeTabella + '(' +  SQLColonne  + ') ON COMMIT DELETE ROWS';
    tempQuery.Execute;

    //preparazione stringa SQL delle colonne per l'inserimento massivo (senza il tipo)
    SQLColonne:='';
    for i:=0 to ListaColonne.Count-1 do
    begin
      if i <> 0 then
        SQLColonne:=SQLColonne + ',';
      SQLColonne:=SQLColonne + '"' + ListaColonne[i].Value + '"';
    end;

    // inserimento dei dati
    ListaValori:=TStringList.Create;
    try
      DataSet.DisableControls;
      try
        DataSet.First;
        NumRiga:=1;
        while not DataSet.Eof do  //scorro tutto il dataset
        begin
          SQLValori:='';
          k:=0;
          for i:=0 to ListaColonne.Count-1 do //per ogni colonna che devo stampare
          begin
            NomeColonna:=ListaColonne[i].Key;
            // separatore tra i valori
            if k <> 0 then
              SQLValori:=SQLValori + ',';

            if NomeColonna = '#' then
              SQLValori:=SQLValori + FloatToStrF(NumRiga, ffGeneral, 50, 20, LFmtSettings)
            else
            begin
              // date
              if (DataSet.FieldByName(NomeColonna) is TDateTimeField) or (DataSet.FieldByName(NomeColonna) is TDateField) then
              begin
                if DataSet.FieldByName(NomeColonna).IsNull then
                  SQLValori:=SQLValori + 'NULL'                      //gestisco data NULL
                else if (DataSet.FieldByName(NomeColonna) is TDateTimeField) then
                  SQLValori:=SQLValori + 'TO_DATE(''' + formatdatetime('yyyy-mm-dd hhnnss', (DataSet.FieldByName(NomeColonna) as TDateTimeField).AsDateTime) + ''', ''YYYY-MM-DD HH24MISS'')'
                else if (DataSet.FieldByName(NomeColonna) is TDateField) then
                  SQLValori:=SQLValori + 'TO_DATE(''' + formatdatetime('yyyy-mm-dd hhnnss', (DataSet.FieldByName(NomeColonna) as TDateField).AsDateTime) + ''', ''YYYY-MM-DD HH24MISS'')'
              end
              // numeri
              else if (DataSet.FieldByName(NomeColonna) is TIntegerField)
                     or (DataSet.FieldByName(NomeColonna) is TLargeIntField)
                     or (DataSet.FieldByName(NomeColonna) is TWordField)
                     or (DataSet.FieldByName(NomeColonna) is TFloatField)
                     or (DataSet.FieldByName(NomeColonna) is TSmallIntField)
              then
              begin
                if DataSet.FieldByName(NomeColonna).IsNull then
                  SQLValori:=SQLValori + 'NULL'
                else
                  SQLValori:=SQLValori + FloatToStrF(DataSet.FieldByName(NomeColonna).AsExtended, ffGeneral, 50, 20, LFmtSettings);
              end
              // altro
              else
              begin
                try
                  SQLValori:=SQLValori + '''' + DataSet.FieldByName(NomeColonna).AsString.Replace('''','''''') + '''';
                except
                  SQLValori:=SQLValori + '''''';
                end;
              end;
            end;
            Inc(k);
          end;
          if SQLValori <> '' then
            ListaValori.Add(SQLValori);

          Inc(NumRiga);
          DataSet.Next;
          //inserisco i valori 500 alla volta
          if (ListaValori.Count >= 500) or ((ListaValori.Count > 0) and DataSet.Eof) then
          begin
            tempQuery.SQL.Clear;
            tempQuery.SQL.Add('INSERT INTO ' + NomeTabella + '(' + SQLColonne + ')');
            for j:=0 to ListaValori.Count-1 do
              tempQuery.SQL.Add('SELECT ' + ListaValori[j] + ' FROM DUAL' + IfThen(j <> ListaValori.Count-1, ' UNION ALL', ''));
            tempQuery.Execute;
            ListaValori.Clear;
          end;
        end;
      finally
        DataSet.First;
        DataSet.EnableControls;
      end;
    finally
      FreeAndNil(ListaValori);
    end;

    // creo il file xlsx con la funzione Oracle MEDPF_XLSX
    LOB:=TLOBLocator.CreateTemporary(PSessioneOracle, otBLOB, True);
    try
      tempQuery.SQL.Text:='BEGIN :RESULT:=MEDPF_XLSX(p_tabella => ''' + NomeTabella + '''' + IfThen(not Intestazione, ', p_header => false', '') + '); END;';
      tempQuery.DeclareVariable('RESULT', otBLOB);
      tempQuery.SetComplexVariable('RESULT', LOB);
      tempQuery.Execute;
      Result:=TMemoryStream.Create;
      Result.CopyFrom(LOB, LOB.Size);
    finally
      FreeAndNil(LOB);
    end;
  finally
    // in ogni caso provo a droppare la tabella temporanea, se non c'è e/o da errore non lo propago al chiamante
    try
      tempQuery.DeleteVariables;
      tempQuery.SQL.Text:='DROP TABLE ' + NomeTabella;
      tempQuery.Execute;
    except end;
    //ripristino l'afterscroll sul dataset
    DataSet.AfterScroll:=AfterScroll;
    FreeAndNil(tempQuery);
    FreeAndNil(ListaColonne);//distruggo sempre la lista delle colonne
  end;
end;

procedure R180StringGridCopyToClipboard(StringGrid:TStringGrid);
var
  S:String;
  i,j: Integer;
begin
  S:='';
  Clipboard.Clear;
  Screen.Cursor:=crHourGlass;
  try
    for i:=0 to StringGrid.RowCount - 1 do
    begin
      for j:=0 to StringGrid.ColCount - 1 do
        S:=S + StringGrid.Cells[j,i] + #9;
      S:=S + #13#10;
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
  Clipboard.AsText:=S;
end;

function R180IncollaTestoDaClipboard(Testo:String;InizioSelezione,LunghezzaSelezione: Integer):String;
var
  TestoSalvato:String;
begin
  TestoSalvato:=Testo;
  try
    Result:=Copy(Testo,1,InizioSelezione) + Clipboard.AsText + Copy(Testo,InizioSelezione + 1 + LunghezzaSelezione);
  except
    Result:=TestoSalvato;
  end;
end;

procedure R180DBGridSelezionaRighe(DBGrid:TDBGrid; Modo:Char);
var
  BM:TBookMark;
begin
  {$IFNDEF VER185}
    SetLength(BM,0);
  {$ENDIF}
  with DbGrid.DataSource.DataSet do
  begin
    if not Active then
      exit;
    if Modo = 'N' then
    begin
      DbGrid.SelectedRows.Clear;
      exit;
    end;
    DisableControls;
    First;
    try
      while not EOF do
      begin
        case Modo of
          'S':DbGrid.SelectedRows.CurrentRowSelected:=True;
          'C':DbGrid.SelectedRows.CurrentRowSelected:=not DbGrid.SelectedRows.CurrentRowSelected;
        end;
        if (DbGrid.SelectedRows.CurrentRowSelected) and
           ({$IFNDEF VER185}(Length(BM) = 0) or {$ENDIF} (not DbGrid.DataSource.DataSet.BookMarkValid(BM))) then
          BM:=DbGrid.DataSource.DataSet.GetBookmark;
        Next;
      end;
    finally
      if {$IFNDEF VER185}(Length(BM) > 0) and {$ENDIF} DbGrid.DataSource.DataSet.BookMarkValid(BM) then
      begin
        DbGrid.DataSource.DataSet.GotoBookmark(BM);
        DbGrid.DataSource.DataSet.FreeBookmark(BM);
      end;
      EnableControls;
    end;
  end;
end;

function R180GetColonnaDBGrid(DBGrid:TDBGrid; Campo:String): Integer;
var
  i: Integer;
begin
  Result:=-1;
  Campo:=UpperCase(Campo); // ottimizzazione confronto
  for i:=0 to DBGrid.Columns.Count - 1 do
  begin
    if UpperCase(DBGrid.Columns[i].FieldName) = Campo then
    begin
      Result:=i;
      Break;
    end;
  end;
end;

function R180FormatiCodificati(Dato,Formato:String;Lung: Integer=0):String;
begin
  Result:=TFunzioniGenerali.FormatiCodificati(Dato,Formato,Lung);
end;

procedure R180AbilitaOggetti(C:TWinControl; Abilitato:Boolean);
var
  i: Integer;
begin
  for i:=0 to C.ControlCount - 1 do
  begin
    if C.Controls[i] is TWinControl then
      (C.Controls[i] as TWinControl).Enabled:=Abilitato
    else if C.Controls[i] is TGraphicControl then
      (C.Controls[i] as TGraphicControl).Enabled:=Abilitato;
  end;
end;

procedure R180VisualizzaOggetti(C:TWinControl; Visibile:Boolean);
var
  i: Integer;
begin
  for i:=0 to C.ControlCount - 1 do
  begin
    if C.Controls[i] is TWinControl then
      (C.Controls[i] as TWinControl).Visible:=Visibile
    else if C.Controls[i] is TGraphicControl then
      (C.Controls[i] as TGraphicControl).Visible:=Visibile;
  end;
end;

function R180Sha1Encrypt(const PStr: String): String;
// funzione per cifrare una stringa con l'algoritmo sha-1
// importante: utilizza librerie open source per effettuare la cifratura
var
  Hash: TDCP_hash;
  HashDigest: array of byte;
  i, read: integer;
  buffer: array[0..16383] of byte;
  strmInput: TStringStream;
begin
  Result:='';

  Hash:=TDCP_sha1.Create(nil);
  try
    try
      // inizializza l'oggetto hash
      Hash.Init;

      // crea stream di appoggio per impostazione dati da cifrare
      strmInput:=TStringStream.Create(PStr);
      read:=strmInput.Read(buffer,Sizeof(buffer));

      Hash.Update(buffer,read);

      // distrugge lo stream di appoggio
      FreeAndNil(strmInput);

      // garantisce che l'hashsize sia 160 bit
      if Hash.HashSize <> 160 then
        raise Exception.Create(Format('Errore nella crittografia sha-1: hashsize = %d',[Hash.HashSize]));

      // il digest è un array 0 based con 20 elementi (uno per ogni byte)
      SetLength(HashDigest,Hash.HashSize div 8);

      // salva il risultato nell'hashdigest (array di 20 byte)
      Hash.Final(HashDigest[0]);

      // ricompone la stringa sha1 concatenando i caratteri esadecimali
      for i:=0 to Length(HashDigest) - 1 do
        Result:=Result + IntToHex(HashDigest[i],2);
    except
      on E: Exception do
        raise Exception.Create(Format('Errore nella crittografia sha-1: %s (%s)',[E.Message,E.ClassName]));
    end;
  finally
    FreeAndNil(Hash);
  end;
end;

procedure R180FileEncryptAES(Encrypt:Boolean;SourceFileName,DestFileName,Passphrase,TipoHash:String);
//Es. file:///C:/DelphiUnitAggiuntive/dcpcrypt2/Docs/Ciphers.html#Example1
//La crittografia del file     rc4  funziona ma non è sicura perciò usiamo la AES/Rijndael
//La crittografia della chiave sha1 funziona ma non è sicura perciò usiamo la sha256
//Parametri: Encrypt:        True = cripta, False = decripta
//           SourceFileName: Nome del file da criptare/decriptare
//           DestFileName:   Nome del file criptato/decriptato. Lasciare vuoto per sostituire il SourceFileName
//           Passphrase:     Passphrase da utilizzare per criptare/decriptare
//           TipoHash:       Tipo di hash da eseguire sulla Passphrase (NO,SHA1,SHA256)
var
  Cipher:TDCP_rijndael;
  Source,Dest:TFileStream;
  bSostituisciFile:Boolean;
begin
  bSostituisciFile:=DestFileName.Trim = '';
  try
    if bSostituisciFile then
      DestFileName:=SourceFileName + '.temp';
    Source:=TFileStream.Create(SourceFileName,fmOpenRead);
    Dest:=TFileStream.Create(DestFileName,fmCreate);
    Cipher:=TDCP_rijndael.Create(nil);
    (*if TipoHash = HASHTYPE_NoHash then
      Cipher.Init(Passphrase)                        // initialize the cipher without         hash of the passphrase
    else*) if TipoHash = HASHTYPE_Sha1 then
      Cipher.InitStr(Passphrase,TDCP_sha1)           // initialize the cipher with the sha1   hash of the passphrase
    else if TipoHash = HASHTYPE_Sha256 then
      Cipher.InitStr(Passphrase,TDCP_sha256);        // initialize the cipher with the sha256 hash of the passphrase
    if Encrypt then
      Cipher.EncryptStream(Source,Dest,Source.Size)  // encrypt the contents of the file
    else
      Cipher.DecryptStream(Source,Dest,Source.Size); // decrypt the contents of the file
    Cipher.Burn;
    Cipher.Free;
    Dest.Free;
    Source.Free;
    if bSostituisciFile then
    begin
      SysUtils.DeleteFile(SourceFileName);
      SysUtils.RenameFile(DestFileName,SourceFileName);
    end;
  except
    on E:Exception do
      raise Exception.Create(Format('Errore nella ' + IfThen(not Encrypt,'de') + 'crittografia AES: %s (%s)',[E.Message,E.ClassName]));
  end;
end;

function R180RDL_ECB_Decrypt(const PStr,PPassPhrase: String): String;
// PStr: criptato e Base-64
//  es.PStr = 'CcFq1RCXLKuLAGFhFmtStzW3N5f0DBlGk9OmmLtTmcA=    ';
//     PPassPhrase = 'Video meliora proboque deteriora sequor'
//     Result = 'GP4WEB#15102015150525' (più qualche schifezza da eliminare)
var
  InStream,OutStream:TStringStream;
  i: integer;
  abtk:TIdBytes;
  HMD5b64_TK: RawByteString;
begin
  Result:=PStr;
  {$WARN IMPLICIT_STRING_CAST_LOSS OFF}
  HMD5b64_TK:=Result;
  {$WARN IMPLICIT_STRING_CAST_LOSS ON}
  with TIdDecoderMIME.Create(nil) do
  try
    {$WARN IMPLICIT_STRING_CAST OFF}
    abtk:=DecodeBytes(HMD5b64_TK);
    {$WARN IMPLICIT_STRING_CAST ON}
  finally
    Free;
  end;
  InStream:=TStringStream.Create;
  InStream.SetSize(Length(abtk));
  for i:=0 to High(abtk) do
    InStream.Bytes[i]:=abtk[i];
  OutStream:=TStringStream.Create;
  with TRDLCryptoEBC.Create do
  try
    SetKey(PPassPhrase);
    RDLEncryptStreamEBC(InStream,OutStream,False);
  finally
    Free;
  end;
  Result:=OutStream.DataString;
  FreeAndNil(InStream);
  FreeAndNil(OutStream);
end;

function R180RDL_ECB_Encrypt(const PStr,PPassPhrase: String): String;
// PStr: criptato e Base-64
//  es.PStr = 'GP4WEB#15102015150525'
//     PPassPhrase = 'Video meliora proboque deteriora sequor'
//     Result = 'CcFq1RCXLKuLAGFhFmtStzW3N5f0DBlGk9OmmLtTmcA=    ';
var
  InStream,OutStream:TStringStream;
  i: integer;
  abtk:TIdBytes;
  rawPassword: RawByteString;
begin
  Result:=PStr;
  {$WARN IMPLICIT_STRING_CAST_LOSS OFF}
  rawPassword:=PStr;
  {$WARN IMPLICIT_STRING_CAST_LOSS ON}
  if Length(rawPassword) mod 16  > 0 then
    for i:=1 to 16 - (Length(rawPassword) mod 16) do
      rawPassword:=rawPassword + chr(32);
  InStream:=TStringStream.Create(rawPassword);
  OutStream:=TStringStream.Create;
  try
    with TRDLCryptoEBC.Create do
    try
      SetKey(PPassPhrase);
      RDLEncryptStreamEBC(InStream,OutStream,True);
    finally
      Free;
    end;
    //Bytearray in Base64: da 16 car a 24
    SetLength(abtk,OutStream.Size);
    for i:=0 to High(abtk) do
      abtk[i]:=OutStream.Bytes[i];
    //Indy
    with TIdEncoderMIME.Create(nil) do
    try
      Result:=EncodeBytes(abtk);
      Result:=Result + Format('%*s',[16 - IfThen((Length(Result) mod 16) > 0,(Length(Result) mod 16)),'']);
    finally
      Free;
    end;
  finally
    FreeAndNil(InStream);
    FreeAndNil(OutStream);
  end;
end;

function R180SSO_TokenUsr(Utente,Mask:String):String;
begin
  Result:=TFunzioniGenerali.SSO_TokenUsr(Utente,Mask);
end;

function R180SetVariable(ODS:TOracleDataset; Variabile:String; Valore:Variant):Boolean;
begin
  Result:=False;
  if (ODS.GetVariable(Variabile) <> Valore) and ((ODS.GetVariable(Variabile) <> unAssigned) or (Valore <> null)) then
  begin
    Result:=True;
    ODS.SetVariable(Variabile,Valore);
    ODS.Close;
  end
  else if (ODS.GetVariable(Variabile) = unAssigned) and (Valore = null) then
    //Per mantenere retro-compatibilità
    Result:=True;
end;

procedure R180SetReadBuffer(ODS:TDataSet);
begin
  if ODS is TOracleDataSet then
    TOracleDataSet(ODS).ReadBuffer:=min(max(TOracleDataSet(ODS).CountQueryHits,5),9999) + 1;
end;

function R180CloseDataSetTag0(DS: TDataset; const DistruggiFields: Boolean = False): Boolean;
// Decrementa il tag del dataset e quindi lo chiude se il tag è <= 0
// Questo sistema è utilizzato in Irisweb per evitare la chiusura dei
// dataset condivisi su W001DtM
begin
  Result:=False;
  Exit;//Alberto 07/06/2013 - annullata la chiusura del dataset

  Result:=False;
  DS.Tag:=DS.Tag - 1;
  if DS.Tag <= 0 then
  begin
    // 1. distruzione campi persistenti
    if DistruggiFields then
    begin
      while (DS.FieldCount <> 0) do
        try DS.Fields[0].Free; except end;
    end;

    // 2. chiusura dataset
    try
      if DS is TOracleDataset then
        TOracleDataset(DS).CloseAll
      else
        DS.Close;
      DS.Tag:=0;
      Result:=True;
    except
    end;
  end;
end;

function R180GetStringList(DataSet:TDataSet; Colonne:String):String;
begin
  Result:=TFunzioniGenerali.GetStringList(DataSet,Colonne);
end;

function R180In(const Valore:String; lstValori:array of String):Boolean;
begin
  Result:=TFunzioniGenerali._In(Valore,lstValori);
end;

function R180In(const Valore: Integer; lstValori:array of Integer):Boolean;
begin
  Result:=TFunzioniGenerali._In(Valore,lstValori);
end;

function R180In(const Valore:TObject; lstValori:array of TObject):Boolean; overload;
begin
  Result:=TFunzioniGenerali._In(Valore,lstValori);
end;

function R180Between(const Valore,Da,A:String):Boolean;
begin
  Result:=TFunzioniGenerali.Between(Valore,Da,A);
end;

function R180Between(const Valore,Da,A: Integer):Boolean;
begin
  Result:=TFunzioniGenerali.Between(Valore,Da,A);
end;

function R180Between(const Valore,Da,A:TDateTime):Boolean;
begin
  Result:=TFunzioniGenerali.Between(Valore,Da,A);
end;

function R180Indenta(const PTesto: String; const PIndentazione: Integer): String;
// indenta il testo contenuto in PTesto di PIndentazione caratteri
// es.
//   PTesto = 'alfa'#13#10'beta'#13#10'gamma'
//   R180Indenta(PTesto,2) = '  alfa'#13#10'  beta'#13#10'  gamma'
begin
  Result:=TFunzioniGenerali.Indenta(PTesto,PIndentazione);
end;

// G E S T I O N E   S T R I N G
function R180Capitalize(const PTesto: String): String;
// Restituisce la stringa data con l'iniziale maiuscola
begin
  Result:=TFunzioniGenerali.Capitalize(PTesto);
end;

procedure R180Tokenize(const Lista: TStrings; const Value: String; const Delimiter: String = ',');
// Data una stringa ed un delimitatore, restituisce una stringlist i cui elementi
//  sono rappresentati dai singoli token delimitati.
//  Rappresenta un'alternativa all'uso di commatext, in quanto più flessibile.
//  Il delimitatore è di tipo string e può contenere più caratteri.
//  Esempi:
//    Input1  -> Value = 'aaa|bbb|ccc', Delimiter = '|'
//    Output1 -> Lista[0] = 'aaa', Lista[1] = 'bbb', Lista[2] = 'ccc'
//    Input2  -> Value = 'aaa+++ddd+++eee', Delimiter = '+++'
//    Output2 -> Lista[0] = 'aaa', Lista[1] = 'ddd', Lista[2] = 'eee'
//  Nota: la gestione della StringList (creazione/distruzione) è delegata all'utilizzatore
begin
  TFunzioniGenerali.Tokenize(Lista,Value,Delimiter);
end;

procedure R180SplitLines(Lista: TStrings; BreakSet: TSysCharSet = [' ',',']; MaxCol: Integer = 2000);
//  Suddivide le righe dell'oggetto TStrings indicato, mandando a capo
//  il testo di ogni riga al numero di caratteri specificato in MaxCol;
//  una riga potrà quindi essere divisa in 2 o più.
//  Il BreakSet rappresenta il set di caratteri considerati separatori di parole,
//  ovvero dove la riga può essere troncata in modo sicuro.
//  es. per codice SQL si consiglia di mantenere il default: spazio e virgola.
//  Attenzione!! La funzione modifica l'oggetto TStrings indicato, suddividendo
//  ogni riga "lunga" in più righe (aggiungendo quindi elementi alla lista).
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
begin
  TFunzioniGenerali.SplitLines(Lista,BreakSet,MaxCol);
end;

// G E S T I O N E   C A R T E L L E

function R180GetOSTempDir: String;
// restituisce la directory temp di windows
var
  LTempFolder: array[0..MAX_PATH] of Char;
begin
  try
    GetTempPath(MAX_PATH,@LTempFolder);
    {$WARN IMPLICIT_STRING_CAST OFF}
    Result:=AnsiString(LTempFolder);
    {$WARN IMPLICIT_STRING_CAST ON}
  except
    on E: Exception do
      raise Exception.Create(Format('Errore durante l''estrazione della directory temp del sistema: %s',[E.Message]));
  end;
end;

procedure R180RemoveDir(const DirName: string);
//  Elimina una directory e TUTTO il suo contenuto senza chiedere conferma
//  Questa procedura utilizza chiamate ricorsive per attraversare le strutture
//  delle directory, per cui vengono utilizzati i puntatori per mantenere
//  minimo l'utilizzo dello stack.
{$WARN SYMBOL_PLATFORM OFF}
var
  SearchRec: ^TSearchRec;
  FileName: PString;
  NumFile: Integer;
begin
  if Trim(DirName) = '' then
    Exit;

  // disabilita input/output checking
  {$I-}

  // alloca un nuovo record (TSearchRec) e una nuova string (FileName)
  New(SearchRec);
  New(FileName);

  try
    NumFile:=SysUtils.FindFirst(DirName + '\*.*', SysUtils.faAnyFile, SearchRec^);

    while (NumFile = 0) do
    begin
      with SearchRec^ do
      begin
        FileName^:=DirName + '\' + Name;

        // verifica se il file corrente è in realtà una directory
        if ((Attr and SysUtils.faDirectory) = 0) then
        begin
          // il file non è una directory: verifica che non sia un file di sistema o un volume ID (C:) }
          if ((Attr and SysUtils.faSysFile) = 0) then
          begin
            // rimuove l'attributo readonly, se il file è indicato come tale
            if ((Attr and SysUtils.faReadOnly) <> 0) then
              FileSetAttr(FileName^,FileGetAttr(FileName^) and (not SysUtils.faReadOnly));

            // cancella file
            SysUtils.DeleteFile(FileName^);
          end;
        end
        else if ((Name <> '.') and (Name <> '..')) then
        begin
          // si tratta di una directory -> chiamata ricorsiva
          R180RemoveDir(FileName^);
        end;
      end;
      NumFile:=SysUtils.FindNext(SearchRec^);
    end;

    SysUtils.FindClose(SearchRec^);
    RmDir(DirName);
  finally
    // rilascia la memoria allocata per le strutture
    Dispose(FileName);
    Dispose(SearchRec);
  end;

  // riabilita input/output checking
  {$I+}
{$WARN SYMBOL_PLATFORM ON}
end;

function R180IsDirectoryWritable(const PDirName: String): Boolean;
// restituisce
// - True  se la directory indicata esiste ed è accessibile in scrittura
// - False altrimenti
var
  FileName: String;
  H: THandle;
begin
  Result:=False;

  // se la directory non esiste restituisce False
  if not TDirectory.Exists(PDirName) then
    Exit;

  // imposta un file temporaneo per verificare scrittura in directory
  FileName:=IncludeTrailingPathDelimiter(PDirName) + 'chk.tmp';

  // creazione file temporaneo
  H:=CreateFile(PChar(FileName),GENERIC_READ or GENERIC_WRITE,0,nil,CREATE_NEW,FILE_ATTRIBUTE_TEMPORARY or FILE_FLAG_DELETE_ON_CLOSE,0);
  Result:=H <> INVALID_HANDLE_VALUE;

  // chiude handle ed elimina contestualmente il file
  if Result then
    CloseHandle(H);
end;

// A L T R E   F U N Z I O N I
function R180GetIPFromHost(var HostName, IPaddr, WSAErr: String): Boolean;
type
  Name = array[0..100] of AnsiChar;
  PName = ^Name;
var
  HEnt: pHostEnt;
  HName: PName;
  WSAData: TWSAData;
  i: Integer;
begin
  Result:=False;
  if WSAStartup($0101, WSAData) <> 0 then
  begin
    WSAErr:='Winsock is not responding."';
    Exit;
  end;
  IPaddr:='';
  New(HName);
  if GetHostName(HName^, SizeOf(Name)) = 0 then
  begin
    {$WARN IMPLICIT_STRING_CAST OFF}
    HostName:=AnsiString(HName^);
    {$WARN IMPLICIT_STRING_CAST ON}
    HEnt:=GetHostByName(HName^);
    for i:=0 to HEnt^.h_length - 1 do
      IPaddr:=Concat(IPaddr,IntToStr(Ord(HEnt^.h_addr_list^[i])) + '.');
    SetLength(IPaddr, Length(IPaddr) - 1);
    Result:=True;
  end
  else
  begin
    case WSAGetLastError of
      WSANOTINITIALISED: WSAErr:='WSANotInitialised';
      WSAENETDOWN      : WSAErr:='WSAENetDown';
      WSAEINPROGRESS   : WSAErr:='WSAEInProgress';
    end;
  end;
  Dispose(HName);
  WSACleanup;
end;

function R180CalcoloCodiceFiscale(Cognome,Nome,Sesso,CodCat:String; DataNas:TDateTime):String;
// calcolo del codice fiscale
begin
  Result:=TFunzioniGenerali.CalcoloCodiceFiscale(Cognome,Nome,Sesso,CodCat,DataNas);
end;

function R180SostituisciCaratteriSpeciali(Testo:String):String;
begin
  Result:=TFunzioniGenerali.SostituisciCaratteriSpeciali(Testo);
end;

procedure R180SetComboItemsValues(lst:TStrings; ItemsValues:array of TItemsValues; TipoLista:String);
begin
  TFunzioniGenerali.SetComboItemsValues(lst,ItemsValues,TipoLista);
end;

//XE3
procedure R180DBGridSetDrawingStyle(Sender:TComponent);
var
  i: Integer;
begin
  for i:=0 to Sender.ComponentCount - 1 do
  begin
    if Sender.Components[i] is TDBGrid then
      TDBGrid(Sender.Components[i]).DrawingStyle:=gdsClassic;
  end;
end;

function R180GetCsvIntersect(const PElenco1, PElenco2: String): String;
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
begin
   Result:=TFunzioniGenerali.GetCsvIntersect(PElenco1,PElenco2);
end;

procedure R180StringListIntersect(PList1, PList2: TStringList; var RListIntersect: TStringList);
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
begin
  TFunzioniGenerali.StringListIntersect(PList1,PList2,RListIntersect);
end;

procedure R180JsonString2Comp(Sender: TComponent; JsonPair: TJSONPair);
begin
  if Sender is TTabControl then
    (Sender as TTabControl).TabIndex:=StrToInt(jsonPair.JSONValue.Value)
  else if Sender is TCheckBox then
    (Sender as TCheckBox).Checked:=jsonPair.JSONValue.Value = 'S'
  else if Sender is TEdit then
    (Sender as TEdit).Text:=jsonPair.JSONValue.Value
  else if Sender is TMaskEdit then
    (Sender as TMaskEdit).Text:=jsonPair.JSONValue.Value
  else if Sender is TSpinEdit then
    (Sender as TSpinEdit).Text:=jsonPair.JSONValue.Value
  else if Sender is TComboBox then
    (Sender as TComboBox).Text:=jsonPair.JSONValue.Value
  else if Sender is TDBLookupComboBox then
    (Sender as TDBLookupComboBox).KeyValue:=jsonPair.JSONValue.Value
  else if Sender is TRadioGroup then
    (Sender as TRadioGroup).ItemIndex:=StrToInt(jsonPair.JSONValue.Value)
  else if Sender is TMemo then
    (Sender as TMemo).Text:=jsonPair.JSONValue.Value
  else
    raise Exception.Create('Errore durante la lettura del JSON, classe '+Sender.ClassName+' non gestita.');
end;

procedure R180ToolBarHandleNeeded(Sender: TWinControl);
var
  i: Integer;
begin
  for i:=0 to Sender.ControlCount - 1 do
  begin
    if Sender.Controls[i] is TToolbar then
      (Sender.Controls[i] as TToolbar).HandleNeeded
    else if Sender.Controls[i] is TWinControl then
      R180ToolBarHandleNeeded(Sender.Controls[i] as TWinControl);
  end;
end;

function R180NumOccorrenzeString(const Substring, Text: string): integer;
begin
  Result:=TFunzioniGenerali.NumOccorrenzeString(Substring,Text);
end;

// RTTI

function R180SetPropValue(PObject: TObject; PropertyName: String; PropertyValue: Variant): Boolean;
begin
  Result:=TFunzioniGenerali.SetPropValue(PObject,PropertyName,PropertyValue);
end;

function R180GetPropValue(PObject: TObject; PropertyName: String): Variant;
begin
  Result:=TFunzioniGenerali.GetPropValue(PObject,PropertyName);
end;

function R180AnonMethod2NotifyEvent(Owner: TComponent; Proc: TProc<TObject>): TNotifyEvent;
begin
  Result:=TNotifyEventWrapper.Create(Owner, Proc).Event;
end;

// Verifica se l'utente corrente è membro del gruppo degli amministratori.
function R180WinApiIsUserAnAdmin():BOOL; external 'shell32.dll' name 'IsUserAnAdmin';

// Utilizza i tipi di Delphi
function R180IsUserAnAdmin():Boolean;
begin
  Result:=R180WinApiIsUserAnAdmin;
end;

(*
function R180AnonMethod2Proc(Owner: TComponent; Proc: TProc): TProcObject;
begin
  Result:=TProcWrapper.Create(Owner, Proc).Proc;
end;
*)

//function R180GetActiveDirectoryUserInfo(const PDomain: string; const PUserAccountName: string; out RADUserInfo: TActiveDirectoryUserInfo): TResCtrl;
//type
//  TADsOpenObject   = function (lpszPathName: PWideChar; lpszUserName: PWideChar;
//    lpszPassword: PWideChar; dwReserved: DWORD; const riid: TGUID;
//    out pObject): HRESULT; stdcall;
//  TADsGetObject    = function(PathName: PWideChar; const IID: TGUID; out Void):
//    HRESULT; stdcall;
//var
//  LPathName: string;
//  LAdsLibHandle: THandle;
//  _LADsOpenObject: TADsOpenObject;
//  _LADsGetObject: TADsGetObject;
//  // strutture per cercare l'account utente attraverso lo username
//  LDirSearch: IDirectorySearch;
//  LSearchPrefs: array[0..1] of ADS_SEARCHPREF_INFO;
//  LColumns: array[0..0] of PWideChar;
//  LSearchRes: NativeUInt;
//  LStatus: HRESULT;
//  LColumnRes: ads_search_column;
//  // numero di utenti trovati
//  LRecordCount: Integer;
//  i: Integer;
//  LUser: IADSUser;
//  LFilter: string;
//const
//  ACTIVEDSDLL = 'activeds.dll';
//
//  // ADSI success codes
//  S_ADS_ERRORSOCCURRED = $00005011;
//  S_ADS_NOMORE_ROWS    = $00005012;
//  S_ADS_NOMORE_COLUMNS = $00005013;
//
//  // ADSI error codes
//  E_ADS_BAD_PATHNAME            = $80005000;
//  E_ADS_INVALID_DOMAIN_OBJECT   = $80005001;
//  E_ADS_INVALID_USER_OBJECT     = $80005002;
//  E_ADS_INVALID_COMPUTER_OBJECT = $80005003;
//  E_ADS_UNKNOWN_OBJECT          = $80005004;
//  E_ADS_PROPERTY_NOT_SET        = $80005005;
//  E_ADS_PROPERTY_NOT_SUPPORTED  = $80005006;
//  E_ADS_PROPERTY_INVALID        = $80005007;
//  E_ADS_BAD_PARAMETER           = $80005008;
//  E_ADS_OBJECT_UNBOUND          = $80005009;
//  E_ADS_PROPERTY_NOT_MODIFIED   = $8000500A;
//  E_ADS_PROPERTY_MODIFIED       = $8000500B;
//  E_ADS_CANT_CONVERT_DATATYPE   = $8000500C;
//  E_ADS_PROPERTY_NOT_FOUND      = $8000500D;
//  E_ADS_OBJECT_EXISTS           = $8000500E;
//  E_ADS_SCHEMA_VIOLATION        = $8000500F;
//  E_ADS_COLUMN_NOT_SET          = $80005010;
//  E_ADS_INVALID_FILTER          = $80005014;
//begin
//  Result.Clear;
//
//  // se il dominio non è specificato esce subito
//  if (PDomain = '') then
//  begin
//    Result.Messaggio:='il dominio non è stato specificato!';
//    Exit;
//  end;
//
//  // se il nome dell'account non è specificato esce subito
//  if (PUserAccountName = '') then
//  begin
//    Result.Messaggio:='il nome dell''account utente non è stato specificato!';
//    Exit;
//  end;
//
//  // path per la ricerca nel dominio
//  LPathName:=Format('LDAP://%s',[PDomain]);
//
//  // prepara i puntatori ai metodi esposti dalla dll
//  LAdsLibHandle:=LoadLibrary(ACTIVEDSDLL);
//  try
//    if LAdsLibHandle <> 0 then
//    begin
//      @_LADsOpenObject:=GetProcAddress(LAdsLibHandle, 'ADsOpenObject');
//      @_LADsGetObject:=GetProcAddress(LAdsLibHandle, 'ADsGetObject');
//    end
//    else
//    begin
//      Result.Messaggio:=Format('errore durante il caricamento dei metodi della libreria %s:'#13#10'%s'#13#10'%s',[ACTIVEDSDLL,'ADsOpenObject','ADsGetObject']);
//      Exit;
//    end;
//
//    try
//      // prepara array di proprietà da leggere
//      LColumns[0]:=StringToOleStr('AdsPath');
//  //    LColumns[1]:=StringToOleStr('displayName');
//  //    LColumns[2]:=StringToOleStr('mail');
//  //    LColumns[3]:=StringToOleStr('sAMAccountName');
//  //    LColumns[4]:=StringToOleStr('userPrincipalName');
//
//      // prepara l'oggetto "DirectorySearch"
//      _LADsGetObject(PWideChar(WideString(LPathName)), IDirectorySearch, LDirSearch);
//
//      // verifica che l'oggetto per la ricerca esista
//      if LDirSearch = nil then
//      begin
//        Result.Messaggio:=Format('ricerca dell''utente in Active Directory impossibile: verificare il dominio e i permessi di accesso',[]);
//        Exit;
//      end;
//
//      try
//        // imposta le preferenze di ricerca
//        LSearchPrefs[0].dwSearchPref:=ADS_SEARCHPREF_SEARCH_SCOPE;
//        LSearchPrefs[0].vValue.dwType:=ADSTYPE_INTEGER;
//        LSearchPrefs[0].vValue.Integer:=ADS_SCOPE_SUBTREE;
//        LDirSearch.SetSearchPreference(@LSearchPrefs[0], 1);
//
//        // effettua la ricerca utilizzando il SAM account name
//        //'(&(CN=*)(|(sAMAccountName=%0:s))'
//        LFilter:= Format('(&(sAMAccountName=%s))',[PUserAccountName]);
//        LDirSearch.ExecuteSearch(PWideChar(WideString(LFilter)), nil, $FFFFFFFF, LSearchRes);
//
//        // estrae i record corrispondenti
//        LRecordCount:=0;
//
//        LStatus:=LDirSearch.GetNextRow(LSearchRes);
//        if (LStatus <> S_ADS_NOMORE_ROWS) then
//        begin
//          // trovato (almeno) un record
//          Inc(LRecordCount);
//
//          // estrae le informazioni per la riga (appartenenti alle colonne definite)
//          for i:=Low(LColumns) to High(LColumns) do
//          begin
//            LStatus:=LDirSearch.GetColumn(LSearchRes, LColumns[i], LColumnRes);
//            if Succeeded(LStatus) then
//            begin
//              // utilizza il valore di AdsPath per estrarre le info dell'utente
//              if SameText(LColumnRes.pszAttrName,'AdsPath') then
//              begin
//                // estrae le informazioni dell'utente
//                LStatus:=_LADsGetObject(LColumnRes.pADsValues.CaseExactString, IADsUser, LUser);
//                if Succeeded(LStatus) then
//                begin
//                  RADUserInfo.User:=LUser.Name;
//                  RADUserInfo.FullName:=LUser.FullName;
//                  RADUserInfo.Email:=LUser.EmailAddress;
//                end;
//              end;
//
//              // distrugge il result
//              LDirSearch.FreeColumn(LColumnRes);
//            end;
//          end;
//
//          // l'account trovato deve essere univoco
//          // se LRecordCount risulta <> 1 --> errore
//          LStatus:=LDirSearch.GetNextRow(LSearchRes);
//          if (LStatus <> S_ADS_NOMORE_ROWS) then
//            Inc(LRecordCount);
//        end;
//
//        // chiude la ricerca
//        //LDirSearch.CloseSearchHandle(LSearchRes); // NO! Access violation!
//
//        // verifica il numero di record trovati
//        case LRecordCount of
//          0: Result.Messaggio:=Format('nessun account presente per l''utente "%s" in Active Directory',[PUserAccountName]);
//          1: Result.Ok:=True;
//        else
//          Result.Messaggio:=Format('sono stati trovati più account per l''utente "%s" in Active Directory',[PUserAccountName]);
//        end;
//      finally
//        LDirSearch:=nil;
//      end;
//    except
//      on E: Exception do
//      begin
//        // errore di esecuzione
//        Result.Messaggio:=Format('lettura dei dati dell''account "%s" fallita: %s (%s)',
//                                 [PUserAccountName,E.Message,E.ClassName]);
//      end;
//    end;
//  finally
//    FreeLibrary(LAdsLibHandle);
//  end;
//end;

procedure R180OracleObjectSource(const PObjName: String; POracleSession: TOracleSession; var RResultList: TStringList);
var
  LOQ: TOracleQuery;
begin
  if PObjName.Trim = '' then
    raise Exception.Create('L''oggetto oracle di cui visualizzare il sorgente non è stato indicato!');

  if RResultList = nil then
    raise Exception.Create('Non è stata indicata la stringlist per contenere il risultato!');

  RResultList.Clear;

  LOQ:=TOracleQuery.Create(nil);
  try
    LOQ.Session:=POracleSession;
    LOQ.ReadBuffer:=500;
    LOQ.SQL.Add('select V.TEXT ');
    LOQ.SQL.Add('from   USER_SOURCE V ');
    LOQ.SQL.Add('where  V.NAME = :NAME ');
    LOQ.SQL.Add('order by V.LINE ');
    LOQ.DeclareAndSet('NAME',otString,PObjName);
    LOQ.Execute;
    while not LOQ.Eof do
    begin
      RResultList.Add(LOQ.FieldAsString('TEXT').Replace(#13#10,'',[rfReplaceAll]));
      LOQ.Next;
    end;
  finally
    FreeAndNil(LOQ);
  end;
end;

{$IFDEF IRISWEB}{$IFNDEF WEBSVC}
(*
 * Funzione che testa se una stringa contiene una possibile injection
 * Parametri:
 *  Stringa: Stringa da verificare
 *  InjTypes: Tipologia di filtro da applicare XSS o SQL injection
 *  SendExcept: Se la stringa risulta malevola solleva un'eccezzione
 * Valori di ritorno
 *  True: La stringa contiene caratteri non validi, ed è quindi da scartare
 *  False: Se la stringa è adeguata
 *)
function R180VerificaStringaPerInjection(Stringa:String; InjTypes: TStringFilterType = injXSS; SendExcept:Boolean = False):Boolean;
var
  i:Integer;
begin
  Result:=False;
  if Stringa = '' then
    Exit;
  for i:=Low(FILTRI_INJECTION) to High(FILTRI_INJECTION) do
    begin
      if FILTRI_INJECTION[i].Enable and (InjTypes in FILTRI_INJECTION[i].InjTypes) then
      begin
        Result:=TRegEx.IsMatch(Stringa, FILTRI_INJECTION[i].Role, [roIgnoreCase]);
        if Result then
        begin
          if SendExcept then
            raise ETentativoXSSException.Create(Format('Stringa con contenuto non valido in base alla regola "%s"', [FILTRI_INJECTION[i].Description]));
          Break;
        end;
      end;
    end;
end;

(*
 * Funzione che ripulisce eventuali injection malevole dalla stringa passata come parametro
 * Parametri:
 *  Stringa: Stringa da verificare
 *  InjTypes: Tipologia di filtro da applicare XSS o SQL injection
 *  Sostituzione: Stringa da utilizzare durante la sostituzione
 * Valore di ritorno
 *  Stringa ripulita dalle parti malevole
 *)
function R180PulisciStringaPerInjection(Stringa:String; InjTypes: TStringFilterType = injXSS; Sostituzione:String = ''):String;
var
  i:Integer;
begin
  Result:=Stringa;
  if Result <> '' then
  begin
    for i:=Low(FILTRI_INJECTION) to High(FILTRI_INJECTION) do
    begin
      if FILTRI_INJECTION[i].Enable and (InjTypes in FILTRI_INJECTION[i].InjTypes) then
      begin
        while TRegEx.IsMatch(Result, FILTRI_INJECTION[i].Role, [roIgnoreCase]) do
        begin
          Result:=TRegex.Replace(Result, FILTRI_INJECTION[i].Role, Sostituzione, [roIgnoreCase]);
        end;
      end;
    end;
  end;
end;
{$ENDIF WEBSVC}{$ENDIF IRISWEB}

end.


