unit WA155URicercaDocumentale;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR100UBase, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton,
  meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, meIWLink, WA155URicercaDocumentaleDM, IWDBGrids, medpIWDBGrid,
  IWCompEdit, meIWEdit, IWCompLabel, meIWLabel, Vcl.Menus, meIWImageButton,
  IWTMSCheckList, meTIWCheckListBox, meIWImageFile, medpIWImageButton,
  A000USessione, A000UInterfaccia, A000UMessaggi, A000UCostanti,
  System.IOUtils, C180FunzioniGenerali,
  C190FunzioniGeneraliWeb, A155URicercaDocumentaleMW, Oracle, OracleData,
  WC700USelezioneAnagrafeFM, System.StrUtils,
  WR102UGestTabella, System.Actions, Vcl.ActnList, medpIWTabControl;

type
  TWA155FRicercaDocumentale = class(TWR102FGestTabella)
    lblNomeFile: TmeIWLabel;
    edtNomeFile: TmeIWEdit;
    lblDimensioneDa: TmeIWLabel;
    edtDimensioneDa: TmeIWEdit;
    lblDimensioneA: TmeIWLabel;
    edtDimensioneA: TmeIWEdit;
    lblPeriodoDal: TmeIWLabel;
    edtPeriodoDal: TmeIWEdit;
    lblPeriodoAl: TmeIWLabel;
    edtPeriodoAl: TmeIWEdit;
    lblDataCreazioneDal: TmeIWLabel;
    edtDataCreazioneDal: TmeIWEdit;
    lblDataCreazioneAl: TmeIWLabel;
    edtDataCreazioneAl: TmeIWEdit;
    lblEstensioni: TmeIWLabel;
    lblUtente: TmeIWLabel;
    lblTipologia: TmeIWLabel;
    lblUfficio: TmeIWLabel;
    lstUtenti: TmeTIWCheckListBox;
    lstTipologie: TmeTIWCheckListBox;
    lstEstensioni: TmeTIWCheckListBox;
    lstUffici: TmeTIWCheckListBox;
    lblNote: TmeIWLabel;
    edtNote: TmeIWEdit;
    pmnSelezione: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    lblKBDa: TmeIWLabel;
    lblKBA: TmeIWLabel;
    actPulisci: TAction;
    lblFamiliare: TmeIWLabel;
    edtFamiliare: TmeIWEdit;
    procedure IWAppFormCreate(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure actAggiornaExecute(Sender: TObject);
    procedure actPulisciExecute(Sender: TObject);
  private
    function  GetElencoCheckList(PCheckListBox: TmeTIWCheckListBox): String;
    procedure PulisciFiltri;
    function  GetFiltroDocumenti: String;
  protected
    procedure ImpostazioniWC700; override;
    procedure RefreshPage; override;
  public
    AbilitaGestioneA154: Boolean;
    function InizializzaAccesso:Boolean; override;
    procedure WC700CambioProgressivo(Sender: TObject); override;
    procedure AggiornaAccessoEScarica(const PId: Integer; const PFilePath: String);
  end;

const
  LIMITE_CARATTERI_NOTE = 100;  // limite di caratteri per le note da visualizzare in tabella
  LIMITE_RIGHE_NOTE     =   4;  // limite di ritorni a capo per le note da visualizzare in tabella

implementation

uses IWApplication, IWGlobal, WA155URicercaDocumentaleBrowseFM;

{$R *.dfm}

{ TWA155FRicercaDocumentale }

function TWA155FRicercaDocumentale.InizializzaAccesso: Boolean;
begin
  Result:=True;
end;

procedure TWA155FRicercaDocumentale.IWAppFormCreate(Sender: TObject);
var
  c: Integer;
  Liste: TElencoListe;
begin
  // nasconde funzioni di modifica
  actCopiaSu.Visible:=False;
  actNuovo.Visible:=False;
  actModifica.Visible:=False;
  actElimina.Visible:=False;
  actAnnulla.Visible:=False;
  actConferma.Visible:=False;

  inherited;

  //AddScrollBarManager('divscrollable');

  // valuta abilitazione gestione documenti
  AbilitaGestioneA154:=A000GetInibizioni('Tag','76') <> 'N';

  // gestione tabella
  SolaLettura:=True;
  InterfacciaWR102.DettaglioFM:=False;
  InterfacciaWR102.TemplateAutomatico:=False;
  WR302DM:=TWA155FRicercaDocumentaleDM.Create(Self);
  WR302DM.selTabella:=(WR302DM as TWA155FRicercaDocumentaleDM).A155MW.selT960;
  InterfacciaWR102.NomeTabella:=WR302DM.selTabella.UpdatingTable.ToUpper;

  // imposta la gestione automatica della selezione del periodo
  AssegnaGestPeriodo(edtPeriodoDal,edtPeriodoAl);
  AssegnaGestPeriodo(edtDataCreazioneDal,edtDataCreazioneAl);

  AttivaGestioneC700;

  grdC700.WC700FM.C700MergeSelAnagrafe(WR302DM.selTabella,False);
  grdC700.WC700FM.C700MergeSettaPeriodo(WR302DM.selTabella,Parametri.DataLavoro,Parametri.DataLavoro);
  WR302DM.selTabella.SetVariable('AZIENDA',Parametri.Azienda);
  WR302DM.selTabella.SetVariable('HINTT030V430',Parametri.CampiRiferimento.C26_HintT030V430);
  WR302DM.selTabella.SetVariable('FILTRO_DOCUMENTI',null);
  WR302DM.selTabella.Open;

  WBrowseFM:=TWA155FRicercaDocumentaleBrowseFM.Create(Self);
  // assegna alle checklistbox i rispettivi elementi
  Liste:=(WR302DM as TWA155FRicercaDocumentaleDM).A155MW.Liste;
  lstEstensioni.Items.Assign(Liste.ListaEstensioniT960);
  lstUtenti.Items.Assign(Liste.ListaUtentiT960);
  lstTipologie.Items.Assign(Liste.ListaTipologieT960);
  lstUffici.Items.Assign(Liste.ListaUfficiT960);
end;

procedure TWA155FRicercaDocumentale.IWAppFormRender(Sender: TObject);
var
  LCheckHeight, LCheckWidth: String;
const
  CHECK_EXTRATAG = 'style=white-space:nowrap;margin: 1px 0 1em 0;height:%s;width:%s';
  JQ_HEIGHT      = '$("#%schecklist").height("%s");';
begin
  inherited;

  // stile per le checklistbox
  LCheckHeight:='7em';
  LCheckWidth:='8em';
  lstEstensioni.ExtraTagParams.Text:=Format(CHECK_EXTRATAG,[LCheckHeight,LCheckWidth]);
  LCheckWidth:='16em';
  lstUtenti.ExtraTagParams.Text:=Format(CHECK_EXTRATAG,[LCheckHeight,LCheckWidth]);
  LCheckWidth:='23em';
  lstTipologie.ExtraTagParams.Text:=Format(CHECK_EXTRATAG,[LCheckHeight,LCheckWidth]);
  LCheckWidth:='15em';
  lstUffici.ExtraTagParams.Text:=Format(CHECK_EXTRATAG,[LCheckHeight,LCheckWidth]);

  jqTemp.Enabled:=True;
  jqTemp.OnReady.Clear;
  jqTemp.OnReady.Add(Format(JQ_HEIGHT,[lstEstensioni.HTMLName,'100%']));
  jqTemp.OnReady.Add(Format(JQ_HEIGHT,[lstUtenti.HTMLName,'100%']));
  jqTemp.OnReady.Add(Format(JQ_HEIGHT,[lstTipologie.HTMLName,'100%']));
  jqTemp.OnReady.Add(Format(JQ_HEIGHT,[lstUffici.HTMLName,'100%']));
end;

procedure TWA155FRicercaDocumentale.RefreshPage;
begin
  inherited;
  actAggiornaExecute(nil);
end;

procedure TWA155FRicercaDocumentale.ImpostazioniWC700;
begin
  inherited;
  grdC700.AttivaBrowse:=False;
  grdC700.AttivaLabel:=False;
  grdC700.WC700FM.C700DatiVisualizzati:='';
  grdC700.WC700FM.C700DatiSelezionati:=C700CampiBase;
  grdC700.WC700FM.C700DataLavoro:=Parametri.DataLavoro;
end;

procedure TWA155FRicercaDocumentale.WC700CambioProgressivo(Sender: TObject);
begin
  inherited;
  if (WR302DM.selTabella <> nil) and
     (WR302DM.selTabella.Active) then
  begin
    // aggiorna la tabella
    actAggiornaExecute(nil);
  end;
end;

procedure TWA155FRicercaDocumentale.PulisciFiltri;
var
  i: Integer;
begin
  // nome file ed estensioni
  edtNomeFile.Clear;
  for i:=0 to lstEstensioni.Items.Count - 1 do
    lstEstensioni.Selected[i]:=False;

  // CF Familiare
  edtFamiliare.Clear;

  // utenti
  for i:=0 to lstUtenti.Items.Count - 1 do
    lstUtenti.Selected[i]:=False;

  // periodo
  edtPeriodoDal.Clear;
  edtPeriodoAl.Clear;

  // data creazione
  edtDataCreazioneDal.Clear;
  edtDataCreazioneAl.Clear;

  // dimensione
  edtDimensioneDa.Text:='0';
  edtDimensioneA.Text:='0';

  // tipologie
  for i:=0 to lstTipologie.Items.Count - 1 do
    lstTipologie.Selected[i]:=False;

  // uffici
  for i:=0 to lstUffici.Items.Count - 1 do
    lstUffici.Selected[i]:=False;

  // note
  edtNote.Clear;
end;

procedure TWA155FRicercaDocumentale.Selezionatutto1Click(Sender: TObject);
var
  i: Integer;
begin
  with (pmnSelezione.PopupComponent as TmeTIWCheckListBox) do
  begin
    for i:=0 to Items.Count - 1 do
    begin
      if Sender = SelezionaTutto1 then
        Selected[i]:=True
      else if Sender = DeselezionaTutto1 then
        Selected[i]:=False
      else if Sender = InvertiSelezione1 then
        Selected[i]:=not Selected[i];
    end;
  end;
end;

procedure TWA155FRicercaDocumentale.actAggiornaExecute(Sender: TObject);
var
  LId: Integer;
begin
  // salva id per riposizionamento
  if (WR302DM.selTabella.Active) and
     (WR302DM.selTabella.RecordCount > 0) then
    LId:=WR302DM.selTabella.FieldByName('ID').AsInteger
  else
    LId:=-1;

  // riapre il dataset
  WR302DM.selTabella.Close;
  WR302DM.selTabella.SetVariable('FILTRO_DOCUMENTI',GetFiltroDocumenti);
  grdC700.WC700FM.C700MergeSelAnagrafe(WR302DM.selTabella,False);
  grdC700.WC700FM.C700MergeSettaPeriodo(WR302DM.selTabella,Parametri.DataLavoro,Parametri.DataLavoro);
  WR302DM.selTabella.Open;

  // tenta di riposizionarsi su record precedente
  if LId <> -1 then
    WR302DM.selTabella.SearchRecord('ID',LId,[srFromBeginning]);

  WBrowseFM.grdTabella.medpAggiornaCDS;
  AggiornaRecord;
end;

procedure TWA155FRicercaDocumentale.actPulisciExecute(Sender: TObject);
begin
  PulisciFiltri;
end;

function TWA155FRicercaDocumentale.GetElencoCheckList(PCheckListBox: TmeTIWCheckListBox): String;
// restituisce il commatext dei codici selezionati
var
  i: Integer;
  LElemento: String;
begin
  Result:='';
  for i:=0 to PCheckListBox.Items.Count - 1 do
  begin
    if PCheckListBox.Selected[i] then
    begin
      LElemento:=TValore(PCheckListBox.Items.Objects[i]).Valore;
      Result:=Result + ',' + LElemento;
    end;
  end;

  // elimina la virgola iniziale
  if Result.StartsWith(',') then
    Result:=Result.Substring(1);
end;

function TWA155FRicercaDocumentale.GetFiltroDocumenti: String;
// imposta l'oggetto FiltroDoc per determinare il filtro sql per i documenti,
// quindi restituisce il filtro stesso
var
  LNomeUtente: String;
  i: Integer;
  FD: TFiltroDocumenti;
begin
  // assegna il filtro documenti
  FD:=(WR302DM as TWA155FRicercaDocumentaleDM).A155MW.FiltroDoc;

  // nome file ed estensioni
  FD.NomeFile:=edtNomeFile.Text;
  FD.ListEstensioni.CommaText:=GetElencoCheckList(lstEstensioni);

  // nome file ed estensioni
  FD.CodFiscale:=edtFamiliare.Text;

  // utenti
  FD.ListUtenti.Clear;
  for i:=0 to lstUtenti.Items.Count - 1 do
  begin
    if lstUtenti.Selected[i] then
    begin
      LNomeUtente:=TInfoUtente(lstUtenti.Items.Objects[i]).NomeUtente;
      FD.ListUtenti.Add(TInfoUtente(lstUtenti.Items.Objects[i]));
    end;
  end;

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
  if edtDimensioneDa.Text = '' then
    FD.Dimensione.MinKB:=0
  else if not TryStrToInt(edtDimensioneDa.Text,FD.Dimensione.MinKB) then
    raise Exception.Create(Format('Il dato %s è errato',[lblDimensioneDa.Caption]));
  if edtDimensioneA.Text = '' then
    FD.Dimensione.MaxKB:=0
  else if not TryStrToInt(edtDimensioneA.Text,FD.Dimensione.MaxKB) then
    raise Exception.Create(Format('Il dato %s è errato',[lblDimensioneA.Caption]));

  // tipologie
  FD.ListTipologie.CommaText:=GetElencoCheckList(lstTipologie);

  // uffici
  FD.ListUffici.CommaText:=GetElencoCheckList(lstUffici);

  // note
  FD.Note:=edtNote.Text;

  Result:=FD.GetFiltroSQL;
end;

procedure TWA155FRicercaDocumentale.AggiornaAccessoEScarica(const PId: Integer; const PFilePath: String);
begin
  (WR302DM as TWA155FRicercaDocumentaleDM).A155MW.C021DM.AggiornaDatiAccesso(PId,Parametri.Operatore);
  actAggiornaExecute(nil);

  // effettua il download del file
  NomeFileGenerato:=PFilePath;
  InviaFileGenerato;
end;

end.
