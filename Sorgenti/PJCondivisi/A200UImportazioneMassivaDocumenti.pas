unit A200UImportazioneMassivaDocumenti;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.CheckLst, Vcl.ExtCtrls,
  Vcl.Menus, ClipBrd,
  Vcl.Buttons, Vcl.DBCtrls, Vcl.Mask, System.StrUtils, System.Math,
  A000UInterfaccia, A000USessione, A000UMessaggi, A000UCostanti,
  A083UMsgElaborazioni, A200UImportazioneMassivaDocumentiDtM, B022UUtilityGestDocumentaleMW,
  C004UParamForm, C180FunzioniGenerali, C700USelezioneAnagrafe, SelAnagrafe, InputPeriodo;

type
  TA200FImportazioneMassivaDocumenti = class(TForm)
    frmSelAnagrafe: TfrmSelAnagrafe;
    StatusBar: TStatusBar;
    pnlImpImposta: TPanel;
    lblmpPath: TLabel;
    lblImpFiltro: TLabel;
    lblImpFormato: TLabel;
    lblImpTipologia: TLabel;
    lblImpNote: TLabel;
    lblImpUfficio: TLabel;
    lblImpSeparatore: TLabel;
    lblImpNomeFile: TLabel;
    lblInfoHelp: TLabel;
    lblImpNomeFileOut: TLabel;
    edtImpPath: TEdit;
    btnImpPathBrowse: TButton;
    edtImpFiltro: TEdit;
    memNote: TMemo;
    chkImpVisualIrisWeb: TCheckBox;
    btnImpAnalizza: TButton;
    dcmbImpTipologia: TDBLookupComboBox;
    dcmbImpUfficio: TDBLookupComboBox;
    edtImpSeparatore: TEdit;
    edtImpNomeFile: TEdit;
    pnlImpNomeFileOut: TPanel;
    lblImpNomeFileExt: TLabel;
    rgpImpNomeFileOutOrig: TRadioButton;
    rgpImpNomeFileOutPred: TRadioButton;
    rgpImpNomeFileOutTag: TRadioButton;
    edtImpNomeFileOutPred: TEdit;
    rgpImpAzioneDocTip: TRadioGroup;
    pnlImpComandi: TPanel;
    lblImpFilesSelezionati: TLabel;
    lblImpDimensTotale: TLabel;
    btnAnomalie: TBitBtn;
    btnEsegui: TBitBtn;
    prgImp: TProgressBar;
    pnlImpDocDaImportare: TPanel;
    Splitter1: TSplitter;
    grpImpDocDaImportare: TGroupBox;
    lstImpDocDaImportare: TCheckListBox;
    grpImpDocIgnorati: TGroupBox;
    lstImpDocIgnorati: TListBox;
    pmnImpDocDaImportare: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    pmnImpFileIgnorati: TPopupMenu;
    Copianegliappunti1: TMenuItem;
    frmInputPeriodo: TfrmInputPeriodo;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure edtImpPathChange(Sender: TObject);
    procedure btnImpPathBrowseClick(Sender: TObject);
    procedure edtImpFiltroChange(Sender: TObject);
    procedure edtImpFormatiOnChange(Sender:TObject);
    procedure rgpImpNomeFileOutOnClick(Sender: TObject);
    procedure edtImpNomeFileOutPredChange(Sender: TObject);
    procedure btnImpAnalizzaClick(Sender: TObject);
    procedure lstImpDocDaImportareClickCheck(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure Copianegliappunti1Click(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure frmInputPeriodoedtInizioExit(Sender: TObject);
    procedure frmInputPeriodoedtFineExit(Sender: TObject);
  private
    DATA_VUOTA:String;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ResetRicerca;
    procedure ImpostaLabelSelezioneFile;
    { Metodi Property }
    function _GetDataI: TDateTime;
    procedure _PutDataI(const Value: TDateTime);
    function _GetDataF: TDateTime;
    procedure _PutDataF(const Value: TDateTime);
  public
    { Property }
    property DataI:TDateTime read _GetDataI write _PutDataI;
    property DataF:TDateTime read _GetDataF write _PutDataF;
  end;

var
  A200FImportazioneMassivaDocumenti: TA200FImportazioneMassivaDocumenti;

procedure OpenA200ImportazioneMassivaDocumenti;

implementation

{$R *.dfm}

procedure OpenA200ImportazioneMassivaDocumenti;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA200ImportazioneMassivaDocumenti') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TA200FImportazioneMassivaDocumenti, A200FImportazioneMassivaDocumenti);
  Application.CreateForm(TA200FImportazioneMassivaDocumentiDtM, A200FImportazioneMassivaDocumentiDtM);
  try
    A200FImportazioneMassivaDocumenti.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A200FImportazioneMassivaDocumentiDtM.Free;
    A200FImportazioneMassivaDocumenti.Free;
  end;
end;

procedure TA200FImportazioneMassivaDocumenti.FormCreate(Sender: TObject);
begin
  DATA_VUOTA:='  ' + FormatSettings.DateSeparator + '  ' + FormatSettings.DateSeparator + '    ';
end;

procedure TA200FImportazioneMassivaDocumenti.FormShow(Sender: TObject);
begin
  C700DatiVisualizzati:='';
  C700DatiSelezionati:=C700CampiBase + ', T430INIZIO, T430FINE, T030.CODFISCALE';
  C700DataLavoro:=Parametri.DataLavoro;
  C700DataDal:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,0,False);
  frmSelAnagrafe.SoloPersonaleInterno:=False;
  frmSelAnagrafe.SelezionePeriodica:=False;
  frmSelAnagrafe.NumRecords;
  CreaC004(SessioneOracle,'A200',Parametri.ProgOper);
  GetParametriFunzione;
  rgpImpNomeFileOutOnClick(nil);
end;

procedure TA200FImportazioneMassivaDocumenti.frmInputPeriodoedtFineExit(Sender: TObject);
begin
  if DataF <= 0 then
    raise Exception.Create(A000MSG_ERR_DATA_VALIDA);
end;

procedure TA200FImportazioneMassivaDocumenti.frmInputPeriodoedtInizioExit(Sender: TObject);
begin
  frmInputPeriodo.edtInizioExit(Sender);
  if DataI <= 0 then
    raise Exception.Create(A000MSG_ERR_DATA_VALIDA);
end;

procedure TA200FImportazioneMassivaDocumenti.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PutParametriFunzione;
end;

procedure TA200FImportazioneMassivaDocumenti.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
  FreeAndNil(C004FParamForm);
end;

procedure TA200FImportazioneMassivaDocumenti.GetParametriFunzione;
var
  ParametroDB:String;
begin
  edtImpPath.Text:=C004FParamForm.GetParametro('PATH','');
  edtImpFiltro.Text:=C004FParamForm.GetParametro('FILTRO','*.*');
  edtImpSeparatore.Text:=C004FParamForm.GetParametro('SEPARATORE','_');
  edtImpNomeFile.Text:=C004FParamForm.GetParametro('NOME_FILE_IN','<MATRICOLA>_<NOME_DEL_FILE>');

  ParametroDB:=C004FParamForm.GetParametro('NOME_FILE_OUT',A200FImportazioneMassivaDocumentiDtM.B022MW.FORMATO_NOME_FILE_OUT_ORIG);
  if ParametroDB = A200FImportazioneMassivaDocumentiDtM.B022MW.FORMATO_NOME_FILE_OUT_ORIG then
    rgpImpNomeFileOutOrig.Checked:=True
  else if ParametroDB = A200FImportazioneMassivaDocumentiDtM.B022MW.FORMATO_NOME_FILE_OUT_PRED then
    rgpImpNomeFileOutPred.Checked:=True
  else
    rgpImpNomeFileOutTag.Checked:=True;

  edtImpNomeFileOutPred.Text:=C004FParamForm.GetParametro('NOME_FILE_OUT_PRED','');

  rgpImpNomeFileOutOnClick(nil);

  try
    dcmbImpTipologia.KeyValue:=C004FParamForm.GetParametro('TIPOLOGIA',A200FImportazioneMassivaDocumentiDtM.B022MW.CodTipologiaDefault);
  except
    dcmbImpTipologia.KeyValue:=A200FImportazioneMassivaDocumentiDtM.B022MW.CodTipologiaDefault;
  end;

  try
    rgpImpAzioneDocTip.ItemIndex:=StrToInt(C004FParamForm.GetParametro('AZIONE_DOC_TIP','0'));
  except
    rgpImpAzioneDocTip.ItemIndex:=0;
  end;

  try
    dcmbImpUfficio.KeyValue:=C004FParamForm.GetParametro('UFFICIO',A200FImportazioneMassivaDocumentiDtM.B022MW.CodUfficioDefault);
  except
    dcmbImpUfficio.KeyValue:=A200FImportazioneMassivaDocumentiDtM.B022MW.CodUfficioDefault;
  end;

  frmInputPeriodo.edtInizio.Text:=C004FParamForm.GetParametro('PERIODO_DAL',DATA_VUOTA);
  frmInputPeriodo.edtFine.Text:=C004FParamForm.GetParametro('PERIODO_AL',DATA_VUOTA);
  memNote.Lines.Text:=C004FParamForm.GetParametro('NOTE','');
  chkImpVisualIrisWeb.Checked:=(C004FParamForm.GetParametro('VIS_PORTALE_WEB','N') = 'S')
end;

procedure TA200FImportazioneMassivaDocumenti.PutParametriFunzione;
var
  ParametroDB:String;
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('PATH',edtImpPath.Text);
  C004FParamForm.PutParametro('FILTRO',edtImpFiltro.Text);
  C004FParamForm.PutParametro('SEPARATORE',edtImpSeparatore.Text);
  C004FParamForm.PutParametro('NOME_FILE_IN',edtImpNomeFile.Text);

  if rgpImpNomeFileOutOrig.Checked then
    ParametroDB:=A200FImportazioneMassivaDocumentiDtM.B022MW.FORMATO_NOME_FILE_OUT_ORIG
  else if rgpImpNomeFileOutPred.Checked then
    ParametroDB:=A200FImportazioneMassivaDocumentiDtM.B022MW.FORMATO_NOME_FILE_OUT_PRED
  else
    ParametroDB:=A200FImportazioneMassivaDocumentiDtM.B022MW.FORMATO_NOME_FILE_OUT_TAG;
  C004FParamForm.PutParametro('NOME_FILE_OUT',ParametroDB);

  C004FParamForm.PutParametro('NOME_FILE_OUT_PRED',edtImpNomeFileOutPred.Text);
  C004FParamForm.PutParametro('TIPOLOGIA',VarToStr(dcmbImpTipologia.KeyValue));
  C004FParamForm.PutParametro('AZIONE_DOC_TIP',IntToStr(rgpImpAzioneDocTip.ItemIndex));
  C004FParamForm.PutParametro('UFFICIO',VarToStr(dcmbImpUfficio.KeyValue));
  C004FParamForm.PutParametro('PERIODO_DAL',frmInputPeriodo.edtInizio.Text);
  C004FParamForm.PutParametro('PERIODO_AL',frmInputPeriodo.edtFine.Text);
  C004FParamForm.PutParametro('NOTE',memNote.Lines.Text);
  C004FParamForm.PutParametro('VIS_PORTALE_WEB',IfThen(chkImpVisualIrisWeb.Checked,'S','N'));
  try SessioneOracle.Commit; except end;
end;

procedure TA200FImportazioneMassivaDocumenti.edtImpPathChange(Sender: TObject);
begin
  ResetRicerca;
end;

procedure TA200FImportazioneMassivaDocumenti.btnImpPathBrowseClick(Sender: TObject);
var
  OpenDialog:TOpenDialog;
  FileOpenDialog:TFileOpenDialog;
begin
  if Win32MajorVersion >= 6 then  // Vista+
  begin
    FileOpenDialog:=TFileOpenDialog.Create(Self);
    try
      FileOpenDialog.Options:=[fdoPickFolders];
      if FileOpenDialog.Execute then
      begin
        ResetRicerca;
        edtImpPath.Text:=FileOpenDialog.FileName;
      end;
    finally
      FileOpenDialog.Free;
    end;
  end
  else
  begin
    OpenDialog:=TOpenDialog.Create(Self);
    OpenDialog.FileName:='path_documenti';
    try
      if OpenDialog.Execute then
      begin
        ResetRicerca;
        edtImpPath.Text:=ExtractFileDir(OpenDialog.FileName);
      end;
    finally
      OpenDialog.Free;
    end;
  end;
end;

procedure TA200FImportazioneMassivaDocumenti.edtImpFiltroChange(Sender: TObject);
begin
  ResetRicerca;
end;

procedure TA200FImportazioneMassivaDocumenti.edtImpFormatiOnChange(Sender:TObject);
begin
  ResetRicerca;
end;

procedure TA200FImportazioneMassivaDocumenti.rgpImpNomeFileOutOnClick(Sender: TObject);
begin
  edtImpNomeFileOutPred.Enabled:=rgpImpNomeFileOutPred.Checked;
  edtImpNomeFileOutPred.Color:=IfThen(edtImpNomeFileOutPred.Enabled,clWindow,clBtnFace);
  ResetRicerca;
end;

procedure TA200FImportazioneMassivaDocumenti.edtImpNomeFileOutPredChange(Sender: TObject);
begin
  ResetRicerca;
end;

procedure TA200FImportazioneMassivaDocumenti.btnImpAnalizzaClick(Sender: TObject);
var
  i:Integer;
  SearchConfig:TB022DocumentiSearchConfig;
begin
  if A200FImportazioneMassivaDocumentiDtM.B022MW.ElencoDocumentiImport <> nil then
    FreeAndNil(A200FImportazioneMassivaDocumentiDtM.B022MW.ElencoDocumentiImport);
  SearchConfig:=TB022DocumentiSearchConfig.Create;
  try
    SearchConfig.Separatore:=edtImpSeparatore.Text;
    SearchConfig.FormatoNomeFile:=Trim(edtImpNomeFile.Text);
    if rgpImpNomeFileOutOrig.Checked then
    begin
      SearchConfig.TipoNomeFileOutput:=tnfoOriginale;
    end
    else if rgpImpNomeFileOutPred.Checked then
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

    with A200FImportazioneMassivaDocumentiDtM.B022MW do
      ElencoDocumentiImport:=AnalizzaDocumentiImport(Trim(edtImpPath.Text),Trim(edtImpFiltro.Text),C700SelAnagrafe,SearchConfig);

    lstImpDocDaImportare.Items.Clear;
    lstImpDocIgnorati.Clear;
    for i:=0 to A200FImportazioneMassivaDocumentiDtM.B022MW.ElencoDocumentiImport.ListaDocumenti.Count - 1 do
      lstImpDocDaImportare.Items.Add(A200FImportazioneMassivaDocumentiDtM.B022MW.ElencoDocumentiImport.ListaDocumenti[i].NomeFile);
    for i:=0 to A200FImportazioneMassivaDocumentiDtM.B022MW.ElencoDocumentiImport.ListaFileIgnorati.Count - 1 do
      lstImpDocIgnorati.Items.Add(A200FImportazioneMassivaDocumentiDtM.B022MW.ElencoDocumentiImport.ListaFileIgnorati[i]);

    lstImpDocDaImportare.CheckAll(cbChecked);
    lstImpDocDaImportare.OnClickCheck(nil);
  finally
    FreeAndNil(SearchConfig);
  end;
end;

procedure TA200FImportazioneMassivaDocumenti.lstImpDocDaImportareClickCheck(Sender: TObject);
begin
  ImpostaLabelSelezioneFile;
end;

procedure TA200FImportazioneMassivaDocumenti.Selezionatutto1Click(Sender: TObject);
begin
  lstImpDocDaImportare.CheckAll(cbChecked);
end;

procedure TA200FImportazioneMassivaDocumenti.Deselezionatutto1Click(Sender: TObject);
begin
  lstImpDocDaImportare.CheckAll(cbUnchecked);
end;

procedure TA200FImportazioneMassivaDocumenti.Invertiselezione1Click(Sender: TObject);
var
  i:Integer;
begin
  for i:=0 to lstImpDocDaImportare.Count - 1 do
    lstImpDocDaImportare.Checked[i]:=not lstImpDocDaImportare.Checked[i];
end;

procedure TA200FImportazioneMassivaDocumenti.Copianegliappunti1Click(Sender: TObject);
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
  Clipboard.Clear;
  Clipboard.AsText:=TestoCopiato;
end;

procedure TA200FImportazioneMassivaDocumenti.btnEseguiClick(Sender: TObject);
var
  i,nFileImp:Integer;
  ConfigImport:TB022DocumentiImportConfig;
  DimMB:Double;
  InfoStatoPanel:TStatusPanel;
begin
  InfoStatoPanel:=StatusBar.Panels[1];
  InfoStatoPanel.Text:='';

  nFileImp:=0;
  for i:=0 to lstImpDocDaImportare.Count - 1 do
    if lstImpDocDaImportare.Checked[i] then
      Inc(nFileImp);
  if nFileImp = 0 then
    Exit;

  A200FImportazioneMassivaDocumentiDtM.B022MW.Controlli(DATA_VUOTA,frmInputPeriodo.edtInizio.Text,frmInputPeriodo.edtFine.Text);

  if R180MessageBox(Format(A000MSG_A200_DLG_FMT_AVVIO_IMPORT,[nFileImp]),DOMANDA,'Importa') = mrYes then
  begin
    // Se è attiva la sovrascrittura chiediamo conferma prima di proseguire
    if rgpImpAzioneDocTip.ItemIndex = 1 then
      if MessageDlg(Format(A000MSG_A200_DLG_FMT_CONFIRM_SOVRASCR,[dcmbImpTipologia.Text]),mtWarning,[mbYes,mbNo],-1,mbNo) = mrNo then
        Exit;
    prgImp.Max:=nFileImp;
    prgImp.Position:=0;

    for i:=0 to pnlImpImposta.ControlCount - 1 do
      pnlImpImposta.Controls[i].Enabled:=False;
    for i:=0 to pnlImpNomeFileOut.ControlCount - 1 do
      pnlImpNomeFileOut.Controls[i].Enabled:=False;
    btnEsegui.Enabled:=False;
    btnAnomalie.Enabled:=False;
    prgImp.Enabled:=True;
    Screen.Cursor:=crHourGlass;
    Application.ProcessMessages;
    ConfigImport:=TB022DocumentiImportConfig.Create;
    try
      ConfigImport.Tipologia:=dcmbImpTipologia.KeyValue;
      ConfigImport.Sovrascrivi:=(rgpImpAzioneDocTip.ItemIndex = 1);
      ConfigImport.UfficioRiferimento:=dcmbImpUfficio.KeyValue;
      ConfigImport.PeriodoDal:=A200FImportazioneMassivaDocumentiDtM.B022MW.DataInizioStr;
      ConfigImport.PeriodoAl:=A200FImportazioneMassivaDocumentiDtM.B022MW.DataFineStr;
      ConfigImport.Note:=memNote.Lines.Text;
      ConfigImport.AccessoPortale:=IfThen(chkImpVisualIrisWeb.Checked,'S','N');
      try
        RegistraMsg.IniziaMessaggio('A200');
        for i:=0 to lstImpDocDaImportare.Items.Count - 1 do
          if lstImpDocDaImportare.Checked[i] then
          begin
            // Gli indici corrispondono
            InfoStatoPanel.Text:=Format(A000MSG_A200_MSG_IMPORTAZIONE,[A200FImportazioneMassivaDocumentiDtM.B022MW.ElencoDocumentiImport.ListaDocumenti.Items[i].NomeFile]);
            Application.ProcessMessages;
            // Verifico che la dimensione del file non ecceda i limiti
            // controllo dimensione file
            DimMB:=A200FImportazioneMassivaDocumentiDtM.B022MW.ElencoDocumentiImport.ListaDocumenti.Items[i].DimensioneByte / BYTES_MB;
            if DimMB > A200FImportazioneMassivaDocumentiDtM.B022MW.IterMaxDimAllegatoMB then
            begin
              RegistraMsg.InserisciMessaggio('A', Format(A000MSG_A200_ERR_SUPERO_MAX_DIM,[A200FImportazioneMassivaDocumentiDtM.B022MW.ElencoDocumentiImport.ListaDocumenti.Items[i].NomeFile]),
                                             Parametri.Azienda, A200FImportazioneMassivaDocumentiDtM.B022MW.ElencoDocumentiImport.ListaDocumenti.Items[i].Progressivo);
            end
            else
              A200FImportazioneMassivaDocumentiDtM.B022MW.ImportaDocumento(A200FImportazioneMassivaDocumentiDtM.B022MW.ElencoDocumentiImport.ListaDocumenti.Items[i],ConfigImport);
            prgImp.StepIt;
            Application.ProcessMessages;
          end;
      except
        on E:Exception do
        begin
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A200_ERR_FMT_IMPORT_EXC,[A200FImportazioneMassivaDocumentiDtM.B022MW.ElencoDocumentiImport.ListaDocumenti.Items[i].NomeFile,E.Message]),
                                         Parametri.Azienda, A200FImportazioneMassivaDocumentiDtM.B022MW.ElencoDocumentiImport.ListaDocumenti.Items[i].Progressivo);
        end;
      end;
    finally
      for i:=0 to pnlImpImposta.ControlCount - 1 do
        pnlImpImposta.Controls[i].Enabled:=True;
      for i:=0 to pnlImpNomeFileOut.ControlCount - 1 do
      begin
        pnlImpNomeFileOut.Controls[i].Enabled:=True;
      end;
      Screen.Cursor:=crDefault;
      InfoStatoPanel.Text:='';
      btnEsegui.Enabled:=True;
      btnAnomalie.Enabled:=RegistraMsg.ContieneTipoI or RegistraMsg.ContieneTipoA;
      FreeAndNil(ConfigImport);
      if not RegistraMsg.ContieneTipoA then
        R180MessageBox(A000MSG_A200_MSG_IMPORT_OK,INFORMA,'Importazione')
      else
        R180MessageBox(A000MSG_A200_ERR_IMPORT_ANOM,ESCLAMA,'Importazione');
    end;
  end;
end;

procedure TA200FImportazioneMassivaDocumenti.btnAnomalieClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A200','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe;
end;

procedure TA200FImportazioneMassivaDocumenti.ResetRicerca;
begin
  if A200FImportazioneMassivaDocumentiDtM.B022MW.ElencoDocumentiImport <> nil then
    FreeAndNil(A200FImportazioneMassivaDocumentiDtM.B022MW.ElencoDocumentiImport);
  lstImpDocDaImportare.Clear;
  lstImpDocIgnorati.Clear;
  ImpostaLabelSelezioneFile;
end;

procedure TA200FImportazioneMassivaDocumenti.ImpostaLabelSelezioneFile;
var
  i,NumFileSelezionati,DimensioneTotale:Integer;
begin
  NumFileSelezionati:=0;
  DimensioneTotale:=0;
  btnEsegui.Enabled:=False;
  for i:=0 to lstImpDocDaImportare.Items.Count - 1 do
    if lstImpDocDaImportare.Checked[i] then
    begin
      inc(NumFileSelezionati);
      DimensioneTotale:=DimensioneTotale + A200FImportazioneMassivaDocumentiDtM.B022MW.ElencoDocumentiImport.ListaDocumenti[i].DimensioneByte;
      btnEsegui.Enabled:=not SolaLettura;
    end;
  lblImpFilesSelezionati.Caption:=Format(A000MSG_A200_MSG_DLG_NUM_FILE_SELEZ,[NumFileSelezionati]);
  lblImpDimensTotale.Caption:=Format(A000MSG_A200_MSG_DLG_DIM_FILE_SELEZ,[R180GetFileSizeStr(DimensioneTotale)]);
end;

{ DataF }
function TA200FImportazioneMassivaDocumenti._GetDataF: TDateTime;
begin
  Result := frmInputPeriodo.DataFine;
end;
procedure TA200FImportazioneMassivaDocumenti._PutDataF(const Value: TDateTime);
begin
  frmInputPeriodo.DataFine := Value;
end;
{ ----DataF }
{ DataI }
function TA200FImportazioneMassivaDocumenti._GetDataI: TDateTime;
begin
  Result := frmInputPeriodo.DataInizio;
end;
procedure TA200FImportazioneMassivaDocumenti._PutDataI(const Value: TDateTime);
begin
  frmInputPeriodo.DataInizio := Value;
end;
{ ----DataI }

end.
