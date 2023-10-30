unit WA102UParScaricoGiustifDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWDBExtCtrls, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWDBRadioGroup, IWCompCheckbox, meIWDBCheckBox, IWCompButton,
  meIWButton, A000UInterfaccia,
  IWDBGrids, medpIWDBGrid, meIWGrid,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, meIWEdit, meIWDBComboBox,
  IWCompListbox, meIWDBLookupComboBox, Math, StrUtils, IWAdvRadioGroup,
  meTIWAdvRadioGroup, IWCompGrids, IWCompJQueryWidget, meIWLabel, DB,
  meIWCheckBox, IWCompMemo, meIWDBMemo;

type
  TWA102FParScaricoGiustifDettFM = class(TWR205FDettTabellaFM)
    lblNomeScarico: TmeIWLabel;
    lblAzienda: TmeIWLabel;
    dchkScaricoAutomatico: TmeIWDBCheckBox;
    lblCodiciTipi: TmeIWLabel;
    lblGiustifGiornInt: TmeIWLabel;
    lblGiustifMezzaGiorn: TmeIWLabel;
    dedtGiustifGiornInt: TmeIWDBEdit;
    dedtGiustifMezzaGiorn: TmeIWDBEdit;
    lblParametriFile: TmeIWLabel;
    lblNomeFile: TmeIWLabel;
    dedtNomeScarico: TmeIWDBEdit;
    grdMappatura: TmeIWGrid;
    lblMappatura: TmeIWLabel;
    dedtNomeFile: TmeIWDBEdit;
    dcmbAzienda: TmeIWDBLookupComboBox;
    lblGiustifDaA: TmeIWLabel;
    lblGiustifNumOre: TmeIWLabel;
    dedtGiustifDaA: TmeIWDBEdit;
    dedtGiustifNumOre: TmeIWDBEdit;
    lblCampiSeparatiDa: TmeIWLabel;
    dedtCampiSeparatiDa: TmeIWDBEdit;
    lblFormatoData: TmeIWLabel;
    dcmbFormatoData: TmeIWDBComboBox;
    dchkMatricolaNumerica: TmeIWDBCheckBox;
    dchkRiconoscimentoCausale: TmeIWDBCheckBox;
    dchkAnnullamentoPeriodo: TmeIWDBCheckBox;
    rgpStrutturaDati: TmeTIWAdvRadioGroup;
    dmemExprChiave: TmeIWDBMemo;
    chkExprChiave: TmeIWCheckBox;
    dchkOracleDopo: TmeIWDBCheckBox;
    dchkOraclePrima: TmeIWDBCheckBox;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdMappaturaRenderCell(ACell: TIWGridCell; const ARow,AColumn: Integer);
    procedure rgpStrutturaDatiClick(Sender: TObject);
    procedure chkExprChiaveClick(Sender: TObject);
  private
    procedure MostraNascondiElementi;
  public
    procedure AttivaGrid(ActiveEdit:Boolean);
    procedure DataSet2Componenti; override;
    procedure AbilitaComponenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaColonneGrid;
  end;

implementation

uses WA102UParScaricoGiustif, WA102UParScaricoGiustifDM, WR100UBase;

{$R *.dfm}

procedure TWA102FParScaricoGiustifDettFM.IWFrameRegionCreate(Sender: TObject);
var i:Integer;
begin
  inherited;
  grdMappatura.RowCount:=3;
  grdMappatura.ColumnCount:=27;
  grdMappatura.Cell[0,0].Text:='';
  grdMappatura.Cell[1,0].Text:='Pos.';
  grdMappatura.Cell[2,0].Text:='Lung.';
  with TWA102FParScaricoGiustifDM(WR302DM) do
    for i:=1 to grdMappatura.ColumnCount - 1 do
      grdMappatura.Cell[0,i].Text:=selTabella.FieldByName(GetNomeCampo(i)).DisplayLabel;
  dcmbAzienda.ListSource:=TWA102FParScaricoGiustifDM(WR302DM).dsrI090;
end;

procedure TWA102FParScaricoGiustifDettFM.DataSet2Componenti;
var i,P:Byte;
    S:String;
begin
  with (WR302DM as TWA102FParScaricoGiustifDM) do
  begin
    CaricaColonneGrid;
    if selTabella.FieldByName('TIPOFILE').AsString = 'F' then
      rgpStrutturaDati.ItemIndex:=0
    else if selTabella.FieldByName('TIPOFILE').AsString = 'T' then
      rgpStrutturaDati.ItemIndex:=1
    else if selTabella.FieldByName('TIPOFILE').AsString = 'R' then
      rgpStrutturaDati.ItemIndex:=2;

    for i:=1 to grdMappatura.ColumnCount - 1 do
    begin
      S:=selTabella.FieldByName(GetNomeCampo(i)).AsString;
      if selTabella.FieldByName('TIPOFILE').AsString = 'F' then
      begin
        P:=Pos(',',S);
        grdMappatura.Cell[1,i].Text:=Copy(S,1,P - 1);
        grdMappatura.Cell[2,i].Text:=Copy(S,P + 1,Length(S));
      end
      else if selTabella.FieldByName('TIPOFILE').AsString = 'T' then
        grdMappatura.Cell[1,i].Text:=S;
    end;
  end;
  //se la struttura dati è "richieste web" tutti i componenti inutilizzati diventano invisibili
  MostraNascondiElementi;
end;

procedure TWA102FParScaricoGiustifDettFM.CaricaColonneGrid;
var i:Integer;
begin
  with TWA102FParScaricoGiustifDM(WR302DM) do
  begin
    if selTabella.FieldByName('TIPOFILE').AsString = 'F' then
    begin
      lblParametriFile.Caption:='Parametri file sequenziale';
      lblNomeFile.Caption:='Path e nome file';
      lblMappatura.Caption:='Mappatura dei dati sul file di input';
      grdMappatura.ColumnCount:=19;
      grdMappatura.RowCount:=3;
      grdMappatura.Cell[1,0].Text:='Pos.';
      grdMappatura.Cell[2,0].Text:='Lung.';
    end
    else if selTabella.FieldByName('TIPOFILE').AsString = 'T' then
    begin
      lblParametriFile.Caption:='Parametri tabella Oracle';
      lblNomeFile.Caption:='Nome tabella Oracle';
      lblMappatura.Caption:='Mappatura dei dati nella tabella Oracle';
      grdMappatura.RowCount:=2;
      grdMappatura.ColumnCount:=27;
    end;
    with TWA102FParScaricoGiustifDM(WR302DM) do
      for i:=1 to grdMappatura.ColumnCount - 1 do
        grdMappatura.Cell[0,i].Text:=selTabella.FieldByName(GetNomeCampo(i)).DisplayLabel;
  end;
end;

procedure TWA102FParScaricoGiustifDettFM.chkExprChiaveClick(Sender: TObject);
begin
  dmemExprChiave.Css:='width70chr height10 fontcourier' + IfThen(not chkExprChiave.Checked,' nascosto');

  // se il check è disattivo pulisce il campo
  if not chkExprChiave.Checked then
  begin
    if WR302DM.selTabella.State in [dsInsert,dsEdit] then
      WR302DM.selTabella.FieldByName('EXPR_CHIAVE').AsString:='';
  end;
end;

procedure TWA102FParScaricoGiustifDettFM.AbilitaComponenti;
begin
  with TWA102FParScaricoGiustifDM(WR302DM) do
  begin
    if selTabella.State in [dsInsert, dsEdit] then
    begin
      lblCampiSeparatiDa.Enabled:=selTabella.FieldByName('TIPOFILE').AsString <> 'T';
      dedtCampiSeparatiDa.Enabled:=selTabella.FieldByName('TIPOFILE').AsString <> 'T';;
    end;
    AttivaGrid(selTabella.State in [dsInsert, dsEdit]);
  end;
end;

procedure TWA102FParScaricoGiustifDettFM.AttivaGrid(ActiveEdit : Boolean);
var
  i: Integer;
begin
  if ActiveEdit then
  begin
    for i:=1 to grdMappatura.ColumnCount - 1 do
    begin
      grdMappatura.Cell[1,i].Control:=TmeIWEdit.Create(Self);
      TmeIWEdit(grdMappatura.Cell[1,i].Control).Text:=grdMappatura.Cell[1,i].Text;
      TmeIWEdit(grdMappatura.Cell[1,i].Control).Css:=IfThen(rgpStrutturaDati.ItemIndex = 0,'input5','width10chr');
      grdMappatura.Cell[1,i].Text:='';
      if TWA102FParScaricoGiustifDM(WR302DM).selTabella.FieldByName('TIPOFILE').AsString = 'F' then
      begin
        grdMappatura.Cell[2,i].Control:=TmeIWEdit.Create(Self);;
        TmeIWEdit(grdMappatura.Cell[2,i].Control).Text:=grdMappatura.Cell[2,i].Text;
        TmeIWEdit(grdMappatura.Cell[2,i].Control).Css:='input5';
        grdMappatura.Cell[2,i].Text:='';
      end;
    end;
  end
  else
  begin
    for i := 1 to (grdMappatura.ColumnCount - 1) do
    begin
      grdMappatura.Cell[1,i].Control:=nil;
      if rgpStrutturaDati.ItemIndex = 0 then
        grdMappatura.Cell[2,i].Control:=nil;
    end;
  end;
end;

procedure TWA102FParScaricoGiustifDettFM.grdMappaturaRenderCell(ACell: TIWGridCell;const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin

  if not C190RenderCell(ACell,ARow,AColumn,True,False,False) then
    Exit;

  if AColumn = 0 then
    ACell.Css:='riga_intestazione';
end;

procedure TWA102FParScaricoGiustifDettFM.Componenti2DataSet;
var i,P,L:Byte;
begin
  inherited;
  with TWA102FParScaricoGiustifDM(WR302DM) do
  begin
    if rgpStrutturaDati.ItemIndex = 0 then
      selTabella.FieldByName('TIPOFILE').AsString:='F'
    else if rgpStrutturaDati.ItemIndex = 1 then
      selTabella.FieldByName('TIPOFILE').AsString:='T'
    else if rgpStrutturaDati.ItemIndex = 2 then
      selTabella.FieldByName('TIPOFILE').AsString:='R';

    for i:=1 to grdMappatura.ColumnCount - 1 do
    begin
      if selTabella.FieldByName('TIPOFILE').AsString = 'T' then
        selTabella.FieldByName(GetNomeCampo(i)).AsString:=TmeIWEdit(grdMappatura.Cell[1,i].Control).Text
      else if selTabella.FieldByName('TIPOFILE').AsString = 'F' then
      begin
        P:=StrToIntDef(TmeIWEdit(grdMappatura.Cell[1,i].Control).Text,0);
        L:=StrToIntDef(TmeIWEdit(grdMappatura.Cell[2,i].Control).Text,0);
        selTabella.FieldByName(GetNomeCampo(i)).AsString:=IntToStr(P) + ',' + IntToStr(L);
      end
      else if selTabella.FieldByName('TIPOFILE').AsString = 'R' then
      begin
        selTabella.FieldByName('NOMEFILE').AsString:='(na)';
        selTabella.FieldByName('CAUSALE').AsString:='(na)';
        selTabella.FieldByName('MATRICOLA').AsString:='(na)';
        selTabella.FieldByName('CHIAVE').Clear;
        selTabella.FieldByName('EXPR_CHIAVE').Clear;
      end;
    end;
  end;
end;

procedure TWA102FParScaricoGiustifDettFM.rgpStrutturaDatiClick(Sender: TObject);
var
  i,P:Byte;
  S:String;
begin
  inherited;
  if rgpStrutturaDati.ItemIndex = 0 then
    TWA102FParScaricoGiustifDM(WR302DM).selTabella.FieldByName('TIPOFILE').AsString:='F'
  else if rgpStrutturaDati.ItemIndex = 1 then
    TWA102FParScaricoGiustifDM(WR302DM).selTabella.FieldByName('TIPOFILE').AsString:='T'
  else if rgpStrutturaDati.ItemIndex = 2 then
    TWA102FParScaricoGiustifDM(WR302DM).selTabella.FieldByName('TIPOFILE').AsString:='R';
  //funzioni
  CaricaColonneGrid;
  for i:=1 to grdMappatura.ColumnCount - 1 do
  begin
    if rgpStrutturaDati.ItemIndex = 0 then
    begin
      grdMappatura.Cell[1,i].Text:='0';
      grdMappatura.Cell[2,i].Text:='0';
    end
    else if rgpStrutturaDati.ItemIndex = 1 then
      grdMappatura.Cell[1,i].Text:='';
  end;
  AbilitaComponenti;
  //se la struttura dati è "richieste web" tutti i componenti inutilizzati diventano invisibili
  MostraNascondiElementi;
end;

procedure TWA102FParScaricoGiustifDettFM.MostraNascondiElementi;
begin
  dchkOraclePrima.Visible:=rgpStrutturaDati.ItemIndex <> 2;
  dchkOracleDopo.Visible:=rgpStrutturaDati.ItemIndex <> 2;
  lblParametriFile.Visible:=rgpStrutturaDati.ItemIndex <> 2;
  lblNomeFile.Visible:=rgpStrutturaDati.ItemIndex <> 2;
  dedtNomeFile.Visible:=rgpStrutturaDati.ItemIndex <> 2;
  lblCodiciTipi.Visible:=rgpStrutturaDati.ItemIndex <> 2;
  lblGiustifGiornInt.Visible:=rgpStrutturaDati.ItemIndex <> 2;
  dedtGiustifGiornInt.Visible:=rgpStrutturaDati.ItemIndex <> 2;
  lblGiustifMezzaGiorn.Visible:=rgpStrutturaDati.ItemIndex <> 2;
  dedtGiustifMezzaGiorn.Visible:=rgpStrutturaDati.ItemIndex <> 2;
  lblCampiSeparatiDa.Visible:=rgpStrutturaDati.ItemIndex <> 2;
  dedtCampiSeparatiDa.Visible:=rgpStrutturaDati.ItemIndex <> 2;
  lblFormatoData.Visible:=rgpStrutturaDati.ItemIndex <> 2;
  dcmbFormatoData.Visible:=rgpStrutturaDati.ItemIndex <> 2;
  lblGiustifDaA.Visible:=rgpStrutturaDati.ItemIndex <> 2;
  dedtGiustifDaA.Visible:=rgpStrutturaDati.ItemIndex <> 2;
  lblGiustifNumOre.Visible:=rgpStrutturaDati.ItemIndex <> 2;
  dedtGiustifNumOre.Visible:=rgpStrutturaDati.ItemIndex <> 2;
  dchkMatricolaNumerica.Visible:=rgpStrutturaDati.ItemIndex <> 2;
  dchkRiconoscimentoCausale.Visible:=rgpStrutturaDati.ItemIndex <> 2;
  dchkAnnullamentoPeriodo.Visible:=rgpStrutturaDati.ItemIndex <> 2;
  chkExprChiave.Visible:=rgpStrutturaDati.ItemIndex <> 2;
  dmemExprChiave.Visible:=rgpStrutturaDati.ItemIndex <> 2;
  lblMappatura.Visible:=rgpStrutturaDati.ItemIndex <> 2;
  grdMappatura.Visible:=rgpStrutturaDati.ItemIndex <> 2;
  C190VisualizzaElemento(JQuery,'divFile',rgpStrutturaDati.ItemIndex <> 2);
  C190VisualizzaElemento(JQuery,'divGiustificativi',rgpStrutturaDati.ItemIndex <> 2);
  C190VisualizzaElemento(JQuery,'divChiave',rgpStrutturaDati.ItemIndex <> 2);
  C190VisualizzaElemento(JQuery,'divMappatura',rgpStrutturaDati.ItemIndex <> 2);
end;

end.
