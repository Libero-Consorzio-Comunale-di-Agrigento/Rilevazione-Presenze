unit WP553URisorseResidueContoAnnuale;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink,WP553URisorseResidueContoAnnualeDM, WP553URisorseResidueContoAnnualeBrowseFM,
  WP553URisorseResidueContoAnnualeDettFM;

type
  TWP553FRisorseResidueContoAnnuale = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

function TWP553FRisorseResidueContoAnnuale.InizializzaAccesso: Boolean;
begin
  Result:=True;
end;

procedure TWP553FRisorseResidueContoAnnuale.IWAppFormCreate(Sender: TObject);
begin
  inherited;

  WR302DM:=TWP553FRisorseResidueContoAnnualeDM.Create(Self);
  WBrowseFM:=TWP553FRisorseResidueContoAnnualeBrowseFM.Create(Self);
  WDettaglioFM:=TWP553FRisorseResidueContoAnnualeDettFM.Create(Self);

  CreaTabDefault;
end;

end.
