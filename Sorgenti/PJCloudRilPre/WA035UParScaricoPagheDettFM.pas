unit WA035UParScaricoPagheDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWDBExtCtrls, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWDBRadioGroup,
  IWCompCheckbox, meIWDBCheckBox, IWCompButton,
  meIWButton, A000UInterfaccia,
  IWDBGrids, medpIWDBGrid, meIWGrid,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, meIWEdit, meIWDBComboBox,
  IWCompListbox, meIWDBLookupComboBox, Math, StrUtils, IWAdvRadioGroup,
  meTIWAdvRadioGroup, IWCompGrids, IWCompExtCtrls, IWCompJQueryWidget, meIWLabel,DB,
  MedpIWMultiColumnComboBox;

type
  TWA035FParScaricoPagheDettFM = class(TWR205FDettTabellaFM)
    lblCodice: TmeIWLabel;
    lblDescrizione: TmeIWLabel;
    dchkSalvataggioAutomatico: TmeIWDBCheckBox;
    lblNomeFile: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
    lblMappatura: TmeIWLabel;
    dedtNomeFile: TmeIWDBEdit;
    lblFormatoData: TmeIWLabel;
    dcmbFormatoData: TmeIWDBComboBox;
    rgpTipoSupporto: TmeTIWAdvRadioGroup;
    dedtDescrizione: TmeIWDBEdit;
    dchkRicreazioneAutomatica: TmeIWDBCheckBox;
    lblUtentePaghe: TmeIWLabel;
    dedtUtentePaghe: TmeIWDBEdit;
    lblNomeEnte: TmeIWLabel;
    dedtNomeEnte: TmeIWDBEdit;
    lblDatiOrari: TmeIWLabel;
    drgpDatiOrari: TmeIWDBRadioGroup;
    rgpPrecisione: TmeTIWAdvRadioGroup;
    lblSeparatore: TmeIWLabel;
    drgpSeparatore: TmeIWDBRadioGroup;
    lblData: TmeIWLabel;
    lblTipoData: TmeIWLabel;
    drgpTipoData: TmeIWDBRadioGroup;
    grdMappatura: TmedpIWDBGrid;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdMappaturaRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure grdMappaturaDataSet2Componenti(Row: Integer);
    procedure grdMappaturaComponenti2DataSet(Row: Integer);
    procedure rgpPrecisioneClick(Sender: TObject);
    procedure rgpTipoSupportoClick(Sender: TObject);
  private
    CambiaStatoGrid : boolean;
    procedure cmbTipoChange(Sender: TObject; Index: Integer);
    procedure DataSet2Componenti; override;
    procedure AbilitaComponenti; override;
    procedure Componenti2DataSet; override;
  public
  end;

implementation

uses WA035UParScaricoPaghe, WA035UParScaricoPagheDM, WR100UBase;

{$R *.dfm}

procedure TWA035FParScaricoPagheDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdMappatura.medpPaginazione:=False;
  CambiaStatoGrid:=true;

  grdMappatura.medpAttivaGrid(TWA035FParScaricoPagheDM(TWA035FParScaricoPaghe(Self.Parent).WR302DM).Q192,False,False);

  grdMappatura.medpPreparaComponenteGenerico('WR102',grdMappatura.medpIndexColonna('TIPO')+1,0,DBG_MECMB,'5','2','','','S');
  grdMappatura.medpPreparaComponenteGenerico('WR102',grdMappatura.medpIndexColonna('NOME')+1,0,DBG_EDT,'10','','','','S');
  grdMappatura.medpPreparaComponenteGenerico('WR102',grdMappatura.medpIndexColonna('POS')+1,0,DBG_EDT,'5','','','','S');
  grdMappatura.medpPreparaComponenteGenerico('WR102',grdMappatura.medpIndexColonna('LUNG')+1,0,DBG_EDT,'5','','','','S');
  grdMappatura.medpPreparaComponenteGenerico('WR102',grdMappatura.medpIndexColonna('DEF')+1,0,DBG_EDT,'10','','','','S');
end;

procedure TWA035FParScaricoPagheDettFM.DataSet2Componenti;
begin
  inherited;
  with TWA035FParScaricoPagheDM(WR302DM) do
  begin
    rgpPrecisione.ItemIndex:=StrToInt(selTabella.FieldByName('precisione').AsString);

    if selTabella.FieldByName('TIPOFILE').AsString = 'F' then
      rgpTipoSupporto.ItemIndex:=0
    else
      rgpTipoSupporto.ItemIndex:=1;

    Q192.Close;
    Q192.SetVariable('CODICE',selTabella.FieldByName('CODICE').AsString);
    Q192.SetVariable('TIPOPAR',TWA035FParScaricoPaghe(Self.Owner).VoceMenu);
    Q192.Open;
    if grdMappatura.medpDataSet <> nil then
      grdMappatura.medpCaricaCDS;
  end;
end;

procedure TWA035FParScaricoPagheDettFM.AbilitaComponenti;
begin
  inherited;
  with TWA035FParScaricoPagheDM(WR302DM) do
  begin
    if (selTabella.State in [dsInsert,dsEdit])then
    begin
      dedtUtentePaghe.Enabled:=selTabella.FieldByName('TIPOFILE').AsString <> 'F';
      dchkSalvataggioAutomatico.Enabled:=dedtUtentePaghe.Enabled;
      dchkRicreazioneAutomatica.Enabled:=dedtUtentePaghe.Enabled;

      drgpSeparatore.Enabled:=selTabella.FieldByName('precisione').AsString = '2';
    end;

    if CambiaStatoGrid then
      grdMappatura.medpAttivaGrid(Q192,(selTabella.State in [dsInsert,dsEdit]),(selTabella.State in [dsInsert,dsEdit]));
  end;
end;

procedure TWA035FParScaricoPagheDettFM.Componenti2DataSet;
begin
  inherited;
  with TWA035FParScaricoPagheDM(WR302DM) do
  begin
    selTabella.FieldByName('PRECISIONE').AsString:=IntToStr(rgpPrecisione.ItemIndex);
    if rgpTipoSupporto.ItemIndex = 0 then
      selTabella.FieldByName('TIPOFILE').AsString:='F'
    else if rgpTipoSupporto.ItemIndex = 1 then
      selTabella.FieldByName('TIPOFILE').AsString:='T';
    end;
end;

procedure TWA035FParScaricoPagheDettFM.rgpPrecisioneClick(Sender: TObject);
begin
  inherited;
  TWA035FParScaricoPagheDM(WR302DM).selTabella.FieldByName('PRECISIONE').AsString:=IntToStr(rgpPrecisione.ItemIndex);
  CambiaStatoGrid:=false;
  AbilitaComponenti;
  CambiaStatoGrid:=true;
end;

procedure TWA035FParScaricoPagheDettFM.rgpTipoSupportoClick(Sender: TObject);
begin
  inherited;
  if rgpTipoSupporto.ItemIndex = 0 then
    TWA035FParScaricoPagheDM(WR302DM).selTabella.FieldByName('TIPOFILE').AsString:='F'
  else if rgpTipoSupporto.ItemIndex = 1 then
    TWA035FParScaricoPagheDM(WR302DM).selTabella.FieldByName('TIPOFILE').AsString:='T';
  CambiaStatoGrid:=false;
  AbilitaComponenti;
  CambiaStatoGrid:=true;
end;

procedure TWA035FParScaricoPagheDettFM.grdMappaturaDataSet2Componenti(Row: Integer);
begin
  inherited;
  if TWA035FParScaricoPaghe(Self.Parent).VoceMenu = cParPaghe then
  begin
    with (grdMappatura.medpCompCella(Row,grdMappatura.medpIndexColonna('TIPO'),0) as TMedpIWMultiColumnComboBox ) do
    begin
      Items.Clear;
      AddRow('0;FILLER');
      AddRow('1;ENTE');
      AddRow('2;DATA');
      AddRow('3;MATRICOLA');
      AddRow('4;BADGE');
      AddRow('5;COD. INTERNO');
      AddRow('6;COD. PAGHE');
      AddRow('7;SEGNO');
      AddRow('8;VALORE');
      AddRow('9;MISURA');
      AddRow('A;DA DATA');
      AddRow('B;A DATA');
      AddRow('C;RIFERIMENTO');
      AddRow('D;DA ORE');
      AddRow('E;A ORE');
      AddRow('F;DATA DI CASSA');
      AddRow('G;IMPORTO');
      AddRow('H;DATO ANAGRAFICO');
      AddRow('I;CAPITOLO');
      AddRow('L;ARTICOLO');
      PopupHeight:=10;
    end;
  end
  else if TWA035FParScaricoPaghe(Self.Parent).VoceMenu = cParContab then
  begin
    with (grdMappatura.medpCompCella(Row,grdMappatura.medpIndexColonna('TIPO'),0) as TMedpIWMultiColumnComboBox) do
    begin
      Items.Clear;
      AddRow('0;FILLER');
      AddRow('1;DATA ELABORAZIONE');
      AddRow('2;TOTALE DARE');
      AddRow('3;TOTALE AVERE');
      AddRow('4;N. RIGHE DETT. D/A SU STESSA RIGA');
      AddRow('5;N. RIGHE DETT. D/A SU DUE RIGHE');
      AddRow('6;PROGRESSIVO RIGA');
      AddRow('7;ID-CONTO');
      AddRow('8;SEGNO IMPORTO');
      AddRow('9;IMPORTO');
      AddRow('A;DARE AVERE');
      AddRow('B;SEGNO IMP. DARE');
      AddRow('C;IMPORTO_DARE');
      AddRow('D;SEGNO IMP. AVERE');
      AddRow('E;IMPORTO_AVERE');
      AddRow('F;DATA ESPORTAZIONE');
      AddRow('G;DATA COMPETENZA');
      AddRow('H;DESCRIZIONE CONTO');
      PopupHeight:=10;
    end;
  end;
  with (grdMappatura.medpCompCella(Row,grdMappatura.medpIndexColonna('TIPO'),0) as TMedpIWMultiColumnComboBox) do
  begin
    Text:=grdMappatura.medpValoreColonna(Row, 'TIPO');
    OnChange:=cmbTipoChange;
  end;

  TmeIWEdit(grdMappatura.medpCompCella(Row,grdMappatura.medpIndexColonna('NOME'),0)).Text:=grdMappatura.medpValoreColonna(Row, 'NOME');
  TmeIWEdit(grdMappatura.medpCompCella(Row,grdMappatura.medpIndexColonna('POS'),0)).Text:=grdMappatura.medpValoreColonna(Row, 'POS');
  TmeIWEdit(grdMappatura.medpCompCella(Row,grdMappatura.medpIndexColonna('LUNG'),0)).Text:=grdMappatura.medpValoreColonna(Row, 'LUNG');
  TmeIWEdit(grdMappatura.medpCompCella(Row,grdMappatura.medpIndexColonna('DEF'),0)).Text:=grdMappatura.medpValoreColonna(Row, 'DEF');
end;

procedure TWA035FParScaricoPagheDettFM.cmbTipoChange(Sender: TObject; Index: Integer);
begin
  grdMappatura.medpClientDataSet.Edit;
  grdMappatura.medpClientDataSet.FieldByName('D_TIPO').AsString:=(Sender as TMedpIWMultiColumnComboBox).Items[Index].RowData[1];
  grdMappatura.medpClientDataSet.Post;
end;

procedure TWA035FParScaricoPagheDettFM.grdMappaturaComponenti2DataSet(
  Row: Integer);
begin
  inherited;
  grdMappatura.medpDataSet.FieldByName('TIPO').AsString:=(grdMappatura.medpCompCella(Row,grdMappatura.medpIndexColonna('TIPO'),0) as TMedpIWMultiColumnComboBox).Text;
  grdMappatura.medpDataSet.FieldByName('D_TIPO').AsString:=grdMappatura.medpValoreColonna(Row, 'D_TIPO');
  grdMappatura.medpDataSet.FieldByName('NOME').AsString:=TmeIWEdit(grdMappatura.medpCompCella(Row,grdMappatura.medpIndexColonna('NOME'),0)).Text;
  grdMappatura.medpDataSet.FieldByName('POS').AsString:=TmeIWEdit(grdMappatura.medpCompCella(Row,grdMappatura.medpIndexColonna('POS'),0)).Text;
  grdMappatura.medpDataSet.FieldByName('LUNG').AsString:=TmeIWEdit(grdMappatura.medpCompCella(Row,grdMappatura.medpIndexColonna('LUNG'),0)).Text;
  grdMappatura.medpDataSet.FieldByName('DEF').AsString:=TmeIWEdit(grdMappatura.medpCompCella(Row,grdMappatura.medpIndexColonna('DEF'),0)).Text;
end;

procedure TWA035FParScaricoPagheDettFM.grdMappaturaRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdMappatura.medpNumColonna(AColumn);

  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdMappatura.medpCompGriglia) + 1) and (grdMappatura.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdMappatura.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

end.
