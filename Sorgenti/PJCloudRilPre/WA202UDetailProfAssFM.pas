unit WA202UDetailProfAssFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions, Vcl.ActnList, Vcl.Menus, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion,
  meIWComboBox, meIWLabel, IWCompEdit, medpIWMultiColumnComboBox, meIWButton, meIWEdit, medpIWMessageDlg,
  A000UMessaggi, A000UInterfaccia, A000UCostanti, IWCompButton, IWCompLabel;

type
  TWA202FDetailProfAssFM = class(TWR203FGestDetailFM)
    lblGG: TmeIWLabel;
    edtGG: TmeIWEdit;
    edtScadenza: TmeIWEdit;
    lblScadenza: TmeIWLabel;
    lblDecorrenza: TmeIWLabel;
    edtDecorrenza: TmeIWEdit;
    edtFine: TmeIWEdit;
    lblFine: TmeIWLabel;
    lblPAssenze: TmeIWLabel;
    cmbPAssenze: TMedpIWMultiColumnComboBox;
    lblDescrizione: TmeIWLabel;
    btnApplica: TmeIWButton;
    procedure cmbPAssenzeAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure btnApplicaClick(Sender: TObject);
    procedure EseguiStoricizzazione(Sender: TObject; R: TmeIWModalResult; KI: String);
  private
    { Private declarations }

  public
    { Public declarations }
    EseguiStoricizzazionePA: procedure(pDataI: TDateTime; pDataF: TDateTime; pAssenze: string) of object;
    procedure InibisciCampi;
  end;

implementation

{$R *.dfm}

procedure TWA202FDetailProfAssFM.btnApplicaClick(Sender: TObject);
var DataI, DataF: TDateTime;
begin
  inherited;
  if cmbPAssenze.Text.IsEmpty then
    raise Exception.Create(A000MSG_MSG_SEL_PROFILO);

  if not TryStrToDate(edtDecorrenza.Text, DataI) then
    raise Exception.Create(A000MSG_ERR_DATA_DECORRENZA);
  if not TryStrToDate(edtFine.Text,DataF) then
    raise Exception.Create(A000MSG_ERR_DATA_SCADENZA);

  if DataI > DataF then
    raise Exception.Create(A000MSG_ERR_DECOR_SUP_SCAD);

  MsgBox.WebMessageDlg(A000MSG_A202_MSG_CONFERMA_STORICIZZ,mtConfirmation,[mbYes,mbNo],EseguiStoricizzazione,'');
end;

procedure TWA202FDetailProfAssFM.cmbPAssenzeAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  lblDescrizione.Caption:=cmbPAssenze.Items[Index].RowData[1];
end;

procedure TWA202FDetailProfAssFM.InibisciCampi;
{Inibisce campi per storicizzazione}
begin
  cmbPAssenze.Enabled:=False;
  cmbPAssenze.ItemIndex:=-1;
  lblDescrizione.Caption:='';
  edtDecorrenza.Enabled:=False;
  edtFine.Enabled:=False;
  edtScadenza.Text:='';
  edtGG.Text:='';
  edtDecorrenza.Text:='';
  edtFine.Text:='';
  btnApplica.Enabled:=False;
end;

//  CONTROLLI PASSENZE
procedure TWA202FDetailProfAssFM.EseguiStoricizzazione(Sender: TObject; R: TmeIWModalResult; KI: String);
var DataI, DataF: TDateTime;
begin
  if R = mrNo then
    exit;
  try
    DataI:=StrToDate(edtDecorrenza.Text);
    DataF:=StrToDate(edtFine.Text);
    EseguiStoricizzazionePA(DataI, DataF, cmbPAssenze.Text);

  except
    on E:Exception do
      raise Exception.Create(A000MSG_ERR_OPERAZIONE_NON_ESEGUITA + CRLF + E.Message);
  end;
end;

end.
