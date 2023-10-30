program S030PProvved;

uses
  madExcept,
  madListHardware,
  madListProcesses,
  madListModules,
  Forms,
  S030UProvved in 'S030UProvved.pas' {S030FProvved},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  S030UProvvedimentiDtM in 'S030UProvvedimentiDtM.pas' {S030FProvvedimentiDtM: TDataModule},
  R001UGESTTAB in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  S030UDettaglio in 'S030UDettaglio.pas' {S030FDettaglio},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  S030UProvvedimentiMW in '..\MWCondivisi\S030UProvvedimentiMW.pas' {S030FProvvedimentiMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TS030FProvved, S030FProvved);
  Application.CreateForm(TS030FProvvedimentiDtM, S030FProvvedimentiDtM);
  Application.Run;
end.
