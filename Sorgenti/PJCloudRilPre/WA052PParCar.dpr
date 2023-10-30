program WA052PParCar;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  L021Call in '..\Copy\L021Call.pas',
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  A052UParCarMW in '..\MWRilPre\A052UParCarMW.pas' {A052FParCarMW: TDataModule},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WA052ULogin in 'WA052ULogin.pas' {WA052FLogin: TIWAppForm},
  WA052UParCarDM in 'WA052UParCarDM.pas' {WA052FParCarDM: TIWUserSessionBase},
  WA052UParCar in 'WA052UParCar.pas' {WA052FParCar: TIWAppForm},
  WA052UParCarBrowseFM in 'WA052UParCarBrowseFM.pas' {WA052FParCarBrowseFM: TFrame},
  WA052UParCarDettFM in 'WA052UParCarDettFM.pas' {WA052FParCarDettFM: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  WA052UElencoFontsFM in 'WA052UElencoFontsFM.pas' {WA052FElencoFontsFM: TFrame},
  WA052UProprietaFM in 'WA052UProprietaFM.pas' {WA052FProprietaFM: TFrame},
  WC013UCheckListFM in '..\Copy\WC013UCheckListFM.pas' {WC013FCheckListFM: TFrame},
  WA052UPreviewFM in 'WA052UPreviewFM.pas' {WA052FPreviewFM: TFrame},
  C190FunzioniGeneraliWeb in '..\Copy\C190FunzioniGeneraliWeb.pas';

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  TIWStart.Execute(True);
end.
