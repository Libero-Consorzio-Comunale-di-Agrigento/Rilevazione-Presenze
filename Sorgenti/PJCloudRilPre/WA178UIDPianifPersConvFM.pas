unit WA178UIDPianifPersConvFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, Vcl.Menus, IWCompJQueryWidget, IWVCLComponent, WC013UCheckListFM,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, StrUtils,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  C190FunzioniGeneraliWeb, DB, MedpIWMulticolumnComboBox, meIWLabel, meIWEdit, meIWImageFile, A000UInterfaccia, C180FunzioniGenerali;

type
  TWA178FIDPianifPersConvFM = class(TWR203FGestDetailFM)
    procedure grdTabellaDataSet2Componenti(Row: Integer);
  private
    WC013: TWC013FCheckListFM;
    RowEdit,Col: Integer;
    procedure cmbDescrizioneAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Text: String);
    procedure imgResponsabiliClick(Sender: TObject);
    procedure FiltroRespResult(Sender: TObject; Result: Boolean);
    { Private declarations }
  public
    { Public declarations }
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
  end;

implementation

{$R *.dfm}

uses WA178UPianifPersConvDM;

{ TWA178FIDPianifPersConvFM }

procedure TWA178FIDPianifPersConvFM.CaricaDettaglio(DataSet: TDataSet; DataSource: TDataSource);
begin
  inherited;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('GIORNO'),0,DBG_MECMB,'7','2','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('D_GIORNO'),0,DBG_LBL,'20','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TOLL_DALLE'),0,DBG_EDT,'input_hour_of_day','CAMBIADATO','','','D');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DALLE'),0,DBG_EDT,'input_hour_of_day','CAMBIADATO','','','D');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('ALLE'),0,DBG_EDT,'input_hour_of_day','CAMBIADATO','','','D');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TOLL_ALLE'),0,DBG_EDT,'input_hour_of_day','CAMBIADATO','','','D');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('RESPONSABILE'),0,DBG_MECMB,'7','1','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('STRUTTURA'),0,DBG_MECMB,'7','1','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('RESPONSABILI_CC'),1,DBG_IMG,'','CAMBIADATO','','','D');
end;

procedure TWA178FIDPianifPersConvFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;
  //Caricamento combo GIORNO
  TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_GIORNO'),0)).Caption:=grdTabella.medpValoreColonna(Row,'D_GIORNO');
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('GIORNO'),0) as TMedpIWMultiColumnComboBox) do
  begin
    Tag:=Row;
    Items.Clear;
    AddRow(Format('%s;%s',['1','Lunedì']));
    AddRow(Format('%s;%s',['2','Martedì']));
    AddRow(Format('%s;%s',['3','Mercoledì']));
    AddRow(Format('%s;%s',['4','Giovedì']));
    AddRow(Format('%s;%s',['5','Venerdì']));
    AddRow(Format('%s;%s',['6','Sabato']));
    AddRow(Format('%s;%s',['7','Domenica']));
    Text:=grdTabella.medpValoreColonna(Row,'GIORNO');
    OnAsyncChange:=cmbDescrizioneAsyncChange;
  end;
  //Caricamento combo RESPONSABILE
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('RESPONSABILE'),0) as TMedpIWMultiColumnComboBox) do
  begin
    Tag:=Row;
    Items.Clear;
    with (WR302DM as TWA178FPianifPersConvDM).A178MW.selI095 do
    begin
      First;
      while not Eof do
      begin
        AddRow(FieldByName('COD_ITER').AsString);
        Next;
      end;
    end;
    Text:=grdTabella.medpValoreColonna(Row,'RESPONSABILE');
  end;

  //Caricamento combo STRUTTURA
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('STRUTTURA'),0) as TMedpIWMultiColumnComboBox) do
  begin
    Tag:=Row;
    Items.Clear;
    with (WR302DM as TWA178FPianifPersConvDM).A178MW do
    begin
      if selCdcPersConv.Active then
      begin
        selT421.FieldByName('STRUTTURA').DisplayLabel:=R180Capitalize(Parametri.CampiRiferimento.C13_CdcPersConv);
        selCdcPersConv.First;
        while not selCdcPersConv.Eof do
        begin
          AddRow(selCdcPersConv.FieldByName('CODICE').AsString);
          selCdcPersConv.Next;
        end;
      end;
    end;
    Text:=grdTabella.medpValoreColonna(Row,'STRUTTURA');
  end;

  //Caricamento RESPONSABILI_CC
  TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('RESPONSABILI_CC'),0) as TmeIWEdit).ReadOnly:=True;
  TmeIWImageFile(TmeIWImageFile(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('RESPONSABILI_CC'),1))).OnClick:=imgResponsabiliClick;
end;

procedure TWA178FIDPianifPersConvFM.imgResponsabiliClick(Sender: TObject);
var RespSelezionati:String;
    i:Integer;
    lstResponsabili:TStringList;
begin
  lstResponsabili:=TStringList.Create;
  lstResponsabili.Clear;
  with (WR302DM as TWA178FPianifPersConvDM).A178MW.selI095 do
  begin
    First;
    while not Eof do
    begin
      lstResponsabili.Add(FieldByName('COD_ITER').AsString);
      Next;
    end;
  end;
  RowEdit:=grdTabella.medpRigaDiCompGriglia(TmeIWImageFile(Sender).FriendlyName);
  Col:=grdTabella.medpIndexColonna('RESPONSABILI_CC');
  RespSelezionati:=TmeIWEdit(grdTabella.medpCompCella(RowEdit,Col,0)).Text;
  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  with WC013 do
  begin
    ckList.Items.Assign(lstResponsabili);
    ResultEvent:=FiltroRespResult;
    C190PutCheckList(RespSelezionati,30,ckList);
    WC013.Visualizza(0,0,'Responsabili');
  end;
  FreeAndNil(lstResponsabili);
end;

procedure TWA178FIDPianifPersConvFM.FiltroRespResult(Sender: TObject; Result: Boolean);
begin
  if Result then
  begin
    (WR302DM as TWA178FPianifPersConvDM).A178MW.selT421.FieldByName('RESPONSABILI_CC').AsString:=C190GetCheckList(30,WC013.ckList);
    TmeIWEdit(grdTabella.medpCompCella(RowEdit,Col,0)).Text:=(WR302DM as TWA178FPianifPersConvDM).A178MW.selT421.FieldByName('RESPONSABILI_CC').AsString;
  end;
end;

procedure TWA178FIDPianifPersConvFM.cmbDescrizioneAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Text:String);
var r:Integer;
begin
  inherited;
  with (Sender as TMedpIWMultiColumnComboBox) do
  begin
    r:=grdTabella.medpRigaDiCompGriglia(FriendlyName);
    TmeIWLabel(grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('D_GIORNO'),0)).Caption:=Items[Index].RowData[1];
  end;
end;

end.
