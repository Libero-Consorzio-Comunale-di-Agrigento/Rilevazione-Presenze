unit WA042UImpostazioniProspettoFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompButton, meIWButton, IWCompLabel, meIWLabel, IWCompEdit, meIWEdit, IWCompRadioButton, meIWRadioButton;

type
  TWA042FImpostazioniProspettoFM = class(TWR200FBaseFM)
    btnChiudi: TmeIWButton;
    lblLimite1: TmeIWLabel;
    edtLimite1: TmeIWEdit;
    edtLimite2: TmeIWEdit;
    lblLimite2: TmeIWLabel;
    rbtGiornata1: TmeIWRadioButton;
    rbtIntervallo1: TmeIWRadioButton;
    rbtIntervallo2: TmeIWRadioButton;
    rbtGiornata2: TmeIWRadioButton;
    btnConferma: TmeIWButton;
    procedure btnChiudiClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Visualizza;
  end;

implementation

uses WR100UBase, WA042UStampaPreAss;

{$R *.dfm}

procedure TWA042FImpostazioniProspettoFM.btnChiudiClick(Sender: TObject);
begin
  inherited;
  if Sender = btnConferma then
  begin
    with (Self.Owner as TWA042FStampaPreAss) do
    begin
      try
        A042MW.tPb_Limite1:=StrToTime(edtLimite1.Text);
      except
        raise exception.Create(edtLimite1.Text + ' non è un''ora valida.');
      end;
      A042MW.bPb_Intervallo1:=RbtIntervallo1.Checked;
      A042MW.bPb_Giornata1:=RbtGiornata1.Checked;
      try
        A042MW.tPb_Limite2:=StrToTime(edtLimite2.Text);
      except
        raise exception.Create(edtLimite2.Text + ' non è un''ora valida.');
      end;
      A042MW.bPb_Intervallo2:=RbtIntervallo2.Checked;
      A042MW.bPb_Giornata2:=RbtGiornata2.Checked;
    end;
  end;
  ReleaseOggetti;
  Free;
end;

procedure TWA042FImpostazioniProspettoFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  with (Self.Owner as TWA042FStampaPreAss) do
  begin
    edtLimite1.Text:=FormatDateTime('hh.nn',A042MW.tPb_Limite1);
    RbtIntervallo1.Checked:=A042MW.bPb_Intervallo1;
    RbtGiornata1.Checked:=A042MW.bPb_Giornata1;
    edtLimite2.Text:=FormatDateTime('hh.nn',A042MW.tPb_Limite2);
    RbtIntervallo2.Checked:=A042MW.bPb_Intervallo2;
    RbtGiornata2.Checked:=A042MW.bPb_Giornata2;
  end;
end;

procedure TWA042FImpostazioniProspettoFM.Visualizza;
begin
  TWR100FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,370,350,350,'(WA042) Impostazioni prospetto ore lavorate','#WA042_ImpostazioniProspetto',False,True);
end;

end.
