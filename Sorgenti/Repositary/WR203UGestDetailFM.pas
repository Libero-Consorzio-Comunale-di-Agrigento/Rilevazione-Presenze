unit WR203UGestDetailFM;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Math, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWDBGrids, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWCompEdit,
  IWHTML40Container, IWRegion, ActnList, Oracle, OracleData, DB,
  A000UInterfaccia,
  meIWGrid, meIWImageFile, meIWEdit, medpIWDBGrid, medpIWMessageDlg,
  C190FunzioniGeneraliWeb, C180FunzioniGenerali,
  WR100UBase, WR102UGestTabella, WR103UGestMasterDetail, WR204UBrowseTabellaFM,
  WC003URicercaDatiFM, WC004UEstrazioneDatiFM, IWCompGrids, IWCompJQueryWidget,A000UMessaggi,
  System.Actions, Vcl.Menus, WR010UBase;

type
  TWR203FGestDetailFM = class(TWR204FBrowseTabellaFM)
    actlstDetailNavBar: TActionList;
    actAggiorna: TAction;
    actRicerca: TAction;
    actEstrai: TAction;
    actPrimo: TAction;
    actPrecedente: TAction;
    actSuccessivo: TAction;
    actUltimo: TAction;
    actNuovo: TAction;
    actCopiaSu: TAction;
    actModifica: TAction;
    actElimina: TAction;
    actAnnulla: TAction;
    actConferma: TAction;
    grdDetailNavBar: TmeIWGrid;
    pmnGrdTabellaDett: TPopupMenu;
    actScaricaInExcelDett: TMenuItem;
    actScaricaInCSVDett: TMenuItem;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure actAggiornaExecute(Sender: TObject);
    procedure actAnnullaExecute(Sender: TObject);
    procedure actConfermaExecute(Sender: TObject);virtual;
    procedure actEliminaExecute(Sender: TObject);virtual;
    procedure actModificaExecute(Sender: TObject);
    procedure actNuovoExecute(Sender: TObject);
    procedure actPrecedenteExecute(Sender: TObject);
    procedure actPrimoExecute(Sender: TObject);
    procedure actRicercaExecute(Sender: TObject);
    procedure actSuccessivoExecute(Sender: TObject);
    procedure actUltimoExecute(Sender: TObject);
    procedure actEstraiExecute(Sender: TObject);
    procedure TemplateProcessorBeforeProcess(var VTemplate: TStream);
  private
    procedure DataSetTranslateMessage(Sender: TOracleDataSet; ErrorCode: Integer; const ConstraintName: string; Action: Char; var Msg: string);
  protected
    DataSetReadOnlyOriginale:Boolean;
    procedure ResultDelete(Sender: TObject; R: TmeIWModalResult; KI: String); virtual;
    function InserimentoAbilitato:Boolean; override;
  public
    Relazionato:Boolean;
    DSMasterState:TDataSetState;
    evBeforeApplyUpdates:procedure of object;
    procedure AggiornaDettaglio; virtual;
    procedure CaricaDettaglio(DataSet:TDataSet; DataSource:TDataSource); overload; virtual;
    procedure imgDetailNavBarClick(Sender: TObject);
    procedure DataSourceStateChange(Sender: TObject); virtual;
  end;

implementation

{$R *.dfm}

procedure TWR203FGestDetailFM.IWFrameRegionCreate(Sender: TObject);
begin
  actScaricaInExcelDett.Name:=C190CreaNomeComponente(actScaricaInExcelDett.Name,Self);
  pmnGrdTabellaDett.Name:=C190CreaNomeComponente(pmnGrdTabellaDett.Name,Self);
  inherited;
  TWR102FGestTabella(Self.Owner).CreaNavigatorBar(actlstDetailNavBar,grdDetailNavBar,imgDetailNavBarClick);
  grdTabella.medpEditMultiplo:=True;
  Relazionato:=True;
end;

procedure TWR203FGestDetailFM.CaricaDettaglio(DataSet:TDataSet; DataSource:TDataSource);
begin
  grdTabella.RigaInserimento:=InserimentoAbilitato;
  grdTabella.medpAttivaGrid(DataSet,False,False);

  grdTabella.medpDataSource:=DataSource;
  grdTabella.medpDataSource.OnStateChange:=DataSourceStateChange;
  DataSourceStateChange(DataSet);

  grdTabella.medpPreparaComponentiDefault;
end;

procedure TWR203FGestDetailFM.actEstraiExecute(Sender: TObject);
begin
  inherited;
  with TWC004FEstrazioneDatiFM.Create(Self.Owner) do
  begin
    InizializzaQuery(Self);
    Visualizza;
  end;
end;

function TWR203FGestDetailFM.InserimentoAbilitato:Boolean;
begin
  Result:=False;
  if (not TWR100FBase(Self.Owner).SolaLettura) and
     (actNuovo.Visible)then
    Result:=True;
end;

procedure TWR203FGestDetailFM.actEliminaExecute(Sender: TObject);
begin
  if grdTabella.medpDataSet.RecordCount = 0 then
   exit;

  //DC 30-10-2020 - controlla che la riga selezionata non sia quella vuota
  if grdTabella.medpClientDataset.FieldByName('DBG_ROWID').AsString = '*' then
    exit;

  MsgBox.WebMessageDlg(A000MSG_DLG_CANCELLAZIONE,mtConfirmation,[mbYes,mbNo],ResultDelete,'');
end;

procedure TWR203FGestDetailFM.ResultDelete(Sender: TObject; R: TmeIWModalResult; KI: String);
var
  RowID:String;
begin
  if R = mrYes then
  begin
    DataSetReadOnlyOriginale:=grdTabella.medpReadOnly;
    if DataSetReadOnlyOriginale then
      TOracleDataSet(grdTabella.medpDataSet).ReadOnly:=False;
    try
      grdTabella.medpCancella;
      if grdTabella.medpCachedUpdates then
      begin
        if Assigned(evBeforeApplyUpdates) then
          evBeforeApplyUpdates;
        SessioneOracle.ApplyUpdates([TOracleDataSet(grdTabella.medpDataSet)],False);
      end;
      SessioneOracle.Commit;
      TOracleDataSet(grdTabella.medpDataSet).CancelUpdates;
    finally
      if DataSetReadOnlyOriginale then
        TOracleDataSet(grdTabella.medpDataSet).ReadOnly:=True;
    end;

    grdTabella.medpDataSet.Cancel;
    grdTabella.medpDataSet.First;
    RowID:=TOracleDataSet(grdTabella.medpDataSet).RowId;
    grdTabella.medpCreaColonne;
    grdTabella.medpDataSet.Locate('ROWID',RowID,[]);
    grdTabella.medpAggiornaCDS;
  end;
end;

procedure TWR203FGestDetailFM.TemplateProcessorBeforeProcess(
  var VTemplate: TStream);
var
  StrListTemp: TStringList;
  nomeForm,sScroll: String;
begin
  inherited;
  StrListTemp:=TStringList.Create();
  StrListTemp.LoadFromStream(VTemplate);

  nomeForm:=(Self.Owner as TWR010FBase).medpCodiceForm;
  sScroll:='onscroll="onscrollDivWR010(this,''HIDDEN_' + nomeForm + 'DIVSCROLLABLEWR203SCROLLTOP'',''HIDDEN_' + nomeForm + 'DIVSCROLLABLEWR203SCROLLLEFT'');"';


  StrListTemp.Text:=StringReplace(strListTemp.Text, '{%SCROLLWR203%}', sScroll, [rfReplaceAll]);

  //SALVATAGGIO SU STREAM VTemplate
  VTemplate.Free;
  VTemplate:=TStringStream.Create;
  strListTemp.SaveToStream(VTemplate);
  FreeAndNil(strListTemp);
  TStringStream(VTemplate).Seek(0, soFromBeginning);
end;

procedure TWR203FGestDetailFM.actNuovoExecute(Sender: TObject);
begin
  inherited;
  DataSetReadOnlyOriginale:=grdTabella.medpReadOnly;
  if DataSetReadOnlyOriginale then
    TOracleDataSet(grdTabella.medpDataSet).ReadOnly:=False;
  grdTabella.medpInserisci(True);
  TWR100FBase(Self.Owner).MessaggioStatus(INFORMA,'Inserimento');
end;

procedure TWR203FGestDetailFM.actModificaExecute(Sender: TObject);
begin
  //DC 30-10-2020 - controlla che la riga selezionata non sia quella vuota
  if grdTabella.medpClientDataset.FieldByName('DBG_ROWID').AsString = '*' then
    exit;

  if grdTabella.medpDataSet.RecordCount = 0 then
  begin
    if InserimentoAbilitato then
      actNuovoExecute(Sender);
    exit;
  end;
  inherited;
  DataSetReadOnlyOriginale:=grdTabella.medpReadOnly;
  if DataSetReadOnlyOriginale then
    TOracleDataSet(grdTabella.medpDataSet).ReadOnly:=False;
  grdTabella.medpModifica(True);
  TWR100FBase(Self.Owner).MessaggioStatus(INFORMA,'Modifica');
end;

procedure TWR203FGestDetailFM.actAnnullaExecute(Sender: TObject);
var
  RowID:String;
begin
   //...ritornare sul record corrente quando si è sulla pagina
  grdTabella.medpStato:=msBrowse;
  grdTabella.medpDataSet.Cancel;
  if grdTabella.medpCachedUpdates and (grdTabella.medpDataSet is TOracleDataSet) then
    TOracleDataSet(grdTabella.medpDataSet).CancelUpdates;
  if DataSetReadOnlyOriginale then
    TOracleDataSet(grdTabella.medpDataSet).ReadOnly:=True;

  //Caratto 19/01/2015 gestione in caso di clientdataset
  RowID:=grdTabella.medpGetRowID;
  grdTabella.medpCreaColonne;
  if grdTabella.medpDataSet is TOracleDataSet then
    grdTabella.medpDataSet.Locate('ROWID',RowID,[])
  else
    grdTabella.medpDataSet.RecNo:=StrToIntDef(RowID,0);
  grdTabella.medpAggiornaCDS;
end;

procedure TWR203FGestDetailFM.actConfermaExecute(Sender: TObject);
var
  r:Integer;
  RowID:String;
  bInsert: Boolean;
begin
  bInsert:=(grdTabella.medpDataSet.State = dsInsert);
  if bInsert then
    grdTabella.medpConferma(0)
  else
  begin
    if not grdTabella.medpEditMultiplo then
    begin
      //Agosto 22/08/2019 (vedi Caratto 28/06/2013) Nel caso di edit in line su pagina successiva alla 1, bisogna
      //tenere conto di passare il valore della riga relativo (all'interno della pagina) e non assoluto (dal primo record del dataset)
      r:=grdTabella.medpDataSet.RecNo;
      if grdTabella.medpGetCurrPag > 1 then
        r:=r - (grdTabella.medpGetCurrPag - 1) * grdTabella.medpRighePagina;
      //Agosto 22/08/2019 (vedi Caratto 21/02/2013) recno Parte da riga 1 mentre componenti griglia da riga da 0 se non c'è riga inserimento. (aggiunto - Ifthen per problema su WA034. in edit prendeva riga errata)
      grdTabella.medpConferma(r - IfThen(grdTabella.RigaInserimento,0,1));
    end
    else
    begin
      grdTabella.medpDataSet.Cancel;
      grdTabella.medpDataSet.First;
      for r:=IfThen(grdTabella.RigaInserimento,1,0) to High(grdTabella.medpCompGriglia) do
      begin
        grdTabella.medpDataSet.Edit;
        grdTabella.medpConferma(r);
        grdTabella.medpDataSet.Next;
      end;
      grdTabella.medpDataSet.First;
    end;
  end;
  try
    //Gestione cached updates
    if grdTabella.medpCachedUpdates then
    begin
      if Assigned(evBeforeApplyUpdates) then
        evBeforeApplyUpdates;
      grdTabella.medpDataSet.Cancel;
      grdTabella.medpDataSet.First;
      while not grdTabella.medpDataSet.Eof do
      begin
        if TOracleDataSet(grdTabella.medpDataSet).UpdateStatus in [usInserted,usModified] then
        begin
          RegistraLog.SettaProprieta(IfThen(TOracleDataSet(grdTabella.medpDataSet).UpdateStatus = usInserted,'I','M'),R180Query2NomeTabella(grdTabella.medpDataSet),Copy(Self.Name,1,5),grdTabella.medpDataSet,True);
          RegistraLog.RegistraOperazione;
        end;
        grdTabella.medpDataSet.Next;
      end;
      SessioneOracle.ApplyUpdates([TOracleDataSet(grdTabella.medpDataSet)],False);
    end;
    SessioneOracle.Commit;
    //Caratto 19/01/2015 medpDataSet potrebbe essere un clientDataset (es. wa172)
    if grdTabella.medpDataSet is TOracleDataSet then
      TOracleDataSet(grdTabella.medpDataSet).CancelUpdates
    else
    begin
      //In caso di ClientDataset uso l'evento evBeforeApplyUpdates per poter eseguire controlli
      //dopo il post. il ClientDataset non ha la proprietà cachecupdate pertanto prima eseguo
      //il post sui record e poi posso eseguire verifiche per esempio sui totali (es wa172)
      if Assigned(evBeforeApplyUpdates) then
        evBeforeApplyUpdates;
    end;
    RowID:=grdTabella.medpGetRowID;
    grdTabella.medpDataSet.Cancel;
    grdTabella.medpStato:=msBrowse;
    if DataSetReadOnlyOriginale then
      TOracleDataSet(grdTabella.medpDataSet).ReadOnly:=True;
    grdTabella.medpDataSet.First;
    grdTabella.medpCreaColonne;
    if not grdTabella.medpEditMultiplo then
    begin
      if grdTabella.medpDataSet is TOracleDataSet then
        grdTabella.medpDataSet.Locate('ROWID',RowID,[])
      else
        grdTabella.medpDataSet.RecNo:=StrToIntDef(Rowid,0);
    end;
    grdTabella.medpAggiornaCDS;
  except
    on E:Exception do
    begin
      //Gestione per OracleDataset in cachedUpdate. se CliendDataset non deve fare nulla
      if grdTabella.medpDataSet is TOracleDataSet then
      begin
        if SessioneOracle.Tag <= 1 then
          SessioneOracle.Rollback;
        grdTabella.medpDataSet.Cancel;
        TOracleDataSet(grdTabella.medpDataSet).CancelUpdates;
      end;
      //reimposto lo stato del dataset
      if bInsert then
        grdTabella.medpDataSet.Insert
      else
        grdTabella.medpDataSet.Edit;
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TWR203FGestDetailFM.actPrimoExecute(Sender: TObject);
// spostamento su primo record
begin
  grdTabella.medpDataSet.First;

  grdTabella.medpAggiornaCDS(False);
end;

procedure TWR203FGestDetailFM.actPrecedenteExecute(Sender: TObject);
// spostamento su record precedente
begin
  inherited;
  grdTabella.medpDataSet.Prior;
  grdTabella.medpAggiornaCDS(False);
end;

procedure TWR203FGestDetailFM.actSuccessivoExecute(Sender: TObject);
begin
  inherited;
   //per la gestione storicizzata serve obbligatoriamente il RowID
  grdTabella.medpDataSet.Next;

  grdTabella.medpAggiornaCDS(False);
end;

procedure TWR203FGestDetailFM.actUltimoExecute(Sender: TObject);
// spostamento su ultimo record
begin
  inherited;
  grdTabella.medpDataSet.Last;
  grdTabella.medpAggiornaCDS(False);
end;

procedure TWR203FGestDetailFM.actAggiornaExecute(Sender: TObject);
var ID:String;
begin
  if grdTabella.medpDataSet is TOracleDataSet then
  begin
    ID:=(grdTabella.medpDataSet as TOracleDataSet).RowID;
    grdTabella.medpDataSet.Refresh;
    if grdTabella.medpDataSet.FindField('ROWID') <> nil then // bugfix: se non c'è il field rowid non effettua la locate, che solleva eccezione
      grdTabella.medpDataSet.Locate('RowID',ID,[]);
    grdTabella.medpAggiornaCDS;
  end;
end;

procedure TWR203FGestDetailFM.actRicercaExecute(Sender: TObject);
begin
  with TWC003FRicercaDatiFM.Create(Self.Owner) do
  begin
    SearchGrid:=grdTabella;
    SearchDataset:=grdTabella.medpDataSet;
    Visualizza;
  end;
end;

procedure TWR203FGestDetailFM.AggiornaDettaglio;
begin
  if grdTabella.medpDataSet = nil then
    exit;

  if grdTabella.medpDataSet is TOracleDataSet then
    TOracleDataSet(grdTabella.medpDataSet).OnTranslateMessage:=DataSetTranslateMessage;

  grdTabella.medpCreaColonne;
  if grdTabella.medpComandiCustom then
    grdTabella.medpCaricaCDS;
end;

procedure TWR203FGestDetailFM.DataSetTranslateMessage(Sender: TOracleDataSet; ErrorCode: Integer; const ConstraintName: string; Action: Char; var Msg: string);
begin
  inherited;
  if ErrorCode = 1 then
    Msg:='Chiave già esistente';
end;

procedure TWR203FGestDetailFM.DataSourceStateChange(Sender: TObject);
var
  i:Integer;
  Browse:Boolean;
begin
  if DSMasterState = dsInsert then
    exit;

  Browse:=not (grdTabella.medpDataSet.State in [dsInsert,dsEdit]);

  grdTabella.medpBrowse:=Browse;
  if grdTabella.medpDataSet.State = dsInsert then
   grdTabella.medpClientDataSet.First;
  grdTabella.RowClick:=Browse;

  actRicerca.Enabled:=Browse;
  actPrimo.Enabled:=Browse;
  actPrecedente.Enabled:=Browse;
  actSuccessivo.Enabled:=Browse;
  actUltimo.Enabled:=Browse;
  actEstrai.Enabled:=Browse;
  actElimina.Enabled:=Browse and not(TWR100FBase(Self.Owner).SolaLettura);
  actNuovo.Enabled:=Browse and not(TWR100FBase(Self.Owner).SolaLettura);
  actModifica.Enabled:=Browse and not(TWR100FBase(Self.Owner).SolaLettura);

  actConferma.Enabled:=not Browse;
  actAnnulla.Enabled:=not Browse;

  actCopiaSu.Enabled:=Browse and not(TWR100FBase(Self.Owner).SolaLettura);
  actAggiorna.Enabled:=Browse;
  TWR100FBase(Self.Owner).AbilitaToolBar(TWR102FGestTabella(Self.Owner).grdNavigatorBar,Browse,TWR102FGestTabella(Self.Owner).actlstNavigatorBar);

  if TWR102FGestTabella(Self.Owner).grdC700 <> nil then
    TWR102FGestTabella(Self.Owner).grdC700.AbilitaToolbar(Browse);

  with TWR102FGestTabella(Self.Owner) do
  begin
    if InterfacciaWR102.GestioneStoricizzata then
    begin
      if not Browse then //se sono in modifica o inserimento disabilito tutta la toolbarstorico
        AggiornaToolBarStorico(False, False, False, False, False, False)
      else //reimposto le abilitazioni di toolbarstorico.
        selTabellaStateChange(WR302DM.selTabella);
    end;
  end;

  //Caratto 18/10/2013 se il frame di dettaglio è inserito nel tabcontrol
  //del padre a fianco di Browse e detail (gestione non standard in WA110)
  //non devo eseguire l'abilitazione/disabilitazione dello stesso
  if TWR102FGestTabella(Self.Owner).grdTabControl.Tabs[Self] = nil then
    TWR100FBase(Self.Owner).AbilitaToolBar(TWR102FGestTabella(Self.Owner).grdTabControl,Browse,nil);

  TWR100FBase(Self.Owner).AbilitaToolBar(TWR103FGestMasterDetail(Self.Owner).grdDetailTabControl,Browse,nil);
  if (WR302DM.selTabella.RecordCount = 0) then
    TWR100FBase(Self.Owner).AbilitaToolBar(grdDetailNavBar,False,nil)
  else
    TWR100FBase(Self.Owner).AggiornaToolBar(grdDetailNavBar,actlstDetailNavBar);

  if TWR103FGestMasterDetail(Self.Owner).DisabilitaFigliInModifica then
  begin
    for i:=0 to TWR103FGestMasterDetail(Self.Owner).DetailsCount - 1 do
      if (TWR103FGestMasterDetail(Self.Owner).DetailFM[i] is TWR203FGestDetailFM) and
         (TWR103FGestMasterDetail(Self.Owner).DetailFM[i] <> Self) then
      begin
        (TWR103FGestMasterDetail(Self.Owner).DetailFM[i] as TWR203FGestDetailFM).DSMasterState:=grdTabella.medpDataSet.State;
        TWR100FBase(Self.Owner).AbilitaToolBar((TWR103FGestMasterDetail(Self.Owner).DetailFM[i] as TWR203FGestDetailFM).grdDetailNavBar,Browse and (WR302DM.selTabella.RecordCount > 0),(TWR103FGestMasterDetail(Self.Owner).DetailFM[i] as TWR203FGestDetailFM).actlstDetailNavBar);
        (TWR103FGestMasterDetail(Self.Owner).DetailFM[i] as TWR203FGestDetailFM).grdTabella.medpBrowse:=Browse;
      end;
  end;

  if TWR103FGestMasterDetail(Self.Owner).WBrowseFM <> nil then
    if TWR103FGestMasterDetail(Self.Owner).WBrowseFM.grdTabella.medpDataSet.State = dsBrowse then
      TWR103FGestMasterDetail(Self.Owner).WBrowseFM.grdTabella.medpBrowse:=Browse;
end;

procedure TWR203FGestDetailFM.imgDetailNavBarClick(Sender: TObject);
begin
  // Massimo 21/01/2013
  //TWR100FBase(Self.Parent).MessaggioStatus(INFORMA,'');
  TWR100FBase(Self.Owner).MessaggioStatus(INFORMA,'');
  TAction(actlstDetailNavBar.Actions[TmeIWImageFile(Sender).Tag]).Execute;
end;

end.
