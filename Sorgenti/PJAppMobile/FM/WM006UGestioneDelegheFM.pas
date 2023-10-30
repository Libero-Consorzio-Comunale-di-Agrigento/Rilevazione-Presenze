unit WM006UGestioneDelegheFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WM000UFrameBase, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, MedpUnimPanelBase, uniPageControl, unimTabPanel,
  MedpUnimTabPanelBase, uniPanel, uniLabel, unimLabel, MedpUnimLabel,
  MedpUnimPanelListaElem, MedpUnimPanelListaDisclosure, uniButton, uniBitBtn,
  unimBitBtn, MedpUnimButton, MedpUnimPanel2Button, MedpUnimPanelHeaderDett,
  MedpUnimPanelNumElem, MedpUnimPanelDataDaA, MedpUnimPanel2Labels, uniCheckBox,
  unimCheckBox, uniEdit, unimEdit, MedpUnimEdit, MedpUnimPanel4Labels, A000UCostanti, StrUtils,
  WM006UGestioneDelegheMW, WM006UGestioneDelegheDM, WM000UMainModule, A000USessione, Generics.Collections,
  MedpUnimPanelDisclosure, WM000UConstants, A000UInterfaccia, MedpUnimTypes;

type
  TWM006FGestioneDelegheFM = class(TWM000FFrameBase)
    tpnlGestioneDeleghe: TMedpUnimTabPanelBase;
    tabDelegheAttive: TUnimTabSheet;
    tabInserimentoModifica: TUnimTabSheet;
    tabFiltroUtenti: TUnimTabSheet;
    pnlListaDeleghe: TMedpUnimPanelListaDisclosure;
    pnlHeaderFiltroUtenti: TMedpUnimPanelHeaderDett;
    pnlNumDeleghe: TMedpUnimPanelNumElem;
    pnlCognome: TMedpUnimPanelBase;
    lblCognome: TMedpUnimLabel;
    edtCognome: TMedpUnimEdit;
    pnlMatricola: TMedpUnimPanelBase;
    lblMatricola: TMedpUnimLabel;
    edtMatricola: TMedpUnimEdit;
    pnlUtenteDelegato: TMedpUnimPanelBase;
    lblUtenteDelegato: TMedpUnimLabel;
    edtUtenteDelegato: TMedpUnimEdit;
    pnlNumUtentiTrovati: TMedpUnimPanelNumElem;
    pnlListaUtentiTrovati: TMedpUnimPanelListaDisclosure;
    btnFiltra: TMedpUnimButton;
    pnlInserimentoModifica: TMedpUnimPanelBase;
    lblInsModDelega: TMedpUnimLabel;
    pnlUtente: TMedpUnimPanelBase;
    btnFiltroUtenti: TMedpUnimButton;
    pnlEscludiDelegato: TMedpUnimPanelBase;
    lblEscludiDelegato: TMedpUnimLabel;
    chkEscludiDelegato: TUnimCheckBox;
    pnlProfilo: TMedpUnimPanelBase;
    lblProfilo: TMedpUnimLabel;
    pnlLabelsProfilo: TMedpUnimPanelBase;
    edtProfilo: TMedpUnimEdit;
    btnProfiloDefault: TMedpUnimButton;
    pnlValidita: TMedpUnimPanelBase;
    lblValidita: TMedpUnimLabel;
    pnlDateValidita: TMedpUnimPanelDataDaA;
    pnlPulsanti: TMedpUnimPanelBase;
    pnlOkAnnulla: TMedpUnimPanel2Button;
    btnEliminaDelega: TMedpUnimButton;
    pnlLabelsUtente: TMedpUnimPanelBase;
    lblUtente: TMedpUnimLabel;
    lblNominativo: TMedpUnimLabel;
    lblUtenteValue: TMedpUnimLabel;
    lblNominativoValue: TMedpUnimLabel;
    pnlDaDelegare: TMedpUnimPanelBase;
    lblDaDelegare: TMedpUnimLabel;
    lblDaDelegareValue: TMedpUnimLabel;
    lblFiltroPersonalizzato: TMedpUnimLabel;
    procedure UniFrameCreate(Sender: TObject);
    procedure UniFrameDestroy(Sender: TObject); override;
    procedure ProfiloDefaultClick(Sender: TObject);
    procedure BackClick(Sender: TObject);
    procedure SelezionaUtenteClick(Sender: TObject);
    procedure FiltraUtentiClick(Sender: TObject);
    procedure UtenteFiltratoClick(Sender: TObject);
    procedure AnnullaDelegaClick(Sender: TObject);
    procedure EliminaDelegaClick(Sender: TObject);
    procedure InserimentoDelegaClick(Sender: TObject);
    procedure ModificaDelegaClick(Sender: TObject);
    procedure OkInserimentoDelegaClick(Sender: TObject);
    procedure OkModificaDelegaClick(Sender: TObject);
  private
    WM006MW: TWM006FGestioneDelegheMW;

    function CreaPanelUtente(LUtente: TUtenteDelegato): TMedpUnimPanel4Labels;
    procedure AggiornaListaUtenti;
    function CreaPanelDelega(LDelega: TDelega): TMedpUnimPanel4Labels;
    procedure AggiornaListaDeleghe;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWM006FGestioneDelegheFM.UniFrameCreate(Sender: TObject);
begin
  inherited;
  SessioneOracle.Preferences.UseOci7:=False;
  SessioneOracle.LogOn;
  SessioneOracle.UseOCI80:=not SessioneOracle.Preferences.UseOci7;
  tpnlGestioneDeleghe.ActivePage:=tabDelegheAttive;

  WM006MW:=TWM006FGestioneDelegheMW.Create(WM000FMainModule.InfoLogin.SessioneIrisWin);

  AggiornaListaDeleghe;
end;

procedure TWM006FGestioneDelegheFM.UniFrameDestroy(Sender: TObject);
begin
  FreeAndNil(WM006MW);
  inherited;
  SessioneOracle.LogOff;
end;

procedure TWM006FGestioneDelegheFM.ProfiloDefaultClick(Sender: TObject);
begin
  inherited;
  edtProfilo.Text:=WM006MW.GetProfiloDefault(WM000FMainModule.InfoLogin.SessioneIrisWin.SessioneOracle,
                                                IfThen(lblUtenteValue.Caption = '--', '', lblUtenteValue.Caption), Trunc(pnlDateValidita.DataDa.Date), Trunc(pnlDateValidita.DataA.Date));
end;

procedure TWM006FGestioneDelegheFM.BackClick(Sender: TObject);
begin
  inherited;
  tpnlGestioneDeleghe.Prior;
end;

procedure TWM006FGestioneDelegheFM.InserimentoDelegaClick(Sender: TObject);
begin
  inherited;

  lblInsModDelega.Caption:='Inserimento delega';
  lblDaDelegareValue.Caption:=WM000FMainModule.InfoLogin.ParametriLogin.Profilo;
  pnlOkAnnulla.Button1.OnClick:=OkInserimentoDelegaClick;

  btnFiltroUtenti.Enabled:=True;
  btnProfiloDefault.Enabled:=True;
  edtProfilo.Enabled:=True;
  btnEliminaDelega.Visible:=False;

  lblUtenteValue.Caption:='--';
  lblNominativoValue.Caption:='--';
  edtProfilo.Text:='';
  pnlDateValidita.DataDa.Date:=Trunc(Now);
  pnlDateValidita.DataA.Date:=Trunc(Now);
  chkEscludiDelegato.Checked:=True;

  tpnlGestioneDeleghe.ActivePage:=tabInserimentoModifica;
end;

procedure TWM006FGestioneDelegheFM.ModificaDelegaClick(Sender: TObject);
begin
  if sender is TMedpUnimPanelDisclosure then
  begin
    if WM006MW.SelezionaDelegaInModifica(VarToStr((sender as TMedpUnimPanelDisclosure).Key)) then
    begin
      lblInsModDelega.Caption:='Modifica delega';
      lblDaDelegareValue.Caption:=WM006MW.UtenteDelegante.Profilo;
      pnlOkAnnulla.Button1.OnClick:=OkModificaDelegaClick;

      btnFiltroUtenti.Enabled:=False;
      btnProfiloDefault.Enabled:=False;
      edtProfilo.Enabled:=False;
      btnEliminaDelega.Visible:=True;

      with WM006MW do
      begin
        lblUtenteValue.Caption:=DelegaInModifica.Utente;
        lblNominativoValue.Caption:=DelegaInModifica.Cognome + ' ' + DelegaInModifica.Nome;
        edtProfilo.Text:=DelegaInModifica.Profilo;
        pnlDateValidita.DataDa.Date:=DelegaInModifica.InizioValidita;
        pnlDateValidita.DataA.Date:=DelegaInModifica.FineValidita;
        chkEscludiDelegato.Checked:=DelegaInModifica.EscludiDelegato;
      end;

      tpnlGestioneDeleghe.ActivePage:=tabInserimentoModifica;
    end;
  end;
end;

procedure TWM006FGestioneDelegheFM.AnnullaDelegaClick(Sender: TObject);
var LModalResult: Integer;
    LMessaggio: String;
begin
  inherited;
  if lblInsModDelega.Caption = 'Inserimento delega' then
    LMessaggio:='Annullare l''inserimento della delega?'
  else
    LMessaggio:='Annullare la modifica della delega selezionata?';

  LModalResult:=MessageDlg(LMessaggio, TMsgDlgType.mtConfirmation, mbYesNo);

  if LModalResult = mrYes then
    tpnlGestioneDeleghe.Prior;
end;

procedure TWM006FGestioneDelegheFM.EliminaDelegaClick(Sender: TObject);
var LModalResult: Integer;
    LResCtrl: TResCtrl;
begin
  inherited;

  LModalResult:=MessageDlg('Confermare l''eliminazione della delega visualizzata?', TMsgDlgType.mtConfirmation, mbYesNo);

  if LModalResult = mrYes then
  begin
    LResCtrl:=WM006MW.EliminaDelegaInModifica;

    if LResCtrl.Ok then
    begin
      AggiornaListaDeleghe;
      tpnlGestioneDeleghe.Prior;
    end
    else
      ShowMessage(LResCtrl.Messaggio);
  end;
end;

procedure TWM006FGestioneDelegheFM.OkInserimentoDelegaClick(Sender: TObject);
var LModalResult: Integer;
    LResCtrl: TResCtrl;
begin
  inherited;

  LModalResult:=MessageDlg('Confermare l''inserimento della delega?', TMsgDlgType.mtConfirmation, mbYesNo);

  if LModalResult = mrYes then
  begin
    LResCtrl:=WM006MW.ControlliInserimentoOK(lblUtenteValue.Caption, edtProfilo.Text, pnlDateValidita.DataDa.Date, pnlDateValidita.DataA.Date);

    if LResCtrl.Ok and (LResCtrl.Messaggio <> '') then //inserisco la delega eliminando la precedente
    begin
      LModalResult:=MessageDlg(LResCtrl.Messaggio, TMsgDlgType.mtConfirmation, mbYesNo);

      if LModalResult = mrYes then
      begin
        LResCtrl:=WM006MW.EliminaDelegaEsistente;

        if not LResCtrl.Ok then
        begin
          ShowMessage(LResCtrl.Messaggio);
          Exit;
        end;

        LResCtrl:=WM006MW.InserisciDelega(lblUtenteValue.Caption,
                                          edtProfilo.Text,
                                          pnlDateValidita.DataDa.Date,
                                          pnlDateValidita.DataA.Date,
                                          chkEscludiDelegato.Checked);

        if LResCtrl.Ok then
        begin
          AggiornaListaDeleghe;
          tpnlGestioneDeleghe.Prior;
        end
        else
          ShowMessage(LResCtrl.Messaggio);
      end;
    end
    else if LResCtrl.Ok then        // inserisco la delega normalmente
    begin
      LResCtrl:=WM006MW.InserisciDelega(lblUtenteValue.Caption,
                                          edtProfilo.Text,
                                          pnlDateValidita.DataDa.Date,
                                          pnlDateValidita.DataA.Date,
                                          chkEscludiDelegato.Checked);

      if LResCtrl.Ok then
      begin
        AggiornaListaDeleghe;
        tpnlGestioneDeleghe.Prior;
      end
      else
        ShowMessage(LResCtrl.Messaggio);
    end
    else
      ShowMessage(LResCtrl.Messaggio);
  end;
end;

procedure TWM006FGestioneDelegheFM.OkModificaDelegaClick(Sender: TObject);
var LModalResult: Integer;
    LResCtrl: TResCtrl;
begin
  inherited;

  LModalResult:=MessageDlg('Confermare la modifica della delega?', TMsgDlgType.mtConfirmation, mbYesNo);

  if LModalResult = mrYes then
  begin
    LResCtrl:=WM006MW.ControlliModificaOK(lblUtenteValue.Caption, edtProfilo.Text, pnlDateValidita.DataDa.Date, pnlDateValidita.DataA.Date);

    if LResCtrl.Ok and (LResCtrl.Messaggio <> '') then  // elimino la delega precedente e inserisco la modificata
    begin
      LModalResult:=MessageDlg(LResCtrl.Messaggio, TMsgDlgType.mtConfirmation, mbYesNo);

      if LModalResult = mrYes then
      begin
        LResCtrl:=WM006MW.EliminaDelegaEsistente;

        if not LResCtrl.Ok then
        begin
          ShowMessage(LResCtrl.Messaggio);
          Exit;
        end;

        LResCtrl:=WM006MW.InserisciDelega(lblUtenteValue.Caption,
                                          edtProfilo.Text,
                                          pnlDateValidita.DataDa.Date,
                                          pnlDateValidita.DataA.Date,
                                          chkEscludiDelegato.Checked);

        if LResCtrl.Ok then
        begin
          AggiornaListaDeleghe;
          tpnlGestioneDeleghe.Prior;
        end
        else
          ShowMessage(LResCtrl.Messaggio);
      end;
    end
    else if LResCtrl.Ok then    // modifico la delega normalmente
    begin
      LResCtrl:=WM006MW.ModificaDelega(edtProfilo.Text,
                                       pnlDateValidita.DataDa.Date,
                                       pnlDateValidita.DataA.Date,
                                       chkEscludiDelegato.Checked);

      if LResCtrl.Ok then
      begin
        AggiornaListaDeleghe;
        tpnlGestioneDeleghe.Prior;
      end
      else
        ShowMessage(LResCtrl.Messaggio);
    end
    else
      ShowMessage(LResCtrl.Messaggio);
  end;
end;

procedure TWM006FGestioneDelegheFM.SelezionaUtenteClick(Sender: TObject);
begin
  inherited;
  pnlListaUtentiTrovati.Clear;
  pnlNumUtentiTrovati.NumElementi:=0;
  edtCognome.Text:='';
  edtMatricola.Text:='';
  edtUtenteDelegato.Text:='';

  lblFiltroPersonalizzato.Visible:=WM006MW.C90_FiltroDeleghe <> '';

  tpnlGestioneDeleghe.ActivePage:=tabFiltroUtenti;
end;

procedure TWM006FGestioneDelegheFM.FiltraUtentiClick(Sender: TObject);
var LModalResult: Integer;
begin
  inherited;

  if (WM006MW.C90_FiltroDeleghe = '') and  // non da messaggio se esiste un filtro personalizzato
     (Trim(edtCognome.Text) = '') and
     (Trim(edtMatricola.Text) = '') and
     (Trim(edtUtenteDelegato.Text) = '') then
  begin
    LModalResult:=MessageDlg('Non è stato impostato nessun parametro di ricerca per filtrare la lista degli utenti web.'#13#10'Vuoi continuare?', TMsgDlgType.mtConfirmation, mbYesNo);

    if LModalResult = mrNo then
      Exit;
  end;

  AggiornaListaUtenti;
end;

procedure TWM006FGestioneDelegheFM.UtenteFiltratoClick(Sender: TObject);
var tempKey: Integer;
begin
  if sender is TMedpUnimPanelDisclosure then
  begin
    tempKey:=(sender as TMedpUnimPanelDisclosure).Key;

    with WM006MW do
    begin
      lblUtenteValue.Caption:=ListaUtenti[tempKey].Utente;
      lblNominativoValue.Caption:=ListaUtenti[tempKey].Cognome + ' ' + ListaUtenti[tempKey].Cognome;
    end;

    tpnlGestioneDeleghe.Prior;
  end;
end;

function TWM006FGestioneDelegheFM.CreaPanelUtente(LUtente: TUtenteDelegato): TMedpUnimPanel4Labels;
begin
  Result:=TMedpUnimPanel4Labels.Create(Self);

  with Result do
  begin
    LayoutConfig.Height:='auto';
    Label1.Caption:=LUtente.Cognome + ' ' + LUtente.Nome;
    Label1.LayoutConfig.Width:='100%';
    Label1.LayoutConfig.Height:='25';
    Label2.Visible:=False;
    Label3.Caption:=LUtente.Utente;
    Label3.Font.Style:=[fsItalic];
    Label3.LayoutConfig.Width:='100%';
    Label3.LayoutConfig.Height:='25';
    Label4.Visible:=False;
  end;
end;

procedure TWM006FGestioneDelegheFM.AggiornaListaUtenti;
var i : Integer;
begin
  pnlListaUtentiTrovati.Clear;

  with WM000FMainModule.InfoLogin do
    WM006MW.AggiornaListaUtenti(Trim(edtCognome.Text),
                                Trim(edtMatricola.Text),
                                Trim(edtUtenteDelegato.Text));

  with WM006MW do
    for i:=0 to ListaUtenti.Count-1 do
      pnlListaUtentiTrovati.Add(CreaPanelUtente(ListaUtenti[i]), True, i, UtenteFiltratoClick);

  pnlNumUtentiTrovati.NumElementi:=pnlListaUtentiTrovati.NumeroElementi;
end;

function TWM006FGestioneDelegheFM.CreaPanelDelega(LDelega: TDelega): TMedpUnimPanel4Labels;
begin
  Result:=TMedpUnimPanel4Labels.Create(Self);

  with Result do
  begin
    LayoutConfig.Height:='auto';
    Layout:='vbox';

    Label1.Caption:='DELEGATO: ' + LDelega.Cognome + ' ' + LDelega.Nome + ' (' + LDelega.Utente + ')';
    Label1.JustifyContent:=JustifyStart;
    Label1.BoxModel.CSSMargin.Top:='3px';
    Label1.LayoutConfig.Width:='100%';
    Label1.LayoutConfig.Height:='auto';
    Label1.Font.Style:=[fsBold];

    Label2.Caption:='Dal ' + formatdatetime('dd/mm/yyyy', LDelega.InizioValidita) + ' al ' + formatdatetime('dd/mm/yyyy', LDelega.FineValidita);
    Label2.JustifyContent:=JustifyStart;
    Label2.LayoutConfig.Width:='100%';
    Label2.LayoutConfig.Height:='auto';

    Label3.Caption:='Profilo: ' + LDelega.Profilo;
    Label3.JustifyContent:=JustifyStart;
    Label3.LayoutConfig.Width:='100%';
    Label3.LayoutConfig.Height:='auto';

    Label4.Caption:='Escludi delegato: ' + IfThen(LDelega.EscludiDelegato, 'Si', 'No');
    Label4.JustifyContent:=JustifyStart;
    Label4.BoxModel.CSSMargin.Bottom:='3px';
    Label4.LayoutConfig.Width:='100%';
    Label4.LayoutConfig.Height:='auto';
  end;
end;

procedure TWM006FGestioneDelegheFM.AggiornaListaDeleghe;
var i : Integer;
begin
  pnlListaDeleghe.Clear;

  with WM000FMainModule.InfoLogin do
    WM006MW.AggiornaListaDeleghe(DatiGenerali.Parametri.Azienda, ParametriLogin.Utente);

  with WM006MW do
    for i:=0 to ListaDeleghe.Count-1 do
      pnlListaDeleghe.Add(CreaPanelDelega(ListaDeleghe[i]), True, ListaDeleghe[i].Id, ModificaDelegaClick);

  pnlNumDeleghe.NumElementi:=pnlListaDeleghe.NumeroElementi;
end;

initialization
  RegisterClass(TWM006FGestioneDelegheFM);

end.
