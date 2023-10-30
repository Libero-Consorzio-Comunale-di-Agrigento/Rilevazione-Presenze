unit WP684UGrigliaDettDefinizioneFondiBrowseFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR204UBrowseTabellaFM, Vcl.Menus,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, OracleData,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids,
  IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  meIWLabel, meIWEdit, meIWImageFile, meIWComboBox, WC015USelEditGridFM;

type
  TWP684FGrigliaDettDefinizioneFondiBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
  private
    RowEdit,Col: Integer;
    procedure edtCodVoceCodContrattoAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure imgCodVoceClick(Sender: TObject);
    procedure VoceSelezionata(Sender: TObject; Result: Boolean);
    procedure DataChange;
  public
    procedure PreparaComponenti(AbilitaModifiche:Boolean);
  end;

implementation

uses WP684UGrigliaDettDefinizioneFondi, WP684UGrigliaDettDefinizioneFondiDM;

{$R *.dfm}

procedure TWP684FGrigliaDettDefinizioneFondiBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  //Forzo la paginazione della testata a 15 righe
  grdTabella.medpRighePagina:=15;
end;

procedure TWP684FGrigliaDettDefinizioneFondiBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
var
  edt: TmeIWEdit;
  img: TmeIWImageFile;
begin
  inherited;
  with TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_CONTRATTO'),0)) do
  begin
    Items.Clear;
    Items.Add('');
    ItemIndex:=0;
    with (Self.Owner as TWP684FGrigliaDettDefinizioneFondi).P684GrigliaDettMW.selP210 do
    begin
      Close;
      Open;
      while not Eof do
      begin
        Items.Add(FieldByName('COD_CONTRATTO').AsString);
        if (Self.Owner as TWP684FGrigliaDettDefinizioneFondi).P684GrigliaDettMW.selP690.FieldByName('COD_CONTRATTO').AsString = FieldByName('COD_CONTRATTO').AsString then
          ItemIndex:=RecNo;
        Next;
      end;
      Close;
    end;
    OnAsyncChange:=edtCodVoceCodContrattoAsyncChange;
  end;

  edt:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DATA_RETRIBUZIONE'),0) as TmeIWEdit);
  if edt.Text <> '' then
    edt.Text:=FormatDateTime('mm/yyyy',StrToDate(edt.Text));

  edt:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_VOCE'),0) as TmeIWEdit);
  edt.OnAsyncChange:=edtCodVoceCodContrattoAsyncChange;

  img:=TmeIWImageFile(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_VOCE'),1));
  img.OnClick:=imgCodVoceClick;
end;

procedure TWP684FGrigliaDettDefinizioneFondiBrowseFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  with (Self.Owner as TWP684FGrigliaDettDefinizioneFondi).P684GrigliaDettMW do
  begin
    selP690.FieldByName('COD_CONTRATTO').AsString:=TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_CONTRATTO'),0)).Text;
    selP690.FieldByName('DATA_RETRIBUZIONE').AsDateTime:=R180FineMese(selP690.FieldByName('DATA_RETRIBUZIONE').AsDateTime);
  end;
end;

procedure TWP684FGrigliaDettDefinizioneFondiBrowseFM.edtCodVoceCodContrattoAsyncChange(Sender: TObject; EventParams: TStringList);
var sDataCompQuote:String;
begin
  //Aggiorna la label descrizione
  RowEdit:=grdTabella.medpRigaDiCompGriglia(TmeIWImageFile(Sender).FriendlyName);
  with (Self.Owner as TWP684FGrigliaDettDefinizioneFondi).P684GrigliaDettMW do
  begin
    selP690.FieldByName('COD_CONTRATTO').AsString:=TmeIWComboBox(grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('COD_CONTRATTO'),0)).Text;
    selP690.FieldByName('COD_VOCE').AsString:=TmeIWEdit(grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('COD_VOCE'),0)).Text;
  end;
  DataChange;
end;

procedure TWP684FGrigliaDettDefinizioneFondiBrowseFM.imgCodVoceClick(Sender: TObject);
var WC015: TWC015FSelEditGridFM;
    CodContratto: String;
begin
  //Apre la maschera di selezione voci
  WC015:=TWC015FSelEditGridFM.Create(Self.Owner);
  RowEdit:=grdTabella.medpRigaDiCompGriglia(TmeIWImageFile(Sender).FriendlyName);
  with (Self.Owner as TWP684FGrigliaDettDefinizioneFondi).P684GrigliaDettMW do
  begin
    Col:=grdTabella.medpIndexColonna('COD_CONTRATTO');
    CodContratto:=TmeIWComboBox(grdTabella.medpCompCella(RowEdit,Col,0)).Text;
    R180SetVariable(selP200,'Decorrenza',DataElabGrigliaDett);
    R180SetVariable(selP200,'Cod_Contratto',CodContratto);
    R180SetVariable(selP200,'Cod_Voce','*');
    selP200.Open;
    Col:=grdTabella.medpIndexColonna('COD_VOCE');
    WC015.medpCurrRecord:=selP200.SearchRecord('COD_VOCE;COD_VOCE_SPECIALE',VarArrayOf([TmeIWEdit(grdTabella.medpCompCella(RowEdit,Col,0)).Text,'BASE']),[srFromBeginning]);
    WC015.medpSearchKind:=skContent;
    WC015.medpSearchField:='COD_VOCE';
    WC015.ResultEvent:=VoceSelezionata;
    WC015.Visualizza('Elenco voci contratto ' + CodContratto,selP200,False,False,True);
  end;
end;

procedure TWP684FGrigliaDettDefinizioneFondiBrowseFM.VoceSelezionata(Sender: TObject; Result: Boolean);
var CodVoce:String;
begin
  //Ritorna il codice voce selezionato
  with (Self.Owner as TWP684FGrigliaDettDefinizioneFondi).P684GrigliaDettMW do
    if Result then
    begin
      CodVoce:=selP200.FieldByName('COD_VOCE').AsString;
      //Imposto sul dataset per scatenare calcField e impostare descrizione corretta
      selP690.FieldByName('COD_VOCE').AsString:=CodVoce;
      (grdTabella.medpCompCella(RowEdit,Col,0) as TmeIWEdit).Text:=CodVoce;
      DataChange;
    end;
end;

procedure TWP684FGrigliaDettDefinizioneFondiBrowseFM.DataChange;
var
  colDescizione: Integer;
  lbl: TmeIWLabel;
begin
  colDescizione:=grdTabella.medpIndexColonna('Descrizione');
  lbl:=(grdTabella.medpCompCella(RowEdit,colDescizione,0) as TmeIWLabel);
  //Descrizione cod voce può cambiare alla modifica di codvoce, codcontratto
  lbl.Text:=(Self.Owner as TWP684FGrigliaDettDefinizioneFondi).P684GrigliaDettMW.selP690.FieldByName('Descrizione').AsString;
end;

procedure TWP684FGrigliaDettDefinizioneFondiBrowseFM.PreparaComponenti(AbilitaModifiche:Boolean);
begin
  grdTabella.medpPreparaComponentiDefault;
  if not AbilitaModifiche then
    exit;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DATA_RETRIBUZIONE'),0,DBG_EDT,'input_data_my','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('COD_CONTRATTO'),0,DBG_CMB,'','','','');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('COD_VOCE'),0,DBG_EDT,'','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('COD_VOCE'),1,DBG_IMG,'','CAMBIADATO','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('IMPORTO'),0,DBG_EDT,'input_num_generic_neg','','','','S');
end;

end.
