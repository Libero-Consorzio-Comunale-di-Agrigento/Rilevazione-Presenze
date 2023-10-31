program A138PTurniApparati;

uses
  Forms,
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  A138UTurniApparati in 'A138UTurniApparati.pas' {A138FTurniApparati},
  R004UGESTSTORICODTM in '..\REPOSITARY\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  A138UTurniApparatiDTM in 'A138UTurniApparatiDTM.pas' {A138FTurniApparatiDTM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA138FTurniApparati, A138FTurniApparati);
  Application.CreateForm(TA138FTurniApparatiDTM, A138FTurniApparatiDTM);
  Application.Run;
end.
