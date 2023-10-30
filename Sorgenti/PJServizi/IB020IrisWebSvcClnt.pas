// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://localhost/IrisWebSrv/B020PIrisWebSvc.dll/wsdl/IB020IrisWebSvc01
//  >Import : http://localhost/IrisWebSrv/B020PIrisWebSvc.dll/wsdl/IB020IrisWebSvc01:0
// Encoding : utf-8
// Version  : 1.0
// (07/12/2009 12.53.46 - - $Rev: 10138 $)
// ************************************************************************ //

unit IB020IrisWebSvcClnt;

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
  // !:double          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  TMyEmployee          = class;                 { "urn:B020UIrisWebSvc01Intf"[GblCplx] }

  { "urn:B020UIrisWebSvc01Intf"[GblSmpl] }
  TEnumTest = (etNone, etAFew, etSome, etAlot);

  TDoubleArray = array of Double;               { "urn:B020UIrisWebSvc01Intf"[GblCplx] }


  // ************************************************************************ //
  // XML       : TMyEmployee, global, <complexType>
  // Namespace : urn:B020UIrisWebSvc01Intf
  // ************************************************************************ //
  TMyEmployee = class(TRemotable)
  private
    FLastName: WideString;
    FFirstName: WideString;
    FSalary: Double;
  published
    property LastName:  WideString  read FLastName write FLastName;
    property FirstName: WideString  read FFirstName write FFirstName;
    property Salary:    Double      read FSalary write FSalary;
  end;


  // ************************************************************************ //
  // Namespace : urn:B020UIrisWebSvc01Intf-IB020IrisWebSvc01
  // soapAction: urn:B020UIrisWebSvc01Intf-IB020IrisWebSvc01#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : IB020IrisWebSvc01binding
  // service   : IB020IrisWebSvc01service
  // port      : IB020IrisWebSvc01Port
  // URL       : http://localhost/IrisWebSrv/B020PIrisWebSvc.dll/soap/IB020IrisWebSvc01
  // ************************************************************************ //
  IB020IrisWebSvc01 = interface(IInvokable)
  ['{F3378FFA-4A43-E70D-2E54-600EABEC5CAD}']
    function  echoEnum(const Value: TEnumTest): TEnumTest; stdcall;
    function  echoDoubleArray(const Value: TDoubleArray): TDoubleArray; stdcall;
    function  echoMyEmployee(const Value: TMyEmployee): TMyEmployee; stdcall;
    function  echoDouble(const Value: Double): Double; stdcall;
    function  CartellinoPDF(const Db: WideString; const Azienda: WideString; const Matricola: WideString; const Dal: WideString; const Al: WideString; const Parametrizzazione: WideString;
                            const FilePdf: WideString): WideString; stdcall;
    function R600GetAssenze(const DB,Azienda,Matricola,DataRiferimento,Causale,DataNasFam: WideString): WideString; stdcall;
    function R502Conteggi(const DB,Azienda,Matricola,DataRiferimento: WideString): WideString; stdcall;
  end;

function GetIB020IrisWebSvc01(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IB020IrisWebSvc01;


implementation
  uses SysUtils;

function GetIB020IrisWebSvc01(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IB020IrisWebSvc01;
const
  defSvc  = 'IB020IrisWebSvc01service';
  defPrt  = 'IB020IrisWebSvc01Port';
var
  RIO: THTTPRIO;
  URL,IIS,defWSDL,defURL:String;
begin
  URL:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B020','URL','');
  IIS:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B020','IIS','S');
  if not URL.EndsWith('/') then
    URL:=URL + '/';
  if IIS = 'S' then
  begin
    defWSDL:=URL + 'B020PIrisWebSvc.dll/wsdl/IB020IrisWebSvc01';
    defURL:=URL + 'B020PIrisWebSvc.dll/soap/IB020IrisWebSvc01';
  end
  else
  begin
    defWSDL:=URL + 'wsdl/IB020IrisWebSvc01';
    defURL:=URL + 'soap/IB020IrisWebSvc01';
  end;

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
    Result := (RIO as IB020IrisWebSvc01);
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


initialization
  InvRegistry.RegisterInterface(TypeInfo(IB020IrisWebSvc01), 'urn:B020UIrisWebSvc01Intf-IB020IrisWebSvc01', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IB020IrisWebSvc01), 'urn:B020UIrisWebSvc01Intf-IB020IrisWebSvc01#%operationName%');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TDoubleArray), 'urn:B020UIrisWebSvc01Intf', 'TDoubleArray');
  RemClassRegistry.RegisterXSClass(TMyEmployee, 'urn:B020UIrisWebSvc01Intf', 'TMyEmployee');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TEnumTest), 'urn:B020UIrisWebSvc01Intf', 'TEnumTest');

end.