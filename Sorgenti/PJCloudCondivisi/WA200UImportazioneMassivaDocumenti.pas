unit WA200UImportazioneMassivaDocumenti;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR100UBase, IWBaseComponent, DBClient, Db,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, medpIWStatusBar, IWCompEdit, meIWEdit, IWCompGrids,
  meIWGrid, IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,
  A000UInterfaccia, Math, StrUtils, A000UMessaggi, C180FunzioniGenerali,
  WA200UImportazioneMassivaDocumentiDM, WC700USelezioneAnagrafeFM,
  meIWRadioGroup, IWCompLabel, meIWLabel, IWCompListbox, meIWComboBox,
  IWCompCheckbox, meIWCheckBox, IWCompMemo, meIWMemo, IWDBStdCtrls,
  meIWDBLookupComboBox, meIWImageFile, medpIWImageButton, Vcl.Menus,
  IWTMSCheckList, meTIWCheckListBox, meIWListbox, A000UCostanti, B022UUtilityGestDocumentaleMW,
  IWAdvCheckGroup, meTIWAdvCheckGroup, medpIWMessageDlg, WC019UProgressBarFM;

type
  TWA200FImportazioneMassivaDocumenti = class(TWR100FBase)
    lblmpPath: TmeIWLabel;
    edtImpPath: TmeIWEdit;
    lblImpFiltro: TmeIWLabel;
    edtImpFiltro: TmeIWEdit;
    edtImpSeparatore: TmeIWEdit;
    lblImpSeparatore: TmeIWLabel;
    lblImpFormato: TmeIWLabel;
    lblImpNomeFile: TmeIWLabel;
    edtImpNomeFile: TmeIWEdit;
    lblInfoHelp: TmeIWLabel;
    rgpImpNomeFileOut: TmeIWRadioGroup;
    lblImpNomeFileOut: TmeIWLabel;
    edtImpNomeFileOutPred: TmeIWEdit;
    lblImpNomeFileExt: TmeIWLabel;
    lblImpTipologia: TmeIWLabel;
    dcmbImpTipologia: TmeIWDBLookupComboBox;
    rgpImpAzioneDocTip: TmeIWRadioGroup;
    lblImpAzioneDocTip: TmeIWLabel;
    lblImpUfficio: TmeIWLabel;
    dcmbImpUfficio: TmeIWDBLookupComboBox;
    lblImpRiferitiDal: TmeIWLabel;
    edtImpPeriodoDal: TmeIWEdit;
    lblImpRiferitiAl: TmeIWLabel;
    edtImpPeriodoAl: TmeIWEdit;
    lblImpNote: TmeIWLabel;
    memNote: TmeIWMemo;
    lblImpVisualIrisWeb: TmeIWLabel;
    chkImpVisualIrisWeb: TmeIWCheckBox;
    btnEsegui: TmedpIWImageButton;
    btnAnomalie: TmedpIWImageButton;
    lblImpFilesSelezionati: TmeIWLabel;
    lblImpDimensTotale: TmeIWLabel;
    lblImpDocDaImportare: TmeIWLabel;
    lblImpDocIgnorati: TmeIWLabel;
    pmnImpDocDaImportare: TPopupMenu;
    Selezionatutto1Giorni: TMenuItem;
    Deselezionatutto1Giorni: TMenuItem;
    Invertiselezione1Giorni: TMenuItem;
    lstImpDocIgnorati: TmeIWListbox;
    pmnImpFileIgnorati: TPopupMenu;
    actScaricaInExcel: TMenuItem;
    btnImpAnalizza: TmeIWButton;
    lstImpDocDaImportare: TmeTIWAdvCheckGroup;
    actScaricaInCSV: TMenuItem;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure edtImpPathAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure edtImpFiltroAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure edtImpFormatiAsyncChange(Sender:TObject; EventParams: TStringList);
    procedure rgpImpNomeFileOutAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure edtImpNomeFileOutPredAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnImpAnalizzaClick(Sender: TObject);
    procedure lstImpDocDaImportareAsyncItemClick(Sender: TObject; EventParams: TStringList; Index: Integer);
    procedure Invertiselezione1GiorniClick(Sender: TObject);
    procedure actScaricaInExcelClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure actScaricaInCSVClick(Sender: TObject);
  private
    { Private declarations }
    DATA_VUOTA:String;
    sCssLstImpDocDaImportare:String;
    WA200DM: TWA200FImportazioneMassivaDocumentiDM;
    iFileImp:Integer;
    ConfigImport:TB022DocumentiImportConfig;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ResetRicerca;
    procedure ImpostaLabelSelezioneFile;
    procedure ResultAvvioImport(Sender: TObject; ModalResult: TmeIWModalResult; KeyID: String);
    procedure ControllaSovrascrittura;
    procedure ResultSovrascrittura(Sender: TObject; ModalResult: TmeIWModalResult; KeyID: String);
    procedure LanciaElaborazione;
    procedure InizioElaborazione; override;
    function CurrentRecordElaborazione: Integer; override;
    function TotalRecordsElaborazione: Integer; override;
    procedure ElaboraElemento; override;
    function ElementoSuccessivo: Boolean; override;
    function ElaborazioneTerminata:String; override;
  public
    { Public declarations }
  protected
    procedure ImpostazioniWC700; override;
    procedure WC700AperturaSelezione(Sender: TObject); virtual;
  end;

implementation
{$R *.dfm}

procedure TWA200FImportazioneMassivaDocumenti.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  sCssLstImpDocDaImportare:=lstImpDocDaImportare.Css;
  AttivaGestioneC700;
  WA200DM:=TWA200FImportazioneMassivaDocumentiDM.Create(Self);
  WA200DM.B022MW.selAnagrafe:=grdC700.selAnagrafe;
  GetParametriFunzione;
  DATA_VUOTA:='';
end;

procedure TWA200FImportazioneMassivaDocumenti.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  inherited;
end;

procedure TWA200FImportazioneMassivaDocumenti.ImpostazioniWC700;
begin
  grdC700.WC700FM.C700DatiVisualizzati:='';
  grdC700.WC700FM.C700DatiSelezionati:=C700CampiBase + ', T430INIZIO, T430FINE, T030.CODFISCALE';
  grdC700.WC700FM.C700PersonaleInterno:=False;
  grdC700.WC700FM.C700SelezionePeriodica:=False;
end;

procedure TWA200FImportazioneMassivaDocumenti.WC700AperturaSelezione(Sender: TObject);
begin
  grdC700.WC700FM.C700DataLavoro:=Parametri.DataLavoro;
  grdC700.WC700FM.C700DataDal:=Parametri.DataLavoro;
end;

procedure TWA200FImportazioneMassivaDocumenti.GetParametriFunzione;
var
  ParametroDB:String;
begin
  edtImpPath.Text:=C004DM.GetParametro('PATH','');
  edtImpFiltro.Text:=C004DM.GetParametro('FILTRO','*.*');
  edtImpSeparatore.Text:=C004DM.GetParametro('SEPARATORE','_');
  edtImpNomeFile.Text:=C004DM.GetParametro('NOME_FILE_IN','<MATRICOLA>_<NOME_DEL_FILE>');

  ParametroDB:=C004DM.GetParametro('NOME_FILE_OUT',WA200DM.B022MW.FORMATO_NOME_FILE_OUT_ORIG);
  rgpImpNomeFileOut.ItemIndex:=IfThen(ParametroDB = WA200DM.B022MW.FORMATO_NOME_FILE_OUT_ORIG,0,
                               IfThen(ParametroDB = WA200DM.B022MW.FORMATO_NOME_FILE_OUT_PRED,1,
                                                                                              2));

  edtImpNomeFileOutPred.Text:=C004DM.GetParametro('NOME_FILE_OUT_PRED','');

  rgpImpNomeFileOutAsyncClick(nil,nil);

  try
    WA200DM.cdsAppTipologia.FieldByName('CODICE').AsString:=C004DM.GetParametro('TIPOLOGIA',WA200DM.B022MW.CodTipologiaDefault);
  except
    WA200DM.cdsAppTipologia.FieldByName('CODICE').AsString:=WA200DM.B022MW.CodTipologiaDefault;
  end;

  try
    rgpImpAzioneDocTip.ItemIndex:=StrToInt(C004DM.GetParametro('AZIONE_DOC_TIP','0'));
  except
    rgpImpAzioneDocTip.ItemIndex:=0;
  end;

  try
    WA200DM.cdsAppUfficio.FieldByName('CODICE').AsString:=C004DM.GetParametro('UFFICIO',WA200DM.B022MW.CodUfficioDefault);
  except
    WA200DM.cdsAppUfficio.FieldByName('CODICE').AsString:=WA200DM.B022MW.CodUfficioDefault;
  end;

  edtImpPeriodoDal.Text:=C004DM.GetParametro('PERIODO_DAL','');
  edtImpPeriodoAl.Text:=C004DM.GetParametro('PERIODO_AL','');
  memNote.Lines.Text:=C004DM.GetParametro('NOTE','');
  chkImpVisualIrisWeb.Checked:=(C004DM.GetParametro('VIS_PORTALE_WEB','N') = 'S')
end;

procedure TWA200FImportazioneMassivaDocumenti.PutParametriFunzione;
var
  ParametroDB:String;
begin
  C004DM.Cancella001;
  C004DM.PutParametro('PATH',edtImpPath.Text);
  C004DM.PutParametro('FILTRO',edtImpFiltro.Text);
  C004DM.PutParametro('SEPARATORE',edtImpSeparatore.Text);
  C004DM.PutParametro('NOME_FILE_IN',edtImpNomeFile.Text);
  ParametroDB:=IfThen(rgpImpNomeFileOut.ItemIndex = 0,WA200DM.B022MW.FORMATO_NOME_FILE_OUT_ORIG,
               IfThen(rgpImpNomeFileOut.ItemIndex = 1,WA200DM.B022MW.FORMATO_NOME_FILE_OUT_PRED,
                                                      WA200DM.B022MW.FORMATO_NOME_FILE_OUT_TAG));
  C004DM.PutParametro('NOME_FILE_OUT',ParametroDB);
  C004DM.PutParametro('NOME_FILE_OUT_PRED',edtImpNomeFileOutPred.Text);
  C004DM.PutParametro('TIPOLOGIA',VarToStr(dcmbImpTipologia.KeyValue));
  C004DM.PutParametro('AZIONE_DOC_TIP',IntToStr(rgpImpAzioneDocTip.ItemIndex));
  C004DM.PutParametro('UFFICIO',VarToStr(dcmbImpUfficio.KeyValue));
  C004DM.PutParametro('PERIODO_DAL',edtImpPeriodoDal.Text);
  C004DM.PutParametro('PERIODO_AL',edtImpPeriodoAl.Text);
  C004DM.PutParametro('NOTE',memNote.Lines.Text);
  C004DM.PutParametro('VIS_PORTALE_WEB',IfThen(chkImpVisualIrisWeb.Checked,'S','N'));
  try SessioneOracle.Commit; except end;
end;

procedure TWA200FImportazioneMassivaDocumenti.edtImpPathAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  ResetRicerca;
end;

procedure TWA200FImportazioneMassivaDocumenti.edtImpFiltroAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  ResetRicerca;
end;

procedure TWA200FImportazioneMassivaDocumenti.edtImpFormatiAsyncChange(Sender:TObject; EventParams: TStringList);
begin
  ResetRicerca;
end;

procedure TWA200FImportazioneMassivaDocumenti.rgpImpNomeFileOutAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  edtImpNomeFileOutPred.Enabled:=rgpImpNomeFileOut.ItemIndex = 1;
  edtImpNomeFileOutPred.Color:=IfThen(edtImpNomeFileOutPred.Enabled,clWindow,clBtnFace);
  ResetRicerca;
end;

procedure TWA200FImportazioneMassivaDocumenti.edtImpNomeFileOutPredAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  ResetRicerca;
end;

procedure TWA200FImportazioneMassivaDocumenti.btnImpAnalizzaClick(Sender: TObject);
var
  i:Integer;
  SearchConfig:TB022DocumentiSearchConfig;
begin
  inherited;
  if WA200DM.B022MW.ElencoDocumentiImport <> nil then
    FreeAndNil(WA200DM.B022MW.ElencoDocumentiImport);
  lstImpDocDaImportare.Css:=sCssLstImpDocDaImportare;
  SearchConfig:=TB022DocumentiSearchConfig.Create;
  try
    SearchConfig.Separatore:=edtImpSeparatore.Text;
    SearchConfig.FormatoNomeFile:=Trim(edtImpNomeFile.Text);
    if rgpImpNomeFileOut.ItemIndex = 0 then
      SearchConfig.TipoNomeFileOutput:=tnfoOriginale
    else if rgpImpNomeFileOut.ItemIndex = 1 then
    begin
      if Trim(edtImpNomeFileOutPred.Text) = '' then
        raise Exception.Create(A000MSG_A200_ERR_NO_NOMEFILE_PRED);
      SearchConfig.TipoNomeFileOutput:=tnfoPredefinito;
      SearchConfig.NomeFileOutputPredef:=Trim(edtImpNomeFileOutPred.Text);
    end
    else
      SearchConfig.TipoNomeFileOutput:=tnfoTagNomeFile;
    SearchConfig.PreparaIndiciTag;
    if (SearchConfig.TipoNomeFileOutput = tnfoTagNomeFile) and (not SearchConfig.IndiciTag.ContainsKey(TAG_NOME_DEL_FILE)) then
      raise Exception.Create(Format(A000MSG_A200_ERR_FMT_NOMEFILE_NO_TAG,[TAG_NOME_DEL_FILE]));

    with WA200DM.B022MW do
      ElencoDocumentiImport:=AnalizzaDocumentiImport(Trim(edtImpPath.Text),Trim(edtImpFiltro.Text),selAnagrafe,SearchConfig);

    lstImpDocDaImportare.Items.Clear;
    lstImpDocIgnorati.Clear;
    for i:=0 to WA200DM.B022MW.ElencoDocumentiImport.ListaDocumenti.Count - 1 do
    begin
      lstImpDocDaImportare.Items.Add(WA200DM.B022MW.ElencoDocumentiImport.ListaDocumenti[i].NomeFile);
      lstImpDocDaImportare.IsChecked[i]:=True;
    end;
    for i:=0 to WA200DM.B022MW.ElencoDocumentiImport.ListaFileIgnorati.Count - 1 do
      lstImpDocIgnorati.Items.Add(WA200DM.B022MW.ElencoDocumentiImport.ListaFileIgnorati[i]);

    ImpostaLabelSelezioneFile;
  finally
    FreeAndNil(SearchConfig);
  end;
end;

procedure TWA200FImportazioneMassivaDocumenti.lstImpDocDaImportareAsyncItemClick(Sender: TObject; EventParams: TStringList; Index: Integer);
begin
  inherited;
  ImpostaLabelSelezioneFile;
end;

procedure TWA200FImportazioneMassivaDocumenti.Invertiselezione1GiorniClick(Sender: TObject);
var i:Integer;
begin
  with (pmnImpDocDaImportare.PopupComponent as TmeTIWAdvCheckGroup) do
    for i:=0 to Items.Count - 1 do
      if Sender = SelezionaTutto1Giorni then
        IsChecked[i]:=True
      else if Sender = DeselezionaTutto1Giorni then
        IsChecked[i]:=False
      else if Sender = InvertiSelezione1Giorni then
        IsChecked[i]:=not IsChecked[i];
  ImpostaLabelSelezioneFile;
end;

procedure TWA200FImportazioneMassivaDocumenti.actScaricaInCSVClick(Sender: TObject);
var
  i:Integer;
  TestoCopiato:String;
begin
  TestoCopiato:='';
  for i:=0 to lstImpDocIgnorati.Items.Count - 1 do
  begin
    if i > 0 then
      TestoCopiato:=TestoCopiato + CRLF;
    TestoCopiato:=TestoCopiato + lstImpDocIgnorati.Items[i];
  end;
  InviaFile('FileIgnorati.xls',TestoCopiato);
end;

procedure TWA200FImportazioneMassivaDocumenti.actScaricaInExcelClick(Sender: TObject);
var
  i:Integer;
  CDS: TClientDataset;
begin
  CDS:=TClientDataset.Create(nil);
  try
    CDS.FieldDefs.Add('FileIgnorati',ftString,4000);
    CDS.CreateDataSet;
    for i:=0 to lstImpDocIgnorati.Items.Count - 1 do
    begin
      CDS.Append;
      CDS.FieldByName('FileIgnorati').AsString:=lstImpDocIgnorati.Items[i];
      CDS.Post;
    end;
    InviaFile('FileIgnorati.xlsx',R180DatasetToXlsx(SessioneOracle,False,CDS,nil));
  finally
    FreeAndNil(CDS);
  end;
end;

procedure TWA200FImportazioneMassivaDocumenti.btnEseguiClick(Sender: TObject);
var
  i,nFileImp:Integer;
begin
  nFileImp:=0;
  for i:=0 to lstImpDocDaImportare.Items.Count - 1 do
    if lstImpDocDaImportare.IsChecked[i] then
      Inc(nFileImp);
  if nFileImp = 0 then
    Exit;
  //Controlli bloccanti
  WA200DM.B022MW.Controlli(DATA_VUOTA,edtImpPeriodoDal.Text,edtImpPeriodoAl.Text);
  //Richiesta conferma
  MsgBox.WebMessageDlg(Format(A000MSG_A200_DLG_FMT_AVVIO_IMPORT,[nFileImp]),mtConfirmation,[mbYes,mbNo],ResultAvvioImport,'');
  Exit;
end;

procedure TWA200FImportazioneMassivaDocumenti.ResultAvvioImport(Sender: TObject; ModalResult: TmeIWModalResult; KeyID: String);
begin
  if ModalResult = mrYes then
    ControllaSovrascrittura;
end;

procedure TWA200FImportazioneMassivaDocumenti.ControllaSovrascrittura;
begin
  if rgpImpAzioneDocTip.ItemIndex = 1 then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_A200_DLG_FMT_CONFIRM_SOVRASCR,[dcmbImpTipologia.Text]),mtConfirmation,[mbYes,mbNo],ResultSovrascrittura,'');
    Exit;
  end
  else
    LanciaElaborazione;
end;

procedure TWA200FImportazioneMassivaDocumenti.ResultSovrascrittura(Sender: TObject; ModalResult: TmeIWModalResult; KeyID: String);
begin
  if ModalResult = mrYes then
    LanciaElaborazione;
end;

procedure TWA200FImportazioneMassivaDocumenti.LanciaElaborazione;
begin
  StartElaborazioneCiclo(btnEsegui.HTMLName,True);
end;

procedure TWA200FImportazioneMassivaDocumenti.InizioElaborazione;
begin
  inherited;
  btnAnomalie.Enabled:=False;
  iFileImp:=0;
  ConfigImport:=TB022DocumentiImportConfig.Create;
  ConfigImport.Tipologia:=dcmbImpTipologia.KeyValue;
  ConfigImport.Sovrascrivi:=(rgpImpAzioneDocTip.ItemIndex = 1);
  ConfigImport.UfficioRiferimento:=dcmbImpUfficio.KeyValue;
  ConfigImport.PeriodoDal:=WA200DM.B022MW.DataInizioStr;
  ConfigImport.PeriodoAl:=WA200DM.B022MW.DataFineStr;
  ConfigImport.Note:=memNote.Lines.Text;
  ConfigImport.AccessoPortale:=IfThen(chkImpVisualIrisWeb.Checked,'S','N');
  RegistraMsg.IniziaMessaggio('A200');
end;

function TWA200FImportazioneMassivaDocumenti.CurrentRecordElaborazione: Integer;
begin
  Result:=iFileImp;
end;

function TWA200FImportazioneMassivaDocumenti.TotalRecordsElaborazione: Integer;
begin
  Result:=lstImpDocDaImportare.Items.Count;
end;

procedure TWA200FImportazioneMassivaDocumenti.ElaboraElemento;
var DimMB:Double;
begin
  inherited;
  try
    if lstImpDocDaImportare.IsChecked[iFileImp] then
    begin
      // Verifico che la dimensione del file non ecceda i limiti
      // controllo dimensione file
      DimMB:=WA200DM.B022MW.ElencoDocumentiImport.ListaDocumenti.Items[iFileImp].DimensioneByte / BYTES_MB;
      if DimMB > WA200DM.B022MW.IterMaxDimAllegatoMB then
      begin
        RegistraMsg.InserisciMessaggio('A', Format(A000MSG_A200_ERR_SUPERO_MAX_DIM,[WA200DM.B022MW.ElencoDocumentiImport.ListaDocumenti.Items[iFileImp].NomeFile]),
                                       Parametri.Azienda, WA200DM.B022MW.ElencoDocumentiImport.ListaDocumenti.Items[iFileImp].Progressivo);
      end
      else
        WA200DM.B022MW.ImportaDocumento(WA200DM.B022MW.ElencoDocumentiImport.ListaDocumenti.Items[iFileImp],ConfigImport);
    end;
    iFileImp:=iFileImp + 1;
  except
    on E:Exception do
    begin
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A200_ERR_FMT_IMPORT_EXC,[WA200DM.B022MW.ElencoDocumentiImport.ListaDocumenti.Items[iFileImp].NomeFile,E.Message]),
                                     Parametri.Azienda, WA200DM.B022MW.ElencoDocumentiImport.ListaDocumenti.Items[iFileImp].Progressivo);
      iFileImp:=lstImpDocDaImportare.Items.Count + 1;//Per uscire dall'elaborazione senza usare il raise che riporterebbe il messaggio a video
    end;
  end;
end;

function TWA200FImportazioneMassivaDocumenti.ElementoSuccessivo: Boolean;
begin
  Result:=iFileImp < lstImpDocDaImportare.Items.Count;
end;

function TWA200FImportazioneMassivaDocumenti.ElaborazioneTerminata: String;
begin
  if not RegistraMsg.ContieneTipoA then
    Result:=A000MSG_A200_MSG_IMPORT_OK
  else
    Result:=A000MSG_A200_ERR_IMPORT_ANOM;
  btnAnomalie.Enabled:=RegistraMsg.ContieneTipoI or RegistraMsg.ContieneTipoA;
  FreeAndNil(ConfigImport);
end;

procedure TWA200FImportazioneMassivaDocumenti.btnAnomalieClick(Sender: TObject);
var
  Params: String;
begin
  inherited;
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' + Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + medpCodiceForm + ParamDelimiter +
          //'ID=' + id + ParamDelimiter +
          'TIPO=A,B,I';
  AccediForm(201,Params,True);
end;

procedure TWA200FImportazioneMassivaDocumenti.ResetRicerca;
var
  i:Integer;
begin
  if WA200DM.B022MW.ElencoDocumentiImport <> nil then
    FreeAndNil(WA200DM.B022MW.ElencoDocumentiImport);
  for i:=lstImpDocDaImportare.Items.Count - 1 downto 0 do
    lstImpDocDaImportare.Items.Delete(i);
  lstImpDocDaImportare.Css:='invisibile';
  lstImpDocIgnorati.Clear;
  ImpostaLabelSelezioneFile;
end;

procedure TWA200FImportazioneMassivaDocumenti.ImpostaLabelSelezioneFile;
var
  i,NumFileSelezionati,DimensioneTotale:Integer;
begin
  NumFileSelezionati:=0;
  DimensioneTotale:=0;
  btnEsegui.Enabled:=False;
  for i:=0 to lstImpDocDaImportare.Items.Count - 1 do
    if lstImpDocDaImportare.IsChecked[i] then
    begin
      inc(NumFileSelezionati);
      DimensioneTotale:=DimensioneTotale + WA200DM.B022MW.ElencoDocumentiImport.ListaDocumenti[i].DimensioneByte;
      btnEsegui.Enabled:=not SolaLettura;
    end;
  lblImpFilesSelezionati.Caption:=Format(A000MSG_A200_MSG_DLG_NUM_FILE_SELEZ,[NumFileSelezionati]);
  lblImpDimensTotale.Caption:=Format(A000MSG_A200_MSG_DLG_DIM_FILE_SELEZ,[R180GetFileSizeStr(DimensioneTotale)]);
end;

end.
