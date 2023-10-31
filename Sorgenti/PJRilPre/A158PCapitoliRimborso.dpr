program A158PCapitoliRimborso;

uses
  Vcl.Forms,
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  A158UCapitoliRimborso in 'A158UCapitoliRimborso.pas' {A158FCapitoliRimborso},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A158UCapitoliRimborsoDM in 'A158UCapitoliRimborsoDM.pas' {A158FCapitoliRimborsoDM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A158UCapitoliRimborsoMW in '..\MWRilPre\A158UCapitoliRimborsoMW.pas' {A158FCapitoliRimborsoMW: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA158FCapitoliRimborso, A158FCapitoliRimborso);
  Application.CreateForm(TA158FCapitoliRimborsoDM, A158FCapitoliRimborsoDM);
  Application.Run;
end.
