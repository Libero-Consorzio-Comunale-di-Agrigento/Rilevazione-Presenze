program A175PRegoleOrologi;

uses
  madExcept,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  A175URegoleOrologi in 'A175URegoleOrologi.pas' {A175FRegoleOrologi},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A175URegoleOrologiDM in 'A175URegoleOrologiDM.pas' {A175FRegoleOrologiDM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A175URegoleOrologiMW in 'A175URegoleOrologiMW.pas' {A175FRegoleOrologiMW: TDataModule},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA175FRegoleOrologi, A175FRegoleOrologi);
  Application.CreateForm(TA175FRegoleOrologiDM, A175FRegoleOrologiDM);
  Application.CreateForm(TA175FRegoleOrologiMW, A175FRegoleOrologiMW);
  Application.Run;
end.
