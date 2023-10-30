unit WA027UCarMen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR100UBase, ActnList, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, medpIWStatusBar, meIWGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,
  IWCompCheckbox, meIWCheckBox, IWCompEdit, meIWEdit, IWCompLabel, meIWLabel,
  IWDBStdCtrls, meIWDBLabel,
  A000UInterfaccia, WA027UCarMenDM, C180FunzioniGenerali,
  A000UCostanti, A000USessione, OracleData, IWCompExtCtrls, IWCompGrids, A000UMessaggi,
  medpIWMessageDlg, IWCompProgressBar, meIWProgressBar, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompButton, meIWButton,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  meIWRegion, medpIWImageButton, meIWImageFile,StrUtils,
  medpIWMultiColumnComboBox, Data.DB, Datasnap.DBClient, Datasnap.Win.MConnect,
  System.JSON, C190FunzioniGeneraliWeb, WinAPI.ActiveX, WC020UInputDataOreFM;

type
  TWA027FCarMen = class(TWR100FBase)
    lblDa: TmeIWLabel;
    lblA: TmeIWLabel;
    edtDa: TmeIWEdit;
    edtA: TmeIWEdit;
    chkAutoGiustificazione: TmeIWCheckBox;
    chkIgnoraAnomalieStampa: TmeIWCheckBox;
    chkNumeraPagine: TmeIWCheckBox;
    edtNumeraPagine: TmeIWEdit;
    chkPaginaParita: TmeIWCheckBox;
    lblParametrizzazioneStampa: TmeIWLabel;
    lblParametrizzazione: TmeIWLabel;
    dlblDescrizione: TmeIWDBLabel;
    chkParametrizzazioniTipoCartellino: TmeIWCheckBox;
    lblOpzioniAggiornamento: TmeIWLabel;
    chkAggiornamentoSchedaRiepilogativa: TmeIWCheckBox;
    chkIgnoraAnomalieAggiornamento: TmeIWCheckBox;
    chkAggiornamentoBuoniPasto: TmeIWCheckBox;
    chkAggiornamentoAccessiMensa: TmeIWCheckBox;
    imbGeneraPDF: TmedpIWImageButton;
    imbSoloAggiornamento: TmedpIWImageButton;
    imbAnomalie: TmedpIWImageButton;
    cmbParametrizzazione: TMedpIWMultiColumnComboBox;
    imbBloccoRiepiloghi: TmedpIWImageButton;
    imbArchiviazioneCartellini: TmedpIWImageButton;
    chkInserimentoRiposi: TmeIWCheckBox;
    DCOMConnection: TDCOMConnection;
    btnHdnInviaFile: TmeIWButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure cmbParametrizzazioneAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure chkNumeraPagineAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure imbSoloAggiornamentoClick(Sender: TObject);
    procedure imbAnomalieClick(Sender: TObject);
    procedure chkAggiornamentoSchedaRiepilogativaAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure imbBloccoRiepiloghiClick(Sender: TObject);
    procedure edtAAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure edtDaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure imbArchiviazioneCartelliniClick(Sender: TObject);
    procedure btnHdnInviaFileClick(Sender: TObject);
  private
    CodiceT950:String;
    WA027FCarMenDM:TWA027FCarMenDM;
    //Variabili usate da elaborazione (Attenzione non si possono lanciare più elaborazioni contemporaneamente)
    DataI,DataF:TDateTime;
    A,M,G,A2,M2,G2:Word;
    iSQL:Integer;
    S,SQLText,Mat:String;
    URL_Stampa:String;
    lst:TStringList;
    CalCartRes,SenderName,SelectedSenderName:String;
    AbilBuoniPasto,AbilAccessiMensa,AbilInserimentoRiposi,ForzaPeriodo:Boolean;
    function InizializzaAccesso:Boolean; override;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ResultWC700(Sender: TObject; Result: Boolean);
    procedure AbilitaBloccoRiepiloghi;
    procedure EseguiStampaViaB028;
    function CreateJsonString:String;
    procedure DistruggiOggetti; override;
    procedure ResultWC020(Sender: TObject; Result: Boolean; Valore: String);
  protected
    procedure InizioElaborazione; override;
    procedure ElaboraElemento; override;
    function ElementoSuccessivo: Boolean; override;
    procedure FineCicloElaborazione; override;
    function ElaborazioneTerminata:String; override;
    procedure DistruzioneOggettiElaborazione(Errore:Boolean); override;
    function CurrentRecordElaborazione: Integer; override;
    function TotalRecordsElaborazione: Integer; override;
    procedure WC700AperturaSelezione(Sender: TObject); override;
  end;

implementation

uses IWApplication, IWGlobal, SyncObjs;

{$R *.dfm}

procedure TWA027FCarMen.IWAppFormCreate(Sender: TObject);
var Dal,Al:TDateTime;
begin
  inherited;
  imbBloccoRiepiloghi.Visible:=(A000GetInibizioni('Tag','59'(*funz. A126*)) = 'S');
  AttivaGestioneC700;
  grdC700.WC700FM.C700SelezionePeriodica:=True;
  grdC700.AttivaBrowse:=False;
  grdC700.WC700FM.ResultEvent:=ResultWC700;

  //CampiV430:='V430.T430BADGE,V430.T430INIZIO,V430.T430FINE';//'V430.*';
  WA027FCarMenDM:=TWA027FCarMenDM.Create(Self);
  chkAggiornamentoSchedaRiepilogativa.Enabled:=A000GetInibizioni('Tag',IntToStr(Self.Tag)) = 'S';
  chkAutoGiustificazione.Enabled:=A000GetInibizioni('Tag',IntToStr(Self.Tag)) = 'S';
  imbSoloAggiornamento.Visible:=A000GetInibizioni('Tag',IntToStr(Self.Tag)) = 'S';
  AbilBuoniPasto:=A000GetInibizioni('Tag','36') = 'S';
  AbilAccessiMensa:=A000GetInibizioni('Tag','28') = 'S';
  //Alberto 04/04/2018: abilitazione inserimento riposi solo è definito un campo anagrafico per la regola. Se regola unica non si abilita per evitare sbagli da parte degli operatori.
  AbilInserimentoRiposi:=(A000GetInibizioni('Tag','17') = 'S') and (Parametri.CampiRiferimento.C16_INSRIPOSI <> '');
  ForzaPeriodo:=False;
  SelectedSenderName:='';
  Dal:=R180InizioMese(Parametri.DataLavoro);
  Al:=R180FineMese(Parametri.DataLavoro);
  edtDa.Text:=FormatDateTime('dd/mm/yyyy',Dal);
  edtA.Text:=FormatDateTime('dd/mm/yyyy',Al);
  cmbParametrizzazione.Items.Clear;
  with WA027FCarMenDM.Q950Lista do
  begin
    while not Eof do
    begin
      cmbParametrizzazione.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
    First; //Seleziono di default il primo
  end;
  dlblDescrizione.DataSource:=WA027FCarMenDM.dsrQ950Lista;
  cmbParametrizzazione.ItemIndex:=-1;
  imbAnomalie.Enabled:=False;
  imbArchiviazioneCartellini.Visible:=A000GetInibizioni('Tag','75') = 'S';
end;

function TWA027FCarMen.InizializzaAccesso: Boolean;
var
  Progressivo: Integer;
  sData: String;
  Data: TDateTime;
begin
  ChkAggiornamentoSchedaRiepilogativa.Enabled:=not SolaLettura;
  GetParametriFunzione;
  chkAggiornamentoSchedaRiepilogativaAsyncClick(nil,nil);

  sData:=getParam('DATA');
  if sData <> '' then
  begin
    Data:=StrToDate(sData);
    edtDa.Text:=FormatDateTime('dd/mm/yyyy',R180InizioMese(Data));
    edtA.Text:=FormatDateTime('dd/mm/yyyy',R180FineMese(Data));
  end;

  Progressivo:=StrToIntDef(GetParam('PROGRESSIVO'),0);
  if Progressivo > 0 then
  begin
    grdC700.WC700FM.C700Progressivo:=Progressivo;
    grdC700.WC700FM.actConfermaExecute(nil);
  end;

  Result:=True;
end;

procedure TWA027FCarMen.btnHdnInviaFileClick(Sender: TObject);
begin
  GGetWebApplicationThreadVar.SendFile(DCOMNomeFile,true,'application/x-download',ExtractFileName(DCOMNomeFile));
end;

procedure TWA027FCarMen.chkAggiornamentoSchedaRiepilogativaAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  imbSoloAggiornamento.Enabled:=chkAggiornamentoSchedaRiepilogativa.Checked;
  chkIgnoraAnomalieAggiornamento.Enabled:=chkAggiornamentoSchedaRiepilogativa.Checked;
  chkAggiornamentoBuoniPasto.Enabled:=chkAggiornamentoSchedaRiepilogativa.Checked and AbilBuoniPasto;
  chkAggiornamentoAccessiMensa.Enabled:=chkAggiornamentoSchedaRiepilogativa.Checked and AbilAccessiMensa;
  chkInserimentoRiposi.Enabled:=chkAggiornamentoSchedaRiepilogativa.Checked and AbilInserimentoRiposi;

  if not chkAggiornamentoSchedaRiepilogativa.Checked then
  begin
    chkAggiornamentoBuoniPasto.Checked:=False;
    chkAggiornamentoAccessiMensa.Checked:=False;
    chkInserimentoRiposi.Checked:=False;
  end;
  AbilitaBloccoRiepiloghi;
end;

procedure TWA027FCarMen.chkNumeraPagineAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  edtNumeraPagine.Enabled:=chkNumeraPagine.Checked;
end;

procedure TWA027FCarMen.cmbParametrizzazioneAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  WA027FCarMenDM.Q950Lista.SearchRecord('CODICE', Value, [srFromBeginning]);
end;

procedure TWA027FCarMen.imbAnomalieClick(Sender: TObject);
var
  Params: String;
begin
  if  (RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB) then
  begin
    Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' +Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + medpCodiceForm + ParamDelimiter +
          'ID=' + IntToStr(RegistraMsg.ID) + ParamDelimiter +
          'TIPO=A,B';

    accediForm(201,Params,True);
  end;

end;

procedure TWA027FCarMen.imbArchiviazioneCartelliniClick(Sender: TObject);
var
  PeriodoDal, PeriodoAl: TDateTime;
  Params: String;
begin
  inherited;
  Params:='PERIODODAL=' + edtDa.Text + ParamDelimiter + 'PERIODOAL=' + edtA.Text + ParamDelimiter + 'PROGRESSIVO=' + IntToStr(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  AccediForm(75, Params, True);
end;

procedure TWA027FCarMen.imbBloccoRiepiloghiClick(Sender: TObject);
var Params: String;
begin
  Params:='PROG=' + grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsString + ParamDelimiter +
        'CHIAMANTE=' + medpCodiceForm + ParamDelimiter +
        'DATADA=' + edtDa.Text + ParamDelimiter +
        'DATAA=' + edtA.Text;
  accediForm(59,Params,True);
end;

procedure TWA027FCarMen.imbSoloAggiornamentoClick(Sender: TObject);
var WC020FInputDataOreFM: TWC020FInputDataOreFM;
begin
  MessaggioStatus(INFORMA,'');
  if grdC700.SelAnagrafe.RecordCount = 0 then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_NO_DIP,mtError,[mbOk],nil,'');
    Exit;
  end;
  if (Sender = imbSoloAggiornamento) and (not chkAggiornamentoSchedaRiepilogativa.Checked) then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_AGGIORNAMENTO_NON_ABIL,mtError,[mbOk],nil,'');
    Exit;
  end;
  if not TryStrToDate(edtDa.Text,DataI) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,['inizio periodo']),mtError,[mbOk],nil,'');
    edtDa.SetFocus;
    Exit;
  end;
  if not TryStrToDate(edtA.Text,DataF) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,['fine periodo']),mtError,[mbOk],nil,'');
    edtA.SetFocus;
    Exit;
  end;
  if DataF < DataI then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_PERIODO_ERRATO,mtError,[mbOk],nil,'');
    exit;
  end;
  //Controllo obsoleto
  (*if R180Anno(DataI) <> R180Anno(DataF) then
  begin
    MsgBox.WebMessageDlg(A000MSG_A027_ERR_DATE_ANNO,mtError,[mbOk],nil,'');
    exit;
  end;*)
  if R180Anno(DataI) < R180Anno(DataF) - 19 then
  begin
    MsgBox.MessageBox(A000MSG_R003_MSG_PERIODO_MAGGIORE_20_ANNI,ERRORE);
    exit;
  end;

  if (Sender = imbGeneraPDF) and (cmbParametrizzazione.Text = '') then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_A027_MSG_PARAMETRIZZAZIONE]),mtError,[mbOk],nil,'');
    Exit;
  end;

  if (Sender = imbGeneraPDF) then
      SelectedSenderName:=imbGeneraPDF.HTMLName
  else if (Sender = imbSoloAggiornamento) then
      SelectedSenderName:=imbSoloAggiornamento.HTMLName;

  if (not ForzaPeriodo) and (DataF > R180FineMese(Now)) then
  begin
    WC020FInputDataOreFM:=TWC020FInputDataOreFM.Create(Self.Parent);
    WC020FInputDataOreFM.ImpostaCampiData(A000MSG_A027_ERR_CONFERMA_PERIODO,Now,'dd/mm/yyyy');
    WC020FInputDataOreFM.ResultEvent:=ResultWC020;
    WC020FInputDataOreFM.Visualizza(A000MSG_A027_ERR_CONFERMA_PERIODO_TITOLO);
    Exit;
  end
  else
    ForzaPeriodo:=False;

  if (Sender = imbGeneraPDF) and (Parametri.CampiRiferimento.C90_W009_WA027_UsaB028 = 'S') then
  begin
    // In questo caso effettuiamo la stampa del PDF via B028
    EseguiStampaViaB028;
  end
  else
  begin
    // Flusso standard.
    SenderName:=TmedpIWImageButton(Sender).HTMLName;
    //Visualizza progress bar e fa partire elaborazione
    StartElaborazioneCiclo(SenderName,True);
  end;
end;

procedure TWA027FCarMen.ResultWC020(Sender: TObject; Result: Boolean; Valore: String);
begin
  if Result then
  begin
    if edtA.Text = Valore then
    begin
      ForzaPeriodo:=True;
      if SelectedSenderName = imbGeneraPDF.HTMLName then
        imbSoloAggiornamentoClick(imbGeneraPDF)
      else if SelectedSenderName = imbSoloAggiornamento.HTMLName then
        imbSoloAggiornamentoClick(imbSoloAggiornamento);
    end
    else
    begin
      MsgBox.WebMessageDlg(A000MSG_A027_ERR_DATA_ERRATA,mtError,[mbOk],nil,'');
      Exit;
    end;
  end;
end;

procedure TWA027FCarMen.ResultWC700(Sender: TObject; Result: Boolean);
begin
  AbilitaBloccoRiepiloghi;
end;

procedure TWA027FCarMen.AbilitaBloccoRiepiloghi;
begin
  try
    imbBloccoRiepiloghi.Enabled:=(A000GetInibizioni('Tag','59'(*funz. A126*)) = 'S') and
                                 (StrToDate(edtDa.Text) < StrToDate(edtA.Text)) and
                                 (StrToDate(edtDa.Text) = R180InizioMese(StrToDate(edtDa.Text))) and
                                 (StrToDate(edtA.Text) = R180FineMese(StrToDate(edtA.Text))) and
                                 chkAggiornamentoSchedaRiepilogativa.Checked and
                                 (grdC700.SelAnagrafe.RecordCount > 0);
  except //Date impostate male...
    imbBloccoRiepiloghi.Enabled:=False;
  end;
end;

procedure TWA027FCarMen.GetParametriFunzione;
begin
  //Leggo i parametri di questa mappa
  with C004DM do
  begin
    cmbParametrizzazione.Text:=GetParametro('NOMESTAMPA','');
    cmbParametrizzazioneAsyncChange(nil,nil, -1, cmbParametrizzazione.Text);

    ChkNumeraPagine.Checked:=GetParametro('CK_NUMERO_PAGINA', 'N') = 'S';
    EdtNumeraPagine.Text:=GetParametro('NUMERO_PAGINA', '1');
    ChkPaginaParita.Checked:=GetParametro('PAGINAPARITA', 'N') = 'S';

    ChkAutoGiustificazione.Checked:=GetParametro('AUTOGIUSTIFICAZIONE', 'N') = 'S';
    ChkIgnoraAnomalieAggiornamento.Checked:=GetParametro('IGNORAANOMALIE', 'S') = 'S';
    ChkIgnoraAnomalieStampa.Checked:=GetParametro('IGNORAANOMALIESTAMPA', 'S') = 'S';
    ChkParametrizzazioniTipoCartellino.Checked:=GetParametro('PARAMTIPOCAR', 'S') = 'S';
  end;

  (*todo
  //Leggo i parametri della form di stampa
  sParametri.sFileTesto:=C004DM.GetParametro('FILETESTO', '');
  sParametri.sCarCon:=C004DM.GetParametro('CARRIGA', '');
  sParametri.sNumRighe:=C004DM.GetParametro('NUMRIGHE', '0');
  sParametri.sNumRigheHeader:=C004DM.GetParametro('NUMHEADER', '0');
  sParametri.sNumRigheFooter:=C004DM.GetParametro('NUMFOOTER', '0');
  sParametri.sSaltoPagina:=C004DM.GetParametro('SALTOPAGINA', '');
*)
end;
procedure TWA027FCarMen.PutParametriFunzione;
begin
  //Leggo i parametri di questa mappa
  with C004DM do
  begin
    Cancella001;
    PutParametro('NOMESTAMPA',cmbParametrizzazione.Text);
    PutParametro('CK_NUMERO_PAGINA', IfThen(ChkNumeraPagine.Checked,'S','N'));
    PutParametro('NUMERO_PAGINA', EdtNumeraPagine.Text);
    PutParametro('PAGINAPARITA', IfThen(ChkPaginaParita.Checked,'S','N'));
    PutParametro('AUTOGIUSTIFICAZIONE', IfThen(ChkAutoGiustificazione.Checked,'S','N'));
    PutParametro('IGNORAANOMALIE', IfThen(ChkIgnoraAnomalieAggiornamento.Checked,'S','N'));
    PutParametro('IGNORAANOMALIESTAMPA', IfThen(ChkIgnoraAnomalieStampa.Checked,'S','N'));
    PutParametro('PARAMTIPOCAR', IfThen(ChkParametrizzazioniTipoCartellino.Checked,'S','N'));
  end;
end;

procedure TWA027FCarMen.InizioElaborazione;
begin
  inherited;
  // annulla messaggio statusbar
  grdStatusBar.StatusBarComponent('MESSAGGIO').Value:='';

  S:='';
  Mat:='';
  URL_Stampa:='';
  SQLText:='';
  if SenderName = imbGeneraPDF.HTMLName then
    MessaggioFinaleProgressBar:=A000MSG_MSG_PDF_IN_CORSO;
  DataI:=StrToDate(edtDa.Text);
  DataF:=StrToDate(edtA.Text);

  WA027FCarMenDM.selAnagrafeW:=grdC700.selAnagrafe;
  WA027FCarMenDM.CartelliniChiusi:=Parametri.WEBCartelliniChiusi = 'S';
  WA027FCarMenDM.Stampa:=SenderName = imbGeneraPDF.HTMLName;
  WA027FCarMenDM.RegLog:=True;
  WA027FCarMenDM.RaveProjectFile:=gSC.ContentPath + 'report\' + RAVE_MODEL_CARTELLINO;
  WA027FCarMenDM.NomeFile:=GetNomeFile('pdf');
  WA027FCarMenDM.RaveOutputFileName:=WA027FCarMenDM.NomeFile;
  SQLText:=grdC700.selAnagrafe.SQL.Text;
  CodiceT950:=Trim(Copy(StringReplace(cmbParametrizzazione.Text,SPAZIO,' ',[rfReplaceAll]),1,5));
  DecodeDate(DataI,A,M,G);
  DecodeDate(DataF,A2,M2,G2);
  //Se le date differiscono di mese o di anno, allora i giorni vanno
  //da 1 all'ultimo del mese
  if (M <> M2) or (A <> A2) then
  begin
    G:=1;
    G2:=R180GiorniMese(DataF);
    DataI:=EncodeDate(A,M,G);
    DataF:=EncodeDate(A2,M2,G2);
    edtDa.Text:=DateToStr(DataI);
    edtA.Text:=DateToStr(DataF);
  end;
  WA027FCarMenDM.DataF:=DataF;
  try
    WA027FCarMenDM.CreazioneR400(Self);
  except
    on E: Exception do
    begin
      raise Exception.Create(A000MSG_ERR_GENERICO);
    end;
  end;
  if chkAggiornamentoBuoniPasto.Checked then
  begin
    try
      WA027FCarMenDM.CreazioneR350(chkIgnoraAnomalieAggiornamento.Checked);
    except
      on E: Exception do
      begin
        raise Exception.Create(A000MSG_ERR_GENERICO);
      end;
    end;
  end;
  if chkAggiornamentoAccessiMensa.Checked then
  begin
    try
      WA027FCarMenDM.CreazioneR300(DataI,DataF);
    except
      on E: Exception do
      begin
        raise Exception.Create(A000MSG_ERR_GENERICO);
      end;
    end;
  end;
  if chkInserimentoRiposi.Checked then
  begin
    try
      WA027FCarMenDM.CreazioneA041;
    except
      on E: Exception do
      begin
        raise Exception.Create(A000MSG_ERR_GENERICO);
      end;
    end;
  end;
  with WA027FCarMenDM.R400FCartellinoDtM.Q950Int do
  begin
    Close;
    SetVariable('Codice',CodiceT950);
    Open;
  end;
  WA027FCarMenDM.R400FCartellinoDtM.selDatiBloccati.Close;
  WA027FCarMenDM.R400FCartellinoDtM.SoloAggiornamento:=SenderName = imbSoloAggiornamento.HTMLName;
  WA027FCarMenDM.R400FCartellinoDtM.AggiornamentoScheda:=chkAggiornamentoSchedaRiepilogativa.Checked;
  WA027FCarMenDM.R400FCartellinoDtM.AutoGiustificazione:=chkAutoGiustificazione.Checked;
  PutParametriFunzione;
  SessioneOracle.Commit;

  //AGGIUNTA LUCA -> anomalie aggiornamento
  WA027FCarMenDM.R400FCartellinoDtM.IgnoraAnomalie:=chkIgnoraAnomalieAggiornamento.Checked;
  WA027FCarMenDM.R400FCartellinoDtM.CalcoloCompetenze:=False;
  WA027FCarMenDM.R400FCartellinoDtM.lstDettaglio.Clear;
  WA027FCarMenDM.R400FCartellinoDtM.lstRiepilogo.Clear;
  WA027FCarMenDM.R400FCartellinoDtM.LeggiDatiRichiesti('Intestazione');
  WA027FCarMenDM.R400FCartellinoDtM.LeggiDatiRichiesti('Dettaglio');
  WA027FCarMenDM.R400FCartellinoDtM.LeggiDatiRichiesti('Riepilogo');

  grdC700.selAnagrafe.SetVariable('DATALAVORO',DataF);
  grdC700.selAnagrafe.Close;
  if (SenderName = imbGeneraPDF.HTMLName) and (Pos(WA027FCarMenDM.R400FCartellinoDtM.CampiIntestazione,grdC700.selAnagrafe.SQL.Text) = 0) and
     ((Pos('T030.*',grdC700.selAnagrafe.SQL.Text) = 0) or (Pos('V430.*',grdC700.selAnagrafe.SQL.Text) = 0)) and
     (Trim(WA027FCarMenDM.R400FCartellinoDtM.CampiIntestazione) <> '') then // daniloc. 23.12.2010
  begin
    S:=grdC700.selAnagrafe.SQL.Text;
    iSQL:=R180CercaParolaIntera('FROM',UpperCase(S),'.,;');//iSQL:=Pos('FROM',S);
    if iSQL > 0 then
      Insert(',' + WA027FCarMenDM.R400FCartellinoDtM.CampiIntestazione + ' ',S,iSQL);
    grdC700.selAnagrafe.SQL.Text:=S;
  end;

  try
    grdC700.selAnagrafe.Open;
  except
    on E:Exception do
    begin
      raise Exception.Create(A000MSG_A027_ERR_FMT_STAMPA);
    end;
  end;

  if SenderName = imbGeneraPDF.HTMLName then
  begin
    lst:=TStringList.Create;
    with WA027FCarMenDM.R400FCartellinoDtM do
    try
      SetLength(VetDatiLiberiSQL,0);
      selT951.Close;
      selT951.SetVariable('Codice',Q950Int.FieldByName('CODICE').AsString);
      selT951.Open;
      while not selT951.Eof do
      begin
        lst.Add(Trim(selT951.FieldByName('RIGA').AsString));
        selT951.Next;
      end;
      selT951.Close;
      WA027FCarMenDM.GetLabels(lst,'Riepilogo2001',nil);
      //Devo già avere l'elenco dei dati liberi 2001
      CreaClientDataSet(grdC700.selAnagrafe);
    finally
      FreeAndNil(lst);//.Free;
    end;
  end;
  grdC700.selAnagrafe.First;  //caratto 04/01/2013
  WA027FCarMenDM.R400FCartellinoDtM.A027SelAnagrafe:=grdC700.selAnagrafe;
end;

function TWA027FCarMen.CurrentRecordElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecNO;
end;

function TWA027FCarMen.TotalRecordsElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecordCount;
end;

procedure TWA027FCarMen.WC700AperturaSelezione(Sender: TObject);
var
  D: TDateTime;
begin
  if TryStrToDate(edtDa.Text,D) then
    grdC700.WC700FM.C700DataDal:=D;

  if TryStrToDate(edtA.Text,D) then
    grdC700.WC700FM.C700DataLavoro:=D;
end;

procedure TWA027FCarMen.ElaboraElemento;
begin
  CalCartRes:=WA027FCarMenDM.CalcoloCartellini(A,M,G,A2,M2,G2);
  SessioneOracle.Commit;
  //  MessaggioStatus(ERRORE, CalCartRes); //todo ??non aggiorna status in async
end;

function TWA027FCarMen.ElementoSuccessivo: Boolean;
begin
  Result:=False;
  grdC700.selAnagrafe.Next;
  if not grdC700.selAnagrafe.Eof then //richiama calcolo su nuovo dipendente
  begin
    Result:=True;
  end;
end;

procedure TWA027FCarMen.FineCicloElaborazione;
begin
  inherited;

  WA027FCarMenDM.ChiusuraQuery(WA027FCarMenDM.R400FCartellinoDtM);
  with WA027FCarMenDM.R400FCartellinoDtM do
  begin
    //Chiudo subito le query e le unit dei conteggi, salvo Q950Int che serve in stampa
    Q950Int.Open;
    selT004.Open;
    WA027FCarMenDM.ChiusuraQuery(R450DtM1);
    FreeAndNil(WA027FCarMenDM.R400FCartellinoDtM.R450DtM1);
    FreeAndNil(WA027FCarMenDM.R400FCartellinoDtM.R600DtM1);
  end;

  imbAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);

  if SenderName = imbGeneraPDF.HTMLName then
  begin
    if WA027FCarMenDM.R400FCartellinoDtM.cdsRiepilogo.RecordCount > 0 then
    begin
      if Pos(INI_PAR_NO_STAMPACARTELLINO,W000ParConfig.ParametriAvanzati{W000ParametriAvanzati}) = 0 then // gestione parametri di configurazione su file
      begin
        WA027FCarMenDM.WA027CSStampa:=CSStampa;
        S:=WA027FCarMenDM.EsecuzioneStampa;
        if S <> '' then
          raise Exception.Create('Produzione file pdf fallita: ' + S);
        // visualizza pdf
        if Pos(INI_PAR_NO_PDF,W000ParConfig.ParametriAvanzati{W000ParametriAvanzati}) = 0 then // gestione parametri di configurazione su file
        begin
          //gestito da WR100
          NomeFileGenerato:=WA027FCarMenDM.NomeFile;
          Exit;
        end;
      end;
    end
    else
      raise Exception.Create(A000MSG_A027_ERR_NO_CART);
  end;
end;

function TWA027FCarMen.ElaborazioneTerminata: String;
begin
  if imbAnomalie.Enabled then
    Result:=A000MSG_MSG_ELABORAZIONE_ANOMALIE
  else
    Result:=inherited;
end;

procedure TWA027FCarMen.DistruzioneOggettiElaborazione(Errore:Boolean);
begin
  PutParametriFunzione;
  try SessioneOracle.Commit; except end;

  if SenderName = imbGeneraPDF.HTMLName then
  begin
    with WA027FCarMenDM.R400FCartellinoDtM do
    begin
      cdsRiepilogo.Close;
      cdsDettaglio.Close;
      cdsSettimana.Close;
      cdsAssenze.Close;
      cdsPresenze.Close;
      Q950Int.CloseAll;
      selT004.Close;
    end;
  end;

  grdC700.selAnagrafe.CloseAll;
  grdC700.selAnagrafe.SQL.Text:=SQLText;
  if WA027FCarMenDM.R400FCartellinoDtM <> nil then
  begin
    WA027FCarMenDM.R400FCartellinoDtM.Q950Int.CloseAll;
    WA027FCarMenDM.R400FCartellinoDtM.selT004.CloseAll;
    WA027FCarMenDM.R400FCartellinoDtM.A027SelAnagrafe:=nil;
    FreeAndNil(WA027FCarMenDM.R400FCartellinoDtM);
  end;
  grdC700.selAnagrafe.Open;
  WA027FCarMenDM.DistruggiLstRaveComp;
end;

procedure TWA027FCarMen.DistruggiOggetti;
begin
  //!!!!Blocco dell'applicazione se non si libera la R400!!!!!
  FreeAndNil(WA027FCarMenDM.R400FCartellinoDtM);
end;

procedure TWA027FCarMen.edtAAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  AbilitaBloccoRiepiloghi;
end;

procedure TWA027FCarMen.edtDaAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  AbilitaBloccoRiepiloghi;
end;

procedure TWA027FCarMen.EseguiStampaViaB028;
var DettaglioLog:OleVariant;
    DatiUtente: String;
begin
  DCOMNomeFile:='';
  try
    //Chiamo Servizio COM B028 per creare il pdf su server
    DCOMNomeFile:=GetNomeFile('pdf');
    ForceDirectories(ExtractFileDir(DCOMNomeFile));
    DatiUtente:=CreateJsonString;
    if (not IsLibrary) and
       (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then // gestione parametri di configurazione su file
      CoInitialize(nil);
    if not DCOMConnection.Connected then
      DCOMConnection.Connected:=True;
    try
      DCOMConnection.AppServer.PrintA027(grdC700.selAnagrafe.SubstitutedSQL,
                                         DCOMNomeFile,
                                         Parametri.Operatore,
                                         Parametri.Azienda,
                                         WR000DM.selAnagrafe.Session.LogonDataBase,
                                         DatiUtente,
                                         DettaglioLog);
    finally
      DCOMConnection.Connected:=False;
    end;
    if FileExists(DCOMNomeFile) then
      if Pos(INI_PAR_NO_PDF,W000ParConfig.ParametriAvanzati) = 0 then // gestione parametri di configurazione su file
      begin
        AddToInitProc(Format('SubmitClick("%s", "", true);',[btnHdnInviaFile.HTMLName]));
      end
    else
    begin
      DCOMNomeFile:='';
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_A027_ERR_NO_FILE_PDF));
    end;
  except
    on E:Exception do
    begin
      DCOMNomeFile:='';
      raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A027_ERR_FMT_STAMPA_CARTELLINO_B028),[E.message]));
    end;
  end;
end;

function TWA027FCarMen.CreateJsonString:String;
var
  JSONObject:TJSONObject;
begin
  JSONObject:=TJSONObject.Create;
  try
    JSONObject.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
    JSONObject.AddPair('NomeStampa',Trim(Copy(cmbParametrizzazione.Text,1,5)));
    C190Comp2JsonString(edtDa,JSONObject,'EDaData');
    C190Comp2JsonString(edtA,JSONObject,'EAData');
    C190Comp2JsonString(chkAutoGiustificazione,JSONObject,'chkAutoGiustificazione');
    C190Comp2JsonString(chkIgnoraAnomalieStampa,JSONObject,'chkIgnoraAnomalieStampa');
    C190Comp2JsonString(chkNumeraPagine,JSONObject,'chkNumPagina');
    C190Comp2JsonString(edtNumeraPagine,JSONObject,'edtNumPagina');
    C190Comp2JsonString(chkPaginaParita,JSONObject,'chkPaginaParita');
    C190Comp2JsonString(chkParametrizzazioniTipoCartellino,JSONObject,'chkParametrizzazioniTipoCartellino');
    C190Comp2JsonString(chkAggiornamentoSchedaRiepilogativa,JSONObject,'CAggiornamento');
    C190Comp2JsonString(chkIgnoraAnomalieAggiornamento,JSONObject,'chkIgnoraAnomalie');
    C190Comp2JsonString(chkAggiornamentoBuoniPasto,JSONObject,'chkBuoniPasto');
    C190Comp2JsonString(chkAggiornamentoAccessiMensa,JSONObject,'chkAccessiMensa');
    C190Comp2JsonString(chkInserimentoRiposi,JSONObject,'chkInserimentoRiposi');
    Result:=JSONObject.ToString;
  finally
    JSONObject.Free;
  end;
end;

end.
