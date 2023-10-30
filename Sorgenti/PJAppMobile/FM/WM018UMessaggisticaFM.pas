unit WM018UMessaggisticaFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WM000UFrameBase, uniGUIBaseClasses, A000UInterfaccia,
  uniGUIClasses, uniGUImJSForm, MedpUnimPanelBase, uniPageControl, unimTabPanel, MedpUnimTypes,
  MedpUnimTabPanelBase, uniPanel, MedpUnimPanel2Labels, MedpUnimLabel, C180FunzioniGenerali,
  MedpUnimPanelDisclosure, uniImage, unimImage, uniLabel, unimLabel, A000UCostanti,
  MedpUnimLabelIcon, MedpUnimPanelIconLabel, MedpUnimPanelNumElem,  Generics.Collections,
  MedpUnimPanelListaElem, MedpUnimPanelListaDisclosure, MedpUnimPanelMessaggio, WM018UMessaggisticaDM,
  MedpUnimRadioGroup, MedpUnimPanelDataDaA, uniMultiItem, unimSelect, System.IoUtils,
  MedpUnimSelect, uniEdit, unimEdit, MedpUnimEdit, uniButton, uniBitBtn,
  unimBitBtn, MedpUnimButton, MedpUnimMemo, WM018UMessaggisticaMW, WM000UServerModule,
  MedpUnimPanelHeaderDett, uniCheckBox, unimCheckBox, StrUtils;

type
  TWM018FMessaggisticaFM = class(TWM000FFrameBase)
    tpnlMessaggistica: TMedpUnimTabPanelBase;
    tabRicevuti: TUnimTabSheet;
    tabInviati: TUnimTabSheet;
    tabDettaglioMessaggio: TUnimTabSheet;
    pnlHeaderRicevuti: TMedpUnimPanelBase;
    lblMessaggiRicevuti: TMedpUnimLabel;
    pnlOutboxNext: TMedpUnimPanelBase;
    imgOutboxNext: TUnimImage;
    lblOutboxNext: TMedpUnimLabel;
    imgInbox: TUnimImage;
    pnlHeaderInviati: TMedpUnimPanelBase;
    imgOutbox: TUnimImage;
    lblMessaggiInviati: TMedpUnimLabel;
    pnlInboxPrev: TMedpUnimPanelBase;
    imgInboxPrev: TUnimImage;
    lblInboxPrev: TMedpUnimLabel;
    pnlFiltroRicevuti: TMedpUnimPanelBase;
    pnlFiltroInviati: TMedpUnimPanelBase;
    pnlNumRicevuti: TMedpUnimPanelNumElem;
    pnlNumInviati: TMedpUnimPanelNumElem;
    pnlListaRicevuti: TMedpUnimPanelListaDisclosure;
    pnlListaInviati: TMedpUnimPanelListaDisclosure;
    pnlFiltroDataRic: TMedpUnimPanelDataDaA;
    lblFiltroDataRic: TMedpUnimLabel;
    cmbMittente: TMedpUnimSelect;
    lblFiltroRicevuti: TMedpUnimLabel;
    rgpFiltroRicevuti: TMedpUnimRadioGroup;
    pnlOggettoTestoRic: TMedpUnimPanelBase;
    edtOggettoTestoRic: TMedpUnimEdit;
    btnFiltroRicercaRic: TMedpUnimButton;
    lblDettOggetto: TMedpUnimLabel;
    pnlDettAllegati: TMedpUnimPanelBase;
    pnlNumAllegati: TMedpUnimPanelNumElem;
    pnlDettListaAllegati: TMedpUnimPanelListaDisclosure;
    memTestoMessaggio: TMedpUnimMemo;
    pnlHeaderDettMessaggio: TMedpUnimPanelHeaderDett;
    pnlDettMittente: TMedpUnimPanelBase;
    lblDettMittente: TMedpUnimLabel;
    lblDettObbligatorio: TMedpUnimLabel;
    lblDettLetto: TMedpUnimLabel;
    pnlDettMsgLetto: TMedpUnimPanelBase;
    lblDettMsgLetto: TMedpUnimLabel;
    pnlDettDateMessaggio: TMedpUnimPanel2Labels;
    chkDettMsgLetto: TUnimCheckBox;
    pnlOggettoTestoInv: TMedpUnimPanelBase;
    edtOggettoTestoInv: TMedpUnimEdit;
    btnFiltroRicercaInv: TMedpUnimButton;
    cmbSelAnagrafica: TMedpUnimSelect;
    pnlFiltroDataInv: TMedpUnimPanelDataDaA;
    pnlFiltroDataInvioInv: TMedpUnimPanelBase;
    lblFiltroDataInv: TMedpUnimLabel;
    chkInviatiInv: TUnimCheckBox;
    pnlChkFiltroInv: TMedpUnimPanelBase;
    pnlChkSospesiInv: TMedpUnimPanelBase;
    chkSospesiInv: TUnimCheckBox;
    lblSospesiInv: TMedpUnimLabel;
    pnlChkCancellatiInv: TMedpUnimPanelBase;
    chkCancellatiInv: TUnimCheckBox;
    lblCancellatiInv: TMedpUnimLabel;
    pnlTuttiInv: TMedpUnimPanelBase;
    chkTuttiInv: TUnimCheckBox;
    lblTuttiInv: TMedpUnimLabel;
    lblFiltroInviati: TMedpUnimLabel;
    tabDestinatari: TUnimTabSheet;
    lblDettDataLettura: TMedpUnimLabel;
    lblDettDestinatari: TMedpUnimLabel;
    pnlHeaderDettDestinatari: TMedpUnimPanelHeaderDett;
    rgpFiltroDestinatari: TMedpUnimRadioGroup;
    pnlListaDestinatari: TMedpUnimPanelListaElem;
    procedure UniFrameCreate(Sender: TObject);
    procedure UniFrameDestroy(Sender: TObject); override;
    procedure pnlOutboxNextClick(Sender: TObject);
    procedure pnlInboxPrevClick(Sender: TObject);
    procedure lblFiltroRicevutiClick(Sender: TObject);
    procedure lblFiltroInviatiClick(Sender: TObject);
    procedure pnlListaRicevutiChange(Sender: TObject);
    procedure pnlListaInviatiChange(Sender: TObject);
    procedure rgpFiltroRicevutiChange(Sender: TObject);
    procedure MessaggioRicevutoDisclosure(Sender: TObject);
    procedure pnlNumAllegatilblIconaClick(Sender: TObject);

    procedure AggiornaListaMessaggiRicevuti(Sender: TObject);
    procedure AggiornaListaMessaggiInviati(Sender: TObject);
    procedure DownloadAllegatoClick(Sender: TObject);
    procedure pnlHeaderDettMessaggiolblBackClick(Sender: TObject);
    procedure pnlHeaderDettMessaggiolblDownClick(Sender: TObject);
    procedure pnlHeaderDettMessaggiolblUpClick(Sender: TObject);
    procedure chkDettMsgLettoClick(Sender: TObject);
    procedure chkInviatiInvClick(Sender: TObject);
    procedure chkSospesiInvClick(Sender: TObject);
    procedure chkCancellatiInvClick(Sender: TObject);
    procedure chkTuttiInvClick(Sender: TObject);
    procedure pnlDettMittenteClick(Sender: TObject);
    procedure pnlHeaderDettDestinatarilblBackClick(Sender: TObject);
    procedure AggiornaListaDestinatari(Sender: TObject);
  private
    FFiltroRicevutiAperto: Boolean;
    FFiltroInviatiAperto: Boolean;
    FListaAllegatiAperta: Boolean;

    WM018MW: TWM018FMessaggisticaMW;

    procedure AggiornaDettaglioMessaggioRicevuto(PMessaggio: TMessaggioRicevuto);
    procedure AggiornaDettaglioMessaggioInviato(PMessaggio: TMessaggioInviato);
    procedure AggiornaListaAllegati(PListaAllegati: TObjectList<TAllegatoMessaggio>);

    procedure CreaSeparatore(PTesto: String);
    procedure SvuotaFiltroRicevutiOpzionale;
    procedure SvuotaFiltroInviatiOpzionale;
  protected
    procedure LoadCompleted; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWM018FMessaggisticaFM.UniFrameCreate(Sender: TObject);
begin
  inherited;
  FFiltroRicevutiAperto:=False;
  FFiltroInviatiAperto:=False;
  FListaAllegatiAperta:=False;

  imgInbox.Url:=WM000FServerModule.FilesFolderURL + 'img/inbox-white.png';
  imgOutbox.Url:=WM000FServerModule.FilesFolderURL + 'img/outbox-white.png';
  imgInboxPrev.Url:=WM000FServerModule.FilesFolderURL + 'img/inbox-blue.png';
  imgOutboxNext.Url:=WM000FServerModule.FilesFolderURL + 'img/outbox-blue.png';

  SessioneOracle.Preferences.UseOci7:=False;
  SessioneOracle.LogOn;
  SessioneOracle.UseOCI80:=not SessioneOracle.Preferences.UseOci7;
  tpnlMessaggistica.ActivePage:=tabRicevuti;

  WM018MW:=TWM018FMessaggisticaMW.Create(A000SessioneIrisWIN);
  WM018MW.Modalita:=TModalitaMessaggi.MMRicevuti;

  rgpFiltroRicevuti.ItemIndex:=0;
  pnlFiltroDataRic.DataDa.Date:=DATE_NULL;
  pnlFiltroDataRic.DataA.Date:=DATE_NULL;
  pnlFiltroDataRic.ClearIcon.Visible:=True;
  cmbMittente.ItemIndex:=-1;
  edtOggettoTestoRic.Text:='';

  chkSospesiInv.Checked:=True;
  chkInviatiInv.Checked:=True;
  pnlFiltroDataInv.DataDa.Date:=DATE_NULL;
  pnlFiltroDataInv.DataA.Date:=DATE_NULL;
  pnlFiltroDataInv.DataDa.Text:='';
  pnlFiltroDataInv.DataA.Text:='';
  pnlFiltroDataInv.ClearIcon.Visible:=True;
  cmbSelAnagrafica.Visible:=False;
  pnlOggettoTestoInv.Visible:=False;

  AggiornaListaMessaggiRicevuti(nil);
end;

procedure TWM018FMessaggisticaFM.UniFrameDestroy(Sender: TObject);
begin
  FreeAndNil(WM018MW);
  inherited;
  SessioneOracle.LogOff;
end;

procedure TWM018FMessaggisticaFM.LoadCompleted;
begin
  inherited;
  pnlOutboxNext.Visible:=AbilitazioneFunzione = 'S';

  if WM018MW.ObbligatoriDaLeggerePresenti then
    UniSession.AddJS('Ext.toast({message: "<i class=''fas fa-exclamation-triangle fa-2x'' style=''color: #157fcc;''></i><br><p style=''font-size:18px; margin-left: 5px; margin-right: 5px;''>  Sono presenti messaggi con lettura obbligatoria da leggere  </p>", timeout: 3000}); ');
end;

procedure TWM018FMessaggisticaFM.MessaggioRicevutoDisclosure(Sender: TObject);
var LMessaggio: TMessaggio;
begin
  if Sender is TMedpUnimPanelDisclosure then
  begin
    LMessaggio:=WM018MW.SelezionaMessaggioById((Sender as TMedpUnimPanelDisclosure).Key);

    if LMessaggio is TMessaggioRicevuto then
      AggiornaDettaglioMessaggioRicevuto(LMessaggio as TMessaggioRicevuto)
    else
      AggiornaDettaglioMessaggioInviato(LMessaggio as TMessaggioInviato);

    tpnlMessaggistica.ActivePage:=tabDettaglioMessaggio;
  end;
end;

procedure TWM018FMessaggisticaFM.pnlHeaderDettDestinatarilblBackClick(Sender: TObject);
begin
  inherited;
  tpnlMessaggistica.ActivePage:=tabDettaglioMessaggio;
end;

procedure TWM018FMessaggisticaFM.pnlHeaderDettMessaggiolblBackClick(Sender: TObject);
begin
  inherited;
  if WM018MW.Modalita=TModalitaMessaggi.MMRicevuti then
  begin
    AggiornaListaMessaggiRicevuti(Sender);
    tpnlMessaggistica.ActivePage:=tabRicevuti;
  end
  else
  begin
    AggiornaListaMessaggiInviati(Sender);
    tpnlMessaggistica.ActivePage:=tabInviati;
  end;
end;

procedure TWM018FMessaggisticaFM.pnlHeaderDettMessaggiolblDownClick(Sender: TObject);
begin
  inherited;

  if WM018MW.Next then
  begin
    if (WM018MW.MessaggioSelezionato is TMessaggioRicevuto) then
      AggiornaDettaglioMessaggioRicevuto(WM018MW.MessaggioSelezionato as TMessaggioRicevuto)
    else if True then
      AggiornaDettaglioMessaggioInviato(WM018MW.MessaggioSelezionato as TMessaggioInviato);
  end;
end;

procedure TWM018FMessaggisticaFM.pnlHeaderDettMessaggiolblUpClick(Sender: TObject);
begin
  inherited;

  if WM018MW.Prior then
  begin
    if (WM018MW.MessaggioSelezionato is TMessaggioRicevuto) then
      AggiornaDettaglioMessaggioRicevuto(WM018MW.MessaggioSelezionato as TMessaggioRicevuto)
    else if True then
      AggiornaDettaglioMessaggioInviato(WM018MW.MessaggioSelezionato as TMessaggioInviato);
  end;
end;

procedure TWM018FMessaggisticaFM.pnlListaInviatiChange(Sender: TObject);
begin
  inherited;
  pnlNumInviati.NumElementi:=pnlListaInviati.NumeroElementi;
end;

procedure TWM018FMessaggisticaFM.pnlListaRicevutiChange(Sender: TObject);
begin
  inherited;
  pnlNumRicevuti.NumElementi:=pnlListaRicevuti.NumeroElementi;
end;

procedure TWM018FMessaggisticaFM.pnlNumAllegatilblIconaClick(Sender: TObject);
begin
  inherited;
  if FListaAllegatiAperta then
  begin
    FListaAllegatiAperta:=False;
    pnlNumAllegati.Icona.JSInterface.JSCall('setStyle', ['transform: rotate(0turn)']);
    pnlDettAllegati.JSInterface.JSCall('setHeight',['35px']);
  end
  else
  begin
    FListaAllegatiAperta:=True;
    pnlNumAllegati.Icona.JSInterface.JSCall('setStyle', ['transform: rotate(0.5turn)']);
    pnlDettAllegati.JSInterface.JSCall('setHeight',[IntToStr(35+5+(43*pnlNumAllegati.NumElementi))+'px']);
  end;
end;

procedure TWM018FMessaggisticaFM.pnlOutboxNextClick(Sender: TObject);
begin
  inherited;
  WM018MW.Modalita:=TModalitaMessaggi.MMInviati;
  SvuotaFiltroInviatiOpzionale;
  AggiornaListaMessaggiInviati(Sender);
  tpnlMessaggistica.Next;
end;

procedure TWM018FMessaggisticaFM.pnlInboxPrevClick(Sender: TObject);
begin
  inherited;
  WM018MW.Modalita:=TModalitaMessaggi.MMRicevuti;
  SvuotaFiltroRicevutiOpzionale;
  AggiornaListaMessaggiRicevuti(Sender);
  tpnlMessaggistica.Prior;
end;

procedure TWM018FMessaggisticaFM.pnlDettMittenteClick(Sender: TObject);
begin
  inherited;
  if (WM018MW.Modalita = TModalitaMessaggi.MMInviati) and Assigned(WM018MW.MessaggioSelezionato) then
  begin
    if (WM018MW.MessaggioSelezionato as TMessaggioInviato).Destinatari = '' then
      Exit;

    rgpFiltroDestinatari.ItemIndex:=0;
    rgpFiltroDestinatari.Visible:=WM018MW.MessaggioSelezionato.Stato <> 'S';
    AggiornaListaDestinatari(Sender);
    tpnlMessaggistica.ActivePage:=tabDestinatari;
  end;
end;

procedure TWM018FMessaggisticaFM.lblFiltroInviatiClick(Sender: TObject);
begin
  inherited;
  FFiltroInviatiAperto:=not FFiltroInviatiAperto;

  if FFiltroInviatiAperto then
  begin
    lblFiltroInviati.Caption:='<i class="fas fa-angle-up"></i> Filtro messaggi <i class="fas fa-angle-up"></i>';
    pnlFiltroInviati.JSInterface.JSCall('setHeight',['210px']);
    cmbSelAnagrafica.Visible:=False;
  end
  else
  begin
    lblFiltroInviati.Caption:='<i class="fas fa-angle-down"></i> Filtro messaggi <i class="fas fa-angle-down"></i>';
    pnlFiltroInviati.JSInterface.JSCall('setHeight',['114px']);
    SvuotaFiltroInviatiOpzionale;
    AggiornaListaMessaggiInviati(Sender);
  end;

  cmbSelAnagrafica.Visible:=FFiltroInviatiAperto;
  pnlOggettoTestoInv.Visible:=FFiltroInviatiAperto;
end;

procedure TWM018FMessaggisticaFM.lblFiltroRicevutiClick(Sender: TObject);
begin
  inherited;
  FFiltroRicevutiAperto:=not FFiltroRicevutiAperto;

  if FFiltroRicevutiAperto then
  begin
    lblFiltroRicevuti.Caption:='<i class="fas fa-angle-up"></i> Filtro messaggi <i class="fas fa-angle-up"></i>';
    pnlFiltroRicevuti.JSInterface.JSCall('setHeight',['208px']);
  end
  else
  begin
    lblFiltroRicevuti.Caption:='<i class="fas fa-angle-down"></i> Filtro messaggi <i class="fas fa-angle-down"></i>';
    pnlFiltroRicevuti.JSInterface.JSCall('setHeight',['40px']);
    SvuotaFiltroRicevutiOpzionale;
    AggiornaListaMessaggiRicevuti(Sender);
  end;
end;

procedure TWM018FMessaggisticaFM.CreaSeparatore(PTesto: String);
var LLabels: TMedpUnimPanel2Labels;
begin
  LLabels:=TMedpUnimPanel2Labels.Create(Self);

  with LLabels do
  begin
    LayoutConfig.Height:='35';
    DaContare:=False;

    with Label1 do
    begin
      Caption:=PTesto;
      BoxModel.CSSMargin.Left:='10px';
      LayoutConfig.Height:='30';
      LayoutConfig.Width:='100%';
      Font.Style:=[fsBold];
      JustifyContent:=TJustifyContent.JustifyCenter;
    end;

    Label2.Visible:=False;
  end;

  if WM018MW.Modalita = TModalitaMessaggi.MMRicevuti then
    pnlListaRicevuti.AddHeader(LLabels)
  else
    pnlListaInviati.AddHeader(LLabels);
end;

procedure TWM018FMessaggisticaFM.AggiornaListaMessaggiRicevuti(Sender: TObject);
var i: Integer;
    LInizioObbl: Boolean;
    LInizioNonObbl: Boolean;
    LInizioLetti: Boolean;
    LCodMittente: String;
    LDaLeggere, LLetti, LCancellati: Boolean;
    LResCtrl: TResCtrl;
begin
  pnlListaRicevuti.Clear;

  LDaLeggere:=False;
  LLetti:=False;
  LCancellati:=False;

  case rgpFiltroRicevuti.ItemIndex of
    0 : LDaLeggere:=True;
    1 : LLetti:=True;
    3 : LCancellati:=True;
    else
    begin
      LDaLeggere:=True;
      LLetti:=True;
      LCancellati:=True;
    end;
  end;

  if cmbMittente.ItemIndex <> -1 then
    LCodMittente:=cmbMittente.ListaCodici[cmbMittente.ItemIndex]
  else
    LCodMittente:='';
  cmbMittente.Clear;

  LResCtrl:=WM018MW.AggiornaListaMessaggiRicevuti(pnlFiltroDataRic.DataDa.Date,
                                                  pnlFiltroDataRic.DataA.Date,
                                                  LDaLeggere, LLetti, LCancellati,
                                                  LCodMittente,
                                                  Trim(edtOggettoTestoRic.Text));
  if not LResCtrl.Ok then
  begin
    ShowMessage(LResCtrl.Messaggio);
    Exit;
  end;

  LInizioObbl:=True;
  LInizioNonObbl:=True;
  LInizioLetti:=True;

  with WM018MW do
  begin
    for i:=0 to ListaMessaggi.Count-1 do
    begin
      //gestione separatore messaggi ricevuti
      if ListaMessaggi[i].LetturaObbligatoria and ((ListaMessaggi[i] as TMessaggioRicevuto).DataLettura = DATE_NULL) and LInizioObbl then
      begin
        LInizioObbl:=False;
        CreaSeparatore('<i class="fas fa-exclamation-triangle"></i> OBBLIGATORI - <i class="fas fa-envelope"></i> DA LEGGERE');
      end
      else if (not ListaMessaggi[i].LetturaObbligatoria) and ((ListaMessaggi[i] as TMessaggioRicevuto).DataLettura = DATE_NULL) and LInizioNonObbl then
      begin
        LInizioNonObbl:=False;
        CreaSeparatore('<i class="fas fa-envelope"></i> DA LEGGERE');
      end
      else if ((ListaMessaggi[i] as TMessaggioRicevuto).DataLettura <> DATE_NULL) and LInizioLetti then
      begin
        LInizioLetti:=False;
        CreaSeparatore('<i class="fas fa-envelope-open-text"></i> LETTI');
      end;

      pnlListaRicevuti.Add(TMedpUnimPanelMessaggio.Create(pnlListaRicevuti,
                                                          'Da: ' + ListaMessaggi[i].CodMittente,
                                                          IfThen(ListaMessaggi[i].Oggetto.Length > 32, ListaMessaggi[i].Oggetto.Substring(0, 32) + '...', ListaMessaggi[i].Oggetto),
                                                          ListaMessaggi[i].LetturaObbligatoria,
                                                          ListaMessaggi[i].Allegati,
                                                          FormatDateTime('dd/MM/yyyy hh:mm', ListaMessaggi[i].DataInvio)
                                                          ), True, ListaMessaggi[i].Id, MessaggioRicevutoDisclosure, False);
    end;

    cmbMittente.Popola(ListaMittenti, '');
    cmbMittente.ItemIndex:=cmbMittente.IndexOfCode(LCodMittente);
  end;
end;

procedure TWM018FMessaggisticaFM.AggiornaListaMessaggiInviati(Sender: TObject);
var LListaMessaggi: TObjectList<TMessaggio>;
    i: Integer;
    LResCtrl: TResCtrl;
    LSospesi, LInviati, LCancellati: Boolean;
    LInizioInviati: Boolean;
    LInizioSospesi: Boolean;
    LInizioCancellati: Boolean;
    LSelAnagrafica: String;
begin
  pnlListaInviati.Clear;

  LSospesi:=chkSospesiInv.Checked or chkTuttiInv.Checked;
  LInviati:=chkInviatiInv.Checked or chkTuttiInv.Checked;
  LCancellati:=chkCancellatiInv.Checked or chkTuttiInv.Checked;

  if cmbSelAnagrafica.ItemIndex <> -1 then
    LSelAnagrafica:=cmbSelAnagrafica.ListaCodici[cmbSelAnagrafica.ItemIndex]
  else
    LSelAnagrafica:='';
  cmbSelAnagrafica.Clear;

  LResCtrl:=WM018MW.AggiornaListaMessaggiInviati(pnlFiltroDataInv.DataDa.Date,
                                                  pnlFiltroDataInv.DataA.Date,
                                                  LSospesi, LInviati, LCancellati,
                                                  LSelAnagrafica,
                                                  Trim(edtOggettoTestoInv.Text));
  if not LResCtrl.Ok then
  begin
    ShowMessage(LResCtrl.Messaggio);
    Exit;
  end;

  LInizioInviati:=True;
  LInizioSospesi:=True;
  LInizioCancellati:=True;

  with WM018MW do
  begin
    for i:=0 to ListaMessaggi.Count-1 do
    begin
      //gestione separatore messaggi inviati
      if (ListaMessaggi[i].Stato = 'I') and LInizioInviati then
      begin
        LInizioInviati:=False;
        CreaSeparatore('<i class="fas fa-paper-plane"></i> INVIATI');
      end
      else if (ListaMessaggi[i].Stato = 'S') and LInizioSospesi then
      begin
        LInizioSospesi:=False;
        CreaSeparatore('<i class="fas fa-stopwatch"></i> SOSPESI');
      end
      else if (ListaMessaggi[i].Stato = 'C') and LInizioCancellati then
      begin
        LInizioCancellati:=False;
        CreaSeparatore('<i class="fas fa-trash-alt"></i> CANCELLATI');
      end;

      pnlListaInviati.Add(TMedpUnimPanelMessaggio.Create(pnlListaInviati,
                                                         'A: ' + (ListaMessaggi[i] as TMessaggioInviato).Destinatari + IfThen((ListaMessaggi[i] as TMessaggioInviato).DestTotali > 2, ', ...', ''),
                                                         IfThen(ListaMessaggi[i].Oggetto.Length > 32, ListaMessaggi[i].Oggetto.Substring(0, 32) + '...', ListaMessaggi[i].Oggetto),
                                                         ListaMessaggi[i].LetturaObbligatoria,
                                                         ListaMessaggi[i].Allegati,
                                                         IfThen(ListaMessaggi[i].Stato = 'S', 'Sospeso', FormatDateTime('dd/MM/yyyy hh:mm', ListaMessaggi[i].DataInvio))),
                                                         True,
                                                         ListaMessaggi[i].Id,
                                                         MessaggioRicevutoDisclosure,
                                                         False);
    end;

    cmbSelAnagrafica.Popola(ListaSelAnagrafica, '');
    cmbSelAnagrafica.ItemIndex:=cmbSelAnagrafica.IndexOfCode(LSelAnagrafica);
  end;
end;

procedure TWM018FMessaggisticaFM.AggiornaDettaglioMessaggioRicevuto(PMessaggio: TMessaggioRicevuto);
var LResCtrl: TResCtrl;
begin
  if Assigned(PMessaggio) then
  begin
    LResCtrl:=WM018MW.AggiornaStatoRicezione;
    if not LResCtrl.Ok then
      ShowMessage('Errore nell''aggiornamento dello stato di ricezione: ' + LResCtrl.Messaggio);

    FListaAllegatiAperta:=False;
    pnlNumAllegati.Icona.JSInterface.JSCall('setStyle', ['transform: rotate(0turn)']);
    pnlDettAllegati.JSInterface.JSCall('setHeight',['35px']);

    if PMessaggio.Allegati then
    begin
      LResCtrl:=WM018MW.AggiornaAllegatiMessaggio(PMessaggio);
      if not LResCtrl.Ok then
        ShowMessage('Errore nell''aggiornamento della lista degli allegati: ' + LResCtrl.Messaggio);
    end;

    pnlHeaderDettMessaggio.Down.Visible:=not WM018MW.Eof;
    pnlHeaderDettMessaggio.Up.Visible:=not (WM018MW.IdxMessaggio = 0);

    lblDettMittente.Text:='Da: ' + PMessaggio.CodMittente + ' - ' + PMessaggio.DescrMittente;
    pnlDettDateMessaggio.Label1.Caption:='Invio:<br>' + FormatDateTime('dd/MM/yyyy hh:mm', PMessaggio.DataInvio);
    pnlDettDateMessaggio.Label2.Caption:='Ricezione:<br>' + FormatDateTime('dd/MM/yyyy hh:mm', (PMessaggio as TMessaggioRicevuto).DataRicezione);
    pnlDettMsgLetto.Visible:=PMessaggio.Stato <> 'C'; //solo se non cancellato
    chkDettMsgLetto.Checked:=(PMessaggio as TMessaggioRicevuto).DataLettura <> DATE_NULL;
    lblDettOggetto.Caption:=PMessaggio.Oggetto;
    memTestoMessaggio.Memo.Lines.Text:=PMessaggio.Testo;
    lblDettObbligatorio.Visible:=PMessaggio.LetturaObbligatoria;
    if (PMessaggio as TMessaggioRicevuto).DataLettura <> DATE_NULL then
    begin
      lblDettLetto.Caption:='<i class="fas fa-envelope-open-text"></i>';
      lblDettDataLettura.Caption:=FormatDateTime('dd/MM/yyyy hh:mm', (PMessaggio as TMessaggioRicevuto).DataLettura);
    end
    else
    begin
      lblDettLetto.Caption:='<i class="fas fa-envelope"></i>';
      lblDettDataLettura.Caption:='';
    end;

    if not Assigned(PMessaggio.ListaAllegati) then
      pnlNumAllegati.NumElementi:=0
    else
      AggiornaListaAllegati(PMessaggio.ListaAllegati);

    lblDettDestinatari.Visible:=False;
    pnlDettDateMessaggio.BoxModel.CSSMargin.Bottom:='0px';
  end;
end;

procedure TWM018FMessaggisticaFM.AggiornaDettaglioMessaggioInviato(PMessaggio: TMessaggioInviato);
var LResCtrl: TResCtrl;
begin
  if Assigned(PMessaggio) then
  begin
    FListaAllegatiAperta:=False;
    pnlNumAllegati.Icona.JSInterface.JSCall('setStyle', ['transform: rotate(0turn)']);
    pnlDettAllegati.JSInterface.JSCall('setHeight',['35px']);

    if PMessaggio.Allegati then
    begin
      LResCtrl:=WM018MW.AggiornaAllegatiMessaggio(PMessaggio);
      if not LResCtrl.Ok then
        ShowMessage('Errore nell''aggiornamento della lista degli allegati: ' + LResCtrl.Messaggio);
    end;

    pnlHeaderDettMessaggio.Down.Visible:=not WM018MW.Eof;
    pnlHeaderDettMessaggio.Up.Visible:=not (WM018MW.IdxMessaggio = 0);

    lblDettMittente.Text:='A: ' + PMessaggio.Destinatari + IfThen(PMessaggio.DestTotali > 2, ', ...', '');
    pnlDettDateMessaggio.Label1.Caption:=IfThen(PMessaggio.DestTotali = 0, '', 'Ricevuto:<br>' + PMessaggio.DestRicevuti.ToString + '/' + PMessaggio.DestTotali.ToString + ' destinatar' + IfThen(PMessaggio.DestTotali = 1, 'io', 'i'));
    pnlDettDateMessaggio.Label2.Caption:=IfThen(PMessaggio.DestTotali = 0, '', 'Letto:<br>' + PMessaggio.DestLetti.ToString + '/' + PMessaggio.DestTotali.ToString + ' destinatar' + IfThen(PMessaggio.DestTotali = 1, 'io', 'i'));
    pnlDettMsgLetto.Visible:=False;

    lblDettOggetto.Caption:=PMessaggio.Oggetto;
    memTestoMessaggio.Memo.Lines.Text:=PMessaggio.Testo;
    lblDettObbligatorio.Visible:=PMessaggio.LetturaObbligatoria;

    if PMessaggio.DestLetti = PMessaggio.DestTotali then
      lblDettLetto.Caption:='<i class="fas fa-envelope-open-text"></i>'
    else
      lblDettLetto.Caption:='<i class="fas fa-envelope"></i>';

    if not Assigned(PMessaggio.ListaAllegati) then
      pnlNumAllegati.NumElementi:=0
    else
      AggiornaListaAllegati(PMessaggio.ListaAllegati);

    lblDettDestinatari.Visible:=True;
    pnlDettDateMessaggio.BoxModel.CSSMargin.Bottom:='8px';
  end;
end;

procedure TWM018FMessaggisticaFM.AggiornaListaAllegati(PListaAllegati: TObjectList<TAllegatoMessaggio>);
var i: Integer;
    tempPnl: TMedpUnimPanel2Labels;
begin
  if Assigned(PListaAllegati) then
  begin
    pnlNumAllegati.NumElementi:=PListaAllegati.Count;
    pnlNumAllegati.Icona.Visible:=PListaAllegati.Count > 0;

    pnlDettListaAllegati.Clear;
    for i:=0 to PListaAllegati.Count-1 do
    begin
      tempPnl:=TMedpUnimPanel2Labels.Create(pnlDettListaAllegati);

      with tempPnl do
      begin
        LayoutAttribs.Pack:='justify';
        BoxModel.CSSPadding.Right:='8px';
        BoxModel.CSSPadding.Left:='5px';

        Label1.Caption:=PListaAllegati[i].Nome;
        Label1.Flex:=1;
        Label1.Font.Size:=12;
        Label1.JustifyContent:=TJustifyContent.JustifyStart;
        Label1.LayoutConfig.Height:='auto';
        Label2.Caption:=R180GetFileSizeStr(PListaAllegati[i].Dimensione);
        Label2.Flex:=0;
        Label2.Font.Size:=12;
        Label2.LayoutConfig.Height:='auto';
        Label2.LayoutConfig.Width:='auto';
      end;

      pnlDettListaAllegati.Add(tempPnl, True, PListaAllegati[i].Nome, DownloadAllegatoClick, True, 14);
    end;
  end;
end;

procedure TWM018FMessaggisticaFM.AggiornaListaDestinatari(Sender: TObject);
var i: Integer;
    LPanel: TMedpUnimPanel2Labels;
    LFiltro: TFiltroDestinatari;
    LResCtrl: TResCtrl;
begin
  pnlListaDestinatari.Clear;

  if Assigned(WM018MW.MessaggioSelezionato) and (WM018MW.MessaggioSelezionato is TMessaggioInviato) then
  begin
    case rgpFiltroDestinatari.ItemIndex of
      0: LFiltro:=TFiltroDestinatari.FDTutti;
      1: LFiltro:=TFiltroDestinatari.FDRicevuto;
      2: LFiltro:=TFiltroDestinatari.FDNonRicevuto;
      else LFiltro:=TFiltroDestinatari.FDTutti;
    end;

    LResCtrl:=WM018MW.AggiornaDestMessaggioSelezionato(LFiltro);
    if not LResCtrl.Ok then
    begin
      ShowMessage('Errore nell''aggiornamento della lista dei destinatari: ' + LResCtrl.Messaggio);
      Exit;
    end;

    with WM018MW.MessaggioSelezionato as TMessaggioInviato do
    begin
      for i:=0 to ListaDestinatari.Count-1 do
      begin
        LPanel:=TMedpUnimPanel2Labels.Create(pnlListaDestinatari);

        if ListaDestinatari[i] is TDestinatarioWeb then
          LPanel.Label1.Caption:=Format('Matr. %s<br>%s %s', [(ListaDestinatari[i] as TDestinatarioWeb).Matricola, (ListaDestinatari[i] as TDestinatarioWeb).Cognome, (ListaDestinatari[i] as TDestinatarioWeb).Nome])
        else
          LPanel.Label1.Caption:='Operatore:<br>' + (ListaDestinatari[i] as TDestinatarioWin).Utente;

        if ListaDestinatari[i].DataRicezione = DATE_NULL then
          LPanel.Label2.Caption:='Ricevuto:<br>-'
        else
          LPanel.Label2.Caption:='Ricevuto:<br>' + FormatDateTime('dd/MM/yyyy hh:mm', ListaDestinatari[i].DataRicezione);

        if Stato <> 'S' then
        begin
          LPanel.Label1.JustifyContent:=TJustifyContent.JustifyStart;
          LPanel.Label1.Font.Size:=13;
          LPanel.Label2.JustifyContent:=TJustifyContent.JustifyStart;
          LPanel.Label2.Font.Size:=13;
        end
        else
        begin
          LPanel.Label1.JustifyContent:=TJustifyContent.JustifyCenter;
          LPanel.Label1.Font.Size:=13;
          LPanel.Label2.Visible:=False;
        end;

        LPanel.BoxModel.CSSPadding.Top:='5px';
        LPanel.BoxModel.CSSPadding.Bottom:='5px';
        LPanel.BoxModel.CSSPadding.Left:='5px';
        LPanel.BoxModel.CSSPadding.Right:='5px';

        pnlListaDestinatari.Add(LPanel);
      end;
    end;
  end;
end;

procedure TWM018FMessaggisticaFM.DownloadAllegatoClick(Sender: TObject);
var LNomeFile, LRandomFolder, LPathFile: String;
    LResCtrl: TResCtrl;
begin
  if Sender is TMedpUnimPanelDisclosure then
  begin
    repeat
      LRandomFolder:=IntToStr(Random(9999));
      LPathFile:=TPath.Combine(WM000FServerModule.LocalCachePath,LRandomFolder);
    until not DirectoryExists(LPathFile);

    LNomeFile:=(Sender as TMedpUnimPanelDisclosure).Key;

    LResCtrl:=WM018MW.DownloadAllegato(WM018MW.MessaggioSelezionato.Id, LNomeFile, LPathFile);
    if not LResCtrl.Ok then
    begin
      ShowMessage(LResCtrl.Messaggio);
      Exit;
    end;

    UniSession.AddJS('window.open("' + WM000FServerModule.GlobalCacheURL + UniSession.SessionId + '/' + LRandomFolder + '/' + LNomeFile +'", "_blank")');
  end;
end;

procedure TWM018FMessaggisticaFM.chkDettMsgLettoClick(Sender: TObject);
var LResCtrl: TResCtrl;
begin
  inherited;
  if WM018MW.MessaggioSelezionato is TMessaggioRicevuto then
  begin
    WM018MW.AggiornaStatoLettura(chkDettMsgLetto.Checked);
    if not LResCtrl.Ok then
    begin
      ShowMessage(LResCtrl.Messaggio);
      Exit;
    end;

    if (WM018MW.MessaggioSelezionato as TMessaggioRicevuto).DataLettura <> DATE_NULL then
    begin
      lblDettLetto.Caption:='<i class="fas fa-envelope-open-text"></i>';
      lblDettDataLettura.Caption:=FormatDateTime('dd/MM/yyyy hh:mm', (WM018MW.MessaggioSelezionato as TMessaggioRicevuto).DataLettura);
    end
    else
    begin
      lblDettLetto.Caption:='<i class="fas fa-envelope"></i>';
      lblDettDataLettura.Caption:='';
    end;
  end;
end;

procedure TWM018FMessaggisticaFM.chkInviatiInvClick(Sender: TObject);
begin
  inherited;
  if not (chkInviatiInv.Checked or chkSospesiInv.Checked or chkCancellatiInv.Checked) then
  begin
    chkInviatiInv.Checked:=True;
    Exit;
  end;

  chkTuttiInv.Checked:=chkInviatiInv.Checked and chkSospesiInv.Checked and chkCancellatiInv.Checked;

  pnlFiltroDataInv.DataDa.Enabled:=chkInviatiInv.Checked;
  pnlFiltroDataInv.DataA.Enabled:=chkInviatiInv.Checked;
  pnlFiltroDataInv.ClearIcon.CSSColor:=IfThen(chkInviatiInv.Checked, '#b0b0b0', '#e6e6e6');

  if not chkInviatiInv.Checked then
  begin
    pnlFiltroDataInv.DataDa.Date:=DATE_NULL;
    pnlFiltroDataInv.DataA.Date:=DATE_NULL;
    pnlFiltroDataInv.DataDa.Text:='';
    pnlFiltroDataInv.DataA.Text:='';
  end;

  AggiornaListaMessaggiInviati(Sender);
end;

procedure TWM018FMessaggisticaFM.chkSospesiInvClick(Sender: TObject);
begin
  inherited;
  if not (chkInviatiInv.Checked or chkSospesiInv.Checked or chkCancellatiInv.Checked) then
  begin
    chkSospesiInv.Checked:=True;
    Exit;
  end;

  chkTuttiInv.Checked:=chkInviatiInv.Checked and chkSospesiInv.Checked and chkCancellatiInv.Checked;
  AggiornaListaMessaggiInviati(Sender);
end;

procedure TWM018FMessaggisticaFM.chkCancellatiInvClick(Sender: TObject);
begin
  inherited;
  if not (chkInviatiInv.Checked or chkSospesiInv.Checked or chkCancellatiInv.Checked) then
  begin
    chkCancellatiInv.Checked:=True;
    Exit;
  end;

  chkTuttiInv.Checked:=chkInviatiInv.Checked and chkSospesiInv.Checked and chkCancellatiInv.Checked;
  AggiornaListaMessaggiInviati(Sender);
end;

procedure TWM018FMessaggisticaFM.chkTuttiInvClick(Sender: TObject);
begin
  inherited;

  if chkTuttiInv.Checked then
  begin
    chkInviatiInv.Checked:=True;
    chkSospesiInv.Checked:=True;
    chkCancellatiInv.Checked:=True;

    chkInviatiInvClick(Sender);

    AggiornaListaMessaggiInviati(Sender);
  end
  else
    chkTuttiInv.Checked:=True;
end;

procedure TWM018FMessaggisticaFM.rgpFiltroRicevutiChange(Sender: TObject);
begin
  inherited;
  SvuotaFiltroRicevutiOpzionale;

  if rgpFiltroRicevuti.ItemIndex = 3 then
  begin
    pnlFiltroDataRic.DataDa.Enabled:=False;
    pnlFiltroDataRic.DataA.Enabled:=False;
    pnlFiltroDataRic.ClearIcon.CSSColor:='#e6e6e6';
  end
  else
  begin
    pnlFiltroDataRic.DataDa.Enabled:=True;
    pnlFiltroDataRic.DataA.Enabled:=True;
    pnlFiltroDataRic.ClearIcon.CSSColor:='#b0b0b0';
  end;

  AggiornaListaMessaggiRicevuti(Sender);
end;

procedure TWM018FMessaggisticaFM.SvuotaFiltroInviatiOpzionale;
begin
  cmbSelAnagrafica.ItemIndex:=-1;
  edtOggettoTestoInv.Text:='';
end;

procedure TWM018FMessaggisticaFM.SvuotaFiltroRicevutiOpzionale;
begin
  pnlFiltroDataRic.DataDa.Text:='';
  pnlFiltroDataRic.DataA.Text:='';
  pnlFiltroDataRic.DataDa.Date:=DATE_NULL;
  pnlFiltroDataRic.DataA.Date:=DATE_NULL;
  cmbMittente.ItemIndex:=-1;
  edtOggettoTestoRic.Text:='';
end;

initialization
  RegisterClass(TWM018FMessaggisticaFM);

end.
