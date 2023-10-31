program A202PRapportiLavoro;

uses
  Vcl.Forms,
  OracleMonitor,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A202URapportiLavoro in 'A202URapportiLavoro.pas' {A202FRapportiLavoro},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A202URapportiLavoroDM in 'A202URapportiLavoroDM.pas' {A202FRapportiLavoroDM: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A202URapportiLavoroMW in '..\MWRilPre\A202URapportiLavoroMW.pas' {A202FRapportiLavoroMW: TDataModule},
  C023UInfoDati in '..\Copy\C023UInfoDati.pas' {C023FInfoDati},
  R002UQREP in '..\Repositary\R002UQREP.pas' {R002FQRep},
  A202UStampa in 'A202UStampa.pas' {A202FStampa};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA202FRapportiLavoroDM, A202FRapportiLavoroDM);
  A202FRapportiLavoroDM.ImpostaModalita(PASSENZE); //PASSENZE //VALIDAZIONE
  Application.CreateForm(TA202FRapportiLavoro, A202FRapportiLavoro);
  Application.Run;
end.
