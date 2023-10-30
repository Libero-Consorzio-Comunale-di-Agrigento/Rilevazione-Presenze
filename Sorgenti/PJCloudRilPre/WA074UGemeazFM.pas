unit WA074UGemeazFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWCompEdit, meIWEdit, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel,
  IWCompListbox, meIWComboBox, IWCompButton, meIWButton,WR100UBase,
  IWCompCheckbox, meIWCheckBox, IWCompExtCtrls, meIWRadioGroup;

type
  TParametriGemeaz = record
    CodiceCliente : String;
    ValoreBuono   : String;
    SiglaTestata  : String;
    TipoFile      : Integer;
    FormatoMatricola: String;
    Ticket        : Boolean;
    BuoniPasto    : Boolean;
  end;

  TWA074ModalResultEvents = procedure(ParametriGemeaz: TParametriGemeaz) of object;

  TWA074FGemeazFM = class(TWR200FBaseFM)
    lblCodCliente: TmeIWLabel;
    edtCodCliente: TmeIWEdit;
    lblValoreBuono: TmeIWLabel;
    edtValoreBuono: TmeIWEdit;
    lblFormatoMatricola: TmeIWLabel;
    cmbFormatoMatricola: TmeIWComboBox;
    btnChiudi: TmeIWButton;
    lblSiglaTestata: TmeIWLabel;
    edtSiglaTestata: TmeIWEdit;
    chkTicket: TmeIWCheckBox;
    chkBuoniPasto: TmeIWCheckBox;
    lblDati: TmeIWLabel;
    rgpTipoFile: TmeIWRadioGroup;
    lblTipoFile: TmeIWLabel;
    lblNomeFile: TmeIWLabel;
    edtNomeFile: TmeIWEdit;
    btnConferma: TmeIWButton;
    procedure btnChiudiClick(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
  private
    { Private declarations }
  public
    ModalResult: TWA074ModalResultEvents;
    procedure Visualizza(ParametriGemeaz: TParametriGemeaz);
  end;

implementation

{$R *.dfm}

{ TWA074FGemeazFM }

procedure TWA074FGemeazFM.btnChiudiClick(Sender: TObject);
begin
  ReleaseOggetti;
  Free;
end;

procedure TWA074FGemeazFM.btnConfermaClick(Sender: TObject);
var
  ParametriGemeaz: TParametriGemeaz;
begin
  inherited;
  with ParametriGemeaz do
  begin
    CodiceCliente:=edtCodCliente.Text;
    ValoreBuono:=edtValoreBuono.Text;
    FormatoMatricola:=cmbFormatoMatricola.Text;
    SiglaTestata:=edtSiglaTestata.Text;
    Ticket:=chkTicket.Checked;
    BuoniPasto:=chkBuoniPasto.Checked;
    TipoFile:=rgpTipoFile.ItemIndex;
  end;
  if Assigned(ModalResult) then
    ModalResult(ParametriGemeaz);
  btnChiudiClick(nil);
end;

procedure TWA074FGemeazFM.Visualizza(ParametriGemeaz: TParametriGemeaz);
begin
  with ParametriGemeaz do
  begin
    edtCodCliente.Text:=CodiceCliente;
    edtValoreBuono.Text:=ValoreBuono;
    cmbFormatoMatricola.Text:=FormatoMatricola;
    edtSiglaTestata.Text:=SiglaTestata;
    chkTicket.Checked:=Ticket;
    chkBuoniPasto.Checked:=BuoniPasto;
    rgpTipoFile.ItemIndex:=TipoFile;
  end;

  TWR100FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,350,380,380,'Dati per gemeaz','#WA074FGemeazFM',False,True);
end;

end.
