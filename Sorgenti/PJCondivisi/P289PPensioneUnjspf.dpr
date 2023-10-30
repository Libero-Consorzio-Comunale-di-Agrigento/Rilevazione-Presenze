program P289PPensioneUnjspf;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  P289UPensioneUnjspf in 'P289UPensioneUnjspf.pas' {P289FPensioneUnjspf},
  P289UPensioneUnjspfDtM in 'P289UPensioneUnjspfDtM.pas' {P289FPensioneUnjspfDtM: TDataModule},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TP289FPensioneUnjspf, P289FPensioneUnjspf);
  Application.CreateForm(TP289FPensioneUnjspfDtM, P289FPensioneUnjspfDtM);
  Application.Run;
end.
