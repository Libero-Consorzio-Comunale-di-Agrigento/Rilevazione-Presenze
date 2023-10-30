program A022PContratti;

uses
  Forms,
  A022UContratti in 'A022UContratti.pas' {A022FContratti},
  A022UContrattiDtM1 in 'A022UContrattiDtM1.pas' {A022FContrattiDtM1: TDataModule},
  A022UMaggiorazioni in 'A022UMaggiorazioni.pas' {A022FMaggiorazioni},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A022UContrattiMW in '..\MWRilPre\A022UContrattiMW.pas' {A022FContrattiMW: TDataModule};

{$R *.RES}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  Application.Initialize;
  Application.CreateForm(TA022FContratti, A022FContratti);
  Application.CreateForm(TA022FContrattiDtM1, A022FContrattiDtM1);
  Application.Run;
end.
