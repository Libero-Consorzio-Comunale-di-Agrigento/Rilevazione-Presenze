unit WA091ULiquidPresenze;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  A000UMessaggi,
  A091ULiquidPresenzeMW,
  C180FunzioniGenerali,
  C190FunzioniGeneraliWeb,
  FunzioniGenerali,
  WR100UBase,
  WA091ULiquidPresenzeDM,
  WC013UCheckListFM,
  medpIWMessageDlg,
  SysUtils, Variants, Classes, System.DateUtils,
  IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, medpIWC700NavigatorBar, IWCompEdit, meIWEdit, IWCompLabel, meIWLabel,
  meIWRadioGroup, IWCompCheckbox, meIWCheckBox, StrUtils, meIWImageFile,
  medpIWImageButton, IWAdvCheckGroup, meTIWAdvCheckGroup,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  medpIWTabControl, IWDBGrids, medpIWDBGrid, Menus,
  IWCompListbox, meIWComboBox, Vcl.Controls, Vcl.Forms;

type
  TTipoValore = (tvZero, tvLiquidato);

  TWA091FLiquidPresenze = class(TWR100FBase)
    grdTabDetail: TmedpIWTabControl;
    WA091ParametriRG: TIWRegion;
    lblAnno: TmeIWLabel;
    lblCausale: TmeIWLabel;
    edtAnno: TmeIWEdit;
    edtCausale: TmeIWEdit;
    btnCausali: TmeIWButton;
    lblLiquidazione: TmeIWLabel;
    lblArrotLiq: TmeIWLabel;
    edtArrotLiq: TmeIWEdit;
    lblMaxLiq: TmeIWLabel;
    edtMaxLiq: TmeIWEdit;
    lblCompensazione: TmeIWLabel;
    lblArrotComp: TmeIWLabel;
    edtArrotComp: TmeIWEdit;
    lblMaxComp: TmeIWLabel;
    edtMaxComp: TmeIWEdit;
    rgpDisponibilita: TmeIWRadioGroup;
    lblDisponibilita: TmeIWLabel;
    chkAggiornamento: TmeIWCheckBox;
    chkSaltoPagina: TmeIWCheckBox;
    chkTotaliRaggr: TmeIWCheckBox;
    chkTotaliGenerali: TmeIWCheckBox;
    imgSoloAggiornamento: TmedpIWImageButton;
    imgAnomalie: TmedpIWImageButton;
    cgpDettaglio: TmeTIWAdvCheckGroup;
    lblDettaglio: TmeIWLabel;
    TemplateParametriRG: TIWTemplateProcessorHTML;
    WA091RisultatiRG: TIWRegion;
    grdRisultati: TmedpIWDBGrid;
    TemplateRisultatiRG: TIWTemplateProcessorHTML;
    imgAnteprima: TmedpIWImageButton;
    pmnGrid: TPopupMenu;
    actScaricaInExcel: TMenuItem;
    btnConfermaDati: TmeIWButton;
    btnAnnullaDati: TmeIWButton;
    btnModificaDati: TmeIWButton;
    btnLiquida: TmeIWButton;
    btnImpostaLiquidato: TmeIWButton;
    lblMeseDa: TmeIWLabel;
    cmbMeseDa: TmeIWComboBox;
    lblMeseA: TmeIWLabel;
    cmbMeseA: TmeIWComboBox;
    chkAnnullaLiquidazione: TmeIWCheckBox;
    chkLiquidazioni: TmeIWCheckBox;
    chkCompensazioni: TmeIWCheckBox;
    lblMessaggio: TmeIWLabel;
    actScaricaInCSV: TMenuItem;
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnCausaliClick(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure imgSoloAggiornamentoClick(Sender: TObject);
    procedure imgAnomalieClick(Sender: TObject);
    procedure chkAggiornamentoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure grdRisultatiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdTabDetailTabControlChange(Sender: TObject);
    procedure actScaricaInExcelClick(Sender: TObject);
    procedure btnConfermaDatiClick(Sender: TObject);
    procedure btnModificaDatiClick(Sender: TObject);
    procedure btnAnnullaDatiClick(Sender: TObject);
    procedure btnLiquidaClick(Sender: TObject);
    procedure btnImpostaLiquidatoClick(Sender: TObject);
    procedure grdRisultatiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure chkAnnullaLiquidazioneAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure chkLiquidazioniAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure chkCompensazioniAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure edtAnnoAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure cmbMeseDaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure cmbMeseAAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure actScaricaInCSVClick(Sender: TObject);
  private
    FMeseInizio: TDateTime;
    FMeseFine: TDateTime;
    FElencoCausali: string;
    FDataUltimaLiquidazione: TDateTime;
    FMeseElaborazione: TDateTime;
    A091MW: TA091FLiquidPresenzeMW;
//    DataElab: TDateTime;
    RicaricaGridRisultati: Boolean;
    //AnnullaLiquidazioni: Boolean;
    //AnnullaCompensazioni: Boolean;
    FLiquidazioneInModifica: Boolean;
    SenderHTMLName: String;
    WA091FLiquidPresenzeDM: TWA091FLiquidPresenzeDM;
    FLstCausali: TStringList;
    FLstPagineBloccate: TStringList;
    procedure OnPeriodoModificato;
    procedure OnImpostazioniModificate;
    function IsAnnullaLiq: Boolean; inline;
    procedure AggiungiCampiIntestazioneDettaglioSelAnag;
    procedure cklistCausaliResult(Sender: TObject; Result: Boolean);
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    function VerificaAnno: Boolean;
    procedure ConfermaDati;
    procedure SetLiquidazioneInModifica(const PInModifica: Boolean);
    procedure AnnullaDati;
    procedure VisualizzaModificaLiquidazione(PVisualizza: Boolean);
    procedure ImpostaValoriLiquidato(PTipoValore: TTipoValore);
    function ConfermaLiquidazione(var RErrMsg: String): Boolean;
    procedure DoAggiornamento;
    procedure OnConfermaAggiornamento(Sender: TObject; Res: TmeIWModalResult;
      KeyID: String);
  protected
    procedure WC700AperturaSelezione(Sender: TObject); override;
    procedure ImpostazioniWC700; override;
    procedure InizializzaMsgElaborazione; override;
    procedure InizioElaborazione; override;
    function CurrentRecordElaborazione: Integer; override;
    function TotalRecordsElaborazione: Integer; override;
    procedure DistruzioneOggettiElaborazione(Errore: Boolean); override;
    procedure ElaboraElemento; override;
    function ElementoSuccessivo: Boolean; override;
    procedure FineCicloElaborazione; override;
    function ElaborazioneTerminata:String; override;
  public
    function InizializzaAccesso:Boolean; override;
    procedure WC700CambioProgressivo(Sender: TObject); override;
  end;

implementation

uses
  IWApplication;

{$R *.dfm}

procedure TWA091FLiquidPresenze.IWAppFormCreate(Sender: TObject);
begin
  grdTabDetail.AggiungiTab('Parametri',WA091ParametriRG);
  grdTabDetail.AggiungiTab('Risultati',WA091RisultatiRG);
  grdTabDetail.HasFiller:=True;
  grdTabDetail.ActiveTab:=WA091ParametriRG;

  inherited;

  // imposta come mese di elaborazione quello della data lavoro
  FMeseElaborazione:=R180InizioMese(Parametri.DataLavoro);

  grdC700:=TmedpIWC700NavigatorBar.Create(Self);//Alberto: creato prima di AttivaGestioneC700 per impostare le altre proprietà non standard
  //Massimo 23/07/2103 con questo codice non eredita la selezione anagrafe
  //grdC700.ImpostaProgressivoCorrente:=False;
  grdC700.ImpostaProgressivoCorrente:=True;
  grdC700.AttivaBrowse:=False;

  AttivaGestioneC700;
  WA091FLiquidPresenzeDM:=TWA091FLiquidPresenzeDM.Create(Self);
  WA091FLiquidPresenzeDM.A091FLiquidPresenzeMW.SelAnagrafe:=grdC700.selAnagrafe;
  A091MW:=WA091FLiquidPresenzeDM.A091FLiquidPresenzeMW;
  FLstCausali:=TStringList.Create;
  FLstPagineBloccate:=TStringList.Create;
end;

function TWA091FLiquidPresenze.InizializzaAccesso: Boolean;
var
  i: Integer;
  LMese: Integer;
begin
  // imposta anno
  edtAnno.Text:=FormatDateTime('yyyy',Parametri.DataLavoro);

  LMese:=Parametri.DataLavoro.Month;
  cmbMeseDa.OnAsyncChange:=nil;
  try
    cmbMeseDa.ItemIndex:=LMese - 1;
  finally
    cmbMeseDa.OnAsyncChange:=cmbMeseDaAsyncChange;
  end;

  cmbMeseA.OnAsyncChange:=nil;
  try
    cmbMeseA.ItemIndex:=LMese - 1;
  finally
    cmbMeseA.OnAsyncChange:=cmbMeseAAsyncChange;
  end;

  chkAggiornamento.Enabled:=not SolaLettura;
  imgSoloAggiornamento.Enabled:=chkAggiornamento.Checked;
  imgAnomalie.Enabled:=False;

  // gestione liquidazione manuale
  VisualizzaModificaLiquidazione(False);

  with WA091FLiquidPresenzeDM.A091FLiquidPresenzeMW do
    for i:=0 to LstCampiAnagrafe.Count - 1 do
    begin
      cgpDettaglio.Items.Add(LstCampiAnagrafe[i]);
    end;

  GetParametriFunzione;

  // forza impostazioni form
  OnPeriodoModificato;

  RicaricaGridRisultati:=False;
  grdRisultati.medpPaginazione:=True;
  grdRisultati.medpRighePagina:=18;
  grdTabDetail.Tabs[WA091RisultatiRG].Enabled:=False;
  Result:=True;
end;

procedure TWA091FLiquidPresenze.OnPeriodoModificato;
begin
  // determina i mesi di riferimento
  FMeseInizio:=EncodeDate(StrToInt(edtAnno.Text),cmbMeseDa.ItemIndex + 1,1);
  FMeseFine:=EncodeDate(StrToInt(edtAnno.Text),cmbMeseA.ItemIndex + 1,1);

  // gestione modifica impostazioni
  OnImpostazioniModificate;
end;

procedure TWA091FLiquidPresenze.OnImpostazioniModificate;
var
  LIsMeseSingolo: Boolean;
  LAnnullaLiq: Boolean;
  LAnnullamentoConsentito: Boolean;
begin
  // determina se il periodo è di un singolo mese
  LIsMeseSingolo:=(FMeseInizio = FMeseFine);

  // impostazioni opzioni
  chkAggiornamento.Enabled:=not SolaLettura;
  if not chkAggiornamento.Enabled then
    chkAggiornamento.Checked:=False;

  // annullamento liquidazione
  chkAnnullaLiquidazione.Enabled:=not SolaLettura;
  if not chkAnnullaLiquidazione.Enabled then
    chkAnnullaLiquidazione.Checked:=False;

  // abilita l'opzione di annullamento liquidazioni
  chkLiquidazioni.Enabled:=chkAnnullaLiquidazione.Checked;
  if not chkLiquidazioni.Enabled then
    chkLiquidazioni.Checked:=False;

  // abilita l'opzione di annullamento compensazioni
  chkCompensazioni.Enabled:=chkAnnullaLiquidazione.Checked;
  if not chkCompensazioni.Enabled then
    chkCompensazioni.Checked:=False;

  if IsAnnullaLiq then
  begin
    // determina la data dell'ultimo mese da annullare
    FDataUltimaLiquidazione:=A091MW.GetDataUltimaLiquidazioneAnno(FMeseInizio,FElencoCausali,chkLiquidazioni.Checked,chkCompensazioni.Checked);
  end
  else
    FDataUltimaLiquidazione:=DATE_NULL;

  // visualizza data ultima liquidazione
  LAnnullaLiq:=IsAnnullaLiq;
  LAnnullamentoConsentito:=LAnnullaLiq and (R180Between(FDataUltimaLiquidazione,FMeseInizio,FMeseFine));
  lblMessaggio.Css:=C190ImpostaCssNascosto(lblMessaggio.Css,LAnnullaLiq);
  if not lblMessaggio.Css.Contains('nascosto') then
  begin
    // messaggio in base al caso
    if FDataUltimaLiquidazione = DATE_NULL then
      lblMessaggio.Caption:=Format(A000MSG_A091_DLG_FMT_NO_LIQ_ANNO,[FMeseInizio.Year])
    else if R180Between(FDataUltimaLiquidazione,FMeseInizio,FMeseFine) then
      lblMessaggio.Caption:=Format(A000MSG_A091_DLG_FMT_ULTIMA_LIQ_PERIODO,[FDataUltimaLiquidazione.ToString('mmmm yyyy')])
    else
      lblMessaggio.Caption:=Format(A000MSG_A091_DLG_FMT_ULTIMA_LIQ_ANNO,[FDataUltimaLiquidazione.ToString('mmmm yyyy')])
  end;

  // impostazioni pulsante "solo aggiornamento"
  imgSoloAggiornamento.Enabled:=(chkAggiornamento.Checked or LAnnullamentoConsentito);
  if chkAnnullaLiquidazione.Checked then
  begin
    imgSoloAggiornamento.Caption:='Esegui';
    imgSoloAggiornamento.ImageFile.FileName:='img\btnEsegui.png';
  end
  else
  begin
    imgSoloAggiornamento.Caption:='Solo aggiornamento';
    imgSoloAggiornamento.ImageFile.FileName:='img\btnSalva.png';
  end;

  // anteprima e stampa abilitate se non si tratta di annullamento ed il periodo è inferiore o uguale a un mese
  imgAnteprima.Enabled:=not chkAnnullaLiquidazione.Checked and LIsMeseSingolo;
end;

procedure TWA091FLiquidPresenze.actScaricaInCSVClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    csvDownload:=grdRisultati.ToCsv
  else
    InviaFile('Anomalie.xls',csvDownload);
end;

procedure TWA091FLiquidPresenze.actScaricaInExcelClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    streamDownload:=grdRisultati.ToXlsx
  else
    InviaFile('Anomalie.xlsx',streamDownload);
end;

procedure TWA091FLiquidPresenze.btnCausaliClick(Sender: TObject);
var
  WC013: TWC013FCheckListFM;
  LstCodice,
  LstDescrizione: TStringList;
begin
  LstCodice:=TStringList.Create;
  LstDescrizione:=TStringList.Create;
  try
    WC013:=TWC013FCheckListFM.Create(Self);
    A091MW.selT275.First;
    while not A091MW.selT275.Eof do
    begin
      LstCodice.Add(A091MW.selT275.FieldByName('CODICE').AsString);
      LstDescrizione.Add(Format('%-5s',[A091MW.selT275.FieldByName('CODICE').AsString]) + ' - ' + A091MW.selT275.FieldByName('DESCRIZIONE').AsString);
      A091MW.selT275.Next;
    end;
    WC013.CaricaLista(LstDescrizione, LstCodice);
    WC013.ImpostaValoriSelezionati(FLstCausali);
    WC013.ResultEvent:=cklistCausaliResult;
    WC013.Visualizza(0,0,'Scelta causali di presenza');
  finally
    FreeAndNil(LstCodice);
    FreeAndNil(LstDescrizione);
  end;
end;

procedure TWA091FLiquidPresenze.chkAggiornamentoAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  // i checkbox "effettua liquidazione" ed "annulla liquidazione" sono mutuamente esclusivi
  if chkAggiornamento.Checked and
     chkAnnullaLiquidazione.Enabled then
  begin
    chkAnnullaLiquidazione.Checked:=False;
  end;

  OnImpostazioniModificate;
end;

procedure TWA091FLiquidPresenze.chkAnnullaLiquidazioneAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  // i checkbox "effettua liquidazione" ed "annulla liquidazione" sono mutuamente esclusivi
  if chkAnnullaLiquidazione.Checked and
     chkAggiornamento.Enabled then
  begin
    chkAggiornamento.Checked:=False;
  end;

  OnImpostazioniModificate;
end;

procedure TWA091FLiquidPresenze.chkCompensazioniAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  OnImpostazioniModificate;
end;

procedure TWA091FLiquidPresenze.chkLiquidazioniAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  OnImpostazioniModificate;
end;

procedure TWA091FLiquidPresenze.cklistCausaliResult(Sender: TObject; Result:Boolean);
var
  lstTmp: TStringList;
begin
  if Result then
  begin
    lstTmp:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    FLstCausali.Clear;
    FLstCausali.Assign(lstTmp);
    FreeAndNil(lstTmp);
    edtCausale.Text:=FLstCausali.CommaText;
    FElencoCausali:=FLstCausali.CommaText;
  end;
end;

procedure TWA091FLiquidPresenze.cmbMeseDaAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  // sposta il mese finale se il periodo non è corretto
  if cmbMeseDa.ItemIndex > cmbMeseA.ItemIndex then
    cmbMeseA.ItemIndex:=cmbMeseDa.ItemIndex;

  OnPeriodoModificato;
end;

procedure TWA091FLiquidPresenze.cmbMeseAAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  // sposta il mese iniziale se il periodo non è corretto
  if cmbMeseDa.ItemIndex > cmbMeseA.ItemIndex then
    cmbMeseDa.ItemIndex:=cmbMeseA.ItemIndex;

  OnPeriodoModificato;
end;

procedure TWA091FLiquidPresenze.GetParametriFunzione;
begin
  edtCausale.Text:=C004DM.GetParametro('CAUSALE','');
  FLstCausali.CommaText:=edtCausale.Text;
  FElencoCausali:=FLstCausali.CommaText;
  edtArrotLiq.Text:=C004DM.GetParametro('ARROTLIQ','0');
  edtMaxLiq.Text:=C004DM.GetParametro('MAXLIQ','00.00');
  edtArrotComp.Text:=C004DM.GetParametro('ARROTCOMP','0');
  edtMaxComp.Text:=C004DM.GetParametro('MAXCOMP','00.00');
  rgpDisponibilita.ItemIndex:=StrToInt(C004DM.GetParametro('DISPONIBILITA','0'));
  chkSaltoPagina.Checked:=C004DM.GetParametro('SALTOPAGINA','N') = 'S';
  chkTotaliRaggr.Checked:=C004DM.GetParametro('TOTALIPARZIALI','N') = 'S';
  chkTotaliGenerali.Checked:=C004DM.GetParametro('TOTALIGENERALI','N') = 'S';
  //Non usare , come separatore altrimenti il metodo CommaText prende come delimitatore anche lo spazio
  C190PutCheckList(C004DM.GetParametro('DETTAGLIO',''),99,cgpDettaglio,';');
end;

procedure TWA091FLiquidPresenze.grdRisultatiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  LEsistonoRecord, LPaginaModificabile: Boolean;
begin
  inherited;

  LEsistonoRecord:=grdRisultati.medpDataSet.RecordCount > 0;
  VisualizzaModificaLiquidazione(LEsistonoRecord);

  // verifica se la pagina attuale è modificabile per la liquidazione
  LPaginaModificabile:=(LEsistonoRecord) and
                       (FLstPagineBloccate.IndexOf(grdRisultati.medpGetCurrPag.ToString) = -1);

  btnModificaDati.Enabled:=(not FLiquidazioneInModifica) and LPaginaModificabile;
  btnLiquida.Enabled:=(not FLiquidazioneInModifica) and LPaginaModificabile;
end;

procedure TWA091FLiquidPresenze.grdRisultatiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
  Campo: String;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdRisultati.medpNumColonna(AColumn);
  Campo:=grdRisultati.medpColonna(NumColonna).DataField.ToUpper;

  // assegnazione componenti
  if (ARow > 0) and (ARow <= High(grdRisultati.medpCompGriglia) + 1) and (grdRisultati.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdRisultati.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;

  if ARow > 0 then
  begin
    // dettaglio

    // valuta i singoli campi
    if Campo = 'LIQUIDATO' then
    begin
      ACell.Css:=ACell.Css + ' font_rosso';
    end;
  end;
end;

procedure TWA091FLiquidPresenze.grdTabDetailTabControlChange(Sender: TObject);
var
  LGestModificaLiq: Boolean;
begin
  if (grdTabDetail.ActiveTab = WA091RisultatiRG) and (RicaricaGridRisultati) then
  begin
    //grdRisultati.medpAttivaGrid(WA091FLiquidPresenzeDM.A091FLiquidPresenzeMW.TabellaStampa,False,False);
    grdRisultati.medpEditMultiplo:=True;
    grdRisultati.medpRowSelect:=False;
    grdRisultati.medpAttivaGrid(WA091FLiquidPresenzeDM.A091FLiquidPresenzeMW.TabellaStampa,False,False,False);

    LGestModificaLiq:=(not chkAggiornamento.Checked) and (grdRisultati.medpDataSet.RecordCount > 0);
    VisualizzaModificaLiquidazione(LGestModificaLiq);
    if LGestModificaLiq then
    begin
      // prepara la gestione della liquidazione manuale
      SetLiquidazioneInModifica(False);
    end;
    RicaricaGridRisultati:=False;
  end;
end;

procedure TWA091FLiquidPresenze.ImpostaValoriLiquidato(PTipoValore: TTipoValore);
var
  r: Integer;
  LValore: String;
  IWEdt: TmeIWEdit;
begin
  if grdRisultati.medpStato = msEdit then
  begin
    for r:=0 to High(grdRisultati.medpCompGriglia) do
    begin
      case PTipoValore of
        tvLiquidato: LValore:=grdRisultati.medpValoreColonna(r,'Liquidato_Disp');
        tvZero:      LValore:='00.00';
      else
        LValore:='';
      end;

      IWEdt:=(grdRisultati.medpCompCella(r,'LIQUIDATO',0) as TmeIWEdit);
      IWEdt.Text:=LValore;
    end;
  end;
end;

procedure TWA091FLiquidPresenze.VisualizzaModificaLiquidazione(PVisualizza: Boolean);
begin
  // in readonly la modifica liquidazione è nascosta
  if SolaLettura then
    PVisualizza:=False;

  btnModificaDati.Visible:=PVisualizza;
  btnConfermaDati.Visible:=PVisualizza;
  btnAnnullaDati.Visible:=PVisualizza;
  btnImpostaLiquidato.Visible:=PVisualizza;
  btnLiquida.Visible:=PVisualizza;
end;

procedure TWA091FLiquidPresenze.SetLiquidazioneInModifica(const PInModifica: Boolean);
begin
  FLiquidazioneInModifica:=PInModifica;

  btnModificaDati.Enabled:=not PInModifica;
  btnConfermaDati.Enabled:=PInModifica;
  btnAnnullaDati.Enabled:=PInModifica;
  btnImpostaLiquidato.Enabled:=PInModifica;
  btnLiquida.Enabled:=(not PInModifica) and (FLstPagineBloccate.IndexOf(grdRisultati.medpGetCurrPag.ToString) = -1);

  // in modifica disabilita la possibilità di navigare fra le pagine
  if PInModifica then
    grdRisultati.medpDisabilitaNavBar
  else
    grdRisultati.medpAbilitaNavBar;
end;

procedure TWA091FLiquidPresenze.btnModificaDatiClick(Sender: TObject);
begin
  grdRisultati.medpModifica(False);
  ImpostaValoriLiquidato(tvZero);
  SetLiquidazioneInModifica(True);
end;

procedure TWA091FLiquidPresenze.btnConfermaDatiClick(Sender: TObject);
begin
  ConfermaDati;
  SetLiquidazioneInModifica(False);
end;

procedure TWA091FLiquidPresenze.btnAnnullaDatiClick(Sender: TObject);
begin
  AnnullaDati;
  SetLiquidazioneInModifica(False);
end;

procedure TWA091FLiquidPresenze.btnImpostaLiquidatoClick(Sender: TObject);
begin
  ImpostaValoriLiquidato(tvLiquidato);
end;

procedure TWA091FLiquidPresenze.btnLiquidaClick(Sender: TObject);
var
  LNumPag: Integer;
  LErrore: String;
begin
  // salva numero pagina corrente
  LNumPag:=grdRisultati.medpGetCurrPag;

  // effettua liquidazione della pagina corrente
  if ConfermaLiquidazione(LErrore) then
  begin
    FLstPagineBloccate.Add(LNumPag.ToString);
  end
  else
  begin
    MsgBox.MessageBox(LErrore,ESCLAMA);
  end;

  // aggiornamento tabella
  grdRisultati.medpStato:=msBrowse;
  grdRisultati.medpBrowse:=True;
  grdRisultati.medpCaricaCDS;
end;

procedure TWA091FLiquidPresenze.ConfermaDati;
var
  r: Integer;
  LIdRiga: String;
begin
  grdRisultati.medpDataSet.Cancel;
  for r:=0 to High(grdRisultati.medpCompGriglia) do
  begin
    LIdRiga:=grdRisultati.medpValoreColonna(r,'IdRiga');
    if grdRisultati.medpDataSet.Locate('IdRiga',LIdRiga,[]) then
    begin
      grdRisultati.medpDataSet.Edit;
      grdRisultati.medpConferma(r);
    end;
  end;

  grdRisultati.medpStato:=msBrowse;
  grdRisultati.medpBrowse:=True;
  grdRisultati.medpCaricaCDS;
end;

procedure TWA091FLiquidPresenze.AnnullaDati;
var
  r: Integer;
  LIdRiga: String;
begin
  grdRisultati.medpDataSet.Cancel;
  for r:=0 to High(grdRisultati.medpCompGriglia) do
  begin
    LIdRiga:=grdRisultati.medpValoreColonna(r,'IdRiga');
    if grdRisultati.medpDataSet.Locate('IdRiga',LIdRiga,[]) then
      grdRisultati.medpAnnulla(r);
  end;
end;

function TWA091FLiquidPresenze.ConfermaLiquidazione(var RErrMsg: String): Boolean;
var
  r, LIdRiga: Integer;
begin
  // PRE: periodo di un mese singolo
  Assert(R180InizioMese(FMeseInizio) = R180InizioMese(FMeseFine),'Il periodo deve essere di un mese singolo!');

  grdRisultati.medpDataSet.Cancel;
  try
    for r:=0 to High(grdRisultati.medpCompGriglia) do
    begin
      LIdRiga:=grdRisultati.medpValoreColonna(r,'IdRiga').ToInteger;
      A091MW.LiquidazioneDatiModificati(StrToInt(edtAnno.Text),
                                        FMeseInizio.Month,
                                        rgpDisponibilita.ItemIndex,
                                        LIdRiga);
    end;
    Result:=True;
  except
    on E: Exception do
    begin
      RErrMsg:=E.Message;
      Result:=False;
    end;
  end;
end;

procedure TWA091FLiquidPresenze.imgAnomalieClick(Sender: TObject);
var
  Params: String;
begin
  // accesso alla gestione dei messaggi delle elaborazioni
  if RegistraMsg.ContieneAnomalie then
  begin
    Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
            'OPERATORE=' +Parametri.Operatore + ParamDelimiter +
            'MASCHERA=' + medpCodiceForm + ParamDelimiter +
            'ID=' + IntToStr(RegistraMsg.ID) + ParamDelimiter +
            'TIPO=A,B';
    AccediForm(201,Params,True);
  end;
end;

function TWA091FLiquidPresenze.VerificaAnno: Boolean;
begin
  Result:=False;

  if (StrToInt(edtAnno.Text) < 1900) or
     (StrToInt(edtAnno.Text) > 3999) then
  begin
    MsgBox.WebMessageDlg(A000MSG_A091_ERR_ANNO,mtError,[mbOk],nil,'');
    edtAnno.SetFocus;
    Exit;
  end;

  Result:=True;
end;

procedure TWA091FLiquidPresenze.imgSoloAggiornamentoClick(Sender: TObject);
var
  LMsg: string;
begin
  if edtCausale.Text = '' then
  begin
    MsgBox.MessageBox(A000MSG_A091_ERR_NO_CAUSALE,ESCLAMA);
    Exit;
  end;

  if not VerificaAnno then
    Exit;

  // imposta anticipatamente il valore di questa variabile
  SenderHTMLName:=(Sender as TmedpIWImageButton).HTMLName;

  // conferma in caso di annullamento
  if IsAnnullaLiq then
  begin
    if FMeseInizio = FDataUltimaLiquidazione then
      LMsg:=Format(A000MSG_A091_DLG_FMT_CONF_ANNULLA_LIQ_1,[FDataUltimaLiquidazione.ToString('mmmm yyyy')])
    else
      LMsg:=Format(A000MSG_A091_DLG_FMT_CONF_ANNULLA_LIQ_N,[FMeseInizio.ToString('mmmm'),FDataUltimaLiquidazione.ToString('mmmm yyyy')]);

    MsgBox.WebMessageDlg(LMsg, mtConfirmation, [mbYes,mbNo], OnConfermaAggiornamento, 'CONFERMA_ANNULLA');
    Exit;
  end;

  // effettua l'elaborazione
  DoAggiornamento;
end;

procedure TWA091FLiquidPresenze.OnConfermaAggiornamento(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if KeyID = 'CONFERMA_ANNULLA' then
  begin
    // conferma annullamento liquidazioni
    case Res of
      mrYes:
        begin
          DoAggiornamento;
          MsgBox.ClearKeys;
        end;
      mrNo:
        MsgBox.ClearKeys;
    end;
  end;
end;

procedure TWA091FLiquidPresenze.DoAggiornamento;
var
  LMsg: string;
begin
  imgAnomalie.Enabled:=False;

  // inizio elaborazione: messaggio globale per il periodo
  RegistraMsg.IniziaMessaggio(medpCodiceForm);

  if IsAnnullaLiq then
  begin
    LMsg:=Format('Inizio annullamento liquidazioni nel periodo %s - %s',[FMeseInizio.ToString('mmmm yyyy'),FDataUltimaLiquidazione.ToString('mmmm yyyy')]);
    RegistraMsg.InserisciMessaggio('I',LMsg,Parametri.Azienda);

    // ciclo di elaborazione per ogni liquidazione presente nel periodo
    FMeseElaborazione:=FDataUltimaLiquidazione;
  end
  else
  begin
    LMsg:=Format('Inizio elaborazione liquidazione %s(disponibilità %s) nel periodo %s - %s',
                 [IfThen(chkAggiornamento.Checked, 'con aggiornamento del riepilogo '),
                  IfThen(rgpDisponibilita.ItemIndex = 0, 'mensile', 'annuale'),
                  FMeseInizio.ToString('mmmm yyyy'),
                  FMeseFine.ToString('mmmm yyyy')]);
    RegistraMsg.InserisciMessaggio('I',LMsg,Parametri.Azienda);

    // modifica selezione anagrafica per includere campi di intestazione e dettaglio (per la grid)
    AggiungiCampiIntestazioneDettaglioSelAnag;

    // ciclo di elaborazione per ogni mese del periodo
    FMeseElaborazione:=FMeseInizio;
  end;

//  SenderHTMLName:=(Sender as TmedpIWImageButton).HTMLName;
  StartElaborazioneCiclo(SenderHTMLName, True);
end;

procedure TWA091FLiquidPresenze.PutParametriFunzione;
begin
  C004DM.Cancella001;
  C004DM.PutParametro('CAUSALE',edtCausale.Text);
  C004DM.PutParametro('ARROTLIQ',edtArrotLiq.Text);
  C004DM.PutParametro('MAXLIQ',edtMaxLiq.Text);
  C004DM.PutParametro('ARROTCOMP',edtArrotComp.Text);
  C004DM.PutParametro('MAXCOMP',edtMaxComp.Text);
  C004DM.PutParametro('DISPONIBILITA',IntToStr(rgpDisponibilita.ItemIndex));
  C004DM.PutParametro('SALTOPAGINA',IfThen(chkSaltoPagina.Checked,'S','N'));
  C004DM.PutParametro('TOTALIPARZIALI',IfThen(chkTotaliRaggr.Checked,'S','N'));
  C004DM.PutParametro('TOTALIGENERALI',IfThen(chkTotaliGenerali.Checked,'S','N'));
  //Non usare , come separatore altrimenti il metodo CommaText prende come delimitatore anche lo spazio
  C004DM.PutParametro('DETTAGLIO',C190GetCheckList(99,cgpDettaglio,';'));
end;

procedure TWA091FLiquidPresenze.IWAppFormDestroy(Sender: TObject);
begin
  FreeAndNil(FLstCausali);
  FreeAndNil(FLstPagineBloccate);
  inherited;
end;

procedure TWA091FLiquidPresenze.WC700AperturaSelezione(Sender: TObject);
begin
  // apre la selezione anagrafica sul mese di elaborazione
  grdC700.WC700FM.C700DataDal:=R180InizioMese(FMeseElaborazione);
  grdC700.WC700FM.C700DataLavoro:=R180FineMese(FMeseElaborazione);
end;

procedure TWA091FLiquidPresenze.WC700CambioProgressivo(Sender: TObject);
begin
  OnImpostazioniModificate;
end;

procedure TWA091FLiquidPresenze.ImpostazioniWC700;
begin
  inherited;

  grdC700.WC700FM.C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  grdC700.WC700FM.C700DataLavoro:=Parametri.DataLavoro;
  grdC700.WC700FM.C700DataDal:=Parametri.DataLavoro;
  grdC700.WC700FM.C700SelezionePeriodica:=True;
end;

function TWA091FLiquidPresenze.IsAnnullaLiq: Boolean;
begin
  Result:=(chkAnnullaLiquidazione.Checked and (chkLiquidazioni.Checked or chkCompensazioni.Checked));
end;

procedure TWA091FLiquidPresenze.AggiungiCampiIntestazioneDettaglioSelAnag;
// modifica selezione anagrafica per includere campi di intestazione e dettaglio
var
  LstIntestazione: TStringList;
  LstDettaglio: TStringList;
  S: string;
  i: Integer;
begin
  LstIntestazione:=TStringList.Create;
  LstDettaglio:=TStringList.Create;

  try
    // l'intestazione non è prevista su IrisCloud
    (*
    for i:=0 to cgpIntestazione.Items.Count - 1 do
      if cgpIntestazione.IsChecked[i] then
        LstIntestazione.Add(cgpIntestazione.Items[i]);
    *)

    // campi anagrafici per dettaglio
    for i:=0 to cgpDettaglio.Items.Count - 1 do
      if cgpDettaglio.isChecked[i] then
        LstDettaglio.Add(cgpDettaglio.Items[i]);

    S:=A091MW.SettaIntestazioneDettaglio(grdC700.selAnagrafe.SQL.Text, LstIntestazione, LstDettaglio);
    if S <> '' then
    begin
      grdC700.selAnagrafe.CloseAll;
      grdC700.selAnagrafe.SQL.Text:=S;
    end;
  finally
    FreeAndNil(LstIntestazione);
    FreeAndNil(LstDettaglio);
  end;
end;

// #############################   ELABORAZIONE   ##############################

procedure TWA091FLiquidPresenze.InizializzaMsgElaborazione;
var
  LMsg: string;
begin
  if IsAnnullaLiq then
    LMsg:='Annullamento liquidazioni del mese di %s'
  else
    LMsg:='Elaborazione liquidazioni del mese di %s';
  LMsg:=Format(LMsg,[FMeseElaborazione.ToString('mmmm yyyy')]);
  WC022FMsgElaborazioneFM.Messaggio:=LMsg;
end;

procedure TWA091FLiquidPresenze.InizioElaborazione;
// procedura richiamata per ogni mese del periodo da elaborare
begin
  inherited;

  // inizializza dataset per controllo blocco riepiloghi
  A091MW.InizializzaDatiBloccati;

  if IsAnnullaLiq then
  begin
    RegistraMsg.InserisciMessaggio('I',Format('Annullamento liquidazioni di %s',[FMeseElaborazione.ToString('mmmm yyyy')]),Parametri.Azienda);

    // imposta messaggio finestra di progresso
    WC019FProgressBarFM.MessaggioStep2:=Format('Annullamento liquidazioni di %s in corso...',[FMeseElaborazione.ToString('mmmm yyyy')]);

    // imposta le strutture dati per l'annullamento delle liquidazioni
    A091MW.ImpostaVarAnnulla(FMeseElaborazione, FElencoCausali, chkLiquidazioni.Checked, chkCompensazioni.Checked);
  end
  else
  begin
    RegistraMsg.InserisciMessaggio('I',Format('Elaborazione liquidazioni di %s',[FMeseElaborazione.ToString('mmmm yyyy')]),Parametri.Azienda);

    // imposta messaggio finestra di progresso
    WC019FProgressBarFM.MessaggioStep2:=Format('Elaborazione liquidazioni di %s in corso...',[FMeseElaborazione.ToString('mmmm yyyy')]);

    // modifica selezione anagrafica per includere campi di intestazione e dettaglio (per la grid)
    AggiungiCampiIntestazioneDettaglioSelAnag;
  end;

  // riapre la selezione anagrafica sul periodo da considerare
  if grdC700.WC700FM.C700SettaPeriodoSelAnagrafe(R180InizioMese(FMeseElaborazione),R180FineMese(FMeseElaborazione)) then
    grdC700.selAnagrafe.Close;
  grdC700.selAnagrafe.Open;
  grdC700.selAnagrafe.First;
  A091MW.SelAnagrafe:=grdC700.selAnagrafe;

  if not IsAnnullaLiq then
  begin
    A091MW.CreaTabellaStampa(True);
    //Alberto 24/02/2006: Inizializzo i conteggi
    A091MW.R450DtM1.ConteggiMese('Generico', FMeseElaborazione.Year, FMeseElaborazione.Month, 0);
  end;

  // pulisce array delle pagine bloccate per la liquidazione
  FLstPagineBloccate.Clear;
end;

function TWA091FLiquidPresenze.CurrentRecordElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecNo;
end;

function TWA091FLiquidPresenze.TotalRecordsElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecordCount;
end;

procedure TWA091FLiquidPresenze.ElaboraElemento;
// elabora il dipendente per calcolare o annullare le liquidazioni del mese
begin
  if IsAnnullaLiq then
  begin
    // annulla la liquidazione del mese per le causali selezionate
    A091MW.AnnullaLiquidazione(FMeseElaborazione, FElencoCausali)
  end
  else
  begin
    // calcola e/o aggiorna il riepilogo del mese per le causali selezionate
    A091MW.ElaboraDipendente(FLstCausali,
                             FMeseElaborazione.Year,
                             FMeseElaborazione.Month,
                             R180OreMinutiExt(edtMaxLiq.Text),
                             StrToIntDef(Trim(edtArrotLiq.Text),0),
                             R180OreMinutiExt(edtMaxComp.Text),
                             StrToIntDef(Trim(edtArrotComp.Text),0),
                             rgpDisponibilita.ItemIndex,
                             chkAggiornamento.Checked);
  end;
end;

function TWA091FLiquidPresenze.ElementoSuccessivo: Boolean;
begin
  grdC700.selAnagrafe.Next;
  Result:=not grdC700.selAnagrafe.Eof;
end;

procedure TWA091FLiquidPresenze.FineCicloElaborazione;
begin
  inherited;

  // calcola il fruito e aggiorna il budget per il mese
  A091MW.PreparaAggiornaFruitoBudget(FMeseElaborazione);
end;

function TWA091FLiquidPresenze.ElaborazioneTerminata: String;
var
  LOldMeseElaborazione: TDateTime;
  i: Integer;
  LName: String;
  LVal: Variant;
  LValStr: String;
begin
  // determina se è necessario far ripartire l'elaborazione sul mese successivo da elaborare
  if IsAnnullaLiq then
  begin
    LOldMeseElaborazione:=FMeseElaborazione;

    // cerca l'ultima liquidazione dell'anno per annullarla
    FMeseElaborazione:=A091MW.GetDataUltimaLiquidazioneAnno(FMeseInizio,FElencoCausali,chkLiquidazioni.Checked,chkCompensazioni.Checked);

    // se l'ultima liquidazione risulta uguale al valore appena gestito
    // segnala la situazione anomala (si rischia infatti un loop)
    if FMeseElaborazione = LOldMeseElaborazione then
    begin
      // l'elaborazione non viene fatta ripartire
      RipartiElaborazione:=False;

      // segnalazione dell'anomalia nei messaggi delle elaborazioni
      RegistraMsg.InserisciMessaggio('A',Format('Alcune liquidazioni del mese di %s non sono state eliminate! Verificare la query di controllo.',[LOldMeseElaborazione.ToString('mmmm yyyy')]));
      RegistraMsg.InserisciMessaggio('A','Query di controllo (sql)');
      RegistraMsg.InserisciMessaggio('A',A091MW.selT074.SubstitutedSQL);
      RegistraMsg.InserisciMessaggio('A','Query di controllo (variabili)');
      for i:=0 to A091MW.selT074.VariableCount - 1 do
      begin
        LName:=A091MW.selT074.VariableName(i);
        LVal:=A091MW.selT074.GetVariable(i);
        if LVal = null then
          LValStr:='<null>'
        else
          LValStr:=VarToStr(LVal);
        RegistraMsg.InserisciMessaggio('A',Format('%s = %s',[LName,LValStr]));
      end;
    end
    else
    begin
      // se la liquidazione rientra nel periodo selezionato fa ripartire l'elaborazione
      RipartiElaborazione:=(FMeseElaborazione <> DATE_NULL) and (FMeseElaborazione >= FMeseInizio);
    end;
  end
  else
  begin
    // passa al mese successivo
    FMeseElaborazione:=R180AddMesi(FMeseElaborazione, 1);

    // se il mese successivo da elaborare rientra nel periodo selezionato fa ripartire l'elaborazione
    RipartiElaborazione:=FMeseElaborazione <= FMeseFine;
  end;

  // se l'elaborazione è terminata, effettua le operazioni finali
  if not RipartiElaborazione then
  begin
    // abilita il pulsante delle anomalie
    imgAnomalie.Enabled:=RegistraMsg.ContieneAnomalie;

    grdTabDetail.Tabs[WA091RisultatiRG].Enabled:=False;

    // reimposta il mese di elaborazione
    FMeseElaborazione:=FMeseInizio;

    // aggiorna eventualmente la data di ultima liquidazione
    OnImpostazioniModificate;

    // in caso di anteprima visualizza la grid dei risultati
    if SenderHTMLName = imgAnteprima.HTMLName then
    begin
      RicaricaGridRisultati:=True;
      grdTabDetail.Tabs[WA091RisultatiRG].Enabled:=True;
      grdTabDetail.ActiveTab:=WA091RisultatiRG;
    end;
  end;

  // restituisce il messaggio di fine elaborazione
  if imgAnomalie.Enabled then
    Result:=A000MSG_MSG_ELABORAZIONE_ANOMALIE
  else
    Result:=inherited;
end;

procedure TWA091FLiquidPresenze.DistruzioneOggettiElaborazione(Errore: Boolean);
// distruzione degli oggetti creati durante l'elaborazione
begin
  inherited;

  if Errore then
    SessioneOracle.Rollback
  else
  begin
    PutParametriFunzione;
    SessioneOracle.Commit;
  end;
end;

procedure TWA091FLiquidPresenze.edtAnnoAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  OnPeriodoModificato;
end;

end.
