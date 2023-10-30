unit WA007UProfiliOrariDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWVCLComponent, Db,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWDBExtCtrls, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWDBRadioGroup, IWCompListbox, meIWDBComboBox,
  C180FunzioniGenerali, meIWEdit, IWCompCheckbox, meIWDBCheckBox, meIWLabel,
  IWCompExtCtrls, IWCompJQueryWidget;

type
  TWA007FProfiliOrariDettFM = class(TWR205FDettTabellaFM)
    lblCodice: TmeIWLabel;
    lblDescrizione: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
    dedtDescrizione: TmeIWDBEdit;
    dchkIgnoraTimbrature: TmeIWDBCheckBox;
    lblPrioritaScelta: TmeIWLabel;
    lblConfrontaTimbrature: TmeIWLabel;
    drgpConfrontaTimbrature: TmeIWDBRadioGroup;
    dchkScostamentoEntrata: TmeIWDBCheckBox;
    dchkTimbratureEsterne: TmeIWDBCheckBox;
    lblMinRitardoEntrata: TmeIWLabel;
    lblAnticipoUscita: TmeIWLabel;
    dedtMinRitardoEntrata: TmeIWDBEdit;
    dedtAnticipoUscita: TmeIWDBEdit;
    lblTotaleSettimane: TmeIWLabel;
    lblNumSettimane: TmeIWLabel;
    dchkPrioritaDomFest: TmeIWDBCheckBox;
    dchkPrioritaDomNonLav: TmeIWDBCheckBox;
    lblPesoPRITIMSC_S: TmeIWLabel;
    dedtPesoPRITIMSC_S: TmeIWDBEdit;
    lblPesiPrioritaScelta: TmeIWLabel;
    lblPesoTIMBESTERNE: TmeIWLabel;
    dedtPesoTIMBESTERNE: TmeIWDBEdit;
    lblPesoPRITIMSC_A: TmeIWLabel;
    dedtPesoPRITIMSC_A: TmeIWDBEdit;
    lblPesoTIMBNONAPPOGGIATE_S: TmeIWLabel;
    dedtPesoTIMBNONAPPOGGIATE_S: TmeIWDBEdit;
    lblPesoSCOSTENTRATA_S: TmeIWLabel;
    dedtPesoSCOSTENTRATA_S: TmeIWDBEdit;
    lblPesoTIMBNONAPPOGGIATE_N: TmeIWLabel;
    dedtPesoTIMBNONAPPOGGIATE_N: TmeIWDBEdit;
    lblPesoRITARDO_ENTRATA: TmeIWLabel;
    dedtPesoRITARDO_ENTRATA: TmeIWDBEdit;
    lblPesoMINANTSCELTA: TmeIWLabel;
    dedtPesoMINANTSCELTA: TmeIWDBEdit;
    dchkIgnoraStaccoPMT: TmeIWDBCheckBox;
  private
  public
    procedure DataSet2Componenti; override;
  end;

implementation
  uses WA007UProfiliOrariDM;

{$R *.dfm}

{ TWA007FProfiliOrariDettFM }

procedure TWA007FProfiliOrariDettFM.DataSet2Componenti;
begin
  inherited;
  with TWA007FProfiliOrariDM(WR302DM) do
    lblNumSettimane.Caption:=IntToStr(selT221.RecordCount);
end;

end.
