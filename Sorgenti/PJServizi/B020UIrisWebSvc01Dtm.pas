unit B020UIrisWebSvc01Dtm;

interface

uses
  SysUtils, Classes, HTTPApp, InvokeRegistry, WSDLIntf, TypInfo, WebServExp,
  WSDLBind, XMLSchema, WSDLPub, SOAPPasInv, SOAPHTTPPasInv, SOAPHTTPDisp,
  WebBrokerSOAP, Oracle, RpDefine, A000USessione, C180FunzioniGenerali;

type
  TB020FIrisWebSvc01Dtm = class(TWebModule)
    HTTPSoapDispatcher1: THTTPSoapDispatcher;
    HTTPSoapPascalInvoker1: THTTPSoapPascalInvoker;
    WSDLHTMLPublish1: TWSDLHTMLPublish;
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleCreate(Sender: TObject);
    procedure WebModuleBeforeDispatch(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleAfterDispatch(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    lstSessioniMondoEDP:array of TOracleSession;
    lstSessioniOracle:array of TOracleSession;
    SessioneirisWIN:TSessioneIrisWin;
  end;

var
  B020FIrisWebSvc01Dtm: TB020FIrisWebSvc01Dtm;
  WebModuleClass: TComponentClass = TB020FIrisWebSvc01Dtm;

implementation

{$R *.dfm}

procedure TB020FIrisWebSvc01Dtm.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' B020DtM.DefaultHandlerAction.inizio');
  WSDLHTMLPublish1.ServiceInfo(Sender, Request, Response, Handled);
  R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' B020DtM.DefaultHandlerAction.fine');
end;

procedure TB020FIrisWebSvc01Dtm.WebModuleAfterDispatch(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' B020DtM.AfterDispatch');
end;

procedure TB020FIrisWebSvc01Dtm.WebModuleBeforeDispatch(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' B020DtM.BeforeDispatch');
end;

procedure TB020FIrisWebSvc01Dtm.WebModuleCreate(Sender: TObject);
begin
  R180ScriviMsgLog('B020.log',FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' B020DtM.Create');
  SessioneIrisWIN:=TSessioneIrisWin.Create(nil);
  B020FIrisWebSvc01Dtm:=Self;
  A000SettaVariabiliAmbiente;
  //RpDefine.DataID:='B020';
end;

procedure TB020FIrisWebSvc01Dtm.WebModuleDestroy(Sender: TObject);
begin
  FreeAndNil(SessioneIrisWIN);
end;

end.
