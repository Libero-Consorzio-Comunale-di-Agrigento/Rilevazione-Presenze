unit WA034UIntPagheBrowseFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR204UBrowseTabellaFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWCompLabel,
  meIWLabel,WA034UIntPagheDM,A000UInterfaccia, IWCompButton, meIWButton,
  IWCompEdit, DB,A034UIntPagheMW,
  C190FunzioniGeneraliWeb,meIWCheckBox,StrUtils, medpIWMultiColumnComboBox,
  Vcl.Menus;

type
  TWA034FIntPagheBrowseFM = class(TWR204FBrowseTabellaFM)
    lblCampoInterfaccia: TmeIWLabel;
    btnParametriAvanzati: TmeIWButton;
    lblDescInterfaccia: TmeIWLabel;
    cmbInterfaccia: TMedpIWMultiColumnComboBox;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnParametriAvanzatiClick(Sender: TObject);
    procedure cmbInterfacciaChange(Sender: TObject; Index: Integer);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
  private
    { Private declarations }
  public
    procedure CaricaComboInterfaccia;
  end;

implementation uses WA034UIntPaghe;

{$R *.dfm}

procedure TWA034FIntPagheBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  CaricaComboInterfaccia;
  grdTabella.medpRighePagina:=-1;
  grdTabella.medpAggiornaCDS(True);

  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('FLAG'),0,DBG_CHK,'10','','Scaricare','','C');
end;

procedure TWA034FIntPagheBrowseFM.btnParametriAvanzatiClick(Sender: TObject);
begin
  inherited;
  TWA034FIntPaghe(Self.Owner).ParametriAvanzati;
end;

procedure TWA034FIntPagheBrowseFM.CaricaComboInterfaccia;
var
  BM: TBookmark;
  evScroll: TEvDataset;
begin
  with TWA034FIntPagheDM(WR302DM).A034FIntPagheMW.selC9ScaricoPaghe do
  begin
    //il dataset C9 su afterscroll riaggiorna il selT190. quindi rimuovo gli eventi
    //per scorrere il dataset per il caricamento
    BM:=Bookmark;
    evScroll:=AfterScroll;
    AfterScroll:=nil;
    First;
    cmbInterfaccia.Items.Clear;
    while not Eof do
    begin
      cmbInterfaccia.addRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
    goToBookMark(BM);

    cmbInterfaccia.ItemIndex:=-1;
    cmbInterfaccia.Text:=FieldByName('CODICE').AsString;
    if FieldByName('CODICE').AsString = '<INTERFACCIA UNICA>' then
    begin
      cmbInterfaccia.Visible:=False;
      lblCampoInterfaccia.Caption:='';
      lblDescInterfaccia.Caption:=FieldByName('CODICE').AsString;
    end
    else
    begin
      cmbInterfaccia.Visible:=True;
      lblCampoInterfaccia.Caption:=Parametri.CampiRiferimento.C9_ScaricoPaghe + ':';
      lblDescInterfaccia.Caption:=FieldByName('DESCRIZIONE').AsString;
    end;
    AfterScroll:=evScroll;
  end;
end;

procedure TWA034FIntPagheBrowseFM.cmbInterfacciaChange(Sender: TObject;
  Index: Integer);
begin
  inherited;
  with TWA034FIntPagheDM(WR302DM).A034FIntPagheMW.selC9ScaricoPaghe do
  begin
    if not Locate('CODICE',cmbInterfaccia.Text,[]) then
    begin
      //se inserito un valore non presente nella lista. resetto
      First;
      cmbInterfaccia.Text:=FieldByName('CODICE').AsString
    end;
    lblDescInterfaccia.Caption:=FieldByName('DESCRIZIONE').AsString;
  end;

  grdTabella.medpAggiornaCDS(True);
end;

procedure TWA034FIntPagheBrowseFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  with(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('FLAG'),0) as TmeIWCheckBox) do
    grdTabella.medpDataset.FieldByName('FLAG').AsString:=IfThen(Checked,'S','N');
end;

procedure TWA034FIntPagheBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;
  with(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('FLAG'),0) as TmeIWCheckBox) do
  begin
    Checked:=grdTabella.medpValoreColonna(Row,'FLAG') = 'S'
  end;
end;

end.
