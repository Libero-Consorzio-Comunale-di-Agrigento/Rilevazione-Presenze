unit WA080URientriObbligatoriBrowseFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR204UBrowseTabellaFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion,
  C190FunzioniGeneraliWeb, meIWLabel;

type
  TWA080FRientriObbligatoriBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
  private
    { Private declarations }
  public
    procedure PutTipoCartellino(Valore:String);
  end;


implementation

uses WA080URientriObbligatoriDM;

{$R *.dfm}

procedure TWA080FRientriObbligatoriBrowseFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  with TWA080FRientriObbligatoriDM(WR302DM).selTabella do
  begin
    FieldByName('CODICE').AsString:=TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CODICE'),0)).Caption;
    end;
end;

procedure TWA080FRientriObbligatoriBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;
  TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CODICE'),0)).Caption:=TWA080FRientriObbligatoriDM(WR302DM).selTabella.GetVariable('TIPOCARTELLINO');

end;

procedure TWA080FRientriObbligatoriBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CODICE'),0,DBG_LBL,'10','','null','','S');
end;

procedure TWA080FRientriObbligatoriBrowseFM.PutTipoCartellino(Valore: String);
begin
   TWA080FRientriObbligatoriDM(WR302DM).PutTipoCartellino(Valore);
   grdTabella.medpCaricaCDS;
end;

end.
