unit WA123UPartecipazioniSindacatiBrowseFM;

interface

uses
  Winapi.Windows, StrUtils, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR204UBrowseTabellaFM,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, OracleData,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids,
  IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, medpIWMultiColumnComboBox, C190FunzioniGeneraliWeb,
  meIWLabel, meIWImageFile, meIWEdit, A000UCostanti, Vcl.Menus;

type
  TWA123FPartecipazioniSindacatiBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure grdTabellaComponenti2DataSet(Row: Integer);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    procedure imgAccediClick(Sender: TObject);
    procedure CodAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure CodOrgAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure dataAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure cmbRefresh;
  public
    { Public declarations }
  end;

implementation

uses WA123UPartecipazioniSindacati, WA123UPartecipazioniSindacatiDM;

{$R *.dfm}

procedure TWA123FPartecipazioniSindacatiBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('COD_SINDACATO'),0,DBG_MECMB,'5','1','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('COD_SINDACATO'),1,DBG_IMG,'','ACCEDI','','','');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DESC_SINDACATO'),0,DBG_LBL,'20','1','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('COD_ORGANISMO'),0,DBG_MECMB,'5','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DESC_ORGANISMO'),0,DBG_LBL,'20','1','null','','S');
end;

procedure TWA123FPartecipazioniSindacatiBrowseFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  with (WR302DM as TWA123FPartecipazioniSindacatiDM).SelTabella do
  begin
    FieldByName('COD_SINDACATO').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_SINDACATO'),0) as TmedpIWMultiColumnComboBox).Text;
    FieldByName('COD_ORGANISMO').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_ORGANISMO'),0) as TmedpIWMultiColumnComboBox).Text;
  end;
end;

procedure TWA123FPartecipazioniSindacatiBrowseFM.dataAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  if (grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('DADATA'),0) as TmeIWEdit).Text <> '' then
  begin
   (WR302DM as TWA123FPartecipazioniSindacatiDM).A123MW.selT247.FieldByName('DADATA').AsDateTime:=StrToDateTime((grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('DADATA'),0) as TmeIWEdit).Text);
   (WR302DM as TWA123FPartecipazioniSindacatiDM).selTabellaDADATAValidate(nil);
  end;

  if (grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('ADATA'),0) as TmeIWEdit).Text <> '' then
  begin
   (WR302DM as TWA123FPartecipazioniSindacatiDM).A123MW.selT247.FieldByName('ADATA').AsDateTime:=StrToDateTime((grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('ADATA'),0) as TmeIWEdit).Text);
   (WR302DM as TWA123FPartecipazioniSindacatiDM).selTabellaADATAValidate(nil);
  end;

  cmbRefresh;
end;

procedure TWA123FPartecipazioniSindacatiBrowseFM.cmbRefresh;
var i:integer;
begin
  with (grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('COD_SINDACATO'),0) as TmedpIWMultiColumnComboBox) do
  begin
    items.Clear;
    Text:=ifthen((grdTabella.medpValoreColonna(grdTabella.medpClientDataSet.RecNo-1,'COD_SINDACATO')<>''),grdTabella.medpValoreColonna(grdTabella.medpClientDataSet.RecNo-1,'COD_SINDACATO'),'');
    with (WR302DM as TWA123FPartecipazioniSindacatiDM) do
    begin
      A123MW.CaricaSindacati;
      for i := 0 to ListaSindacati.Count - 1 do
        AddRow(ListaSindacati.Strings[i]);
    end;
  end;

  with (grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('COD_ORGANISMO'),0) as TmedpIWMultiColumnComboBox) do
  begin
    items.Clear;
    Text:=ifthen((grdTabella.medpValoreColonna(grdTabella.medpClientDataSet.RecNo-1,'COD_ORGANISMO')<>''),grdTabella.medpValoreColonna(grdTabella.medpClientDataSet.RecNo-1,'COD_ORGANISMO'),'');
    with (WR302DM as TWA123FPartecipazioniSindacatiDM) do
    begin
      for i := 0 to ListaOrganismi.Count - 1 do
        AddRow(ListaOrganismi.Strings[i]);
    end;
  end;
end;

procedure TWA123FPartecipazioniSindacatiBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
var i:Integer;
begin
  inherited;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DADATA'),0) as TmeIWEdit) do
  begin
    OnAsyncChange:=dataAsyncChange;
    Css:='input_data_dmy';
  end;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ADATA'),0) as TmeIWEdit) do
  begin
    OnAsyncChange:=dataAsyncChange;
    Css:='input_data_dmy';
  end;
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DESC_SINDACATO'),0) as TmeIWLabel).Text:=grdTabella.medpValoreColonna(Row, 'DESC_SINDACATO');
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DESC_ORGANISMO'),0) as TmeIWLabel).Text:=grdTabella.medpValoreColonna(Row, 'DESC_ORGANISMO');
  //COD_SINDACATO
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_SINDACATO'),1) as TmeIWImageFile) do
  begin
    Enabled:=true;
    OnClick:=imgAccediClick;
  end;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_SINDACATO'),0) as TmedpIWMultiColumnComboBox) do
  begin
    Tag:=Row;
    items.Clear;
    OnAsyncChange:=CodAsyncChange;
    Text:=ifthen((grdTabella.medpValoreColonna(Row,'COD_SINDACATO')<>''),grdTabella.medpValoreColonna(Row,'COD_SINDACATO'),'');
    with (WR302DM as TWA123FPartecipazioniSindacatiDM) do
    begin
      A123MW.CaricaSindacati;
      for i := 0 to ListaSindacati.Count - 1 do
        AddRow(ListaSindacati.Strings[i]);
    end;
  end;
  //COD_ORGANISMO
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_ORGANISMO'),0) as TmedpIWMultiColumnComboBox) do
  begin
    Tag:=Row;
    items.Clear;
    OnAsyncChange:=CodOrgAsyncChange;
    Text:=ifthen((grdTabella.medpValoreColonna(Row,'COD_ORGANISMO')<>''),grdTabella.medpValoreColonna(Row,'COD_ORGANISMO'),'');
    with (WR302DM as TWA123FPartecipazioniSindacatiDM) do
    begin
      for i := 0 to ListaOrganismi.Count - 1 do
        AddRow(ListaOrganismi.Strings[i]);
    end;
  end;
end;

procedure TWA123FPartecipazioniSindacatiBrowseFM.imgAccediClick(Sender: TObject);
var Params, CmbText: String;
begin
  CmbText:=(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('COD_SINDACATO'),0) as TmedpIWMultiColumnComboBox).text;
  Params:='TIPO=S' + ParamDelimiter + 'CODICE=' + Trim(CmbText);
  (Self.Owner as TWA123FPartecipazioniSindacati).AccediForm(55,Params);
end;

procedure TWA123FPartecipazioniSindacatiBrowseFM.CodAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
var Descrizione, CmbText:String;
begin
  Descrizione:='';
  CmbText:=Trim(Copy((grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('COD_SINDACATO'),0) as TmedpIWMultiColumnComboBox).text,1,5));
  with (WR302DM as TWA123FPartecipazioniSindacatiDM).A123MW do
   if (CmbText <> '') and (selT240.SearchRecord('CODICE',CmbText,[srFromBeginning])) then
     Descrizione:=selT240.FieldByName('DESCRIZIONE').AsString;
  with (grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('DESC_SINDACATO'),0) as TmeIWLabel) do
    Text:=Descrizione;
end;

procedure TWA123FPartecipazioniSindacatiBrowseFM.CodOrgAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
var Descrizione, CmbText:String;
begin
  Descrizione:='';
  CmbText:=Trim(Copy((grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('COD_ORGANISMO'),0) as TmedpIWMultiColumnComboBox).text,1,5));
  with (WR302DM as TWA123FPartecipazioniSindacatiDM).A123MW do
   if (CmbText <> '') and (selT245.SearchRecord('CODICE',CmbText,[srFromBeginning])) then
     Descrizione:=selT245.FieldByName('DESCRIZIONE').AsString;
  with (grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('DESC_ORGANISMO'),0) as TmeIWLabel) do
    Text:=Descrizione;
end;


end.
