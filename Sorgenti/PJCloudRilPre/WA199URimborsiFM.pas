unit WA199URimborsiFM;

interface

uses
  C190FunzioniGeneraliWeb,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, OracleData,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, Vcl.Menus, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  Data.DB, medpIWMultiColumnComboBox;

type
  TWA199FRimborsiFM = class(TWR203FGestDetailFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
    procedure actConfermaExecute(Sender: TObject); override;
  public
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
  end;

implementation

uses WA199UCheckRimborsi, WA199UCheckRimborsiDM;

{$R *.dfm}

procedure TWA199FRimborsiFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  // nasconde action
  actNuovo.Visible:=False;
  actElimina.Visible:=False;
end;

procedure TWA199FRimborsiFM.CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource);
begin
  inherited;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('D_STATO'),0,DBG_MECMB,'12','2','null','','S');
  grdTabella.medpCaricaCDS;
end;

procedure TWA199FRimborsiFM.grdTabellaComponenti2DataSet(Row: Integer);
var
  IWC: TIWCustomControl;
  IWCmb: TMedpIWMultiColumnComboBox;
  Valore: String;
begin
  inherited;
  // imposta valore multicolumn (il valore attuale è su D_STATO, e viene riportato su STATO)
  Valore:='';
  IWC:=grdTabella.medpCompCella(Row,'D_STATO',0);
  if IWC <> nil then
  begin
    IWCmb:=TMedpIWMultiColumnComboBox(IWC);
    Valore:=IWCmb.Text;
  end;

  grdTabella.medpDataSet.FieldByName('STATO').AsString:=Valore;
end;

procedure TWA199FRimborsiFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;
  // popola multicolumn e imposta il valore del campo
  with (grdTabella.medpCompCella(Row,'D_STATO',0) as TMedpIWMultiColumnComboBox) do
  begin
    PopUpHeight:=3;
    Items.Clear;
    with (WR302DM as TWA199FCheckRimborsiDM).A100FCheckRimborsiMW.cdsStato do
    begin
      First;
      while not Eof do
      begin
        AddRow(Format('%s;%s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
        Next;
      end;
    end;
    Text:=grdTabella.medpValoreColonna(Row,'STATO');
  end;
end;

procedure TWA199FRimborsiFM.actConfermaExecute(Sender: TObject);
begin
  inherited;

  // refresh del dataset master dopo gli update
  (WR302DM as TWA199FCheckRimborsiDM).A100FCheckRimborsiMW.selM040CheckRimb_Funzioni.Refresh;
  (Self.Owner as TWA199FCheckRimborsi).actAggiornaExecute(nil);
end;

end.
