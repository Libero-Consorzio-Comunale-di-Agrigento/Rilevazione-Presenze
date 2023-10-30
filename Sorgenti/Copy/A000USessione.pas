unit A000USessione;

interface

uses
  SysUtils, Classes, Forms, Controls, Types, Oracle, OracleData, OracleCI, Windows,
  Registry, A000UCostanti, A000UMessaggi, C180FunzioniGenerali, System.IOUtils,
  Variants, DBClient, RegolePassword, System.SyncObjs, Data.DB;

type
  TSessioneIrisWIN = class(TComponent)
  public
    SessioneOracle:TOracleSession;
    QueryPK1:TOracleDataSet; //TQueryPK;
    RegistraLog:TOracleQuery;//TRegistraLog;
    RegistraMsg:TOracleQuery;//TRegistraMsg;
    Parametri:TParametri;
    QVistaOracle:String;
    class procedure BeforeOpenEvent(DataSet:TDataSet);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AlterSessionSessioneOracle;
    procedure ApplicationOnException(Sender:TObject; E:Exception);
  end;

var
  DataBaseDrv:TDataBaseDrv;
  {$IFNDEF IRISWEB}{$IFNDEF IRISAPP}
    // iriswin
    A000SessioneIrisWIN:TSessioneIrisWIN;
    SolaLettura,SolaLetturaOriginale:Boolean;
  {$ELSEIF Defined(WEBSVC)}
    // webservices
    // MONDOEDP - commessa MAN/09 SVILUPPO#1.ini
    // A000SessioneIrisWIN è ora una function con scope globale
    // A000SessioneIrisWIN:TSessioneIrisWIN;
    // MONDOEDP - commessa MAN/09 SVILUPPO#1.fine
  {$ENDIF}{$ENDIF}
  IntestazioneStampa:String;
  //QVistaOracle:String = QVistaOracle_Const;
  //QVistaOraclePeriodica:String = QVistaOracle_Const;

procedure A000SettaVariabiliAmbiente;
procedure A000LogonDBOracle(Sessione:TOracleSession);
procedure A000ParamDBOracle(DB:TOracleSession; RiconnessioneForzata:Boolean = True);
procedure A000SetParametri(DB:TOracleSession);
procedure A000ParamDBOracleMultiThread(SessioneIW:TSessioneIrisWIN);
procedure A000GetMsgTradotti;
function  A000GetInibizioni(TipoDato,Dato:String):Char;
function  A000GetAbilitazioniFunzioni(const PTipoDato, PDato:String): TAbilitazioniFunzioni;
function  A000OperatoreAbilitato(Prog:LongInt; DataDa,DataA:TDateTime):Boolean;
function  A000ModuloAbilitato(Sessione:TOracleSession; Modulo,Azienda:String):Boolean;
function  GetPassword:Boolean;
function  A000GetSuffissoQVista(Campo:String):String;
procedure A000GetTabella(Dato:String; var Tabella,Codice,Storico:String; Sessione:TOracleSession = nil);
procedure A000GetTabellaP430(Dato:String; var Tabella,Codice,Storico:String);
function  A000LookupTabella(Dato:String; Query:TOracleDataSet):Boolean;
procedure A000GetLayout(SessioneIW:TSessioneIrisWIN; SessioneDB:TOracleSession);
procedure A000GetChiavePrimaria(Sessione:TOracleSession; Tabella:String; L:TStringList);
function  A000selDizionarioDatiAziendali(Sessione:TOracleSession):String;
function  A000FiltroDizionario(T,C:String):Boolean;
procedure A000AggiornaFiltroDizionario(T,CodOld,C:String);
function  A000GetHomePath: String;
function  A000GetPassword(PosFilePwd:String):TStringList;
function  A000DescDatiEnte(Dato:String):String;

implementation

uses
  A000UInterfaccia, C003UPassword, QueryPK, RegistrazioneLog, Cestino
  {$IFDEF WEBSVC}
  ,Datasnap.DSSession
  {$ENDIF WEBSVC}
  ;

function GetPassword:Boolean;
var S:String;
    i,j:Integer;
begin
  Result:=True;
  C003FPassword:=TC003FPassword.Create(nil);
  with C003FPassword do
    try
      try
        Password.Text:='***********************';
        if ShowModal <> mrOK then
          begin
          Result:=False;
          Abort;
          end;
        S:=Password.Text;
        if Length(S) <> Length(Parametri.PassOper) then
          begin
          Result:=False;
          Abort;
          end;
        j:=Length(S);
        for i:=1 to Length(Parametri.PassOper) do
          if S[j] <> Parametri.PassOper[i] then
            begin
            Result:=False;
            Break;
            end
          else
            dec(j);
      finally
        Release;
      end;
    except
    end;
end;

procedure A000SettaVariabiliAmbiente;
var FS:TFormatSettings;
    i:Integer;
begin
  if CSFormatSettings <> nil then
    CSFormatSettings.Enter;
  try
    {$IFNDEF VER210}FormatSettings.{$ENDIF}DateSeparator:='/';
    {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortDateFormat:='dd/mm/yyyy';
    {$IFNDEF VER210}FormatSettings.{$ENDIF}TimeSeparator:='.';
    {$IFNDEF VER210}FormatSettings.{$ENDIF}DecimalSeparator:=',';
    {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:='.';
    {$IFNDEF VER210}FormatSettings.{$ENDIF}LongTimeFormat:='hh.nn.ss';
    if Parametri <> nil then
    begin
      {$IFDEF IRISWEB}{$IFNDEF WEBSVC}
        if Pos(INI_PAR_TRADUZIONE_CAPTION,W000ParConfig.ParametriAvanzati) > 0 then
          Parametri.Lingua:='E';
      {$ENDIF}{$ENDIF}
      if Parametri.CampiRiferimento.C1_CedoliniConValuta = 'S' then //TORINO_ITC
        Parametri.Lingua:='E';
      if Parametri.Lingua = 'I' then
      begin
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortMonthNames[1]:='gen';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortMonthNames[2]:='feb';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortMonthNames[3]:='mar';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortMonthNames[4]:='apr';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortMonthNames[5]:='mag';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortMonthNames[6]:='giu';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortMonthNames[7]:='lug';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortMonthNames[8]:='ago';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortMonthNames[9]:='set';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortMonthNames[10]:='ott';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortMonthNames[11]:='nov';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortMonthNames[12]:='dic';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[1]:='gennaio';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[2]:='febbraio';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[3]:='marzo';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[4]:='aprile';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[5]:='maggio';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[6]:='giugno';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[7]:='luglio';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[8]:='agosto';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[9]:='settembre';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[10]:='ottobre';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[11]:='novembre';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[12]:='dicembre';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortDayNames[1]:='dom';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortDayNames[2]:='lun';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortDayNames[3]:='mar';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortDayNames[4]:='mer';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortDayNames[5]:='gio';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortDayNames[6]:='ven';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortDayNames[7]:='sab';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongDayNames[1]:='domenica';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongDayNames[2]:='lunedì';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongDayNames[3]:='martedì';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongDayNames[4]:='mercoledì';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongDayNames[5]:='giovedì';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongDayNames[6]:='venerdì';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongDayNames[7]:='sabato';
      end
      else if Parametri.Lingua = 'E' then
      begin
        FS:=TFormatSettings.Create('en-GB');
        for i:=Low(FS.ShortMonthNames) to High(FS.ShortMonthNames) do
        begin
          FormatSettings.ShortMonthNames[i]:=FS.ShortMonthNames[i];
          FormatSettings.LongMonthNames[i]:=FS.LongMonthNames[i];
        end;
        for i:=Low(FS.ShortDayNames) to High(FS.ShortDayNames) do
        begin
          FormatSettings.ShortDayNames[i]:=FS.ShortDayNames[i];
          FormatSettings.LongDayNames[i]:=FS.LongDayNames[i];
        end;
      end;
    end;
    {$IFNDEF IRISWEB}{$IFNDEF IRISAPP}
    Application.UpdateFormatSettings:=False;
    {$ENDIF}{$ENDIF}
  finally
    if CSFormatSettings <> nil then
      CSFormatSettings.Leave;
  end;
end;

procedure A000LogonDBOracle(Sessione:TOracleSession);
var lstPwd:TStringList;
    i:Integer;
begin
  R180SetOracleInstantClient;
  Sessione.LogonUserName:='MONDOEDP';
  {$IFDEF IRISWEB}
    Sessione.ThreadSafe:=True;
  {$ENDIF}
  //----------------------------------------------------------------------------
  {$IFDEF IRISAPP}
    Sessione.ThreadSafe:=True;
  {$ENDIF}
  //----------------------------------------------------------------------------
  //Ricerca pwd su A000FilePwdApplication
  lstPwd:=A000GetPassword(A000FilePwdApplication);
  try
    for i:=0 to lstPwd.Count - 1 do
    try
      Sessione.LogonPassword:=lstPwd[i];
      Sessione.Logon;
      Break;
    except
      on E:Exception do
      begin
        if (DebugHook <> 0) and (Pos('ORA-01017',E.Message.ToUpper) = 0) then
        begin
          //Sessione.LogonDatabase:='IRIS';
          raise Exception.Create('DB' + Sessione.LogonDatabase + ' non raggiungibile:' + CRLF + E.Message);
          try
            Sessione.Logon;
            Break;
          except
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(lstPwd);//.Free;
  end;

  if not Sessione.Connected then
  begin
    //Ricerca pwd su A000FilePwdHost
    lstPwd:=A000GetPassword(A000FilePwdHost);
    try
      for i:=0 to lstPwd.Count - 1 do
      try
        Sessione.LogonPassword:=lstPwd[i];
        Sessione.Logon;
        Break;
      except
        on E:Exception do
        begin
          if Pos('ORA-01017',E.Message.ToUpper) = 0 then
          begin
            //Sessione.LogonDatabase:='IRIS';
            raise Exception.Create('DB' + Sessione.LogonDatabase + ' non raggiungibile:' + CRLF + E.Message);
            try
              Sessione.Logon;
              Break;
            except
            end;
          end;
        end;
      end;
    finally
      FreeAndNil(lstPwd);//.Free;
    end;
  end;

  //Se non è possibile connttersi rieseguo un ultimo logon per generare l'eccezione
  if not Sessione.Connected then
    Sessione.Logon;
  Sessione.UseOCI80:=(not Sessione.Preferences.UseOci7) and (OracleCI.OCI80);
  A000SettaVariabiliAmbiente;
end;

procedure A000ParamDBOracle(DB:TOracleSession; RiconnessioneForzata:Boolean = True);
var SetPar:TOracleQuery;
begin
  {$IFNDEF IRISWEB}
  R180SetOracleInstantClient;
  DataBaseDrv:=dbOracle;
  {$ENDIF}
  //Leggo i parametri di connessione al DataBase
  //--A000SetParametri--//Parametri.Path:=ExtractFilePath(Application.ExeName) + 'Archivi';
  ForceDirectories(Parametri.Path + '\Temp');
  //--A000SetParametri--//Parametri.DataLavoro:=Date;
  if RiconnessioneForzata or (not DB.Connected) then
    with DB do
    begin
      LogOff;
      LogonUserName:=Parametri.UserName;
      LogonPassword:=R180Decripta(Parametri.Password,21041974);
      LogonDataBase:=Parametri.Database;
      BytesPerCharacter:=bc1Byte;
      {$IFDEF IRISWEB}
        ThreadSafe:=True;
      {$ENDIF}
      //----------------------------------------------------------------------------
      {$IFDEF IRISAPP}
        ThreadSafe:=True;
      {$ENDIF}
      //----------------------------------------------------------------------------
      if Parametri.VersioneOracle >= 11 then
        Preferences.UseOci7:=False;
      try
        LogOn;
      except
        {$IFNDEF IRISWEB}
        if Pos('B006',ExtractFileName(Application.ExeName)) = 1 then
          LogonDataBase:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B006','Database','IRIS')
        else if Pos('B010',ExtractFileName(Application.ExeName)) = 1 then
          LogonDataBase:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B010','Database','IRIS')
        else if Pos('B014',ExtractFileName(Application.ExeName)) = 1 then
          LogonDataBase:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B014','Database','IRIS')
        else
          LogonDataBase:=R180GetRegistro(HKEY_CURRENT_USER,'A001','Database','IRIS');
        {$ENDIF}
        LogOn;
      end;
      UseOCI80:=(not Preferences.UseOci7) and (OracleCI.OCI80);
    end;
  SetPar:=TOracleQuery.Create(nil);
  try
    SetPar.Session:=DB;
    SetPar.SQL.Add('ALTER SESSION SET NLS_TERRITORY = AMERICA');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_DATE_FORMAT = "DD/MM/YYYY"');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_NUMERIC_CHARACTERS = ",."');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_DATE_LANGUAGE = ITALIAN');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_SORT = BINARY');
    SetPar.Execute;
  finally
    SetPar.Free;
  end;
  if Parametri.Applicazione = 'PAGHE' then
    IntestazioneStampa:='Gestione Economica'
  else if Parametri.Applicazione = 'RILPRE' then
    IntestazioneStampa:='Rilevazione Presenze'
  else if Parametri.Applicazione = 'RPWEB' then
    IntestazioneStampa:='Rilevazione Presenze'
  else if Parametri.Applicazione = 'STAGIU' then
    IntestazioneStampa:='Gestione Giuridica'
  else if Parametri.Applicazione = 'MISTRA' then
    IntestazioneStampa:='Missioni/Trasferte'
  else if Parametri.Applicazione = 'PINFO' then
    IntestazioneStampa:='Punto Informativo';
  A000SetParametri(DB);

  {$IFNDEF IRISWEB}//Applicativi client-server
  A000SettaVariabiliAmbiente;
  A000GetMsgTradotti;
  {$ENDIF}

  {$IFDEF WEBSVC}//Web services ma non IrisWEB/IrisCloud
  A000SettaVariabiliAmbiente;
  {$ENDIF}
end;

procedure A000SetParametri(DB:TOracleSession);
var SetPar:TOracleQuery;
    FormatSetting:TFormatSettings;
    //S:String;
begin
  Parametri.Path:=ExtractFilePath(Application.ExeName) + 'Archivi';
  Parametri.DataLavoro:=Date;
  SetPar:=TOracleQuery.Create(nil);
  try
    SetPar.Session:=DB;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('SELECT COUNT(*) FROM P001_TABP430 WHERE TABELLA = ''T030_ANAGRAFICO''');
    try
      A000SessioneIrisWIN.QVistaOracle:=QVistaOracle_Const;
      Parametri.V430:='T430';
      SetPar.Execute;
      if SetPar.FieldAsInteger(0) > 0 then
      begin
        Parametri.V430:='P430';
        A000SessioneIrisWIN.QVistaOracle:=QVistaOracle_Const + #13#10 + 'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)';
      end;
    except
    end;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('select count(*) from v$nls_parameters where parameter = ''NLS_CHARACTERSET'' and value like ''%UTF%''');
    try
      SetPar.Execute;
      if SetPar.FieldAsInteger(0) > 0 then
        Parametri.DBUnicode:=True;
    except
    end;
    with TCestino.create(DB) do
      try
        CaricaCestino;
      finally
        Free;
      end;
  finally
    SetPar.Free;
  end;
  try
    {$WARN SYMBOL_PLATFORM OFF}
    FormatSetting:=TFormatSettings.Create(0);  //non serve fare il free
    {$WARN SYMBOL_PLATFORM ON}
    Parametri.TimeSeparatorDef:=FormatSetting.TimeSeparator;
  except
    Parametri.TimeSeparatorDef:=':';
  end;
end;

procedure A000ParamDBOracleMultiThread(SessioneIW:TSessioneIrisWIN);
var SetPar:TOracleQuery;
    FormatSetting:TFormatSettings;
begin
  R180SetOracleInstantClient;
  DataBaseDrv:=dbOracle;
  //Leggo i parametri di connessione al DataBase
  SessioneIW.Parametri.Path:=ExtractFilePath(Application.ExeName) + 'Archivi';
  ForceDirectories(SessioneIW.Parametri.Path + '\Temp');
  SessioneIW.Parametri.DataLavoro:=Date;
  with SessioneIW.SessioneOracle do
  begin
    if not R180In(SessioneIW.Name,['B021','B110']) then
      LogOff;
    LogonUserName:=SessioneIW.Parametri.UserName;
    LogonPassword:=R180Decripta(SessioneIW.Parametri.Password,21041974);
    LogonDataBase:=SessioneIW.Parametri.Database;
    if SessioneIW.Parametri.VersioneOracle >= 11 then
      Preferences.UseOci7:=False;
    BytesPerCharacter:=bc1Byte;
    {$IFDEF IRISWEB}
      ThreadSafe:=True;
    {$ENDIF}
    {$IFDEF IRISAPP}
      ThreadSafe:=True;
    {$ENDIF}
    try
      LogOn;
    except
      if Pos('B006',ExtractFileName(Application.ExeName)) = 1 then
        LogonDataBase:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B006','Database','IRIS')
      else if Pos('B010',ExtractFileName(Application.ExeName)) = 1 then
        LogonDataBase:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B010','Database','IRIS')
      else if Pos('B014',ExtractFileName(Application.ExeName)) = 1 then
        LogonDataBase:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B014','Database','IRIS')
      else
        LogonDataBase:=R180GetRegistro(HKEY_CURRENT_USER,'A001','Database','IRIS');
      LogOn;
    end;
    UseOCI80:=(not Preferences.UseOci7) and (OracleCI.OCI80);
  end;
  SetPar:=TOracleQuery.Create(nil);
  try
    SetPar.Session:=SessioneIW.SessioneOracle;
    SetPar.SQL.Add('ALTER SESSION SET NLS_TERRITORY = AMERICA');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_DATE_FORMAT = "DD/MM/YYYY"');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_NUMERIC_CHARACTERS = ",."');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_DATE_LANGUAGE = ITALIAN');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_SORT = BINARY');
    SetPar.Execute;
    //SetPar.SQL.Clear;
    //SetPar.SQL.Add('ALTER SESSION SET CURSOR_SHARING = FORCE');
    //SetPar.Execute;
    {P430}SetPar.SQL.Clear;
    SetPar.SQL.Add('SELECT COUNT(*) FROM P001_TABP430 WHERE TABELLA = ''T030_ANAGRAFICO''');
    try
      SessioneIW.QVistaOracle:=QVistaOracle_Const;
      SessioneIW.Parametri.V430:='T430';
      SetPar.Execute;
      if SetPar.FieldAsInteger(0) > 0 then
      begin
        SessioneIW.Parametri.V430:='P430';
        SessioneIW.QVistaOracle:=QVistaOracle_Const + #13#10 + 'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)';
      end;
    except
    {P430}end;
  finally
    SetPar.Free;
  end;
  if SessioneIW.Parametri.Applicazione = 'PAGHE' then
    IntestazioneStampa:='Gestione Economica'
  else if SessioneIW.Parametri.Applicazione = 'RILPRE' then
    IntestazioneStampa:='Rilevazione Presenze'
  else if SessioneIW.Parametri.Applicazione = 'RPWEB' then
    IntestazioneStampa:='Rilevazione Presenze'
  else if SessioneIW.Parametri.Applicazione = 'STAGIU' then
    IntestazioneStampa:='Gestione Giuridica'
  else if SessioneIW.Parametri.Applicazione = 'MISTRA' then
    IntestazioneStampa:='Missioni/Trasferte'
  else if SessioneIW.Parametri.Applicazione = 'PINFO' then
    IntestazioneStampa:='Punto Informativo';
  try
    {$WARN SYMBOL_PLATFORM OFF}
    FormatSetting:=TFormatSettings.Create(0);  //non serve fare il free
    {$WARN SYMBOL_PLATFORM ON}
    Parametri.TimeSeparatorDef:=FormatSetting.TimeSeparator;
  except
    Parametri.TimeSeparatorDef:=':';
  end;
  A000SettaVariabiliAmbiente;
end;

procedure A000GetMsgTradotti;
var selI015:TOracleDataSet;
    cdsI015:TClientDataSet;
    i:Integer;
begin
  // utilizzo di clientdataset cdsI015 per localizzazione
  if (Parametri.CampiRiferimento.C90_Lingua = '') (*or
     (UpperCase(Parametri.CampiRiferimento.C90_Lingua) = 'ITALIANO')*) then
    exit;
  selI015:=nil;
  if Parametri.cdsI015 = nil then
  try
    cdsI015:=TClientDataSet.Create(nil);
    selI015:=TOracleDataSet.Create(nil);
    selI015.Session:=SessioneOracle;
    selI015.SQL.Text:='select I015.*' + #13#10 +
                      'from   MONDOEDP.I015_TRADUZIONI_CAPTION I015' + #13#10 +
                      'where  I015.AZIENDA = :AZIENDA' + #13#10 +
                      'and    I015.LINGUA = :LINGUA' + #13#10 +
                      'and    I015.APPLICAZIONE = :APPLICAZIONE' + #13#10 +
                      'order by I015.MASCHERA, I015.COMPONENTE';
    selI015.DeclareAndSet('AZIENDA',otString,Parametri.Azienda);
    selI015.DeclareAndSet('LINGUA',otString,UpperCase(Parametri.CampiRiferimento.C90_Lingua));
    selI015.DeclareAndSet('APPLICAZIONE',otString,'W000');
    try
      selI015.Open;
      cdsI015.Filtered:=False;
      cdsI015.Close;
      cdsI015.FieldDefs.Assign(selI015.FieldDefs);
      cdsI015.FieldDefs.Find('CAPTION').Required:=False;
      cdsI015.CreateDataSet;
      cdsI015.LogChanges:=False;
      cdsI015.IndexDefs.Clear;
      cdsI015.IndexDefs.Add('Primario',('LINGUA;APPLICAZIONE;MASCHERA'),[]);
      selI015.First;
      while not selI015.Eof do
      begin
        cdsI015.Append;
        for i:=0 to selI015.FieldCount - 1 do
          cdsI015.Fields[i].Value:=selI015.Fields[i].Value;
        cdsI015.Post;
        selI015.Next;
      end;
      if cdsI015.RecordCount > 0 then
        Parametri.cdsI015:=cdsI015
      else
        FreeAndNil(cdsI015);
    except
    end;
  finally
    if Assigned(selI015) then
      FreeAndNil(selI015);
  end;
end;

function A000GetHomePath: String;
begin
  Result:=R180GetRegistro(HKEY_LOCAL_MACHINE,'','HOME','C:\IrisWIN').Trim;
end;

function A000GetPassword(PosFilePwd:String):TStringList;
//Restituisce la password criptata su file
var L:TStringList;
    HomePath,FilePwd:String;
begin
  Result:=TStringList.Create;
  L:=TStringList.Create;
  try
    try
      if PosFilePwd = A000FilePwdHost then
        HomePath:=IncludeTrailingPathDelimiter(A000GetHomePath)
      else
      begin
        HomePath:='.\';
        {$IFNDEF IRISWEB}{$IFNDEF WEBSVC}
        HomePath:=ExtractFilePath(Application.ExeName);
        {$ENDIF}{$ENDIF}
      end;
      for FilePwd in TDirectory.GetFiles(HomePath,'IrisWIN*.ini') do
      begin
        L.LoadFromFile(FilePwd);
        if L.Count > 0 then
          Result.Add(R180Decripta(L[0],20111972));
      end;
    except
      raise;
    end;
  finally
    L.Free;
    Result.Add(A000PasswordFissa);
    Result.Add(A000PasswordFissa2);
  end;
end;

function A000DescDatiEnte(Dato:String):String;
var i:Integer;
begin
  Result:='';
  for i:=1 to High(DatiEnte) do
    if DatiEnte[i].Nome = Dato then
    begin
      Result:=DatiEnte[i].Desc;
      Break;
    end;
end;

function A000GetInibizioni(TipoDato,Dato:String):Char;
{Restituisce il tipo di abilitazione sulla funzione specificata:
R = ReadOnly; S = Scrittura; N = Negato
TipoDato può essere: 'Funzione','Tag'}
var i:Integer;
begin
  Result:='N';
  if (UpperCase(TipoDato) = 'TAG') and (StrToIntDef(Dato,-1) < 0) then
  begin
    Result:='S';
    exit;
  end;
  for i:=0 to High(Parametri.AbilitazioniFunzioni) do
  begin
    if UpperCase(TipoDato) = 'FUNZIONE' then
    begin
      if UpperCase(Parametri.AbilitazioniFunzioni[i].Funzione) = UpperCase(Dato) then
      begin
        Result:=Parametri.AbilitazioniFunzioni[i].Inibizione;
        if Parametri.AbilitazioniFunzioni[i].Tag = 421 then
          Result:='S';
        Break;
      end;
    end
    else if UpperCase(TipoDato) = 'TAG' then
      if Parametri.AbilitazioniFunzioni[i].Tag = StrToIntDef(Dato,-1) then
      begin
        Result:=Parametri.AbilitazioniFunzioni[i].Inibizione;
        if Parametri.AbilitazioniFunzioni[i].Tag = 421 then
          Result:='S';
        Break;
      end;
  end;
  //{$IFNDEF IRISWEB}
  //if Result = 'N' then
  //  SolaLettura:=SolaLetturaOriginale;
  //{$ENDIF}
end;

function A000GetAbilitazioniFunzioni(const PTipoDato, PDato:String): TAbilitazioniFunzioni;
var
  i, LDatoInt: Integer;
  LDatoStr: String;
  LCercaFunzione: Boolean;
begin
  // imposta variabili per la ricerca
  LDatoStr:=PDato.ToUpper;
  LDatoInt:=-1;
  LCercaFunzione:=(PTipoDato.ToUpper = 'FUNZIONE');
  if LCercaFunzione then
    LDatoStr:=PDato.ToUpper
  else
    LDatoInt:=StrToIntDef(PDato,-1);

  // imposta record fittizio se dato non trovato
  Result.Descrizione:='';
  Result.Funzione:='';
  Result.Tag:=0;
  Result.Inibizione:=#0;
  Result.AccessoBrowse:='';
  Result.RighePagina:=0;

  // effettua la ricerca del record corrispondente
  for i:=0 to High(Parametri.AbilitazioniFunzioni) do
  begin
    if LCercaFunzione then
    begin
      if Parametri.AbilitazioniFunzioni[i].Funzione.ToUpper = LDatoStr then
      begin
        Result:=Parametri.AbilitazioniFunzioni[i];
        Break;
      end;
    end
    else
    begin
      if Parametri.AbilitazioniFunzioni[i].Tag = LDatoInt then
      begin
        Result:=Parametri.AbilitazioniFunzioni[i];
        Break;
      end;
    end;
  end;
end;

function A000OperatoreAbilitato(Prog:LongInt; DataDa,DataA:TDateTime) : Boolean;
begin
  Result:=True;
  if Parametri.OperBloc then
    with TOracleQuery.Create(nil) do
    try
      Session:=SessioneOracle;
      SQL.Add('SELECT COUNT(*) FROM T070_SCHEDARIEPIL WHERE');
      SQL.Add('PROGRESSIVO = ' + IntToStr(Prog) + ' AND');
      SQL.Add('DATA BETWEEN ''' + FormatDateTime('dd/mm/yyyy',R180InizioMese(DataDa)) + '''');
      SQL.Add('AND ''' + FormatDateTime('dd/mm/yyyy',R180InizioMese(DataA)) + '''');
      Execute;
      if Field(0) > 0 then
        Result:=Parametri.AbilitaSchedeChiuse = 'S';
      Close;
    finally
      Free;
    end;
end;

function A000ModuloAbilitato(Sessione:TOracleSession; Modulo,Azienda:String):Boolean;
var SQLtext:String;
begin
  Result:=True;
  try
    with TOracleDataSet.Create(nil) do
    try
      Session:=Sessione;
      SQLtext:='SELECT * FROM MONDOEDP.I080_MODULI WHERE MODULO = ''' + R180Cripta(Modulo,14091943) + '''';
      SQLtext:=SQLtext + ' AND AZIENDA = ''' + UpperCase(Azienda) + '''';
      SQL.Add(SQLtext);
      Open;
      if RecordCount = 0 then
        Result:=False;
    finally
      Free;
    end;
  except
  end;
end;

function A000GetSuffissoQVista(Campo:String):String;
begin
  if (Pos('T430',Campo) <> 1) and ((Pos('P430',Campo) <> 1)) then
  begin
    if (UpperCase(Campo) = 'CITTA') or (UpperCase(Campo) = 'PROVINCIA') then
      Campo:='T480.'
    else
      Campo:='T030.';
  end;
end;

procedure A000GetTabella(Dato:String; var Tabella,Codice,Storico:String; Sessione:TOracleSession = nil);
const StruttT430:Array[1..45] of TStruttT430 =
      ((Campo:'PROGRESSIVO';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'DATADECORRENZA';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'DATAFINE';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'BADGE';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'EDBADGE';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'INDIRIZZO';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'COMUNE';Tabella:'T480_COMUNI';Codice:'CODICE';Storico:'N'),
       (Campo:'CAP';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'TELEFONO';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'INIZIO';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'FINE';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'TIPOOPE';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'TERMINALI';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'CAUSSTRAORD';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'STRAORDE';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'STRAORDU';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'STRAORDEU';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'STRAORDEU2';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'CONTRATTO';Tabella:'T200_CONTRATTI';Codice:'CODICE';Storico:'N'),
       (Campo:'ORARIO';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'HTEORICHE';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'PERSELASTICO';Tabella:'T025_CONTMENSILI';Codice:'CODICE';Storico:'N'),
       (Campo:'TGESTIONE';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'PLUSORA';Tabella:'T060_PLUSORARIO';Codice:'CODICE';Storico:'N'),
       (Campo:'CALENDARIO';Tabella:'T010_CALENDIMPOSTAZ';Codice:'CODICE';Storico:'N'),
       (Campo:'IPRESENZA';Tabella:'T163_CODICIINDENNITA';Codice:'CODICE';Storico:'N'),
       (Campo:'PORARIO';Tabella:'T220_PROFILIORARI';Codice:'CODICE';Storico:'S'),
       (Campo:'PASSENZE';Tabella:'T261_DESCPROFASS';Codice:'CODICE';Storico:'N'),
       (Campo:'ABCAUSALE1';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'ABPRESENZA1';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'SQUADRA';Tabella:'T603_SQUADRE';Codice:'CODICE';Storico:'N'),
       (Campo:'TIPORAPPORTO';Tabella:'T450_TIPORAPPORTO';Codice:'CODICE';Storico:'N'),
       (Campo:'PARTTIME';Tabella:'T460_PARTTIME';Codice:'CODICE';Storico:'N'),
       (Campo:'DOCENTE';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'TIPO_LOCALITA_DIST_LAVORO';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'COD_LOCALITA_DIST_LAVORO';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'QUALIFICAMINIST';Tabella:'T470_QUALIFICAMINIST';Codice:'CODICE';Storico:'S'),
       (Campo:'MEDICINA_LEGALE';Tabella:'T485_MEDICINELEGALI';Codice:'CODICE';Storico:'N'),
       (Campo:'INIZIO_IND_MAT';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'FINE_IND_MAT';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'INDIRIZZO_DOM_BASE';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'COMUNE_DOM_BASE';Tabella:'T480_COMUNI';Codice:'CODICE';Storico:'N'),
       (Campo:'CAP_DOM_BASE';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'AZIENDA_BASE';Tabella:'T440_AZIENDE_BASE';Codice:'CODICE';Storico:'N'),
       (Campo:'RAPPORTI_UNIFICATI';Tabella:'T430_STORICO';Codice:'';Storico:'N')
       );
var I500:TOracleQuery;
    i:Integer;
begin
  Storico:='N';
  Tabella:='';
  Codice:='';
  if Dato = '' then exit;
  for i:=1 to High(StruttT430) do
  begin
    if UpperCase(Dato) = StruttT430[i].Campo then
    begin
      Tabella:=StruttT430[i].Tabella;
      Codice:=StruttT430[i].Codice;
      Storico:=StruttT430[i].Storico;
      Break;
    end;
  end;
  if Tabella = '' then
  begin
    I500:=TOracleQuery.Create(nil);
    try
      if Sessione = nil then
        I500.Session:=SessioneOracle
      else
        I500.Session:=Sessione;
      I500.SQL.Add('SELECT TABELLA,STORICO FROM I500_DATILIBERI WHERE UPPER(NOMECAMPO) = ''' + UpperCase(Dato) + '''');
      I500.Execute;
      if I500.RowsProcessed > 0 then
      begin
        if I500.Field('TABELLA') = 'S' then
        begin
          Tabella:='I501' + Dato;
          Codice:='CODICE';
          Storico:=I500.Field('STORICO');
        end
        else
          Tabella:='T430_STORICO';
      end;
      I500.Close;
    except
    end;
    I500.Free;
  end;
  if Tabella = 'T430_STORICO' then
    Codice:=Dato;
end;

procedure A000GetTabellaP430(Dato:String; var Tabella,Codice,Storico:String);
const StruttP430:Array[1..42] of TStruttT430 =
      ((Campo:'PROGRESSIVO';Tabella:'P430_ANAGRAFICO';Codice:'';Storico:'N'),
       (Campo:'DECORRENZA';Tabella:'P430_ANAGRAFICO';Codice:'';Storico:'N'),
       (Campo:'DECORRENZA_FINE';Tabella:'P430_ANAGRAFICO';Codice:'';Storico:'N'),
       (Campo:'COD_CONTRATTO';Tabella:'P210_CONTRATTI';Codice:'COD_CONTRATTO';Storico:'N'),
       (Campo:'COD_PARAMETRISTIPENDI';Tabella:'P212_PARAMETRISTIPENDI';Codice:'COD_PARAMETRISTIPENDI';Storico:'S'),
       (Campo:'COD_TIPOASSOGGETTAMENTO';Tabella:'P240_TIPIASSOGGETTAMENTI';Codice:'COD_TIPOASSOGGETTAMENTO';Storico:'S'),
       (Campo:'COD_POSIZIONE_ECONOMICA';Tabella:'P220_LIVELLI';Codice:'COD_POSIZIONE_ECONOMICA';Storico:'S'),
       (Campo:'COD_PARTTIME';Tabella:'P040_PARTTIME';Codice:'COD_PARTTIME';Storico:'N'),
       (Campo:'PROGRESSIVO_EREDE_DI';Tabella:'T030_ANAGRAFICO';Codice:'PROGRESSIVO';Storico:'N'),
       (Campo:'COD_BANCA';Tabella:'P010_BANCHE';Codice:'COD_BANCA';Storico:'N'),
       (Campo:'COD_STATOCIVILE';Tabella:'P020_STATOCIVILE';Codice:'COD_STATOCIVILE';Storico:'N'),
       (Campo:'COD_NAZIONALITA';Tabella:'P120_NAZIONALITA';Codice:'COD_NAZIONALITA';Storico:'N'),
       (Campo:'COD_PAGAMENTO';Tabella:'P130_PAGAMENTI';Codice:'COD_PAGAMENTO';Storico:'N'),
       (Campo:'COD_VALUTA_STAMPA';Tabella:'P030_VALUTE';Codice:'COD_VALUTA';Storico:'S'),
       (Campo:'COD_CAUSALEIRPEF';Tabella:'P080_CAUSALIIRPEF';Codice:'COD_CAUSALEIRPEF';Storico:'N'),
       (Campo:'COD_REGIONE_IRPEF';Tabella:'T482_REGIONI';Codice:'COD_REGIONE';Storico:'N'),
       (Campo:'COD_COMUNE_IRPEF';Tabella:'T480_COMUNI';Codice:'CODICE';Storico:'N'),
       (Campo:'COD_DEDUZIONEIRPEF';Tabella:'P082_DEDUZIONIIRPEF';Codice:'COD_DEDUZIONEIRPEF';Storico:'N'),
       (Campo:'COD_TABELLAANF';Tabella:'P236_TABELLEANF';Codice:'COD_TABELLAANF';Storico:'S'),
       (Campo:'COD_CODICEINPS';Tabella:'P090_CODICIINPS';Codice:'COD_CODICEINPS';Storico:'S'),
       (Campo:'COD_INQUADRINPS';Tabella:'P096_INQUADRINPS';Codice:'COD_INQUADRINPS';Storico:'S'),
       (Campo:'COD_EMENSTIPOASS';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_EMENSTIPOCESS';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_TIPORAPP_COCOCO';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_TIPOATT_COCOCO';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_ALTRAASS_COCOCO';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_CUDINPDAPCAUSACESS';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_INQUADRINPDAP';Tabella:'P094_INQUADRINPDAP';Codice:'COD_INQUADRINPDAP';Storico:'S'),
       (Campo:'COD_CODICEINAIL';Tabella:'P092_CODICIINAIL';Codice:'COD_CODICEINAIL';Storico:'S'),
       (Campo:'COD_QUALIFICA_INAIL';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_COMUNE_INAIL';Tabella:'T480_COMUNI';Codice:'CODCATASTALE';Storico:'N'),
       (Campo:'COD_CATEGPARTICOLARE';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_CAUSALELA';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_ONAOSITIPOPAG';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_ONAOSITIPOASS';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_ONAOSITIPOCESS';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_FPC';Tabella:'P026_FONDIPREVCOMPL';Codice:'COD_FPC';Storico:'S'),
       (Campo:'COD_INPDAPMOTIVOSOSP_FPC';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_INPDAPTIPOCESS_FPC';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_CATEG_CONVENZ';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_INPDAPTIPOLS_ALTRA_AMM';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_ENTE_APPARTENENZA';Tabella:'P015_ENTIAPPARTENENZA';Codice:'COD_ENTE_APPARTENENZA';Storico:'N')
       );
var i:Integer;
begin
  Storico:='N';
  Tabella:='';
  Codice:='';
  if Dato = '' then exit;
  for i:=1 to High(StruttP430) do
    if UpperCase(Dato) = StruttP430[i].Campo then
    begin
      Tabella:=StruttP430[i].Tabella;
      Codice:=StruttP430[i].Codice;
      Storico:=StruttP430[i].Storico;
      Break;
    end;
end;

function A000LookupTabella(Dato:String; Query:TOracleDataSet):Boolean;
var Tabella,Codice,Storico:String;
    lst:TStringList;
begin
  Result:=False;
  A000GetTabella(Dato,Tabella,Codice,Storico);
  if Tabella <> '' then
  begin
    Result:=True;
    if Query = nil then
      exit;
    lst:=TStringList.Create;
    try
      if (Dato.ToUpper = 'COD_LOCALITA_DIST_LAVORO') and (Tabella.ToUpper = 'T430_STORICO') then
      //Caso particolare di COD_LOCALITA_DIST_LAVORO
      begin
        lst.Text:=
          'select distinct' + CRLF +
          '  T430.COD_LOCALITA_DIST_LAVORO CODICE,' + CRLF +
          '  decode(T430.TIPO_LOCALITA_DIST_LAVORO,''C'',T480.CITTA,''P'',M042.DESCRIZIONE) DESCRIZIONE' + CRLF +
          'from T430_STORICO T430, T480_COMUNI T480, M042_LOCALITA M042' + CRLF +
          'where T430.COD_LOCALITA_DIST_LAVORO = T480.CODICE(+)' + CRLF +
          'and   T430.COD_LOCALITA_DIST_LAVORO = M042.CODICE(+)' + CRLF +
          'and   decode(T430.TIPO_LOCALITA_DIST_LAVORO,''C'',T480.CITTA,''P'',M042.DESCRIZIONE) is not null' + CRLF +
          'order by 1';
      end
      else
      //Gestione standard
      begin
        lst.Add(Format('SELECT DISTINCT %s CODICE,',[Codice]));
        if Tabella = 'T430_STORICO' then
          lst.Add('NULL DESCRIZIONE')
        else if Tabella = 'T480_COMUNI' then
          lst.Add('CITTA DESCRIZIONE')
        else
          lst.Add('DESCRIZIONE');
        lst.Add(Format(' FROM %s T1 WHERE %s IS NOT NULL :FILTRO',[Tabella,Codice]));
        if Storico = 'S' then
          if Copy(Tabella,1,4) = 'I501' then
            lst.Add(' AND :DECORRENZA BETWEEN DECORRENZA AND DECORRENZA_FINE')
          else
            lst.Add(Format(' AND DECORRENZA = (SELECT MAX(DECORRENZA) FROM %s WHERE %s = T1.%s AND DECORRENZA <= :DECORRENZA)',[Tabella,Codice,Codice]));
        lst.Add(' ORDER BY 1');
      end;
      if lst.Text <> Query.SQL.Text then
      begin
        Query.SQL.Assign(lst);
        Query.DeleteVariables;
        Query.DeclareAndSet('FILTRO',otSubst,null);
        if Storico = 'S' then
          Query.DeclareVariable('DECORRENZA',otDate);
        Query.Close;
      end;
    finally
      lst.Free;
    end;
  end;
end;

procedure A000GetChiavePrimaria(Sessione:TOracleSession; Tabella:String; L:TStringList);
{Restituisce in L l'elenco delle colonne che fanno parte della chiave primaria}
var OwnerMondoEDP:Boolean;
begin
  OwnerMondoEDP:=Pos('MONDOEDP.',UpperCase(Tabella)) > 0;
  Tabella:=StringReplace(Tabella,'MONDOEDP.','',[rfIgnoreCase]);
  with TOracleDataSet.Create(nil) do
  try
    Session:=Sessione;
    if OwnerMondoEDP and (Sessione.LogonUsername.ToUpper <> 'MONDOEDP') then
      SQL.Add('SELECT COLUMN_NAME FROM ALL_CONS_COLUMNS T1,ALL_CONSTRAINTS T2 WHERE')
    else
      SQL.Add('SELECT COLUMN_NAME FROM USER_CONS_COLUMNS T1,USER_CONSTRAINTS T2 WHERE');
    SQL.Add('T1.TABLE_NAME = T2.TABLE_NAME AND');
    SQL.Add('T1.CONSTRAINT_NAME = T2.CONSTRAINT_NAME AND');
    SQL.Add('T1.TABLE_NAME = ''' + UpperCase(Tabella) + ''' AND ');
    SQL.Add('CONSTRAINT_TYPE = ''P''');
    if OwnerMondoEDP then
      SQL.Add('AND T1.OWNER = ''MONDOEDP'' AND T2.OWNER = ''MONDOEDP''');
    SQL.Add('ORDER BY POSITION');
    Open;
    L.Clear;
    while not Eof do
      begin
      L.Add(FieldByName('COLUMN_NAME').AsString);
      Next;
      end;
    Close;
  finally
    Free;
  end;
end;

procedure A000GetLayout(SessioneIW:TSessioneIrisWIN; SessioneDB:TOracleSession);
begin
  with TOracleDataSet.Create(SessioneDB) do
  try
    try
      Session:=SessioneDB;
      if SessioneIW.Parametri.Username = '' then
        SQL.Text:='SELECT DISTINCT NOME FROM T033_LAYOUT'
      else
        SQL.Text:='SELECT DISTINCT NOME FROM ' + SessioneIW.Parametri.Username + '.T033_LAYOUT';
      Open;
      if SearchRecord('NOME',SessioneIW.Parametri.Layout,[srFromBeginning]) then
        SessioneIW.Parametri.Layout:=FieldByName('NOME').AsString
      else if SearchRecord('NOME',SessioneIW.Parametri.Operatore,[srFromBeginning]) then
        SessioneIW.Parametri.Layout:=FieldByName('NOME').AsString
      else
        SessioneIW.Parametri.Layout:='DEFAULT';
      Close;
    except;
      SessioneIW.Parametri.Layout:='DEFAULT';
    end;
  finally
    Free;
  end;
end;

function A000selDizionarioDatiAziendali(Sessione:TOracleSession):String;
var Schema,Tabella,Codice,Storico,Dato:String;
begin
  Result:='';
  Schema:=SessioneOracle.LogonUsername;
  if Sessione <> nil then
    Schema:=Sessione.LogonUsername;
  if Schema = '' then
    exit;

  with TOracleDataSet.Create(nil) DO
  try
    Session:=SessioneOracle;
    SQL.Text:=Format('select TIPO, DATO from MONDOEDP.I091_DATIENTE where AZIENDA in (select AZIENDA from MONDOEDP.I090_ENTI where UTENTE = ''%s'') and (TIPO like ''C22%%'' or TIPO like ''C29%%'') and DATO is not null',[Schema]);
    Open;

    Dato:=VarToStr(Lookup('TIPO','C22_ENTE_GIURIDICO','DATO'));
    A000GetTabella(Dato,Tabella,Codice,Storico,Sessione);
    if (Tabella <> '') and (Tabella <> 'T430_STORICO') then
      Result:=Result + ' UNION' + #13#10 + 'SELECT DISTINCT ''AUTOCERTIFICAZIONI: ENTI'' TABELLA, ' + Codice + ' CODICE FROM ' + Tabella;

    Dato:=VarToStr(Lookup('TIPO','C22_QUALIFICA_GIURIDICO','DATO'));
    A000GetTabella(Dato,Tabella,Codice,Storico,Sessione);
    if (Tabella <> '') and (Tabella <> 'T430_STORICO') then
      Result:=Result + ' UNION' + #13#10 + 'SELECT DISTINCT ''AUTOCERTIFICAZIONI: QUALIFICHE'' TABELLA, ' + Codice + ' CODICE FROM ' + Tabella;

    Dato:=VarToStr(Lookup('TIPO','C22_DISCIPLINA_GIURIDICO','DATO'));
    A000GetTabella(Dato,Tabella,Codice,Storico,Sessione);
    if (Tabella <> '') and (Tabella <> 'T430_STORICO') then
      Result:=Result + ' UNION' + #13#10 + 'SELECT DISTINCT ''AUTOCERTIFICAZIONI: DISCIPLINE'' TABELLA, ' + Codice + ' CODICE FROM ' + Tabella;

    Dato:=VarToStr(Lookup('TIPO','C29_CHIAMATEREP_FILTRO1','DATO'));
    A000GetTabella(Dato,Tabella,Codice,Storico,Sessione);
    if (Tabella <> '') and (Tabella <> 'T430_STORICO') then
      Result:=Result + ' UNION' + #13#10 + 'SELECT DISTINCT ''CAMBIO TURNI REPERIBILITA'' TABELLA, ' + Codice + ' CODICE FROM ' + Tabella;
  finally
    Free;
  end;

end;

function A000FiltroDizionario(T,C:String):Boolean;
{Filtro sulle seguenti tabelle:
CAUSALI ASSENZA
RAGGRUPPAMENTI ASSENZA
PROFILI ASSENZA
CAUSALI PRESENZA
RAGGRUPPAMENTI PRESENZA
MODELLI ORARIO
PROFILI ORARIO
CALENDARI
TURNI REPERIBILITA
GENERATORE DI STAMPE
PARAMETRIZZAZIONI CARTELLINO
TIPOLOGIA TRASFERTA
GRUPPI PESATURE INDIVIDUALI
GRUPPI SC.QUANTITATIVE IND.
RIMBORSI MISSIONI
PROFILI PIANIF. TURNI
OROLOGI DI TIMBRATURA
}
var i:Integer;
begin
  Result:=True;
  for i:=0 to High(Parametri.FiltroDizionario) do
    if Parametri.FiltroDizionario[i].Tabella = T then
    begin
      //Elementi del cestino: sempre esclusi
      if Parametri.FiltroDizionario[i].Cestino and (Parametri.FiltroDizionario[i].Codice = C) then
      begin
        Result:=False;
        exit;
      end
      //Elementi NON del cestino: comportamento normale
      else if not Parametri.FiltroDizionario[i].Cestino then
      begin
        Result:=not Parametri.FiltroDizionario[i].Abilitato;
        if Parametri.FiltroDizionario[i].Codice = C then
        begin
          Result:=not Result;
          Break;
        end;
      end;
    end;
end;

procedure A000AggiornaFiltroDizionario(T,CodOld,C:String);
var OQ:TOracleQuery;
    T1,C1:String;
    EsisteTabella,Abilitato:Boolean;
    i,iOld:Integer;
  {procedure CorreggiFiltroDizionarioVuotoOLD(T,C:String);
  var selI074:TOracleDataSet;
      insDizionario:TOracleQuery;
  begin
    selI074:=TOracleDataSet.Create(nil);
    insDizionario:=TOracleQuery.Create(nil);
    with selI074 do
    try
      Session:=SessioneOracle;
      SQL.Clear;
      SQL.Add('SELECT PROFILO,MAX(CODICE) CODICE FROM MONDOEDP.I074_FILTRODIZIONARIO');
      SQL.Add(Format('WHERE TABELLA = ''%s'' and AZIENDA = ''%s''',[T,Parametri.Azienda]));
      SQL.Add(Format('AND PROFILO = (SELECT FILTRO_DIZIONARIO FROM MONDOEDP.I070_UTENTI WHERE PROGRESSIVO = %d)',[Parametri.ProgOper]));
      SQL.Add('GROUP BY PROFILO HAVING COUNT(*) = 1 AND MAX(CODICE) = ''' + C + '''');
      Open;
      if RecordCount > 0 then
      begin
        insDizionario.Session:=SessioneOracle;
        insDizionario.SQL.Clear;
        insDizionario.SQL.Add('INSERT INTO MONDOEDP.I074_FILTRODIZIONARIO (PROFILO,TABELLA,CODICE,ABILITATO,AZIENDA)');
        insDizionario.SQL.Add('SELECT ''' + FieldByName('PROFILO').AsString + ''',A.TABELLA,A.CODICE,''N'',''' + Parametri.Azienda + ''' FROM (');
        insDizionario.SQL.Add(A000selDizionario + A000selDizionarioDatiAziendali(insDizionario.Session) + A000selDizionarioSicurezzaRiepiloghi);
        insDizionario.SQL.Add(') A');
        insDizionario.SQL.Add('WHERE A.TABELLA = ''' + T + ''' AND A.CODICE <> ''' + C + '''');
        try
          insDizionario.Execute;
          SessioneOracle.Commit;
        except
          raise;
        end;
        SetLength(Parametri.FiltroDizionario,Length(Parametri.FiltroDizionario) + 1);
        Parametri.FiltroDizionario[High(Parametri.FiltroDizionario)].Tabella:=T;
        Parametri.FiltroDizionario[High(Parametri.FiltroDizionario)].Codice:='TABELLA DISABILITATA';
        Parametri.FiltroDizionario[High(Parametri.FiltroDizionario)].Abilitato:=True;
        Parametri.FiltroDizionario[High(Parametri.FiltroDizionario)].Cestino:=False;
      end;
    finally
      Free;
      insDizionario.Free;
    end;
  end;}

  procedure CorreggiFiltroDizionarioVuoto(T,C:String);
  var selI074:TOracleDataSet;
      insDizionarioMOD:TOracleQuery;
  begin
    selI074:=TOracleDataSet.Create(nil);
    insDizionarioMOD:=TOracleQuery.Create(nil);
    with selI074 do
    try
      Session:=SessioneOracle;
      SQL.Clear;
      SQL.Add('SELECT PROFILO,MAX(CODICE) CODICE FROM MONDOEDP.I074_FILTRODIZIONARIO');
      SQL.Add(Format('WHERE TABELLA = ''%s'' and AZIENDA = ''%s''',[T,Parametri.Azienda]));
      SQL.Add(Format('AND PROFILO = (SELECT FILTRO_DIZIONARIO FROM MONDOEDP.I070_UTENTI WHERE PROGRESSIVO = %d)',[Parametri.ProgOper]));
      SQL.Add('GROUP BY PROFILO HAVING COUNT(*) = 1 AND MAX(CODICE) = ''' + C + '''');
      Open;
      if RecordCount > 0 then
      begin //Sto per eliminare l'unico codice della tabella corrente e con abilitazione = 'S' -> deve essere aggiunto il codice speciale 'DIZIONARIO DISABILITATO'
        insDizionarioMOD.Session:=SessioneOracle;
        insDizionarioMOD.SQL.Clear;
        insDizionarioMOD.SQL.Add('insert into MONDOEDP.I074_FILTRODIZIONARIO (AZIENDA, PROFILO,TABELLA,CODICE,ABILITATO)');
        insDizionarioMOD.SQL.Add(Format('select ''%s'', FILTRO_DIZIONARIO, ''%s'',''DIZIONARIO DISABILITATO'', ''S'' from MONDOEDP.I070_UTENTI WHERE PROGRESSIVO = ''%d''',
                                        [Parametri.Azienda, T, Parametri.ProgOper]));
        try
          insDizionarioMOD.Execute;
          SessioneOracle.Commit;
        except
          raise;
        end;
        SetLength(Parametri.FiltroDizionario,Length(Parametri.FiltroDizionario) + 1);
        Parametri.FiltroDizionario[High(Parametri.FiltroDizionario)].Tabella:=T;
        Parametri.FiltroDizionario[High(Parametri.FiltroDizionario)].Codice:='DIZIONARIO DISABILITATO';
        Parametri.FiltroDizionario[High(Parametri.FiltroDizionario)].Abilitato:=True;
        Parametri.FiltroDizionario[High(Parametri.FiltroDizionario)].Cestino:=False;
      end;
    finally
      Free;
      insDizionarioMOD.Free;
    end;
  end;
begin
  EsisteTabella:=False;
  Abilitato:=False;
  iOld:=-1;
  C:=Trim(C);
  CodOld:=Trim(CodOld);
  if C = CodOld then
    exit;
  for i:=0 to High(Parametri.FiltroDizionario) do
    if (Parametri.FiltroDizionario[i].Tabella = T) and (not Parametri.FiltroDizionario[i].Cestino) then
    begin
      EsisteTabella:=True;
      Abilitato:=Parametri.FiltroDizionario[i].Abilitato;
      if C <> '' then
        if not Abilitato then
          C:=''
        else if Parametri.FiltroDizionario[i].Codice = C then
          C:='';
      if (CodOld <> '') and (Parametri.FiltroDizionario[i].Codice = CodOld) then
        iOld:=i;
    end;
  if not EsisteTabella then
    C:='';
  OQ:=TOracleQuery.Create(nil);
  try
    T1:='''' + T + '''';
    C1:='''' + C + '''';
    OQ.Session:=SessioneOracle;
    if CodOld <> '' then
    begin
      if Abilitato then
        CorreggiFiltroDizionarioVuoto(T,CodOld);
      OQ.SQL.Clear;
      OQ.SQL.Add('DELETE MONDOEDP.I074_FILTRODIZIONARIO WHERE');
      OQ.SQL.Add(Format('TABELLA = ''%s'' AND CODICE = ''%s'' and AZIENDA = ''%s''',[T,CodOld,Parametri.Azienda]));
      if T = 'PROFILI ORARIO' then
        //Verifico che sia l'ultima storicizzazione esistente con quel codice
        OQ.SQL.Add(Format('AND NOT EXISTS (SELECT ''X'' FROM T220_PROFILIORARI WHERE CODICE = ''%s'')',[CodOld]));
      OQ.SQL.Add(Format('AND PROFILO = (SELECT FILTRO_DIZIONARIO FROM MONDOEDP.I070_UTENTI WHERE PROGRESSIVO = %d)',[Parametri.ProgOper]));
      try
        OQ.Execute;
        SessioneOracle.Commit;
        if iOld >= 0 then
        begin
          for i:=iOld + 1 to High(Parametri.FiltroDizionario) do
            Parametri.FiltroDizionario[i - 1]:=Parametri.FiltroDizionario[i];
          SetLength(Parametri.FiltroDizionario,Length(Parametri.FiltroDizionario) - 1);
        end;
      except
      end;
    end;
    if C <> '' then
    begin
      OQ.SQL.Clear;
      OQ.SQL.Add('INSERT INTO MONDOEDP.I074_FILTRODIZIONARIO (PROFILO,TABELLA,CODICE,AZIENDA)');
      OQ.SQL.Add(Format('SELECT FILTRO_DIZIONARIO,%s,%s,''%s'' FROM MONDOEDP.I070_UTENTI WHERE',[T1,C1,Parametri.Azienda]));
      OQ.SQL.Add(Format('PROGRESSIVO = %d AND',[Parametri.ProgOper]));
      OQ.SQL.Add('FILTRO_DIZIONARIO IS NOT NULL AND');
      OQ.SQL.Add('EXISTS (SELECT ''X'' FROM MONDOEDP.I074_FILTRODIZIONARIO');
      OQ.SQL.Add(Format('WHERE PROFILO = FILTRO_DIZIONARIO AND TABELLA = %s)',[T1]));
      try
        OQ.Execute;
        SetLength(Parametri.FiltroDizionario,Length(Parametri.FiltroDizionario) + 1);
        Parametri.FiltroDizionario[High(Parametri.FiltroDizionario)].Tabella:=T;
        Parametri.FiltroDizionario[High(Parametri.FiltroDizionario)].Codice:=C;
        Parametri.FiltroDizionario[High(Parametri.FiltroDizionario)].Abilitato:=True;
        Parametri.FiltroDizionario[High(Parametri.FiltroDizionario)].Cestino:=False;
        //Elimina il codice speciale 'DIZIONARIO DISABILITATO'
        OQ.SQL.Clear;
        OQ.SQL.Add('DELETE MONDOEDP.I074_FILTRODIZIONARIO WHERE');
        OQ.SQL.Add(Format('TABELLA = ''%s'' AND CODICE = ''DIZIONARIO DISABILITATO'' and AZIENDA = ''%s''',[T,Parametri.Azienda]));
        OQ.SQL.Add(Format('AND PROFILO = (SELECT FILTRO_DIZIONARIO FROM MONDOEDP.I070_UTENTI WHERE PROGRESSIVO = %d)',[Parametri.ProgOper]));
        OQ.Execute;
      except
      end;
    end;
    SessioneOracle.Commit;
  finally
    OQ.Free;
  end;
end;

constructor TSessioneIrisWIN.Create(AOwner: TComponent);
var tmpOwner:TComponent;
begin
  inherited Create(AOwner);
  //Gestione Owner nella creazione componenti all'interno di SessioneIrisWIN per accedere alla struttura completa
  tmpOwner:=AOwner;
  if tmpOwner = nil then
    tmpOwner:=Self;
  SessioneOracle:=TOracleSession.Create(AOwner);
  SessioneOracle.NullValue:=nvNull;
  SessioneOracle.Preferences.ZeroDateIsNull:=False;
  SessioneOracle.Preferences.TrimStringFields:=False;
  SessioneOracle.Preferences.UseOCI7:=False;//Alberto 15/02/2013
  SessioneOracle.BytesPerCharacter:=bc1Byte;
  SessioneOracle.MessageTable:='MONDOEDP.I018_ORACLEMESSAGE';
  {$IFDEF IRISWEB}SessioneOracle.ThreadSafe:=True;{$ENDIF}
  //----------------------------------------------------------------------------
  {$IFDEF IRISAPP}
  SessioneOracle.ThreadSafe:=True;
  {$ENDIF}
  //----------------------------------------------------------------------------
  SessioneOracle.Cursor:=crSQLWait;
  QueryPK1:=TQueryPK.Create(tmpOwner);
  QueryPK1.Session:=SessioneOracle;
  RegistraLog:=TRegistraLog.Create(tmpOwner);
  RegistraLog.Session:=SessioneOracle;
  RegistraMsg:=TRegistraMsg.Create(SessioneOracle);
  Parametri:=TParametri.Create(tmpOwner);
  Parametri.ClientIPInfo.Status:=isUndefined;
  Parametri.ClientIPInfo.IP:=PUBLIC_IP_UNKNOWN;
  QVistaOracle:=QVistaOracle_Const;
  {$IFNDEF IRISWEB}
  Application.OnException:=ApplicationOnException;
  {$ENDIF}
end;

procedure TSessioneIrisWIN.AlterSessionSessioneOracle;
var SetPar:TOracleQuery;
begin
  SetPar:=TOracleQuery.Create(nil);
  try
    SetPar.Session:=SessioneOracle;
    SetPar.SQL.Add('ALTER SESSION SET NLS_TERRITORY = AMERICA');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_DATE_FORMAT = "DD/MM/YYYY"');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_NUMERIC_CHARACTERS = ",."');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_DATE_LANGUAGE = ITALIAN');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_SORT = BINARY');
    SetPar.Execute;
  finally
    SetPar.Free;
  end;
end;

procedure TSessioneIrisWIN.ApplicationOnException(Sender:TObject; E:Exception);
begin
  {$IFNDEF IRISWEB}
  E.Message:=A000TraduzioneEccezioni(E.Message);
  Application.ShowException(E);
  {$ENDIF}
end;

class procedure TSessioneIrisWIN.BeforeOpenEvent(DataSet: TDataSet);
begin
  R180SetReadBuffer(Dataset);
end;

destructor TSessioneIrisWIN.Destroy;
begin
  try
    if (SessioneOracle <> nil) and (SessioneOracle.Tag <= 0) and (SessioneOracle.Name <> 'SessioneIrisWEB') then
    begin
      SessioneOracle.LogOff;
      FreeAndNil(SessioneOracle);
    end;
  except
  end;
  try if QueryPK1 <> nil then FreeAndNil(QueryPK1); except end;
  try if RegistraLog <> nil then FreeAndNil(RegistraLog); except end;
  try if RegistraMsg <> nil then FreeAndNil(RegistraMsg); except end;
  try if Parametri <> nil then FreeAndNil(Parametri); except end;
  inherited Destroy;
end;

initialization
  {$IFNDEF VER210}FormatSettings.{$ENDIF}DateSeparator:='/';
  {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortDateFormat:='dd/mm/yyyy';
  {$IFNDEF VER210}FormatSettings.{$ENDIF}TimeSeparator:='.';
  {$IFNDEF VER210}FormatSettings.{$ENDIF}DecimalSeparator:=',';
  {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:='.';
  {$IFNDEF VER210}FormatSettings.{$ENDIF}LongTimeFormat:='hh.nn.ss';
  Oracle.NoUnicodeSupport:=True;
end.

