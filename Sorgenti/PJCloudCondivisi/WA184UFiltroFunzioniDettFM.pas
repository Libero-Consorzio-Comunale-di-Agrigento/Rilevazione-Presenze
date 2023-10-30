unit WA184UFiltroFunzioniDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Math,
  Dialogs, WR205UDettTabellaFM, IWVCLComponent, StrUtils,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWDBExtCtrls, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWDBRadioGroup, IWCompListbox, meIWDBLookupComboBox,
  meIWDBComboBox, meIWDBLabel,
  meIWLabel, IWCompCheckbox, meIWDBCheckBox, A000UInterfaccia, Menus,
  meIWCheckBox, C180FunzioniGenerali,
  C190FunzioniGeneraliWeb, IWCompButton, meIWButton,
  IWDBGrids, medpIWDBGrid, DB, DBClient, StdCtrls, WC011UListboxFM,
  WC013UCheckListFM, IWCompMemo, meIWMemo, Oracle, OracleData,
  A000UCostanti, A000USessione, medpIWMessageDlg, meIWComboBox, IWCompExtCtrls,
  IWCompGrids, IWCompJQueryWidget, meIWImageFile, meIWEdit, L021Call, medpIWImageButton;

type
  TWA184FFiltroFunzioniDettFM = class(TWR205FDettTabellaFM)
    lblPermesso: TmeIWLabel;
    dedtPermesso: TmeIWDBEdit;
    lblAzienda: TmeIWLabel;
    dcmbAzienda: TmeIWDBLookupComboBox;
    lblLegenda: TmeIWLabel;
    grdFunzioni: TmedpIWDBGrid;
    dsrcI073: TDataSource;
    cdsI073: TClientDataSet;
    imgTuttiR: TmeIWImageFile;
    imgTuttiN: TmeIWImageFile;
    imgTuttiS: TmeIWImageFile;
    lblFiltroFunzioni: TmeIWLabel;
    cmbFiltroFunzioni: TmeIWComboBox;
    btnAggiornaFiltroFunzioni: TmedpIWImageButton;
    edtContenuto: TmeIWEdit;
    lblContenuto: TmeIWLabel;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdFunzioniRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure imgTuttiSClick(Sender: TObject);
    procedure imgTuttiNClick(Sender: TObject);
    procedure imgTuttiRClick(Sender: TObject);
    procedure cmbFiltroFunzioniAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnAggiornaFiltroFunzioniClick(Sender: TObject);
    procedure edtContenutoAsyncKeyDown(Sender: TObject; EventParams: TStringList);
  private
    procedure CaricagrdFunzioni;
    procedure CaricaCmbFiltroFunzioni;
    procedure FiltraElencoFunzioni;
  public
    procedure TrasformaComponenti(AbilitaEdit: Boolean);
  end;

implementation

uses WA184UFiltroFunzioniDM, WA184UFiltroFunzioni, WR100UBase;

{$R *.dfm}

procedure TWA184FFiltroFunzioniDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  dcmbAzienda.ListSource:=TWA184FFiltroFunzioniDM(TWA184FFiltroFunzioni(Self.Owner).WR302DM).D090;
  inherited;
  dcmbAzienda.DataSource:=TWA184FFiltroFunzioniDM(TWA184FFiltroFunzioni(Self.Owner).WR302DM).dsrI073;
  dedtPermesso.DataSource:=TWA184FFiltroFunzioniDM(TWA184FFiltroFunzioni(Self.Owner).WR302DM).dsrI073;

  grdFunzioni.medpPaginazione:=True;
  grdFunzioni.medpRighePagina:=500;
  grdFunzioni.medpBrowse:=False;
  grdFunzioni.medpDataSet:=TWA184FFiltroFunzioniDM(WR302DM).selI073;
  CaricaCmbFiltroFunzioni;
  CaricagrdFunzioni;
end;

procedure TWA184FFiltroFunzioniDettFM.btnAggiornaFiltroFunzioniClick(Sender: TObject);
begin
  inherited;
  TWA184FFiltroFunzioniDM(WR302DM).AggiornaI073;
end;

procedure TWA184FFiltroFunzioniDettFM.CaricaCmbFiltroFunzioni;
var i,lstidx:integer;
    Lst: TStringList;
begin
  Lst:=L021GruppiDisponibili(Parametri.Applicazione);
  lstidx:=cmbFiltroFunzioni.ItemIndex;
  cmbFiltroFunzioni.Items.Clear;
  cmbFiltroFunzioni.Items.Add('Tutti');
  for i:=0 to Lst.Count-1 do
    cmbFiltroFunzioni.Items.Add(Lst[i]);
  cmbFiltroFunzioni.ItemIndex:=max(0,lstidx);
  FreeAndNil(Lst);
end;

procedure TWA184FFiltroFunzioniDettFM.CaricagrdFunzioni;
begin
  grdFunzioni.medpBrowse:=True;
  grdFunzioni.medpCreaCDS;
  grdFunzioni.medpEliminaColonne;
  grdFunzioni.medpAggiungiColonna('GRUPPO','Gruppo','',nil);
  grdFunzioni.medpAggiungiColonna('DESCRIZIONE','Funzione','',nil);
  grdFunzioni.medpAggiungiColonna('INIBIZIONE','Abilitazione','DBG_ROWID',nil);
  grdFunzioni.medpAggiungiColonna('ACCESSO_BROWSE','Accesso Browse','DBG_ROWID',nil);
  grdFunzioni.medpAggiungiColonna('RIGHE_PAGINA','Righe pagina','DBG_ROWID',nil);

  grdFunzioni.medpInizializzaCompGriglia;

  grdFunzioni.medpCaricaCDS;
end;

procedure TWA184FFiltroFunzioniDettFM.cmbFiltroFunzioniAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  FiltraElencoFunzioni;
end;

procedure TWA184FFiltroFunzioniDettFM.edtContenutoAsyncKeyDown(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  FiltraElencoFunzioni;
end;

procedure TWA184FFiltroFunzioniDettFM.FiltraElencoFunzioni;
begin
  with TWA184FFiltroFunzioniDM(TWA184FFiltroFunzioni(Self.Owner).WR302DM) do
  begin
    Gruppo:=cmbFiltroFunzioni.Text;
    Descrizione:=edtContenuto.Text;

    selI073.Filtered:=False;
    selI073.Filtered:=True;
    CaricagrdFunzioni;
    grdFunzioni.Refresh;
  end;
end;

procedure TWA184FFiltroFunzioniDettFM.TrasformaComponenti(AbilitaEdit: Boolean);
var
  i:Integer;
begin
  if AbilitaEdit then
  begin
    grdFunzioni.medpBrowse:=False;

    for i:=0 to High(grdFunzioni.medpCompGriglia) do
    begin
      // inibizione
      grdFunzioni.medpPreparaComponenteGenerico('C',0,0,DBG_CMB,'1','','','');
      grdFunzioni.medpCreaComponenteGenerico(i,2,grdFunzioni.Componenti);
      with TmeIWComboBox(grdFunzioni.medpCompCella(i,2,0)) do
      begin
        Items.Clear;
        Items.Add('S');
        Items.Add('N');
        Items.Add('R');
        ItemIndex:=Items.IndexOf(grdFunzioni.medpValoreColonna(i,'INIBIZIONE'));
      end;

      // accesso browse
      grdFunzioni.medpPreparaComponenteGenerico('C',0,0,DBG_CMB,'1','','','');
      grdFunzioni.medpCreaComponenteGenerico(i,3,grdFunzioni.Componenti);
      with TmeIWComboBox(grdFunzioni.medpCompCella(i,3,0)) do
      begin
        Items.Clear;
        Items.Add('S');
        Items.Add('N');
        ItemIndex:=Items.IndexOf(grdFunzioni.medpValoreColonna(i,'ACCESSO_BROWSE'));
      end;

      // righe pagina
      grdFunzioni.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'4','','','');
      grdFunzioni.medpCreaComponenteGenerico(i,4,grdFunzioni.Componenti);
      with TmeIWEdit(grdFunzioni.medpCompCella(i,4,0)) do
      begin
        Css:='input_num_nnnnd_neg width4chr';
        Text:=grdFunzioni.medpValoreColonna(i,'RIGHE_PAGINA');
      end;
    end;
  end
  else
  begin
    grdFunzioni.medpBrowse:=True;

    for i := 0 to High(grdFunzioni.medpCompGriglia) do
    begin
    //  CARATTO 20/11/2012 Componente non creato come grid
//      C190PulisciIWGrid(TIWGrid(grdFunzioni.medpCompgriglia[i].CompColonne[2]));
      FreeAndNil(grdFunzioni.medpCompgriglia[i].CompColonne[2]);
      FreeAndNil(grdFunzioni.medpCompgriglia[i].CompColonne[3]);
      FreeAndNil(grdFunzioni.medpCompgriglia[i].CompColonne[4]);
    end;
  end;
end;

procedure TWA184FFiltroFunzioniDettFM.grdFunzioniRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
begin
  inherited;
  if not grdFunzioni.medpRenderCell(ACell,ARow,AColumn,True,True,False) then
    Exit;
  if (ARow > 0) and (ARow <= High(grdFunzioni.medpCompGriglia) + 1) and (grdFunzioni.medpCompGriglia[ARow - 1].CompColonne[AColumn] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdFunzioni.medpCompGriglia[ARow - 1].CompColonne[AColumn];
  end;
end;

procedure TWA184FFiltroFunzioniDettFM.imgTuttiNClick(Sender: TObject);
var
  i:Integer;
begin
  for i:=0 to High(grdFunzioni.medpCompGriglia) do
  begin
    TIWComboBox(grdFunzioni.medpCompCella(i,2,0)).ItemIndex:=TIWComboBox(grdFunzioni.medpCompCella(i,2,0)).Items.IndexOf('N');
  end;
end;

procedure TWA184FFiltroFunzioniDettFM.imgTuttiRClick(Sender: TObject);
var
  i:Integer;
begin
  for i:=0 to High(grdFunzioni.medpCompGriglia) do
  begin
    TIWComboBox(grdFunzioni.medpCompCella(i,2,0)).ItemIndex:=TIWComboBox(grdFunzioni.medpCompCella(i,2,0)).Items.IndexOf('R');
  end;
end;

procedure TWA184FFiltroFunzioniDettFM.imgTuttiSClick(Sender: TObject);
var
  i:Integer;
begin
  for i:=0 to High(grdFunzioni.medpCompGriglia) do
  begin
    TIWComboBox(grdFunzioni.medpCompCella(i,2,0)).ItemIndex:=TIWComboBox(grdFunzioni.medpCompCella(i,2,0)).Items.IndexOf('S');
  end;
end;

end.
