program P690PStampaFondi;

uses
  Forms,
  P690UStampaFondi in 'P690UStampaFondi.pas' {P690FStampaFondi},
  R004UGESTSTORICODTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  P690UStampaFondiDtM in 'P690UStampaFondiDtM.pas' {P690FStampaFondiDtM: TDataModule},
  P690UStampa in 'P690UStampa.pas' {P690FStampa},
  R002UQREP in '..\Repositary\R002UQREP.pas' {R002FQRep},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  P690UStampaFondiMW in '..\MWCondivisi\P690UStampaFondiMW.pas' {P690FStampaFondiMW: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TP690FStampaFondi, P690FStampaFondi);
  Application.CreateForm(TP690FStampaFondiDtM, P690FStampaFondiDtM);
  Application.Run;
end.
