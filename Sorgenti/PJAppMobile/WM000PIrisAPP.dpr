//{$define UNIGUI_VCL} // Comment out this line to turn this project into an ISAPI module

{$ifndef UNIGUI_VCL}
library
{$else}
program
{$endif}
  WM000PIrisAPP;

uses
  uniGUIISAPI,
  Forms,
  {$ifdef UNIGUI_VCL}
  OracleMonitor,
  {$endif UNIGUI_VCL}
  WM000UServerModule in 'WM000UServerModule.pas' {WM000FServerModule: TUniGUIServerModule},
  WM000UMainModule in 'WM000UMainModule.pas' {WM000FMainModule: TUniGUIMainModule},
  WM000UConstants in 'WM000UConstants.pas',
  WM000UTypes in 'WM000UTypes.pas',
  WM000UFrameBase in 'FM\WM000UFrameBase.pas' {WM000FFrameBase: TUniFrame},
  WR002URichiesteFM in 'FM\WR002URichiesteFM.pas' {WR002FRichiesteFM: TUniFrame},
  WR003UGestRichiesteFM in 'FM\WR003UGestRichiesteFM.pas' {WR003FGestRichiesteFM: TUniFrame},
  WM000UDataSetMW in 'MW\WM000UDataSetMW.pas',
  WM001ULoginMW in 'MW\WM001ULoginMW.pas',
  WM004UCartellinoMW in 'MW\WM004UCartellinoMW.pas',
  WM005UCedolinoMW in 'MW\WM005UCedolinoMW.pas',
  WM011UDatiGiornalieriMW in 'MW\WM011UDatiGiornalieriMW.pas',
  WM012UElencoDipendentiMW in 'MW\WM012UElencoDipendentiMW.pas',
  WM014URicTimbratureMW in 'MW\WM014URicTimbratureMW.pas',
  WM015UTimbraturaVirtualeMW in 'MW\WM015UTimbraturaVirtualeMW.pas',
  WR003UNoteMW in 'MW\WR003UNoteMW.pas',
  WR002URichiesteMW in 'MW\WR002URichiesteMW.pas',
  WM000UFrameForm in 'FORM\WM000UFrameForm.pas' {WM000FFrameForm: TUnimForm},
  WM000UMain in 'FORM\WM000UMain.pas' {WM000FMain: TUnimForm},
  WM002UInfo in 'FORM\WM002UInfo.pas' {WM002FInfo: TUnimForm},
  WM015UGoogleMaps in 'FORM\WM015UGoogleMaps.pas' {WM015FGoogleMaps: TUnimForm},
  WM014URicTimbratureFM in 'FM\WM014URicTimbratureFM.pas' {WM014FRicTimbratureFM: TUniFrame},
  WR005UTimbratureModificabiliMW in 'MW\WR005UTimbratureModificabiliMW.pas',
  WM015UTimbraturaVirtualeFM in 'FM\WM015UTimbraturaVirtualeFM.pas' {WM015FTimbraturaVirtualeFM: TUniFrame},
  WR004UAutRichiesteFM in 'FM\WR004UAutRichiesteFM.pas' {WR004FAutRichiesteFM: TUniFrame},
  WM010UAutTimbratureMW in 'MW\WM010UAutTimbratureMW.pas',
  WM010UAutTimbratureFM in 'FM\WM010UAutTimbratureFM.pas' {WM010FAutTimbratureFM: TUniFrame},
  WM003UAutAssenzeFM in 'FM\WM003UAutAssenzeFM.pas' {WM003FAutAssenzeFM: TUniFrame},
  WM003UAutAssenzeMW in 'MW\WM003UAutAssenzeMW.pas',
  WR004UCompetenzeMW in 'MW\WR004UCompetenzeMW.pas',
  WM013URicAssenzeFM in 'FM\WM013URicAssenzeFM.pas' {WM013FRicAssenzeFM: TUniFrame},
  WM013URicAssenzeMW in 'MW\WM013URicAssenzeMW.pas',
  WM001ULogin in 'FORM\WM001ULogin.pas' {WM001FLogin: TUnimLoginForm},
  WM009UNotificheMW in 'MW\WM009UNotificheMW.pas',
  WM009UNotifiche in 'FORM\WM009UNotifiche.pas' {WM009FNotifiche: TUnimForm},
  WM005UCedolinoFM in 'FM\WM005UCedolinoFM.pas' {WM005FCedolinoFM: TUniFrame},
  WM004UCartellinoFM in 'FM\WM004UCartellinoFM.pas' {WM004FCartellinoFM: TUniFrame},
  WM011UDatiGiornalieriFM in 'FM\WM011UDatiGiornalieriFM.pas' {WM011FDatiGiornalieriFM: TUniFrame},
  WM012UElencoDipendentiFM in 'FM\WM012UElencoDipendentiFM.pas' {WM012FElencoDipendentiFM: TUniFrame},
  WM000UMessageDlg in 'FORM\WM000UMessageDlg.pas' {WM000FMessageDlg: TUnimForm},
  B110UServerMethodsDMClient in 'B110UServerMethodsDMClient.pas',
  B110UClientModule in 'B110UClientModule.pas' {B110FClientModule: TDataModule},
  WM000UParConfig in 'WM000UParConfig.pas',
  A000Versione in '..\Copy\A000Versione.pas',
  WM006UGestioneDelegheFM in 'FM\WM006UGestioneDelegheFM.pas' {WM006FGestioneDelegheFM: TUniFrame},
  WM000UDataModuleBaseDM in 'DM\WM000UDataModuleBaseDM.pas' {WM000FDataModuleBaseDM: TDataModule},
  WM006UGestioneDelegheDM in 'DM\WM006UGestioneDelegheDM.pas' {WM006FGestioneDelegheDM: TDataModule},
  WM006UGestioneDelegheMW in 'MW\WM006UGestioneDelegheMW.pas',
  A000USessione in '..\Copy\A000USessione.pas',
  WM001ULoginOAuth2MW in 'MW\WM001ULoginOAuth2MW.pas' {WM001FLoginOAuth2MW: TDataModule},
  WM001URecuperoPasswordMW in 'MW\WM001URecuperoPasswordMW.pas' {WM001FRecuperoPasswordMW: TDataModule},
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas',
  WM000UTestFM in 'FM\WM000UTestFM.pas' {WM000FTestFM: TUniFrame},
  WM016UCambioOrarioMW in 'MW\WM016UCambioOrarioMW.pas',
  WM016URicCambioOrarioFM in 'FM\WM016URicCambioOrarioFM.pas' {WM016FRicCambioOrarioFM: TUniFrame},
  WM017UAutCambioOrarioFM in 'FM\WM017UAutCambioOrarioFM.pas' {WM017FAutCambioOrarioFM: TUniFrame},
  WM015UTimbraturaVirtualeDM in 'DM\WM015UTimbraturaVirtualeDM.pas' {WM015FTimbraturaVirtualeDM: TDataModule},
  WR006UAllegatiMW in 'MW\WR006UAllegatiMW.pas' {WR006FAllegatiMW: TDataModule},
  WM018UMessaggisticaDM in 'DM\WM018UMessaggisticaDM.pas' {WM018FMessaggisticaDM: TDataModule},
  WM018UMessaggisticaFM in 'FM\WM018UMessaggisticaFM.pas' {WM018FMessaggisticaFM: TUniFrame},
  WM018UMessaggisticaMW in 'MW\WM018UMessaggisticaMW.pas' {WM018FMessaggisticaMW: TDataModule},
  WM019URicCertificazioniFM in 'FM\WM019URicCertificazioniFM.pas' {WM019FRicCertificazioniFM: TUniFrame},
  WM020UAutCertificazioniFM in 'FM\WM020UAutCertificazioniFM.pas' {WM020FAutCertificazioniFM: TUniFrame},
  WM019UCertificazioniMW in 'MW\WM019UCertificazioniMW.pas',
  WM019UModelloCertificazioneMW in 'MW\WM019UModelloCertificazioneMW.pas' {WM019FModelloCertificazioneMW: TDataModule},
  WR002UIterDM in 'DM\WR002UIterDM.pas' {WR002FIterDM: TDataModule},
  WM019UCertificazioniDM in 'DM\WM019UCertificazioniDM.pas' {WM019FCertificazioniDM: TDataModule},
  WM016UCambioOrarioDM in 'DM\WM016UCambioOrarioDM.pas' {WM016FCambioOrarioDM: TDataModule},
  C180FunzioniGenerali in '..\Copy\C180FunzioniGenerali.pas',
  WM001UCambioPasswordMW in 'MW\WM001UCambioPasswordMW.pas' {WM001FCambioPasswordMW: TDataModule};

{$R *.res}

{$ifndef UNIGUI_VCL}
exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;
{$endif}

begin
{$ifdef UNIGUI_VCL}
  ReportMemoryLeaksOnShutdown:=DebugHook <> 0;
  Application.Initialize;
  TWM000FServerModule.Create(Application);
  Application.Run;
{$endif}
end.
