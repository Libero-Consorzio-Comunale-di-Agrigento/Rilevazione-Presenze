program B005PAggIris;

uses
  Forms,
  HTMLHelpViewer,
  MidasLib,
  OracleMonitor,
  SysUtils,
  C180FunzioniGenerali,
  B005UAggIris in 'B005UAggIris.pas' {B005FAggIris},
  B005UAggIrisDtM1 in 'B005UAggIrisDtM1.pas' {B005FAggIrisDtM1: TDataModule},
  B005UInvioEMail in 'B005UInvioEMail.pas' {B005FInvioEMail};

var
  CHMFile:String;

{$R *.RES}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Aggiornamento base dati';
  Application.HelpFile := 'Help\IrisWIN_accessori.chm';
  CHMFile:=R180PreparaFileHelpTemp(IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + Application.HelpFile);
  if CHMFile <> '' then
    Application.HelpFile:=CHMFile;
  Application.CreateForm(TB005FAggIris, B005FAggIris);
  Application.CreateForm(TB005FAggIrisDtM1, B005FAggIrisDtM1);
  Application.Run;
end.
