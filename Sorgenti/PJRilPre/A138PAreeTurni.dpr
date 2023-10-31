program A138PAreeTurni;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A138UAreeTurni in 'A138UAreeTurni.pas' {A138FAreeTurni},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A138UAreeTurniDtM in 'A138UAreeTurniDtM.pas' {A138FAreeTurniDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A138UAreeTurniMW in '..\MWRilPre\A138UAreeTurniMW.pas' {A138FAreeTurniMW};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA138FAreeTurni, A138FAreeTurni);
  Application.CreateForm(TA138FAreeTurniDtM, A138FAreeTurniDtM);
  Application.Run;
end.
