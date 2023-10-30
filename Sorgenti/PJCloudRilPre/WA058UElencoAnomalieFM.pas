unit WA058UElencoAnomalieFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompGrids, meIWGrid, IWCompLabel, meIWLabel, C190FunzioniGeneraliWeb,
  IWCompButton, meIWButton, IWDBGrids, meIWDBGrid, A058UPianifTurniDtM1,
  medpIWDBGrid;

type
  TWA058FElencoAnomalieFM = class(TWR200FBaseFM)
    btnChiudi: TmeIWButton;
    grdAnomalie: TmedpIWDBGrid;
    procedure btnChiudiClick(Sender: TObject);
  private
    { Private declarations }
  public
    A058FPianifTurniDtM1:TA058FPianifTurniDtM1;
    constructor Create(AOwner: TComponent;A058DM:TA058FPianifTurniDtM1); overload;
    procedure Visualizza;
  end;

implementation

uses A000UInterfaccia, WR010UBase;

constructor TWA058FElencoAnomalieFM.Create(AOwner: TComponent;A058DM:TA058FPianifTurniDtM1);
begin
  inherited Create(AOwner);
  Self.A058FPianifTurniDtM1:=A058DM;
  Self.grdAnomalie.medpPaginazione:=False;
  Self.grdAnomalie.medpDataSet:=Self.A058FPianifTurniDtM1.selAnomalie;
end;

procedure TWA058FElencoAnomalieFM.btnChiudiClick(Sender: TObject);
begin
  Self.Free;
end;

procedure TWA058FElencoAnomalieFM.Visualizza;
begin
  Self.A058FPianifTurniDtM1.selAnomalie.Close;
  Self.A058FPianifTurniDtM1.selAnomalie.ClearVariables;
  Self.A058FPianifTurniDtM1.selAnomalie.SetVariable('AZIENDA',Parametri.Azienda);
  Self.A058FPianifTurniDtM1.selAnomalie.SetVariable('OPERATORE',Parametri.Operatore);
  Self.A058FPianifTurniDtM1.selAnomalie.SetVariable('DATA_ELAB',Date);
  Self.A058FPianifTurniDtM1.selAnomalie.SetVariable('ID_MESSAGGI', RegistraMsg.ID);
  Self.A058FPianifTurniDtM1.selAnomalie.Open;
  Self.grdAnomalie.medpAttivaGrid(Self.A058FPianifTurniDtM1.selAnomalie,False,False,False);
  (Self.Parent as TWR010FBase).VisualizzajQMessaggio(JQuery, 1200, -1,EM2PIXEL * 50,
                                                     'Elenco anomalie', '#WA058_ElencoAnomalie', False, True);
end;

{$R *.dfm}

end.
