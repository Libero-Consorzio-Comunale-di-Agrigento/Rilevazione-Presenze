program B021PIrisRestSvc_Vcl;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  OracleMonitor,
  MidasLib,
  IwJclDebug,
  IwJclStackTrace,
  IWRtlFix,
  DBClient,
  L021Call in '..\Copy\L021Call.pas',
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000ServerController: TDataModule},
  A000Versione in '..\Copy\A000Versione.pas',
  C180FunzioniGenerali in '..\Copy\C180FunzioniGenerali.pas',
  C190FunzioniGeneraliWeb in '..\Copy\C190FunzioniGeneraliWeb.pas',
  WC000UServerAdmin in '..\Copy\WC000UServerAdmin.pas',
  A000UCostanti in '..\Copy\A000UCostanti.pas',
  WC000UConfigIni in '..\Copy\WC000UConfigIni.pas',
  WC000UErrLimiteSessioni in '..\Copy\WC000UErrLimiteSessioni.pas',
  B021UContentHandler in 'B021UContentHandler.pas',
  B021UIrisRestSvcDM in 'B021UIrisRestSvcDM.pas' {B021FIrisRestSvcDM: TDataModule},
  R014URestDM in '..\Repositary\R014URestDM.pas' {R014FRestDM: TDataModule};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.

