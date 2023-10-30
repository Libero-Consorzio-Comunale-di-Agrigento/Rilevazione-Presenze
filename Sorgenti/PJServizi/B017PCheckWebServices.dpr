program B017PCheckWebServices;

uses
  Vcl.SvcMgr,
  System.SysUtils,
  B017UCheckWebServices in 'B017UCheckWebServices.pas' {B017FCheckWebServices: TService};

{$R *.RES}

{$ifdef DEBUG}
  {$APPTYPE CONSOLE}
{$endif}

var Result: Boolean;

begin
  {$ifdef DEBUG}
  try
    WriteLn('TB017FCheckWebServices in DEBUG mode. Premere enter per uscire.');
    B017FCheckWebServices:=TB017FCheckWebServices.Create(nil);
    B017FCheckWebServices.ServiceStart(B017FCheckWebServices, Result);
    ReadLn;
    FreeAndNil(B017FCheckWebServices);
  except
    on E: Exception do
    begin
      Writeln(E.ClassName, ': ', E.Message);
      WriteLn('Premere enter per uscire.');
      ReadLn;
    end;
  end;
  {$else}
  // Windows 2003 Server requires StartServiceCtrlDispatcher to be
  // called before CoRegisterClassObject, which can be called indirectly
  // by Application.Initialize. TServiceApplication.DelayInitialize allows
  // Application.Initialize to be called from TService.Main (after
  // StartServiceCtrlDispatcher has been called).
  //
  // Delayed initialization of the Application object may affect
  // events which then occur prior to initialization, such as
  // TService.OnCreate. It is only recommended if the ServiceApplication
  // registers a class object with OLE and is intended for use with
  // Windows 2003 Server.
  //
  // Application.DelayInitialize := True;
  //
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TB017FCheckWebServices, B017FCheckWebServices);
  Application.Run;
  {$endif}
end.
