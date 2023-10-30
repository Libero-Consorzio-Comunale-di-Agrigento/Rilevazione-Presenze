program WA117POreLiquidateAnniPrec;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas',
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WA117ULogin in 'WA117ULogin.pas' {WA117FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WA117UOreLiquidateAnniPrec in 'WA117UOreLiquidateAnniPrec.pas' {WA117FOreLiquidateAnniPrec: TIWAppForm},
  L021Call in '..\Copy\L021Call.pas',
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WA117UOreLiquidateAnniPrecDM in 'WA117UOreLiquidateAnniPrecDM.pas' {WA117FOreLiquidateAnniPrecDM: TIWUserSessionBase},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WA117UOreLiquidateAnniPrecBrowseFM in 'WA117UOreLiquidateAnniPrecBrowseFM.pas' {WA117FOreLiquidateAnniPrecBrowseFM: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A117UOreLiquidateAnniPrecMW in '..\MWRilPre\A117UOreLiquidateAnniPrecMW.pas' {A117FOreLiquidateAnniPrecMW: TDataModule};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
