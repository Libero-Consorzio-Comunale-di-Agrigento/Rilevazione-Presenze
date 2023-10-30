unit WA121UOrganizzSindacaliCompetenzeFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompGrids, meIWGrid, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWApplication,
  IWHTMLContainer, IWHTML40Container, IWRegion, medpIWMultiColumnComboBox, meIWEdit, meIWLabel,
  C190FunzioniGeneraliWeb, Vcl.Menus;

type
  TWA121FOrganizzSindacaliCompetenzeFM = class(TWR203FGestDetailFM)
    PopupMenu1: TPopupMenu;
    Annocorrente1: TMenuItem;
    procedure grdTabellaComponenti2DataSet(Row: Integer);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure Annocorrente1Click(Sender: TObject);
  private
    procedure SelT242AREAasyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure SelT242TIPOasyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
  public
    procedure InizializzaComponenti;
  end;


implementation

uses WA121UOrganizzSindacali, WA121UOrganizzSindacaliDM;

{$R *.dfm}

procedure TWA121FOrganizzSindacaliCompetenzeFM.InizializzaComponenti;
begin
  inherited;
  grdTabella.RigaInserimento:=True;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TIPO'),0,DBG_MECMB,'3','2','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('AREA_SINDACALE'),0,DBG_MECMB,'5','2','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DESC_CONTRATTO'),0,DBG_LBL,'20','1','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DESC_TIPO'),0,DBG_LBL,'20','1','null','','S');
end;

procedure TWA121FOrganizzSindacaliCompetenzeFM.Annocorrente1Click( Sender: TObject);
begin
  inherited;
  (WR302DM as TWA121FOrganizzSindacaliDM).A121MW.FiltraAnnoCorrente(Annocorrente1.Checked);
  grdTabella.medpAggiornaCDS(True);
  //Necessario perchè altrimenti in async il refresh di grdCompetenze non viene renderizzato
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[(Self.Owner as TWA121FOrganizzSindacali).btnSendFile.HTMLName]));
end;

procedure TWA121FOrganizzSindacaliCompetenzeFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  (WR302DM as TWA121FOrganizzSindacaliDM).A121MW.selT242.FieldByName('TIPO').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TIPO'),0) as TmedpIWMultiColumnComboBox).Text;
  (WR302DM as TWA121FOrganizzSindacaliDM).A121MW.selT242.FieldByName('AREA_SINDACALE').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('AREA_SINDACALE'),0) as TmedpIWMultiColumnComboBox).Text;
end;

procedure TWA121FOrganizzSindacaliCompetenzeFM.grdTabellaDataSet2Componenti(Row: Integer);
var i:Integer;
begin
  inherited;
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('SCADENZA'),0) as TmeIWEdit).Css:='input_data_dmy';
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DECORRENZA'),0) as TmeIWEdit).Css:='input_data_dmy';
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DESC_CONTRATTO'),0) as TmeIWLabel).Text:=grdTabella.medpValoreColonna(Row, 'DESC_CONTRATTO');
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DESC_TIPO'),0) as TmeIWLabel).Text:=grdTabella.medpValoreColonna(Row, 'DESC_TIPO');
  //cmbTipo
  with (WR302DM as TWA121FOrganizzSindacaliDM).A121MW do
    for i := 0 to High(D_TipoContratto) do
      (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TIPO'),0) as TmedpIWMultiColumnComboBox).AddRow(Format('%s;%s',[D_TipoContratto[i].Value,D_TipoContratto[i].Item]));
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TIPO'),0) as TmedpIWMultiColumnComboBox) do
  begin
    OnAsyncChange:=SelT242TIPOasyncChange;
    Text:=grdTabella.medpValoreColonna(Row, 'TIPO');
  end;
  //cmb areaSindacale
  with (WR302DM as TWA121FOrganizzSindacaliDM).A121MW.selT200 do
  begin
    First;
    while not Eof do
    begin
      (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('AREA_SINDACALE'),0) as TmedpIWMultiColumnComboBox).AddRow(Format('%s;%s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
  end;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('AREA_SINDACALE'),0) as TmedpIWMultiColumnComboBox) do
  begin
    OnAsyncChange:=SelT242AREAasyncChange;
    Text:=grdTabella.medpValoreColonna(Row, 'AREA_SINDACALE');
  end;
end;

procedure TWA121FOrganizzSindacaliCompetenzeFM.SelT242AREAasyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
var Descrizione, CmbText:String;
begin
  Descrizione:='';
  CmbText:=(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('AREA_SINDACALE'),0) as TmedpIWMultiColumnComboBox).text;
  if Trim(CmbText) <> '' then
    Descrizione:=(WR302DM as TWA121FOrganizzSindacaliDM).A121MW.selT200.LookUp('CODICE',CmbText,'DESCRIZIONE');
  with (grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('DESC_CONTRATTO'),0) as TmeIWLabel) do
    Text:=Descrizione;
end;

procedure TWA121FOrganizzSindacaliCompetenzeFM.SelT242TIPOasyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
var Descrizione, CmbText:String;
    i:Integer;
begin
  Descrizione:='';
  CmbText:=(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('TIPO'),0) as TmedpIWMultiColumnComboBox).text;
  with (WR302DM as TWA121FOrganizzSindacaliDM).A121MW do
    for i := 0 to High(D_TipoContratto) do
      if Trim(CmbText) = D_TipoContratto[i].Value then
        Descrizione:=D_TipoContratto[i].Item;
  with (grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('DESC_TIPO'),0) as TmeIWLabel) do
    Text:=Descrizione;
end;

end.
