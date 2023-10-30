unit WA024UIndPresenzaIndennitaFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR203UGestDetailFM, ActnList, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWDBGrids, medpIWDBGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, meIWGrid,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  C190FunzioniGeneraliWeb, meIWLabel, meIWImageFile,
  A000UInterfaccia, OracleData, Db, meIWEdit, medpIWMessageDlg, Math,
  MedpIWMultiColumnComboBox, IWCompJQueryWidget, IWCompGrids,
  IWCompListbox, WA089URegIndPresenza,C180FunzioniGenerali, System.Actions,
  Vcl.Menus;

type
  TWA024FIndPresenzaIndennitaFM = class(TWR203FGestDetailFM)
    procedure grdTabellaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
  private
    { Private declarations }
    procedure imgAccediClick(Sender: TObject);
    procedure cmbDescrizioneAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Text:String);
  public
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
  end;

implementation

uses WA024UIndPResenzaDM, WA024UIndPresenza, WR100UBase;

{$R *.dfm}

procedure TWA024FIndPresenzaIndennitaFM.CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource);
begin
  grdTabella.medpComandiCustom:=True;
  inherited;
  grdTabella.medpPreparaComponenteGenerico('WR102-R',grdTabella.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','ACCEDI','','','');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('Indennita'),0,DBG_MECMB,'10','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('D_Indennita'),0,DBG_LBL,'20','','null','','S');
  grdTabella.medpCaricaCDS;
end;

procedure TWA024FIndPresenzaIndennitaFM.grdTabellaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var r : Integer;
    img : TmeIWImageFile;
begin
  inherited;
  for r := 1 to High(grdTabella.medpCompGriglia) do
  if grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('DBG_COMANDI'),0) <> nil then
  begin
    img:=TmeIWImageFile(grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('DBG_COMANDI'),0));
    img.OnClick:=imgAccediClick;
  end;
end;

procedure TWA024FIndPresenzaIndennitaFM.grdTabellaComponenti2DataSet(Row: Integer);
var i:integer;
begin
  inherited;
  grdTabella.medpDataSet.FieldByName('Codice').AsString:=TWA024FIndPresenzaDM(TWA024FIndPresenza(Self.Parent).WR302DM).selTabella.FieldByNamE('CODICE').AsString;
end;

procedure TWA024FIndPresenzaIndennitaFM.grdTabellaDataSet2Componenti(Row: Integer);
var
  desc : String;
begin
  inherited;
  TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_Indennita'),0)).Caption:=grdTabella.medpValoreColonna(Row,'D_indennita');
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('Indennita'),0) as TMedpIWMultiColumnComboBox) do
  begin
    PopUpHeight:=10;
    Items.Clear;
    TWA024FIndPresenzaDM(WR302DM).Q162.First;
    while not TWA024FIndPresenzaDM(WR302DM).Q162.Eof do
    begin
      desc:=TWA024FIndPresenzaDM(WR302DM).Q162.FieldByName('DESCRIZIONE').AsString;
      if desc = '' then
        desc:='vuoto';
      AddRow(TWA024FIndPresenzaDM(WR302DM).Q162.FieldByName('CODICE').AsString+ ';' +desc);
      TWA024FIndPresenzaDM(WR302DM).Q162.Next;
    end;
    Text:=grdTabella.medpValoreColonna(Row, 'Indennita');
    OnAsyncChange:=cmbDescrizioneAsyncChange;
  end;
end;

procedure TWA024FIndPresenzaIndennitaFM.imgAccediClick(Sender: TObject);
var
  Codice : String;
  r      : Integer;
begin
  r:=grdTabella.medpRigaDiCompGriglia(TmeIWImageFile(Sender).FriendlyName);
  if grdTabella.medpDataSet.State = dsBrowse then
    codice:=grdTabella.medpValoreColonna(r, 'Indennita')
  else
    codice:=(grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('Indennita'),0) as TMedpIWMultiColumnComboBox).Text;
  TWA024FIndPresenza(Self.Parent).AccediForm(117,'CODICE='+ codice);
end;

procedure TWA024FIndPresenzaIndennitaFM.cmbDescrizioneAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Text:String);
var
  r:Integer;
begin
  inherited;
  with (Sender as TMedpIWMultiColumnComboBox) do
  begin
    r:=grdTabella.medpRigaDiCompGriglia(FriendlyName);
    TmeIWLabel(grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('D_Indennita'),0)).Caption:=Items[Index].RowData[1];
  end;
end;

end.
