library B021PIrisRestSvc_IIS;

uses
  IWInitISAPI,
  IW.Isapi.ThreadPool,
  DBClient,
  MidasLib,
  IWJclDebug,
  IWJclStackTrace,
  L021Call in '..\Copy\L021Call.pas',
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000ServerController: TDataModule},
  A000Versione in '..\Copy\A000Versione.pas',
  C180FunzioniGenerali in '..\Copy\C180FunzioniGenerali.pas',
  C190FunzioniGeneraliWeb in '..\Copy\C190FunzioniGeneraliWeb.pas',
  IWRtlFix,
  WC000UServerAdmin in '..\Copy\WC000UServerAdmin.pas',
  A000UCostanti in '..\Copy\A000UCostanti.pas',
  WC000UConfigIni in '..\Copy\WC000UConfigIni.pas',
  WC000UErrLimiteSessioni in '..\Copy\WC000UErrLimiteSessioni.pas',
  B021UContentHandler in 'B021UContentHandler.pas',
  B021UIrisRestSvcDM in 'B021UIrisRestSvcDM.pas' {B021FIrisRestSvcDM: TDataModule};

{$R *.res}

exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;

begin
  //PatchMakeObjectInstance;
  IWRun;
end.

