program A154PGestioneDocumentale;

uses
  madExcept,
  madListHardware,
  madListProcesses,
  madListModules,
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A154UGestioneDocumentale in 'A154UGestioneDocumentale.pas' {A154FGestioneDocumentale},
  A154UGestioneDocumentaleDtM in 'A154UGestioneDocumentaleDtM.pas' {A154FGestioneDocumentaleDtM: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A154UGestioneDocumentaleMW in '..\MWRilPre\A154UGestioneDocumentaleMW.pas' {A154FGestioneDocumentaleMW: TDataModule},
  C015UElencoValori in '..\Copy\C015UElencoValori.pas' {C015FElencoValori};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.MainFormOnTaskbar:=True;
  Application.CreateForm(TA154FGestioneDocumentale, A154FGestioneDocumentale);
  Application.CreateForm(TA154FGestioneDocumentaleDtM, A154FGestioneDocumentaleDtM);
  Application.Run;
end.
