program A064PBudgetStraordinario;

uses
  Forms,
  OracleMonitor,
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A064UBudgetStraordinarioDtM in 'A064UBudgetStraordinarioDtM.pas' {A064FBudgetStraordinarioDtM: TDataModule},
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame},
  C600USelAnagrafe in '..\Copy\C600USelAnagrafe.pas' {C600frmSelAnagrafe: TFrame},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A064UBudgetStraordinario in 'A064UBudgetStraordinario.pas' {A064FBudgetStraordinario},
  A064UDipendenti in 'A064UDipendenti.pas' {A064FDipendenti},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A064UBudgetStraordinarioMW in '..\MWRilPre\A064UBudgetStraordinarioMW.pas' {A064FBudgetStraordinarioMW: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA064FBudgetStraordinario, A064FBudgetStraordinario);
  Application.CreateForm(TA064FBudgetStraordinarioDtM, A064FBudgetStraordinarioDtM);
  Application.CreateForm(TA064FDipendenti, A064FDipendenti);
  Application.Run;
end.
