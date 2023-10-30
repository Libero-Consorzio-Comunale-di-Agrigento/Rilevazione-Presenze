unit WA087UImpAttestatiMal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,OracleData, Math,DB,
  Dialogs, WR100UBase, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, IWCompLabel, meIWLabel, IWCompListbox, IWDBStdCtrls, meIWDBLookupComboBox, meIWDBLabel, IWCompCheckbox,
  meIWCheckBox, A087UImpAttestatiMalMW, IWCompEdit, medpIWMultiColumnComboBox, meIWImageFile, IWDBGrids, medpIWDBGrid,
  medpIWMessageDlg, A000UInterfaccia, A000UCostanti, A000UMessaggi, medpIWImageButton, meIWEdit, Menus,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, IWApplication, WC700USelezioneAnagrafeFM, WC700USelezioneAnagrafeDM, medpIWC700NavigatorBar,
  IWCompFileUploader, meIWFileUploader;

type
  TWA087FImpAttestatiMal = class(TWR100FBase)
    chkEsenzione: TmeIWCheckBox;
    lblPercorsoFile: TmeIWLabel;
    chkAnomalie: TmeIWCheckBox;
    chkInserimento: TmeIWCheckBox;
    grdPreview: TmedpIWDBGrid;
    lblCertificati: TmeIWLabel;
    btnEsegui: TmedpIWImageButton;
    btnAnomalie: TmedpIWImageButton;
    edtPathFileDeleted: TmeIWEdit;
    pmnAzioni: TPopupMenu;
    actScaricaInExcelPreview: TMenuItem;
    btnVisualizzaFile: TmedpIWImageButton;
    lbFileScelto: TmeIWLabel;
    lblFileSceltoDescr: TmeIWLabel;
    btnUpload: TmedpIWImageButton;
    grdProfili: TmedpIWDBGrid;
    lblProfili: TmeIWLabel;
    btnDipEsclusi: TmeIWButton;
    fileUpload: TmeIWFileUploader;
    actScaricaInCSVPreview: TMenuItem;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure grdPreviewRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure chkAnomalieAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure actScaricaInExcelPreviewClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure btnRefreshCertificatiClick(Sender: TObject);
    procedure btnVisualizzaFileClick(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure btnUploadClick(Sender: TObject);
    procedure grdProfiliRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure btnDipEsclusiClick(Sender: TObject);
    procedure grdProfiliAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure actScaricaInCSVPreviewClick(Sender: TObject);
  private
    A087MW: TA087FImpAttestatiMalMW;
    ColoraGriglia:Boolean;
    CurrDip: Integer;
    PathFileUploaded:String;
    LstDipEsclusi:TStringList;
    procedure GetParametri;
    procedure PutParametri;
    procedure FiltroDipendenti;
    function GetPathFile: String;
    function IsAnomalieChecked: Boolean;
    function IsInserimentoChecked: Boolean;
    function IsValidChkEsenzione: Boolean;
    procedure C700FiltraCertificati(Sender: TObject);
    procedure ResultCausaleMal(Sender: TObject; R: TmeIWModalResult; KI: String);
    //Gestione ProgressBar
    procedure InizioElaborazione; override;
    procedure ElaboraElemento; override;
    procedure FineCicloElaborazione; override;
    function ElementoSuccessivo: Boolean; override;
    function ElaborazioneTerminata: String; override;
    function CurrentRecordElaborazione: Integer; override;
    function TotalRecordsElaborazione: Integer; override;
    procedure RecuperaFile;
    procedure AbilitaAzioni;
    procedure ResultVisFiltrati(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure imgAccediClick(Sender: TObject);
  protected
    procedure ImpostazioniWC700; override;
  end;

implementation

{$R *.dfm}

procedure TWA087FImpAttestatiMal.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  grdC700:=TmedpIWC700NavigatorBar.Create(Self);
  grdC700.AttivaBrowse:=False;
  grdC700.WC700FM.actConferma.OnExecute:=C700FiltraCertificati;
  //Per attivare automaticamente selezione totale di tutte le anagrafiche
  grdC700.ImpostaProgressivoCorrente:=False;
  grdC700.SelezioneVuota:=False;
  grdC700.WC700FM.C700Progressivo:=-1;
  AttivaGestioneC700;

  PathFileUploaded:='';
  lblFileSceltoDescr.Caption:='';
  ColoraGriglia:=False;
  LstDipEsclusi:=TStringList.Create;
  A087MW:=TA087FImpAttestatiMalMW.Create(Self);
  A087MW.SelAnagrafe:=grdC700.selAnagrafe;
  with A087MW do
  begin
    evtAnomalieChecked:=IsAnomalieChecked;
    evtGetPathFile:=GetPathFile;
    evtIsValidChkEsenzione:=IsValidChkEsenzione;
    evtInserimentoChecked:=IsInserimentoChecked;
  end;
  try
    GetParametri;
    btnAnomalie.Enabled:=False;
    btnEsegui.Enabled:=chkAnomalie.Checked or chkInserimento.Checked;
  except
  end;

  grdProfili.medpPaginazione:=False;
  grdProfili.medpComandiCustom:=True;
  grdProfili.medpRowSelect:=False;
  grdProfili.medpAttivaGrid(A087MW.selT269,False,False);
  grdProfili.medpPreparaComponentiDefault;
  grdProfili.medpPreparaComponenteGenerico('WR102-R',grdProfili.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','ACCEDI','','','');
  // forzato per gestione componenti WR102-R
  grdProfili.medpCaricaCDS;
end;

procedure TWA087FImpAttestatiMal.IWAppFormDestroy(Sender: TObject);
begin
  PutParametri;
  inherited;
end;

procedure TWA087FImpAttestatiMal.IWAppFormRender(Sender: TObject);
begin
  inherited;
  lblFileSceltoDescr.Caption:=ExtractFileName(PathFileUploaded);
end;

procedure TWA087FImpAttestatiMal.ImpostazioniWC700;
begin
  inherited;
  with grdC700.WC700FM do
  begin
    C700DatiSelezionati:=C700CampiBase + ',CODFISCALE';
    C700DataLavoro:=Parametri.DataLavoro;
  end;
end;

procedure TWA087FImpAttestatiMal.PutParametri;
begin
  C004DM.Cancella001;
  if chkEsenzione.Checked then
    C004DM.PutParametro(UpperCase(chkEsenzione.Name),'S')
  else
    C004DM.PutParametro(UpperCase(chkEsenzione.Name),'N');
  if chkAnomalie.Checked then
    C004DM.PutParametro(UpperCase(chkAnomalie.Name),'S')
  else
    C004DM.PutParametro(UpperCase(chkAnomalie.Name),'N');
  if chkInserimento.Checked then
    C004DM.PutParametro(UpperCase(chkInserimento.Name),'S')
  else
    C004DM.PutParametro(UpperCase(chkInserimento.Name),'N');
  try SessioneOracle.Commit; except end;
end;

procedure TWA087FImpAttestatiMal.GetParametri;
begin
  chkEsenzione.Checked:=C004DM.GetParametro(UpperCase(chkEsenzione.Name),'N') = 'S';
  chkAnomalie.Checked:=C004DM.GetParametro(UpperCase(chkAnomalie.Name),'N') = 'S';
  chkInserimento.Checked:=C004DM.GetParametro(UpperCase(chkInserimento.Name),'N') = 'S';
end;

procedure TWA087FImpAttestatiMal.actScaricaInCSVPreviewClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    csvDownload:=grdPreview.ToCsv
  else
    inviaFile('Estrazione.xls',csvDownload);
end;

procedure TWA087FImpAttestatiMal.actScaricaInExcelPreviewClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    streamDownload:=grdPreview.ToXlsx
  else
    inviaFile('Estrazione.xlsx',streamDownload);
end;

procedure TWA087FImpAttestatiMal.btnAnomalieClick(Sender: TObject);
var Params: String;
begin
  inherited;
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' + Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + medpCodiceForm + ParamDelimiter +
          'ID=' + IntToStr(RegistraMsg.ID) + ParamDelimiter +
          'TIPO=A';
  accediForm(201,Params,False);
end;

procedure TWA087FImpAttestatiMal.btnDipEsclusiClick(Sender: TObject);
var msg: String;
    i: Integer;
begin
  for i:=0 to LstDipEsclusi.Count-1 do
    msg:=msg+LstDipEsclusi[i]+#13#10;
  MsgBox.WebMessageDlg(msg,mtInformation,[mbOk],nil,'','Dipendenti esclusi dalla selezione');
end;

procedure TWA087FImpAttestatiMal.ResultCausaleMal(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    btnEseguiClick(Sender)
  else
    MsgBox.ClearKeys;
end;

procedure TWA087FImpAttestatiMal.RecuperaFile;
var
  nFile: String;
  nNuovoUpload:Boolean;
begin
  { DONE : TEST IW 14 OK }
  nNuovoUpload:=True;
  if not fileUpload.IsPresenteFileUploadato then
    if PathFileUploaded = '' then
      raise Exception.Create(A000MSG_ERR_FILE_INESISTENTE)
    else
      nNuovoUpload:=False;

  if nNuovoUpload then
  begin
    nFile:=fileUpload.NomeFile;
    try
      // path e nome per il salvataggio su file system
      PathFileUploaded:=GGetWebApplicationThreadVar.UserCacheDir + nFile;
      // se esiste già un file con lo stesso nome lo cancella
      if FileExists(PathFileUploaded) then
        DeleteFile(PathFileUploaded);
      fileUpload.SalvaSuFile(PathFileUploaded);
      fileUpload.Ripristina;
    except
      raise Exception.Create(Format(A000MSG_ERR_FMT_ERRORE,['upload fallito']));
    end;
  end;
end;

procedure TWA087FImpAttestatiMal.btnEseguiClick(Sender: TObject);
var
  i:integer;
begin
  if Not A087MW.TestFiltroProfili then
    raise Exception.Create(Format(A000MSG_A087_ERR_FMT_FILTROPROFILI,['IrisCloud']));

  RecuperaFile;
  //Serve per committare i dati sulla tabella T001
  SessioneOracle.Commit;
  Self.Enabled:=False;
  ColoraGriglia:=True;
  //Resetto contatori dei totali
  A087MW.TotCodFiscEsclusi:=0;
  A087MW.TotElaborazioniOK:=0;
  A087MW.TotElaborazioniErr:=0;
  //Gestione Progress Bar
  StartElaborazioneCiclo(btnEsegui.HTMLName);
end;

procedure TWA087FImpAttestatiMal.btnRefreshCertificatiClick(Sender: TObject);
begin
  RecuperaFile;
  if FileExists(PathFileUploaded) then
    A087MW.LeggiFileXML(False)
  else
  begin
    A087MW.CDtsTemp.EmptyDataSet;
    MsgBox.WebMessageDlg(A000MSG_ERR_FILE_INESISTENTE,mtInformation,[mbOk],nil,'');
  end;
  if grdPreview.medpDataSet = nil then
    grdPreview.medpAttivaGrid(A087MW.CDtsTemp,False,False);
  grdPreview.medpAggiornaCDS(True);
end;

procedure TWA087FImpAttestatiMal.btnUploadClick(Sender: TObject);
begin
  ColoraGriglia:=False;
  RecuperaFile;
  AbilitaAzioni;
  if FileExists(PathFileUploaded) then
    A087MW.LeggiFileXML(False)
  else
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_FILE_INESISTENTE,mtInformation,[mbOk],nil,'');
    Abort;
  end;
  FiltroDipendenti;
  if grdPreview.medpDataSet = nil then
    grdPreview.medpAttivaGrid(A087MW.CDtsTemp,False,False);
  grdPreview.medpAggiornaCDS(True);
end;

procedure TWA087FImpAttestatiMal.AbilitaAzioni;
begin
  btnVisualizzaFile.Enabled:=True;
  btnEsegui.Enabled:=chkAnomalie.Checked or chkInserimento.Checked;
end;

procedure TWA087FImpAttestatiMal.btnVisualizzaFileClick(Sender: TObject);
begin
  RecuperaFile;
  if FileExists(PathFileUploaded) then
    GGetWebApplicationThreadVar.SendFile(PathFileUploaded,true,'application/x-download',ExtractFileName(PathFileUploaded))
  else
    MsgBox.WebMessageDlg(A000MSG_ERR_FILE_INESISTENTE,mtInformation,[mbOk],nil,'');
end;

function TWA087FImpAttestatiMal.GetPathFile: String;
begin
  Result:=PathFileUploaded;
end;

procedure TWA087FImpAttestatiMal.grdPreviewRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  ClrCella:TColor;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
  if (ARow < 1) or (Not ColoraGriglia) then
    Exit;
  A087MW.CDtsTemp.First;
  A087MW.CDtsTemp.Locate('idcertificato_attestato',grdPreview.medpValoreColonna(ARow - 1,'IDCERTIFICATO_ATTESTATO'),[]);
  ClrCella:=A087MW.ColoraCella;
  if ClrCella = clRed then
    ACell.Css:='bg_rosso fontWhite'
  else if ClrCella = clWebDarkOrange then
    ACell.Css:='bg_arancio fontWhite'
  else if ClrCella = clGray then
    ACell.Css:='bg_grigio fontWhite';
end;

procedure TWA087FImpAttestatiMal.grdProfiliAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var r : Integer;
    img : TmeIWImageFile;
begin
  inherited;
  for r :=0 to High(grdProfili.medpCompGriglia) do
    if grdProfili.medpCompCella(r,grdProfili.medpIndexColonna('DBG_COMANDI'),0) <> nil then
    begin
      img:=(grdProfili.medpCompCella(r,grdProfili.medpIndexColonna('DBG_COMANDI'),0) as TmeIWImageFile);
      img.Enabled:=true;
      img.OnClick:=imgAccediClick;
    end;
end;

procedure TWA087FImpAttestatiMal.imgAccediClick(Sender: TObject);
var r: Integer;
    Params: String;
begin
  r:=grdProfili.medpRigaDiCompGriglia((Sender as TmeIWImageFile).FriendlyName);
  Params:='CODICE=' + grdProfili.medpValoreColonna(r, 'CODICE');
  AccediForm(72,Params);
end;

procedure TWA087FImpAttestatiMal.grdProfiliRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var NumColonna: Integer;
begin
  inherited;
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
  NumColonna:=grdProfili.medpNumColonna(AColumn);
  // assegnazione componenti
  if (ARow > 0) and (ARow <= High(grdProfili.medpCompGriglia) + 1) and (grdProfili.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdProfili.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWA087FImpAttestatiMal.C700FiltraCertificati(Sender: TObject);
begin
  grdC700.WC700FM.actConfermaExecute(grdC700.WC700FM.actConferma);
  FiltroDipendenti;
end;

procedure TWA087FImpAttestatiMal.ResultVisFiltrati(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    btnDipEsclusiClick(Self);
end;

procedure TWA087FImpAttestatiMal.FiltroDipendenti;
var
  StrOut:String;
begin
  LstDipEsclusi.Clear;
  btnDipEsclusi.Enabled:=False;
  if A087MW.CDtsTemp.Active then
  begin
    A087MW.CDtsTemp.Filtered:=False;
    if grdC700.selAnagrafe.RecordCount > 0 then
    begin
      //Carico dipendenti esclusi
      A087MW.DipInclusi:=False;
      A087MW.CDtsTemp.Filtered:=True;
      btnDipEsclusi.Enabled:=A087MW.CDtsTemp.RecordCount > 0;
      A087MW.CDtsTemp.First;
      StrOut:='';
      while Not A087MW.CDtsTemp.Eof do
      begin
        StrOut:=A087MW.CDtsTemp.FieldByName('cognome_lavoratore').AsString + ' ' +
                A087MW.CDtsTemp.FieldByName('nome_lavoratore').AsString + ' ' +
                A087MW.CDtsTemp.FieldByName('codicefiscale_lavoratore').AsString;
        LstDipEsclusi.Add(StrOut);
        A087MW.CDtsTemp.Next;
      end;
      //-------------------------
      //Assegno contatore dipendenti esclusi
      A087MW.TotEsclusiSelAnag:=LstDipEsclusi.Count;
      //-------------------------
      A087MW.CDtsTemp.Filtered:=False;
      A087MW.DipInclusi:=True;
      A087MW.CDtsTemp.Filtered:=True;
    end;
    //Bruno 29/03/2016
    //if grdPreview.medpDataSet = nil then
    grdPreview.medpAttivaGrid(A087MW.CDtsTemp,False,False);
    //grdPreview.medpAggiornaCDS(True);

    if btnDipEsclusi.Enabled then
      MsgBox.WebMessageDlg(A000MSG_A087_DLG_DIP_ESCLUSI,mtConfirmation,[mbYes,mbNo],ResultVisFiltrati,'');
  end;
end;

function TWA087FImpAttestatiMal.IsAnomalieChecked: Boolean;
begin
  Result:=chkAnomalie.Checked;
end;

function TWA087FImpAttestatiMal.IsInserimentoChecked: Boolean;
begin
  Result:=chkInserimento.Checked;
end;

function TWA087FImpAttestatiMal.IsValidChkEsenzione: Boolean;
begin
  Result:=chkEsenzione.Enabled and chkEsenzione.Checked;
end;

procedure TWA087FImpAttestatiMal.chkAnomalieAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  if (Sender = chkInserimento) then
    if chkInserimento.Checked then
    begin
      chkAnomalie.Checked:=True;
      chkAnomalie.Enabled:=False;
    end
    else
      chkAnomalie.Enabled:=True;
  btnEsegui.Enabled:=chkAnomalie.Checked or chkInserimento.Checked;
end;

function TWA087FImpAttestatiMal.CurrentRecordElaborazione: Integer;
begin
  Result:=CurrDip;
end;

procedure TWA087FImpAttestatiMal.ElaboraElemento;
begin
  inherited;
  A087MW.ElaboraDipendente(CurrDip);
end;

function TWA087FImpAttestatiMal.ElaborazioneTerminata: String;
var i: Integer;
begin
  Result:=inherited;
  if A087MW.CDtsTemp.Active then
  begin
    A087MW.CDtsTemp.First;
    A087MW.CDtsTemp.EnableControls;
    //Elaborazione finale in caso SOLO verifica anomalia
    if not chkInserimento.Checked then
    begin
      SessioneOracle.Rollback;
      for i:=low(A087MW.VetAttestato) to High(A087MW.VetAttestato) do
      begin
        A087MW.delT048.SetVariable('ID',A087MW.VetAttestato[i].ID_Certificato);
        A087MW.delT048.SetVariable('TIPO',A087MW.VetAttestato[i].Tipo_Elemento);
        A087MW.delT048.Execute;
      end;
      if High(A087MW.VetAttestato) >= 0 then
        SessioneOracle.Commit;
    end;
  end;
  Self.Enabled:=True;
  if chkInserimento.Checked then
  begin
    if A087MW.BloccoAnomalia then
      Result:=A000MSG_A087_MSG_ANOMALIE_BLOCCANTI
    else if (Not A087MW.BloccoAnomalia) and (RegistraMsg.ContieneTipoA) then
      Result:=A000MSG_A087_MSG_ANOMALIE_NON_BLOCCANTI
    else if Not A087MW.BloccoAnomalia then
      Result:=A000MSG_A087_MSG_IMPORT_TERMINATA;
  end
  else
  begin
    if A087MW.BloccoAnomalia then
      Result:=A000MSG_A087_ERR_ANOMALIE_BLOCCANTI
    else if (Not A087MW.BloccoAnomalia) and (RegistraMsg.ContieneTipoA) then
      Result:=A000MSG_A087_ERR_ANOMALIE_NON_BLOCCANTI
    else
      Result:=A000MSG_A087_MSG_NO_ANOMALIE
  end;
  btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA or A087MW.BloccoAnomalia;
  if grdPreview.medpDataSet = nil then
    grdPreview.medpAttivaGrid(A087MW.CDtsTemp,False,False);
  grdPreview.medpAggiornaCDS(True);
end;

function TWA087FImpAttestatiMal.ElementoSuccessivo: Boolean;
begin
  Result:=False;
  if (CurrDip >= Low(A087MW.VetAttestato)) and (CurrDip < High(A087MW.VetAttestato))  then
  begin
    CurrDip:=CurrDip+1;
    Result:=True;
  end;
end;

procedure TWA087FImpAttestatiMal.FineCicloElaborazione;
begin
  inherited;
  A087MW.CDtsTemp.EnableControls;
  RegistraMsg.InserisciMessaggio('I',A087MW.ReportContatori,Parametri.Azienda);
end;

function TWA087FImpAttestatiMal.TotalRecordsElaborazione: Integer;
begin
  Result:=Length(A087MW.VetAttestato);
end;

procedure TWA087FImpAttestatiMal.InizioElaborazione;
begin
  inherited;
  A087MW.BloccoAnomalia:=False;
  A087MW.CDtsTemp.DisableControls;
  //Lettura file XML e creazione DATASET temporaneo dati
  A087MW.LeggiFileXML(True);
  //Inserimento su tabella Oracle T048
  if Not A087MW.BloccoAnomalia then
    A087MW.InsDipT048;
  A087MW.InizializzaR600;
  CurrDip:=Low(A087MW.VetAttestato);
end;

end.
