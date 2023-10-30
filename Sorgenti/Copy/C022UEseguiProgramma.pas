unit C022UEseguiProgramma;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, C180FunzioniGenerali;

type
  TC022FEseguiProgramma = class(TForm)
    pnlHeader: TPanel;
    pnlHeaderLabel: TPanel;
    pnlHeaderCmdLine: TPanel;
    lblStato: TLabel;
    lblInEsecuzione: TLabel;
    spltSplitter: TSplitter;
    pnlContainer: TPanel;
    tmrStart: TTimer;
    pnlGridMain: TGridPanel;
    pnlGridOutput: TGridPanel;
    pnlGridError: TGridPanel;
    pnlOutputLabel: TPanel;
    memOutput: TMemo;
    pnlErrorLabel: TPanel;
    memError: TMemo;
    procedure FormShow(Sender: TObject);
    procedure tmrStartTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    InEsecuzione:Boolean;
    procedure AggiornaOutput(DettagliEsecuzione:T180SyncProcessExecResults);
  public
    PathProgramma, DirProgramma, Argomenti:String;
    ChiudiAlTermine:Boolean;
    sperSyncProcessExecResults:T180SyncProcessExecResults;
  end;

var
  C022FEseguiProgramma: TC022FEseguiProgramma;
  function C022EseguiProgramma(const PathProgramma, DirProgramma, Argomenti: String;
                               const TitoloFinestra:String='';
                               const ChiudiAlTermine:Boolean=false;
                               const MostraHeader:Boolean=true):T180SyncProcessExecResults;

implementation

resourcestring
  C022_IN_ESEC='In esecuzione';
  C022_TERMINATO='Terminato';

function C022EseguiProgramma(const PathProgramma, DirProgramma, Argomenti: String;
                             const TitoloFinestra:String='';
                             const ChiudiAlTermine:Boolean=false;
                             const MostraHeader:Boolean=true):T180SyncProcessExecResults;
begin
  C022FEseguiProgramma:=TC022FEseguiProgramma.Create(nil);
  try
    C022FEseguiProgramma.PathProgramma:=PathProgramma;
    C022FEseguiProgramma.DirProgramma:=DirProgramma;
    C022FEseguiProgramma.Argomenti:=Argomenti;

    if not MostraHeader then
      C022FEseguiProgramma.pnlHeader.Visible:=false
    else
      C022FEseguiProgramma.lblInEsecuzione.Caption:=ExtractFileName(PathProgramma) + ' ' + Argomenti;

    if TitoloFinestra <> '' then
      C022FEseguiProgramma.Caption:='<C022> ' + TitoloFinestra;
    C022FEseguiProgramma.ChiudiAlTermine:=ChiudiAlTermine;

    C022FEseguiProgramma.ShowModal;
    Result:=C022FEseguiProgramma.sperSyncProcessExecResults;
  finally
    FreeAndNil(C022FEseguiProgramma);
  end;

end;

{$R *.dfm}

procedure TC022FEseguiProgramma.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if InEsecuzione then
    Action:=caNone;
end;

procedure TC022FEseguiProgramma.FormShow(Sender: TObject);
begin
  lblStato.Caption:=C022_IN_ESEC;
  InEsecuzione:=true;
end;

procedure TC022FEseguiProgramma.tmrStartTimer(Sender: TObject);
begin
  tmrStart.Enabled:=false;
  Application.ProcessMessages;
  sperSyncProcessExecResults:=R180SyncProcessExec(PathProgramma,DirProgramma,Argomenti,AggiornaOutput);
  InEsecuzione:=false;
  lblStato.Caption:=C022_TERMINATO + ' (' + IntToStr(sperSyncProcessExecResults.CodiceUscita) + ')';
  if ChiudiAlTermine then
    Close;
end;

procedure TC022FEseguiProgramma.AggiornaOutput(DettagliEsecuzione:T180SyncProcessExecResults);
begin
  // STDOUT
  memOutput.Text:=DettagliEsecuzione.DatiStdOut;
  // Posiziono il cursore all'ultimo carattere
  memOutput.SelLength:=0;
  memOutput.SelStart:=Length(memOutput.Text);

  // STDERR
  memError.Text:=DettagliEsecuzione.DatiStdErr;
  memError.SelLength:=0;
  memError.SelStart:=Length(memError.Text);

  Application.ProcessMessages;
end;

end.
