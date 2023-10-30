library B100PWSMedpRepositary_IIS;

uses
  ActiveX,
  ComObj,
  WebBroker,
  ISAPIApp,
  ISAPIThreadPool,
  R014URestDM in '..\Repositary\R014URestDM.pas' {R014FRestDM: TDataModule},
  B021UCustomConverter in 'B021UCustomConverter.pas',
  B021UUtils in 'B021UUtils.pas',
  B100UListener in 'B100UListener.pas' {B100FListener: TWebModule},
  B100UR010WsEntiDM in 'B100UR010WsEntiDM.pas' {B100FR010WsEntiDM: TDataModule},
  B100UWSMedpRepositaryDM in 'B100UWSMedpRepositaryDM.pas' {B100FWSMedpRepositaryDM: TDataModule};

{$R *.res}

exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;

begin
  CoInitFlags:=COINIT_MULTITHREADED;
  Application.Initialize;
  Application.CreateForm(TB100FListener, B100FListener);
  Application.Run;
end.

