program A200PImportazioneMassivaDocumenti;

uses
  Vcl.Forms,
  OracleMonitor,
  A200UImportazioneMassivaDocumenti in 'A200UImportazioneMassivaDocumenti.pas' {A200FImportazioneMassivaDocumenti},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A200UImportazioneMassivaDocumentiDtM in 'A200UImportazioneMassivaDocumentiDtM.pas' {A200FImportazioneMassivaDocumentiDtM: TDataModule},
  B022UUtilityGestDocumentaleMW in '..\MWCondivisi\B022UUtilityGestDocumentaleMW.pas',
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  InputPeriodo in '..\Componenti\InputPeriodo.pas' {frmInputPeriodo: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=DebugHook <> 0;
  {$WARN SYMBOL_PLATFORM OFF}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA200FImportazioneMassivaDocumenti, A200FImportazioneMassivaDocumenti);
  Application.CreateForm(TA200FImportazioneMassivaDocumentiDtM, A200FImportazioneMassivaDocumentiDtM);
  Application.Run;
end.
