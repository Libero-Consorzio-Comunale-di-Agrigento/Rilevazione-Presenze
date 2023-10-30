unit WA204UDatiCertificazioneDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, Vcl.Menus, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  Oracle, OracleData, Data.DB, C190FunzioniGeneraliWeb,
  meIWEdit, medpIWMultiColumnComboBox, meIWLabel;

type
  TWA204FDatiCertificazioneDettFM = class(TWR203FGestDetailFM)
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
  end;

implementation

uses
  WA204UModelliCertificazione, WA204UModelliCertificazioneDM, A000UCostanti;

{$R *.dfm}

procedure TWA204FDatiCertificazioneDettFM.CaricaDettaglio(DataSet: TDataSet; DataSource: TDataSource);
begin
  inherited;
  grdTabella.medpPaginazione:=True;
  grdTabella.medpRighePagina:=50;
  grdTabella.medpEditMultiplo:=False;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('OBBLIGATORIO'),0,DBG_MECMB,'1','1','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('FORMATO'),0,DBG_MECMB,'1','1','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('ELENCO_FISSO'),0,DBG_MECMB,'1','1','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DATO_ANAGRAFICO'),0,DBG_MECMB,'10','1','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('QUERY_VALORE'),0,DBG_MECMB,'10','1','null','','S');

  grdTabella.medpPreparaComponenteGenerico('WR102','DESCRIZIONE_CALC',0,DBG_LBL,'50','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102','DESCRIZIONE_CALC',1,DBG_IMG,'','PUNTINI','','','D');
  grdTabella.medpPreparaComponenteGenerico('WR102','VALORI_CALC',0,DBG_LBL,'50','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102','VALORI_CALC',1,DBG_IMG,'','PUNTINI','','','D');
  grdTabella.medpPreparaComponenteGenerico('WR102','VALIDAZIONE_CALC',0,DBG_LBL,'50','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102','VALIDAZIONE_CALC',1,DBG_IMG,'','PUNTINI','','','D');
  grdTabella.medpPreparaComponenteGenerico('WR102','HINT_CALC',0,DBG_LBL,'50','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102','HINT_CALC',1,DBG_IMG,'','PUNTINI','','','D');

  grdTabella.medpCaricaCDS;
end;

procedure TWA204FDatiCertificazioneDettFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  with TWA204FModelliCertificazioneDM(WR302DM).selSG237 do
  begin
    FieldByName('DESCRIZIONE').AsString:=StringReplace(Trim((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DESCRIZIONE_CALC'),0) as TmeIWLabel).Text), CRLF, '<br>',[rfReplaceAll]);
    FieldByName('VALORI').AsString:=StringReplace(Trim((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('VALORI_CALC'),0) as TmeIWLabel).Text), CRLF, '<br>',[rfReplaceAll]);
    FieldByName('VALIDAZIONE').AsString:=StringReplace(Trim((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('VALIDAZIONE_CALC'),0) as TmeIWLabel).Text), CRLF, '<br>',[rfReplaceAll]);
    FieldByName('HINT').AsString:=StringReplace(Trim((grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('HINT_CALC'),0) as TmeIWLabel).Text), CRLF, '<br>',[rfReplaceAll]);
  end;
end;

procedure TWA204FDatiCertificazioneDettFM.grdTabellaDataSet2Componenti(Row: Integer);
var
  DS: TOracleDataSet;
begin
  inherited;

  TWA204FModelliCertificazione(Self.Owner).CreaBtnTesto(grdTabella, TWA204FModelliCertificazioneDM(WR302DM).selSG237, 'DESCRIZIONE_CALC',Row);
  TWA204FModelliCertificazione(Self.Owner).CreaBtnTesto(grdTabella, TWA204FModelliCertificazioneDM(WR302DM).selSG237, 'VALORI_CALC',Row);
  TWA204FModelliCertificazione(Self.Owner).CreaBtnTesto(grdTabella, TWA204FModelliCertificazioneDM(WR302DM).selSG237, 'VALIDAZIONE_CALC',Row);
  TWA204FModelliCertificazione(Self.Owner).CreaBtnTesto(grdTabella, TWA204FModelliCertificazioneDM(WR302DM).selSG237, 'HINT_CALC',Row);

  // obbligatorio: combobox con valori [S | N]
  with (grdTabella.medpCompCella(Row,'OBBLIGATORIO',0) as TMedpIWMultiColumnComboBox) do
  begin
    ColumnSeparator:=';';
    ColCount:=2;
    Items.Clear;
    AddRow('S;Sì');
    AddRow('N;No');
    Text:=grdTabella.medpValoreColonna(Row,'OBBLIGATORIO');
  end;

  // formato: combobox con valori
  with (grdTabella.medpCompCella(Row,'FORMATO',0) as TMedpIWMultiColumnComboBox) do
  begin
    ColumnSeparator:=';';
    ColCount:=2;
    Items.Clear;
    AddRow('S;Stringa');
    AddRow('C;Checkbox');
    AddRow('N;Numero');
    AddRow('D;Data');
    AddRow('M;Messaggio');
    AddRow('U;Url');
    AddRow('T;Testo su due colonne');
    Text:=grdTabella.medpValoreColonna(Row,'FORMATO');
  end;

  // lunghezza max
  with (grdTabella.medpCompCella(Row,'LUNG_MAX',0) as TmeIWEdit) do
  begin
    Hint:='<html>0 = Limite massimo (2000 caratteri)';
    ShowHint:=True;
  end;

  // elenco fisso: combobox con valori [S | N]
  with (grdTabella.medpCompCella(Row,'ELENCO_FISSO',0) as TMedpIWMultiColumnComboBox) do
  begin
    ColumnSeparator:=';';
    ColCount:=2;
    Items.Clear;
    AddRow('S;Sì');
    AddRow('N;No');
    Text:=grdTabella.medpValoreColonna(Row,'ELENCO_FISSO');
  end;

  // dato anagrafico: combobox con elenco
  with (grdTabella.medpCompCella(Row,'DATO_ANAGRAFICO',0) as TMedpIWMultiColumnComboBox) do
  begin
    PopUpHeight:=10;
    Items.Clear;

    DS:=TWA204FModelliCertificazioneDM(WR302DM).A204MW.selT430Colonne;
    DS.Open;
    DS.First;
    while not DS.Eof do
    begin
      AddRow(DS.FieldByName('COLUMN_NAME').AsString);
      DS.Next;
    end;
    Text:=grdTabella.medpValoreColonna(Row,'DATO_ANAGRAFICO');
  end;

  // interrogazioni servizio: combobox con elenco
  with (grdTabella.medpCompCella(Row,'QUERY_VALORE',0) as TMedpIWMultiColumnComboBox) do
  begin
    PopUpHeight:=10;
    Items.Clear;

    DS:=TWA204FModelliCertificazioneDM(WR302DM).A204MW.selT002;
    DS.Open;
    DS.First;
    while not DS.Eof do
    begin
      AddRow(DS.FieldByName('NOME').AsString);
      DS.Next;
    end;
    Text:=grdTabella.medpValoreColonna(Row,'QUERY_VALORE');
  end;
end;

end.
