program WA014PDebitiAggiuntivi;

uses
  IWStart,
  UTF8ContentParser,
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  WR100UBase in '..\Repositary\WR100UBase.pas' {WR100FBase: TIWAppForm},
  WR101ULogin in '..\Repositary\WR101ULogin.pas' {WR101FLogin: TIWAppForm},
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  WR204UBrowseTabellaFM in '..\Repositary\WR204UBrowseTabellaFM.pas' {WR204FBrowseTabellaFM: TFrame},
  WR205UDettTabellaFM in '..\Repositary\WR205UDettTabellaFM.pas' {WR205FDettTabellaFM: TFrame},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WR302UGestTabellaDM in '..\Repositary\WR302UGestTabellaDM.pas' {WR302FGestTabellaDM: TIWUserSessionBase},
  WA014UDebitiAggiuntivi in 'WA014UDebitiAggiuntivi.pas' {WA014FDebitiAggiuntivi: TIWAppForm},
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000ServerController: TIWServerControllerBase},
  WA014ULogin in 'WA014ULogin.pas' {WA014FLogin: TIWAppForm},
  WA014UDebitiAggiuntiviDM in 'WA014UDebitiAggiuntiviDM.pas' {WA014FDebitiAggiuntiviDM: TIWUserSessionBase},
  WC003URicercaDatiFM in '..\Copy\WC003URicercaDatiFM.pas' {WC003FRicercaDatiFM: TFrame},
  WC004UEstrazioneDatiFM in '..\Copy\WC004UEstrazioneDatiFM.pas' {WC004FEstrazioneDatiFM: TFrame},
  WA014UDebitiAggiuntiviBrowseFM in 'WA014UDebitiAggiuntiviBrowseFM.pas' {WA014FDebitiAggiuntiviBrowseFM: TFrame},
  WR102UGestTabella in '..\Repositary\WR102UGestTabella.pas' {WR102FGestTabella: TIWAppForm},
  WA014UDebitiAggiuntiviDettFM in 'WA014UDebitiAggiuntiviDettFM.pas' {WA014FDebitiAggiuntiviDettFM: TFrame},
  WC015USelEditGridFM in '..\Copy\WC015USelEditGridFM.pas' {WC015FSelEditGridFM: TFrame},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(True);
end.
