unit OldC180FunzioniGenerali;

interface

uses
  A000UCostanti, A000UMessaggi,
  SysUtils, StrUtils, Vcl.Graphics, Registry, db, classes,
  Vcl.Controls, Vcl.CheckLst, Vcl.Forms, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls,
  Vcl.Clipbrd, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.Mask,
  Vcl.Dialogs, Vcl.ExtCtrls,
  Oracle, OracleData, System.Math, Windows, Variants, WinSvc,
  DCPcrypt2, DCPsha1, uUtilsCrypto, IdCoderMIME, IdGlobal, IdHashMessageDigest,
  DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF}
  System.IOUtils, System.Types;

type
  TAnnoInt   = 1900..3999;
  TMeseInt   = 1..12;
  TGiornoInt = 1..31;

const
  CR                     = #13;
  LF                     = #10;
  CRLF                   = #13#10;
  TAB                    = #9;
  SPACE                  = #32;
  SPAZI_SET              = [LF,CR,SPACE];
  DATE_NULL: TDateTime   = 0;                 // 30/12/1899
  DATE_MIN : TDateTime   = 2;                 // 01/01/1900
  DATE_MAX : TDateTime   = 767010;            // 31/12/3999
  SPECIAL_CHAR           = '!%&/()=@#-_*';
  ORACLE_MAX_IN_VALUES   = 1000;
  C700NEO_ASSUNTO        = $0055AA00;

procedure OldR180InvertiSelezioneCheckList(MyCheckListBox:TCheckListBox);
procedure OldR180PutCheckList(S:String; L:Word; CL:TCheckListBox; Separator:char=',');
function  OldR180GetCheckList(L:Word; CL:TCheckListBox; Separator:char=','):String;
function  OldR180RadioGroupButton(RG: TRadioGroup; I: Integer): TRadioButton;
function  OldR180CalcolaCIN(ABI,CAB,CC:String):String;
function  OldR180CalcolaCINEuropa(ABI,CAB,CC,CinItalia,CodNazione:String):String;
function  OldR180CheckIban(IBAN: String): Boolean;
function  OldR180IndexOf(L:TStrings; S:String; NC:Word):Integer;
function  OldR180IndexFromValue(L:TStrings; Value:String):Integer;
function  OldR180OreMinuti(Ora:TDateTime):Word; overload;
function  OldR180OreMinuti(Ora:Variant):Word; overload;
function  OldR180OreMinuti(Ora:String):LongInt; overload;
function  OldR180OreMinutiExt(Ora:String):LongInt;
function  OldR180MinutiOre(Minuti:LongInt; const PTimeSeparator: Char = '.'):String;
function  OldR180GiorniMese(Data:TDateTime):Byte;
function  OldR180InizioMese(Data:TDateTime):TDateTime;
function  OldR180FineMese(Data:TDateTime):TDateTime;
function  OldR180InizioMeseSettimanale(Data:TDateTime; UltimaSettInterna:Boolean):TDateTime;
function  OldR180FineMeseSettimanale(Data:TDateTime; UltimaSettInterna:Boolean):TDateTime;
function  OldR180AddMesi(Data:TDateTime; Mesi:Integer; MantieniFineMese:Boolean = False):TDateTime;
procedure OldR180SpostaPeriodo(DalOld,AlOld:TDateTime;Avanti,Contiguo:Boolean;var DalNew,AlNew:TDateTime);
function  OldR180Anno(Data:TDateTime):Word;
function  OldR180Mese(Data:TDateTime):Word;
function  OldR180Giorno(Data:TDateTime):Word;
function  OldR180SettimanaAnno(Data:TDateTime; IniziaDomenica:Boolean = True):Integer;
function  OldR180StrToDateFmt(Data,Formato:String):TDateTime;
function  OldEsisteApice(Value:String):Boolean;
function  OldAggiungiApice(Value:String):String;
function  OldAggiungiApiceDoppio(Value:String):String;
function  OldR180Centesimi(Minuti:Longint):String;
function  OldR180CarattereDef(const S:String; N:Word = 1; D:Char = #0):Char;
function  OldR180Spaces(S:String; L:Word):String;
function  OldR180EliminaSpaziMultipli(const Val: String): String;
function  OldR180GetValore(S,P,A:String; var Valore:String):Boolean;
function  OldR180GetFontStyle(FS:String):TFontStyles;
function  OldR180DimLung(S:String; D:Integer):String;
function  OldR180LPad(const PStr:String; PNumCaratteri:Integer; PCarattere:char):String;
function  OldR180RPad(const PStr:String; PNumCaratteri:Integer; PCarattere:char):String;
function  OldR180ElencoGiorni(Inizio,Fine:TDateTime; Formato:String):String;
function  OldR180ElencoMesi(Inizio,Fine:TDateTime; Formato:String):String;
procedure OldR180AppendFile(const NomeFile,Testo:String);
procedure OldR180AppendFileNoCR(const NomeFile,Testo:String);
function  OldR180NomeMese(Num:Byte):String;
function  OldR180NomeMeseAnno(D: TDateTime): String;
function  OldR180NomeGiorno(Anno,Mese,Giorno:Word):String; overload;
function  OldR180NomeGiorno(D:TDateTime):String; overload;
function  OldR180NomeGiornoSett(GiornoSettimana:Word):String;
function  OldIdentificatore(const Nome:String):String;
function  OldEliminaRitornoACapo(Testo : String) : String;
function  OldCalcolaPasqua(Anno:Integer):TDateTime;
function  OldFestivo(Giorno,Mese,Anno:Integer):Boolean;
function  OldR180ArrotondaMinuti(Valore,Arrotondamento:Integer):Integer;
function  OldR180Decripta(S:String; Key:LongInt):String;
function  OldR180Cripta(S:String; Key:LongInt):String;
function  OldR180CriptaI070(Password:string):string;
function  OldR180DecriptaI070(Password:string):string;
function  OldR180DimLungR(S:String; D:Integer):String;
function  OldR180InserisciColonna(var S:String; const C:String):Boolean;
function  OldR180InConcat(const Parola,Stringa:String):Boolean;
function  OldR180CercaParolaIntera(const Parola,Stringa,CaratteriSeparazione:String):Integer;
function  OldR180NumOccorrenzeCar(S:String; C:Char):Integer;
function  OldR180NumOccorrenzeString(const Substring, Text: string): integer;
procedure OldR180PutRegistro(Root:HKEY; const Chiave,Dato,Valore:String);
function  OldR180GetRegistro(Root:HKEY; const Chiave,Dato,Def:String):String;
function  OldR180ScriviMsgLog(const FileLog,Msg:String):Boolean;
function  OldR180GetEnvVarValue(const VarName: string): string;
function  OldR180SetEnvVarValue(const VarName, VarValue: string): Integer;
procedure OldR180SetOracleInstantClient;
procedure OldR180OraValidate(S:String);
function  OldOreMinutiValidate(Valore:String): Boolean;
procedure OldR180ClearDBEditDateTime(Sender:TObject);
function  OldR180StrToGiorniOre(Valore,UM:String):Real;
function  OldR180GiorniOreToStr(Valore:Real; UM:String; Formato:String=''):String;
function  OldR180GetFilePath(S:String; EndSlash:Boolean = False):String;
function  OldR180GetFileName(S:String):String;
function  OldR180GetFileSize(const PFileName:String): Int64;
function  OldR180GetFileSizeStr(const PSizeInBytes: Int64): String; overload;
function  OldR180GetFileSizeStr(const PFileName:String): String; overload;
function  OldR180FileToByteArray(const PFileName: String): TByteDynArray;
procedure OldR180ByteArrayToFile(const PByteArr: TByteDynArray; const PFileName: String);
function  OldR180GetCampiConcatenati(D:TDataSet; C:TStringList):String;
function  OldR180EstraiNomeTabella(SqlText:string):string;
function  OldR180Query2NomeTabella(DS:TDataSet):string;
function  OldR180Arrotonda(Dato,Valore:Real; Tipo:String): Real;
function  OldR180AzzeraPrecisione(Dato:Real; NumDec:Integer): Real;
function  OldR180Formatta(Dato:Real; NumCrt,NumDec:Integer):String;
function  OldR180CifreDecimali(Dato:Real):Byte;
function  OldR180FormattaNumero(S,F:String):String;
function  OldR180FormattaNumeroSoloDec(S,F:String):String;
function  OldR180IsDigit(const PStr: String; PIndex: Integer): Boolean; overload;
function  OldR180IsDigit(const PChr: Char): Boolean; overload;
function  OldR180IsNumeric(S:String):Boolean;
function  OldR180IsSpecialChar(const PChr: Char): Boolean;
function  OldR180EliminaZeriASinistra(S:String):String;
function  OldR180ControllaPeriodo(const PDataInizio, PDataFine: String; var RDataInizio, RDataFine: TDateTime; var Err: String): Boolean; overload;
function  OldR180ControllaPeriodo(const PDataInizio: String; const PNumeroGiorni: Integer; var RDataInizio, RDataFine: TDateTime; var Err: String): Boolean; overload;
function  OldR180ControllaPeriodo(const PDataInizio, PDataFine: TDateTime; var Err: String): Boolean; overload;
function  OldR180MessageBox(const Messaggio, Tipo: String; const Titolo: String = ''; const KeyID: String = ''): Integer;
function  OldR180Values(S:String):String;
function  OldR180NomeFileDatato(NomeFile,Formato:String; Data:TDateTime):String;
function  OldR180EstraiExtFile(S:String):String;
function  OldR180GetOracleRelease(ss:TOracleSession):String;
procedure OldR180InizializzaArray(var Vettore:array of Integer; Valore:Integer = 0); overload;
procedure OldR180InizializzaArray(var Vettore:array of Real; Valore:Real = 0); overload;
function  OldR180SommaArray(Vettore:array of Integer):Integer; overload;
function  OldR180SommaArray(Vettore:array of Real):Real; overload;
function  OldR180SysDate(Sessione:TOracleSession):TDateTime;
function  OldR180AttivaHintSQL(SQL:String; VersioneOracle:Integer):String;
function  OldR180NumeroInLettere(Sessione:TOracleSession; Numero:Real):String;
function  OldR180LunghezzaCampo(F:TField):Integer;
procedure OldR180DBGridCopyToClipboard(DBGrid:TDBGrid; CopyToExcel:Boolean; RigheSelezionate:Boolean = True; Intestazione:Boolean = True; NoACapo:Boolean = False);
procedure OldR180StringGridCopyToClipboard(StringGrid:TStringGrid);
function  OldR180IncollaTestoDaClipboard(Testo:String;InizioSelezione,LunghezzaSelezione:Integer):String;
procedure OldR180DBGridSelezionaRighe(DBGrid:TDBGrid; Modo:Char);
function  OldR180GetColonnaDBGrid(DBGrid:TDBGrid; Campo:String):Integer;
function  OldR180FormatiCodificati(Dato,Formato:String;Lung:integer=0):String;
function  OldR180FormattaValoreLike(sValore:String):String;
procedure OldR180AbilitaOggetti(C:TWinControl; Abilitato:Boolean);
function  OldR180GetStringList(DataSet:TDataSet; Colonne:String):String;
function  OldR180In(const Valore:String; lstValori:array of String):Boolean; overload;
function  OldR180In(const Valore:Integer; lstValori:array of Integer):Boolean; overload;
function  OldR180In(const Valore:TObject; lstValori:array of TObject):Boolean; overload;
function  OldR180Between(const Valore,Da,A:String):Boolean; overload;
function  OldR180Between(const Valore,Da,A:Integer):Boolean; overload;
function  OldR180Between(const Valore,Da,A:TDateTime):Boolean; overload;
function  OldR180Indenta(const PTesto: String; const PIndentazione: Integer): String;
function  OldR180Sha1Encrypt(const PStr: String): String;
function  OldR180RDL_ECB_Decrypt(const PStr,PPassPhrase: String): String;
function  OldR180RDL_ECB_Encrypt(const PStr,PPassPhrase: String): String;
function  OldR180SSO_TokenUsr(Utente,Mask:String):String;
function  OldR180SetVariable(ODS:TOracleDataset; Variabile:String; Valore:Variant):Boolean;
function  OldR180CloseDataSetTag0(DS: TDataset; const DistruggiFields: Boolean = False): Boolean;
function  OldR180Capitalize(const PTesto: String): String;
function  OldR180SplittaArray(Const InStringa, Separatore:String):TArrString;
procedure OldR180Tokenize(const Lista: TStrings; const Value: String; const Delimiter: String = ',');
procedure OldR180SplitLines(Lista: TStrings; BreakSet: TSysCharSet = [' ',',']; MaxCol: Integer = 2000);
function  OldR180GetOSTempDir: String;
procedure OldR180RemoveDir(const DirName: string);
function  OldR180IsDirectoryWritable(const PDirName: String): Boolean;
function  OldR180InserisciAliasT030(const StrSql: String): String;
function  OldR180GetIPFromHost(var HostName, IPaddr, WSAErr: String): Boolean;
function  OldR180GetServicePath(strServiceName: string; strMachine: string = ''): String;
function  OldR180CalcoloCodiceFiscale(Cognome,Nome,Sesso,CodCat:String; DataNas:TDateTime):String;
function  OldR180SostituisciCaratteriSpeciali(Testo:String):String;
procedure OldR180SetComboItemsValues(lst:TStrings; ItemsValues:array of TItemsValues; TipoLista:String);
function  OldR180GetCsvIntersect(const PElenco1, PElenco2: String): String;
procedure OldR180StringListIntersect(PList1, PList2: TStringList; var RListIntersect: TStringList);
procedure OldR180JsonString2Comp(Sender: TComponent; JsonPair: TJSONPair);
function  OldR180getCaptionTipologia(TipoQuota: String) : String;

//XE4
procedure OldR180DBGridSetDrawingStyle(Sender:TComponent);
procedure OldR180ToolBarHandleNeeded(Sender: TWinControl);

// RTTI
function  OldR180SetPropValue(PObject: TObject; PropertyName: String; PropertyValue: Variant): Boolean;
function  OldR180GetPropValue(PObject: TObject; PropertyName: String): Variant;

// costanti
const
  // messagebox
  INFORMA           = 'INFORMA';           // icona info     + pulsante OK
  DOMANDA           = 'DOMANDA';           // icona question + pulsanti Si, No
  DOMANDA_ESCI      = 'DOMANDA_ESCI';      // icona question + pulsanti Si, No, Annulla
  ERR_ELAB_CONTINUA = 'ERR_ELAB_CONTINUA'; // icona warning  + pulsanti Si, No, Termina
  ERR_ELAB_STOP     = 'ERR_ELAB_STOP';     // icona warning  + pulsanti Ignora, Termina
  ERR_ELAB_TERMINA  = 'ERR_ELAB_TERMINA';  // icona warning  + pulsante Termina
  ESCLAMA           = 'ESCLAMA';           // icona warning  + pulsante OK
  ERRORE            = 'ERRORE';            // icona error    + pulsante OK
  // win admin
  SECURITY_NT_AUTHORITY: TSIDIdentifierAuthority = (Value: (0, 0, 0, 0, 0, 5)) ;
  SECURITY_BUILTIN_DOMAIN_RID = $00000020;
  DOMAIN_ALIAS_RID_ADMINS = $00000220;

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

function OldR180getCaptionTipologia(TipoQuota: String) : String;
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

function OldR180GetOracleRelease(ss:TOracleSession):String;
begin
  try
    Result:=trim(copy(ss.ServerVersion,Pos('release',LowerCase(ss.ServerVersion)) + Length('Release')));
    Result:=Copy(StringReplace(Result,'.','',[RFREPLACEALL]),1);
  except
    Result:='';
  end;
end;

function OldR180GetServicePath(strServiceName: string; strMachine: string = ''): String;
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

// G E S T I O N E   I B A N
function OldR180CalcolaCIN(ABI,CAB,CC:String):String;
{Dato un ABI, CAB e conto corrente, calcola il CIN Italia}
const Numeri:String = '0123456789';
      Lettere:String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
      LisPari:array[0..25]of Integer =
      (0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);
      LisDisp:array[0..25]of Integer =
      (1,0,5,7,9,13,15,17,19,21,2,4,18,20,11,3,6,8,12,14,16,10,22,25,24,23);
var BBAN,Aus,Ret:String;
    i,j,Sum:Integer;
    Errore:Boolean;
  function Normalizza(Val:String;Dim:Integer):String;
  var i:Integer;
      Ret:String;
  begin
    Val:=Trim(Val);
    for i:=Length(Val)+1 to Dim do
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

  if Length(BBAN) > 22 then
    Errore:=True;

  Sum:=0;
  for i:=1 to Length(BBAN) do
  begin
    Aus:=copy(BBAN,i,1);

    j:=pos(Aus,Numeri);
    if j <= 0 then
      j:=pos(Aus,Lettere);
    if j > 0 then
      if (i mod 2) = 0 then
        Sum:=Sum + LisPari[j-1]
      else
        Sum:=Sum + LisDisp[j-1]
    else
      Errore:=True;
  end;
  if Not(Errore) then
    Ret:=copy(Lettere,(Sum mod 26) + 1,1)
  else
    Ret:='';
  Result:=Ret;
end;

function OldR180CalcolaCINEuropa(ABI,CAB,CC,CinItalia,CodNazione:String):String;
const ValoreOriginale:array[0..35] of char =
      ('0','1','2','3','4','5','6','7','8','9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');
      ValoreDecodificato:array[0..35] of String =
      ('0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35');
var   IBANInvertito,IBANNumerico,S:String;
      I,J,Resto:Integer;
      TrovatoValore,Errore:Boolean;
  function Normalizza(Val:String;Dim:Integer):String;
  var i:Integer;
      Ret:String;
  begin
    Val:=Trim(Val);
    for i:=Length(Val)+1 to Dim do
      Ret:=Ret + '0';
    Result:=Ret + Val;
  end;
begin
  Errore:=False;
  if (ABI = '') or (CAB = '') or (CC = '') or (CinItalia = '') or (CodNazione = '') then
    Errore:=True;

  ABI:=Normalizza(ABI,5);
  CAB:=Normalizza(CAB,5);
  CC:=Normalizza(UpperCase(CC),12);
  IBANInvertito:=CinItalia+ABI+CAB+CC+CodNazione+'00';
  TrovatoValore:=False;
  for I:=1 to Length(IBANInvertito) do
  begin
    TrovatoValore:=False;
    for J:=0 to 35 do
      if IBANInvertito[I] = ValoreOriginale[J] then
      begin
        IBANNumerico:=IBANNumerico+ValoreDecodificato[J];
        TrovatoValore:=True;
        break;
      end;
    if not TrovatoValore then
      break;
  end;
  if (TrovatoValore) and (not Errore) then
  begin
    S:=IBANNumerico;
    Resto:=0;
    while Length(S) > 0 do
    begin
      Resto:=StrToInt(Copy(S,1,8)) mod 97;
      if Length(S) > 8 then
        S:=IntToStr(Resto)+Copy(S,9)
      else
        S:='';
    end;
    Result:=Format('%.2d',[(98-Resto) mod 97]);
  end
  else
    Result:='';
end;

function OldR180CheckIban(IBAN: string): Boolean;
  function ChangeAlpha(input: string): string;
  var
    a: Char;
  begin
    Result:=input;
    for a:='A' to 'Z' do
    begin
      Result:=StringReplace(Result,a,IntToStr(Ord(a) - 55),[rfReplaceAll]);
    end;
  end;

  function CalculateDigits(IBAN: String): Integer;
  var
    v, l: Integer;
    alpha: String;
    number: Longint;
    resto: Integer;
  begin
    IBAN:=UpperCase(IBAN);
    IBAN:=IBAN + Copy(IBAN,1,4);
    Delete(IBAN,1,4);
    IBAN:=ChangeAlpha(IBAN);
    v:=1;
    l:=9;
    resto:=0;
    alpha:='';
    try
      while v <= Length(IBAN) do
      begin
        if l > Length(IBAN) then
          l:=Length(IBAN);
        alpha:=alpha + Copy(IBAN,v,l);
        number:=StrToInt(alpha);
        resto:=number mod 97;
        v:=v + l;
        alpha:=IntToStr(resto);
        l:=9 - Length(alpha);
      end;
    except
      resto:=0;
    end;
    Result:=resto;
  end;
begin
  IBAN:=StringReplace(IBAN,' ','',[rfReplaceAll]);
  Result:=CalculateDigits(IBAN) = 1;
end;

function OldR180FormattaValoreLike(sValore:String):String;
//Indicare il valore del campo like comprendente le i Wildchars
//Es.: '%VALORE%'
begin
  if Pos('_', sValore) > 0 then
    sValore:=StringReplace(sValore,'_','\_',[rfReplaceAll]);
  Result:=sValore;
end;

(*function OldR180EstraiProgressivoC700(C700SqlText:String; C700Progressivo:integer):String;
//ESEMPIO DI UTILIZZO...
//    MiaStringa:='AND PROGRESSIVO in ' + R180EstraiProgressivoC700(C700SelAnagrafe.SQL.Text,C700Progressivo);
//    MioDataset.SetVariable('progressivo', MiaStringa);
//    if MioDataset.VariableIndex('DATALAVORO')>-1 then
//      MioDataset.DeleteVariable('DATALAVORO');
//    if Pos(':DATALAVORO',UpperCase(MiaStringa)) > 0 then
//    begin
//      MioDataset.DeclareVariable('DATALAVORO',otDate);
//      MioDataset.SetVariable('DATALAVORO',Parametri.DataLavoro);
//    end;
var
  sSelAnagrafico:String;
begin
  Result:='';
  //Leggo il progressivo filtrato dalla C700
  sSelAnagrafico:=C700SqlText;
  //Considero la parte di istruzione SQL dal FROM in poi...
  sSelAnagrafico:=Copy(sSelAnagrafico, Pos('FROM', UpperCase(sSelAnagrafico)), length(sSelAnagrafico));
  //Elimino eventuali ORDER BY...
  if Pos('ORDER BY', UpperCase(sSelAnagrafico)) > 0 then
    sSelAnagrafico:=Copy(sSelAnagrafico, 1, Pos('ORDER BY', UpperCase(sSelAnagrafico))-1);
  sSelAnagrafico:= '(SELECT PROGRESSIVO ' + sSelAnagrafico + ')';
  //Se nella stringa SelAnagrafico trovo ":PROGRESSIVO" significa che non ho filtrato tramite la lente ed allora
  //sostituisco :PROGRESSIVO con la variabile pubblica P700FDialogStampa.Progressivo
  if Pos(':PROGRESSIVO', sSelAnagrafico) > 0 then
    sSelAnagrafico:= StringReplace(sSelAnagrafico, ':PROGRESSIVO', inttostr(C700Progressivo), [rfReplaceAll, rfIgnoreCase]);
  Result:=sSelAnagrafico;
end;*)

function OldR180ControllaPeriodo(const PDataInizio, PDataFine: String; var RDataInizio, RDataFine: TDateTime; var Err: String): Boolean;
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
//   OldR180ControllaPeriodo('02/08/2014','31/09/2014')
//   -> controlla la validit� delle date espresse in stringa e la correttezza del periodo
//      in questo caso restituisce False (la data finale � errata)
var
  LInizio, LFine: TDateTime;
begin
  // 1. determina le date del periodo in base ai parametri
  // inizializzazione variabili
  Result:=False;
  RDataInizio:=DATE_NULL;
  RDataFine:=DATE_NULL;

  // data inizio periodo
  if Trim(PDataInizio) = '' then
  begin
    // data inizio vuota
    LInizio:=DATE_MIN;
  end
  else
  begin
    // data inizio indicata: verifica formato
    if not TryStrToDate(PDataInizio,LInizio) then
    begin
      Err:=A000MSG_ERR_DATA_INIZIO_PERIODO; //A000TraduzioneStringhe(A000MSG_ERR_DATA_INIZIO_PERIODO);
      Exit;
    end;
  end;

  // data fine periodo
  if Trim(PDataFine) = '' then
  begin
    // data fine vuota
    LFine:=DATE_MAX;
  end
  else
  begin
    // data fine indicata: verifica formato
    if not TryStrToDate(PDataFine,LFine) then
    begin
      Err:=A000MSG_ERR_DATA_FINE_PERIODO; //A000TraduzioneStringhe(A000MSG_ERR_DATA_FINE_PERIODO);
      Exit;
    end;
  end;

  // 2. controlla il periodo
  Result:=OldR180ControllaPeriodo(LInizio,LFine,Err);
  if Result then
  begin
    RDataInizio:=LInizio;
    RDataFine:=LFine;
  end;
end;

function OldR180ControllaPeriodo(const PDataInizio: String; const PNumeroGiorni: Integer; var RDataInizio, RDataFine: TDateTime; var Err: String): Boolean;
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
//   OldR180ControllaPeriodo('10/04/2014',18)
//   -> controlla la correttezza del periodo 10/04/2014 - 27/04/2014
//      in questo caso restituisce True
var
  LInizio, LFine: TDateTime;
begin
  // 1. determina le date del periodo in base ai parametri
  // inizializzazione variabili
  Result:=False;
  RDataInizio:=DATE_NULL;
  RDataFine:=DATE_NULL;

  // data inizio periodo
  if Trim(PDataInizio) = '' then
  begin
    // data inizio vuota
    LInizio:=DATE_MIN;
  end
  else
  begin
    // data inizio indicata: verifica formato
    if not TryStrToDate(PDataInizio,LInizio) then
    begin
      Err:=A000MSG_ERR_DATA_INIZIO_PERIODO; //A000TraduzioneStringhe(A000MSG_ERR_DATA_INIZIO_PERIODO);
      Exit;
    end;
  end;

  // il numero di giorni deve essere almeno pari a 1 (1 giorno totale)
  if PNumeroGiorni < 1 then
  begin
    Err:=A000MSG_ERR_PERIODO_ERRATO; //A000TraduzioneStringhe(A000MSG_ERR_PERIODO_ERRATO);
    Exit;
  end;

  // calcola data fine periodo
  LFine:=LInizio + (PNumeroGiorni - 1);

  // 2. controlla il periodo
  Result:=OldR180ControllaPeriodo(LInizio,LFine,Err);
  if Result then
  begin
    RDataInizio:=LInizio;
    RDataFine:=LFine;
  end;
end;

function OldR180ControllaPeriodo(const PDataInizio, PDataFine: TDateTime; var Err: String): Boolean;
// function che effettua i controlli standard su un periodo indicato
// nota: la funzione controlla che le date siano entrambe indicate
begin
  Result:=False;

  // 1. data inizio periodo
  // controlla validit� nel range convenzionale
  if (PDataInizio < DATE_MIN) or (PDataInizio > DATE_MAX) then
  begin
    Err:=A000MSG_ERR_DATA_INIZIO_PERIODO; //A000TraduzioneStringhe(A000MSG_ERR_DATA_INIZIO_PERIODO);
    Exit;
  end;
  // controlla indicazione data
  // la data inizio � considerata "vuota" se � uguale a DATE_NULL oppure a DATE_MIN
  if (PDataInizio = DATE_NULL) or (PDataInizio = DATE_MIN) then
  begin
    Err:=A000MSG_ERR_DATA_INIZIO_PERIODO_VUOTA; //A000TraduzioneStringhe(A000MSG_ERR_DATA_INIZIO_PERIODO_VUOTA);
    Exit;
  end;

  // 2. data fine periodo
  // controlla validit� nel range convenzionale
  if (PDataFine < DATE_MIN) or (PDataFine > DATE_MAX) then
  begin
    Err:=A000MSG_ERR_DATA_FINE_PERIODO; //A000TraduzioneStringhe(A000MSG_ERR_DATA_FINE_PERIODO);
    Exit;
  end;
  // controlla indicazione data
  // la data fine � considerata "vuota" se � uguale a DATE_NULL oppure a DATE_MAX
  if (PDataFine = DATE_NULL) or (PDataFine = DATE_MAX) then
  begin
    Err:=A000MSG_ERR_DATA_FINE_PERIODO_VUOTA; //A000TraduzioneStringhe(A000MSG_ERR_DATA_FINE_PERIODO_VUOTA);
    Exit;
  end;

  // 3. controlla consecutivit� periodo
  if PDataInizio > PDataFine then
  begin
    Err:=A000MSG_ERR_PERIODO_ERRATO; //A000TraduzioneStringhe(A000MSG_ERR_PERIODO_ERRATO);
    Exit;
  end;

  // periodo ok
  Result:=True;
end;

function OldR180MessageBox(const Messaggio, Tipo: String; const Titolo: String = '';
  const KeyID: String = ''): Integer;
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
    // se l'elaborazione non � su thread separato ma l'interazione prevede
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
          // la discriminante � che i pulsanti siano 1 oppure > 1
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

procedure OldR180InvertiSelezioneCheckList(MyCheckListBox:TCheckListBox);
var
  i:integer;
begin
  if MyCheckListBox.Count <= 0 then
    Exit;
  for i:=0 to MyCheckListBox.Count - 1 do
    MyCheckListBox.Checked[i]:=Not MyCheckListBox.Checked[i];
end;

procedure OldR180PutCheckList(S:String; L:Word; CL:TCheckListBox; Separator:char=',');
var Lista:TStringList;
    i,j,indice:Integer;
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

function OldR180GetCheckList(L:Word; CL:TCheckListBox; Separator:char=','):String;
var i:Integer;
begin
  Result:='';
  for i:=0 to CL.Items.Count - 1 do
    if CL.Checked[i] then
    begin
      if Result <> '' then
        Result:=Result + Separator;
      Result:=Result + Trim(Copy(CL.Items[i],1,L));
    end;
end;

function OldR180RadioGroupButton(RG: TRadioGroup; I: Integer): TRadioButton;
begin
  if (I < 0) or (I >= RG.Items.Count) then
  begin
    Result:=nil;
    Exit;
  end;
  Result:=(RG.Controls[I] as TRadioButton);
end;

function OldR180IndexOf(L:TStrings; S:String; NC:Word):Integer;
var i:Integer;
begin
  Result:=-1;
  for i:=0 to L.Count - 1 do
    if Trim(Copy(L[i],1,NC)) = Trim(S) then
    begin
      Result:=i;
      Break;
    end;
end;

function OldR180IndexFromValue(L:TStrings; Value:String):Integer;
var i:Integer;
begin
  Result:=-1;
  for i:=0 to L.Count - 1 do
    if L.ValueFromIndex[i] = Value then
    begin
      Result:=i;
      Break;
    end;
end;

function OldEsisteApice(Value: String): Boolean;
begin
  Result:=Pos('''',Value) > 0;
end;

function OldAggiungiApice(Value:String):String;
begin
  Result:=StringReplace(Value,'''','''''',[rfReplaceAll]);
end;

function OldAggiungiApiceDoppio(Value: String): String;
var I,J,Z : Integer;
begin
  Result:=Value;
  if OldEsisteApice(Value) then
  begin
    I:=1;
    J:=1;
    while I <= Length(Value) do
    begin
      if Value[I] <> '''' then
        Result[J]:= Value[I]
      else
      begin
        SetLength(Result,Length(Result)+1);
        Result[J]:=Value[I];
        for Z:=1 to 1 do
        begin
          J:=J + 1;
          Result[J]:=Value[I];
        end;
      end;
      I:=I + 1;
      J:=J + 1;
    end;
  end;
end;

// ----------   F U N Z I O N I   P E R   O R E / M I N U T I   ----------------
function OldR180Centesimi(Minuti:LongInt):String;
//Dati i minuti, restituisce la stringa nel formato hh:mm
// con i minuti espressi in centesimi.
var Ore:Word;
    Min : Word;
    OreS,MinS:String;
    L:Byte;
begin
  Ore:=Abs(Minuti) div 60;
  Min:=Abs(Minuti) mod 60;
  Min:=round((Min * 100) / 60);
  OreS:=IntToStr(Ore);
  //Calcolo la lunghezza delle ore
  L:=Length(OreS);
  if L = 1 then inc(L);
  MinS:=FloatToStr(Min);
  Result:=Copy('0' + OreS,Length(OreS) + 2 - L,L) + '.' + Copy('0' + MinS,Length(MinS),2);
  if Minuti < 0 then
    Result:='-' + Result;
end;

function OldR180OreMinuti(Ora:TDateTime):Word;
{Data un 'ora del giorno in TDateTime, la converte in Minuti}
var Hour,Min,Sec,MSec:Word;
begin
  DecodeTime(Ora, Hour, Min, Sec, MSec);
  Result:=Hour * 60  + Min;
end;

function OldR180OreMinuti(Ora:Variant):Word;
{Data un 'ora del giorno in Variant (Data o Stringa), la converte in Minuti}
begin
  if VarIsStr(Ora) then
    Result:=OldR180OreMinuti(VarToStr(Ora))
  else
    Result:=OldR180OreMinuti(VarToDateTime(Ora));
end;

function OldR180OreMinuti(Ora:String):LongInt;
// Data un'ora in formato stringa, la converte in Minuti
// L'ora pu� avere i seguenti formati:
// - [-]hhhh[.|:|,]mm           | es. 134.59, 18.36, -20:50
// - [-]hhhh[.|:|,]mm[.|:|,]ss  | es. 134.59.00, 18.36.00, -20:50:00
// Da usare quando si hanno pi� di 23 ore e quindi non si pu� usare il tipo TDateTime
var Posiz,i:Byte;
    Hour,Min:LongInt;
    Negativo:Boolean;
    sMin:String;
begin
  i:=1;
  Negativo:=False;
  while i <= Length(Ora) do
  begin
    if (Ora[i] <> ' ') and (Ora[i] <> '-') then
      Break;
    if Ora[i] = '-' then
    begin
      Negativo:=True;
      Break;
    end;
    inc(i);
  end;
  i:=1;
  while i <= Length(Ora) do
  begin
    if Ora[i] = ' ' then
      Delete(Ora,i,1)
    else
      inc(i);
  end;
  Min:=0;
  Posiz:=Pos('.',Ora);
  //Controllo se vengono usati i ':' come separatore
  if Posiz = 0 then
    Posiz:=Pos(':',Ora);
  //Controllo se viene usata la ',' come separatore
  if Posiz = 0 then
    Posiz:=Pos(',',Ora);
  if Posiz = 0 then
    Hour:=StrToIntDef(Ora,0)
  else
  begin
    Hour:=StrToIntDef(Copy(Ora,1,Posiz - 1),0);
    // chiamata 74591.ini - TORINO_COMUNE
    // accetta anche i valori di "Ora" comprensivi di secondi (es. 23.59.00)
    sMin:=Copy(Ora,Posiz + 1,Length(Ora));
    if Pos('.',sMin) > 0 then
      sMin:=Copy(sMin,1,Pos('.',sMin) - 1)
    else if Pos(':',sMin) > 0 then
      sMin:=Copy(sMin,1,Pos(':',sMin) - 1)
    else if Pos(',',sMin) > 0 then
      sMin:=Copy(sMin,1,Pos(',',sMin) - 1);
    Min:=StrToIntDef(sMin,0);
    // chiamata 74591.fine
  end;
  Result:=Abs(Hour) * 60 + Min;
  if Negativo then
    Result:=-Result;
end;

function OldR180OreMinutiExt(Ora:String):LongInt;
begin
  Result:=OldR180OreMinuti(Ora);
end;

function OldR180MinutiOre(Minuti:LongInt; const PTimeSeparator: Char = '.'):String;
{Dati i minuti, restituisce la stringa nel formato hh:mm}
var Ore,Min:LongInt;
    OreS,MinS{,OldTimeFormat}:String;
    L:Byte;
begin
  // gestione non thread safe rimossa.ini
  //OldTimeFormat:={$IFNDEF VER210}FormatSettings.{$ENDIF}LongTimeFormat;
  //{$IFNDEF VER210}FormatSettings.{$ENDIF}LongTimeFormat:='hh:mm';
  //{$IFNDEF VER210}FormatSettings.{$ENDIF}TimeSeparator:='.';
  // gestione non thread safe rimossa.fine
  Ore:=Abs(Minuti) div 60;
  Min:=Abs(Minuti) mod 60;
  OreS:=IntToStr(Ore);
  L:=Length(OreS);
  //Calcolo la lunghezza delle ore
  if L = 1 then inc(L);
  MinS:=IntToStr(Min);
  Result:=Copy('0' + OreS,Length(OreS) + 2 - L,L) + PTimeSeparator {'.'} + Copy('0' + MinS,Length(Mins),2);
  if Minuti < 0 then
    Result:='-' + Result;
  // gestione non thread safe rimossa.ini
  //{$IFNDEF VER210}FormatSettings.{$ENDIF}LongTimeFormat:=OldTimeFormat;
  // gestione non thread safe rimossa.fine
end;

function OldR180GiorniMese(Data:TDateTime):Byte;
{Restituisce il numero di giorni del mese}
var Anno,Mese,Giorno:Word;
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

function OldR180InizioMese(Data:TDateTime):TDateTime;
var A,M,G:Word;
begin
  DecodeDate(Data,A,M,G);
  Result:=EncodeDate(A,M,1);
end;

function OldR180FineMese(Data:TDateTime):TDateTime;
var A,M,G:Word;
begin
  DecodeDate(Data,A,M,G);
  Result:=EncodeDate(A,M,OldR180GiorniMese(Data));
end;

function OldR180InizioMeseSettimanale(Data:TDateTime; UltimaSettInterna:Boolean):TDateTime;
{Restituisce l'inizio del mese nell'ambito del conteggio settimanale:
  il mese comincia sempre di luned� e finisce sempre di domenica}
begin
  Result:=OldR180InizioMese(Data);
  if UltimaSettInterna then
    //luned� della prima settimana che interseca il mese e ultima settimana interna al mese
    Result:=Result - DayOfWeek(Result - 1) + 1
  else
    //luned� della prima settimana compresa nel mese e ultima settimana interseca mese succ.
    Result:=Result + ((8 - DayOfWeek(Result - 1)) mod 7);
end;

function OldR180FineMeseSettimanale(Data:TDateTime; UltimaSettInterna:Boolean):TDateTime;
{Restituisce la fine del mese nell'ambito del conteggio settimanale:
  il mese comincia sempre di luned� e finisce sempre di domenica}
begin
  Result:=OldR180FineMese(Data);
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

function OldR180AddMesi(Data:TDateTime; Mesi:Integer; MantieniFineMese:Boolean = False):TDateTime;
var A,M,G:Word;
    i:Integer;
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
  if (G > OldR180GiorniMese(InizioMese)) or
     ((Data = OldR180FineMese(Data)) and MantieniFineMese) then
    Result:=OldR180FineMese(InizioMese)
  else
  begin
    try
      Result:=EncodeDate(A,M,G);
    except
      Result:=OldR180FineMese(InizioMese);
    end;
  end;
end;

procedure OldR180SpostaPeriodo(DalOld,AlOld:TDateTime;Avanti,Contiguo:Boolean;var DalNew,AlNew:TDateTime);
var GGDiff,MMDiff,AADiff,Molt:Integer;
begin
  Molt:=IfThen(Avanti,1,-1);
  if Contiguo then //periodo immediatamente precedente o successivo
  begin
    if Avanti then
      DalNew:=Trunc(AlOld + 1)
    else
      AlNew:=Trunc(DalOld - 1);
    if (DalOld = OldR180InizioMese(DalOld)) and (AlOld = OldR180FineMese(AlOld)) then //mi sposto di mesi interi
    begin
      AADiff:=OldR180Anno(AlOld) - OldR180Anno(DalOld);
      MMDiff:=(OldR180Mese(AlOld) - OldR180Mese(DalOld)) + (12 * AADiff);
      if Avanti then
        AlNew:=OldR180FineMese(OldR180AddMesi(DalNew,MMDiff * Molt))
      else
        DalNew:=OldR180InizioMese(OldR180AddMesi(AlNew,MMDiff * Molt));
    end
    else //mi sposto di giorni
    begin
      GGDiff:=Trunc(AlOld - DalOld);
      if Avanti then
        AlNew:=DalNew + GGDiff
      else
        DalNew:=AlNew - GGDiff;
    end;
  end
  else //periodo precedente o successivo specificato
  begin
    MMDiff:=1;//per ora fisso
    if Avanti then
    begin
      AlNew:=OldR180FineMese(OldR180AddMesi(AlOld,MMDiff * Molt));
      DalNew:=OldR180InizioMese(AlNew);
    end
    else
    begin
      DalNew:=OldR180InizioMese(OldR180AddMesi(DalOld,MMDiff * Molt));
      AlNew:=OldR180FineMese(DalNew);
    end
  end;
end;

function OldR180StrToDateFmt(Data,Formato:String):TDateTime;
var DataOut,TimeOut:String;
    i:Integer;
begin
  Formato:=Trim(UpperCase(Formato));
  DataOut:=Data;
  TimeOut:='HH.NN';
  if Formato <> '' then
  begin
    DataOut:=UpperCase({$IFNDEF VER210}FormatSettings.{$ENDIF}ShortDateFormat);
    for i:=1 to Length(Formato) do
      if Formato[i] in ['Y','M','D'] then
      //if CharInSet(Formato[i],['Y','M','D']) then
        DataOut:=StringReplace(DataOut,Formato[i],Data[i],[rfIgnoreCase])
      else if Formato[i] in ['H','N'] then
        TimeOut:=StringReplace(TimeOut,Formato[i],Data[i],[rfIgnoreCase])
  end;
  if TimeOut = 'HH.NN' then
    Result:=StrToDate(DataOut)
  else
    Result:=StrToDateTime(DataOut + ' ' + TimeOut);
end;

function OldR180CarattereDef(const S:String; N:Word = 1; D:Char = #0):Char;
{Restituisce il carattere in posizione N della stringa S
 Gestisce la non esistenza di quella posizione nella stringa}
begin
  Result:=#0;
  if N = 0 then
    exit;
  if Length(S) >= N then
    Result:=S[N]
  else
    Result:=D;
end;

function OldR180Spaces(S:String; L:Word):String;
{Aggiungo N Spazi alla stringa S}
var i,Lung:Word;
begin
  Result:=S;
  Lung:=Length(S) + 1;
  for i:=Lung to L do
    S:=S + ' ';
  Result:=S;
end;

function OldR180EliminaSpaziMultipli(const Val: String): String;
var
  i, n : integer;
begin
  SetLength(Result,Length(Val));
  if Val <> '' then
  begin
    n:=0;
    for i:=1 to Length(Val) do
    begin
      if (Val[i] in SPAZI_SET) then
      begin
        if (n < 1) or (Result[n] <> SPACE) then
        begin
          inc(n);
          Result[n]:=SPACE;
        end;
      end
      else
      begin
        inc(n);
        Result[n]:=Val[i];
      end;
    end;

    // elimina spazi in fondo
    while (n > 1) and (Result[n] = SPACE) do
      Dec(n);
    SetLength(Result,n);
  end;
end;

function OldR180GetValore(S,P,A:String; var Valore:String):Boolean;
var i,j:Integer;
begin
  Result:=False;
  //Stringa di partenza
  i:=Pos(P,S);
  if i = 0 then exit;
  i:=i + Length(P);
  //Stringa di arrivo
  if A = '' then
    j:=Length(S) + 1
  else
    begin
    j:=Pos(A,S);
    if j = 0 then j:=Length(S) + 1;
    end;
  Result:=True;
  Valore:=Copy(S,i,j - i);
end;

function OldR180GetFontStyle(FS:String):TFontStyles;
{Restituisce il FontStyle partendo dal formato stringa
 precedentemente salvato}
begin
  Result:=[];
  if OldR180CarattereDef(FS,1,'0') = '1' then
    Result:=Result + [fsBold];
  if OldR180CarattereDef(FS,2,'0') = '1' then
    Result:=Result + [fsItalic];
  if OldR180CarattereDef(FS,3,'0') = '1' then
    Result:=Result + [fsUnderline];
  if OldR180CarattereDef(FS,4,'0') = '1' then
    Result:=Result + [fsStrikeOut];
end;

function OldR180DimLung(S:String; D:Integer):String;
{Aggiungo n spazi in coda ad S in modo da ottenere la lunghezza = D}
var i,L:Integer;
begin
  if D = 0 then D:=Length(S);
  Result:=Copy(S,1,D);
  L:=Length(Result);
  for i:=L to D - 1 do
    Result:=Result + ' ';
end;

function OldR180LPad(const PStr:string; PNumCaratteri:integer; PCarattere:char): string;
// left pad
begin
  Result:=StringOfChar(PCarattere,PNumCaratteri - Length(PStr)) + PStr;
end;

function OldR180RPad(const PStr:string; PNumCaratteri:integer; PCarattere:char): string;
// right pad
begin
  Result:=PStr + StringOfChar(PCarattere,PNumCaratteri - Length(PStr));
end;

function OldR180ElencoGiorni(Inizio,Fine:TDateTime; Formato:String):String;
{Restituisce una stringa contenente tutte le date da inizio a fine nel formato specificato}
var Corr:TDateTime;
begin
  Result:='';
  Corr:=Inizio;
  while Corr <= Fine do
    begin
    Result:=Result + FormatDateTime(Formato,Corr);
    Corr:=Corr + 1;
    end;
end;

function OldR180ElencoMesi(Inizio,Fine:TDateTime; Formato:String):String;
{Restituisce una stringa contenente il numero del mese solo}
var Corr:TDateTime;
    M:String;
begin
  Result:='';
  Corr:=Inizio;
  M:='';
  while Corr <= Fine do
    begin
    if M <> FormatDateTime('mm',Corr) then
      begin
      Result:=Result + OldR180DimLung(FormatDateTime('mm',Corr),Length(Formato));
      M:=FormatDateTime('mm',Corr);
      end
    else
      Result:=Result + OldR180DimLung('',Length(Formato));
    Corr:=Corr + 1;
    end;
end;

function OldR180NomeMese(Num:Byte):String;
{ Restituisce il nome del mese indicato dal numero
  (1 = gennaio, 2 = febbraio, ...)
}
begin
  Result:='';
  if Num in [1..12] then
    Result:={$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[Num];
end;

function OldR180NomeMeseAnno(D: TDateTime): String;
// restituisce mese in lettere e anno della data indicati
// es. R180NomeMeseAnno(05/04/2014) = 'Aprile 2014'
begin
  Result:=Format('%s %d',[OldR180NomeMese(OldR180Mese(D)),OldR180Anno(D)]);
end;

function OldR180NomeGiorno(Anno,Mese,Giorno:Word):String;
begin
  Result:='';
  try
    Result:={$IFNDEF VER210}FormatSettings.{$ENDIF}LongDayNames[DayOfWeek(EncodeDate(Anno,Mese,Giorno))];
  except
    Result:='';
  end;
end;

function OldR180NomeGiorno(D:TDateTime):String;
begin
  Result:='';
  Result:={$IFNDEF VER210}FormatSettings.{$ENDIF}LongDayNames[DayOfWeek(D)];
end;

function OldR180NomeGiornoSett(GiornoSettimana:Word):String;
//Non si pu� fare un overload di R180NomeGiorno
//perch� non viene fatta distinzione sul parametro in ingresso tra Word e TDateTime,
//con l'effetto collaterale di richiamare sempre la stessa function
begin
  Result:='';
  if (GiornoSettimana >= 1) and (GiornoSettimana <= 6) then
    Result:={$IFNDEF VER210}FormatSettings.{$ENDIF}LongDayNames[GiornoSettimana + 1]
  else if GiornoSettimana = 7 then
    Result:={$IFNDEF VER210}FormatSettings.{$ENDIF}LongDayNames[1];
end;

// -----------------------   G E S T I O N E   F I L E   -----------------------
procedure OldR180AppendFile(const NomeFile,Testo:String);
{Appende il testo specificato al file NomeFile (usato per i file di log)}
var F:TextFile;
begin
  AssignFile(F,NomeFile);
  if FileExists(NomeFile) then
    Append(F)
  else
    Rewrite(F);
  Writeln(F,Testo);
  CloseFile(F);
end;

procedure OldR180AppendFileNoCR(const NomeFile,Testo:String);
{Appende il testo specificato al file NomeFile (usato per i file di log)}
var F:TextFile;
begin
  AssignFile(F,NomeFile);
  if FileExists(NomeFile) then
    Append(F)
  else
    Rewrite(F);
  Write(F,Testo);
  CloseFile(F);
end;

function OldIdentificatore(const Nome:String):String;
var I:Integer;
begin
  Result:=Nome;
  i:=1;
  while i <= Length(Result) do
    begin
    if not (Result[i] in ['A'..'Z', 'a'..'z', '0'..'9', '_']) then
      Delete(Result,i,1)
    else
      inc(i);
    end;
end;

function OldEliminaRitornoACapo(Testo:String):String;
var Pos1:Integer;
begin
  Pos1:=pos(#$D#$A,UpperCase(Testo));
  while Pos1 > 0 do
    begin
    Delete(Testo,Pos1,2);
    Insert(' ',Testo,Pos1);
    Pos1:=pos(#$D#$A,UpperCase(Testo));
    end;
  Result:=Testo;
end;

function OldCalcolaPasqua(Anno: Integer):TDateTime;
var SAnno,DAnno,VarCal,VarCal1,VarCal2,Anno1,Anno2,Anno3,Anno4,Ope,Ope1,Erre,Erre1: Integer;
    GP,MP: Integer;
begin
  SAnno:=StrToInt(Copy(IntToStr(Anno),1,2));
  DAnno:=StrToInt(Copy(IntToStr(Anno),3,2));
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
  Result:=StrToDateTime(IntToStr(GP)+'/'+IntToStr(MP)+'/'+IntToStr(Anno));
end;

function OldFestivo(Giorno,Mese,Anno: Integer):Boolean;
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

function OldR180ArrotondaMinuti(Valore,Arrotondamento:Integer):Integer;
{Arrotondamento Valore come routine z892_arrotondaP su Rp502Pro}
var ArrAbs:Integer;
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
function OldR180Decripta(S:String; Key:LongInt):String;
{Usata per decriptare la password dell'utente Oracle MONDOEDP
 I caratteri utilizzati vanno dal codice 32 al 126}
var i,k,OS:Integer;
    SKey:String;
begin
  Result:='';
  SKey:=IntToStr(Key);
  k:=0;
  for i:=1 to Length(S) do
    begin
    inc(k);
    if k > Length(SKey) then
      k:=1;
    OS:=StrToInt(SKey[k]);
    inc(k);
    if k > Length(SKey) then
      k:=1;
    OS:=OS + StrToInt(SKey[k]);
    dec(k);
    if Ord(S[i]) - OS < 32 then
      Result:=Result + Chr(126 - (31 - (Ord(S[i]) - OS)))
    else
      Result:=Result + Chr(Ord(S[i]) - OS);
    end;
end;

function OldR180Cripta(S:String; Key:LongInt):String;
{Usata per criptare la password dell'utente Oracle MONDOEDP
 I caratteri utilizzati vanno dal codice 32 al 126}
var i,k,OS:Integer;
    SKey:String;
begin
  Result:='';
  SKey:=IntToStr(Key);
  k:=0;
  for i:=1 to Length(S) do
    begin
    inc(k);
    if k > Length(SKey) then
      k:=1;
    OS:=StrToInt(SKey[k]);
    inc(k);
    if k > Length(SKey) then
      k:=1;
    OS:=OS + StrToInt(SKey[k]);
    dec(k);
    if Ord(S[i]) + OS > 126 then
      Result:=Result + Chr(31 + Ord(S[i]) + OS - 126)
    else
      Result:=Result + Chr(Ord(S[i]) + OS);
    end;
end;

function OldR180CriptaI070(Password:string):string;
{Restituisce la stringa crittografata per la password riferita a I070_UTENTI}
var Criptato:String;
    i:integer;
begin
  if Trim(Password) = '' then
    begin
    result:= '';
    exit;
    end;
  Criptato:='';
  for i:=Length(Password) downto 1 do
  begin
    Criptato:=Criptato+IntToHex(158-Ord(Password[i]),2);
  end;
  Result:=Criptato;
end;

function OldR180DecriptaI070(Password:string):string;
{Rende leggibile la stringa crittografata per la password riferita a I070_UTENTI}
var Criptato,EsaDec:String;
    i:integer;
begin
  if Trim(Password) = '' then
    begin
    result:= '';
    exit;
    end;
  Criptato:='';
  i:=Length(PassWord);
  while i > 0 do
    begin
    EsaDec:='$'+Copy(Password,i-1,2);
    try
      Criptato:=Criptato+Chr(158-StrToInt(EsaDec));
    except
    end;
    i:=i-2;
    end;
  Result:=Criptato;
end;

function OldR180DimLungR(S:String; D:Integer):String;
{Aggiungo n spazi in testa ad S in modo da ottenere la lunghezza = D}
var L:Integer;
begin
  if D = 0 then D:=Length(S);
  Result:=Copy(S,1,D);
  L:=Length(Result);
  if D > L then
    Result:=StringOfChar(' ',D - L) + Result;
end;

function OldR180InserisciColonna(var S:String; const C:String): Boolean;
// Ricerca la stringa C in S
//   S � la query anagrafica restituita da C700
// Se C non esiste viene inserita
var P,P1:Integer;
    CampiSel,SUpper:String;
begin
  Result:=False;
  if C = '' then exit;

  SUpper:=UpperCase(S);
  // ricerca parole chiave "FROM"
  P:=Pos('FROM',SUpper);
  if P = 0 then exit;

  // ricerca parola chiave "SELECT"
  P1:=Pos('SELECT',SUpper);
  if P1 = 0 then exit;

  // se la colonna C non � presente fra i campi selezionati, viene aggiunta
  CampiSel:=UpperCase(Copy(S,P1 + 6,P - 7));
  if OldR180CercaParolaIntera(C,CampiSel,'.,;') = 0 then
  begin
    Insert(',' + C + ' ',S,P);
    Result:=True;
  end;
end;

function OldR180InserisciAliasT030(const StrSql: String): String;
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
    SearchStr:=UpperCase(Result);
    OldCampo:=UpperCase(CampiT030[i]);
    NewCampo:=ALIAS_T030 + OldCampo;

    NewStr:=Result;
    Result:='';
    while SearchStr <> '' do
    begin
      Offset:=OldR180CercaParolaIntera(OldCampo,SearchStr,',()=<>|!/+-*');
      if Offset = 0 then
      begin
        Result:=Result + NewStr;
        Break;
      end;
      Result:=Result + Copy(NewStr, 1, Offset - 1) + NewCampo;
      NewStr:=Copy(NewStr, Offset + Length(OldCampo), MaxInt);
      SearchStr:=Copy(SearchStr, Offset + Length(OldCampo), MaxInt);
    end;
  end;
end;

function OldR180InConcat(const Parola,Stringa:String):Boolean;
{Restituisce True se Parola esiste in Stringa che contiene valori separati da Virgola}
begin
  Result:=Pos(',' + Parola + ',',',' + Stringa + ',') > 0;
end;

function OldR180CercaParolaIntera(const Parola,Stringa,CaratteriSeparazione:String):Integer;
// Funzione ricorsiva per cercare Parola dentro Stringa se � limitata da spazi
// o da caratteri contenuti in CaratteriSeparazione
var x,y:Integer;
    S:String;
begin
  Result:=0;
  if Parola = '' then
    exit;
  x:=Pos(Parola,Stringa);
  if x > 0 then
  begin
    // determina porzione da verificare
    if x = 1 then
      S:=Trim(Copy(Stringa,1,Length(Parola) + 1))
    else
      S:=Trim(Copy(Stringa,x - 1,Length(Parola) + 2));
    // verifica carattere precedente
    if Pos(Copy(S,1,1),CaratteriSeparazione) > 0 then
      S:=Copy(S,2,Length(S));
    // verifica carattere successivo
    if Pos(Copy(S,Length(S),1),CaratteriSeparazione) > 0 then
      S:=Copy(S,1,Length(S) -1);
    // determina posizione
    if S = Parola then
      Result:=x
    else
    begin
      // ricerca nella porzione successiva di stringa
      y:=OldR180CercaParolaIntera(Parola,Copy(Stringa,x + 1,Length(Stringa)),CaratteriSeparazione);
      if y > 0 then
        Result:=x + y;
    end;
  end
end;

function OldR180NumOccorrenzeCar(S:String; C:Char):Integer;
{ Conta il numero di occorrenze del carattere C nella stringa S }
var i:Integer;
begin
  Result:=0;
  for i:=1 to Length(s) do
    if S[i] = C then
      inc(Result);
end;

// G E S T I O N E   R E G I S T R O   W I N D O W S
procedure OldR180PutRegistro(Root:HKEY; const Chiave,Dato,Valore:String);
var Registro:TRegistry;
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

function OldR180GetRegistro(Root:HKEY; const Chiave,Dato,Def:String):String;
var Registro:TRegistry;
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

function OldR180ScriviMsgLog(const FileLog,Msg:String):Boolean;
var sPath:String;
begin
  Result:=False;
  try
    sPath:=Trim(OldR180GetRegistro(HKEY_LOCAL_MACHINE,'','PATH_LOG','c:\IrisWIN\Archivi'));
    if sPath = '' then
      exit;
    if Copy(sPath,Length(sPath),1) <> '\' then
      sPath:=sPath + '\';
    if ForceDirectories(sPath) then
    begin
      OldR180AppendFile(sPath + FileLog,Msg);
      Result:=True;
    end;
  except
  end;
end;

// G E S T I O N E   V A R I A B I L I   D I   A M B I E N T E
function OldR180GetEnvVarValue(const VarName: string): string;
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

function OldR180SetEnvVarValue(const VarName, VarValue: string): Integer;
begin
  // Simply call API function
  if SetEnvironmentVariable(PChar(VarName), PChar(VarValue)) then
    Result:=0
  else
    Result:=GetLastError;
end;

procedure OldR180SetOracleInstantClient;
var Registro:TRegistry;
    PathOIC:String;
  function UsaoIC:Boolean;
  var S:String;
  begin
    Result:=False;
    if not FileExists('B012PAllineamentoClient.ini') then
      exit;
    with TStringList.Create do
    try
      LoadFromFile('B012PAllineamentoClient.ini');
      S:=Values['#PathOIC'];
    finally
      Free;
    end;
    if S <> '' then
    begin
      if DirectoryExists(ExtractFilePath(Application.ExeName) + S) then
      begin
        PathOIC:=ExtractFilePath(Application.ExeName) + S;
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
  try
    Registro:=TRegistry.Create;
    try
      Registro.RootKey:=HKEY_LOCAL_MACHINE;
      Registro.OpenKeyReadOnly('Software');
      PathOIC:=ExtractFilePath(Application.ExeName) + 'OIC';
      if (not Registro.KeyExists('oracle')) or UsaOIC then
      begin
        OldR180SetEnvVarValue('TNS_ADMIN',PathOIC);
        OldR180SetEnvVarValue('LD_LIBRARY_PATH',PathOIC);
        OldR180SetEnvVarValue('PATH',PathOIC + ';%PATH%');
        //R180SetEnvVarValue('NLS_LANG','AMERICAN_AMERICA.WE8MSWIN1252');
        OldR180SetEnvVarValue('NLS_LANG','ITALIAN_ITALY.WE8MSWIN1252');
      end;
    finally
      FreeAndNil(Registro);
    end;
  except
  end;
end;

procedure OldR180OraValidate(S:String);
begin
  if S = '' then
    exit;
  if Length(S) <> 5 then
    raise Exception.Create('Il formato del dato è HH.MM');
  if Pos(' ',S) > 0 then
    raise Exception.Create('Il formato del dato è HH.MM');
  if StrToInt(Copy(S,1,2)) > 23 then
    raise Exception.Create('Le ore devono essere comprese tra 00 e 23');
  if StrToInt(Copy(S,4,2)) > 59 then
    raise Exception.Create('I minuti devono essere compresi tra 00 e 59');
end;

function OldOreMinutiValidate(Valore: String):Boolean;
// verifica se il campo contiene un valore ore minuti valido
var Posiz,Minuti : Integer;
    SOre, SMin : String;
begin
  Result:=False;
  if Pos(' ',Trim(Valore)) > 1 then
    raise Exception.Create('Dato non valido!');
  Posiz:=Pos('.',Valore);
  if Posiz = 0 then
    Posiz:=Pos(':',Valore);
  if Posiz = 0 then exit;
  SMin:=Trim(Copy(Valore,Posiz + 1,2));
  if Length(SMin)<2 then
    raise Exception.Create('Indicare 2 cifre per i minuti');
  SOre:=Trim(Copy(Valore,1,Posiz-1));
  if Length(SOre)<2 then
    raise Exception.Create('Indicare almeno 2 cifre per le ore');
  Minuti:=StrToInt(SMin);
  if Minuti > 59 then
    raise Exception.Create('I minuti devono essere minori di 60!');
  Result:=True;
end;

procedure OldR180ClearDBEditDateTime(Sender:TObject);
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

function OldR180StrToGiorniOre(Valore,UM:String):Real;
begin
  Result:=0;
  try
    if UM = 'G' then
    begin
      Valore:=StringReplace(Valore,' ','0',[rfReplaceAll]);
      Valore:=StringReplace(Valore,'.',{$IFNDEF VER210}FormatSettings.{$ENDIF}DecimalSeparator,[rfReplaceAll]);
      Result:=StrToFloat(Valore);
    end
    else if UM = 'O' then
      Result:=OldR180OreMinutiExt(Valore);
  except
  end;
end;

function OldR180GiorniOreToStr(Valore:Real; UM:String; Formato:String=''):String;
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
      Result:=OldR180MinutiOre(Trunc(Valore));
  except
  end;
end;

function OldR180GetFilePath(S:String; EndSlash:Boolean = False):String;
var i:Integer;
begin
  Result:='';
  for i:=Length(S) downto 1 do
    if S[i] in ['/','\'] then
    begin
      if EndSlash then
        Result:=Copy(S,1,i)
      else
        Result:=Copy(S,1,i - 1);
      Break;
    end;
end;

function OldR180GetFileName(S:String):String;
var i:Integer;
begin
  Result:=S;
  for i:=Length(S) downto 1 do
    if S[i] in ['/','\'] then
    begin
      Result:=Copy(S,i + 1,Length(S));
      Break;
    end;
end;

function OldR180GetFileSize(const PFileName:String): Int64;
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

function OldR180GetFileSizeStr(const PSizeInBytes: Int64): String;
// converte la dimensione del file espressa in byte in un formato stringa human-readable
const
  SOGLIA_GB = 1073741823; // soglia oltre la quale la dimensione è espressa in Gb
  SOGLIA_MB =    1048575; // soglia oltre la quale la dimensione è espressa in Mb
  SOGLIA_KB =       1023; // soglia oltre la quale la dimensione è espressa in Kb
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

function OldR180GetFileSizeStr(const PFileName:String): String;
// determina la dimensione del file specificato e la restituisce in un formato stringa human-readable
begin
  Result:=OldR180GetFileSizeStr(OldR180GetFileSize(PFileName));
end;

function OldR180FileToByteArray(const PFileName: String): TByteDynArray;
const
  BLOCK_SIZE = 1024;
var
  BytesRead,BytesToWrite,Count:integer;
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

procedure OldR180ByteArrayToFile(const PByteArr: TByteDynArray; const PFileName: String);
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

function OldR180GetCampiConcatenati(D:TDataSet; C:TStringList):String;
var i:Integer;
begin
  Result:='';
  for i:=0 to C.Count - 1 do
    try
      Result:=Result + D.FieldByName(C[i]).AsString;
      if i < C.Count - 1 then
        Result:=Result + ' ';
    except
    end;
end;

function OldR180EstraiNomeTabella(SqlText:String):String;
{funzione che estrae da una frase Sql il nome della prima tabella dopo la
 clausola FROM}
var i,Posiz,Lung:integer;
    Testo:string;
begin
  Posiz:=Pos('FROM',UpperCase(SqlText));
  if Posiz > 0 then
  begin
    i:=Posiz + 4;
    Lung:=Length(SqlText);
    Testo:='';
    while (i <= Lung) and (not(UpCase(SqlText[i]) in ['A'..'Z'])) do
      inc(i);
    while (i <= Lung) and (not(SqlText[i] in [#10,#13,#0,' ',',','"',''''])) do
    begin
      Testo:=Testo + SqlText[i];
      inc(i);
    end;
    Result:=Testo;
  end
  else
    Result:='';
end;

function OldR180Query2NomeTabella(DS:TDataSet):string;
begin
  Result:='';
  (*if DS is TQuery then
     Result:=R180EstraiNomeTabella((DS as TQuery).SQL.Text)
  else*)
  if DS is TOracleDataSet then
    Result:=OldR180EstraiNomeTabella((DS as TOracleDataSet).SQL.Text);
end;

function OldR180Anno(Data:TDateTime):Word;
begin
  Result:=StrToInt(FormatDateTime('yyyy',Data));
end;

function OldR180Mese(Data:TDateTime):Word;
begin
  Result:=StrToInt(FormatDateTime('mm',Data));
end;

function OldR180Giorno(Data:TDateTime):Word;
begin
  Result:=StrToInt(FormatDateTime('dd',Data));
end;

function OldR180SettimanaAnno(Data:TDateTime; IniziaDomenica:Boolean = True):Integer;
begin
  if IniziaDomenica then
    //num settimana cconsiderando Domenica come primo giorno
    Result:=Trunc(OldR180Arrotonda((Trunc(Data + 7 - DayOfWeek(Data) - EncodeDate(OldR180Anno(Data),1,1) + 1)/7),1,'E'))
  else
    //num settimana cconsiderando Luned� come primo giorno
    Result:=Trunc(OldR180Arrotonda((Trunc(Data + 7 - DayOfWeek(Data - 1) - EncodeDate(OldR180Anno(Data),1,1) + 1)/7),1,'E'));
end;

function OldR180Arrotonda(Dato,Valore:Real; Tipo:String): Real;
//Arrotondamento
var Delta:Real;
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
    Delta:= -Delta;
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

function OldR180AzzeraPrecisione(Dato:Real; NumDec:Integer): Real;
//Azzera il dato se minore della precisione
var Precisione:Real;
begin
  Precisione:=Power(10, -NumDec);
  if Abs(Dato) < Precisione then
    Result:=0
  else
    Result:=Dato;
end;

function OldR180Formatta(Dato:Real; NumCrt,NumDec:Integer):String;
//Formattazione dato numerico in stringa
var FS:TFormatSettings;
begin
  //Alberto 09/05/2013: forzo il separatore delle migliaia
  FS:=TFormatSettings.Create(LOCALE_SYSTEM_DEFAULT);  //non serve fare il free
  //GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT,FS);
  FS.ThousandSeparator:='.';
  FS.DecimalSeparator:=',';
  Result:=Format('%*.*n',[NumCrt,NumDec,Dato],FS);
end;

function OldR180CifreDecimali(Dato:Real):Byte;
var P:Byte;
begin
  Result:=0;
  P:=Pos({$IFNDEF VER210}FormatSettings.{$ENDIF}DecimalSeparator,FloatToStr(Dato));
  if P > 0 then
    Result:=Length(FloatToStr(Dato)) - P;
end;

function OldR180FormattaNumero(S,F:String):String;
{M = Separatore di migliaia     (S/N)
 D = Num. cifre per i decimali  (0..x)
 0 = Stampare 0 (S/N)
 SD = ./,
}
var C:Currency;
    i:Integer;
    SD:String;
begin
  if F = '' then
  begin
    Result:=S;
    exit;
  end;
  if S = '' then
    S:='0';
  C:=StrToFloat(S);
  with TStringList.Create do
  try
    CommaText:=UpperCase(F);
    //Decido se stampare il valore Zero o meno
    if (Values['0'] = 'N') and (C = 0) then
    begin
      Result:='';
      exit;
    end;
    //Separatore di migliaia
    if Values['M'] = 'S' then
      F:='n'
    else
      F:='f';
    //Precisione (numero di decimali)
    if Values['D'] <> '' then
      F:='.' + Values['D'] + F;
    Result:=Format('%' + F,[C]);
    SD:=Values['SD'];
    if SD <> '' then
      if SD <> {$IFNDEF VER210}FormatSettings.{$ENDIF}DecimalSeparator then
      begin
        for i:=1 to Length(Result) do
          if Result[i] = {$IFNDEF VER210}FormatSettings.{$ENDIF}DecimalSeparator then
            Result[i]:={$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator
          else if Result[i] = {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator then
            Result[i]:={$IFNDEF VER210}FormatSettings.{$ENDIF}DecimalSeparator;
      end;
  finally
    Free;
  end;
end;

function OldR180FormattaNumeroSoloDec(S,F:String):String;
{D = Num. cifre per i decimali  (0..x)}
var C:Currency;
begin
  Result:=S;
  if F = '' then
    exit;
  with TStringList.Create do
  try
    CommaText:=UpperCase(F);
    //Precisione (numero di decimali)
    if Values['D'] <> '' then
    begin
      if S = '' then
        S:='0';
      C:=StrToFloat(S);
      F:='.' + Values['D'] + 'f';
      Result:=Format('%' + F,[C]);
    end;
  finally
    Free;
  end;
end;

function OldR180IsDigit(const PStr: String; PIndex: Integer): Boolean;
// restituisce True se il carattere PIndex-esimo della stringa PStr � una cifra
begin
  Result:=OldR180IsDigit(OldR180CarattereDef(PStr,PIndex));
end;

function OldR180IsDigit(const PChr: Char): Boolean;
// restituisce True se il carattere specificato � una cifra
begin
  Result:=PChr in ['0'..'9'];
end;

{$HINTS OFF} // l'hint sulla variabile "nr" � trascurabile
function OldR180IsNumeric(S:String):Boolean;
var nr:Real;
    c:Integer;
begin
  S:=Trim(StringReplace(S,',','.',[rfReplaceAll]));
  val(S,nr,c);
  Result:=c = 0;
end;
{$HINTS ON}

function OldR180IsSpecialChar(const PChr: Char): Boolean;
begin
  Result:=Pos(PChr,SPECIAL_CHAR) > 0;
end;

function OldR180EliminaZeriASinistra(S:String):String;
{Elimina gli zeri a sinistra di una stringa}
var i:Integer;
begin
  Result:=S;
  for i:=1 to Length(S) - 1 do
    if S[i] <> '0' then
      Break
    else
      Result:=Copy(Result,2,Length(S));
end;

function OldR180Values(S:String):String;
begin
  Result:='';
  if Pos('=',S) > 0 then
    Result:=Copy(S,Pos('=',S) + 1,Length(S));
end;

function OldR180NomeFileDatato(NomeFile,Formato:String; Data:TDateTime):String;
var Path,FN:String;
begin
  if Trim(Formato) = '' then
  begin
    Result:=NomeFile;
    exit;
  end;
  Path:=ExtractFilePath(NomeFile);
  FN:=ExtractFileName(NomeFile);
  if pos('.',FN) <> 0 then
    Insert(FormatDateTime(Formato,Data),FN,pos('.',FN))
  else
    FN:=FN + FormatDateTime(Formato,Data);
  Result:=Path + FN;
end;

function OldR180EstraiExtFile(S:String):String;
{Estrae l'estensione del file, delimitata da '.'}
var i:Integer;
begin
  Result:='';
  for i:=Length(S) downto 1 do
    if S[i] = '.' then
      Break
    else
      Result:=S[i] + Result;
end;

procedure OldR180InizializzaArray(var Vettore:array of Integer; Valore:Integer = 0); overload;
var i:Integer;
begin
  for i:=0 to High(Vettore) do
    Vettore[i]:=Valore;
end;

procedure OldR180InizializzaArray(var Vettore:array of Real; Valore:Real = 0); overload;
var i:Integer;
begin
  for i:=0 to High(Vettore) do
    Vettore[i]:=Valore;
end;

function OldR180SommaArray(Vettore:array of Integer):Integer;
var i:Integer;
begin
  Result:=0;
  for i:=0 to High(Vettore) do
    Result:=Result + Vettore[i];
end;

function OldR180SommaArray(Vettore:array of Real):Real;
var i:Integer;
begin
  Result:=0;
  for i:=0 to High(Vettore) do
    Result:=Result + Vettore[i];
end;

function OldR180SysDate(Sessione:TOracleSession):TDateTime;
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

function OldR180AttivaHintSQL(SQL:String; VersioneOracle:Integer):String;
{Attiva/disattiva gli hint delle query in base alla versione del db}
var i:Integer;
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

function OldR180NumeroInLettere(Sessione:TOracleSession; Numero:Real):String;
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

function OldR180LunghezzaCampo(F:TField):Integer;
begin
  if F is TStringField then
    Result:=F.Size
  else
    Result:=F.DisplayWidth;
  if F.Index < F.DataSet.FieldCount - 1 then
    inc(Result);
end;

procedure OldR180DBGridCopyToClipboard(DBGrid:TDBGrid; CopyToExcel:Boolean; RigheSelezionate:Boolean = True; Intestazione:Boolean = True; NoACapo:Boolean = False);
var S:String;
    i,j:Integer;
begin
  with DbGrid.DataSource.DataSet do
  begin
    if not Active then
      exit;
    S:='';
    Clipboard.Clear;
    DisableControls;
    Screen.Cursor:=crHourGlass;

    // determina l'indice dell'ultimo campo visibile
    for j:=FieldCount - 1 downto 0 do
    begin
      if Fields[j].Visible then
        Break;
    end;

    First;
    try
      // esporta campi di intestazione
      if Intestazione then
      begin
        if not Eof then
        begin
          for i:=0 to FieldCount - 1 do
          begin
            if Fields[i].Visible then
            begin
              if CopyToExcel then
              begin
                // accoda carattere di tabulazione (separatore di colonna excel)
                // eccetto per l'ultimo campo visibile
                S:=S + Fields[i].FieldName + IfThen(i < j,TAB);
              end
              else
              begin
                if i < j then
                  S:=S + Format('%-*s',[OldR180Lunghezzacampo(Fields[i]),Copy(Fields[i].FieldName,1,OldR180Lunghezzacampo(Fields[i]))])
                else
                  S:=S + Format('%-s',[Fields[i].FieldName]);
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
          for i:=0 to FieldCount - 1 do
          begin
            if Fields[i].Visible then
            begin
              if CopyToExcel then
              begin
                // accoda carattere di tabulazione (separatore di colonna excel)
                // eccetto per l'ultimo campo visibile
                //Alberto 06/02/2017: se il campo contiene dei ritorni a capo, viene racchiuso tra virgolette in modo che su excel non vaa a capo su un'altra riga
                S:=S + IfThen(Pos(CRLF,Fields[i].AsString) > 0,'"') +
                       Fields[i].AsString +
                       IfThen(Pos(CRLF,Fields[i].AsString) > 0,'"') +
                       IfThen(i < j,TAB);
              end
              else
              begin
                if i < j then
                  S:=S + Format('%-*s',[OldR180Lunghezzacampo(Fields[i]),Copy(Fields[i].AsString,1,OldR180Lunghezzacampo(Fields[i]))])
                else
                  S:=S + Format('%-s',[Fields[i].AsString]);
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

procedure OldR180StringGridCopyToClipboard(StringGrid:TStringGrid);
var S:String;
    i,j:Integer;
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

function OldR180IncollaTestoDaClipboard(Testo:String;InizioSelezione,LunghezzaSelezione:Integer):String;
var TestoSalvato:String;
begin
  TestoSalvato:=Testo;
  try
    Result:=Copy(Testo,1,InizioSelezione) + Clipboard.AsText + Copy(Testo,InizioSelezione + 1 + LunghezzaSelezione);
  except
    Result:=TestoSalvato;
  end;
end;

procedure OldR180DBGridSelezionaRighe(DBGrid:TDBGrid; Modo:Char);
var BM:TBookMark;
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

function OldR180GetColonnaDBGrid(DBGrid:TDBGrid; Campo:String):Integer;
var
  i:Integer;
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

function OldR180FormatiCodificati(Dato,Formato:String;Lung:integer=0):String;
begin
  Result:=Trim(Dato);
  Formato:=UpperCase(Trim(Formato));
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
        Result:=FormatDateTime('yyyy-mm',StrToDate('01/' + Copy(Dato,1,2) + '/' + Copy(Dato,3,4)));
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
    Result:=Format('%-' + IntToStr(Lung) + '.' + IntToStr(Lung)+'s',[Dato]);
  end
  else if Formato = 'CF' then //Codice fiscale fluper
  begin
    Result:=Format('%-16.16s',[Dato]);
  end
  else if Formato = 'NU' then //Numerico intero positivo e negativo fluper
  begin
    //Gestisco il valore negativo...
    if StrToInt(Dato) < 0 then
      if Lung>1 then
        Lung:=Lung-1;
    Result:=Format('%' + IntToStr(Lung) + '.' + IntToStr(Lung) + 'd',[StrToInt(Dato)]);
  end
  else if Formato = 'NP' then //Numerico intero positivo fluper
  begin
    if StrToInt(Dato) < 0 then
      Dato:='0';
    Result:=Format('%' + IntToStr(Lung) + '.' + IntToStr(Lung) + 'd',[StrToInt(Dato)]);
  end
  else if Formato = 'VP' then //Numerico positivo con 2 decimali fluper
  begin
    if StrToFloat(Dato) < 0 then
      Dato:='0';
    Result:=Format('%' + IntToStr(Lung) + '.2f',[StrToFloat(Dato)]);
    Result:=StringReplace(Result,',','',[RfReplaceAll]);
    Result:=StringReplace(Result,'.','',[RfReplaceAll]);
    Result:=Format('%' + IntToStr(Lung) + '.' + IntToStr(Lung) + 'd',[StrToInt(Result)]);
  end
  else if Formato = 'VN' then //Numerico positivo e negativo con 2 decimali fluper
  begin
    //Gestisco il valore negativo...
    if StrToFloat(Dato) < 0 then
      if Lung>1 then
        Lung:=Lung-1;
    Result:=Format('%' + IntToStr(Lung) + '.2f',[StrToFloat(Dato)]);
    Result:=StringReplace(Result,',','',[RfReplaceAll]);
    Result:=StringReplace(Result,'.','',[RfReplaceAll]);
    Result:=Format('%' + IntToStr(Lung) + '.' + IntToStr(Lung) + 'd',[StrToInt(Result)]);
  end
  else if Formato = 'VP1' then //Numerico positivo con 1 decimale fluper
  begin
    if StrToFloat(Dato) < 0 then
      Dato:='0';
    Result:=Format('%' + IntToStr(Lung) + '.1f',[StrToFloat(Dato)]);
    Result:=StringReplace(Result,',','',[RfReplaceAll]);
    Result:=StringReplace(Result,'.','',[RfReplaceAll]);
    Result:=Format('%' + IntToStr(Lung) + '.' + IntToStr(Lung) + 'd',[StrToInt(Result)]);
  end
  else if Formato = 'VN1' then //Numerico positivo e negativo con 1 decimale fluper
  begin
    //Gestisco il valore negativo...
    if StrToFloat(Dato) < 0 then
      if Lung>1 then
        Lung:=Lung-1;
    Result:=Format('%' + IntToStr(Lung) + '.1f',[StrToFloat(Dato)]);
    Result:=StringReplace(Result,',','',[RfReplaceAll]);
    Result:=StringReplace(Result,'.','',[RfReplaceAll]);
    Result:=Format('%' + IntToStr(Lung) + '.' + IntToStr(Lung) + 'd',[StrToInt(Result)]);
  end
  else if Copy(Formato,1,1) = 'L' then //inps
  begin
    if Lung=0 then
      Lung:=StrToIntDef(Copy(Formato,2,Length(Formato)),Length(Result));
    Result:=Copy(Result,1,Lung);
  end;
end;

procedure OldR180AbilitaOggetti(C:TWinControl; Abilitato:Boolean);
var i:Integer;
begin
  for i:=0 to C.ControlCount - 1 do
  begin
    if C.Controls[i] is TWinControl then
      (C.Controls[i] as TWinControl).Enabled:=Abilitato
    else if C.Controls[i] is TGraphicControl then
      (C.Controls[i] as TGraphicControl).Enabled:=Abilitato;
  end;
end;

function OldR180Sha1Encrypt(const PStr: String): String;
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

      // il digest � un array 0 based con 20 elementi (uno per ogni byte)
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

function OldR180RDL_ECB_Decrypt(const PStr,PPassPhrase: String): String;
{ PStr: criptato e Base-64
  es.PStr = 'CcFq1RCXLKuLAGFhFmtStzW3N5f0DBlGk9OmmLtTmcA=    ';
     PPassPhrase = 'Video meliora proboque deteriora sequor'
     Result = 'GP4WEB#15102015150525' (pi� qualche schifezza da eliminare)
}
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
    abtk:=DecodeBytes(HMD5b64_TK);
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

function OldR180RDL_ECB_Encrypt(const PStr,PPassPhrase: String): String;
{ PStr: criptato e Base-64
  es.PStr = 'GP4WEB#15102015150525'
     PPassPhrase = 'Video meliora proboque deteriora sequor'
     Result = 'CcFq1RCXLKuLAGFhFmtStzW3N5f0DBlGk9OmmLtTmcA=    ';
}
var
  InStream,OutStream:TStringStream;
  i: integer;
  abtk:TIdBytes;
  rawPassword: RawByteString;
begin
  Result:=PStr;
  rawPassword:=PStr;
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

function OldR180SSO_TokenUsr(Utente,Mask:String):String;
var sep,FmtTS:String;
    posusr:Integer;
const MASK_USER = 'user';
begin
  Result:=Utente;
  Mask:=LowerCase(Mask);
  //verifico che mask contenga 'user' e qualcos'altro
  if (Mask = '') or
     (Mask = MASK_USER) or
     (pos(MASK_USER,Mask) = 0) then
    exit;
  //estraggo il separatore tra user e il formato data
  posusr:=pos('user',Mask);
  if posusr = 1 then
  begin
    sep:=Copy(Mask,length(MASK_USER) + 1,1);
    FmtTS:=Copy(Mask,Pos(sep,Mask) + 1,Length(Mask));
  end
  else
  begin
    sep:=Copy(Mask,pos(MASK_USER,Mask) - 1,1);
    FmtTS:=Copy(Mask,1,Pos(sep,Mask) -1);
  end;
  if posusr = 1 then
    Result:=Result + sep + FormatDateTime(FmtTS,Now)
  else
    Result:=FormatDateTime(FmtTS,Now) + sep + Result;
end;

function OldR180SetVariable(ODS:TOracleDataset; Variabile:String; Valore:Variant):Boolean;
begin
  Result:=False;
  if ODS.GetVariable(Variabile) <> Valore then
  begin
    Result:=True;
    ODS.SetVariable(Variabile,Valore);
    ODS.Close;
  end;
end;

function OldR180CloseDataSetTag0(DS: TDataset; const DistruggiFields: Boolean = False): Boolean;
// Decrementa il tag del dataset e quindi lo chiude se il tag � <= 0
// Questo sistema � utilizzato in Irisweb per evitare la chiusura dei
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

function OldR180GetStringList(DataSet:TDataSet; Colonne:String):String;
var i,lung:Integer;
    S:String;
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
        if OldR180CercaParolaIntera(Fields[i].FieldName,Colonne,',') > 0 then
        begin
          lung:=Fields[i].Size;
          if lung = 0 then
            lung:=Fields[i].DisplayWidth;
          if lung > 0 then
            S:=S + IfThen(S <> '',' ') + Format('%-*s',[lung,Fields[i].AsString]);
        end;
      if S <> '' then
        Result:=Result + S + CRLF;
      Next;
    end;
  finally
    EnableCOntrols;
  end;
  Result:=Trim(Result);
end;

(*
function OldR180In(const Valore,lstValori:Variant):Boolean;
var i,i0,i1:Integer;
begin
  if not VarIsArray(lstValori) then
    Result:=Valore = lstValori
  else
  begin
    Result:=False;
    i0:=VarArrayLowBound(lstValori,1);
    i1:=VarArrayHighBound(lstValori,1);
    for i:=i0 to i1 do
      if Valore = lstValori[i] then
      begin
        Result:=True;
        Break;
      end;
  end;
end;
*)

function OldR180In(const Valore:String; lstValori:array of String):Boolean;
var i:Integer;
begin
  Result:=False;
  for i:=Low(lstValori) to High(lstValori) do
    if Valore = lstValori[i] then
    begin
      Result:=True;
      Break;
    end;
end;

function OldR180In(const Valore:Integer; lstValori:array of Integer):Boolean;
var i:Integer;
begin
  Result:=False;
  for i:=Low(lstValori) to High(lstValori) do
    if Valore = lstValori[i] then
    begin
      Result:=True;
      Break;
    end;
end;

function  OldR180In(const Valore:TObject; lstValori:array of TObject):Boolean; overload;
var
  i:integer;
begin
  Result:=False;
  for i:=Low(lstValori) to High(lstValori) do
    if Valore = lstValori[i] then
    begin
      Result:=True;
      Break;
    end;
end;

(*
function OldR180Between(const Valore,Da,A:Variant):Boolean;
begin
  Result:=(Valore >= Da) and (Valore <= A);
end;
*)

function OldR180Between(const Valore,Da,A:String):Boolean;
begin
  Result:=(Valore >= Da) and (Valore <= A);
end;

function OldR180Between(const Valore,Da,A:Integer):Boolean;
begin
  Result:=(Valore >= Da) and (Valore <= A);
end;

function OldR180Between(const Valore,Da,A:TDateTime):Boolean;
begin
  Result:=(Valore >= Da) and (Valore <= A);
end;

function OldR180Indenta(const PTesto: String; const PIndentazione: Integer): String;
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
  // es. a volte nel codice i ritorni a capo
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

(* Non utilizzare al momento: sono dei prototipi non funzionanti
function OldR180Decode(const Valore: Variant; KeyValueArr: array of const): Variant;
{ Emula la funzione Decode di Oracle.
    Esempio di utilizzo:
    [definizione variabili]
    var Variabile: Variant;
    var Matricola: String;
    [utilizzo funzione]
    Risultato:=R180Decode(Matricola, ['1', 500,
                                      '2', 600,
                                      '3', 700,
                                      '4', 800,
                                      1000] )
    // Matricola = '3' -> Risultato = 700
    // Matricola = '9' -> Risultato = 1000
}
var
  i, Lim, NumElem: Integer;
  function VarRecValue(Key: TVarRec): Variant;
  begin
    case Key.VType of
      vtInteger:    Result:=Key.VInteger;
      vtBoolean:    Result:=Key.VBoolean;
      vtChar:       Result:=Key.VChar;
      vtExtended:   Result:=Key.VExtended^;
      vtString:     Result:=Key.VString^;
      vtPChar:      Result:=String(Key.VPChar);
      vtObject:     Result:=Key.VObject.ClassName;
      vtClass:      Result:=Key.VClass.ClassName;
      vtAnsiString: Result:=String(Key.VAnsiString);
      vtCurrency:   Result:=Key.VCurrency^;
      vtVariant:    Result:=Key.VVariant^;
      vtInt64:      Result:=Key.VInt64^;
    else
      Result:=null;
    end;
  end;
begin
  // inizializza variabili di supporto
  NumElem:=Length(KeyValueArr);

  // determina il valore di default
  if NumElem mod 2 = 0 then
  begin
    // no valore di default
    Lim:=NumElem - 1;
    Result:=null
  end
  else
  begin
    // � indicato il valore di default
    Lim:=NumElem - 2;
    Result:=VarRecValue(KeyValueArr[NumElem - 1]);
  end;

  // ciclo di decodifica
  i:=0;
  while i <= Lim do
  begin
    if Valore = VarRecValue(KeyValueArr[i]) then
    begin
      Result:=VarRecValue(KeyValueArr[i + 1]);
      Exit;
    end;
    i:=i + 2;
  end;
end;

function OldR180DecodeStr(const Valore: Variant; KeyValueArr: array of const): String;
{ Emula la funzione Decode di Oracle, con la limitazione di tipo
  sul valore restituito.
    Esempio di utilizzo:
    [definizione variabili]
    var Altezza: Variant;
    var Risultato: String;
    [utilizzo funzione]
    Risultato:=R180DecodeStr(Variabile, [10, 'Basso',
                                         20, 'Medio',
                                         30, 'Alto',
                                         'Fuori misura',
                                      1000] )
    // Altezza = 10 -> Risultato = 'Basso'
    // Altezza = 45 -> Risultato = 'Fuori misura'
}
begin
  Result:=VarToStr(R180Decode(Valore,KeyValueArr));
end;
*)

// G E S T I O N E   S T R I N G
function OldR180Capitalize(const PTesto: String): String;
// Restituisce la stringa data con l'iniziale maiuscola
begin
  Result:=UpperCase(Copy(PTesto,1,1)) +
          LowerCase(Copy(PTesto,2,Length(PTesto) - 1));
end;

function OldR180SplittaArray(Const InStringa, Separatore:String):TArrString;
{Data una stringa ed un delimitatore, restituisce un TArrString
 (array of String, dichiarato all'interno della C180) i cui elementi
 sono rappresentati dai singoli token delimitati.
 Esempi:
  Input1  -> Value = 'aaa|bbb|ccc', Delimiter = '|'
  Output1 -> Lista[0] = 'aaa', Lista[1] = 'bbb', Lista[2] = 'ccc'
 ATTENZIONE!
 Il delimitatore dev'essere di 1 singolo caratttere}
var i:integer;
begin
  SetLength(Result,1);
  for i:=1 to Length(InStringa) do
    if Trim(InStringa[i]) <> Separatore then
      Result[High(Result)]:=Result[High(Result)] + InStringa[i]
    else
      SetLength(Result,Length(Result) + 1);
end;

procedure OldR180Tokenize(const Lista: TStrings; const Value: String; const Delimiter: String = ',');
{ Data una stringa ed un delimitatore, restituisce una stringlist i cui elementi
  sono rappresentati dai singoli token delimitati.
  Rappresenta un'alternativa all'uso di commatext, in quanto pi� flessibile.
  Il delimitatore � di tipo string e pu� contenere pi� caratteri.
  Esempi:
    Input1  -> Value = 'aaa|bbb|ccc', Delimiter = '|'
    Output1 -> Lista[0] = 'aaa', Lista[1] = 'bbb', Lista[2] = 'ccc'
    Input2  -> Value = 'aaa+++ddd+++eee', Delimiter = '+++'
    Output2 -> Lista[0] = 'aaa', Lista[1] = 'ddd', Lista[2] = 'eee'
  Nota: la gestione della StringList (creazione/distruzione) � delegata all'utilizzatore }
var
  Dx,Delta: integer;
  Testo,Token: string;
begin
  if Lista = nil then
    raise Exception.Create('Lista non inizializzata!');
  if Value = '' then
  begin
    // valore vuoto: la stringlist viene pulita
    Lista.Clear;
    Exit;
  end;
  if Delimiter = '' then
  begin
    // delimitatore vuoto: la stringlist viene caricata con un solo elemento
    Lista.Clear;
    Lista.Add(Value);
    Exit;
  end;

  Delta:=Length(Delimiter);
  Testo:=Value + Delimiter;
  Lista.BeginUpdate;
  Lista.Clear;
  // ciclo di estrazione dei token
  try
    while Length(Testo) > 0 do
    begin
      Dx:=Pos(Delimiter, Testo);
      Token:=Copy(Testo,0,Dx - 1);
      Lista.Add(Token);
      Testo:=Copy(Testo,Dx + Delta,MaxInt);
    end;
  finally
    Lista.EndUpdate;
  end;
end;

procedure OldR180SplitLines(Lista: TStrings; BreakSet: TSysCharSet = [' ',',']; MaxCol: Integer = 2000);
{ Suddivide le righe dell'oggetto TStrings indicato, mandando a capo
  il testo di ogni riga al numero di caratteri specificato in MaxCol;
  una riga potr� quindi essere divisa in 2 o pi�.
  Il BreakSet rappresenta il set di caratteri considerati separatori di parole,
  ovvero dove la riga pu� essere troncata in modo sicuro.
  es. per codice SQL si consiglia di mantenere il default: spazio e virgola.
  Attenzione!! La funzione modifica l'oggetto TStrings indicato, suddividendo
  ogni riga "lunga" in pi� righe (aggiungendo quindi elementi alla lista).

  Es.
    // input
    SQLCreato.Count = 2
    SQLCreato[0] = 'select A, B, C from T1'
    SQLCreato[1] = 'where B in (10,20,30,40,50) order by A'

    // richiamo la funzione con limite a 15 caratteri
    BreakSet:=[' ',','];
    R180SplitLines(SQLCreato,BreakSet,15);

    // output
    SQLCreato.Count = 5
    SQLCreato[0] = 'select A, B, C'
    SQLCreato[1] = 'from T1'
    SQLCreato[2] = 'where B in (10,'
    SQLCreato[3] = '20,30,40,50)
    SQLCreato[4] = 'order by A'
  }
var
  RigheList: TStringList;
  TempStr: String;
  i,j: Integer;
begin
  if Lista = nil then
    Exit;

  if Lista.Count = 0 then
    Exit;

  // creazione stringlist di appoggio
  RigheList:=TStringList.Create();
  try
    i:=0;
    while i < Lista.Count do
    begin
      if Length(Lista[i]) > MaxCol then
      begin
        // wrap del testo a 2000 caratteri
        TempStr:=WrapText(Lista[i],#13#10,BreakSet,MaxCol);

        // tokenize della riga splittata
        OldR180Tokenize(RigheList,TempStr,#13#10);

        // reimposta la stringlist originale
        Lista[i]:=RigheList[0];
        for j:=1 to RigheList.Count - 1 do
          Lista.Insert(i+j,RigheList[j]);

        i:=i + RigheList.Count - 1;
      end;
      i:=i + 1;
    end;
  finally
    FreeAndNil(RigheList);
  end;
end;

// G E S T I O N E   C A R T E L L E

function OldR180GetOSTempDir: String;
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

procedure OldR180RemoveDir(const DirName: string);
{ Elimina una directory e TUTTO il suo contenuto senza chiedere conferma
  Questa procedura utilizza chiamate ricorsive per attraversare le strutture
  delle directory, per cui vengono utilizzati i puntatori per mantenere
  minimo l'utilizzo dello stack.
}
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

        // verifica se il file corrente � in realt� una directory
        if ((Attr and SysUtils.faDirectory) = 0) then
        begin
          // il file non � una directory: verifica che non sia un file di sistema o un volume ID (C:) }
          if ((Attr and SysUtils.faSysFile) = 0) then
          begin
            // rimuove l'attributo readonly, se il file � indicato come tale
            if ((Attr and SysUtils.faReadOnly) <> 0) then
              FileSetAttr(FileName^,FileGetAttr(FileName^) and (not SysUtils.faReadOnly));

            // cancella file
            SysUtils.DeleteFile(FileName^);
          end;
        end
        else if ((Name <> '.') and (Name <> '..')) then
        begin
          // si tratta di una directory -> chiamata ricorsiva
          OldR180RemoveDir(FileName^);
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

function OldR180IsDirectoryWritable(const PDirName: String): Boolean;
// restituisce
// - True  se la directory indicata esiste ed � accessibile in scrittura
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
function OldR180GetIPFromHost(var HostName, IPaddr, WSAErr: String): Boolean;
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

function OldR180CalcoloCodiceFiscale(Cognome,Nome,Sesso,CodCat:String; DataNas:TDateTime):String;
{Routine di calcolo del codice fiscale}
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
  cod_fisc, tmp, c_contr:string;
  tmp_voc:array [1..2] of char; // contiene le prime due vocali
  tmp_cons:array [1..4] of char; // contiene le prime 4 consonanti
  Valido:boolean;
  n_voc, n_cons,k,A,M,G:Word;
function Calc_Chk(Cod_Fisc:string):string;
// calcola il carattere di controllo del codice fiscale
// ritorna 'errore' se trovato carattere non consentito
var tmp, k, posiz:Word;
begin
  if Length(Trim(Cod_Fisc)) < 15 then
    begin
    Result:='errore';
    exit;
    end;
  tmp:=0;
  k:=1;
  //Valori dei caratteri dispari
  repeat
    posiz:=Pos(Copy(Cod_Fisc, k, 1),Controllo);
    if Posiz  > 0 then
      tmp:=tmp + Dispari[posiz];
    k:=k + 2;
  until k > 15;
  k:=2;
  repeat
    posiz:=Pos(Copy(Cod_Fisc, k, 1),Controllo);
    tmp:=tmp + Pari[posiz];
    k:=k + 2;
  until k > 14;
  tmp:=(tmp mod 26) + 1;
  Result:=Copy(Controllo, tmp, 1);
end;
begin
  //FUNCTION calc_cf( cognome, nome, sesso, d_nasc, cod_cat )
  // calcola il codice fiscale noti i dati di partenza
  SetLength(Tmp,1);
  Tmp_Voc[1]:=#0;
  Tmp_Voc[2]:=#0;
  Tmp_Cons[1]:=#0;
  Tmp_Cons[2]:=#0;
  Tmp_Cons[3]:=#0;
  Tmp_Cons[4]:=#0;
  Result:='';//ECodFiscale.Field.AsString;
  if (Trim(Cognome) = '') or (Trim(Nome) = '') or (DataNas = 0) or (Trim(CodCat) = '') then
    exit;
  // calcola le lettere del cognome
  Cognome:=UpperCase(Trim(Cognome ));
  n_voc:=0;
  n_cons:=0;
  for k:=1 to Length(Cognome) do
    begin
    tmp:=Copy(Cognome, k, 1);
    if (Pos(Tmp,Vocali) > 0) and (n_voc < 2) then
      begin
      Inc(n_voc);
      Tmp_Voc[n_voc]:=Tmp[1];
      end;
    if (Pos(Tmp,Consonanti) > 0) and (n_cons < 4) then
      begin
      Inc(n_cons);
      Tmp_Cons[n_cons]:=Tmp[1];
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
  Nome:=UpperCase(Trim(Nome));
  n_voc:=0;
  n_cons:=0;
  for k:=1 to Length(Nome) do
    begin
    tmp:=Copy(Nome, k, 1);
    if (Pos(Tmp,Vocali) > 0) and (n_voc < 2) then
      begin
      Inc(n_voc);
      Tmp_Voc[n_voc]:=Tmp[1];
      end;
    if (Pos(Tmp,Consonanti) > 0) and (n_cons < 4) then
      begin
      Inc(n_cons);
      Tmp_Cons[n_cons]:=Tmp[1];
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
  Cod_Fisc:=Cod_Fisc + Copy(IntToStr(A),3,2);
  Cod_Fisc:=Cod_Fisc + Mesi[M];
  if Sesso = 'F' then
    G:=G + 40;
  if G < 10 then
    tmp:='0' + IntToStr(G)
  else
    tmp:=IntTostr(G);
  Cod_Fisc:=Cod_Fisc + tmp;
  // aggiunge codice catastale
  Cod_Fisc:= Cod_Fisc + CodCat;
  // trasforma eventuali spazi in zeri
  // Clipper - do zerpad with cod_fisc
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

function OldR180SostituisciCaratteriSpeciali(Testo:String):String;
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

procedure OldR180SetComboItemsValues(lst:TStrings; ItemsValues:array of TItemsValues; TipoLista:String);
{TipoLista: I=Item, V=Value}
var i,c:Integer;
    S:String;
begin
  lst.Clear;
  for i:=0 to High(ItemsValues) do
  begin
    S:='';
    for c:=1 to Length(TipoLista) do
    begin
      if c > 1 then
        S:=S + '=';
      if TipoLista[c] = 'I' then
        S:=S + ItemsValues[i].Item
      else if TipoLista[c] = 'V' then
        S:=S + ItemsValues[i].Value;
    end;
    lst.Add(S);
  end;
end;

//XE3
procedure OldR180DBGridSetDrawingStyle(Sender:TComponent);
var i:Integer;
begin
  for i:=0 to Sender.ComponentCount - 1 do
    if Sender.Components[i] is TDBGrid then
      TDBGrid(Sender.Components[i]).DrawingStyle:=gdsClassic;
end;

function OldR180GetCsvIntersect(const PElenco1, PElenco2: String): String;
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
  LElenco1:=Trim(PElenco1);
  if RightStr(LElenco1,1) = ',' then
    LElenco1:=LeftStr(LElenco1,Length(LElenco1) - 1);

  // trim della stringa con l'elenco 2
  // rimuove eventuale virgola finale nella stringa
  LElenco2:=Trim(PElenco2);
  if RightStr(LElenco2,1) = ',' then
    LElenco2:=LeftStr(LElenco2,Length(LElenco2) - 1);

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
      OldR180StringListIntersect(L1,L2,LIntersect);

      Result:=LIntersect.CommaText;
    except
    end;
  finally
    FreeAndNil(L1);
    FreeAndNil(L2);
    FreeAndNil(LIntersect);
  end;
end;

procedure OldR180StringListIntersect(PList1, PList2: TStringList; var RListIntersect: TStringList);
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

  // crea una nuova stringlist di appoggio
  L:=TStringList.Create;
  try
    // tratta la stringlist come fosse un insieme
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

procedure OldR180JsonString2Comp(Sender: TComponent; JsonPair: TJSONPair);
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

procedure OldR180ToolBarHandleNeeded(Sender: TWinControl);
var i:Integer;
begin
  for i:=0 to Sender.ControlCount - 1 do
    if Sender.Controls[i] is TToolbar then
      (Sender.Controls[i] as TToolbar).HandleNeeded
    else if Sender.Controls[i] is TWinControl then
      OldR180ToolBarHandleNeeded(Sender.Controls[i] as TWinControl);
end;

function OldR180NumOccorrenzeString(const Substring, Text: string): integer;
var
  offset: integer;
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

function OldR180SetPropValue(PObject: TObject; PropertyName: String; PropertyValue: Variant): Boolean;
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

function OldR180GetPropValue(PObject: TObject; PropertyName: String): Variant;
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

end.
