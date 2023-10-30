unit WA015UPlusOraIndivDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel, IWCompExtCtrls, IWDBExtCtrls, meIWDBRadioGroup, IWCompCheckbox, meIWDBCheckBox;

type
  TWA015FPlusOraIndivDettFm = class(TWR205FDettTabellaFM)
    lblAnno: TmeIWLabel;
    dedtAnno: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    dedDescrizione: TmeIWDBEdit;
    drgpDebito: TmeIWDBRadioGroup;
    dchkGestAnticipo: TmeIWDBCheckBox;
    lblGennaio: TmeIWLabel;
    dedtDebGennaio: TmeIWDBEdit;
    lblFebbraio: TmeIWLabel;
    dedtDebFebbraio: TmeIWDBEdit;
    lblMarzo: TmeIWLabel;
    dedtDebMarzo: TmeIWDBEdit;
    lblAprile: TmeIWLabel;
    dedtDebAprile: TmeIWDBEdit;
    lblMaggio: TmeIWLabel;
    dedtDebMaggio: TmeIWDBEdit;
    lblGiugno: TmeIWLabel;
    dedtDebGiugno: TmeIWDBEdit;
    dedtDebLuglio: TmeIWDBEdit;
    lblAgosto: TmeIWLabel;
    dedtDebAgosto: TmeIWDBEdit;
    lblSettembre: TmeIWLabel;
    dedtDebSettembre: TmeIWDBEdit;
    lblOttobre: TmeIWLabel;
    dedtDebOttobre: TmeIWDBEdit;
    lblNovembre: TmeIWLabel;
    dedtDebNovembre: TmeIWDBEdit;
    lblDicembre: TmeIWLabel;
    dedtDebDicembre: TmeIWDBEdit;
    lblLuglio: TmeIWLabel;
    dchkAntGennaio: TmeIWDBCheckBox;
    dchkAntFebbraio: TmeIWDBCheckBox;
    dchkAntMarzo: TmeIWDBCheckBox;
    dchkAntAprile: TmeIWDBCheckBox;
    dchkAntMaggio: TmeIWDBCheckBox;
    dchkAntGiugno: TmeIWDBCheckBox;
    dchkAntLuglio: TmeIWDBCheckBox;
    dchkAntAgosto: TmeIWDBCheckBox;
    dchkAntSettembre: TmeIWDBCheckBox;
    dchkAntOttobre: TmeIWDBCheckBox;
    dchkAntNovembre: TmeIWDBCheckBox;
    dchkAntDicembre: TmeIWDBCheckBox;
    lblDebitoAgg1: TmeIWLabel;
    lblGestAnticipo1: TmeIWLabel;
    lblDebitoAgg2: TmeIWLabel;
    lblGestAnticipo2: TmeIWLabel;
    lblDebito: TmeIWLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

end.
