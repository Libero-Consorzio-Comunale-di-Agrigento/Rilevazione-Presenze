unit WA047UAccessoManualeFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompButton, meIWButton, IWCompEdit,
  medpIWMultiColumnComboBox, IWCompLabel, meIWLabel, IWCompExtCtrls,
  meIWRadioGroup, A000UCostanti, A000UInterfaccia,medpIWMessageDlg;

type
  TWA047FAccessoManualeFM = class(TWR200FBaseFM)
    btnConferma: TmeIWButton;
    btnChiudi: TmeIWButton;
    lblRilevatore: TmeIWLabel;
    cmbRilevatore: TMedpIWMultiColumnComboBox;
    lblCausale: TmeIWLabel;
    cmbCausale: TMedpIWMultiColumnComboBox;
    lblDescCausale: TmeIWLabel;
    lblDescOrologio: TmeIWLabel;
    rgpPasto: TmeIWRadioGroup;
    lblPasto: TmeIWLabel;
    procedure btnChiudiClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure cmbCausaleAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure cmbRilevatoreAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
  private
    procedure caricaComboCausale;
    procedure ImpostaDescCausale;
    procedure caricaComboRilevatore;
    procedure ImpostaDescRilevatore;
    { Private declarations }
  public
    Data: TDateTime;
    procedure Visualizza;
  end;

implementation
uses WA047UTimbMensa;

{$R *.dfm}

procedure TWA047FAccessoManualeFM.btnChiudiClick(Sender: TObject);
var
  AccessiMensa: TAccessiMensa;
  bConferma: Boolean;
  Msg:String;
begin
  inherited;

  bConferma:=(Sender = btnConferma);

  if bConferma then
  begin
    AccessiMensa.Causale:=cmbCausale.Text;
    if AccessiMensa.Causale = '' then
      AccessiMensa.Causale:='*';

    AccessiMensa.Rilevatore:=cmbRilevatore.Text;
    if rgpPasto.ItemIndex = 0 then
      AccessiMensa.PranzoCena:='P'
    else
      AccessiMensa.PranzoCena:='C';

    AccessiMensa.Accessi:=1;
    with (Self.Parent as TWA047FTimbMensa) do
    begin
      Msg:=WA047FTimbMensaDM.A047FTimbMensaMW.NuovoAccessoManuale(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Data,AccessiMensa);
    end;

    if Msg <> '' then
    begin
      MsgBox.WebMessageDlg(Msg,mtError,[mbOk],nil,'');
      Abort;
    end;
  end;
  (Self.Parent as TWA047FTimbMensa).CaricaGrid;
  ReleaseOggetti;
  Free;
end;

procedure TWA047FAccessoManualeFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  caricaComboCausale;
  caricaComboRilevatore;
end;

procedure TWA047FAccessoManualeFM.caricaComboCausale;
begin
  cmbCausale.Items.Clear;
  with (Self.Parent as TWA047FTimbMensa) do
  begin
    cmbCausale.AddRow('*;Senza causale');
    QCausGiust.First;
    while not QCausGiust.Eof do
    begin
      cmbCausale.AddRow(QCausGiust.FieldByName('CODICE').AsString + ';' + QCausGiust.FieldByName('DESCRIZIONE').AsString);
      QCausGiust.Next;
    end;
  end;
end;

procedure TWA047FAccessoManualeFM.caricaComboRilevatore;
begin
  cmbRilevatore.Items.Clear;
  with (Self.Parent as TWA047FTimbMensa) do
  begin
    QRilevatori.First;
    cmbRilevatore.AddRow(';Senza rilevatore');
    while not QRilevatori.Eof do
    begin
      cmbRilevatore.AddRow(QRilevatori.FieldByName('CODICE').AsString + ';' +  QRilevatori.FieldByName('DESCRIZIONE').AsString);
      QRilevatori.Next;
    end;
  end;
end;

procedure TWA047FAccessoManualeFM.cmbCausaleAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  ImpostaDescCausale;
  ImpostaDescRilevatore;
end;

procedure TWA047FAccessoManualeFM.cmbRilevatoreAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  ImpostaDescRilevatore;
end;

procedure TWA047FAccessoManualeFM.ImpostaDescCausale;
begin
  lblDescCausale.Caption:='';
  if cmbCausale.ItemIndex <> -1 then
    lblDescCausale.Caption:=cmbCausale.Items[cmbCausale.ItemIndex].RowData[1];
end;

procedure TWA047FAccessoManualeFM.ImpostaDescRilevatore;
begin
  lblDescOrologio.Caption:='';
  if cmbRilevatore.ItemIndex <> -1 then
    lblDescOrologio.Caption:=cmbRilevatore.Items[cmbRilevatore.ItemIndex].RowData[1];
end;

procedure TWA047FAccessoManualeFM.Visualizza;
begin
  inherited;
  cmbCausale.Text:='*';
  ImpostaDescCausale;
  cmbRilevatore.Text:='';
  ImpostaDescRilevatore;
  rgpPasto.ItemIndex:=0;
  TWA047FTimbMensa(Self.Parent).VisualizzaJQMessaggio(jQuery,360,200,200, 'Proprietà pasto','#'+Self.Name,False,True);
end;

end.
