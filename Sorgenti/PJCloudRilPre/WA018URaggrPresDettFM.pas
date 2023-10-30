unit WA018URaggrPresDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWDBExtCtrls, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWDBRadioGroup, IWCompExtCtrls, IWCompJQueryWidget,
  meIWLabel;

type
  TWA018FRaggrPresDettFM = class(TWR205FDettTabellaFM)
    dedtCodice: TmeIWDBEdit;
    lblCodice: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    lblIndennitaNotturna: TmeIWLabel;
    drgpIndennitaNotturna: TmeIWDBRadioGroup;
    lblIndennitaFestiva: TmeIWLabel;
    drgpIndennitaFestiva: TmeIWDBRadioGroup;
    drgpIndennitaPresenza: TmeIWDBRadioGroup;
    lblIndennitaPresenza: TmeIWLabel;
    lblInquadramento: TmeIWLabel;
    drgpInquadramento: TmeIWDBRadioGroup;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
