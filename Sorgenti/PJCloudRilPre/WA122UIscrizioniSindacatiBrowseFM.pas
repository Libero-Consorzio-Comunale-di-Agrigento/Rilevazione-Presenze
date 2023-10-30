unit WA122UIscrizioniSindacatiBrowseFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR204UBrowseTabellaFM, StrUtils,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, meIWImageFile,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, medpIWMultiColumnComboBox,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids, meIWLabel, meIWEdit,
  IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWHTMLContainer, OracleData,
  IWHTML40Container, IWRegion, C190FunzioniGeneraliWeb, IWCompEdit, Vcl.Menus, A000UCostanti;

type
  TWA122FIscrizioniSindacatiBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
  private
    procedure imgAccediClick(Sender: TObject);
    procedure CodAsyncChange(Sender: TObject; EventParams: TStringList;Index: Integer; Value: string);
   procedure dataIscrAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure dataCessAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure cmbCodSindacatoRefresh;
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA122UIscrizioniSindacatiDM, WA122UIscrizioniSindacati;

{$R *.dfm}

procedure TWA122FIscrizioniSindacatiBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('COD_SINDACATO'),0,DBG_MECMB,'5','1','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('COD_SINDACATO'),1,DBG_IMG,'','ACCEDI','','','');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DESC_SINDACATO'),0,DBG_LBL,'20','1','null','','S');
  //  MONDOEDP - chiamata 82423.ini
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('NUM_PROT_ISCR'),0,DBG_EDT,'input_num_nnnnndd','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('NUM_PROT_CESS'),0,DBG_EDT,'input_num_nnnnndd','','null','','S');
  //  MONDOEDP - chiamata 82423.fine
end;

procedure TWA122FIscrizioniSindacatiBrowseFM.imgAccediClick(Sender: TObject);
var Params, CmbText: String;
begin
  CmbText:=(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('COD_SINDACATO'),0) as TmedpIWMultiColumnComboBox).text;
  Params:='TIPO=S' + ParamDelimiter + 'CODICE=' + Trim(CmbText);
  (Self.Owner as TWA122FIscrizioniSindacati).AccediForm(55,Params);
end;

procedure TWA122FIscrizioniSindacatiBrowseFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  with (WR302DM as TWA122FIscrizioniSindacatiDM).SelTabella do
    FieldByName('COD_SINDACATO').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_SINDACATO'),0) as TmedpIWMultiColumnComboBox).Text;
end;

procedure TWA122FIscrizioniSindacatiBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
var i: integer;
begin
  inherited;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DATA_ISCR'),0) as TmeIWEdit) do
  begin
    OnAsyncChange:=dataIscrAsyncChange;
    Css:='input_data_dmy';
  end;

  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DATA_CESS'),0) as TmeIWEdit) do
  begin
    OnAsyncChange:=dataCessAsyncChange;
    Css:='input_data_dmy';
  end;

  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DATA_DEC_CES'),0) as TmeIWEdit).Css:='input_data_dmy';
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DATA_DEC_ISCR'),0) as TmeIWEdit).Css:='input_data_dmy';

  //  MONDOEDP - chiamata 82423.ini
  //(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('NUM_PROT_ISCR'),0) as TmeIWEdit).Css:='input_num_nnnnndd';
  //(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('NUM_PROT_CESS'),0) as TmeIWEdit).Css:='input_num_nnnnndd';
  //  MONDOEDP - chiamata 82423.fin

  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DESC_SINDACATO'),0) as TmeIWLabel).Text:=grdTabella.medpValoreColonna(Row, 'DESC_SINDACATO');

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
    with (WR302DM as TWA122FIscrizioniSindacatiDM) do
    begin
      A122MW.CaricaSindacati;
      for i := 0 to LstSindacati.Count - 1 do
        AddRow(LstSindacati.Strings[i]);
    end;
  end;
end;

procedure TWA122FIscrizioniSindacatiBrowseFM.cmbCodSindacatoRefresh;
var i:integer;
begin
  with (grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('COD_SINDACATO'),0) as TmedpIWMultiColumnComboBox) do
  begin
    items.Clear;
    Text:=ifthen((grdTabella.medpValoreColonna(grdTabella.medpClientDataSet.RecNo-1,'COD_SINDACATO')<>''),grdTabella.medpValoreColonna(grdTabella.medpClientDataSet.RecNo-1,'COD_SINDACATO'),'');
    with (WR302DM as TWA122FIscrizioniSindacatiDM) do
    begin
      A122MW.CaricaSindacati;
      for i := 0 to LstSindacati.Count - 1 do
        AddRow(LstSindacati.Strings[i]);
    end;
  end;

end;

procedure TWA122FIscrizioniSindacatiBrowseFM.dataIscrAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  (WR302DM as TWA122FIscrizioniSindacatiDM).A122MW.selT246.FieldByName('DATA_ISCR').AsDateTime:=StrToDateTime((grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('DATA_ISCR'),0) as TmeIWEdit).Text);
  (WR302DM as TWA122FIscrizioniSindacatiDM).A122MW.selT246DATA_ISCRValidate;
  (grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('DATA_DEC_ISCR'),0) as TmeIWEdit).Text:=FormatDateTime('dd/MM/YYYY',(WR302DM as TWA122FIscrizioniSindacatiDM).A122MW.selT246.FieldByName('DATA_DEC_ISCR').AsDateTime);
  cmbCodSindacatoRefresh;
end;

procedure TWA122FIscrizioniSindacatiBrowseFM.dataCessAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  (WR302DM as TWA122FIscrizioniSindacatiDM).A122MW.selT246.FieldByName('DATA_CESS').AsDateTime:=StrToDateTime((grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('DATA_CESS'),0) as TmeIWEdit).Text);
  (WR302DM as TWA122FIscrizioniSindacatiDM).A122MW.selT246DATA_CESSValidate;
  (grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('DATA_DEC_CES'),0) as TmeIWEdit).Text:=FormatDateTime('dd/MM/YYYY',(WR302DM as TWA122FIscrizioniSindacatiDM).A122MW.selT246.FieldByName('DATA_DEC_CES').AsDateTime);
  cmbCodSindacatoRefresh;
end;

procedure TWA122FIscrizioniSindacatiBrowseFM.CodAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
var Descrizione, CmbText:String;
begin
  Descrizione:='';
  CmbText:=Trim((grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('COD_SINDACATO'),0) as TmedpIWMultiColumnComboBox).text);
  with (WR302DM as TWA122FIscrizioniSindacatiDM).A122MW do
   if (CmbText <> '') and (selT240.SearchRecord('CODICE',CmbText,[srFromBeginning])) then
     Descrizione:=selT240.FieldByName('DESCRIZIONE').AsString;
  with (grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('DESC_SINDACATO'),0) as TmeIWLabel) do
    Text:=Descrizione;
end;

end.
