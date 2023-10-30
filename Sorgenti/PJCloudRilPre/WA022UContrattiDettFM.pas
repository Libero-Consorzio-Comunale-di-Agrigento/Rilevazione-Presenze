unit WA022UContrattiDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWDBExtCtrls, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWDBRadioGroup, A000UMessaggi,
  meIWLabel,
  IWCompCheckbox, meIWDBCheckBox, Db,
  meIWEdit, IWDBGrids, medpIWDBGrid, MedpIWMulticolumnComboBox, IWCompListbox,
  WA012UVisualizzaCalendarioFM, medpIWMessageDlg, A000UInterfaccia,
  C190FunzioniGeneraliWeb, C180FunzioniGenerali, IWCompExtCtrls, IWCompGrids,
  IWCompJQueryWidget, WC020UInputDataOreFM, meIWComboBox, meIWImageFile,
  medpIWImageButton;

type
  TWA022FContrattiDettFM = class(TWR205FDettTabellaFM)
    lblCodice: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    grdFasce: TmedpIWDBGrid;
    lblTipoIndennita: TmeIWLabel;
    lblTipoContratto: TmeIWLabel;
    lblDecorrenza: TmeIWLabel;
    dedtDecorrenza: TmeIWDBEdit;
    drgpTipoContratto: TmeIWDBRadioGroup;
    drgpTipoIndennita: TmeIWDBRadioGroup;
    lblDurataReperibilita: TmeIWLabel;
    dedtDurataReperibilita: TmeIWDBEdit;
    lblMaxStraordinario: TmeIWLabel;
    dedtMaxStraordinario: TmeIWDBEdit;
    lblMaxEccedenza: TmeIWLabel;
    dedtMaxEccedenza: TmeIWDBEdit;
    lblArrotondamentoIndennita: TmeIWLabel;
    dedtArrotondamentoIndennita: TmeIWDBEdit;
    dchkOreLavFasceConAss: TmeIWDBCheckBox;
    lblFasciaIndennitaNotturna: TmeIWLabel;
    lblDalle: TmeIWLabel;
    lblAlle: TmeIWLabel;
    dedtIndNotteDa: TmeIWDBEdit;
    dedtIndNotteA: TmeIWDBEdit;
    dedtArrotondamento: TmeIWDBEdit;
    lblArrotondamento: TmeIWLabel;
    lblTolleranza: TmeIWLabel;
    dedtTolleranza: TmeIWDBEdit;
    grdOreSupplementari: TmedpIWDBGrid;
    cmbT203Decorrenza: TmeIWComboBox;
    lblT203Decorrenza: TmeIWLabel;
    imgT203Storicizza: TmeIWImageFile;
    grdFasceAziendali: TmedpIWDBGrid;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdFasceRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdFasceDataSet2Componenti(Row:Integer);
    procedure grdFasceComponenti2DataSet(Row: Integer);
    // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.ini
    procedure Intf_T200AfterScroll;
    procedure imgT203StoricizzaClick(Sender: TObject);
    procedure cmbT203DecorrenzaChange(Sender: TObject);
    // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.fine
  private
    // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.ini
    procedure ResultNuovaDecorrenza(Sender: TObject; Result: Boolean;
      Valore: String);
    // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.fine
  public
    procedure AbilitaComponenti; override;
    procedure DataSet2Componenti; override;
  end;

implementation

uses WA022UContrattiDM, WA022UContratti, WR100UBase;

{$R *.dfm}

procedure TWA022FContrattiDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  //attivazione gestione Tab JQuery
  JQuery.OnReady.Text:=Format(W000JQ_Tabs,[Name]);

  grdFasce.medpAttivaGrid(TWA022FContrattiDM(TWA022FContratti(Self.Parent).WR302DM).T201,False,False);

  //Si aggiunge +1 perchè in modifica compare la colonna con i bottoni di editing
  grdFasce.medpPreparaComponenteGenerico('WR102',grdFasce.medpIndexColonna('FASCIADA1')+1,0,DBG_EDT,'ORA2','','','','S');
  grdFasce.medpPreparaComponenteGenerico('WR102',grdFasce.medpIndexColonna('FASCIAA1')+1,0,DBG_EDT,'ORA2','','','','S');
  grdFasce.medpPreparaComponenteGenerico('WR102',grdFasce.medpIndexColonna('MAGGIOR1')+1,0,DBG_MECMB,'10','2','','','S');
  grdFasce.medpPreparaComponenteGenerico('WR102',grdFasce.medpIndexColonna('FASCIADA2')+1,0,DBG_EDT,'ORA2','','','','S');
  grdFasce.medpPreparaComponenteGenerico('WR102',grdFasce.medpIndexColonna('FASCIAA2')+1,0,DBG_EDT,'ORA2','','','','S');
  grdFasce.medpPreparaComponenteGenerico('WR102',grdFasce.medpIndexColonna('MAGGIOR2')+1,0,DBG_MECMB,'10','2','','','S');
  grdFasce.medpPreparaComponenteGenerico('WR102',grdFasce.medpIndexColonna('FASCIADA3')+1,0,DBG_EDT,'ORA2','','','','S');
  grdFasce.medpPreparaComponenteGenerico('WR102',grdFasce.medpIndexColonna('FASCIAA3')+1,0,DBG_EDT,'ORA2','','','','S');
  grdFasce.medpPreparaComponenteGenerico('WR102',grdFasce.medpIndexColonna('MAGGIOR3')+1,0,DBG_MECMB,'10','2','','','S');
  grdFasce.medpPreparaComponenteGenerico('WR102',grdFasce.medpIndexColonna('FASCIADA4')+1,0,DBG_EDT,'ORA2','','','','S');
  grdFasce.medpPreparaComponenteGenerico('WR102',grdFasce.medpIndexColonna('FASCIAA4')+1,0,DBG_EDT,'ORA2','','','','S');
  grdFasce.medpPreparaComponenteGenerico('WR102',grdFasce.medpIndexColonna('MAGGIOR4')+1,0,DBG_MECMB,'10','2','','','S');

  // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.ini
  TWA022FContrattiDM(WR302DM).A022MW.selT203.Open;
  grdOreSupplementari.medpAttivaGrid(TWA022FContrattiDM(WR302DM).A022MW.selT203,False,False,False);
  TWA022FContrattiDM(WR302DM).A022MW.Intf_T200AfterScroll:=Intf_T200AfterScroll;
  Intf_T200AfterScroll;
  // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.fine
end;

// AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.ini
procedure TWA022FContrattiDettFM.Intf_T200AfterScroll;
begin
  // imposta decorrenza nulla
  TWA022FContrattiDM(WR302DM).A022MW.Decorrenza:=DATE_NULL;

  // popola combobox decorrenze
  cmbT203Decorrenza.Items.Clear;
  cmbT203Decorrenza.Items.AddStrings(TWA022FContrattiDM(WR302DM).A022MW.lstT203Decorrenze);
  if TWA022FContrattiDM(WR302DM).A022MW.DecorrenzaCorrente > 0 then
  begin
    cmbT203Decorrenza.ItemIndex:=cmbT203Decorrenza.Items.IndexOf(DateToStr(TWA022FContrattiDM(WR302DM).A022MW.DecorrenzaCorrente));
    TWA022FContrattiDM(WR302DM).A022MW.Decorrenza:=TWA022FContrattiDM(WR302DM).A022MW.DecorrenzaCorrente;
  end;

  // carica grid
  grdOreSupplementari.medpCaricaCDS;
end;
// AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.fine

// AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.ini
procedure TWA022FContrattiDettFM.cmbT203DecorrenzaChange(Sender: TObject);
begin
  inherited;
  // imposta decorrenza
  TWA022FContrattiDM(WR302DM).A022MW.Decorrenza:=StrToDate(cmbT203Decorrenza.Text);

  // carica grid
  grdOreSupplementari.medpCaricaCDS;
end;
// AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.fine

procedure TWA022FContrattiDettFM.DataSet2Componenti;
begin
  with TWA022FContrattiDM(WR302DM) do
  begin
    T201.Close;
    T201.SetVariable('Codice',selTabella.FieldByname('Codice').AsString);
    T201.Open;
  end;
  if grdFasce.medpDataSet <> nil then
    grdFasce.medpCaricaCDS;
end;

procedure TWA022FContrattiDettFM.AbilitaComponenti;
begin
  grdFasce.medpAttivaGrid(TWA022FContrattiDM(WR302DM).T201,(WR302DM.selTabella.State in [dsInsert,dsEdit]),False);
  // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.ini
  grdOreSupplementari.medpAttivaGrid(TWA022FContrattiDM(WR302DM).A022MW.selT203,(WR302DM.selTabella.State in [dsInsert,dsEdit]),False);
  // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.fine

  // MONDOEDP - Commessa: MAN/08 SVILUPPO#238.ini
  //grdFasceAziendali.medpComandiCustom:=True;
  grdFasceAziendali.medpRowSelect:=False;
  grdFasceAziendali.medpPaginazione:=True;
  grdFasceAziendali.medpRighePagina:=20;
  grdFasceAziendali.medpAttivaGrid(((Self.Parent as TWA022FContratti).WR302DM as TWA022FContrattiDM).T210,(WR302DM.selTabella.State in [dsInsert,dsEdit]),
                                                                                                          (WR302DM.selTabella.State in [dsInsert,dsEdit]),
                                                                                                          (WR302DM.selTabella.State in [dsInsert,dsEdit]));
  // MONDOEDP - Commessa: MAN/08 SVILUPPO#238.fine
end;

procedure TWA022FContrattiDettFM.grdFasceDataSet2Componenti(Row:Integer);
var
  Item:String;
  function getFormattedText(NomeColonna : String) : String;
  var
    Str: String;
  begin
    Str:=grdFasce.medpValoreColonna(Row, NomeColonna);

    if (Str = '')  then
      Result:=''
    else
      Result:=FormatDateTime('hh:mm', StrToDateTime(Str));
    end;
begin
  TmeIWEdit(grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('FASCIADA1'),0)).Text:=getFormattedText('FASCIADA1');
  TmeIWEdit(grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('FASCIAA1'),0)).Text:=getFormattedText('FASCIAA1');

  TmeIWEdit(grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('FASCIADA2'),0)).Text:=getFormattedText('FASCIADA2');
  TmeIWEdit(grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('FASCIAA2'),0)).Text:=getFormattedText('FASCIAA2');

  TmeIWEdit(grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('FASCIADA3'),0)).Text:=getFormattedText('FASCIADA3');
  TmeIWEdit(grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('FASCIAA3'),0)).Text:=getFormattedText('FASCIAA3');

  TmeIWEdit(grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('FASCIADA4'),0)).Text:=getFormattedText('FASCIADA4');
  TmeIWEdit(grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('FASCIAA4'),0)).Text:=getFormattedText('FASCIAA4');

  with TWA022FContrattiDM(TWA022FContratti(Self.Parent).WR302DM) do
  begin
    T210.First;
    while not T210.Eof do
    begin
      Item:=T210.FieldByName('CODICE').AsString + ';' + T210.FieldByName('DESCRIZIONE').AsString;
      (grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('MAGGIOR1'),0) as TMedpIWMultiColumnComboBox).AddRow(Item);
      (grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('MAGGIOR2'),0) as TMedpIWMultiColumnComboBox).AddRow(Item);
      (grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('MAGGIOR3'),0) as TMedpIWMultiColumnComboBox).AddRow(Item);
      (grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('MAGGIOR4'),0) as TMedpIWMultiColumnComboBox).AddRow(Item);
      T210.Next;
    end;
    with (grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('MAGGIOR1'),0) as TMedpIWMultiColumnComboBox) do
    begin
      Text:=grdFasce.medpValoreColonna(Row, 'MAGGIOR1');
      PopupHeight:=10;
    end;

    with (grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('MAGGIOR2'),0) as TMedpIWMultiColumnComboBox) do
    begin
      Text:=grdFasce.medpValoreColonna(Row, 'MAGGIOR2');
      PopupHeight:=10;
    end;

    with (grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('MAGGIOR3'),0) as TMedpIWMultiColumnComboBox) do
    begin
      Text:=grdFasce.medpValoreColonna(Row, 'MAGGIOR3');
      PopupHeight:=10;
    end;

    with (grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('MAGGIOR4'),0) as TMedpIWMultiColumnComboBox) do
    begin
      Text:=grdFasce.medpValoreColonna(Row, 'MAGGIOR4');
      PopupHeight:=10;
    end;
  end;
end;

procedure TWA022FContrattiDettFM.grdFasceComponenti2DataSet(Row: Integer);
begin
  grdFasce.medpDataSet.FieldByName('FASCIADA1').AsDateTime:=StrToDateTime('01/01/1900 ' + TmeIWEdit(grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('FASCIADA1'),0)).Text);
  grdFasce.medpDataSet.FieldByName('FASCIAA1').AsDateTime:=StrToDateTime('01/01/1900 ' + TmeIWEdit(grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('FASCIAA1'),0)).Text);

  grdFasce.medpDataSet.FieldByName('FASCIADA2').AsDateTime:=StrToDateTime('01/01/1900 ' + TmeIWEdit(grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('FASCIADA2'),0)).Text);
  grdFasce.medpDataSet.FieldByName('FASCIAA2').AsDateTime:=StrToDateTime('01/01/1900 ' + TmeIWEdit(grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('FASCIAA2'),0)).Text);

  grdFasce.medpDataSet.FieldByName('FASCIADA3').AsDateTime:=StrToDateTime('01/01/1900 ' + TmeIWEdit(grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('FASCIADA3'),0)).Text);
  grdFasce.medpDataSet.FieldByName('FASCIAA3').AsDateTime:=StrToDateTime('01/01/1900 ' + TmeIWEdit(grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('FASCIAA3'),0)).Text);

  grdFasce.medpDataSet.FieldByName('FASCIADA4').AsString:=TmeIWEdit(grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('FASCIADA4'),0)).Text;
  grdFasce.medpDataSet.FieldByName('FASCIAA4').AsString:=TmeIWEdit(grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('FASCIAA4'),0)).Text;

  grdFasce.medpDataSet.FieldByName('MAGGIOR1').AsString:=(grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('MAGGIOR1'),0) as TMedpIWMulticolumnComboBox ).Text;
  grdFasce.medpDataSet.FieldByName('MAGGIOR2').AsString:=(grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('MAGGIOR2'),0) as TMedpIWMulticolumnComboBox).Text;
  grdFasce.medpDataSet.FieldByName('MAGGIOR3').AsString:=(grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('MAGGIOR3'),0) as TMedpIWMulticolumnComboBox).Text;
  grdFasce.medpDataSet.FieldByName('MAGGIOR4').AsString:=(grdFasce.medpCompCella(Row,grdFasce.medpIndexColonna('MAGGIOR4'),0) as TMedpIWMulticolumnComboBox).Text;
end;

procedure TWA022FContrattiDettFM.grdFasceRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdFasce.medpNumColonna(AColumn);

  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdFasce.medpCompGriglia) + 1) and (grdFasce.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    if AColumn = 1 then
      Exit;
    ACell.Text:='';
    ACell.Control:=grdFasce.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

// AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.ini
procedure TWA022FContrattiDettFM.imgT203StoricizzaClick(Sender: TObject);
var
  WC020: TWC020FInputDataOreFM;
begin
  WC020:=TWC020FInputDataOreFM.Create(Self.Parent);
  WC020.ImpostaCampiData('Nuova decorrenza:',Date,'mm/yyyy');
  WC020.ResultEvent:=ResultNuovaDecorrenza;
  WC020.Visualizza('Nuova decorrenza ore supplementari');
end;

procedure TWA022FContrattiDettFM.ResultNuovaDecorrenza(Sender: TObject; Result: Boolean; Valore: String);
var
  D: TDateTime;
begin
  if Result then
  begin
    if not TryStrToDate(Valore,D) then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_DATA_DECORRENZA));

    D:=R180InizioMese(D);
    if not TWA022FContrattiDM(WR302DM).A022MW.CheckT203Decorrenza(D) then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_DECORRENZA_DUPLICATA));
    TWA022FContrattiDM(WR302DM).A022MW.AddT203Decorrenza(D);
    Intf_T200AfterScroll;
  end;
end;
// AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.fine

end.
