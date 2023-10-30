unit WA036UTurniRepBrowseFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR204UBrowseTabellaFM, IWCompJQueryWidget, IWVCLComponent, DB,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, StrUtils, Math,
  meIWEdit, meIWComboBox, meIWLabel, C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  Vcl.Menus;

type
  TWA036FTurniRepBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
    procedure edtMeseAsyncChange(Sender: TObject; EventParams: TStringList);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA036UTurniRepDM;

{$R *.dfm}

procedure TWA036FTurniRepBrowseFM.IWFrameRegionCreate(Sender: TObject);
var i:Integer;
begin
  inherited;
  grdTabella.medpPaginazione:=True;
  grdTabella.medpPreparaComponentiDefault;
  for i:=0 to WR302DM.selTabella.Fields.Count - 1 do
  begin
    if Copy(WR302DM.selTabella.Fields[i].FieldName,1,3) = 'VP_' then
      grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna(WR302DM.selTabella.Fields[i].FieldName),0,DBG_CMB,'6','2','null','','S')
    else if WR302DM.selTabella.Fields[i].FieldName = 'CALCMESE' then
      grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna(WR302DM.selTabella.Fields[i].FieldName),0,DBG_LBL,'10','','null','','S');
  end;

  //  MONDOEDP - chiamata 82423.ini
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('ANNO'),0,DBG_EDT,'input_num_nnnn','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('MESE'),0,DBG_EDT,'input_month','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TURNIINTERI'),0,DBG_EDT,'input_num_nnn','','null','','S');

  // *** prova
  //grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TURNIORE'),0,DBG_EDT,'input_hour_hhhnn','','null','','S');

  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('GETTONE_CHIAMATA'),0,DBG_EDT,'input_num_nnn','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TURNI_OLTREMAX'),0,DBG_EDT,'input_num_nnn','','null','','S');
  //  MONDOEDP - chiamata 82423.fine
end;

procedure TWA036FTurniRepBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
var i:Integer;
    Campo:String;
begin
  inherited;
  //  MONDOEDP - chiamata 82423.ini
  //(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ANNO'),0) as TmeIWEdit).Css:='input_num_nnnn';
  //  MONDOEDP - chiamata 82423.fine
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('MESE'),0) as TmeIWEdit) do
  begin
    //  MONDOEDP - chiamata 82423.ini
    //Css:='input_month';
    //  MONDOEDP - chiamata 82423.fine
    OnAsyncChange:=edtMeseAsyncChange;
    Tag:=Row;
  end;
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CALCMESE'),0) as TmeIWLabel).Caption:=grdTabella.medpValoreColonna(Row,'CALCMESE');
  //  MONDOEDP - chiamata 82423.ini
  // impostazioni campi numeriche spostate nel formcreate, utilizzando medpPreparaComponenteGenerico
  // impostazioni campi orari ???
  {
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNIINTERI'),0) as TmeIWEdit).Css:='input_num_nnn';
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNIORE'),0) as TmeIWEdit).Css:='input_hour_hhhmm';
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('OREMAGG'),0) as TmeIWEdit).Css:='input_hour_hhhmm';
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ORENONMAGG'),0) as TmeIWEdit).Css:='input_hour_hhhmm';
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('GETTONE_CHIAMATA'),0) as TmeIWEdit).Css:='input_num_nnn';
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TURNI_OLTREMAX'),0) as TmeIWEdit).Css:='input_num_nnn';
  }
  //  MONDOEDP - chiamata 82423.fine
  for i:=0 to WR302DM.selTabella.Fields.Count - 1 do
  begin
    if Copy(WR302DM.selTabella.Fields[i].FieldName,1,3) = 'VP_' then
    begin
      Campo:=WR302DM.selTabella.Fields[i].FieldName;
      with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna(Campo),0) as TmeIWComboBox) do
      begin
        Tag:=Row;
        (WR302DM as TWA036FTurniRepDM).A036MW.CaricaPickList(Items,Campo);
        ItemIndex:=Items.IndexOf(grdTabella.medpDataSet.FieldByName(Campo).AsString);
      end;
    end;
  end;
end;

procedure TWA036FTurniRepBrowseFM.grdTabellaComponenti2DataSet(Row: Integer);
var i:Integer;
    Campo:String;
begin
  inherited;
  for i:=0 to WR302DM.selTabella.Fields.Count - 1 do
    if Copy(WR302DM.selTabella.Fields[i].FieldName,1,3) = 'VP_' then
    begin
      Campo:=WR302DM.selTabella.Fields[i].FieldName;
      WR302DM.selTabella.FieldByName(Campo).AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna(Campo),0) as TmeIWComboBox).Text;
    end;
end;

procedure TWA036FTurniRepBrowseFM.edtMeseAsyncChange(Sender: TObject; EventParams: TStringList);
var Row: Integer;
begin
  Row:=(Sender as TmeIWEdit).Tag;
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CALCMESE'),0) as TmeIWLabel).Caption:=R180Capitalize(R180NomeMese(StrToIntDef((Sender as TmeIWEdit).Text,0)));
end;

end.
