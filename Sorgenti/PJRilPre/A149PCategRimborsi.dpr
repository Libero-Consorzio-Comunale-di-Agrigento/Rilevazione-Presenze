program A149PCategRimborsi;

uses
  Vcl.Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A149UCategRimborsi in 'A149UCategRimborsi.pas' {A149FCategRimborsi},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A149UCategRimborsiDM in 'A149UCategRimborsiDM.pas' {A149FCategRimborsiDM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA149FCategRimborsi, A149FCategRimborsi);
  Application.CreateForm(TA149FCategRimborsiDM, A149FCategRimborsiDM);
  Application.Run;
end.
