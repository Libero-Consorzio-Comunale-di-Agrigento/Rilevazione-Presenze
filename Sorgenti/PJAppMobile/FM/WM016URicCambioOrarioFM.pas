unit WM016URicCambioOrarioFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR003UGestRichiesteFM,
  MedpUnimPanel2Button, MedpUnimPanelListaDettaglio, MedpUnimPanelHeaderDett,
  MedpUnimPanelListaElem, MedpUnimPanelListaDisclosure, MedpUnimPanelNumElem,
  MedpUnimPanelDataDaA, MedpUnimRadioGroup, uniPanel, uniPageControl,
  unimTabPanel, MedpUnimTabPanelBase, uniGUIBaseClasses, uniGUIClasses,
  uniGUImJSForm, MedpUnimPanelBase, WM016UCambioOrarioMW, A000UCostanti, A000UInterfaccia,
  MedpUnimPanel4Labels, C180FunzioniGenerali, StrUtils, WR002URichiesteMW, MedpUnimTypes,
  uniLabel, unimLabel, MedpUnimLabel, MedpUnimRadioButton, uniDateTimePicker,
  unimDatePicker, MedpUnimDatePicker, MedpUnimMemo, uniCheckBox, unimCheckBox,
  uniMultiItem, unimSelect, MedpUnimSelect, FunzioniGenerali, Generics.Collections, WM016UCambioOrarioDM,
  WM000UMainModule, MedpUnimPanel2Labels, uniFileUpload, unimFileUpload,
  uniEdit, unimEdit, MedpUnimEdit, uniButton, uniBitBtn, unimBitBtn,
  MedpUnimButton;

type
  TWM016FRicCambioOrarioFM = class(TWR003FGestRichiesteFM)
    pnlModRichiesta: TMedpUnimPanelBase;
    rbtnCambio: TMedpUnimRadioButton;
    rbtnInversione: TMedpUnimRadioButton;
    memNote: TMedpUnimMemo;
    pnlSoloNote: TMedpUnimPanelBase;
    lblSoloNote: TMedpUnimLabel;
    chkSoloNote: TUnimCheckBox;
    pnlData: TMedpUnimPanelBase;
    edtData: TMedpUnimDatePicker;
    lblGiornoSett: TMedpUnimLabel;
    lblGiorno: TMedpUnimLabel;
    lblOrario: TMedpUnimLabel;
    lblOrarioDesc: TMedpUnimLabel;
    lblSecondoGiorno: TMedpUnimLabel;
    cmbSecondoGiorno: TMedpUnimSelect;
    lblOrarioRichiesto: TMedpUnimLabel;
    cmbOrarioRichiesto: TMedpUnimSelect;
    lblOrarioRichiestoDesc: TMedpUnimLabel;
    procedure UniFrameCreate(Sender: TObject); override;
    procedure UniFrameDestroy(Sender: TObject); override;
    procedure OnNuovaRichiestaClick(Sender: TObject); override;
    procedure chkSoloNoteClick(Sender: TObject);
    procedure edtDataChange(Sender: TObject);
    procedure rbtnModRichiestaChange(Sender: TObject);
    procedure cmbSecondoGiornoChange(Sender: TObject);
  private
    WM016MW: TWM016FCambioOrarioMW;

    FFormat : TFormatSettings; //usato per la conversione della data del secondo giorno da cmbSecondoGiorno

    procedure AggiornaTabInserimentoRichiesta;
    procedure AggiornaOrari;
    procedure AggiornaGiorni;
  protected
    procedure AggiornaHeaderDettaglio; override;
    function AggiornaListaDettaglio: TResCtrl; override;
    function  CreaLabelsRichiesta: TMedpUnimPanelBase; override;

    function ControllaEliminaRichiesta: TResCtrl; override;
    procedure EliminaRichiesta; override;

    function ControllaRevocaRichiesta: TResCtrl; override;
    procedure RevocaRichiesta; override;

    function ControllaOkRichiesta: TResCtrl; override;
    procedure OkRichiesta; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWM016FRicCambioOrarioFM.UniFrameCreate(Sender: TObject);
begin
  if Parametri.CampiRiferimento.C90_WebTipoCambioOrario = '' then
  begin
    MainPanel.Visible:=False;
    raise Exception.Create('Per accedere alla funzione Richiesta cambio orario è necessario impostare il seguente dato aziendale del gruppo IrisWEB: "Web: Tipologia cambio orario!"');
  end;

  SessioneOracle.Preferences.UseOci7:=False;
  SessioneOracle.LogOn;
  SessioneOracle.UseOCI80:=not SessioneOracle.Preferences.UseOci7;
  FAutorizzatore:=False;
  WR002RichiesteMW:=TWM016FCambioOrarioMW.Create(A000SessioneIrisWin, FAutorizzatore);
  WM016MW:=WR002RichiesteMW as TWM016FCambioOrarioMW;

  inherited;

  FFormat:=TFormatSettings.Create(LOCALE_SYSTEM_DEFAULT);
  FFormat.DateSeparator := '/';
  FFormat.TimeSeparator := ':';
  FFormat.ShortDateFormat := 'dd/mm/YYYY';
end;

procedure TWM016FRicCambioOrarioFM.UniFrameDestroy(Sender: TObject);
begin
  WM016MW:=nil;
  inherited;
  SessioneOracle.LogOff;
end;

procedure TWM016FRicCambioOrarioFM.OnNuovaRichiestaClick(Sender: TObject);
begin
  inherited;
  if WM016MW.ModalitaRichiesta = mrCambioOrario then
    rbtnCambio.RadioIcon.Checked:=True
  else
    rbtnInversione.RadioIcon.Checked:=True;

  if WM016MW.C90_WebTipoCambioOrario <> 'E' then
    pnlModRichiesta.Visible:=False;

  edtData.Date:=Now;
  AggiornaTabInserimentoRichiesta;
  AggiornaGiorni;
  AggiornaOrari;

  tpnlRichieste.Last;
end;

procedure TWM016FRicCambioOrarioFM.edtDataChange(Sender: TObject);
begin
  inherited;
  AggiornaGiorni;
  AggiornaOrari;
end;

procedure TWM016FRicCambioOrarioFM.cmbSecondoGiornoChange(Sender: TObject);
var LOrarioValido: TPair<String, String>;
begin
  inherited;
  if cmbSecondoGiorno.ItemIndex <> -1 then
  begin
    LOrarioValido:=WM016MW.GetOrarioValido(StrToDateTime(cmbSecondoGiorno.ListaCodici[cmbSecondoGiorno.ItemIndex], FFormat));
    lblOrarioRichiestoDesc.Caption:=LOrarioValido.Key + ' ' + LOrarioValido.Value;
  end;
end;

procedure TWM016FRicCambioOrarioFM.rbtnModRichiestaChange(Sender: TObject);
begin
  inherited;
  AggiornaTabInserimentoRichiesta;
  AggiornaGiorni;
  AggiornaOrari;
end;

procedure TWM016FRicCambioOrarioFM.chkSoloNoteClick(Sender: TObject);
begin
  inherited;
  AggiornaTabInserimentoRichiesta;
end;

procedure TWM016FRicCambioOrarioFM.AggiornaTabInserimentoRichiesta;
begin
  lblOrario.Visible:=not chkSoloNote.Checked;
  lblOrarioDesc.Visible:=not chkSoloNote.Checked;
  lblOrarioRichiesto.Visible:=not chkSoloNote.Checked;

  if rbtnCambio.RadioIcon.Checked then
  begin
    WM016MW.ModalitaRichiesta:=mrCambioOrario;
    lblGiorno.Caption:='Giorno';
    lblOrario.Caption:='Orario';
    lblSecondoGiorno.Visible:=False;
    cmbSecondoGiorno.Visible:=False;
    lblOrarioRichiesto.Caption:='Orario richiesto';
    cmbOrarioRichiesto.Visible:=not chkSoloNote.Checked;
    lblOrarioRichiestoDesc.Visible:=False;
  end
  else if rbtnInversione.RadioIcon.Checked then
  begin
    WM016MW.ModalitaRichiesta:=mrInversioneGiorno;
    lblGiorno.Caption:='Primo giorno';
    lblOrario.Caption:='Orario primo giorno';
    lblSecondoGiorno.Visible:=not chkSoloNote.Checked;
    cmbSecondoGiorno.Visible:=not chkSoloNote.Checked;
    lblOrarioRichiesto.Caption:='Orario secondo giorno';
    cmbOrarioRichiesto.Visible:=False;
    lblOrarioRichiestoDesc.Visible:=not chkSoloNote.Checked;
  end;
end;

procedure TWM016FRicCambioOrarioFM.AggiornaGiorni;
var i: Integer;
    LListaGiorni: TList<TDateTime>;
begin
  lblGiornoSett.Caption:=TFunzioniGenerali.NomeGiorno(edtData.Date) + ' (' + WM016MW.GetTipoGiornoEsteso(A000SessioneIrisWin.Parametri.ProgressivoOper, edtData.Date) + ')';

  if WM016MW.ModalitaRichiesta = mrInversioneGiorno then
  begin
    cmbSecondoGiorno.Clear;
    try
      LListaGiorni:=WM016MW.GetGiorniDisponibiliInversione(edtData.Date);

      for i:=0 to LListaGiorni.Count-1 do
        cmbSecondoGiorno.Add(FormatDateTime('dd/mm/yyyy', LListaGiorni[i]), R180NomeGiorno(LListaGiorni[i]) + ' (' + WM016MW.GetTipoGiornoEsteso(A000SessioneIrisWin.Parametri.ProgressivoOper, LListaGiorni[i]) + ')');

      if cmbSecondoGiorno.Count <> 0 then
      begin
        cmbSecondoGiorno.ItemIndex:=0;
        cmbSecondoGiornoChange(cmbSecondoGiorno);
      end;
    finally
      FreeAndNil(LListaGiorni);
    end;
  end;
end;

procedure TWM016FRicCambioOrarioFM.AggiornaOrari;
var LResCtrl: TResCtrl;
    LOrarioOriginale: TPair<String, String>;
    i: Integer;
begin
  LOrarioOriginale:=WM016MW.GetOrarioValido(edtData.Date);
  lblOrarioDesc.Caption:=LOrarioOriginale.Key + ' ' + LOrarioOriginale.Value;

  if WM016MW.ModalitaRichiesta = mrCambioOrario then
  begin
    cmbOrarioRichiesto.Clear;
    LResCtrl:=WM016MW.AggiornaListaOrari(edtData.Date, LOrarioOriginale);

    if not LResCtrl.Ok then
      ShowMessage(LResCtrl.Messaggio);

    for i:=0 to WM016MW.ListaOrario.Count-1 do
      cmbOrarioRichiesto.Add(WM016MW.ListaOrario[i].Key, WM016MW.ListaOrario[i].Value);

    cmbOrarioRichiesto.ItemIndex:=cmbOrarioRichiesto.IndexOfCode(LOrarioOriginale.Key);
  end;
end;

procedure TWM016FRicCambioOrarioFM.AggiornaHeaderDettaglio;
begin
  inherited;
  pnlEliminaRevoca.Button1.Visible:= WM016MW.FiltroStatoRichiesta = srDaAutorizzare;
end;

function TWM016FRicCambioOrarioFM.AggiornaListaDettaglio: TResCtrl;
var LCambioGiorno: Boolean;
    LCambioOrario: Boolean;
begin
  pnlListaDettaglio.Clear;

  LCambioGiorno:=Trunc(WM016MW.Data) <> Trunc(WM016MW.DataInver);
  LCambioOrario:=WM016MW.Orario.Key <> WM016MW.OrarioInver.Key;

  if Assigned(WM016MW) then
  begin
    pnlListaDettaglio.Add2Labels('Nominativo', WM016MW.Nominativo, False, 0, nil);
    pnlListaDettaglio.Add2Labels(ITEM_DATA_RICHIESTA_TEXT, FormatDateTime('dd/mm/yyyy hh:mm', WM016MW.DataRichiesta), False, 0, nil);
    pnlListaDettaglio.Add2Labels(IfThen(LCambioGiorno, 'Primo giorno', 'Giorno'), R180NomeGiorno(WM016MW.Data) + ' ' + FormatDateTime('dd/mm/yyyy', WM016MW.Data) + ' (' + WM016MW.GetTipoGiornoEsteso(WM016MW.Progressivo, WM016MW.Data) + ')', False, 0, nil);

    if WM016MW.SoloNote <> 'S' then
    begin
      if LCambioGiorno then
        pnlListaDettaglio.Add2Labels('Secondo giorno', R180NomeGiorno(WM016MW.DataInver) + ' ' + FormatDateTime('dd/mm/yyyy', WM016MW.DataInver) + ' (' + WM016MW.GetTipoGiornoEsteso(WM016MW.Progressivo, WM016MW.DataInver) + ')', False, 0, nil);

      pnlListaDettaglio.Add2Labels('Orario' + IfThen(LCambioOrario, ' originale', ''), WM016MW.Orario.Key + ' - ' + WM016MW.Orario.Value, False, 0, nil);

      if LCambioOrario then
        pnlListaDettaglio.Add2Labels('Orario richiesto', WM016MW.OrarioInver.Key + ' - ' + WM016MW.OrarioInver.Value, False, 0, nil);
    end;

    pnlListaDettaglio.Add2Labels('Autorizzazione', IfThen(WM016MW.AutorizzUtile = 'S', 'Si', IfThen(WM016MW.AutorizzUtile = 'N', 'No', WM016MW.AutorizzUtile)), False, 0, nil);
    pnlListaDettaglio.Add2Labels('Responsabile', Trim(WM016MW.NominativoResp), False, 0, nil);

    if WM016MW.SoloNote = 'S' then
      pnlListaDettaglio.Add2Labels('Solo note', '<i class="far fa-check-square"></i>', False, 0, nil);

    pnlListaDettaglio.Add2Labels(ITEM_NOTE_TEXT, ITEM_MORE_DETAILS, True, 0, OnDisclNoteClick);

    Result.Ok:=True;
  end
  else
  begin
    Result.Ok:=False;
    Result.Messaggio:='Errore: Oggetto WM016CambioOrarioMW non inizializzato, impossibile aggiornare il dettaglio';
  end;
end;

function TWM016FRicCambioOrarioFM.CreaLabelsRichiesta: TMedpUnimPanelBase;
var LCambioGiorno: Boolean;
    LCambioOrario: Boolean;
begin
  LCambioGiorno:=(Trunc(WM016MW.Data) <> Trunc(WM016MW.DataInver)) or (WM016MW.SoloNote = 'S');
  LCambioOrario:=(WM016MW.Orario.Key <> WM016MW.OrarioInver.Key) or (WM016MW.SoloNote = 'S');

  Result:=TMedpUnimPanel4Labels.Create(Self);

  with Result as TMedpUnimPanel4Labels do
  begin
    Constraints.MinHeight:=40;

    LayoutConfig.Height:='auto';
    Layout:='vbox';
    LayoutAttribs.Align:='center';
    LayoutAttribs.Pack:='start';

    Label1.Caption:='CAMBIO ' + IfThen(LCambioGiorno, 'GIORNO', '') + IfThen(LCambioGiorno and LCambioOrario, '/', '') + IfThen(LCambioOrario, 'ORARIO', '');
    Label1.Font.Style:=Label1.Font.Style + [fsBold];
    Label1.LayoutConfig.Width:='98%';
    Label1.JustifyContent:=JustifyStart;
    Label1.BoxModel.CSSMargin.Top:='2px';
    Label1.BoxModel.CSSMargin.Bottom:='2px';

    Label2.Caption:='Giorno: ' + FormatDateTime('dd/mm/yyyy', WM016MW.Data) + IfThen(LCambioGiorno and not (WM016MW.SoloNote = 'S'), ' <i class="fas fa-long-arrow-alt-right"></i> ' + FormatDateTime('dd/mm/yyyy', WM016MW.DataInver), '');
    Label2.LayoutConfig.Width:='98%';
    Label2.JustifyContent:=JustifyStart;
    Label3.BoxModel.CSSMargin.Bottom:='2px';

    if WM016MW.SoloNote = 'S' then
      Label3.Caption:='(solo note)'
    else
      Label3.Caption:='Orario:  ' + WM016MW.Orario.Key + IfThen(LCambioOrario, ' <i class="fas fa-long-arrow-alt-right"></i> ' + WM016MW.OrarioInver.Key, '');

    Label3.LayoutConfig.Width:='98%';
    Label3.BoxModel.CSSMargin.Bottom:='2px';
    Label3.JustifyContent:=JustifyStart;

    Label4.Caption:='';
    Label4.LayoutConfig.Width:='0%';
  end;
end;

function TWM016FRicCambioOrarioFM.ControllaEliminaRichiesta: TResCtrl;
begin
  inherited;
  Result.Clear;
  Result.Ok:=True;
end;

procedure TWM016FRicCambioOrarioFM.EliminaRichiesta;
var LResCtrl: TResCtrl;
    LRisposteMsg: TRisposteMsg;
begin
  inherited;
  LResCtrl:=WM016MW.EliminaRichiestaSRV(nil, nil, nil, LRisposteMsg);

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

function TWM016FRicCambioOrarioFM.ControllaRevocaRichiesta: TResCtrl;
begin
  raise Exception.Create('Funzione ControllaRevocaRichiesta non implementata');
end;

procedure TWM016FRicCambioOrarioFM.RevocaRichiesta;
begin
  raise Exception.Create('Funzione RevocaRichiesta non implementata');
end;

function TWM016FRicCambioOrarioFM.ControllaOkRichiesta: TResCtrl;
begin
  inherited;
  Result.Clear;

  if (WM016MW.ModalitaRichiesta = mrCambioOrario) and (cmbOrarioRichiesto.ItemIndex = -1) and not chkSoloNote.Checked then
  begin
    Result.Messaggio:='Selezionare un orario per il cambio';
    Exit;
  end;

  if (WM016MW.ModalitaRichiesta = mrInversioneGiorno) and (cmbSecondoGiorno.ItemIndex = -1) and not chkSoloNote.Checked then
  begin
    Result.Messaggio:='Selezionare un secondo giorno per il cambio';
    Exit;
  end;

  if Assigned(WM016MW.Richiesta) then
      WM016MW.Richiesta.Free;

  WM016MW.Richiesta:=TRichiestaCambioOrario.Create;
  try
    with WM016MW.Richiesta do
    begin
      Progressivo:=A000SessioneIrisWin.Parametri.ProgressivoOper;
      Data:=Trunc(edtData.Date);
      TipoGiorno:=WM016MW.GetTipoGiorno(Progressivo, Data);

      Note:=Trim(memNote.Memo.Text);
      SoloNote:=chkSoloNote.Checked;

      if SoloNote then
      begin
        CodOrario:='';
        CodOrarioInver:='';
        DataInver:=DATE_NULL;
        TipoGiornoInver:='';
      end
      else
      begin
        CodOrario:=Copy(lblOrarioDesc.Caption, 1, Pos(' ', lblOrarioDesc.Caption) - 1);

        if WM016MW.ModalitaRichiesta = mrCambioOrario then
        begin
          DataInver:=Trunc(Data);
          CodOrarioInver:=cmbOrarioRichiesto.ListaCodici[cmbOrarioRichiesto.ItemIndex];
          TipoGiornoInver:=TipoGiorno;
        end
        else
        begin
          DataInver:=StrToDateTime(cmbSecondoGiorno.ListaCodici[cmbSecondoGiorno.ItemIndex], FFormat);
          CodOrarioInver:=Copy(lblOrarioRichiestoDesc.Caption, 1, Pos(' ', lblOrarioRichiestoDesc.Caption) - 1);
          TipoGiornoInver:=WM016MW.GetTipoGiorno(Progressivo, DataInver);
        end;
      end;
    end;
  except
    on e: Exception do
    begin
      Result.Messaggio:='Errore nella creazione della richiesta: ' + E.Message;
      Exit;
    end;
  end;
  Result:=WM016MW.ControllaRichiesta;
end;

procedure TWM016FRicCambioOrarioFM.OkRichiesta;
var LResCtrl: TResCtrl;
    LModalResult: Integer;
    LRisposteMsg: TRisposteMsg;   //usato solo per retrocompatibilità con gestione B110
begin
  inherited;
  LResCtrl:=WM016MW.InserisciRichiestaSRV(nil, nil, nil, LRisposteMsg);

  if not LResCtrl.Ok then
  begin
    LModalResult:=MessageDlg(LResCtrl.Messaggio, TMsgDlgType.mtConfirmation, mbYesNo);

    if LModalResult = mrNo then
    begin
      WM016MW.AnnullaInserimentoRichiesta;
      Exit;
    end;
  end;

  LResCtrl:=WM016MW.ConfermaInserimentoRichiesta;

  if not LResCtrl.Ok then
    ShowMessage(LResCtrl.Messaggio)
  else
  begin
    ShowMessage('Inserimento effettuato');

    LResCtrl:=AggiornaListaRichieste;
    if not LResCtrl.Ok then
      ShowMessage(LResCtrl.Messaggio);

    tpnlRichieste.First;
  end;
end;

initialization
  RegisterClass(TWM016FRicCambioOrarioFM);

end.
