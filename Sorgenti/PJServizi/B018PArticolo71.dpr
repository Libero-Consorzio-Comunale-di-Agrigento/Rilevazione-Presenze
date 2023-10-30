program B018PArticolo71;

uses
  Forms,
  HtmlHelpViewer,
  MidasLib,
  A000UInterfaccia,
  B018UArticolo71DtM1 in 'B018UArticolo71DtM1.pas' {B018FArticolo71DtM1: TDataModule},
  B018UArticolo71 in 'B018UArticolo71.pas' {B018FArticolo71},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Art.71 D.L.112/08';
  Application.HelpFile := 'Help\IrisWin_accessori.chm';
  Application.CreateForm(TB018FArticolo71, B018FArticolo71);
  Application.CreateForm(TB018FArticolo71DtM1, B018FArticolo71DtM1);
  if Parametri.Azienda = '' then
    Application.Terminate
  else
    Application.Run;
end.
