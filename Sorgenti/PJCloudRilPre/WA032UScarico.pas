unit WA032UScarico;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR100UBase, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, IWCompListbox, IWDBStdCtrls,
  meIWDBLookupComboBox, IWCompCheckbox, meIWCheckBox, IWCompLabel, meIWLabel, IWCompMemo, meIWMemo,
  A000UInterfaccia, R200UScaricoTimbratureDtM, meIWComboBox, OracleData,medpIWMessageDlg, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, meIWRegion, medpIWTabControl,
  meIWImageFile, medpIWImageButton, IWCompEdit, meIWEdit,C180FunzioniGenerali, IWAdvCheckGroup,
  meTIWAdvCheckGroup, Menus, A000UMessaggi, IWApplication, System.IOUtils, C190FunzioniGeneraliWeb,
  IWCompFileUploader, meIWFileUploader;

type
  TFile = record
    Nome:String;
    Data:TDateTime;
  end;

  TWA032FScarico = class(TWR100FBase)
    lblRigaDescr: TmeIWLabel;
    lblScaricoDescr: TmeIWLabel;
    lblAziendaDescr: TmeIWLabel;
    lblBadgeDescr: TmeIWLabel;
    WA032ScarichiRG: TmeIWRegion;
    btnScarico: TmeIWButton;
    btnRecuperoScarico: TmeIWButton;
    memMessaggi: TmeIWMemo;
    cmbScarico: TmeIWComboBox;
    chkScarichiAuto: TmeIWCheckBox;
    lblScarico: TmeIWLabel;
    lblRiga: TmeIWLabel;
    lblAzienda: TmeIWLabel;
    lblBadge: TmeIWLabel;
    grdTabDetail: TmedpIWTabControl;
    WA032PrecedentiRG: TmeIWRegion;
    TemplateScarichiRG: TIWTemplateProcessorHTML;
    TemplatePrecedentiRG: TIWTemplateProcessorHTML;
    lblPrametrizzazionelbl: TmeIWLabel;
    lblParametrizzazione: TmeIWLabel;
    lblTimbrature: TmeIWLabel;
    lblDataDa: TmeIWLabel;
    lblOreDa: TmeIWLabel;
    lblDataAl: TmeIWLabel;
    lblOreAl: TmeIWLabel;
    edtFDataDa: TmeIWEdit;
    edtOreDa: TmeIWEdit;
    edtFDataAL: TmeIWEdit;
    edtOreAl: TmeIWEdit;
    lblFiles: TmeIWLabel;
    lblPercorso: TmeIWLabel;
    lblNomeFile: TmeIWLabel;
    edtFiltroNome: TmeIWEdit;
    lblDataModifica: TmeIWLabel;
    lblDataModificaAl: TmeIWLabel;
    edtDataDa: TmeIWEdit;
    edtDataA: TmeIWEdit;
    btnRefresh: TmedpIWImageButton;
    edtPathTimb: TmeIWEdit;
    cgplstFiles: TmeTIWAdvCheckGroup;
    btnConferma: TmeIWButton;
    memMessaggiPrec: TmeIWMemo;
    pmnAzioni: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    lnkScaricoScelta: TmeIWLink;
    lblUploadFile: TmeIWLabel;
    lblNomeFileScarico: TmeIWLabel;
    IWFile: TmeIWFileUploader;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure btnScaricoClick(Sender: TObject);
    procedure grdTabDetailTabControlChanging(Sender: TObject; var AllowChange: Boolean);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure edtFiltroNomeAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure edtDataDaAsyncExit(Sender: TObject; EventParams: TStringList);
    procedure lnkScaricoSceltaClick(Sender: TObject);
    procedure cmbScaricoAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure chkScarichiAutoAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    VetFile:array of TFile;
    R200:TR200FScaricoTimbratureDtM;
    procedure InizializzaScarichiPrecedentiRG;
    procedure QuickSort(iLo, iHi: Integer);
    procedure CaricaFile(var Lista:TmeTIWAdvCheckGroup;Path:String);
    procedure ResultConferma(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure PutParametriFunzione;
    procedure CaricaComboBox;
    procedure ValidaData(Sender: TIWEdit);
    procedure ValidaOra(Sender: TIWEdit);
    procedure ValidaInput;
    procedure EffettuaUpload;
  public
    { Public declarations }

  end;

implementation

uses WC502UMenuRilPreFM;

{$R *.dfm}

procedure TWA032FScarico.IWAppFormCreate(Sender: TObject);
{Mi posiziono sullo scarico di Default}
var SQL:String;
begin
  grdTabDetail.AggiungiTab('Ultimi scarichi',WA032ScarichiRG);
  grdTabDetail.AggiungiTab('Recupero scarichi precedenti',WA032PrecedentiRG);
  grdTabDetail.HasFiller:=True;
  grdTabDetail.ActiveTab:=WA032ScarichiRG;
  inherited;
  R200:=TR200FScaricoTimbratureDtM.Create(nil);
  with R200 do
  begin
    SessioneOracleB006:=SessioneOracle;
    ConnettiDataBase(SessioneOracle.LogonDatabase);
    if Parametri.Azienda <> 'AZIN' then
    begin
      if QI100.Active then
        QI100.Close;
      SQL:='WHERE (INSTR('','' || I100.AZIENDE || '','','',' + Parametri.Azienda + ','') > 0 ';
      SQL:=SQL + 'OR I100.AZIENDE IS NULL)';
      QI100.SetVariable('WHERE',SQL);
      QI100.Open;
    end;
    QI100.Filtered:=False;
    CaricaComboBox;
  end;
  cmbScarico.ItemIndex:=cmbScarico.Items.IndexOf(C004DM.GetParametro('NOME_SCARICO',cmbScarico.Text));
  chkScarichiAuto.Checked:=C004DM.GetParametro('SCARICHI_AUTO','N') = 'S';
  //cmbScarico.Enabled:=not chkScarichiAuto.Checked;
  cmbScaricoAsyncChange(cmbScarico,nil);
  chkScarichiAutoAsyncClick(chkScarichiAuto,nil);
end;

procedure TWA032FScarico.CaricaComboBox;
begin
  with R200.QI100 do
  begin
    Close;
    Open;
    First;
    while not Eof do
    begin
      cmbScarico.Items.Add(FieldByName('SCARICO').AsString);
      Next;
    end;
  end;
  cmbScarico.ItemIndex:=0;
end;

procedure TWA032FScarico.IWAppFormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(R200);
end;

procedure TWA032FScarico.lnkScaricoSceltaClick(Sender: TObject);
var
  Params: String;
begin
  inherited;
  Params:='SCARICO=' + cmbScarico.Text;
  AccediForm(119, Params, False); //OpenA031ParScarico(EScarico.Text);
end;

procedure TWA032FScarico.btnConfermaClick(Sender: TObject);
begin
  ValidaInput;
  MsgBox.WebMessageDlg(A000MSG_A032_DLG_RECUPERARE_FILE,mtConfirmation,[mbYes,mbNo],ResultConferma,'');
end;

procedure TWA032FScarico.ResultConferma(Sender: TObject; R: TmeIWModalResult; KI: String);
var i,ItemsChecked:Integer;
begin
  if R = mrYes then
  begin
    R200.QI100.SearchRecord('SCARICO',cmbScarico.Text,[srFromBeginning]);
    try
      R200.DataIRecupero:=StrToDate(edtFDataDa.Text) + (R180OreMinutiExt(edtOreDa.Text) / 1440);
      R200.DataFRecupero:=StrToDate(edtFDataAl.Text) + (R180OreMinutiExt(edtOreAl.Text) / 1440);
      memMessaggiPrec.Lines.Clear;
      ItemsChecked:=0;
      for i:=0 to cgplstFiles.Items.Count - 1 do
        if cgplstFiles.IsChecked[i] then
          inc(ItemsChecked);
      for i:=0 to cgplstFiles.Items.Count - 1 do
        if cgplstFiles.IsChecked[i] then
        begin
          R200.LMessaggi.Clear;
          R200.NFRecupero:=Trim(edtPathTimb.Text);
          if (R200.NFRecupero <> '') and (R200.NFRecupero[Length(R200.NFRecupero)] <> '\') then
            R200.NFRecupero:=R200.NFRecupero + '\';
          R200.NFRecupero:=R200.NFRecupero + VetFile[i].Nome;
          Application.ProcessMessages;
          R200.Scarico(True,False);
          with R200 do
          begin
            RegistraMsg.LeggiMessaggi(RegistraMsg.ID);
            memMessaggiPrec.Lines.Add('<< Acquisizione file: ' + VetFile[i].Nome + ' >>');
            while Not RegistraMsg.selI005.Eof do
            begin
              memMessaggiPrec.Lines.Add(RegistraMsg.selI005.FieldByName('DATA_MSG').AsString + ' - ' + RegistraMsg.selI005.FieldByName('MSG').AsString);
              RegistraMsg.selI005.Next;
            end;
          end;
        end;
    finally
      R200.NFRecupero:='';
    end;
    MsgBox.WebMessageDlg(A000MSG_A032_MSG_SCARICO_TERMINATO,mtInformation,[mbOK],nil,'');
    CaricaFile(cgplstFiles,edtPathTimb.Text);
  end;
end;

procedure TWA032FScarico.btnRefreshClick(Sender: TObject);
begin
  CaricaFile(cgplstFiles,edtPathTimb.Text);
end;

procedure TWA032FScarico.EffettuaUpload;
var
  LFileName: String;
begin
  { DONE : TEST IW 14 OK }
  try
    // ottenimento del path in cui salvare il file
    LFileName:=GGetWebApplicationThreadVar.UserCacheDir + IWFile.NomeFile;

    // eliminazione file precedente e effettuazione upload
    DeleteFile(LFileName);
    IWFile.SalvaSuFile(LFileName);
    IWFile.Ripristina;

    //salvataggio path su variabile pubblica per l'utilizzo in R200
    R200.UploadFileWA032:=LFileName;
  except
    on E: Exception do
    begin
      IWFile.Ripristina;
      MsgBox.MessageBox(E.Message,ERRORE,'Errore upload file');
    end;
  end;
end;

procedure TWA032FScarico.btnScaricoClick(Sender: TObject);
{Nome file di appoggio = TIaammgg.IRR}
begin
  if not chkScarichiAuto.Checked then
  begin
    R200.QI100.SearchRecord('SCARICO',cmbScarico.Text,[srFromBeginning]);
    // aggiunta per lo scarico timbrature da file scelto dall'utente
    { DONE : TEST IW 14 OK }
    if IWFile.IsPresenteFileUploadato then
      EffettuaUpload;
  end;
  R200.LMessaggi.Clear;
  R200.Scarico(not chkScarichiAuto.Checked,False);
  with R200 do
  begin
    RegistraMsg.LeggiMessaggi(RegistraMsg.ID);
    memMessaggi.Lines.Clear;
    while not RegistraMsg.selI005.Eof do
    begin
      memMessaggi.Lines.Add(RegistraMsg.selI005.FieldByName('DATA_MSG').AsString + ' - ' + RegistraMsg.selI005.FieldByName('MSG').AsString);
      RegistraMsg.selI005.Next;
    end;
    lblScaricoDescr.Caption:=LScarico.Caption;
    lblAziendaDescr.Caption:=LAzienda.Caption;
    lblRigaDescr.Caption:=LRiga.Caption;
    lblBadgeDescr.Caption:=LBadge.Caption;
    PutParametriFunzione;
    //Controllo Caption perchè la procedure R200.Scarico valorizza LScarico
    //solo se anche ScrollBox (componente win A032) è valorizzato
    if lblScaricoDescr.Caption = '' then
      lblScaricoDescr.Caption:=cmbScarico.Text;
  end;
  MsgBox.WebMessageDlg(A000MSG_A032_MSG_SCARICO_TERMINATO,mtInformation,[mbOK],nil,'');
end;

procedure TWA032FScarico.chkScarichiAutoAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  cmbScarico.Enabled:=not chkScarichiAuto.Checked;
  btnRecuperoScarico.Enabled:=not chkScarichiAuto.Checked;

  { DONE : TEST IW 14 OK }
  lblNomeFileScarico.Css:=C190ImpostaCssInvisibile(lblNomeFileScarico.Css, not chkScarichiAuto.Checked);
  lblUploadFile.Css:=C190ImpostaCssInvisibile(lblNomeFileScarico.Css, not chkScarichiAuto.Checked);
  C190VisualizzaElementoAsync(jqTemp,IWFile.HTMLName,not chkScarichiAuto.Checked);

end;

procedure TWA032FScarico.cmbScaricoAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  if cmbScarico.Text <> '' then
    lblNomeFileScarico.Caption:=R200.QI100.Lookup('SCARICO',cmbScarico.Text,'NOMEFILE')
  else
    lblNomeFileScarico.Caption:='';
end;

procedure TWA032FScarico.grdTabDetailTabControlChanging(Sender: TObject; var AllowChange: Boolean);
begin
  inherited;
  if grdTabDetail.ActiveTab = WA032ScarichiRG then
    InizializzaScarichiPrecedentiRG;
end;

procedure TWA032FScarico.InizializzaScarichiPrecedentiRG;
begin
  edtDataDa.Text:=DateToStr(Date);
  edtDataA.Text:=DateToStr(Date);
  edtFDataDa.Text:=DateToStr(Date);
  edtFDataAL.Text:=DateToStr(Date);
  edtOreDa.Text:='00.00';
  edtOreAl.Text:='23.59';
  with R200 do
  begin
    QI100.SearchRecord('SCARICO',cmbScarico.Text,[srFromBeginning]);
    edtPathTimb.Text:=R180GetFilePath(QI100.FieldByName('NOMEFILE').AsString,True);
    lblPrametrizzazionelbl.Text:=QI100.FieldByName('SCARICO').AsString;
  end;
  //lstFiles.MultiSelect:=True;
  CaricaFile(cgplstFiles,edtPathTimb.Text);
end;

procedure TWA032FScarico.CaricaFile(var Lista: TmeTIWAdvCheckGroup; Path: String);
var FFile:TSearchRec;
    i:integer;
begin
  Lista.Items.Clear;
  SetLength(VetFile,0);
  if (Path = '') or not DirectoryExists(Path) then
    Exit;
  if Path[Length(Path)] <> '\' then
    Path:=Path + '\';
  if FindFirst(Path + IfThen(edtFiltroNome.Text = '','*.*',edtFiltroNome.Text),faSysFile,FFile) <> 0 then
    Exit;
  repeat
    if (FFile.Name <> '.') and (FFile.Name <> '..') and
       (Trunc(FileDateToDateTime(FFile.Time)) >= StrToDate(edtDataDa.Text)) and
       (Trunc(FileDateToDateTime(FFile.Time)) <= StrToDate(edtDataA.Text)) then
    begin
      SetLength(VetFile,length(VetFile) + 1);
      VetFile[Length(VetFile)-1].Nome:=FFile.Name;
      VetFile[Length(VetFile)-1].Data:=FileDateToDateTime(FFile.Time);
    end;
  until FindNext(FFile) <> 0;
  if length(VetFile) > 0 then
    QuickSort(Low(VetFile),High(VetFile));
  for i:=Low(VetFile) to High(VetFile) do
    Lista.Items.Add(R180DimLung(VetFile[i].Nome,45) + DateTimeToStr(VetFile[i].Data));
  PutParametriFunzione;
end;

procedure TWA032FScarico.QuickSort(iLo, iHi: Integer);
var Lo, Hi: Integer;
    Mid:TDate;
    T:TFile;
begin
  Lo := iLo;
  Hi := iHi;
  Mid := VetFile[(Lo + Hi) div 2].Data;
  repeat
    while VetFile[Lo].Data > Mid do Inc(Lo);
    while VetFile[Hi].Data < Mid do Dec(Hi);
    if Lo <= Hi then
      begin
      T := VetFile[Lo];
      VetFile[Lo]:=VetFile[Hi];
      VetFile[Hi]:=T;
      Inc(Lo);
      Dec(Hi);
      end;
  until Lo > Hi;
  if Hi > iLo then QuickSort(iLo, Hi);
  if Lo < iHi then QuickSort(Lo, iHi);
end;

procedure TWA032FScarico.Selezionatutto1Click(Sender: TObject);
var
 i:Integer;
begin
  inherited;
  for i:=0 to cgplstFiles.Items.Count - 1 do
    cgplstFiles.IsChecked[i]:=True;
  cgplstFiles.AsyncUpdate;
end;

procedure TWA032FScarico.Invertiselezione1Click(Sender: TObject);
var
  i:Integer;
begin
  inherited;
  for i:=0 to cgplstFiles.Items.Count - 1 do
    cgplstFiles.IsChecked[i]:=not cgplstFiles.IsChecked[i];
  cgplstFiles.AsyncUpdate;
end;

procedure TWA032FScarico.Deselezionatutto1Click(Sender: TObject);
var
  i:Integer;
begin
  inherited;
  for i:=0 to cgplstFiles.Items.Count - 1 do
    cgplstFiles.IsChecked[i]:=False;
  cgplstFiles.AsyncUpdate;
end;

procedure TWA032FScarico.edtDataDaAsyncExit(Sender: TObject; EventParams: TStringList);
begin
  CaricaFile(cgplstFiles,edtPathTimb.Text);
end;

procedure TWA032FScarico.edtFiltroNomeAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  CaricaFile(cgplstFiles,edtPathTimb.Text);
end;

procedure TWA032FScarico.PutParametriFunzione;
begin
  with C004DM do
  begin
    Cancella001;
    PutParametro('NOME_SCARICO',VarToStr(cmbScarico.Text));
    if chkScarichiAuto.Checked then
      PutParametro('SCARICHI_AUTO','S')
    else
      PutParametro('SCARICHI_AUTO','N');
    try SessioneOracle.Commit; except end;
  end;
end;

procedure TWA032FScarico.ValidaInput;
begin
  ValidaData(edtFDataDa);
  ValidaOra(edtOreDa);
  ValidaData(edtFDataAL);
  ValidaOra(edtOreAl);
  ValidaData(edtDataDa);
  ValidaData(edtDataA);
end;

procedure TWA032FScarico.ValidaData(Sender :TIWEdit);
begin
  if (Sender as TIWEdit).Text <> '' then
    StrToDate((Sender as TIWEdit).Text);
end;

procedure TWA032FScarico.ValidaOra(Sender :TIWEdit);
begin
  if (Sender as TIWEdit).Text <> '' then
    R180OraValidate(TIWEdit(Sender).Text);
end;

end.
