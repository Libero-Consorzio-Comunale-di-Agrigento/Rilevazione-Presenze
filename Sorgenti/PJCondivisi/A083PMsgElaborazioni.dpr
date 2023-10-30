program A083PMsgElaborazioni;

uses
  Forms,
  OracleMonitor,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A083UMsgElaborazioni in 'A083UMsgElaborazioni.pas' {A083FMsgElaborazioni},
  A083UMsgElaborazioniDtm in 'A083UMsgElaborazioniDtm.pas' {A083FMsgElaborazioniDtm: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R002UQREP in '..\Repositary\R002UQREP.pas' {R002FQRep},
  A083UStampa in 'A083UStampa.pas' {A083FStampa},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A083UMsgElaborazioniMW in '..\MWCondivisi\A083UMsgElaborazioniMW.pas' {A083FMsgElaborazioniMW: TDataModule},
  InputPeriodo in '..\Componenti\InputPeriodo.pas' {frmInputPeriodo: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA083FMsgElaborazioni, A083FMsgElaborazioni);
  Application.CreateForm(TA083FMsgElaborazioniDtm, A083FMsgElaborazioniDtm);
  Application.Run;
end.
