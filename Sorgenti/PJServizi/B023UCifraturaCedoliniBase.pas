unit B023UCifraturaCedoliniBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.Samples.Spin, A000UInterfaccia, A083UMsgElaborazioni, A000UMessaggi,
  C180FunzioniGenerali;

type
  TB023FCifraturaCedoliniBase = class(TForm)
    pnlBottom: TPanel;
    prbProgress: TProgressBar;
    StatusBar: TStatusBar;
    btnEsegui: TBitBtn;
    btnChiudi: TBitBtn;
    btnAnomalie: TBitBtn;
    pnlMain: TPanel;
    btnDisattivaElaborazioni: TBitBtn;
    procedure FormDestroy(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject); virtual;
    procedure btnDisattivaElaborazioniClick(Sender: TObject); virtual;
  private
    { Private declarations }
  public
    procedure SetProgressBarMaxValue(MaxValue:Integer);
    procedure StepItProgressBar;
    procedure ResetProgressBar;
    procedure SetStatusText(InfoText:String);
    procedure AbilitaComponenti(Abilita:Boolean); virtual; abstract;
  end;

var
  B023FCifraturaCedoliniBase: TB023FCifraturaCedoliniBase;

implementation

uses B023UCifraturaCedoliniDtM;

{$R *.DFM}

procedure TB023FCifraturaCedoliniBase.SetProgressBarMaxValue(MaxValue:Integer);
begin
  prbProgress.Max:=MaxValue;
end;

procedure TB023FCifraturaCedoliniBase.StepItProgressBar;
begin
  prbProgress.StepIt;
end;

procedure TB023FCifraturaCedoliniBase.btnAnomalieClick(Sender: TObject);
begin
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'B023','');
end;

procedure TB023FCifraturaCedoliniBase.btnDisattivaElaborazioniClick(
  Sender: TObject);
begin
  if R180MessageBox(A000MSG_B023_DLG_INTERR_ELAB,DOMANDA) = mrYes then
    B023FCifraturaCedoliniDtM.InterrompiElaborazione:=true;
end;

procedure TB023FCifraturaCedoliniBase.btnEseguiClick(Sender: TObject);
begin
  // Post elaborazione
  Application.ProcessMessages;
  if B023FCifraturaCedoliniDtM.PresenzaAnomalie then
  begin
    if R180MessageBox(A000MSG_B023_DLG_ELAB_ANOM,DOMANDA) = mrYes then
      btnAnomalieClick(nil);
  end
  else if B023FCifraturaCedoliniDtM.OperazioneAnnullata then
    R180MessageBox(A000MSG_B023_MSG_ELAB_ABORT,INFORMA)
  else
    R180MessageBox(A000MSG_B023_MSG_ELAB_OK,INFORMA)
end;

procedure TB023FCifraturaCedoliniBase.FormDestroy(Sender: TObject);
begin
  B023FCifraturaCedoliniDtM.Free;
end;

procedure TB023FCifraturaCedoliniBase.ResetProgressBar;
begin
  prbProgress.Position:=0;
end;

procedure TB023FCifraturaCedoliniBase.SetStatusText(InfoText:String);
begin
  StatusBar.Panels[0].Text:=InfoText;
end;

end.
