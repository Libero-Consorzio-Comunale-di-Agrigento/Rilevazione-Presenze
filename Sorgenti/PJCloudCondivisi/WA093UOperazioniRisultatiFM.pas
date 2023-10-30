unit WA093UOperazioniRisultatiFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWDBGrids, medpIWDBGrid,meIWGrid, DB, DBClient, A000UInterfaccia, OracleData,
  IWCompGrids, IWCompJQueryWidget;

type
  TWA093FOperazioniRisultatiFM = class(TWR200FBaseFM)
    grdAnagra: TmedpIWDBGrid;
    grdRisultati: TmedpIWDBGrid;
    grdDettaglio: TmedpIWDBGrid;
    cdsrAnagra: TDataSource;
    cdsAnagra: TClientDataSet;
    cdsrRisultati: TDataSource;
    cdsRisultati: TClientDataSet;
    cdsrDettaglio: TDataSource;
    cdsDettaglio: TClientDataSet;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure IWFrameRegionRender(Sender: TObject);
  private
    procedure DBGridColumnClick(ASender: TObject; const AValue: string);
  public
    procedure CreaGrid(Grid:TmedpIWDBGrid);
    procedure CaricaDati(Grid:TmedpIWDBGrid;DBG_ROWID:String = '');
    procedure AggiornaVisualizzazioneGrid;
  end;

implementation

{$R *.dfm}

uses WA093UOperazioni, WA093UOperazioniDM;

procedure TWA093FOperazioniRisultatiFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdAnagra.medpPaginazione:=True;
  grdAnagra.medpRighePagina:=10;
  //Massimo: Commentato perchè in effetti in questa pagina lo spazio non manca e magari il paramentro
  //può essere anche valorizzato a 10 perchè invece in altre maschere 'si è più allo stretto'.
  //medpRighePagina è valorizzato nel Render del Frame
  //grdAnagra.medpRighePagina:=StrToIntDef(Parametri.CampiRiferimento.C90_WebRighePag,-1);
  grdAnagra.medpDataSet:=TWA093FOperazioni(Self.Owner).grdC700.selAnagrafe;
  grdAnagra.DataSource:=cdsrAnagra;
  grdAnagra.Css:='grid grdIntera';

  grdRisultati.medpPaginazione:=True;
  //grdRisultati.medpRighePagina:=StrToIntDef(Parametri.CampiRiferimento.C90_WebRighePag,-1);
  grdRisultati.medpDataSet:=TWA093FOperazioniDM(TWA093FOperazioni(Self.Owner).WR300DM).Q000;
  grdRisultati.DataSource:=cdsrRisultati;
  //grdRisultati.Css:='grid grdMetaSinistra';

  grdDettaglio.medpPaginazione:=False;
  //grdDettaglio.medpRighePagina:=StrToIntDef(Parametri.CampiRiferimento.C90_WebRighePag,-1);
  grdDettaglio.medpDataSet:=TWA093FOperazioniDM(TWA093FOperazioni(Self.Owner).WR300DM).Q001;
  grdDettaglio.DataSource:=cdsrDettaglio;
  //grdDettaglio.Css:='grid grdMetaDestra';
end;

procedure TWA093FOperazioniRisultatiFM.IWFrameRegionRender(Sender: TObject);
var righePag: Integer;
begin
  inherited;
  if grdAnagra.Visible then
    righePag:=10
  else
    righePag:=25;
  grdRisultati.medpRighePagina:=righePag;
  if grdRisultati.medpClientDataSet <> nil then
    grdRisultati.medpAggiornaCDS(True);

  //grdDettaglio.medpRighePagina:=righePag;
  if grdDettaglio.medpClientDataSet <> nil then
    grdDettaglio.medpAggiornaCDS(True);
end;

procedure TWA093FOperazioniRisultatiFM.CreaGrid(Grid:TmedpIWDBGrid);
var
  i:Integer;
begin
  Grid.medpBrowse:=True;
  Grid.medpDataSet.Refresh;
  Grid.medpCreaCDS;
  //Impostazione delle colonne da visualizzare sulla DBGrid
  Grid.medpEliminaColonne;

  //***grdTabella.medpAggiungiColonna(WR302DM.selTabella.Fields[0].FieldName,WR302DM.selTabella.Fields[0].DisplayLabel,'DBG_ROWID',DBGridColumnClick,_OnTitleClick);
  //***for i:=1 to WR302DM.selTabella.FieldCount - 1 do
  for i:=0 to Grid.medpDataSet.FieldCount - 1 do
  begin
    Grid.medpAggiungiColonna(Grid.medpDataSet.Fields[i].FieldName,Grid.medpDataSet.Fields[i].DisplayLabel,'',nil,nil);
    Grid.medpColonna(Grid.medpDataSet.Fields[i].FieldName).Visible:=Grid.medpDataSet.Fields[i].Visible;
  end;
  Grid.medpAggiungiRowClick('DBG_ROWID',DBGridColumnClick); //***

  Grid.medpInizializzaCompGriglia;
  Grid.RigaInserimento:=False;

  CaricaDati(Grid);
end;

procedure TWA093FOperazioniRisultatiFM.grdRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(TmedpIWDBGrid(ACell.Grid).medpCompGriglia) + 1) and (TmedpIWDBGrid(ACell.Grid).medpCompGriglia[ARow - 1].CompColonne[AColumn] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=TmedpIWDBGrid(ACell.Grid).medpCompGriglia[ARow - 1].CompColonne[AColumn];
  end;
end;

procedure TWA093FOperazioniRisultatiFM.CaricaDati(Grid:TmedpIWDBGrid;DBG_ROWID:String = '');
begin
  Grid.medpCaricaCDS(DBG_ROWID);
end;

procedure TWA093FOperazioniRisultatiFM.DBGridColumnClick(ASender: TObject; const AValue: string);
var
  Grid:TmedpIWDBGrid;
begin
  //inherited;
  if (ASender is TIWDBGridColumn) then
    Grid:=TmedpIWDBGrid(TIWDBGridColumn(ASender).grid)
  else if (ASender is TmedpIWDBGrid) then
    Grid:=TmedpIWDBGrid(ASender)
  else
    Exit;

  Grid.medpClientDataSet.Locate('DBG_ROWID',AValue,[]);
  if AValue <> '*' then
  begin
    if (Grid.medpDataSet is TOracleDataSet) and (TOracleDataSet(Grid.medpDataSet).RowID <> '') then
    begin
      if (Grid.medpRowIDField <> '') and (Grid.medpDataset.FindField(Grid.medpRowIDField) <> nil) then
        Grid.medpDataSet.Locate(Grid.medpRowIDField,AValue,[])
      else
        Grid.medpDataSet.Locate('ROWID',AValue,[]);
    end
    else if AValue <> '' then
    begin
      if Grid.medpDataSet.RecNo <> StrToInt(AValue) then
        Grid.medpDataSet.RecNo:=StrToInt(AValue)
      else if @Grid.medpDataSet.AfterScroll <> nil then
        Grid.medpDataSet.AfterScroll(Grid.medpDataSet);
    end;
  end;
end;

procedure TWA093FOperazioniRisultatiFM.AggiornaVisualizzazioneGrid;
begin
  if grdDettaglio.Visible then
  begin
    JQuery.OnReady.Text:='$(''#WA093_risultati'').attr(''class'',''grdMetaSinistra''); ' +
                         '$(''#WA093_dettaglio'').attr(''class'',''grdMetaDestra'');';
  end
  else
  begin
    JQuery.OnReady.Text:='$(''#WA093_risultati'').attr(''class'',''grdIntera'');';
  end;
end;

end.
