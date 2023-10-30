unit WA199UCheckRimborsiBrowseFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR204UBrowseTabellaFM, Vcl.Menus,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids,
  IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWAdvRadioGroup, meTIWAdvRadioGroup, IWCompEdit,
  meIWEdit, IWCompLabel, meIWLabel;

type
  TWA199FCheckRimborsiBrowseFM = class(TWR204FBrowseTabellaFM)
    lblPeriodoDal: TmeIWLabel;
    edtPeriodoDal: TmeIWEdit;
    lblPeriodoAl: TmeIWLabel;
    edtPeriodoAl: TmeIWEdit;
    rgpRimborsi: TmeTIWAdvRadioGroup;
    rgpStato: TmeTIWAdvRadioGroup;
    lblPeriodo: TmeIWLabel;
    procedure rgpRimborsiClick(Sender: TObject);
    procedure rgpStatoClick(Sender: TObject);
  public
    procedure FiltraMissioni;
    procedure AbilitazioneFiltri;
  end;

implementation

uses WA199UCheckRimborsi, WA199UCheckRimborsiDM;

{$R *.dfm}

procedure TWA199FCheckRimborsiBrowseFM.FiltraMissioni;
// applica i filtri sul dataset master delle missioni in base ai valori
// presenti sull'interfaccia
begin
  ((Self.Owner as TWA199FCheckRimborsi).WR302DM as TWA199FCheckRimborsiDM).A100FCheckRimborsiMW.FiltraMissioni(edtPeriodoDal.Text,edtPeriodoAl.Text,rgpRimborsi.ItemIndex,rgpStato.ItemIndex);
  grdTabella.medpCaricaCDS;
end;

procedure TWA199FCheckRimborsiBrowseFM.rgpRimborsiClick(Sender: TObject);
begin
  AbilitazioneFiltri;
  FiltraMissioni;
end;

procedure TWA199FCheckRimborsiBrowseFM.rgpStatoClick(Sender: TObject);
begin
  FiltraMissioni;
end;

procedure TWA199FCheckRimborsiBrowseFM.AbilitazioneFiltri;
begin
  rgpStato.Enabled:=rgpRimborsi.ItemIndex <> 1;
  if not rgpStato.Enabled then
  begin
    rgpStato.OnClick:=nil;
    rgpStato.ItemIndex:=0;
    rgpStato.OnClick:=rgpStatoClick;
  end;
end;

end.
