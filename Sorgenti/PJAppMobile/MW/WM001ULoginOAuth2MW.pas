unit WM001ULoginOAuth2MW;

interface

uses
  System.SysUtils,
  System.Classes,
  A000UCostanti,
  A000Versione,
  FunzioniGenerali,
  WM000UConstants,
  System.Net.URLClient,
  System.Net.HttpClient,
  System.Net.HttpClientComponent,
  System.Net.Mime,
  JSON;

type

  TOAuth2Token = class(TObject)
  public
    TokenType: String;
    ExpiresIn: Integer;
    AccessToken: String;
    RefreshToken: String;

    constructor Create(PTokenType, PAccessToken, PRefreshToken: String; PExpiresIn: Integer); overload;
    constructor Create(JSONObject: TJSONObject); overload;
  end;

  TWM001FLoginOAuth2MW = class(TDataModule)
    HTTPClient: TNetHTTPClient;
    HTTPRequest: TNetHTTPRequest;
  private
    FClientId: String;
    FClientSecret: String;
    FUrlFase1: String;
    FUrlFase2: String;
    FInfoUserJSON: String;
    //fase1, acquisizione del token
    function GetAccessToken(PUsername, PPassword: String; var Auth2Token: TOAuth2Token): TResCtrl;
  public
    constructor Create(PClientId, PClientSecret, PUrlFase1, PUrlFase2, PInfoUserJSON: String); overload;
    //login completo (fase1 + fase2)
    function Login(PUsername, PPassword: String; var InfoUser: String; var AccessToken, RefreshToken, TokenType: String): TResCtrl;
    //login solo fase2 con token già acquisito
    function LoginFase2(PTokenType, PAccessToken: String; var InfoUser: String): TResCtrl;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

constructor TWM001FLoginOAuth2MW.Create(PClientId, PClientSecret, PUrlFase1, PUrlFase2, PInfoUserJSON: String);
begin
  inherited Create(nil);

  FClientId:=PClientId;
  FClientSecret:=PClientSecret;
  FUrlFase1:=PUrlFase1;
  FUrlFase2:=PUrlFase2;
  FInfoUserJSON:=PInfoUserJSON;
end;

function TWM001FLoginOAuth2MW.GetAccessToken(PUsername, PPassword: String; var Auth2Token: TOAuth2Token): TResCtrl;
var LHTTPResponse: IHTTPResponse;
    LJsonResponse: TJSONObject;
    LParametri: TMultipartFormData;
begin
  Result.Clear;

  try
    LParametri:=TMultipartFormData.Create;

    LParametri.AddField('username', PUsername);
    LParametri.AddField('password', PPassword);
    LParametri.AddField('client_id', FClientId);
    LParametri.AddField('client_secret', FClientSecret);
    LParametri.AddField('grant_type','password');
    LParametri.AddField('scope','*');

    try
      LHTTPResponse:=HTTPRequest.Post(FUrlFase1, LParametri);
    except
      on E : Exception do
      begin
        Result.Messaggio:='Errore nella richiesta HTTP dell''autenticazione OAuth 2.0 (Fase1): ' + E.Message;
        Exit;
      end;
    end;

    //se il login è eseguito
    if LHTTPResponse.StatusCode = 200 then
    begin
      try
        LJsonResponse:=TJSONObject.ParseJSONValue(LHTTPResponse.ContentAsString) as TJSONObject;
      except
        on E : Exception do
        begin
          Result.Messaggio:='Errore nella lettura della risposta HTTP dell''autenticazione OAuth 2.0 (Fase1): ' + E.Message;
          Exit;
        end;
      end;

      Auth2Token:=TOAuth2Token.Create(LJsonResponse);

      if (Auth2Token.AccessToken <> '') and (Auth2Token.TokenType <> '') then
        Result.Ok:=True
      else
        Result.Messaggio:='Parametri richiesti per l''autenticazione OAuth 2.0 (Fase 1) non trovati';
    end
    else if LHTTPResponse.StatusCode = 400 then
      Result.Messaggio:='Autenticazione OAuth 2.0 (Fase 1) non riuscita, utente e/o password non validi'
    else
      Result.Messaggio:='Autenticazione OAuth 2.0 (Fase 1) non riuscita, status code: ' + IntToStr(LHTTPResponse.StatusCode);

  finally
    FreeAndNil(LParametri);
    FreeAndNil(LJsonResponse);
  end;
end;

function TWM001FLoginOAuth2MW.LoginFase2(PTokenType, PAccessToken: String; var InfoUser: String): TResCtrl;
var LHeaders: TNetHeaders;
    LHTTPResponse: IHTTPResponse;
    LJsonResponse: TJSONObject;
begin
  Result.Clear;
  InfoUser:='';

  try
    LHeaders:=TNetHeaders.Create(TNameValuePair.Create('Authorization', PTokenType + ' ' + PAccessToken));

    try
      LHTTPResponse:=HTTPRequest.Get(FUrlFase2, nil, LHeaders);
    except
      on E : Exception do
      begin
        Result.Messaggio:='Errore nella richiesta HTTP dell''autenticazione OAuth 2.0 (Fase2): ' + E.Message;
        Exit;
      end;
    end;

    if LHTTPResponse.StatusCode = 200 then
    begin
      try
        LJsonResponse:=TJSONObject.ParseJSONValue(LHTTPResponse.ContentAsString) as TJSONObject;
      except
        on E : Exception do
        begin
          Result.Messaggio:='Errore nella lettura della risposta HTTP dell''autenticazione OAuth 2.0 (Fase2): ' + E.Message;
          Exit;
        end;
      end;
      
      LJsonResponse.TryGetValue<String>(FInfoUserJSON, InfoUser);

      if InfoUser <> '' then
        Result.Ok:=True
      else
        Result.Messaggio:='Parametri richiesti per l''autenticazione OAuth 2.0 (Fase 2) non trovati';
    end
    else
      Result.Messaggio:='Autenticazione OAuth 2.0 (Fase 2) non riuscita, status code: ' + IntToStr(LHTTPResponse.StatusCode);
  finally
    FreeAndNil(LJsonResponse);
  end;
end;

function TWM001FLoginOAuth2MW.Login(PUsername, PPassword: String; var InfoUser, AccessToken, RefreshToken, TokenType: String): TResCtrl;
var LOAuth2Token: TOAuth2Token;
begin
  InfoUser:='';
  AccessToken:='';
  RefreshToken:='';
  TokenType:='';
  Result.Clear;

  if PUsername = '' then
  begin
    Result.Messaggio:='Indicare l''utente richiesto per l''autenticazione';
    Exit;
  end;

  if PPassword = '' then
  begin
    Result.Messaggio:='Indicare la password richiesta per l''autenticazione';
    Exit;
  end;

  try
    Result:=GetAccessToken(PUsername, PPassword, LOAuth2Token);

    if Result.Ok then
    begin
      Result:=LoginFase2(LOAuth2Token.TokenType, LOAuth2Token.AccessToken, InfoUser);

      if Result.Ok then
        if Assigned(LOAuth2Token) then
        begin
          AccessToken:=LOAuth2Token.AccessToken;
          RefreshToken:=LOAuth2Token.RefreshToken;
          TokenType:=LOAuth2Token.TokenType;
        end;
    end;
  finally
    FreeAndNil(LOAuth2Token);
  end;
end;

{ TOAuthToken }

constructor TOAuth2Token.Create(PTokenType, PAccessToken, PRefreshToken: String; PExpiresIn: Integer);
begin
  TokenType:=PTokenType;
  ExpiresIn:=PExpiresIn;
  AccessToken:=PAccessToken;
  RefreshToken:=PRefreshToken;
end;

constructor TOAuth2Token.Create(JSONObject: TJSONObject);
begin
  if Assigned(JSONObject) then
  begin
    JSONObject.TryGetValue<String>('access_token', AccessToken);
    JSONObject.TryGetValue<String>('refresh_token', RefreshToken);
    JSONObject.TryGetValue<String>('token_type', TokenType);
    JSONObject.TryGetValue<Integer>('expires_in', ExpiresIn);
  end
  else
    inherited Create;
end;

end.
