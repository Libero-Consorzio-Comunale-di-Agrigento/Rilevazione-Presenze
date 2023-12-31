program A058PPianifTurni;

uses
  Forms,
  MidasLib,
  OracleMonitor,
  A000UInterfaccia,
  A058UPianifTurni in 'A058UPianifTurni.pas' {A058FPianifTurni},
  A058UPianifTurniDtm1 in 'A058UPianifTurniDtm1.pas' {A058FPianifTurniDtM1: TDataModule},
  A058UGrigliaPianif in 'A058UGrigliaPianif.pas' {A058FGrigliaPianif},
  A058UModPianif in 'A058UModPianif.pas' {A058FModPianif},
  A058UTabellone in 'A058UTabellone.pas' {A058FTabellone},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A058UDettaglioTipiOperatori in 'A058UDettaglioTipiOperatori.pas' {A058FDettaglioTipiOperatori},
  A058UDettaglioGiornata in 'A058UDettaglioGiornata.pas' {A058FDettaglioGiornata},
  A058UCoperturaSquadra in 'A058UCoperturaSquadra.pas' {A058FCoperturaSquadra},
  A058UCopiaPianificazione in 'A058UCopiaPianificazione.pas' {A058FCopiaPianificazione},
  A058UStampaAssenze in 'A058UStampaAssenze.pas' {A058FStampaAssenze},
  A058UValidaAssenze in 'A058UValidaAssenze.pas' {A058FValidaAssenze},
  R002UQREP in '..\Repositary\R002UQREP.pas' {R002FQRep},
  A058UStampaRiepTimb in 'A058UStampaRiepTimb.pas' {A058FStampaRiepTimb},
  A058UStampaRiepNote in 'A058UStampaRiepNote.pas' {A058FStampaRiepNote},
  A058ULegenda in 'A058ULegenda.pas' {A058FLegenda},
  InputPeriodo in '..\Componenti\InputPeriodo.pas' {frmInputPeriodo: TFrame};

{$R *.RES}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}
  Parametri.Applicazione:='RILPRE';
  Application.Initialize;
  Application.CreateForm(TA058FPianifTurni, A058FPianifTurni);
  Application.CreateForm(TA058FPianifTurniDtM1, A058FPianifTurniDtM1);
  Application.Run;
end.
