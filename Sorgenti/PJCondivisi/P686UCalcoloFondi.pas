unit P686UCalcoloFondi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Math, StrUtils,
  Dialogs, StdCtrls, CheckLst, ExtCtrls, Buttons, Mask, C180FunzioniGenerali,
  A000UCostanti, A000USessione, A000UInterfaccia, C004UParamForm, A003UDataLavoroBis, ComCtrls,
  Menus, Oracle, OracleData, System.Diagnostics, A000UMessaggi;

type
  TP686FCalcoloFondi = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    clbFondi: TCheckListBox;
    edtDecorrenzaDa: TMaskEdit;
    edtDecorrenzaA: TMaskEdit;
    lblDecorrenzaDa: TLabel;
    lblDecorrenzaA: TLabel;
    btnDecorrenzaDa: TBitBtn;
    btnDecorrenzaA: TBitBtn;
    rgpStatoCedolini: TRadioGroup;
    edtDataMonit: TMaskEdit;
    lblDataMonit: TLabel;
    btnDataMonit: TBitBtn;
    btnEsegui: TBitBtn;
    btnChiudi: TBitBtn;
    lblFondi: TLabel;
    ProgressBar1: TProgressBar;
    StatusBar: TStatusBar;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    rgpModalitaCalcolo: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDecorrenzaDaClick(Sender: TObject);
    procedure btnDecorrenzaAClick(Sender: TObject);
    procedure btnDataMonitClick(Sender: TObject);
    procedure edtDecorrenzaDaExit(Sender: TObject);
    procedure edtDecorrenzaAExit(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure AvanzaProgressBar;
    procedure Selezionatutto1Click(Sender: TObject);
  private
    { Private declarations }
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ImpostaParametriElaborazione;
    procedure Elaborazioni;
    procedure AggiornaListaFondi;
  public
    { Public declarations }
  end;

var
  P686FCalcoloFondi: TP686FCalcoloFondi;

  procedure OpenP686CalcoloFondi;

implementation

uses P686UCalcoloFondiDtM;

{$R *.dfm}

procedure OpenP686CalcoloFondi;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenP686CalcoloFondi') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TP686FCalcoloFondi,P686FCalcoloFondi);
  with P686FCalcoloFondi do
    try
      P686FCalcoloFondiDtM:=TP686FCalcoloFondiDtM.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      P686FCalcoloFondiDtM.Free;
      Free;
    end;
end;

procedure TP686FCalcoloFondi.FormCreate(Sender: TObject);
begin
  A000SettaVariabiliAmbiente;
end;

procedure TP686FCalcoloFondi.FormShow(Sender: TObject);
begin
  CreaC004(SessioneOracle,'P686',Parametri.ProgOper);
  GetParametriFunzione;
  edtDataMonit.Text:=DateToStr(Parametri.DataLavoro);
  AggiornaListaFondi;
end;

procedure TP686FCalcoloFondi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TP686FCalcoloFondi.GetParametriFunzione;
{Leggo i parametri della form}
begin
  edtDecorrenzaDa.Text:=C004FParamForm.GetParametro('DECORRENZA_DA','01/01/' + IntToStr(R180Anno(Parametri.DataLavoro)));
  edtDecorrenzaA.Text:=C004FParamForm.GetParametro('DECORRENZA_A','31/12/' + IntToStr(R180Anno(Parametri.DataLavoro)));
end;

procedure TP686FCalcoloFondi.PutParametriFunzione;
{Scrivo i parametri della forma}
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('DECORRENZA_DA',edtDecorrenzaDa.Text);
  C004FParamForm.PutParametro('DECORRENZA_A',edtDecorrenzaA.Text);
  try SessioneOracle.Commit; except end;
end;

procedure TP686FCalcoloFondi.btnDecorrenzaDaClick(Sender: TObject);
begin
  edtDecorrenzaDa.Text:=DateToStr(DataOut(StrToDate(edtDecorrenzaDa.Text),'Dalla decorrenza','G'));
  edtDecorrenzaDaExit(nil);
end;

procedure TP686FCalcoloFondi.btnDecorrenzaAClick(Sender: TObject);
begin
  edtDecorrenzaA.Text:=DateToStr(DataOut(StrToDate(edtDecorrenzaA.Text),'Alla scadenza','G'));
  edtDecorrenzaAExit(nil);
end;

procedure TP686FCalcoloFondi.btnDataMonitClick(Sender: TObject);
begin
  edtDataMonit.Text:=DateToStr(DataOut(StrToDate(edtDataMonit.Text),'Data monitoraggio','G'));
end;

procedure TP686FCalcoloFondi.edtDecorrenzaDaExit(Sender: TObject);
begin
  AggiornaListaFondi;
end;

procedure TP686FCalcoloFondi.edtDecorrenzaAExit(Sender: TObject);
begin
  AggiornaListaFondi;
end;

procedure TP686FCalcoloFondi.btnEseguiClick(Sender: TObject);
var LStopwatch: TStopwatch;
begin
  ImpostaParametriElaborazione;
  try
    P686FCalcoloFondiDtm.P686FCalcoloFondiMW.Controlli;
    // avvio timer di precisione
    LStopWatch:=TStopwatch.StartNew;
    try
      Elaborazioni;
    finally
      ProgressBar1.Position:=0;
      // stop timer di precisione
      LStopWatch.Stop;
      StatusBar.Panels[0].Text:='Tempo di esecuzione: ' + FormatDateTime(FMT_DURATA_ELABORAZIONE,LStopWatch.ElapsedMilliseconds / MSecsPerDay);
      StatusBar.Repaint;
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
  if P686FCalcoloFondiDtm.P686FCalcoloFondiMW.MsgErrore <> '' then
    R180MessageBox(P686FCalcoloFondiDtm.P686FCalcoloFondiMW.MsgErrore,'ERRORE')
  else
    R180MessageBox(A000MSG_MSG_ELAB_TERMINATA_OK,'INFORMA');
end;

procedure TP686FCalcoloFondi.ImpostaParametriElaborazione;
var i:Integer;
begin
  with P686FCalcoloFondiDtm.P686FCalcoloFondiMW.ParametriElaborazione do
  begin
    dDecorrenzaDa:=StrToDate(edtDecorrenzaDa.Text);
    dDecorrenzaA:=StrToDate(edtDecorrenzaA.Text);
    dDataMonit:=StrToDate(edtDataMonit.Text);
    iModalitaCalcolo:=rgpModalitaCalcolo.ItemIndex;
    iStatoCedolini:=rgpStatoCedolini.ItemIndex;
    lstFondi.Clear;
    for i:=0 to clbFondi.Count - 1 do
      if clbFondi.Checked[i] then
        lstFondi.Add(Trim(Copy(clbFondi.Items[i],1,Pos('-',clbFondi.Items[i])-1)));
  end;
end;

procedure TP686FCalcoloFondi.Elaborazioni;
var i:Integer;
begin
  Screen.Cursor:=crHourGlass;
  StatusBar.Panels[0].Text:='';
  with P686FCalcoloFondiDtM.P686FCalcoloFondiMW do
  begin
    MsgErrore:='';
    Inizializzazioni;
    ProgressBar1.Max:=StrToIntDef(VarToStr(selP688Conta.Field(0)),0);
    ProgressBar1.Position:=0;
    try
      for i:=0 to ParametriElaborazione.lstFondi.Count - 1 do
      begin
        StatusBar.Panels[0].Text:='Elaborazione fondo ' + ParametriElaborazione.lstFondi.Strings[i] + ' in corso...';
        StatusBar.Repaint;
        ElaboraFondo(ParametriElaborazione.lstFondi.Strings[i]);
      end;
    except
      on E:exception do
      begin
        SessioneOracle.Rollback;
        MsgErrore:='Elaborazione fallita:' + E.Message;
      end;
    end;
  end;
end;

procedure TP686FCalcoloFondi.AggiornaListaFondi;
begin
  with P686FCalcoloFondiDtM.P686FCalcoloFondiMW do
  begin
    if LetturaFondi(edtDecorrenzaDa.Text,edtDecorrenzaA.Text) then
    begin
      clbFondi.Items.Clear;
      while not selP684.Eof do
      begin
        clbFondi.Items.Add(selP684.FieldByName('COD_FONDO').AsString + ' - ' +
          selP684.FieldByName('DESCRIZIONE').AsString);
        selP684.Next;
      end;
    end;
  end;
end;

procedure TP686FCalcoloFondi.AvanzaProgressBar;
begin
  ProgressBar1.StepBy(1);
  Application.ProcessMessages;
end;

procedure TP686FCalcoloFondi.Selezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  clbFondi.SetFocus;
  for i:=0 to clbFondi.Items.Count - 1 do
    if Sender = SelezionaTutto1 then
      clbFondi.Checked[i]:=True
    else if Sender = DeselezionaTutto1 then
      clbFondi.Checked[i]:=False
    else if Sender = InvertiSelezione1 then
      clbFondi.Checked[i]:=not clbFondi.Checked[i];
end;

end.
