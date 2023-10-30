unit WA115UIterAutorizzativiBrowseFM;

interface

uses
  StrUtils,
  System.Classes,
  System.SysUtils,
  System.Variants,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Menus,
  Winapi.Messages,
  Winapi.Windows,
  WR204UBrowseTabellaFM,
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
  meIWComboBox,
  meIWImageFile,
  meIWLabel,
  meIWMemo,
  medpIWDBGrid,
  medpIWMultiColumnComboBox;

type
  TWA115FIterAutorizzativiBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
  private
  public
    procedure grdselI094preparaComponenti(Sender: TObject);
    procedure grdselI094DataSet2Componenti(Sender: TObject;Row: Integer);
    procedure grdselI094Componenti2DataSet(Sender: TObject;Row: Integer);
  end;

const
  NOME_BROWSE: String = 'Iter autorizzativi';
  CAMPI_COMBO: TArray<String> = ['REVOCABILE'];
  CAMPI_DI_TESTO: TArray<String> = ['MAIL_OGGETTO_DIP', 'MAIL_CORPO_DIP', 'MAIL_OGGETTO_RESP', 'MAIL_CORPO_RESP', 'EXPR_PERIODO_VISUAL', 'MSG_NOTIFICA'];
  CAMPI_TABELLA: TArray<String> = ['C_CHKDATI_ITER_AUT'];

implementation

uses
  WA115UIterAutorizzativi,
  WA115UIterAutorizzativiDM,
  A000UCostanti;

{$R *.dfm}

procedure TWA115FIterAutorizzativiBrowseFM.grdTabellaComponenti2DataSet(Row: Integer);
var
  i:Integer;
begin
  inherited;
  with TWA115FIterAutorizzativiDM(WR302DM).selTabella do
  begin
    for i:=Low(CAMPI_DI_TESTO) to High(CAMPI_DI_TESTO) do
    begin
      FieldByName(CAMPI_DI_TESTO[i]).AsString:=Trim((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna(CAMPI_DI_TESTO[i]),0) as TmeIWLabel).Text);
    end;
  end;
  if(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('REVOCABILE'),0) <> nil) then
      grdTabella.medpDataSet.FieldByName('REVOCABILE').AsString:=TMedpIWMultiColumnComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('REVOCABILE'),0)).Text;
end;

procedure TWA115FIterAutorizzativiBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
var
  i:Integer;
begin
  inherited;
  for i:=Low(CAMPI_DI_TESTO) to High(CAMPI_DI_TESTO) do
  begin
    if not grdTabella.medpDataSet.FieldByName(CAMPI_DI_TESTO[i]).ReadOnly then
      TWA115FIterAutorizzativi(Self.Owner).CreaBtnTesto(grdTabella, TWA115FIterAutorizzativiDM(WR302DM).selTabella, CAMPI_DI_TESTO[i],Row);
  end;

  for i:=Low(CAMPI_COMBO) to High(CAMPI_COMBO) do
  begin
    if (not grdTabella.medpDataSet.FieldByName(CAMPI_COMBO[i]).ReadOnly) and ((grdTabella.medpCompCella(Row,CAMPI_COMBO[i],0) as TMedpIWMultiColumnComboBox) <> nil) then
    begin
      with (grdTabella.medpCompCella(Row,CAMPI_COMBO[i],0) as TMedpIWMultiColumnComboBox) do
      begin
        // obbligatorio: combobox con valori [S | N]
        ColumnSeparator:=';';
        ColCount:=1;
        Items.Clear;
        AddRow(' ');
        AddRow('S');
        AddRow('N');
        Text:=grdTabella.medpValoreColonna(Row,CAMPI_COMBO[i]);
      end;
    end;
  end;

  for i:=Low(CAMPI_TABELLA) to High(CAMPI_TABELLA) do
  begin
    if not grdTabella.medpDataSet.FieldByName(CAMPI_TABELLA[i]).ReadOnly then
      TWA115FIterAutorizzativi(Self.Owner).CreaBtnTabellaSelI094(grdTabella, TWA115FIterAutorizzativiDM(WR302DM).selTabella, CAMPI_TABELLA[i],Row);
  end;
end;

procedure TWA115FIterAutorizzativiBrowseFM.IWFrameRegionCreate(Sender: TObject);
var
  i:Integer;
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;

  for i:=Low(CAMPI_COMBO) to High(CAMPI_COMBO) do
  begin
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna(CAMPI_COMBO[i]),0,DBG_MECMB,'1','1','null','','S');
  end;

  for i:=Low(CAMPI_DI_TESTO) to High(CAMPI_DI_TESTO) do
  begin
    if not grdTabella.medpDataSet.FieldByName(CAMPI_DI_TESTO[i]).ReadOnly then
    begin
      grdTabella.medpPreparaComponenteGenerico('WR102',CAMPI_DI_TESTO[i],0,DBG_LBL,'50','','null','','S');
      grdTabella.medpPreparaComponenteGenerico('WR102',CAMPI_DI_TESTO[i],1,DBG_IMG,'','PUNTINI','','','D');
    end;
  end;

  for i:=Low(CAMPI_TABELLA) to High(CAMPI_TABELLA) do
  begin
    if not grdTabella.medpDataSet.FieldByName(CAMPI_TABELLA[i]).ReadOnly then
    begin
      grdTabella.medpPreparaComponenteGenerico('WR102',CAMPI_TABELLA[i],0,DBG_LBL,'50','','null','','S');
      grdTabella.medpPreparaComponenteGenerico('WR102',CAMPI_TABELLA[i],1,DBG_IMG,'','PUNTINI','','','D');
    end;
  end;

  grdTabella.Summary:=NOME_BROWSE;
  grdTabella.Caption:=Format(grdTabella.Caption, [TWA115FIterAutorizzativiDM(WR302DM).A115MW.AziendaCorrente]);
  grdTabella.RigaInserimento:=False;
  grdTabella.medpEditMultiplo:=False;
  grdTabella.medpPaginazione:=False;
  grdTabella.medpCaricaCDS;
end;

{ selI94 }

procedure TWA115FIterAutorizzativiBrowseFM.grdselI094preparaComponenti(Sender: TObject);
begin
 with TWC015FSelEditGridFM(Sender).grdElenco do
  begin
    medpPreparaComponenteGenerico('WR102',medpIndexColonna('EXPR_DATA'),0,DBG_MEMO,'40','2','null','','S');
    medpPreparaComponenteGenerico('WR102',medpIndexColonna('STATO'),0,DBG_CMB,'1','','null','','S');
    medpPreparaComponenteGenerico('WR102',medpIndexColonna('D_RIEPILOGO') ,0,DBG_CMB,'20','','null','','S');
  end;
end;

procedure TWA115FIterAutorizzativiBrowseFM.grdselI094DataSet2Componenti(Sender: TObject;Row: Integer);
begin
  with TWC015FSelEditGridFM(Sender).grdElenco do
  begin
    TmeIWMemo(medpCompCella(Row,medpIndexColonna('EXPR_DATA'),0)).Text:=medpClientDataSet.FieldByName('EXPR_DATA').AsString;
    TmeIWComboBox(medpCompCella(Row,medpIndexColonna('STATO'),0)).Items.Add(' ');
    TmeIWComboBox(medpCompCella(Row,medpIndexColonna('STATO'),0)).Items.Add('C');
    TmeIWComboBox(medpCompCella(Row,medpIndexColonna('STATO'),0)).Items.Add('A');
    TmeIWComboBox(medpCompCella(Row,medpIndexColonna('STATO'),0)).ItemIndex:=StrToInt(IfThen(Row > 0,IntToStr(TmeIWComboBox(medpCompCella(Row,medpIndexColonna('STATO'),0)).Items.IndexOf(medpValoreColonna(Row,'STATO'))),'0'));
  end;

  with TWA115FIterAutorizzativiDM(WR302DM).A115MW.cdsBloccoRiep do
  begin
    First;
    TmeIWComboBox(TWC015FSelEditGridFM(Sender).grdElenco.medpCompCella(Row,(TWC015FSelEditGridFM(Sender).grdElenco.medpIndexColonna('D_RIEPILOGO')),0)).Items.Add(' ');
    while not Eof do
    begin
      TmeIWComboBox(TWC015FSelEditGridFM(Sender).grdElenco.medpCompCella(Row,TWC015FSelEditGridFM(Sender).grdElenco.medpIndexColonna('D_RIEPILOGO'),0)).Items.Add(FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
    TmeIWComboBox(TWC015FSelEditGridFM(Sender).grdElenco.medpCompCella(Row,TWC015FSelEditGridFM(Sender).grdElenco.medpIndexColonna('D_RIEPILOGO'),0)).ItemIndex:=0;
  end;
end;

procedure TWA115FIterAutorizzativiBrowseFM.grdselI094Componenti2DataSet(Sender: TObject;Row: Integer);
var
  strTmp:String;
begin
  with TWC015FSelEditGridFM(Sender).grdElenco do
  begin
    medpDataSet.FieldByName('EXPR_DATA').AsString:=TmeIWMemo(medpCompCella(Row,medpIndexColonna('EXPR_DATA'),0)).text;
    medpDataSet.FieldByName('STATO').AsString:=TmeIWComboBox(medpCompCella(Row,medpIndexColonna('STATO'),0)).text;
  end;

  with TWA115FIterAutorizzativiDM(WR302DM).A115MW.cdsBloccoRiep do
  begin
    First;
    while not Eof do
    begin
      strTmp:=TmeIWComboBox(TWC015FSelEditGridFM(Sender).grdElenco.medpCompCella(Row,TWC015FSelEditGridFM(Sender).grdElenco.medpIndexColonna('D_RIEPILOGO'),0)).text;
      if FieldByName('DESCRIZIONE').AsString = strTmp then
      begin
        TWC015FSelEditGridFM(Sender).grdElenco.medpDataSet.FieldByName('RIEPILOGO').AsString:=FieldByName('CODICE').AsString;
        break;
      end;
      Next;
    end;
  end;
end;

end.
