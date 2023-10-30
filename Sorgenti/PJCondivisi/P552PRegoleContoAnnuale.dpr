program P552PRegoleContoAnnuale;

uses
  Forms,
  P552URegoleContoAnnuale in 'P552URegoleContoAnnuale.pas' {P552FRegoleContoAnnuale},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  P552URegoleContoAnnualeDtM in 'P552URegoleContoAnnualeDtM.pas' {P552FRegoleContoAnnualeDtM: TDataModule},
  P552UDettaglioRegoleContoAnn in 'P552UDettaglioRegoleContoAnn.pas' {P552FDettaglioRegoleContoAnn},
  R001UGESTTAB in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  P552UEsportazioneFile in 'P552UEsportazioneFile.pas' {P552FEsportazioneFile},
  C600USelAnagrafe in '..\Copy\C600USelAnagrafe.pas' {C600frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  P552URegoleContoAnnualeMW in '..\MWCondivisi\P552URegoleContoAnnualeMW.pas' {P552FRegoleContoAnnualeMW: TDataModule},
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  Application.Initialize;
  Application.CreateForm(TP552FRegoleContoAnnuale, P552FRegoleContoAnnuale);
  Application.CreateForm(TP552FRegoleContoAnnualeDtM, P552FRegoleContoAnnualeDtM);
  Application.Run;
end.
