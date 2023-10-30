unit WA111UTracciatoFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompGrids, meIWGrid, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, C190FunzioniGeneraliWeb,
  meIWComboBox, medpIWMultiColumnComboBox, meIWEdit, OracleData, DB,
  C180FunzioniGenerali, Vcl.Menus;

type
  TWA111FTracciatoFM = class(TWR203FGestDetailFM)
    procedure grdTabellaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
    procedure cmbTipoChange(Sender: TObject);
    procedure actNuovoExecute(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);
    procedure actEliminaExecute(Sender: TObject); override;
  private
    { Private declarations }
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
    procedure PreparaComponenti;
    procedure AssegnaPickList(Row:Integer;Tipo:String);
  public
    { Public declarations }
  end;

var
  WA111FTracciatoFM: TWA111FTracciatoFM;

implementation

uses WA111UParMessaggiDM, WA111UParMessaggi, A000UInterfaccia;

{$R *.dfm}

procedure TWA111FTracciatoFM.CaricaDettaglio(DataSet: TDataSet; DataSource: TDataSource);
begin
  grdTabella.medpEditMultiplo:=False;
  inherited;
  PreparaComponenti;
end;

procedure TWA111FTracciatoFM.PreparaComponenti;
begin
  grdTabella.medpPreparaComponentiDefault;
  with (WR302DM as TWA111FParMessaggiDM).A111MW.selT292 do
  begin
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TIPO_RECORD'),0,DBG_CMB,'2','','','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TIPO'),0,DBG_CMB,'2','','','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('NOME_COLONNA'),0,DBG_EDT,'20','','','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('POSIZIONE'),0,DBG_EDT,'2','','','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('VALORE_DEFAULT'),0,DBG_MECMB,'30','1','','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('FORMATO'),0,DBG_MECMB,'20','1','','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CODICE_DATO'),0,DBG_MECMB,'20','1','','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CHIAVE'),0,DBG_CMB,'1','','','','S');

    //  MONDOEDP - chiamata 82423.ini
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('NUMERO_RECORD'),0,DBG_EDT,'input_num_nnn','','','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('POSIZIONE'),0,DBG_EDT,'input_num_nnn','','','','S');
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('LUNGHEZZA'),0,DBG_EDT,'input_num_nnn','','','','S');
    //  MONDOEDP - chiamata 82423.fine
  end;
end;

procedure TWA111FTracciatoFM.grdTabellaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
begin
  inherited;
  grdTabella.medpColonna('NOME_COLONNA').Visible:=(WR302DM as TWA111FParMessaggiDM).A111MW.selT291.FieldByName('TIPO_FILE').AsString = 'O';
  grdTabella.medpColonna('POSIZIONE').Visible:=(WR302DM as TWA111FParMessaggiDM).A111MW.selT291.FieldByName('TIPO_FILE').AsString = 'A';
end;

procedure TWA111FTracciatoFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;
  AssegnaPickList(Row,(WR302DM as TWA111FParMessaggiDM).A111MW.selT292.FieldByName('TIPO').AsString);
  //Carico combo TIPO_RECORD
  if grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TIPO_RECORD'),0) <> nil then
    with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TIPO_RECORD'),0) as TmeIWComboBox) do
    begin
      RequireSelection:=False;
      NoSelectionText:=' ';
      ItemIndex:=Items.IndexOf((WR302DM as TWA111FParMessaggiDM).A111MW.selT292.FieldByName('TIPO_RECORD').AsString);
    end;
  //Carico combo TIPO
  if grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TIPO'),0) <> nil then
    with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TIPO'),0) as TmeIWComboBox) do
    begin
      OnChange:=cmbTipoChange;
      RequireSelection:=False;
      NoSelectionText:=' ';
      ItemIndex:=R180IndexOf(Items,(WR302DM as TWA111FParMessaggiDM).A111MW.selT292.FieldByName('TIPO').AsString,2);
    end;

  //  MONDOEDP - chiamata 82423.ini
  {
  // Imposto edit NUMERO_RECORD
  if grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('NUMERO_RECORD'),0) <> nil then
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('NUMERO_RECORD'),0) as TmeIWEdit).Css:='input_num_nnn';
  // Imposto edit POSIZIONE
  if grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('POSIZIONE'),0) <> nil then
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('POSIZIONE'),0) as TmeIWEdit).Css:='input_num_nnn';
  // Imposto edit LUNGHEZZA
  if grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('LUNGHEZZA'),0) <> nil then
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('LUNGHEZZA'),0) as TmeIWEdit).Css:='input_num_nnn';
  }
  //  MONDOEDP - chiamata 82423.fine

  // Carico combo VALORE_DEFAULT
  if grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('VALORE_DEFAULT'),0) <> nil then
    with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('VALORE_DEFAULT'),0) as TmedpIWMultiColumnComboBox) do
    begin
      Tag:=Row;
      Text:=(WR302DM as TWA111FParMessaggiDM).A111MW.selT292.FieldByName('VALORE_DEFAULT').AsString;
    end;
  // Carico combo FORMATO
  if grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('FORMATO'),0) <> nil then
    with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('FORMATO'),0) as TmedpIWMultiColumnComboBox) do
    begin
      Tag:=Row;
      Text:=(WR302DM as TWA111FParMessaggiDM).A111MW.selT292.FieldByName('FORMATO').AsString;
    end;
  //Carico combo CODICE_DATO
  if grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CODICE_DATO'),0) <> nil then
    with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CODICE_DATO'),0) as TmedpIWMultiColumnComboBox) do
    begin
      Tag:=Row;
      Text:=(WR302DM as TWA111FParMessaggiDM).A111MW.selT292.FieldByName('CODICE_DATO').AsString;
    end;
  //Carico combo CHIAVE
  if grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CHIAVE'),0) <> nil then
    with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CHIAVE'),0) as TmeIWComboBox) do
    begin
      RequireSelection:=True;
      ItemIndex:=Items.IndexOf((WR302DM as TWA111FParMessaggiDM).A111MW.selT292.FieldByName('CHIAVE').AsString);
    end;
end;

procedure TWA111FTracciatoFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  with (WR302DM as TWA111FParMessaggiDM).A111MW.selT292 do
  begin
    FieldByName('TIPO_RECORD').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TIPO_RECORD'),0) as TmeIWComboBox).Text;
    FieldByName('TIPO').AsString:=Trim(Copy((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TIPO'),0) as TmeIWComboBox).Text,1,2));
    FieldByName('VALORE_DEFAULT').AsString:=Trim((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('VALORE_DEFAULT'),0) as TmedpIWMultiColumnComboBox).Text);
    FieldByName('FORMATO').AsString:=Trim((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('FORMATO'),0) as TmedpIWMultiColumnComboBox).Text);
    FieldByName('CODICE_DATO').AsString:=Trim((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CODICE_DATO'),0) as TmedpIWMultiColumnComboBox).Text);
    FieldByName('CHIAVE').AsString:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CHIAVE'),0) as TmeIWComboBox).Text;
  end;
end;

procedure TWA111FTracciatoFM.cmbTipoChange(Sender: TObject);
var r: Integer;
begin
  inherited;
  r:=grdTabella.medpRigaDiCompGriglia((Sender as TmeIWComboBox).FriendlyName);
  AssegnaPickList(r,Copy((Sender as TmeIWComboBox).Text,1,2));
  // Pulisco combo VALORE_DEFAULT
  if grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('VALORE_DEFAULT'),0) <> nil then
    (grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('VALORE_DEFAULT'),0) as TmedpIWMultiColumnComboBox).Text:='';
  // Pulisco combo FORMATO
  if grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('FORMATO'),0) <> nil then
    (grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('FORMATO'),0) as TmedpIWMultiColumnComboBox).Text:='';
end;

procedure TWA111FTracciatoFM.actNuovoExecute(Sender: TObject);
begin
  if not ((WR302DM as TWA111FParMessaggiDM).A111MW.selT291.State = dsEdit) then
    exit;
  inherited;
end;

procedure TWA111FTracciatoFM.actModificaExecute(Sender: TObject);
begin
  if not ((WR302DM as TWA111FParMessaggiDM).A111MW.selT291.State = dsEdit) then
    exit;
  inherited;
end;

procedure TWA111FTracciatoFM.actEliminaExecute(Sender: TObject);
begin
  if not ((WR302DM as TWA111FParMessaggiDM).A111MW.selT291.State = dsEdit) then
    exit;
  inherited;
end;

procedure TWA111FTracciatoFM.AssegnaPickList(Row:Integer;Tipo:String);
var i,x:Integer;
begin
  with (WR302DM as TWA111FParMessaggiDM).A111MW do
    for i:=0 to grdTabella.Columns.Count - 1 do
      if (grdTabella.medpCompCella(Row,i,0) <> nil) then
      begin
        //Svuoto picklist
        if (grdTabella.medpCompCella(Row,i,0) is TmeIWComboBox) then
          (grdTabella.medpCompCella(Row,i,0) as TmeIWComboBox).Items.Clear
        else if (grdTabella.medpCompCella(Row,i,0) is TmedpIWMultiColumnComboBox) then
          (grdTabella.medpCompCella(Row,i,0) as TmedpIWMultiColumnComboBox).Items.Clear;
        //Assegno picklist
        if i = grdTabella.medpIndexColonna('TIPO_RECORD') then
          (grdTabella.medpCompCella(Row,i,0) as TmeIWComboBox).Items.Assign(PLTipoRecord)
        else if i = grdTabella.medpIndexColonna('TIPO') then
          (grdTabella.medpCompCella(Row,i,0) as TmeIWComboBox).Items.Assign(PLTipo)
        else if i = grdTabella.medpIndexColonna('VALORE_DEFAULT') then
        begin
          if Tipo = 'FI' then
            for x:=0 to PLDefaultFill.Count - 1 do
              (grdTabella.medpCompCella(Row,i,0) as TmedpIWMultiColumnComboBox).AddRow(PLDefaultFill[x])
          else if Tipo = 'VL' then
            for x:=0 to PLDefaultVal.Count - 1 do
              (grdTabella.medpCompCella(Row,i,0) as TmedpIWMultiColumnComboBox).AddRow(PLDefaultVal[x])
          else if Tipo = 'DE' then
            for x:=0 to PLDefaultDesc.Count - 1 do
              (grdTabella.medpCompCella(Row,i,0) as TmedpIWMultiColumnComboBox).AddRow(PLDefaultDesc[x])
          else if Tipo = 'AN' then
            for x:=0 to PLDefaultAnag.Count - 1 do
              (grdTabella.medpCompCella(Row,i,0) as TmedpIWMultiColumnComboBox).AddRow(PLDefaultAnag[x]);
        end
        else if i = grdTabella.medpIndexColonna('FORMATO') then
        begin
          if (Tipo = 'DT') or (Tipo = 'DC') or (Tipo = 'DS') then
            for x:=0 to PLFormatoData.Count - 1 do
              (grdTabella.medpCompCella(Row,i,0) as TmedpIWMultiColumnComboBox).AddRow(PLFormatoData[x])
          else if Tipo = 'VL' then
            for x:=0 to PLFormatoVal.Count - 1 do
              (grdTabella.medpCompCella(Row,i,0) as TmedpIWMultiColumnComboBox).AddRow(PLFormatoVal[x])
          else if Tipo = 'DE' then
            for x:=0 to PLFormatoDesc.Count - 1 do
              (grdTabella.medpCompCella(Row,i,0) as TmedpIWMultiColumnComboBox).AddRow(PLFormatoDesc[x]);
        end
        else if i = grdTabella.medpIndexColonna('CODICE_DATO') then
          for x:=0 to PLCodDato.Count - 1 do
            (grdTabella.medpCompCella(Row,i,0) as TmedpIWMultiColumnComboBox).AddRow(PLCodDato[x])
        else if i = grdTabella.medpIndexColonna('CHIAVE') then
          (grdTabella.medpCompCella(Row,i,0) as TmeIWComboBox).Items.Assign(PLChiave);
      end;
end;

end.
