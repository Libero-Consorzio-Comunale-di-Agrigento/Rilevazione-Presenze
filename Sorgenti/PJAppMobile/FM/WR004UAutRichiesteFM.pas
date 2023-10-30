unit WR004UAutRichiesteFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR002URichiesteFM,
  MedpUnimPanelHeaderDett, MedpUnimPanelListaElem, MedpUnimPanelNumElem,
  MedpUnimPanelDataDaA, MedpUnimRadioGroup, uniPanel, uniPageControl,
  unimTabPanel, MedpUnimTabPanelBase, uniGUIBaseClasses, uniGUIClasses,
  uniGUImJSForm, unimPanel, MedpUnimPanelBase, uniLabel, unimLabel,
  MedpUnimLabel, MedpUnimPanel2Button, A000UCostanti, WR002URichiesteMW, WM010UAutTimbratureMW, WM000UMainModule,
  MedpUnimPanel2Labels, MedpUnimTypes, MedpUnimPanelListaDisclosure,
  MedpUnimPanelListaDettaglio, MedpUnimPanelSlideUp, uniCheckBox, unimCheckBox,
  MedpUnimMemo, uniFileUpload, unimFileUpload, uniEdit, unimEdit, MedpUnimEdit;

type
  TWR004FAutRichiesteFM = class(TWR002FRichiesteFM)
    pnlAutorizzazione: TMedpUnimPanelBase;
    lblLivello: TMedpUnimLabel;
    pnlAutorizzaNega: TMedpUnimPanel2Button;
    pnlAutorizzaTutti: TMedpUnimPanelSlideUp;
    pnlAutorizzaNegaTutti: TMedpUnimPanel2Button;
    procedure UniFrameCreate(Sender: TObject); virtual;
    procedure btnAutorizzaClick(Sender: TObject);
    procedure btnNegaClick(Sender: TObject);
    procedure btnAutorizzaTuttiClick(Sender: TObject);
    procedure btnNegaTuttiClick(Sender: TObject);
  private
    procedure CreaHeaderRichieste;
    procedure ImpostaAutorizzazione(const PAutorizzazione: String);
    procedure AutorizzaTutti(const PAutorizzazione: String);
  protected
    FAutorizzaTuttiDisponibile: Boolean;
    function AggiornaListaRichieste: TResCtrl; override;
    procedure ImpostaPannelloAutorizzazione;
    procedure OnChangeAbilitaFunzioneProc(Sender: TObject);
    function GetMsgAutorizza(Aut: String): String; virtual;
    function GetMsgAutorizzaTutti(Aut: String): String; virtual;
    function GetMsgAutorizzato(Aut: String): String; virtual;
    function GetMsgAutorizzatoTutti(Aut: String): String; virtual;
  end;

implementation

{$R *.dfm}


{ TWR004FAutRichiesteFM }

procedure TWR004FAutRichiesteFM.UniFrameCreate(Sender: TObject);
begin
  inherited;
  FAutorizzatore:=True;
end;

function TWR004FAutRichiesteFM.AggiornaListaRichieste: TResCtrl;
var LOldNominativo: String;
begin
  pnlListaRichieste.Clear;

  if Assigned(WR002RichiesteMW) then
  begin
    LOldNominativo:='';

    with WM000FMainModule do
      Result:=WR002RichiesteMW.AggiornaRichiesteSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin);

    if Result.Ok then
    begin
      while not WR002RichiesteMW.Eof do
      begin
        if LOldNominativo <> WR002RichiesteMW.Nominativo then
          CreaHeaderRichieste;

        CreaPanelRichiesta;

        LOldNominativo:=WR002RichiesteMW.Nominativo;
        WR002RichiesteMW.Next;
      end;
      ImpostaPannelloAutorizzazione;
    end;
  end
  else
  begin
    Result.Ok:=False;
    Result.Messaggio:='Errore: Oggetto WR002RichiesteMW non inizializzato, impossibile aggiornare la lista delle richieste';
  end;
end;

procedure TWR004FAutRichiesteFM.CreaHeaderRichieste;
var LLabels: TMedpUnimPanel2Labels;
begin
  LLabels:=TMedpUnimPanel2Labels.Create(Self);

  with LLabels do
  begin
    LayoutConfig.Height:='35';
    DaContare:=False;

    with Label1 do
    begin
      Caption:=WR002RichiesteMW.Nominativo;
      BoxModel.CSSMargin.Left:='10px';
      LayoutConfig.Height:='30';
      LayoutConfig.Width:='100%';
      Font.Style:=[fsBold];
      JustifyContent:=TJustifyContent.JustifyStart;
    end;

    Label2.Visible:=False;
  end;

  pnlListaRichieste.AddHeader(LLabels);
end;

function TWR004FAutRichiesteFM.GetMsgAutorizza(Aut: String): String;
begin
  Result:='';
  if Aut = 'S' then
    Result:='Vuoi autorizzare questa richiesta?'
  else if Aut = 'N' then
    Result:='Vuoi negare l''autorizzazione a questa richiesta?';
end;

function TWR004FAutRichiesteFM.GetMsgAutorizzaTutti(Aut: String): String;
begin
  Result:='';
  if Aut = 'S' then
    Result:='Autorizzare tutte le richieste?'
  else if Aut = 'N' then
    Result:='Negare l''autorizzazione a tutte le richieste?';
end;

procedure TWR004FAutRichiesteFM.btnAutorizzaClick(Sender: TObject);
var LModalResult: Integer;
begin
  LModalResult:=MessageDlg(GetMsgAutorizza('S'), TMsgDlgType.mtConfirmation, mbYesNo);

  if LModalResult = mrYes then
    ImpostaAutorizzazione('S');
end;

function TWR004FAutRichiesteFM.GetMsgAutorizzato(Aut: String): String;
begin
  Result:='';
  if Aut = 'S' then
    Result:='Richiesta autorizzata'
  else if Aut = 'N' then
    Result:='Richiesta negata';
end;

function TWR004FAutRichiesteFM.GetMsgAutorizzatoTutti(Aut: String): String;
begin
  Result:='';
  if Aut = 'S' then
    Result:='Richieste autorizzate correttamente'
  else if Aut = 'N' then
    Result:='Richieste negate correttamente';
end;

procedure TWR004FAutRichiesteFM.btnNegaClick(Sender: TObject);
var LModalResult: Integer;
begin
  LModalResult:=MessageDlg(GetMsgAutorizza('N'), TMsgDlgType.mtConfirmation, mbYesNo);

  if LModalResult = mrYes then
    ImpostaAutorizzazione('N');
end;

procedure TWR004FAutRichiesteFM.btnAutorizzaTuttiClick(Sender: TObject);
var LModalResult: Integer;
begin
  LModalResult:=MessageDlg(GetMsgAutorizzaTutti('S'), TMsgDlgType.mtConfirmation, mbYesNo);

  if LModalResult = mrYes then
    AutorizzaTutti('S');
end;

procedure TWR004FAutRichiesteFM.btnNegaTuttiClick(Sender: TObject);
var LModalResult: Integer;
begin
  LModalResult:=MessageDlg(GetMsgAutorizzaTutti('N'), TMsgDlgType.mtConfirmation, mbYesNo);

  if LModalResult = mrYes then
    AutorizzaTutti('N');
end;

procedure TWR004FAutRichiesteFM.ImpostaAutorizzazione(const PAutorizzazione: String);
var LResCtrl: TResCtrl;
begin
  with WM000FMainModule do
    LResCtrl:=WR002RichiesteMW.AutorizzaRichiestaSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin, PAutorizzazione);

  // refresh richieste da autorizzare
  if LResCtrl.Ok then
  begin
    ShowMessage(GetMsgAutorizzato(PAutorizzazione));

    LResCtrl:=AggiornaListaRichieste;

    if not LResCtrl.Ok then
      ShowMessage(LResCtrl.Messaggio);

    tpnlRichieste.Prior;
  end
  else
    ShowMessage(LResCtrl.Messaggio);
end;

procedure TWR004FAutRichiesteFM.AutorizzaTutti(const PAutorizzazione: String);
var LResCtrl: TResCtrl;
begin
  with WM000FMainModule do
    LResCtrl:=WR002RichiesteMW.AutorizzaTutti(B110ClientModule, InfoClient, InfoLogin.ParametriLogin, PAutorizzazione);

  // refresh richieste da autorizzare
  if LResCtrl.Ok then
    ShowMessage(GetMsgAutorizzatoTutti(PAutorizzazione))
  else
    ShowMessage(LResCtrl.Messaggio);

  LResCtrl:=AggiornaListaRichieste;
  if not LResCtrl.Ok then
    ShowMessage(LResCtrl.Messaggio);
end;

procedure TWR004FAutRichiesteFM.ImpostaPannelloAutorizzazione;
begin
  pnlAutorizzazione.Visible:=(AbilitazioneFunzione = 'S') and (WR002RichiesteMW.FiltroStatoRichiesta = TStatoRichieste.srDaAutorizzare);
  pnlAutorizzaTutti.Visible:=pnlAutorizzazione.Visible and FAutorizzaTuttiDisponibile and (WR002RichiesteMW.RecordCount > 0);
end;

procedure TWR004FAutRichiesteFM.OnChangeAbilitaFunzioneProc(Sender: TObject);
begin
  ImpostaPannelloAutorizzazione;
end;

initialization
  RegisterClass(TWR004FAutRichiesteFM);

end.
