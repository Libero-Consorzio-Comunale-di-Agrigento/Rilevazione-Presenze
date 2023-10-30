program B021PRiallineamento;

uses
  Forms,
  B021URiallineamento in 'B021URiallineamento.pas' {B021FRiallineamento},
  B021URiallineamentoDM in 'B021URiallineamentoDM.pas' {B021FRiallineamentoDM},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TB021FRiallineamento, B021FRiallineamento);
  Application.CreateForm(TB021FRiallineamentoDM, B021FRiallineamentoDM);
  Application.Run;
end.
