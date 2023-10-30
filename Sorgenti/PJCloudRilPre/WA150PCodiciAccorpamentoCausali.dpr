program WA150PCodiciAccorpamentoCausali;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
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
  WA150UCodiciAccorpamentoCausali in 'WA150UCodiciAccorpamentoCausali.pas' {WA150FCodiciAccorpamentoCausali: TIWAppForm},
  WA150UCodiciAccorpamentoCausaliBrowseFM in 'WA150UCodiciAccorpamentoCausaliBrowseFM.pas' {WA150FCodiciAccorpamentoCausaliBrowseFm: TFrame},
  WA150UCodiciAccorpamentoCausaliDM in 'WA150UCodiciAccorpamentoCausaliDM.pas' {WA150FCodiciAccorpamentoCausaliDM: TIWUserSessionBase},
  WA150UCodiciAccorpamentoCausaliLogin in 'WA150UCodiciAccorpamentoCausaliLogin.pas' {WA150FCodiciAccorpamentoCausaliLogin: TIWAppForm},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A150UAccorpamentoCausaliMW in '..\MWRilPre\A150UAccorpamentoCausaliMW.pas' {A150FAccorpamentoCausaliMW: TDataModule};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
