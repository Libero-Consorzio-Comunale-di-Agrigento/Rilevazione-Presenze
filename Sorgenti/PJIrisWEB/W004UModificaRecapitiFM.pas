unit W004UModificaRecapitiFM;

interface

uses
  SysUtils, Classes, Controls, Forms, StrUtils, Math,
  IWVCLBaseContainer, IWColor, IWContainer, IWRegion, IWHTMLContainer,
  IWHTML40Container, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompJQueryWidget, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWLabel, R010UPaginaWeb, C190FunzioniGeneraliWeb,
  IWCompButton, meIWButton, IWCompEdit, meIWEdit, medpIWMultiColumnComboBox;

type
  TW004FModificaRecapitiFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    IWTemplateProcessorFrame: TIWTemplateProcessorHTML;
    jQVisFrame: TIWJQueryWidget;
    lblT1: TmeIWLabel;
    lblT2: TmeIWLabel;
    lblT3: TmeIWLabel;
    btnAnnulla: TmeIWButton;
    edtRecapitoT1: TmeIWEdit;
    edtRecapitoT2: TmeIWEdit;
    edtRecapitoT3: TmeIWEdit;
    btnOK: TmeIWButton;
    lblRecapito: TmeIWLabel;
    cmbDatoAgg1T1: TMedpIWMultiColumnComboBox;
    cmbDatoAgg1T2: TMedpIWMultiColumnComboBox;
    cmbDatoAgg1T3: TMedpIWMultiColumnComboBox;
    lblDatoAgg1: TmeIWLabel;
    lblDatoAgg2: TmeIWLabel;
    cmbDatoAgg2T1: TMedpIWMultiColumnComboBox;
    cmbDatoAgg2T2: TMedpIWMultiColumnComboBox;
    cmbDatoAgg2T3: TMedpIWMultiColumnComboBox;
    lblAreeTurni: TmeIWLabel;
    cmbAreaSquadraT1: TMedpIWMultiColumnComboBox;
    cmbAreaSquadraT2: TMedpIWMultiColumnComboBox;
    cmbAreaSquadraT3: TMedpIWMultiColumnComboBox;
    procedure cmbDatoAgg1T1AsyncDoubleClick(Sender: TObject; EventParams: TStringList);
    procedure cmbDatoAgg2T1AsyncDoubleClick(Sender: TObject; EventParams: TStringList);
    procedure btnAnnullaClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    Modificato:Boolean;
    CodT1,CodT2,CodT3,
    RecapitoT1,RecapitoT2,RecapitoT3,
    DatoAgg1T1,DatoAgg1T2,DatoAgg1T3,
    DatoAgg2T1,DatoAgg2T2,DatoAgg2T3,
    DatoAgg1Ana,DatoAgg2Ana,
    DatoAreaSquadraT1,DatoAreaSquadraT2,DatoAreaSquadraT3 :String;
    RecT1Attivo,RecT2Attivo,RecT3Attivo:Boolean;
    constructor Create(AOwner:TComponent); override;
    procedure Visualizza;
  end;

implementation

{$R *.dfm}

{ TW004FModificaRecapitiFM }
constructor TW004FModificaRecapitiFM.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  lblDatoAgg1.Caption:='';
  lblDatoAgg2.Caption:='';
  lblAreeTurni.Caption:='';
  RecT1Attivo:=False;
  RecT2Attivo:=False;
  RecT3Attivo:=False;
  Modificato:=False;
end;

procedure TW004FModificaRecapitiFM.Visualizza;
begin
  lblT1.Enabled:=RecT1Attivo;
  if CodT1 <> '' then
    lblT1.Caption:=Copy(lblT1.Caption,1,Length(lblT1.Caption) - 1) + CodT1;
  edtRecapitoT1.Enabled:=lblT1.Enabled;
  cmbDatoAgg1T1.Enabled:=lblT1.Enabled;
  cmbDatoAgg2T1.Enabled:=lblT1.Enabled;
  cmbAreaSquadraT1.Enabled:=lblT1.Enabled;
  edtRecapitoT1.Text:=RecapitoT1;
  cmbDatoAgg1T1.Text:=DatoAgg1T1;
  cmbDatoAgg2T1.Text:=DatoAgg2T1;
  cmbAreaSquadraT1.Text:=DatoAreaSquadraT1;


  lblT2.Enabled:=RecT2Attivo;
  if CodT2 <> '' then
    lblT2.Caption:=Copy(lblT2.Caption,1,Length(lblT2.Caption) - 1) + CodT2;
  edtRecapitoT2.Enabled:=lblT2.Enabled;
  cmbDatoAgg1T2.Enabled:=lblT2.Enabled;
  cmbDatoAgg2T2.Enabled:=lblT2.Enabled;
  cmbAreaSquadraT2.Enabled:=lblT2.Enabled;
  edtRecapitoT2.Text:=RecapitoT2;
  cmbDatoAgg1T2.Text:=DatoAgg1T2;
  cmbDatoAgg2T2.Text:=DatoAgg2T2;
  cmbAreaSquadraT2.Text:=DatoAreaSquadraT2;

  lblT3.Enabled:=RecT3Attivo;
  if CodT3 <> '' then
    lblT3.Caption:=Copy(lblT3.Caption,1,Length(lblT3.Caption) - 1) + CodT3;
  edtRecapitoT3.Enabled:=lblT3.Enabled;
  cmbDatoAgg1T3.Enabled:=lblT3.Enabled;
  cmbDatoAgg2T3.Enabled:=lblT3.Enabled;
  cmbAreaSquadraT3.Enabled:=lblT3.Enabled;
  edtRecapitoT3.Text:=RecapitoT3;
  cmbDatoAgg1T3.Text:=DatoAgg1T3;
  cmbDatoAgg2T3.Text:=DatoAgg2T3;
  cmbAreaSquadraT3.Text:=DatoAreaSquadraT3;

  if lblDatoAgg1.Caption = '' then
  begin
    cmbDatoAgg1T1.Css:='invisibile';
    cmbDatoAgg1T2.Css:='invisibile';
    cmbDatoAgg1T3.Css:='invisibile';
  end;
  if lblDatoAgg2.Caption = '' then
  begin
    cmbDatoAgg2T1.Css:='invisibile';
    cmbDatoAgg2T2.Css:='invisibile';
    cmbDatoAgg2T3.Css:='invisibile';
  end;

  if lblAreeTurni.Caption = '' then
  begin
    cmbAreaSquadraT1.Css:='invisibile';
    cmbAreaSquadraT2.Css:='invisibile';
    cmbAreaSquadraT3.Css:='invisibile';
  end;

  (Self.Parent as TR010FPaginaWeb).VisualizzajQMessaggio(jQVisFrame,IfThen(lblAreeTurni.Caption <> '',987,IfThen(lblDatoAgg2.Caption <> '',837,IfThen(lblDatoAgg1.Caption <> '',650,433))),170,EM2PIXEL * 1,'Modifica ' + IfThen((lblDatoAgg1.Caption <> '') or (lblAreeTurni.Caption <> ''),'informazioni aggiuntive','recapiti alternativi'),'#' + Name,False,False);
end;

procedure TW004FModificaRecapitiFM.cmbDatoAgg1T1AsyncDoubleClick(Sender: TObject; EventParams: TStringList);
begin
  (Sender as TMedpIWMultiColumnComboBox).Text:=DatoAgg1Ana;
end;

procedure TW004FModificaRecapitiFM.cmbDatoAgg2T1AsyncDoubleClick(Sender: TObject; EventParams: TStringList);
begin
  (Sender as TMedpIWMultiColumnComboBox).Text:=DatoAgg2Ana;
end;

procedure TW004FModificaRecapitiFM.btnAnnullaClick(Sender: TObject);
begin
  Self.Free;
end;

procedure TW004FModificaRecapitiFM.btnOKClick(Sender: TObject);
begin
  Modificato:=True;
  RecapitoT1:=Trim(edtRecapitoT1.Text);
  RecapitoT2:=Trim(edtRecapitoT2.Text);
  RecapitoT3:=Trim(edtRecapitoT3.Text);
  DatoAgg1T1:=Trim(cmbDatoAgg1T1.Text);
  DatoAgg1T2:=Trim(cmbDatoAgg1T2.Text);
  DatoAgg1T3:=Trim(cmbDatoAgg1T3.Text);
  DatoAgg2T1:=Trim(cmbDatoAgg2T1.Text);
  DatoAgg2T2:=Trim(cmbDatoAgg2T2.Text);
  DatoAgg2T3:=Trim(cmbDatoAgg2T3.Text);
  DatoAreaSquadraT1:=Trim(cmbAreaSquadraT1.Text);
  DatoAreaSquadraT2:=Trim(cmbAreaSquadraT2.Text);
  DatoAreaSquadraT3:=Trim(cmbAreaSquadraT3.Text);
  Self.Free;
end;

end.
