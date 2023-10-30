unit WA179UProfiliIterAutDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompLabel, meIWLabel,
  IWCompEdit, medpIWMultiColumnComboBox, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid,
  IWCompListbox, IWDBStdCtrls, meIWDBLookupComboBox, C180FunzioniGenerali,
  Math, A000UInterfaccia, Vcl.StdCtrls, meIWDBLabel, meIWEdit;

type
  TWA179FProfiliIterAutDettFM = class(TWR205FDettTabellaFM)
    grdIterAutorizzativi: TmedpIWDBGrid;
    cmbCodiceIter: TMedpIWMultiColumnComboBox;
    lblCodiceIter: TmeIWLabel;
    lblProfilo: TmeIWLabel;
    edtProfilo: TmeIWEdit;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure cmbCodiceIterChange(Sender: TObject; Index: Integer);
    procedure IWFrameRegionRender(Sender: TObject);
    procedure grdIterAutorizzativiDataSet2Componenti(Row: Integer);
    procedure grdIterAutorizzativiComponenti2DataSet(Row: Integer);
  private
    { Private declarations }
    procedure CaricaGridIter;
  public
    { Public declarations }
    procedure ConfermaGridIter;
    procedure AbilitaComponenti; override;
    procedure CaricaMultiColumnCombobox; override;
  end;

implementation

uses
  WA179UProfiliIterAutDM, C190FunzioniGeneraliWeb, A000UCostanti,
  WA179UProfiliIterAut;

{$R *.dfm}

procedure TWA179FProfiliIterAutDettFM.ConfermaGridIter;
var
  r: Integer;
begin
  GrdIterAutorizzativi.medpDataSet.First;
  for r:=IfThen(GrdIterAutorizzativi.RigaInserimento,1,0) to High(GrdIterAutorizzativi.medpCompGriglia) do
  begin
    //Mi posizione sul record corretto mediante recNo
    GrdIterAutorizzativi.medpDataSet.RecNo:=r + 1;
    GrdIterAutorizzativi.medpDataSet.Edit;
    GrdIterAutorizzativi.medpConferma(r);
  end;
  GrdIterAutorizzativi.medpDataSet.First;
end;

procedure TWA179FProfiliIterAutDettFM.CaricaGridIter;
begin
  GrdIterAutorizzativi.DataSource:=(WR302DM as TWA179FProfiliIterAutDM).dsrI075;
  GrdIterAutorizzativi.medpPaginazione:=False;
  GrdIterAutorizzativi.medpRowSelect:=False;
  GrdIterAutorizzativi.medpEditMultiplo:=True;
  GrdIterAutorizzativi.medpAttivaGrid((WR302DM as TWA179FProfiliIterAutDM).selI075,False,False,False);
  GrdIterAutorizzativi.medpPreparaComponenteGenerico('WR102','D_ACCESSO',0,DBG_MECMB,'20','2','','');
end;

procedure TWA179FProfiliIterAutDettFM.CaricaMultiColumnCombobox;
var
  i:Integer;
begin
  inherited;
  //Codici Iter
  cmbCodiceIter.Items.Clear;
  for i:=0 to High(A000IterAutorizzativi) do
  begin
    cmbCodiceIter.AddRow(Format('%s;%s',[A000IterAutorizzativi[i].Cod,A000IterAutorizzativi[i].Desc]));
  end;
  cmbCodiceIter.ItemIndex:=0;
end;

procedure TWA179FProfiliIterAutDettFM.cmbCodiceIterChange(Sender: TObject;
  Index: Integer);
begin
  inherited;
  (WR302DM AS TWA179FProfiliIterAutDM).OpenSelI075((Parent as TWA179FProfiliIterAut).cmbAzienda.Items[(Parent as TWA179FProfiliIterAut).cmbAzienda.ItemIndex].RowData[0], cmbCodiceIter.Items[cmbCodiceIter.ItemIndex].RowData[0]);
  GrdIterAutorizzativi.medpAggiornaCDS(True);
end;

procedure TWA179FProfiliIterAutDettFM.grdIterAutorizzativiComponenti2DataSet(
  Row: Integer);
var
  Cmb:TMedpIWMultiColumnComboBox;
begin
  inherited;
  Cmb:=(GrdIterAutorizzativi.medpCompCella(Row,'D_ACCESSO',0) as TMedpIWMultiColumnComboBox);
  if Cmb.ItemIndex >= 0 then
  begin
    (WR302DM as TWA179FProfiliIterAutDM).selI075.FieldByName('ACCESSO').AsString:=Cmb.Items[Cmb.ItemIndex].RowData[0];
  end;
end;

procedure TWA179FProfiliIterAutDettFM.grdIterAutorizzativiDataSet2Componenti(Row: Integer);
var
  i:Integer;
  Cmb:TMedpIWMultiColumnComboBox;
begin
  inherited;
  Cmb:=(grdIterAutorizzativi.medpCompCella(Row,'D_ACCESSO',0) as TMedpIWMultiColumnComboBox);
  Cmb.CodeColumn:=1;
  Cmb.Items.Clear;
  for i:=Low((WR302DM as TWA179FProfiliIterAutDM).A179MW.D_TipoAccesso) to High((WR302DM as TWA179FProfiliIterAutDM).A179MW.D_TipoAccesso) do
  begin
    Cmb.AddRow(Format('%s;%s',[(WR302DM as TWA179FProfiliIterAutDM).A179MW.D_TipoAccesso[i].Value,
                               (WR302DM as TWA179FProfiliIterAutDM).A179MW.D_TipoAccesso[i].Item]));
  end;
end;

procedure TWA179FProfiliIterAutDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  CaricaMultiColumnCombobox;
  CaricaGridIter;
  cmbCodiceIter.Enabled:=True;
  cmbCodiceIter.ReadOnly:=False;
end;

procedure TWA179FProfiliIterAutDettFM.IWFrameRegionRender(Sender: TObject);
begin
  inherited;
  cmbCodiceIter.Enabled:=True;
end;

procedure TWA179FProfiliIterAutDettFM.AbilitaComponenti;
begin
  inherited;
  cmbCodiceIter.Enabled:=True;
end;

end.
