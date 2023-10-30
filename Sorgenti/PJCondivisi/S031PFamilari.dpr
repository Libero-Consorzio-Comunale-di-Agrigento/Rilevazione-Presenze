program S031PFamilari;

uses
  Forms,
  MidasLib,
  S031UFamiliari in 'S031UFamiliari.pas' {S031FFamiliari},
  S031UFamiliariDtM in 'S031UFamiliariDtM.pas' {S031FFamiliariDtM: TDataModule},
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  S031UFamiliariMW in '..\MWCondivisi\S031UFamiliariMW.pas' {S031FFamiliariMW: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule};

{$R *.RES}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  Application.Initialize;
  Application.CreateForm(TS031FFamiliari, S031FFamiliari);
  Application.CreateForm(TS031FFamiliariDtM, S031FFamiliariDtM);
  Application.Run;
end.
