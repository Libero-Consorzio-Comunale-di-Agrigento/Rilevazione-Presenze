program B013PIntegrazioneEMK;

uses
  Forms,
  HtmlHelpViewer,
  MidasLib,
  B013UIntegrazioneEMK in 'B013UIntegrazioneEMK.pas' {B013FIntegrazioneEMK},
  B013UIntegrazioneEMKDtM in 'B013UIntegrazioneEMKDtM.pas' {B013FIntegrazioneEMKDtM: TDataModule},
  B013UPianificazioneIntegrazione in 'B013UPianificazioneIntegrazione.pas' {B013FPianificazioneIntegrazione};

{$R *.RES}

begin
  Application.Initialize;
  Application.HelpFile := 'Help\IrisWIN_accessori.hlp';
  Application.CreateForm(TB013FIntegrazioneEMK, B013FIntegrazioneEMK);
  Application.CreateForm(TB013FIntegrazioneEMKDtM, B013FIntegrazioneEMKDtM);
  Application.CreateForm(TB013FPianificazioneIntegrazione, B013FPianificazioneIntegrazione);
  Application.Run;
end.
