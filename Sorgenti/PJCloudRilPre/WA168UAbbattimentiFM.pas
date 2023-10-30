unit WA168UAbbattimentiFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, Vcl.Menus, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  C190FunzioniGeneraliWeb, meIWComboBox, medpIWMultiColumnComboBox, meIWLabel,
  OracleData, Data.Db;

type
  TWA168FAbbattimentiFM = class(TWR203FGestDetailFM)
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure cmbDescrizioneAbbattimentoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Text:String);
  private
    { Private declarations }
  public
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
  end;

implementation
  uses
    WR102UGestTabella;

{$R *.dfm}

procedure TWA168FAbbattimentiFM.CaricaDettaglio(DataSet: TDataSet; DataSource: TDataSource);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TipoAbbattimento'),0,DBG_MECMB,'5','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('Desc_Abbattimento'),0,DBG_LBL,'10','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('MeseApplicazioneAbbattimento'),0,DBG_EDT,'input_data_my','','null','','S');
end;

procedure TWA168FAbbattimentiFM.grdTabellaDataSet2Componenti(Row: Integer);
var
  cmb: TmeIWComboBox;
  i: Integer;
begin
  inherited;
  if (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TipoAbbattimento'),0) <> nil) and
     (not (Self.Owner as TWR102FGestTabella).InterfacciaWR102.StoricizzazioneInCorso) then
    with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TipoAbbattimento'),0)as TMedpIWMultiColumnComboBox) do
    begin
      Items.Clear;
      PopUpHeight:=20;
      LookupColumn:=1;
      Text:=grdTabella.medpValoreColonna(Row, 'TipoAbbattimento');
      AddRow(Format('%s;%s',['AS','Assenze']));
      AddRow(Format('%s;%s',['GS','Giorni Servizio']));
      AddRow(Format('%s;%s',['PT','Part-time']));
      AddRow(Format('%s;%s',['SO','Saldo ore anno corrente']));
      OnAsyncChange:=cmbDescrizioneAbbattimentoAsyncChange;
    end;
end;


procedure TWA168FAbbattimentiFM.cmbDescrizioneAbbattimentoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Text:String);
var
  r:Integer;
begin
  inherited;
  with (Sender as TMedpIWMultiColumnComboBox) do
  begin
    r:=grdTabella.medpRigaDiCompGriglia(FriendlyName);
    TmeIWLabel(grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('Desc_Abbattimento'),0)).Caption:=Items[Index].RowData[1];
  end;
end;

end.
