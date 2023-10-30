program P553PRisorseResidueContoAnnuale;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  P553URisorseResidueContoAnnuale in 'P553URisorseResidueContoAnnuale.pas' {P553FRisorseResidueContoAnnuale},
  R004UGESTSTORICODTM in '..\Repositary\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  P553URisorseResidueContoAnnualeDtM in 'P553URisorseResidueContoAnnualeDtM.pas' {P553FRisorseResidueContoAnnualeDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  P553URisorseResidueContoAnnualeMW in '..\MWCondivisi\P553URisorseResidueContoAnnualeMW.pas' {P553FRisorseResidueContoAnnualeMW: TDataModule};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  Application.Initialize;
  Application.CreateForm(TP553FRisorseResidueContoAnnuale, P553FRisorseResidueContoAnnuale);
  Application.CreateForm(TP553FRisorseResidueContoAnnualeDtM, P553FRisorseResidueContoAnnualeDtM);
  Application.Run;
end.
