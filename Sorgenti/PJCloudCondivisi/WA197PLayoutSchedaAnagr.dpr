program WA197PLayoutSchedaAnagr;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  L021Call in '..\Copy\L021Call.pas',
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WA197ULogin in 'WA197ULogin.pas' {WA197FLogin: TIWAppForm},
  WA197ULayoutSchedaAnagrDM in 'WA197ULayoutSchedaAnagrDM.pas' {WA197FLayoutSchedaAnagrDM: TIWUserSessionBase},
  WA197ULayoutSchedaAnagr in 'WA197ULayoutSchedaAnagr.pas' {WA197FLayoutSchedaAnagr: TIWAppForm},
  WA197ULayoutSchedaAnagrBrowseFM in 'WA197ULayoutSchedaAnagrBrowseFM.pas' {WA197FLayoutSchedaAnagrBrowseFM: TFrame},
  WA197ULayoutSchedaAnagrDettFM in 'WA197ULayoutSchedaAnagrDettFM.pas' {WA197FLayoutSchedaAnagrDettFM: TFrame},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  WA197UPreviewFM in 'WA197UPreviewFM.pas' {WA197FPreviewFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
