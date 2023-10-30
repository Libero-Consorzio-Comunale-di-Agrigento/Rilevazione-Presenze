unit C024UNotifichePushDM;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, EncdDecd, DateUtils, IdURI, IOUtils,
  JOSE.Core.JWT, JOSE.Core.JWS, JOSE.Core.JWA.Factory, JOSE.Core.JWK, JOSE.Core.JWA, JOSE.Types.JSON, System.WideStrings,
  JOSE.Types.Bytes, JOSE.Hashing.HMAC, System.NetEncoding, IdCoderMIME, IdGlobal, A000UCostanti,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  //MiscObj, ECCObj, AESObj,                        //TMS -> no server
  //SynEcc, SynCommons, SynCrypto,                  //mormot -> non funziona...
  Crypt2, PublicKey, PrivateKey, Prng, Ecc, Global; //Chilkat -> OK

type
  TStrProc = procedure(const S: string) of object;
  THTTPClientRequestCompleted = procedure(const Sender: TObject; const AResponse: IHTTPResponse) of object;
  THTTPClientRequestError = procedure(const Sender: TObject; const AError: string) of object;

  TC024FNotifichePushDM = class(TR005FDataModuleMW)
    HTTPClient: TNetHTTPClient;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure HTTPClientRequestCompleted(const Sender: TObject; const AResponse: IHTTPResponse);
    procedure HTTPClientRequestError(const Sender: TObject; const AError: string);
  private
    FInizializzato: Boolean;

    FECDSAPublicKey: TStringList;
    FECDSAPrivateKey: TStringList;
    FApplicationServerKey: String;

    FTitolo: String;
    FMailRiferimento: String;
    FUrlClick: String;

    function GetProtocolAndHost(const URI: string): string;
    function CalcolaTokenJWT(PUrlWSPush: String): String;
    function CalcolaSharedSecret(ua_public: String; var as_public: String): String;
    function CalcolaPayload(p256dhKey, authSecret, plaintext: String): TBytesStream;
    function CalcolaHTTPHeader(PUrlWSPush: String; PHttpBodyPresente: Boolean): TArray<TNameValuePair>;
    function CalcolaPlaintext(Titolo, Testo, Id, Url: String): String;

    //spostare
    function CalcolaAES128GCM(Key, InitVector, Authdata, Plaintext: String): String;
    function Base64UrltoBase64(Value: String): String;
    function Base64toBase64Url(Value: String): String;
    function Base64Concat(value1, value2: String): String;
  public
    OnRequestCompleted: THTTPClientRequestCompleted;
    OnRequestError: THTTPClientRequestError;

    property ECDSAPublicKey: TStringList read FECDSAPublicKey;
    property ECDSAPrivateKey: TStringList read FECDSAPrivateKey;
    property ApplicationServerKey: String read FApplicationServerKey;
    property MailRiferimento: String read FMailRiferimento;

    procedure Inizializza(PEMPublicKeyPath, PEMPrivateKeyPath, DEMPublicKeyPath, Titolo, MailRiferimento, UrlClick: String);
    function InviaNotifica(ReceiverKey, AuthSecret, UrlWSPush, Testo, Id: String): TResCtrl;

    class function CalcolaApplicationServerKey(DEMFileName: String): String;  //si può mettere privata?
    class procedure IscrizioneNotifiche(DEMFileName, nomeFunzioneJs: String; RichiestaIscrizioneNotifiche: TStrProc);
  end;

const
  TITOLO_IRISAPP = 'IrisAPP';
  TITOLO_IRISWEB = 'IrisWEB';

  //generatore di chiavi VAPID con openssl:
  // openssl ecparam -genkey -name prime256v1 -noout -out ec_private.pem
  // openssl ec -in ec_private.pem -pubout -out ec_public.pem
  // openssl ec -in ec_private.pem -outform DER -pubout -out ec_public.dem

  // Parametri Inizializza:
  // ec_private.pem -> PEMPrivateKeyPath
  // ec_public.pem  -> PEMPublicKeyPath
  // ec_public.dem  -> DEMPublicKeyPath

  //richiede dll openssl in C:\Windows\SysWOW64(ssleay32.dll/libeay32.dll) x dll UniGUI!!??
  //richiede ServiceWorker.js/NotifichePush.js

  //x IrisAPP inserire nel CustomFiles del server module NotifichePush.js

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TC024FNotifichePushDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FInizializzato:=False;
  FECDSAPublicKey:=TStringList.Create;
  FECDSAPrivateKey:=TStringList.Create;
end;

procedure TC024FNotifichePushDM.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FECDSAPublicKey);
  FreeAndNil(FECDSAPrivateKey);
end;

class procedure TC024FNotifichePushDM.IscrizioneNotifiche(DEMFileName, nomeFunzioneJs: String; RichiestaIscrizioneNotifiche: TStrProc);
var LApplicationServerKey: String;
begin
  LApplicationServerKey:=Self.CalcolaApplicationServerKey(DEMFileName);

  if Assigned(RichiestaIscrizioneNotifiche) then
    RichiestaIscrizioneNotifiche('iscrizioneNotifichePush("' + LApplicationServerKey + '", ' + nomeFunzioneJs + ')') //serve passare inviaDatiAlServer?
  else
    raise Exception.Create('RichiestaIscrizioneNotifiche non definito');
end;

//estrae 65 byte dal file .dem (ApplicationServerKey), ritornati con codifica base64url
class function TC024FNotifichePushDM.CalcolaApplicationServerKey(DEMFileName: String): String;
var
  F: TFileStream;
  Buffer: array [0..64] of Byte;
begin
  if not TFile.Exists(DEMFileName) then
    raise Exception.Create('File DEM PublicKey non trovato');

  F:=TFileStream.Create(DEMFileName, fmOpenRead);
  try
    F.Seek(26, soFromBeginning);
    F.Read(Buffer, 65);
    Result:=EncodeBase64(@Buffer, 65);
    Result:=StringReplace(Result, #13#10, '', [rfReplaceAll]);
    Result:=StringReplace(Result, '=', '', [rfReplaceAll]);
    Result:=StringReplace(Result, '+', '-', [rfReplaceAll]);
    Result:=StringReplace(Result, '/', '_', [rfReplaceAll]);
  finally
    FreeAndNil(F);
  end;
end;

procedure TC024FNotifichePushDM.Inizializza(PEMPublicKeyPath, PEMPrivateKeyPath, DEMPublicKeyPath, Titolo, MailRiferimento, UrlClick: String);
var glob: HCkGlobal;
begin
  if not TFile.Exists(PEMPublicKeyPath) then
    raise Exception.Create('File PEM PublicKey non trovato');
  if not TFile.Exists(PEMPrivateKeyPath) then
    raise Exception.Create('File PEM PrivateKey non trovato');
  if not TFile.Exists(DEMPublicKeyPath) then
    raise Exception.Create('File DEM PublicKey non trovato');

  FECDSAPublicKey.LoadFromFile(PEMPublicKeyPath);
  FECDSAPrivateKey.LoadFromFile(PEMPrivateKeyPath);
  FApplicationServerKey:=CalcolaApplicationServerKey(DEMPublicKeyPath);
  FTitolo:=Titolo;
  FMailRiferimento:=MailRiferimento;
  FUrlClick:=UrlClick;
  FInizializzato:=True;

  //inizializza dll Chilkat
  glob:=CkGlobal_Create;
  try
    if (not CkGlobal_UnlockBundle(glob,'Anything for 30-day trial')) then
    begin
      raise Exception(CkGlobal__lastErrorText(glob));
      Exit;
    end;
  finally
    CkGlobal_Dispose(glob);
  end;
end;

function TC024FNotifichePushDM.InviaNotifica(ReceiverKey, AuthSecret, UrlWSPush, Testo, Id: String): TResCtrl;
var Plaintext: String;
    HttpBody: TBytesStream;
    HTTPResponse: IHTTPResponse;
begin
  Result.Clear;
  try
    if not FInizializzato then
    begin
      Result.Messaggio:='C024FNotifichePushDM non inizializzato';
      Exit;
    end;

    Plaintext:=CalcolaPlaintext(FTitolo, Testo, Id, FUrlClick);
    HttpBody:=CalcolaPayload(ReceiverKey, AuthSecret, Plaintext);
    try
      HTTPResponse:=HTTPClient.Post(UrlWSPush, HttpBody, nil, CalcolaHTTPHeader(UrlWSPush, Assigned(HttpBody)));

      Result.Ok:=True;
    finally
      FreeAndNil(HttpBody);
    end;
  except
    on E: Exception do
      Result.Messaggio:=E.Message;
  end;
end;

function TC024FNotifichePushDM.GetProtocolAndHost(const URI: string): string;
var
  IdURI: TIdURI;
begin
  IdURI:=TIdURI.Create(URI);
  try
    Result:=IdURI.Protocol + '://' + IdURI.Host;
  finally
    FreeAndNil(IdURI);
  end;
end;

procedure TC024FNotifichePushDM.HTTPClientRequestCompleted(const Sender: TObject; const AResponse: IHTTPResponse);
begin
  inherited;
  if Assigned(OnRequestCompleted) then
    OnRequestCompleted(Sender, AResponse);
end;

procedure TC024FNotifichePushDM.HTTPClientRequestError(const Sender: TObject; const AError: string);
begin
  inherited;
  if Assigned(OnRequestError) then
    OnRequestError(Sender, AError);
end;

//ritorna il token JWT firmandolo con la chiave ECDSA privata
function TC024FNotifichePushDM.CalcolaTokenJWT(PUrlWSPush: String): String;
var
  LJWT: TJWT;
  LSigner: TJWS;
  LKeys: TKeyPair;
  LAlg: TJOSEAlgorithmId;
  LJWTPayload: String;
  LUTCTime: Int64;
begin
  Result:='';
  LAlg:=TJOSEAlgorithmId.ES256;

  LJWTPayload:='{"aud": "%s","exp": %d,"sub": "mailto:%s"}';
  LUTCTime:=DateTimeToUnix(TTimeZone.Local.ToUniversalTime(Now + 1)); //impostare la scadenza max 24h avanti
  LJWTPayload:=Format(LJWTPayload, [GetProtocolAndHost(PUrlWSPush), LUTCTime, FMailRiferimento]); //

  LJWT:=TJWT.Create(JOSE.Core.JWT.TJWTClaims);
  try
    LJWT.Header.JSON.Free;
    LJWT.Header.JSON:=TJSONObject(TJSONObject.ParseJSONValue('{"alg": "ES256","typ": "JWT"}'));
    LJWT.Claims.JSON.Free;
    LJWT.Claims.JSON:=TJSONObject(TJSONObject.ParseJSONValue(LJWTPayload));

    if Assigned(LJWT.Header.JSON) and Assigned(LJWT.Claims.JSON) then
    begin
      LSigner:=TJWS.Create(LJWT);

      try
        LKeys:=TKeyPair.Create(FECDSAPublicKey.Text, FECDSAPrivateKey.Text);

        LSigner.SkipKeyValidation:=False;
        LSigner.Sign(LKeys.PrivateKey, LAlg);

        Result:=LSigner.Header.AsString + '.' + LSigner.Payload.AsString + '.' + LSigner.Signature.AsString;
      finally
        FreeAndNil(LKeys);
        FreeAndNil(LSigner);
      end;
    end;
  finally
    FreeAndNil(LJWT);
  end;
end;

function TC024FNotifichePushDM.CalcolaHTTPHeader(PUrlWSPush: String; PHttpBodyPresente: Boolean): TArray<TNameValuePair>;
begin
  Result:=TArray<TNameValuePair>.Create
  (
    TNameValuePair.Create('Authorization', 'WebPush ' + CalcolaTokenJWT(PUrlWSPush)),
    TNameValuePair.Create('TTL', '0'),
    TNameValuePair.Create('Urgency', 'high'),  // urgency-option = ("very-low" / "low" / "normal" / "high")
    TNameValuePair.Create('Crypto-Key', 'p256ecdsa=' + FApplicationServerKey)
  );

  if PHttpBodyPresente then
  begin
    SetLength(Result, 5);
    Result[4]:=TNameValuePair.Create('Content-Encoding', 'aes128gcm');
  end;
end;

function TC024FNotifichePushDM.Base64UrltoBase64(Value: String): String;
var padding, i: integer;
begin
  Result:=Value;
  padding:=(4 - (Value.Length mod 4)) mod 4;
  for i := 0 to padding-1 do
    Result:=Result + '=';
  Result:=StringReplace(Result, '-', '+', [rfReplaceAll]);
  Result:=StringReplace(Result, '_', '/', [rfReplaceAll]);
end;

function TC024FNotifichePushDM.Base64toBase64Url(Value: String): String;
begin
  Result:=StringReplace(Value, '=', '', [rfReplaceAll]);
  Result:=StringReplace(Result, '+', '-', [rfReplaceAll]);
  Result:=StringReplace(Result, '/', '_', [rfReplaceAll]);
end;

function TC024FNotifichePushDM.Base64Concat(value1, value2: String): String;
var value2_TIdbytes, result_TIdbytes: TIdBytes;
    i: Integer;
begin
  result_TIdbytes:=TIdDecoderMIME.DecodeBytes(value1);
  value2_TIdbytes:=TIdDecoderMIME.DecodeBytes(value2);

  for i := 0 to Length(value2_TIdbytes)-1 do
    InsertByte(result_TIdbytes, value2_TIdbytes[i], Length(result_TIdbytes));

  Result:=TIdEncoderMIME.EncodeBytes(result_TIdbytes);
end;

function TC024FNotifichePushDM.CalcolaPlaintext(Titolo, Testo, Id, Url: String): String;
var LJson: TJSONObject;
begin
  LJson:=TJSONObject.Create;
  try
    LJson.AddPair('title', Titolo);
    LJson.AddPair('body', Testo);
    LJson.AddPair('id', Id);
    LJson.AddPair('url', Url);

    Result:=LJson.ToString;
  finally
    FreeAndNil(LJson);
  end;
end;

function TC024FNotifichePushDM.CalcolaSharedSecret(ua_public: String; var as_public: String): String;
var
  i: Integer;
  prngServer: HCkPrng;
  eccServer: HCkEcc;
  privKeyServer: HCkPrivateKey;
  pubKeyServer: HCkPublicKey;
  JWKpublicKey: PWideChar;
  JSonValue:TJSonValue;
  pubKeyFromClient: HCkPublicKey;
  as_public_x, as_public_y, ua_public_x, ua_public_y: String;
  as_public_x_TIdbytes, as_public_y_TIdbytes,
  ua_public_x_TIdbytes, ua_public_y_TIdbytes, ua_public_TIdbytes: TIdBytes;

  //TMS
  //ecc: TECCEncSign;
begin
  //Chilkat ECDH SECRET --------------------------------------------------------
  //OK
  prngServer:=CkPrng_Create();
  eccServer:=CkEcc_Create();
  try
    privKeyServer:=CkEcc_GenEccKey(eccServer,'secp256r1',prngServer);
    if (CkEcc_getLastMethodSuccess(eccServer) <> True) then
    begin
      raise Exception(CkEcc__lastErrorText(eccServer));
      Exit;
    end;
    pubKeyServer:=CkPrivateKey_GetPublicKey(privKeyServer);

    JWKpublicKey:=CkPublicKey__GetJwk(pubKeyServer);
    if (CkPublicKey_getLastMethodSuccess(pubKeyServer) <> True) then
    begin
      raise Exception(CkPublicKey__lastErrorText(pubKeyServer));
      Exit;
    end;

    //estrazione as_public
    JsonValue:=TJSonObject.ParseJSONValue(JWKpublicKey);
    as_public_x:=Base64UrlToBase64(JsonValue.GetValue<string>('x'));
    as_public_y:=Base64UrlToBase64(JsonValue.GetValue<string>('y'));

    as_public:=Base64Concat('BA==', as_public_x);
    as_public:=Base64Concat(as_public, as_public_y);

    ua_public_TIdbytes:=TIdDecoderMIME.DecodeBytes(ua_public);

    //creazione ua_public x calcolo shared secret
    for i := 1 to 32 do
      InsertByte(ua_public_x_TIdbytes, ua_public_TIdbytes[i], Length(ua_public_x_TIdbytes));
    for i := 33 to Length(ua_public_TIdbytes)-1 do
      InsertByte(ua_public_y_TIdbytes, ua_public_TIdbytes[i], Length(ua_public_y_TIdbytes));

    ua_public_x:=Base64ToBase64Url(TIdEncoderMIME.EncodeBytes(ua_public_x_TIdbytes));
    ua_public_y:=Base64ToBase64Url(TIdEncoderMIME.EncodeBytes(ua_public_y_TIdbytes));

    JWKpublicKey:=PWideChar('{"kty":"EC","crv":"P-256","x":"' + ua_public_x + '","y":"' + ua_public_y + '"}');
    pubKeyFromClient:=CkPublicKey_Create();
    if not CkPublicKey_LoadFromString(pubKeyFromClient, JWKpublicKey) then
    begin
      raise Exception(CkEcc__lastErrorText(pubKeyFromClient));
      Exit;
    end;
    //calcolo shared secret
    Result:=CkEcc__sharedSecretENC(eccServer, privKeyServer, pubKeyFromClient,'base64');
  finally
    FreeAndNil(JsonValue);
    CkPublicKey_Dispose(pubKeyFromClient);
    CkPublicKey_Dispose(pubKeyServer);
    CkPrivateKey_Dispose(privKeyServer);
    CkPrng_Dispose(prngServer);
    CkEcc_Dispose(eccServer);
  end;

  //TMS Cryptography Pack ECDH SECRET ------------------------------------------
  // OK (ma non funziona su dll!!)
  {ecc:=TECCEncSign.Create;
  try
    ecc.ECCType:=p256;
    ecc.OutputFormat:=TConvertType.base64;
    ecc.Unicode:=yesUni;
    ecc.GenerateKeys;

    as_public:=ecc.PublicKey;

    Result:=ecc.GenerateSharedSecret(ua_public);
  finally
    FreeAndNil(ecc);
  end;}
  //----------------------------------------------------------------------------
end;

function TC024FNotifichePushDM.CalcolaAES128GCM(Key, InitVector, AuthData, Plaintext: String): String;
var
  i: Integer;
  crypt: HCkCrypt2;
  base64: TBase64Encoding;
  K, IV, AAD, PT, CT, TAG: PWideChar;
  CT_TIdbytes, TAG_TIdbytes, ciphertext_TIdbytes: TIdBytes;

  //TMS
  //aesgcm: AESObj.TAESGCM;
  //Key_Tbytes, InitVector_Tbytes, AuthData_Tbytes: Tbytes;
  //InitVector_ansi, Key_ansi, Authdata_ansi: String;
begin
  //Chilkat AES128GCM ----------------------------------------------------------
  // OK
  base64:=TBase64Encoding.Create(0);
  crypt:=CkCrypt2_Create();
  try
    CkCrypt2_putCryptAlgorithm(crypt, 'aes');
    CkCrypt2_putCipherMode(crypt, 'gcm');
    CkCrypt2_putKeyLength(crypt, 128);

    K:=PWideChar(Key);
    IV:=PWideChar(InitVector);
    AAD:=PWideChar(Authdata);
    PT:=PWideChar(base64.Encode(Plaintext));

    CkCrypt2_putEncodingMode(crypt, 'base64');
    CkCrypt2_SetEncodedIV(crypt, IV, 'base64');
    CkCrypt2_SetEncodedKey(crypt, K, 'base64');

    CkCrypt2_SetEncodedAad(crypt, AAD, 'base64');

    CT:=CkCrypt2__encryptEncoded(crypt, PT);
    if (CkCrypt2_getLastMethodSuccess(crypt) <> True) then
    begin
      raise Exception(CkCrypt2__lastErrorText(crypt));
      Exit;
    end;

    TAG:=CkCrypt2__getEncodedAuthTag(crypt, 'base64');

    CT_TIdbytes:=TIdDecoderMIME.DecodeBytes(CT);
    TAG_TIdbytes:=TIdDecoderMIME.DecodeBytes(TAG);

    //devo accodare TAG a CT
    SetLength(ciphertext_TIdbytes, 0);
    ciphertext_TIdbytes:=CT_TIdbytes;
    for i:=0 to Length(TAG_TIdbytes)-1 do
      InsertByte(ciphertext_TIdbytes, TAG_TIdbytes[i], Length(ciphertext_TIdbytes));

    Result:=TIdEncoderMIME.EncodeBytes(ciphertext_TIdbytes);
  finally
    CkCrypt2_Dispose(crypt);
    FreeAndNil(base64);
  end;
  //----------------------------------------------------------------------------

  //TMS Cryptography Pack AES128GCM --------------------------------------------
  // OK (ma non funziona su dll!!)
  {Key_Tbytes:=DecodeBase64(Key);
  InitVector_Tbytes:=DecodeBase64(InitVector);
  AuthData_TBytes:=DecodeBase64(Authdata);
  aesgcm:=AESObj.TAESGCM.Create;
  try
    aesgcm.Unicode:=yesUni;
    aesgcm.TagSizeBits:=128;
    aesgcm.KeyLength:=kl128;
    SetString(Key_ansi, PAnsiChar(@Key_Tbytes[0]), Length(Key_Tbytes));
    aesgcm.Key:=Key_ansi;
    aesgcm.OutputFormat:=TConvertType.base64;
    aesgcm.IVMode:=TIVMode.userdefined;
    aesgcm.IVLength:=12;
    SetString(InitVector_ansi, PAnsiChar(@InitVector_Tbytes[0]), Length(InitVector_Tbytes));
    aesgcm.IV:=InitVector_ansi;
    SetString(AuthData_ansi, PAnsiChar(@AuthData_Tbytes[0]), Length(AuthData_Tbytes));
    Result:=aesgcm.EncryptAndGenerate(plaintext, '');
  finally
    FreeAndNil(aesgcm);
  end;}
  //----------------------------------------------------------------------------
end;

function TC024FNotifichePushDM.CalcolaPayload(p256dhKey, authSecret, plaintext: String): TBytesStream;
var
  base64: TBase64Encoding;

  as_private, ua_public, as_public, auth_secret, IKM, key_info, ecdh_secret, header: String;
  NONCE, NONCE_info, NONCE_ansi, salt, CEK, CEK_ansi, CEK_info, PRK, PRK_key, payload, ciphertext: String;

  ua_public_TIdbytes, as_public_TIdbytes, as_public_TIdbytes_temp, as_private_TIdbytes, key_info_TIdbytes, header_TIdbytes, ciphertext_TIdbytes, payload_TIdbytes: TIdBytes;
  CEK_Tbytes, PRK_key_Tbytes, IKM_Tbytes, NONCE_Tbytes, PRK_Tbytes, salt_Tbytes: Tbytes;

  i: integer;

  //ua_public_TECCPublicKey: TECCPublicKey;
  //as_private_TECCPrivateKey: TECCPrivateKey;
  //as_public_TECCPublicKey: TECCPublicKey;
  //as_public_TECCPublicKeyUncompressed, ua_public_TECCPublicKeyUncompressed: TECCPublicKeyUncompressed;
  //ecdh_secret_TECCSecretKey: TECCSecretKey;

  //AESEngine: TAESGCMEngine;
  //AESTag: TAESBlock;
  plaintext_Tbytes, ciphertext_Tbytes, AAD_Tbytes: Tbytes;

  glob: HCkGlobal;
  crypt: HCkCrypt2;
  K: PWideChar;
  IV: PWideChar;
  AAD: PWideChar;
  PT: PWideChar;
  CT: PWideChar;
  T: PWideChar;
  ctResult: PWideChar;
  tResult: PWideChar;
  ptResult: PWideChar;
  tInvalid: PWideChar;
  TAG: PWideChar;
  CT_TIdbytes: TIdBytes;
  TAG_TIdbytes: TIdBytes;

  pubKeyFromClient: HCkPublicKey;

  success: Boolean;
  prngServer: HCkPrng;
  eccServer: HCkEcc;
  privKeyServer: HCkPrivateKey;
  pubKeyServer: HCkPublicKey;
  pubKeyFromServer: HCkPublicKey;
  sharedSecret1: PWideChar;
  sharedSecret2: PWideChar;
  JWKpublicKey: PWideChar;

  JSonValue: TJSonValue;
  as_public_x, as_public_y, ua_public_x, ua_public_y: String;
  as_public_x_TIdbytes, as_public_y_TIdbytes, ua_public_x_TIdbytes, ua_public_y_TIdbytes: TIdBytes;
begin
  if Trim(plaintext) = '' then
  begin
    Result:=nil;
    Exit;
  end;

  base64:=TBase64Encoding.Create(0);
  try
    //ATTENZIONE!!! as_public finisce nell'header del payload in formato X9.62!!!

    //MORMOT ECDH SECRET ---------------------------------------------------------
    // OK (con chiavi fisse)

    //creazione dinamica delle chiavi non funziona!!!
    {if ecc_make_key(as_public_TECCPublicKey, as_private_TECCPrivateKey) then
      ecc_uncompress_key_pas(as_public_TECCPublicKey, as_public_TECCPublicKeyUncompressed);
    //as_private
    as_private:=EncodeBase64(@as_private_TECCPrivateKey, Length(as_private_TECCPrivateKey));
    //as_public
    //as_public:=EncodeBase64(@as_public_TECCPublicKeyUncompressed, Length(as_public_TECCPublicKeyUncompressed));
    as_public:=EncodeBase64(@as_public_TECCPublicKey, Length(as_public_TECCPublicKey));
    //as_public:=as_public.Replace(#$D#$A,'');
    //as_public_TIdbytes_temp:=TIdDecoderMIME.DecodeBytes(as_public);
    //InsertByte(as_public_TIdbytes, 4, Length(as_public_TIdbytes));
    //for i := 0 to 31 do //Length(as_public_TIdbytes_temp)-1 do
    //  InsertByte(as_public_TIdbytes, as_public_TIdbytes_temp[i], Length(as_public_TIdbytes));
    //as_public:=TIdEncoderMIME.EncodeBytes(as_public_TIdbytes);}

    {as_private:='XgHEB5rp8OTtAAiQJl6UjTci/erdjiXaXx9+wJu3BGU=';
    as_private_TIdbytes:=TIdDecoderMIME.DecodeBytes(as_private);
    as_public:='BKL47Nckm8D0cHyw4a83DqaiNtLqv9+YnBTDz27gn2K2RVaX9tMYhoavsiK0DqBnFp+qO0XdcLl2mZ3WHJcRsuc=';
    as_public_TIdbytes:=TIdDecoderMIME.DecodeBytes(as_public);

    ua_public:=Base64UrltoBase64(p256dhKey);//convert.Base64UrlToBase64(p256dhKey);  //input da registrazione browser
    ua_public_TIdbytes:=TIdDecoderMIME.DecodeBytes(ua_public);

    Move(ua_public_TIdbytes[0], ua_public_TECCPublicKey, 33); //dovrei usare la versione compressa?? Perchè così funziona??
    Move(as_private_TIdbytes[0], as_private_TECCPrivateKey, Length(as_private_TIdbytes));
    if ecdh_shared_secret(ua_public_TECCPublicKey, as_private_TECCPrivateKey, ecdh_secret_TECCSecretKey) then
      ecdh_secret:=EncodeBase64(@ecdh_secret_TECCSecretKey, Length(ecdh_secret_TECCSecretKey));}
    //----------------------------------------------------------------------------

    //ecdh_secret
    ua_public:=Base64UrltoBase64(p256dhKey);          //input da registrazione browser
    ua_public_TIdbytes:=TIdDecoderMIME.DecodeBytes(ua_public);

    ecdh_secret:=CalcolaSharedSecret(ua_public, as_public);
    as_public_TIdbytes:=TIdDecoderMIME.DecodeBytes(as_public);

    //auth_secret
    auth_secret:=Base64UrltoBase64(authSecret);  //input da registrazione browser

    //salt
    salt_Tbytes:=TJOSEBytes.RandomBytes(16).AsBytes;
    salt:=EncodeBase64(salt_Tbytes, Length(salt_Tbytes));

    //key_info
    key_info:='WebPush: info' + #0;
    key_info_TIdbytes:=toBytes(key_info);
    for i := 0 to Length(ua_public_TIdbytes)-1 do
      InsertByte(key_info_TIdbytes, ua_public_TIdbytes[i], Length(key_info_TIdbytes));
    for i := 0 to Length(as_public_TIdbytes)-1 do
      InsertByte(key_info_TIdbytes, as_public_TIdbytes[i], Length(key_info_TIdbytes));
    key_info:=TIdEncoderMIME.EncodeBytes(key_info_TIdbytes);
    //key_info - aggiunta #1 finale
    InsertByte(key_info_TIdbytes, 1, Length(key_info_TIdbytes));
    key_info:=TIdEncoderMIME.EncodeBytes(key_info_TIdbytes);

    //cek_info
    cek_info:=base64.Encode('Content-Encoding: aes128gcm' + #0#1);

    //nonce_info
    nonce_info:=base64.Encode('Content-Encoding: nonce' + #0#1);

    //PRK_key
    PRK_key_Tbytes:=THMAC.Sign(DecodeBase64(ecdh_secret), DecodeBase64(auth_secret), THMACAlgorithm.SHA256);
    PRK_key:=EncodeBase64(PRK_key_Tbytes, Length(PRK_key_Tbytes));

    //IKM
    IKM_Tbytes:=THMAC.Sign(DecodeBase64(key_info), PRK_key_Tbytes, THMACAlgorithm.SHA256);
    IKM:=EncodeBase64(IKM_Tbytes, Length(IKM_Tbytes));

    //PRK
    PRK_Tbytes:=THMAC.Sign(IKM_Tbytes, salt_Tbytes, THMACAlgorithm.SHA256);
    PRK:=EncodeBase64(PRK_Tbytes, Length(PRK_Tbytes));

    //CEK
    CEK_Tbytes:=THMAC.Sign(DecodeBase64(cek_info), PRK_Tbytes, THMACAlgorithm.SHA256);
    SetLength(CEK_Tbytes, 16);
    CEK:=EncodeBase64(CEK_Tbytes, Length(CEK_Tbytes));                          //key per AES128GCM

    //NONCE
    NONCE_Tbytes:=THMAC.Sign(DecodeBase64(nonce_info), PRK_Tbytes, THMACAlgorithm.SHA256);
    SetLength(NONCE_Tbytes, 12);
    NONCE:=EncodeBase64(NONCE_Tbytes, Length(NONCE_Tbytes));                    //iv per AES128GCM

    //MORMOT AES128GCM------------------------------------------------------------
    //!! non funziona !!
    {plaintext_Tbytes:=DecodeBase64(base64.Encode(plaintext + #2)); //TEncoding.UTF8.GetBytes(plaintext + #2);
    SetLength(ciphertext_Tbytes, Length(plaintext_Tbytes));

    SetLength(AAD_Tbytes, 0);

    if AESEngine.FullEncryptAndAuthenticate(CEK_Tbytes, Length(CEK_Tbytes)*8,
                                            NONCE_Tbytes, Length(NONCE_Tbytes),
                                            AAD_Tbytes, Length(AAD_Tbytes),
                                            plaintext_Tbytes, ciphertext_Tbytes, Length(plaintext_Tbytes),
                                            AESTag) then
    begin
      ciphertext:=EncodeBase64(ciphertext_Tbytes, Length(ciphertext_Tbytes));
      ciphertext_TIdbytes:=TIdDecoderMIME.DecodeBytes(ciphertext);
    end;}
    //----------------------------------------------------------------------------

    //ciphertext = AES128GCM(plaintext + 0x02, key=CEK, iv=NONCE, AAD='')
    ciphertext:=CalcolaAES128GCM(CEK, NONCE, '',  plaintext + #2);

    //header
    header:=salt.Replace('=', '') + 'AAEABB' + as_public; //AAEABB = 4096 (dimensione del record in network byte order su 32 bit?)
    payload:=Base64Concat(header, ciphertext);

    Result:=TBytesStream.Create(DecodeBase64(payload));
  finally
    FreeAndNil(base64);
  end;
end;

end.
