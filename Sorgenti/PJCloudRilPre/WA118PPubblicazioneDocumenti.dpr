program WA118PPubblicazioneDocumenti;

uses
  Forms,
  IWStart,
  UTF8ContentParser,
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000FInterfaccia: TIWServerControllerBase},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WR103UGestMasterDetail in '..\Repositary\WR103UGestMasterDetail.pas' {WR103FGestMasterDetail: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR203UGestDetailFM in '..\Repositary\WR203UGestDetailFM.pas' {WR203FGestDetailFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WR303UGestMasterDetailDM in '..\Repositary\WR303UGestMasterDetailDM.pas' {WR303FGestMasterDetailDM: TIWUserSessionBase},
  A118UPubblicazioneDocumentiMW in '..\MWRilPre\A118UPubblicazioneDocumentiMW.pas' {A118FPubblicazioneDocumentiMW: TDataModule},
  WA118ULogin in 'WA118ULogin.pas' {WA118FLogin: TIWAppForm},
  WA118UPubblicazioneDocumentiDM in 'WA118UPubblicazioneDocumentiDM.pas' {WA118FPubblicazioneDocumentiDM: TIWUserSessionBase},
  WA118UPubblicazioneDocumenti in 'WA118UPubblicazioneDocumenti.pas' {WA118FPubblicazioneDocumenti: TIWAppForm},
  WA118UPubblicazioneDocumentiBrowseFM in 'WA118UPubblicazioneDocumentiBrowseFM.pas' {WA118FPubblicazioneDocumentiBrowseFM: TFrame},
  WA118UPubblicazioneDocumentiDettFM in 'WA118UPubblicazioneDocumentiDettFM.pas' {WA118FPubblicazioneDocumentiDettFM: TFrame},
  WA118ULivelliFM in 'WA118ULivelliFM.pas' {WA118FLivelliFM: TFrame};

{$R *.res}

begin
  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown:=True;
  {$ENDIF DEBUG}

  TIWStart.Execute(True);
end.
