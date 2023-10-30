program P688PMonitoraggioFondi;

uses
  Forms,
  P688UMonitoraggioFondi in 'P688UMonitoraggioFondi.pas' {P688FMonitoraggioFondi},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  P688UMonitoraggioFondiDtM in 'P688UMonitoraggioFondiDtM.pas' {P688FMonitoraggioFondiDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  P688UMonitoraggioFondiMW in '..\MWCondivisi\P688UMonitoraggioFondiMW.pas' {P688FMonitoraggioFondiMW: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TP688FMonitoraggioFondi, P688FMonitoraggioFondi);
  Application.CreateForm(TP688FMonitoraggioFondiDtM, P688FMonitoraggioFondiDtM);
  Application.Run;
end.
