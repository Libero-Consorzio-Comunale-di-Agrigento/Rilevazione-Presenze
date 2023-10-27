// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://osahr.intraosa.net:8090/areas/services/JBFService?wsdl
// Encoding : UTF-8
// Version  : 1.0
// (18/11/2009 11.31.51 - - $Rev: 7300 $)
// ************************************************************************ //

unit JBFService;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns, Windows, C180FunzioniGenerali;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[]


  // ************************************************************************ //
  // Namespace : http://services.PSGExt
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : JBFServiceSoapBinding
  // service   : DefaultWebServiceService
  // port      : JBFService
  // URL       : http://osahr.intraosa.net:8090/areas/services/JBFService (default)
  // ************************************************************************ //
  EngiWebService = interface(IInvokable)
  ['{A3F86856-9FD1-B25E-4A64-BF53DA6D6070}']
    function  call(const xml: WideString): WideString; stdcall;
  end;

  ERGOWebService = interface(IInvokable)
  ['{CAC87E20-17F5-47BA-8D15-9C4F304DEC08}']
    function  cercasessionetypo3(const sessione,applicativo: WideString): WideString; stdcall;
  end;

function GetDefaultWebService(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): THTTPRIO;
//function GetEngiWebService(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): EngiWebService;
//function GetERGOWebService(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): ERGOWebService;

implementation

uses SysUtils;

function GetDefaultWebService(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): THTTPRIO;
const
  defSvc  = 'DefaultWebServiceService';
  defPrt  = 'JBFService';
var
  RIO: THTTPRIO;
  URL,defWSDL,defURL:String;
begin
  URL:=R180GetRegistro(HKEY_LOCAL_MACHINE,'W001','URL_WS_AUTH','');
  defWSDL:=URL + '?wsdl';
  defURL:=URL;

  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := RIO;
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;

(*
function GetENGIWebService(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): EngiWebService;
const
  //defWSDL = 'http://osahr.intraosa.net:8090/areas/services/JBFService?wsdl';
  //defURL  = 'http://osahr.intraosa.net:8090/areas/services/JBFService';
  defSvc  = 'DefaultWebServiceService';
  defPrt  = 'JBFService';
var
  RIO: THTTPRIO;
  URL,defWSDL,defURL:String;
begin
  URL:=R180GetRegistro(HKEY_LOCAL_MACHINE,'W001','URL_WS_AUTH','');
  defWSDL:=URL + '?wsdl';
  defURL:=URL;

  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as EngiWebService);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;

function GetERGOWebService(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): ERGOWebService;
const
  defSvc  = 'DefaultWebServiceService';
  defPrt  = 'JBFService';
var
  RIO: THTTPRIO;
  URL,defWSDL,defURL:String;
begin
  URL:=R180GetRegistro(HKEY_LOCAL_MACHINE,'W001','URL_WS_AUTH','');
  defWSDL:=URL + '?wsdl';
  defURL:=URL;

  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as ERGOWebService);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;
*)

initialization
  InvRegistry.RegisterInterface(TypeInfo(EngiWebService), 'http://services.PSGExt', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(EngiWebService), '');

  InvRegistry.RegisterInterface(TypeInfo(ERGOWebService), 'http://services.PSGExt', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(ERGOWebService), '');

end.