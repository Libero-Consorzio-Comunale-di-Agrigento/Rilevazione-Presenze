program A057PSpostSquadra;

uses
  Forms,
  A057USpostSquadra in 'A057USpostSquadra.pas' {A057FSpostSquadra},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A057USpostSquadraDM in 'A057USpostSquadraDM.pas' {A057FSpostSquadraDM: TDataModule},
  A057USpostSquadraMW in '..\MWRilPre\A057USpostSquadraMW.pas' {A057FSpostSquadraMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA057FSpostSquadra, A057FSpostSquadra);
  Application.CreateForm(TA057FSpostSquadraDM, A057FSpostSquadraDM);
  Application.Run;
end.
