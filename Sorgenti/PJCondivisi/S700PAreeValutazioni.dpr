program S700PAreeValutazioni;

uses
  Forms,
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  S700UAreeValutazioniDtM in 'S700UAreeValutazioniDtM.pas' {S700FAreeValutazioniDtM: TDataModule},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame},
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  S700UAreeValutazioni in 'S700UAreeValutazioni.pas' {S700FAreeValutazioni},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  S700UAreeValutazioniMW in '..\MWCondivisi\S700UAreeValutazioniMW.pas' {S700FAreeValutazioniMW: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TS700FAreeValutazioni, S700FAreeValutazioni);
  Application.CreateForm(TS700FAreeValutazioniDtM, S700FAreeValutazioniDtM);
  Application.Run;
end.
