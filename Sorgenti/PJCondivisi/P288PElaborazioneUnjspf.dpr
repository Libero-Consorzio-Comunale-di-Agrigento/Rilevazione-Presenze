program P288PElaborazioneUnjspf;

uses
  Forms,
  P288UElaborazioneUnjspf in 'P288UElaborazioneUnjspf.pas' {P288FElaborazioneUnjspf},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  P288UElaborazioneUnjspfDtM in 'P288UElaborazioneUnjspfDtM.pas' {P288FElaborazioneUnjspfDtM: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TP288FElaborazioneUnjspf, P288FElaborazioneUnjspf);
  Application.CreateForm(TP288FElaborazioneUnjspfDtM, P288FElaborazioneUnjspfDtM);
  Application.Run;
end.
