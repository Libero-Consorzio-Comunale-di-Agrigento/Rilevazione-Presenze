program P686PCalcoloFondi;

uses
  Forms,
  P686UCalcoloFondi in 'P686UCalcoloFondi.pas' {P686FCalcoloFondi},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  P686UCalcoloFondiDtM in 'P686UCalcoloFondiDtM.pas' {P686FCalcoloFondiDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  P686UCalcoloFondiMW in '..\MWCondivisi\P686UCalcoloFondiMW.pas' {P686FCalcoloFondiMW: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TP686FCalcoloFondi, P686FCalcoloFondi);
  Application.CreateForm(TP686FCalcoloFondiDtM, P686FCalcoloFondiDtM);
  Application.Run;
end.
