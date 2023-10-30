program A065PStampaBudget;

uses
  madExcept,
  madListHardware,
  madListProcesses,
  madListModules,
  Forms,
  A065UStampaBudget in 'A065UStampaBudget.pas' {A065FStampaBudget},
  R004UGESTSTORICODTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  R002UQREP in '..\Repositary\R002UQREP.pas' {R002FQRep},
  A065UStampa in 'A065UStampa.pas' {A065FStampa},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A065UStampaBudgetMW in '..\MWRilPre\A065UStampaBudgetMW.pas' {A065FStampaBudgetMW: TDataModule};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=DebugHook <> 0;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA065FStampaBudget, A065FStampaBudget);
  Application.Run;
end.
