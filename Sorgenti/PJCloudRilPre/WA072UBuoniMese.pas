unit WA072UBuoniMese;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,
  System.Actions;

type
  TWA072FBuoniMese = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA072UBuoniMeseDM, WA072UBuoniMeseBrowseFM;

{$R *.dfm}

procedure TWA072FBuoniMese.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA072FBuoniMeseDM.Create(Self);
  AttivaGestioneC700;
  WBrowseFM:=TWA072FBuoniMeseBrowseFM.Create(Self);
  CreaTabDefault;
end;

end.
