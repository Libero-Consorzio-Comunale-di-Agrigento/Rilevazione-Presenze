unit WM019URicCertificazioniFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR003UGestRichiesteFM, uniCheckBox,
  unimCheckBox, MedpUnimMemo, MedpUnimPanel2Labels, uniGUIClasses, uniEdit,
  unimEdit, MedpUnimEdit, uniLabel, unimLabel, MedpUnimLabel, MedpUnimPanel4LabelsIcon,
  MedpUnimPanel2Button, MedpUnimPanelListaDettaglio, MedpUnimPanelHeaderDett,
  MedpUnimPanelListaElem, MedpUnimPanelListaDisclosure, MedpUnimPanelNumElem, WR002URichiesteMW,
  MedpUnimPanelDataDaA, MedpUnimRadioGroup, uniPanel, uniPageControl, StrUtils, Generics.Collections,
  unimTabPanel, MedpUnimTabPanelBase, uniGUIBaseClasses, uniGUImJSForm, WM019UCertificazioniDM, WM019UModelloCertificazioneMW,
  MedpUnimPanelBase, WM019UCertificazioniMW, A000UInterfaccia, uniButton,
  uniBitBtn, unimBitBtn, MedpUnimButton, A000UCostanti, MedpUnimTypes,
  uniMultiItem, unimSelect, MedpUnimSelect, MedpUnimCheckBox;

type
  TWM019FRicCertificazioniFM = class(TWR003FGestRichiesteFM)
    lblFiltroModello: TMedpUnimLabel;
    cmbFiltroModello: TMedpUnimSelect;
    lblValidita: TMedpUnimLabel;
    pnlDateValidita: TMedpUnimPanelDataDaA;
    pnlStato: TMedpUnimPanelBase;
    lblStato: TMedpUnimLabel;
    lblInsModRichiesta: TMedpUnimLabel;
    lblNoteDocumento: TMedpUnimLabel;
    memNoteDocumento: TMedpUnimMemo;
    btnCompilaScheda: TMedpUnimButton;
    lblModello: TMedpUnimLabel;
    cmbModello: TMedpUnimSelect;
    lblDescrizioneModello: TMedpUnimLabel;
    tabModello: TUnimTabSheet;
    pnlHeaderModello: TMedpUnimPanelHeaderDett;
    pnlModello: TMedpUnimPanelBase;
    chkStato: TMedpUnimCheckBox;
    pnlOkAnnullaModello: TMedpUnimPanel2Button;
    lblCodModello: TMedpUnimLabel;
    procedure UniFrameCreate(Sender: TObject);
    procedure UniFrameDestroy(Sender: TObject); override;
    procedure OnFiltriRichiestaChange(Sender: TObject);
    procedure cmbFiltroModelloChange(Sender: TObject);
    procedure OnNuovaRichiestaClick(Sender: TObject); override;
    procedure OnModificaRichiestaClick(Sender: TObject); override;
    procedure btnCompilaSchedaClick(Sender: TObject);
    procedure cmbModelloChange(Sender: TObject);
    procedure pnlHeaderModellolblBackClick(Sender: TObject);
    procedure OnDisclModelloClick(Sender: TObject);
    procedure pnlOkAnnullaModelloButton1Click(Sender: TObject);
    procedure pnlOkAnnullaModelloButton2Click(Sender: TObject);
  private
    WM019MW: TWM019FCertificazioniMW;
    WM019ModelloMW: TWM019FModelloCertificazioneMW;

    procedure AggiornaTabNuovaRichiesta;
  protected
    procedure AggiornaHeaderDettaglio; override;
    function AggiornaListaDettaglio: TResCtrl; override;
    function CreaLabelsRichiesta: TMedpUnimPanelBase; override;

    function ControllaOkRichiesta: TResCtrl; override;
    procedure OkRichiesta; override;

    function ControllaEliminaRichiesta: TResCtrl; override;
    procedure EliminaRichiesta; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWM019FRicCertificazioniFM.UniFrameCreate(Sender: TObject);
var i: Integer;
begin
  SessioneOracle.Preferences.UseOci7:=False;
  SessioneOracle.LogOn;
  SessioneOracle.UseOCI80:=not SessioneOracle.Preferences.UseOci7;
  FAutorizzatore:=False;

  WM019ModelloMW:=TWM019FModelloCertificazioneMW.Create(A000SessioneIrisWin, pnlModello);
  WR002RichiesteMW:=TWM019FCertificazioniMW.Create(A000SessioneIrisWin, FAutorizzatore, WM019ModelloMW);
  WM019MW:=WR002RichiesteMW as TWM019FCertificazioniMW;

  //popolo la combobox per il filtro dei modelli
  cmbFiltroModello.Add('', '');
  for i:=0 to WM019MW.ListaModelli.Count-1 do
    cmbFiltroModello.Add(WM019MW.ListaModelli[i].Codice, WM019MW.ListaModelli[i].Descrizione);

  inherited;

  pnlDataDaA.ClearIcon.OnClick(pnlDataDaA.ClearIcon);
end;

procedure TWM019FRicCertificazioniFM.UniFrameDestroy(Sender: TObject);
begin
  FreeAndNil(WM019ModelloMW);
  WM019MW:=nil;
  inherited;
  SessioneOracle.LogOff;
end;

procedure TWM019FRicCertificazioniFM.AggiornaHeaderDettaglio;
begin
  inherited;
  pnlEliminaRevoca.Visible:= WM019MW.FiltroStatoRichiesta = srDaAutorizzare;

  if Assigned(WM019MW) then
  with WM019MW do
  begin
    btnDettModifica.Visible:=(Autorizzazione = '') and CertValida and GetInputPresenti;
  end;
end;

function TWM019FRicCertificazioniFM.AggiornaListaDettaglio: TResCtrl;
begin
  pnlListaDettaglio.Clear;

  if Assigned(WM019MW) then
  begin
    pnlListaDettaglio.Add2Labels('Nominativo', WM019MW.Nominativo, False, 0, nil);
    pnlListaDettaglio.Add2Labels(ITEM_DATA_RICHIESTA_TEXT, FormatDateTime('dd/mm/yyyy hh:mm', WM019MW.DataRichiesta), False, 0, nil);
    pnlListaDettaglio.Add2Labels('Stato', WM019MW.StatoRichiesta, False, 0, nil);
    pnlListaDettaglio.Add2Labels('Validità', WM019MW.Periodo, False, 0, nil);
    pnlListaDettaglio.Add2Labels('Modello', WM019MW.CodModello, True, 0, OnDisclModelloClick);
    pnlListaDettaglio.Add2Labels('Note al documento', WM019MW.Descrizione, False, 0, nil);
    pnlListaDettaglio.Add2Labels(ITEM_NOTE_TEXT, ITEM_MORE_DETAILS, True, 0, OnDisclNoteClick);

    //aggiunta gestione allegati se richiesta
    Result:=AggiungiGestAllegatiDettaglio;
    if not Result.Ok then
      Exit;

    Result.Ok:=True;
  end
  else
  begin
    Result.Ok:=False;
    Result.Messaggio:='Errore: Oggetto WM019MW non inizializzato, impossibile aggiornare il dettaglio';
  end;
end;

function TWM019FRicCertificazioniFM.CreaLabelsRichiesta: TMedpUnimPanelBase;
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

procedure TWM019FRicCertificazioniFM.AggiornaTabNuovaRichiesta;
var LResCtrl: TResCtrl;
    LModello: TModelloCertificazione;
    LInputPresenti: Boolean;
    i: Integer;
begin
  if Operazione = 'I' then
  begin
    lblInsModRichiesta.Text:='Inserimento scheda informativa';

    lblCodModello.Visible:=False;
    chkStato.CheckIcon.Enabled:=False;
    cmbModello.Visible:=True;
    memNoteDocumento.Memo.Text:='';
    memNoteDocumento.Memo.ReadOnly:=False;

    //gestione cmb modello
    cmbModello.Clear;
    LResCtrl:=WM019MW.AggiornaModelliDisponibili;
    if not LResCtrl.Ok then
      ShowMessage(LResCtrl.Messaggio);
    for i:=0 to WM019MW.ListaModelliDisponibili.Count-1 do
      cmbModello.Add(WM019MW.ListaModelliDisponibili[i].Codice, WM019MW.ListaModelliDisponibili[i].Descrizione);

    if WM019MW.ListaModelliDisponibili.Count > 0 then
    begin
      if (WM019MW.ListaModelliDisponibili.Count = 1) or (not VarIsNull(WM019MW.ListaModelliDisponibili[0].Ordine)) then
        cmbModello.ItemIndex:=0
      else
        cmbModello.ItemIndex:=-1;
    end
    else
      cmbModello.ItemIndex:=-1;

    cmbModelloChange(cmbModello);
  end
  else if Operazione = 'M' then
  begin
    lblInsModRichiesta.Text:='Modifica scheda informativa';

    LModello:=WM019MW.Modelli[WM019MW.CodModello];
    if not Assigned(LModello) then
    begin
      ShowMessage('Modello in modifica non trovato');
      Exit;
    end;

    LResCtrl:=WM019MW.AggiornaModello(Operazione, LModello.Codice); //aggiorno il panel del modello
    if not LResCtrl.Ok then
    begin
      ShowMessage('Errore nell''aggiornamento del modello: ' + LResCtrl.Messaggio);
      Exit;
    end;

    lblCodModello.Visible:=True;
    cmbModello.Visible:=False;
    btnCompilaScheda.Enabled:=True;
    lblDescrizioneModello.Text:=LModello.Descrizione;
    lblCodModello.Caption:=WM019MW.CodModello;
    memNoteDocumento.Memo.Text:=WM019MW.Descrizione; //"note al documento"
    pnlDateValidita.DataDa.Enabled:=True;
    pnlDateValidita.DataA.Enabled:=True;
    pnlDateValidita.DataDa.Date:=WM019MW.Dal;
    pnlDateValidita.DataA.Date:=WM019MW.Al;


    pnlDateValidita.DataDa.ReadOnly:=WM019MW.TipoRichiesta = 'D';
    pnlDateValidita.DataA.ReadOnly:=WM019MW.TipoRichiesta = 'D';
    memNoteDocumento.Memo.ReadOnly:=WM019MW.TipoRichiesta = 'D';

    //GESTIONE CAMPO 'D_TIPO_RICHIESTA' ABILITATO SI/NO
    LInputPresenti:=WM019MW.GetInputPresenti(LModello.Id);
    chkStato.CheckIcon.Checked:=WM019MW.TipoRichiesta = 'D';
    chkStato.CheckIcon.Enabled:=LInputPresenti;
  end;
end;

function TWM019FRicCertificazioniFM.ControllaOkRichiesta: TResCtrl;
var LModello: TModelloCertificazione;
begin
  inherited;

  Result.Clear;
  if Assigned(WM019MW.Richiesta) then
      WM019MW.Richiesta.Free;

  WM019MW.Richiesta:=TRichiestaCertificazione.Create;
  try
    with WM019MW.Richiesta do
    begin
      Progressivo:=A000SessioneIrisWin.Parametri.ProgressivoOper;
      Data:=Trunc(Now);

      if Operazione = 'I' then
      begin
        Id:=0;
        CodModello:=cmbModello.ListaCodici[cmbModello.ItemIndex];
      end
      else
      begin
        Id:=WM019MW.ID;
        CodModello:=lblCodModello.Caption;
      end;

      LModello:=WM019MW.Modelli[CodModello];
      if not Assigned(LModello) then
      begin
        ShowMessage(Format('Modello %s non trovato', [CodModello]));
        Exit;
      end;

      IdModello:=LModello.Id;
      Definitiva:=chkStato.CheckIcon.Checked;
      Dal:=pnlDateValidita.DataDa.Date;
      Al:=pnlDateValidita.DataA.Date;
      Note:=Trim(StringReplace(memNoteDocumento.Memo.Text, #13#10, ' ', [rfReplaceAll]));
    end;
  except
    on E: Exception do
    begin
      Result.Messaggio:='Errore nella creazione della richiesta: ' + E.Message;
      Exit;
    end;
  end;
  Result:=WM019MW.ControllaRichiesta;
end;

procedure TWM019FRicCertificazioniFM.OkRichiesta;
var LResCtrl: TResCtrl;
    LModalResult: Integer;
    LRisposteMsg: TRisposteMsg;   //usato solo per retrocompatibilità con gestione B110
begin
  inherited;

  if Operazione = 'I' then
  begin
    LResCtrl:=WM019MW.InserisciRichiestaSRV(nil, nil, nil, LRisposteMsg);
    if not LResCtrl.Ok then                //errore
    begin
      ShowMessage(LResCtrl.Messaggio);
      Exit;
    end
    else if LResCtrl.Messaggio <> '' then  //warning
    begin
      LModalResult:=MessageDlg(LResCtrl.Messaggio, TMsgDlgType.mtConfirmation, mbYesNo);
      if LModalResult = mrNo then
      begin
        WM019MW.AnnullaInserimentoRichiesta;
        Exit;
      end;
    end;

    LResCtrl:=WM019MW.ConfermaInserimentoRichiesta;
    if not LResCtrl.Ok then
      ShowMessage(LResCtrl.Messaggio)
    else
    begin
      ShowMessage('Inserimento effettuato');

      LResCtrl:=AggiornaListaRichieste;
      if not LResCtrl.Ok then
        ShowMessage(LResCtrl.Messaggio);

      Operazione:='';
      tpnlRichieste.First;
    end;
  end
  else if Operazione = 'M' then
  begin
    LResCtrl:=WM019MW.ModificaRichiestaSRV;
    if not LResCtrl.Ok then                 //no validità o errore
    begin
      ShowMessage(LResCtrl.Messaggio);
      Exit;
    end
    else if LResCtrl.Messaggio <> '' then   //warning
    begin
      LModalResult:=MessageDlg(LResCtrl.Messaggio, TMsgDlgType.mtConfirmation, mbYesNo);
      if LModalResult = mrNo then
      begin
        WM019MW.AnnullaModificaRichiesta;
        Exit;
      end;
    end;

    LResCtrl:=WM019MW.ConfermaModificaRichiesta;
    if not LResCtrl.Ok then
      ShowMessage(LResCtrl.Messaggio)
    else
    begin
      ShowMessage('Modifica completata');

      LResCtrl:=AggiornaListaRichieste;
      if not LResCtrl.Ok then
        ShowMessage(LResCtrl.Messaggio);

      Operazione:='';
      tpnlRichieste.First;
    end;
  end;
end;

function TWM019FRicCertificazioniFM.ControllaEliminaRichiesta: TResCtrl;
begin
  inherited;
  Result.Clear;
  Result.Ok:=True;
end;

procedure TWM019FRicCertificazioniFM.EliminaRichiesta;
var LResCtrl: TResCtrl;
    LRisposteMsg: TRisposteMsg;
begin
  inherited;
  LResCtrl:=WM019MW.EliminaRichiestaSRV(nil, nil, nil, LRisposteMsg);

  if LResCtrl.Ok then
  begin
    ShowMessage('Richiesta eliminata');

    LResCtrl:=AggiornaListaRichieste;
    if not LResCtrl.Ok then
      ShowMessage(LResCtrl.Messaggio);

    tpnlRichieste.First;
  end
  else
    ShowMessage(LResCtrl.Messaggio);
end;

procedure TWM019FRicCertificazioniFM.OnFiltriRichiestaChange(Sender: TObject);
begin
  inherited;

  if rgpTipoRichiesta.ItemIndex = 0 then
    pnlFiltroRichieste.BoxModel.CSSMargin.Top:='5px'
  else
    pnlFiltroRichieste.BoxModel.CSSMargin.Top:='15px';
end;

procedure TWM019FRicCertificazioniFM.cmbFiltroModelloChange(Sender: TObject);
var LResCtrl: TResCtrl;
begin
  inherited;

  LResCtrl:=WM019MW.ApplicaFiltroCodModello(cmbFiltroModello.ListaCodici[cmbFiltroModello.ItemIndex]);
  if not LResCtrl.Ok then
    ShowMessage(LResCtrl.Messaggio)
  else
    AggiornaListaRichieste;
end;

procedure TWM019FRicCertificazioniFM.cmbModelloChange(Sender: TObject);
var LModello: TModelloCertificazione;
    LPeriodoDefault: TPair<TDateTime, TDateTime>;
    LInputPresenti: Boolean;
    LResCtrl: TResCtrl;
begin
  inherited;

  if cmbModello.ItemIndex >= 0 then
  begin
    LModello:=WM019MW.ListaModelliDisponibili[cmbModello.ItemIndex];
    LResCtrl:=WM019MW.AggiornaModello(Operazione, LModello.Codice);
    if not LResCtrl.Ok then
    begin
      ShowMessage('Errore nell''aggiornamento del modello: ' + LResCtrl.Messaggio);
      Exit;
    end;

    lblDescrizioneModello.Text:=LModello.Descrizione;

    //GESTIONE CAMPO 'D_TIPO_RICHIESTA' ABILITATO SI/NO
    LInputPresenti:=WM019MW.GetInputPresenti(LModello.Id);
    //Se non ci sono campi di input la richiesta è subito definitiva e bloccata
    chkStato.CheckIcon.Enabled:=LInputPresenti;
    chkStato.CheckIcon.Checked:=not LInputPresenti;

    if LModello.Periodo <> '' then
    begin
      LResCtrl:=WM019MW.GetPeriodoDefault(LModello.Periodo, LPeriodoDefault);
      if LResCtrl.Ok then
      begin
        pnlDateValidita.DataDa.Date:=LPeriodoDefault.Key;
        pnlDateValidita.DataA.Date:=LPeriodoDefault.Value;
      end
      else
        ShowMessage('Lettura del periodo di default fallita: ' + LResCtrl.Messaggio);
    end
    else
    begin
      pnlDateValidita.DataDa.Text:='';
      pnlDateValidita.DataA.Text:='';
    end;

    pnlDateValidita.DataDa.Enabled:=True;
    pnlDateValidita.DataA.Enabled:=True;
    pnlDateValidita.DataDa.ReadOnly:=not (LModello.PeriodoModificabile = 'S');
    pnlDateValidita.DataA.ReadOnly:=pnlDateValidita.DataDa.ReadOnly;
    memNoteDocumento.Memo.Enabled:=True;
    btnCompilaScheda.Enabled:=True;
  end
  else
  begin
    lblDescrizioneModello.Text:='Nessun modello selezionato';
    pnlDateValidita.DataDa.Text:='';
    pnlDateValidita.DataA.Text:='';
    pnlDateValidita.DataDa.Enabled:=False;
    pnlDateValidita.DataA.Enabled:=False;
    memNoteDocumento.Memo.Enabled:=False;
    btnCompilaScheda.Enabled:=False;
  end;
end;

procedure TWM019FRicCertificazioniFM.OnNuovaRichiestaClick(Sender: TObject);
begin
  inherited;

  AggiornaTabNuovaRichiesta;
  tpnlRichieste.ActivePage:=tabNuovaRichiesta;
end;

procedure TWM019FRicCertificazioniFM.OnModificaRichiestaClick(Sender: TObject);
begin
  inherited;

  AggiornaTabNuovaRichiesta;
  tpnlRichieste.ActivePage:=tabNuovaRichiesta;
end;

procedure TWM019FRicCertificazioniFM.btnCompilaSchedaClick(Sender: TObject);
begin
  inherited;

  if Operazione = 'I' then
  begin
    pnlHeaderModello.LabelDettaglio.Caption:='Modello ' + WM019MW.ListaModelliDisponibili[cmbModello.ItemIndex].Codice;
    pnlOkAnnullaModello.Visible:=True;
    pnlHeaderModello.Back.Visible:=False;
  end
  else
  begin
    pnlHeaderModello.LabelDettaglio.Caption:='Modello ' + WM019MW.CodModello;
    pnlOkAnnullaModello.Visible:=WM019MW.TipoRichiesta <> 'D';
    pnlHeaderModello.Back.Visible:=not pnlOkAnnullaModello.Visible;
  end;

  tpnlRichieste.ActivePage:=tabModello;
end;

procedure TWM019FRicCertificazioniFM.OnDisclModelloClick(Sender: TObject);
var LResCtrl: TResCtrl;
begin
  LResCtrl:=WM019MW.AggiornaModello(Operazione, WM019MW.CodModello);
  if not LResCtrl.Ok then
  begin
    ShowMessage('Errore nell''aggiornamento del modello: ' + LResCtrl.Messaggio);
    Exit;
  end;

  Operazione:='';
  pnlHeaderModello.LabelDettaglio.Caption:='Modello ' + WM019MW.CodModello;
  pnlOkAnnullaModello.Visible:=False;
  pnlHeaderModello.Back.Visible:=True;
  tpnlRichieste.ActivePage:=tabModello;
end;

procedure TWM019FRicCertificazioniFM.pnlHeaderModellolblBackClick(Sender: TObject);
begin
  inherited;
  if Operazione <> '' then
    tpnlRichieste.ActivePage:=tabNuovaRichiesta
  else
    tpnlRichieste.ActivePage:=tabDettaglio;
end;

procedure TWM019FRicCertificazioniFM.pnlOkAnnullaModelloButton1Click(Sender: TObject);
var LResCtrl: TResCtrl;
begin
  inherited;
  LResCtrl:=WM019MW.CtrlDatiModello;
  if not LResCtrl.Ok then
    ShowMessage(LResCtrl.Messaggio)
  else
    tpnlRichieste.ActivePage:=tabNuovaRichiesta;
end;

procedure TWM019FRicCertificazioniFM.pnlOkAnnullaModelloButton2Click(Sender: TObject);
var LModalResult: Integer;
    LCodModello: String;
    LResCtrl: TResCtrl;
begin
  inherited;

  LModalResult:=MessageDlg('Annullare le modifiche apportate al modello?', TMsgDlgType.mtConfirmation, mbYesNo);
  if LModalResult = mrYes then
  begin
    if Operazione = 'I' then
      LCodModello:=WM019MW.ListaModelliDisponibili[cmbModello.ItemIndex].Codice
    else
      LCodModello:=WM019MW.CodModello;

    LResCtrl:=WM019MW.AggiornaModello(Operazione, LCodModello);
    if not LResCtrl.Ok then
    begin
      ShowMessage('Errore nell''aggiornamento del modello: ' + LResCtrl.Messaggio);
      Exit;
    end;
    tpnlRichieste.ActivePage:=tabNuovaRichiesta;
  end;
end;

initialization
  RegisterClass(TWM019FRicCertificazioniFM);

end.
