unit W039UGestioneDocumentale;

interface

uses
  A000UInterfaccia,
  A000UCostanti,
  A000UMessaggi,
  R012UWebAnagrafico,
  W039UGestioneDocumentaleDM,
  A154UGestioneDocumentaleMW,
  A155URicercaDocumentaleMW,
  C021UDocumentiManagerDM,
  C180FunzioniGenerali,
  C190FunzioniGeneraliWeb,
  W000UMessaggi,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, IWVCLComponent,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, OracleData, IWCompGrids, IWDBGrids, medpIWDBGrid, System.StrUtils,
  IWCompListbox, meIWComboBox, IWCompEdit, meIWEdit, meIWImageFile,
  IWGlobal, IWApplication, IWCompExtCtrls, medpIWImageButton, Math,
  System.IOUtils, Vcl.Menus, System.Types, Oracle, meIWMemo, meIWCheckBox,
  meIWGrid, meIWFileUploader, medpIWMessageDlg;

type
  TAzioniAbilitate = record
    Modifica: Boolean;
    Elimina: Boolean;
  end;

  TW039FGestioneDocumentale = class(TR012FWebAnagrafico)
    grdDocumenti: TmedpIWDBGrid;
    lblNomeFile: TmeIWLabel;
    edtNomeFile: TmeIWEdit;
    lblNote: TmeIWLabel;
    edtNote: TmeIWEdit;
    lblPeriodoDal: TmeIWLabel;
    edtPeriodoDal: TmeIWEdit;
    lblPeriodoAl: TmeIWLabel;
    edtPeriodoAl: TmeIWEdit;
    lblDataCreazioneDal: TmeIWLabel;
    edtDataCreazioneDal: TmeIWEdit;
    lblDataCreazioneAl: TmeIWLabel;
    edtDataCreazioneAl: TmeIWEdit;
    lblEstensione: TmeIWLabel;
    lblTipologia: TmeIWLabel;
    cmbEstensione: TmeIWComboBox;
    cmbTipologia: TmeIWComboBox;
    imgAggiorna: TmedpIWImageButton;
    imgPulisci: TmedpIWImageButton;
    lblFiltri: TmeIWLabel;
    pmnDocumenti: TPopupMenu;
    mnuEsportaExcel: TMenuItem;
    lblFamiliare: TmeIWLabel;
    edtFamiliare: TmeIWEdit;
    VisualizzaDatiAggiuntivi: TMenuItem;
    btnDatiAggiuntivi: TmeIWButton;
    mnuEsportaCsv: TMenuItem;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure grdDocumentiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdDocumentiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure imgAggiornaClick(Sender: TObject);
    procedure imgPulisciAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure edtNomeFileSubmit(Sender: TObject);
    procedure edtNoteSubmit(Sender: TObject);
    procedure btnSendFileClick(Sender: TObject);
    procedure mnuEsportaExcelClick(Sender: TObject);
    procedure edtFamiliareSubmit(Sender: TObject);
    procedure VisualizzaDatiAggiuntiviClick(Sender: TObject);
    procedure btnVisualizzaDatiAggiuntiviClick(Sender: TObject);
    procedure mnuEsportaCsvClick(Sender: TObject);
  private
    iImgDownload, jImgDownload: Integer;
    W039DM: TW039FGestioneDocumentaleDM;
    C021DM: TC021FDocumentiManagerDM;
    FNomeFileGenerato: String;
    procedure GetElencoDocumenti;
    procedure PulisciFiltri;
    function  GetFiltroDocumenti: String;
    procedure imgDownloadClick(Sender: TObject);
    function Occurrences(const Substring, Text: string): integer;
    procedure AggiornaAccessoEScarica(const PId: Integer; const PFilePath: String);
  protected
    procedure VisualizzaDipendenteCorrente; override;
    procedure GetDipendentiDisponibili(Data: TDateTime); override;
  public
    function InizializzaAccesso: Boolean; override;
  end;

const
  LIMITE_CARATTERI_NOTE = 100;  // limite di caratteri per le note da visualizzare in tabella
  LIMITE_RIGHE_NOTE     =   4;  // limite di ritorni a capo per le note da visualizzare in tabella

implementation

{$R *.dfm}

{ TW039FGestioneDocumentale }

function TW039FGestioneDocumentale.InizializzaAccesso: Boolean;
const
  FUNZIONE = 'InizializzaAccesso';
var
  Liste: TElencoListe;
begin
  Log('Traccia',Format('%s - inizio',[FUNZIONE]));

  // controlli per accesso
  //Result:=False;

  GetDipendentiDisponibili(Parametri.DataLavoro);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);

  if not Parametri.InibizioneIndividuale then
  begin
    // seleziona l'item "tutti i dipendenti" (o l'unico della lista)
    cmbDipendentiDisponibili.ItemIndex:=0;
  end;

  // carica le liste di decodifica e assegna alle combobox i rispettivi elementi
  W039DM.A155MW.CaricaListe;
  Liste:=W039DM.A155MW.Liste;
  cmbEstensione.Items.Assign(Liste.ListaEstensioniT960);
  cmbTipologia.Items.Assign(Liste.ListaTipologieT960);

  // se sono presenti elementi con ordinamento per le tipologie, seleziona il primo
  if cmbTipologia.Items.Count > 0 then
  begin
    if not (TValore(cmbTipologia.Items.Objects[0]).Valore = '*') then
      cmbTipologia.ItemIndex:=0
    else
      cmbTipologia.ItemIndex:=-1;
  end;

  VisualizzaDipendenteCorrente;

  Result:=True;
  Log('Traccia',Format('%s - fine',[FUNZIONE]));
end;

procedure TW039FGestioneDocumentale.IWAppFormCreate(Sender: TObject);
const
  FUNZIONE = 'IWAppFormCreate';
begin
  Log('Traccia',Format('%s - inizio',[FUNZIONE]));
  inherited;

  // datamodule e variabili di supporto
  W039DM:=TW039FGestioneDocumentaleDM.Create(Self);
  C021DM:=TC021FDocumentiManagerDM.Create(nil);
  C021DM.Maschera:=medpCodiceForm;
  FNomeFileGenerato:='';

  // gestione dataset principale: apertura fittizia solo per elenco colonne
  W039DM.selT960.Close;
  W039DM.selT960.SetVariable('DATALAVORO',Parametri.DataLavoro);
  W039DM.selT960.SetVariable('FILTRO_ANAG','and 1 = 0');
  W039DM.selT960.SetVariable('AZIENDA',Parametri.Azienda);
  W039DM.selT960.SetVariable('HINTT030V430',Parametri.CampiRiferimento.C26_HintT030V430);
  W039DM.selT960.SetVariable('FILTRO_DOCUMENTI','');
  W039DM.selT960.Open;

  // impostazioni tabella
  grdDocumenti.medpRighePagina:=GetRighePaginaTabella;
  grdDocumenti.medpTestoNoRecord:='Nessun documento';
  grdDocumenti.medpComandiCustom:=True;
  grdDocumenti.medpAttivaGrid(W039DM.selT960,False,False,False);
  grdDocumenti.medpPreparaComponentiDefault;

  // componente per download (colonna comandi)
  iImgDownload:=grdDocumenti.medpIndexColonna(DBG_COMANDI);
  jImgDownload:=0;
  grdDocumenti.medpPreparaComponenteGenerico('R',iImgDownload,jImgDownload,DBG_IMG,'','SALVA','Download del documento','','C');

  grdDocumenti.medpCaricaCDS;
  // imposta la gestione automatica della selezione del periodo
  AssegnaGestPeriodo(edtPeriodoDal,edtPeriodoAl);
  AssegnaGestPeriodo(edtDataCreazioneDal,edtDataCreazioneAl);

  Log('Traccia',Format('%s - fine',[FUNZIONE]));
end;

procedure TW039FGestioneDocumentale.IWAppFormDestroy(Sender: TObject);
const
  FUNZIONE = 'IWAppFormDestroy';
begin
  Log('Traccia',Format('%s - inizio',[FUNZIONE]));
  FreeAndNil(C021DM);
  inherited;
  Log('Traccia',Format('%s - fine',[FUNZIONE]));
end;

procedure TW039FGestioneDocumentale.mnuEsportaExcelClick(Sender: TObject);
const
  FUNZIONE = 'mnuEsportaExcelClick';
begin
  Log('Traccia',Format('%s - inizio',[FUNZIONE]));
  if not Assigned(Sender) then
    streamDownload:=grdDocumenti.ToXlsx
  else
    InviaFile('Documenti.xlsx',streamDownload);
  Log('Traccia',Format('%s - fine',[FUNZIONE]));
end;

procedure TW039FGestioneDocumentale.mnuEsportaCsvClick(Sender: TObject);
const
  FUNZIONE = 'mnuEsportaCsvClick';
begin
  Log('Traccia',Format('%s - inizio',[FUNZIONE]));
  if not Assigned(Sender) then
    csvDownload:=grdDocumenti.ToCsv
  else
    InviaFile('Documenti.xls',csvDownload);
  Log('Traccia',Format('%s - fine',[FUNZIONE]));
end;

procedure TW039FGestioneDocumentale.GetDipendentiDisponibili(Data: TDateTime);
const
  FUNZIONE = 'GetDipendentiDisponibili';
begin
  Log('Traccia',Format('%s - inizio',[FUNZIONE]));
  ElementoTuttiDip:=not Parametri.InibizioneIndividuale;
  inherited;
  Log('Traccia',Format('%s - fine',[FUNZIONE]));
end;


procedure TW039FGestioneDocumentale.VisualizzaDipendenteCorrente;
var
  Liste: TElencoListe;
  ValEstensione, ValTipologia: String;
const
  FUNZIONE = 'VisualizzaDipendenteCorrente';
begin
  Log('Traccia',Format('%s - inizio',[FUNZIONE]));
  inherited;

  // estrae l'elenco dei documenti
  GetElencoDocumenti;

  // salva valori combobox ricerca
  if cmbEstensione.ItemIndex = -1 then
    ValEstensione:=''
  else
    ValEstensione:=cmbEstensione.Items[cmbEstensione.ItemIndex];
  if cmbTipologia.ItemIndex = -1 then
    ValTipologia:=''
  else
    ValTipologia:=cmbTipologia.Items[cmbTipologia.ItemIndex];

  // carica le liste di decodifica e assegna alle combobox i rispettivi elementi
  W039DM.A155MW.CaricaListe;
  Liste:=W039DM.A155MW.Liste;
  cmbEstensione.Items.Assign(Liste.ListaEstensioniT960);
  cmbEstensione.ItemIndex:=cmbEstensione.Items.IndexOf(ValEstensione);
  cmbTipologia.Items.Assign(Liste.ListaTipologieT960);
  cmbTipologia.ItemIndex:=cmbTipologia.Items.IndexOf(ValTipologia);

  Log('Traccia',Format('%s - fine',[FUNZIONE]));
end;

procedure TW039FGestioneDocumentale.VisualizzaDatiAggiuntiviClick(Sender: TObject);
begin
  inherited;
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnDatiAggiuntivi.HTMLName]));
end;

procedure TW039FGestioneDocumentale.btnVisualizzaDatiAggiuntiviClick(Sender: TObject);
var hash, versione: String;
begin
  inherited;
  hash:=IfThen(W039DM.selT960.FieldByName('HASH').AsString = '', 'Non presente', W039DM.selT960.FieldByName('HASH').AsString);
  versione:=IfThen(W039DM.selT960.FieldByName('VERSIONE').AsString = '', 'non presente', W039DM.selT960.FieldByName('VERSIONE').AsString);

  MsgBox.MessageBox('Nome file: ' + W039DM.selT960.FieldByName('NOME_FILE').AsString + '.' + W039DM.selT960.FieldByName('EXT_FILE').AsString + CRLF
                    + 'Data creazione: ' + W039DM.selT960.FieldByName('DATA_CREAZIONE').AsString + CRLF
                    + 'Versione: ' + versione + CRLF
                    + '--------------------------------------------------------------------------------' + CRLF
                    + 'Hash (SHA-512 in codifica Base64): ' + CRLF
                    + hash.Substring(0, 43) + CRLF
                    + hash.Substring(43),
                    INFORMA
                    );
end;

procedure TW039FGestioneDocumentale.edtFamiliareSubmit(Sender: TObject);
const
  FUNZIONE = 'edtFamiliareSubmit';
begin
  Log('Traccia',Format('%s - inizio',[FUNZIONE]));
  imgAggiornaClick(nil);
  Log('Traccia',Format('%s - fine',[FUNZIONE]));
end;

procedure TW039FGestioneDocumentale.edtNomeFileSubmit(Sender: TObject);
const
  FUNZIONE = 'edtNomeFileSubmit';
begin
  Log('Traccia',Format('%s - inizio',[FUNZIONE]));
  imgAggiornaClick(nil);
  Log('Traccia',Format('%s - fine',[FUNZIONE]));
end;

procedure TW039FGestioneDocumentale.edtNoteSubmit(Sender: TObject);
const
  FUNZIONE = 'edtNoteSubmit';
begin
  Log('Traccia',Format('%s - inizio',[FUNZIONE]));
  imgAggiornaClick(nil);
  Log('Traccia',Format('%s - fine',[FUNZIONE]));
end;

procedure TW039FGestioneDocumentale.GetElencoDocumenti;
var
  FiltroAnag: String;
  OldIdDocumento: Integer;
const
  FUNZIONE = 'GetElencoDocumenti';
begin
  Log('Traccia',Format('%s - inizio',[FUNZIONE]));

  // imposta filtri per documenti
  FiltroAnag:=IfThen(TuttiDipSelezionato,WR000DM.FiltroRicerca,FiltroSingoloAnagrafico);

  // nel caso di utente web responsabile (con filtro anagrafe)
  // è necessario considerare il flag ACCESSO_RESPONSABILE
  // per impedire che possa visualizzare documenti dei sottoposti a cui non ha accesso
  if (Parametri.TipoOperatore = 'I060') and
     (not Parametri.InibizioneIndividuale) then
  begin
    FiltroAnag:=FiltroAnag +
                Format(' and ((T960.PROGRESSIVO = %d) or (T960.NOME_UTENTE = ''%s'') or (T960.ACCESSO_RESPONSABILE = ''S''))',
                       [Parametri.ProgressivoOper,Parametri.Operatore]);
  end;

  if W039DM.selT960.Active then
    OldIdDocumento:=W039DM.selT960.FieldByName('ID').AsInteger
  else
    OldIdDocumento:=-1;

  // aggiorna dataset principale
  W039DM.selT960.Close;
  W039DM.selT960.SetVariable('DATALAVORO',Parametri.DataLavoro);
  W039DM.selT960.SetVariable('FILTRO_ANAG',FiltroAnag);
  W039DM.selT960.SetVariable('AZIENDA',Parametri.Azienda);
  W039DM.selT960.SetVariable('HINTT030V430',Parametri.CampiRiferimento.C26_HintT030V430);
  W039DM.selT960.SetVariable('FILTRO_DOCUMENTI',GetFiltroDocumenti);
  W039DM.selT960.Open;

  // visibilità colonne relative al dipendente
  grdDocumenti.medpColonna('MATRICOLA').Visible:=TuttiDipSelezionato;
  grdDocumenti.medpColonna('NOMINATIVO').Visible:=TuttiDipSelezionato;
  W039DM.TuttiDipSelezionato:=TuttiDipSelezionato;

  // aggiorna tabella
  grdDocumenti.medpCaricaCDS;

  // riposizionamento su eventuale record selezionato
  if OldIdDocumento > -1 then
  begin
    W039DM.selT960.SearchRecord('ID',OldIdDocumento,[srFromBeginning]);
    grdDocumenti.medpAggiornaCDS;
  end;

  Log('Traccia',Format('%s - fine',[FUNZIONE]));
end;

procedure TW039FGestioneDocumentale.grdDocumentiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  r: Integer;
  IWImg: TmeIWImageFile;
const
  FUNZIONE = 'grdDocumentiAfterCaricaCDS';
begin
  Log('Traccia',Format('%s - inizio',[FUNZIONE]));

  for r:=IfThen(grdDocumenti.medpRigaInserimento,1,0) to High(grdDocumenti.medpCompGriglia) do
  begin
    // download
    IWImg:=(grdDocumenti.medpCompCella(r,iImgDownload,jImgDownload) as TmeIWImageFile);
    if IWImg <> nil then
      IWImg.OnClick:=imgDownloadClick;
  end;
  Log('Traccia',Format('%s - fine',[FUNZIONE]));
end;

function TW039FGestioneDocumentale.Occurrences(const Substring, Text: string): integer;
var
  offset: integer;
begin
  result := 0;
  offset := PosEx(Substring, Text, 1);
  while offset <> 0 do
  begin
    inc(result);
    offset := PosEx(Substring, Text, offset + length(Substring));
  end;
end;

procedure TW039FGestioneDocumentale.grdDocumentiRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
var
  NumColonna, x: Integer;
  Campo: String;
  NoteLimitate: Boolean;
begin
  if not grdDocumenti.medpRenderCell(ACell,ARow,AColumn,True,True,True) then
    Exit;

  NumColonna:=grdDocumenti.medpNumColonna(AColumn);
  Campo:=grdDocumenti.medpColonna(NumColonna).DataField;

  if (ARow <> 0) and (Length(grdDocumenti.medpCompGriglia) > 0) then
  begin
    if Campo = 'TIPOLOGIA' then
    begin
      ACell.Text:=grdDocumenti.medpValoreColonna(ARow - 1,'D_TIPOLOGIA');
    end
    else if Campo = 'UFFICIO' then
    begin
      ACell.Text:=grdDocumenti.medpValoreColonna(ARow - 1,'D_UFFICIO');
    end
    else if Campo = 'ACCESSO_RESPONSABILE' then
    begin
      ACell.Text:=grdDocumenti.medpValoreColonna(ARow - 1,'D_ACCESSO_RESPONSABILE');
      ACell.Css:=ACell.Css + ' align_center';
    end
    else if Campo = 'AUTOCERTIFICAZIONE' then
    begin
      ACell.Text:=grdDocumenti.medpValoreColonna(ARow - 1,'D_AUTOCERTIFICAZIONE');
      ACell.Css:=ACell.Css + ' align_center';
    end
    else if (Campo = 'DATA_RILASCIO') or (Campo = 'DATA_NOTIFICA') then
    begin
      ACell.Css:=ACell.Css + ' align_center';
    end
    else if Campo = 'NOTE' then
    begin
      // se il testo supera certe soglie (lunghezza o ritorni a capo)
      // lo riduce inserendo dei puntini di sospensione
      // per evitare che la riga ecceda dimensioni accettabili
      if (ACell.Text = '') or (ACell.Text = '<br>') then
      begin
        ACell.Hint:='';
        ACell.ShowHint:=False;
      end
      else
      begin
        ACell.Hint:=C190ConvertiSimboliHtml(ACell.Text);
        NoteLimitate:=False;
        if Length(ACell.Text) > LIMITE_CARATTERI_NOTE then
        begin
          NoteLimitate:=True;
          ACell.Text:=Format('%s...',[Copy(ACell.Text,1,LIMITE_CARATTERI_NOTE)]);
        end;
        x:=Occurrences('<br>',ACell.Text) - IfThen(ACell.Text.EndsWith('<br>'),1);
        if x >= LIMITE_RIGHE_NOTE then
        begin
          NoteLimitate:=True;
          ACell.Text:=Format('<div style="overflow-y: hidden; text-overflow: ellipsis; max-height: %d.5em;">%s</div>',[LIMITE_RIGHE_NOTE,ACell.Text]);
        end;
        ACell.ShowHint:=NoteLimitate;
        if ACell.ShowHint then
          ACell.Css:=ACell.Css + ' tooltipHtml';
      end;
    end;
  end;

  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdDocumenti.medpCompGriglia) + 1) and (grdDocumenti.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdDocumenti.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
    if ACell.Control is TmeIWFileUploader then
      Self.ContainerImplementation.AddComponent(ACell.Control); // Bugfix IW 14 (no JS con AddToInitProc())
  end;

  if (ARow > 0) and (ARow <= High(grdDocumenti.medpCompGriglia) + 1) and (grdDocumenti.medpValoreColonna(ARow - 1,'DATA_LETTURA_PROGRESSIVO') = '') then
    ACell.Css:=ACell.Css + ' font_grassetto';
end;

procedure TW039FGestioneDocumentale.imgDownloadClick(Sender: TObject);
// effettua il download dell'allegato
var
  i: Integer;
  FN: String;
  LId: Integer;
  LDoc: TDocumento;
  LResCtrl: TResCtrl;
const
  FUNZIONE = 'imgDownloadClick';
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  i:=grdDocumenti.medpRigaDiCompGriglia(FN);

  // estrae id richiesta
  LId:=grdDocumenti.medpValoreColonna(i,'ID').ToInteger;

  // se l'id non è valido esce immediatamente
  if LId <= 0 then
    Exit;

  A000SessioneWEB.AnnullaTimeOut;
  try
    // estrae il file con i metadati associati
    LResCtrl:=C021DM.GetById(LId,True,LDoc);
    if not LResCtrl.Ok then
    begin
      MsgBox.MessageBox(LResCtrl.Messaggio,ESCLAMA);
      Exit;
    end;

    // aggiorna i dati di accesso e scarica il documento
    // IMPORTANTE: al momento i dati di accesso non sono aggiornati!!!
    try
      AggiornaAccessoEScarica(LDoc.Id,LDoc.FilePath);
    except
      on E: Exception do
      begin
        MsgBox.MessageBox(E.Message,ESCLAMA);
        Exit;
      end;
    end;
  finally
    FreeAndNil(LDoc);
    A000SessioneWEB.RipristinaTimeOut;
  end;
end;

procedure TW039FGestioneDocumentale.AggiornaAccessoEScarica(const PId: Integer; const PFilePath: String);
var
  LId: Integer;
  LOldRowId: String;
const
  FUNZIONE = 'AggiornaAccessoEScarica';
begin
  Log('Traccia',Format('%s - inizio',[FUNZIONE]));

  LId:=W039DM.selT960.FieldByName('ID').AsInteger;
  LOldRowId:=W039DM.selT960.RowId;

  // aggiorna i dati di lettura del file
  if Parametri.TipoOperatore = 'I060' then
  begin
    // utente di creazione è di I060 e il suo progressivo = T960.PROGRESSIVO
    // accesso al documento da parte di utente I060,
    // progressivo = T960.PROGRESSIVO e DATA_LETTURA_PROGRESSIVO is null
    C021DM.AggiornaDatiLettura(PId,Parametri.ProgressivoOper);
  end;

  // aggiorna i dati di accesso al file (esegue l'operazione solo per operatore win)
  C021DM.AggiornaDatiAccesso(PId,Parametri.Operatore);

  // refresh dataset
  W039DM.selT960.Refresh;
  W039DM.selT960.SearchRecord('ID',LId,[srFromBeginning]);
  grdDocumenti.medpCaricaCDS(LOldRowId);

  // effettua il download del file
  FNomeFileGenerato:=PFilePath;
  AddToInitProc(Format('SubmitClick("%s", "", true);',[btnSendFile.HTMLName]));
  Log('Traccia',Format('%s - fine',[FUNZIONE]));
end;

procedure TW039FGestioneDocumentale.btnSendFileClick(Sender: TObject);
const
  FUNZIONE = 'btnSendFileClick';
begin
  Log('Traccia',Format('%s - inizio',[FUNZIONE]));
  GGetWebApplicationThreadVar.SendFile(FNomeFileGenerato,true,'application/x-download',ExtractFileName(FNomeFileGenerato));
  Log('Traccia',Format('%s - fine',[FUNZIONE]));
end;

procedure TW039FGestioneDocumentale.PulisciFiltri;
const
  FUNZIONE = 'PulisciFiltri';
begin
  Log('Traccia',Format('%s - inizio',[FUNZIONE]));
  // nome file ed estensioni
  edtNomeFile.Clear;
  cmbEstensione.ItemIndex:=-1;

  // CF Familiare
  edtFamiliare.Clear;

  // periodo
  edtPeriodoDal.Clear;
  edtPeriodoAl.Clear;

  // data creazione
  edtDataCreazioneDal.Clear;
  edtDataCreazioneAl.Clear;

  // tipologie
  cmbTipologia.ItemIndex:=-1;

  // note
  edtNote.Clear;
  Log('Traccia',Format('%s - fine',[FUNZIONE]));
end;

function TW039FGestioneDocumentale.GetFiltroDocumenti: String;
// imposta l'oggetto FiltroDoc per determinare il filtro sql per i documenti,
// quindi restituisce il filtro stesso
var
  FD: TFiltroDocumenti;
const
  FUNZIONE = 'GetFiltroDocumenti';
begin
  Log('Traccia',Format('%s - inizio',[FUNZIONE]));
  // assegna il filtro documenti
  FD:=W039DM.A155MW.FiltroDoc;

  // nome file ed estensioni
  FD.NomeFile:=edtNomeFile.Text;
  FD.ListEstensioni.CommaText:=cmbEstensione.Text;

  // CF Familiare
  FD.CodFiscale:=edtFamiliare.Text;

  // utenti
  FD.ListUtenti.Clear;

  // periodo
  FD.Periodo.Inizio:=DATE_NULL;
  FD.Periodo.Fine:=DATE_NULL;
  if edtPeriodoDal.Text <> '' then
    TryStrToDate(edtPeriodoDal.Text,FD.Periodo.Inizio);
  if edtPeriodoAl.Text <> '' then
    TryStrToDate(edtPeriodoAl.Text,FD.Periodo.Fine);

  // data creazione
  FD.Creazione.Inizio:=DATE_NULL;
  FD.Creazione.Fine:=DATE_NULL;
  if edtDataCreazioneDal.Text <> '' then
    TryStrToDate(edtDataCreazioneDal.Text,FD.Creazione.Inizio);
  if edtDataCreazioneAl.Text <> '' then
    TryStrToDate(edtDataCreazioneAl.Text,FD.Creazione.Fine);

  // dimensione
  FD.Dimensione.MinKB:=0;
  FD.Dimensione.MaxKB:=0;

  // tipologie
  if cmbTipologia.ItemIndex = -1 then
    FD.ListTipologie.Clear
  else
    FD.ListTipologie.CommaText:=TValore(cmbTipologia.Items.Objects[cmbTipologia.ItemIndex]).Valore;

  // uffici
  FD.ListUffici.CommaText:='';

  // note
  FD.Note:=edtNote.Text;

  Result:=FD.GetFiltroSQL;
  Log('Traccia',Format('%s - fine',[FUNZIONE]));
end;

procedure TW039FGestioneDocumentale.imgAggiornaClick(Sender: TObject);
const
  FUNZIONE = 'imgAggiornaClick';
begin
  Log('Traccia',Format('%s - inizio',[FUNZIONE]));
  VisualizzaDipendenteCorrente;
  Log('Traccia',Format('%s - fine',[FUNZIONE]));
end;

procedure TW039FGestioneDocumentale.imgPulisciAsyncClick(Sender: TObject; EventParams: TStringList);
const
  FUNZIONE = 'imgPulisciAsyncClick';
begin
  Log('Traccia',Format('%s - inizio',[FUNZIONE]));
  PulisciFiltri;
  Log('Traccia',Format('%s - fine',[FUNZIONE]));
end;

end.
