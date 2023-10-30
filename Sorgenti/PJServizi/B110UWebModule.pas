unit B110UWebModule;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Datasnap.DSHTTPCommon,
  Datasnap.DSHTTPWebBroker, Datasnap.DSServer,
  Web.WebFileDispatcher, Web.HTTPProd,
  DataSnap.DSAuth,
  Datasnap.DSProxyJavaScript, IPPeerServer, Datasnap.DSMetadata,
  Datasnap.DSServerMetadata, Datasnap.DSClientMetadata, Datasnap.DSCommonServer,
  Datasnap.DSHTTP,
  IdHTTPWebBrokerBridge, IdSchedulerOfThreadPool, System.IOUtils,
  Data.DBXCommon, Data.DBCommonTypes, System.JSON, C180FunzioniGenerali;

type
  TB110FWebModule = class(TWebModule)
    DSHTTPWebDispatcher1: TDSHTTPWebDispatcher;
    DSServer1: TDSServer;
    DSServerClass1: TDSServerClass;
    ServerFunctionInvoker: TPageProducer;
    ReverseString: TPageProducer;
    WebFileDispatcher1: TWebFileDispatcher;
    DSProxyGenerator1: TDSProxyGenerator;
    DSServerMetaDataProvider1: TDSServerMetaDataProvider;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure ServerFunctionInvokerHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure WebModuleDefaultAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleBeforeDispatch(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebFileDispatcher1BeforeDispatch(Sender: TObject;
      const AFileName: string; Request: TWebRequest; Response: TWebResponse;
      var Handled: Boolean);
    procedure WebModuleCreate(Sender: TObject);
    procedure WebModuleAfterDispatch(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure DSServer1Error(DSErrorEventObject: TDSErrorEventObject);
    procedure WebModuleException(Sender: TObject; E: Exception;
      var Handled: Boolean);
    procedure WebModuleDestroy(Sender: TObject);
    procedure DSHTTPWebDispatcher1HTTPTrace(Sender: TObject;
      AContext: TDSHTTPContext; ARequest: TDSHTTPRequest;
      AResponse: TDSHTTPResponse);
    procedure DSServer1Connect(DSConnectEventObject: TDSConnectEventObject);
    procedure DSServer1Disconnect(DSConnectEventObject: TDSConnectEventObject);
    procedure DSServer1Prepare(DSPrepareEventObject: TDSPrepareEventObject);
    procedure DSHTTPWebDispatcher1FormatResult(Sender: TObject;
      var ResultVal: TJSONValue; const Command: TDBXCommand;
      var Handled: Boolean);
    procedure WebFileDispatcher1AfterDispatch(Sender: TObject;
      const AFileName: string; Request: TWebRequest; Response: TWebResponse;
      var Handled: Boolean);
    procedure DSServerClass1CreateInstance(DSCreateInstanceEventObject: TDSCreateInstanceEventObject);
    procedure DSServerClass1DestroyInstance(DSDestroyInstanceEventObject: TDSDestroyInstanceEventObject);
    procedure DSServerClass1Prepare(DSPrepareEventObject: TDSPrepareEventObject);
  private
    FServer: TIdHTTPWebBrokerBridge;
    FServerFunctionInvokerAction: TWebActionItem;
    function AllowServerFunctionInvoker: Boolean;
  end;

var
  WebModuleClass: TComponentClass = TB110FWebModule;

implementation

{$R *.dfm}

uses
  B110UUtils,
  B110UServerMethodsDM,
  FunzioniGenerali,
  C200UWebServicesServerUtils,
  A000UCostanti,
  Web.WebReq,
  Winapi.Windows,
  Datasnap.DSSession;

procedure TB110FWebModule.DSHTTPWebDispatcher1FormatResult(Sender: TObject; var ResultVal: TJSONValue; const Command: TDBXCommand; var Handled: Boolean);
const
  NOME_METODO = 'DSHTTPWebDispatcher1FormatResult';
begin
  {$IF Defined(DEBUG) and Defined(DEBUG_WEBMODULE)}
  TLogger.SetCategory(CATEGORIA_DATASNAP);
  TLogger.EnterMethod(NOME_METODO,Self);
  TLogger.ExitMethod(NOME_METODO,Self);
  {$ENDIF}
end;

procedure TB110FWebModule.DSHTTPWebDispatcher1HTTPTrace(Sender: TObject;
  AContext: TDSHTTPContext; ARequest: TDSHTTPRequest;
  AResponse: TDSHTTPResponse);
const
  NOME_METODO = 'DSHTTPWebDispatcher1HTTPTrace';
begin
  {$IF Defined(DEBUG) and Defined(DEBUG_WEBMODULE)}
  TLogger.SetCategory(CATEGORIA_DATASNAP);
  TLogger.EnterMethod(NOME_METODO,Self);
  TLogger.Debug('URI',ARequest.URI);
  TLogger.Debug('RemoteIP',ARequest.RemoteIP);
  TLogger.ExitMethod(NOME_METODO,Self);
  {$ENDIF}
end;

procedure TB110FWebModule.DSServer1Connect(DSConnectEventObject: TDSConnectEventObject);
const
  NOME_METODO = 'DSServer1Connect';
begin
  {$IF Defined(DEBUG) and Defined(DEBUG_WEBMODULE)}
  TLogger.SetCategory(CATEGORIA_DATASNAP);
  TLogger.EnterMethod(NOME_METODO,Self);
  TLogger.Debug('DSConnectEventObject',DSConnectEventObject);
  TLogger.ExitMethod(NOME_METODO,Self);
  {$ENDIF}
end;

procedure TB110FWebModule.DSServer1Disconnect(DSConnectEventObject: TDSConnectEventObject);
const
  NOME_METODO = 'DSServer1Disconnect';
begin
  {$IF Defined(DEBUG) and Defined(DEBUG_WEBMODULE)}
  TLogger.SetCategory(CATEGORIA_DATASNAP);
  TLogger.EnterMethod(NOME_METODO,Self);
  TLogger.Debug('DSConnectEventObject',DSConnectEventObject);
  TLogger.ExitMethod(NOME_METODO,Self);
  {$ENDIF}
end;

procedure TB110FWebModule.DSServer1Error(DSErrorEventObject: TDSErrorEventObject);
const
  NOME_METODO = 'DSServer1Error';
begin
  {$IF Defined(DEBUG) and Defined(DEBUG_WEBMODULE)}
  TLogger.SetCategory(CATEGORIA_DATASNAP);
  TLogger.EnterMethod(NOME_METODO,Self);
  TLogger.Error(DSErrorEventObject.Error.Message);
  TLogger.ExitMethod(NOME_METODO,Self);
  {$ENDIF}
end;

procedure TB110FWebModule.DSServer1Prepare(DSPrepareEventObject: TDSPrepareEventObject);
const
  NOME_METODO = 'DSServer1Prepare';
begin
  {$IF Defined(DEBUG) and Defined(DEBUG_WEBMODULE)}
  TLogger.SetCategory(CATEGORIA_DATASNAP);
  TLogger.EnterMethod(NOME_METODO,Self);
  TLogger.Debug('DSPrepareEventObject',DSPrepareEventObject);
  TLogger.Debug('DSPrepareEventObject.MethodAlias',DSPrepareEventObject.MethodAlias);
  TLogger.ExitMethod(NOME_METODO,Self);
  {$ENDIF}
end;

procedure TB110FWebModule.DSServerClass1CreateInstance(DSCreateInstanceEventObject: TDSCreateInstanceEventObject);
const
  NOME_METODO = 'DSServerClass1CreateInstance';
begin
  {$IF Defined(DEBUG) and Defined(DEBUG_WEBMODULE)}
  TLogger.SetCategory(CATEGORIA_DATASNAP);
  TLogger.EnterMethod(NOME_METODO,Self);
  TLogger.Debug('DSCreateInstanceEventObject',DSCreateInstanceEventObject);
  TLogger.ExitMethod(NOME_METODO,Self);
  {$ENDIF}
end;

procedure TB110FWebModule.DSServerClass1DestroyInstance(DSDestroyInstanceEventObject: TDSDestroyInstanceEventObject);
const
  NOME_METODO = 'DSServerClass1DestroyInstance';
begin
  {$IF Defined(DEBUG) and Defined(DEBUG_WEBMODULE)}
  TLogger.SetCategory(CATEGORIA_DATASNAP);
  TLogger.EnterMethod(NOME_METODO,Self);
  TLogger.Debug('DSDestroyInstanceEventObject',DSDestroyInstanceEventObject);
  TLogger.ExitMethod(NOME_METODO,Self);
  {$ENDIF}
end;

procedure TB110FWebModule.DSServerClass1GetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
const
  NOME_METODO = 'DSServerClass1GetClass';
begin
  {$IF Defined(DEBUG) and Defined(DEBUG_WEBMODULE)}
  TLogger.SetCategory(CATEGORIA_DATASNAP);
  TLogger.EnterMethod(NOME_METODO,Self);
  try
  {$ENDIF}
    PersistentClass := B110UServerMethodsDM.TB110FServerMethodsDM;

    { TODO 1 -cAnalisi tecnica : Verificare il timeout di sessione }
    DSHTTPWebDispatcher1.SessionTimeout:=TB110FParametriServer.Impostazioni_SessionTimeout;
  {$IF Defined(DEBUG) and Defined(DEBUG_WEBMODULE)}
  finally
    TLogger.ExitMethod(NOME_METODO,Self);
  end;
  {$ENDIF}
end;

procedure TB110FWebModule.DSServerClass1Prepare(DSPrepareEventObject: TDSPrepareEventObject);
const
  NOME_METODO = 'DSServerClass1Prepare';
begin
  {$IF Defined(DEBUG) and Defined(DEBUG_WEBMODULE)}
  TLogger.SetCategory(CATEGORIA_DATASNAP);
  TLogger.EnterMethod(NOME_METODO,Self);
  TLogger.Debug('DSPrepareEventObject',DSPrepareEventObject);
  TLogger.ExitMethod(NOME_METODO,Self);
  {$ENDIF}
end;

procedure TB110FWebModule.ServerFunctionInvokerHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
const
  NOME_METODO = 'ServerFunctionInvokerHTMLTag';
begin
  {$IF Defined(DEBUG) and Defined(DEBUG_WEBMODULE)}
  TLogger.SetCategory(CATEGORIA_DATASNAP);
  TLogger.EnterMethod(NOME_METODO,Self);
  try
  {$ENDIF}
    if SameText(TagString, 'urlpath') then
      ReplaceText := string(Request.InternalScriptName)
    else if SameText(TagString, 'port') then
      ReplaceText := IntToStr(Request.ServerPort)
    else if SameText(TagString, 'host') then
      ReplaceText := string(Request.Host)
    else if SameText(TagString, 'classname') then
      ReplaceText := B110UServerMethodsDM.TB110FServerMethodsDM.ClassName
    else if SameText(TagString, 'loginrequired') then
      if DSHTTPWebDispatcher1.AuthenticationManager <> nil then
        ReplaceText := 'true'
      else
        ReplaceText := 'false'
    else if SameText(TagString, 'serverfunctionsjs') then
      ReplaceText := string(Request.InternalScriptName) + '/js/serverfunctions.js'
    else if SameText(TagString, 'servertime') then
      ReplaceText := DateTimeToStr(Now)
    else if SameText(TagString, 'serverfunctioninvoker') then
      if AllowServerFunctionInvoker then
        ReplaceText :=
        '<div><a href="' + string(Request.InternalScriptName) +
        '/ServerFunctionInvoker" target="_blank">Server Functions</a></div>'
      else
        ReplaceText := '';
  {$IF Defined(DEBUG) and Defined(DEBUG_WEBMODULE)}
  finally
    TLogger.ExitMethod(NOME_METODO,Self);
  end;
  {$ENDIF}
end;

procedure TB110FWebModule.WebModuleDefaultAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
const
  NOME_METODO = 'WebModuleDefaultAction';
begin
  {$IF Defined(DEBUG) and Defined(DEBUG_WEBMODULE)}
  TLogger.SetCategory(CATEGORIA_DATASNAP);
  TLogger.EnterMethod(NOME_METODO,Self);
  try
  {$ENDIF}
    if (Request.InternalPathInfo = '') or (Request.InternalPathInfo = '/')then
      Response.Content := ReverseString.Content
    else
      Response.SendRedirect(Request.InternalScriptName + '/');
  {$IF Defined(DEBUG) and Defined(DEBUG_WEBMODULE)}
  finally
    TLogger.ExitMethod(NOME_METODO,Self);
  end;
  {$ENDIF}
end;

procedure TB110FWebModule.WebModuleDestroy(Sender: TObject);
const
  NOME_METODO = 'WebModuleDestroy';
begin
  {$IF Defined(DEBUG) and Defined(DEBUG_WEBMODULE)}
  TLogger.SetCategory(CATEGORIA_DATASNAP);
  TLogger.EnterMethod(NOME_METODO,Self);
  try
  {$ENDIF}
    if not IsLibrary then
      exit;

    //TerminateThreads;
    if TDSSessionManager.Instance <> nil then
      TDSSessionManager.Instance.TerminateAllSessions;

    FServer.Active := False;
    FServer.Bindings.Clear;
  {$IF Defined(DEBUG) and Defined(DEBUG_WEBMODULE)}
  finally
    TLogger.ExitMethod(NOME_METODO,Self);
  end;
  {$ENDIF}
end;

procedure TB110FWebModule.WebModuleException(Sender: TObject; E: Exception; var Handled: Boolean);
const
  NOME_METODO = 'WebModuleException';
begin
  {$IF Defined(DEBUG) and Defined(DEBUG_WEBMODULE)}
  TLogger.SetCategory(CATEGORIA_DATASNAP);
  TLogger.EnterMethod(NOME_METODO,Self);
  TLogger.Error('Eccezione web module',E);
  TLogger.ExitMethod(NOME_METODO,Self);
  {$ENDIF}
end;

procedure TB110FWebModule.WebModuleBeforeDispatch(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
const
  NOME_METODO = 'WebModuleBeforeDispatch';
begin
  {$IF Defined(DEBUG) and Defined(DEBUG_WEBMODULE)}
  TLogger.SetCategory(CATEGORIA_DATASNAP);
  TLogger.EnterMethod(NOME_METODO,Self);
  try
    TLogger.Debug('Request',Request);
    TLogger.Debug('Response',Response);
  {$ENDIF}

    if FServerFunctionInvokerAction <> nil then
      FServerFunctionInvokerAction.Enabled := AllowServerFunctionInvoker;

  {$IF Defined(DEBUG) and Defined(DEBUG_WEBMODULE)}
  finally
    TLogger.ExitMethod(NOME_METODO,Self);
  end;
  {$ENDIF}
end;

procedure TB110FWebModule.WebModuleAfterDispatch(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
const
  NOME_METODO = 'WebModuleAfterDispatch';
begin
  {$IF Defined(DEBUG) and Defined(DEBUG_WEBMODULE)}
  TLogger.SetCategory(CATEGORIA_DATASNAP);
  TLogger.EnterMethod(NOME_METODO,Self);
  try
  {$ENDIF}
    // bugfix delphi.ini
    // sovrascrive il content-type (che contrariamente a quanto atteso vale sempre text/html)
    if Response.Content.StartsWith('{"result"') then
      Response.ContentType:='application/json';
    // bugfix delphi.fine

  {$IF Defined(DEBUG) and Defined(DEBUG_WEBMODULE)}
    TLogger.Debug('Request',Request);
    TLogger.Debug('Response',Response);
  finally
    TLogger.ExitMethod(NOME_METODO,Self);
  end;
  {$ENDIF}
end;

function TB110FWebModule.AllowServerFunctionInvoker: Boolean;
begin
  Result:=(Request.RemoteAddr = '127.0.0.1') or (Request.RemoteAddr = '0:0:0:0:0:0:0:1') or (Request.RemoteAddr = '::1');
end;

procedure TB110FWebModule.WebFileDispatcher1BeforeDispatch(Sender: TObject;
  const AFileName: string; Request: TWebRequest; Response: TWebResponse;
  var Handled: Boolean);
var
  D1, D2: TDateTime;
const
  NOME_METODO = 'WebFileDispatcher1BeforeDispatch';
begin
  {$IF Defined(DEBUG) and Defined(DEBUG_WEBMODULE)}
  TLogger.SetCategory(CATEGORIA_DATASNAP);
  TLogger.EnterMethod(NOME_METODO,Self);
  try
  {$ENDIF}
    Handled := False;
    if SameFileName(ExtractFileName(AFileName), 'serverfunctions.js') then
      if not FileExists(AFileName) or (FileAge(AFileName, D1) and FileAge(WebApplicationFileName, D2) and (D1 < D2)) then
      begin
        DSProxyGenerator1.TargetDirectory := ExtractFilePath(AFileName);
        DSProxyGenerator1.TargetUnitName := ExtractFileName(AFileName);
        DSProxyGenerator1.Write;
      end;
  {$IF Defined(DEBUG) and Defined(DEBUG_WEBMODULE)}
  finally
    TLogger.ExitMethod(NOME_METODO,Self);
  end;
  {$ENDIF}
end;

procedure TB110FWebModule.WebFileDispatcher1AfterDispatch(Sender: TObject;
  const AFileName: string; Request: TWebRequest; Response: TWebResponse;
  var Handled: Boolean);
const
  NOME_METODO = 'WebFileDispatcher1AfterDispatch';
begin
  {$IF Defined(DEBUG) and Defined(DEBUG_WEBMODULE)}
  TLogger.SetCategory(CATEGORIA_DATASNAP);
  TLogger.EnterMethod(NOME_METODO,Self);
  TLogger.ExitMethod(NOME_METODO,Self);
  {$ENDIF}
end;

procedure TB110FWebModule.WebModuleCreate(Sender: TObject);
var
  SchedulerOfThreadPool: TIdSchedulerOfThreadPool;
const
  NOME_METODO = 'WebModuleCreate';
begin
  {$IF Defined(DEBUG) and Defined(DEBUG_WEBMODULE)}
  TLogger.SetCategory(CATEGORIA_DATASNAP);
  TLogger.EnterMethod(NOME_METODO,Self);
  try
  {$ENDIF}
    FServerFunctionInvokerAction := ActionByName('ServerFunctionInvokerAction');
    if not IsLibrary then
      exit;

    //Era presente in Form.Create
    FServer := TIdHTTPWebBrokerBridge.Create(Self);

    // aggiunte suggerite da M. Cantù.inizio
    // sono comunque parametrizzate sul file di configurazione

    // 1. pool di thread
    if TB110FParametriServer.Impostazioni_PoolSize > 0 then
    begin
      SchedulerOfThreadPool:=TIdSchedulerOfThreadPool.Create(FServer);
      SchedulerOfThreadPool.PoolSize:=TB110FParametriServer.Impostazioni_PoolSize;
      FServer.Scheduler:=SchedulerOfThreadPool;
    end;

    // 2. max concurrent connections
    FServer.MaxConnections:=TB110FParametriServer.Impostazioni_MaxConnections;
    // aggiunte suggerite da M. Cantù.fine
  {$IF Defined(DEBUG) and Defined(DEBUG_WEBMODULE)}
  finally
    TLogger.ExitMethod(NOME_METODO,Self);
  end;
  {$ENDIF}
end;

initialization
  // configura il logger
  TLogger.Configure(TLogOptions.Create('REST Server B110',TB110FParametriServer.Impostazioni_FileLog,TB110FParametriServer.Impostazioni_LiveViewLog,R180GetPathLog));

finalization
  Web.WebReq.FreeWebModules;

end.

