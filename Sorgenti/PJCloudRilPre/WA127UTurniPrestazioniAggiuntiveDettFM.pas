unit WA127UTurniPrestazioniAggiuntiveDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWCompCheckbox, IWDBStdCtrls, meIWDBCheckBox,
  IWCompEdit, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWLabel;

type
  TWA127FTurniPrestazioniAggiuntiveDettFM = class(TWR205FDettTabellaFM)
    lblCodice: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    lblOraInizio: TmeIWLabel;
    dedtOraInizio: TmeIWDBEdit;
    lblOraFine: TmeIWLabel;
    dedtOraFine: TmeIWDBEdit;
    dchkControlloPartTime: TmeIWDBCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
