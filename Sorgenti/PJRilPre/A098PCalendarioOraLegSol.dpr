program A098PCalendarioOraLegSol;

uses
  Vcl.Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A098UCalendarioOraLegSol in 'A098UCalendarioOraLegSol.pas' {A098FCalendarioOraLegSol},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A098UCalendarioOraLegSolDtm in 'A098UCalendarioOraLegSolDtm.pas' {A098FCalendarioOraLegSolDtm: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A098UCalendarioOraLegSolMW in '..\MWRilPre\A098UCalendarioOraLegSolMW.pas' {A098FCalendarioOraLegSolMW: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA098FCalendarioOraLegSolDtm, A098FCalendarioOraLegSolDtm);
  Application.CreateForm(TA098FCalendarioOraLegSol, A098FCalendarioOraLegSol);
  Application.Run;
end.
