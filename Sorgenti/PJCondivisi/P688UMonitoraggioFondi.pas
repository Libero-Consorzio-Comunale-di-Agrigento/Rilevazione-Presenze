unit P688UMonitoraggioFondi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, ExtCtrls, Buttons, Mask, C180FunzioniGenerali,
  A000UCostanti, A000USessione, A000UInterfaccia, C004UParamForm, A003UDataLavoroBis, Clipbrd,
  Menus, Data.DB, A000UMessaggi;

type
  TP688FMonitoraggioFondi = class(TForm)
    Panel3: TPanel;
    Panel1: TPanel;
    lblDecorrenzaDa: TLabel;
    lblDecorrenzaA: TLabel;
    edtDecorrenzaDa: TMaskEdit;
    edtDecorrenzaA: TMaskEdit;
    btnDecorrenzaDa: TBitBtn;
    btnDecorrenzaA: TBitBtn;
    dgrdDettaglio: TDBGrid;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    MenuItem1: TMenuItem;
    Copia2: TMenuItem;
    CopiaInExcel: TMenuItem;
    Panel2: TPanel;
    rgpTipoTotalizzazione: TRadioGroup;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDecorrenzaDaClick(Sender: TObject);
    procedure btnDecorrenzaAClick(Sender: TObject);
    procedure edtDecorrenzaDaExit(Sender: TObject);
    procedure edtDecorrenzaAExit(Sender: TObject);
    procedure rgpTipoTotalizzazioneClick(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure Copia2Click(Sender: TObject);
  private
    { Private declarations }
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure Aggiorna;
  public
    { Public declarations }
  end;

var
  P688FMonitoraggioFondi: TP688FMonitoraggioFondi;

  procedure OpenP688MonitoraggioFondi;

implementation

uses P688UMonitoraggioFondiDtM;

{$R *.dfm}

procedure OpenP688MonitoraggioFondi;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenP688MonitoraggioFondi') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TP688FMonitoraggioFondi,P688FMonitoraggioFondi);
  with P688FMonitoraggioFondi do
    try
      P688FMonitoraggioFondiDtM:=TP688FMonitoraggioFondiDtM.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      P688FMonitoraggioFondiDtM.Free;
      Free;
    end;
end;

procedure TP688FMonitoraggioFondi.FormShow(Sender: TObject);
begin
  CreaC004(SessioneOracle,'P688',Parametri.ProgOper);
  GetParametriFunzione;
  Aggiorna;
end;

procedure TP688FMonitoraggioFondi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TP688FMonitoraggioFondi.GetParametriFunzione;
{Leggo i parametri della form}
begin
  edtDecorrenzaDa.Text:=C004FParamForm.GetParametro('DECORRENZA_DA','01/01/' + IntToStr(R180Anno(Parametri.DataLavoro)));
  edtDecorrenzaA.Text:=C004FParamForm.GetParametro('DECORRENZA_A','31/12/' + IntToStr(R180Anno(Parametri.DataLavoro)));
end;

procedure TP688FMonitoraggioFondi.PutParametriFunzione;
{Scrivo i parametri della forma}
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('DECORRENZA_DA',edtDecorrenzaDa.Text);
  C004FParamForm.PutParametro('DECORRENZA_A',edtDecorrenzaA.Text);
  try SessioneOracle.Commit; except end;
end;

procedure TP688FMonitoraggioFondi.btnDecorrenzaDaClick(Sender: TObject);
begin
  edtDecorrenzaDa.Text:=DateToStr(DataOut(StrToDate(edtDecorrenzaDa.Text),'Dalla decorrenza','G'));
end;

procedure TP688FMonitoraggioFondi.btnDecorrenzaAClick(Sender: TObject);
begin
  edtDecorrenzaA.Text:=DateToStr(DataOut(StrToDate(edtDecorrenzaA.Text),'Alla scadenza','G'));
end;

procedure TP688FMonitoraggioFondi.edtDecorrenzaDaExit(Sender: TObject);
begin
  if StrToDate(edtDecorrenzaA.Text) < StrToDate(edtDecorrenzaDa.Text) then
  begin
    edtDecorrenzaDa.SetFocus;
    raise exception.Create(A000MSG_ERR_DECORR_NON_SUCC_SCAD);
  end;
  Aggiorna;
end;

procedure TP688FMonitoraggioFondi.edtDecorrenzaAExit(Sender: TObject);
begin
  if StrToDate(edtDecorrenzaA.Text) < StrToDate(edtDecorrenzaDa.Text) then
  begin
    edtDecorrenzaA.SetFocus;
    raise exception.Create(A000MSG_ERR_DECORR_NON_SUCC_SCAD);
  end;
  Aggiorna;
end;

procedure TP688FMonitoraggioFondi.rgpTipoTotalizzazioneClick(Sender: TObject);
begin
  Aggiorna;
end;

procedure TP688FMonitoraggioFondi.Selezionatutto1Click(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dgrdDettaglio,'S');
end;

procedure TP688FMonitoraggioFondi.Deselezionatutto1Click(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dgrdDettaglio,'N');
end;

procedure TP688FMonitoraggioFondi.Invertiselezione1Click(Sender: TObject);
begin
  R180DBGridSelezionaRighe(dgrdDettaglio,'C');
end;

procedure TP688FMonitoraggioFondi.Copia2Click(Sender: TObject);
var S:String;
  i:Integer;
begin
  with dgrdDettaglio.DataSource.DataSet do
  begin
    if not Active then
      exit;
    S:='';
    Clipboard.Clear;
    DisableControls;
    Screen.Cursor:=crHourGlass;
    First;
    try
      if not EOF then
      begin
        for i:=0 to FieldCount - 1 do
          if Fields[i].Visible then
            S:=S + Fields[i].DisplayLabel + #9;
        S:=S + #13#10;
      end;
      while not EOF do
      begin
        if dgrdDettaglio.SelectedRows.CurrentRowSelected then
        begin
          for i:=0 to FieldCount - 1 do
            if Fields[i].Visible then
              S:=S + Fields[i].AsString + #9;
          S:=S + #13#10;
        end;
        Next;
      end;
    finally
      First;
      EnableControls;
      Screen.Cursor:=crDefault;
    end;
  end;
  Clipboard.AsText:=S;
end;

procedure TP688FMonitoraggioFondi.Aggiorna;
begin
  screen.Cursor:=crHourglass;
  P688FMonitoraggioFondiDtM.P688FMonitoraggioFondiMW.LetturaFondi(edtDecorrenzaDa.Text,edtDecorrenzaA.Text,rgpTipoTotalizzazione.ItemIndex);
  screen.Cursor:=crDefault;
end;

end.
