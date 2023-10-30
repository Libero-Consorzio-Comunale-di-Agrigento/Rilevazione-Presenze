program S028PMotivazioni;

uses
  Forms,
  R001UGESTTAB in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  S028UMotivazioni in 'S028UMotivazioni.pas' {S028FMotivazioni},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  S028UMotivazioniDtM in 'S028UMotivazioniDtM.pas' {S028FMotivazioniDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  S028UMotivazioniMW in '..\MWCondivisi\S028UMotivazioniMW.pas' {S028FmotivazioniMW: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TS028FMotivazioniDtM, S028FMotivazioniDtM);
  Application.CreateForm(TS028FMotivazioni, S028FMotivazioni);
  Application.CreateForm(TS028FmotivazioniMW, S028FmotivazioniMW);
  Application.Run;
end.
