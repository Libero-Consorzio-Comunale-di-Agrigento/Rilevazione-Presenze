unit WM020UAutCertificazioniFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR004UAutRichiesteFM, uniCheckBox, StrUtils,
  unimCheckBox, MedpUnimMemo, MedpUnimPanel2Labels, uniGUIClasses, uniEdit,
  unimEdit, MedpUnimEdit, MedpUnimPanelListaDettaglio, uniLabel, unimLabel,
  MedpUnimLabel, MedpUnimPanelHeaderDett, MedpUnimPanel2Button, MedpUnimPanel4LabelsIcon,
  MedpUnimPanelSlideUp, MedpUnimPanelListaElem, MedpUnimPanelListaDisclosure,
  MedpUnimPanelNumElem, MedpUnimPanelDataDaA, MedpUnimRadioGroup, uniPanel, MedpUnimTypes,
  uniPageControl, unimTabPanel, MedpUnimTabPanelBase, uniGUIBaseClasses, A000UCostanti,
  uniGUImJSForm, MedpUnimPanelBase, A000UInterfaccia, WM019UCertificazioniMW, WM019UModelloCertificazioneMW,
  uniMultiItem, unimSelect, MedpUnimSelect;

type
  TWM020FAutCertificazioniFM = class(TWR004FAutRichiesteFM)
    tabModello: TUnimTabSheet;
    pnlHeaderModello: TMedpUnimPanelHeaderDett;
    pnlModello: TMedpUnimPanelBase;
    lblFiltroModello: TMedpUnimLabel;
    cmbFiltroModello: TMedpUnimSelect;
    procedure UniFrameCreate(Sender: TObject);
    procedure UniFrameDestroy(Sender: TObject); override;
    procedure OnDisclModelloClick(Sender: TObject);
    procedure pnlHeaderModellolblBackClick(Sender: TObject);
    procedure OnFiltriRichiestaChange(Sender: TObject);
    procedure cmbFiltroModelloChange(Sender: TObject);
  private
    WM019MW: TWM019FCertificazioniMW;
    WM019ModelloMW: TWM019FModelloCertificazioneMW;
  protected
    function AggiornaListaDettaglio: TResCtrl; override;
    function  CreaLabelsRichiesta: TMedpUnimPanelBase; override;

    function GetMsgAutorizza(Aut: String): String; override;
    function GetMsgAutorizzaTutti(Aut: String): String; override;
    function GetMsgAutorizzato(Aut: String): String; override;
    function GetMsgAutorizzatoTutti(Aut: String): String; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWM020FAutCertificazioniFM.UniFrameCreate(Sender: TObject);
var i: Integer;
begin
  SessioneOracle.Preferences.UseOci7:=False;
  SessioneOracle.LogOn;
  SessioneOracle.UseOCI80:=not SessioneOracle.Preferences.UseOci7;
  FAutorizzatore:=True;
  WM019ModelloMW:=TWM019FModelloCertificazioneMW.Create(A000SessioneIrisWin, pnlModello);
  WR002RichiesteMW:=TWM019FCertificazioniMW.Create(A000SessioneIrisWin, FAutorizzatore, WM019ModelloMW);
  WM019MW:=WR002RichiesteMW as TWM019FCertificazioniMW;

  cmbFiltroModello.Add('', '');
  for i:=0 to WM019MW.ListaModelli.Count-1 do
    cmbFiltroModello.Add(WM019MW.ListaModelli[i].Codice, WM019MW.ListaModelli[i].Descrizione);

  FAutorizzaTuttiDisponibile:=True;
  OnChangeAbilitaFunzione:=OnChangeAbilitaFunzioneProc;
  inherited;

  pnlDataDaA.ClearIcon.OnClick(pnlDataDaA.ClearIcon);
end;

procedure TWM020FAutCertificazioniFM.UniFrameDestroy(Sender: TObject);
begin
  FreeAndNil(WM019ModelloMW);
  WM019MW:=nil;
  inherited;
  SessioneOracle.LogOff;
end;

procedure TWM020FAutCertificazioniFM.OnDisclModelloClick(Sender: TObject);
var LResCtrl: TResCtrl;
begin
  LResCtrl:=WM019MW.AggiornaModello('', WM019MW.CodModello);
  if not LResCtrl.Ok then
  begin
    ShowMessage('Errore nell''aggiornamento del modello: ' + LResCtrl.Messaggio);
    Exit;
  end;

  pnlHeaderModello.LabelDettaglio.Caption:='Modello ' + WM019MW.CodModello;
  pnlHeaderModello.Back.Visible:=True;
  tpnlRichieste.ActivePage:=tabModello;
end;

procedure TWM020FAutCertificazioniFM.OnFiltriRichiestaChange(Sender: TObject);
begin
  inherited;

  if rgpTipoRichiesta.ItemIndex = 0 then
    pnlFiltroRichieste.BoxModel.CSSMargin.Top:='5px'
  else
    pnlFiltroRichieste.BoxModel.CSSMargin.Top:='15px';
end;

procedure TWM020FAutCertificazioniFM.pnlHeaderModellolblBackClick(Sender: TObject);
begin
  inherited;
  tpnlRichieste.ActivePage:=tabDettaglio;
end;

function TWM020FAutCertificazioniFM.AggiornaListaDettaglio: TResCtrl;
begin
  pnlListaDettaglio.Clear;

  lblLivello.Text:=Format('Livello %d',[WM019MW.LivelloAutorizzazione]);

  pnlListaDettaglio.Add2Labels('Nominativo', WM019MW.Nominativo, False, 0, nil);
  pnlListaDettaglio.Add2Labels(ITEM_DATA_RICHIESTA_TEXT, FormatDateTime('dd/mm/yyyy hh:mm', WM019MW.DataRichiesta), False, 0, nil);
  pnlListaDettaglio.Add2Labels('Stato', WM019MW.StatoRichiesta, False, 0, nil);
  pnlListaDettaglio.Add2Labels('Validità', WM019MW.Periodo, False, 0, nil);
  pnlListaDettaglio.Add2Labels('Modello', WM019MW.CodModello, True, 0, OnDisclModelloClick);
  pnlListaDettaglio.Add2Labels('Note al documento', WM019MW.Descrizione, False, 0, nil);
  pnlListaDettaglio.Add2Labels(ITEM_NOTE_TEXT, ITEM_MORE_DETAILS, True, 0, OnDisclNoteClick);

  Result:=AggiungiGestAllegatiDettaglio;
  if not Result.Ok then
    Exit;

  Result.Ok:=True;
end;

procedure TWM020FAutCertificazioniFM.cmbFiltroModelloChange(Sender: TObject);
var LResCtrl: TResCtrl;
begin
  inherited;

  LResCtrl:=WM019MW.ApplicaFiltroCodModello(cmbFiltroModello.ListaCodici[cmbFiltroModello.ItemIndex]);
  if not LResCtrl.Ok then
    ShowMessage(LResCtrl.Messaggio)
  else
    AggiornaListaRichieste;
end;

function TWM020FAutCertificazioniFM.CreaLabelsRichiesta: TMedpUnimPanelBase;
var LPanel: TMedpUnimPanel4LabelsIcon;
    LCondizioneAllegati: String;
    LNumAllegati: Integer;
begin
  LPanel:=TMedpUnimPanel4LabelsIcon.Create(Self);

  with LPanel do
  begin
    LayoutConfig.Height:='auto';
    LayoutConfig.Width:='100%';
    Labels.Label1.LayoutConfig.Width:='100%';
    Labels.Label1.Caption:=WM019MW.CodModello + IfThen(not WM019MW.Definitiva, ' - <i>(da confermare)</i>');
    Labels.Label1.Constraints.MinHeight:=20;
    Labels.Label1.JustifyContent:=JustifyStart;
    Labels.Label1.Font.Style:=[fsBold];
    Labels.Label1.BoxModel.CSSMargin.Top:='2px';
    Labels.Label2.LayoutConfig.Width:='100%';
    Labels.Label2.Caption:=WM019MW.Periodo;
    if Labels.Label2.Caption = '' then
      Labels.Label2.Visible:=False;
    Labels.Label2.Constraints.MinHeight:=20;
    Labels.Label2.JustifyContent:=JustifyStart;
    Labels.Label3.Visible:=False;
    Labels.Label4.Visible:=False;

    Icon.Visible:=False;

    if Assigned(WR006AllegatiMW) then  //se è attiva la gestione allegati
    begin
      LCondizioneAllegati:=WR006AllegatiMW.GetCondizioneAllegati;
      BoxModel.CSSMargin.Left:='5px';

      if LCondizioneAllegati <> 'N' then
      begin
        Icon.Visible:=True;

        LNumAllegati:=WR006AllegatiMW.GetNumeroAllegati(WM019MW.ID);

        if LNumAllegati > 0 then
          Icon.JSInterface.JSCall('addCls', ['allegato-presente'])
        else
        begin
          if LCondizioneAllegati = 'O' then
            Icon.JSInterface.JSCall('addCls', ['allegato-obbligatorio']);
        end;

        Icon.Caption:='fas fa-paperclip';
        Icon.BoxModel.CSSBorderRadius:='30px';
        Icon.BoxModel.CSSPadding.Top:='6px';
        Icon.BoxModel.CSSPadding.Bottom:='6px';
        Icon.BoxModel.CSSPadding.Left:='6px';
        Icon.BoxModel.CSSPadding.Right:='6px';
      end;
    end;
  end;
  Result:=LPanel;
end;

//messaggi personalizzati
function TWM020FAutCertificazioniFM.GetMsgAutorizza(Aut: String): String;
begin
  Result:='';
  if Aut = 'S' then
    Result:='Vuoi validare questa richiesta?'
  else if Aut = 'N' then
    Result:='Vuoi negare la validazione a questa richiesta?';
end;

function TWM020FAutCertificazioniFM.GetMsgAutorizzaTutti(Aut: String): String;
begin
  Result:='';
  if Aut = 'S' then
    Result:='Validare tutte le richieste?'
  else if Aut = 'N' then
    Result:='Negare la validazione a tutte le richieste?';
end;

function TWM020FAutCertificazioniFM.GetMsgAutorizzato(Aut: String): String;
begin
  Result:='';
  if Aut = 'S' then
    Result:='Richiesta validata'
  else if Aut = 'N' then
    Result:='Richiesta negata';
end;

function TWM020FAutCertificazioniFM.GetMsgAutorizzatoTutti(Aut: String): String;
begin
  Result:='';
  if Aut = 'S' then
    Result:='Richieste validate correttamente'
  else if Aut = 'N' then
    Result:='Richieste negate correttamente';
end;

initialization
  RegisterClass(TWM020FAutCertificazioniFM);

end.
