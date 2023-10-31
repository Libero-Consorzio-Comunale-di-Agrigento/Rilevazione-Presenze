unit A154UGestioneDocumentale;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, A000USessione, A000UInterfaccia, A000UCostanti, A000UMessaggi,
  C013UCheckList, C015UElencoValori, C180FunzioniGenerali, C700USelezioneAnagrafe,
  R001UGESTTAB, SelAnagrafe, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  Grids, DBGrids, checklst, System.Actions, Vcl.StdCtrls, Vcl.Mask, Winapi.ShellAPI,
  Vcl.DBCtrls, Vcl.ExtCtrls, System.IOUtils, C021UDocumentiManagerDM,
  Vcl.Buttons, C020UVisualizzaDataSet, Oracle, OracleData, A154UGestioneDocumentaleMW,
  System.ImageList;

type
  TA154FGestioneDocumentale = class(TR001FGestTab)
    frmSelAnagrafe: TfrmSelAnagrafe;
    dgrdDocumenti: TDBGrid;
    pnlDettaglio: TPanel;
    dedtID: TDBEdit;
    dedtDataCreazione: TDBEdit;
    dedtPeriodoDal: TDBEdit;
    dedtPeriodoAl: TDBEdit;
    lblID: TLabel;
    lblDataCreazione: TLabel;
    lblNote: TLabel;
    lblProprietario: TLabel;
    lblPeriodoDal: TLabel;
    lblPeriodoAl: TLabel;
    dedtDNomeFile: TDBEdit;
    lblNomeFile: TLabel;
    btnSelezionaFile: TButton;
    lblTipologia: TLabel;
    lblUfficio: TLabel;
    ActionList2: TActionList;
    actFileDownload: TAction;
    actFileVisualizza: TAction;
    lblDimensione: TLabel;
    dedtDDimensione: TDBEdit;
    dedtDProprietario: TDBEdit;
    dcmbTipologia: TDBLookupComboBox;
    dcmbUfficio: TDBLookupComboBox;
    pmnTabelle: TPopupMenu;
    actAccediTabella: TAction;
    mnuAccediTabella: TMenuItem;
    dmemNote: TDBMemo;
    pmnDocumenti: TPopupMenu;
    mnuCopiaExcel: TMenuItem;
    dlgFileOpen: TOpenDialog;
    dlgFileSave: TSaveDialog;
    Salva1: TMenuItem;
    Apri1: TMenuItem;
    N4: TMenuItem;
    dchkAccessoResponsabile: TDBCheckBox;
    N5: TMenuItem;
    actResetLettura: TAction;
    dedtDDatiAccesso: TDBEdit;
    lblDatiAccesso: TLabel;
    Resetlettura1: TMenuItem;
    lblDataLetturaProgressivo: TLabel;
    dedtDataLetturaProgressivo: TDBEdit;
    grpBoxAutoCertificazioni: TGroupBox;
    lblDataRichiestaEnte: TLabel;
    lblDataRicezioneEnte: TLabel;
    dChkAutocertificazione: TDBCheckBox;
    dchkRichiedereEnte: TDBCheckBox;
    dEdtDataRichiestaEnte: TDBEdit;
    dEdtDataRicezioneEnte: TDBEdit;
    dEdtDataRilascio: TDBEdit;
    lblDataRilascio: TLabel;
    drgpPathStorage: TDBRadioGroup;
    btnEMailAllegato: TBitBtn;
    dchkAccessoPortale: TDBCheckBox;
    lblFamiliare: TLabel;
    dcmbFamiliare: TDBComboBox;
    lbld_Familiare: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnSelezionaFileClick(Sender: TObject);
    procedure actFileDownloadExecute(Sender: TObject);
    procedure actFileVisualizzaExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure actAccediTabellaExecute(Sender: TObject);
    procedure pmnTabellePopup(Sender: TObject);
    procedure mnuCopiaExcelClick(Sender: TObject);
    procedure actResetLetturaExecute(Sender: TObject);
    procedure pmnDocumentiPopup(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure dChkAutocertificazioneClick(Sender: TObject);
    procedure btnEMailAllegatoClick(Sender: TObject);
    procedure dcmbFamiliareExit(Sender: TObject);
    procedure TRegisClick(Sender: TObject);
  private
    FC021DM: TC021FDocumentiManagerDM;
    procedure CambiaProgressivo;
    procedure AggiornaAccesso;
    procedure AbilitazioniAutocertificazioni;
  public
    ParID: Integer;
    procedure GestioneAfterScroll;
  end;

var
  A154FGestioneDocumentale: TA154FGestioneDocumentale;

procedure OpenA154GestioneDocumentale(Prog:LongInt; PId: Integer);

implementation

uses A154UGestioneDocumentaleDtM;

{$R *.dfm}

procedure OpenA154GestioneDocumentale(Prog:LongInt; PId: Integer);
begin
  if Prog <= 0 then
  begin
    R180MessageBox('Nessun dipendente selezionato!',INFORMA);
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA154GestioneDocumentale') of
    'N':begin
          R180MessageBox('Funzione non abilitata!',INFORMA);
          Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A154FGestioneDocumentale:=TA154FGestioneDocumentale.Create(nil);
  with A154FGestioneDocumentale do
  try
    A154FGestioneDocumentaleDtM:=TA154FGestioneDocumentaleDtM.Create(nil);
    C700Progressivo:=Prog;
    ParID:=PId;
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A154FGestioneDocumentaleDtM.Free;
    Free;
  end;
end;

procedure TA154FGestioneDocumentale.AbilitazioniAutocertificazioni;
begin
  dchkRichiedereEnte.Enabled:=dChkAutocertificazione.Checked;
  dEdtDataRichiestaEnte.Enabled:=dChkAutocertificazione.Checked;
  dEdtDataRicezioneEnte.Enabled:=dChkAutocertificazione.Checked;
  lblDataRichiestaEnte.Enabled:=dChkAutocertificazione.Checked;
  lblDataRicezioneEnte.Enabled:=dChkAutocertificazione.Checked;
end;

procedure TA154FGestioneDocumentale.FormCreate(Sender: TObject);
begin
  inherited;

  // inizializzazioni
  ParID:=0;

  // aggiunge tipi di file alla dialog di apertura e download file
  dlgFileSave.Filter:='Tutti i file|*.*';
  dlgFileOpen.Filter:='Tutti i file|*.*';

  // impostazione campi
  dedtID.ReadOnly:=True;
  dedtDataCreazione.ReadOnly:=True;
  dedtDNomeFile.ReadOnly:=True;
  dedtDProprietario.ReadOnly:=True;

  // abilitazione pulsanti
  btnSelezionaFile.Enabled:=False;
  actFileVisualizza.Enabled:=False;
  actFileDownload.Enabled:=False;
  dcmbFamiliare.Enabled:=False;
end;

procedure TA154FGestioneDocumentale.FormShow(Sender: TObject);
begin
  inherited;

  // scorciatoia per datamodulo di servizio per allegati
  FC021DM:=A154FGestioneDocumentaleDtM.A154MW.C021DM;

  DButton.DataSet:=A154FGestioneDocumentaleDtM.selT960;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,2,True);
  frmSelAnagrafe.NumRecords;

  // combobox
  dcmbTipologia.ListSource:=A154FGestioneDocumentaleDtM.A154MW.dsrT962Lookup;
  dcmbUfficio.ListSource:=A154FGestioneDocumentaleDtM.A154MW.dsrT963Lookup;

  // posizionamento sul record eventualmente indicato
  if ParID > 0 then
    A154FGestioneDocumentaleDtM.selT960.SearchRecord('ID',ParID,[srFromBeginning]);
  AbilitazioniAutocertificazioni;

  drgpPathStorage.Visible:=A154FGestioneDocumentaleDtM.A154MW.ModuloGestioneDocumentale;
  lblNomeFile.Visible:=A154FGestioneDocumentaleDtM.A154MW.ModuloGestioneDocumentale;
  dedtDNomeFile.Visible:=A154FGestioneDocumentaleDtM.A154MW.ModuloGestioneDocumentale;
  btnSelezionaFile.Visible:=A154FGestioneDocumentaleDtM.A154MW.ModuloGestioneDocumentale;
  lblDimensione.Visible:=A154FGestioneDocumentaleDtM.A154MW.ModuloGestioneDocumentale;
  dedtDDimensione.Visible:=A154FGestioneDocumentaleDtM.A154MW.ModuloGestioneDocumentale;
  btnEMailAllegato.Visible:=A154FGestioneDocumentaleDtM.A154MW.ModuloGestioneDocumentale;

  if not A154FGestioneDocumentaleDtM.A154MW.ModuloGestioneDocumentale then
    dgrdDocumenti.PopupMenu:=nil;
  dgrdDocumenti.Columns[R180GetColonnaDBGrid(dgrdDocumenti,'D_NOME_FILE')].Visible:=A154FGestioneDocumentaleDtM.A154MW.ModuloGestioneDocumentale;
  dgrdDocumenti.Columns[R180GetColonnaDBGrid(dgrdDocumenti,'D_DIMENSIONE')].Visible:=A154FGestioneDocumentaleDtM.A154MW.ModuloGestioneDocumentale;
  dgrdDocumenti.Columns[R180GetColonnaDBGrid(dgrdDocumenti,'AUTOCERTIFICAZIONE')].Visible:=A154FGestioneDocumentaleDtM.A154MW.ModuloGestioneDocumentale;
  dgrdDocumenti.Columns[R180GetColonnaDBGrid(dgrdDocumenti,'DATA_NOTIFICA')].Visible:=A154FGestioneDocumentaleDtM.A154MW.ModuloGestioneDocumentale;
end;

procedure TA154FGestioneDocumentale.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
  inherited;
end;

procedure TA154FGestioneDocumentale.GestioneAfterScroll;
begin
  NumRecords;
end;

procedure TA154FGestioneDocumentale.mnuCopiaExcelClick(Sender: TObject);
begin
  R180DBGridCopyToClipboard(dgrdDocumenti,True,False,True);
end;

procedure TA154FGestioneDocumentale.pmnDocumentiPopup(Sender: TObject);
begin
  inherited;
  actResetLettura.Enabled:=(not SolaLettura) and (not DButton.DataSet.FieldByName('UTENTE_ACCESSO').IsNull);
end;

procedure TA154FGestioneDocumentale.pmnTabellePopup(Sender: TObject);
begin
  actAccediTabella.Enabled:=not SolaLettura;
end;

procedure TA154FGestioneDocumentale.TRegisClick(Sender: TObject);
begin
  //se sono in insert
  if A154FGestioneDocumentaleDtM.A154MW.selT960_Funzioni.State = dsInsert then
    if A154FGestioneDocumentaleDtM.A154MW.CheckVersionabile then    //se la tipologia selezionata è versionabile
      if A154FGestioneDocumentaleDtM.A154MW.CheckVersioniPresenti then   //se sono già presenti delle altre versioni dello stesso documento
        if MessageDlg(A000MSG_A154_DLG_NUOVA_VERSIONE,mtConfirmation,[mbYes,mbNo],0) <> mrYes then
          Exit;

  //se sono in edit e cambio tipologia
  if (A154FGestioneDocumentaleDtM.A154MW.selT960_Funzioni.State = dsEdit) and A154FGestioneDocumentaleDtM.A154MW.CambioTipologia then
    if A154FGestioneDocumentaleDtM.A154MW.CheckVersionabile then    //se la tipologia selezionata è versionabile
      if A154FGestioneDocumentaleDtM.A154MW.CheckVersioniPresenti then   //se sono già presenti delle altre versioni dello stesso documento
        if MessageDlg(A000MSG_A154_DLG_NUOVA_VERSIONE,mtConfirmation,[mbYes,mbNo],0) <> mrYes then
          Exit;

  inherited;
end;

procedure TA154FGestioneDocumentale.actAccediTabellaExecute(Sender: TObject);
var
  LNomeTabella: string;
  LComp: TComponent;
  ODS: TOracleDataSet;
  vCodice:Variant;
begin
  // estrae il componente che ha richiamato la action
  LComp:=(Sender as TAction).ActionComponent;

  if LComp is TMenuItem then
  begin
    // il componente è un item di menu -> recupera componente che ha richiamato il popup
    LComp:=(TMenuItem(LComp).GetParentMenu as TPopupMenu).PopupComponent;

    if LComp = dcmbTipologia then
    begin
      // tabella T962_TIPO_DOCUMENTI
      ODS:=A154FGestioneDocumentaleDtM.A154MW.selT962;
      LNomeTabella:='Tipologie documenti';
      vCodice:=dcmbTipologia.KeyValue;
    end
    else if LComp = dcmbUfficio then
    begin
      // tabella T963_UFFICIO_DOCUMENTI
      ODS:=A154FGestioneDocumentaleDtM.A154MW.selT963;
      LNomeTabella:='Uffici';
      vCodice:=dcmbUfficio.KeyValue;
    end
    else
      Exit;

    // riapre dataset per modifiche a tabella
    ODS.Close;
    ODS.Open;

    // gestione tabella
    OpenC015FElencoValori(R180Query2NomeTabella(ODS),
                          Format('<A154> %s',[LNomeTabella]),
                          ODS.SQL.Text,
                          'CODICE',vCodice,ODS,650);

    // riapre dataset
    ODS.Close;
    ODS.Open;
    with A154FGestioneDocumentaleDtM.A154MW do
    begin
      selT962Lookup.Refresh;
      selT963Lookup.Refresh;
    end;
  end;
end;

procedure TA154FGestioneDocumentale.actFileDownloadExecute(Sender: TObject);
// effettua il download dell'allegato
var
  LId: Integer;
  LDoc: TDocumento;
  LFileName: String;
  LResCtrl: TResCtrl;
begin
  // estrae id allegato
  LId:=DButton.DataSet.FieldByName('ID').AsInteger;

  // se l'id non è valido esce immediatamente
  if LId <= 0 then
    Exit;

  // estrae info documento da db
  Screen.Cursor:=crHourGlass;
  try
    try
      // estrae il file con i metadati associati
      LResCtrl:=FC021DM.GetById(LId,True,LDoc);
      if not LResCtrl.Ok then
      begin
        R180MessageBox(LResCtrl.Messaggio,ESCLAMA);
        Exit;
      end;

      // dialog per richiesta destinazione file
      {$WARN SYMBOL_PLATFORM OFF}
      dlgFileSave.Title:='Selezionare destinazione';
      dlgFileSave.FileName:=LDoc.GetNomeFileCompleto;
      if dlgFileSave.Execute then
      begin
        // il file è stato selezionato
        LFileName:=dlgFileSave.FileName;
        // cancella eventuale file già esistente
        if TFile.Exists(LFileName) then
          TFile.Delete(LFileName);
        TFile.Move(LDoc.FilePath,LFileName);
        // aggiorna i dati di accesso al documento
        AggiornaAccesso;
      end;
      {$WARN SYMBOL_PLATFORM ON}
    except
      on E: Exception do
      begin
        R180MessageBox(Format(A000TraduzioneStringhe(A000MSG_A154_ERR_FMT_DOC_SALVA),[E.Message]),ESCLAMA);
        Exit;
      end;
    end;
  finally
    FreeAndNil(LDoc);
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA154FGestioneDocumentale.actFileVisualizzaExecute(Sender: TObject);
// apre il documento allegato utilizzando la shellexecute
var
  LId: Integer;
  LDoc: TDocumento;
  LResCtrl: TResCtrl;
begin
  // estrae id allegato
  LId:=DButton.DataSet.FieldByName('ID').AsInteger;

  // se l'id non è valido esce immediatamente
  if LId <= 0 then
    Exit;

  // estrae info documento da db
  Screen.Cursor:=crHourGlass;
  try
    try
      // estrae il file con i metadati associati
      LResCtrl:=FC021DM.GetById(LId,True,LDoc);
      if not LResCtrl.Ok then
      begin
        R180MessageBox(LResCtrl.Messaggio,ESCLAMA);
        Exit;
      end;

      // apre il documento con il visualizzatore associato
      ShellExecute(0,'open',PChar(LDoc.FilePath),nil,nil,SW_SHOWNORMAL);
      // aggiorna i dati di accesso al documento
      AggiornaAccesso;
    except
      on E: Exception do
      begin
        R180MessageBox(Format(A000TraduzioneStringhe(A000MSG_A154_ERR_FMT_DOC_APRI),[E.Message]),ESCLAMA);
        Exit;
      end;
    end;
  finally
    FreeAndNil(LDoc);
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA154FGestioneDocumentale.actResetLetturaExecute(Sender: TObject);
var
  LId: Integer;
begin
  // verifica dataset attivo
  if not A154FGestioneDocumentaleDtM.selT960.Active then
    Exit;

  // verifica presenza di almeno un record
  if A154FGestioneDocumentaleDtM.selT960.RecordCount = 0 then
    Exit;

  // annulla i dati di lettura (data_accesso e utente_accesso)
  LId:=A154FGestioneDocumentaleDtM.selT960.FieldByName('ID').AsInteger;
  FC021DM.ResetDatiAccesso(LId);

  // refresh tabella
  A154FGestioneDocumentaleDtM.selT960.Refresh;
  A154FGestioneDocumentaleDtM.selT960.SearchRecord('ID',LId,[srFromBeginning]);
end;

procedure TA154FGestioneDocumentale.btnEMailAllegatoClick(Sender: TObject);
var
  RetSendMail:TResultElaborazione;
begin
  inherited;
  if A154FGestioneDocumentaleDtM.selT960.Active and (A154FGestioneDocumentaleDtM.selT960.RecordCount > 0) then
  begin
    RetSendMail:=A154FGestioneDocumentaleDtM.A154MW.SendMailAllegato(TDestEMailAllegato.UfficioToDipendente);
    btnEMailAllegato.Enabled:=not RetSendMail.Esito;
  end;
end;

procedure TA154FGestioneDocumentale.btnSelezionaFileClick(Sender: TObject);
// selezione di file
var
  LFileName, LNomeFile, LExtFile: string;
  LDimensioneByte: Int64;
begin
  {$WARN SYMBOL_PLATFORM OFF}
  if (DButton.State = dsEdit) and (not A154FGestioneDocumentaleDtM.A154MW.EditNomeFile) then
    Exit;

  dlgFileOpen.Title:=Format('Selezionare documento (max %d MB)',[StrToIntDef(Parametri.CampiRiferimento.C90_IterMaxDimAllegatoMB,5)]);
  //dlgFile.DefaultFolder:=//???
  if dlgFileOpen.Execute then
  begin
    // il file è stato selezionato
    LFileName:=dlgFileOpen.FileName;
    // determina cartella file
    DButton.DataSet.FieldByName('D_CARTELLA_FILE').AsString:=TPath.GetDirectoryName(LFileName);
    // determina nome + estensione
    LNomeFile:=TPath.GetFileNameWithoutExtension(LFileName);
    LExtFile:=TPath.GetExtension(LFileName).Replace(TPath.ExtensionSeparatorChar,'');
    DButton.DataSet.FieldByName('NOME_FILE').AsString:=LNomeFile;
    DButton.DataSet.FieldByName('EXT_FILE').AsString:=LExtFile;

    // dimensione
    LDimensioneByte:=R180GetFileSize(LFileName);
    DButton.DataSet.FieldByName('DIMENSIONE').AsFloat:=LDimensioneByte;
  end;
  {$WARN SYMBOL_PLATFORM ON}
end;

procedure TA154FGestioneDocumentale.CambiaProgressivo;
begin
  A154FGestioneDocumentaleDtM.A154MW.FiltraFamiliari(C700Progressivo);
  A154FGestioneDocumentaleDtM.selT960.Close;
  A154FGestioneDocumentaleDtM.selT960.SetVariable('PROGRESSIVO',C700Progressivo);
  A154FGestioneDocumentaleDtM.selT960.Open;
  dcmbFamiliare.Items.Clear;
  with A154FGestioneDocumentaleDtM.A154MW.selSG101 do
  begin
    First;
    while not eof do
    begin
      dcmbFamiliare.Items.Add(FieldByName('CODFISCALE').AsString);
      next;
    end;
  end;

  lblD_Familiare.Caption:='';
  if A154FGestioneDocumentaleDtM.A154MW.selSG101.SearchRecord('CODFISCALE',A154FGestioneDocumentaleDtM.selT960.FieldByName('CF_FAMILIARE').AsString,[srFromBeginning]) then
    lblD_Familiare.Caption:=A154FGestioneDocumentaleDtM.A154MW.selSG101.FieldByName('DENOMINAZIONE').AsString;

  NumRecords;
end;

procedure TA154FGestioneDocumentale.DButtonDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  dchkRichiedereEnte.Enabled:=(not A154FGestioneDocumentaleDtM.selT960.FieldByName('DATA_RICHIESTA_ENTE').IsNull) or
                              (not A154FGestioneDocumentaleDtM.selT960.FieldByName('DATA_RICEZIONE_ENTE').IsNull);
  AbilitazioniAutocertificazioni;
end;

procedure TA154FGestioneDocumentale.DButtonStateChange(Sender: TObject);
var
  LIsTipologiaIter: Boolean;
begin
  inherited;
  LIsTipologiaIter:=DButton.DataSet.FieldByName('TIPOLOGIA').AsString <> DOC_TIPOL_ITER;

  // abilitazione dei dati
  // dedtID.ReadOnly:=True;
  // dedtDataCreazione.ReadOnly:=True;
  btnSelezionaFile.Enabled:=(DButton.State = dsInsert) or ((DButton.State = dsEdit) and A154FGestioneDocumentaleDtM.A154MW.EditNomeFile);
  dedtPeriodoDal.Enabled:=(DButton.State <> dsEdit) or (LIsTipologiaIter);
  dedtPeriodoAl.Enabled:=dedtPeriodoDal.Enabled;
  dcmbTipologia.Enabled:=(DButton.State <> dsEdit) or (LIsTipologiaIter);
  dcmbFamiliare.Enabled:=(DButton.State = dsInsert) or (DButton.State = dsEdit);

end;

procedure TA154FGestioneDocumentale.dChkAutocertificazioneClick(
  Sender: TObject);
begin
  inherited;
   AbilitazioniAutocertificazioni;
end;

procedure TA154FGestioneDocumentale.dcmbFamiliareExit(Sender: TObject);
var ErroreCF:String;
begin
  inherited;

  with A154FGestioneDocumentaleDtM do
  begin
    if A154MW.selSG101.SearchRecord('CODFISCALE',dcmbFamiliare.Text,[srFromBeginning]) then
      A154FGestioneDocumentale.lblD_Familiare.Caption:=A154MW.selSG101.FieldByName('DENOMINAZIONE').AsString
    else
      A154FGestioneDocumentale.lblD_Familiare.Caption:='';
  end;
end;

procedure TA154FGestioneDocumentale.AggiornaAccesso;
// aggiorna i dati di accesso per la tabella indicata
var
  LId: Integer;
begin
  // verifica dataset attivo
  if not A154FGestioneDocumentaleDtM.selT960.Active then
    Exit;

  // verifica presenza di almeno un record
  if A154FGestioneDocumentaleDtM.selT960.RecordCount = 0 then
    Exit;

  // aggiorna dati accesso
  LId:=A154FGestioneDocumentaleDtM.selT960.FieldByName('ID').AsInteger;
  FC021DM.AggiornaDatiAccesso(LId,Parametri.Operatore);

  // refresh tabella
  A154FGestioneDocumentaleDtM.selT960.Refresh;
  A154FGestioneDocumentaleDtM.selT960.SearchRecord('ID',LId,[srFromBeginning]);
end;

end.
