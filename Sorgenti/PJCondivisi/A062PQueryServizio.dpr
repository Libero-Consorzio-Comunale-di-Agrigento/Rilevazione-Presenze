program A062PQueryServizio;

uses
  Forms,
  OracleMonitor,
  A062UQueryServizio in 'A062UQueryServizio.pas' {A062FQueryServizio},
  A062UQueryServizioDtM1 in 'A062UQueryServizioDtM1.pas' {A062FQueryServizioDtM1: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A062UAccessoDB in 'A062UAccessoDB.pas' {A062FAccessoDB},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A062UQueryServizioMW in '..\MWCondivisi\A062UQueryServizioMW.pas' {A062FQueryServizioMW: TDataModule}
 {$IFDEF ISO},
  Q062UAllegati in '..\PJIso9001\Q062UAllegati.pas' {Q062FAllegati},
  Q062UEMail in '..\PJIso9001\Q062UEMail.pas' {Q062FEMail}
  {$ENDIF}
  ;

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA062FQueryServizio, A062FQueryServizio);
  Application.CreateForm(TA062FQueryServizioDtM1, A062FQueryServizioDtM1);
  Application.CreateForm(TA062FAccessoDB, A062FAccessoDB);
  Application.Run;
end.
