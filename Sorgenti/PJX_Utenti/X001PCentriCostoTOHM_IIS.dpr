library X001PCentriCostoTOHM_IIS;

uses
  ISAPIApp,
  IWInitISAPI,
  ISAPIThreadPool,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000ServerController: TIWServerControllerBase},
  X001UCentriCosto in 'X001UCentriCosto.pas' {X001FCentriCosto: TIWAppForm},
  X001UCentriCostoDtM in 'X001UCentriCostoDtM.pas' {X001FCentriCostoDtM: TDataModule};

{$R *.RES}

exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;

begin
  IWRun;
end.
