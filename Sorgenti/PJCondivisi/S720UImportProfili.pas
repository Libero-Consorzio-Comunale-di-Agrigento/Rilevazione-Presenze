unit S720UImportProfili;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, StrUtils,
  Vcl.Samples.Spin, Vcl.ComCtrls, Vcl.ExtCtrls, A000UMessaggi,
  A000UInterfaccia, A083UMsgElaborazioni, C004UParamForm, C180FunzioniGenerali;

type
  TS720FImportProfili = class(TForm)
    Panel0: TPanel;
    lblAnno: TLabel;
    lblNomeFileInput: TLabel;
    lblSeparatore: TLabel;
    sbtNomeFileInput: TSpeedButton;
    edtAnno: TSpinEdit;
    edtNomeFileInput: TEdit;
    Panel2: TPanel;
    ProgressBar1: TProgressBar;
    StatusBar: TStatusBar;
    btnEsegui: TBitBtn;
    btnChiudi: TBitBtn;
    btnAnomalie: TBitBtn;
    edtSeparatore: TEdit;
    OpenDialog1: TOpenDialog;
    chkSoloControlli: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure sbtNomeFileInputClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnEseguiClick(Sender: TObject);
    procedure chkSoloControlliClick(Sender: TObject);
  private
    { Private declarations }
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure IniziaImport;
    procedure ImpostaStatusBar(Testo:String);
    procedure ImpostaProgressBar(RecTot:Integer);
    procedure AggiornaProgressBar;
    procedure TerminaImport;
  public
    { Public declarations }
    SL: Boolean;
  end;

var
  S720FImportProfili: TS720FImportProfili;

implementation

{$R *.dfm}

uses S720UProfiliAreeDtM;

procedure TS720FImportProfili.FormShow(Sender: TObject);
begin
  CreaC004(SessioneOracle,'S720',Parametri.ProgOper);
  GetParametriFunzione;
  btnAnomalie.Enabled:=False;
  with S720FProfiliAreeDtM.S720FProfiliAreeMW do
  begin
    evtIniziaImport:=IniziaImport;
    evtImpostaStatusBar:=ImpostaStatusBar;
    evtImpostaProgressBar:=ImpostaProgressBar;
    evtAggiornaProgressBar:=AggiornaProgressBar;
    evtTerminaImport:=TerminaImport;
  end;
  chkSoloControlliClick(nil);
end;

procedure TS720FImportProfili.GetParametriFunzione;
{Leggo i parametri della form}
begin
  edtAnno.Value:=StrToIntDef(C004FParamForm.GetParametro('edtAnno',''),S720FProfiliAreeDtM.S720FProfiliAreeMW.AnnoMinNuoviCodici);
  edtSeparatore.Text:=C004FParamForm.GetParametro('edtSeparatore',';');
  edtNomeFileInput.Text:=C004FParamForm.GetParametro('edtNomeFileInput','');
  chkSoloControlli.Checked:=C004FParamForm.GetParametro('chkSoloControlli','S') = 'S';
end;

procedure TS720FImportProfili.sbtNomeFileInputClick(Sender: TObject);
begin
  OpenDialog1.Title:='Nome file importazione profili';
  if edtNomeFileInput.Text <> '' then
    OpenDialog1.FileName:=edtNomeFileInput.Text;
  if OpenDialog1.Execute then
    edtNomeFileInput.Text:=OpenDialog1.FileName;
end;

procedure TS720FImportProfili.chkSoloControlliClick(Sender: TObject);
begin
  btnEsegui.Enabled:=not SL or chkSoloControlli.Checked;
end;

procedure TS720FImportProfili.btnAnomalieClick(Sender: TObject);
begin
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'S720','');
end;

procedure TS720FImportProfili.PutParametriFunzione;
{Scrivo i parametri della form}
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('edtAnno',IntToStr(edtAnno.Value));
  C004FParamForm.PutParametro('edtSeparatore',edtSeparatore.Text);
  C004FParamForm.PutParametro('edtNomeFileInput',edtNomeFileInput.Text);
  C004FParamForm.PutParametro('chkSoloControlli',IfThen(chkSoloControlli.Checked,'S','N'));
  try SessioneOracle.Commit; except end;
end;

procedure TS720FImportProfili.btnEseguiClick(Sender: TObject);
begin
  if not chkSoloControlli.Checked and (R180MessageBox(Format(A000MSG_S720_DLG_FMT_CONFERMA_IMP,[edtAnno.Text]),DOMANDA) = mrNo) then
    exit;
  btnAnomalie.Enabled:=False;
  S720FProfiliAreeDtM.S720FProfiliAreeMW.ImportProfili(chkSoloControlli.Checked,StrToIntDef(edtAnno.Text,0),edtSeparatore.Text,edtNomeFileInput.Text);
  btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA;
  if btnAnomalie.Enabled then
  begin
    if chkSoloControlli.Checked then
    begin
      if R180MessageBox(A000MSG_DLG_CTRL_ANOMALIE_VIS,DOMANDA) = mrYes then
        BtnAnomalieClick(nil);
    end
    else if R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,DOMANDA) = mrYes then
      BtnAnomalieClick(nil);
  end
  else
  begin
    if chkSoloControlli.Checked then
      R180MessageBox(A000MSG_MSG_CONTROLLO_TERMINATO,INFORMA)
    else
      R180MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA,INFORMA);
  end;
end;

procedure TS720FImportProfili.IniziaImport;
begin
  Screen.Cursor:=crHourGlass;
end;

procedure TS720FImportProfili.ImpostaStatusBar(Testo:String);
begin
  StatusBar.Panels[1].Text:=Testo;
  Application.ProcessMessages;
end;

procedure TS720FImportProfili.ImpostaProgressBar(RecTot:Integer);
begin
  ProgressBar1.Position:=0;
  ProgressBar1.Max:=RecTot;
  Application.ProcessMessages;
end;

procedure TS720FImportProfili.AggiornaProgressBar;
begin
  ProgressBar1.StepIt;
  Application.ProcessMessages;
end;

procedure TS720FImportProfili.TerminaImport;
begin
  StatusBar.Panels[1].Text:='';
  ProgressBar1.Position:=0;
  Application.ProcessMessages;
  Screen.Cursor:=crDefault;
end;

procedure TS720FImportProfili.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

end.
