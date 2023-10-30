program X002PSSOLoginWeb;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils, System.IniFiles , Winapi.Windows, Winapi.Messages,  IOUtils, Shellapi,
  IdURI, A000UCostanti, C180FunzioniGenerali;

var
  url: String;
  irisWebLocation, PaginaSingola: String;
  xusr, Parametri:String;
  TempHost,TempIP,Err: String;
  IniFile: TIniFile;

const FileLog = 'X002.log';

function UserName:string;
var
  Buffer: array[0..255] of char;
  BufferSize: DWORD;
begin
  BufferSize:=sizeOf(Buffer);
  GetUserName(@buffer, BufferSize);
  Result:=Buffer;
end;

begin
  try
    try
      if FileExists(FileLog) then
        DeleteFile(FileLog);
    except
    end;
    try
      IniFile:=TIniFile.Create('.\x002.ini');
      //impostazioni operative
      irisWebLocation:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_HOME,'');
      PaginaSingola:=IniFile.ReadString(INI_SEZ_IMPOST_OPER,INI_ID_SINGLEPAGE,'');
      try R180AppendFile(FileLog,'irisWebLocation: ' + irisWebLocation); except end;
    finally
      FreeAndNil(IniFile);
    end;

    if not R180GetIPFromHost(TempHost,TempIP,Err) then
    begin
      TempHost:='localhost';
      TempIP:='127.0.0.1';
    end;

    if PaginaSingola = '' then
      PaginaSingola:='none';

    //Parametri:='loginesterno=S' + '&xusr=' + R180CriptaI070(UserName) + '&clientname=' + TempHost;
    try R180AppendFile(FileLog,'UserName: ' + UserName); except end;
    xusr:=R180SSO_TokenUsr(UserName,A000SSO_UsrMask);
    xusr:=R180RDL_ECB_Encrypt(xusr,A000SSO_RDLPassphrase);
    Parametri:='loginesterno=S' + '&xusr=' + xusr + '&clientname=' + TempHost;
    if Pos('?',irisWebLocation) = 0 then
      Parametri:='?' + Parametri
    else
      Parametri:='&' + Parametri;
    if pos('http',LowerCase(irisWebLocation)) = 0 then
      irisWebLocation:='http://' + irisWebLocation;
    url:=TIdURI.URLEncode(irisWebLocation + Parametri);
    //Converto il carattere '+' con l'escape, altrimenti passandolo in get IrisWEB lo trasforma in spazio
    url:=StringReplace(url,'+','%2B',[rfReplaceAll]);
    ShellExecute(0,'open', PChar(url), NIL, NIL, SW_SHOWNORMAL);
  except
    on E: Exception do
    begin
      Writeln(E.ClassName, ': ', E.Message);
      try R180AppendFile(FileLog,E.ClassName + ': ' + E.Message); except end;
     end;
  end;
end.
