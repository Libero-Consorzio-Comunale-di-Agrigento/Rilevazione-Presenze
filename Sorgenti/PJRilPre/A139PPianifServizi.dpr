program A139PPianifServizi;

uses
  Forms,
  A139UPianifServizi in 'A139UPianifServizi.pas' {A139FPianifServizi},
  R004UGESTSTORICODTM in '..\REPOSITARY\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  A139UPianifServiziDtm in 'A139UPianifServiziDtm.pas' {A139FPianifServiziDtm: TDataModule},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame},
  A139UCopiaServizi in 'A139UCopiaServizi.pas' {A139FCopiaServizi},
  R001UGESTTAB in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  A139UGestisciPattuglie in 'A139UGestisciPattuglie.pas' {A139FGestisciPattuglie},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R002UQREP in '..\Repositary\R002UQREP.pas' {R002FQRep},
  A139UStampaServizi in 'A139UStampaServizi.pas' {A139FStampaServizi},
  A139UGestisciApparati in 'A139UGestisciApparati.pas' {A139FGestisciApparati},
  A139UDialogStampa in 'A139UDialogStampa.pas' {A139FDialogStampa},
  A139UNoteServizi in 'A139UNoteServizi.pas' {A139FNoteServizi},
  A139UQuadroRiass in 'A139UQuadroRiass.pas' {A139FQuadroRiass};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA139FPianifServizi, A139FPianifServizi);
  Application.CreateForm(TA139FPianifServiziDtm, A139FPianifServiziDtm);
  Application.Run;
end.
