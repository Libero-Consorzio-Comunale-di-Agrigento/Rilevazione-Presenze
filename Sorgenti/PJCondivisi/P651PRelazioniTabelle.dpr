program P651PRelazioniTabelle;

uses
  madExcept,
  madListHardware,
  madListProcesses,
  madListModules,
  Forms,
  MidasLib,
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  P651URelazioniTabelle in 'P651URelazioniTabelle.pas' {P651FRelazioniTabelle},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  P651URelazioniTabelleDtM in 'P651URelazioniTabelleDtM.pas' {P651FRelazioniTabelleDtM: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  P651URelazioniTabelleMW in '..\MWCondivisi\P651URelazioniTabelleMW.pas' {P651FRelazioniTabelleMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TP651FRelazioniTabelle, P651FRelazioniTabelle);
  Application.CreateForm(TP651FRelazioniTabelleDtM, P651FRelazioniTabelleDtM);
  Application.Run;
end.
