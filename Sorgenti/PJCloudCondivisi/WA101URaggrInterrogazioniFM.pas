unit WA101URaggrInterrogazioniFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, Vcl.Menus, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  DB, C190FunzioniGeneraliWeb, meIWComboBox, A000Usessione;

type
  TWA101FRaggrInterrogazioniFM = class(TWR203FGestDetailFM)
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
  end;

implementation

uses WA101URaggrInterrogazioniDM;

{$R *.dfm}

procedure TWA101FRaggrInterrogazioniFM.CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource);
begin
  inherited;
  grdTabella.medpEditMultiplo:=False;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('COD_QUERY'),0,DBG_CMB,'40','','null','','S');
end;

procedure TWA101FRaggrInterrogazioniFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_QUERY'),0) as TmeIWComboBox).NoSelectionText:=' ';
  (WR302DM as TWA101FRaggrInterrogazioniDM).A101MW.selT002.First;
  while not (WR302DM as TWA101FRaggrInterrogazioniDM).A101MW.selT002.Eof do
  begin
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_QUERY'),0) as TmeIWComboBox).Items.Add((WR302DM as TWA101FRaggrInterrogazioniDM).A101MW.selT002.FieldByName('NOME').AsString);
    (WR302DM as TWA101FRaggrInterrogazioniDM).A101MW.selT002.Next;
  end;
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_QUERY'),0) as TmeIWComboBox).ItemIndex:=
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_QUERY'),0) as TmeIWComboBox).Items.IndexOf(
  grdTabella.medpValoreColonna(Row,'COD_QUERY'));
end;

procedure TWA101FRaggrInterrogazioniFM.grdTabellaRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
var
  CssTemp:string;
begin
  inherited;
  if ARow <= 1 then
    Exit;
  if not A000FiltroDizionario('INTERROGAZIONI DI SERVIZIO',grdTabella.medpValoreColonna(ARow - 1,'COD_QUERY')) then
  begin
    //intestazione
    // rimuove i css specifici della riga
    CssTemp:=StringReplace(Trim(ACell.Css),'riga_intestazione','',[rfReplaceAll]);
    CssTemp:=StringReplace(CssTemp,'riga_selezionata','',[rfReplaceAll]);
    CssTemp:=StringReplace(CssTemp,'riga_bianca','',[rfReplaceAll]);
    CssTemp:=StringReplace(CssTemp,'riga_colorata','',[rfReplaceAll]);
    if CssTemp = '' then
      CssTemp:=''
    else
      CssTemp:=CssTemp + ' ';
    CssTemp:=CssTemp + 'bg_grigio';
    ACell.Css:=Trim(CssTemp);
  end;
end;

end.
