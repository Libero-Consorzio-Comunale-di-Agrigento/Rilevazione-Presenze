unit WA145UComVisiteFiscali;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR100UBase, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton,
  meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, meIWLink, medpIWTabControl, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, meIWRegion, IWCompLabel,
  meIWLabel, IWCompEdit, meIWEdit, WA145UComVisiteFiscaliDM,
  medpIWMultiColumnComboBox, IWCompCheckbox, meIWCheckBox, A000UInterfaccia,
  meIWRadioGroup, IWAdvRadioGroup, meTIWAdvRadioGroup, IWCompListbox,
  meIWListbox, meIWImageFile, IWApplication, C190FunzioniGeneraliWeb,
  IWCompJQueryWidget, IWCompMemo, meIWMemo, medpIWImageButton, StrUtils,
  Data.DB, Datasnap.DBClient, Datasnap.Win.MConnect, medpIWMessageDlg, A000UMessaggi,
  Data.DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} A000UCostanti, ActiveX, Math, IWDBGrids, medpIWDBGrid,
  meIWComboBox, C180FunzioniGenerali, WA145UDettaglioAssenzeFM, Vcl.Menus;

type
  TWA145FComVisiteFiscali = class(TWR100FBase)
    grdTabDetail: TmedpIWTabControl;
    WA145VisiteFiscaliRG: TmeIWRegion;
    WA145VisiteFiscaliRGTemplate: TIWTemplateProcessorHTML;
    WA145EsenzioniRG: TmeIWRegion;
    WA145EsenzioniRGTemplate: TIWTemplateProcessorHTML;
    edtDataElaborazione: TmeIWEdit;
    lblDataElaborazione: TmeIWLabel;
    cmbMedicineLegali: TMedpIWMultiColumnComboBox;
    lblMedicineLegali: TmeIWLabel;
    lblDescMedicineLegali: TmeIWLabel;
    lblRegistrazioni: TmeIWLabel;
    chkIns: TmeIWCheckBox;
    chkProl: TmeIWCheckBox;
    chkSoloCont: TmeIWCheckBox;
    chkCanc: TmeIWCheckBox;
    chkAggiorna: TmeIWCheckBox;
    chkAnnulla: TmeIWCheckBox;
    lblOpzioniEsenzione: TmeIWLabel;
    chkEsenzioneAutomatica: TmeIWCheckBox;
    lblNumeroMinimoEventi: TmeIWLabel;
    edtNumeroMinimoEventi: TmeIWEdit;
    lblMaxGiorniContinuativi: TmeIWLabel;
    edtMaxGiorniContinuativi: TmeIWEdit;
    lblMesiVerificaEventi: TmeIWLabel;
    edtMesiVerificaEventi: TmeIWEdit;
    lblOpzioniStampa: TmeIWLabel;
    rgpTipoStampa: TmeTIWAdvRadioGroup;
    chkPeriodiComunicati: TmeIWCheckBox;
    chkFiltroDataComun: TmeIWCheckBox;
    edtDataDa: TmeIWEdit;
    edtDataA: TmeIWEdit;
    lblDataDa: TmeIWLabel;
    lblDataA: TmeIWLabel;
    chkStampaAssMal: TmeIWCheckBox;
    chkNote: TmeIWCheckBox;
    lblDatiAnagrafici: TmeIWLabel;
    lstElementiDettaglio: TmeIWListbox;
    lblDisponibili: TmeIWLabel;
    lblSelezionati: TmeIWLabel;
    imgRimuovi: TmeIWImageFile;
    imgAggiungi: TmeIWImageFile;
    chkLogo: TmeIWCheckBox;
    edtLogoLarg: TmeIWEdit;
    chkNumProt: TmeIWCheckBox;
    edtNumProt: TmeIWEdit;
    chkLuogo: TmeIWCheckBox;
    edtLuogo: TmeIWEdit;
    JQuery: TIWJQueryWidget;
    lstElementiDettaglioSelezionati: TmeIWListbox;
    memDato1: TmeIWMemo;
    memDato2: TmeIWMemo;
    memFirma: TmeIWMemo;
    lblDato1: TmeIWLabel;
    lblDato2: TmeIWLabel;
    lblFirma: TmeIWLabel;
    btnEsegui: TmedpIWImageButton;
    btnGeneraPDF: TmedpIWImageButton;
    btnEsenzioni: TmedpIWImageButton;
    DCOMConnection: TDCOMConnection;
    grdEsenzioni: TmedpIWDBGrid;
    rgpFiltro: TmeTIWAdvRadioGroup;
    pmnElemDettaglio: TPopupMenu;
    actAggiungiTutti: TMenuItem;
    actRimuoviTutti: TMenuItem;
    pmnGrdTabella: TPopupMenu;
    actScaricaInExcel: TMenuItem;
    actScaricaInCSV: TMenuItem;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure cmbMedicineLegaliAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure chkProlAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure rgpTipoStampaAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure imgAggiungiAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure imgRimuoviAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure chkLogoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure chkNumProtAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure chkLuogoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure chkOpzioniAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure edtDataDaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnEsenzioniClick(Sender: TObject);
    procedure btnGeneraPDFClick(Sender: TObject);
    procedure rgpFiltroClick(Sender: TObject);
    procedure grdEsenzionimedpStatoChange;
    procedure grdEsenzioniComponenti2DataSet(Row: Integer);
    procedure grdEsenzioniDataSet2Componenti(Row: Integer);
    function grdEsenzioniBeforeModifica(Sender: TObject): Boolean;
    procedure grdEsenzioniAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure lstElementiDettaglioAsyncDoubleClick(Sender: TObject;
      EventParams: TStringList);
    procedure lstElementiDettaglioSelezionatiAsyncDoubleClick(Sender: TObject;
      EventParams: TStringList);
    procedure actAggiungiTuttiAsyncClick(Sender: TObject);
    procedure actRimuoviTuttiAsyncClick(Sender: TObject);
    procedure actScaricaInExcelClick(Sender: TObject);
    procedure actScaricaInCSVClick(Sender: TObject);
  private
    DataUltimaComunicazione: TDateTime;
    EsistonoComunicazioni: Boolean;
    WA145FComVisiteFiscaliDM: TWA145FComVisiteFiscaliDM;
    SenderHTMLName: String;
    procedure GetParametriFunzione;
    procedure CaricaCmbMedicineLegali;
    procedure AbilitazioneSoloCont;
    procedure SetElencoIndividualeVisible(idx:Integer);
    procedure AbilitazioneLogoLarg;
    procedure AbilitazioneNumProt;
    procedure AbilitazioneLuogo;
    procedure AbilitazioneGrpOperazioni(bEnab: Boolean);
    procedure SetOpzioni(Sender: TObject);
    procedure AbilitaOperazioni;
    procedure EstraiUltimaDataComunicazione;
    procedure PutParametriFunzione;
    procedure ResultEseguiAnnulla(Sender: TObject; Res: TmeIWModalResult;
      KeyID: String);
    procedure CallDCOMPrinter;
    function CreateJSonString: String;
    function Controlli: String;
    procedure ResultDataElab(Sender: TObject; Res: TmeIWModalResult;
      KeyID: String);
    procedure PartenzaElaborazione;
    procedure ConfermaAggiornamento;
    procedure ResultConfermaAggiornamento(Sender: TObject;
      Res: TmeIWModalResult; KeyID: String);
    procedure EseguiControlli;
    procedure PopolaDatiElab;
    procedure EseguiElaborazioneEsenzioni;
    procedure SetEsenzioniInModifica(val: Boolean);
    procedure AbilitazionePulsanti;
    procedure imgDettaglioDipendenteClick(Sender: TObject);
    procedure AggiungiElemDettaglio(idx: Integer);
    procedure RimuoviElemDettaglio(idx: Integer);
  protected
    procedure ElaborazioneServer; override;
    procedure InizializzaMsgElaborazione; override;
    procedure WC700AperturaSelezione(Sender: TObject); override;
  public
    function InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

procedure TWA145FComVisiteFiscali.IWAppFormCreate(Sender: TObject);
var
  lstCampiAnagrafici: TStringList;
  s: String;
begin
  grdTabDetail.AggiungiTab('Parametri',WA145VisiteFiscaliRG);
  grdTabDetail.AggiungiTab('Esenzioni',WA145EsenzioniRG);
  grdTabDetail.HasFiller:=True;
  grdTabDetail.ActiveTab:=WA145VisiteFiscaliRG;
  grdTabDetail.Tabs[WA145EsenzioniRG].Enabled:=False;
  inherited;
  AttivaGestioneC700;

  WA145FComVisiteFiscaliDM:=TWA145FComVisiteFiscaliDM.Create(Self);
  CaricaCmbMedicineLegali;
  lblDescMedicineLegali.Caption:='';
  try
    lstCampiAnagrafici:=TStringList.Create();
    lstElementiDettaglio.Items.Clear;
    WA145FComVisiteFiscaliDM.A145FComVisiteFiscaliMW.getLstCampiAnagrafici(lstCampiAnagrafici);
    for s in lstCampiAnagrafici do
      lstElementiDettaglio.Items.Add(s);
  finally
    FreeAndNil(lstCampiAnagrafici);
  end;
  lstElementiDettaglio.ItemIndex:=0;
end;

function TWA145FComVisiteFiscali.InizializzaAccesso: Boolean;
begin
  // propone la data di elaborazione
  edtDataElaborazione.Text:=DateToStr(Parametri.DataLavoro);

  chkAggiorna.Enabled:=Not SolaLettura;
  GetParametriFunzione;
  EstraiUltimaDataComunicazione;
  Result:=True;
end;

procedure TWA145FComVisiteFiscali.GetParametriFunzione;
var
  S: String;
  lstTmp: TStringList;
begin
  rgpTipoStampa.ItemIndex:=StrToIntDef(C004DM.GetParametro('TIPOSTAMPA','0'),0);
  rgpTipoStampaAsyncClick(nil,nil);
  chkIns.Checked:=C004DM.GetParametro('INSERIMENTO','N') = 'S';
  chkProl.Checked:=C004DM.GetParametro('PROLUNGAMENTO','N') = 'S';
  chkCanc.Checked:=C004DM.GetParametro('CANCELLAZIONE','N') = 'S';
  chkSoloCont.Checked:=C004DM.GetParametro('SOLOCONT','N') = 'S';
  AbilitazioneSoloCont;
  chkNote.Checked:=C004DM.GetParametro('CHKNOTE','N') = 'S';
  chkStampaAssMal.Checked:=C004DM.GetParametro('CHKSTAMPAASSMAL','N') = 'S';
  chkEsenzioneAutomatica.Checked:=C004DM.GetParametro('ESENZIONEAUTO','N') = 'S';
  edtNumeroMinimoEventi.Text:=C004DM.GetParametro('NUMEROMINEVENTI','');
  edtMaxGiorniContinuativi.Text:=C004DM.GetParametro('GIORNICONTINUATIVI','');
  edtMesiVerificaEventi.Text:=C004DM.GetParametro('MESIEVENTI','');
  chkLogo.Checked:=C004DM.GetParametro('CHKLOGO','N') = 'S';
  edtLogoLarg.Text:=C004DM.GetParametro('EDTLOGOLARG','');
  AbilitazioneLogoLarg;
  chkNumProt.Checked:=C004DM.GetParametro('CHKNUMPROT','N') = 'S';
  edtNumProt.Text:=C004DM.GetParametro('EDTNUMPROT','');
  AbilitazioneNumProt;
  chkLuogo.Checked:=C004DM.GetParametro('CHKLUOGO','N') = 'S';
  edtLuogo.Text:=C004DM.GetParametro('EDTLUOGO','');
  AbilitazioneLuogo;
  memDato1.Text:=C004DM.GetParametro('DATOLIBERO1','');
  memDato2.Text:=C004DM.GetParametro('DATOLIBERO2','');
  memFirma.Text:=C004DM.GetParametro('FIRMA','');

  // opzioni
  if WA145FComVisiteFiscaliDM.A145FComVisiteFiscaliMW.C004_SALVA_OPZIONI then
  begin
    chkPeriodiComunicati.Checked:=(C004DM.GetParametro('PERIODI_COMUNICATI','N') = 'S');
    chkAggiorna.Checked:=(C004DM.GetParametro('AGGIORNAMENTO','N') = 'S');
    chkAnnulla.Checked:=(C004DM.GetParametro('ANNULLAMENTO','N') = 'S');
  end
  else
  begin
    chkPeriodiComunicati.Checked:=False;
    chkAggiorna.Checked:=False;
    chkAnnulla.Checked:=False;
  end;

  // abilitazione periodo per opzione "includi periodi già comunicati"
  edtDataDa.Enabled:=chkPeriodiComunicati.Checked;
  edtDataA.Enabled:=chkPeriodiComunicati.Checked;

  // abilitazione pulsanti di gestione
  AbilitazionePulsanti;

  // elenco campi di dettaglio
  S:=C004DM.GetParametro('LISTA_DETTAGLI','');
  if Trim(S) <> '' then
  begin
    try
      lstTmp:=TStringList.Create;
      lstTmp.CommaText:=S;
      lstElementiDettaglioSelezionati.Items.Assign(lstTmp);
      lstElementiDettaglioSelezionati.ItemIndex:=0;
    finally
      FreeAndNil(lstTmp);
    end;
  end;
end;

procedure TWA145FComVisiteFiscali.grdEsenzioniAfterCaricaCDS(Sender: TObject;
  DBG_ROWID: string);
var
  i: Integer;
begin
  with grdEsenzioni do
  begin
    for i:=0 to High(medpCompGriglia) do
    begin
      //Associo l'evento OnClick alle icone dei comandi
      if (medpCompGriglia[i].CompColonne[0] <> nil) then
      begin
        (medpCompCella(i,0,4) as TmeIWImageFile).OnClick:=imgDettaglioDipendenteClick;
        (medpCompCella(i,0,4) as TmeIWImageFile).hint:='Visualizza dettaglio dipendente';
      end;
    end;
  end;
end;

procedure TWA145FComVisiteFiscali.imgDettaglioDipendenteClick(Sender: TObject);
var
  WA145FDettaglioAssenzeFM: TWA145FDettaglioAssenzeFM;
  Titolo: String;
begin
  //mi posiziono sul record giusto
  grdEsenzioni.medpColumnClick(Sender,(Sender as TmeIWImageFile).FriendlyName);

  WA145FDettaglioAssenzeFM:=TWA145FDettaglioAssenzeFM.Create(Self);
  WA145FDettaglioAssenzeFM.WR300DM:=WA145FComVisiteFiscaliDM;
  WA145FDettaglioAssenzeFM.CaricaDettaglio(grdEsenzioni.medpClientDataSet.FieldByName('PROGRESSIVO').AsInteger);
  with grdEsenzioni.medpClientDataSet do
  begin
    Titolo:='Visualizzazione dettaglio periodi assenza di ' +
          FieldByName('COGNOME').AsString + ' ' +
          FieldByName('NOME').AsString + ' (MATR.' +
          FieldByName('MATRICOLA').AsString + ')';
  end;
  WA145FDettaglioAssenzeFM.Visualizza(Titolo);
end;

function TWA145FComVisiteFiscali.grdEsenzioniBeforeModifica(
  Sender: TObject): Boolean;
var r: Integer;
begin
  inherited;
  r:=grdEsenzioni.medpRigaDiCompGriglia((Sender as TmeIWImageFile).FriendlyName);
  (grdEsenzioni.medpCompCella(r,0,4) as TmeIWImageFile).css:='invisibile';
  Result:=True;
end;

procedure TWA145FComVisiteFiscali.grdEsenzioniComponenti2DataSet(Row: Integer);
begin
  inherited;
  //devo rimettere i campi editabili altrimenti errore in calcField
  SetEsenzioniInModifica(False);
end;

procedure TWA145FComVisiteFiscali.grdEsenzioniDataSet2Componenti(Row: Integer);
var
  cmb: TmeIWComboBox;
  val: String;
begin
  inherited;
  cmb:=(grdEsenzioni.medpCompCella(Row,grdEsenzioni.medpIndexColonna('TIPOESENZIONE'),0) as TmeIWCombobox);

  with WA145FComVisiteFiscaliDM.A145FComVisiteFiscaliMW.selT047Esenzioni do
  begin
    Close;
    Open;
    First;
    cmb.clear;
    cmb.Items.add('');
    cmb.ItemIndex:=0;
    while not Eof do
    begin
      cmb.items.Add(FieldByName('TIPO_ESENZIONE').AsString);
      val:=grdEsenzioni.medpClientDataSet.FieldByName('TIPOESENZIONE').AsString;
      if val = FieldByName('TIPO_ESENZIONE').AsString then
      begin
        cmb.ItemIndex:=cmb.Items.Count - 1;
      end;
      Next;
    end;
  end;
end;

procedure TWA145FComVisiteFiscali.grdEsenzionimedpStatoChange;
begin
  inherited;
  SetEsenzioniInModifica(grdEsenzioni.medpStato = msEdit);
  if (grdEsenzioni.medpStato = msBrowse) then
  begin
    //aggiornamento perchè dati sono filtrati e modificando potrebbero essere variati
    grdEsenzioni.medpAggiornaCDS(True);
  end;
end;

procedure TWA145FComVisiteFiscali.SetEsenzioniInModifica(val: Boolean);
var
  i: Integer;
begin
  with WA145FComVisiteFiscaliDM.A145FComVisiteFiscaliMW do
  begin
    //in modifica devo settare i campi a readonly per evitare la creazione dei componenti
    for i:=0 to TabellaEsenzioni.FieldDefs.Count - 1 do
    begin
      if UpperCase(TabellaEsenzioni.FieldDefs[i].Name) <> 'TIPOESENZIONE' then
        TabellaEsenzioni.FieldByName(TabellaEsenzioni.FieldDefs[i].Name).ReadOnly:=val;
    end;
  end;
  //disabilito pulsante esenzioni
  rgpFiltro.Enabled:=not val;
  AbilitazionePulsanti;
end;

procedure TWA145FComVisiteFiscali.imgAggiungiAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  AggiungiElemDettaglio(lstElementiDettaglio.ItemIndex);
end;

procedure TWA145FComVisiteFiscali.AggiungiElemDettaglio(idx: Integer);
var
  s: string;
begin
  if idx <> -1 then
  begin
    s:=lstElementiDettaglio.Items[idx];
    if lstElementiDettaglioSelezionati.Items.IndexOf(s) = -1 then
      lstElementiDettaglioSelezionati.Items.Add(lstElementiDettaglio.Items[idx]);
  end;

  if lstElementiDettaglioSelezionati.ItemIndex = -1 then
    lstElementiDettaglioSelezionati.ItemIndex:=0;
end;

procedure TWA145FComVisiteFiscali.imgRimuoviAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  RimuoviElemDettaglio(lstElementiDettaglioSelezionati.ItemIndex);
end;

procedure TWA145FComVisiteFiscali.RimuoviElemDettaglio(idx: Integer);
begin
  if idx <> -1 then
    lstElementiDettaglioSelezionati.Items.Delete(idx);

  if lstElementiDettaglioSelezionati.ItemIndex >= lstElementiDettaglioSelezionati.Items.Count then
     lstElementiDettaglioSelezionati.ItemIndex:=lstElementiDettaglioSelezionati.Items.Count - 1;
end;

procedure TWA145FComVisiteFiscali.CaricaCmbMedicineLegali;
begin
  with WA145FComVisiteFiscaliDM.A145FComVisiteFiscaliMW do
  begin
    selT485.First;
    while not selT485.Eof do
    begin
      if not (selT485.FieldByName('CODICE').AsString.IsEmpty) then
        cmbMedicineLegali.AddRow(Format('%s;%s',[selT485.FieldByName('CODICE').AsString,selT485.FieldByName('DESCRIZIONE').AsString]));
      selT485.Next;
    end;
  end;
end;

procedure TWA145FComVisiteFiscali.AbilitazioneLogoLarg;
begin
  if not chkLogo.Checked then
    edtLogoLarg.Text:='';
  edtLogoLarg.Enabled:=chkLogo.Checked;
end;

procedure TWA145FComVisiteFiscali.chkLogoAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  AbilitazioneLogoLarg;
end;

procedure TWA145FComVisiteFiscali.chkLuogoAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  AbilitazioneLuogo;
end;

procedure TWA145FComVisiteFiscali.chkNumProtAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  AbilitazioneNumProt;
end;

procedure TWA145FComVisiteFiscali.chkProlAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  AbilitazioneSoloCont;
end;

procedure TWA145FComVisiteFiscali.AbilitazioneLuogo;
begin
  edtLuogo.Enabled:=chkLuogo.Checked;
end;

procedure TWA145FComVisiteFiscali.AbilitazioneNumProt;
begin
  if not chkNumProt.Checked then
    edtNumProt.Text:='';
  edtNumProt.Enabled:=chkNumProt.Checked;
end;

procedure TWA145FComVisiteFiscali.AbilitazioneSoloCont;
begin
  chkSoloCont.Enabled:=chkProl.Checked;
  if not chkProl.Checked then
    chkSoloCont.Checked:=False;
end;

procedure TWA145FComVisiteFiscali.actAggiungiTuttiAsyncClick(Sender: TObject);
var i: Integer;
begin
  inherited;
  for i:=0 to lstElementiDettaglio.Items.Count -1 do
    AggiungiElemDettaglio(i);
end;

procedure TWA145FComVisiteFiscali.actRimuoviTuttiAsyncClick(Sender: TObject);
begin
  inherited;
  lstElementiDettaglioSelezionati.Items.Clear;
  lstElementiDettaglioSelezionati.ItemIndex:=-1;
end;

procedure TWA145FComVisiteFiscali.actScaricaInCSVClick(Sender: TObject);
var
  NomeFile: String;
begin
  if not Assigned(Sender) then
    csvDownload:=grdEsenzioni.ToCsv
  else
  begin
    NomeFile:=Title + '.xls';
    NomeFile:=NomeFile.Replace(' ','_').Replace('(','').Replace(')','').Replace('/','').Replace('\','');
    InviaFile(NomeFile,csvDownload);
  end;
end;

procedure TWA145FComVisiteFiscali.actScaricaInExcelClick(Sender: TObject);
var
  NomeFile: String;
begin
  if not Assigned(Sender) then
    streamDownload:=grdEsenzioni.ToXlsx
  else
  begin
    NomeFile:=Title + '.xlsx';
    NomeFile:=NomeFile.Replace(' ','_').Replace('(','').Replace(')','').Replace('/','').Replace('\','');
    InviaFile(NomeFile,streamDownload);
  end;
end;

procedure TWA145FComVisiteFiscali.btnEseguiClick(Sender: TObject);
begin
  inherited;
  MsgBox.WebMessageDlg(Format(A000MSG_A145_DLG_FMT_ANNULLAMENTO,[DateToStr(DataUltimaComunicazione)]),mtConfirmation,[mbYes,mbNo],ResultEseguiAnnulla,'');
end;

procedure TWA145FComVisiteFiscali.btnEsenzioniClick(Sender: TObject);
begin
  inherited;
  cmbMedicineLegali.Text:='';
  WA145FComVisiteFiscaliDM.A145FComVisiteFiscaliMW.selT485.Refresh;
  caricacmbMedicineLegali;
  chkIns.Checked:=True;
  chkProl.Checked:=True;
  chkCanc.Checked:=True;
  chkPeriodiComunicati.Checked:=False;
  chkAggiorna.Checked:=False;
  chkAnnulla.Checked:=False;
  SenderHTMLName:=btnEsenzioni.HTMLName;
  EseguiControlli;
end;

procedure TWA145FComVisiteFiscali.EseguiControlli;
var
  Msg: String;
begin
  Msg:=Controlli;
  if Msg <> '' then
  begin
    MsgBox.WebMessageDlg(Msg,mtInformation,[mbOk],nil,'');
    Abort;
  end;
  // controlli in base all'opzione scelta
  if (not chkPeriodiComunicati.Checked ) and
     (not chkFiltroDataComun.Checked) and
     (chkAggiorna.Checked) then
  begin
    // chiede conferma se data elaborazione è precedente a quella odierna
    if WA145FComVisiteFiscaliDM.A145FComVisiteFiscaliMW.DatiElab.DataElaborazione < Date then
    begin
      MsgBox.WebMessageDlg(A000MSG_A145_DLG_COM_PREC_SYSDATE,mtConfirmation,[mbYes,mbNo],ResultDataElab,'');
      Abort;
    end;

    ConfermaAggiornamento;
  end;
  PartenzaElaborazione;
end;

procedure TWA145FComVisiteFiscali.ConfermaAggiornamento;
var
  Msg: String;
begin
  // conferma aggiornamento
  if cmbMedicineLegali.Text = '' then
    Msg:=A000MSG_A145_DLG_AGGIORNAMENTO
  else
    Msg:=A000MSG_A145_DLG_AGGIORNAMENTO_MED_LEG;

  MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultConfermaAggiornamento,'');
  Abort;
end;

procedure TWA145FComVisiteFiscali.PopolaDatiElab;
var
  i: Integer;
begin
  with WA145FComVisiteFiscaliDM.A145FComVisiteFiscaliMW do
  begin
    DatiElab.bAggiorna:=chkAggiorna.Checked;
    DatiElab.bPeriodiComunicati:=chkPeriodiComunicati.Checked;
    DatiElab.bNumProt:=chkNumProt.Checked;
    DatiElab.sNumProt:=edtNumProt.Text;
    DatiElab.bLuogo:=chkLuogo.Checked;
    DatiElab.sLuogo:=edtLuogo.Text;
    DatiElab.sDato1:=memDato1.Text;
    DatiElab.sDato2:=memDato2.Text;
    DatiElab.sFirma:=memFirma.Text;
    DatiElab.bPeriodiComunicati:=chkPeriodiComunicati.Checked;
    DatiElab.bProl:=chkProl.Checked;
    DatiElab.sMedicineLegali:=cmbMedicineLegali.Text;
    DatiElab.bEsenzioneAutomatica:=chkEsenzioneAutomatica.Checked;
    DatiElab.iTipoStampa:=rgpTipoStampa.ItemIndex;
    DatiElab.sMaxGiorniContinuativi:=edtMaxGiorniContinuativi.Text;
    DatiElab.sMesiVerificaEventi:=edtMesiVerificaEventi.Text;
    DatiElab.sNumeroMinimoEventi:=edtNumeroMinimoEventi.Text;
    DatiElab.bFiltroDataComun:=chkFiltroDataComun.Checked;
    DatiElab.bSoloCont:=chkSoloCont.Checked;

      // valorizza la stringlist dei campi di dettaglio richiesti
    DatiElab.ListaDettaglio.Clear;
    for i:=0 to lstElementiDettaglioSelezionati.Items.Count - 1 do
      DatiElab.ListaDettaglio.Add(VarToStr(selI010.Lookup('NOME_LOGICO',lstElementiDettaglioSelezionati.Items[i],'NOME_CAMPO')));
  end;
end;

procedure TWA145FComVisiteFiscali.PartenzaElaborazione;
var
  DataInizio, DataFine: TDateTime;
begin
  PopolaDatiElab;

  with WA145FComVisiteFiscaliDM.A145FComVisiteFiscaliMW do
  begin
    DataInizio:=IfThen(DatiElab.bPeriodiComunicati,DatiElab.DataDa,DatiElab.DataElaborazione);
    DataFine:=IfThen(DatiElab.bPeriodiComunicati,DatiElab.DataA,DatiElab.DataElaborazione);
  end;
  if grdC700.WC700FM.C700SettaPeriodoSelAnagrafe(DataInizio,DataFine) then
    grdC700.SelAnagrafe.CloseAll;

  WA145FComVisiteFiscaliDM.A145FComVisiteFiscaliMW.SelAnagrafe:=grdC700.SelAnagrafe;
  WA145FComVisiteFiscaliDM.A145FComVisiteFiscaliMW.ImpostaCampiSelAnagrafe;

  if grdC700.selAnagrafe.RecordCount = 0 then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_NO_DIP,mtError,[mbOk],nil,'');
    Abort;
  end;

  StartElaborazioneServer(SenderHTMLName);
end;

procedure TWA145FComVisiteFiscali.btnGeneraPDFClick(Sender: TObject);
begin
  inherited;
  SenderHTMLName:=btnGeneraPDF.HTMLName;
  EseguiControlli;
end;

function TWA145FComVisiteFiscali.Controlli: String;
// controlli per la generazione di una comunicazione / visualizzazione dei periodi comunicati
var
  Temp: Integer;
begin
  // pulizia variabili
  with WA145FComVisiteFiscaliDM.A145FComVisiteFiscaliMW do
  begin
    DatiElab.DataElaborazione:=0;
    DatiElab.DataDa:=0;
    DatiElab.DataA:=0;
  end;
  Result:='';
  // data elaborazione
  if not chkPeriodiComunicati.Checked then
  begin
    if not TryStrToDate(edtDataElaborazione.Text,WA145FComVisiteFiscaliDM.A145FComVisiteFiscaliMW.DatiElab.DataElaborazione) then
    begin
      Result:=A000MSG_A145_ERR_DATA_ELAB;
      Exit;
    end;
  end;

  // tipo operazione
  if not (chkIns.Checked or chkProl.Checked or chkCanc.Checked) and (Not chkFiltroDataComun.Checked) then
  begin
    Result:=A000MSG_A145_ERR_TIPO_OPERAZIONE;
    Exit;
  end;
  if ((chkIns.Checked or chkProl.Checked) and chkCanc.Checked) or chkFiltroDataComun.Checked then
    WA145FComVisiteFiscaliDM.A145FComVisiteFiscaliMW.DatiElab.Operazione:='%'
  else if (chkIns.Checked or chkProl.Checked) then
    WA145FComVisiteFiscaliDM.A145FComVisiteFiscaliMW.DatiElab.Operazione:='I'
  else
    WA145FComVisiteFiscaliDM.A145FComVisiteFiscaliMW.DatiElab.Operazione:='C';

  // controlli per stampa individuale
  if rgpTipoStampa.ItemIndex = 1 then
  begin
    // logo
    if chkLogo.Checked then
    begin
      if edtLogoLarg.Text = '' then
      begin
        Result:=A000MSG_A145_ERR_NO_LOGO_LARG;
        Exit;
      end
      else if not TryStrToInt(edtLogoLarg.Text,Temp) then
      begin
        Result:=A000MSG_A145_ERR_LOGO_LARG;
        Exit;
      end;
    end;

    // num. protocollo
    if chkNumProt.Checked then
    begin
      if edtNumProt.Text = '' then
      begin
        Result:=A000MSG_A145_ERR_NO_NUM_PROT;
        Exit;
      end
    end;

    // luogo di stampa
    if chkLuogo.Checked then
    begin
      if edtLuogo.Text = '' then
      begin
        Result:=A000MSG_A145_ERR_NO_LUOGO;
        Exit;
      end
    end;
  end;

  // controlli in base all'opzione scelta
  if chkPeriodiComunicati.Checked or chkFiltroDataComun.Checked then
  begin
    // controlli per "includi periodi già comunicati"
    if not TryStrToDate(edtDataDa.Text, WA145FComVisiteFiscaliDM.A145FComVisiteFiscaliMW.DatiElab.DataDa) then
    begin
      Result:=A000MSG_A145_ERR_DATA_INIZIO_PERIODO;
      Exit;
    end;

    if not TryStrToDate(edtDataA.Text,WA145FComVisiteFiscaliDM.A145FComVisiteFiscaliMW.DatiElab.DataA) then
    begin
      Result:=A000MSG_A145_ERR_DATA_FINE_PERIODO;
      Exit;
    end;

    if WA145FComVisiteFiscaliDM.A145FComVisiteFiscaliMW.DatiElab.DataDa > WA145FComVisiteFiscaliDM.A145FComVisiteFiscaliMW.DatiElab.DataA then
    begin
      Result:=A000MSG_A145_ERR_PERIODO;
      Exit;
    end;
  end
  else if chkAggiorna.Checked then
  begin
    // controlli per "aggiornamento data comunicazione"

    // blocca se la data di comunicazione non è successiva all'ultima in archivio
    if WA145FComVisiteFiscaliDM.A145FComVisiteFiscaliMW.DatiElab.DataElaborazione < DataUltimaComunicazione then
    begin
      Result:=Format(A000MSG_A145_ERR_COM_PRECEDENTE,[FormatDateTime('dd/mm/yyyy',DataUltimaComunicazione)]);
      Exit;
    end;
  end;
end;

procedure TWA145FComVisiteFiscali.ResultEseguiAnnulla(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
  begin
    SenderHTMLName:=btnEsegui.HTMLName;
    StartElaborazioneServer(SenderHTMLName);
  end;
end;

procedure TWA145FComVisiteFiscali.ResultDataElab(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
  begin
    ConfermaAggiornamento;
  end;
end;

procedure TWA145FComVisiteFiscali.ResultConfermaAggiornamento(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
  begin
    PartenzaElaborazione;
  end;
end;

procedure TWA145FComVisiteFiscali.cmbMedicineLegaliAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  if cmbMedicineLegali.ItemIndex > -1 then
    lblDescMedicineLegali.Caption:=cmbMedicineLegali.Items[cmbMedicineLegali.ItemIndex].RowData[1]
  else
    lblDescMedicineLegali.Caption:='';
end;

procedure TWA145FComVisiteFiscali.edtDataDaAsyncChange(Sender: TObject;
  EventParams: TStringList);
var
  DataDaTemp, DataATemp: TDateTime;
begin
  if TryStrToDate(edtDataDa.Text,DataDaTemp) and
     TryStrToDate(edtDataA.Text,DataATemp) then
  begin
    // se la data di inizio periodo è successiva a quella di fine,
    // reimposta la data di fine = a quella di inizio
    if DataDaTemp > DataATemp then
      edtDataA.Text:=edtDataDa.Text;
  end;
end;

procedure TWA145FComVisiteFiscali.chkOpzioniAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  SetOpzioni(Sender);
end;

procedure TWA145FComVisiteFiscali.rgpFiltroClick(Sender: TObject);
begin
 with WA145FComVisiteFiscaliDM.A145FComVisiteFiscaliMW do
  begin
    itemIndexFiltroEsenzioni:=rgpFiltro.ItemIndex;
    TabellaEsenzioni.Filtered:=False;
    TabellaEsenzioni.Filtered:=True;
    grdEsenzioni.medpAggiornaCDS(True);
  end;
end;

procedure TWA145FComVisiteFiscali.rgpTipoStampaAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  AbilitazionePulsanti;
  SetElencoIndividualeVisible(rgpTipoStampa.ItemIndex);
  chkStampaAssMal.Enabled:=rgpTipoStampa.ItemIndex = 0;
  // la stampa individuale considera solo i nuovi periodi (inserimenti)
  AbilitaOperazioni;
  if rgpTipoStampa.ItemIndex = 1 then
  begin
    //chkIns.Checked:=True;
    //chkProl.Checked:=False;
    chkCanc.Checked:=False;
  end;
end;

procedure TWA145FComVisiteFiscali.SetElencoIndividualeVisible(idx: Integer);
var
  bElenco: Boolean;
  bIndividuale: Boolean;
begin
  bElenco:=idx = 0;
  bIndividuale:=not bElenco;
  if GGetWebApplicationThreadVar.IsCallBack then
  begin
    C190VisualizzaElementoAsync(JQuery,'divElenco',bElenco);
    C190VisualizzaElementoAsync(JQuery,'divIndividuale',bIndividuale);
  end
  else
  begin
    C190VisualizzaElemento(JQuery,'divElenco',bElenco);
    C190VisualizzaElemento(JQuery,'divIndividuale',bIndividuale);
  end;
(*
  lblDisponibili.Visible:=bElenco;
  lblSelezionati.Visible:=bElenco;
  lstElementiDettaglio.Visible:=bElenco;
  lstElementiDettaglioSelezionati.Visible:=bElenco;
  imgAggiungi.Visible:=bElenco;
  imgRimuovi.Visible:=bElenco;

  chkLogo.Visible:=bIndividuale;
  edtLogoLarg.Visible:=bIndividuale;
  chkNumProt.Visible:=bIndividuale;
  edtNumProt.Visible:=bIndividuale;
  chkLuogo.Visible:=bIndividuale;
  edtLuogo.Visible:=bIndividuale;
  lblDato1.Visible:=bIndividuale;
  lblDato2.Visible:=bIndividuale;
  lblFirma.Visible:=bIndividuale;
  memDato1.Visible:=bIndividuale;
  memDato2.Visible:=bIndividuale;
  memFirma.Visible:=bIndividuale;
*)
end;

procedure TWA145FComVisiteFiscali.EstraiUltimaDataComunicazione;
// estrae la data dell'ultima comunicazione presente sulla T047
begin
  DataUltimaComunicazione:=WA145FComVisiteFiscaliDM.A145FComVisiteFiscaliMW.GetUltimaComunicazione;
  EsistonoComunicazioni:=(DataUltimaComunicazione > EncodeDate(1800,1,1));
  chkAnnulla.Enabled:=EsistonoComunicazioni and Not SolaLettura;
  if not EsistonoComunicazioni then
    chkAnnulla.Checked:=False;
end;

procedure TWA145FComVisiteFiscali.AbilitazioneGrpOperazioni(bEnab:Boolean);
begin
  chkIns.Enabled:=bEnab;
  chkProl.Enabled:=bEnab;
  chkCanc.Enabled:=bEnab;
  chkSoloCont.Enabled:=bEnab and chkProl.Checked;
end;

procedure TWA145FComVisiteFiscali.AbilitaOperazioni;
begin
  chkIns.Enabled:={(rgpTipoStampa.ItemIndex = 0) and }(not chkAnnulla.Checked);
  chkProl.Enabled:={(rgpTipoStampa.ItemIndex = 0) and }(not chkAnnulla.Checked);
  chkCanc.Enabled:=(rgpTipoStampa.ItemIndex = 0) and (not chkAnnulla.Checked);
end;

procedure TWA145FComVisiteFiscali.SetOpzioni(Sender: TObject);
begin
  AbilitazioneGrpOperazioni(Not chkFiltroDataComun.Checked);
  if (Sender = chkFiltroDataComun) and chkPeriodiComunicati.Checked then
    chkPeriodiComunicati.Checked:=False;
  if (Sender = chkPeriodiComunicati) and chkFiltroDataComun.Checked then
    AbilitazioneGrpOperazioni(False);
  if (Sender = chkPeriodiComunicati) or (Sender = chkFiltroDataComun) then
  begin
    if chkEsenzioneAutomatica.Checked then
      chkEsenzioneAutomatica.Checked:=False;
    chkEsenzioneAutomatica.Enabled:=not chkPeriodiComunicati.Checked and Not chkFiltroDataComun.Checked;
  end;
  // disabilita gli altri check (sono tutti in esclusiva)
  if chkAggiorna <> Sender then
    chkAggiorna.Checked:=False;
  if chkAnnulla <> Sender then
    chkAnnulla.Checked:=False;
  if Sender <> chkPeriodiComunicati then
    chkPeriodiComunicati.Checked:=False;

  // abilitazione data elaborazione
  edtDataElaborazione.Enabled:=not(chkPeriodiComunicati.Checked or chkAnnulla.Checked or chkFiltroDataComun.Checked);

  // abilitazione combo medicine legali
  cmbMedicineLegali.Enabled:=not chkAnnulla.Checked;
  if not cmbMedicineLegali.Enabled then
    cmbMedicineLegali.Text:='';

  // abilitazione operazioni stampa
  AbilitaOperazioni;

  // periodo per "includi già comunicati"
  edtDataDa.Enabled:=chkPeriodiComunicati.Checked or chkFiltroDataComun.Checked or chkFiltroDataComun.Checked;
  edtDataA.Enabled:=chkPeriodiComunicati.Checked or chkFiltroDataComun.Checked or chkFiltroDataComun.Checked;
  edtDataDa.Text:=IfThen(chkPeriodiComunicati.Checked or chkFiltroDataComun.Checked  or chkFiltroDataComun.Checked,DateToStr(Parametri.DataLavoro),'');
  edtDataA.Text:=IfThen(chkPeriodiComunicati.Checked or chkFiltroDataComun.Checked  or chkFiltroDataComun.Checked,DateToStr(Parametri.DataLavoro),'');

  // abilitazione pulsanti di gestione
  AbilitazionePulsanti;
end;

procedure TWA145FComVisiteFiscali.WC700AperturaSelezione(Sender: TObject);
var
  dTmp: TDateTime;
begin
  inherited;
  if not TryStrToDate(edtDataElaborazione.Text,dTmp) then
    dTmp:=Parametri.DataLavoro;

  grdC700.WC700FM.C700DataDal:=dTmp;
  grdC700.WC700FM.C700DataLavoro:=dTmp;
end;

procedure TWA145FComVisiteFiscali.AbilitazionePulsanti;
begin
  btnGeneraPDF.Enabled:=not chkAnnulla.Checked;
  btnEsenzioni.Enabled:=(rgpTipoStampa.ItemIndex = 0) and (not chkAnnulla.Checked);
  if grdEsenzioni.medpStato <> msBrowse then
    btnEsenzioni.Enabled:=False;
  btnEsegui.Enabled:=(chkAnnulla.Checked) and (not SolaLettura);
end;

procedure TWA145FComVisiteFiscali.PutParametriFunzione;
// Salva i parametri della form
begin
  C004DM.Cancella001;

  C004DM.PutParametro('TIPOSTAMPA',IntToStr(rgpTipoStampa.ItemIndex));
  C004DM.PutParametro('INSERIMENTO',IfThen(chkIns.Checked,'S','N'));
  C004DM.PutParametro('PROLUNGAMENTO',IfThen(chkProl.Checked,'S','N'));
  C004DM.PutParametro('CANCELLAZIONE',IfThen(chkCanc.Checked,'S','N'));
  C004DM.PutParametro('ESENZIONEAUTO',IfThen(chkEsenzioneAutomatica.Checked,'S','N'));
  C004DM.PutParametro('NUMEROMINEVENTI',edtNumeroMinimoEventi.Text);
  C004DM.PutParametro('GIORNICONTINUATIVI',edtMaxGiorniContinuativi.Text);
  C004DM.PutParametro('MESIEVENTI',edtMesiVerificaEventi.Text);
  C004DM.PutParametro('CHKLOGO',IfThen(chkLogo.Checked,'S','N'));
  C004DM.PutParametro('EDTLOGOLARG',edtLogoLarg.Text);
  C004DM.PutParametro('CHKNUMPROT',IfThen(chkNumProt.Checked,'S','N'));
  C004DM.PutParametro('EDTNUMPROT',edtNumProt.Text);
  C004DM.PutParametro('CHKLUOGO',IfThen(chkLuogo.Checked,'S','N'));
  C004DM.PutParametro('CHKNOTE',IfThen(chkNote.Checked,'S','N'));
  C004DM.PutParametro('CHKSTAMPAASSMAL',IfThen(chkNote.Checked,'S','N'));
  C004DM.PutParametro('EDTLUOGO',edtLuogo.Text);
  C004DM.PutParametro('DATOLIBERO1',memDato1.Text);
  C004DM.PutParametro('DATOLIBERO2',memDato2.Text);
  C004DM.PutParametro('FIRMA',memFirma.Text);
  // opzioni
  if WA145FComVisiteFiscaliDM.A145FComVisiteFiscaliMW.C004_SALVA_OPZIONI then
  begin
    C004DM.PutParametro('PERIODI_COMUNICATI',IfThen(chkPeriodiComunicati.Checked,'S','N'));
    C004DM.PutParametro('AGGIORNAMENTO',IfThen(chkAggiorna.Checked,'S','N'));
    C004DM.PutParametro('ANNULLAMENTO',IfThen(chkAnnulla.Checked,'S','N'));
  end;

  C004DM.PutParametro('LISTA_DETTAGLI',lstElementiDettaglioSelezionati.Items.CommaText);

  try SessioneOracle.Commit; except end;
end;

procedure TWA145FComVisiteFiscali.ElaborazioneServer;
begin
  inherited;
  if SenderHTMLName = btnEsegui.HTMLName then
  begin
    CallDCOMPrinter;
    EstraiUltimaDataComunicazione;
  end
  else if SenderHTMLName = btnEsenzioni.HTMLName then
  begin
    EseguiElaborazioneEsenzioni;
  end
  else if SenderHTMLName = btnGeneraPDF.HTMLName then
  begin
    CallDCOMPrinter;
    if chkAggiorna.Checked then
      EstraiUltimaDataComunicazione;
  end;
end;

procedure TWA145FComVisiteFiscali.EseguiElaborazioneEsenzioni;
begin
  DCOMNomeFile:=''; //RESETTO in caso di stampa precendente
  with WA145FComVisiteFiscaliDM.A145FComVisiteFiscaliMW do
  begin
    // creazione client dataset per la stampa
    CreaTabellaStampa;
    OttimizzaPeriodi;

    InizioElaborazione(True);

    // ciclo principale sulle persone selezionate
    SelAnagrafe.First;
    while not SelAnagrafe.EOF do
    begin
      ElaboraElemento(True);
      SelAnagrafe.Next;
    end;

    if TabellaStampa.RecordCount > 0 then
    begin
      DCOMMsg:='';
      grdTabDetail.Tabs[WA145EsenzioniRG].Enabled:=True;
      grdTabDetail.ActiveTab:=WA145EsenzioniRG;
      WA145FComVisiteFiscaliDM.A145FComVisiteFiscaliMW.CreaTabellaEsenzioni;

      grdEsenzioni.medpComandiCustom:=true;

      grdEsenzioni.medpAttivaGrid(WA145FComVisiteFiscaliDM.A145FComVisiteFiscaliMW.TabellaEsenzioni,not SolaLettura,False,False);
      grdEsenzioni.medpPreparaComponenteGenerico('WR102',grdEsenzioni.medpIndexColonna('TIPOESENZIONE'),0,DBG_CMB,'15','','','','S');
      grdEsenzioni.medpPreparaComponenteGenerico('R',0,4,DBG_IMG,'','PUNTINI','','','');
      grdEsenzioni.medpCaricaCDS;

      rgpFiltro.ItemIndex:=0;
      rgpFiltroClick(nil);
    end
    else
    begin
      grdTabDetail.Tabs[WA145EsenzioniRG].Enabled:=False;
      DCOMMsg:=MessaggioNessunPeriodo(chkPeriodiComunicati.Checked);
    end;
    TabellaStampa.Close;
    SelAnagrafe.First;
  end;
end;

function TWA145FComVisiteFiscali.CreateJSonString: String;
var json: TJSONObject;
begin
  json:=TJSONObject.Create;
  try
    //Popolo il json con i valori necessari al B028 per creare il PDF per la stampa
    json.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
    C190Comp2JsonString(edtDataElaborazione,json);
    C190Comp2JsonString(cmbMedicineLegali,json);
    C190Comp2JsonString(chkIns,json);
    C190Comp2JsonString(chkProl,json);
    C190Comp2JsonString(chkSoloCont,json);
    C190Comp2JsonString(chkCanc,json);
    C190Comp2JsonString(chkAggiorna,json);
    C190Comp2JsonString(chkAnnulla,json);
    C190Comp2JsonString(chkEsenzioneAutomatica,json);
    C190Comp2JsonString(edtNumeroMinimoEventi,json);
    C190Comp2JsonString(edtMaxGiorniContinuativi,json);
    C190Comp2JsonString(edtMesiVerificaEventi,json);
    C190Comp2JsonString(rgpTipoStampa,json);
    C190Comp2JsonString(chkPeriodiComunicati,json);
    C190Comp2JsonString(chkFiltroDataComun,json);
    C190Comp2JsonString(edtDataDa,json);
    C190Comp2JsonString(edtDataA,json);
    C190Comp2JsonString(chkStampaAssMal,json);
    C190Comp2JsonString(chkNote,json);
    C190Comp2JsonString(chkLogo,json);
    C190Comp2JsonString(edtLogoLarg,json);
    C190Comp2JsonString(chkNumProt,json);
    C190Comp2JsonString(edtNumProt,json);
    C190Comp2JsonString(chkLuogo,json);
    C190Comp2JsonString(edtLuogo,json);
    C190Comp2JsonString(memDato1,json);
    C190Comp2JsonString(memDato2,json);
    C190Comp2JsonString(memFirma,json);
    json.AddPair('lstElementiDettaglio',TJSONString.Create(lstElementiDettaglioSelezionati.Items.CommaText));

    Result:=json.ToString;
  finally
    FreeAndNil(json);
  end;
end;

procedure TWA145FComVisiteFiscali.CallDCOMPrinter;
var DettaglioLog:OleVariant;
    DatiUtente: String;
begin
  DCOMNomeFile:='';
  if (SenderHTMLName = btnGeneraPDF.HTMLName) then
  begin
    DCOMNomeFile:=GetNomeFile('pdf');
    ForceDirectories(ExtractFileDir(DCOMNomeFile));
  end
  else
    DCOMNomeFile:='';

  DatiUtente:=CreateJSonString;

  if (not IsLibrary) and
     (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then // gestione parametri di configurazione su file
    CoInitialize(nil);

  if not DCOMConnection.Connected then
    DCOMConnection.Connected:=True;
  try
    DCOMConnection.AppServer.PrintA145(grdC700.selAnagrafe.SubstitutedSQL,
                                       DCOMNomeFile,
                                       Parametri.Operatore,
                                       Parametri.Azienda,
                                       WR000DM.selAnagrafe.Session.LogonDataBase,
                                       DatiUtente,
                                       DettaglioLog);
  finally
    DCOMMsg:=DettaglioLog;
    DCOMConnection.Connected:=False;
  end;
end;

procedure TWA145FComVisiteFiscali.InizializzaMsgElaborazione;
begin
  with WC022FMsgElaborazioneFM do
  begin
    if SenderHTMLName <> btnGeneraPDF.HTMLName then
    begin
      Messaggio:=A000MSG_MSG_ELABORAZIONE_IN_CORSO;
      Titolo:=A000MSG_MSG_ELABORAZIONE;
      ImgFileName:=IMG_FILENAME_ELABORAZIONE;
    end
    else
    begin
      Messaggio:=A000MSG_MSG_ELABORAZIONE_PDF_IN_CORSO;
      Titolo:=A000MSG_MSG_ELABORAZIONE;
      ImgFileName:=IMG_FILENAME_PDF;
    end;
  end;
end;

procedure TWA145FComVisiteFiscali.lstElementiDettaglioAsyncDoubleClick(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  AggiungiElemDettaglio(lstElementiDettaglio.ItemIndex);
end;

procedure TWA145FComVisiteFiscali.lstElementiDettaglioSelezionatiAsyncDoubleClick(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  RimuoviElemDettaglio(lstElementiDettaglioSelezionati.ItemIndex);
end;

procedure TWA145FComVisiteFiscali.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  FreeAndNil(WA145FComVisiteFiscaliDM);
  inherited;
end;

end.
