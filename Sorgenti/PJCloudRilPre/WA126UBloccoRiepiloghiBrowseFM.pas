unit WA126UBloccoRiepiloghiBrowseFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR204UBrowseTabellaFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWCompCheckbox,
  meIWCheckBox;

type
  TWA126FBloccoRiepiloghiBrowseFM = class(TWR204FBrowseTabellaFM)
    chkDipendentiSelezionati: TmeIWCheckBox;
    procedure chkDipendentiSelezionatiClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA126UBloccoRiepiloghi;

{$R *.dfm}

procedure TWA126FBloccoRiepiloghiBrowseFM.chkDipendentiSelezionatiClick(
  Sender: TObject);
begin
  inherited;
  (Self.Owner as TWA126FBloccoRiepiloghi).caricaElenco;
end;

procedure TWA126FBloccoRiepiloghiBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  chkDipendentiSelezionati.Checked:=True;
end;

end.
