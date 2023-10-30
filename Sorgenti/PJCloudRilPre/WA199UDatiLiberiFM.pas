unit WA199UDatiLiberiFM;

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
  TWA199FDatiLiberiFM = class(TWR203FGestDetailFM)
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWA199FDatiLiberiFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  // la grid è in sola lettura
  actNuovo.Visible:=False;
  actModifica.Visible:=False;
  actElimina.Visible:=False;
  actAnnulla.Visible:=False;
  actConferma.Visible:=False;
end;

end.
