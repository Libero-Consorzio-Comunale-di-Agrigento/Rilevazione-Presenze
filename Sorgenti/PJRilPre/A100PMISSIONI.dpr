program A100PMISSIONI;

uses
  Forms,
  R001UGESTTAB in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  A100UMissioni in 'A100UMissioni.pas' {A100FMISSIONI},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A100URicalcoloIndTrasp in 'A100URicalcoloIndTrasp.pas' {A100FRicalcoloIndTrasp},
  R004UGestStoricoDTM in '..\REPOSITARY\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A100UMISSIONIDTM in 'A100UMISSIONIDTM.pas' {A100FMISSIONIDtM: TDataModule},
  A100UDettaglioRimborsi in 'A100UDettaglioRimborsi.pas' {A100FDettaglioRimborsi},
  A100UTipiPagamento in 'A100UTipiPagamento.pas' {A100FTipiPagamento},
  A100UDistanzeChilometriche in 'A100UDistanzeChilometriche.pas' {A100FDistanzeChilometriche},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame},
  A100UImpRimborsiIter in 'A100UImpRimborsiIter.pas' {A100FImpRimborsiIter},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A100UMissioniMW in '..\MWRilPre\A100UMissioniMW.pas' {A100FMissioniMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  A100UImpRimborsiIterMW in '..\MWRilPre\A100UImpRimborsiIterMW.pas' {A100FImpRimborsiIterMW: TDataModule},
  A000UCostanti in '..\Copy\A000UCostanti.pas',
  A100UCheckRimborsi in 'A100UCheckRimborsi.pas' {A100FCheckRimborsi},
  A100UCheckRimborsiMW in '..\MWRilPre\A100UCheckRimborsiMW.pas' {A100FCheckRimborsiMW: TDataModule};

{$R *.RES}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=DebugHook <> 0;
  {$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.CreateForm(TA100FMISSIONI, A100FMISSIONI);
  Application.CreateForm(TA100FMISSIONIDtM, A100FMISSIONIDtM);
  Application.Run;
end.
