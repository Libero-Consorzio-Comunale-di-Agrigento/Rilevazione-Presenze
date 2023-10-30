program A109PImmagini;

uses
  Forms,
  MidasLib,
  A109UImmagini in 'A109UImmagini.pas' {A109FImmagini},
  A109UImmaginiDtM in 'A109UImmaginiDtM.pas' {A109FImmaginiDtM: TDataModule},
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  R004UGESTSTORICODTM in '..\Repositary\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A109UImmaginiMW in '..\MWRilPre\A109UImmaginiMW.pas' {A109FimmaginiMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA109FImmagini, A109FImmagini);
  Application.CreateForm(TA109FImmaginiDtM, A109FImmaginiDtM);
  Application.Run;
end.
