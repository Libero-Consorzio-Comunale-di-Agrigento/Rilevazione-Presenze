program B009PPuntoInformativo;

uses
  Forms,
  HtmlHelpViewer,
  MidasLib,
  A000UInterfaccia,
  B009UPuntoInformativo in 'B009UPuntoInformativo.pas' {B009FPuntoInformativo},
  R004UGestStoricoDTM in '..\REPOSITARY\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  B009UPuntoInformativoDtM1 in 'B009UPuntoInformativoDtM1.pas' {B009FPuntoInformativoDtM1: TDataModule},
  B009UDialogBox in 'B009UDialogBox.pas' {B009FDialogBox},
  B009UAnteprima in 'B009UAnteprima.pas' {B009FAnteprima},
  B009UImpostazioniBadge in 'B009UImpostazioniBadge.pas' {B009FImpostazioniBadge};

{$R *.RES}

begin
  Application.Initialize;
  Parametri.Applicazione:='PINFO';
  Application.Title := 'Punto Informativo';
  Application.CreateForm(TB009FPuntoInformativo, B009FPuntoInformativo);
  Application.CreateForm(TB009FPuntoInformativoDtM1, B009FPuntoInformativoDtM1);
  Application.Run;
end.


