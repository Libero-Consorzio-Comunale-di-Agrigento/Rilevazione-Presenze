program A177PFerieSolidali;

uses
  Vcl.Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A177UFerieSolidali in 'A177UFerieSolidali.pas' {A177FFerieSolidali},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A177UFerieSolidaliDM in 'A177UFerieSolidaliDM.pas' {A177FFerieSolidaliDM: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A177UFerieSolidaliMW in '..\MWRilPre\A177UFerieSolidaliMW.pas' {A177FFerieSolidaliMW: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA177FFerieSolidaliDM, A177FFerieSolidaliDM);
  Application.CreateForm(TA177FFerieSolidali, A177FFerieSolidali);
  Application.Run;
end.
