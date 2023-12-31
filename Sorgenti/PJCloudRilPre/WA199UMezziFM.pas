unit WA199UMezziFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, Vcl.Menus, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion;

type
  TWA199FMezziFM = class(TWR203FGestDetailFM)
    procedure IWFrameRegionCreate(Sender: TObject);
  private

  public

  end;

implementation

{$R *.dfm}

procedure TWA199FMezziFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  // la grid � in sola lettura
  actNuovo.Visible:=False;
  actModifica.Visible:=False;
  actElimina.Visible:=False;
  actAnnulla.Visible:=False;
  actConferma.Visible:=False;
end;

end.
