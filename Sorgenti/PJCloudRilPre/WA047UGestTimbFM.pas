unit WA047UGestTimbFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR208UGestTimbFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWControl,
  medpIWMultiColumnComboBox, IWCompExtCtrls, IWDBExtCtrls,
  meIWDBRadioGroup, IWDBStdCtrls, meIWDBEdit, IWCompEdit, meIWEdit, IWCompLabel,
  meIWLabel, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWCompButton,
  meIWButton, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion,A000UGestioneTimbraGiustMW;

type
  TWA047FGestTimbFM = class(TWR208FGestTimbFM)
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    { Private declarations }
  public
    public procedure Visualizza; override;
  end;

implementation
uses WR104UGestCartellino;
{$R *.dfm}

{ TWA047FGestTimbFM }

procedure TWA047FGestTimbFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  rgpTipoCausale.Visible:=False;
end;

procedure TWA047FGestTimbFM.Visualizza;
begin
  inherited;
  with A000FGestioneTimbraGiustMW do
  begin
    dedtOra.Enabled:=(StatoTimb = stInserimento);
  end;
  TWR104FGestCartellino(Self.Parent).VisualizzaJQMessaggio(jQuery,412,302,302, 'Dati Timbratura','#'+Self.Name,False,True);
end;

end.
