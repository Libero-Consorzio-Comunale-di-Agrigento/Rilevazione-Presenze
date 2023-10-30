program B020PIrisWEBSvc_Vcl;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  B020UControlPnl in 'B020UControlPnl.pas' {Form1},
  B020UIrisWebSvc01Dtm in 'B020UIrisWebSvc01Dtm.pas' {B020FIrisWebSvc01Dtm: TWebModule},
  B020UIrisWebSvc01Impl in 'B020UIrisWebSvc01Impl.pas',
  B020UIrisWebSvc01Intf in 'B020UIrisWebSvc01Intf.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
