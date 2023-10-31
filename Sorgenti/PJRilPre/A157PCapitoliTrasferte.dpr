program A157PCapitoliTrasferte;

uses
  Vcl.Forms,
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A157UCapitoliTrasferte in 'A157UCapitoliTrasferte.pas' {A157FCapitoliTrasferte},
  A157UCapitoliTrasferteDM in 'A157UCapitoliTrasferteDM.pas' {A157FCapitoliTrasferteDM: TDataModule},
  A157UCapitoliTrasferteMW in '..\MWRilPre\A157UCapitoliTrasferteMW.pas' {A157FCapitoliTrasferteMW: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA157FCapitoliTrasferte, A157FCapitoliTrasferte);
  Application.CreateForm(TA157FCapitoliTrasferteDM, A157FCapitoliTrasferteDM);
  Application.CreateForm(TA157FCapitoliTrasferteMW, A157FCapitoliTrasferteMW);
  Application.Run;
end.
