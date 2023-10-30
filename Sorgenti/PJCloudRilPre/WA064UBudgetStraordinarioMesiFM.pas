unit WA064UBudgetStraordinarioMesiFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions, WR100UBase,
  Vcl.ActnList, Vcl.Menus, IWCompJQueryWidget, IWVCLComponent, DB, meIWEdit,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, StrUtils,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  C190FunzioniGeneraliWeb;

type
  TWA064FBudgetStraordinarioMesiFM = class(TWR203FGestDetailFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
  private
    { Private declarations }
    Row,Col:Integer;
    procedure edtOreAsyncExit(Sender: TObject; EventParams: TStringList);
    procedure edtImportoAsyncExit(Sender: TObject; EventParams: TStringList);
  public
    { Public declarations }
    procedure AggiornaDettaglio; override;
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
  end;

implementation

uses WA064UBudgetStraordinario, WA064UBudgetStraordinarioDM;

{$R *.dfm}

procedure TWA064FBudgetStraordinarioMesiFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  //Forzo la paginazione
  grdTabella.medpPaginazione:=False;
  grdTabella.medpRighePagina:=12;//massimo mesi dell'anno
end;

procedure TWA064FBudgetStraordinarioMesiFM.AggiornaDettaglio;
var Abilita:Boolean;
begin
  inherited;
  //Abilito le action del dettaglio solo se i mesi sono previsti
  Abilita:=(not (Self.Owner as TWA064FBudgetStraordinario).SolaLettura) and ((WR302DM as TWA064FBudgetStraordinarioDM).selTabella.RecordCount > 0);
  actCopiaSu.Enabled:=False;
  actNuovo.Enabled:=False;
  actModifica.Enabled:=Abilita;
  actElimina.Enabled:=False;
  (Self.Owner as TWR100FBase).AggiornaToolBar(grdDetailNavBar,actlstDetailNavBar);
end;

procedure TWA064FBudgetStraordinarioMesiFM.CaricaDettaglio(DataSet: TDataSet; DataSource: TDataSource);
begin
  inherited;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('ORE'),0,DBG_EDT,'input_hour_hhhhmm','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('IMPORTO'),0,DBG_EDT,'input_num_generic','','','','S');
end;

procedure TWA064FBudgetStraordinarioMesiFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;
  TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ORE'),0)).OnAsyncExit:=edtOreAsyncExit;
  TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('IMPORTO'),0)).OnAsyncExit:=edtImportoAsyncExit;
end;

procedure TWA064FBudgetStraordinarioMesiFM.grdTabellaRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  inherited;
  if (AColumn = grdTabella.medpIndexColonna('CODGRUPPO'))
  or (AColumn = grdTabella.medpIndexColonna('TIPO'))
  or (AColumn = grdTabella.medpIndexColonna('DECORRENZA')) then
    ACell.Css:='invisibile';

  if (AColumn = grdTabella.medpIndexColonna('ORE_RESIDUO_AUTO'))
  or (AColumn = grdTabella.medpIndexColonna('IMPORTO_RESIDUO_AUTO')) then
    ACell.Css:=IfThen((Self.Owner as TWA064FBudgetStraordinario).rgpTipoResiduo.ItemIndex = 0,ACell.Css,'invisibile');

  if (AColumn = grdTabella.medpIndexColonna('ORE_RESIDUO'))
  or (AColumn = grdTabella.medpIndexColonna('IMPORTO_RESIDUO')) then
    ACell.Css:=IfThen((Self.Owner as TWA064FBudgetStraordinario).rgpTipoResiduo.ItemIndex = 1,ACell.Css,'invisibile');
end;

procedure TWA064FBudgetStraordinarioMesiFM.edtOreAsyncExit(Sender: TObject; EventParams: TStringList);
begin
  Row:=grdTabella.medpRigaDiCompGriglia(TmeIWEdit(Sender).FriendlyName);
  with (WR302DM as TWA064FBudgetStraordinarioDM) do
  begin
    (*if TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('IMPORTO_MANUALE'),0)).Text <> '' then
      TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('IMPORTO_DOVUTO'),0)).Text:=
        TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('IMPORTO_MANUALE'),0)).Text
    else
      if TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('IMPORTO_RETTIFICA'),0)).Text <> '' then
        TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('IMPORTO_DOVUTO'),0)).Text:=
          TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('IMPORTO_RETTIFICA'),0)).Text
      else
        TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('IMPORTO_DOVUTO'),0)).Text:=
          TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('IMPORTO_INIZIALE'),0)).Text;*)
  end;
end;

procedure TWA064FBudgetStraordinarioMesiFM.edtImportoAsyncExit(Sender: TObject; EventParams: TStringList);
begin
  Row:=grdTabella.medpRigaDiCompGriglia(TmeIWEdit(Sender).FriendlyName);
  with (WR302DM as TWA064FBudgetStraordinarioDM) do
  begin
    (*if TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('IMPORTO_MANUALE'),0)).Text <> '' then
      TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('IMPORTO_DOVUTO'),0)).Text:=
        TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('IMPORTO_MANUALE'),0)).Text
    else
      if TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('IMPORTO_RETTIFICA'),0)).Text <> '' then
        TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('IMPORTO_DOVUTO'),0)).Text:=
          TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('IMPORTO_RETTIFICA'),0)).Text
      else
        TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('IMPORTO_DOVUTO'),0)).Text:=
          TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('IMPORTO_INIZIALE'),0)).Text;*)
  end;
end;

end.
