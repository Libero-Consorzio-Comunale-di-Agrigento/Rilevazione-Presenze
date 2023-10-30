unit W034UPubblicazioneDocumenti;

interface

uses
  A000UInterfaccia,
  A000UCostanti,
  A000USessione,
  A118UPubblicazioneDocumentiMW,
  JBFService,
  W000UMessaggi,
  C021UDocumentiManagerDM,
  R010UPaginaWeb,
  WC012UVisualizzaFileFM,
  W034UPubblicazioneDocumentiDM,
  C180FunzioniGenerali,
  FunzioniGenerali,
  C190FunzioniGeneraliWeb,
  System.DateUtils,
  System.StrUtils,
  System.Math,
  System.SysUtils,
  Windows,
  IWGlobal,
  Oracle,
  OracleData,
  DB,
  DBClient,
  IWApplication,
  Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IWVCLComponent, IWBaseLayoutComponent, meIWMemo,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompLabel, meIWLabel, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, IWCompEdit,
  IWCompGrids, IWDBGrids, meIWDBGrid, IWCompButton,
  meIWImageFile, IWCompMemo, medpIWDBGrid, IWLayoutMgrForm, IWLayoutMgrHTML,
  meIWButton, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IW.Browser.InternetExplorer, IWCompCheckbox, meIWCheckBox,
  meIWGrid, meIWComboBox, ActnList, Menus, IWCompMenu, medpIWMultiColumnComboBox,
  System.IOUtils, meIWEdit, System.Diagnostics, System.TimeSpan, IWCompListbox,
  Xml.Xmldom, Xml.XMLIntf, Xml.Win.msxmldom, Xml.XMLDoc, Winapi.ActiveX;

type

  TInputOpenSession = record
    Azienda: String;
    User: String;
    Password: String;
    Ufficio: String;
    Entita: String;
    DataLavoro: TDateTime;
  end;

  TOutputOpenSession = record
    Ok: Boolean;
    SessionID: String;
    ExceptionCode: String;
    ExceptionDesc: String;
  end;

  TInputCedolino = record
    CodFiscale: String;
    MeseAnno: String;   // mm/yyyy
    AlfaUno: String;
    AlfaDue: String;
  end;

  TOutputCedolino = record
    Ok: Boolean;
    Cedolino: String;
    ExceptionCode: String;
    ExceptionDesc: String;
    LogErrore: String;
    function ToString: String;
  end;

  TInputCU = record
    CodFiscale: String;
    Anno: Integer;
  end;

  TOutputCU = record
    Ok: Boolean;
    Cud: String;
    ExceptionCode: String;
    ExceptionDesc: String;
    LogErrore: String;
    function ToString: String;
  end;

  TFiltroDocumenti = record
    FLabel: TmeIWLabel;
    FCombo: TmeIWComboBox;
  end;

  TW034FPubblicazioneDocumenti = class(TR010FPaginaWeb)
    lblTipologie: TmeIWLabel;
    lblDescTipologia: TmeIWLabel;
    memDettaglio: TmeIWMemo;
    grdDocumenti: TmedpIWDBGrid;
    ajnPreparaDataset: TIWAJAXNotifier;
    ajnPopolaDataset: TIWAJAXNotifier;
    ajnVisualizza: TIWAJAXNotifier;
    lnkVisualizza: TmeIWLink;
    chkDettaglio: TmeIWCheckBox;
    grdFiltroDocumenti: TmeIWGrid;
    lblFiltroDocumenti: TmeIWLabel;
    cmbTipologie: TMedpIWMultiColumnComboBox;
    lblTempoRicerca: TmeIWLabel;
    cmbAnno: TmeIWComboBox;
    cmbMese: TmeIWComboBox;
    lblAnno: TmeIWLabel;
    lblMese: TmeIWLabel;
    btnStampa: TmeIWButton;
    xmlDoc: TXMLDocument;
    procedure IWAppFormCreate(Sender: TObject);
    procedure grdDocumentiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdDocumentiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure ajnPreparaDatasetNotify(Sender: TObject);
    procedure ajnPopolaDatasetNotify(Sender: TObject);
    procedure ajnVisualizzaNotify(Sender: TObject);
    procedure lnkVisualizzaClick(Sender: TObject);
    procedure grdFiltroDocumentiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure IWAppFormRender(Sender: TObject);
    procedure cmbTipologieAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure btnSendFileClick(Sender: TObject);
    procedure chkDettaglioAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnStampaClick(Sender: TObject);
    procedure cmbAnnoAsyncChange(Sender: TObject; EventParams: TStringList);
  private
    A118MW: TA118FPubblicazioneDocumentiMW;
    W034DM: TW034FPubblicazioneDocumentiDM;
    C021DM: TC021FDocumentiManagerDM;
    FStatoElab: String;
    FFiltroDocArr: array of TFiltroDocumenti;
    FNomeFileGenerato: String;
    FNomeFileDownload: String;
    FmemDettaglioCss: String;
    procedure cmbFiltroDocumentiChange(Sender: TObject);
    procedure CaricaElencoTipologie;
    function PreparaDatasetDocumenti: TResCtrl;
    procedure ClearFiltri;
    procedure GestioneFiltri;
    procedure imgDownloadFileClick(Sender: TObject);
    procedure imgDownloadDocumentaleClick(Sender: TObject);
    procedure AggiornaAccessoEScarica(const PId: Integer; const PFilePath: String);
    function CallService(PInputXML: String): TResCtrl;
    function OpenSession(PParam: TInputOpenSession): TOutputOpenSession;
    function GetCedolino(const PSessionId: String; PParam: TInputCedolino): TOutputCedolino;
    function GetCU(const PSessionId: String; PParam: TInputCU): TOutputCU;
    procedure ParseOutputXML(const PXMLString: String; var PXMLDoc: TXMLDocument);
  protected
    function  GetInfoFunzione: String; override;
    function  GetInfoDebug: String; override;
    procedure DistruggiOggetti; override;
  public
    function  InizializzaAccesso: Boolean; override;
  end;

const
  XML_IN_OPEN_SESSION =
    '<?xml version="1.0" ?> ' +
    '<!-- ' +
    '  Test con richiesta completa ' +
    '--> ' +
    '<Input> ' +
    '  <OpenSession> ' +
    '    <user>%s</user> ' +
    '    <password>%s</password> ' +
    '    <azienda>%s</azienda> ' +
    '    <ufficio>%s</ufficio> ' +
    '    <dataLavoro>%s</dataLavoro> ' +
    '    <entita>%s</entita> ' +
    '  </OpenSession> ' +
    '</Input> ';

  XML_IN_CEDOLINO =
    '<?xml version="1.0" encoding="UTF-8"?> ' +
    '<Input SessionID="%s"> ' +
    '  <Get useBeanExtraData="false"> ' +
    '    <objectName>PSGPers.webService.WebServiceCedolino</objectName> ' +
    '    <listKey> ' +
    '      <codiceFiscale>%s</codiceFiscale> ' + // es. RSSMRA60A01I200X
    '      <meseAnno>%s</meseAnno> ' +           // es. 01/2018
    '      <alfaUno>%s</alfaUno> ' +             // es. S
    '      <alfaDue>%s</alfaDue> ' +
    '    </listKey> ' +
    '  <Parameters> ' +
    '  </Parameters> ' +
    '</Get> ' +
    '</Input> ';

  XML_IN_CUD =
    '<?xml version="1.0" encoding="UTF-8"?> ' +
    '<Input SessionID="%s"> ' +
    '  <Get useBeanExtraData="false"> ' +
    '    <objectName>PSGPers.webService.WebServiceCUD</objectName> ' +
    '    <listKey> ' +
    '      <codiceFiscale>%s</codiceFiscale> ' +
    '      <anno>%d</anno> ' +
    '      </listKey> ' +
    '    <Parameters> ' +
    '    </Parameters> ' +
    '  </Get> ' +
    '</Input> ';

implementation

{$R *.dfm}

function TW034FPubblicazioneDocumenti.InizializzaAccesso:Boolean;
var
  LJSCode: string;
begin
  Result:=True;

  // estrae info tipologie documenti da I200
  CaricaElencoTipologie;

  // EMPOLI_ASL11 - chiamata 82749.ini
  // proporre il primo elemento anche se esistono più tipologie visibili
  if cmbTipologie.Items.Count > 0 then
  // EMPOLI_ASL11 - chiamata 82749.fine
  begin
    cmbTipologie.ItemIndex:=0;
    cmbTipologie.Text:=cmbTipologie.Items[0].RowData[0];
    LJSCode:=Format('processAjaxEvent("onChange", %sIWCL,"%s.DoAsyncChange",true,null,true); ',
                    [cmbTipologie.HTMLName,cmbTipologie.HTMLName]);
    AddToInitProc(LJSCode);
  end;
end;

procedure TW034FPubblicazioneDocumenti.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  A118MW:=TA118FPubblicazioneDocumentiMW.Create(nil);
  W034DM:=TW034FPubblicazioneDocumentiDM.Create(nil);
  W034DM.A118MW:=A118MW;

  C021DM:=TC021FDocumentiManagerDM.Create(nil);
  C021DM.Maschera:=medpCodiceForm;
  FStatoElab:='';
  FNomeFileGenerato:='';
  FNomeFileDownload:='';
  FmemDettaglioCss:=memDettaglio.Css;

  // tabella documenti
  grdDocumenti.medpRighePagina:=GetRighePaginaTabella;
  grdDocumenti.medpDataSet:=W034DM.cdsFile;
  grdDocumenti.medpTestoNoRecord:='Nessun documento';
  grdDocumenti.medpRowSelect:=False;
  grdDocumenti.medpComandiCustom:=True;

  // tempo di ricerca
  lblTempoRicerca.Text:='';

  // dettaglio elaborazione
  chkDettaglio.Visible:=(DebugHook <> 0) or R180In(Parametri.Operatore,['SYSMAN','MONDOEDP']);
  memDettaglio.Css:='invisibile';
end;

procedure TW034FPubblicazioneDocumenti.IWAppFormRender(Sender: TObject);
var
  LSorg: String;
  LVisFiltro: Boolean;
begin
  inherited;

  // sorgente documenti
  LSorg:=cmbTipologie.Items[cmbTipologie.ItemIndex].RowData[2];

  // determina visualizzazione filtri record
  LVisFiltro:=R180In(LSorg,[SORGENTE_FS_EXT,SORGENTE_T960]) and (grdFiltroDocumenti.ColumnCount > 1);

  // tabella filtro dati
  lblFiltroDocumenti.Visible:=LVisFiltro;
  grdFiltroDocumenti.Visible:=LVisFiltro;
  AddToInitProc(Format('document.getElementById("W034FiltroDocumenti").className = "%s"; ',
                       [IfThen(LVisFiltro,'groupbox fs100','invisibile')]));
end;

function TW034FPubblicazioneDocumenti.GetInfoDebug: String;
begin
  Result:=Format('%s: %d',[A118MW.VARIABILI[5].Nome,A118MW.VARIABILI[5].ValoreInt]);
end;

function TW034FPubblicazioneDocumenti.GetInfoFunzione: String;
begin
  Result:=A000TraduzioneStringhe(A000MSG_W034_MSG_TIPOLOGIA_DOC) + ': ' + IfThen(cmbTipologie.Text = '','',cmbTipologie.Text);
end;

procedure TW034FPubblicazioneDocumenti.DistruggiOggetti;
begin
  try ClearFiltri; except end;
  try FreeAndNil(A118MW); except end;
  try FreeAndNil(W034DM); except end;
  try FreeAndNil(C021DM); except end;
end;

procedure TW034FPubblicazioneDocumenti.grdDocumentiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i: Integer;
  LSorg: String;
  LExtFile: String;
  LIWImg: TmeIWImageFile;
  LIWLbl: TmeIWLabel;
begin
  LSorg:=cmbTipologie.Items[cmbTipologie.ItemIndex].RowData[2];

  // righe dei dati
  for i:=0 to High(grdDocumenti.medpCompGriglia) do
  begin
    // salva
    LIWImg:=(grdDocumenti.medpCompCella(i,0,0) as TmeIWImageFile);
    LIWImg.FriendlyName:=IntToStr(i);
    if LSorg = SORGENTE_FS_EXT then
      LIWImg.OnClick:=imgDownloadFileClick
    else if LSorg = SORGENTE_T960 then
      LIWImg.OnClick:=imgDownloadDocumentaleClick;
    { DONE : TEST IW 14 OK }
    // LIWImg.medpDownloadButton:=True;

    // estensione file
    LExtFile:=grdDocumenti.medpValoreColonna(i,CAMPO_EXT_DOCUMENTO);
    LIWLbl:=(grdDocumenti.medpCompCella(i,CAMPO_EXT_DOCUMENTO,0) as TmeIWLabel);
    LIWLbl.Css:='file_ext';
    LIWLbl.ExtraTagParams.Add(Format('data-file-ext=%s',[LExtFile]));
    LIWLbl.Caption:=LExtFile;
  end;
end;

procedure TW034FPubblicazioneDocumenti.grdDocumentiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  LNumColonna: Integer;
  LCampo: String;
  LSorg: String;
begin
  if GGetWebApplicationThreadVar.IsCallback then
    Exit;

  if not grdDocumenti.medpRenderCell(ACell,ARow,AColumn,True,True,False) then
    Exit;

  LNumColonna:=grdDocumenti.medpNumColonna(AColumn);
  LCampo:=grdDocumenti.medpColonna(LNumColonna).DataField;

  // nasconde colonna path documento se non è selezionato il dettaglio della ricerca
  LSorg:=cmbTipologie.Items[cmbTipologie.ItemIndex].RowData[2];
  if (LCampo = CAMPO_PATH_DOCUMENTO) and
     (LSorg = SORGENTE_FS_EXT) then
  begin
    ACell.Css:=ACell.Css + ' w034_colpath' + IfThen(not chkDettaglio.Checked,' invisibile');
  end;

  if ARow > 0 then
  begin
    if not R180In(LCampo,[CAMPO_PATH_DOCUMENTO,CAMPO_NOME_DOCUMENTO]) then
    begin
      ACell.Css:=ACell.Css.Replace('align_right','',[]).Replace('align_left','',[]) + ' align_center';
    end;
  end;

  // assegnazione componenti
  if (ARow > 0) and (ARow <= High(grdDocumenti.medpCompGriglia) + 1) and (grdDocumenti.medpCompGriglia[ARow - 1].CompColonne[LNumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdDocumenti.medpCompGriglia[ARow - 1].CompColonne[LNumColonna];
  end;
end;

procedure TW034FPubblicazioneDocumenti.grdFiltroDocumentiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  if GGetWebApplicationThreadVar.IsCallback then
    Exit;

  RenderCell(ACell,ARow,AColumn,False,False,False);
end;

procedure TW034FPubblicazioneDocumenti.ajnPreparaDatasetNotify(Sender: TObject);
// carica la struttura dati
var
  LResCtrl: TResCtrl;
begin
  lblTempoRicerca.Visible:=False;
  lblTempoRicerca.Text:='';

  // predispone il dataset dei documenti in base alla tipologia selezionata
  LResCtrl:=PreparaDatasetDocumenti;

  // verifica errore operazione
  if not LResCtrl.Ok then
  begin
    FStatoElab:=LResCtrl.Messaggio;
    ajnVisualizza.Notify;
    Exit;
  end;

  // popola la tabella con i documenti
  ajnPopolaDataset.Notify;
end;

procedure TW034FPubblicazioneDocumenti.ajnPopolaDatasetNotify(Sender: TObject);
// popola il dataset dei documenti in base alla tipologia selezionata
var
  LResCtrl: TResCtrl;
  LStopWatch: TStopwatch;
  function TimeSpanToTime(PDuration: TTimeSpan): String;
  begin
    Result:='';
    if PDuration.Hours > 0 then
      Result:=Format('%.2dh, ',[PDuration.Hours]);
    if (Result <> '') or (PDuration.Minutes > 0) then
      Result:=Result + Format('%.2d m, ',[PDuration.Minutes]);
    Result:=Result + Format('%.2d.%d s',[PDuration.Seconds,PDuration.Milliseconds]);
  end;
begin
  // popola il dataset dei documenti
  LStopWatch:=TStopwatch.StartNew;
  try
    LResCtrl:=W034DM.PopolaDataset;

    // verifica errore operazione
    if not LResCtrl.Ok then
      FStatoElab:=LResCtrl.Messaggio;
  finally
    LStopWatch.Stop;
    lblTempoRicerca.Text:='Ricerca effettuata in ' + TimeSpanToTime(LStopWatch.Elapsed);

    // visualizza risultato ricerca
    ajnVisualizza.Notify;
  end;
end;

procedure TW034FPubblicazioneDocumenti.ajnVisualizzaNotify(Sender: TObject);
// tabella caricata: aggiorna visualizzazione
var
  LJSCode: String;
begin
  MessaggioPopup('');
  LJSCode:=Format('setTimeout(function() { SubmitClick("%s","",true);  }, 500);',[lnkVisualizza.HTMLName]);
  GGetWebApplicationThreadVar.CallBackResponse.AddJavascriptToExecuteAsCDATA(LJSCode);
end;

procedure TW034FPubblicazioneDocumenti.lnkVisualizzaClick(Sender: TObject);
// visualizza la tabella
var
  LSorg: String;
  LIdx: Integer;
  LGGDispCed: Integer;
  LDataDisp: TDateTime;
  LAnnoCorr: Integer;
  LAnno: Integer;
  LMeseProposto: TDateTime;
begin
  // sorgente documenti
  LSorg:=cmbTipologie.Items[cmbTipologie.ItemIndex].RowData[2];

  if FStatoElab = '' then
  begin
    if R180In(LSorg,[SORGENTE_FS_EXT,SORGENTE_T960]) then
    begin
      // carica grid documenti trovati e visualizza elementi interfaccia
      grdDocumenti.medpCaricaCDS;
      grdDocumenti.Visible:=True;
      lblTempoRicerca.Visible:=True;

      // gestione dei filtri in base ai record in tabella
      GestioneFiltri;
    end
    else
    begin
      // visualizza interfaccia per richiedere i dati da webservice
      if LSorg = SORGENTE_WS_ENGI_CEDOL then
      begin
        // cedolino

        // popola combobox anni in base a specifiche cliente (SAVONA_ASL2)
        cmbAnno.Items.Clear;
        LAnnoCorr:=Date.Year;
        for LAnno:=LAnnoCorr downto LAnnoCorr - 5 do
          cmbAnno.Items.Add(LAnno.ToString);

        // imposta evento alla modifica dell'anno selezionato
        cmbAnno.OnAsyncChange:=cmbAnnoAsyncChange;

        // visualizza scelta anno e mese
        lblAnno.Visible:=True;
        cmbAnno.Visible:=True;
        lblMese.Visible:=True;
        cmbMese.Visible:=True;

        // determina il giorno del mese da cui sono disponibili i cedolini
        LGGDispCed:=StrToIntDef(Parametri.CampiRiferimento.C90_W034GiornoMeseDispCedolino,0);

        // seleziona automaticamente anno / mese da proporre per la stampa
        if R180Between(LGGDispCed,1,31) then
        begin
          // determina la data di disponibilità del nuovo cedolino
          if LGGDispCed > R180GiorniMese(Date) then
            LDataDisp:=R180FineMese(Date)
          else
            LDataDisp:=EncodeDate(Date.Year,Date.Month,LGGDispCed);

          // se è stata raggiunta la data di disponibilità nel mese,
          // il cedolino proposto è quello è quello del mese in corso
          // altrimenti è si propone quello del mese precedente
          LMeseProposto:=IfThen(Date >= LDataDisp, Date, Date.AddMonths(-1));
        end
        else
        begin
          LMeseProposto:=Date.AddMonths(-1);
        end;
        LIdx:=cmbAnno.Items.IndexOf(LMeseProposto.Year.ToString);
        cmbAnno.ItemIndex:=LIdx;
        cmbAnnoAsyncChange(nil,nil);
        cmbMese.ItemIndex:=LMeseProposto.Month - 1;

        btnStampa.Caption:='Stampa cedolino';
      end
      else
      begin
        // certificazione unica

        // popola combobox anni in base a specifiche cliente (SAVONA_ASL2)
        cmbAnno.Items.Clear;
        LAnnoCorr:=Date.Year;
        for LAnno:=LAnnoCorr downto 2012 do
          cmbAnno.Items.Add(LAnno.ToString);

        // nessun evento alla modifica dell'anno selezionato
        cmbAnno.OnAsyncChange:=nil;

        // pulisce la combobox di scelta mese
        cmbMese.Items.Clear;

        // visualizza scelta anno e nasconde scelta mese
        lblAnno.Visible:=True;
        cmbAnno.Visible:=True;
        lblMese.Visible:=False;
        cmbMese.Visible:=False;

        // seleziona automaticamente l'anno corrente
        LIdx:=cmbAnno.Items.IndexOf(Date.Year.ToString);
        cmbAnno.ItemIndex:=LIdx;

        btnStampa.Caption:='Stampa CU';
      end;

      // visualizza il pulsante di stampa
      btnStampa.Visible:=True;
    end;
  end
  else
  begin
    // segnalazione errore
    MsgBox.MessageBox(FStatoElab,ESCLAMA);
  end;

  // dettaglio per debug
  memDettaglio.Clear;
  memDettaglio.Css:=IfThen(chkDettaglio.Checked,FmemDettaglioCss,'invisibile');
  if chkDettaglio.Checked then
    memDettaglio.Lines.AddStrings(W034DM.LstDettaglio);
end;

procedure TW034FPubblicazioneDocumenti.cmbAnnoAsyncChange(Sender: TObject; EventParams: TStringList);
var
  LMese: Integer;
  LMeseMax: Integer;
begin
  // se l'anno selezionato è quello corrente, i mesi sono limitati al mese corrente
  LMeseMax:=IfThen(cmbAnno.ItemIndex = cmbAnno.Items.IndexOf(Date.Year.ToString),Date.Month,12);

  // popola combobox mesi in base all'anno selezionato
  cmbMese.Items.Clear;
  for LMese:=1 to LMeseMax do
    cmbMese.Items.Add(Format('%.2d - %s',[LMese,R180NomeMese(LMese)]));
  cmbMese.ItemIndex:=0;
  cmbMese.Invalidate;
end;

procedure TW034FPubblicazioneDocumenti.cmbFiltroDocumentiChange(Sender: TObject);
// gestione del filtro del dataset
var
  c: Integer;
  LIWCmb: TmeIWComboBox;
  LNomeCampo,LValoreCampo,LFiltro: String;
begin
  W034DM.cdsFile.Filtered:=False;
  LFiltro:='';
  c:=1;
  while c < grdFiltroDocumenti.ColumnCount do
  begin
    if Assigned(grdFiltroDocumenti.Cell[0,c].Control) then
    begin
      // se la combobox ha un filtro specificato, lo applica
      LIWCmb:=(grdFiltroDocumenti.Cell[0,c].Control as TmeIWComboBox);
      if LIWCmb.ItemIndex > 0 then
      begin
        LNomeCampo:=LIWCmb.FriendlyName;
        LValoreCampo:=LIWCmb.Text;
        LFiltro:=Format('%s and (%s = ''%s'')',[LFiltro,LNomeCampo,LValoreCampo]);
      end;
    end;
    c:=c + 2;
  end;
  if LFiltro <> '' then
    LFiltro:=Copy(LFiltro,6);

  W034DM.cdsFile.Filter:=LFiltro;
  W034DM.cdsFile.Filtered:=(LFiltro <> '');
  grdDocumenti.medpCaricaCDS;
end;

procedure TW034FPubblicazioneDocumenti.cmbTipologieAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
var
  LSorg: String;
  LJSCode: String;
begin
  // decodifica descrizione tipologia e sorgente documenti
  if cmbTipologie.ItemIndex = -1 then
  begin
    lblDescTipologia.Caption:='';
    LSorg:='';
  end
  else
  begin
    lblDescTipologia.Caption:=cmbTipologie.Items[cmbTipologie.ItemIndex].RowData[1];
    LSorg:=cmbTipologie.Items[cmbTipologie.ItemIndex].RowData[2];
  end;

  // nasconde inizialmente gli elementi di interfaccia legati ai risultati di ricerca
  grdDocumenti.Visible:=False;
  lblFiltroDocumenti.Visible:=False;
  grdFiltroDocumenti.Visible:=False;
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute('$("#W034FiltroDocumenti").fadeOut(200); ');
  lblTempoRicerca.Visible:=False;
  lblAnno.Visible:=False;
  cmbAnno.Visible:=False;
  lblMese.Visible:=False;
  cmbMese.Visible:=False;
  btnStampa.Visible:=False;

  // dettaglio elaborazione
  chkDettaglio.Visible:=((DebugHook <> 0) or R180In(Parametri.Operatore,['SYSMAN','MONDOEDP'])) and
                        (LSorg = SORGENTE_FS_EXT);
  if not chkDettaglio.Visible then
    chkDettaglio.Checked:=False;

  // nasconde dettaglio elaborazione
  memDettaglio.Clear;
  memDettaglio.Css:='invisibile';

  // imposta lo stato di elaborazione iniziale
  FStatoElab:='';

  if R180In(LSorg,[SORGENTE_FS_EXT,SORGENTE_T960]) then
  begin
    // imposta le variabili anagrafiche con le info dell'utente attualmente loggato
    // (serve per la ricerca dei soli documenti afferenti al progressivo dell'utente)
    A118MW.ImpostaVariabiliAnagraficheDaUtente;

    // effettua ricerca documenti
    MessaggioPopup('Ricerca documenti in corso...');
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA('ActivateLock();');
    ajnPreparaDataset.Notify;
  end
  else
  begin
    // visualizza interfaccia per richiesta dati per webservice
    LJSCode:=Format('SubmitClick("%s","",true); ',[lnkVisualizza.HTMLName]);
    GGetWebApplicationThreadVar.CallBackResponse.AddJavascriptToExecuteAsCDATA(LJSCode);
  end;
end;

procedure TW034FPubblicazioneDocumenti.chkDettaglioAsyncClick(Sender: TObject; EventParams: TStringList);
var
  LJSCode: String;
begin
  // dettaglio per debug
  memDettaglio.Clear;
  memDettaglio.Css:=IfThen(chkDettaglio.Checked,FmemDettaglioCss,'invisibile');
  if chkDettaglio.Checked then
    memDettaglio.Lines.AddStrings(W034DM.LstDettaglio);

  LJSCode:=Format('$(".w034_colpath").%s();',[IfThen(chkDettaglio.Checked,'show','hide')]);
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(LJSCode);
end;

procedure TW034FPubblicazioneDocumenti.CaricaElencoTipologie;
// popola la combobox di elenco tipologie
var
  LResCtrl: TResCtrl;
  LSorg: String;
begin
  // imposta le variabili anagrafiche con le info dell'utente attualmente loggato
  // (serve per il controllo sul filtro visualizzazione tipologia)
  A118MW.ImpostaVariabiliAnagraficheDaUtente;

  // estrazione delle tipologie di documento
  A118MW.selI200.First;
  while not A118MW.selI200.Eof do
  begin
    LSorg:=A118MW.selI200.FieldByName('SORGENTE_DOCUMENTI').AsString;
    LResCtrl:=A118MW.CheckFiltroDocumenti(A118MW.selI200.FieldByName('FILTRO').AsString);
    if LResCtrl.Ok then
      cmbTipologie.AddRow(Format('%s;%s;%s',[A118MW.selI200.FieldByName('CODICE').AsString,A118MW.selI200.FieldByName('DESCRIZIONE').AsString,LSorg]));
    A118MW.selI200.Next;
  end;
end;

function TW034FPubblicazioneDocumenti.PreparaDatasetDocumenti: TResCtrl;
var
  LSorg: String;
begin
  Result:=W034DM.PreparaDataset(cmbTipologie.Text);

  if not Result.Ok then
    Exit;

  // determina sorgente documenti
  LSorg:=cmbTipologie.Items[cmbTipologie.ItemIndex].RowData[2];
  if R180In(LSorg,[SORGENTE_FS_EXT,SORGENTE_T960]) then
  begin
    // imposta la tabella
    grdDocumenti.medpAttivaGrid(W034DM.cdsFile,False,False);

    // visibilità campi
    grdDocumenti.medpColonna(CAMPO_NOME_DOCUMENTO).Visible:=LSorg = SORGENTE_T960;
    if LSorg = SORGENTE_T960 then
      grdDocumenti.medpColonna(CAMPO_ID).Visible:=False;

    // icona per download documento
    grdDocumenti.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','SALVA','Salva il documento','','C');
    grdDocumenti.medpPreparaComponenteGenerico('R',CAMPO_EXT_DOCUMENTO,0,DBG_LBL,'','','','','C');
  end;
end;

procedure TW034FPubblicazioneDocumenti.ClearFiltri;
var
  i: Integer;
begin
  // distrugge gli elementi di interfaccia per filtro dati
  for i:=0 to High(FFiltroDocArr) do
  begin
    FreeAndNil(FFiltroDocArr[i].FLabel);
    FreeAndNil(FFiltroDocArr[i].FCombo);
  end;
  SetLength(FFiltroDocArr,0);
end;

procedure TW034FPubblicazioneDocumenti.GestioneFiltri;
// predispone eventualmente le combobox di filtro per i campi con più valori
var
  i,c: Integer;
  LNomeCampo: String;
  LValoriMultipli: Boolean;
begin
  // distrugge gli elementi di interfaccia per filtro dati
  ClearFiltri;

  // esce subito se non ci sono record nel clientdataset
  if W034DM.cdsFile.RecordCount = 0 then
  begin
    grdFiltroDocumenti.ColumnCount:=1;
    Exit;
  end;

  // crea gli elementi di interfaccia per filtro dati
  SetLength(FFiltroDocArr,W034DM.cdsFile.FieldCount);
  for i:=0 to High(FFiltroDocArr) do
  begin
    // combo per filtro su valore specifico
    FFiltroDocArr[i].FCombo:=TmeIWComboBox.Create(Self);
    FFiltroDocArr[i].FCombo.Items.Duplicates:=dupIgnore;
    FFiltroDocArr[i].FCombo.Items.Sorted:=True;
    FFiltroDocArr[i].FCombo.Items.Add('');
    FFiltroDocArr[i].FCombo.FriendlyName:=W034DM.cdsFile.Fields[i].FieldName;

    // label con nome campo
    FFiltroDocArr[i].FLabel:=TmeIWLabel.Create(Self);
    FFiltroDocArr[i].FLabel.Caption:=W034DM.cdsFile.Fields[i].DisplayLabel;
    FFiltroDocArr[i].FLabel.ForControl:=FFiltroDocArr[i].FCombo;
  end;

  // popolamento delle combo con i valori distinct
  W034DM.cdsFile.First;
  while not W034DM.cdsFile.Eof do
  begin
    for i:=0 to W034DM.cdsFile.FieldCount - 1 do
    begin
      LNomeCampo:=W034DM.cdsFile.Fields[i].FieldName;
      if not R180In(LNomeCampo,[CAMPO_ID,CAMPO_NOME_DOCUMENTO,CAMPO_PATH_DOCUMENTO,CAMPO_PERIODO_DAL,CAMPO_PERIODO_AL]) then
        FFiltroDocArr[i].FCombo.Items.Add(W034DM.cdsFile.Fields[i].AsString);
    end;
    W034DM.cdsFile.Next;
  end;

  // seleziona primo elemento
  for i:=0 to High(FFiltroDocArr) do
  begin
    FFiltroDocArr[i].FCombo.ItemIndex:=0;
    FFiltroDocArr[i].FCombo.OnChange:=cmbFiltroDocumentiChange;
  end;

  // popola la grid di filtro
  grdFiltroDocumenti.ColumnCount:=W034DM.cdsFile.FieldCount * 2;
  c:=0;
  for i:=0 to High(FFiltroDocArr) do
  begin
    // se i valori nella combo sono almeno due diversi, visualizza la combobox
    LNomeCampo:=FFiltroDocArr[i].FCombo.FriendlyName;
    if not R180In(LNomeCampo,[CAMPO_ID,CAMPO_NOME_DOCUMENTO,CAMPO_PATH_DOCUMENTO,CAMPO_PERIODO_DAL,CAMPO_PERIODO_AL]) then
    begin
      LValoriMultipli:=FFiltroDocArr[i].FCombo.Items.Count > 2;
      if LValoriMultipli then
      begin
        grdFiltroDocumenti.Cell[0,c].Control:=FFiltroDocArr[i].FLabel;
        grdFiltroDocumenti.Cell[0,c + 1].Control:=FFiltroDocArr[i].FCombo;
        c:=c + 2;
      end;
    end;
  end;

  grdFiltroDocumenti.ColumnCount:=max(1,c);
end;

procedure TW034FPubblicazioneDocumenti.imgDownloadFileClick(Sender: TObject);
// download documento (storage su file system)
var
  i,c: Integer;
  IWC: TIWDBGridColumn;
  NomeFile: String;
begin
  i:=(Sender as TmeIWImageFile).FriendlyName.ToInteger;
  FNomeFileGenerato:=grdDocumenti.medpValoreColonna(i,CAMPO_PATH_DOCUMENTO);

  // nel nome documento cerca di inserire i dati delle colonne presenti a video
  FNomeFileDownload:='';
  for c:=0 to grdDocumenti.Columns.Count - 1 do
  begin
    IWC:=grdDocumenti.medpColonna(c);
    if Assigned(IWC) then
    begin
      if (IWC.Visible) and
         (not IWC.DataField.StartsWith('DBG_')) and
         (not R180In(IWC.DataField,[CAMPO_PATH_DOCUMENTO,CAMPO_NOME_DOCUMENTO,CAMPO_EXT_DOCUMENTO])) then
      begin
        FNomeFileDownload:=FNomeFileDownload + grdDocumenti.medpValoreColonna(i,IWC.DataField) + '_';
      end;
    end;
  end;
  FNomeFileDownload:=FNomeFileDownload + grdDocumenti.medpValoreColonna(i,CAMPO_NOME_DOCUMENTO);

  (*Alberto: ipotesi per aprire file in nuova pagina del browser
  NomeFile:=GetNomeFile(ExtractFileExt(FNomeFileGenerato));
  TFile.Copy(FNomeFileGenerato,NomeFile);
  VisualizzaFile(NomeFile,'Download file',nil,nil);
  exit;
  *)

  AddToInitProc(Format('SubmitClick("%s", "", true);',[btnSendFile.HTMLName]));
end;

procedure TW034FPubblicazioneDocumenti.imgDownloadDocumentaleClick(Sender: TObject);
// download documento (storage su gestione documentale)
var
  i: Integer;
  LId: Integer;
  LDoc: TDocumento;
  LResCtrl: TResCtrl;
begin
  i:=(Sender as TmeIWImageFile).FriendlyName.ToInteger;

  // estrae id richiesta
  LId:=grdDocumenti.medpValoreColonna(i,CAMPO_ID).ToInteger;

  // se l'id non è valido esce immediatamente
  if LId <= 0 then
    Exit;

  // estrae il file con i metadati associati
  A000SessioneWEB.AnnullaTimeOut;
  try
    LResCtrl:=C021DM.GetById(LId,True,LDoc);

    if not LResCtrl.Ok then
    begin
      MsgBox.MessageBox(LResCtrl.Messaggio,ESCLAMA);
      Exit;
    end;

    // aggiorna i dati di accesso e scarica il documento
    // IMPORTANTE: al momento i dati di accesso non sono aggiornati!!!
    try
      AggiornaAccessoEScarica(LDoc.Id,LDoc.FilePath);
    except
      on E: Exception do
      begin
        MsgBox.MessageBox(E.Message,ESCLAMA);
        Exit;
      end;
    end;
  finally
    FreeAndNil(LDoc);
    A000SessioneWEB.RipristinaTimeOut;
  end;
end;

procedure TW034FPubblicazioneDocumenti.AggiornaAccessoEScarica(const PId: Integer; const PFilePath: String);
begin
  // aggiorna i dati di lettura del file
  if Parametri.TipoOperatore = 'I060' then
  begin
    // utente di creazione è di I060 e il suo progressivo = T960.PROGRESSIVO
    // accesso al documento da parte di utente I060,
    // progressivo = T960.PROGRESSIVO e DATA_LETTURA_PROGRESSIVO is null
    C021DM.AggiornaDatiLettura(PId,Parametri.ProgressivoOper);
  end;

  // aggiorna i dati di accesso al file (esegue l'operazione solo per operatore win)
  C021DM.AggiornaDatiAccesso(PId,Parametri.Operatore);

  // effettua il download del file
  FNomeFileGenerato:=PFilePath;
  FNomeFileDownload:=TPath.GetFileName(FNomeFileGenerato);
  AddToInitProc(Format('SubmitClick("%s", "", true);',[btnSendFile.HTMLName]));
end;

procedure TW034FPubblicazioneDocumenti.btnSendFileClick(Sender: TObject);
begin
  GGetWebApplicationThreadVar.SendFile(FNomeFileGenerato,True,'application/x-download',FNomeFileDownload);
end;

procedure TW034FPubblicazioneDocumenti.btnStampaClick(Sender: TObject);
var
  LSorg: String;
  LInput: TInputOpenSession;
  LOutput: TOutputOpenSession;
  LSessionID: String;
  LInputCed: TInputCedolino;
  LOutputCed: TOutputCedolino;
  LMese: Integer;
  LInputCU: TInputCU;
  LOutputCU: TOutputCU;
begin
  // estrae il tipo di sorgente dei documenti
  LSorg:=VarToStr(A118MW.selI200.Lookup('CODICE',cmbTipologie.Text,'SORGENTE_DOCUMENTI'));

  // imposta parametri per richiesta nuova sessione
  // ***verificare se necessaria parametrizzazione dei dati
  LInput.User:=Parametri.CampiRiferimento.C90_W034WSUser;
  LInput.Azienda:='01';
  LInput.Password:=Parametri.CampiRiferimento.C90_W034WSPassword;
  LInput.Ufficio:='PERS';
  LInput.Entita:='ESEL';
  LInput.DataLavoro:=Date;

  try
    LOutput:=OpenSession(LInput);
    if LOutput.Ok then
    begin
      LSessionID:=LOutput.SessionID;

      if LSorg = SORGENTE_WS_ENGI_CU then
      begin
        // parametri per generazione CU
        LInputCU.CodFiscale:=Parametri.CodFiscaleOper;
        if not TryStrToInt(cmbAnno.Text,LInputCU.Anno) then
        begin
          MsgBox.MessageBox('L''anno indicato per la stampa della CU non è valido!',ESCLAMA);
          Exit;
        end;
        // l'anno effettivo è quello precedente a quello richiesto
        LInputCU.Anno:=LInputCU.Anno - 1;

        LOutputCU:=GetCU(LSessionID,LInputCU);

        if LOutputCU.Ok then
        begin
          // imposta nome e path del file temporaneo da inviare al browser
          FNomeFileDownload:=Format('CU_%s_%s.pdf',[Parametri.MatricolaOper,cmbAnno.Text]);
          { DONE : TEST IW 14 OK }
          FNomeFileGenerato:=TPath.Combine(WebApplication.UserCacheDir,FNomeFileDownload);

          // decodifica la CU da base64
          R180DecodeFileB64(LOutputCU.Cud,FNomeFileGenerato);

          // effettua il download del file
          AddToInitProc(Format('SubmitClick("%s", "", true);',[btnSendFile.HTMLName]));
        end
        else
        begin
          MsgBox.MessageBox(Format('Si è verificato un errore durante la generazione della CU:'#13#10'%s',[LOutputCU.ToString]),ESCLAMA);
          Exit;
        end;
      end
      else if LSorg = SORGENTE_WS_ENGI_CEDOL then
      begin
        LMese:=cmbMese.ItemIndex + 1;

        // parametri per generazione cedolino
        LInputCed.CodFiscale:=Parametri.CodFiscaleOper;
        LInputCed.MeseAnno:=Format('%.2d/%s',[LMese,cmbAnno.Text]);
        LInputCed.AlfaUno:='S'; //*** ???
        LInputCed.AlfaDue:='SV';

        LOutputCed:=GetCedolino(LSessionID,LInputCed);

        if LOutputCed.Ok then
        begin
          // imposta nome e path del file temporaneo da inviare al browser
          FNomeFileDownload:=Format('cedolino_%s_%s_%s.pdf',[Parametri.MatricolaOper,R180NomeMese(LMese),cmbAnno.Text]);
          { DONE : TEST IW 14 OK }
          FNomeFileGenerato:=TPath.Combine(WebApplication.UserCacheDir,FNomeFileDownload);

          // decodifica il cedolino da base64
          R180DecodeFileB64(LOutputCed.Cedolino,FNomeFileGenerato);

          // effettua il download del file
          AddToInitProc(Format('SubmitClick("%s", "", true);',[btnSendFile.HTMLName]));
        end
        else
        begin
          MsgBox.MessageBox(Format('%s',[LOutputCed.ToString]),ESCLAMA);
          Exit;
        end;
      end;
    end
    else
    begin
      MsgBox.MessageBox(Format('Si è verificato un errore durante la fase di OpenSession:'#13#10'%s - %s',[LOutput.ExceptionCode,LOutput.ExceptionDesc]),ESCLAMA);
      Exit;
    end;
  except
    on E: Exception do
    begin
      MsgBox.MessageBox(Format('Si è verificato un errore durante la stampa:'#13#10'%s',[E.Message]),ESCLAMA);
      Exit;
    end;
  end;
end;

{$REGION 'JBFService Engineering'}

function TW034FPubblicazioneDocumenti.CallService(PInputXML: String): TResCtrl;
var
  LJSB: EngiWebService;
  LUrl: String;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  // estrae url webservice da richiamare
  LUrl:=VarToStr(A118MW.selI200.Lookup('CODICE',cmbTipologie.Text,'URL_WS'));

  // richiama il web service JBF con la richiesta
  if (not IsLibrary) then
    CoInitialize(nil);
  try
    LJSB:=(JBFService.GetDefaultWebService(False,LUrl) as EngiWebService);
    try
      Result.Messaggio:=LJSB.call(PInputXML);
    except
      on E:Exception do
      begin
        Result.Messaggio:=Format('Chiamata al metodo "call" fallita: %s',[E.Message]);
        Exit;
      end;
    end;
  finally
    if (not IsLibrary) then
      CoUninitialize;
  end;

  Result.Ok:=True;
end;

procedure TW034FPubblicazioneDocumenti.ParseOutputXML(const PXMLString: String; var PXMLDoc: TXMLDocument);
begin
  xmlDoc.XML.Clear;
  xmlDoc.XML.Add(PXMLString);
  if (not IsLibrary) then
    CoInitialize(nil);
  try
    try
      xmlDoc.Active:=True;
    except
      on E:Exception do
      begin
        raise Exception.CreateFmt('Errore risposta: %s (%s)',[E.ClassName,E.Message]);
      end;
    end;
  finally
    if (not IsLibrary) then
      CoUninitialize;
  end;
end;

function TW034FPubblicazioneDocumenti.OpenSession(PParam: TInputOpenSession): TOutputOpenSession;
var
  LDataLavoro: String;
  LInputXML: string;
  LOutputXML: String;
  LResCtrl: TResCtrl;
  LNodeLst: IDOMNodeList;
begin
  Result.Ok:=False;

  LDataLavoro:=FormatDateTime('yyyymmdd',PParam.DataLavoro);
  LInputXML:=Format(XML_IN_OPEN_SESSION,[PParam.User,PParam.Password,PParam.Azienda,PParam.Ufficio,LDataLavoro,PParam.Entita]);

  LResCtrl:=CallService(LInputXML);

  if LResCtrl.Ok then
  begin
    LOutputXML:=LResCtrl.Messaggio;
  end
  else
  begin
    raise Exception.CreateFmt('Errore in fase di chiamata al servizio OpenSession: %s',[LResCtrl.Messaggio]);
  end;

  // esegue il parsing del xml di risposta
  ParseOutputXML(LOutputXML,xmlDoc);

  // verifica l'xml di risposta

  // 1. verifica errori gravi
  LNodeLst:=xmlDoc.DOMDocument.getElementsByTagName('Exception');
  if Assigned(LNodeLst) and (LNodeLst.Length > 0) then
  begin
    // estrae codice e descrizione errore
    LNodeLst:=xmlDoc.DOMDocument.getElementsByTagName('Code');
    if Assigned(LNodeLst) and (LNodeLst.Length > 0) then
    begin
      try
        Result.ExceptionCode:=LNodeLst.item[0].childNodes[0].nodeValue;
      except
      end;
    end;

    LNodeLst:=xmlDoc.DOMDocument.getElementsByTagName('Description');
    if Assigned(LNodeLst) and (LNodeLst.Length > 0) then
    begin
      try
        Result.ExceptionDesc:=LNodeLst.item[0].childNodes[0].nodeValue;
      except
      end;
    end;

    Exit;
  end;

  // risposta ok
  LNodeLst:=xmlDoc.DOMDocument.getElementsByTagName('SessionID');
  if Assigned(LNodeLst) and (LNodeLst.Length > 0) then
  begin
    try
      Result.SessionID:=LNodeLst.item[0].childNodes[0].nodeValue;
    except
    end;
  end;

  Result.Ok:=True;
end;

function TW034FPubblicazioneDocumenti.GetCedolino(const PSessionId: String; PParam: TInputCedolino): TOutputCedolino;
var
  LInputXML: String;
  LResCtrl: TResCtrl;
  LOutputXML: String;
  LNodeLst: IDOMNodeList;
begin
  Result.Ok:=False;

  // prepara input e richiama servizio
  LInputXML:=Format(XML_IN_CEDOLINO,[PSessionId,PParam.CodFiscale,PParam.MeseAnno,PParam.AlfaUno,PParam.AlfaDue]);
  LResCtrl:=CallService(LInputXML);

  if LResCtrl.Ok then
  begin
    LOutputXML:=LResCtrl.Messaggio;
  end
  else
  begin
    raise Exception.CreateFmt('Errore in fase di chiamata al servizio Cedolino: %s',[LResCtrl.Messaggio]);
  end;

  // esegue il parsing del xml di risposta
  ParseOutputXML(LOutputXML,xmlDoc);

  // verifica la risposta

  // 1. verifica errori gravi
  LNodeLst:=xmlDoc.DOMDocument.getElementsByTagName('Exception');
  if Assigned(LNodeLst) and (LNodeLst.Length > 0) then
  begin
    // estrae codice e descrizione errore
    LNodeLst:=xmlDoc.DOMDocument.getElementsByTagName('Code');
    if Assigned(LNodeLst) and (LNodeLst.Length > 0) then
    begin
      try
        Result.ExceptionCode:=LNodeLst.item[0].childNodes[0].nodeValue;
      except
      end;
    end;

    LNodeLst:=xmlDoc.DOMDocument.getElementsByTagName('Description');
    if Assigned(LNodeLst) and (LNodeLst.Length > 0) then
    begin
      try
        Result.ExceptionDesc:=LNodeLst.item[0].childNodes[0].nodeValue;
      except
      end;
    end;

    Exit;
  end;

  // errori non bloccanti
  LNodeLst:=xmlDoc.DOMDocument.getElementsByTagName('logErrore');
  if Assigned(LNodeLst) and (LNodeLst.Length > 0) then
  begin
    if LNodeLst.item[0].childNodes.Length > 0 then
    begin
      try
        Result.LogErrore:=LNodeLst.item[0].childNodes[0].nodeValue;
      except
      end;
    end;
  end;

  // risposta ok
  LNodeLst:=xmlDoc.DOMDocument.getElementsByTagName('cedolino');
  if Assigned(LNodeLst) and (LNodeLst.Length > 0) then
  begin
    if LNodeLst.item[0].childNodes.Length > 0 then
    begin
      try
        Result.Cedolino:=LNodeLst.item[0].childNodes[0].nodeValue;
      except
      end;
    end;
  end;

  // risultato operazione
  Result.Ok:=(Result.LogErrore = '');
end;

function TW034FPubblicazioneDocumenti.GetCU(const PSessionId: String; PParam: TInputCU): TOutputCU;
var
  LInputXML: String;
  LResCtrl: TResCtrl;
  LOutputXML: String;
  LNodeLst: IDOMNodeList;
begin
  Result.Ok:=False;

  // prepara input e richiama servizio
  LInputXML:=Format(XML_IN_CUD,[PSessionId,PParam.CodFiscale,PParam.Anno]);
  LResCtrl:=CallService(LInputXML);

  if LResCtrl.Ok then
  begin
    LOutputXML:=LResCtrl.Messaggio;
  end
  else
  begin
    raise Exception.CreateFmt('Errore in fase di chiamata al servizio Cud: %s',[LResCtrl.Messaggio]);
  end;

  // esegue il parsing del xml di risposta
  ParseOutputXML(LOutputXML,xmlDoc);

  // verifica la risposta

  // 1. verifica errori gravi
  LNodeLst:=xmlDoc.DOMDocument.getElementsByTagName('Exception');
  if Assigned(LNodeLst) and (LNodeLst.Length > 0) then
  begin
    // estrae codice e descrizione errore
    LNodeLst:=xmlDoc.DOMDocument.getElementsByTagName('Code');
    if Assigned(LNodeLst) and (LNodeLst.Length > 0) then
    begin
      try
        Result.ExceptionCode:=LNodeLst.item[0].childNodes[0].nodeValue;
      except
      end;
    end;

    LNodeLst:=xmlDoc.DOMDocument.getElementsByTagName('Description');
    if Assigned(LNodeLst) and (LNodeLst.Length > 0) then
    begin
      try
        Result.ExceptionDesc:=LNodeLst.item[0].childNodes[0].nodeValue;
      except
      end;
    end;

    Exit;
  end;

  // errori non bloccanti
  LNodeLst:=xmlDoc.DOMDocument.getElementsByTagName('logErrore');
  if Assigned(LNodeLst) and (LNodeLst.Length > 0) then
  begin
    if LNodeLst.item[0].childNodes.Length > 0 then
    begin
      try
        Result.LogErrore:=LNodeLst.item[0].childNodes[0].nodeValue;
      except
      end;
    end;
  end;

  // risposta ok
  LNodeLst:=xmlDoc.DOMDocument.getElementsByTagName('cud');
  if Assigned(LNodeLst) and (LNodeLst.Length > 0) then
  begin
    if LNodeLst.item[0].childNodes.Length > 0 then
    begin
      try
        Result.Cud:=LNodeLst.item[0].childNodes[0].nodeValue;
      except
      end;
    end;
  end;

  // risultato operazione
  Result.Ok:=(Result.LogErrore = '');
end;

{$ENDREGION}

{ TOutputCedolino }

function TOutputCedolino.ToString: String;
begin
  if Ok then
    Result:='ok'
  else
  begin
    // eccezione
    if ExceptionCode <> '' then
      Result:=Format('Eccezione: %s - %s',[ExceptionCode,ExceptionDesc])
    else if ExceptionDesc <> '' then
      Result:=Format('Eccezione: %s',[ExceptionDesc]);

    // aggiunge il log errore
    if LogErrore <> '' then
      Result:=Result + IfThen(Result <> '',#13#10) + LogErrore;
  end;
end;

{ TOutputCud }

function TOutputCU.ToString: String;
begin
  if Ok then
    Result:='ok'
  else
  begin
    if ExceptionCode <> '' then
      Result:=Format('Eccezione: %s - %s',[ExceptionCode,ExceptionDesc]);

    if LogErrore <> '' then
      Result:=Result + IfThen(Result <> '',#13#10) + LogErrore;
  end;
end;

end.
