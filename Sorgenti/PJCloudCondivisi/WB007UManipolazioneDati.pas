unit WB007UManipolazioneDati;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR100UBase, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton,
  meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, meIWLink, medpIWC700NavigatorBar, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, medpIWTabControl, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, meIWRegion, A000UInterfaccia,
  meIWRadioGroup, IWAdvRadioGroup, meTIWAdvRadioGroup, IWCompListbox,
  meIWComboBox, WB007UManipolazioneDatiDM, B007UManipolazioneDatiMW, IWCompCheckbox, meIWCheckBox,
  IWDBGrids, medpIWDBGrid, C180FunzioniGenerali, C190FunzioniGeneraliWeb, medpIWMultiColumnComboBox,
  meIWImageFile, medpIWImageButton , medpIWMessageDlg, A000UMessaggi,
  WC020UInputDataOreFM, IWCompJQueryWidget, Generics.Collections,
  A000UCostanti, IWAdvCheckGroup,
  meTIWAdvCheckGroup, OracleData, WC013UCheckListFM, IWApplication,
  IWCompMemo, meIWMemo, Data.DB, IWCompFileUploader, meIWFileUploader;

type

  TAzione = class
  private
    FCaption: String;
    FRegion: TmeIWRegion;
  public
    constructor Create(Az: String; Reg: TMeIWRegion); overload;
    property Caption : String read FCaption write FCaption;
    property Region: TmeIWregion read FRegion write FRegion;
  end;

  TListAzioni = class(TList<TAzione>)
  public
    function getRegion(Az: String):TmeIWRegion;
    destructor destroy; override;
  end;

  TWB007FManipolazioneDati = class(TWR100FBase)
    edtDallaData: TmeIWEdit;
    edtAllaData: TmeIWEdit;
    lblDallaData: TmeIWLabel;
    lblAllaData: TmeIWLabel;
    grdTabDetailold: TmedpIWTabControl;
    WB007StoricizzazioneRG: TmeIWRegion;
    TemplateStoricizazioneRG: TIWTemplateProcessorHTML;
    cmbDatoAgg: TmeIWComboBox;
    lblDatoAgg: TmeIWLabel;
    chkStorico: TmeIWCheckBox;
    chkStoriciSuccessivi: TmeIWCheckBox;
    grdValori: TmedpIWDBGrid;
    btnEsegui: TmedpIWImageButton;
    WB007CancellazioneRG: TmeIWRegion;
    TemplateCancellazioneRG: TIWTemplateProcessorHTML;
    rgpCancDati: TmeTIWAdvRadioGroup;
    btnAggiornaSchedeAnag: TmedpIWImageButton;
    btnAnomalie: TmedpIWImageButton;
    chkLogSchedeAnag: TmeIWCheckBox;
    lblCaptionElencoMatricole: TmeIWLabel;
    JQuery: TIWJQueryWidget;
    grdSchedeAnag: TmeIWGrid;
    btnLog: TmedpIWImageButton;
    lblCaptionElencoTabelle: TmeIWLabel;
    cgpTabelle: TmeTIWAdvCheckGroup;
    WB007CancellazioneGiustRG: TmeIWRegion;
    rgpCancGiust: TmeTIWAdvRadioGroup;
    cgpCausGiust: TmeTIWAdvCheckGroup;
    TemplateCancellazioneGiust: TIWTemplateProcessorHTML;
    lblElencoCausali: TmeIWLabel;
    TemplateRicodificaGiustRG: TIWTemplateProcessorHTML;
    rgpPeriodi: TmeTIWAdvRadioGroup;
    WB007RicodificaGiustRG: TmeIWRegion;
    rgpRicodificaGiust: TmeTIWAdvRadioGroup;
    edtOldCausale: TmeIWEdit;
    lblOldCausale: TmeIWLabel;
    cmbCausali: TMedpIWMultiColumnComboBox;
    lblCausali: TmeIWLabel;
    lblDescCausale: TmeIWLabel;
    rgpTipoCaus: TmeIWRadioGroup;
    lblTipoCaus: TmeIWLabel;
    WB007RiallineamentoGiustRG: TmeIWRegion;
    TemplateRiallineamentoGiustRG: TIWTemplateProcessorHTML;
    lblCausaliAss: TmeIWLabel;
    edtCausali: TmeIWEdit;
    btnElencoCausali: TmeIWButton;
    WB007UnificazioneMatrRG: TmeIWRegion;
    TemplateUnificazioneMatrRG: TIWTemplateProcessorHTML;
    lblDatiAnag: TmeIWLabel;
    edtDatiAnag: TmeIWEdit;
    btnDatiAnag: TmeIWButton;
    btnAggiornaMatr: TmedpIWImageButton;
    grdMatricole: TmeIWGrid;
    WB007EsecuzioneScriptRG: TmeIWRegion;
    TemplateEsecuzioneScriptRG: TIWTemplateProcessorHTML;
    btnVisualizzaFile: TmedpIWImageButton;
    lbFileScelto: TmeIWLabel;
    lblFileSceltoDescr: TmeIWLabel;
    memLog: TmeIWMemo;
    WB007CestinoRG: TmeIWRegion;
    cmbFiltroTabelle: TMedpIWMultiColumnComboBox;
    lblFunzione: TmeIWLabel;
    TemplateCestinoRG: TIWTemplateProcessorHTML;
    grdCestino: TmedpIWDBGrid;
    lblAzione: TmeIWLabel;
    cmbAzione: TmeIWComboBox;
    WB007AllineaTimbRG: TmeIWRegion;
    btnRefreshAllTimb: TmedpIWImageButton;
    grdTimbUguali: TmedpIWDBGrid;
    TemplateAllineaTimb: TIWTemplateProcessorHTML;
    fileUpload: TmeIWFileUploader;
    btnAfterUpload: TmeIWButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure cmbDatoAggChange(Sender: TObject);
    procedure grdValoriDataSet2Componenti(Row: Integer);
    procedure edtDallaDataAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnEseguiClick(Sender: TObject);
    procedure grdValorimedpStatoChange;
    procedure rgpCancDatiClick(Sender: TObject);
    procedure btnAggiornaSchedeAnagClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure btnLogClick(Sender: TObject);
    procedure rgpCancGiustClick(Sender: TObject);
    procedure rgpRicodificaGiustClick(Sender: TObject);
    procedure rgpPeriodiAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure cmbCausaliAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure rgpTipoCausAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnElencoCausaliClick(Sender: TObject);
    procedure grdRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure btnDatiAnagClick(Sender: TObject);
    procedure btnAggiornaMatrClick(Sender: TObject);
    procedure btnVisualizzaFileClick(Sender: TObject);
    procedure cmbFiltroTabelleChange(Sender: TObject; Index: Integer);
    procedure grdCestinoAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure cmbAzioneChange(Sender: TObject);
    procedure btnRefreshAllTimbClick(Sender: TObject);
    procedure btnAfterUploadClick(Sender: TObject);
  private
    lstAzioni: TListAzioni;
    CurrentRegion: TmeIWRegion;
    DallaData, AllaData: TDateTime;
    bElaborazioneAggiornaSchedeAnag,
    bCicloLstElemeti: Boolean;
    lstElementi, lstElencoTab: TStringList;
    lastIndexRgpCancDati,
    idxElementoCorrente: Integer;
    SalvaFine: String;
    PathFileUploaded: String;
    PreparazioneStoricizzazione: TPreparazioneStoricizzazione;
    ParametriStoricizzazione: TParametriStoricizzazione;
    bRecordAggiornati: Boolean;
    LstMessaggi: TStringList;
    tempoCancellazione: TtempoCancellazione;
    WB007FManipolazioneDatiDM: TWB007FManipolazioneDatiDM;
    DatiAgg: TDatiAgg;
    procedure CaricaCmbDatoAgg;
    procedure ControlloDipendenti;
    function ControlliStoricizzazioneDati: String;
    procedure ResultConfermaStart(Sender: TObject; Res: TmeIWModalResult;KeyID: String);
    function ControlliCancellazioneDatiDipendente: String;
    procedure ResultConfermaCancellazione(Sender: TObject;
      Res: TmeIWModalResult; KeyID: String);
    procedure ResultInputCancellazione(Sender: TObject; Result: Boolean;
      Valore: String);
    procedure CaricaGridSchedeAnag;
    function ControlliCancellazioneSchedaAnag: String;
    function ControlliCancellazionePeriodica: String;
    procedure AbilitazioniTabCancDati;
    procedure AbilitazioniTabStoricizzazione;
    procedure AbilitazioniTabGiustificativi;
    function ControlliCancellazioneGiustificativi: String;
    procedure AbilitazioniTabRicodifica;
    procedure CaricaCmbCausali;
    function ControlliRicodificaGiustificativi: String;
    function ControlliAllineamentoTimbrature: String;
    procedure CausaliAssenzaResult(Sender: TObject; Result: Boolean);
    procedure AbilitazioniTabRiallineamentoGiust;
    function ControlliRiallineamentoGiustificativi: String;
    procedure CaricaGridMatricole;
    procedure AbilitazioniTabUnificazioneMatr;
    procedure DatiAnagResult(Sender: TObject; Result: Boolean);
    function ControlliUnificazioneMatricole: String;
    procedure RecuperaFile;
    procedure AbilitazioniTabEsecuzioneScript;
    procedure ControlliEsecuzioneScript;
    procedure AbilitazioniTabCestino;
    procedure imgRipristinaClick(Sender: TObject);
    procedure ResultCestinoRipristina(Sender: TObject; R: TmeIWModalResult;
      KI: String);
    procedure EseguiRipristina(NuovoValore: String);
    procedure ResultCestinoNuovoValore(Sender: TObject; Result: Boolean;
      Valore: String);
    procedure ResultCestinoRinomina(Sender: TObject; R: TmeIWModalResult;
      KI: String);
    procedure imgCancellaClick(Sender: TObject);
    procedure ResultCestinoCancella(Sender: TObject; R: TmeIWModalResult;
      KI: String);
    procedure OnAzioneChange;
    procedure AbilitazioniTabAllineaTimb;
  protected
    procedure WC700AperturaSelezione(Sender: TObject); override;
    procedure InizioElaborazione; override;
    function ElementoSuccessivo: Boolean; override;
    function CurrentRecordElaborazione: Integer; override;
    function TotalRecordsElaborazione: Integer; override;
    procedure ElaboraElemento; override;
    procedure FineCicloElaborazione; override;
    function ElaborazioneTerminata:String; override;
    procedure DistruzioneOggettiElaborazione(Errore: Boolean); override;
  public
    function InizializzaAccesso: Boolean; override;
  end;

implementation

uses A023UAllTimbMW;

{$R *.dfm}

procedure TWB007FManipolazioneDati.IWAppFormCreate(Sender: TObject);
var
  Az: TAzione;
begin
  inherited;
  WB007FManipolazioneDatiDM:=TWB007FManipolazioneDatiDM.Create(Self);
  grdC700:=TmedpIWC700NavigatorBar.Create(Self);//Alberto: creato prima di AttivaGestioneC700 per impostare le altre proprietà non standard
  grdC700.ImpostaProgressivoCorrente:=False;
  grdC700.SelezioneVuota:=True;
  grdC700.AttivaBrowse:=False;

  AttivaGestioneC700;
  WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.SelAnagrafe:=grdC700.selAnagrafe;

  LstMessaggi:=TStringList.Create;
  btnLog.Enabled:=False;
  btnAnomalie.Enabled:=False;

  //Storicizzazione
  lstAzioni:=TListAzioni.Create();
  lstAzioni.Add(TAzione.Create('Storicizzazione/Aggiornamento dati',WB007StoricizzazioneRG));
  lstAzioni.Add(TAzione.Create('Cancellazione dati',WB007CancellazioneRG));
  lstAzioni.Add(TAzione.Create('Cancellazione giustificativi',WB007CancellazioneGiustRG));
  lstAzioni.Add(TAzione.Create('Ricodifica giustif. Assenza/Presenza',WB007RicodificaGiustRG));
  lstAzioni.Add(TAzione.Create('Riallineamento giustificativi',WB007RiallineamentoGiustRG));
  lstAzioni.Add(TAzione.Create('Unificazione matricole',WB007UnificazioneMatrRG));
  lstAzioni.Add(TAzione.Create('Esecuzione script',WB007EsecuzioneScriptRG));
  lstAzioni.Add(TAzione.Create('Cestino',WB007CestinoRG));
  lstAzioni.Add(TAzione.Create('Allineamento timbrature',WB007AllineaTimbRG));

  cmbAzione.Items.Clear;
  for Az in lstAzioni do
  begin
    cmbAzione.items.Add(Az.Caption);
    Az.Region.Visible:=False;
  end;
  CurrentRegion:=nil;
  cmbAzione.ItemIndex:=0;
  OnAzioneChange;

  lstElementi:=TStringList.Create;
  lstElencoTab:=TStringList.Create;

  DatiAgg.SelezioneAnagrafe:='';
  DatiAgg.Dal:=DATE_NULL;
  DatiAgg.Al:=DATE_NULL;
end;

function TWB007FManipolazioneDati.InizializzaAccesso: boolean;
var
  i: Integer;
  lstTabelleCestino: TStringList;
  s: String;
begin
  Result:=False;
  DallaData:=Parametri.DataLavoro;
  AllaData:=Parametri.DataLavoro;

  edtDallaData.Text:=DateToStr(DallaData);
  edtAllaData.Text:=DateToStr(AllaData);

  //Storicizzazione
  CaricaCmbDatoAgg;
  WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.DatoDaAggiornare:=CmbDatoAgg.SelectedValue;
  ChkStorico.Checked:=True;
  grdValori.medpAttivaGrid(WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.CdsValori,not SolaLettura, not SolaLettura, not SolaLettura);
  grdValori.medpPreparaComponenteGenerico('WR102',grdValori.medpIndexColonna('VALOREOLD'),0,DBG_MECMB,'25','1','','','S');
  grdValori.medpPreparaComponenteGenerico('WR102',grdValori.medpIndexColonna('VALORENEW'),0,DBG_MECMB,'25','1','','','S');

  //cancellazione dati
  lastIndexRgpCancDati:=-1;

  WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.ImpostaCdsDipendenti;
  CaricaGridSchedeAnag;

  lstElencoTab.Clear;
  for i:=0 to high(TabelleCancella) do
    lstElencoTab.Add(WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.ItemTabellaCancella(i));

  //Cancellazione giustificativi
  with WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.selQ265 do
  begin
    First;
    while not Eof do
    begin
      cgpCausGiust.Items.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
      Next;
    end;
  end;
  //Ricodifica giustificativi
  CaricaCmbCausali;
  edtOldCausale.Text:='';

  //Allineamento giustificativi
  edtCausali.Text:='';

  //Unificazione matricole
  edtDatiAnag.Text:='';
  CaricaGridMatricole;

  //Esecuzione script
  PathFileUploaded:='';
  lblFileSceltoDescr.Caption:='';
  //Necessario altrimenti la pressione del pulsante fa sparire il componente upload
  { DONE : TEST IW 14 OK }
  //btnVisualizzaFile.DontSubmitFiles:=True;

  //Cestino
  lstTabelleCestino:=TStringList.Create;
  with WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW do
  begin
    MyCestino.ListaTabelle(lstTabelleCestino);
    for s in lstTabelleCestino do
    begin
      cmbFiltroTabelle.AddRow(s);
    end;
    FreeAndNil(lstTabelleCestino);

    grdCestino.medpComandiCustom:=True;
    //fittizio serve solo per non estrarre nulla e partire con dataset vuoto
    MyCestino.Seek_selI025('<fittizio>');
    grdCestino.medpAttivaGrid(MyCestino.Get_selI025,False,False);
    grdCestino.medpPreparaComponenteGenerico('WR102-R',grdCestino.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','IMPORTA','','','');
    grdCestino.medpPreparaComponenteGenerico('WR102-R',grdCestino.medpIndexColonna('DBG_COMANDI'),1,DBG_IMG,'','CANCELLA','','','');

    grdCestino.medpCaricaCDS();
  end;

  OnAzioneChange;
  Result:=True;
end;

procedure TWB007FManipolazioneDati.cmbAzioneChange(Sender: TObject);
begin
  inherited;
  OnAzioneChange;
end;

procedure TWB007FManipolazioneDati.cmbCausaliAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  if cmbCausali.ItemIndex >=0 then
    lblDescCausale.Caption:=cmbCausali.Items[cmbCausali.ItemIndex].RowData[1]
  else
    lblDescCausale.Caption:='';
end;

procedure TWB007FManipolazioneDati.cmbDatoAggChange(Sender: TObject);
begin
  inherited;
  WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.DatoDaAggiornare:=CmbDatoAgg.SelectedValue;
  WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.ResetCdsValori;
  grdValori.medpAggiornaCDS(True);
end;

procedure TWB007FManipolazioneDati.cmbFiltroTabelleChange(Sender: TObject;
  Index: Integer);
begin
  inherited;
  with WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW do
  begin
    MyCestino.Seek_selI025(MyCestino.DescToCod(cmbFiltrotabelle.Text));
    grdCestino.medpAggiornaCDS(True);
  end;
end;

procedure TWB007FManipolazioneDati.edtDallaDataAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  if (CurrentRegion = WB007StoricizzazioneRG) and (rgpPeriodi.ItemIndex = 1) then
  begin
    edtAllaData.Text:=edtDallaData.Text;
  end;
end;

procedure TWB007FManipolazioneDati.grdCestinoAfterCaricaCDS(Sender: TObject;
  DBG_ROWID: string);
var
  r: Integer;
  img: TmeIWImageFile;
begin
  inherited;
  for r:=0 to High(grdCestino.medpCompGriglia) do
  begin
    if grdCestino.medpCompCella(r,grdCestino.medpIndexColonna('DBG_COMANDI'),0) <> nil then
    begin
      img:=(grdCestino.medpCompCella(r,grdCestino.medpIndexColonna('DBG_COMANDI'),0) as TmeIWImageFile);
      img.hint:='Ripristina';
      img.OnClick:=imgRipristinaClick;
    end;
    if grdCestino.medpCompCella(r,grdCestino.medpIndexColonna('DBG_COMANDI'),1) <> nil then
    begin
      img:=(grdCestino.medpCompCella(r,grdCestino.medpIndexColonna('DBG_COMANDI'),1) as TmeIWImageFile);
      img.hint:='Cancella';
      img.OnClick:=imgCancellaClick;
    end;
  end;
end;

procedure TWB007FManipolazioneDati.imgCancellaClick(Sender: TObject);
var
  r: Integer;
  Chiave: String;
begin
  r:=grdCestino.medpRigaDiCompGriglia((Sender as TmeIWImageFile).FriendlyName);
  Chiave:=grdCestino.medpValoreColonna(r, 'CHIAVE');

  with WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW do
    MyCestino.Get_selI025.SearchRecord('ROWID', grdCestino.medpCompGriglia[r].RowID,[srFromBeginning]);

  MsgBox.WebMessageDlg(Format(A000MSG_B007_DLG_FMT_CANCELLA_CODICE,[Chiave]),mtConfirmation,[mbYes,mbNo],ResultCestinoCancella,'');
  Exit;
end;

procedure TWB007FManipolazioneDati.imgRipristinaClick(Sender: TObject);
var r: Integer;
    Chiave: String;
begin
  r:=grdCestino.medpRigaDiCompGriglia((Sender as TmeIWImageFile).FriendlyName);
  Chiave:=grdCestino.medpValoreColonna(r, 'CHIAVE');

  with WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW do
    MyCestino.Get_selI025.SearchRecord('ROWID', grdCestino.medpCompGriglia[r].RowID,[srFromBeginning]);

  MsgBox.WebMessageDlg(Format(A000MSG_B007_DLG_FMT_RIPRISTINA_CODICE,[Chiave]),mtConfirmation,[mbYes,mbNo],ResultCestinoRipristina,'');
  Exit;
end;

procedure TWB007FManipolazioneDati.ResultCestinoCancella(Sender: TObject; R: TmeIWModalResult; KI: String);
var
  Msg: String;
begin
  if R = mrYes then
  begin
    with WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW do
    begin
      Msg:=CancellaCestino;

      if Trim(Msg) <> '' then
        MsgBox.WebMessageDlg(Msg,mtError,[mbOk],nil,'')
      else
        MsgBox.WebMessageDlg(A000MSG_B007_DLG_CANCELLA_OK,mtInformation,[mbOk],nil,'');

      MyCestino.Get_selI025.Refresh;
      grdCestino.medpAggiornaCDS(True);
    end;
  end;
end;

procedure TWB007FManipolazioneDati.ResultCestinoRipristina(Sender: TObject; R: TmeIWModalResult; KI: String);
var
  NuovoValore, Msg: String;
begin
  if R = mrYes then
  begin
    with WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW do
    begin
      NuovoValore:='';
      if MyCestino.TestRipristino then
      begin
        NuovoValore:=MyCestino.Get_selI025.FieldByName('CHIAVE').AsString;

        Msg:=Format(A000MSG_B007_DLG_FMT_RIDEF_RIPRISTINA,[MyCestino.Get_selI025.FieldByName('TABELLA').AsString,MyCestino.Get_selI025.FieldByName('CHIAVE').AsString]);

        MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultCestinoRinomina,'');
        Exit;
      end;
      EseguiRipristina(NuovoValore);
    end;
  end;
end;

procedure TWB007FManipolazioneDati.ResultCestinoRinomina(Sender: TObject; R: TmeIWModalResult; KI: String);
var
 WC020FInputDataOreFM: TWC020FInputDataOreFM;
begin
  if R = mrYes then
  begin
    WC020FInputDataOreFM:=TWC020FInputDataOreFM.Create(Self);
    WC020FInputDataOreFM.ImpostaCampiText('Nuovo valore:',WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.MyCestino.Get_selI025.FieldByName('CHIAVE').AsString);
    WC020FInputDataOreFM.Visualizza('Rinomina valore');
    WC020FInputDataOreFM.ResultEvent:=ResultCestinoNuovoValore;
  end;
end;

procedure TWB007FManipolazioneDati.ResultCestinoNuovoValore(Sender: TObject;Result: Boolean; Valore: String);
begin
  if Result then
  begin
    EseguiRipristina(Valore);
  end;
end;


procedure TWB007FManipolazioneDati.EseguiRipristina(NuovoValore: String);
var
  Msg: String;
begin
  with WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW do
  begin
    Msg:=RipristinaCestino(NuovoValore);

    if Trim(Msg) <> '' then
      MsgBox.WebMessageDlg(Msg,mtError,[mbOk],nil,'')
    else
      MsgBox.WebMessageDlg(A000MSG_B007_DLG_RIPRISTINA_OK,mtInformation,[mbOk],nil,'');

    MyCestino.Get_selI025.Refresh;
    grdCestino.medpAggiornaCDS(True);
  end;
end;

procedure TWB007FManipolazioneDati.grdRenderCell(ACell: TIWGridCell; const ARow,
  AColumn: Integer);
begin
  inherited;
  C190RenderCell(ACell,ARow,AColumn,True,False,True);
end;

procedure TWB007FManipolazioneDati.OnAzioneChange;
begin
  //rendo invisibile la region
  if CurrentRegion <> nil then
    CurrentRegion.Visible:=False;

  grdC700.AbilitaToolbar(True);
  //reimposto region corrente
  CurrentRegion:=lstAzioni.getRegion(cmbAzione.Text);
  if CurrentRegion = nil then Exit;
  
  CurrentRegion.Visible:=True;
  if CurrentRegion = WB007StoricizzazioneRG then
    AbilitazioniTabStoricizzazione
  else if CurrentRegion = WB007CancellazioneRG then
    AbilitazioniTabCancDati
  else if CurrentRegion = WB007CancellazioneGiustRG then
    AbilitazioniTabGiustificativi
  else if CurrentRegion = WB007RicodificaGiustRG then
    AbilitazioniTabRicodifica
  else if CurrentRegion = WB007RiallineamentoGiustRG then
    AbilitazioniTabRiallineamentoGiust
  else if CurrentRegion = WB007UnificazioneMatrRG then
    AbilitazioniTabUnificazioneMatr
  else if CurrentRegion = WB007EsecuzioneScriptRG then
    AbilitazioniTabEsecuzioneScript
  else if CurrentRegion = WB007CestinoRG then
    AbilitazioniTabCestino
  else if CurrentRegion = WB007AllineaTimbRG then
    AbilitazioniTabAllineaTimb;

  btnEsegui.Visible:=(CurrentRegion <> WB007CestinoRG);
  btnAnomalie.Visible:=(CurrentRegion <> WB007CestinoRG) and
                       (CurrentRegion <> WB007EsecuzioneScriptRG);
  btnLog.Visible:=btnAnomalie.Visible;
end;

procedure TWB007FManipolazioneDati.grdValoriDataSet2Componenti(Row: Integer);
var
  ElencoValori: TElencoValoriAggDati;
  cmbValoreEsistente,cmbNuovoValore: TMedpIWMultiColumnComboBox;
  S: String;
begin
  inherited;
  ElencoValori:=WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.ValoriAggDati(cmbDatoAgg.SelectedValue);

  cmbValoreEsistente:=(grdValori.medpCompCella(Row,grdValori.medpIndexColonna('VALOREOLD'),0) as TMedpIWMultiColumnComboBox );
  cmbNuovoValore:=(grdValori.medpCompCella(Row,grdValori.medpIndexColonna('VALORENEW'),0) as TMedpIWMultiColumnComboBox );

  cmbValoreEsistente.Items.Clear;
  cmbValoreEsistente.CustomElement:=True;

  cmbNuovoValore.Items.Clear;
  cmbNuovoValore.CustomElement:=True;

  for S in ElencoValori.lstValoreEsistente do
    cmbValoreEsistente.AddRow(S);

  for S in ElencoValori.lstNuovoValore do
    cmbNuovoValore.AddRow(S);

  FreeAndNil(ElencoValori);
end;

procedure TWB007FManipolazioneDati.grdValorimedpStatoChange;
begin
  inherited;
  //Disabilito per evitare cmabiamenti mentre sto modificando
  cmbDatoAgg.Enabled:=grdValori.medpStato = msBrowse;
end;

procedure TWB007FManipolazioneDati.ControlloDipendenti;
begin
  if grdC700.WC700FM.C700SettaPeriodoSelAnagrafe(DallaData,AllaData) then
    grdC700.selAnagrafe.Close;
  grdC700.selAnagrafe.Open;
  grdC700.selAnagrafe.First;

  if grdC700.selAnagrafe.RecordCount = 0 then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_NO_DIP,mtError,[mbOk],nil,'');
    Abort;
  end;
end;

procedure TWB007FManipolazioneDati.btnAfterUploadClick(Sender: TObject);
begin
  inherited;
  RecuperaFile;
end;

procedure TWB007FManipolazioneDati.btnAggiornaMatrClick(Sender: TObject);
begin
  inherited;
  if grdC700.SelAnagrafe.RecordCount = 0 then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_NO_DIP,mtError,[mbOk],nil,'');
    Exit;
  end;
  if grdC700.SelAnagrafe.RecordCount > 1 then
  begin
    MsgBox.WebMessageDlg(A000MSG_B007_ERR_SOLO_UN_DIP,mtError,[mbOk],nil,'');
    Exit;
  end;
  if Trim(edtDatiAnag.Text) = '' then
  begin
    MsgBox.WebMessageDlg(A000MSG_B007_ERR_DATI_ANAG_UNIF,mtError,[mbOk],nil,'');
    Exit;
  end;
  WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.CaricaElencoUnificazioneMatr(edtDatiAnag.Text);
  CaricaGridMatricole;
end;

procedure TWB007FManipolazioneDati.btnAggiornaSchedeAnagClick(Sender: TObject);
begin
  inherited;
  bElaborazioneAggiornaSchedeAnag:=True;
  ControlloDipendenti;
  StartElaborazioneCiclo(btnAggiornaSchedeAnag.HTMLName);
end;

procedure TWB007FManipolazioneDati.btnAnomalieClick(Sender: TObject);
var
  Params: String;
begin
  inherited;
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' + Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + medpCodiceForm + ParamDelimiter +
          'ID=' + IntToStr(RegistraMsg.ID) + ParamDelimiter +
          'TIPO=A,B,I';
  accediForm(201,Params,True);
end;

procedure TWB007FManipolazioneDati.btnDatiAnagClick(Sender: TObject);
var
  WC013: TWC013FCheckListFM;
  LstSel: TStringList;
  ElencoValoriChecklist: TElencoValoriChecklist;
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Owner);

  LstSel:=TStringList.Create;
  try
    ElencoValoriChecklist:=WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.ListaDatiAnagraficiUnificazione;

    LstSel.CommaText:=edtDatiAnag.Text;
    WC013.CaricaLista(ElencoValoriChecklist.lstDescrizione, ElencoValoriChecklist.lstCodice);

    WC013.ImpostaValoriSelezionati(LstSel);
    WC013.ResultEvent:=DatiAnagResult;
    WC013.Visualizza(0,0,'<WC013> Dati anagrafici');
  finally
    FreeAndNil(ElencoValoriChecklist);
    FreeAndNil(LstSel);
  end;
end;

procedure TWB007FManipolazioneDati.CausaliAssenzaResult(Sender: TObject; Result: Boolean);
var
  lstValori: TStringList;
begin
  if Result then
  begin
    lstValori:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    edtCausali.Text:=lstValori.CommaText;
    FreeAndNil(lstValori);
  end;
end;

procedure TWB007FManipolazioneDati.DatiAnagResult(Sender: TObject; Result: Boolean);
var
  lstValori: TStringList;
begin
  if Result then
  begin
    lstValori:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    edtDatiAnag.Text:=lstValori.CommaText;
    FreeAndNil(lstValori);
  end;
end;

procedure TWB007FManipolazioneDati.btnElencoCausaliClick(Sender: TObject);
var
  WC013: TWC013FCheckListFM;
  LstSel: TStringList;
  ElencoValoriChecklist: TElencoValoriChecklist;
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Owner);

  LstSel:=TStringList.Create;
  try
    ElencoValoriChecklist:=WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.ListaTesteCatena;

    LstSel.CommaText:=edtCausali.Text;
    WC013.CaricaLista(ElencoValoriChecklist.lstDescrizione, ElencoValoriChecklist.lstCodice);

    WC013.ImpostaValoriSelezionati(LstSel);
    WC013.ResultEvent:=CausaliAssenzaResult;
    WC013.Visualizza(0,0,'<WC013> Causali assenza');
  finally
    FreeAndNil(ElencoValoriChecklist);
    FreeAndNil(LstSel);
  end;
end;

procedure TWB007FManipolazioneDati.btnEseguiClick(Sender: TObject);
var
  sMsgConferma: String;
  lstOutput: TStringList;
begin
  if CurrentRegion = nil then Exit;

  bElaborazioneAggiornaSchedeAnag:=False;
  if edtDallaData.Enabled then
  begin
    if not TryStrToDate(edtDallaData.Text,DallaData) then
    begin
      MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,[A000MSG_B007_MSG_DALLA_DATA]),mtError,[mbOk],nil,'');
      Exit;
    end;
  end
  else
    DallaData:=Parametri.DataLavoro;  //non messo a null perchè passato a C700SettaPeriodoSelAnagrafe

  if edtAllaData.Enabled then
  begin
    if not TryStrToDate(edtAllaData.Text,AllaData) then
    begin
      MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,[A000MSG_B007_MSG_ALLA_DATA]),mtError,[mbOk],nil,'');
      Exit;
    end;
  end
  else
    AllaData:=Parametri.DataLavoro;  //non messo a null perchè passato a C700SettaPeriodoSelAnagrafe

  if DallaData > AllaData then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_PERIODO_ERRATO,mtError,[mbOk],nil,'');
    Exit;
  end;

  sMsgConferma:='';
  if CurrentRegion = WB007StoricizzazioneRG then
  begin
    ControlloDipendenti;
    sMsgConferma:=ControlliStoricizzazioneDati;
  end
  else if CurrentRegion = WB007CancellazioneRG then
  begin
    if rgpCancDati.ItemIndex = 0 then
    begin
      ControlloDipendenti;
      sMsgConferma:=ControlliCancellazioneDatiDipendente;
      if sMsgConferma  <> '' then
      begin
        MsgBox.WebMessageDlg(sMsgConferma,mtConfirmation,[mbYes,mbNo],ResultConfermaCancellazione,'');
        Exit;
      end;
    end
    else if rgpCancDati.ItemIndex = 1 then
    begin
      sMsgConferma:=ControlliCancellazioneSchedaAnag;
    end
    else if rgpCancDati.ItemIndex = 2 then
    begin
      sMsgConferma:=ControlliCancellazionePeriodica;
    end
    else if rgpCancDati.ItemIndex = 3 then
    begin
      ControlloDipendenti;
      sMsgConferma:=ControlliCancellazionePeriodica;
    end
  end
  else if CurrentRegion = WB007CancellazioneGiustRG then
  begin
    if rgpCancGiust.ItemIndex = 1 then
      ControlloDipendenti;
    sMsgConferma:=ControlliCancellazioneGiustificativi;
  end
  else if CurrentRegion = WB007RicodificaGiustRG then
  begin
    if rgpRicodificaGiust.ItemIndex = 1 then
      ControlloDipendenti;
    sMsgConferma:=ControlliRicodificaGiustificativi;
  end
  else if CurrentRegion = WB007RiallineamentoGiustRG then
  begin
    ControlloDipendenti;
    sMsgConferma:=ControlliRiallineamentoGiustificativi;
  end
  else if CurrentRegion = WB007UnificazioneMatrRG then
  begin
    sMsgConferma:=ControlliUnificazioneMatricole;
  end
  else if CurrentRegion = WB007EsecuzioneScriptRG then
  begin
    ControlliEsecuzioneScript;
    //Non passa per elaborazione quindi devo fare iniziaMessaggio
    RegistraMsg.IniziaMessaggio(medpCodiceForm);

    lstOutput:=WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.EseguiScript(PathFileUploaded);
    MemLog.Lines.Assign(lstOutput);
    FreeAndNil(lstOutput);
    //Devo uscire e non deve partire elaborazione
    Exit;
  end
  else if CurrentRegion = WB007AllineaTimbRG then
  begin
    ControlloDipendenti;
    sMsgConferma:=ControlliAllineamentoTimbrature;
  end;

  if sMsgConferma <> '' then
  begin
    MsgBox.WebMessageDlg(sMsgConferma,mtConfirmation,[mbYes,mbNo],ResultConfermaStart,'');
    Exit;
  end;
  //Start Elaborazione
  StartElaborazioneCiclo(btnEsegui.HTMLName);
end;

procedure TWB007FManipolazioneDati.btnLogClick(Sender: TObject);
var
  params: String;
begin
  inherited;
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' + Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + medpCodiceForm + ParamDelimiter +
          'ID=' + IntToStr(RegistraMsg.ID) + ParamDelimiter +
          'TIPO=I';
  accediForm(201,Params,True);
end;

procedure TWB007FManipolazioneDati.RecuperaFile;
var nomeFile: String;
begin
  { DONE : TEST IW 14 OK }
  if not fileUpload.IsPresenteFileUploadato then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_FILE_INESISTENTE,mtError,[mbOk],nil,'');
    exit;
  end;

  nomeFile:=fileUpload.NomeFile;
  try
    // path e nome per il salvataggio su file system
    PathFileUploaded:=GGetWebApplicationThreadVar.UserCacheDir + nomeFile;
    // se esiste già un file con lo stesso nome lo cancella
    if FileExists(PathFileUploaded) then
      DeleteFile(PathFileUploaded);
    fileUpload.SalvaSuFile(PathFileUploaded);
    fileUpload.Ripristina;
    btnVisualizzaFile.Enabled:=True;
    lblFileSceltoDescr.Caption:=ExtractFileName(PathFileUploaded);
  except
    begin
      fileUpload.Ripristina;
      btnVisualizzaFile.Enabled:=False;
      PathFileUploaded:='';
      lblFileSceltoDescr.Caption:='';
      MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_ERRORE,['upload fallito']),mtError,[mbOk],nil,'');
    end;
  end;

end;

procedure TWB007FManipolazioneDati.btnVisualizzaFileClick(Sender: TObject);
begin
  if FileExists(PathFileUploaded) then
    GGetWebApplicationThreadVar.SendFile(PathFileUploaded,true,'application/x-download',ExtractFileName(PathFileUploaded))
  else
    MsgBox.WebMessageDlg(A000MSG_ERR_FILE_INESISTENTE,mtInformation,[mbOk],nil,'');
end;

//Esegue i controlli per la storicizzazione
//se richiesta conferma restituisce Stringa per presentare msgbox di conferma
function TWB007FManipolazioneDati.ControlliStoricizzazioneDati: String;
var
  sMsg: String;
begin
  with WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW do
  begin
    sMsg:=ControlliStoricizzazione(cmbDatoAgg.SelectedValue,chkStoriciSuccessivi.Checked);
    if sMsg <> '' then
    begin
      MsgBox.WebMessageDlg(sMsg,mtError,[mbOk],nil,'');
      Abort;
    end;
    // Conferma
    Result:=MessaggioConfermaStoricizzazione(rgpPeriodi.ItemIndex,DallaData, AllaData)
  end;
end;

//Esegue i controlli per la cancellazione
//se richiesta conferma restituisce Stringa per presentare msgbox di conferma
function TWB007FManipolazioneDati.ControlliCancellazioneDatiDipendente: String;
begin
  with WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW do
  begin
    // Conferma
    Result:=MessaggioConfermaCancellazioneDatiDipendente
  end;
end;

//Esegue i controlli per la cancellazione schede anagrafiche
//se richiesta conferma restituisce Stringa per presentare msgbox di conferma
function TWB007FManipolazioneDati.ControlliCancellazioneSchedaAnag:String;
var
  r: Integer;
  chk: TmeIWCheckBox;
begin
  lstElementi.Clear;
  for r:=1 to grdSchedeAnag.RowCount - 1 do
  begin
    chk:=(grdSchedeAnag.Cell[r,0].Control as TmeIWCheckbox);
    if chk.checked then
    begin
      lstElementi.add(IntToStr(chk.tag));
    end;
  end;

  if lstElementi.Count = 0 then
  begin
    MsgBox.WebMessageDlg(A000MSG_B007_ERR_NO_MATRICOLA,mtError,[mbOk],nil,'');
    Abort;
  end;
  Result:=WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.MessaggioConfermaCancellazioneSchedeAnag(lstElementi.Count);
end;

//Esegue i controlli per la cancellazione periodica
//se richiesta conferma restituisce Stringa per presentare msgbox di conferma
function TWB007FManipolazioneDati.ControlliCancellazionePeriodica:String;
var
  r: Integer;
  chk: TmeIWCheckBox;
  indice: Integer;
  Msg: String;
begin
  lstElementi.Clear;
  Msg:='';
  for r:=0 to cgpTabelle.Items.Count  - 1 do
  begin
    if cgpTabelle.IsChecked[r] then
    begin
      indice:=LstElencoTab.IndexOf(cgpTabelle.Items[r]);
      lstElementi.add(IntToStr(indice));

      Msg:=Msg + cgpTabelle.Items[r] + #13#10;
    end;
  end;
  if rgpCancDati.ItemIndex = 3 then
  begin
    Msg:=Msg + Format(A000MSG_B007_MSG_NUM_DIP,[IntToStr(grdC700.selAnagrafe.RecordCount)]);
  end;
  if lstElementi.Count = 0 then
  begin
    MsgBox.WebMessageDlg(A000MSG_B007_ERR_NO_TABELLA,mtError,[mbOk],nil,'');
    Abort;
  end;
  Result:=Format(A000MSG_B007_DLG_FMT_CANC_DATI,[Msg ,FormatDateTime('dd/mm/yyyy',DallaData),FormatDateTime('dd/mm/yyyy',AllaData)]);
end;

//Esegue i controlli per la cancellazione giustficativi
//se richiesta conferma restituisce Stringa per presentare msgbox di conferma
function TWB007FManipolazioneDati.ControlliCancellazioneGiustificativi:String;
var
  r: Integer;
  Msg, sCaus: String;
begin
  lstElementi.Clear;
  Result:='';
  Msg:='';
  sCaus:='';
  for r:=0 to cgpCausGiust.Items.Count - 1 do
  begin
    if cgpCausGiust.IsChecked[r] then
    begin
      lstElementi.add(Trim(Copy(cgpCausGiust.Items[r],1,5)));
      sCaus:=sCaus + cgpCausGiust.Items[r] + #13#10;
    end;
  end;

  if lstElementi.Count = 0 then
  begin
    MsgBox.WebMessageDlg(A000MSG_B007_ERR_NO_CAUSALE,mtError,[mbOk],nil,'');
    Abort;
  end;

  if rgpCancGiust.ItemIndex = 1 then
  begin
    Msg:=Format(A000MSG_B007_MSG_NUM_DIP,[IntToStr(grdC700.selAnagrafe.RecordCount)]);
  end;

  Result:=Format(A000MSG_B007_DLG_FMT_CANC_GIUST,[sCaus,FormatDateTime('dd/mm/yyyy',DallaData),FormatDateTime('dd/mm/yyyy',AllaData),Msg]);
end;

//Esegue i controlli per il riallineamento giustificativi
//se richiesta conferma restituisce Stringa per presentare msgbox di conferma
function TWB007FManipolazioneDati.ControlliRiallineamentoGiustificativi:String;
begin
  lstElementi.Clear;
  if (edtCausali.Text = '') then
  begin
    MsgBox.WebMessageDlg(A000MSG_B007_ERR_NO_CAUSALE_ASS,mtError,[mbOk],nil,'');
    Abort;
  end;
  lstElementi.CommaText:=edtCausali.Text;
  Result:=WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.MessaggioConfermaRiallineamentoGiust(DallaData,grdC700.selAnagrafe.RecordCount);
end;

procedure TWB007FManipolazioneDati.ControlliEsecuzioneScript;
begin
  if PathFileUploaded = '' then
  begin
    MsgBox.WebMessageDlg(A000MSG_B007_ERR_INDICARE_FILE_SCRIPT,mtError,[mbOk],nil,'');
    Abort;
  end;

  if not FileExists(PathFileUploaded) then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_FILE_INESISTENTE,mtError,[mbOk],nil,'');
    Abort;
  end;
end;

function TWB007FManipolazioneDati.ControlliUnificazioneMatricole: String;
var
  chk: TmeIWCheckbox;
  r: Integer;
  sProg, msg: String;
begin
  lstElementi.Clear;
  for r:=1 to grdMatricole.RowCount - 1 do
  begin
    chk:=(grdMatricole.Cell[r,0].Control as TmeIWCheckbox);
    if chk.checked then
    begin
      lstElementi.add(IntToStr(chk.tag));
    end;
  end;

  if lstElementi.Count <= 0 then
  begin
    MsgBox.WebMessageDlg(A000MSG_B007_ERR_NO_MATR_UNIF,mtError,[mbOk],nil,'');
    Abort;
  end;

  Result:=Format(A000MSG_B007_DLG_FMT_UNIFICAZIONE,[IntToStr(lstElementi.Count),grdC700.SelAnagrafe.FieldByName('MATRICOLA').AsString]);

  if (not grdC700.SelAnagrafe.FieldByName('T430FINE').IsNull) and (grdC700.SelAnagrafe.FieldByName('T430FINE').AsDateTime < Parametri.DataLavoro) then
  begin  //se matr.new non è in servzio controllo le old
    for sProg in lstElementi do
    begin
      msg:=WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.VerificaDateUnificazione(StrToInt(sProg));
      if msg <> '' then
      begin
        Result:=Result + #13#10 + msg;
      end;
    end;
  end;
end;

//Esegue i controlli per la ricodifica giustficativi
//se richiesta conferma restituisce Stringa per presentare msgbox di conferma
function TWB007FManipolazioneDati.ControlliRicodificaGiustificativi:String;
var
  s, sDip: String;
begin
  lstElementi.Clear;
  if (Trim(edtOldCausale.Text)='') or (Trim(CmbCausali.Text)='') then
  begin
    MsgBox.WebMessageDlg(A000MSG_B007_ERR_DATI_RICODIFICA,mtError,[mbOk],nil,'');
    Abort;
  end;

  s:='';
  if rgpTipoCaus.ItemIndex = 1 then
    s:=A000MSG_B007_MSG_TUTTE_CAUS;

  if rgpRicodificaGiust.ItemIndex = 0 then
  begin
    //creo un elemento fittizio su lstElementi. Serve perchè l'elaborazione cicla su selanagrafe
    //o su lstElementi. se non ci sono elementi l'elaborazione non parte.
    lstElementi.Add('');
    sDip:=Format(A000MSG_B007_MSG_FMT_TUTTI_DIP_AZ,[Parametri.Azienda])
  end
  else
    sDip:=Format(A000MSG_B007_MSG_NUM_DIP,[IntToStr(grdC700.selAnagrafe.RecordCount)]);

  Result:=Format(A000MSG_B007_DLG_FMT_RICODIFICA,[s,
                                                  edtOldCausale.Text,
                                                  CmbCausali.Text,
                                                  FormatDateTime('dd/mm/yyyy',DallaData),
                                                  FormatDateTime('dd/mm/yyyy',AllaData),
                                                  sDip])
end;

function TWB007FManipolazioneDati.ControlliAllineamentoTimbrature: String;
var
  DS: TDataSet;
  OldProgressivo: Integer;
begin
  // controllo se la tabella è aggiornata
  if (DatiAgg.Dal <> DallaData) or
     (DatiAgg.Al <> AllaData) or
     (DatiAgg.SelezioneAnagrafe <> grdC700.selAnagrafe.SubstitutedSQL) then
  begin
    MsgBox.MessageBox('E'' necessario aggiornare la tabella prima di eseguire l''allineamento!',ESCLAMA);
    Exit;
  end;

  // determina progressivi da considerare
  lstElementi.Clear;
  OldProgressivo:=-1;
  DS:=WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.A023FAllTimbMW.cdsT100;
  DS.First;
  while not DS.Eof do
  begin
    if DS.FieldByName('PROGRESSIVO').AsInteger <> OldProgressivo then
      lstElementi.Add(DS.FieldByName('PROGRESSIVO').AsString);
    OldProgressivo:=DS.FieldByName('PROGRESSIVO').AsInteger;
    DS.Next;
  end;
  DS.First;

  Result:=WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.MessaggioConfermaAllineamentoTimb(DallaData,AllaData,grdC700.selAnagrafe.RecordCount);
end;

//
procedure TWB007FManipolazioneDati.CaricaCmbDatoAgg;
begin
  cmbDatoAgg.Items.Clear;

  with WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW do
  begin
    selI010.Close;
    selI010.Filter:='TABLE_NAME = ''V430_STORICO''';
    selI010.Filtered:=True;
    selI010.Open;
    selI010.First;
    while not selI010.Eof do
    begin
      cmbDatoAgg.Items.Add(SelI010.FieldByName('NOME_LOGICO').AsString  + '=' + SelI010.FieldByName('NOME_CAMPO').AsString);
      selI010.Next;
    end;
  end;
end;

procedure TWB007FManipolazioneDati.ResultConfermaStart(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
    StartElaborazioneCiclo(btnEsegui.HTMLName);
end;

procedure TWB007FManipolazioneDati.ResultConfermaCancellazione(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
var
  WC020FInputDataOreFM: TWC020FInputDataOreFM;
begin
  if Res = mrYes then
  begin
    WC020FInputDataOreFM:=TWC020FInputDataOreFM.Create(Self);
    WC020FInputDataOreFM.ImpostaCampiText('Indicare il numero di dipendenti da cancellare:','0');
    WC020FInputDataOreFM.ResultEvent:=ResultInputCancellazione;
    WC020FInputDataOreFM.Visualizza('Conferma cancellazione');
  end;
end;

procedure TWB007FManipolazioneDati.ResultInputCancellazione(Sender: TObject; Result: Boolean; Valore: String);
begin
  if Result then
  begin
    if (Valore = '0') or (Valore <> IntToStr(grdC700.selAnagrafe.RecordCount)) then
    begin
      MsgBox.WebMessageDlg(A000MSG_MSG_OPERAZIONE_ANNULLATA,mtInformation,[mbOk],nil,'');
      Exit;
    end;
    StartElaborazioneCiclo(btnEsegui.HTMLName);
  end;
end;

procedure TWB007FManipolazioneDati.AbilitazioniTabCancDati;
begin
  grdC700.AbilitaToolbar(True);
  edtDallaData.Enabled:=(rgpCancDati.ItemIndex > 1);
  edtAllaData.Enabled:=(rgpCancDati.ItemIndex > 1);
  grdC700.AbilitaToolbar(rgpCancDati.ItemIndex <> 2);
  btnAggiornaSchedeAnag.Visible:=rgpCancDati.ItemIndex = 1;
  chkLogSchedeAnag.Visible:=rgpCancDati.ItemIndex = 1;
  grdSchedeAnag.Visible:=rgpCancDati.ItemIndex = 1;
  cgpTabelle.Visible:=rgpCancDati.ItemIndex > 1;
  C190VisualizzaElemento(JQuery,'grpElencoMatricole',(rgpCancDati.ItemIndex = 1));
  C190VisualizzaElemento(JQuery,'grpElencoTabelle',(rgpCancDati.ItemIndex > 1));
end;

procedure TWB007FManipolazioneDati.rgpCancDatiClick(Sender: TObject);
var
  lstTabelle: TStringList;
  i: Integer;
begin
  AbilitazioniTabCancDati;
  if rgpCancDati.ItemIndex = lastIndexRgpCancDati then
    exit;
  lastIndexRgpCancDati:=rgpCancDati.ItemIndex;

  if (rgpCancDati.ItemIndex = 2) or (rgpCancDati.ItemIndex = 3) then
  begin
    for i:=0 to cgpTabelle.Items.Count  - 1 do
      cgpTabelle.IsChecked[i]:=False;

    cgpTabelle.Items.Clear;

    if rgpCancDati.ItemIndex = 2 then
    begin
      lstTabelle:=WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.ElencoTabelleCancellaTotale;
      cgpTabelle.Items.Assign(lstTabelle);
      FreeAndNil(lstTabelle);
    end
    else
    begin
      lstTabelle:=WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.ElencoTabelleCancellaDipendente;
      cgpTabelle.Items.Assign(lstTabelle);
      FreeAndNil(lstTabelle);
    end;
  end;
end;

procedure TWB007FManipolazioneDati.AbilitazioniTabGiustificativi;
begin
  grdC700.AbilitaToolbar((rgpCancGiust.ItemIndex = 1));
  edtDallaData.Enabled:=True;
  edtAllaData.Enabled:=True;
end;

procedure TWB007FManipolazioneDati.rgpCancGiustClick(Sender: TObject);
begin
  AbilitazioniTabGiustificativi;
end;

procedure TWB007FManipolazioneDati.AbilitazioniTabStoricizzazione;
begin
  inherited;
  edtDallaData.Enabled:=True;
  edtAllaData.Enabled:=(rgpPeriodi.ItemIndex = 0);
  if rgpPeriodi.ItemIndex = 1 then
  begin
    edtAllaData.Text:=edtDallaData.Text;
  end;
end;

procedure TWB007FManipolazioneDati.AbilitazioniTabUnificazioneMatr;
begin
  inherited;
  edtDallaData.Enabled:=False;
  edtAllaData.Enabled:=False;
end;

procedure TWB007FManipolazioneDati.AbilitazioniTabEsecuzioneScript;
begin
  inherited;
  grdC700.AbilitaToolbar(False);
  edtDallaData.Enabled:=False;
  edtAllaData.Enabled:=False;
end;

procedure TWB007FManipolazioneDati.AbilitazioniTabCestino;
begin
  inherited;
  grdC700.AbilitaToolbar(False);
  edtDallaData.Enabled:=False;
  edtAllaData.Enabled:=False;
end;

procedure TWB007FManipolazioneDati.AbilitazioniTabAllineaTimb;
begin
  // creazione middleware per allineamento timbrature solo in caso di necessità
  if Assigned(WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.A023FAllTimbMW) then
    FreeAndNil(WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.A023FAllTimbMW);

  WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.A023FAllTimbMW:=TA023FAllTimbMW.Create(nil);
  WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.A023FAllTimbMW.Q100.Session:=SessioneOracle;
  WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW. A023FAllTimbMW.Q100Upd.Session:=SessioneOracle;
  grdTimbUguali.medpRighePagina:=GetRighePaginaTabella;
  grdTimbUguali.medpAttivaGrid(WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.A023FAllTimbMW.cdsT100,False,False,False);
  //grdTimbUguali.DataSource:=WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.A023FAllTimbMW.dsrT100;


  grdC700.AbilitaToolbar(True);
  edtDallaData.Enabled:=True;
  edtAllaData.Enabled:=True;
end;

procedure TWB007FManipolazioneDati.rgpPeriodiAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  AbilitazioniTabStoricizzazione;
end;

procedure TWB007FManipolazioneDati.AbilitazioniTabRicodifica;
begin
  grdC700.AbilitaToolbar((rgpRicodificaGiust.ItemIndex = 1));
  edtDallaData.Enabled:=True;
  edtAllaData.Enabled:=True;
end;

procedure TWB007FManipolazioneDati.AbilitazioniTabRiallineamentoGiust;
begin
  edtAllaData.Enabled:=False;
end;

procedure TWB007FManipolazioneDati.rgpRicodificaGiustClick(Sender: TObject);
begin
  inherited;
  AbilitazioniTabRicodifica;
end;

procedure TWB007FManipolazioneDati.rgpTipoCausAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  CaricaCmbCausali;
end;

procedure TWB007FManipolazioneDati.CaricaCmbCausali;
var
  selCausali: TOracleDataset;
  val: String;
begin
  val:=cmbCausali.Text;
  if rgpTipoCaus.ItemIndex = 0 then
    selCausali:=WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.selQ265
  else
    selCausali:=WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.selQ275;

  selCausali.First;
  cmbCausali.Items.Clear;

  while not selCausali.eof do
  begin
    cmbCausali.AddRow(selCausali.FieldByName('CODICE').AsString + ';' + selCausali.FieldByName('DESCRIZIONE').AsString);
    selCausali.Next;
  end;
  cmbCausali.Text:=val;
  if cmbCausali.ItemIndex = -1 then
  begin
    cmbCausali.Text:='';
    lblDescCausale.Text:='';
  end;
end;

procedure TWB007FManipolazioneDati.CaricaGridSchedeAnag;
var
  colControl: Integer;
  rowControl: Integer;
begin
  // Deallocazione controlli della griglia e pulizia dati
  C190PulisciIWGrid(grdSchedeAnag,True);
  with WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW do
  begin
    grdSchedeAnag.ColumnCount:=7;
    grdSchedeAnag.RowCount:=cdsDipendenti.RecordCount + 1;

    colControl:=0;
    rowControl:=0;
    //checkbox
    grdSchedeAnag.Cell[rowControl,colControl].Text:='';
    grdSchedeAnag.Cell[rowControl,colControl].Css:='width2chr';
    inc(colControl);

    //Progressivo
    grdSchedeAnag.Cell[rowControl,colControl].Text:='Progressivo';
    grdSchedeAnag.Cell[rowControl,colControl].Css:='width10chr';
    inc(colControl);

    //Matricola
    grdSchedeAnag.Cell[rowControl,colControl].Text:='Matricola';
    grdSchedeAnag.Cell[rowControl,colControl].Css:='width10chr';
    inc(colControl);

    //Cognome
    grdSchedeAnag.Cell[rowControl,colControl].Text:='Cognome';
    grdSchedeAnag.Cell[rowControl,colControl].Css:='width20chr';
    inc(colControl);

    //Nome
    grdSchedeAnag.Cell[rowControl,colControl].Text:='Nome';
    grdSchedeAnag.Cell[rowControl,colControl].Css:='width20chr';
    inc(colControl);

    //Inizio
    grdSchedeAnag.Cell[rowControl,colControl].Text:='Inizio';
    grdSchedeAnag.Cell[rowControl,colControl].Css:='width10chr';
    inc(colControl);

    //Fine
    grdSchedeAnag.Cell[rowControl,colControl].Text:='Fine';
    grdSchedeAnag.Cell[rowControl,colControl].Css:='width10chr';
    inc(colControl);

    cdsDipendenti.First;

    while not cdsDipendenti.Eof do
    begin
      inc(rowControl);
      colControl:=0;

      //tempdario checkbox
      grdSchedeAnag.Cell[rowControl,colControl].Control:=TmeIWCheckbox.Create(Self);
      with (grdSchedeAnag.Cell[rowControl,colControl].Control as TmeIWCheckbox) do
      begin
        Caption:='';
        Tag:=cdsDipendenti.FieldByName('PROGRESSIVO').AsInteger;
      end;

      inc(colControl);

      //Progressivo
      grdSchedeAnag.Cell[rowControl,colControl].Text:=cdsDipendenti.FieldByName('PROGRESSIVO').AsString;
      inc(colControl);

      //Matricola
      grdSchedeAnag.Cell[rowControl,colControl].Text:=cdsDipendenti.FieldByName('MATRICOLA').AsString;
      inc(colControl);

      //Cognome
      grdSchedeAnag.Cell[rowControl,colControl].Text:=cdsDipendenti.FieldByName('COGNOME').AsString;
      inc(colControl);

      //NOME
      grdSchedeAnag.Cell[rowControl,colControl].Text:=cdsDipendenti.FieldByName('NOME').AsString;
      inc(colControl);

      //INIZIO
      grdSchedeAnag.Cell[rowControl,colControl].Text:=DateToStr(cdsDipendenti.FieldByName('INIZIO').AsDateTime);
      inc(colControl);

      //FINE
      grdSchedeAnag.Cell[rowControl,colControl].Text:=DateToStr(cdsDipendenti.FieldByName('FINE').AsDateTime);
      inc(colControl);

      cdsDipendenti.Next;
    end;
  end;
end;

procedure TWB007FManipolazioneDati.CaricaGridMatricole;
var
  colControl: Integer;
  rowControl: Integer;
begin
  // Deallocazione controlli della griglia e pulizia dati
  C190PulisciIWGrid(grdMatricole,True);
  with WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW do
  begin
    grdMatricole.ColumnCount:=7;
    grdMatricole.RowCount:=cdsDipendentiUnificazione.RecordCount + 1;

    colControl:=0;
    rowControl:=0;
    //checkbox
    grdMatricole.Cell[rowControl,colControl].Text:='';
    grdMatricole.Cell[rowControl,colControl].Css:='width2chr';
    inc(colControl);

    //Progressivo
    grdMatricole.Cell[rowControl,colControl].Text:='Progressivo';
    grdMatricole.Cell[rowControl,colControl].Css:='width10chr';
    inc(colControl);

    //Matricola
    grdMatricole.Cell[rowControl,colControl].Text:='Matricola';
    grdMatricole.Cell[rowControl,colControl].Css:='width10chr';
    inc(colControl);

    //Cognome
    grdMatricole.Cell[rowControl,colControl].Text:='Cognome';
    grdMatricole.Cell[rowControl,colControl].Css:='width20chr';
    inc(colControl);

    //Nome
    grdMatricole.Cell[rowControl,colControl].Text:='Nome';
    grdMatricole.Cell[rowControl,colControl].Css:='width20chr';
    inc(colControl);

    //Inizio
    grdMatricole.Cell[rowControl,colControl].Text:='Inizio';
    grdMatricole.Cell[rowControl,colControl].Css:='width10chr';
    inc(colControl);

    //Fine
    grdMatricole.Cell[rowControl,colControl].Text:='Fine';
    grdMatricole.Cell[rowControl,colControl].Css:='width10chr';
    inc(colControl);

    cdsDipendentiUnificazione.First;

    while not cdsDipendentiUnificazione.Eof do
    begin
      inc(rowControl);
      colControl:=0;

      //checkbox
      grdMatricole.Cell[rowControl,colControl].Control:=TmeIWCheckbox.Create(Self);
      with (grdMatricole.Cell[rowControl,colControl].Control as TmeIWCheckbox) do
      begin
        Caption:='';
        Tag:=cdsDipendentiUnificazione.FieldByName('T430PROGRESSIVO').AsInteger;
      end;

      inc(colControl);

      //Progressivo
      grdMatricole.Cell[rowControl,colControl].Text:=cdsDipendentiUnificazione.FieldByName('T430PROGRESSIVO').AsString;
      inc(colControl);

      //Matricola
      grdMatricole.Cell[rowControl,colControl].Text:=cdsDipendentiUnificazione.FieldByName('MATRICOLA').AsString;
      inc(colControl);

      //Cognome
      grdMatricole.Cell[rowControl,colControl].Text:=cdsDipendentiUnificazione.FieldByName('COGNOME').AsString;
      inc(colControl);

      //NOME
      grdMatricole.Cell[rowControl,colControl].Text:=cdsDipendentiUnificazione.FieldByName('NOME').AsString;
      inc(colControl);

      //INIZIO
      grdMatricole.Cell[rowControl,colControl].Text:=DateToStr(cdsDipendentiUnificazione.FieldByName('T430INIZIO').AsDateTime);
      inc(colControl);

      //FINE
      grdMatricole.Cell[rowControl,colControl].Text:=DateToStr(cdsDipendentiUnificazione.FieldByName('T430FINE').AsDateTime);
      inc(colControl);

      cdsDipendentiUnificazione.Next;
    end;
  end;
end;

procedure TWB007FManipolazioneDati.InizioElaborazione;
begin
  inherited;
  lstMessaggi.Clear;
  btnLog.Enabled:=False;
  btnAnomalie.Enabled:=False;
  bCicloLstElemeti:=False;
  if CurrentRegion = WB007StoricizzazioneRG then
  begin
    PreparazioneStoricizzazione:=WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.PreparaStoricizzazione(CmbDatoAgg.SelectedValue);
    ParametriStoricizzazione.bStorico:=chkStorico.Checked;
    ParametriStoricizzazione.DataDa:=DallaData;
    ParametriStoricizzazione.DataA:=AllaData;
    ParametriStoricizzazione.iPeriodo:=rgpPeriodi.ItemIndex;
    ParametriStoricizzazione.bStoriciSuccessivi:=chkStoriciSuccessivi.Checked;
    ParametriStoricizzazione.Dato:=CmbDatoAgg.SelectedValue;
    ParametriStoricizzazione.DescDato:=CmbDatoAgg.Text;
    ParametriStoricizzazione.PreparazioneStoricizzazione:=PreparazioneStoricizzazione;
    bRecordAggiornati:=False;
  end
  else if CurrentRegion = WB007CancellazioneRG then
  begin
    if bElaborazioneAggiornaSchedeAnag then
    begin
      WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.ImpostaCdsDipendenti;
    end
    else
    begin
      idxElementoCorrente:=0;
      //Cancellazione schede anagrafiche cicla su elementi selezionati nella grid e non su selAnagrafe.
      //Cancellazione periodica cicla su elementi selezionati nella chekList e non su selAnagrafe.
      bCicloLstElemeti:=(rgpCancDati.ItemIndex >= 1);
    end;
    if (rgpCancDati.ItemIndex >= 1) then
      tempoCancellazione:=WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.InizializzaTempo(DallaData, AllaData);
  end
  else if CurrentRegion = WB007CancellazioneGiustRG then
  begin
    //se cancellazione per dipendente il ciclo di elaborazione è su selAnagrafe e non su lstElementi
    bCicloLstElemeti:=(rgpCancGiust.ItemIndex = 0);
  end
  else if CurrentRegion = WB007RicodificaGiustRG then
  begin
    //se ricodifica per dipendente il ciclo di elaborazione è su selAnagrafe
    //se totale creo un elemento fittizio su lstElementi e ciclo su questo
    bCicloLstElemeti:=(rgpRicodificaGiust.ItemIndex = 0);
  end
  else if CurrentRegion = WB007RiallineamentoGiustRG then
  begin
    WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.InizioElaborazioneRiallineamentoGiust;
  end
  else if CurrentRegion = WB007UnificazioneMatrRG then
  begin
    SalvaFine:=WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.InizioUnificazioneMatricole;
  end
  else if CurrentRegion = WB007AllineaTimbRG then
  begin
    // ciclo su elementi nella tabella delle timbrature da allineare
    bCicloLstElemeti:=True;
  end;
end;

function TWB007FManipolazioneDati.ElementoSuccessivo: Boolean;
begin
  Result:=False;
  if bCicloLstElemeti then
  begin
    inc(idxElementoCorrente);
    if idxElementoCorrente < lstElementi.Count then
     Result:=True;
  end
  else
  begin
    grdC700.selAnagrafe.Next;
    if not grdC700.selAnagrafe.Eof then //richiama calcolo su nuovo dipendente
    begin
      Result:=True;
    end;
  end;
end;

function TWB007FManipolazioneDati.CurrentRecordElaborazione: Integer;
begin
  if bCicloLstElemeti then
  begin
    Result:=idxElementoCorrente + 1;
  end
  else
  begin
    Result:=grdC700.selAnagrafe.RecNO;
  end;
end;

function TWB007FManipolazioneDati.TotalRecordsElaborazione: Integer;
begin
  if bCicloLstElemeti then
  begin
    Result:=lstElementi.Count;
  end
  else
  begin
    Result:=grdC700.selAnagrafe.RecordCount;
  end;
end;

procedure TWB007FManipolazioneDati.WC700AperturaSelezione(Sender: TObject);
var D: TDateTime;
begin
  if TryStrToDate(edtDallaData.Text,D) then
    grdC700.WC700FM.C700DataDal:=D;

  if TryStrToDate(edtAllaData.Text,D) then
    grdC700.WC700FM.C700DataLavoro:=D;
end;

procedure TWB007FManipolazioneDati.ElaboraElemento;
var
  s: String;
begin
  if CurrentRegion = WB007StoricizzazioneRG then
  begin
    if WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.ElaborazioneStoricizzaDipendente(ParametriStoricizzazione,LstMessaggi) then
      bRecordAggiornati:=True;
  end
  else if CurrentRegion = WB007CancellazioneRG then
  begin
    if rgpCancDati.ItemIndex = 0 then  // cancellazione dei dipendenti selezionati
    begin
      WB007FManipolazioneDatiDM.CancellaDatiDipendente;
    end
    else if rgpCancDati.ItemIndex = 1 then  // cancellazione schede anagrafiche
    begin
      if bElaborazioneAggiornaSchedeAnag then
      begin
        WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.CaricaCdsDipendentiSelCols(chkLogSchedeAnag.Checked);
      end
      else
      begin
        WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.ElaborazioneCancellaSchedaAnagDipendente(StrToInt(lstElementi[idxElementoCorrente]));
      end;
    end
    else if rgpCancDati.ItemIndex > 1 then
    begin
      WB007FManipolazioneDatiDM.CancellaDati(StrToInt(lstElementi[idxElementoCorrente]), DallaData, AllaData, tempoCancellazione, (rgpCancDati.ItemIndex = 2));
    end;
  end
  else if CurrentRegion = WB007CancellazioneGiustRG then
  begin
    if rgpCancGiust.ItemIndex = 0 then //ciclo elaborazione per lstElementi
    begin
      WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.CancellaCodiceGiustifProg(lstElementi[idxElementoCorrente], DallaData, AllaData, 0);
    end
    else
    begin //ciclo elaborazione per selAnagrafe
      for s in lstElementi do
      begin
        WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.CancellaCodiceGiustifProg(s, DallaData, AllaData, grdC700.Selanagrafe.FieldByName('PROGRESSIVO').AsInteger);
      end;
    end;
  end
  else if CurrentRegion = WB007RicodificaGiustRG then
  begin
    with WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW do
    begin
      if rgpRicodificaGiust.ItemIndex = 0 then
      begin
        ElaborazioneRicodificaGiust(DallaData,
                                    AllaData,
                                    Trim(edtOldCausale.Text),
                                    cmbCausali.Text,
                                    (rgpTipoCaus.ItemIndex = 1));
      end
      else
      begin
        ElaborazioneRicodificaGiustDipendente(DallaData,
                                              AllaData,
                                              Trim(edtOldCausale.Text),
                                              cmbCausali.Text,
                                              (rgpTipoCaus.ItemIndex = 1));
      end;
    end;
  end
  else if CurrentRegion = WB007RiallineamentoGiustRG then
  begin
    WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.ElaborazioneRiallinementoGiustDipendente(lstElementi,DallaData);
  end
  else if CurrentRegion = WB007UnificazioneMatrRG then
  begin
    WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.UnificazioneMatricolaDip(StrToInt(lstElementi[idxElementoCorrente]));
  end
  else if CurrentRegion = WB007AllineaTimbRG then
  begin
    WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.AllineamentoTimbrature(lstElementi[idxElementoCorrente].ToInteger,DallaData,AllaData);
  end;
end;

procedure TWB007FManipolazioneDati.FineCicloElaborazione;
begin
  if CurrentRegion = WB007StoricizzazioneRG then
  begin
    if bRecordAggiornati then
      WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.InserisciI020(PreparazioneStoricizzazione.NomeTabella,CmbDatoAgg.SelectedValue);
  end
  else if CurrentRegion = WB007CancellazioneRG then
  begin
    if bElaborazioneAggiornaSchedeAnag then
    begin
      WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.CaricaCdsDipendentiSelSQL;
      if chkLogSchedeAnag.Checked then
        btnLog.Enabled:=True;

      CaricaGridSchedeAnag;
    end;
  end
  else if CurrentRegion = WB007RiallineamentoGiustRG then
  begin
    btnLog.Enabled:=True;
  end
  else  if CurrentRegion = WB007UnificazioneMatrRG then
  begin
    WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.FineUnificazioneMatricole(SalvaFine);
  end
  else if CurrentRegion = WB007AllineaTimbRG then
  begin
    // aggiorna timbrature da allineare
    btnRefreshAllTimbClick(nil);
  end;

  btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
end;

function TWB007FManipolazioneDati.ElaborazioneTerminata: String;
begin
  if LstMessaggi.count > 0 then
  begin
    Result:=A000MSG_MSG_ELABORAZIONE_ANOMALIE;
    NomeFileGenerato:='anomalie.txt';
    StreamGenerato:=LstMessaggi.Text;
  end
  else if btnAnomalie.Enabled then
    Result:=A000MSG_MSG_ELABORAZIONE_ANOMALIE
  else
    Result:=inherited;
end;

procedure TWB007FManipolazioneDati.btnRefreshAllTimbClick(Sender: TObject);
var
  DatiAnag: TDatiAnag;
begin
  // Sender = nil -> richiamo automatico
  //                 evita controlli
  if Sender <> nil then
  begin
    // controlli su selezione anagrafe e periodo
    ControlloDipendenti;

    if not TryStrToDate(edtDallaData.Text,DallaData) then
    begin
      MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,[A000MSG_B007_MSG_DALLA_DATA]),mtError,[mbOk],nil,'');
      Exit;
    end;

    if not TryStrToDate(edtAllaData.Text,AllaData) then
    begin
      MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,[A000MSG_B007_MSG_ALLA_DATA]),mtError,[mbOk],nil,'');
      Exit;
    end;

    if DallaData > AllaData then
    begin
      MsgBox.WebMessageDlg(A000MSG_ERR_PERIODO_ERRATO,mtError,[mbOk],nil,'');
      Exit;
    end;
  end;

  // svuota clientdataset di riferimento
  WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.A023FAllTimbMW.cdsT100.DisableControls;
  WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.A023FAllTimbMW.cdsT100.Filter:='';
  WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.A023FAllTimbMW.cdsT100.Filtered:=False;
  DatiAnag:=TA023FAllTimbMW.GetDatiAnag;
  WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.A023FAllTimbMW.LeggiTimbratureUguali(DatiAnag,DATE_NULL,DATE_NULL,True);

  // ciclo di update sui progressivi selezionati
  grdC700.selAnagrafe.First;
  while not grdC700.selAnagrafe.Eof do
  begin
    try
      DatiAnag:=TA023FAllTimbMW.GetDatiAnag(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,grdC700.selAnagrafe.FieldByName('COGNOME').AsString,grdC700.selAnagrafe.FieldByName('NOME').AsString,grdC700.selAnagrafe.FieldByName('MATRICOLA').AsString);
      WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.A023FAllTimbMW.LeggiTimbratureUguali(DatiAnag,DallaData,AllaData,False);
    except
      on E: Exception do
      begin
        if LstMessaggi.Count = 0 then
        begin
          LstMessaggi.Add(Format('Elenco errori riscontrati durante la lettura delle timbrature da allineare dal %s al %s',[DateToStr(DallaData),DateToStr(AllaData)]));
          LstMessaggi.Add('');
        end;

        LstMessaggi.Add(Format('%-35s - matr. %-8s: (%s) %s',
                             [Copy(grdC700.selAnagrafe.FieldByName('COGNOME').AsString + ' ' +
                                   grdC700.selAnagrafe.FieldByName('NOME').AsString,1,35),
                              grdC700.selAnagrafe.FieldByName('MATRICOLA').AsString,
                              E.ClassName,E.Message]));
      end;
    end;

    grdC700.selAnagrafe.Next;
  end;

  // filtra solo timbrature con scambio automatico
  WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.A023FAllTimbMW.cdsT100.Filter:='AUTOMATICO = ''S''';
  WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.A023FAllTimbMW.cdsT100.Filtered:=True;
  WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.A023FAllTimbMW.cdsT100.EnableControls;

  // aggiorna tabella
  grdTimbUguali.medpCaricaCDS;

  // salva i dati di selezione anagrafe e periodo
  DatiAgg.SelezioneAnagrafe:=grdC700.selAnagrafe.SubstitutedSQL;
  DatiAgg.Dal:=DallaData;
  DatiAgg.Al:=AllaData;
end;

procedure TWB007FManipolazioneDati.DistruzioneOggettiElaborazione(Errore: Boolean);
begin
  inherited;
  if CurrentRegion = WB007RiallineamentoGiustRG then
  begin
    //fatto in DistruzioneOggettiElaborazione e non FinecicloElaborazione
    //perchè qui viene eseguita anche in caso di errori (devo ditruggere R600 per evitare memory leak)
    WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.FineElaborazioneRiallineamentoGiust;
  end;
end;

procedure TWB007FManipolazioneDati.IWAppFormDestroy(Sender: TObject);
begin
  lstElementi.clear;
  FreeAndNil(lstElementi);
  // distruzione middleware allineamento timbrature
  try
    if (Assigned(WB007FManipolazioneDatiDM)) and
       (Assigned(WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW)) and
       (Assigned(WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.A023FAllTimbMW)) then
      FreeAndNil(WB007FManipolazioneDatiDM.B007FManipolazioneDatiMW.A023FAllTimbMW);
  except
  end;
  FreeAndNil(WB007FManipolazioneDatiDM);
  FreeAndNil(LstMessaggi);
  FreeAndNil(LstElencoTab);
  FreeAndNil(lstAzioni);
  inherited;
end;

{ TAzione }

constructor TAzione.Create(Az: String; Reg: TMeIWRegion);
begin
  FCaption:=Az;
  FRegion:=Reg;
end;

{ TListAzioni }

function TListAzioni.getRegion(Az: String): TmeIWRegion;
var
  Azione: TAzione;
begin
  Result:=nil;
  for Azione in Self do
  begin
    if Azione.Caption = Az then
    begin
      Result:=Azione.Region;
      Break;
    end;
  end;
end;

destructor TListAzioni.destroy;
var
  i:Integer;
  Azione: TAzione;
begin
 for i:=0 to Self.Count - 1 do
  begin
    Azione:=Self.Items[i] ;
    FreeAndNil(Azione);
  end;
  Self.Clear;
  inherited;
end;
end.
