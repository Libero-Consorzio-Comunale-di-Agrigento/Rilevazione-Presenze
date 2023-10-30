unit WM000UMainModule;

interface

uses
  A000UCostanti,
  A000Versione,
  A000USessione,
  B110USharedTypes,
  C200UWebServicesTypes,
  B110UClientModule,
  B110UUtils,
  C180FunzioniGenerali,
  WM001ULoginMW,
  WM009UNotificheMW,
  uniGUIMainModule,
  uniGUITypes,
  SysUtils,
  Classes,
  uIdCustomHTTPServer,
  uniGUIApplication,
  WM001ULoginOAuth2MW,
  WM000UConstants;
  //DatiBloccati;

type
  TWM000FMainModule = class(TUniGUIMainModule)
    procedure UniGUIMainModuleCreate(Sender: TObject);
    procedure UniGUIMainModuleDestroy(Sender: TObject);
    procedure UniGUIMainModuleBeforeLogin(Sender: TObject; var Handled: Boolean);
  private
    FInfoClient: TInfoClient;
    FInfoLogin: TWM001FLoginMW;
    FNotifiche: TWM009FNotificheMW;
    FB110ClientModule: TB110FClientModule;
    //FSelDatiBloccati: TDatiBloccati;     //da valutare, per ora è istanziato e usato solo nel MW di cambio orario

    function LoginCookies(Session: TUniGUISession; var Handled:Boolean): TResCtrl;
    function LoginGETPOST(Session: TUniGUISession; var Handled:Boolean): TResCtrl;
    function LoginOAuth2(Session: TUniGUISession; UrlGetUser, InfoUser: String; var Handled:Boolean): TResCtrl;
    function LoginRemoteUser(Session: TUniGUISession; var Handled:Boolean): TResCtrl;
    //procedure logFileHTTPRequest(Session: TUniGUISession);
  public
    property InfoClient: TInfoClient read FInfoClient;
    property InfoLogin: TWM001FLoginMW read FInfoLogin;
    property B110ClientModule: TB110FClientModule read FB110ClientModule;
    property Notifiche: TWM009FNotificheMW read FNotifiche;
    //property SelDatiBloccati: TDatiBloccati read FselDatiBloccati;

    //function VerificaDatiBloccati(PProgressivo:Integer; PData:TDateTime; PRiepilogo:String; PIgnoraElusione:Boolean = False): TResCtrl;
  end;

function WM000FMainModule: TWM000FMainModule;

implementation

{$R *.dfm}

uses
  UniGUIVars, WM000UServerModule;

function WM000FMainModule: TWM000FMainModule;
begin
  Result:=TWM000FMainModule(UniApplication.UniMainModule);
end;

procedure TWM000FMainModule.UniGUIMainModuleCreate(Sender: TObject);
begin
  with WM000FServerModule do
    FB110ClientModule:=TB110FClientModule.Create(nil,
                                                 ParConfig.HostB110,
                                                 ParConfig.UrlB110,
                                                 ParConfig.ProtocolloB110,
                                                 ParConfig.PortB110);

  FInfoClient:=TInfoClient.Create(VersionePA,BuildPA,'','');

  FInfoLogin:=TWM001FLoginMW.Create;
  FNotifiche:=TWM009FNotificheMW.Create;

  //FselDatiBloccati:=TDatiBloccati.Create(Self);
end;

procedure TWM000FMainModule.UniGUIMainModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FInfoClient);
  FreeAndNil(FInfoLogin);
  FreeAndNil(FB110ClientModule);
  FreeAndNil(FNotifiche);
end;

//login automatico senza passare dalla form di login (Handled:=True)
procedure TWM000FMainModule.UniGUIMainModuleBeforeLogin(Sender: TObject; var Handled: Boolean);
var LResCtrl: TResCtrl;
begin
  Handled:=False;

  if (Sender as TUniGUISession).UniApplication.Cookies.Values[COOKIE_AZIENDA] <> '' then
  begin
    with InfoLogin do
    begin
      LResCtrl:=AggiornaSessioneIrisWin((Sender as TUniGUISession).UniApplication.Cookies.Values[COOKIE_AZIENDA], '');
      if not LResCtrl.Ok then
        Exit;

      //se è richiesta l'aut. OAuth 2.0
      if SessioneIrisWin.Parametri.CampiRiferimento.C90_SSO_Tipo = 'OAUTH2' then
        LoginOAuth2((Sender as TUniGUISession),
                    SessioneIrisWin.Parametri.CampiRiferimento.C90_SSO_OAUTH2UrlGetUser,
                    SessioneIrisWin.Parametri.CampiRiferimento.C90_SSO_OAUTH2InfoUser,
                    Handled)
      else
      //login automatico interno
      begin
        // login con dati metodo GET/POST
        LResCtrl:=LoginGETPOST((Sender as TUniGUISession), Handled);
        if LResCtrl.Ok then  // se il login GET/POST va a buon fine (indipendentemente dall'autenticazione), esco
          Exit;

        //login automatico con cookies
        LoginCookies((Sender as TUniGUISession), Handled);
      end;
    end;
  end
  //VENEZIA_IUAV.ini
  else if (WM000FServerModule.ParConfig.LoginEsterno = 'S')
      and ((Sender as TUniGUISession).RequestHeader['remoteuser'] <> '') then
  begin
    LResCtrl:=LoginRemoteUser((Sender as TUniGUISession), Handled);
    //se non mi sono loggato ed è presente la pagina Home nel file ini ci vado
    if (not Handled or not LResCtrl.Ok) and (WM000FServerModule.ParConfig.Home <> '') then
      (Sender as TUniGUISession).UniApplication.Terminate(Format('<script>window.location.href = "%s";</script>',[WM000FServerModule.ParConfig.Home]));
  end;
  //VENEZIA_IUAV.fine
end;

function TWM000FMainModule.LoginCookies(Session: TUniGUISession; var Handled:Boolean): TResCtrl;
var LResCtrl: TResCtrl;
    LAzienda, LUsername, LPassword, LPasswordEnc: String;
    LScadenzaCookie: Double;
    LTemp: TArray<String>;
begin
  //login con cookies
  Result.Clear;
  Handled:=False;

  with Session.UniApplication.Cookies do
  begin
    LAzienda:=Values[COOKIE_AZIENDA];
    LUsername:='';
    LPassword:='';

    //------------------------------------------------------------------------------------------------
    //[TEMP] transizione da password a token cifrato [10.8(0)] da eliminare in futuro
    if Values[COOKIE_PASSWORD] <> '' then
    begin
      if WM000FMainModule.InfoLogin.DatiGenerali.Parametri.ValiditaPassword <> 0 then
        LScadenzaCookie:=Date+(WM000FMainModule.InfoLogin.DatiGenerali.Parametri.ValiditaPassword *30)
      else
        LScadenzaCookie:=Date+999;

      LUsername:=Values[COOKIE_UTENTE];
      LPassword:=Values[COOKIE_PASSWORD];
      SetCookie(COOKIE_TOKEN, R180RDL_ECB_Encrypt(LUsername + COOKIE_SEP + LPassword, COOKIE_PASSPHRASE), LScadenzaCookie);
      //cookies COOKIE_UTENTE e COOKIE_PASSWORD eliminati in MainForm in pnlMenuItemClick (qui non funziona!)
    end
    //------------------------------------------------------------------------------------------------
    else
    begin
      LTemp:=R180RDL_ECB_Decrypt(Values[COOKIE_TOKEN], COOKIE_PASSPHRASE).Split([COOKIE_SEP]);
      if Length(LTemp) = 2 then
      begin
        LUsername:=LTemp[0];
        LTemp:=LTemp[1].Split([' ']);
        if Length(LTemp) > 1 then
          LPassword:=LTemp[0];
      end;
    end;
  end;

  if (LAzienda <> '') and (LUsername <>'') and (LPassword <> '') then
  begin
    LResCtrl:=InfoLogin.LoginB110(B110ClientModule,
                                InfoClient,
                                LAzienda,
                                LUsername,
                                LPassword,
                                WM000FServerModule.ParConfig.Profilo);
    Handled:=LResCtrl.Ok;
    Result.Ok:=True;
  end
  else
    Result.Messaggio:='Parametri necessari per il login non trovati';
end;

function TWM000FMainModule.LoginGETPOST(Session: TUniGUISession; var Handled:Boolean): TResCtrl;
var LResCtrl: TResCtrl;
    LAzienda, LUsername, LPassword, LProfilo: String;
begin
  // login con dati metodo GET/POST
  Result.Clear;
  Handled:=False;

  with Session do
  begin
    LAzienda:=Query['azienda'];
    LUsername:=Query['usr'];
    LPassword:=Query['pwd'];
    LProfilo:=Query['profilo'];
  end;

  if LAzienda = '' then
    LAzienda:=WM000FServerModule.ParConfig.Azienda;
  if LProfilo = '' then
    LProfilo:=WM000FServerModule.ParConfig.Profilo;

  if (LAzienda <> '') and (LUsername <>'') and (LPassword <> '') then
  begin
    LResCtrl:=InfoLogin.LoginB110(B110ClientModule,
                                  InfoClient,
                                  LAzienda,
                                  LUsername,
                                  LPassword,
                                  LProfilo);
    Handled:=LResCtrl.Ok;
    Result.Ok:=True;
  end
  else
    Result.Messaggio:='Parametri necessari per il login non trovati';
end;

function TWM000FMainModule.LoginOAuth2(Session: TUniGUISession; UrlGetUser, InfoUser: String; var Handled:Boolean): TResCtrl;
var LResCtrl: TResCtrl;
    LAzienda, LUsername, LProfilo: String;
    LLoginOAuth2: TWM001FLoginOAuth2MW;
begin
  Result.Clear;
  Handled:=False;

  LAzienda:=Session.UniApplication.Cookies.Values[COOKIE_AZIENDA];
  LProfilo:=WM000FServerModule.ParConfig.Profilo;

  try
    LLoginOAuth2:=TWM001FLoginOAuth2MW.Create('', '', '', UrlGetUser, InfoUser);

    with Session.UniApplication.Cookies do
      LResCtrl:=LLoginOAuth2.LoginFase2(Values[COOKIE_OAUTH2_TOKENTYPE], Values[COOKIE_OAUTH2_ACCESSTOKEN], LUsername);

    if LResCtrl.Ok then
    begin
      with WM000FMainModule do
      begin
        LResCtrl:=InfoLogin.LoginB110(B110ClientModule,
                                      InfoClient,
                                      LAzienda,
                                      LUsername,
                                      PASSWORD_LOGIN_ESTERNO,
                                      LProfilo);
      end;

      Handled:=LResCtrl.Ok;
      Result.Ok:=True;
    end
    else
      Result.Messaggio:='Parametri necessari per il login non trovati';
  finally
    FreeAndNil(LLoginOAuth2);
  end;
end;

function TWM000FMainModule.LoginRemoteUser(Session: TUniGUISession; var Handled: Boolean): TResCtrl;
var LResCtrl: TResCtrl;
    LAzienda, LRemoteuser, LPassword, LProfilo: String;
begin
  Result.Clear;
  Handled:=False;

  LResCtrl:=InfoLogin.AggiornaSessioneIrisWin(WM000FServerModule.ParConfig.Azienda, '');
  if not LResCtrl.Ok then
    Exit;

  LRemoteuser:=Session.RequestHeader['remoteuser'];
  LAzienda:=WM000FServerModule.ParConfig.Azienda;
  LProfilo:=WM000FServerModule.ParConfig.Profilo;
  LPassword:=PASSWORD_LOGIN_ESTERNO;

  if LRemoteuser <> '' then
  begin
    LResCtrl:=InfoLogin.LoginB110(B110ClientModule,
                                  InfoClient,
                                  LAzienda,
                                  LRemoteuser,
                                  LPassword,
                                  LProfilo);
    Handled:=LResCtrl.Ok;
    Result.Ok:=True;
  end
  else
    Result.Messaggio:='Parametro remoteuser necessario per il login non trovato';
end;

{function TWM000FMainModule.VerificaDatiBloccati(PProgressivo:Integer; PData:TDateTime; PRiepilogo:String; PIgnoraElusione:Boolean = False): TResCtrl;
begin
  Result.Clear;

  selDatiBloccati.Close;
  if selDatiBloccati.DatoBloccato(PProgressivo, PData, PRiepilogo, PIgnoraElusione) then
    Result.Messaggio:=selDatiBloccati.MessaggioLog
  else
    Result.Ok:=True;
end;}


{function TWM000FMainModule.TipoDispositivo: String;
begin

  Result:='UniGUI vede il dispositivo come: ';

  if upDesktop in UniSession.UniPlatform then
    Result:=Result + '|desktop| ';

  if upMobile in UniSession.UniPlatform then
    Result:=Result + '|mobile| ';

  if upPhone in UniSession.UniPlatform then
    Result:=Result + '|phone| ';

  if upTablet in UniSession.UniPlatform then
    Result:=Result + '|tablet| ';

  if upAndroid in UniSession.UniPlatform then
    Result:=Result + '|android| ';

  if upiPhone in UniSession.UniPlatform then
    Result:=Result + '|iPhone| ';

  if upiPad in UniSession.UniPlatform then
    Result:=Result + '|iPad| ';

  if upiPod in UniSession.UniPlatform then
    Result:=Result + '|iPod| ';

  if upIOS in UniSession.UniPlatform then
    Result:=Result + '|iOS| ';

end;}

{procedure TWM000FMainModule.logFileHTTPRequest(Session: TUniGUISession);
var fFile : TextFile;
    stringa: String;
    Ora: TDateTime;
begin
  AssignFile(fFile, WM000FServerModule.StartPath + '\LogHTTPRequest.txt');
  if FileExists('LogHTTPRequest.txt') <> true then
    Rewrite(fFile)
  else
    Append(fFile);

  Ora:=Now;

  Writeln(fFile, '--||-- INIZIO: ' + FormatDateTime('c', Ora) + ' --||--');

  Writeln(fFile, '--remoteuser in Query[remoteuser]');
  if Session.Query['remoteuser'] = '' then
    Writeln(fFile, 'Parametro remoteuser non trovato in Query')
  else
    Writeln(fFile, Session.Query['remoteuser']);

  Writeln(fFile, '--remoteuser in RequestHeader[remoteuser]');
  if Session.RequestHeader['remoteuser'] = '' then
    Writeln(fFile, 'Parametro remoteuser non trovato in RequestHeader')
  else
    Writeln(fFile, Session.RequestHeader['remoteuser']);

  Writeln(fFile, '--Url');
  if Session.Url = '' then
    Writeln(fFile, 'Stringa Session.Url vuota')
  else
    Writeln(fFile, Session.Url);

  Writeln(fFile, '--BaseUrl');
  if Session.BaseUrl = '' then
    Writeln(fFile, 'Stringa Session.BaseUrl vuota')
  else
    Writeln(fFile, Session.BaseUrl);

  Writeln(fFile, '--UrlPath');
  if Session.UrlPath = '' then
    Writeln(fFile, 'Stringa Session.UrlPath vuota')
  else
    Writeln(fFile, Session.UrlPath);

  Writeln(fFile, '--UrlReferer');
  if Session.UrlReferer = '' then
    Writeln(fFile, 'Stringa Session.UrlReferer vuota')
  else
    Writeln(fFile, Session.UrlReferer);

  Writeln(fFile, '--Session.QueryParams');
  if Session.QueryParams.Count = 0 then
    Writeln(fFile, 'Nessuna stringa in QueryParams')
  else
    for stringa in Session.QueryParams do
      Writeln(fFile, stringa);

  Writeln(fFile, '--Response');
  if Session.Response = '' then
    Writeln(fFile, 'Stringa Session.Response vuota')
  else
    Writeln(fFile, Session.Response);

  Writeln(fFile, '--PathInfo');
  if Session.PathInfo = '' then
    Writeln(fFile, 'Stringa Session.PathInfo vuota')
  else
    Writeln(fFile, Session.PathInfo);

  Writeln(fFile, '--UserAgent');
  if Session.UserAgent = '' then
    Writeln(fFile, 'Stringa Session.UserAgent vuota')
  else
    Writeln(fFile, Session.UserAgent);

  Writeln(fFile, '--ARequest.Command');
  if Session.ARequest.FormParams = '' then
    Writeln(fFile, 'Stringa Command vuota')
  else
    Writeln(fFile, Session.ARequest.Command);

  Writeln(fFile, '--ARequest.Document');
  if Session.ARequest.FormParams = '' then
    Writeln(fFile, 'Stringa Document vuota')
  else
    Writeln(fFile, Session.ARequest.Document);

  Writeln(fFile, '--ARequest.UnparsedParams');
  if Session.ARequest.FormParams = '' then
    Writeln(fFile, 'Stringa UnparsedParams vuota')
  else
    Writeln(fFile, Session.ARequest.UnparsedParams);

  Writeln(fFile, '--ARequest.Params (Parametri GET)');
  if Session.ARequest.Params.Count = 0 then
    Writeln(fFile, 'Nessun parametro GET presente')
  else
    for stringa in Session.ARequest.Params do
      Writeln(fFile, stringa);

  Writeln(fFile, '--ARequest.FormParams (POST Stream)');
  if Session.ARequest.FormParams = '' then
    Writeln(fFile, 'Stringa PostStream vuota')
  else
    Writeln(fFile, Session.ARequest.FormParams);

  Writeln(fFile, '--ARequest.QueryParams');
  if Session.ARequest.FormParams = '' then
    Writeln(fFile, 'Stringa QueryParams vuota')
  else
    Writeln(fFile, Session.ARequest.QueryParams);

  Writeln(fFile, '--||-- FINE:   ' + FormatDateTime('c', Ora) + ' --||--');
  Writeln(fFile, '');

  CloseFile(fFile);
end;}

{function CheckIPPubblico(IP: String): Boolean;  //C180?
var Strings: TStrings;
    i, j, k, temp: Integer;
    IPDouble: Double;
    Range: TList<TPair<Double, Double>>;
begin
  //http://www.aboutmyip.com/AboutMyXApp/IP2Integer.jsp
  //https://en.wikipedia.org/wiki/Reserved_IP_addresses
  Result:=True;
  IPDouble:=0;
  Strings:=TStringList.Create;
  try
    Strings.StrictDelimiter:=True;
    Strings.Delimiter:= '.';
    Strings.DelimitedText:=IP;

    //Controllo di valità della stringa dell'IP
    if Strings.Count <> 4 then   //deve avere 4 ottetti
      raise Exception.Create('Indirizzo IP non valido');

    for j:=0 to Strings.Count-1 do
    begin
      try
        temp:=StrToInt(Strings[j]);
      except
        on Exception : EConvertError do  //ogni ottetto deve essere un numero
          raise Exception.Create('Indirizzo IP non valido');
      end;
      if (temp < 0) or (temp > 255) then //ogni numero deve stare tra 0 e 255
        raise Exception.Create('Indirizzo IP non valido');
    end;

    //Conversione in double della stringa dell'IP
    for i:=Strings.Count-1 downto 0 do
      IPDouble:=IPDouble + StrToInt(Strings[i]) * IntPower(256, Strings.Count-1-i);

    //Definizione e verifica dei range di IP riservati (non pubblici)
    Range:=TList<TPair<Double, Double>>.Create;
    try
      Range.Add(TPair<Double, Double>.Create(167772160, 184549375));    // 10.0.0.0 -> 10.255.255.255
      Range.Add(TPair<Double, Double>.Create(1681915904, 1686110207));  // 100.64.0.0 -> 100.127.255.255
      Range.Add(TPair<Double, Double>.Create(2130706432, 2147483647));  // 127.0.0.0 -> 127.255.255.255
      Range.Add(TPair<Double, Double>.Create(2886729728, 2887778303));  // 172.16.0.0 -> 172.31.255.255
      Range.Add(TPair<Double, Double>.Create(3221225472, 3221225727));  // 192.0.0.0 -> 192.0.0.255
      Range.Add(TPair<Double, Double>.Create(3232235520, 3232301055));  // 192.168.0.0 -> 192.168.255.255
      Range.Add(TPair<Double, Double>.Create(3323068416, 3323199487));  // 198.18.0.0 -> 198.19.255.255

      for k:=0 to Range.Count-1 do
        if (IPDouble >= Range[k].Key) and (IPDouble <= Range[k].Value) then
        begin
          Result:=False;
          Exit;
        end;

    finally
      FreeAndNil(Range);
    end;
  finally
    FreeAndNil(Strings);
  end;
end;}

initialization
  RegisterMainModuleClass(TWM000FMainModule);

end.
