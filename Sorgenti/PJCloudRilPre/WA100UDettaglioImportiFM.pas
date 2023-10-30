unit WA100UDettaglioImportiFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid,
  IWCompButton, meIWButton, WA100UMissioniDM,WR010UBase, C190FunzioniGeneraliWeb,
  meIWLabel, MedpIWMultiColumnComboBox, meIWEdit, A000UInterfaccia, A000UMessaggi,
  medpIWMessageDlg, DB;

type
  TResultEvent = procedure(Reset:Boolean) of object;

  TWA100FDettaglioImportiFM = class(TWR200FBaseFM)
    grdTabella: TmedpIWDBGrid;
    btnChiudi: TmeIWButton;
    procedure btnChiudiClick(Sender: TObject);
    procedure grdTabellaRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    function grdTabellaBeforeModifica(Sender: TObject): Boolean;
    function grdTabellaBeforeCancella(Sender: TObject): Boolean;
  private
    iPv_RecordCount: Integer;
    procedure cmbTipoRimborsoAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure edtImpValEstAsyncChange(Sender: TObject;
      EventParams: TStringList);
  public
    ResultEvent: TResultEvent;
    procedure Visualizza;
  end;

implementation

{$R *.dfm}

procedure TWA100FDettaglioImportiFM.btnChiudiClick(Sender: TObject);
var Reset:Boolean;
begin
  inherited;
  Reset:=False;
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    if M051.State in [dsEdit,dsInsert] then
    begin
      MsgBox.WebMessageDlg(A000MSG_ERR_FORM_CON_MODIFICHE,mtInformation,[mbOk],nil,'');
      Exit;
    end;

    if (iPv_RecordCount > 0) and (M051.RecordCount = 0) then
      Reset:=True;
  end;

  if Assigned(ResultEvent) then
  try
    ResultEvent(Reset);
  except
    on E: EAbort do;
    on E: Exception do
      raise;
  end;

  ReleaseOggetti;
  Free;
end;

procedure TWA100FDettaglioImportiFM.cmbTipoRimborsoAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
var cmb: TMedpIWMultiColumnComboBox;
begin
  cmb:=(Sender as TMedpIWMultiColumnComboBox);
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    grdTabella.medpDataset.FieldByName('TIPORIMBORSO').AsString:=cmb.Text;

    //Descrizione e somma sono lookup di TIPORIMBORSO
    (grdTabella.medpCompCella(cmb.Tag,grdTabella.medpIndexColonna('DESCTIPORIMBORSO'),0) as TmeIWLabel).Caption:=grdTabella.medpDataset.FieldByName('DESCTIPORIMBORSO').AsString;
    (grdTabella.medpCompCella(cmb.Tag,grdTabella.medpIndexColonna('SOMMA'),0) as TmeIWLabel).Caption:=grdTabella.medpDataset.FieldByName('SOMMA').AsString;
  end;
end;

function TWA100FDettaglioImportiFM.grdTabellaBeforeCancella(
  Sender: TObject): Boolean;
begin
  Result:=True;
  if grdTabella.medpDataSet.FieldByName('IMPORTO').AsCurrency < 0 then
  begin
    MsgBox.WebMessageDlg(A000MSG_A100_ERR_CANC_DETT,mtError,[mbOk],nil,'');
    Result:=False;
  end;
end;

function TWA100FDettaglioImportiFM.grdTabellaBeforeModifica(Sender: TObject): Boolean;
begin
  inherited;
  Result:=True;
  //D051DataChange imposta readonly per record automatici non modificabili
  if grdTabella.medpDataSet.FieldByName('IMPORTO').AsCurrency < 0 then
  begin
    MsgBox.WebMessageDlg(A000MSG_A100_ERR_MOD_DETT,mtError,[mbOk],nil,'');
    Result:=False;
  end;
end;

procedure TWA100FDettaglioImportiFM.grdTabellaDataSet2Componenti(Row: Integer);
var combo: TMedpIWMultiColumnComboBox;
begin
  inherited;
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    combo:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TIPORIMBORSO'),0) as TMedpIWMultiColumnComboBox );
    combo.Tag:=Row;
    combo.Items.Clear;
    combo.PopupHeight:=10;

    m049.First;
    while not m049.Eof do
    begin
      combo.AddRow(m049.FieldByName('CODICE').AsString + ';' + m049.FieldByName('DESCRIZIONE').AsString);
      m049.Next;
    end;
    combo.OnAsyncChange:=cmbTipoRimborsoAsyncChange;

    //Descrizione
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DESCTIPORIMBORSO'),0) as TmeIWLabel).Caption:=grdTabella.medpValoreColonna(Row, 'DESCTIPORIMBORSO');
    //Somma
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('SOMMA'),0) as TmeIWLabel).Caption:=grdTabella.medpValoreColonna(Row, 'SOMMA');

    if Not(Q050.FieldByName('COD_VALUTA_EST').IsNull) then
    begin
      with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('IMPORTO_VALEST'),0) as TmeIWEdit) do
      begin
        OnAsyncChange:=edtImpValEstAsyncChange;
        Tag:=Row;
      end;
    end;
  end;
end;

procedure TWA100FDettaglioImportiFM.edtImpValEstAsyncChange(Sender: TObject; EventParams: TStringList);
var edt: TmeIWEdit;
begin
  edt:=(Sender as TmeIWEdit);
  grdTabella.medpDataset.FieldByName('IMPORTO_VALEST').AsString:=edt.Text;
  //Il change di IMPORTO_VALEST modifica anche importo
  (grdTabella.medpCompCella(edt.Tag,grdTabella.medpIndexColonna('IMPORTO'),0) as TmeIWEdit).Text:=grdTabella.medpDataset.FieldByName('IMPORTO').AsString;
end;

procedure TWA100FDettaglioImportiFM.grdTabellaRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
var Agrid: TmedpIWDBGrid;
  NumColonna: Integer;
begin
  inherited;
  Agrid:=TmedpIWDBGrid(ACell.Grid);
  if not Agrid.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=Agrid.medpNumColonna(AColumn);
  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(Agrid.medpCompGriglia) + 1) and (Agrid.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdTabella.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWA100FDettaglioImportiFM.Visualizza;
begin
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    iPv_RecordCount:=M051.RecordCount;
    M051.FieldByName('IMPORTO_VALEST').Visible:=False;
    if Not(Q050.FieldByName('COD_VALUTA_EST').IsNull) then
    begin
      M051.FieldByName('IMPORTO_VALEST').Visible:=True;
    end;
    grdTabella.medpAttivaGrid(M051,True,True,True);

    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DATARIMBORSO'),0,DBG_EDT,'DATA','10','null','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TIPORIMBORSO'),0,DBG_MECMB,'5','2','','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DESCTIPORIMBORSO'),0,DBG_LBL,'50','1','null','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('SOMMA'),0,DBG_LBL,'5','1','null','','S');

    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('IMPORTO'),0,DBG_EDT,'input_num_generic','10','null','','S');
    if Not(Q050.FieldByName('COD_VALUTA_EST').IsNull) then
    begin
      //importo valuta estera
      grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('IMPORTO_VALEST'),0,DBG_EDT,'input_num_generic','10','null','','S');
    end;
  end;
  (Self.Parent as TWR010FBase).VisualizzaJQMessaggio(jQuery,700,-1,EM2PIXEL * 30, 'Dettaglio importi','#wa100DettaglioImporti_container',False,True);
end;

end.
