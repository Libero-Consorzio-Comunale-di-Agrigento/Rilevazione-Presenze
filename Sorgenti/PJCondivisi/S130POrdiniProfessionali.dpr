program S130POrdiniProfessionali;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  S130UOrdiniProfessionali in 'S130UOrdiniProfessionali.pas' {S130FOrdiniProfessionali},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  S130UOrdiniProfessionaliDtM in 'S130UOrdiniProfessionaliDtM.pas' {S130FOrdiniProfessionaliDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  S130UOrdiniProfessionaliMW in '..\MWCondivisi\S130UOrdiniProfessionaliMW.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TS130FOrdiniProfessionali, S130FOrdiniProfessionali);
  Application.CreateForm(TS130FOrdiniProfessionaliDtM, S130FOrdiniProfessionaliDtM);
  Application.Run;
end.
