unit WA094USkLimitiStraordBrowseFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR204UBrowseTabellaFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, meIWLabel,
  IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, WA094USkLimitiStraordDM,
  C190FunzioniGeneraliWeb, meIWComboBox, A000UCostanti, WR100UBase, meIWEdit,
  IWCompListbox, A000UInterfaccia, A000UMessaggi, medpIWMessageDlg, Vcl.Menus,
  OracleData, C180FunzioniGenerali;

type
  TWA094FSkLimitiStraordBrowseFM = class(TWR204FBrowseTabellaFM)
    grdLiqIndAnn: TmedpIWDBGrid;
    grdT830: TmedpIWDBGrid;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdLiqIndAnnRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    function grdLiqIndAnnBeforeInserisci(Sender: TObject): Boolean;
    // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.ini
    function grdT830BeforeInserisci(Sender: TObject): Boolean;
    procedure grdT830DataSet2Componenti(Row: Integer);
    procedure grdT830Componenti2DataSet(Row: Integer);
    // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.fine
  private
    LastDataGriglia,
    CssGriglia: String;
    LastRow: Integer;
    // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.ini
    IWEdtData: TmeIWEdit;
    IWCompOreSupplAnno: TIWCustomControl;
    IWCompOreStraordAnno: TIWCustomControl;
    procedure edtDataAsyncChange(Sender: TObject; EventParams: TStringList);
    // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.fine
  end;

implementation

uses WA094USkLimitiStraord;
{$R *.dfm}

procedure TWA094FSkLimitiStraordBrowseFM.IWFrameRegionCreate(Sender: TObject);
var AttivaGrid: Boolean;
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('ANNO'),0,DBG_EDT,'input_num_nnnn','','','','S');
  if grdTabella.medpColonna('DAL').Visible then
  begin
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DAL'),0,DBG_EDT,'input_num_nn','','','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('AL'),0,DBG_EDT,'input_num_nn','','','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CAUSALE'),0,DBG_CMB,'','','','','S');
  end;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('MESE'),0,DBG_EDT,'input_num_nn','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('LIQUIDABILE'),0,DBG_CMB,'','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('ORE_TEORICHE'),0,DBG_EDT,'','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('ORE'),0,DBG_EDT,'','','','','S');

  //Griglia Liquid Ind Ann
  grdLiqIndAnn.medpRighePagina:=9999;
  grdLiqIndAnn.medpAttivaGrid((WR302DM as TWA094FSkLimitiStraordDM).A094FSkLimitiStraordMW.selT825,(Self.Parent as TWA094FSkLimitiStraord).AttivaGridIndAnn,(Self.Parent as TWA094FSkLimitiStraord).AttivaGridIndAnn,(Self.Parent as TWA094FSkLimitiStraord).AttivaGridIndAnn);
  grdLiqIndAnn.medpPreparaComponentiDefault;
  grdLiqIndAnn.medpPreparaComponenteGenerico('WR102',grdLiqIndAnn.medpIndexColonna('ANNO'),0,DBG_EDT,'input_num_nnnn','','','','S');

  // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.ini
  grdT830.Visible:=(WR302DM as TWA094FSkLimitiStraordDM).A094FSkLimitiStraordMW.EsisteT203;
  if grdT830.Visible then
  begin
    grdT830.medpRighePagina:=9999;
    grdT830.medpAttivaGrid((WR302DM as TWA094FSkLimitiStraordDM).A094FSkLimitiStraordMW.selT830,Parametri.A094_Anno = 'S',Parametri.A094_Anno = 'S',Parametri.A094_Anno = 'S');
    grdT830.medpPreparaComponentiDefault;
    grdT830.medpPreparaComponenteGenerico('WR102',grdT830.medpIndexColonna('DATA'),0,DBG_EDT,'input_data_dmy','','','','');
  end;

  IWEdtData:=nil;
  IWCompOreSupplAnno:=nil;
  IWCompOreStraordAnno:=nil;
  // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.fine
end;

function TWA094FSkLimitiStraordBrowseFM.grdLiqIndAnnBeforeInserisci(Sender: TObject): Boolean;
begin
  inherited;
  //consente inserimento solo se esite una selezione

  Result:=(Self.Parent as TWA094FSkLimitiStraord).VerificaSelezioneC700;
  if not Result then
    MsgBox.WebMessageDlg(A000MSG_ERR_NO_DIP_INS,mtError,[mbOk],nil,'');
end;

procedure TWA094FSkLimitiStraordBrowseFM.grdLiqIndAnnRenderCell(
  ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=TmedpIWDBGrid(ACell.Grid).medpNumColonna(AColumn);
  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(TmedpIWDBGrid(ACell.Grid).medpCompGriglia) + 1) and (TmedpIWDBGrid(ACell.Grid).medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=TmedpIWDBGrid(ACell.Grid).medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

// AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.ini
function TWA094FSkLimitiStraordBrowseFM.grdT830BeforeInserisci(Sender: TObject): Boolean;
begin
  inherited;
  Result:=(Self.Parent as TWA094FSkLimitiStraord).VerificaSelezioneC700;
  if not Result then
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_ERR_NO_DIP_INS),ERRORE);
end;

procedure TWA094FSkLimitiStraordBrowseFM.grdT830DataSet2Componenti(Row: Integer);
begin
  // input data
  IWEdtData:=(grdT830.medpCompCella(Row,'DATA',0) as TmeIWEdit);
  //IWEdt.Tag:=Row;
  //IWEdt.Text:=grdRelazioniCampi.medpValoreColonna(Row,'DATA');
  IWEdtData.OnAsyncChange:=edtDataAsyncChange;

  // ore calcolate
  IWCompOreSupplAnno:=(grdT830.medpCompCella(Row,'ORE_SUPPL_ANNO',0) as TIWCustomControl);
  IWCompOreStraordAnno:=(grdT830.medpCompCella(Row,'ORE_STRAORD_ANNO',0) as TIWCustomControl);
end;

procedure TWA094FSkLimitiStraordBrowseFM.grdT830Componenti2DataSet(Row: Integer);
begin
  IWEdtData:=nil;
  IWCompOreSupplAnno:=nil;
  IWCompOreStraordAnno:=nil;
end;

procedure TWA094FSkLimitiStraordBrowseFM.edtDataAsyncChange(Sender: TObject; EventParams: TStringList);
var
  D: TDateTime;
  DS: TOracleDataSet;
  OreSupplAnno: String;
  OreStraordAnno: String;
begin
  if TryStrToDate((Sender as TmeIWEdit).Text,D) then
  begin
    DS:=(WR302DM as TWA094FSkLimitiStraordDM).A094FSkLimitiStraordMW.selT830;

    // imposta la data e fa scattare l'evento oncalcfields per calcolare le ore
    DS.FieldByName('DATA').AsDateTime:=D;

    // campi calcolati
    OreSupplAnno:=DS.FieldByName('ORE_SUPPL_ANNO').AsString;
    OreStraordAnno:=DS.FieldByName('ORE_STRAORD_ANNO').AsString;

    // ore supplementari
    if Assigned(IWCompOreSupplAnno) then
    begin
      if IWCompOreSupplAnno is TmeIWLabel then
        TmeIWLabel(IWCompOreSupplAnno).Text:=OreSupplAnno
      else if IWCompOreSupplAnno is TmeIWEdit then
        TmeIWEdit(IWCompOreSupplAnno).Text:=OreSupplAnno;
    end;

    // ore straord
    if Assigned(IWCompOreStraordAnno) then
    begin
      if IWCompOreStraordAnno is TmeIWLabel then
        TmeIWLabel(IWCompOreStraordAnno).Text:=OreStraordAnno
      else if IWCompOreSupplAnno is TmeIWEdit then
        TmeIWEdit(IWCompOreStraordAnno).Text:=OreStraordAnno;
    end;
  end;
end;
// AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.ini

procedure TWA094FSkLimitiStraordBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
var
  combo: TmeIWComboBox;
begin
  inherited;
  //LIQUIDABILE
  combo:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('LIQUIDABILE'),0) as TmeIWComboBox);
  combo.Items.Clear;
  combo.Items.Add('S');
  combo.Items.Add('N');
  if grdTabella.medpValoreColonna(Row, 'LIQUIDABILE') = 'S' then
    combo.ItemIndex:=0
  else
    combo.ItemIndex:=1;

  //CAUSALE
  if grdTabella.medpColonna('CAUSALE').Visible then
  begin
    combo:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CAUSALE'),0) as TmeIWComboBox);
    combo.Items.Clear;
    combo.Items.Add('');
    combo.ItemIndex:=0;
    combo.Items.Add(A000LimiteMensileLiquidabile);
    if A000LimiteMensileLiquidabile = grdTabella.medpValoreColonna(Row, 'CAUSALE') then
      combo.ItemIndex:=combo.Items.Count - 1;

    combo.Items.Add(A000LimiteMensileResiduabile);
    if A000LimiteMensileResiduabile = grdTabella.medpValoreColonna(Row, 'CAUSALE') then
      combo.ItemIndex:=combo.Items.Count - 1;

    with (WR302DM as TWA094FSkLimitiStraordDM).A094FSkLimitiStraordMW.selT275 do
    begin
      Open;
      while not Eof do
      begin
        combo.Items.Add(FieldByName('CODICE').AsString);
        if FieldByName('CODICE').AsString = grdTabella.medpValoreColonna(Row, 'CAUSALE') then
          combo.ItemIndex:=combo.Items.Count - 1;
        Next;
      end;
      Close;
    end;
  end;
end;

procedure TWA094FSkLimitiStraordBrowseFM.grdTabellaRenderCell(
  ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  DataCorrente: String;
begin
  inherited;
  if (ARow = 0) and (AColumn = 0) then
  begin
    LastDataGriglia:='';
    cssGriglia:='';
    LastRow:=-1;
  end;
  if ARow <> LastRow then
  begin
    LastRow:=ARow;
    DataCorrente:=grdTabella.DataSource.DataSet.FieldByName('ANNO').AsString + grdTabella.DataSource.DataSet.FieldByName('MESE').AsString;

    if DataCorrente <> LastDataGriglia then  //sul cambio data cambio colore cella
      if cssGriglia = 'riga_bianca' then
        cssGriglia:='riga_colorata'
      else
        cssGriglia:='riga_bianca';
    LastDataGriglia:=DataCorrente;
  end;

  ACell.Css:=StringReplace(ACell.Css,'riga_bianca',cssGriglia,[rfReplaceAll]);
  ACell.Css:=StringReplace(ACell.Css,'riga_colorata',cssGriglia,[rfReplaceAll]);
end;

end.
