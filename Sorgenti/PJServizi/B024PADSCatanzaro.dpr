program B024PADSCatanzaro;

uses
  Vcl.SvcMgr,
  System.SysUtils,
  B024UServerContainer in 'B024UServerContainer.pas' {B024FServerContainer: TService},
  B024UADSCatanzaroDM in 'B024UADSCatanzaroDM.pas' {B024FADSCatanzaroDM: TDataModule},
  B024UADSCatanzaroImpl in 'B024UADSCatanzaroImpl.pas',
  B024UADSCatanzaroIntf in 'B024UADSCatanzaroIntf.pas';

{$R *.res}

begin
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TB024FADSCatanzaroDM, B024FADSCatanzaroDM);
  Application.CreateForm(TB024FServerContainer, B024FServerContainer);
  Application.Run;
end.
