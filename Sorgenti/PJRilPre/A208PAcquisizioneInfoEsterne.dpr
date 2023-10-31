program A208PAcquisizioneInfoEsterne;

uses
  Forms,
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R001UGESTTAB in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  R002UQREP in '..\Repositary\R002UQREP.pas' {R002FQRep},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A208UAcquisizioneInfoEsterneMW in '..\MWRilPre\A208UAcquisizioneInfoEsterneMW.pas' {A208FAcquisizioneInfoEsterneMW: TDataModule},
  A208UVisualizzazioneFileInfoEsterne in 'A208UVisualizzazioneFileInfoEsterne.pas' {A208FVisualizzazioneFileInfoEsterne},
  A208UAcquisizioneInfoEsterneDM in 'A208UAcquisizioneInfoEsterneDM.pas' {A208FAcquisizioneInfoEsterneDM: TDataModule},
  A208UAcquisizioneInfoEsterne in 'A208UAcquisizioneInfoEsterne.pas' {A208FAcquisizioneInfoEsterne};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA208FAcquisizioneInfoEsterne, A208FAcquisizioneInfoEsterne);
  Application.CreateForm(TA208FAcquisizioneInfoEsterneDM, A208FAcquisizioneInfoEsterneDM);
  Application.Run;
end.
