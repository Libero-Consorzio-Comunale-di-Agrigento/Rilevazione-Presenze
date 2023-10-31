program A140PTurniServizi;

uses
  Forms,
  R001UGESTTAB in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  A140UTurniServizi in 'A140UTurniServizi.pas' {A140FTurniServizi},
  R004UGESTSTORICODTM in '..\REPOSITARY\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  A140UTurniServiziDTM in 'A140UTurniServiziDTM.pas' {A140FTurniServiziDTM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA140FTurniServizi, A140FTurniServizi);
  Application.CreateForm(TA140FTurniServiziDTM, A140FTurniServiziDTM);
  Application.Run;
end.
