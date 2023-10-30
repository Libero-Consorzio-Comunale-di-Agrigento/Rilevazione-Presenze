program S720PProfiliAree;

uses
  Forms,
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  S720UProfiliAree in 'S720UProfiliAree.pas' {S720FProfiliAree},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  S720UProfiliAreeDtM in 'S720UProfiliAreeDtM.pas' {S720FProfiliAreeDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  S720UProfiliAreeMW in '..\MWCondivisi\S720UProfiliAreeMW.pas' {S720FProfiliAreeMW: TDataModule},
  S720UImportProfili in 'S720UImportProfili.pas' {S720FImportProfili};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TS720FProfiliAree, S720FProfiliAree);
  Application.CreateForm(TS720FProfiliAreeDtM, S720FProfiliAreeDtM);
  Application.Run;
end.
