library B020PIrisWebSvc;

uses
  ActiveX,
  ComObj,
  WebBroker,
  ISAPIApp,
  ISAPIThreadPool,
  B020UIrisWebSvc01Dtm in 'B020UIrisWebSvc01Dtm.pas' {B020FIrisWebSvc01Dtm: TWebModule},
  B020UIrisWebSvc01Impl in 'B020UIrisWebSvc01Impl.pas',
  B020UIrisWebSvc01Intf in 'B020UIrisWebSvc01Intf.pas';

{$R *.res}

exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;

begin
  CoInitFlags := COINIT_MULTITHREADED;//COINIT_APARTMENTTHREADED;
  Application.Initialize;
  Application.CreateForm(TB020FIrisWebSvc01Dtm, B020FIrisWebSvc01Dtm);
  Application.Run;
end.
