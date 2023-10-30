unit WA089URegIndPresenzaRegMaturazioneFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR203UGestDetailFM, ActnList, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, System.Actions;

type
  TWA089FRegIndPresenzaRegMaturazioneFM = class(TWR203FGestDetailFM)
    procedure grdTabellaComponenti2DataSet(Row: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA089URegIndPResenzaDM, WA089URegIndPresenza;

{$R *.dfm}

procedure TWA089FRegIndPresenzaRegMaturazioneFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  grdTabella.medpDataSet.FieldByName('CODICE').AsString:=TWA089FRegIndPresenzaDM(TWA089FRegIndPresenza(Self.Parent).WR302DM).selTabella.FieldByName('CODICE').AsString;
end;

end.
