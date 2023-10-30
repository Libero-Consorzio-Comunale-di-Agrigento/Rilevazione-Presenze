unit WA115UIterAutorizzativiSelI95DetailFM;

interface

uses
  Data.DB,
  StrUtils,
  System.Actions,
  System.Classes,
  System.SysUtils,
  System.Variants,
  Vcl.ActnList,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Menus,
  Winapi.Messages,
  Winapi.Windows,
  C190FunzioniGeneraliWeb,
  IWBaseContainerLayout,
  IWBaseControl,
  IWBaseHTMLControl,
  IWBaseLayoutComponent,
  IWCompGrids,
  IWCompJQueryWidget,
  IWContainer,
  IWContainerLayout,
  IWControl,
  IWDBGrids,
  IWHTML40Container,
  IWHTMLContainer,
  IWRegion,
  IWTemplateProcessorHTML,
  IWVCLBaseContainer,
  IWVCLBaseControl,
  IWVCLComponent,
  WC015USelEditGridFM,
  WR203UGestDetailFM,
  meIWComboBox,
  meIWEdit,
  meIWGrid,
  meIWLabel,
  meIWMemo,
  medpIWDBGrid,
  medpIWMultiColumnComboBox;

type
  TWA115FIterAutorizzativiSelI95DetailFM = class(TWR203FGestDetailFM)
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
  private
    { Private declarations }
  public
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
    procedure grdselI097preparaComponenti(Sender: TObject);
    procedure grdselI097DataSet2Componenti(Sender: TObject;Row: Integer);
    procedure grdselI097Componenti2DataSet(Sender: TObject;Row: Integer);
  end;

const
  NOME_DETAIL: String = 'Strutture';
  CAMPI_COMBO: TArray<String> = ['FILTRO_INTERFACCIA'];
  CAMPI_DI_TESTO: TArray<String> = ['CONDIZ_AUTORIZZ_AUTOMATICA', 'FILTRO_RICHIESTA', 'CONDIZIONE_ALLEGATI', 'ALLEGATI_MODIFICABILI'];
  CAMPI_TABELLA: TArray<String> = ['C_VALIDITA_ITER_AUT'];

implementation

uses
  WA115UIterAutorizzativi,
  WA115UIterAutorizzativiDM,
  A000UCostanti;

{$R *.dfm}

procedure TWA115FIterAutorizzativiSelI95DetailFM.CaricaDettaglio(DataSet: TDataSet; DataSource: TDataSource);
var
  i:Integer;
begin
  inherited;
  grdTabella.medpPaginazione:=False;
  grdTabella.medpEditMultiplo:=False;
  grdTabella.Summary:=NOME_DETAIL;
  grdTabella.Caption:=NOME_DETAIL;

  grdTabella.medpPreparaComponentiDefault;

  for i := Low(CAMPI_COMBO) to High(CAMPI_COMBO) do
  begin
    if not grdTabella.medpDataSet.FieldByName(CAMPI_COMBO[i]).ReadOnly then
      grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna(CAMPI_COMBO[i]),0,DBG_MECMB,'1','1','null','','S');
  end;

  for i := Low(CAMPI_DI_TESTO) to High(CAMPI_DI_TESTO) do
  begin
    if not grdTabella.medpDataSet.FieldByName(CAMPI_DI_TESTO[i]).ReadOnly then
    begin
      grdTabella.medpPreparaComponenteGenerico('WR102',CAMPI_DI_TESTO[i],0,DBG_LBL,'50','','null','','S');
      grdTabella.medpPreparaComponenteGenerico('WR102',CAMPI_DI_TESTO[i],1,DBG_IMG,'','PUNTINI','','','D');
    end;
  end;

  for i:=Low(CAMPI_TABELLA) to High(CAMPI_TABELLA) do
  begin
    if not grdTabella.medpDataSet.FieldByName(CAMPI_DI_TESTO[i]).ReadOnly then
    begin
      grdTabella.medpPreparaComponenteGenerico('WR102',CAMPI_TABELLA[i],0,DBG_LBL,'50','','null','','S');
      grdTabella.medpPreparaComponenteGenerico('WR102',CAMPI_TABELLA[i],1,DBG_IMG,'','PUNTINI','','','D');
    end;
  end;

  grdTabella.medpPreparaComponenteGenerico('WR102','FILTRO_INTERFACCIA',0,DBG_MECMB,'5','1','','','');
  grdTabella.medpPreparaComponenteGenerico('WR102','COD_ITER',0,DBG_EDT,'10','','','','');
  grdTabella.medpPreparaComponenteGenerico('WR102','DESCRIZIONE',0,DBG_EDT,'25','','','','');
  grdTabella.medpPreparaComponenteGenerico('WR102','MAX_LIV_AUTORIZZ_AUTOMATICA',0,DBG_EDT,'input_num_nnn_neg','','','','');
  grdTabella.medpPreparaComponenteGenerico('WR102','MAX_LIV_NOTE_MODIFICABILI',0,DBG_EDT,'input_num_nnn_neg','','','','');

  grdTabella.medpCaricaCDS;
end;

procedure TWA115FIterAutorizzativiSelI95DetailFM.grdTabellaComponenti2DataSet(Row: Integer);
var
  i:Integer;
begin
  inherited;
  with TWA115FIterAutorizzativiDM(WR302DM).selI095 do
  begin
    for i:=Low(CAMPI_DI_TESTO) to High(CAMPI_DI_TESTO) do
    begin
      if not grdTabella.medpDataSet.FieldByName(CAMPI_DI_TESTO[i]).ReadOnly then
        FieldByName(CAMPI_DI_TESTO[i]).AsString:=Trim((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna(CAMPI_DI_TESTO[i]),0) as TmeIWLabel).Text);
    end;
  end;
end;

procedure TWA115FIterAutorizzativiSelI95DetailFM.grdTabellaDataSet2Componenti(Row: Integer);
var
  i:Integer;
begin
  inherited;

  for i:=Low(CAMPI_DI_TESTO) to High(CAMPI_DI_TESTO) do
  begin
    if not grdTabella.medpDataSet.FieldByName(CAMPI_DI_TESTO[i]).ReadOnly then
      TWA115FIterAutorizzativi(Self.Owner).CreaBtnTesto(grdTabella, TWA115FIterAutorizzativiDM(WR302DM).selI095, CAMPI_DI_TESTO[i],Row);
  end;

  for i:=Low(CAMPI_COMBO) to High(CAMPI_COMBO) do
  begin
    if ((grdTabella.medpCompCella(Row,CAMPI_COMBO[i],0) as TMedpIWMultiColumnComboBox) <> nil) and (not grdTabella.medpDataSet.FieldByName(CAMPI_COMBO[i]).ReadOnly) then
    begin
      with (grdTabella.medpCompCella(Row,CAMPI_COMBO[i],0) as TMedpIWMultiColumnComboBox) do
      begin
        // obbligatorio: combobox con valori [S | N]
        ColumnSeparator:=';';
        ColCount:=1;
        Items.Clear;
        AddRow('S');
        AddRow('N');
        Text:=grdTabella.medpValoreColonna(Row,CAMPI_COMBO[i]);
      end;
    end;
  end;

  for i:=Low(CAMPI_TABELLA) to High(CAMPI_TABELLA) do
  begin
    if not grdTabella.medpDataSet.FieldByName(CAMPI_TABELLA[i]).ReadOnly then
      TWA115FIterAutorizzativi(Self.Owner).CreaBtnTabellaSelI097(grdTabella, TWA115FIterAutorizzativiDM(WR302DM).selI095, CAMPI_TABELLA[i],Row);
  end;
end;

{ selI97 }

procedure TWA115FIterAutorizzativiSelI95DetailFM.grdselI097preparaComponenti(Sender: TObject);
begin
  with TWC015FSelEditGridFM(Sender).grdElenco do
  begin
    medpPreparaComponenteGenerico('WR102',medpIndexColonna('CONDIZ_VALIDITA'),0,DBG_MEMO,'40','2','null','','S');
    medpPreparaComponenteGenerico('WR102',medpIndexColonna('MESSAGGIO'),0,DBG_MEMO,'40','2','null','','S');
    medpPreparaComponenteGenerico('WR102',medpIndexColonna('TIPO_RICHIESTA'),0,DBG_EDT,'2','','','','');
    medpPreparaComponenteGenerico('WR102',medpIndexColonna('BLOCCANTE'),0,DBG_CMB,'1','','null','','S');
    medpPreparaComponenteGenerico('WR102',medpIndexColonna('LIVELLO'),0,DBG_CMB,'1','','null','','S');
  end;
end;

procedure TWA115FIterAutorizzativiSelI95DetailFM.grdselI097DataSet2Componenti(Sender: TObject;Row: Integer);
var
  i:integer;
  IndiceLivello:integer;
  ValoreLivello:String;
begin
  with TWC015FSelEditGridFM(Sender).grdElenco do
  begin
    TmeIWMemo(medpCompCella(Row,medpIndexColonna('CONDIZ_VALIDITA'),0)).text:=medpClientDataSet.FieldByName('CONDIZ_VALIDITA').AsString;
    TmeIWMemo(medpCompCella(Row,medpIndexColonna('MESSAGGIO'),0)).text:=medpClientDataSet.FieldByName('MESSAGGIO').AsString;
    TmeIWEdit(medpCompCella(Row,medpIndexColonna('TIPO_RICHIESTA'),0)).text:=medpClientDataSet.FieldByName('TIPO_RICHIESTA').AsString;
    TmeIWComboBox(medpCompCella(Row,medpIndexColonna('BLOCCANTE'),0)).Items.Add(' ');
    TmeIWComboBox(medpCompCella(Row,medpIndexColonna('BLOCCANTE'),0)).Items.Add('S');
    TmeIWComboBox(medpCompCella(Row,medpIndexColonna('BLOCCANTE'),0)).Items.Add('N');
    TmeIWComboBox(medpCompCella(Row,medpIndexColonna('BLOCCANTE'),0)).ItemIndex:=StrToInt(IfThen(Row>0,IntToStr(TmeIWComboBox(medpCompCella(Row,medpIndexColonna('BLOCCANTE'),0)).Items.IndexOf(medpValoreColonna(Row, 'BLOCCANTE'))),'0'));
    //Caricamento Livello autorizzazione
    for i:=-1 to (WR302DM as TWA115FIterAutorizzativiDM).selI096.RecordCount do
    begin
      (medpCompCella(Row,medpIndexColonna('LIVELLO'),0) as TmeIWComboBox).Items.Add(i.ToString);
    end;
    ValoreLivello:=medpClientDataSet.FieldByName('LIVELLO').AsString;
    IndiceLivello:=(medpCompCella(Row,medpIndexColonna('LIVELLO'),0) as TmeIWComboBox).Items.IndexOf(ValoreLivello);
    if IndiceLivello = -1  then
    begin
      IndiceLivello:=1;
    end;
    (medpCompCella(Row,medpIndexColonna('LIVELLO'),0) as TmeIWComboBox).ItemIndex:=IndiceLivello;
  end;
end;

procedure TWA115FIterAutorizzativiSelI95DetailFM.grdselI097Componenti2DataSet(Sender: TObject;Row: Integer);
begin
  with TWC015FSelEditGridFM(Sender).grdElenco do
  begin
    medpDataSet.FieldByName('CONDIZ_VALIDITA').AsString:=TmeIWMemo(medpCompCella(Row,medpIndexColonna('CONDIZ_VALIDITA'),0)).text;
    medpDataSet.FieldByName('MESSAGGIO').AsString:=TmeIWMemo(medpCompCella(Row,medpIndexColonna('MESSAGGIO'),0)).text;
    medpDataSet.FieldByName('TIPO_RICHIESTA').AsString:=TmeIWEdit(medpCompCella(Row,medpIndexColonna('TIPO_RICHIESTA'),0)).text;
    if TmeIWEdit(medpCompCella(Row,medpIndexColonna('LIVELLO'),0)).text = '0' then
    begin
      medpDataSet.FieldByName('BLOCCANTE').AsString:=TmeIWComboBox(medpCompCella(Row,medpIndexColonna('BLOCCANTE'),0)).text;
    end
    else
    begin
      medpDataSet.FieldByName('BLOCCANTE').AsString:='S';
    end;
  end;
end;

end.
