unit A155URicercaDocumentale;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, A000USessione, A000UInterfaccia, A000UCostanti, A000UMessaggi,
  C013UCheckList, C015UElencoValori, C180FunzioniGenerali, C700USelezioneAnagrafe,
  R001UGESTTAB, SelAnagrafe, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  Grids, DBGrids, checklst, System.Actions, Vcl.StdCtrls, Vcl.Mask, Winapi.ShellAPI,
  Vcl.DBCtrls, Vcl.ExtCtrls, System.IOUtils, C021UDocumentiManagerDM,
  Vcl.Buttons, Vcl.Samples.Spin, A155URicercaDocumentaleMW, System.Math,
  Oracle, OracleData, System.ImageList, InputPeriodo;

type
  TA155FRicercaDocumentale = class(TR001FGestTab)
    frmSelAnagrafe: TfrmSelAnagrafe;
    dgrdDocumenti: TDBGrid;
    pnlDettaglio: TPanel;
    lblUtente: TLabel;
    {$WARN SYMBOL_PLATFORM ON}
    lblTipologia: TLabel;
    lblUfficio: TLabel;
    ActionList2: TActionList;
    actFileDownload: TAction;
    actFileVisualizza: TAction;
    lblNomeFile: TLabel;
    lblEstensioni: TLabel;
    sedtDimensioneDa: TSpinEdit;
    lblDimensioneDa: TLabel;
    sedtDimensioneA: TSpinEdit;
    lblDimensioneA: TLabel;
    lblKBDa: TLabel;
    lblKBA: TLabel;
    edtNomeFile: TEdit;
    lstEstensioni: TCheckListBox;
    lstUtenti: TCheckListBox;
    lstTipologie: TCheckListBox;
    lstUffici: TCheckListBox;
    lblNote: TLabel;
    edtNote: TEdit;
    pmnSelezione: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    pmnAzioniDocumento: TPopupMenu;
    Salva1: TMenuItem;
    Apri1: TMenuItem;
    actAccediDocumento: TAction;
    Accedi1: TMenuItem;
    N4: TMenuItem;
    btnPulisciFiltri: TBitBtn;
    mnuCopiaExcel: TMenuItem;
    N5: TMenuItem;
    dlgFileSave: TSaveDialog;
    rgDocAutocertificazione: TRadioGroup;
    lblFamiliare: TLabel;
    edtFamiliare: TEdit;
    frmInputPeriodoCreaz: TfrmInputPeriodo;
    frmInputPeriodoRif: TfrmInputPeriodo;
    procedure FormShow(Sender: TObject);
    procedure actFileDownloadExecute(Sender: TObject);
    procedure actFileVisualizzaExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure sedtDimensioneDaChange(Sender: TObject);
    procedure sedtDimensioneAChange(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure pmnAzioniDocumentoPopup(Sender: TObject);
    procedure btnPulisciFiltriClick(Sender: TObject);
    procedure actAccediDocumentoExecute(Sender: TObject);
    procedure dgrdDocumentiDblClick(Sender: TObject);
    procedure mnuCopiaExcelClick(Sender: TObject);
  private
    FC021DM: TC021FDocumentiManagerDM;
    FAbilitaGestioneA154: Boolean;
    procedure CambiaProgressivo;
    function  GetFiltroDocumenti: String;
    function GetElencoCheckList(PCheckListBox: TCheckListBox): String;
    procedure PulisciFiltri;
    procedure AggiornaAccesso;
    { Metodi Property }
    function _GetDataRifI: TDateTime;
    procedure _PutDataRifI(const Value: TDateTime);
    function _GetDataRifF: TDateTime;
    procedure _PutDataRifF(const Value: TDateTime);
    function _GetDataCreazI: TDateTime;
    procedure _PutDataCreazI(const Value: TDateTime);
    function _GetDataCreazF: TDateTime;
    procedure _PutDataCreazF(const Value: TDateTime);
  public
    { Property }
    property DataRifI:TDateTime read _GetDataRifI write _PutDataRifI;
    property DataRifF:TDateTime read _GetDataRifF write _PutDataRifF;
    property DataCreazI:TDateTime read _GetDataCreazI write _PutDataCreazI;
    property DataCreazF:TDateTime read _GetDataCreazF write _PutDataCreazF;
  end;

var
  A155FRicercaDocumentale: TA155FRicercaDocumentale;

procedure OpenA155RicercaDocumentale(Prog:LongInt);

implementation

uses A155URicercaDocumentaleDtM,
     A154UGestioneDocumentale;

{$R *.dfm}

procedure OpenA155RicercaDocumentale(Prog:LongInt);
begin
  if Prog <= 0 then
  begin
    R180MessageBox('Nessun dipendente selezionato!',INFORMA);
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA155RicercaDocumentale') of
    'N':begin
          R180MessageBox('Funzione non abilitata!',INFORMA);
          Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A155FRicercaDocumentale:=TA155FRicercaDocumentale.Create(nil);
  with A155FRicercaDocumentale do
  try
    C700Progressivo:=Prog;
    A155FRicercaDocumentaleDtM:=TA155FRicercaDocumentaleDtM.Create(nil);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A155FRicercaDocumentaleDtM.Free;
    Free;
  end;
end;

procedure TA155FRicercaDocumentale.FormCreate(Sender: TObject);
begin
  inherited;

  // valuta abilitazione gestione documenti
  FAbilitaGestioneA154:=A000GetInibizioni('Tag','76') <> 'N';
  frmInputPeriodoRif.CaptionDataOutI:= 'Periodo di riferimento dal';
  frmInputPeriodoRif.CaptionDataOutF:= 'Periodo di riferimento al';
  frmInputPeriodoCreaz.CaptionDataOutI:= 'Data creazione dal';
  frmInputPeriodoCreaz.CaptionDataOutF:= 'Data creazione al';
end;

procedure TA155FRicercaDocumentale.FormShow(Sender: TObject);
var
  Liste: TElencoListe;
begin
  inherited;
  
  // scorciatoia per datamodulo di servizio per allegati
  FC021DM:=A155FRicercaDocumentaleDtM.A155MW.C021DM;

  DButton.DataSet:=A155FRicercaDocumentaleDtM.A155MW.selT960;

  // impostazioni della selezione anagrafica
  C700DatiVisualizzati:='';//'MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,2,False);
  frmSelAnagrafe.NumRecords;

  // imposta dataset
  A155FRicercaDocumentaleDtM.A155MW.selT960.Close;
  C700MergeSelAnagrafe(A155FRicercaDocumentaleDtM.A155MW.selT960,False);
  C700MergeSettaPeriodo(A155FRicercaDocumentaleDtM.A155MW.selT960,Parametri.DataLavoro,Parametri.DataLavoro);
  A155FRicercaDocumentaleDtM.A155MW.selT960.SetVariable('AZIENDA',Parametri.Azienda);
  A155FRicercaDocumentaleDtM.A155MW.selT960.SetVariable('HINTT030V430',Parametri.CampiRiferimento.C26_HintT030V430);
  A155FRicercaDocumentaleDtM.A155MW.selT960.SetVariable('FILTRO_DOCUMENTI',null);
  A155FRicercaDocumentaleDtM.A155MW.selT960.Open;

  // assegna alle checklistbox i rispettivi elementi
  Liste:=A155FRicercaDocumentaleDtM.A155MW.Liste;
  lstEstensioni.Items.Assign(Liste.ListaEstensioniT960);
  lstUtenti.Items.Assign(Liste.ListaUtentiT960);
  lstTipologie.Items.Assign(Liste.ListaTipologieT960);
  lstUffici.Items.Assign(Liste.ListaUfficiT960);

  if not Parametri.ModuloInstallato['GESTIONE_DOCUMENTALE'] then
  begin
    DButton.DataSet.FieldByName('D_NOME_FILE').Visible:=False;
    DButton.DataSet.FieldByName('D_DIMENSIONE').Visible:=False;
  end;
end;

procedure TA155FRicercaDocumentale.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
  inherited;
end;

procedure TA155FRicercaDocumentale.actAccediDocumentoExecute(Sender: TObject);
// accesso alla gestione del documento A154
// pre: la funzione A154 è accessibile
var
  LOldIdDoc: Integer;
begin
  // salva id documento per successivo riposizionamento
  LOldIdDoc:=DButton.DataSet.FieldByName('ID').AsInteger;

  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA154GestioneDocumentale(DButton.DataSet.FieldByName('PROGRESSIVO').AsInteger,DButton.DataSet.FieldByName('ID').AsInteger);
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe;

  // refresh dataset e riposizionamento
  DButton.DataSet.Refresh;
  TOracleDataSet(DButton.DataSet).SearchRecord('ID',LOldIdDoc,[srFromBeginning]);
end;

procedure TA155FRicercaDocumentale.actFileDownloadExecute(Sender: TObject);
// effettua il download dell'allegato
var
  LId: Integer;
  LDoc: TDocumento;
  LFileName: String;
  LResCtrl: TResCtrl;
begin
  // estrae id richiesta dal tag del componente
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
        // salvataggio del file
        TFile.Move(LDoc.FilePath,LFileName);
        // aggiorna i dati di accesso al documento
        AggiornaAccesso;
      end;
      {$WARN SYMBOL_PLATFORM ON}
    except
      on E: Exception do
      begin
        R180MessageBox(Format(A000MSG_A155_ERR_FMT_DOC_SALVA,[E.Message]),ESCLAMA);
        Exit;
      end;
    end;
  finally
    FreeAndNil(LDoc);
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA155FRicercaDocumentale.actFileVisualizzaExecute(Sender: TObject);
// apre il documento allegato utilizzando la shellexecute
var
  LId: Integer;
  LDoc: TDocumento;
  LResCtrl: TResCtrl;
begin
  // estrae id richiesta dal tag del componente
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
        R180MessageBox(Format(A000MSG_A155_ERR_FMT_DOC_APRI,[E.Message]),ESCLAMA);
        Exit;
      end;
    end;
  finally
    FreeAndNil(LDoc);
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA155FRicercaDocumentale.actRefreshExecute(Sender: TObject);
begin
  TOracleDataSet(DButton.DataSet).SetVariable('FILTRO_DOCUMENTI',GetFiltroDocumenti);
  inherited;
end;

procedure TA155FRicercaDocumentale.AggiornaAccesso;
// aggiorna i dati di accesso per la tabella indicata
begin
  FC021DM.AggiornaDatiAccesso(A155FRicercaDocumentaleDtM.A155MW.selT960.FieldByName('ID').AsInteger,Parametri.Operatore);
  A155FRicercaDocumentaleDtM.A155MW.selT960.Refresh;
end;

procedure TA155FRicercaDocumentale.PulisciFiltri;
begin
  // nome file ed estensioni
  edtNomeFile.Clear;
  R180PutCheckList('',MAXWORD,lstEstensioni);

  // codice fiscale familiare
  edtFamiliare.Clear;

  // utenti
  R180PutCheckList('',MAXWORD,lstUtenti);

  // periodo
  DataRifI:= 0;
  DataRifF:= 0;

  // data creazione
  DataCreazI:= 0;
  DataCreazF:= 0;

  // dimensione
  sedtDimensioneDa.Value:=0;
  sedtDimensioneA.Value:=0;

  // tipologie
  R180PutCheckList('',MAXWORD,lstTipologie);

  // uffici
  R180PutCheckList('',MAXWORD,lstUffici);

  // note
  edtNote.Clear;
end;

procedure TA155FRicercaDocumentale.btnPulisciFiltriClick(Sender: TObject);
begin
  PulisciFiltri;
end;

procedure TA155FRicercaDocumentale.CambiaProgressivo;
begin
  if DButton.DataSet = nil then
    Exit;
  if not DButton.DataSet.Active then
    Exit;

  C700MergeSelAnagrafe(DButton.DataSet,False);
  actRefreshExecute(nil);
end;

procedure TA155FRicercaDocumentale.dgrdDocumentiDblClick(Sender: TObject);
begin
  actAccediDocumento.Visible:=FAbilitaGestioneA154 and (DButton.DataSet.Active )and (DButton.DataSet.RecordCount > 0);
  if actAccediDocumento.Visible then
    actAccediDocumentoExecute(nil);
end;

function TA155FRicercaDocumentale.GetElencoCheckList(PCheckListBox: TCheckListBox): String;
// restituisce il commatext dei codici selezionati
var
  i: Integer;
  LElemento: String;
begin
  Result:='';
  for i:=0 to PCheckListBox.Items.Count - 1 do
  begin
    if PCheckListBox.Checked[i] then
    begin
      LElemento:=TValore(PCheckListBox.Items.Objects[i]).Valore;
      Result:=Result + ',' + LElemento;
    end;
  end;

  // elimina la virgola iniziale
  if Result.StartsWith(',') then
    Result:=Result.Substring(1);
end;

function TA155FRicercaDocumentale.GetFiltroDocumenti: String;
// imposta l'oggetto FiltroDoc per determinare il filtro sql per i documenti,
// quindi restituisce il filtro stesso
var
  LNomeUtente: String;
  i: Integer;
  FD: TFiltroDocumenti;
begin
  // assegna il filtro documenti
  FD:=A155FRicercaDocumentaleDtM.A155MW.FiltroDoc;

  // nome file ed estensioni
  FD.NomeFile:=edtNomeFile.Text;
  FD.ListEstensioni.CommaText:=GetElencoCheckList(lstEstensioni);

  // codice fiscale familiare
  FD.CodFiscale:=edtFamiliare.Text;

  // utenti
  FD.ListUtenti.Clear;
  for i:=0 to lstUtenti.Count - 1 do
  begin
    if lstUtenti.Checked[i] then
    begin
      LNomeUtente:=TInfoUtente(lstUtenti.Items.Objects[i]).NomeUtente;
      FD.ListUtenti.Add(TInfoUtente(lstUtenti.Items.Objects[i]));
    end;
  end;

  // periodo
  FD.Periodo.Inizio:= IfThen(DataRifI > 0, DataRifI, DATE_NULL);
  FD.Periodo.Fine:= IfThen(DataRifF> 0, DataRifF, DATE_NULL);

  // data creazione
  FD.Creazione.Inizio:= IfThen(DataCreazI > 0, DataCreazI, DATE_NULL);
  FD.Creazione.Fine:= IfThen(DataCreazF > 0, DataCreazF, DATE_NULL);

  // dimensione
  FD.Dimensione.MinKB:=sedtDimensioneDa.Value;
  FD.Dimensione.MaxKB:=sedtDimensioneA.Value;

  // tipologie
  FD.ListTipologie.CommaText:=GetElencoCheckList(lstTipologie);

  // uffici
  FD.ListUffici.CommaText:=GetElencoCheckList(lstUffici);

  // note
  FD.Note:=edtNote.Text;

  // autocertificazione
  FD.DocRichiedere:=rgDocAutocertificazione.Items[rgDocAutocertificazione.ItemIndex] = 'Doc.da richiedere';
  FD.DocRichiesti:=rgDocAutocertificazione.Items[rgDocAutocertificazione.ItemIndex] = 'Doc.richiesti';
  FD.DocRicevuti:=rgDocAutocertificazione.Items[rgDocAutocertificazione.ItemIndex] = 'Doc.ricevuti';

  Result:=FD.GetFiltroSQL;
end;

procedure TA155FRicercaDocumentale.mnuCopiaExcelClick(Sender: TObject);
begin
  R180DBGridCopyToClipboard(dgrdDocumenti,True,False,True);
end;

procedure TA155FRicercaDocumentale.pmnAzioniDocumentoPopup(Sender: TObject);
var
  LAbilita: Boolean;
begin
  inherited;
  LAbilita:=(DButton.DataSet.Active ) and (DButton.DataSet.RecordCount > 0);
  actFileDownload.Visible:=LAbilita and Parametri.ModuloInstallato['GESTIONE_DOCUMENTALE'];
  actFileVisualizza.Visible:=LAbilita and Parametri.ModuloInstallato['GESTIONE_DOCUMENTALE'];
  actAccediDocumento.Visible:=FAbilitaGestioneA154 and LAbilita;
end;

procedure TA155FRicercaDocumentale.sedtDimensioneDaChange(Sender: TObject);
begin
  if sedtDimensioneA.Value < sedtDimensioneDa.Value then
  begin
    sedtDimensioneA.OnChange:=nil;
    sedtDimensioneA.Value:=sedtDimensioneDa.Value;
    sedtDimensioneA.OnChange:=sedtDimensioneAChange;
  end;
end;

procedure TA155FRicercaDocumentale.Selezionatutto1Click(Sender: TObject);
var
  i:Integer;
begin
  inherited;
  with (pmnSelezione.PopupComponent as TCheckListBox) do
  begin
    for i:=0 to Items.Count - 1 do
    begin
      if Sender = SelezionaTutto1 then
        Checked[i]:=True
      else if Sender = DeselezionaTutto1 then
        Checked[i]:=False
      else if Sender = InvertiSelezione1 then
        Checked[i]:=not Checked[i];
    end;
  end;
end;

procedure TA155FRicercaDocumentale.sedtDimensioneAChange(Sender: TObject);
begin
  if sedtDimensioneDa.Value > sedtDimensioneA.Value then
  begin
    sedtDimensioneDa.OnChange:=nil;
    sedtDimensioneDa.Value:=sedtDimensioneA.Value;
    sedtDimensioneDa.OnChange:=sedtDimensioneDaChange;
  end;
end;

{ DataRifF }
function TA155FRicercaDocumentale._GetDataRifF: TDateTime;
begin
  Result := frmInputPeriodoRif.DataFine;
end;
procedure TA155FRicercaDocumentale._PutDataRifF(const Value: TDateTime);
begin
  frmInputPeriodoRif.DataFine := Value;
end;
{ ----DataRifF }
{ DataRifI }
function TA155FRicercaDocumentale._GetDataRifI: TDateTime;
begin
  Result := frmInputPeriodoRif.DataInizio;
end;
procedure TA155FRicercaDocumentale._PutDataRifI(const Value: TDateTime);
begin
  frmInputPeriodoRif.DataInizio := Value;
end;
{ ----DataRifI }

{ DataCreazF }
function TA155FRicercaDocumentale._GetDataCreazF: TDateTime;
begin
  Result := frmInputPeriodoCreaz.DataFine;
end;
procedure TA155FRicercaDocumentale._PutDataCreazF(const Value: TDateTime);
begin
  frmInputPeriodoCreaz.DataFine := Value;
end;
{ ----DataCreazF }
{ DataCreazI }
function TA155FRicercaDocumentale._GetDataCreazI: TDateTime;
begin
  Result := frmInputPeriodoCreaz.DataInizio;
end;
procedure TA155FRicercaDocumentale._PutDataCreazI(const Value: TDateTime);
begin
  frmInputPeriodoCreaz.DataInizio := Value;
end;
{ ----DataCreazI }

end.
