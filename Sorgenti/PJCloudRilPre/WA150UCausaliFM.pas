unit WA150UCausaliFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, OracleData,
  Dialogs, WR203UGestDetailFM, ActnList, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompGrids, meIWGrid,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid,
  IWVCLBaseContainer, IWContainer, IWApplication, IWHTMLContainer, IWHTML40Container, IWRegion,
  meIWImageFile, C190FunzioniGeneraliWeb, Menus, A000UInterfaccia, WC003URicercaDatiFM,
  A000UCostanti, System.Actions;

type
  TWA150FCausaliFM = class(TWR203FGestDetailFM)
    grdAccorpCausali: TmedpIWDBGrid;
    grdAccorpCausaliNavBar: TmeIWGrid;
    actlstAccorpCausaliNavBar: TActionList;
    actAccorpPrecedente: TAction;
    actAccorpSuccessivo: TAction;
    actAccorpUltimo: TAction;
    actAccorpPrimo: TAction;
    actAccorpRicerca: TAction;
    actAccorpAggiorna: TAction;
    procedure grdTabellaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdAccorpCausaliRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure actPrecedenteExecute(Sender: TObject);
    procedure actAccorpSuccessivoExecute(Sender: TObject);
    procedure actAccorpUltimoExecute(Sender: TObject);
    procedure actAccorpPrimoExecute(Sender: TObject);
    procedure actAccorpRicercaExecute(Sender: TObject);
    procedure actAccorpAggiornaExecute(Sender: TObject);
    procedure actAccorpPrecedenteExecute(Sender: TObject);
  private
    procedure imgAccediClick(Sender: TObject);
    procedure imgAccorpNavBarClick(Sender: TObject);
  public
    procedure PreparaComponenti;
    procedure AggiornaGridAccorpCausali;
  end;

implementation

uses WA150UAccorpamentoCausali, WA150UAccorpamentoCausaliDM, WA150UCodiciAccorpamentoCausali;

{$R *.dfm}

procedure TWA150FCausaliFM.IWFrameRegionCreate(Sender: TObject);
begin
  grdTabella.medpComandiCustom:=True;
  inherited;
  grdTabella.medpPaginazione:=True;
  grdTabella.medpRighePagina:=1000;
  grdAccorpCausali.medpPaginazione:=True;
  grdAccorpCausali.medpRighePagina:=1000;
  (Self.Owner as TWA150FAccorpamentoCausali).CreaNavigatorBar(actlstAccorpCausaliNavBar,grdAccorpCausaliNavBar,imgAccorpNavBarClick);
end;

procedure TWA150FCausaliFM.grdAccorpCausaliRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  inherited;
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
end;

procedure TWA150FCausaliFM.grdTabellaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var r : Integer;
    img : TmeIWImageFile;
begin
  inherited;
  for r := 1 to High(grdTabella.medpCompGriglia) do
    if grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('DBG_COMANDI'),0) <> nil then
    begin
      img:=TmeIWImageFile(grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('DBG_COMANDI'),0));
      img.OnClick:=imgAccediClick;
    end;
end;

procedure TWA150FCausaliFM.imgAccediClick(Sender: TObject);
var r: Integer;
begin
  r:=grdTabella.medpRigaDiCompGriglia(TmeIWImageFile(Sender).FriendlyName);
  (Self.Owner as TWA150FAccorpamentoCausali).AccediForm(91,'COD_TIPOACCORPCAUSALI='+ grdTabella.medpValoreColonna(r, 'COD_TIPOACCORPCAUSALI')+ ParamDelimiter + 'COD_CODICIACCORPCAUSALI='+grdTabella.medpValoreColonna(r, 'COD_CODICIACCORPCAUSALI'));
end;

procedure TWA150FCausaliFM.PreparaComponenti;
begin
  grdtabella.medpCancellaRigaWR102;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102-R',grdTabella.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','ACCEDI','','','');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('COD_TIPOACCORPCAUSALI'),0,DBG_EDT,'5','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('COD_CODICIACCORPCAUSALI'),0,DBG_EDT,'5','','null','','S');
end;

procedure TWA150FCausaliFM.AggiornaGridAccorpCausali;
begin
 with ((Self.Owner as TWA150FAccorpamentoCausali).WR302DM as TWA150FAccorpamentoCausaliDM) do
  begin
    selT257.Close;
    selT257.SetVariable('CodTipoAccorpCausali', selT256.FieldByName('COD_TIPOACCORPCAUSALI').AsString);
    selT257.SetVariable('CodCodiciAccorpCausali', selT256.FieldByName('COD_CODICIACCORPCAUSALI').AsString);
    selT257.Open;
    if grdAccorpCausali.medpDataSet <> nil then
      grdAccorpCausali.medpAggiornaCDS(True)
    else
      grdAccorpCausali.medpAttivaGrid(selT257, False, False);
  end;
end;

procedure TWA150FCausaliFM.imgAccorpNavBarClick(Sender: TObject);
begin
  TAction(actlstAccorpCausaliNavBar.Actions[TmeIWImageFile(Sender).Tag]).Execute;
end;

procedure TWA150FCausaliFM.actAccorpAggiornaExecute(Sender: TObject);
begin
  grdAccorpCausali.medpDataSet.Refresh;
  grdAccorpCausali.medpAggiornaCDS;
end;

procedure TWA150FCausaliFM.actAccorpPrecedenteExecute(Sender: TObject);
// spostamento su record precedente
begin
  grdAccorpCausali.medpDataSet.DisableControls;
  grdAccorpCausali.medpDataSet.Prior;
  grdAccorpCausali.medpDataSet.EnableControls;
  grdAccorpCausali.medpAggiornaCDS(False);
end;

procedure TWA150FCausaliFM.actAccorpPrimoExecute(Sender: TObject);
// spostamento su primo record
begin
  grdAccorpCausali.medpDataSet.DisableControls;
  grdAccorpCausali.medpDataSet.First;
  grdAccorpCausali.medpDataSet.EnableControls;
  grdAccorpCausali.medpAggiornaCDS(False);
end;
procedure TWA150FCausaliFM.actAccorpRicercaExecute(Sender: TObject);
begin
  with TWC003FRicercaDatiFM.Create(Self.Owner) do
  begin
    SearchGrid:=grdAccorpCausali;
    SearchDataset:=TOracleDataSet(grdAccorpCausali.medpDataSet);
    Visualizza;
  end;
end;

procedure TWA150FCausaliFM.actAccorpSuccessivoExecute(Sender: TObject);
begin
  grdAccorpCausali.medpDataSet.DisableControls;
  grdAccorpCausali.medpDataSet.Next;
  grdAccorpCausali.medpDataSet.EnableControls;
  grdAccorpCausali.medpAggiornaCDS(False);
end;

procedure TWA150FCausaliFM.actAccorpUltimoExecute(Sender: TObject);
// spostamento su ultimo record
begin
  grdAccorpCausali.medpDataSet.DisableControls;
  grdAccorpCausali.medpDataSet.Last;
  grdAccorpCausali.medpDataSet.EnableControls;
  grdAccorpCausali.medpAggiornaCDS(False);
end;

procedure TWA150FCausaliFM.actPrecedenteExecute(Sender: TObject);
// spostamento su record precedente
begin
  grdAccorpCausali.medpDataSet.DisableControls;
  grdAccorpCausali.medpDataSet.Prior;
  grdAccorpCausali.medpDataSet.EnableControls;
  grdAccorpCausali.medpAggiornaCDS(False);
end;

end.
