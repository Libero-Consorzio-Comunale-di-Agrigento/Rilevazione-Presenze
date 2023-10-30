unit B100UListener;

interface

uses
  B021UUtils, SysUtils, Classes, HTTPApp, DSHTTP, DSHTTPCommon, DSHTTPWebBroker, DSServer,
  DSCommonServer, IdContext, IdBaseComponent, IdComponent, IdCustomTCPServer,
  IdTCPServer, IdCmdTCPServer, DSTCPServerTransport
  {$IFNDEF VER210}, IPPeerCommon, IPPeerServer, Data.DBXTransport{$ENDIF};

type
  TB100FListener = class(TWebModule)
    DSServer1: TDSServer;
    DSHTTPWebDispatcher1: TDSHTTPWebDispatcher;
    DSServerClass1: TDSServerClass;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure WebModule2DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleAfterDispatch(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  B100FListener: TB100FListener;

implementation

uses WebReq, B100UWSMedpRepositaryDM;

{$R *.dfm}

procedure TB100FListener.WebModule2DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content:='<html><heading/><body>DataSnap Server</body></html>';
end;

procedure TB100FListener.WebModuleAfterDispatch(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
//var
//  SC: Integer;
//  OldReason: String;
begin
  // Sender = B021FListener
  {
  if (Response.StatusCode = 500) and (Copy(Response.ReasonString,1,3) = 'ERR') then
  begin
    if TryStrToInt(Copy(Response.ReasonString,4,3),SC) then
    begin
      OldReason:=Copy(Response.ReasonString,8);
      Response.StatusCode:=SC;
      Response.ReasonString:=OldReason;
    end;
  end;
  }

  // sovrascrive il content-type (che contrariamente a quanto atteso vale sempre text/html)
  Response.ContentType:='application/json';
end;

procedure TB100FListener.DSServerClass1GetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass:=B100UWSMedpRepositaryDM.TB100FWSMedpRepositaryDM;
end;

initialization
  WebRequestHandler.WebModuleClass:=TB100FListener;

end.
