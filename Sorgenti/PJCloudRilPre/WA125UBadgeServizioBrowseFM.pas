unit WA125UBadgeServizioBrowseFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR204UBrowseTabellaFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, meIWEdit, C190FunzioniGeneraliWeb;

type
  TWA125FBadgeServizioBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWA125FBadgeServizioBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;
  with TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DECORRENZA'),0)) do
  begin
    Css:='width15chr input_data_dmyhhmm';
    if Length(Text) = 10 then // dd/mm/yyyy
      Text:=Text+' 00.00';
  end;
  with TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('SCADENZA'),0)) do
  begin
    Css:='width15chr input_data_dmyhhmm';
    if Length(Text) = 10 then // dd/mm/yyyy
      Text:=Text+' 00.00';
  end;
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('BADGESERV'),0) as TmeIWEdit).Css:='input_integer_15';
end;

procedure TWA125FBadgeServizioBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DECORRENZA'),0,DBG_EDT,'20','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('SCADENZA'),0,DBG_EDT,'20','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('BADGESERV'),0,DBG_EDT,'20','','null','','S');
end;

end.
