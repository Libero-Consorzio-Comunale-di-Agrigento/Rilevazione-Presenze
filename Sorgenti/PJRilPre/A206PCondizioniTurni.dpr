program A206PCondizioniTurni;

uses
  Forms,
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A206UCondizioniTurni in 'A206UCondizioniTurni.pas' {A206FCondizioniTurni},
  A206UCondizioniTurniDM in 'A206UCondizioniTurniDM.pas' {A206FCondizioniTurniDM: TDataModule},
  A206UCondizioniTurniMW in '..\MWRilPre\A206UCondizioniTurniMW.pas' {A206FCondizioniTurniMW: TDataModule},
  C600USelAnagrafe in '..\Copy\C600USelAnagrafe.pas' {C600frmSelAnagrafe: TFrame},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A206UCodiciCondizioniTurni in 'A206UCodiciCondizioniTurni.pas' {A206FCodiciCondizioniTurni};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA206FCondizioniTurni, A206FCondizioniTurni);
  Application.CreateForm(TA206FCondizioniTurniDM, A206FCondizioniTurniDM);
  Application.CreateForm(TR001FGestTab, R001FGestTab);
  Application.CreateForm(TA206FCodiciCondizioniTurni, A206FCodiciCondizioniTurni);
  Application.Run;
end.
