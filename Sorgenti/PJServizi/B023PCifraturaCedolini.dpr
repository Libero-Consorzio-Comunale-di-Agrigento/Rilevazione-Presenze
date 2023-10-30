program B023PCifraturaCedolini;

uses
  Vcl.Forms,
  A000UInterfaccia,
  A000UCostanti,
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  B023UCifraturaCedoliniDtM in 'B023UCifraturaCedoliniDtM.pas' {B023FCifraturaCedoliniDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  C180FunzioniGenerali in '..\Copy\C180FunzioniGenerali.pas',
  B023UCifraturaCedoliniBase in 'B023UCifraturaCedoliniBase.pas' {B023FCifraturaCedoliniBase},
  B023UCifraturaCedoliniStandard in 'B023UCifraturaCedoliniStandard.pas' {B023FCifraturaCedoliniStandard},
  B023UCifraturaCedoliniFull in 'B023UCifraturaCedoliniFull.pas' {B023FCifraturaCedoliniFull};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  B023FCifraturaCedoliniDtM:=TB023FCifraturaCedoliniDtM.Create(nil);

  //Il main form è il primo che viene istanziato via CreateForm()
  if (Parametri.Operatore = A000UCostanti.I090MONDOEDP) then
  begin
    Application.CreateForm(TB023FCifraturaCedoliniFull, B023FCifraturaCedoliniFull);
    B023FCifraturaCedoliniDtM.CallerForm:=B023FCifraturaCedoliniFull;
  end
  else if not Parametri.ModificaDatiProtetti then
  begin
    R180MessageBox(A000MSG_B023_ERR_PRIVILEGI_INSUFF,ERRORE);
    B023FCifraturaCedoliniDtM.Free;
    Application.Terminate;
  end
  else
  begin
    Application.CreateForm(TB023FCifraturaCedoliniStandard, B023FCifraturaCedoliniStandard);
    B023FCifraturaCedoliniDtM.CallerForm:=B023FCifraturaCedoliniStandard;
  end;
  Application.Run;
end.
