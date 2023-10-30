unit WA112UInvioMessaggi;

interface

uses

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR100UBase, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton,
  meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, meIWLink, IWDBGrids, medpIWDBGrid, OracleData,
  meIWImageFile, medpIWImageButton, IWCompCheckbox, StrUtils,
  meIWCheckBox, meIWRadioGroup, IWCompEdit, meIWEdit, IWCompLabel, meIWLabel,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  medpIWTabControl, IWCompListbox, IWDBStdCtrls, meIWDBComboBox, medpIWC700NavigatorBar,
  A112UInvioMessaggiMW, A000UInterfaccia, meIWComboBox, C180FunzioniGenerali,
  A000UMessaggi, A000UCostanti, MedpIWMultiColumnComboBox, C190FunzioniGeneraliWeb,
  IWApplication, medpIWMessageDlg, WC010UMemoEditFM, WC700USelezioneAnagrafeFM,
  RegistrazioneLog;

type
  TWA112FInvioMessaggi = class(TWR100FBase)
    grdTabDetail: TmedpIWTabControl;
    WA112ParametriRG: TIWRegion;
    WA112RisultatiRG: TIWRegion;
    dGrdRisultati: TmedpIWDBGrid;
    TemplateParametriRG: TIWTemplateProcessorHTML;
    TemplateRisultatiRG: TIWTemplateProcessorHTML;
    lblDataMessaggio: TmeIWLabel;
    lblDataConsuntivo: TmeIWLabel;
    lblDataScadenza: TmeIWLabel;
    edtDataMessaggio: TmeIWEdit;
    edtDataConsuntivo: TmeIWEdit;
    edtDataScadenza: TmeIWEdit;
    lblNumeroRipetizioni: TmeIWLabel;
    edtNumeroRipetizioni: TmeIWEdit;
    lblOraMessaggio: TmeIWLabel;
    edtOraMessaggio: TmeIWEdit;
    lblNomeFile: TmeIWLabel;
    edtNomeFile: TmeIWEdit;
    rgpFileEsistente: TmeIWRadioGroup;
    lblFileEsistente: TmeIWLabel;
    lblMsgEsistente: TmeIWLabel;
    rgpMsgEsistente: TmeIWRadioGroup;
    dGrdParametri: TmedpIWDBGrid;
    imgAnomalie: TmedpIWImageButton;
    imgVisualizzaFile: TmedpIWImageButton;
    imgEsegui: TmedpIWImageButton;
    cmbParametri: TmeIWComboBox;
    chkVisualizzaBatch: TmeIWCheckBox;
    lnkParametri: TmeIWLink;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure grdTabDetailTabControlChange(Sender: TObject);
    procedure lnkParametriClick(Sender: TObject);
    procedure cmbParametriChange(Sender: TObject);
    procedure chkVisualizzaBatchClick(Sender: TObject);
    procedure dGrdParametriDataSet2Componenti(Row: Integer);
    procedure dGrdParametriComponenti2DataSet(Row: Integer);
    procedure dGrdParametriRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure dGrdRisultatiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure imgEseguiClick(Sender: TObject);
    procedure imgAnomalieClick(Sender: TObject);
    procedure imgVisualizzaFileClick(Sender: TObject);
  private
    { Private declarations }
    A112MW: TA112FInvioMessaggiMW;
    procedure ResultWC700(Sender: TObject; Result: Boolean);
    procedure CaricaComboParametri;
    procedure evtRichiesta(Msg,Chiave:String);
    procedure evtInforma(Msg:String);
    procedure ResultEvtRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure evtClearKeys;
  public
    { Public declarations }
  protected
    procedure ImpostazioniWC700; override;
    procedure InizializzaMsgElaborazione; override;
    procedure ElaborazioneServer; override;
  end;

implementation

{$R *.dfm}

procedure TWA112FInvioMessaggi.IWAppFormCreate(Sender: TObject);
begin
  A112MW:=TA112FInvioMessaggiMW.Create(Self);
  A112MW.Chiamante:='WA112';
  A112MW.evtRichiesta:=evtRichiesta;
  A112MW.evtInforma:=evtInforma;
  A112MW.evtClearKeys:=evtClearKeys;
  grdTabDetail.AggiungiTab('Parametri',WA112ParametriRG);
  grdTabDetail.AggiungiTab('Risultati',WA112RisultatiRG);
  grdTabDetail.HasFiller:=True;
  grdTabDetail.ActiveTab:=WA112ParametriRG;
  inherited;
  grdC700:=TmedpIWC700NavigatorBar.Create(Self);//Danilo: creato prima di AttivaGestioneC700 per impostare le altre proprietà non standard
  grdC700.ImpostaProgressivoCorrente:=False;
  grdC700.AttivaBrowse:=False;
  A112MW.selAnagrafe:=grdC700.selAnagrafe;
  AttivaGestioneC700;
  grdC700.WC700FM.ResultEvent:=ResultWC700;
  CaricaComboParametri;
  edtDataMessaggio.Text:=DateToStr(Now);
  edtOraMessaggio.Text:=FormatDateTime('hh.nn',Now);

  CmbParametri.ItemIndex:=R180IndexOf(CmbParametri.Items,C004DM.GetParametro('PARAMETRI',''),5);
  if CmbParametri.ItemIndex = -1 then
    CmbParametri.ItemIndex:=0;
  cmbParametriChange(cmbParametri);
  chkVisualizzaBatch.Checked:=C004DM.GetParametro('VIS_BATCH','N') = 'S';
  chkVisualizzaBatchClick(chkVisualizzaBatch);
  dGrdParametri.medpAttivaGrid(A112MW.selC292,True,False,False);
  dGrdParametri.medpPreparaComponenteGenerico('WR102',dGrdParametri.medpIndexColonna('VALORE_DEFAULT'),0,DBG_MECMB,'20','1','','','S');
  dGrdParametri.medpPreparaComponenteGenerico('WR102',dGrdParametri.medpIndexColonna('CODICE_DATO'),0,DBG_MECMB,'20','1','','','S');
end;

procedure TWA112FInvioMessaggi.IWAppFormDestroy(Sender: TObject);
begin
  C004DM.Cancella001;
  C004DM.PutParametro('PARAMETRI',VarToStr(Trim(Copy(CmbParametri.Text,1,5))));
  C004DM.PutParametro('VIS_BATCH',IfThen(chkVisualizzaBatch.Checked,'S','N'));
  try SessioneOracle.Commit; except end;
  inherited;
end;

procedure TWA112FInvioMessaggi.ImpostazioniWC700;
begin
  inherited;
  with grdC700.WC700FM do
  begin
    C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
    C700DatiSelezionati:=C700CampiBase + ',T430TERMINALI,T430PASSENZE';
    C700DataLavoro:=Parametri.DataLavoro;
  end;
end;

procedure TWA112FInvioMessaggi.ResultWC700(Sender: TObject; Result: Boolean);
begin
  if Result then
    grdTabDetailTabControlChange(nil);
end;

procedure TWA112FInvioMessaggi.grdTabDetailTabControlChange(Sender: TObject);
begin
  if (grdTabDetail.ActiveTab = WA112RisultatiRG) or A112MW.INIZ then
  begin
    A112MW.RefreshT295(StrToDateTime(edtDataMessaggio.Text));
    dGrdRisultati.medpAttivaGrid(A112MW.selT295,False,False,False);
    if dGrdRisultati.medpDataSet <> nil then
      dGrdRisultati.medpCaricaCDS;
  end;
end;

procedure TWA112FInvioMessaggi.lnkParametriClick(Sender: TObject);
begin
  inherited;
  AccediForm(165,'CODICE=' + Trim(Copy(cmbParametri.Text,1,5)))
end;

procedure TWA112FInvioMessaggi.CaricaComboParametri;
begin
  cmbParametri.Items.Clear;
  with A112MW.selT291 do
  begin
    First;
    while not Eof do
    begin
      cmbParametri.Items.Add(Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
  end;
end;

procedure TWA112FInvioMessaggi.cmbParametriChange(Sender: TObject);
begin
  imgAnomalie.Enabled:=False;
  with A112MW do
  begin
    selT291.SearchRecord('CODICE',Trim(Copy(cmbParametri.Text,1,5)),[srFromBeginning]);
    rgpMsgEsistente.Enabled:=selT291.FieldByName('REGISTRA_MSG').AsString = 'S';
    if selT291.FieldByName('NUM_MMIND_CONS').AsInteger = -1 then
    begin
      QSelect.Close;
      QSelect.Sql.Clear;
      QSelect.Sql.Add('SELECT MAX(DATA) DATACONS FROM T070_SCHEDARIEPIL');
      QSelect.Open;
      edtDataConsuntivo.Text:=FormatDateTime('mm/yyyy',QSelect.Fields[0].AsDateTime);
    end
    else
      edtDataConsuntivo.Text:=FormatDateTime('mm/yyyy',R180InizioMese(R180AddMesi(Date,-selT291.FieldByName('NUM_MMIND_CONS').AsInteger)));
    edtDataScadenza.Text:=DateToStr(Now + selT291.FieldByName('NUM_GGVAL_MSG').AsInteger);
    edtNumeroRipetizioni.Text:=selT291.FieldByName('NUM_RIPET_MSG').AsString;
    if selT291.FieldByName('TIPO_REGISTRAZIONE').AsString = 'R' then
      rgpFileEsistente.ItemIndex:=1
    else
      rgpFileEsistente.ItemIndex:=0;
    // costruzione nome file con data file
    edtNomeFile.Text:=R180NomeFileDatato(selT291.FieldByName('NOME_FILE').AsString,selT291.FieldByName('DATA_FILE').AsString,StrToDate(edtDataMessaggio.Text));
    // costruzione filtro anagrafiche
    if selT291.FieldByName('FILTRO_ANAGR').AsString <> '' then
    begin
      grdC700.actSelezioneAnagraficheExecute(Sender);
      grdC700.WC700FM.ApriSelezione(selT291.FieldByName('FILTRO_ANAGR').AsString);
      grdC700.WC700FM.actConfermaExecute(nil);
    end;
    selT292.Close;
    selT292.SetVariable('CODICE_PARM',selT291.FieldByName('CODICE').AsString);
    selT292.Open;
    CaricaTabellaTemp(C004DM.GetParametro('PARAMETRI',''));
    if dGrdParametri.medpDataSet <> nil then
      dGrdParametri.medpCaricaCDS;
  end;
end;

procedure TWA112FInvioMessaggi.chkVisualizzaBatchClick(Sender: TObject);
var Codice:String;
begin
  with A112MW.selT291 do
  begin
    Codice:=FieldByName('CODICE').AsString;
    Filter:=IfThen(chkVisualizzaBatch.Checked,'','DEFAULT_FILE=''N''');
    Filtered:=not chkVisualizzaBatch.Checked;
    CaricaComboParametri;
    if not SearchRecord('CODICE',Codice,[srFromBeginning]) then
      First;
    cmbParametri.ItemIndex:=R180IndexOf(CmbParametri.Items,FieldByName('CODICE').AsString,5);
    cmbParametriChange(cmbParametri);
  end;
end;

procedure TWA112FInvioMessaggi.dGrdParametriDataSet2Componenti(Row: Integer);
var x:Integer;
begin
  inherited;
  if dGrdParametri.medpValoreColonna(Row,'TIPO') = 'VL' then
  begin
    if dGrdParametri.medpCompCella(Row,dGrdParametri.medpIndexColonna('VALORE_DEFAULT'),0) <> nil then
      with (dGrdParametri.medpCompCella(Row,dGrdParametri.medpIndexColonna('VALORE_DEFAULT'),0) as TmedpIWMultiColumnComboBox) do
      begin
        Items.Clear;
        for x:=0 to A112MW.PLDefaultVal.Count - 1 do
          AddRow(A112MW.PLDefaultVal[x]);
        PopupHeight:=10;
      end;
    if dGrdParametri.medpCompCella(Row,dGrdParametri.medpIndexColonna('CODICE_DATO'),0) <> nil then
      with (dGrdParametri.medpCompCella(Row,dGrdParametri.medpIndexColonna('CODICE_DATO'),0) as TmedpIWMultiColumnComboBox) do
      begin
        Items.Clear;
        for x:=0 to A112MW.PLCodDato.Count - 1 do
          AddRow(A112MW.PLCodDato[x]);
        PopupHeight:=10;
      end;
  end;
end;

procedure TWA112FInvioMessaggi.dGrdParametriComponenti2DataSet(Row: Integer);
begin
  inherited;
  dGrdParametri.medpDataSet.FieldByName('VALORE_DEFAULT').AsString:=(dGrdParametri.medpCompCella(Row,dGrdParametri.medpIndexColonna('VALORE_DEFAULT'),0) as TMedpIWMultiColumnComboBox).Text;
  dGrdParametri.medpDataSet.FieldByName('CODICE_DATO').AsString:=(dGrdParametri.medpCompCella(Row,dGrdParametri.medpIndexColonna('CODICE_DATO'),0) as TMedpIWMultiColumnComboBox).Text;
end;

procedure TWA112FInvioMessaggi.dGrdParametriRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  inherited;
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=dGrdParametri.medpNumColonna(AColumn);

  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(dGrdParametri.medpCompGriglia) + 1) and (dGrdParametri.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=dGrdParametri.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWA112FInvioMessaggi.dGrdRisultatiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  inherited;
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
end;

procedure TWA112FInvioMessaggi.imgEseguiClick(Sender: TObject);
begin
  with A112MW do
  begin
    DHMess:=StrToDateTime(edtDataMessaggio.Text + edtOraMessaggio.Text);
    DMess:=StrToDateTime(edtDataMessaggio.Text);
    HMess:=StrToDateTime(edtOraMessaggio.Text);;
    DCons:=StrToDateTime('01/' + edtDataConsuntivo.Text);
    DScad:=StrToDateTime(edtDataScadenza.Text);
    NRip:=edtNumeroRipetizioni.Text;
    Param:=Copy(cmbParametri.Text,1,5) + ' - ' + Copy(cmbParametri.Text,7);
    NomeFileParam:=edtNomeFile.Text;
    iFileEsistente:=rgpFileEsistente.ItemIndex;
    MantieniMsg:=rgpMsgEsistente.ItemIndex = 0;
    PreparaInviaMessaggi;
  end;
  StartElaborazioneServer(imgEsegui.HTMLName);
end;

procedure TWA112FInvioMessaggi.InizializzaMsgElaborazione;
begin
  with WC022FMsgElaborazioneFM do
  begin
    Messaggio:=A000MSG_MSG_ELABORAZIONE_IN_CORSO;
    Titolo:=A000MSG_MSG_ELABORAZIONE;
    ImgFileName:=IMG_FILENAME_ELABORAZIONE;
  end;
end;

procedure TWA112FInvioMessaggi.ElaborazioneServer;
begin
  A112MW.InviaMessaggi;
end;

procedure TWA112FInvioMessaggi.imgVisualizzaFileClick(Sender: TObject);
var
  WC010FMemoEditFM: TWC010FMemoEditFM;
begin
  inherited;
  if A112MW.selT291.FieldByName('TIPO_FILE').AsString = 'O' then
  begin
    WC010FMemoEditFM:=TWC010FMemoEditFM.Create(Self.Parent);
    with A112MW do
    begin
      WC010FMemoEditFM.memValore.Lines.Clear;
      WC010FMemoEditFM.memValore.Lines.Assign(A112MW.LeggiMessaggiDaTabella(EdtNomeFile.Text));
      WC010FMemoEditFM.Width:=600;
      WC010FMemoEditFM.Height:=350;
      WC010FMemoEditFM.Visualizza('(WA112) File di Invio Messaggi');
    end;
  end
  else
  begin
    if FileExists(edtNomeFile.Text) then
      GGetWebApplicationThreadVar.SendFile(edtNomeFile.Text,true,'application/x-download','(WA112) File di Invio Messaggi'+'.txt')
    else
      MsgBox.WebMessageDlg(A000MSG_ERR_FILE_INESISTENTE,mtError,[mbOk],nil,'');
  end;
end;

procedure TWA112FInvioMessaggi.imgAnomalieClick(Sender: TObject);
var Params: String;
begin
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' +Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + medpCodiceForm + ParamDelimiter +
          'ID=' + IntToStr((A000SessioneIrisWIN.RegistraMsg as TRegistraMsg).ID) + ParamDelimiter +
          'TIPO=A,B,I';
  accediForm(201,Params,True);
end;

procedure TWA112FInvioMessaggi.evtRichiesta(Msg,Chiave:String);
begin
  if not MsgBox.KeyExists(Chiave) then
  begin
    MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultEvtRichiesta,Chiave);
    Abort;
  end;
end;

procedure TWA112FInvioMessaggi.ResultEvtRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    if KI = 'EsisteMessaggio' then
      A112MW.sSkippa:='N';
    imgEseguiClick(nil)
  end
  else
    A112MW.PulisciVariabili;
end;

procedure TWA112FInvioMessaggi.evtInforma(Msg:String);
begin
  imgAnomalie.Enabled:=True;
  //Il messaggio di elaborazione terminata è gestito automaticamente nel WC022
end;

procedure TWA112FInvioMessaggi.evtClearKeys;
begin
  MsgBox.ClearKeys;
end;

end.
