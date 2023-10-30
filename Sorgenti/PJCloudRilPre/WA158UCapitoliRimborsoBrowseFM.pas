unit WA158UCapitoliRimborsoBrowseFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR204UBrowseTabellaFM, Vcl.Menus,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids,
  IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, C190FunzioniGeneraliWeb, medpIWMultiColumnComboBox,
  DB, meIWEdit, IWCompEdit, C180FunzioniGenerali;

type
  TWA158FCapitoliRimborsoBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
  private
    { Private declarations }
    RigaInEdit:integer;
    procedure meIWEditDecorrenzaAsyncExit(Sender: TObject; EventParams: TStringList);
    procedure CaricaCapitoliTrasferta;
  public
    { Public declarations }
  end;

implementation

uses
  WA158UCapitoliRimborsoDM;

{$R *.dfm}

procedure TWA158FCapitoliRimborsoBrowseFM.CaricaCapitoliTrasferta;
var
  DataDecorrenza:TDateTime;
  i:integer;
begin
  if TryStrToDateTime((grdTabella.medpCompCella(RigaInEdit,'DECORRENZA',0) as TmeIWEdit).Text,DataDecorrenza) then
  begin
    (WR302DM as TWA158FCapitoliRimborsoDM).A158MW.ElencoCapitoliTrasferta(DataDecorrenza);
    (grdTabella.medpCompCella(RigaInEdit,'CAPITOLO_TRASFERTA',0) as TMedpIWMultiColumnComboBox).Items.Clear;
    for i:=Low((WR302DM as TWA158FCapitoliRimborsoDM).A158MW.ArrCapitoliTrasferta) to High((WR302DM as TWA158FCapitoliRimborsoDM).A158MW.ArrCapitoliTrasferta) do
      (grdTabella.medpCompCella(RigaInEdit,'CAPITOLO_TRASFERTA',0) as TMedpIWMultiColumnComboBox).AddRow((WR302DM as TWA158FCapitoliRimborsoDM).A158MW.ArrCapitoliTrasferta[i].Value + ';' +
                                                                                                         (WR302DM as TWA158FCapitoliRimborsoDM).A158MW.ArrCapitoliTrasferta[i].Item);
  end;
end;

procedure TWA158FCapitoliRimborsoBrowseFM.meIWEditDecorrenzaAsyncExit(Sender: TObject; EventParams: TStringList);
begin
  CaricaCapitoliTrasferta;
end;

procedure TWA158FCapitoliRimborsoBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;
  RigaInEdit:=Row;
  if WR302DM.selTabella.State in [dsInsert] then
  begin
    (grdTabella.medpCompCella(Row,'DECORRENZA',0) as TmeIWEdit).OnAsyncExit:=meIWEditDecorrenzaAsyncExit;
    (WR302DM as TWA158FCapitoliRimborsoDM).A158MW.selM022.Open;
    C190CaricaMepdMulticolumnComboBox((grdTabella.medpCompCella(Row,'CATEG_RIMBORSO',0) as TMedpIWMultiColumnComboBox),
                                      (WR302DM as TWA158FCapitoliRimborsoDM).A158MW.selM022);
    (grdTabella.medpCompCella(Row,'CATEG_RIMBORSO',0) as TMedpIWMultiColumnComboBox).Text:=grdTabella.medpValoreColonna(Row,'CATEG_RIMBORSO');
    CaricaCapitoliTrasferta;
  end;
end;

procedure TWA158FCapitoliRimborsoBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CATEG_RIMBORSO'),0,DBG_MECMB,'10','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CAPITOLO_TRASFERTA'),0,DBG_MECMB,'10','2','null','','S');
end;

end.
