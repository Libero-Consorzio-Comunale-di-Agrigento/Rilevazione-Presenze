program A171PXMLVisiteFiscali;

uses
  Vcl.Forms,
  A171UXMLVisiteFiscali in 'A171UXMLVisiteFiscali.pas' {A171FXMLVisiteFiscali},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A171UXMLVisiteFiscaliDM in 'A171UXMLVisiteFiscaliDM.pas' {A171FXMLVisiteFiscaliDM: TDataModule},
  A171UXMLVisiteFiscaliMW in '..\MWRilPre\A171UXMLVisiteFiscaliMW.pas' {A171FXMLVisiteFiscaliMW: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  OracleMonitor,
  InputPeriodo in '..\Componenti\InputPeriodo.pas' {frmInputPeriodo: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA171FXMLVisiteFiscaliDM, A171FXMLVisiteFiscaliDM);
  Application.CreateForm(TA171FXMLVisiteFiscali, A171FXMLVisiteFiscali);
  Application.Run;
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=DebugHook <> 0;
end.
