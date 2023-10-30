unit WM000UParConfig;

interface

uses  System.UITypes,
      Graphics,
      SysUtils, IniFiles, A000UCostanti, Classes;

type
  TWM000FParConfig = class(TObject)
    private
      FAzienda: String;
      FStatoAzienda: String;
      FProfilo: String;
      FStatoProfilo: String;
      FTitoloIrisAPP: String;
      FMaxSessioni: Integer;
      FMaxRequests: Integer;
      FTimeoutSessione: Integer;
      FCookieCredenziali: Boolean;
      FRecuperoPassword: Boolean;
      FPaginaIniziale: String;
      FHome: String;
      FUrlReCAPTCHA: String;
      FSiteKeyReCAPTCHA: String;
      FSecretKeyReCAPTCHA: String;

      FHostB110: String;
      FUrlB110: String;
      FPortB110: Integer;
      FProtocolloB110: String;
      FLoginEsterno: String;

      FLogIndyExceptions: Boolean;
      FLogSSLIndyExceptions: Boolean;
      FLogSessionExceptions: Boolean;
    public
      property Azienda: String read FAzienda;
      property StatoAzienda: String read FStatoAzienda;
      property Profilo: String read FProfilo;
      property StatoProfilo: String read FStatoProfilo;
      property TitoloIrisAPP: String read FTitoloIrisAPP;
      property MaxSessioni: Integer read FMaxSessioni;
      property MaxRequests: Integer read FMaxRequests;
      property TimeoutSessione: Integer read FTimeoutSessione;
      property CookieCredenziali: Boolean read FCookieCredenziali;
      property RecuperoPassword: Boolean read FRecuperoPassword;
      property PaginaIniziale: String read FPaginaIniziale;
      property Home: String read FHome;

      property UrlReCAPTCHA: String read FUrlReCAPTCHA;
      property SiteKeyReCAPTCHA: String read FSiteKeyReCAPTCHA;
      property SecretKeyReCAPTCHA: String read FSecretKeyReCAPTCHA;

      property HostB110: String read FHostB110;
      property UrlB110: String read FUrlB110;
      property PortB110: Integer read FPortB110;
      property ProtocolloB110: String read FProtocolloB110;
      property LoginEsterno: String read FLoginEsterno;

      property LogIndyExceptions: Boolean read FLogIndyExceptions;
      property LogSSLIndyExceptions: Boolean read FLogSSLIndyExceptions;
      property LogSessionExceptions: Boolean read FLogSessionExceptions;

      constructor Create(IrisAPPIniName, B110IniName, IniPath: String); overload;
  end;

implementation

{ TWM000ParConfig }

constructor TWM000FParConfig.Create(IrisAPPIniName, B110IniName, IniPath: String);
var IniFile: TIniFile;
begin
  inherited Create;

  IniFile:=TIniFile.Create(IniPath + IrisAPPIniName);
  try
    FAzienda:=IniFile.ReadString(INI_SEZ_IMPOST_OPER, INI_ID_AZIENDA, '');
    FStatoAzienda:=IniFile.ReadString(INI_SEZ_IMPOST_OPER, INI_ID_STATO_AZIENDA, 'S');
    FProfilo:=IniFile.ReadString(INI_SEZ_IMPOST_OPER, INI_ID_PROFILO, '');
    FStatoProfilo:=IniFile.ReadString(INI_SEZ_IMPOST_OPER, INI_ID_STATO_PROFILO, 'S');
    FTitoloIrisAPP:=IniFile.ReadString(INI_SEZ_IMPOST_OPER, INI_ID_TITOLO_IRISAPP, '');
    FMaxSessioni:=IniFile.ReadInteger(INI_SEZ_IMPOST_OPER, INI_ID_MAX_SESSIONI, 250);
    FMaxRequests:=IniFile.ReadInteger(INI_SEZ_IMPOST_OPER, INI_ID_MAX_REQUESTS, 50);
    FTimeoutSessione:=IniFile.ReadInteger(INI_SEZ_IMPOST_OPER, INI_ID_TIMEOUT_DIP, 5);

    FCookieCredenziali:=IniFile.ReadString(INI_SEZ_IMPOST_OPER, INI_ID_REG_CREDENZIALI, 'S') = 'S';
    FRecuperoPassword:=IniFile.ReadString(INI_SEZ_IMPOST_OPER, INI_ID_RECUPERO_PASSWORD, 'N') = 'S';
    FPaginaIniziale:=IniFile.ReadString(INI_SEZ_IMPOST_OPER, INI_ID_STARTPAGE, '');
    FHome:=IniFile.ReadString(INI_SEZ_IMPOST_OPER, INI_ID_HOME, '');

    FUrlReCAPTCHA:=IniFile.ReadString(INI_SEZ_IMPOST_OPER, INI_ID_URLRECAPTCHA, '');
    FSiteKeyReCAPTCHA:=IniFile.ReadString(INI_SEZ_IMPOST_OPER, INI_ID_SITEKEYRECAPTCHA, '');
    FSecretKeyReCAPTCHA:=IniFile.ReadString(INI_SEZ_IMPOST_OPER, INI_ID_SECRETKEYRECAPTCHA, '');

    FHostB110:=IniFile.ReadString(INI_SEZ_IMPOST_SIST, INI_ID_B110HOST, 'localhost');
    FUrlB110:=IniFile.ReadString(INI_SEZ_IMPOST_SIST, INI_ID_B110URL, '');
    FPortB110:=IniFile.ReadInteger(INI_SEZ_IMPOST_SIST, INI_ID_B110PORT, 80);
    FProtocolloB110:=IniFile.ReadString(INI_SEZ_IMPOST_SIST, INI_ID_B110PROTOCOLLO, 'http');

    FLogIndyExceptions:=IniFile.ReadString(INI_SEZ_IMPOST_UG_LOG, INI_UGEL_INDY, 'N') = 'S';
    FLogSSLIndyExceptions:=IniFile.ReadString(INI_SEZ_IMPOST_UG_LOG, INI_UGEL_INDYSSL, 'N') = 'S';
    FLogSessionExceptions:=IniFile.ReadString(INI_SEZ_IMPOST_UG_LOG, INI_UGEL_SESSION, 'N') = 'S';
  finally
    FreeAndNil(IniFile);
  end;

  IniFile:=TIniFile.Create(IniPath + B110IniName);
  try
    FLoginEsterno:=IniFile.ReadString('Default', INI_ID_LOGIN_ESTERNO, 'N');
  finally
    FreeAndNil(IniFile);
  end;
end;

end.
