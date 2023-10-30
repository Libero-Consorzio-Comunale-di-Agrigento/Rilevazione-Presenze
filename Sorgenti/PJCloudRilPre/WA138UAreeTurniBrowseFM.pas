unit WA138UAreeTurniBrowseFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR204UBrowseTabellaFM, Vcl.Menus,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids,
  IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  meIWImageFile, meIWLabel, WC013UCheckListFM, medpIWMultiColumnComboBox,
  A000UCostanti, A000USessione, A000UInterfaccia, C190FunzioniGeneraliWeb;

type
  TImgRow = class
    NumRow:integer;
  end;

  TWA138FAreeTurniBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
  private
    { Private declarations }
    RowEdit: Integer;
  public
    { Public declarations }
  end;

const
  LUNGHEZZA = 10;

implementation

uses WA138UAreeTurniDM;

{$R *.dfm}

procedure TWA138FAreeTurniBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('COLORE'),0,DBG_MECMB,'10','2','null','','S');
end;

procedure TWA138FAreeTurniBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
var cmb:TmedpIWMultiColumnComboBox;
    i, conta: Integer;
begin
  inherited;
  // Campo colore
  conta:=0;
  cmb:=TmedpIWMultiColumnComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COLORE'),0));
  cmb.css:='MulticolCmb';
  cmb.Items.Clear;
  for i:=0 to High(lstColori) do
    if (lstColori[i].Sfondo = 'S') then
    begin
      conta:=conta+1;
      TmedpIWMultiColumnComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COLORE'),0)).AddRow(Format('%s;%s',[lstColori[i].Nome,inttostr(conta)]));
    end;
end;

end.
