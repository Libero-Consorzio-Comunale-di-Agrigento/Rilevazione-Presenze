unit WA186ULoginDipendenti;

interface

uses
  WA186ULoginDipendentiBrowseFM,
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWCompEdit, IWHTMLControls, meIWLink,
  ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel, Variants,
  A000UInterfaccia, A000UCostanti, A000USessione, WR100UBase,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion,
  IWCompButton, WR103UGestMasterDetail,
  IWDBStdCtrls, meIWLabel, WR302UGestTabellaDM, meIWButton, meIWDBNavigator,
  meIWGrid, medpIWTabControl, medpIWStatusBar, C180FunzioniGenerali,
  medpIWMessageDlg, WC009UCopiaSuFM, Oracle, OracleData, Db,
  meIWComboBox, IWCompProgressBar, IWBaseComponent, medpIWMultiColumnComboBox,
  IWBaseHTMLComponent, IWBaseHTML40Component, meIWTimer, meIWEdit, meIWImageFile,
  WA186ULoginDipendentiProfiliFM, WR102UGestTabella,
  IWCompGrids,C190FunzioniGeneraliWeb, meIWRegion, IWCompExtCtrls, System.Actions,
  System.StrUtils, IWCompJQueryWidget;

type
  TWA186FLoginDipendenti = class(TWR103FGestMasterDetail)
    actCreaLogin: TAction;
    jqGestSolaLettura: TIWJQueryWidget;
    procedure IWAppFormCreate(Sender: TObject);
    procedure actNuovoExecute(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);
    procedure actConfermaExecute(Sender: TObject);
    procedure actAnnullaExecute(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
  private
    FProgressivo: Integer;
    FModalitaVisualizzazione: Boolean;
    FAccessoForzato: Boolean;
  public
    procedure OpenPage; override;
    function InizializzaAccesso: Boolean; override;
    procedure selTabellaStateChange(DataSet: TDataSet); override;
    function CaricaStrNomiProfili:String;
    procedure CaricaCmbPermessi(ComboBox: TmeIWComboBox);
    procedure CaricaCmbFiltroAnagrafe(ComboBox: TmeIWComboBox);
    procedure CaricaCmbFiltroFunzioni(ComboBox: TmeIWComboBox);
    procedure CaricaCmbFiltroDizionario(ComboBox: TmeIWComboBox);
    procedure CaricaCmbNomeProfilo(ComboBox: TMedpIWMultiColumnComboBox); //PALERMO_POLICLINICO - 159894: modificata gestione della combo
    procedure CaricaCmbFiltroIter(ComboBox: TmeIWComboBox); // filtro iter autorizzativi
    procedure CaricaCmbDelegatoDa(ComboBox: TmeIWComboBox); // modifica delegato_da
    property ModalitaVisualizzazione: Boolean read FModalitaVisualizzazione;
  end;

implementation

uses
  WA186ULoginDipendentiDM;

{$R *.dfm}

procedure TWA186FLoginDipendenti.OpenPage;
begin
  FProgressivo:=StrToIntDef(GetParam('PROGRESSIVO'),0);
  FModalitaVisualizzazione:=(GetParam('MODALITA_VISUALIZZAZIONE').ToUpper = 'TRUE');

  // in caso di modalità visualizzazione forza l'accesso in sola lettura
  FAccessoForzato:=FModalitaVisualizzazione and (not AccessoAbilitato);
  if FAccessoForzato then
  begin
    // forza l'accesso abilitato alla funzione
    AccessoAbilitato:=True;

    // forza l'accesso in sola lettura
    SolaLettura:=True;
  end;

  inherited;
end;

function TWA186FLoginDipendenti.InizializzaAccesso: Boolean;
begin
  // la modalità visualizzazione prevede la sola visualizzazione dei login associati al progressivo indicato
  if FModalitaVisualizzazione then
  begin
    // imposta la selezione anagrafica ereditata e la esegue
    grdC700.actC700EreditaSelezioneExecute(nil);

    // posizionamento sul progressivo indicato
    grdC700.WC700FM.C700Progressivo:=FProgressivo;

    // conferma la selezione
    grdC700.WC700FM.actConfermaExecute(nil);
  end;

  Result:=True;
end;

procedure TWA186FLoginDipendenti.IWAppFormCreate(Sender: TObject);
var
  Detail:TWA186FLoginDipendentiProfiliFM;
begin
  inherited;

  FProgressivo:=0;
  FModalitaVisualizzazione:=False;
  FAccessoForzato:=False;

  WR100LinkWC700:=False;
  AttivaGestioneC700;

  WR302DM:=TWA186FLoginDipendentiDM.Create(Self);
  InterfacciaWR102.DettaglioFM:=False;
  WBrowseFM:=TWA186FLoginDipendentiBrowseFM.Create(Self);
  CreaTabDefault;

  Detail:=TWA186FLoginDipendentiProfiliFM.Create(Self);
  AggiungiDetail(Detail);
  Detail.CaricaDettaglio(TWA186FLoginDipendentiDM(WR302DM).selI061,TWA186FLoginDipendentiDM(WR302DM).dsrI061);
end;

procedure TWA186FLoginDipendenti.IWAppFormRender(Sender: TObject);
var
  LJSCode: String;
begin
  inherited;

  // modalità sola visualizzazione
  LJSCode:='';
  if FAccessoForzato then
  begin
    // nasconde la tabella che contiene selezione anagrafica + azienda
    LJSCode:=LJSCode + 'document.getElementById("wa186_pnlAnagAzienda").style.display = "none"; '#13#10;
  end;
  if LJSCode <> '' then
    AddToInitProc(LJSCode);

  // visualizza / nasconde elementi interfaccia in base alla modalità di accesso alla funzione
  jqGestSolaLettura.Enabled:=SolaLettura;
end;

procedure TWA186FLoginDipendenti.selTabellaStateChange(DataSet: TDataSet);
begin
  actCreaLogin.Enabled:=not (DataSet.State in [dsInsert,dsEdit]);
  inherited;
end;

function TWA186FLoginDipendenti.CaricaStrNomiProfili:String;
begin
  with TWA186FLoginDipendentiDM(WR302DM) do
  begin
    selI061Dist.Close;
    selI061Dist.SetVariable('AZIENDA',QI090.FieldByName('AZIENDA').AsString);
    selI061Dist.Open;
    selI061Dist.First;
    Result:='';
    while Not selI061Dist.Eof do
    begin
      Result:=Result + '''' + C190EscapeJS(selI061Dist.FieldByName('NOME_PROFILO').AsString) + ''',';
      selI061Dist.Next;
    end;
  end;
end;

procedure TWA186FLoginDipendenti.CaricaCmbPermessi(ComboBox: TmeIWComboBox);
begin
  ComboBox.Items.Clear;
  with TWA186FLoginDipendentiDM(WR302DM) do
  begin
    selI071.First;
    while not selI071.Eof do
    begin
      ComboBox.Items.Add(selI071.FieldByName('PROFILO').AsString);
      selI071.Next;
    end;
  end;
end;

procedure TWA186FLoginDipendenti.CaricaCmbFiltroAnagrafe(ComboBox: TmeIWComboBox);
begin
  ComboBox.Items.Clear;
  with TWA186FLoginDipendentiDM(WR302DM) do
  begin
    selI072Dist.First;
    while not selI072Dist.Eof do
    begin
      ComboBox.Items.Add(selI072Dist.FieldByName('PROFILO').AsString);
      selI072Dist.Next;
    end;
  end;
end;

procedure TWA186FLoginDipendenti.CaricaCmbFiltroFunzioni(ComboBox: TmeIWComboBox);
begin
  ComboBox.Items.Clear;
  with TWA186FLoginDipendentiDM(WR302DM) do
  begin
    selI073Dist.First;
    while not selI073Dist.Eof do
    begin
      ComboBox.Items.Add(selI073Dist.FieldByName('PROFILO').AsString);
      selI073Dist.Next;
    end;
  end;
end;

procedure TWA186FLoginDipendenti.CaricaCmbFiltroDizionario(ComboBox: TmeIWComboBox);
begin
  ComboBox.Items.Clear;
  with TWA186FLoginDipendentiDM(WR302DM) do
  begin
    selI074Dist.First;
    while not selI074Dist.Eof do
    begin
      ComboBox.Items.Add(selI074Dist.FieldByName('PROFILO').AsString);
      selI074Dist.Next;
    end;
  end;
end;

// filtro iter autorizzativi.ini
procedure TWA186FLoginDipendenti.CaricaCmbFiltroIter(ComboBox: TmeIWComboBox);
begin
  ComboBox.Items.Clear;
  with TWA186FLoginDipendentiDM(WR302DM) do
  begin
    selI075Dist.First;
    while not selI075Dist.Eof do
    begin
      ComboBox.Items.Add(selI075Dist.FieldByName('PROFILO').AsString);
      selI075Dist.Next;
    end;
  end;
end;
procedure TWA186FLoginDipendenti.CaricaCmbNomeProfilo(ComboBox: TMedpIWMultiColumnComboBox);
begin
  ComboBox.Items.Clear;
  with TWA186FLoginDipendentiDM(WR302DM) do
  begin
    selI061Dist.Close;
    selI061Dist.SetVariable('AZIENDA',selI090.FieldByName('AZIENDA').AsString);
    selI061Dist.Open;
    selI061Dist.First;
    while not selI061Dist.Eof do
    begin
      ComboBox.AddRow(selI061Dist.FieldByName('NOME_PROFILO').AsString);
      selI061Dist.Next;
    end;
  end;
end;

// filtro iter autorizzativi.fine

// modifica delegato_da.ini
procedure TWA186FLoginDipendenti.CaricaCmbDelegatoDa(ComboBox: TmeIWComboBox);
begin
  ComboBox.Items.Clear;
  with TWA186FLoginDipendentiDM(WR302DM) do
  begin
    selI060.First;
    while not selI060.Eof do
    begin
      if selI060.FieldByName('NOME_UTENTE').AsString <> selTabella.FieldByName('NOME_UTENTE').AsString then
        ComboBox.Items.Add(selI060.FieldByName('NOME_UTENTE').AsString);
      selI060.Next;
    end;
  end;
end;
// modifica delegato_da.fine

procedure TWA186FLoginDipendenti.actModificaExecute(Sender: TObject);
var
  x:Integer;
begin
  inherited;

  TWA186FLoginDipendentiBrowseFM(WBrowseFM).dcmbAzienda.Enabled:=False;
end;

procedure TWA186FLoginDipendenti.actNuovoExecute(Sender: TObject);
begin
  inherited;
  TWA186FLoginDipendentiBrowseFM(WBrowseFM).dcmbAzienda.Enabled:=False;
end;

procedure TWA186FLoginDipendenti.actAnnullaExecute(Sender: TObject);
begin
  TWA186FLoginDipendentiBrowseFM(WBrowseFM).dcmbAzienda.Enabled:=True;
  inherited;
end;

procedure TWA186FLoginDipendenti.actConfermaExecute(Sender: TObject);
var
  RowID:String;
  x:Integer;
begin
  inherited;
  TWA186FLoginDipendentiBrowseFM(WBrowseFM).dcmbAzienda.Enabled:=True;
end;

end.
