unit WP555UDettaglioContoAnnualeFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, Vcl.Menus, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  Data.DB, IWCompExtCtrls, meIWRadioGroup, IWCompLabel, meIWLabel, WR100UBase,
  OracleData, meIWImageFile, medpIWImageButton, A000UInterfaccia, A000UMessaggi, medpIWMessagedlg,
  C190FunzioniGeneraliWeb, A000UCostanti, WC013UCheckListFM,
  WC015USelEditGridFM, meIWEdit, IWCompEdit, WR010UBase, IWCompButton,
  meIWButton;

type
  TWP555FDettaglioContoAnnualeFM = class(TWR203FGestDetailFM)
    rgpTipoDati: TmeIWRadioGroup;
    lblTipoDati: TmeIWLabel;
    btnFiltroRiga: TmedpIWImageButton;
    btnFiltroColonna: TmedpIWImageButton;
    btnSalva: TmedpIWImageButton;
    btnSendFile: TmeIWButton;
    procedure rgpTipoDatiClick(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);
    procedure actEliminaExecute(Sender: TObject);
    procedure actNuovoExecute(Sender: TObject);
    procedure actCopiaSuExecute(Sender: TObject);
    procedure grdTabellaRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure btnFiltroRigaClick(Sender: TObject);
    procedure btnFiltroColonnaClick(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure btnSalvaClick(Sender: TObject);
    procedure btnSendFileClick(Sender: TObject);
    procedure grdTabellaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    SalvaIndex,RowEdit: Integer;
    Intestazione: Boolean;
    procedure FiltroRigaResult(Sender: TObject; Result: Boolean);
    procedure FiltroColonnaResult(Sender: TObject; Result: Boolean);
    procedure imgRigaClick(Sender: TObject);
    procedure ResultElencoRiga(Sender: TObject; Result: Boolean);
    procedure edtRigaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure imgColonnaClick(Sender: TObject);
    procedure ResultElencoColonna(Sender: TObject; Result: Boolean);
    procedure edtColonnaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure ResultConfermaSalva(Sender: TObject; Res: TmeIWModalResult;
      KeyID: String);
    procedure PreparaComponentiModifica;
    procedure imgElencoDipendentiClick(Sender: TObject);
  public
    procedure DataSourceStateChange(Sender: TObject); override;
    procedure CaricaDettaglio(DataSet:TDataSet; DataSource:TDataSource); override;
    procedure AggiornaDettaglio; override;
  end;


implementation

uses
  WP555UContoAnnualeDM;

{$R *.dfm}

{ TWP555FDettaglioContoAnnualeFM }

procedure TWP555FDettaglioContoAnnualeFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  (WR302DM AS TWP555FContoAnnualeDM).P555FContoAnnualeMW.bSelAnagrafe:=rgpTipoDati.ItemIndex = 0;
end;

procedure TWP555FDettaglioContoAnnualeFM.actCopiaSuExecute(Sender: TObject);
begin
  if WR302DM.selTabella.FieldByName('CHIUSO').AsString = 'S' then
  begin
    MsgBox.WebMessageDlg(A000MSG_P555_MSG_MODIFICA_NON_CONSENTITA,mtError,[mbOk],nil,'');
    Exit;
  end;
  inherited;
end;

procedure TWP555FDettaglioContoAnnualeFM.actEliminaExecute(Sender: TObject);
begin
  if WR302DM.selTabella.FieldByName('CHIUSO').AsString = 'S' then
  begin
    MsgBox.WebMessageDlg(A000MSG_P555_MSG_MODIFICA_NON_CONSENTITA,mtError,[mbOk],nil,'');
    Exit;
  end;
  inherited;
end;

procedure TWP555FDettaglioContoAnnualeFM.actModificaExecute(Sender: TObject);
begin
  if WR302DM.selTabella.FieldByName('CHIUSO').AsString = 'S' then
  begin
    MsgBox.WebMessageDlg(A000MSG_P555_MSG_MODIFICA_NON_CONSENTITA,mtError,[mbOk],nil,'');
    Exit;
  end;
  inherited;
end;

procedure TWP555FDettaglioContoAnnualeFM.actNuovoExecute(Sender: TObject);
begin
  if WR302DM.selTabella.FieldByName('CHIUSO').AsString = 'S' then
  begin
    MsgBox.WebMessageDlg(A000MSG_P555_MSG_MODIFICA_NON_CONSENTITA,mtError,[mbOk],nil,'');
    Exit;
  end;
  inherited;
end;

procedure TWP555FDettaglioContoAnnualeFM.AggiornaDettaglio;
begin
  if rgpTipoDati.ItemIndex = 0 then
    grdTabella.medpRighePagina:=-1;
// Elimino la paginazione
//  else
//    grdTabella.medpRighePagina:=10;
  grdTabella.medpComandiCustom:=rgpTipoDati.ItemIndex = 1;
  inherited;
  grdTabella.medpCancellaRigaWR102;
  if rgpTipoDati.ItemIndex = 2 then
  begin
    if (WR302DM AS TWP555FContoAnnualeDM).bErroreCalcoloManuale then
    begin
      rgpTipoDati.ItemIndex:=SalvaIndex;
      rgpTipoDatiClick(nil);
      Exit;
    end;
    if (WR302DM AS TWP555FContoAnnualeDM).P555FContoAnnualeMW.selQuery.RecordCount > 0 then
      btnSalva.Enabled:=True
    else
      btnSalva.Enabled:=False;
    grdtabella.medpAttivaGrid((WR302DM AS TWP555FContoAnnualeDM).P555FContoAnnualeMW.selQuery,false,false);
  end
  else
  begin
    grdtabella.medpAttivaGrid((WR302DM AS TWP555FContoAnnualeDM).P555FContoAnnualeMW.selP555,false,false);
    if grdTabella.medpComandiCustom then
    begin
      grdTabella.medpPreparaComponenteGenerico('WR102-R',grdTabella.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','CAMBIADATO','Elenco dipendenti','','');
      grdTabella.medpCaricaCDS;
    end
    else
    begin
      PreparaComponentiModifica;
    end;
  end;
end;

procedure TWP555FDettaglioContoAnnualeFM.btnFiltroColonnaClick(Sender: TObject);
var
  ListColonne: TElencoValoriChecklist;
  WC013: TWC013FCheckListFM;
  LstSel: TStringList;
begin
  try
    ListColonne:=(WR302DM AS TWP555FContoAnnualeDM).P555FContoAnnualeMW.ListColonne;

    WC013:=TWC013FCheckListFM.Create(Self.Owner);
    WC013.CaricaLista(ListColonne.LstDescrizione, ListColonne.lstCodice);

    LstSel:=TStringList.Create;
    LstSel.StrictDelimiter:=True;
    LstSel.CommaText:=(WR302DM AS TWP555FContoAnnualeDM).P555FContoAnnualeMW.ColSel;
    WC013.ImpostaValoriSelezionati(LstSel);
    FreeAndNil(LstSel);
    WC013.ResultEvent:=FiltroColonnaResult;
    WC013.Visualizza(0,0,'<WC013> Filtro Colonna');
  finally
    if ListColonne <> nil then
      FreeAndNil(ListColonne);
    if LstSel <> nil then
      FreeAndNil(LstSel);
  end;
end;

procedure TWP555FDettaglioContoAnnualeFM.btnFiltroRigaClick(Sender: TObject);
var
  ListRighe: TElencoValoriChecklist;
  WC013: TWC013FCheckListFM;
  LstSel: TStringList;
begin
  try
    ListRighe:=(WR302DM AS TWP555FContoAnnualeDM).P555FContoAnnualeMW.ListRighe;

    WC013:=TWC013FCheckListFM.Create(Self.Owner);
    WC013.CaricaLista(ListRighe.LstDescrizione, ListRighe.lstCodice);

    LstSel:=TStringList.Create;
    LstSel.StrictDelimiter:=True;
    LstSel.CommaText:=(WR302DM AS TWP555FContoAnnualeDM).P555FContoAnnualeMW.RigSel;
    WC013.ImpostaValoriSelezionati(LstSel);
    FreeAndNil(LstSel);
    WC013.ResultEvent:=FiltroRigaResult;
    WC013.Visualizza(0,0,'<WC013> Filtro Riga');
  finally
    if ListRighe <> nil then
      FreeAndNil(ListRighe);
    if LstSel <> nil then
      FreeAndNil(LstSel);
  end;
end;

procedure TWP555FDettaglioContoAnnualeFM.btnSalvaClick(Sender: TObject);
begin
  MsgBox.WebMessageDlg(A000MSG_P555_DLG_INTESTAZIONE,mtConfirmation,[mbYes,mbNo],ResultConfermaSalva,'');
end;

procedure TWP555FDettaglioContoAnnualeFM.btnSendFileClick(Sender: TObject);
var
  lst: TStringList;
begin
  lst:=TStringList.Create;
  try
    (WR302DM AS TWP555FContoAnnualeDM).P555FContoAnnualeMW.SalvaRiepilogo(Intestazione,lst);
    (Self.Owner as TWR010FBase).InviaFile('Riepilogativi.txt',lst.Text);
  finally
    FreeAndNil(lst);
  end;
end;

procedure TWP555FDettaglioContoAnnualeFM.ResultConfermaSalva(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  Intestazione:=False;
  if Res = mrYes then
  begin
    Intestazione:=True;
  end;
  (Self.Owner as TWR010FBase).AddToInitProc(Format('SubmitClick("%s", "", true);',[btnSendFile.HTMLName]))
end;

procedure TWP555FDettaglioContoAnnualeFM.FiltroRigaResult(Sender: TObject; Result: Boolean);
var
  lstTmp: TStringList;
begin
  if Result then
  begin
    lstTmp:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    (WR302DM AS TWP555FContoAnnualeDM).P555FContoAnnualeMW.RigSel:=lstTmp.CommaText;
    FreeAndNil(lstTmp);
    (WR302DM AS TWP555FContoAnnualeDM).P555FContoAnnualeMW.FiltroRigheColonne;
    grdTabella.medpAggiornaCDS(True);
  end;
end;

procedure TWP555FDettaglioContoAnnualeFM.FiltroColonnaResult(Sender: TObject; Result: Boolean);
var
  lstTmp: TStringList;
begin
  if Result then
  begin
    lstTmp:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    (WR302DM AS TWP555FContoAnnualeDM).P555FContoAnnualeMW.ColSel:=lstTmp.CommaText;
    FreeAndNil(lstTmp);
    (WR302DM AS TWP555FContoAnnualeDM).P555FContoAnnualeMW.FiltroRigheColonne;
    grdTabella.medpAggiornaCDS(True);
  end;
end;

procedure TWP555FDettaglioContoAnnualeFM.CaricaDettaglio(DataSet: TDataSet;
  DataSource: TDataSource);
begin
  inherited;
  SalvaIndex:=rgpTipoDati.ItemIndex;
  PreparaComponentiModifica;
end;

procedure TWP555FDettaglioContoAnnualeFM.PreparaComponentiModifica;
begin
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('RIGA'),0,DBG_EDT,'input_num_nnnn','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('RIGA'),1,DBG_IMG,'','CAMBIADATO','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DESC_RIGA'),0,DBG_LBL,'60','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('VALORE_COSTANTE'),0,DBG_LBL,'10','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('COLONNA'),0,DBG_EDT,'input_num_nnnn','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('COLONNA'),1,DBG_IMG,'','CAMBIADATO','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DESC_COLONNA'),0,DBG_LBL,'60','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('VALORE'),0,DBG_EDT,'input_num_12n10d_neg width10chr','','null','','S');
end;

procedure TWP555FDettaglioContoAnnualeFM.DataSourceStateChange(Sender: TObject);
var
  Browse: Boolean;
begin
  inherited;
  Browse:=not (grdTabella.medpDataSet.State in [dsInsert,dsEdit]);
  btnFiltroRiga.Enabled:=Browse;
  btnFiltroColonna.Enabled:=Browse;
  rgpTipoDati.Enabled:=Browse;
end;

procedure TWP555FDettaglioContoAnnualeFM.grdTabellaAfterCaricaCDS(
  Sender: TObject; DBG_ROWID: string);
var
  r: Integer;
  img: TmeIWImageFile;
begin
  inherited;
  if rgpTipoDati.ItemIndex = 1 then
  begin
    for r:=1 to High(grdTabella.medpCompGriglia) do
    if grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('DBG_COMANDI'),0) <> nil then
    begin
      img:=TmeIWImageFile(grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('DBG_COMANDI'),0));
      img.OnClick:=imgElencoDipendentiClick;
    end;
  end;
end;

procedure TWP555FDettaglioContoAnnualeFM.grdTabellaDataSet2Componenti(
  Row: Integer);
var
  img: TmeIWImageFile;
  edt: TmeIWEdit;
begin
  inherited;
  edt:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('RIGA'),0) as TmeIWEdit);
  edt.OnAsyncChange:=edtRigaAsyncChange;

  img:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('RIGA'),1) as TmeIWImageFile);
  img.OnClick:=imgRigaClick;

  edt:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COLONNA'),0) as TmeIWEdit);
  edt.OnAsyncChange:=edtColonnaAsyncChange;

  img:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COLONNA'),1) as TmeIWImageFile);
  img.OnClick:=imgColonnaClick;
end;

procedure TWP555FDettaglioContoAnnualeFM.edtColonnaAsyncChange(Sender: TObject;
  EventParams: TStringList);
var
  lbl: TmeIWLabel;
begin
  RowEdit:=grdtabella.medpRigaDiCompGriglia((Sender as TmeIWEdit).FriendlyName);
  grdTabella.medpdataset.FieldByName('COLONNA').asString:=(Sender as TmeIWEdit).Text;

  lbl:=(grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('DESC_COLONNA'),0) as TmeIWLabel);
  lbl.caption:=grdtabella.medpDataset.FieldByName('DESC_COLONNA').asString;
end;

procedure TWP555FDettaglioContoAnnualeFM.edtRigaAsyncChange(Sender: TObject;
  EventParams: TStringList);
var
  lbl: TmeIWLabel;
  Riga: String;
begin
  RowEdit:=grdtabella.medpRigaDiCompGriglia((Sender as TmeIWEdit).FriendlyName);
  Riga:=(Sender as TmeIWEdit).Text;
  with (WR302DM AS TWP555FContoAnnualeDM).P555FContoAnnualeMW do
  begin
    if not selP552Riga.SearchRecord('ANNO;RIGA',VarArrayOf([AnnoRegole,Riga]),[srFromBeginning]) then
      Riga:='';
  end;
  (Sender as TmeIWEdit).Text:=Riga;
  grdTabella.medpdataset.FieldByName('RIGA').asString:=Riga;

  lbl:=(grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('DESC_RIGA'),0) as TmeIWLabel);
  lbl.caption:=grdtabella.medpDataset.FieldByName('DESC_RIGA').asString;

  lbl:=(grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('VALORE_COSTANTE'),0) as TmeIWLabel);
  lbl.caption:=grdtabella.medpDataset.FieldByName('VALORE_COSTANTE').asString;
end;

procedure TWP555FDettaglioContoAnnualeFM.imgRigaClick(Sender: TObject);
var
  WC015: TWC015FSelEditGridFM;
  Riga: String;
begin
  WC015:=TWC015FSelEditGridFM.Create(Self.Parent);
  RowEdit:=grdtabella.medpRigaDiCompGriglia((Sender as TmeIWImageFile).FriendlyName);
  Riga:=(grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('RIGA'),0) as TmeIWEdit).Text;
  if Trim(Riga) = '' then
    Riga:='1';
  with (WR302DM AS TWP555FContoAnnualeDM).P555FContoAnnualeMW do
  begin
    WC015.medpCurrRecord:=selP552Riga.SearchRecord('ANNO;RIGA',VarArrayOf([AnnoRegole,Riga]),[srFromBeginning]);
    WC015.ResultEvent:=ResultElencoRiga;
    WC015.Visualizza('Elenco dati',selP552Riga,False,False,True);
  end;
end;

procedure TWP555FDettaglioContoAnnualeFM.imgColonnaClick(Sender: TObject);
var
  WC015: TWC015FSelEditGridFM;
  Colonna: String;
begin
  WC015:=TWC015FSelEditGridFM.Create(Self.Parent);
  RowEdit:=grdtabella.medpRigaDiCompGriglia((Sender as TmeIWImageFile).FriendlyName);
  Colonna:=(grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('COLONNA'),0) as TmeIWEdit).Text;
  if Trim(Colonna) = '' then
    Colonna:='1';
  with (WR302DM AS TWP555FContoAnnualeDM).P555FContoAnnualeMW do
  begin
    WC015.medpCurrRecord:=selP552Col.SearchRecord('ANNO;COLONNA',VarArrayOf([AnnoRegole,Colonna]),[srFromBeginning]);
    WC015.ResultEvent:=ResultElencoColonna;
    WC015.Visualizza('Elenco dati',selP552Col,False,False,True);
  end;
end;

procedure TWP555FDettaglioContoAnnualeFM.ResultElencoColonna(Sender: TObject; Result: Boolean);
var
  edt: TmeIWEdit;
  lbl: TmeIWLabel;
begin
  if Result then
  begin
    with (WR302DM AS TWP555FContoAnnualeDM) do
    begin
      //imposto anche il dataset in modo che vengano aggiornati i campi calcolati
      edt:=(grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('COLONNA'),0) as TmeIWEdit);
      edt.Text:=P555FContoAnnualeMW.selP552Col.FieldByName('COLONNA').AsString;
      grdTabella.medpdataset.FieldByName('COLONNA').asString:=edt.Text;

      lbl:=(grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('DESC_COLONNA'),0) as TmeIWLabel);
      lbl.caption:=grdtabella.medpDataset.FieldByName('DESC_COLONNA').asString;
    end;
  end;
end;

procedure TWP555FDettaglioContoAnnualeFM.ResultElencoRiga(Sender: TObject; Result: Boolean);
var
  edt: TmeIWEdit;
  lbl: TmeIWLabel;
begin
  if Result then
  begin
    with (WR302DM AS TWP555FContoAnnualeDM) do
    begin
      //imposto anche il dataset in modo che vengano aggiornati i campi calcolati
      edt:=(grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('RIGA'),0) as TmeIWEdit);
      edt.Text:=P555FContoAnnualeMW.selP552Riga.FieldByName('RIGA').AsString;
      grdTabella.medpdataset.FieldByName('RIGA').asString:=edt.Text;

      lbl:=(grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('DESC_RIGA'),0) as TmeIWLabel);
      lbl.caption:=grdtabella.medpDataset.FieldByName('DESC_RIGA').asString;

      lbl:=(grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('VALORE_COSTANTE'),0) as TmeIWLabel);
      lbl.caption:=grdtabella.medpDataset.FieldByName('VALORE_COSTANTE').asString;
    end;
  end;
end;

procedure TWP555FDettaglioContoAnnualeFM.grdTabellaRenderCell(
  ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  inherited;
  if ARow = 0 then
  begin
    if AColumn = grdTabella.medpIndexColonna('RIGA') then
    begin
      ACell.Css:=ACell.Css+ ' width15chr';
    end
    else if AColumn = grdTabella.medpIndexColonna('COLONNA') then
    begin
      ACell.Css:=ACell.Css+ ' width15chr';
    end
    else if AColumn = grdTabella.medpIndexColonna('VALORE') then
    begin
      ACell.Css:=ACell.Css+ ' width15chr';
    end;
  end;
end;

procedure TWP555FDettaglioContoAnnualeFM.rgpTipoDatiClick(Sender: TObject);
begin
  inherited;
  (WR302DM AS TWP555FContoAnnualeDM).P555FContoAnnualeMW.bSelAnagrafe:=rgpTipoDati.ItemIndex = 0;
  if rgpTipoDati.ItemIndex < 2 then
    SalvaIndex:=rgpTipoDati.ItemIndex;

  WR302DM.selTabella.SearchRecord('ANNO;COD_TABELLA', VarArrayOf([WR302DM.selTabella.FieldByName('ANNO').AsInteger,WR302DM.selTabella.FieldByName('COD_TABELLA').AsString]),[srFromBeginning]);
  AggiornaDettaglio;

  grdDetailNavBar.Visible:=rgpTipoDati.ItemIndex < 2;
  actNuovo.Visible:=rgpTipoDati.ItemIndex = 0;
  actElimina.Visible:=rgpTipoDati.ItemIndex = 0;
  actModifica.Visible:=rgpTipoDati.ItemIndex = 0;
  actConferma.Visible:=rgpTipoDati.ItemIndex = 0;
  actAnnulla.Visible:=rgpTipoDati.ItemIndex = 0;
  TWR100FBase(Self.Owner).AggiornaToolBar(grdDetailNavBar,actlstDetailNavBar);

  btnFiltroRiga.Visible:=rgpTipoDati.ItemIndex < 2;
  btnFiltroColonna.Visible:=rgpTipoDati.ItemIndex < 2;
  //btnSalva.Visible:=rgpTipoDati.ItemIndex = 2;
  (Self.owner as TWR100FBase).grdC700.Visible:=rgpTipoDati.ItemIndex = 0;
end;

procedure TWP555FDettaglioContoAnnualeFM.imgElencoDipendentiClick(Sender: TObject);
var
  r: Integer;
  Riga,Colonna: String;
  WC015: TWC015FSelEditGridFM;
  DescRiga,DescColonna,ValoreCostante,msgSelDip: String;
begin
  r:=grdTabella.medpRigaDiCompGriglia((Sender as TmeIWImageFile).FriendlyName);
  Riga:=grdTabella.medpValoreColonna(r, 'RIGA');
  DescRiga:=grdTabella.medpValoreColonna(r, 'DESC_RIGA');
  ValoreCostante:=grdTabella.medpValoreColonna(r, 'VALORE_COSTANTE');
  Colonna:=grdTabella.medpValoreColonna(r, 'COLONNA');
  DescColonna:=grdTabella.medpValoreColonna(r, 'DESC_COLONNA');
  with (WR302DM AS TWP555FContoAnnualeDM) do
  begin
    P555FContoAnnualeMW.ImpostaSelDip(selTabella.FieldByName('ANNO').AsInteger, StrToIntDef(Colonna,0), StrToIntDef(Riga,0),selTabella.FieldByName('COD_TABELLA').AsString);
    WC015:=TWC015FSelEditGridFM.Create(Self.Parent);
    WC015.Visualizza('Elenco dipendenti Riga: ' + DescRiga + ' - ' + ValoreCostante + ' Colonna: ' + DescColonna,
                     P555FContoAnnualeMW.selDip,False,False,False);
    msgSelDip:=P555FContoAnnualeMW.ControllaSelDip(StrToFloatDef(grdTabella.medpValoreColonna(r, 'VALORE'),0));
    if msgSelDip <> '' then
      MsgBox.WebMessageDlg(msgSelDip,mtInformation,[mbOk],nil,'');
  end;
end;

end.
