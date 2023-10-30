unit B021UContentHandler;

interface

uses
  SysUtils, Classes, IW.Content.Base, HTTPApp, IWApplication, IW.HTTP.Request,
  IW.HTTP.Reply, B021UIrisRestSvcDM, System.JSON, StrUtils, IW.HTTP.FileItem, EncdDecd;

//------------------------------------------------------------------------------
// ATTENZIONE!! Intraweb non consente di usare PUT e DELETE --------------------
//------------------------------------------------------------------------------

type
  TB021FContentHandler = class(TContentBase)
  private
    function GetRequestBody(aRequest: THttpRequest): TJSONObject;
    function GetListaParametri(URI: String): TStringList;
    function GetReplyString(ResultString: String): String;
    function GetReplyJSON(ResultJSON: TJSONObject): String;
    function GetErrorMessage(errorMessage: String): String;
    function Base64UrltoString(Value: String): String;
  protected
    function Execute(aRequest: THttpRequest; aReply: THttpReply; const aPathname: string; aSession: TIWApplication; aParams: TStrings): boolean; override;
  public
    constructor Create; override;
  end;

const
  URL_WS_B021 = '/datasnap/rest/TB021FIrisRestSvcDM/';
  MAX_PARAMETRI = 20; //NUMERO MASSIMO (-1 USATO PER IDENTIFICARE IL METODO) DI PARAMETRI CONTENUTI NELL'URL

  URL_ECHOSTRING                = 'ECHOSTRING';                // GET/POST
  URL_ANAGRAFICHE               = 'ANAGRAFICHE';               // GET
  URL_DIZIONARIO                = 'DIZIONARIO';                // GET + paginazione
  URL_DIZIONARIOASSENZE         = 'DIZIONARIOASSENZE';         // GET
  URL_DIZIONARIOORARI           = 'DIZIONARIOORARI';           // GET
  URL_GIUSTIFICATIVI            = 'GIUSTIFICATIVI';            // GET/POST
  URL_ACCEPTGIUSTIFICATIVI      = 'ACCEPTGIUSTIFICATIVI';      // POST
  URL_UPDATEGIUSTIFICATIVI      = 'UPDATEGIUSTIFICATIVI';      // POST (alternativo a POST su GIUSTIFICATIVI)
  URL_CANCELGIUSTIFICATIVI      = 'CANCELGIUSTIFICATIVI';      // GET
  URL_R502CONTEGGI              = 'R502CONTEGGI';              // GET
  URL_R502TIMBRATURECONTEGGIATE = 'R502TIMBRATURECONTEGGIATE'; // GET
  URL_R600GETASSENZE            = 'R600GETASSENZE';            // GET
  URL_TIMBRATURE                = 'TIMBRATURE';                // GET
  URL_TURNI                     = 'TURNI';                     // GET/POST
  URL_UPDATETURNI               = 'UPDATETURNI';               // POST (alternativo a POST su TURNI)
  URL_ACCEPTTURNI               = 'ACCEPTTURNI';               // POST
  URL_CANCELTURNI               = 'CANCELTURNI';               // GET
  URL_R600CONTROLLIGENERALI     = 'R600CONTROLLIGENERALI';     // GET
  URL_ANAOPEFSE                 = 'ANAOPEFSE';                 // GET
  URL_MANCOP_PERSGG             = 'MANCOP_PERSGG';             // GET
  URL_MANCOP_PERSMM             = 'MANCOP_PERSMM';             // GET
  URL_C021DOCUMENTOBLOB         = 'C021DOCUMENTOBLOB';         // GET
  URL_ACCEPTC021DOCUMENTOBLOB   = 'ACCEPTC021DOCUMENTOBLOB';   // POST
  URL_CANCELC021DOCUMENTOBLOB   = 'CANCELC021DOCUMENTOBLOB';   // GET
  URL_C021DOCUMENTOBLOBTICKET   = 'C021DOCUMENTOBLOBTICKET';   // GET
  URL_I060UTENTI                = 'I060UTENTI';                // POST
implementation

uses
  IW.Content.Handlers, IWMimeTypes;

constructor TB021FContentHandler.Create;
begin
  inherited;
  mFileMustExist:=False;
  mCanStartSession:=True;
  mRequiresSessionStart:=False;
  mRequiresSession:=True;
end;

function TB021FContentHandler.Execute(aRequest: THttpRequest; aReply: THttpReply; const aPathname: string; aSession: TIWApplication; aParams: TStrings): boolean;
var
  B021: TB021FIrisRestSvcDM;
  ResultJSON: TJSONObject;
  ResultString: String;
  LURI, LMetodo, LTemp: String;
  LParametri: TStringList;
  RequestBody: TJSONObject;
begin
  try
    try
      B021:=TB021FIrisRestSvcDM.Create(nil);
      try
        LURI:=Copy(aRequest.PathInfo, Length(URL_WS_B021)+1, Length(aRequest.PathInfo) - Length(URL_WS_B021));

        // Gestione eventuale token di autenticazione
        B021.Token:=aRequest.GetQueryFieldValue('token');
        B021.Timestamp:=aRequest.GetQueryFieldValue('timestamp');

        LParametri:=GetListaParametri(LURI);
        try
          LMetodo:=LParametri[0].ToUpper; //case insensitive
          ResultString:='';
          // -----------------------------------------------------------------------------------
          // EchoString - GET ------------------------------------------------------------------ OK
          if (LMetodo = URL_ECHOSTRING) and (aRequest.HttpMethod = hmGet) then
            ResultString:=B021.EchoString(LParametri[1])
          // -----------------------------------------------------------------------------------
          // EchoString - POST ----------------------------------------------------------------- OK
          else if (LMetodo = URL_ECHOSTRING) and (aRequest.HttpMethod = hmPost) then
          begin
            RequestBody:=GetRequestBody(aRequest);
            try
              ResultString:=B021.updateEchoString(LParametri[1], RequestBody);
            finally
              RequestBody.Free;
            end;
          end
          // -----------------------------------------------------------------------------------
          // Anagrafiche - GET ----------------------------------------------------------------- OK
          else if (LMetodo = URL_ANAGRAFICHE) and (aRequest.HttpMethod = hmGet) then
            ResultJSON:=B021.Anagrafiche(LParametri[1], LParametri[2], LParametri[3], LParametri[4])
          // -----------------------------------------------------------------------------------
          // Dizionario - GET ------------------------------------------------------------------ OK
          else if (LMetodo = URL_DIZIONARIO) and (aRequest.HttpMethod = hmGet) then
          begin
            B021.PageRichiesta:=aRequest.GetQueryFieldValue('page');
            B021.PerPageRichiesta:=aRequest.GetQueryFieldValue('per_page');
            B021.URLRichiesta:=aSession.FullApplicationURL(aRequest) + aRequest.PathInfo;
            ResultJSON:=B021.Dizionario(LParametri[1], LParametri[2], LParametri[3], LParametri[4], LParametri[5]);
          end
          // -----------------------------------------------------------------------------------
          // DizionarioAssenze - GET ----------------------------------------------------------- OK
          else if (LMetodo = URL_DIZIONARIOASSENZE) and (aRequest.HttpMethod = hmGet) then
            ResultJSON:=B021.DizionarioAssenze(LParametri[1], LParametri[2], LParametri[3], LParametri[4])
          // -----------------------------------------------------------------------------------
          // DizionarioOrari - GET -------------------------------------------------------------
          else if (LMetodo = URL_DIZIONARIOORARI) and (aRequest.HttpMethod = hmGet) then
            ResultJSON:=B021.DizionarioOrari(LParametri[1], LParametri[2], LParametri[3], LParametri[4], LParametri[5])
          // -----------------------------------------------------------------------------------
          // Giustificativi - GET -------------------------------------------------------------- OK
          else if (LMetodo = URL_GIUSTIFICATIVI) and (aRequest.HttpMethod = hmGet) then
            ResultJSON:=B021.Giustificativi(LParametri[1], LParametri[2], LParametri[3], LParametri[4], LParametri[5], LParametri[6])
          // -----------------------------------------------------------------------------------
          // Giustificativi/updateGiustificativi - POST ----------------------------------------
          else if ((LMetodo = URL_GIUSTIFICATIVI) or (LMetodo = URL_UPDATEGIUSTIFICATIVI)) and (aRequest.HttpMethod = hmPost) then
          begin
            RequestBody:=GetRequestBody(aRequest);
            try
              ResultJSON:=B021.updateGiustificativi(LParametri[1], LParametri[2], LParametri[3], RequestBody);
            finally
              RequestBody.Free;
            end;
          end
          // -----------------------------------------------------------------------------------
          // acceptGiustificativi - POST ------------------------------------------------------- OK
          else if (LMetodo = URL_ACCEPTGIUSTIFICATIVI) and (aRequest.HttpMethod = hmPost) then
          begin
            RequestBody:=GetRequestBody(aRequest);
            try
              ResultJSON:=B021.acceptGiustificativi(LParametri[1], LParametri[2], LParametri[3], RequestBody);
            finally
              RequestBody.Free;
            end;
          end
          // -----------------------------------------------------------------------------------
          // cancelGiustificativi - GET -------------------------------------------------------- OK
          else if (LMetodo = URL_CANCELGIUSTIFICATIVI) and (aRequest.HttpMethod = hmGet) then
            ResultJSON:=B021.cancelGiustificativi(LParametri[1], LParametri[2], LParametri[3], LParametri[4], LParametri[5], LParametri[6], LParametri[7], LParametri[8], LParametri[9])
          // -----------------------------------------------------------------------------------
          // R502Conteggi - GET ----------------------------------------------------------------
          else if (LMetodo = URL_R502CONTEGGI) and (aRequest.HttpMethod = hmGet) then
            ResultJSON:=B021.R502Conteggi(LParametri[1], LParametri[2], LParametri[3], LParametri[4], LParametri[5])
          // -----------------------------------------------------------------------------------
          // R502TimbratureConteggiate - GET --------------------------------------------------- OK
          else if (LMetodo = URL_R502TIMBRATURECONTEGGIATE) and (aRequest.HttpMethod = hmGet) then
            ResultJSON:=B021.R502TimbratureConteggiate(LParametri[1], LParametri[2], LParametri[3], LParametri[4], LParametri[5], LParametri[6])
          // -----------------------------------------------------------------------------------
          // R600GetAssenze - GET --------------------------------------------------------------
          else if (LMetodo = URL_R600GETASSENZE) and (aRequest.HttpMethod = hmGet) then
            ResultJSON:=B021.R600GetAssenze(LParametri[1], LParametri[2], LParametri[3], LParametri[4], LParametri[5], LParametri[6], LParametri[7])
          // -----------------------------------------------------------------------------------
          // Timbrature - GET ------------------------------------------------------------------ OK
          else if (LMetodo = URL_TIMBRATURE) and (aRequest.HttpMethod = hmGet) then
            ResultJSON:=B021.Timbrature(LParametri[1], LParametri[2], LParametri[3], LParametri[4], LParametri[5], LParametri[6])
          // -----------------------------------------------------------------------------------
          // Turni - GET -----------------------------------------------------------------------
          else if (LMetodo = URL_TURNI) and (aRequest.HttpMethod = hmGet) then
            ResultJSON:=B021.Turni(LParametri[1], LParametri[2], LParametri[3], LParametri[4], LParametri[5], LParametri[6])
          // -----------------------------------------------------------------------------------
          // Turni/updateTurni - POST ----------------------------------------------------------
          else if ((LMetodo = URL_TURNI) or (LMetodo = URL_UPDATETURNI)) and (aRequest.HttpMethod = hmPost) then
          begin
            RequestBody:=GetRequestBody(aRequest);
            try
              ResultJSON:=B021.updateTurni(LParametri[1], LParametri[2], LParametri[3], LParametri[4], RequestBody);
            finally
              RequestBody.Free;
            end;
          end
          // -----------------------------------------------------------------------------------
          // acceptTurni - POST ----------------------------------------------------------------
          else if (LMetodo = URL_ACCEPTTURNI) and (aRequest.HttpMethod = hmPost) then
          begin
            RequestBody:=GetRequestBody(aRequest);
            try
              ResultJSON:=B021.acceptTurni(LParametri[1], LParametri[2], LParametri[3], LParametri[4], RequestBody);
            finally
              RequestBody.Free;
            end;
          end
          // -----------------------------------------------------------------------------------
          // cancelTurni - GET -----------------------------------------------------------------
          else if (LMetodo = URL_CANCELTURNI) and (aRequest.HttpMethod = hmGet) then
            ResultJSON:=B021.cancelTurni(LParametri[1], LParametri[2], LParametri[3], LParametri[4], LParametri[5], LParametri[6], LParametri[7])
          // -----------------------------------------------------------------------------------
          // R600ControlliGenerali - GET -------------------------------------------------------
          else if (LMetodo = URL_R600CONTROLLIGENERALI) and (aRequest.HttpMethod = hmGet) then
            ResultJSON:=B021.R600ControlliGenerali(LParametri[1], LParametri[2], LParametri[3], LParametri[4], LParametri[5], LParametri[6], LParametri[7], LParametri[8])
          // -----------------------------------------------------------------------------------
          // AnaOpeFSE - GET -------------------------------------------------------------------
          else if (LMetodo = URL_ANAOPEFSE) and (aRequest.HttpMethod = hmGet) then
            ResultJSON:=B021.AnaOpeFSE(LParametri[1], LParametri[2], LParametri[3], LParametri[4], LParametri[5], LParametri[6])
          // -----------------------------------------------------------------------------------
          // Mancop_PersGG - GET ---------------------------------------------------------------
          else if (LMetodo = URL_MANCOP_PERSGG) and (aRequest.HttpMethod = hmGet) then
            ResultJSON:=B021.Mancop_PersGG(LParametri[1], LParametri[2], LParametri[3], LParametri[4], LParametri[5], LParametri[6])
          // -----------------------------------------------------------------------------------
          // Mancop_PersMM - GET ---------------------------------------------------------------
          else if (LMetodo = URL_MANCOP_PERSMM) and (aRequest.HttpMethod = hmGet) then
            ResultJSON:=B021.Mancop_PersMM(LParametri[1], LParametri[2], LParametri[3], LParametri[4], LParametri[5], LParametri[6])
          // -----------------------------------------------------------------------------------
          // C021DocumentoBlob - GET ----------------------------------------------------------- OK
          else if (LMetodo = URL_C021DOCUMENTOBLOB) and (aRequest.HttpMethod = hmGet) then
            ResultJSON:=B021.C021DocumentoBlob(LParametri[1], LParametri[2], LParametri[3], Base64UrltoString(LParametri[4]), LParametri[5])
          // -----------------------------------------------------------------------------------
          // acceptC021DocumentoBlob - POST ---------------------------------------------------- OK
          else if (LMetodo = URL_ACCEPTC021DOCUMENTOBLOB) and (aRequest.HttpMethod = hmPost) then
          begin
            RequestBody:=GetRequestBody(aRequest);
            try
              ResultJSON:=B021.acceptC021DocumentoBlob(LParametri[1], LParametri[2], LParametri[3], RequestBody);
            finally
              RequestBody.Free;
            end;
          end
          // -----------------------------------------------------------------------------------
          // cancelC021DocumentoBlob - GET ----------------------------------------------------- OK
          else if (LMetodo = URL_CANCELC021DOCUMENTOBLOB) and (aRequest.HttpMethod = hmGet) then
              ResultJSON:=B021.cancelC021DocumentoBlob(LParametri[1], LParametri[2], LParametri[3], Base64UrltoString(LParametri[4]), LParametri[5])
          // -----------------------------------------------------------------------------------
          // C021DocumentoBlobTicket - GET ----------------------------------------------------- OK
          else if (LMetodo = URL_C021DOCUMENTOBLOBTICKET) and (aRequest.HttpMethod = hmGet) then
            ResultJSON:=B021.C021DocumentoBlobTicket(LParametri[1], LParametri[2], LParametri[3], LParametri[4])
          // -----------------------------------------------------------------------------------
          // I060Utenti        - POST ----------------------------------------------------------
          else if (LMetodo = URL_I060UTENTI) and (aRequest.HttpMethod = hmPost) then
          begin
            RequestBody:=GetRequestBody(aRequest);
            try
              ResultJSON:=B021.updateI060Utenti(LParametri[1], LParametri[2], LParametri[3], RequestBody);
            finally
              RequestBody.Free;
            end;
          end
          // -----------------------------------------------------------------------------------
          else // 404 - Not found
          begin
            Result:=False;
            Exit;
          end;
          // -----------------------------------------------------------------------------------

          // creazione risposta
          aReply.ContentType:=MIME_JSON;
          if (ResultString <> '') or (ResultJSON = nil) then
            aReply.WriteString(GetReplyString(ResultString))
          else if ResultJSON <> nil then
            aReply.WriteString(GetReplyJSON(ResultJSON));

          Result:=True;
        finally
          FreeAndNil(LParametri);
        end;
      finally
        FreeAndNil(B021);
      end;
    except
      // 500 - Internal server error
      on E: Exception do
      begin
        aReply.ResetReplyType;
        aReply.Code:=500;
        aReply.CodeText:='Internal server error';
        aReply.ContentType:=MIME_JSON;
        aReply.WriteString(GetErrorMessage(E.Message));
        Result:=True;
      end;
    end;
  finally
    // termino subito la sessione IW
    aSession.Terminate;
  end;
end;

function TB021FContentHandler.GetRequestBody(aRequest: THttpRequest): TJSONObject;
var fs: TFileStream;
    json: TStringStream;
begin
  if aRequest.Files.Count >= 1 then
  begin
    fs:=TFileStream.Create(aRequest.Files[0].TempPathName, fmOpenRead or fmShareDenyNone);
    json:=TStringStream.Create('');
    try
      json.CopyFrom(fs, 0);
      Result:=TJSONObject.ParseJSONValue(json.DataString) as TJSONObject;
    finally
      json.Free;
      fs.Free;
    end;
  end
  else
    raise Exception.Create('Request body not found');
end;

function TB021FContentHandler.GetErrorMessage(errorMessage: String): String;
var json: TJSONObject;
begin
  json:=TJSONObject.Create;
  try
    json.AddPair('error', TJSONString.Create(errorMessage));
    Result:=json.ToJSON;
  finally
    FreeAndNil(json);
  end;
end;

function TB021FContentHandler.GetListaParametri(URI: String): TStringList;
var i: Integer;
begin
  Result:=TStringList.Create;
  Result.Delimiter:='/';
  Result.StrictDelimiter:=True;
  Result.DelimitedText:=URI;

  for i:=Result.Count to MAX_PARAMETRI-1 do  //per gestire eventuali parametri opzionali non presenti
    Result.Add('');
end;

function TB021FContentHandler.GetReplyJSON(ResultJSON: TJSONObject): String;
var ReplyJSON: TJSONObject;
begin
  Result:='';
  if Assigned(ResultJSON) then
  begin
    ReplyJSON:=TJSONObject.Create(TJSONPair.Create('result', TJSONArray.Create(ResultJSON)));
    try
      Result:=ReplyJSON.ToJSON;
    finally
      FreeAndNil(ReplyJSON);
    end;
  end;
end;

function TB021FContentHandler.GetReplyString(ResultString: String): String;
var ReplyJSON: TJSONObject;
begin
  Result:='';
  ReplyJSON:=TJSONObject.Create(TJSONPair.Create('result', TJSONArray.Create(TJSONString.Create(ResultString))));
  try
    Result:=ReplyJSON.ToJSON;
  finally
    FreeAndNil(ReplyJSON);
  end;
end;

function TB021FContentHandler.Base64UrltoString(Value: String): String;
var padding, i: integer;
begin
  Result:=Value;
  padding:=(4 - (Value.Length mod 4)) mod 4;
  for i := 0 to padding-1 do
    Result:=Result + '=';
  Result:=StringReplace(Result, '-', '+', [rfReplaceAll]);
  Result:=StringReplace(Result, '_', '/', [rfReplaceAll]);
  Result:=DecodeString(Result);
end;

initialization

end.
