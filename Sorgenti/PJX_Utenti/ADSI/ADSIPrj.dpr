program ADSIPrj;

uses
  Vcl.Forms,
  ADSIFrm in 'ADSIFrm.pas' {frmADSI};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmADSI, frmADSI);
  Application.Run;
end.
