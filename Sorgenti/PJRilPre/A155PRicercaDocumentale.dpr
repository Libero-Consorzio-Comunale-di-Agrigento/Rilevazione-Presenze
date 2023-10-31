program A155PRicercaDocumentale;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A155URicercaDocumentale in 'A155URicercaDocumentale.pas' {A155FRicercaDocumentale},
  A155URicercaDocumentaleDtM in 'A155URicercaDocumentaleDtM.pas' {A155FRicercaDocumentaleDtM: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A155URicercaDocumentaleMW in '..\MWRilPre\A155URicercaDocumentaleMW.pas' {A155FRicercaDocumentaleMW: TDataModule},
  C180FunzioniGenerali in '..\Copy\C180FunzioniGenerali.pas',
  InputPeriodo in '..\Componenti\InputPeriodo.pas' {frmInputPeriodo: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.MainFormOnTaskbar:=True;
  Application.CreateForm(TA155FRicercaDocumentale, A155FRicercaDocumentale);
  Application.CreateForm(TA155FRicercaDocumentaleDtM, A155FRicercaDocumentaleDtM);
  Application.Run;
end.
