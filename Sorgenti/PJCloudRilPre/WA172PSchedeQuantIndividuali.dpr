program WA172PSchedeQuantIndividuali;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR103UGestMasterDetail in '..\Repositary\WR103UGestMasterDetail.pas' {WR103FGestMasterDetail: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase},
  WA172ULogin in 'WA172ULogin.pas' {WA172FLogin: TIWAppForm},
  WA172USchedeQuantIndividualiDM in 'WA172USchedeQuantIndividualiDM.pas' {WA172FSchedeQuantIndividualiDM: TIWUserSessionBase},
  WA172USchedeQuantIndividuali in 'WA172USchedeQuantIndividuali.pas' {WA172FSchedeQuantIndividuali: TIWAppForm},
  WA172USchedeQuantIndividualiBrowseFM in 'WA172USchedeQuantIndividualiBrowseFM.pas' {WA172FSchedeQuantIndividualiBrowseFM: TFrame},
  WA172USchedeQuantIndividualiDettFM in 'WA172USchedeQuantIndividualiDettFM.pas' {WA172FSchedeQuantIndividualiDettFM: TFrame},
  WR203UGestDetailFM in '..\Repositary\WR203UGestDetailFM.pas' {WR203FGestDetailFM: TFrame},
  WA172UAnagraficaDetailFM in 'WA172UAnagraficaDetailFM.pas' {WA172FAnagraficaDetailFM: TFrame},
  A172USchedeQuantIndividualiMW in '..\MWRilPre\A172USchedeQuantIndividualiMW.pas' {A172FSchedeQuantIndividualiMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  L021Call in '..\Copy\L021Call.pas',
  A000UCostanti in '..\Copy\A000UCostanti.pas',
  //WR020UBaseFM in '..\Repositary\WR020UBaseFM.pas' {WR020FBaseFM: TFrame},
  WA172USchedeQuantObiettiviFM in 'WA172USchedeQuantObiettiviFM.pas' {WA172FSchedeQuantObiettiviFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
