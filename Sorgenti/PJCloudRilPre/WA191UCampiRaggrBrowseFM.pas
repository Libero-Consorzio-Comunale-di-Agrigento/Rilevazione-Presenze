unit WA191UCampiRaggrBrowseFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR204UBrowseTabellaFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, C190FunzioniGeneraliWeb,
  meIWComboBox, WA191UCampiRaggrDM, Vcl.Menus;

type
  TWA191FCampiRaggrBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
  end;

implementation

{$R *.dfm}

procedure TWA191FCampiRaggrBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;

  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DATADECORR'),0,DBG_EDT,'','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('NOMECAMPO1'),0,DBG_CMB,'','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('NOMECAMPO2'),0,DBG_CMB,'','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TIPOLIMITE'),0,DBG_CMB,'','','','','S');
end;

procedure TWA191FCampiRaggrBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
var
  combo1, combo2 : TmeIWComboBox;
  campo: String;
begin
  inherited;
  combo1:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('NOMECAMPO1'),0) as TmeIWComboBox);
  combo2:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('NOMECAMPO2'),0) as TmeIWComboBox);
  combo1.Items.Clear;
  combo1.NoSelectionText:='';
  combo1.Items.Add('');
  combo1.ItemIndex:=0;

  combo2.Items.Clear;
  combo2.NoSelectionText:='';
  combo2.Items.Add('');
  combo2.ItemIndex:=0;

  with (WR302DM as TWA191FCampiRaggrDM).A094FSkLimitiStraordMW.QCols do
  begin
    First;
    while not Eof do
    begin
      campo:=FieldByName('COLUMN_NAME').AsString;
      combo1.Items.Add(campo);

      if campo = grdTabella.medpValoreColonna(Row, 'NOMECAMPO1') then
        combo1.ItemIndex:=combo1.Items.Count - 1;

      combo2.Items.Add(campo);
      if campo = grdTabella.medpValoreColonna(Row, 'NOMECAMPO2') then
        combo2.ItemIndex:=combo2.Items.Count - 1;
      Next;
    end;
  end;
  //TIPO LIMITE
  combo1:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TIPOLIMITE'),0) as TmeIWComboBox);
  combo1.ItemsHaveValues:=True;
  combo1.Items.Clear;
  combo1.Items.Add('L - Liquidabile=L');
  combo1.Items.Add('R - Residuabile=R');
  if grdTabella.medpValoreColonna(Row, 'TIPOLIMITE') = 'L' then
    combo1.ItemIndex:=0
  else if grdTabella.medpValoreColonna(Row, 'TIPOLIMITE') = 'R' then
    combo1.ItemIndex:=1
  else
    combo1.ItemIndex:=0;  //non usare -1 perchèe altrimenti elemento vuoto
end;

end.
