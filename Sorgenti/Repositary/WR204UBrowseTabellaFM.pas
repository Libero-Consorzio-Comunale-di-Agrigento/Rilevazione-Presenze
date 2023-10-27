unit WR204UBrowseTabellaFM;

interface

uses
  WR200UBaseFM,
  A000UInterfaccia, C190FunzioniGeneraliWeb,
  DB, DBClient, OracleData, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWDBGrids, medpIWDBGrid, IWVCLComponent, IWApplication,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, Classes, Controls, Forms, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  SysUtils, Variants, IWCompGrids, IWCompJQueryWidget, Vcl.Menus;

type
  TWR204FBrowseTabellaFM = class(TWR200FBaseFM)
    grdTabella: TmedpIWDBGrid;
    pmnGrdTabella: TPopupMenu;
    actScaricaInExcel: TMenuItem;
    actScaricaInCSV: TMenuItem;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure grdTabellaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure actScaricaInExcelClick(Sender: TObject);
    procedure actScaricaInCSVClick(Sender: TObject);
  protected
    function InserimentoAbilitato:Boolean; virtual;
  public
  end;

implementation

uses WR010UBase, WR100UBase, WR102UGestTabella, WR203UGestDetailFM, WR302UGestTabellaDM;

{$R *.dfm}

procedure TWR204FBrowseTabellaFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  actScaricaInExcel.Name:=C190CreaNomeComponente(actScaricaInExcel.Name,Self);
  pmnGrdTabella.Name:=C190CreaNomeComponente(pmnGrdTabella.Name,Self);
  grdTabella.AggiornaRecord:=TWR102FGestTabella(Self.Parent).AggiornaRecord;
  //Caratto 17/12/2012 Inibizione ordinamento sulle colonne se gestione storicizzata
  if (TWR102FGestTabella(Self.Parent).InterfacciaWR102.GestioneStoricizzata) and
     (not (Self is TWR203FGestDetailFM)) then //Caratto 14/07/2014 i frame WR203 non devono disabilitare perchè storicizzazione su WR204
    grdTabella.medpOrdinamentoColonne:=False;

  if not (Self is TWR203FGestDetailFM) then
  begin
    grdTabella.medpPaginazione:=True;
    // MONDOEDP - commessa MAN/08 SVILUPPO#161.ini
    // gestione paginazione personalizzabile su filtro funzioni
    //grdTabella.medpRighePagina:=StrToIntDef(Parametri.CampiRiferimento.C90_WebRighePag,-1);
    grdTabella.medpRighePagina:=TWR102FGestTabella(Self.Parent).GetRighePaginaTabella;
    // MONDOEDP - commessa MAN/08 SVILUPPO#161.fine
  end;
  ////grdTabella.PopolaGrid:=CaricaDati;
  if Self.ClassParent = TWR204FBrowseTabellaFM then
  begin
    grdTabella.RigaInserimento:=grdTabella.medpComandiInsert or InserimentoAbilitato;
    grdTabella.medpAttivaGrid(WR302DM.selTabella,False,grdTabella.medpComandiInsert );

    (*caratto 27/11/2012. nuova gestione medpgrid
    non usare InserimentoAbilitato per allowInsert altrimenti inserisci pulsante di nuovo nella grid (es 005 avrebbe pulsante in griglia)
    Impostare invece RigaInserimento altrimenti errore se insert quando la gird è vuota
    grdTabella.medpDataSet:=WR302DM.selTabella;
    grdTabella.DataSource:=WR302DM.cdsrTabella;

    grdTabella.medpCreaColonne;
    *)
  end;
end;

function TWR204FBrowseTabellaFM.InserimentoAbilitato:Boolean;
begin
  Result:=False;
  if (not TWR100FBase(Self.Parent).SolaLettura) and
     (not TWR102FGestTabella(TWR100FBase(Self.Parent)).InterfacciaWR102.DettaglioFM) and
     (TWR102FGestTabella(Self.Parent).actNuovo.Visible) then
    Result:=True;
end;

procedure TWR204FBrowseTabellaFM.actScaricaInCSVClick(Sender: TObject);
var NomeFile:String;
begin
  if not Assigned(Sender) then
    (Self.Owner as TWR010FBase).csvDownload:=grdTabella.ToCsv
  else
  begin
    if grdTabella.Caption <> '' then
      NomeFile:=grdTabella.Caption + '.xls'
    else
      NomeFile:=TWR102FGestTabella(Self.Parent).Title + '.xls';
    NomeFile:=NomeFile.Replace(' ','_').Replace('(','').Replace(')','').Replace('/','').Replace('\','');
    (Self.Owner as TWR010FBase).InviaFile(NomeFile,(Self.Owner as TWR010FBase).csvDownload);
  end;
end;

procedure TWR204FBrowseTabellaFM.actScaricaInExcelClick(Sender: TObject);
var NomeFile:String;
begin
  if not Assigned(Sender) then
    (Self.Owner as TWR010FBase).streamDownload:=grdTabella.ToXlsx
  else
  begin
    if grdTabella.Caption <> '' then
      NomeFile:=grdTabella.Caption + '.xlsx'
    else
      NomeFile:=TWR102FGestTabella(Self.Parent).Title + '.xlsx';
    NomeFile:=NomeFile.Replace(' ','_').Replace('(','').Replace(')','').Replace('/','').Replace('\','');
    (Self.Owner as TWR010FBase).InviaFile(NomeFile,(Self.Owner as TWR010FBase).streamDownload);
  end;
end;

procedure TWR204FBrowseTabellaFM.grdTabellaAfterCaricaCDS(Sender: TObject;DBG_ROWID: string);
begin
  inherited;
  //TWR102FGestTabella(Self.Parent).AggiornaRecord;
end;

procedure TWR204FBrowseTabellaFM.grdTabellaRenderCell(ACell: TIWGridCell;const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdTabella.medpNumColonna(AColumn);
  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdTabella.medpCompGriglia) + 1) and (grdTabella.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdTabella.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

end.
