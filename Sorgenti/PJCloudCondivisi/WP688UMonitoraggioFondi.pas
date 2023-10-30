unit WP688UMonitoraggioFondi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR100UBase, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, medpIWStatusBar, IWCompEdit, meIWEdit, IWCompGrids,
  meIWGrid, IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, WP688UMonitoraggioFondiDM,
  IWCompLabel, meIWLabel, IWDBGrids, medpIWDBGrid, meIWRadioGroup,
  C180FunzioniGenerali, A000UInterfaccia, A000UMessaggi, IWApplication,
  Vcl.Menus;

type
  TWP688FMonitoraggioFondi = class(TWR100FBase)
    lblDecorrenzaDa: TmeIWLabel;
    edtDecorrenzaDa: TmeIWEdit;
    lblDecorrenzaA: TmeIWLabel;
    edtDecorrenzaA: TmeIWEdit;
    grdFondi: TmedpIWDBGrid;
    lblVisualizzazione: TmeIWLabel;
    lblTipoTotalizzazione: TmeIWLabel;
    rgpTipoTotalizzazione: TmeIWRadioGroup;
    btnDate: TmeIWButton;
    btnInviaFile: TmeIWButton;
    pmnGrdTabella: TPopupMenu;
    CopiaInExcel: TMenuItem;
    CopiaInCSV: TMenuItem;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure edtDecorrenzaDaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure edtDecorrenzaAAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnDateClick(Sender: TObject);
    procedure rgpTipoTotalizzazioneClick(Sender: TObject);
    procedure CopiaInExcelClick(Sender: TObject);
    procedure CopiaInCSVClick(Sender: TObject);
  private
    { Private declarations }
    WP688FMonitoraggioFondiDM: TWP688FMonitoraggioFondiDM;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure Aggiorna;
    procedure ForzaSubmit();
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWP688FMonitoraggioFondi.IWAppFormCreate(Sender: TObject);
begin
  inherited;

  WP688FMonitoraggioFondiDM:=TWP688FMonitoraggioFondiDM.Create(Self);
  grdFondi.DataSource:=WP688FMonitoraggioFondiDM.P688FMonitoraggioFondiMW.dsrDati;
  GetParametriFunzione;
  Aggiorna;
end;

procedure TWP688FMonitoraggioFondi.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  FreeAndNil(WP688FMonitoraggioFondiDM);
  inherited;
end;

procedure TWP688FMonitoraggioFondi.GetParametriFunzione;
begin
  edtDecorrenzaDa.Text:=C004DM.GetParametro('edtDecorrenzaDa','01/01/' + IntToStr(R180Anno(Parametri.DataLavoro)));
  edtDecorrenzaA.Text:=C004DM.GetParametro('edtDecorrenzaA','31/12/' + IntToStr(R180Anno(Parametri.DataLavoro)));
end;

procedure TWP688FMonitoraggioFondi.PutParametriFunzione;
var Data: TDateTime;
begin
  C004DM.Cancella001;
  if TryStrToDate(edtDecorrenzaDa.Text,Data) then
    C004DM.PutParametro('edtDecorrenzaDa',edtDecorrenzaDa.Text);
  if TryStrToDate(edtDecorrenzaA.Text,Data) then
    C004DM.PutParametro('edtDecorrenzaA',edtDecorrenzaA.Text);

  try SessioneOracle.Commit; except end;
end;

procedure TWP688FMonitoraggioFondi.edtDecorrenzaDaAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  ForzaSubmit;
end;

procedure TWP688FMonitoraggioFondi.edtDecorrenzaAAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  ForzaSubmit;
end;

procedure TWP688FMonitoraggioFondi.btnDateClick(Sender: TObject);
begin
  Aggiorna;
end;

procedure TWP688FMonitoraggioFondi.rgpTipoTotalizzazioneClick(Sender: TObject);
begin
  inherited;
  Aggiorna;
end;

procedure TWP688FMonitoraggioFondi.Aggiorna;
var Data: TDateTime;
begin
  if not TryStrToDate(edtDecorrenzaDa.Text,Data) then
    raise exception.Create(A000MSG_ERR_DATA_DECORRENZA);
  if not TryStrToDate(edtDecorrenzaA.Text,Data) then
    raise exception.Create(A000MSG_ERR_DATA_SCADENZA);
  if StrToDate(edtDecorrenzaA.Text) < StrToDate(edtDecorrenzaDa.Text) then
    raise exception.Create(A000MSG_ERR_DECORR_NON_SUCC_SCAD);
  WP688FMonitoraggioFondiDM.P688FMonitoraggioFondiMW.LetturaFondi(edtDecorrenzaDa.Text,edtDecorrenzaA.Text,rgpTipoTotalizzazione.ItemIndex);
  grdFondi.medpAttivaGrid(WP688FMonitoraggioFondiDM.P688FMonitoraggioFondiMW.cdsDati,False,False,False);
end;

procedure TWP688FMonitoraggioFondi.ForzaSubmit();
begin
  //Forzo un submit che richiama il click di un pulsante nascosto, così la maschera si riaggiorna
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnDate.HTMLName]));
end;

procedure TWP688FMonitoraggioFondi.CopiaInExcelClick(Sender: TObject);
var
  nFileXls: String;
begin
  if not Assigned(Sender) then
    streamDownload:=grdFondi.ToXlsx
  else
  begin
    nFileXls:='MonitoraggioFondi_Dal_' + edtDecorrenzaDa.Text + '_Al_' + edtDecorrenzaA.Text  + '.xlsx';
    nFileXls:=nFileXls.Replace('\','_').Replace('/','_');
    InviaFile(nFileXls,streamDownload);
  end;
end;

procedure TWP688FMonitoraggioFondi.CopiaInCSVClick(Sender: TObject);
var
  nFileXls: String;
begin
  if not Assigned(Sender) then
    csvDownload:=grdFondi.ToCsv
  else
  begin
    nFileXls:='MonitoraggioFondi_Dal_' + edtDecorrenzaDa.Text + '_Al_' + edtDecorrenzaA.Text  + '.xls';
    nFileXls:=nFileXls.Replace('\','_').Replace('/','_');
    InviaFile(nFileXls,csvDownload);
  end;
end;

end.
