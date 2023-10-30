unit WR003UGestRichiesteFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR002URichiesteFM,
  MedpUnimPanelHeaderDett, MedpUnimPanelListaElem, MedpUnimPanelNumElem,
  MedpUnimPanelDataDaA, MedpUnimRadioGroup, uniPanel, uniPageControl,
  unimTabPanel, MedpUnimTabPanelBase, uniGUIBaseClasses, uniGUIClasses,
  uniGUImJSForm, MedpUnimPanelBase, uniButton, uniBitBtn, unimBitBtn, unimPanel,
  MedpUnimPanel2Button, A000UCostanti, WM000UMainModule,
  MedpUnimPanelListaDisclosure, MedpUnimPanelListaDettaglio, MedpUnimButton, StrUtils,
  MedpUnimMemo, uniEdit, unimEdit, MedpUnimEdit, uniFileUpload, unimFileUpload,
  uniLabel, unimLabel, MedpUnimLabel, MedpUnimPanel2Labels, uniCheckBox,
  unimCheckBox;

type
  TWR003FGestRichiesteFM = class(TWR002FRichiesteFM)
    tabNuovaRichiesta: TUnimTabSheet;
    pnlDatiNuovaRichiesta: TMedpUnimPanelBase;
    pnlEliminaRevoca: TMedpUnimPanel2Button;
    pnlOkAnnulla: TMedpUnimPanel2Button;
    btnDettModifica: TMedpUnimButton;

    procedure OnEliminaRichiestaClick(Sender: TObject);
    procedure OnRevocaRichiestaClick(Sender: TObject);
    procedure OnOkRichiestaClick(Sender: TObject);
    procedure OnAnnullaRichiestaClick(Sender: TObject);
    procedure UniFrameCreate(Sender: TObject); virtual;
    procedure OnNuovaRichiestaClick(Sender: TObject); virtual;
    procedure OnModificaRichiestaClick(Sender: TObject); virtual;
  private

  protected
    Operazione: String;

    procedure LoadCompleted; override;

    function AggiornaListaRichieste: TResCtrl; override;

    procedure OnConfermaEliminaRichiesta;
    function ControllaEliminaRichiesta: TResCtrl; virtual; abstract;
    procedure EliminaRichiesta; virtual; abstract;

    procedure OnConfermaRevocaRichiesta;
    function ControllaRevocaRichiesta: TResCtrl; virtual; abstract;
    procedure RevocaRichiesta; virtual; abstract;

    procedure OnConfermaAnnullaRichiesta;
    function ControllaAnnullaRichiesta: TResCtrl; virtual;
    procedure AnnullaRichiesta; virtual;

    procedure OnConfermaOkRichiesta;
    function ControllaOkRichiesta: TResCtrl; virtual; abstract;
    procedure OkRichiesta; virtual; abstract;

    function GetMsgOkRichiesta: String; virtual;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWR003FGestRichiesteFM.UniFrameCreate(Sender: TObject);
begin
  inherited;
  FAutorizzatore:=False;
  Operazione:='';
end;

procedure TWR003FGestRichiesteFM.LoadCompleted;
begin
  inherited;
  // ATTENZIONE!!!! AbilitazioneFunzione del UniFrameCreate non è ancora stato settato!!!!
  // -- valutare evento su set AbilitazioneFunzione!!!
  pnlNumRichieste.Icona.Visible:=AbilitazioneFunzione = 'S';
end;

function TWR003FGestRichiesteFM.AggiornaListaRichieste: TResCtrl;
begin
  Result.Clear;
  pnlListaRichieste.Clear;

  if Assigned(WR002RichiesteMW) then
  begin
    with WM000FMainModule do
      Result:=WR002RichiesteMW.AggiornaRichiesteSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin);

    if Result.Ok then
      while not WR002RichiesteMW.Eof do
      begin
        CreaPanelRichiesta;
        WR002RichiesteMW.Next;
      end;
  end
  else
    Result.Messaggio:='Errore: Oggetto WR002RichiesteMW non inizializzato, impossibile aggiornare la lista delle richieste';
end;

procedure TWR003FGestRichiesteFM.OnEliminaRichiestaClick(Sender: TObject);
var LModalResult: Integer;
begin
  LModalResult:=MessageDlg('Confermare l''eliminazione della richiesta visualizzata?', TMsgDlgType.mtConfirmation, mbYesNo);

  if LModalResult = mrYes then
    OnConfermaEliminaRichiesta;
end;

procedure TWR003FGestRichiesteFM.OnNuovaRichiestaClick(Sender: TObject);
begin
  Operazione:='I';
end;

procedure TWR003FGestRichiesteFM.OnModificaRichiestaClick(Sender: TObject);
begin
  Operazione:='M';
end;

procedure TWR003FGestRichiesteFM.OnConfermaEliminaRichiesta;
var
  LResCtrl: TResCtrl;
begin
  LResCtrl:=ControllaEliminaRichiesta;

  if LResCtrl.Ok then
    EliminaRichiesta
  else
    ShowMessage(LResCtrl.Messaggio);
end;

procedure TWR003FGestRichiesteFM.OnRevocaRichiestaClick(Sender: TObject);
var LModalResult: Integer;
begin
  LModalResult:=MessageDlg('Confermare la revoca della richiesta visualizzata?', TMsgDlgType.mtConfirmation, mbYesNo);

  if LModalResult = mrYes then
    OnConfermaRevocaRichiesta;
end;

procedure TWR003FGestRichiesteFM.OnConfermaRevocaRichiesta;
var
  LResCtrl: TResCtrl;
begin
  LResCtrl:=ControllaRevocaRichiesta;

  if LResCtrl.Ok then
    RevocaRichiesta
  else
    ShowMessage(LResCtrl.Messaggio);
end;

procedure TWR003FGestRichiesteFM.OnOkRichiestaClick(Sender: TObject);
var LModalResult: Integer;
begin
  LModalResult:=MessageDlg(GetMsgOkRichiesta, TMsgDlgType.mtConfirmation, mbYesNo);

  if LModalResult = mrYes then
    OnConfermaOkRichiesta;
end;

procedure TWR003FGestRichiesteFM.OnConfermaOkRichiesta;
var
  LResCtrl: TResCtrl;
begin
  LResCtrl:=ControllaOkRichiesta;

  if LResCtrl.Ok then
    OkRichiesta
  else
    ShowMessage(LResCtrl.Messaggio);
end;

procedure TWR003FGestRichiesteFM.OnAnnullaRichiestaClick(Sender: TObject);
var LModalResult: Integer;
    LMsg: String;
begin
  if Operazione = 'I' then
    LMsg:='Annullare la richiesta in fase di inserimento?'
  else if Operazione = 'M' then
    LMsg:='Annullare le modifiche applicate alla richiesta?';

  LModalResult:=MessageDlg(LMsg, TMsgDlgType.mtConfirmation, mbYesNo);

  if LModalResult = mrYes then
    OnConfermaAnnullaRichiesta;
end;

procedure TWR003FGestRichiesteFM.OnConfermaAnnullaRichiesta;
var
  LResCtrl: TResCtrl;
begin
  LResCtrl:=ControllaAnnullaRichiesta;

  if LResCtrl.Ok then
    AnnullaRichiesta
  else
    ShowMessage(LResCtrl.Messaggio);
end;

function TWR003FGestRichiesteFM.GetMsgOkRichiesta: String;
begin
  if Operazione = 'I' then
    Result:='Confermare l''inserimento della richiesta?'
  else if Operazione = 'M' then
    Result:='Confermare la modifica della richiesta?'
  else
    raise Exception.Create('Operazione non valida');
end;

function TWR003FGestRichiesteFM.ControllaAnnullaRichiesta: TResCtrl;
begin
  Result.Clear;
  Result.Ok:=True;
end;

procedure TWR003FGestRichiesteFM.AnnullaRichiesta;
begin
  Operazione:='';
  tpnlRichieste.First;
end;

initialization
  RegisterClass(TWR003FGestRichiesteFM);

end.
