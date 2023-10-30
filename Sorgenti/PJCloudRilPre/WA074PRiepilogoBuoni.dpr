program WA074PRiepilogoBuoni;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WA074ULogin in 'WA074ULogin.pas' {WA074FLogin: TIWAppForm},
  WA074URiepilogoBuoni in 'WA074URiepilogoBuoni.pas' {WA074FRiepilogoBuoni: TIWAppForm},
  WA074URiepilogoBuoniDM in 'WA074URiepilogoBuoniDM.pas' {WA074FRiepilogoBuoniDM: TIWUserSessionBase},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WA074UGemeazFM in 'WA074UGemeazFM.pas' {WA074FGemeazFM: TFrame},
  WC700USelezioneAnagrafeFM in '..\Copy\WC700USelezioneAnagrafeFM.pas' {WC700FSelezioneAnagrafeFM: TFrame},
  WC700USelezioneAnagrafeDM in '..\Copy\WC700USelezioneAnagrafeDM.pas' {WC700FSelezioneAnagrafeDM: TIWUserSessionBase},
  A074URiepilogoBuoniMW in '..\MWRilPre\A074URiepilogoBuoniMW.pas' {A074FRiepilogoBuoniMW: TDataModule},
  R350UCalcoloBuoniDtM in '..\MWRilPre\R350UCalcoloBuoniDtM.pas' {R350FCalcoloBuoniDtM: TDataModule};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
