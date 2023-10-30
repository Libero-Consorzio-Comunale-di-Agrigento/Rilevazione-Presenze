program B024PTestClient;

uses
  Vcl.Forms,
  B024UClient in 'B024UClient.pas' {B024FClient};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.CreateForm(TB024FClient,B024FClient);
  Application.MainFormOnTaskbar := True;
  Application.Run;
end.
