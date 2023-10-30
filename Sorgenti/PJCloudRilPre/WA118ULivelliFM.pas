unit WA118ULivelliFM;

interface

uses
  A000UInterfaccia,
  A000UMessaggi,
  C180FunzioniGenerali,
  WA118UPubblicazioneDocumentiDM,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, Vcl.Menus, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  Data.DB, IWCompLabel, meIWLabel, meIWImageFile, OracleData,
  System.Math, medpIWMessageDlg;

type
  TWA118FLivelliFM = class(TWR203FGestDetailFM)
    grdCampi: TmedpIWDBGrid;
    lblCampi: TmeIWLabel;
    grdCampiNavBar: TmeIWGrid;
    actlstCampiNavBar: TActionList;
    actEstraiCampo: TAction;
    actAggiornaCampo: TAction;
    actRicercaCampo: TAction;
    actPrimoCampo: TAction;
    actPrecedenteCampo: TAction;
    actSuccessivoCampo: TAction;
    actUltimoCampo: TAction;
    actCopiaSuCampo: TAction;
    actNuovoCampo: TAction;
    actModificaCampo: TAction;
    actEliminaCampo: TAction;
    actAnnullaCampo: TAction;
    actConfermaCampo: TAction;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure actRicercaExecute(Sender: TObject);
    procedure actNuovoCampoExecute(Sender: TObject);
    procedure actModificaCampoExecute(Sender: TObject);
    procedure actEliminaCampoExecute(Sender: TObject);
    procedure actEstraiCampoExecute(Sender: TObject);
    procedure actAggiornaCampoExecute(Sender: TObject);
    procedure actPrimoCampoExecute(Sender: TObject);
    procedure actPrecedenteCampoExecute(Sender: TObject);
    procedure actSuccessivoCampoExecute(Sender: TObject);
    procedure actUltimoCampoExecute(Sender: TObject);
    procedure actAnnullaCampoExecute(Sender: TObject);
    procedure actConfermaCampoExecute(Sender: TObject);
    procedure actCopiaSuCampoExecute(Sender: TObject);
  private
    FWR302DM: TWA118FPubblicazioneDocumentiDM;
    function InserimentoAbilitatoCampo: Boolean; inline;
    procedure ResultDeleteCampo(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure DataSourceCampiStateChange(Sender: TObject);
  public
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
    procedure AggiornaDettaglio; override;
    procedure OnI201AfterScroll;
    procedure imgCampiNavBarClick(Sender: TObject);
  end;

implementation

uses
  WA118UPubblicazioneDocumenti,
  WC003URicercaDatiFM, WR100UBase, WC004UEstrazioneDatiFM, WR102UGestTabella,
  WR103UGestMasterDetail;

{$R *.dfm}

{ TWA118FLivelliFM }

function TWA118FLivelliFM.InserimentoAbilitatoCampo: Boolean;
begin
  Result:=(not TWR100FBase(Self.Owner).SolaLettura) and
          (actNuovoCampo.Visible);
end;

procedure TWA118FLivelliFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  // edit puntuale
  grdTabella.medpEditMultiplo:=False;
  FWR302DM:=TWA118FPubblicazioneDocumentiDM(TWA118FPubblicazioneDocumenti(Self.Owner).WR302DM);
  TWA118FPubblicazioneDocumenti(Self.Owner).CreaNavigatorBar(actlstCampiNavBar,grdCampiNavBar,imgCampiNavBarClick);
end;

procedure TWA118FLivelliFM.imgCampiNavBarClick(Sender: TObject);
begin
  TWR100FBase(Self.Owner).MessaggioStatus(INFORMA,'');
  TAction(actlstCampiNavBar.Actions[TmeIWImageFile(Sender).Tag]).Execute;
end;

procedure TWA118FLivelliFM.actAggiornaCampoExecute(Sender: TObject);
var
  ID: String;
begin
  ID:=(grdCampi.medpDataSet as TOracleDataSet).RowID;
  grdCampi.medpDataSet.Refresh;
  grdCampi.medpDataSet.Locate('RowID',ID,[]);
  grdCampi.medpAggiornaCDS;
end;

procedure TWA118FLivelliFM.actAnnullaCampoExecute(Sender: TObject);
var
  RowID: String;
begin
  grdCampi.medpStato:=msBrowse;
  grdCampi.medpDataSet.Cancel;
  RowID:=grdCampi.medpGetRowID;
  grdCampi.medpCreaColonne;
  grdCampi.medpDataSet.Locate('ROWID',RowID,[]);
  grdCampi.medpAggiornaCDS;
end;

procedure TWA118FLivelliFM.actConfermaCampoExecute(Sender: TObject);
var
  r:Integer;
  RowID:String;
  bInsert: Boolean;
begin
  bInsert:=(grdCampi.medpDataSet.State = dsInsert);
  if bInsert then
    grdCampi.medpConferma(0)
  else
  begin
    if not grdCampi.medpEditMultiplo then
      grdCampi.medpConferma(grdCampi.medpDataSet.RecNo - IfThen(grdCampi.RigaInserimento,0,1))
    else
    begin
      grdCampi.medpDataSet.Cancel;
      grdCampi.medpDataSet.First;
      for r:=IfThen(grdCampi.RigaInserimento,1,0) to High(grdCampi.medpCompGriglia) do
      begin
        grdCampi.medpDataSet.Edit;
        grdCampi.medpConferma(r);
        grdCampi.medpDataSet.Next;
      end;
      grdCampi.medpDataSet.First;
    end;
  end;

  try
    SessioneOracle.Commit;
    grdCampi.medpDataSet.Cancel;
    grdCampi.medpStato:=msBrowse;
    grdCampi.medpDataSet.First;
    RowID:=grdCampi.medpGetRowID;
    grdCampi.medpCreaColonne;
    grdCampi.medpDataSet.Locate('ROWID',RowID,[]);
    grdCampi.medpAggiornaCDS;
  except
    on E:Exception do
    begin
      if SessioneOracle.Tag <= 1 then
        SessioneOracle.Rollback;
      grdCampi.medpDataSet.Cancel;
      //reimposto lo stato del dataset
      if bInsert then
        grdCampi.medpDataSet.Insert
      else
        grdCampi.medpDataSet.Edit;
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TWA118FLivelliFM.actCopiaSuCampoExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TWA118FLivelliFM.actEliminaCampoExecute(Sender: TObject);
begin
  if grdCampi.medpDataSet.RecordCount = 0 then
   exit;

  MsgBox.WebMessageDlg(A000MSG_DLG_CANCELLAZIONE,mtConfirmation,[mbYes,mbNo],ResultDeleteCampo,'');
end;

procedure TWA118FLivelliFM.actEstraiCampoExecute(Sender: TObject);
begin
  inherited;
  with TWC004FEstrazioneDatiFM.Create(Self.Owner) do
  begin
    InizializzaQuery(Self);
    Visualizza;
  end;
end;

procedure TWA118FLivelliFM.actModificaCampoExecute(Sender: TObject);
begin
  if grdCampi.medpDataSet.RecordCount = 0 then
  begin
    if InserimentoAbilitatoCampo then  //***
      actNuovoCampoExecute(Sender);
    exit;
  end;
  inherited;

  grdCampi.medpModifica(True);
  TWR100FBase(Self.Owner).MessaggioStatus(INFORMA,'Modifica campo');
end;

procedure TWA118FLivelliFM.actNuovoCampoExecute(Sender: TObject);
begin
  inherited;
  grdCampi.medpInserisci(True);
  TWR100FBase(Self.Owner).MessaggioStatus(INFORMA,'Inserimento campo');
end;

procedure TWA118FLivelliFM.actPrecedenteCampoExecute(Sender: TObject);
// spostamento su record precedente
begin
  inherited;
  grdCampi.medpDataSet.Prior;
  grdCampi.medpAggiornaCDS(False);
end;

procedure TWA118FLivelliFM.actPrimoCampoExecute(Sender: TObject);
// spostamento su primo record
begin
  grdCampi.medpDataSet.First;
  grdCampi.medpAggiornaCDS(False);
end;

procedure TWA118FLivelliFM.actRicercaExecute(Sender: TObject);
begin
  with TWC003FRicercaDatiFM.Create(Self.Owner) do
  begin
    SearchGrid:=grdCampi;
    SearchDataset:=TOracleDataSet(grdCampi.medpDataSet);
    Visualizza;
  end;
end;

procedure TWA118FLivelliFM.actSuccessivoCampoExecute(Sender: TObject);
begin
  inherited;
  grdCampi.medpDataSet.Next;
  grdCampi.medpAggiornaCDS(False);
end;

procedure TWA118FLivelliFM.actUltimoCampoExecute(Sender: TObject);
// spostamento su ultimo record
begin
  inherited;
  grdCampi.medpDataSet.Last;
  grdCampi.medpAggiornaCDS(False);
end;

procedure TWA118FLivelliFM.CaricaDettaglio(DataSet: TDataSet; DataSource: TDataSource);
begin
  inherited;
  //grdTabella.medpPreparaComponenteGenerico('WR102','CODICE',0,DBG_IMG,'','CAMBIADATO','','','S');
end;

procedure TWA118FLivelliFM.AggiornaDettaglio;
begin
  inherited;
  grdCampi.medpCaricaCDS;
end;

procedure TWA118FLivelliFM.DataSourceCampiStateChange(Sender: TObject);
var
  LBrowse: Boolean;
begin
  //*** verificare
  if TWR102FGestTabella(Self.Owner).WR302DM.selTabella.State = dsInsert then
    Exit;

  LBrowse:=not (grdCampi.medpDataSet.State in [dsInsert,dsEdit]);

  grdCampi.medpBrowse:=LBrowse;
  if grdCampi.medpDataSet.State = dsInsert then
   grdCampi.medpClientDataSet.First;
  grdCampi.RowClick:=LBrowse;

  actRicercaCampo.Enabled:=LBrowse;
  actPrimoCampo.Enabled:=LBrowse;
  actPrecedenteCampo.Enabled:=LBrowse;
  actSuccessivoCampo.Enabled:=LBrowse;
  actUltimoCampo.Enabled:=LBrowse;
  actEstraiCampo.Enabled:=LBrowse;
  actEliminaCampo.Enabled:=LBrowse and not(TWR100FBase(Self.Owner).SolaLettura);
  actNuovoCampo.Enabled:=LBrowse and not(TWR100FBase(Self.Owner).SolaLettura);
  actModificaCampo.Enabled:=LBrowse and not(TWR100FBase(Self.Owner).SolaLettura);

  actConfermaCampo.Enabled:=not LBrowse;
  actAnnullaCampo.Enabled:=not LBrowse;

  actCopiaSuCampo.Enabled:=LBrowse and not(TWR100FBase(Self.Owner).SolaLettura);
  actAggiornaCampo.Enabled:=LBrowse;
  TWR100FBase(Self.Owner).AbilitaToolBar(TWR102FGestTabella(Self.Owner).grdNavigatorBar,LBrowse,TWR102FGestTabella(Self.Owner).actlstNavigatorBar);
  if TWR102FGestTabella(Self.Owner).grdC700 <> nil then
    TWR102FGestTabella(Self.Owner).grdC700.AbilitaToolbar(LBrowse);

  with TWR102FGestTabella(Self.Owner) do
  begin
    if InterfacciaWR102.GestioneStoricizzata then
    begin
      if not LBrowse then //se sono in modifica o inserimento disabilito tutta la toolbarstorico
        AggiornaToolBarStorico(False, False, False, False, False, False)
      else //reimposto le abilitazioni di toolbarstorico.
        selTabellaStateChange(WR302DM.selTabella);
    end;
  end;

  //Caratto 18/10/2013 se il frame di dettaglio è inserito nel tabcontrol
  //del padre a fianco di LBrowse e detail (gestione non standard in WA110)
  //non devo eseguire l'abilitazione/disabilitazione dello stesso
  if TWR102FGestTabella(Self.Owner).grdTabControl.Tabs[Self]  = nil then
    TWR100FBase(Self.Owner).AbilitaToolBar(TWR102FGestTabella(Self.Owner).grdTabControl,LBrowse,nil);

  TWR100FBase(Self.Owner).AbilitaToolBar(TWR103FGestMasterDetail(Self.Owner).grdDetailTabControl,LBrowse,nil);
  {
  if (WR302DM.selTabella.RecordCount = 0) then
    TWR100FBase(Self.Owner).AbilitaToolBar(grdDetailNavBar,False,nil)
  else
    TWR100FBase(Self.Owner).AggiornaToolBar(grdDetailNavBar,actlstDetailNavBar);

  if TWR103FGestMasterDetail(Self.Owner).WBrowseFM <> nil then
    if TWR103FGestMasterDetail(Self.Owner).WBrowseFM.grdTabella.medpDataSet.State = dsBrowse then
      TWR103FGestMasterDetail(Self.Owner).WBrowseFM.grdTabella.medpBrowse:=LBrowse;
  }

  if (WR302DM.selTabella.RecordCount = 0) then
    TWR100FBase(Self.Owner).AbilitaToolBar(grdCampiNavBar,False,nil)
  else
    TWR100FBase(Self.Owner).AggiornaToolBar(grdCampiNavBar,actlstCampiNavBar);
end;

procedure TWA118FLivelliFM.OnI201AfterScroll;
var
  LLiv: Integer;
begin
  LLiv:=FWR302DM.selI201.FieldByName('LIVELLO').AsInteger;

  // intestazione groupbox
  lblCampi.Caption:=Format('Definizione campi - livello %d',[LLiv]);

  // prepara grid
  grdCampi.RigaInserimento:=InserimentoAbilitatoCampo;
  grdCampi.medpAttivaGrid(FWR302DM.selI202,False,False);
  grdCampi.medpDataSource:=FWR302DM.dsrI202;
  grdCampi.medpDataSource.OnStateChange:=DataSourceCampiStateChange;
  DataSourceCampiStateChange(FWR302DM.selI202);
  //grdTabella.medpPreparaComponentiDefault;

  // nasconde il campo lunghezza se è indicato un separatore
  //grdCampi.Columns.Items[2].Visible:=selI201.FieldByName('SEPARATORE').IsNull;

  // indicazione per i test
  //***lblTest.Caption:=Format('Test impostazioni livello %d',[LLiv]);
end;

procedure TWA118FLivelliFM.ResultDeleteCampo(Sender: TObject; R: TmeIWModalResult; KI: String);
var
  RowID:String;
begin
  if R = mrYes then
  begin
    grdCampi.medpCancella;
    SessioneOracle.Commit;

    grdCampi.medpDataSet.Cancel;
    grdCampi.medpDataSet.First;
    RowID:=TOracleDataSet(grdCampi.medpDataSet).RowId;
    grdCampi.medpCreaColonne;
    grdCampi.medpDataSet.Locate('ROWID',RowID,[]);
    grdCampi.medpAggiornaCDS;
  end;
end;

end.
