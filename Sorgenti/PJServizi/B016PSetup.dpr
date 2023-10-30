program B016PSetup;

uses
  Forms,
  HtmlHelpViewer,
  SysUtils,
  C180FunzioniGenerali,
  B016USetup in 'B016USetup.pas' {B016FSetup},
  B016USetupPercorsi in 'B016USetupPercorsi.pas' {B016FSetupPercorsi},
  B016USetupSelez in 'B016USetupSelez.pas' {B016FSetupSelez};

var
  CHMFile:String;

{$R *.res}

begin
  Application.Initialize;
  Application.HelpFile := 'Help\IrisWIN_accessori.chm';
  CHMFile:=R180PreparaFileHelpTemp(IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + Application.HelpFile);
  if CHMFile <> '' then
    Application.HelpFile:=CHMFile;
  Application.CreateForm(TB016FSetup, B016FSetup);
  Application.Run;
end.
