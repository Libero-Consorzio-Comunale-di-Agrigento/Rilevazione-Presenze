program WA195PImpRichRimborso;

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
  WA195ULogin in 'WA195ULogin.pas' {WA195FLogin: TIWAppForm},
  WA195UImpRichRimborsoDM in 'WA195UImpRichRimborsoDM.pas' {WA195FImpRichRimborsoDM: TIWUserSessionBase},
  WA195UImpRichRimborso in 'WA195UImpRichRimborso.pas' {WA195FImpRichRimborso: TIWAppForm},
  WA195UImpRichRimborsoBrowseFM in 'WA195UImpRichRimborsoBrowseFM.pas' {WA195FImpRichRimborsoBrowseFM: TFrame},
  WA195UImpRichRimborsoDettFM in 'WA195UImpRichRimborsoDettFM.pas' {WA195FImpRichRimborsoDettFM: TFrame},
  A100UImpRimborsiIterMW in '..\MWRilPre\A100UImpRimborsiIterMW.pas' {A100FImpRimborsiIterMW: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule};

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
