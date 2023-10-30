program P680PMacrocategorieFondi;

uses
  Forms,
  R001UGESTTAB in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  P680UMacrocategorieFondi in 'P680UMacrocategorieFondi.pas' {P680FMacrocategorieFondi},
  R004UGESTSTORICODTM in '..\Repositary\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  P680UMacrocategorieFondiDtM in 'P680UMacrocategorieFondiDtM.pas' {P680FMacrocategorieFondiDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  P680UMacrocategorieFondiMW in '..\MWCondivisi\P680UMacrocategorieFondiMW.pas' {P680FMacrocategorieFondiMW: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TP680FMacrocategorieFondi, P680FMacrocategorieFondi);
  Application.CreateForm(TP680FMacrocategorieFondiDtM, P680FMacrocategorieFondiDtM);
  Application.Run;
end.
