program P554PElaborazioneContoAnnuale;

uses
  Forms,
  R004UGestStoricoDTM in '..\REPOSITARY\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  P554UElaborazioneContoAnnualeDtM in 'P554UElaborazioneContoAnnualeDtM.pas' {P554FElaborazioneContoAnnualeDtM: TDataModule},
  P554UElaborazioneContoAnnuale in 'P554UElaborazioneContoAnnuale.pas' {P554FElaborazioneContoAnnuale},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  P554UImpostazioni in 'P554UImpostazioni.pas' {P554FImpostazioni},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  P554UElaborazioneContoAnnualeMW in '..\MWCondivisi\P554UElaborazioneContoAnnualeMW.pas' {P554FElaborazioneContoAnnualeMW: TDataModule},
  P948UCalcoloContoAnnualeDtm in 'P948UCalcoloContoAnnualeDtm.pas' {P948FCalcoloContoAnnualeDtm: TDataModule},
  USelAziendeBase in '..\Componenti\USelAziendeBase.pas';

{$R *.RES}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  Application.Initialize;
  Application.CreateForm(TP554FElaborazioneContoAnnualeDtM, P554FElaborazioneContoAnnualeDtM);
  Application.CreateForm(TP554FElaborazioneContoAnnuale, P554FElaborazioneContoAnnuale);
  //***Application.CreateForm(TP948FCalcoloContoAnnualeDtm, P948FCalcoloContoAnnualeDtm);
  Application.Run;
end.
