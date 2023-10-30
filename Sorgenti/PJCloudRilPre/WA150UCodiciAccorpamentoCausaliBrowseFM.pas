unit WA150UCodiciAccorpamentoCausaliBrowseFM;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms, OracleData,
  Dialogs, WR204UBrowseTabellaFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, medpIWMultiColumnComboBox , meIWLabel,
  C190FunzioniGeneraliWeb, IWCompExtCtrls, meIWImageFile, medpIWImageButton, medpIWMessageDlg,WC013UCheckListFM,
  A000UMessaggi, A000UInterfaccia, C180FunzioniGenerali, Vcl.Menus, meIWEdit;

type
  TWA150FCodiciAccorpamentoCausaliBrowseFm = class(TWR204FBrowseTabellaFM)
    btnFiltroVoci: TmedpIWImageButton;
    btnElimina: TmedpIWImageButton;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
    procedure btnEliminaClick(Sender: TObject);
    procedure btnFiltroVociClick(Sender: TObject);
    procedure IWFrameRegionRender(Sender: TObject);
  private
    WC013: TWC013FCheckListFM;
    LstCodiciSelezionati: TStringList;
    procedure ReleaseOggetti; Override;
    procedure cmbCodiceAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure ResultMsgCancellazione(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ckCodiciResult(Sender: TObject; Result: Boolean);
    procedure InserisciAssSelezionate;
    procedure ResultMsgInserimento(Sender: TObject; R: TmeIWModalResult; KI: String);
  protected
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
  public
    { Public declarations }
  end;


implementation

uses WA150UCodiciAccorpamentoCausaliDM;

{$R *.dfm}

procedure TWA150FCodiciAccorpamentoCausaliBrowseFm.IWFrameRegionCreate(Sender: TObject);
var Tipo, Codice: String;
begin
  inherited;
  LstCodiciSelezionati:=TStringList.Create;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('COD_CAUSALE'),0,DBG_MECMB,'10','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DESCRIZIONE'),0,DBG_LBL,'20','','null','','S');
end;

procedure TWA150FCodiciAccorpamentoCausaliBrowseFm.IWFrameRegionRender(Sender: TObject);
begin
  inherited;
  with (WR302DM as TWA150FCodiciAccorpamentoCausaliDM) do
    grdTabella.Caption:='Accorpamento: '+ SelTabella.GetVariable('CodTipoAccorpCausali') + ' - Codice: '+ SelTabella.GetVariable('CodCodiciAccorpCausali') ;
end;

procedure TWA150FCodiciAccorpamentoCausaliBrowseFm.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  if (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_CAUSALE'),0) as TmedpIWMultiColumnComboBox) <> nil then
    (WR302DM as TWA150FCodiciAccorpamentoCausaliDM).SelTabella.FieldByName('COD_CAUSALE').AsString:=TmedpIWMultiColumnComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_CAUSALE'),0)).Text;
end;

procedure TWA150FCodiciAccorpamentoCausaliBrowseFm.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DESCRIZIONE'),0) as TmeIWLabel).Caption:=grdTabella.medpDataSet.FieldByName('DESCRIZIONE').AsString;
  if (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_CAUSALE'),0) as TmedpIWMultiColumnComboBox) <> nil then
    with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_CAUSALE'),0) as TmedpIWMultiColumnComboBox) do
    begin
      items.Clear;
      with (WR302DM as TWA150FCodiciAccorpamentoCausaliDM).A150MW do
      begin
        //if grdTabella.medpValoreColonna(Row, 'CODICE')<>'' then
          //Text:=grdTabella.medpValoreColonna(Row, 'CODICE');
        selT265.Close;
        selT265.Open;
        while not selT265.Eof do
        begin
          AddRow(selT265.FieldByName('CODICE').AsString+';'+selT265.FieldByName('DESCRIZIONE').AsString);
          selT265.Next;
        end;
      end;
      Tag:=Row;
      OnAsyncChange:=cmbCodiceAsyncChange;
    end;
  if (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('PERCENTUALE'),0) as TmeIWEdit) <> nil then
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('PERCENTUALE'),0) as TmeIWEdit).Css:='input_num_nnndd_neg width5chrImp';
end;

procedure TWA150FCodiciAccorpamentoCausaliBrowseFm.btnEliminaClick(Sender: TObject);
begin
  inherited;
  MsgBox.WebMessageDlg(A000MSG_A150_DLG_CANCELLAZIONE,mtConfirmation,[mbYes,mbNo],ResultMsgCancellazione,'');
end;

procedure TWA150FCodiciAccorpamentoCausaliBrowseFm.Notification(AComponent: TComponent;  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent is TWC013FCheckListFM) and (AComponent = WC013) then
      WC013:=nil
    (*else if (AComponent is TWC015FSelEditGridFM) and (AComponent = WC015FSelEditGridFM) then
      WC015FSelEditGridFM:=nil
    *)
    ;
  end;
end;

procedure TWA150FCodiciAccorpamentoCausaliBrowseFm.ReleaseOggetti;
begin
  inherited;
  FreeAndNil(LstCodiciSelezionati);
  if WC013 <> nil then
    FreeAndNil(WC013);
end;

procedure TWA150FCodiciAccorpamentoCausaliBrowseFm.ResultMsgCancellazione(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    with (WR302DM as TWA150FCodiciAccorpamentoCausaliDM).selTabella do
    begin
      First;
      while not Eof do
        Delete;
      grdTabella.medpAggiornaCDS(True);
    end;
end;

procedure TWA150FCodiciAccorpamentoCausaliBrowseFm.btnFiltroVociClick(Sender: TObject);
var LstCodiciValue, LstCodiciDesc : TStringList;
begin
  inherited;
  LstCodiciValue:=TStringList.Create;
  LstCodiciDesc:=TStringList.Create;
  with (WR302DM as TWA150FCodiciAccorpamentoCausaliDM).A150MW do
  begin
    selT265.Close;
    selT265.Open;
    while not selT265.Eof do
    begin
      LstCodiciValue.Add(selT265.FieldByName('CODICE').AsString);
      LstCodiciDesc.Add(selT265.FieldByName('CODICE').AsString+' '+selT265.FieldByName('DESCRIZIONE').AsString);
      selT265.Next;
    end;
  end;

  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  with WC013 do
  begin
    CaricaLista(LstCodiciDesc, LstCodiciValue);
    ResultEvent:=ckCodiciResult;
    Visualizza(0,0,'<WA150> Filtro Assenze');
  end;
  FreeAndNil(LstCodiciDesc);
  FreeAndNil(LstCodiciValue);
 end;

procedure TWA150FCodiciAccorpamentoCausaliBrowseFm.ckCodiciResult(Sender: TObject; Result: Boolean);
var
  lstTmp: TStringList;
begin
  if Result then
  begin
    lstTmp:=WC013.LeggiValoriSelezionati;
    LstCodiciSelezionati.Clear;
    LstCodiciSelezionati.Assign(lstTmp);
    FreeAndNil(lstTmp);
    if LstCodiciSelezionati.Count > 0 then
      MsgBox.WebMessageDlg(A000MSG_A150_DLG_INSERISCI,mtConfirmation,[mbYes,mbNo],ResultMsgInserimento,'');
  end;
end;

procedure TWA150FCodiciAccorpamentoCausaliBrowseFm.ResultMsgInserimento(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    InserisciAssSelezionate;
end;

procedure TWA150FCodiciAccorpamentoCausaliBrowseFm.InserisciAssSelezionate;
var i:Integer;
begin
  with (WR302DM as TWA150FCodiciAccorpamentoCausaliDM).selTabella do
  begin
    for i:=0 to LstCodiciSelezionati.Count - 1 do
    begin
      Insert;
      FieldByName('COD_CAUSALE').AsString:=Trim(LstCodiciSelezionati[i]);
      FieldByName('DECORRENZA').AsDateTime:=StrToDate('01/01/1900');
      FieldByName('DECORRENZA_FINE').AsDateTime:=StrToDate('31/12/3999');
      Post;
    end;
  end;
  grdTabella.medpAggiornaCDS(True);
end;

procedure TWA150FCodiciAccorpamentoCausaliBrowseFm.cmbCodiceAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
var
  Row: Integer;
begin
  Row:=(Sender as TmedpIWMultiColumnComboBox).Tag;
  grdTabella.medpDataSet.FieldByName('COD_CAUSALE').AsString:=(Sender as TmedpIWMultiColumnComboBox).Text;
  TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DESCRIZIONE'),0)).Caption:=grdTabella.medpDataSet.FieldByName('DESCRIZIONE').AsString;
end;

end.
