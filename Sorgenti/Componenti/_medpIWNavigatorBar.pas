unit medpIWNavigatorBar;

interface

uses
  SysUtils, Classes, Controls, Math, IWVCLBaseControl, IWBaseControl,
  IWAppForm, IWBaseHTMLControl, IWControl, meIWGrid, StrUtils, Variants,
  IWVCLComponent, IWVCLBaseContainer, OracleData, ActnList, DB,
  medpIWDBGrid, medpIWMessageDlg, meIWImageFile, IWApplication;

type
  TmedpIWNavigatorBar = class(TmeIWGrid)
  private
    FMedpGrid: TmedpIWDBGrid;
    DataSet: ToracleDataSet;
    ActionList: TActionList;
    procedure CreaActionList;
    procedure CreaNavigatorBar;
    procedure DataSetStateChange;
    procedure SetMedpGrid(const Value: TmedpIWDBGrid);
    procedure imgNavBarClick(Sender: TObject);
    procedure ResultDelete(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
    actPrimo,
    actPrecedente,
    actRicerca,
    actSuccessivo,
    actUltimo,
    actNuovo,
    actCopiaSu,
    actModifica,
    actElimina,
    actAnnulla,
    actConferma,
    actAggiorna: TAction;
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    procedure AggiornaToolBar;
    procedure AbilitaActListNavBar;
    procedure AbilitaToolBar(abilita: Boolean);
    procedure actPrimoExecute(Sender: TObject);
    procedure actAggiornaExecute(Sender: TObject);
    procedure actPrecedenteExecute(Sender: TObject);
    procedure actSuccessivoExecute(Sender: TObject);
    procedure actUltimoExecute(Sender: TObject);
    procedure actRicercaExecute(Sender: TObject);
    procedure actNuovoExecute(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);
    procedure actEliminaExecute(Sender: TObject);
    procedure actAnnullaExecute(Sender: TObject);
    procedure actConfermaExecute(Sender: TObject);
  published
    property MedpGrid: TmedpIWDBGrid read FMedpGrid write SetMedpGrid;
  end;

implementation

uses C190FunzioniGeneraliWeb, WC003URicercaDatiFM, A000UInterfaccia, A000UMessaggi;

constructor TmedpIWNavigatorBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if Owner is TWinControl then
    Parent:=(Owner as TWinControl);
  Css:='medpToolBar';
  CreaActionList;
  CreaNavigatorBar;
end;

destructor TmedpIWNavigatorBar.Destroy;
begin
  inherited Destroy;
end;

procedure TmedpIWNavigatorBar.SetMedpGrid(const Value: TmedpIWDBGrid);
begin
  FMedpGrid := Value;
  DataSet:=(FMedpGrid.medpDataSet as ToracleDataSet);
  AbilitaActListNavBar;
end;

procedure TmedpIWNavigatorBar.CreaActionList;
begin
  ActionList:=TActionList.Create(Self);

  actAggiorna:=TAction.Create(Self);
  actAggiorna.Caption:='btnAggiorna';
  actAggiorna.Category:='Funzioni';
  actAggiorna.Hint:='Aggiorna';
  actAggiorna.Name:=C190CreaNomeComponente('actNavBarAggiorna',Self.Owner);
  actAggiorna.Tag:=6;
  actAggiorna.OnExecute:=actAggiornaExecute;
  actAggiorna.ActionList:=ActionList;

  actRicerca:=TAction.Create(Self);
  actRicerca.Caption:='btnCerca';
  actRicerca.Category:='Funzioni';
  actRicerca.Hint:='Ricerca/Filtra';
  actRicerca.Name:=C190CreaNomeComponente('actNavBarRicerca',Self.Owner);
  actRicerca.Tag:=1;
  actRicerca.OnExecute:=actRicercaExecute;
  actRicerca.ActionList:=ActionList;

  actPrimo:=TAction.Create(Self);
  actPrimo.Caption:='btnPrimo';
  actPrimo.Category:='Selezione';
  actPrimo.Hint:='Primo';
  actPrimo.Name:=C190CreaNomeComponente('actNavBarPrimo',Self.Owner);
  actPrimo.Tag:=2;
  actPrimo.OnExecute:=actPrimoExecute;
  actPrimo.ActionList:=ActionList;

  actPrecedente:=TAction.Create(Self);
  actPrecedente.Caption:='btnPrecedente';
  actPrecedente.Category:='Selezione';
  actPrecedente.Hint:='Precedente';
  actPrecedente.Name:=C190CreaNomeComponente('actNavBarPrecedente',Self.Owner);
  actPrecedente.Tag:=3;
  actPrecedente.OnExecute:=actPrecedenteExecute;
  actPrecedente.ActionList:=ActionList;

  actSuccessivo:=TAction.Create(Self);
  actSuccessivo.Caption:='btnSuccessivo';
  actSuccessivo.Category:='Selezione';
  actSuccessivo.Hint:='Successivo';
  actSuccessivo.Name:=C190CreaNomeComponente('actNavBarSuccessivo',Self.Owner);
  actSuccessivo.Tag:=4;
  actSuccessivo.OnExecute:=actSuccessivoExecute;
  actSuccessivo.ActionList:=ActionList;

  actUltimo:=TAction.Create(Self);
  actUltimo.Caption:='btnUltimo';
  actUltimo.Category:='Selezione';
  actUltimo.Hint:='Ultimo';
  actUltimo.Name:=C190CreaNomeComponente('actNavBarUltimo',Self.Owner);
  actUltimo.Tag:=5;
  actUltimo.OnExecute:=actUltimoExecute;
  actUltimo.ActionList:=ActionList;

  actNuovo:=TAction.Create(Self);
  actNuovo.Caption:='btnInserisci';
  actNuovo.Category:='Edit';
  actNuovo.Hint:='Modifica';
  actNuovo.Name:=C190CreaNomeComponente('actNavBarNuovo',Self.Owner);
  actNuovo.Tag:=8;
  actNuovo.OnExecute:=actNuovoExecute;
  actNuovo.ActionList:=ActionList;

  actModifica:=TAction.Create(Self);
  actModifica.Caption:='btnModifica';
  actModifica.Category:='Edit';
  actModifica.Hint:='Modifica';
  actModifica.Name:=C190CreaNomeComponente('actNavBarModifica',Self.Owner);
  actModifica.Tag:=8;
  actModifica.OnExecute:=actModificaExecute;
  actModifica.ActionList:=ActionList;

  actElimina:=TAction.Create(Self);
  actElimina.Caption:='btnElimina';
  actElimina.Category:='Edit';
  actElimina.Hint:='Elimina';
  actElimina.Name:=C190CreaNomeComponente('actNavBarElimina',Self.Owner);
  actElimina.Tag:=9;
  actElimina.OnExecute:=actEliminaExecute;
  actElimina.ActionList:=ActionList;

  actAnnulla:=TAction.Create(Self);
  actAnnulla.Caption:='btnAnnulla';
  actAnnulla.Category:='Validazione';
  actAnnulla.Hint:='Annulla';
  actAnnulla.Name:=C190CreaNomeComponente('actNavBarAnnulla',Self.Owner);
  actAnnulla.Tag:=10;
  actAnnulla.OnExecute:=actAnnullaExecute;
  actAnnulla.ActionList:=ActionList;

  actConferma:=TAction.Create(Self);
  actConferma.Caption:='btnConferma';
  actConferma.Category:='Validazione';
  actConferma.Hint:='Conferma';
  actConferma.Name:=C190CreaNomeComponente('actNavBarConferma',Self.Owner);
  actConferma.Tag:=11;
  actConferma.OnExecute:=actConfermaExecute;
  actConferma.ActionList:=ActionList;
end;

procedure TmedpIWNavigatorBar.actConfermaExecute(Sender: TObject);
// conferma operazione
var
  RowID:String;
  r: Integer;
begin
  //Gestione dbgrid
  if not FMedpGrid.medpEditMultiplo then
  begin
    r:=FMedpGrid.medpDataSet.RecNo;
    if FMedpGrid.medpGetCurrPag > 1 then
      r:=r - (FMedpGrid.medpGetCurrPag - 1)  *  FMedpGrid.medpRighePagina;
    FMedpGrid.medpConferma(ifThen(FMedpGrid.medpDataSet.State = dsInsert,0,r - IfThen(FMedpGrid.RigaInserimento,0,1)));
  end
  else
  begin
    FMedpGrid.medpDataSet.Cancel;
    FMedpGrid.medpDataSet.First;
    for r:=IfThen(FMedpGrid.RigaInserimento,1,0) to High(FMedpGrid.medpCompGriglia) do
    begin
      FMedpGrid.medpDataSet.Edit;
      FMedpGrid.medpConferma(r);
      FMedpGrid.medpDataSet.Next;
    end;
    FMedpGrid.medpDataSet.First;
  end;
  if FMedpGrid.medpCachedUpdates then
    DataSet.Session.ApplyUpdates([DataSet],True);
  FMedpGrid.medpStato:=msBrowse;
  RowID:=DataSet.RowId;
  FMedpGrid.medpCreaColonne;
  DataSet.Locate('ROWID',RowID,[]);
  FMedpGrid.medpAggiornaCDS;
  AbilitaActListNavBar;
end;

procedure TmedpIWNavigatorBar.actAnnullaExecute(Sender: TObject);
// annullamento operazione
var
  RowID:String;
begin
  inherited;
  FMedpGrid.medpStato:=msBrowse;
  DataSet.Cancel;
  RowID:=FMedpGrid.medpClientDataSet.FieldByName('DBG_ROWID').AsString;
  FMedpGrid.medpCreaColonne;
  DataSet.Locate('ROWID',RowID,[]);
  FMedpGrid.medpAggiornaCDS;
  AbilitaActListNavBar;
end;

procedure TmedpIWNavigatorBar.actEliminaExecute(Sender: TObject);
begin
  inherited;
  if DataSet.RecordCount = 0 then
   exit;
  MsgBox.WebMessageDlg(A000MSG_DLG_CANCELLAZIONE,mtConfirmation,[mbYes,mbNo],ResultDelete,'')
end;

procedure TmedpIWNavigatorBar.ResultDelete(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    if DataSet.CachedUpdates then
    begin
      DataSet.ReadOnly:=False;
      DataSet.Delete;
      DataSet.Session.ApplyUpdates([DataSet],True);
      DataSet.ReadOnly:=True;
    end
    else
      DataSet.Delete;
    FMedpGrid.medpAggiornaCDS;
  end;
  AbilitaActListNavBar;
end;

procedure TmedpIWNavigatorBar.actModificaExecute(Sender: TObject);
// modifica del record attuale
begin
  inherited;
  if DataSet.CachedUpdates then
  begin
    DataSet.ReadOnly:=False;
    if DataSet.UpdatesPending then
      DataSet.CommitUpdates;
  end;
  DataSet.Edit;
  FMedpGrid.medpModifica(False);
  AbilitaActListNavBar;
end;

procedure TmedpIWNavigatorBar.actNuovoExecute(Sender: TObject);
// inserimento nuovo record
begin
  if DataSet.CachedUpdates then
    DataSet.ReadOnly:=False;
  DataSet.Insert;
  FMedpGrid.medpInserisci(False);
  AbilitaActListNavBar;
end;

procedure TmedpIWNavigatorBar.actRicercaExecute(Sender: TObject);
// creazione frame di ricerca
begin
  inherited;
  with TWC003FRicercaDatiFM.Create(GGetWebApplicationThreadVar) do
  begin
    SearchGrid:=FMedpGrid;
    SearchDataset:=DataSet;
    Visualizza;
  end;
end;

procedure TmedpIWNavigatorBar.actPrecedenteExecute(Sender: TObject);
// spostamento su record precedente
begin
  inherited;
  DataSet.DisableControls;
  DataSet.Prior;
  DataSet.EnableControls;
  FMedpGrid.medpAggiornaCDS(False);
end;

procedure TmedpIWNavigatorBar.actSuccessivoExecute(Sender: TObject);
// spostamento su record precedente
begin
  inherited;
  DataSet.DisableControls;
  DataSet.Next;
  DataSet.EnableControls;
  FMedpGrid.medpAggiornaCDS(False);
end;

procedure TmedpIWNavigatorBar.actAggiornaExecute(Sender: TObject);
// refresh del dataset
var i,k:Integer;
    ID,ElencoCampi:String;
    VarValori:Variant;
begin
  ID:='';
  ID:=DataSet.RowID;
  //Gestione della mancanza di rowid per successivo posizionamento
  if ID = '' then
  begin
    k:=0;
    for i:=0 to DataSet.FieldCount - 1 do
      if DataSet.Fields[i].FieldKind = fkData then
        inc(k);
    VarValori:=VarArrayCreate([0,k - 1],VarVariant);
    ElencoCampi:='';
    k:=-1;
    for i:=0 to DataSet.FieldCount - 1 do
    begin
      if DataSet.Fields[i].FieldKind = fkData then
      begin
        inc(k);
        VarValori[k]:=DataSet.Fields[i].Value;
        ElencoCampi:=ElencoCampi + DataSet.Fields[i].FieldName + ';';
      end;
    end;
    if Copy(ElencoCampi,Length(ElencoCampi),1) = ';' then
      ElencoCampi:=Copy(ElencoCampi,1,Length(ElencoCampi) - 1);
  end;

  DataSet.Refresh;

  if (DataSet is TOracleDataSet) and (ID <> '') then
    DataSet.Locate('RowID',ID,[])
  else
  begin
    DataSet.Locate(ElencoCampi,VarValori,[]);
    VarClear(VarValori);
  end;

  FMedpGrid.medpAggiornaCDS;
end;

procedure TmedpIWNavigatorBar.actPrimoExecute(Sender: TObject);
var S,S2,RI,RI2:String;
begin
  // spostamento su primo record
  inherited;
  RI:=DataSet.RowID;
  DataSet.DisableControls;
  DataSet.First;
  DataSet.EnableControls;
  FMedpGrid.medpAggiornaCDS(False);
end;

procedure TmedpIWNavigatorBar.actUltimoExecute(Sender: TObject);
var S,S2,RI,RI2:String;
begin
  // spostamento su ultimo record
  inherited;
  RI:=DataSet.RowID;
  DataSet.DisableControls;
  DataSet.Last;
  DataSet.EnableControls;
  FMedpGrid.medpAggiornaCDS(False);
end;

procedure TmedpIWNavigatorBar.CreaNavigatorBar;
var
  i, k:Integer;
  PrecCategory: String;
begin
  RowCount:=1;
  ColumnCount:=ActionList.ActionCount;

  if ActionList.ActionCount > 0 then
    PrecCategory:=TAction(ActionList.Actions[0]).Category;

  k:=0;
  for i:=0 to ActionList.ActionCount - 1 do
  begin
    if PrecCategory <> TAction(ActionList.Actions[i]).Category  then
    begin
      Cell[0,k].Css:='x';
      Cell[0,k].Text:='';
      k:=k + 1;
      ColumnCount:=ColumnCount + 1;
      PrecCategory:=TAction(ActionList.Actions[i]).Category;
    end;
    Cell[0,k].Control:=TmeIWImageFile.Create(Self);
    with TmeIWImageFile(Cell[0,k].Control) do
    begin
      Name:=C190CreaNomeComponente(TAction(ActionList.Actions[i]).Name,Self);
      OnClick:=imgNavBarClick;
      Tag:=i;
    end;
    Cell[0,k].Css:='x';
    Cell[0,k].Text:='';
    k:=k + 1;
  end;
  AggiornaToolBar;
end;

procedure TmedpIWNavigatorBar.imgNavBarClick(Sender: TObject);
begin
  TAction(ActionList.Actions[TmeIWImageFile(Sender).Tag]).Execute;
end;

procedure TmedpIWNavigatorBar.AggiornaToolBar;
// Imposta le proprietà Visible e Enabled dei pulsanti legati alle Action delle ToolBar
var
  i, k:Integer;
  PrecCategory,NomeFile: String;
  img: TmeIWImageFile;
  act: TAction;
begin
  if ActionList.ActionCount > 0 then
    PrecCategory:=(ActionList.Actions[0] as TAction).Category;

  k:=0;
  for i:=0 to ActionList.ActionCount - 1 do
  begin
    if PrecCategory <> (ActionList.Actions[i] as TAction).Category  then
    begin
      k:=k + 1;
      PrecCategory:=(ActionList.Actions[i] as TAction).Category;
    end;
    if k > ColumnCount - 1 then
      Break;

    //img:=TmeIWImageFile(ToolBarGrid.Cell[0,k].Control);
    act:=(ActionList.Actions[i] as TAction);

    Cell[0,k].Visible:=act.Visible;
    //if act.Tag < 1000 then
    if Cell[0,k].Control is TmeIWImageFile then
    begin
      if act.Visible then
      begin
        img:=(Cell[0,k].Control as TmeIWImageFile);
        img.Hint:=act.Hint;
        img.Enabled:=act.Enabled;
        NomeFile:=act.Caption + IfThen(not act.Enabled,'_Disabled') + IfThen(act.Checked,'_Checked');
        img.ImageFile.FileName:=Format('img/%s.png',[NomeFile]);
      end;
    end
    else
    begin
      if Cell[0,k].Control <> nil then
        (Cell[0,k].Control as TIWCustomControl).Enabled:=act.Enabled;
    end;
    k:=k + 1;
  end;
end;

procedure TmedpIWNavigatorBar.AbilitaActListNavBar;
var Browse: Boolean;
begin
  Browse:=not (DataSet.State in [dsInsert,dsEdit]);
  DataSetStateChange;
  actRicerca.Enabled:=Browse;
  actPrimo.Enabled:=Browse;
  actPrecedente.Enabled:=Browse;
  actSuccessivo.Enabled:=Browse;
  actUltimo.Enabled:=Browse;
  {actEstrai.Enabled:=Browse;
  actPrecedenteStorico.Enabled:=Browse;
  actSuccessivoStorico.Enabled:=Browse;
  actSelezioneStorico.Enabled:=Browse;
  actElimina.Enabled:=Browse and not(SolaLettura);
  actNuovo.Enabled:=Browse and not(SolaLettura);
  actModifica.Enabled:=Browse and not(SolaLettura);  }

  actElimina.Enabled:=Browse;
  actNuovo.Enabled:=Browse;
  actModifica.Enabled:=Browse;

  actConferma.Enabled:=not Browse;
  actAnnulla.Enabled:=not Browse;

  //actCopiaSu.Enabled:=Browse and not(SolaLettura);
  //actCopiaSu.Enabled:=Browse;
  actAggiorna.Enabled:=Browse;
  AggiornaToolBar;
end;

procedure TmedpIWNavigatorBar.AbilitaToolBar(abilita: Boolean);
begin
  actRicerca.Enabled:=abilita;
  actPrimo.Enabled:=abilita;
  actPrecedente.Enabled:=abilita;
  actSuccessivo.Enabled:=abilita;
  actUltimo.Enabled:=abilita;
  {actEstrai.Enabled:=Browse;
  actPrecedenteStorico.Enabled:=Browse;
  actSuccessivoStorico.Enabled:=Browse;
  actSelezioneStorico.Enabled:=Browse;
  actElimina.Enabled:=Browse and not(SolaLettura);
  actNuovo.Enabled:=Browse and not(SolaLettura);
  actModifica.Enabled:=Browse and not(SolaLettura);  }

  actElimina.Enabled:=abilita;
  actNuovo.Enabled:=abilita;
  actModifica.Enabled:=abilita;

  actConferma.Enabled:=abilita;
  actAnnulla.Enabled:=abilita;

  //actCopiaSu.Enabled:=Browse and not(SolaLettura);
  //actCopiaSu.Enabled:=Browse;
  actAggiorna.Enabled:=abilita;
  AggiornaToolBar;
end;

procedure TmedpIWNavigatorBar.DataSetStateChange;
var
  Browse:Boolean;
begin
  if DataSet.Active then
  begin
    Browse:=not (DataSet.State in [dsInsert,dsEdit]);
    FMedpGrid.medpBrowse:=Browse;
    if DataSet.State = dsInsert then
      FMedpGrid.medpClientDataSet.First;
    FMedpGrid.RowClick:=Browse;
  end;
end;


end.
