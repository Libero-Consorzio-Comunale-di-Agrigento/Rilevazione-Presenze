unit WP684UDestDettDefinizioneFondiFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, Vcl.Menus, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  Data.DB, C180FunzioniGenerali, C190FunzioniGeneraliWeb, A000UCostanti, A000UInterfaccia, A000UMessaggi,
  medpIWMultiColumnComboBox, meIWComboBox, meIWLabel, meIWEdit, meIWImageFile, meIWMemo, medpIWMessageDlg,
  WC013UCheckListFM;

type
  TWP684FDestDettDefinizioneFondiFM = class(TWR203FGestDetailFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
  private
    RowEdit: Integer;
    procedure cmbCodVoceGenAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure edtImportoAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure cmbCodArrotondamentoAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure imgSelAnagrafeClick(Sender: TObject);
    procedure ResultSelAnagrafe(Sender: TObject; Result: Boolean);
    procedure imgCodAccorpamentoClick(Sender: TObject);
    procedure CodAccorpamentoResult(Sender: TObject; Result: Boolean);
    procedure imgVisualizzaDettaglioSpesoClick(Sender: TObject);
  public
    procedure DataSourceStateChange(Sender: TObject); override;
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
  end;

implementation

uses WP684UDefinizioneFondi, WP684UDefinizioneFondiDM;

{$R *.dfm}

procedure TWP684FDestDettDefinizioneFondiFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpEditMultiplo:=False;
end;

procedure TWP684FDestDettDefinizioneFondiFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  with (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW do
  begin
    if TmedpIWMultiColumnComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_VOCE_GEN'),0)) <> nil then
      selP688D.FieldByName('COD_VOCE_GEN').AsString:=TmedpIWMultiColumnComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_VOCE_GEN'),0)).Text;
    selP688D.FieldByName('COD_ARROTONDAMENTO').AsString:=TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_ARROTONDAMENTO'),0)).Text;
  end;
end;

procedure TWP684FDestDettDefinizioneFondiFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;
  grdTabella.medpColonna('DBG_COMANDI').Visible:=False;

  if TmedpIWMultiColumnComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_VOCE_GEN'),0)) <> nil then
  begin
    with TmedpIWMultiColumnComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_VOCE_GEN'),0)) do
    begin
      MaxLength:=5;
      Tag:=Row;
      Items.Clear;
      with (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW.selP686D do
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
        if (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW.selP688D.FieldByName('COD_ARROTONDAMENTO').AsString = FieldByName('COD_ARROTONDAMENTO').AsString then
          ItemIndex:=RecNo;
        Next;
      end;
    end;
    OnAsyncChange:=cmbCodArrotondamentoAsyncChange;
  end;

  TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('IMPORTO'),0)).OnAsyncChange:=edtImportoAsyncChange;
  TmeIWImageFile(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('FILTRO_DIPENDENTI'),1)).OnClick:=imgSelAnagrafeClick;
  TmeIWImageFile(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CODICI_ACCORPAMENTOVOCI'),1)).OnClick:=imgCodAccorpamentoClick;
end;

procedure TWP684FDestDettDefinizioneFondiFM.grdTabellaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var r: Integer;
begin
  inherited;
  grdTabella.medpColonna('DBG_COMANDI').Visible:=not (grdTabella.medpDataSet.State in [dsInsert,dsEdit]);
  for r:=1 to High(grdTabella.medpCompGriglia) do
    if grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('DBG_COMANDI'),0) <> nil then
      TmeIWImageFile(grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('DBG_COMANDI'),0)).OnClick:=imgVisualizzaDettaglioSpesoClick;
end;

procedure TWP684FDestDettDefinizioneFondiFM.cmbCodVoceGenAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  RowEdit:=grdtabella.medpRigaDiCompGriglia((Sender as TMedpIWMultiColumnComboBox).FriendlyName);
  grdtabella.medpDataset.FieldByName('COD_VOCE_GEN').AsString:=(Sender as TMedpIWMultiColumnComboBox).Text;
  (grdTabella.medpCompCella(RowEdit,grdtabella.medpIndexColonna('DescVoceGen'),0) as TmeIWLabel).Caption:=grdtabella.medpDataset.FieldByName('DescVoceGen').AsString;
end;

procedure TWP684FDestDettDefinizioneFondiFM.edtImportoAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  RowEdit:=grdtabella.medpRigaDiCompGriglia((Sender as TmeIWEdit).FriendlyName);
  grdtabella.medpDataset.FieldByName('IMPORTO').Text:=(Sender as TmeIWEdit).Text;
end;

procedure TWP684FDestDettDefinizioneFondiFM.cmbCodArrotondamentoAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  RowEdit:=grdtabella.medpRigaDiCompGriglia((Sender as TmeIWComboBox).FriendlyName);
  grdtabella.medpDataset.FieldByName('COD_ARROTONDAMENTO').AsString:=(Sender as TmeIWComboBox).Text;
  with TmeIWEdit(grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('IMPORTO'),0)) do
  begin
    (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW.ArrotImporto('D');
    Text:=(WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW.selP688D.FieldByName('IMPORTO').AsString;
  end;
end;

procedure TWP684FDestDettDefinizioneFondiFM.imgSelAnagrafeClick(Sender: TObject);
var dDataSelAnagrafe: TDateTime;
begin
  with (Self.Owner as TWP684FDefinizioneFondi).grdC700 do
  begin
    dDataSelAnagrafe:=Parametri.DataLavoro;
    with (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW do
      if not selP688D.FieldByName('DECORRENZA_DA').IsNull then
        dDataSelAnagrafe:=selP688D.FieldByName('DECORRENZA_DA').AsDateTime;
    WC700FM.C700DataLavoro:=dDataSelAnagrafe;
    WC700FM.C700DataDal:=dDataSelAnagrafe;
    if WC700FM.C700SettaPeriodoSelAnagrafe(dDataSelAnagrafe,dDataSelAnagrafe) then
      SelAnagrafe.CloseAll;
    SelAnagrafe.Open;
    WC700FM.ResultEvent:=ResultSelAnagrafe;
    actSelezioneAnagraficheExecute(nil);
  end;
end;

procedure TWP684FDestDettDefinizioneFondiFM.ResultSelAnagrafe(Sender: TObject; Result: Boolean);
var S:String;
begin
  if Result then
  begin
    S:=Trim((Self.Owner as TWP684FDefinizioneFondi).grdC700.WC700FM.SQLCreato.Text);
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    with (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW do
    begin
      S:=TrasformaV430(S);
      TmeIWMemo(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('FILTRO_DIPENDENTI'),0)).Text:=
        Copy(S,1,selP688D.FieldByName('FILTRO_DIPENDENTI').Size);
      if S.Length > selP688D.FieldByName('FILTRO_DIPENDENTI').Size then
        R180MessageBox(A000MSG_P684_MSG_FILTRO_DIPENDENTI,INFORMA);
    end;
  end;
end;

procedure TWP684FDestDettDefinizioneFondiFM.imgCodAccorpamentoClick(Sender: TObject);
var ElencoAccorpamenti: TElencoValoriChecklist;
    WC013: TWC013FCheckListFM;
    S: String;
    LstSel: TStringList;
begin
  try
    RowEdit:=grdTabella.medpRigaDiCompGriglia(TmeIWImageFile(Sender).FriendlyName);
    ElencoAccorpamenti:=(WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW.ElencoAccorpamenti;
    WC013:=TWC013FCheckListFM.Create(Self.Owner);
    WC013.CaricaLista(ElencoAccorpamenti.LstDescrizione, ElencoAccorpamenti.lstCodice);
    S:=TmeIWEdit(grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('CODICI_ACCORPAMENTOVOCI'),0)).Text;
    S:=StringReplace(Copy(S,5,Length(S)-6),''',''',',',[rfReplaceAll]);
    LstSel:=TStringList.Create;
    LstSel.StrictDelimiter:=True;
    LstSel.CommaText:=S;
    WC013.ImpostaValoriSelezionati(LstSel);
    FreeAndNil(LstSel);
    WC013.ResultEvent:=CodAccorpamentoResult;
    WC013.Visualizza(0,0,'<WC013> Elenco accorpamenti');
  finally
    FreeAndNil(ElencoAccorpamenti);
  end;
end;

procedure TWP684FDestDettDefinizioneFondiFM.CodAccorpamentoResult(Sender: TObject; Result: Boolean);
var lstTmp: TStringList;
    S: string;
begin
  if Result then
  begin
    lstTmp:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    S:=lstTmp.CommaText;
    FreeAndNil(lstTmp);
    if Trim(S) <> '' then
      S:='IN(''' + StringReplace(S,',',''',''',[rfReplaceAll]) + ''')';
    with (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW do
    begin
      TmeIWEdit(grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('CODICI_ACCORPAMENTOVOCI'),0)).Text:=
        Copy(S,1,selP688D.FieldByName('CODICI_ACCORPAMENTOVOCI').Size);
      if S.Length > selP688D.FieldByName('CODICI_ACCORPAMENTOVOCI').Size then
        R180MessageBox(A000MSG_P684_MSG_ACCORPAMENTI,INFORMA);
    end;
  end;
end;

procedure TWP684FDestDettDefinizioneFondiFM.imgVisualizzaDettaglioSpesoClick(Sender: TObject);
var r: Integer;
    Imp:Real;
begin
  grdTabella.medpColumnClick(Sender,(Sender as TmeIWImageFile).FriendlyName);
  with (WR302DM AS TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW do
    if LetturaDettaglioImportoSpeso(selP688D.FieldByName('COD_FONDO').AsString,selP688D.FieldByName('DECORRENZA_DA').AsDateTime,Imp) then
      MsgBox.WebMessageDlg(A000MSG_P684_MSG_IMPORTO_SPESO,mtInformation,[mbOk],nil,'');
  r:=grdTabella.medpRigaDiCompGriglia((Sender as TmeIWImageFile).FriendlyName);
  with (WR302DM AS TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW do
  begin
    DataElabGrigliaDett:=selP684.FieldByName('DECORRENZA_DA').AsDateTime;
    FondoElabGrigliaDett:=selP684.FieldByName('COD_FONDO').AsString;
    CodGenElabGrigliaDett:=grdTabella.medpValoreColonna(r,'COD_VOCE_GEN');
    CodDetElabGrigliaDett:=grdTabella.medpValoreColonna(r,'COD_VOCE_DET');
  end;
  (Self.Owner as TWP684FDefinizioneFondi).ApriGrigliaDettDefinizioneFondi;
end;

procedure TWP684FDestDettDefinizioneFondiFM.DataSourceStateChange(Sender: TObject);
begin
  if grdTabella.medpDataSet.State in [dsInsert,dsEdit] then
    with (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW do
    begin
      DataElabDettDes:=selP684.FieldByName('DECORRENZA_DA').AsDateTime;
      FondoElabDettDes:=selP684.FieldByName('COD_FONDO').AsString;
    end;
  inherited;
end;

procedure TWP684FDestDettDefinizioneFondiFM.CaricaDettaglio(DataSet: TDataSet; DataSource: TDataSource);
begin
  grdTabella.medpComandiCustom:=True;
  inherited;
  grdTabella.medpPreparaComponenteGenerico('WR102-R',grdTabella.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','ACCEDI','Visualizza dettaglio speso','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('COD_VOCE_GEN'),0,DBG_MECMB,'5','2','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('IMPORTO'),0,DBG_EDT,'input_num_generic_neg','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('COD_ARROTONDAMENTO'),0,DBG_CMB,'','','','');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('FILTRO_DIPENDENTI'),0,DBG_MEMO,'50','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('FILTRO_DIPENDENTI'),1,DBG_IMG,'','SELANAGRAFE','Selezione anagrafiche','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CODICI_ACCORPAMENTOVOCI'),0,DBG_EDT,'50','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CODICI_ACCORPAMENTOVOCI'),1,DBG_IMG,'','CAMBIADATO','','','S');
end;

end.
