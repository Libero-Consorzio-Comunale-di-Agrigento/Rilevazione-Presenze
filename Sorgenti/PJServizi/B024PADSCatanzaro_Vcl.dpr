program B024PADSCatanzaro_Vcl;

uses
  Forms,
  B024UMainForm in 'B024UMainForm.pas' {B024FMainForm},
  B024UADSCatanzaroDM in 'B024UADSCatanzaroDM.pas' {B024FADSCatanzaroDM: TDataModule},
  B024UADSCatanzaroImpl in 'B024UADSCatanzaroImpl.pas',
  B024UADSCatanzaroIntf in 'B024UADSCatanzaroIntf.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TB024FADSCatanzaroDM, B024FADSCatanzaroDM);
  Application.CreateForm(TB024FMainForm, B024FMainForm);
  Application.Run;
end.
