unit WA023UGestTimbFM;

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
  IWHTML40Container, IWRegion, A000UGestioneTimbraGiustMW, A000UInterfaccia,
  IWAdvRadioGroup, meTIWAdvRadioGroup, Data.DB;

type
  TWA023FGestTimbFM = class(TWR208FGestTimbFM)
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    { Private declarations }
  public
    public procedure Visualizza; override;
    procedure ReleaseOggetti; override;
  end;

implementation

uses WR104UGestCartellino;

{$R *.dfm}

{ TWA023FGestTimbFM }

procedure TWA023FGestTimbFM.IWFrameRegionCreate(Sender: TObject);
var
  LDataSet: TDataSet;
begin
  inherited;

  // filtra il dataset delle causali di presenza
  LDataSet:=(Self.Parent as TWR104FGestCartellino).QCausPres;
  LDataSet.Filter:='INSERIMENTO_TIMB = ''S''';
  LDataSet.Filtered:=True;
end;

procedure TWA023FGestTimbFM.ReleaseOggetti;
begin
  with (Self.Parent as TWR104FGestCartellino) do
    QCausPres.Filtered:=False;
  inherited;
end;

procedure TWA023FGestTimbFM.Visualizza;
begin
  inherited;

  dedtOra.Enabled:=(A000FGestioneTimbraGiustMW.StatoTimb = stInserimento) or (Parametri.T100_Ora = 'S');
  cmbRilevatore.Enabled:=(A000FGestioneTimbraGiustMW.StatoTimb = stInserimento) or (Parametri.T100_Rilevatore = 'S');
  cmbCausale.Enabled:=(A000FGestioneTimbraGiustMW.StatoTimb = stInserimento) or (Parametri.T100_Causale = 'S');

  (Self.Parent as TWR104FGestCartellino).VisualizzaJQMessaggio(jQuery,412,302,302, 'Dati Timbratura','#'+Self.Name,False,True);
end;

end.
