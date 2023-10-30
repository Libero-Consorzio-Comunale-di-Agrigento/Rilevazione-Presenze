unit WA085UPartTimeDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWDBExtCtrls, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWDBRadioGroup, IWCompExtCtrls, IWCompJQueryWidget,
  meIWLabel, DB;

type
  TWA085FPartTimeDettFM = class(TWR205FDettTabellaFM)
    lblTipo: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
    lblCodice: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    dedtIndFest: TmeIWDBEdit;
    lblIndFest: TmeIWLabel;
    dedtIncentivi: TmeIWDBEdit;
    lblIncentivi: TmeIWLabel;
    dedtIndPres: TmeIWDBEdit;
    lblIndPres: TmeIWLabel;
    dedtPianta: TmeIWDBEdit;
    lblPianta: TmeIWLabel;
    dedtAssenzeGg: TmeIWDBEdit;
    lblAssenzeGg: TmeIWLabel;
    dedtAssenzeHh: TmeIWDBEdit;
    lblAssenzeHh: TmeIWLabel;
    dedtDebitoAgg: TmeIWDBEdit;
    lblDebitoAgg: TmeIWLabel;
    drgpTipo: TmeIWDBRadioGroup;
    lblDescrizioneEstesa: TmeIWLabel;
    dedtDescrizioneEstesa: TmeIWDBEdit;
    lblPercentuali: TmeIWLabel;
    dedtValorizGG: TmeIWDBEdit;
    lblValorizGG: TmeIWLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
