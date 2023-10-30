program WA176PRiepilogoIterAutorizzativi;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR103UGestMasterDetail in '..\Repositary\WR103UGestMasterDetail.pas' {WR103FGestMasterDetail: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR203UGestDetailFM in '..\Repositary\WR203UGestDetailFM.pas' {WR203FGestDetailFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase},
  A176URiepilogoIterAutorizzativiMW in '..\MWRilPre\A176URiepilogoIterAutorizzativiMW.pas' {A176FRiepilogoIterAutorizzativiMW: TDataModule},
  WA176ULogin in 'WA176ULogin.pas' {WA176FLogin: TIWAppForm},
  WA176URiepilogoIterAutorizzativiDM in 'WA176URiepilogoIterAutorizzativiDM.pas' {WA176FRiepilogoIterAutorizzativiDM: TIWUserSessionBase},
  WA176URiepilogoIterAutorizzativi in 'WA176URiepilogoIterAutorizzativi.pas' {WA176FRiepilogoIterAutorizzativi: TIWAppForm},
  WA176URiepilogoIterAutorizzativiBrowseFM in 'WA176URiepilogoIterAutorizzativiBrowseFM.pas' {WA176FRiepilogoIterAutorizzativiBrowseFM: TFrame},
  WA176UGestioneIterAutorizzativiFM in 'WA176UGestioneIterAutorizzativiFM.pas' {WA176FGestioneIterAutorizzativiFM: TFrame};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  TIWStart.Execute(True);
end.
