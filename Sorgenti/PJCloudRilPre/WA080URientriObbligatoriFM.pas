unit WA080URientriObbligatoriFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,Dialogs,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  WR205UDettTabellaFM, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel,
  WR100UBase, ActnList, IWCompEdit, IWDBStdCtrls, meIWDBEdit,
  IWCompButton, meIWButton;

type
  TWA080FRientriObbligatoriFM = class(TWR205FDettTabellaFM)
    dedtGiorniLavorativi: TmeIWDBEdit;
    dedtRientriObbligatori: TmeIWDBEdit;
    lblGiorniLavorativi: TmeIWLabel;
    lblRientriObbligatori: TmeIWLabel;
    lblCodice: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

end.
