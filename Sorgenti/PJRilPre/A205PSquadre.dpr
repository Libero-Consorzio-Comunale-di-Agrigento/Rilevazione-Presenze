program A205PSquadre;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A205USquadre in 'A205USquadre.pas' {A205FSquadre},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A205USquadreDM in 'A205USquadreDM.pas' {A205FSquadreDM: TDataModule},
  A205USquadreMW in '..\MWRilPre\A205USquadreMW.pas' {A205FSquadreMW: TDataModule},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA205FSquadre, A205FSquadre);
  Application.CreateForm(TA205FSquadreDM, A205FSquadreDM);
  Application.Run;
end.
