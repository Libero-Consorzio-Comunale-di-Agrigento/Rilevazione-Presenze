unit WR003UGeneratoreStampe;

interface

uses
  Windows, Messages, SysUtils, System.StrUtils, Variants, Classes, Graphics, Controls, Forms, IWApplication, DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF}
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWGlobal,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl,
  IWCompLabel, meIWLabel, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,medpIWC700NavigatorBar, meIWImageFile,
  C004UParamForm, C180FunzioniGenerali, C190FunzioniGeneraliWeb, IWCompEdit, meIWEdit, A000UInterfaccia,
  System.Actions, Data.DB, Datasnap.DBClient, Datasnap.Win.MConnect, ActiveX, WC700USelezioneAnagrafeFM,
  A000UMessaggi, A000USessione, QRCtrls, meIWRadioGroup, A000UCostanti, medpIWMessageDlg,
  meTIWCheckListBox, WC020UInputDataOreFM, Generics.Collections, OracleData,
  WC025UUploadFile, medpIWImageButton, Oracle;

type
  TListaCodici = record
    Lunghezza:Word;
    chklst:TmeTIWCheckListBox;
  end;

  TTipoGenerazione = (tgPDF,tgXLS,tgXLSX,tgTable);

  TWR003FGeneratoreStampe = class(TWR102FGestTabella)
    grdComandi: TmeIWGrid;
    actlstComandi: TActionList;
    lblDal: TmeIWLabel;
    lblAl: TmeIWLabel;
    edtDal: TmeIWEdit;
    edtAl: TmeIWEdit;
    actLblDal: TAction;
    actEdtDal: TAction;
    actLblAl: TAction;
    actEdtAl: TAction;
    actTabella: TAction;
    DCOMConnection: TDCOMConnection;
    actImportaStampa: TAction;
    actEsportaStampa: TAction;
    actInterrogazioniServizio: TAction;
    actStampaPDF: TAction;
    actStampaXLS: TAction;
    btnGeneraPDF: TmedpIWImageButton;
    btnGeneraXLS: TmedpIWImageButton;
    btnGeneraTabella: TmedpIWImageButton;
    btnGeneraTabellaOnly: TmedpIWImageButton;
    actTabellaOnly: TAction;
    btnSalvaTabella: TmedpIWImageButton;
    actStampaXLSX: TAction;
    procedure actStampaPDFExecute(Sender: TObject);
    procedure actTabellaExecute(Sender: TObject);
    procedure actConfermaExecute(Sender: TObject);
    procedure actEliminaExecute(Sender: TObject);
    procedure actCopiaSuExecute(Sender: TObject);
    procedure actEsportaStampaExecute(Sender: TObject);
    procedure actImportaStampaExecute(Sender: TObject);
    procedure actInterrogazioniServizioExecute(Sender: TObject);
    procedure edtAlAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
    procedure actSalvaSuFileExecute(Sender: TObject);
    procedure IWAppFormCreate(Sender: TObject);
    procedure actTabellaOnlyExecute(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure actModificaExecute(Sender: TObject); override;
  private
    CodiceStampa: WideString;
    C004_WR003:TC004FParamForm;
    LastExec_Time,LastExec_App,LastExec_Codice,LastExec_Dal,LastExec_Al,LastExec_Anagra:String;
    procedure CallCOMServer(pCodice:String = '');
    function CreateJSonString: String;
    procedure ResultWC020(Sender: TObject; Result: Boolean; Valore: String);
    procedure ImportaResultEvent(Sender: TObject; Result: Boolean; FileName: String);
    procedure CheckGeneraTabellaOnly;
    procedure ResultGeneraTabellaOnly(Sender:TObject; R:TmeIWModalResult; KI:String);
  protected
    DettaglioLog:OleVariant;
    DatiUtente: String;
    TipoGenerazione:TTipoGenerazione;
    GeneraTabellaOnly:Boolean;
    procedure ElaborazioneServer; override;
    procedure InizializzaMsgElaborazione; override;
    procedure RefreshPage; override;
    procedure WC700AperturaSelezione(Sender: TObject); override;
    procedure ImpostazioniWC700; override;
    procedure CreaToolbarComandi(actlst: TActionList; grdToolbar: TmeIWGrid; _onClick: TprocSender);
    procedure imgComandiClick(Sender: TObject);
    procedure AbilitaActListNavBar(Browse: boolean); override;
    function ActionForDownload(action: TAction):Boolean; override;
    procedure DCOMPrint;virtual;abstract;
  public
    function BloccaStampa: Boolean;
    function ConvertiInValutaVisible(Val: String): boolean; virtual;
    procedure selTabellaStateChange(DataSet: TDataSet); override;
    function VerificaSelezioneC700: boolean; override;
    procedure EseguiDelete; override;
    function InizializzaAccesso:Boolean; override;
  end;

implementation

uses WR003UGeneratoreStampeDM, WR003UGeneratoreStampeDettFM,
  R003UGeneratoreStampeMW;
{$R *.dfm}

procedure TWR003FGeneratoreStampe.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  //Crea componente C004 separato che vada a leggere i dati di A077 o P077, scritti dai corrispondenti progetti win embedded in B028
  C004_WR003:=CreaC004(SessioneOracle,Copy(medpCodiceForm,2,Length(medpCodiceForm)),Parametri.ProgOper,False);
  actTabellaOnly.Visible:=C004_WR003.GetParametro('LASTEXEC_CODICE','') <> '';
end;

procedure TWR003FGeneratoreStampe.IWAppFormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(C004_WR003);
end;

procedure TWR003FGeneratoreStampe.AbilitaActListNavBar(Browse: boolean);
begin
  actImportaStampa.Enabled:=Browse;
  actEsportaStampa.Enabled:=Browse;
  inherited;
  actElimina.Enabled:=actElimina.Enabled and (not BloccaStampa);
  actModifica.Enabled:=Browse;
  actConferma.Enabled:=actConferma.Enabled and (not SolaLettura) and (not BloccaStampa);
end;

procedure TWR003FGeneratoreStampe.actConfermaExecute(Sender: TObject);
begin
  if (WR302DM.selTabella.State = dsEdit) and
     (BloccaStampa) then
  begin
    MsgBox.WebMessageDlg(A000MSG_R003_MSG_STAMPA_BLOCCATA,mtInformation,[mbOk],nil,'');
    Exit;
  end;
  inherited;
end;

function TWR003FGeneratoreStampe.BloccaStampa: Boolean;
begin
  Result:=SolaLettura;
  if (not SolaLettura) then
  begin
   if (WR302DM <> nil) and (WR302DM.selTabella.Active) and (WR302DM.selTabella.FieldByName('STAMPA_BLOCCATA').AsString = 'S') then
     Result:=not Parametri.ModificaDatiProtetti;
  end;
end;

procedure TWR003FGeneratoreStampe.actCopiaSuExecute(Sender: TObject);
var
  WC020FInputDataOreFM: TWC020FInputDataOreFM;
begin
  WC020FInputDataOreFM:=TWC020FInputDataOreFM.Create(Self);
  WC020FInputDataOreFM.ImpostaCampiText('Codice stampa:','');
  WC020FInputDataOreFM.ResultEvent:=ResultWC020;
  WC020FInputDataOreFM.Visualizza('Copia su');
end;

procedure TWR003FGeneratoreStampe.RefreshPage;
begin
  inherited;
  with (WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW do
  begin
    selT002.Refresh;
    selT909.Refresh;
    ElencoDatiCalcolati;
  end;
  (WDettaglioFM as TWR003FGeneratoreStampeDettFM).CaricaLstDatiSerbatoio;
end;

procedure TWR003FGeneratoreStampe.ResultWC020(Sender: TObject; Result: Boolean; Valore: String);
var
  Msg: String;
  StrSQL,lstErrors: TStringList;
  lstCodiciTabCollegate: TList<TCodiciTabCollegate>;
begin
  if Result then
  begin
    with (WR302DM as TWR003FGeneratoreStampeDM) do
    begin
      Msg:=R003FGeneratoreStampeMW.VerificaNomeDuplica(Valore);
      if Msg <> '' then
      begin
        MsgBox.WebMessageDlg(Msg,mtError,[mbOk],nil,'');
        Exit;
      end;

      StrSQL:=TStringList.Create;
      lstCodiciTabCollegate:=getListCodiciSelezionati;
      R003FGeneratoreStampeMW.DuplicaStampa(StrSQL,Valore,lstCodiciTabCollegate);
      FreeAndNil(lstCodiciTabCollegate);

      lstErrors:=R003FGeneratoreStampeMW.EseguiDuplicaStampa(StrSql);
      FreeAndNil(StrSQL);
      if lstErrors.Count > 0 then
      begin
        MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_ELAB_ANOM,[CHR(10) + lstErrors.text]) ,mtInformation,[mbOK],nil,'');
      end
      else
      begin
        selTabella.Refresh;
        selTabella.SearchRecord('CODICE',Valore,[srFromBeginning]);
        WBrowseFM.grdTabella.medpAggiornaCDS;
      end;
      FreeAndNil(lstErrors);
    end;
  end;
end;

procedure TWR003FGeneratoreStampe.selTabellaStateChange(DataSet: TDataSet);
{Selezione anagrafica sempre attiva, anche in modifica}
begin
  inherited;
  if (grdC700 <> nil) and WR100LinkWC700 then
    grdC700.AbilitaToolbar(True);
end;

procedure TWR003FGeneratoreStampe.actEliminaExecute(Sender: TObject);
begin
  if BloccaStampa then
  begin
    MsgBox.WebMessageDlg(A000MSG_R003_MSG_STAMPA_BLOCCATA,mtInformation,[mbOk],nil,'');
    Exit;
  end;
  inherited;
end;

procedure TWR003FGeneratoreStampe.actEsportaStampaExecute(Sender: TObject);
var lst: TStringList;
  lstCodiciTabCollegate:TList<TCodiciTabCollegate>;
  SS: TStringStream;
begin
  inherited;
  with (WR302DM as TWR003FGeneratoreStampeDM) do
  begin
    if SelTabella.RecordCount = 0 then
      Exit;
    try
      lst:=TStringList.Create;
      lstCodiciTabCollegate:=getListCodiciSelezionati;
      R003FGeneratoreStampeMW.DuplicaStampa(lst,'',lstCodiciTabCollegate);
      SS:=TStringStream.Create('');
      lst.SaveToStream(SS);
      GGetWebApplicationThreadVar.SendStream(SS,true,'application/x-download',SelTabella.FieldByName('CODICE').AsString + '.sql');
      TA000FInterfaccia(gSC).SegnaSessioneAttiva;
    finally
      FreeAndNil(lst);
      FreeAndNil(lstCodiciTabCollegate);
    end;
  end;
end;

procedure TWR003FGeneratoreStampe.actImportaStampaExecute(Sender: TObject);
var
  WC025FUploadFile: TWC025FUploadFileFM;
begin
  inherited;
  WC025FUploadFile:=TWC025FUploadFileFM.Create(Self);
  WC025FUploadFile.Visualizza('Importa stampa','Stampa da importare');
  WC025FUploadFile.ResultEvent:=ImportaResultEvent;
end;

procedure TWR003FGeneratoreStampe.actInterrogazioniServizioExecute(
  Sender: TObject);
var
  DataDa: TDateTime;
  DataA: TDateTime;
  Params, sql: string;
begin
  inherited;
  try
    DataDa:=StrToDate(edtDal.Text);
  except
    DataDa:=DATE_NULL;
  end;
  try
    DataA:=StrToDate(edtAl.Text);
  except
    DataA:=DATE_NULL;
  end;

  sql:=(WR302DM AS TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW.SQLInterrogazioniServizio(DataDa, DataA);
  Params:='SQL=' + sql;
  AccediForm(31,Params,False);
end;

procedure TWR003FGeneratoreStampe.ImportaResultEvent(Sender:TObject;Result:Boolean; FileName:String);
var
  Lst: TStringList;
begin
  if Result then
  begin
    try
      Lst:=(WR302DM AS TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW.ImportaStampa(FileName);
      if Lst.Count > 0 then
      begin
        MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_ELAB_ANOM,[CHR(10) + Lst.text]) ,mtInformation,[mbOK],nil,'');
      end;
    finally
      FreeAndNil(Lst);
    end;
    WBrowseFM.grdTabella.medpAggiornaCDS(True);
    AggiornaRecord;
  end;
end;

function TWR003FGeneratoreStampe.ActionForDownload(action: TAction): boolean;
begin
  if action = actEsportaStampa then
    Result:=True
  else
    Result:=False;
end;

procedure TWR003FGeneratoreStampe.actModificaExecute(Sender: TObject);
begin
  WR302DM.selTabella.RefreshRecord;
  inherited;
end;

procedure TWR003FGeneratoreStampe.actStampaPDFExecute(Sender: TObject);
begin
  TipoGenerazione:=tgPDF;
  if WR302DM.selTabella.State <> dsBrowse then
  begin
    (WR302DM as TWR003FGeneratoreStampeDM).CreaStampaTempB028(GGetWebApplicationThreadVar.AppID);
    CallCOMServer(GGetWebApplicationThreadVar.AppID);
  end
  else
    CallCOMServer;
end;

procedure TWR003FGeneratoreStampe.actSalvaSuFileExecute(Sender: TObject);
begin
  inherited;
  if Sender = btnGeneraXLS then
    TipoGenerazione:=tgXLS
  else
    TipoGenerazione:=tgXLSX;
  if WR302DM.selTabella.State <> dsBrowse then
  begin
    (WR302DM as TWR003FGeneratoreStampeDM).CreaStampaTempB028(GGetWebApplicationThreadVar.AppID);
    CallCOMServer(GGetWebApplicationThreadVar.AppID);
  end
  else
    CallCOMServer;
end;

procedure TWR003FGeneratoreStampe.actTabellaExecute(Sender: TObject);
begin
  if WR302DM.selTabella.FieldByName('TABELLA_GENERATA').AsString = '' then
  begin
    MsgBox.WebMessageDlg(A000MSG_R003_MSG_NO_TABELLA,mtInformation,[mbOk],nil,'');
    Exit;
  end;

  TipoGenerazione:=tgTable;
  if WR302DM.selTabella.State <> dsBrowse then
  begin
    (WR302DM as TWR003FGeneratoreStampeDM).CreaStampaTempB028(GGetWebApplicationThreadVar.AppID);
    CallCOMServer(GGetWebApplicationThreadVar.AppID);
  end
  else
    CallCOMServer;
end;

procedure TWR003FGeneratoreStampe.actTabellaOnlyExecute(Sender: TObject);
begin
  CheckGeneraTabellaOnly;
end;

procedure TWR003FGeneratoreStampe.CheckGeneraTabellaOnly;
var
  msg:String;
begin
  inherited;
  C004_WR003.selT001.Refresh;
  LastExec_Time:=C004_WR003.GetParametro('LASTEXEC_TIME','');
  LastExec_App:=C004_WR003.GetParametro('LASTEXEC_APP','');
  LastExec_Codice:=C004_WR003.GetParametro('LASTEXEC_CODICE','');
  LastExec_Dal:=C004_WR003.GetParametro('LASTEXEC_DAL','');
  LastExec_Al:=C004_WR003.GetParametro('LASTEXEC_AL','');
  LastExec_Anagra:=C004_WR003.GetParametro('LASTEXEC_ANAGRA','');

  if LastExec_Codice = '' then
  begin
    raise Exception.Create('Non è disponibile nessuna elaborazione precedente!');
    MsgBox.MessageBox('Non è disponibile nessuna elaborazione precedente!',ERRORE);
    Exit;
  end;

  if LastExec_App <> Parametri.Applicazione then
  begin
    raise Exception.Create('L''elaborazione precedente è stata generata con l''applicativo "' + LastExec_App + '"');
    MsgBox.MessageBox('L''elaborazione precedente è stata generata con l''applicativo "' + LastExec_App + '"',ERRORE);
    Exit;
  end;

  if grdC700.selAnagrafe.RecordCount = 0 then
  begin
    raise Exception.Create(A000MSG_ERR_NO_DIP);
    MsgBox.MessageBox(A000MSG_ERR_NO_DIP,ERRORE);
    Exit;
  end;

  msg:=CRLF +
       'Stampa: ' + LastExec_Codice + CRLF +
       'Periodo: ' + LastExec_Dal  + ' - ' + LastExec_Al + CRLF +
       'Anagrafiche: ' + LastExec_Anagra + CRLF +
       'Eseguita il: ' + LastExec_Time + CRLF;

  MsgBox.WebMessageDlg('La tabella verrà generata a partire da questa elaborazione:' + CRLF + msg + CRLF + 'Proseguire?',mtConfirmation,[mbYes,mbNo],ResultGeneraTabellaOnly,'')
end;

procedure TWR003FGeneratoreStampe.ResultGeneraTabellaOnly(Sender:TObject; R:TmeIWModalResult; KI:String);
begin
  if R <> mrYes then
    exit;

  if VarToStr(WR302DM.selTabella.Lookup('CODICE',LastExec_Codice,'TABELLA_GENERATA')) = '' then
  begin
    raise Exception.Create('La stampa non consente la generazione della tabella!');
    MsgBox.MessageBox('La stampa non consente la generazione della tabella!',ERRORE);
    Exit;
  end;

  if not WR302DM.selTabella.SearchRecord('CODICE',LastExec_Codice,[srFromBeginning]) then
  begin
    raise Exception.Create('Stampa "' + LastExec_Codice + '" non disponibile!');
    MsgBox.MessageBox('Stampa "' + LastExec_Codice + '" non disponibile!',ERRORE);
    Exit;
  end;

  WR302DM.selTabella.AfterScroll:=nil;
  WBrowseFM.grdTabella.medpAggiornaCDS(False);
  WR302DM.selTabella.AfterScroll:=WR302DM.AfterScroll;
  AggiornaRecord;

  edtDal.Text:=LastExec_Dal;
  edtAl.Text:=LastExec_Al;

  TipoGenerazione:=tgTable;
  CallCOMServer;
  //Attivazione qui di GeneraTabellaOnly in modo che sia utilizzabile da CreateJSonString
  GeneraTabellaOnly:=True;
end;

procedure TWR003FGeneratoreStampe.CallCOMServer(pCodice:String = '');
var DataI,DataF:TDateTime;
begin
  GeneraTabellaOnly:=False;
  if grdC700.selAnagrafe.RecordCount = 0 then
  begin
    MsgBox.MessageBox(A000MSG_ERR_NO_DIP,ERRORE);
    Exit;
  end;
  if pCodice = '' then
    CodiceStampa:=Trim(Copy(StringReplace(WBrowseFM.grdTabella.medpClientDataSet.FieldByName('CODICE').AsString,' ',' ',[rfReplaceAll]),1,30))
  else
    CodiceStampa:=pCodice;
  if CodiceStampa = '' then
  begin
    MsgBox.MessageBox(A000MSG_R003_MSG_SPECIFICARE_STAMPA,ERRORE);
    exit;
  end;
  DataI:=StrToDate(edtDal.Text);
  DataF:=StrToDate(edtAl.Text);
  if DataF < DataI then
  begin
    MsgBox.MessageBox(A000MSG_R003_ERR_DATE_NON_CORRETTE,ERRORE);
    exit;
  end;
  if R180Anno(DataI) < R180Anno(DataF) - 19 then
  begin
    MsgBox.MessageBox(A000MSG_R003_MSG_PERIODO_MAGGIORE_20_ANNI,ERRORE);
    exit;
  end;

  // Inizio elaborazione
  StartElaborazioneServer(btnSendFile.HTMLName,True);
end;

function TWR003FGeneratoreStampe.ConvertiInValutaVisible(Val: String): boolean;
begin
  //Per P077 ridefinire
  Result:=False;
end;

procedure TWR003FGeneratoreStampe.ElaborazioneServer;
begin
  DettaglioLog:='';
  MsgFileNonCreato:=A000MSG_ERR_TAB_NON_COMPATIBILE;
  DCOMNomeFile:='';
  DatiUtente:=CreateJSonString;
  //Per l'azione di creazione tabella richiamo il COMServer con DCOMNomeFile=''
  if TipoGenerazione <> tgTable then
  begin
    //if rgpFormatoStampa.ItemIndex = 0 then
    if TipoGenerazione = tgPDF then
      DCOMNomeFile:=GetNomeFile('pdf')
    else if TipoGenerazione = tgXLS then
      DCOMNomeFile:=GetNomeFile('xls')
    else // tgXLSX
      DCOMNomeFile:=GetNomeFile('xlsx');
    ForceDirectories(ExtractFileDir(DCOMNomeFile));
  end;

  if (not IsLibrary) and
     (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then // gestione parametri di configurazione su file
    CoInitialize(nil);
  // in caso di errore indica qual è il server DCOM in modo da facilitare la risoluzione del problema
  try
    if not DCOMConnection.Connected then
      DCOMConnection.Connected:=True;
  except
    on E: Exception do
    begin
      E.Message:=Format('%s: %s',[DCOMConnection.ServerName,E.Message]);
      raise;
    end;
  end;
  try
    DCOMPrint;
  finally
    DCOMConnection.Connected:=False;
    TipoGenerazione:=tgPDF;
    DCOMMsg:=DettaglioLog;
    (WR302DM as TWR003FGeneratoreStampeDM).EliminaStampaTempB028(GGetWebApplicationThreadVar.AppID);

    if WR302DM.selTabella.State = dsBrowse then
      WR302DM.selTabella.RefreshRecord;
    C004_WR003.selT001.Refresh;
    actTabellaOnly.Visible:=C004_WR003.GetParametro('LASTEXEC_CODICE','') <> '';
    AggiornaToolBar(grdComandi,actlstComandi);
  end;
end;

procedure TWR003FGeneratoreStampe.EseguiDelete;
begin
  //non eseguire inherited perchè elimina fisicamente il record
  //in questo caso usa il cestino
  (WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW.CancellaT910;
  WBrowseFM.grdTabella.medpAggiornaCDS;

  if InterfacciaWR102.GestioneStoricizzata then
    GetDateDecorrenza;
  AggiornaRecord;
end;

function TWR003FGeneratoreStampe.CreateJSonString: String;
var json: TJSONObject;
begin
  json:=TJSONObject.Create;
  try
    //Popolo il json con i valori necessari al B028 per creare il PDF per la stampa
    json.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
    C190Comp2JsonString(edtDal,json);
    C190Comp2JsonString(edtAl,json);
    json.AddPair('CodiceStampa',CodiceStampa);
    //Le tabelle temporanee non devono essere cancellate (come nei progetti win)
    json.AddPair('DropTabelleTemp','N');
    //Parametro per generare tabella finale partendo da tabelle temporanee preesistenti
    if GeneraTabellaOnly then
      json.AddPair('GeneraTabellaOnly','S');
    Result:=json.ToString;
  finally
    FreeAndNil(json);
  end;
end;

function TWR003FGeneratoreStampe.InizializzaAccesso: Boolean;
begin
  //SearchRecord per scatenare dataset2Componenti e caricare correttamente checklist elementi del primo elemento all'apertura
  WR302DM.selTabella.SearchRecord('CODICE',WR302DM.selTabella.FieldByName('CODICE').AsString,[srFromBeginning]);
  Result:=True;
end;

procedure TWR003FGeneratoreStampe.InizializzaMsgElaborazione;
begin
  inherited;
  if TipoGenerazione = tgTable then
    with WC022FMsgElaborazioneFM do
    begin
      Titolo:='Creazione Tabella';
      Messaggio:='Creazione Tabella in corso...';
      ImgFileName:=IMG_FILENAME_ELABORAZIONE;
    end
  else //if rgpFormatoStampa.ItemIndex = 1 then
    if TipoGenerazione = tgXLS then
    begin
      with WC022FMsgElaborazioneFM do
      begin
        //Scelgo il formato xls
        Titolo:=A000MSG_MSG_ELABORAZIONE;
        Messaggio:=A000MSG_MSG_ELABORAZIONE_XLS_IN_CORSO;
        ImgFileName:=IMG_FILENAME_XLS;
      end;
    end
    else if TipoGenerazione = tgXLSX then
    begin
      with WC022FMsgElaborazioneFM do
      begin
        //Scelgo il formato xlsx
        Titolo:=A000MSG_MSG_ELABORAZIONE;
        Messaggio:=A000MSG_MSG_ELABORAZIONE_XLSX_IN_CORSO;
        ImgFileName:=IMG_FILENAME_XLSX;
      end;
    end;
end;

procedure TWR003FGeneratoreStampe.CreaToolbarComandi(actlst: TActionList; grdToolbar: TmeIWGrid; _onClick: TprocSender);
var
  i, k:Integer;
  PrecCategory: String;
begin
  grdToolbar.RowCount:=1;
  grdToolbar.ColumnCount:=actlst.ActionCount;
  if actlst.ActionCount > 0 then
    PrecCategory:=TAction(actlst.Actions[0]).Category;
  k:=0;
  for i:=0 to actlst.ActionCount - 1 do
  begin
    if PrecCategory <> TAction(actlst.Actions[i]).Category  then
    begin
      grdToolbar.Cell[0,k].Css:='x';
      grdToolbar.Cell[0,k].Text:='';
      k:=k + 1;
      grdToolbar.ColumnCount:=grdToolbar.ColumnCount + 1;
      PrecCategory:=TAction(actlst.Actions[i]).Category;
    end;

    if (actlst.Actions[i] as TAction).Name = 'actLblDal' then
      grdToolbar.Cell[0,k].Control:=lblDal
    else if (actlst.Actions[i] as TAction).Name = 'actEdtDal' then
      grdToolbar.Cell[0,k].Control:=edtDal
    else if (actlst.Actions[i] as TAction).Name = 'actLblAl' then
      grdToolbar.Cell[0,k].Control:=lblAl
    else if (actlst.Actions[i] as TAction).Name = 'actEdtAl' then
      grdToolbar.Cell[0,k].Control:=edtAl
    else if (actlst.Actions[i] as TAction).Name = 'actStampaPDF' then
      grdToolbar.Cell[0,k].Control:=btnGeneraPDF
    else if (actlst.Actions[i] as TAction).Name = 'actStampaXLS' then
      grdToolbar.Cell[0,k].Control:=btnGeneraXLS
    else if (actlst.Actions[i] as TAction).Name = 'actTabella' then
      grdToolbar.Cell[0,k].Control:=btnGeneraTabella
    else if (actlst.Actions[i] as TAction).Name = 'actTabellaOnly' then
      grdToolbar.Cell[0,k].Control:=btnGeneraTabellaOnly
    else if (actlst.Actions[i] as TAction).Name = 'actStampaXLSX' then
      grdToolbar.Cell[0,k].Control:=btnSalvaTabella
    else
    begin
      grdToolbar.Cell[0,k].Control:=TmeIWImageFile.Create(Self);
      with TmeIWImageFile(grdToolbar.Cell[0,k].Control) do
      begin
        Name:=C190CreaNomeComponente(TAction(actlst.Actions[i]).Name,Self);
        OnClick:=_onClick;
        Tag:=i;
      end;
      grdToolbar.Cell[0,k].Css:='x';
      grdToolbar.Cell[0,k].Text:='';
    end;
    k:=k + 1;
  end;
  AggiornaToolBar(grdToolbar,actlst);
end;

procedure TWR003FGeneratoreStampe.edtAlAsyncDoubleClick(Sender: TObject;
  EventParams: TStringList);
begin
  try
    edtAl.Text:=DateToStr(R180FineMese(StrToDate(edtDal.Text)));
  except
  end;
end;

procedure TWR003FGeneratoreStampe.imgComandiClick(Sender: TObject);
begin
  MessaggioStatus(INFORMA,'');
  TAction(actlstComandi.Actions[TmeIWImageFile(Sender).Tag]).Execute;
end;

function TWR003FGeneratoreStampe.VerificaSelezioneC700: boolean;
begin
  //inibisce controllo dipendente selezionato
  Result:=True;
end;

procedure TWR003FGeneratoreStampe.ImpostazioniWC700;
begin
  grdC700.WC700FM.C700DatiSelezionati:=C700CampiBase+' ,V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,V430.T430DATADECORRENZA,V430.T430DATAFINE';
  grdC700.AttivaBrowse:=False;
  grdC700.AttivaLabel:=False;
end;

procedure TWR003FGeneratoreStampe.WC700AperturaSelezione(Sender: TObject);
var
  D: TDateTime;
begin
  if TryStrToDate(edtDal.Text,D) then
    grdC700.WC700FM.C700DataDal:=D;

  if TryStrToDate(edtAl.Text,D) then
    grdC700.WC700FM.C700DataLavoro:=D;
end;

end.
