unit WP684URisorseDettDefinizioneFondiFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, Vcl.Menus, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  Data.DB, C190FunzioniGeneraliWeb, A000UCostanti, A000UInterfaccia,
  medpIWMultiColumnComboBox, meIWComboBox, meIWLabel, meIWEdit, meIWImageFile;

type
  TWP684FRisorseDettDefinizioneFondiFM = class(TWR203FGestDetailFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure actCopiaSuExecute(Sender: TObject);
  private
    RowEdit: Integer;
    procedure cmbCodVoceGenAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbCodArrotondamentoAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure edtDataRiferimentoAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure edtQuantitaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure imgSelAnagrafeClick(Sender: TObject);
    procedure ResultSelAnagrafe(Sender: TObject; Result: Boolean);
    procedure edtDatoBaseAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure edtMoltiplicatoreAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure edtImportoAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure DataChange;
  public
    procedure DataSourceStateChange(Sender: TObject); override;
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
  end;

implementation

uses WP684UDefinizioneFondi, WP684UDefinizioneFondiDM;

{$R *.dfm}

procedure TWP684FRisorseDettDefinizioneFondiFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpEditMultiplo:=False;
end;

procedure TWP684FRisorseDettDefinizioneFondiFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  with (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW do
  begin
    if TmedpIWMultiColumnComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_VOCE_GEN'),0)) <> nil then
      selP688R.FieldByName('COD_VOCE_GEN').AsString:=TmedpIWMultiColumnComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_VOCE_GEN'),0)).Text;
    selP688R.FieldByName('COD_ARROTONDAMENTO').AsString:=TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_ARROTONDAMENTO'),0)).Text;
  end;
end;

procedure TWP684FRisorseDettDefinizioneFondiFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;
  if TmedpIWMultiColumnComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_VOCE_GEN'),0)) <> nil then
  begin
    with TmedpIWMultiColumnComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_VOCE_GEN'),0)) do
    begin
      MaxLength:=5;
      Tag:=Row;
      Items.Clear;
      with (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW.selP686R do
      begin
        First;
        while not Eof do
        begin
          AddRow(FieldByName('COD_VOCE_GEN').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
          Next;
        end;
      end;
      OnAsyncChange:=cmbCodVoceGenAsyncChange;
    end;
  end;

  with TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_ARROTONDAMENTO'),0)) do
  begin
    Items.Clear;
    Items.Add('');
    ItemIndex:=0;
    with (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW.selP050 do
    begin
      First;
      while not Eof do
      begin
        Items.Add(FieldByName('COD_ARROTONDAMENTO').AsString);
        if (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW.selP688R.FieldByName('COD_ARROTONDAMENTO').AsString = FieldByName('COD_ARROTONDAMENTO').AsString then
          ItemIndex:=RecNo;
        Next;
      end;
    end;
    OnAsyncChange:=cmbCodArrotondamentoAsyncChange;
  end;

  with TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('IMPORTO'),0)) do
  begin
    //IL campo non deve essere impostato a readOnly
    Enabled:=not (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW.AbilitaImportoPrevisto;
    Invalidate;
  end;

  TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DATA_RIFERIMENTO'),0)).OnAsyncChange:=edtDataRiferimentoAsyncChange;
  TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('QUANTITA'),0)).OnAsyncChange:=edtQuantitaAsyncChange;
  TmeIWImageFile(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('QUANTITA'),1)).OnClick:=imgSelAnagrafeClick;
  TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DATOBASE'),0)).OnAsyncChange:=edtDatoBaseAsyncChange;
  TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('MOLTIPLICATORE'),0)).OnAsyncChange:=edtMoltiplicatoreAsyncChange;
  TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('IMPORTO'),0)).OnAsyncChange:=edtImportoAsyncChange;
end;

procedure TWP684FRisorseDettDefinizioneFondiFM.cmbCodVoceGenAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  RowEdit:=grdtabella.medpRigaDiCompGriglia((Sender as TMedpIWMultiColumnComboBox).FriendlyName);
  grdtabella.medpDataset.FieldByName('COD_VOCE_GEN').AsString:=(Sender as TMedpIWMultiColumnComboBox).Text;
  (grdTabella.medpCompCella(RowEdit,grdtabella.medpIndexColonna('DescVoceGen'),0) as TmeIWLabel).Caption:=grdtabella.medpDataset.FieldByName('DescVoceGen').AsString;
  DataChange;
end;

procedure TWP684FRisorseDettDefinizioneFondiFM.cmbCodArrotondamentoAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  RowEdit:=grdtabella.medpRigaDiCompGriglia((Sender as TmeIWComboBox).FriendlyName);
  grdtabella.medpDataset.FieldByName('COD_ARROTONDAMENTO').AsString:=(Sender as TmeIWComboBox).Text;
  DataChange;
end;

procedure TWP684FRisorseDettDefinizioneFondiFM.edtDataRiferimentoAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  RowEdit:=grdtabella.medpRigaDiCompGriglia((Sender as TmeIWEdit).FriendlyName);
  grdtabella.medpDataset.FieldByName('DATA_RIFERIMENTO').Text:=(Sender as TmeIWEdit).Text;
end;

procedure TWP684FRisorseDettDefinizioneFondiFM.edtQuantitaAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  RowEdit:=grdtabella.medpRigaDiCompGriglia((Sender as TmeIWEdit).FriendlyName);
  grdtabella.medpDataset.FieldByName('QUANTITA').Text:=(Sender as TmeIWEdit).Text;
  with (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW do
  begin
    ImpostaMoltiplicatore(selP688R.FieldByName('QUANTITA').IsNull);
    if TmeIWEdit(grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('MOLTIPLICATORE'),0)).Text = '' then
      TmeIWEdit(grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('MOLTIPLICATORE'),0)).Text:=selP688R.FieldByName('MOLTIPLICATORE').AsString;
  end;
  DataChange;
end;

procedure TWP684FRisorseDettDefinizioneFondiFM.imgSelAnagrafeClick(Sender: TObject);
var dDataSelAnagrafe: TDateTime;
begin
  with (Self.Owner as TWP684FDefinizioneFondi).grdC700 do
  begin
    dDataSelAnagrafe:=Parametri.DataLavoro;
    with (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW do
      if not selP688R.FieldByName('DATA_RIFERIMENTO').IsNull then
        dDataSelAnagrafe:=selP688R.FieldByName('DATA_RIFERIMENTO').AsDateTime;
    WC700FM.C700DataLavoro:=dDataSelAnagrafe;
    WC700FM.C700DataDal:=dDataSelAnagrafe;
    if WC700FM.C700SettaPeriodoSelAnagrafe(dDataSelAnagrafe,dDataSelAnagrafe) then
      SelAnagrafe.CloseAll;
    SelAnagrafe.Open;
    WC700FM.ResultEvent:=ResultSelAnagrafe;
    actSelezioneAnagraficheExecute(nil);
  end;
end;

procedure TWP684FRisorseDettDefinizioneFondiFM.ResultSelAnagrafe(Sender: TObject; Result: Boolean);
var NumAnagrafe:Integer;
begin
  if Result then
  begin
    NumAnagrafe:=(Self.Owner as TWP684FDefinizioneFondi).grdC700.selAnagrafe.RecordCount;
    TmeIWEdit(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('QUANTITA'),0)).Text:=NumAnagrafe.ToString;
    (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW.selP688R.FieldByName('QUANTITA').AsFloat:=NumAnagrafe;
  end;
end;

procedure TWP684FRisorseDettDefinizioneFondiFM.edtDatoBaseAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  RowEdit:=grdtabella.medpRigaDiCompGriglia((Sender as TmeIWEdit).FriendlyName);
  grdtabella.medpDataset.FieldByName('DATOBASE').Text:=(Sender as TmeIWEdit).Text;
  with (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW do
  begin
    ImpostaMoltiplicatore(selP688R.FieldByName('DATOBASE').IsNull);
    if TmeIWEdit(grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('MOLTIPLICATORE'),0)).Text = '' then
      TmeIWEdit(grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('MOLTIPLICATORE'),0)).Text:=selP688R.FieldByName('MOLTIPLICATORE').AsString;
  end;
  DataChange;
end;

procedure TWP684FRisorseDettDefinizioneFondiFM.edtMoltiplicatoreAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  RowEdit:=grdtabella.medpRigaDiCompGriglia((Sender as TmeIWEdit).FriendlyName);
  grdtabella.medpDataset.FieldByName('MOLTIPLICATORE').Text:=(Sender as TmeIWEdit).Text;
  DataChange;
end;

procedure TWP684FRisorseDettDefinizioneFondiFM.edtImportoAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  RowEdit:=grdtabella.medpRigaDiCompGriglia((Sender as TmeIWEdit).FriendlyName);
  grdtabella.medpDataset.FieldByName('IMPORTO').Text:=(Sender as TmeIWEdit).Text;
end;

procedure TWP684FRisorseDettDefinizioneFondiFM.DataChange;
var ImportoCalcolato:Boolean;
begin
  with TmeIWEdit(grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('IMPORTO'),0)) do
  begin
    //IL campo non deve essere impostato a readOnly
    ImportoCalcolato:=(WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW.AbilitaImportoPrevisto;
    if ImportoCalcolato then
    begin
      (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW.ImpostaImportoPrevisto;
    end;
    (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW.ArrotImporto('R');
    Text:=(WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW.selP688R.FieldByName('IMPORTO').AsString;
    Enabled:=not ImportoCalcolato;
    Invalidate;
  end;
end;

procedure TWP684FRisorseDettDefinizioneFondiFM.DataSourceStateChange(Sender: TObject);
begin
  if grdTabella.medpDataSet.State in [dsInsert,dsEdit] then
    with (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW do
    begin
      DataElabDettRis:=selP684.FieldByName('DECORRENZA_DA').AsDateTime;
      FondoElabDettRis:=selP684.FieldByName('COD_FONDO').AsString;
    end;
  inherited;
end;

procedure TWP684FRisorseDettDefinizioneFondiFM.actCopiaSuExecute(Sender: TObject);
var CodVoceGenOrig,CodVoceDetOrig,DescrizioneOrig,CodArrotondamentoOrig:String;
    QuantitaOrig,DatoBaseOrig,MoltiplicatoreOrig,ImportoOrig:Real;
    DataRiferimentoOrig:TDateTime;
begin
  with (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW do
  begin
    if selP688R = nil then abort;
    if selP688R.State <> dsBrowse then abort;
    if selP688R.RecordCount < 1 then abort;
    CodVoceGenOrig:=grdTabella.medpDataSet.FieldByName('COD_VOCE_GEN').AsString;
    CodVoceDetOrig:=grdTabella.medpDataSet.FieldByName('COD_VOCE_DET').AsString;
    DescrizioneOrig:=grdTabella.medpDataSet.FieldByName('DESCRIZIONE').AsString;
    DataRiferimentoOrig:=grdTabella.medpDataSet.FieldByName('DATA_RIFERIMENTO').AsDateTime;
    QuantitaOrig:=grdTabella.medpDataSet.FieldByName('QUANTITA').AsFloat;
    DatoBaseOrig:=grdTabella.medpDataSet.FieldByName('DATOBASE').AsFloat;
    MoltiplicatoreOrig:=grdTabella.medpDataSet.FieldByName('MOLTIPLICATORE').AsFloat;
    ImportoOrig:=grdTabella.medpDataSet.FieldByName('IMPORTO').AsFloat;
    CodArrotondamentoOrig:=grdTabella.medpDataSet.FieldByName('COD_ARROTONDAMENTO').AsString;
    selP688R.Insert;
    selP688R.FieldByName('COD_VOCE_GEN').AsString:=CodVoceGenOrig;
    selP688R.FieldByName('COD_VOCE_DET').AsString:=CodVoceDetOrig;
    selP688R.FieldByName('DESCRIZIONE').AsString:=DescrizioneOrig;
    if DataRiferimentoOrig <> DATE_NULL then
      selP688R.FieldByName('DATA_RIFERIMENTO').AsDateTime:=DataRiferimentoOrig;
    selP688R.FieldByName('QUANTITA').AsFloat:=QuantitaOrig;
    selP688R.FieldByName('DATOBASE').AsFloat:=DatoBaseOrig;
    selP688R.FieldByName('MOLTIPLICATORE').AsFloat:=MoltiplicatoreOrig;
    selP688R.FieldByName('IMPORTO').AsFloat:=ImportoOrig;
    selP688R.FieldByName('COD_ARROTONDAMENTO').AsString:=CodArrotondamentoOrig;
    grdTabella.medpInserisci(False);
  end;
end;

procedure TWP684FRisorseDettDefinizioneFondiFM.CaricaDettaglio(DataSet: TDataSet; DataSource: TDataSource);
begin
  grdTabella.medpComandiCustom:=True;
  inherited;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('COD_VOCE_GEN'),0,DBG_MECMB,'5','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('QUANTITA'),0,DBG_EDT,'input_num_nnnnnddddd_neg','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('QUANTITA'),1,DBG_IMG,'','SELANAGRAFE','Selezione anagrafiche','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DATOBASE'),0,DBG_EDT,'input_num_nnnnnddddd_neg','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('MOLTIPLICATORE'),0,DBG_EDT,'input_num_nnnnnddddd_neg','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('IMPORTO'),0,DBG_EDT,'input_num_generic_neg','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('COD_ARROTONDAMENTO'),0,DBG_CMB,'','','','');
end;

end.
