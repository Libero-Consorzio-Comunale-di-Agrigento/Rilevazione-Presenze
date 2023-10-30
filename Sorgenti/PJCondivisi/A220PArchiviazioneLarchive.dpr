program A220PArchiviazioneLarchive;

uses
  Vcl.Forms,
  OracleMonitor,
  A220UArchiviazioneLarchive in 'A220UArchiviazioneLArchive.pas' {A220FArchiviazioneLArchive},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A220UArchiviazioneLArchiveDtM in 'A220UArchiviazioneLArchiveDtM.pas' {A220FArchiviazioneLArchiveDtM: TDataModule},
  A220UArchiviazioneLArchiveMW in '..\MWCondivisi\A220UArchiviazioneLArchiveMW.pas' {A220FArchiviazioneLArchiveMW: TDataModule},
  InputPeriodo in '..\Componenti\InputPeriodo.pas' {frmInputPeriodo: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA220FArchiviazioneLArchive, A220FArchiviazioneLArchive);
  Application.CreateForm(TR001FGestTab, R001FGestTab);
  Application.CreateForm(TR004FGestStoricoDtM, R004FGestStoricoDtM);
  Application.CreateForm(TA220FArchiviazioneLArchiveDtM, A220FArchiviazioneLArchiveDtM);
  Application.Run;
end.
