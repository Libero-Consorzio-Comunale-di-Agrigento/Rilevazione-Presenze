program B100PWSMedpRepositary;

{$APPTYPE GUI}

uses
  Forms,
  SockApp,
  R014URestDM in '..\Repositary\R014URestDM.pas' {R014FRestDM: TDataModule},
  B100UForm in 'B100UForm.pas' {B100FForm},
  B100UWSMedpRepositaryDM in 'B100UWSMedpRepositaryDM.pas' {B100FWSMedpRepositaryDM: TDataModule},
  B100UListener in 'B100UListener.pas' {B100FListener: TWebModule},
  B021UCustomConverter in 'B021UCustomConverter.pas',
  B021UUtils in 'B021UUtils.pas',
  B100UR010WsEntiDM in 'B100UR010WsEntiDM.pas' {B100FR010WsEntiDM: TDataModule};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=DebugHook <> 0;
  {$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  // verificare che le uniche 2 Form create siano
  // - TB021FForm
  // - TB021FListener
  Application.CreateForm(TB100FForm, B100FForm);
  Application.Run;
end.

