unit WA206UCodiciCondizioniTurniDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, IWDBStdCtrls,
  meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompLabel, meIWLabel, IWCompCheckbox, meIWDBCheckBox, IWCompListbox,
  meIWDBComboBox, meIWDBLookupComboBox;

type
  TWA206FCodiciCondizioniTurniDettFM = class(TWR205FDettTabellaFM)
    lblCodice: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    dchkGenerale: TmeIWDBCheckBox;
    dchkIndividuale: TmeIWDBCheckBox;
    lblAbilita: TmeIWLabel;
    lblObbliga: TmeIWLabel;
    lblTipo: TmeIWLabel;
    lblSquadra: TmeIWLabel;
    lblTipoOperatore: TmeIWLabel;
    lblOrario: TmeIWLabel;
    lblSiglaTurno: TmeIWLabel;
    lblGiorno: TmeIWLabel;
    lblMinimo: TmeIWLabel;
    lblOttimale: TmeIWLabel;
    lblMassimo: TmeIWLabel;
    lblValore: TmeIWLabel;
    dchkSqA: TmeIWDBCheckBox;
    dchkOpA: TmeIWDBCheckBox;
    dchkOrA: TmeIWDBCheckBox;
    dchkSgA: TmeIWDBCheckBox;
    dchkGgA: TmeIWDBCheckBox;
    dchkMnA: TmeIWDBCheckBox;
    dchkOtA: TmeIWDBCheckBox;
    dchkMxA: TmeIWDBCheckBox;
    dchkVrA: TmeIWDBCheckBox;
    dchkMnO: TmeIWDBCheckBox;
    dchkOtO: TmeIWDBCheckBox;
    dchkMxO: TmeIWDBCheckBox;
    dchkVrO: TmeIWDBCheckBox;
    dcmbValoreTipo: TmeIWDBLookupComboBox;
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA206UCodiciCondizioniTurni, WA206UCodiciCondizioniTurniDM;

{$R *.dfm}

procedure TWA206FCodiciCondizioniTurniDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  dcmbValoreTipo.ListSource:=((Self.Owner as TWA206FCodiciCondizioniTurni).WR302DM as TWA206FCodiciCondizioniTurniDM).A206MW.dsrTipoVal;
end;

end.
