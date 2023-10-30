program X001PCentriCostoTOHM;

uses
  IWStart,
  X001UCentriCosto in 'X001UCentriCosto.pas' {X001FCentriCosto: TIWAppForm},
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000ServerController: TIWServerControllerBase},
  X001UCentriCostoDtM in 'X001UCentriCostoDtM.pas' {X001FCentriCostoDtM: TDataModule},
  WR000UBaseDM in '..\Repositary\WR000UBaseDM.pas' {WR000FBaseDM: TDataModule},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=DebugHook <> 0;
  TIWStart.Execute(True);
end.

