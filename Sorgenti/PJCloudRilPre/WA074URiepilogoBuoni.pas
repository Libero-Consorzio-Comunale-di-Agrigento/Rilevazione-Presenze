unit WA074URiepilogoBuoni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR100UBase, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, ActnList, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,WA074URiepilogoBuoniDM, IWCompCheckbox, meIWCheckBox, IWCompEdit, meIWEdit, IWCompLabel, meIWLabel, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, meIWRegion, meIWImageFile, IWCompListbox,
  IWDBStdCtrls, meIWDBLookupComboBox, medpIWTabControl, meIWComboBox,C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  A000UInterfaccia,A000UMessaggi,medpIWMessageDlg,WA074UGemeazFM,DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF}IWApplication,
  medpIWImageButton,QueryStorico,StrUtils, medpIWMultiColumnComboBox, A000UCostanti, DB, DBClient, MConnect,
  meIWDBLabel, ActiveX;

type
  TEsitoElab = record
    Tipo: string;
    Id: string;
    procedure Clear; inline;
  end;

  TWA074FRiepilogoBuoni = class(TWR100FBase)
    WA074MaturazioneRG: TmeIWRegion;
    lblDa: TmeIWLabel;
    edtDa: TmeIWEdit;
    lblA: TmeIWLabel;
    edtA: TmeIWEdit;
    ChkDettaglio: TmeIWCheckBox;
    ChkAcquisto: TmeIWCheckBox;
    ChkAggiorna: TmeIWCheckBox;
    ChkIgnoraAnomalie: TmeIWCheckBox;
    ChkInizioAnno: TmeIWCheckBox;
    ChkSaltoPagina: TmeIWCheckBox;
    WA074AcquistoRG: TmeIWRegion;
    lblMeseAcquisto: TmeIWLabel;
    edtDataAcquisto: TmeIWEdit;
    lblUltimoAcquisto: TmeIWLabel;
    edtUltimoAcquisto: TmeIWEdit;
    chkAcqDatiIndividuali: TmeIWCheckBox;
    btnEliminaAcquisto: TmeIWButton;
    chkAcqSaltoPagina: TmeIWCheckBox;
    chkFileSequenziale: TmeIWCheckBox;
    chkAcqAggiornamento: TmeIWCheckBox;
    btnParametriGemeaz: TmeIWButton;
    chkScaricoPaghe: TmeIWCheckBox;
    lblParametrizzazione: TmeIWLabel;
    lblRaggrAnagrafico: TmeIWLabel;
    TemplateMaturazioneRG: TIWTemplateProcessorHTML;
    TemplateAcquistoRG: TIWTemplateProcessorHTML;
    grdTabDetail: TmedpIWTabControl;
    cmbRaggrAnagrafico: TmeIWComboBox;
    btnAnomalie: TmedpIWImageButton;
    btnSoloAggiornamento: TmedpIWImageButton;
    edtPwdFileSequenziale: TmeIWEdit;
    lblPwdFileSequenziale: TmeIWLabel;
    lblDescParametrizzazione: TmeIWLabel;
    edtFileSequenziale: TmeIWEdit;
    btnScaricaFile: TmedpIWImageButton;
    cmbParametrizzazione: TMedpIWMultiColumnComboBox;
    btnGeneraPDF: TmedpIWImageButton;
    DCOMConnection: TDCOMConnection;
    lblNomeFile: TmeIWLabel;
    procedure IWAppFormCreate(Sender: TObject);
    procedure edtDaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure edtAAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure ChkInizioAnnoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnEliminaAcquistoClick(Sender: TObject);
    procedure btnParametriGemeazClick(Sender: TObject);
    procedure IWAppFormAfterRender(Sender: TObject);
    procedure btnSoloAggiornamentoClick(Sender: TObject);
    procedure cmbParametrizzazioneAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure btnAnomalieClick(Sender: TObject);
    procedure btnScaricaFileClick(Sender: TObject);
    procedure chkAcqAggiornamentoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure ChkAggiornaAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnGeneraPDFClick(Sender: TObject);
    procedure chkFileSequenzialeClick(Sender: TObject);
    procedure chkScaricoPagheClick(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
  private
    WA074FRiepilogoBuoniDM:TWA074FRiepilogoBuoniDM;
    WA074FGemeazFM:TWA074FGemeazFM;
    ParametriGemeaz: TParametriGemeaz;
    CampoRagg,SenderName,
    RaggruppamentoGemeaz,
    NomeFileSeqDownload: String;
    TempDataUltimoAcquisto: TDateTime;
    DataI,DataF: TDateTime;
    iLungMatrAnag, iPosiMatrFile, iLungMatrFile: Integer;
    DipInSer: TDipendenteInServizio;
    RegistraFileSeq: Boolean;
    FileSeq:TextFile;
    FEsitoElabDCOM: TEsitoElab;
    procedure MeseUltimoAcquisto(MeseSucc: Boolean);
    procedure AbilitaSalvataggio;
    procedure ResultEliminaAcquisto(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultFileSequenziale(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultDisabilitaAggiornamento(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultParametriGemeaz(Parametri: TParametriGemeaz);
    procedure ControlliAcquisto;
    procedure ImpostaDescParametrizzazione;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure CallDCOMPrinter;
    function CreateJSonString: String;
  protected
    procedure WC700AperturaSelezione(Sender: TObject); override;
    procedure ElaborazioneServer; override;
    procedure AfterElaborazione; override;
    procedure InizioElaborazione; override;
    procedure ElaboraElemento; override;
    function ElementoSuccessivo: Boolean; override;
    function CurrentRecordElaborazione: Integer; override;
    function TotalRecordsElaborazione: Integer; override;
    procedure FineCicloElaborazione;override;
    function ElaborazioneTerminata:String; override;
    procedure DistruzioneOggettiElaborazione(Errore:Boolean); override;
    procedure DistruggiOggetti; override;
  public
    function InizializzaAccesso: Boolean; override;
  end;

implementation

uses
  A074URiepilogoBuoniMW,
  WA037UScaricoPaghe;


{$R *.dfm}
procedure TWA074FRiepilogoBuoni.IWAppFormAfterRender(Sender: TObject);
begin
  { DONE : TEST IW 14 OK }
  if not GGetWebApplicationThreadVar.IsCallBack then
  begin
    inherited;
    jqCalendario.Enabled:=False;
  end;
end;

procedure TWA074FRiepilogoBuoni.IWAppFormCreate(Sender: TObject);
begin
  grdTabDetail.AggiungiTab('Maturazione',WA074MaturazioneRG);
  grdTabDetail.AggiungiTab('Acquisto',WA074AcquistoRG);
  grdTabDetail.HasFiller:=True;
  grdTabDetail.ActiveTab:=WA074MaturazioneRG;
  inherited;
  AttivaGestioneC700;
  grdC700.WC700FM.C700SelezionePeriodica:=True;
  grdC700.AttivaBrowse:=False;

  WA074FRiepilogoBuoniDM:=TWA074FRiepilogoBuoniDM.Create(Self);
  WA074FRiepilogoBuoniDM.A074FRiepilogoBuoniMW.SelAnagrafe:=grdC700.selAnagrafe;
  btnSoloAggiornamento.Enabled:=chkAcqAggiornamento.Checked;

  lblNomeFile.Caption:=Trim(VarToStr(WA074FRiepilogoBuoniDM.A074FRiepilogoBuoniMW.selT191.Lookup('CODICE','A074','NOMEFILE')));
end;


procedure TWA074FRiepilogoBuoni.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  FreeAndNil(WA074FGemeazFM);
  inherited;
end;

procedure TWA074FRiepilogoBuoni.MeseUltimoAcquisto(MeseSucc: Boolean);
var
  DataUltimoAcquisto: TDateTime;
begin
  DataUltimoAcquisto:=WA074FRiepilogoBuoniDM.A074FRiepilogoBuoniMW.getUltimoAcquisto;
  if DataUltimoAcquisto = DATE_NULL then
    edtUltimoAcquisto.Text:=''
  else
    edtUltimoAcquisto.Text:=FormatDateTime('mmmm yyyy',DataUltimoAcquisto);
  if MeseSucc then
  begin
    if DataUltimoAcquisto = DATE_NULL then
      edtDataAcquisto.Text:=FormatDateTime('mm/yyyy',Parametri.DataLavoro)
    else
      edtDataAcquisto.Text:=FormatDateTime('mm/yyyy',R180InizioMese(DataUltimoAcquisto));
  end;
end;

procedure TWA074FRiepilogoBuoni.ResultDisabilitaAggiornamento(Sender: TObject;
  R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    chkAcqAggiornamento.Checked:=False;
    chkFileSequenziale.Checked:=False;
    chkScaricoPaghe.Checked:=False;
    StartElaborazioneCiclo(SenderName);
  end
end;

procedure TWA074FRiepilogoBuoni.ResultEliminaAcquisto(Sender: TObject;
  R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    WA074FRiepilogoBuoniDM.A074FRiepilogoBuoniMW.EliminaAcquisto(TempDataUltimoAcquisto);
    MeseUltimoAcquisto(True);
  end;
end;

procedure TWA074FRiepilogoBuoni.ResultFileSequenziale(Sender: TObject;
  R: TmeIWModalResult; KI: String);
begin
 if R = mrYes then
  ControlliAcquisto;
end;

procedure TWA074FRiepilogoBuoni.ResultParametriGemeaz(Parametri: TParametriGemeaz);
begin
  ParametriGemeaz:=Parametri;
end;

procedure TWA074FRiepilogoBuoni.btnEliminaAcquistoClick(Sender: TObject);
var
  Tot: Integer;
begin
  WA074FRiepilogoBuoniDM.A074FRiepilogoBuoniMW.CountUltimoAcquisto(TempDataUltimoAcquisto,Tot);

  if TempDataUltimoAcquisto <> DATE_NULL then
    MsgBox.WebMessageDlg(Format(A000MSG_A074_DLG_FMT_ELIMINA_ACQUISTO,[Tot,UpperCase(FormatDateTime('mmmm yyyy',TempDataUltimoAcquisto))]),mtConfirmation,[mbYes,mbNo],ResultEliminaAcquisto,'');
end;

procedure TWA074FRiepilogoBuoni.btnGeneraPDFClick(Sender: TObject);
begin
  StartElaborazioneServer(btnGeneraPDF.HTMLName);
end;

procedure TWA074FRiepilogoBuoni.ElaborazioneServer;
begin
  CallDCOMPrinter;
end;

procedure TWA074FRiepilogoBuoni.AfterElaborazione;
begin
  inherited;
  // al termine dell'elaborazione (server o con ciclo di ajaxnotifier),
  // FEsitoElabB028 contiene le eventuali info sul messaggio con anomalie
  btnAnomalie.Enabled:=FEsitoElabDCOM.Id <> '';
  btnAnomalie.Caption:=IfThen(FEsitoElabDCOM.Tipo = TEsitoA074Rec.Info,'Messaggi','Anomalie');
end;

procedure TWA074FRiepilogoBuoni.CallDCOMPrinter;
var
  DettaglioLog:OleVariant;
  DatiUtente: String;
  LDettaglioLogStr: string;
  LDettaglioArr: TArray<String>;
  LIdTemp: Integer;
begin
  //Chiamo Servizio COM B028 per creare il pdf su server
  FEsitoElabDCOM.Clear;
  DCOMNomeFile:=GetNomeFile('pdf');
  ForceDirectories(ExtractFileDir(DCOMNomeFile));
  DatiUtente:=CreateJSonString;
  if (not IsLibrary) and
     (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then // gestione parametri di configurazione su file
    CoInitialize(nil);
  if not DCOMConnection.Connected then
    DCOMConnection.Connected:=True;
  try
    DCOMConnection.AppServer.PrintA074(grdC700.selAnagrafe.SubstitutedSQL,
                                       DCOMNomeFile,
                                       Parametri.Operatore,
                                       Parametri.Azienda,
                                       WR000DM.selAnagrafe.Session.LogonDataBase,
                                       DatiUtente,
                                       DettaglioLog);

    // cast del dettaglio a tipo string
    LDettaglioLogStr:=DettaglioLog;
    if LDettaglioLogStr <> '' then
    begin
      // verifica risposta B028
      // il dettagliolog contiene una stringa separata da virgola con 2 informazioni:
      //   1. il tipo di messaggio (A = sono presenti anomalie / I = sono presenti solo informazioni)
      //   2. l'id del messaggio
      LDettaglioArr:=LDettaglioLogStr.Split([',']);
      if Length(LDettaglioArr) <> 2 then
      begin
        DCOMMsg:=A000MSG_MSG_ELABORAZIONE_ANOMALIE;
        Exit;
      end;

      try
        // tipo messaggio
        FEsitoElabDCOM.Tipo:=LDettaglioArr[0];

        // id del messaggio
        if not TryStrToInt(LDettaglioArr[1],LIdTemp) then
        begin
          DCOMMsg:=Format('Errore nella risposta del servizio di stampa B028: l''ID previsto non è numerico (%s)',[LDettaglioArr[1]]);
          Exit;
        end;
        FEsitoElabDCOM.Id:=LDettaglioArr[1];

        // segnalazione anomalia all'utente
        if FEsitoElabDCOM.Tipo = TEsitoA074Rec.Anomalie then
        begin
          // il log contiene anche anomalie
          DCOMMsg:=A000MSG_MSG_ELABORAZIONE_ANOMALIE;
        end
        else if FEsitoElabDCOM.Tipo = TEsitoA074Rec.Info then
        begin
          // il log contiene solo informazioni
          DCOMMsg:=A000MSG_MSG_ELABORAZIONE_SEGNALAZIONI;
        end
        else
        begin
          // tipo non previsto
          DCOMMsg:=Format('Errore nella risposta del servizio di stampa B028: esito operazione non previsto (%s)',[FEsitoElabDCOM.Tipo]);
          Exit;
        end;
      except
        on E: Exception do
        begin
          DCOMMsg:=Format('Errore nella risposta del servizio di stampa B028: %s',[E.Message]);
        end;
      end;
    end;
  finally
    DCOMConnection.Connected:=False;
  end;
end;

function TWA074FRiepilogoBuoni.CreateJSonString: String;
var json: TJSONObject;
    i: Integer;
begin
  json:=TJSONObject.Create;
  try
    //Popolo il json con i valori necessari al B028 per creare il PDF per la stampa
    //Tab Maturazione
    json.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
    C190Comp2JsonString(grdTabDetail,json,'ActiveTab');
    C190Comp2JsonString(edtDa,json);
    C190Comp2JsonString(edtA,json);
    C190Comp2JsonString(ChkDettaglio,json);
    C190Comp2JsonString(ChkAcquisto,json);
    C190Comp2JsonString(ChkInizioAnno,json);
    C190Comp2JsonString(ChkSaltoPagina,json);
    C190Comp2JsonString(ChkAggiorna,json);
    C190Comp2JsonString(ChkIgnoraAnomalie,json);

    //Tab Acquisto
    C190Comp2JsonString(edtDataAcquisto,json);
    C190Comp2JsonString(edtUltimoAcquisto,json);
    C190Comp2JsonString(chkAcqDatiIndividuali,json);
    C190Comp2JsonString(chkAcqSaltoPagina,json);
    C190Comp2JsonString(chkAcqAggiornamento,json);
    C190Comp2JsonString(chkFileSequenziale,json);
    C190Comp2JsonString(chkScaricoPaghe,json);
    C190Comp2JsonString(edtFileSequenziale,json);
    C190Comp2JsonString(edtPwdFileSequenziale,json);
    C190Comp2JsonString(cmbParametrizzazione,json,'dcmbParametrizzazione');

    C190Comp2JsonString(cmbRaggrAnagrafico,json,'dcmbRaggrAnagrafico');

    Result:=json.ToString;
  finally
    FreeAndNil(json);
  end;
end;

procedure TWA074FRiepilogoBuoni.btnParametriGemeazClick(Sender: TObject);
begin
  inherited;
  WA074FGemeazFM:=TWA074FGemeazFM.Create(Self);
  WA074FGemeazFM.ModalResult:=ResultParametriGemeaz;
  WA074FGemeazFM.Visualizza(ParametriGemeaz);
end;

procedure TWA074FRiepilogoBuoni.chkAcqAggiornamentoAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  btnSoloAggiornamento.Enabled:=chkAcqAggiornamento.Checked;
end;

procedure TWA074FRiepilogoBuoni.ChkAggiornaAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  btnSoloAggiornamento.Enabled:=ChkAggiorna.Checked;
end;

procedure TWA074FRiepilogoBuoni.chkFileSequenzialeClick(Sender: TObject);
begin
  edtFileSequenziale.Enabled:=chkFileSequenziale.Checked;
  edtPwdFileSequenziale.Enabled:=chkFileSequenziale.Checked;
  lblPwdFileSequenziale.Enabled:=chkFileSequenziale.Checked;
  btnParametriGemeaz.Enabled:=chkFileSequenziale.Checked;
  if chkFileSequenziale.Checked then
  begin
    chkScaricoPaghe.Checked:=False;
    chkScaricoPagheClick(Sender);
  end;
end;

procedure TWA074FRiepilogoBuoni.ChkInizioAnnoAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  if ChkInizioAnno.Checked then
    ChkAggiorna.Checked:=False;
  AbilitaSalvataggio;
end;

procedure TWA074FRiepilogoBuoni.chkScaricoPagheClick(Sender: TObject);
begin
  if chkScaricoPaghe.Checked then
  begin
    chkFileSequenziale.Checked:=False;
    chkFileSequenzialeClick(Sender);
    if cmbParametrizzazione.Text = '' then
    begin
      cmbParametrizzazione.ItemIndex:=-1;
      cmbParametrizzazione.Text:='A074';
      ImpostaDescParametrizzazione;
    end;
  end;
  lblParametrizzazione.Enabled:=chkScaricoPaghe.Checked;
  lblDescParametrizzazione.Enabled:=chkScaricoPaghe.Checked;
  lblNomeFile.Enabled:=chkScaricoPaghe.Checked;
  cmbParametrizzazione.Enabled:=chkScaricoPaghe.Checked;
end;

procedure TWA074FRiepilogoBuoni.cmbParametrizzazioneAsyncChange(Sender: TObject;EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  ImpostaDescParametrizzazione;
  lblNomeFile.Caption:=Trim(VarToStr(WA074FRiepilogoBuoniDM.A074FRiepilogoBuoniMW.selT191.Lookup('CODICE',CmbParametrizzazione.Text,'NOMEFILE')));
end;

procedure TWA074FRiepilogoBuoni.ControlliAcquisto;
begin
  RegistraFileSeq:=False;
  if (chkFileSequenziale.Checked) and (edtFileSequenziale.Text <> '') then
  try
    AssignFile(FileSeq,edtFileSequenziale.Text);
    Rewrite(FileSeq);
    RegistraFileSeq:=True;
  except
    MsgBox.WebMessageDlg(Format(A000MSG_A074_ERR_FMT_CREATE_FILE,[edtFileSequenziale.Text]),mtError,[mbOk],nil,'');
    Exit;
  end;

  if chkAcqAggiornamento.Checked or chkFileSequenziale.Checked or chkScaricoPaghe.Checked then
  begin
    if WA074FRiepilogoBuoniDM.A074FRiepilogoBuoniMW.getUltimoAcquistoAuto > DataI then
    begin
      MsgBox.WebMessageDlg(A000MSG_A074_DLG_DISAB_AGGIORNAMENTO,mtConfirmation,[mbYes,mbNo],ResultDisabilitaAggiornamento,'');
      Exit;
    end;
  end;
   StartElaborazioneCiclo(SenderName);
end;

procedure TWA074FRiepilogoBuoni.edtAAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  AbilitaSalvataggio;
end;

procedure TWA074FRiepilogoBuoni.edtDaAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  AbilitaSalvataggio;
end;

procedure TWA074FRiepilogoBuoni.btnAnomalieClick(Sender: TObject);
var
  Params: String;
begin
  if FEsitoElabDCOM.Id <> '' then
  begin
    Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
            'OPERATORE=' + Parametri.Operatore + ParamDelimiter +
            'MASCHERA=' + medpCodiceForm + ParamDelimiter +
            'ID=' + FEsitoElabDCOM.Id + ParamDelimiter +
            'TIPO=A,B,I'; // anche le info
    AccediForm(201,Params,True);
  end;
end;

procedure TWA074FRiepilogoBuoni.btnScaricaFileClick(Sender: TObject);
begin
  if FileExists(NomeFileSeqDownload) then
    GGetWebApplicationThreadVar.SendFile(NomeFileSeqDownload,true,'application/x-download',ExtractFileName(NomeFileSeqDownload))
  else
    MsgBox.WebMessageDlg(A000MSG_ERR_FILE_INESISTENTE,mtError,[mbOk],nil,'');
end;

procedure TWA074FRiepilogoBuoni.btnSoloAggiornamentoClick(Sender: TObject);
begin
  btnAnomalie.Enabled:=False;

  SenderName:=TmedpIWImageButton(Sender).HTMLName;

  if grdC700.selAnagrafe.RecordCount = 0 then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_NO_DIP,mtError,[mbOk],nil,'');
    Exit;
  end;

  if grdTabDetail.activeTab = WA074MaturazioneRG then
  begin
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
      Exit;
    end;
  end
  else
  begin
    if not TryStrToDate('01/' + edtDataAcquisto.Text,DataI) then
    begin
      MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,['Mese acquisto']),mtError,[mbOk],nil,'');
      edtDa.SetFocus;
      Exit;
    end;
    DataI:=R180InizioMese(DataI);
    DataF:=R180FineMese(DataI);

    if (chkScaricoPaghe.Checked) and (cmbParametrizzazione.Text = '') then
    begin
      MsgBox.WebMessageDlg(A000MSG_A074_ERR_PARAMETRIZZAZIONE,mtError,[mbOk],nil,'');
      Exit;
    end;

    if chkFileSequenziale.Checked then
    begin
      if edtPwdFileSequenziale.Text <> 'A074FS' then
      begin
        MsgBox.WebMessageDlg(A000MSG_A074_ERR_PWD_FILE,mtError,[mbOk],nil,'');
        edtPwdFileSequenziale.SetFocus;
        Exit;
      end;

      MsgBox.WebMessageDlg(A000MSG_A074_DLG_FILE_SEQUENZIALE,mtConfirmation,[mbYes,mbNo],ResultFileSequenziale,'');
      Exit;
    end;
  end;

  //Visualizza progress bar e fa partire elaborazione
  StartElaborazioneCiclo(SenderName);
end;

procedure TWA074FRiepilogoBuoni.ImpostaDescParametrizzazione;
begin
  lblDescParametrizzazione.Caption:=VarToStr(WA074FRiepilogoBuoniDM.A074FRiepilogoBuoniMW.selT191.Lookup('CODICE',CmbParametrizzazione.Text,'DESCRIZIONE'));
end;

function TWA074FRiepilogoBuoni.InizializzaAccesso: Boolean;
begin
  if Trim(Parametri.CampiRiferimento.C4_BuoniMensa) = '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage(A000MSG_A074_ERR_CAMPO_RIFERIMENTO);
    Result:=False;
    Exit;
  end;

  with WA074FRiepilogoBuoniDM.A074FRiepilogoBuoniMW do
  begin
    cmbRaggrAnagrafico.Items.Clear;

    dsrI010.DataSet.First;
    while not dsrI010.DataSet.Eof do
    begin
      cmbRaggrAnagrafico.Items.add(dsrI010.DataSet.FieldByName('NOME_LOGICO').AsString +'=' +
                                  dsrI010.DataSet.FieldByName('NOME_CAMPO').AsString);
      dsrI010.DataSet.Next;
    end;
    cmbRaggrAnagrafico.ItemIndex:=0;

    selT191.First;
    CmbParametrizzazione.Items.Clear;
    while not selT191.EOF do
    begin
      CmbParametrizzazione.AddRow(selT191.FieldByName('CODICE').AsString+';'+selT191.FieldByName('DESCRIZIONE').AsString);
      selT191.Next;
    end;

  end;
  edtDa.Text:=FormatDateTime('dd/mm/yyyy',R180InizioMese(Parametri.DataLavoro));
  edtA.Text:=FormatDateTime('dd/mm/yyyy',R180FineMese(Parametri.DataLavoro));
  //acquisto
  MeseUltimoAcquisto(True);
  if not SolaLettura then
    chkAcqAggiornamento.Checked:=False;

  chkAcqAggiornamento.Enabled:=not SolaLettura;
  btnEliminaAcquisto.Enabled:=(not SolaLettura) and (Parametri.A037_EliminaDataCassa = 'S');

  AbilitaSalvataggio;
  CampoRagg:='';
  LblDescParametrizzazione.Caption:='';
  chkFileSequenzialeClick(nil);
  GetParametriFunzione;
  btnAnomalie.Enabled:=False;
  btnScaricaFile.Enabled:=False;
  btnScaricaFile.medpDownloadButton:=True;
  Result:=True;
end;

procedure TWA074FRiepilogoBuoni.AbilitaSalvataggio;
var YY1,MM1,DD1,YY2,MM2,DD2:Word;
    Abilitato:Boolean;
begin
  Abilitato:=False;
  try
    DecodeDate(StrToDate(edtDa.Text),YY1,MM1,DD1);
    DecodeDate(StrToDate(edtA.Text),YY2,MM2,DD2);
    if (YY1 = YY2) and (MM1 = MM2) then
      if (DD1 = 01)and(DD2 = R180GiorniMese(StrToDate(edtA.Text))) then
        Abilitato:=True;
  except
  end;
  if not Abilitato then
    ChkAggiorna.Checked:=False;
  ChkAggiorna.Enabled:=(not SolaLettura) and Abilitato and (not ChkInizioAnno.Checked);
  ChkAggiornaAsyncClick(ChkAggiorna,nil);
end;

//ELABORAZIONE
procedure TWA074FRiepilogoBuoni.InizioElaborazione;
var
  S: String;
  i,P: Integer;
  LFormatoMatricola:TStringList;
begin
  inherited;

  // pulisce eventuale anomalia elaborazione precedente
  FEsitoElabDCOM.Clear;
  DCOMNomeFile:='';

  if SenderName = btnGeneraPDF.HTMLName then
    MessaggioFinaleProgressBar:=A000MSG_MSG_PDF_IN_CORSO;

  NomeFileSeqDownload:='';
  iLungMatrAnag:=5;
  iPosiMatrFile:=1;
  iLungMatrFile:=5;
  LFormatoMatricola:=TStringList.Create;
  try
    LFormatoMatricola.CommaText:=ParametriGemeaz.FormatoMatricola;
    for i:=0 to LFormatoMatricola.Count - 1 do
    begin
      if Copy(Trim(UpperCase(LFormatoMatricola[i])),1,2) = 'LA' then
        iLungMatrAnag:=StrToIntDef(Copy(LFormatoMatricola[i],Pos('=',LFormatoMatricola[i]) + 1,Length(LFormatoMatricola[i]) - Pos('=',LFormatoMatricola[i]) + 1),5)
      else if Copy(Trim(UpperCase(LFormatoMatricola[i])),1,2) = 'PS' then
        iPosiMatrFile:=StrToIntDef(Copy(LFormatoMatricola[i],Pos('=',LFormatoMatricola[i]) + 1,Length(LFormatoMatricola[i]) - Pos('=',LFormatoMatricola[i]) + 1),1)
      else if Copy(Trim(UpperCase(LFormatoMatricola[i])),1,2) = 'LF' then
        iLungMatrFile:=StrToIntDef(Copy(LFormatoMatricola[i],Pos('=',LFormatoMatricola[i]) + 1,Length(LFormatoMatricola[i]) - Pos('=',LFormatoMatricola[i]) + 1),5)
    end;
  finally
    LFormatoMatricola.Free;
  end;

  WA074FRiepilogoBuoniDM.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.selDatiBloccati.Close;

  CampoRagg:=cmbRaggrAnagrafico.Items.ValueFromIndex[cmbRaggrAnagrafico.ItemIndex];

  if grdC700.WC700FM.C700SettaPeriodoSelAnagrafe(DataI,DataF) then
    grdC700.selAnagrafe.CloseAll;

  if CampoRagg <> '' then
  begin
    S:=grdC700.selAnagrafe.SQL.Text;
    if R180InserisciColonna(S,CampoRagg) then
    begin
      grdC700.selAnagrafe.CloseAll;
      grdC700.selAnagrafe.SQL.Text:=S;
    end;
    P:=Pos('ORDER BY',S);
    if (P > 0) and (Pos(CampoRagg,Copy(S,P,Length(S))) = 0) then
    begin
      grdC700.selAnagrafe.CloseAll;
      Insert(CampoRagg + ',',S,P + Length('ORDER BY '));
      grdC700.selAnagrafe.SQL.Text:=S;
    end;
  end;
  grdC700.selAnagrafe.Open;
  grdC700.selAnagrafe.First;
  WA074FRiepilogoBuoniDM.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.selAnagrafe:=grdC700.selAnagrafe;
  WA074FRiepilogoBuoniDM.A074FRiepilogoBuoniMW.CreaTabellaStampa;
  if grdTabDetail.activeTab = WA074MaturazioneRG then
  begin
    with WA074FRiepilogoBuoniDM.A074FRiepilogoBuoniMW do
    begin
      if ChkInizioAnno.Checked then
        R350FCalcoloBuoniDtM.R502ProDtM1.PeriodoConteggi(EncodeDate(R180Anno(DataI),1,1),DataF)
      else
        R350FCalcoloBuoniDtM.R502ProDtM1.PeriodoConteggi(DataI,DataF);
      R350FCalcoloBuoniDtM.RMCampoRagg:=CampoRagg;
      R350FCalcoloBuoniDtM.RMStampa:=True;
      R350FCalcoloBuoniDtM.RMIgnoraAnomalie:=chkIgnoraAnomalie.Checked;
      R350FCalcoloBuoniDtM.RMRegistrazione:=(not SolaLettura) and ChkAggiorna.Checked;
    end;
  end
  else
  begin
    RaggruppamentoGemeaz:='';

    with WA074FRiepilogoBuoniDM.A074FRiepilogoBuoniMW do
    begin
      R350FCalcoloBuoniDtM.RMCampoRagg:=CampoRagg;
      R350FCalcoloBuoniDtM.RMStampa:=True;
      R350FCalcoloBuoniDtM.RMRegistrazione:=(not SolaLettura) and (chkAcqAggiornamento.Checked);
    end;
  end;
  DipInSer:=TDipendenteInServizio.Create(nil);
  DipInSer.Session:=SessioneOracle;
end;

function TWA074FRiepilogoBuoni.CurrentRecordElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecNo;
end;

function TWA074FRiepilogoBuoni.TotalRecordsElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecordCount;
end;

procedure TWA074FRiepilogoBuoni.ElaboraElemento;
var
  Data: TDateTime;
  Variazioni: Integer;
  Intestazione,S: String;
begin
  if grdTabDetail.activeTab = WA074MaturazioneRG then
  begin
    if ChkInizioAnno.Checked then
      Data:=StrToDate(FormatDateTime('01/01/yyyy',DataI))
    else
      Data:=DataI;

    if DipInSer.DipendenteInServizio(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,DataI,DataF) then
      WA074FRiepilogoBuoniDM.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.RiepilogoMensileMaturazione(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Data,DataF,DataI);
  end
  else
  begin
    if DipInSer.DipendenteInServizio(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,DataI,DataF) then
    begin
      with WA074FRiepilogoBuoniDM.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM do
      begin
        RiepilogoMensileAcquisto(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,DataI);
        //Registrazione del file sequenziale degli acquisti per prenotazione (Gemeaz)
        if RegistraFileSeq then
        begin
          Variazioni:=0;
          selT690.Close;
          selT690.SetVariable('PROGRESSIVO',grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          selT690.SetVariable('DATA',DataI);
          selT690.Open;
          if (RiepilogoBT.Tipo = 'B') or (ParametriGemeaz.BuoniPasto) then
            inc(Variazioni,selT690.FieldByName('BUONIPASTO').AsInteger);
          if (RiepilogoBT.Tipo = 'T') or (ParametriGemeaz.Ticket) then
            inc(Variazioni,selT690.FieldByName('TICKET').AsInteger);
          selT690.Close;
          if RiepilogoBT.Acquisto + Variazioni > 0 then
          begin
            S:=WA074FRiepilogoBuoniDM.A074FRiepilogoBuoniMW.GetRigaFile(RiepilogoBT.Acquisto + Variazioni,
                                                                        ParametriGemeaz.SiglaTestata,
                                                                        ParametriGemeaz.CodiceCliente,
                                                                        ParametriGemeaz.ValoreBuono,
                                                                        CampoRagg,
                                                                        ParametriGemeaz.FormatoMatricola,
                                                                        RaggruppamentoGemeaz,
                                                                        Intestazione,
                                                                        ParametriGemeaz.TipoFile);

            if Intestazione <> '' then
              Writeln(FileSeq,Intestazione);

            Writeln(FileSeq,S);
          end;
        end;
      end;
    end;
  end;
end;

function TWA074FRiepilogoBuoni.ElementoSuccessivo: Boolean;
begin
  Result:=False;
  grdC700.selAnagrafe.Next;
  if not grdC700.selAnagrafe.Eof then
  begin
    Result:=True;
  end;
end;

procedure TWA074FRiepilogoBuoni.FineCicloElaborazione;
var
  F037ScaricoPaghe: TWA037FScaricoPaghe;
begin
  FreeAndNil(DipInSer);
  if grdTabDetail.activeTab = WA074MaturazioneRG then
  begin
    if ChkAggiorna.Checked then
    begin
      RegistraLog.SettaProprieta('I','T680_BUONIMENSILI',medpCodiceForm,nil,True);
      RegistraLog.InserisciDato('DAL-AL','',DateToStr(DataI) + '-' + DateToStr(DataF));
      RegistraLog.RegistraOperazione;
    end;
  end
  else
  begin
    if RegistraFileSeq and (ParametriGemeaz.TipoFile = 0) then
      Writeln(FileSeq,Format('%s3%37s',[ParametriGemeaz.SiglaTestata,'']));
    if chkScaricoPaghe.Checked then
    begin
      F037ScaricoPaghe:=TWA037FScaricoPaghe.Create(GGetWebApplicationThreadVar,False);
      F037ScaricoPaghe.OpenWA037ScaricoBuoni(cmbParametrizzazione.Text,DataI,grdC700);
      F037ScaricoPaghe.ClosePage;
    end;
    if RegistraFileSeq then
    begin
      CloseFile(FileSeq);
      RegistraFileSeq:=False;
    end;
    if chkAcqAggiornamento.Checked then
      MeseUltimoAcquisto(False);
    if chkAcqAggiornamento.Checked then
    begin
      RegistraLog.SettaProprieta('I','T690_ACQUISTOBUONI',medpCodiceForm,nil,True);
      RegistraLog.InserisciDato('DATA','',DateToStr(DataI));
      RegistraLog.RegistraOperazione;
    end;
  end;
  WA074FRiepilogoBuoniDM.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.TabellaStampa.Close;

  // indica eventuale id messaggio con anomalie per abilitare la visualizzazione delle anomalie
  if RegistraMsg.ContieneAnomalie then
  begin
    FEsitoElabDCOM.Tipo:=TEsitoA074Rec.Anomalie;
    FEsitoElabDCOM.Id:=RegistraMsg.ID.ToString;
  end
  else
  begin
    FEsitoElabDCOM.Clear;
  end;
end;

procedure TWA074FRiepilogoBuoni.GetParametriFunzione;
begin
  with C004DM do
  begin
    ChkDettaglio.Checked:=GetParametro('DETTAGLIO','N') = 'S';
    ChkAcquisto.Checked:=GetParametro('ACQUISTO','N') = 'S';
    ChkInizioAnno.Checked:=GetParametro('INIZIOANNO','N') = 'S';
    ChkSaltoPagina.Checked:=GetParametro('SALTOPAGINA','N') = 'S';
    ChkIgnoraAnomalie.Checked:=GetParametro('IGNORAANOMALIE','N') = 'S';
    ChkAcqDatiIndividuali.Checked:=GetParametro('ACQDATIINDIVIDUALI','S') = 'S';
    ChkAcqSaltoPagina.Checked:=GetParametro('ACQSALTOPAGINA','N') = 'S';
    ChkFileSequenziale.Checked:=GetParametro('CREAFILESEQ','N') = 'S';
    EdtFileSequenziale.Text:=GetParametro('FILESEQUENZIALE','');
    chkFileSequenzialeClick(nil);
    lblNomeFile.Caption:=Trim(VarToStr(WA074FRiepilogoBuoniDM.A074FRiepilogoBuoniMW.selT191.Lookup('CODICE',GetParametro('PARPAGHE',''),'NOMEFILE')));
    ChkScaricoPaghe.Checked:=GetParametro('CREAFILEACQ','N') = 'S';
    CmbParametrizzazione.ItemIndex:=-1;
    CmbParametrizzazione.Text:=GetParametro('PARPAGHE','');
    ImpostaDescParametrizzazione;
    CmbRaggrAnagrafico.ItemIndex:=StrToInt(GetParametro('RAGGRUPPAMENTO','0'));
    //CmbRaggrAnagrafico.ItemIndex:=StrToInt(ifThen(CmbRaggrAnagrafico.ItemIndex>-1,IntToStr(CmbRaggrAnagrafico.ItemIndex),'0'));
    ParametriGemeaz.CodiceCliente:=GetParametro('CODCLIENTE','');
    ParametriGemeaz.ValoreBuono:=GetParametro('VALOREBUONO','');
    ParametriGemeaz.SiglaTestata:=GetParametro('SIGLATESTATA','TR');
    ParametriGemeaz.TipoFile:=StrToInt(GetParametro('TIPOFILEGEMEAZ','1'));
    ParametriGemeaz.FormatoMatricola:=GetParametro('FORMATOMATRICOLA','');
    ParametriGemeaz.Ticket:=GetParametro('TICKETGEMEAZ','N') = 'S';
    ParametriGemeaz.BuoniPasto:=GetParametro('BUONIGEMEAZ','N') = 'S';
  end;
end;

procedure TWA074FRiepilogoBuoni.PutParametriFunzione;
begin
  with C004DM do
  begin
    Cancella001;
    PutParametro('DETTAGLIO',IfThen(ChkDettaglio.Checked,'S','N'));
    PutParametro('ACQUISTO',IfThen(ChkAcquisto.Checked,'S','N'));
    PutParametro('INIZIOANNO',IfThen(ChkInizioAnno.Checked,'S','N'));
    PutParametro('SALTOPAGINA',IfThen(ChkSaltoPagina.Checked,'S','N'));
    PutParametro('IGNORAANOMALIE',IfThen(chkIgnoraAnomalie.Checked,'S','N'));
    PutParametro('CREAFILESEQ',IfThen(chkFileSequenziale.Checked,'S','N'));
    PutParametro('CREAFILEACQ',IfThen(chkScaricoPaghe.Checked,'S','N'));
    PutParametro('ACQDATIINDIVIDUALI',IfThen(chkAcqDatiIndividuali.Checked,'S','N'));
    PutParametro('ACQSALTOPAGINA',IfThen(chkAcqSaltoPagina.Checked,'S','N'));
    PutParametro('FILESEQUENZIALE',edtFileSequenziale.Text);
    PutParametro('PARPAGHE',CmbParametrizzazione.Text);
    PutParametro('RAGGRUPPAMENTO',IntToStr(CmbRaggrAnagrafico.ItemIndex));
    PutParametro('CODCLIENTE',ParametriGemeaz.CodiceCliente);
    PutParametro('VALOREBUONO',ParametriGemeaz.ValoreBuono);
    PutParametro('SIGLATESTATA',ParametriGemeaz.SiglaTestata);
    PutParametro('TIPOFILEGEMEAZ',IntToStr(ParametriGemeaz.TipoFile));
    PutParametro('FORMATOMATRICOLA',ParametriGemeaz.FormatoMatricola);
    PutParametro('TICKETGEMEAZ',IfThen(ParametriGemeaz.Ticket, 'S', 'N'));
    PutParametro('BUONIGEMEAZ',IfThen(ParametriGemeaz.BuoniPasto, 'S', 'N'));
  end;

  try SessioneOracle.Commit; except end;
end;

function TWA074FRiepilogoBuoni.ElaborazioneTerminata: String;
begin
  if btnAnomalie.Enabled then
    Result:=A000MSG_MSG_ELABORAZIONE_ANOMALIE
  else
    Result:=inherited;
  if chkFileSequenziale.Checked then
  begin
    btnScaricaFile.Enabled:=True;
    NomeFileSeqDownload:=ExpandFileName(edtFileSequenziale.Text);
  end
  else
    btnScaricaFile.Enabled:=False;
end;

procedure TWA074FRiepilogoBuoni.DistruzioneOggettiElaborazione(Errore:Boolean);
begin
  inherited;
  PutParametriFunzione;
  try
    if RegistraFileSeq then
      CloseFile(FileSeq);
  except
  end;
end;

procedure TWA074FRiepilogoBuoni.WC700AperturaSelezione(Sender: TObject);
begin
  if TryStrToDate(edtDa.Text,DataI) then
    grdC700.WC700FM.C700DataDal:=DataI;

  if TryStrToDate(edtA.Text,DataF) then
    grdC700.WC700FM.C700DataLavoro:=DataF;
end;

procedure TWA074FRiepilogoBuoni.DistruggiOggetti;
begin
  FreeAndNil(DipInSer);
end;

{ TEsitoElab }

procedure TEsitoElab.Clear;
begin
  Tipo:='';
  Id:='';
end;

end.
