unit WA100UIndennitaKMFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompGrids, meIWGrid, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, medpIWMessageDlg, DB, OracleData,
  MedpIWMultiColumnComboBox,  WA100UMissioniDM, meIWImageFile,
  C190FunzioniGeneraliWeb, meIWLabel, meIWEdit, WA100UDistanzeChilometricheFM,
  IWCompEdit, IWDBStdCtrls, meIWDBEdit, IWCompLabel, A000UInterfaccia, Vcl.Menus;

type
  TWA100FIndennitaKMFM = class(TWR203FGestDetailFM)
    lblTotaleB: TmeIWLabel;
    dedtKmTotaliIndennitaKm: TmeIWDBEdit;
    dedtImportiTotaliIndennitaKm: TmeIWDBEdit;
    pmnTipoIndennita: TPopupMenu;
    Accedi1: TMenuItem;
    procedure actConfermaExecute(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
    procedure Accedi1Click(Sender: TObject);
  private
    RowEdit: Integer;
    comboTipoIndennita: TMedpIWMultiColumnComboBox;
    procedure cmbCodIndKMAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure imgDistanzeChilometricheClick(Sender: TObject);
    procedure ResultDistanzeChilometriche(Res: Boolean; km: Double);
  protected
    procedure ResultDelete(Sender: TObject; R: TmeIWModalResult; KI: String); override;
  public
    procedure CaricaComboTipoIndennita;
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
  end;

implementation uses WA100UMissioni;

{$R *.dfm}

procedure TWA100FIndennitaKMFM.Accedi1Click(Sender: TObject);
var params: String;
begin
  inherited;
  Params:='CODICE=' + (pmnTipoIndennita.PopupComponent as TMedpIWMultiColumnComboBox).Text;
  (Self.Parent as TWA100FMissioni).AccediForm(157,Params,False);
end;

procedure TWA100FIndennitaKMFM.actConfermaExecute(Sender: TObject);
begin
  inherited;
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    //Per cloud fare sempre ApplyUpdates perchè in cachedUpdate (Su win lo fa toolbarfiglio)
    SessioneOracle.ApplyUpdates([QM052], True);
    //ricalcola totali dovo aver modificato
   CalcolaTotaliIndennitaKm;
  end;
end;

procedure TWA100FIndennitaKMFM.CaricaDettaglio(DataSet: TDataSet; DataSource: TDataSource);
begin
  inherited;
  //Indennita KM
  dedtKmTotaliIndennitaKm.DataSource:=WR302DM.dsrTabella;
  dedtImportiTotaliIndennitaKm.DataSource:=WR302DM.dsrTabella;

  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CODICEINDENNITAKM'),0,DBG_MECMB,'5','2','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DESCRIZIONE'),0,DBG_LBL,'50','1','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('IMPORTOUNITARIO'),0,DBG_LBL,'10','1','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('KMPERCORSI'),0,DBG_EDT,'input_num_generic','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('KMPERCORSI'),1,DBG_IMG,'','CAMBIADATO','','','D');
end;

//cambio label sul cambio della combo
procedure TWA100FIndennitaKMFM.cmbCodIndKMAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
var cmb: TMedpIWMultiColumnComboBox;
begin
  cmb:=(Sender as TMedpIWMultiColumnComboBox);
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    grdTabella.medpDataset.FieldByName('CODICEINDENNITAKM').AsString:=cmb.Text;
    //Descrizione e importo km sono lookup di CODICEINDENNITAKM
    (grdTabella.medpCompCella(cmb.Tag,grdTabella.medpIndexColonna('DESCRIZIONE'),0) as TmeIWLabel).Caption:=grdTabella.medpDataset.FieldByName('DESCRIZIONE').AsString;
    //Importo KM
    (grdTabella.medpCompCella(cmb.Tag,grdTabella.medpIndexColonna('IMPORTOUNITARIO'),0) as TmeIWLabel).Caption:=grdTabella.medpDataset.FieldByName('IMPORTOUNITARIO').AsString;
  end;
end;

procedure TWA100FIndennitaKMFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  //Reset filtro combo
  with ((Self.Parent as TWA100FMissioni).WR302DM as TWA100FMissioniDM) do
    A100FMissioniMW.FiltraRegoleIndennita(False);
end;

procedure TWA100FIndennitaKMFM.CaricaComboTipoIndennita;
begin
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    QM021.First;
    comboTipoIndennita.items.clear;
    while not QM021.Eof do
    begin
      comboTipoIndennita.AddRow(QM021.FieldByName('CODICE').AsString + ';' + QM021.FieldByName('DESCRIZIONE').AsString);
      QM021.Next;
    end;
  end;
end;

procedure TWA100FIndennitaKMFM.grdTabellaDataSet2Componenti(Row: Integer);
var img: TmeIWImageFile;
begin
  inherited;
  //Filtro su combo
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    FiltraRegoleIndennita;

    comboTipoIndennita:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CODICEINDENNITAKM'),0) as TMedpIWMultiColumnComboBox );
    comboTipoIndennita.Tag:=Row;
    comboTipoIndennita.Items.Clear;
    comboTipoIndennita.PopupHeight:=10;

    CaricaComboTipoIndennita;
    comboTipoIndennita.OnAsyncChange:=cmbCodIndKMAsyncChange;
    comboTipoIndennita.medpContextMenu:=pmnTipoIndennita;
  end;
  //Descrizione
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DESCRIZIONE'),0) as TmeIWLabel).Caption:=grdTabella.medpValoreColonna(Row, 'DESCRIZIONE');

  //Importo KM
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('IMPORTOUNITARIO'),0) as TmeIWLabel).Caption:=grdTabella.medpValoreColonna(Row, 'IMPORTOUNITARIO');

  img:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('KMPERCORSI'),1) as TmeIWImageFile);
  img.Tag:=Row;
  img.OnClick:=imgDistanzeChilometricheClick;
end;

procedure TWA100FIndennitaKMFM.ResultDelete(Sender: TObject;
  R: TmeIWModalResult; KI: String);
begin
  inherited;
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    //Per cloud fare sempre ApplyUpdates perchè in cachedUpdate (Su win lo fa toolbarfiglio)
    SessioneOracle.ApplyUpdates([QM052], True);

    //ricalcola totali dovo aver modificato
    CalcolaTotaliIndennitaKm;
  end;
end;

procedure TWA100FIndennitaKMFM.ResultDistanzeChilometriche(Res:Boolean; km: Double);
begin
  if Res then
  begin
    (grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('KMPERCORSI'),0) as TmeIWEdit).Text:=FloatToStr(km);
  end;
end;

procedure TWA100FIndennitaKMFM.imgDistanzeChilometricheClick(Sender: TObject);
var WA100DistFM:TWA100FDistanzeChilometricheFM;
begin
  RowEdit:=(Sender as TmeIWImageFile).Tag;
  with (WR302DM as TWA100FMissioniDM) do
  begin
    A100FMissioniMW.ImpostaSelM041;

    WA100DistFM:=TWA100FDistanzeChilometricheFM.Create(Self.Parent);
    WA100DistFM.ResultEvent:=ResultDistanzeChilometriche;
    WA100DistFM.DataSet:=A100FMissioniMW.SelM041;
    WA100DistFM.Visualizza;
  end;
end;

end.
