program A178PPianifPersConv;

uses
  Forms,
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A178UPianifPersConvDtM in 'A178UPianifPersConvDtM.pas' {A178FPianifPersConvDtM: TDataModule},
  A178UPianifPersConv in 'A178UPianifPersConv.pas' {A178FPianifPersConv},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A178UPianifPersConvMW in '..\MWRilPre\A178UPianifPersConvMW.pas' {A178FPianifPersConvMW: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA178FPianifPersConv, A178FPianifPersConv);
  Application.CreateForm(TA178FPianifPersConvDtM, A178FPianifPersConvDtM);
  Application.Run;
end.
