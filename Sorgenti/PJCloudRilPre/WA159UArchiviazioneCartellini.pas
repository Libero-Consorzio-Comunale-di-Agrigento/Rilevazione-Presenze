unit WA159UArchiviazioneCartellini;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR100UBase, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton,
  meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, meIWLink, IWCompLabel, meIWLabel, IWAdvCheckGroup,
  meTIWAdvCheckGroup, IWDBGrids, medpIWDBGrid, meIWRadioGroup,
  medpIWMultiColumnComboBox, IWCompCheckbox, meIWCheckBox, IWCompEdit, meIWEdit,
  A159UArchiviazioneCartelliniMW, R500Lin, medpIWMessageDlg, C180FunzioniGenerali,
  C190FunzioniGeneraliWeb, meIWImageFile, medpIWImageButton,
  A000UInterfaccia, IWCompProgressBar, meIWProgressBar, IOUtils, StrUtils,
  Vcl.Menus, A000UMessaggi, ActiveX;

type
  TWA159FArchiviazioneCartellini = class(TWR100FBase)
    lblPathPDF: TmeIWLabel;
    lblFilePDF: TmeIWLabel;
    edtFilePDF: TmeIWEdit;
    chkSovrascrivi: TmeIWCheckBox;
    cmbParametrizzazione: TMedpIWMultiColumnComboBox;
    lblPeriodoAl: TmeIWLabel;
    lblPeriodoDal: TmeIWLabel;
    edtPeriodoDal: TmeIWEdit;
    edtPeriodoAl: TmeIWEdit;
    rgpGenerazionePDF: TmeIWRadioGroup;
    lblAnomalie: TmeIWLabel;
    lstAnomalie: TmeTIWAdvCheckGroup;
    lblParametrizzazione: TmeIWLabel;
    edtPathPDF: TmeIWEdit;
    btnStart: TmedpIWImageButton;
    btnLeggiLog: TmedpIWImageButton;
    lblGenerazionePDF: TmeIWLabel;
    lblPeriodo: TmeIWLabel;
    chkAggSchedaRiep: TmeIWCheckBox;
    pmnAnomalie: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    chkParametrizzazioniTipoCartellino: TmeIWCheckBox;
    btnImpostazioniAziendali: TmeIWButton;
    chkInviaRegistro: TmeIWCheckBox;
    cmbElencoRegistri: TMedpIWMultiColumnComboBox;
    lblElencoRegistri: TmeIWLabel;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnLeggiLogClick(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Annullatutto1Click(Sender: TObject);
    procedure btnImpostazioniAziendaliClick(Sender: TObject);
    procedure chkInviaRegistroAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    { Private declarations }
    A159MW:TA159FArchiviazioneCartelliniMW;
    procedure AbilitaComponenti(Stato:boolean);
    procedure CtrlEseguiOperazione;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ResultInizioElaborazione(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultInizioElaborazioneVersionePresente(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultInizioElaborazioneFilePresente(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultInviaRegistro(Sender: TObject; R: TmeIWModalResult; KI: String);
  protected
    procedure ImpostazioniWC700; override;
    function TotalRecordsElaborazione:integer; override;
    function CurrentRecordElaborazione:integer; override;
    procedure InizioElaborazione; override;
    procedure ElaboraElemento; override;
    function ElementoSuccessivo:boolean; override;
    function ElaborazioneTerminata:String; override;
    procedure InviaRegistro;
  public
    { Public declarations }
    function InizializzaAccesso:Boolean; override;
  end;

implementation

uses
  WC700USelezioneAnagrafeFM, A000UCostanti;

{$R *.dfm}

function TWA159FArchiviazioneCartellini.InizializzaAccesso:Boolean;
var
  Progressivo: Integer;
begin
  edtPeriodoDal.Text:=GetParam('PERIODODAL');
  edtPeriodoAl.Text:=GetParam('PERIODOAL');
  if (edtPeriodoDal.Text = '') and (edtPeriodoAl.Text = '') then
  begin
    edtPeriodoDal.Text:=DateToStr(R180InizioMese(Parametri.DataLavoro));
    edtPeriodoAl.Text:=DateToStr(R180FineMese(Parametri.DataLavoro));
  end;
  Progressivo:=StrToIntDef(GetParam('PROGRESSIVO'),0);
  if Progressivo > 0 then
  begin
    grdC700.WC700FM.C700Progressivo:=Progressivo;
    grdC700.WC700FM.actConfermaExecute(nil);
  end;
  Result:=True;
end;

procedure TWA159FArchiviazioneCartellini.CtrlEseguiOperazione;
// procedura di gestione: controlla pianificazione ed esegue l'elaborazione
var
  dal, al: TDateTime;
  numFile: Integer;
begin
  {if chkInviaRegistro.Checked and (Trim(cmbElencoRegistri.Text) <> '') then
  begin
    MsgBox.WebMessageDlg(A000MSG_A159_DLG_INVIA_REGISTRO, mtConfirmation, [mbYes, mbNo], ResultInviaRegistro, '');
    Exit;
  end;}

  //controllo filtri periodo
  if (TryStrToDate(edtPeriodoDal.Text, dal)) and (TryStrToDate(edtPeriodoAl.Text, al)) then
  begin
    if dal > al then
    begin
      raise Exception.Create('Le date di inizio e di fine sono invertite');
    end;
  end
  else
  begin
    if (TryStrToDate(edtPeriodoDal.Text, dal)) then
    begin
      ShowMessage('Solamente la data di inizio è corretta');
      edtPeriodoAl.Text:='''  /  /    ';
    end
    else
    begin
      if (TryStrToDate(edtPeriodoAl.Text, al)) then
      begin
        ShowMessage('Solamente la data di fine è corretta');
        edtPeriodoDal.Text:='''  /  /    ';
      end
      else
      begin
        raise Exception.Create('Nessuna delle due date è corretta');
      end;
    end;
  end;
  if grdC700.selAnagrafe.RecordCount = 0 then
  begin
    raise Exception.Create('Nessun anagrafico selezionato');
  end;
//  if not TDirectory.Exists(edtPathPdf.Text) then
//  begin
//    raise Exception.Create(Format('Il percorso cartellini "%s" non esiste.',[edtPathPdf.Text]));
//  end;
  //modifica del periodo su C700
  grdC700.WC700FM.C700SettaPeriodoSelAnagrafe(Dal,Al);
  //inizializzazione variabili pubbliche MW
  A159MW.LParAziendali.PathPdf:=edtPathPdf.Text;
  A159MW.LParAziendali.FilePdf:=edtFilePdf.Text;
  A159MW.PeriodoDal:=Dal;
  A159MW.PeriodoAl:=Al;
  A159MW.AggiornamentoSchedaRiep:=chkAggSchedaRiep.Checked;
  A159MW.TipoCartellino:=chkParametrizzazioniTipoCartellino.Checked;
  A159MW.SingoloMese:=rgpGenerazionePDF.Items[rgpGenerazionePDF.ItemIndex] = 'File mensile';
  A159MW.Parametrizzazione:=cmbParametrizzazione.Text;
  A159MW.Anomalie:=C190GetCheckList(LUNG_COD_ANOM, lstanomalie);
  A159MW.Sovrascrivi:=chkSovrascrivi.Checked;

  numFile:=0;
  if A159MW.Sovrascrivi or A159MW.Versionabile then
    numFile:=A159MW.VerificaFileEsistenti;

  if A159MW.SalvaSuDocumentale and A159MW.Versionabile and (numFile > 0) then
    MsgBox.WebMessageDlg(Format(A000MSG_A159_DLG_FMT_NUOVA_VERSIONE, [numFile.ToString, IfThen(numFile = 1, 'o', 'i')]), mtConfirmation, [mbYes, mbNo, mbCancel], ResultInizioElaborazioneVersionePresente, '')
  else if A159MW.Sovrascrivi and (numFile > 0) then
    MsgBox.WebMessageDlg(Format(A000MSG_A159_DLG_FMT_SOVRASCRIVI, [numFile.ToString, IfThen(numFile = 1, 'o', 'i')]), mtConfirmation, [mbYes, mbNo, mbCancel], ResultInizioElaborazioneFilePresente, '')
  else
    MsgBox.WebMessageDlg(Format(A000MSG_A159_DLG_FMT_CONFERMA_ELAB, [IntToStr(grdC700.selAnagrafe.RecordCount), IfThen(grdC700.selAnagrafe.RecordCount = 1, 'e', 'i')]), mtConfirmation, [mbYes, mbNo], ResultInizioElaborazione, '');
end;

procedure TWA159FArchiviazioneCartellini.Annullatutto1Click(Sender: TObject);
begin
  inherited;
  C190SelezionaCheckGroup((pmnAnomalie.PopupComponent as TmeTIWAdvCheckGroup),False);
end;

procedure TWA159FArchiviazioneCartellini.btnImpostazioniAziendaliClick(Sender: TObject);
begin
  inherited;
  edtPathPDF.Text:=A159MW.selI210.FieldByName('PATH_FILE').AsString;
  edtFilePDF.Text:=A159MW.selI210.FieldByName('FILE_PDF').AsString;
  chkSovrascrivi.Checked:=not A159MW.Versionabile and (A159MW.selI210.FieldByName('SOSTITUZIONE_FILE').AsString = 'S');
end;

procedure TWA159FArchiviazioneCartellini.btnLeggiLogClick(Sender: TObject);
var
  Params:string;
begin
  inherited;
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' + Parametri.Operatore + ParamDelimiter +
          'MASCHERA=A159' + ParamDelimiter +
          'ID=' + RegistraMsg.ID.ToString + ParamDelimiter +
          'TIPO=A';
  accediForm(201,Params,False);
end;

function TWA159FArchiviazioneCartellini.TotalRecordsElaborazione:Integer;
begin
  Result:=A159MW.TotalRecordsElaborazione;
end;

function TWA159FArchiviazioneCartellini.CurrentRecordElaborazione:integer;
begin
  Result:=A159MW.CurrentRecordElaborazione;
end;

procedure TWA159FArchiviazioneCartellini.InizioElaborazione;
begin
  inherited;
  AbilitaComponenti(False);
  A159MW.InizioElaborazione;
end;

procedure TWA159FArchiviazioneCartellini.ElaboraElemento;
begin
  A159MW.ElaboraElemento;
end;

function TWA159FArchiviazioneCartellini.ElaborazioneTerminata: String;
begin
  A159MW.FineCicloElaborazione;
  Result:=inherited ElaborazioneTerminata;
  AbilitaComponenti(True);
end;

function TWA159FArchiviazioneCartellini.ElementoSuccessivo:boolean;
begin
  Result:=A159MW.ElementoSuccessivo;
end;

procedure TWA159FArchiviazioneCartellini.ResultInviaRegistro(Sender: TObject;R: TmeIWModalResult; KI: String);
var temp: String;
begin
  if R = mrYes then
  begin
    if A159MW.selT960Registro.Locate('ID', cmbElencoRegistri.Items[cmbElencoRegistri.ItemIndex].RowData[3], []) then
    begin
      CoInitialize(nil);
      try
        InviaRegistro;   //invia il registro selezionato
      finally
        CoUninitialize;
        MsgBox.WebMessageDlg(ElaborazioneTerminata, mtInformation, [mbOk], nil, '');
      end;
    end
    else
      raise Exception.Create('Il registro selezionato non è stato trovato, impossibile preseguire con l''operazione');
  end;
end;

procedure TWA159FArchiviazioneCartellini.ResultInizioElaborazione(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    //generazione pdf
    StartElaborazioneCiclo(btnStart.HTMLName)
end;

procedure TWA159FArchiviazioneCartellini.ResultInizioElaborazioneVersionePresente(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrCancel then
    Exit;

  A159MW.CreaNuovaVersione:=R = mrYes;
  A159MW.Sovrascrivi:=False;

  StartElaborazioneCiclo(btnStart.HTMLName)
end;

procedure TWA159FArchiviazioneCartellini.ResultInizioElaborazioneFilePresente(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrCancel then
    Exit;

  A159MW.Sovrascrivi:=R = mrYes;
  A159MW.CreaNuovaVersione:=False;

  StartElaborazioneCiclo(btnStart.HTMLName)
end;

procedure TWA159FArchiviazioneCartellini.InviaRegistro;
begin
  A159MW.InviaRegistroSalvato;
end;

procedure TWA159FArchiviazioneCartellini.AbilitaComponenti(Stato:Boolean);
begin
  btnStart.Enabled:=Stato;
  btnLeggiLog.Enabled:=Stato;
  lstAnomalie.Enabled:=Stato;
  edtPeriodoDal.Enabled:=Stato;
  edtPeriodoAl.Enabled:=Stato;
  edtFilePDF.Enabled:=Stato;
  edtPathPDF.Enabled:=Stato;
  cmbParametrizzazione.Enabled:=Stato;
end;

procedure TWA159FArchiviazioneCartellini.btnStartClick(Sender: TObject);
begin
  inherited;

  if chkInviaRegistro.Checked and (Trim(cmbElencoRegistri.Text) <> '') then
  begin
    MsgBox.WebMessageDlg(A000MSG_A159_DLG_INVIA_REGISTRO, mtConfirmation, [mbYes, mbNo], ResultInviaRegistro, '');
    Exit;
  end;

  PutParametriFunzione;
  CtrlEseguiOperazione;
end;

procedure TWA159FArchiviazioneCartellini.chkInviaRegistroAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  cmbElencoRegistri.Text:='';
  cmbElencoRegistri.Enabled:=chkInviaRegistro.Checked;
  lblElencoRegistri.Enabled:=chkInviaRegistro.Checked;
end;

procedure TWA159FArchiviazioneCartellini.GetParametriFunzione;
var
  ParCartellino:string;
begin
  if R180In(Parametri.Operatore,['MONDOEDP','SYSMAN']) and (A159MW.selI210.FieldByName('PATH_FILE').AsString <> 'DB') then
  begin
    edtPathPDF.Text:=C004DM.GetParametro('PATH_PDF',A159MW.selI210.FieldByName('PATH_FILE').AsString);
    edtFilePDF.Text:=C004DM.GetParametro('FILE_PDF',A159MW.selI210.FieldByName('FILE_PDF').AsString);
    chkSovrascrivi.Checked:=C004DM.GetParametro('SOSTITUZIONE_FILE',A159MW.selI210.FieldByName('SOSTITUZIONE_FILE').AsString) = 'S';
  end
  else
  begin
    edtPathPDF.Text:=A159MW.selI210.FieldByName('PATH_FILE').AsString;
    edtFilePDF.Text:=A159MW.selI210.FieldByName('FILE_PDF').AsString;
    chkSovrascrivi.Checked:=A159MW.selI210.FieldByName('SOSTITUZIONE_FILE').AsString = 'S';
  end;

  edtPathPDF.Enabled:=edtPathPDF.Text <> 'DB';
  edtFilePDF.Enabled:=edtPathPDF.Enabled;
  btnImpostazioniAziendali.Enabled:=edtPathPDF.Enabled;

  chkAggSchedaRiep.Checked:=C004DM.GetParametro(UpperCase(chkAggSchedaRiep.Name),'N') = 'S';
  chkInviaRegistro.Checked:=C004DM.GetParametro(UpperCase(chkInviaRegistro.Name),'N') = 'S';
  C190PutCheckList(C004DM.GetParametro(UpperCase(lstAnomalie.Name),''), LUNG_COD_ANOM, lstAnomalie);
  ParCartellino:=C004DM.GetParametro(UpperCase(cmbParametrizzazione.Name),'');
  if not ParCartellino.IsEmpty then
  begin
    cmbParametrizzazione.Text:=ParCartellino;
  end;
end;

procedure TWA159FArchiviazioneCartellini.PutParametriFunzione;
begin
  try
    C004DM.Cancella001;
    if R180In(Parametri.Operatore,['MONDOEDP','SYSMAN']) then
    begin
      if Trim(edtPathPdf.Text) <> '' then
        C004DM.PutParametro('PATH_PDF',edtPathPdf.Text);
      if Trim(edtFilePdf.Text) <> '' then
        C004DM.PutParametro('FILE_PDF',edtFilePdf.Text);
      C004DM.PutParametro('SOSTITUZIONE_FILE',IfThen(chkSovrascrivi.Checked,'S','N'));
    end;
    C004DM.PutParametro(UpperCase(lstAnomalie.Name),C190GetCheckList(LUNG_COD_ANOM, lstAnomalie));
    C004DM.PutParametro(UpperCase(chkAggSchedaRiep.Name),IfThen(chkAggSchedaRiep.Checked,'S','N'));
    C004DM.PutParametro(UpperCase(cmbParametrizzazione.Name),cmbParametrizzazione.Text);
    C004DM.PutParametro(UpperCase(chkInviaRegistro.Name),IfThen(chkInviaRegistro.Checked,'S','N'));
    SessioneOracle.Commit;
  except
    SessioneOracle.Rollback;
  end;
end;

procedure TWA159FArchiviazioneCartellini.Selezionatutto1Click(Sender: TObject);
begin
  inherited;
  C190SelezionaCheckGroup((pmnAnomalie.PopupComponent as TmeTIWAdvCheckGroup),True);
end;

procedure TWA159FArchiviazioneCartellini.ImpostazioniWC700;
begin
  grdC700.WC700FM.C700DatiSelezionati:=C700CampiBase + ', T030.CODFISCALE';
  grdC700.WC700FM.C700SelezionePeriodica:=True;
end;

procedure TWA159FArchiviazioneCartellini.IWAppFormCreate(Sender: TObject);
var
  i:integer;
begin
  inherited;
  AttivaGestioneC700;
  A159MW:=TA159FArchiviazioneCartelliniMW.Create(nil);
  A159MW.SelAnagrafe:=grdC700.selAnagrafe;
  //Inizio - carico lista anomalie
  lstAnomalie.Items.Clear;
  for i:=low(tdescanom2) to High(tdescanom2) do
    lstAnomalie.Items.Add(R180DimLung('A2_' + IntToStr(tdescanom2[i].N),6) + ' ' + tdescanom2[i].D);
  for i:=low(tdescanom3) to High(tdescanom3) do
    lstAnomalie.Items.Add(R180DimLung('A3_' + IntToStr(tdescanom3[i].N),6) + ' ' + tdescanom3[i].D);
  //Fine - carico lista anomalie
  C190CaricaMepdMulticolumnComboBox(cmbParametrizzazione,A159MW.Q950Lista,'CODICE','DESCRIZIONE');
  GetParametriFunzione;

  C190CaricaMepdMulticolumnComboBox(cmbElencoRegistri, A159MW.selT960Registro, ['DATA_CREAZIONE','PERIODO_DAL','PERIODO_AL','ID']);

  chkInviaRegistro.Enabled:=A159MW.InviareRegistro;
  cmbElencoRegistri.Enabled:=chkInviaRegistro.Checked;
  lblElencoRegistri.Enabled:=chkInviaRegistro.Checked;

  chkSovrascrivi.Enabled:=not A159MW.Versionabile; //se la tipologia è versionabile, il chk sovrascrivi è ininfluente
  chkSovrascrivi.Checked:=not A159MW.Versionabile and chkSovrascrivi.Checked;

  if not R180In(Parametri.Operatore,['MONDOEDP','SYSMAN']) then
  begin
    edtPathPDF.Enabled:=False;
    edtFilePDF.Enabled:=False;
    btnImpostazioniAziendali.Enabled:=False;
    chkSovrascrivi.Enabled:=False;
    rgpGenerazionePDF.Enabled:=False;
    chkAggSchedaRiep.Enabled:=False;
  end;
end;

procedure TWA159FArchiviazioneCartellini.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  FreeAndNil(A159MW);
  inherited;
end;

end.
