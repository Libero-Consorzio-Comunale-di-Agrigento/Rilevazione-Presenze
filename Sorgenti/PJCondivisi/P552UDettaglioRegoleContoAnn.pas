unit P552UDettaglioRegoleContoAnn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  StdCtrls, Mask, DBCtrls, ExtCtrls, Oracle, OracleData, Buttons,
  C180FunzioniGenerali, C013UCheckList, System.Actions, P552URegoleContoAnnualeMW,
  A000UCostanti,Generics.Collections, A000UMessaggi, System.ImageList;

type
  TP552FDettaglioRegoleContoAnn = class(TR001FGestTab)
    Panel2: TPanel;
    lblNumero: TLabel;
    dedtNumero: TDBEdit;
    Label1: TLabel;
    dedtDescrizione: TDBEdit;
    dedtValoreCostante: TDBEdit;
    lblValoreCostante: TLabel;
    lblArrotondamento: TLabel;
    Panel3: TPanel;
    lblAnno: TLabel;
    edtTabella: TEdit;
    lblTabella: TLabel;
    edtAnno: TEdit;
    lblCodTabella: TLabel;
    gpbAccorpamento: TGroupBox;
    lblCodAccorpamento: TLabel;
    dedtCodAccorpamento: TDBEdit;
    drdgModalita: TDBRadioGroup;
    gpbTabSostitutive: TGroupBox;
    lblTredicesimaAC: TLabel;
    lblTredicesimaAP: TLabel;
    lblArretratiAC: TLabel;
    lblArretratiAP: TLabel;
    cmbTabTredicesimaAC: TComboBox;
    cmbTabTredicesimaAP: TComboBox;
    cmbTabArretratiAC: TComboBox;
    cmbTabArretratiAP: TComboBox;
    cmbRigheTredicesimaAC: TComboBox;
    cmbRigheTredicesimaAP: TComboBox;
    cmbRigheArretratiAC: TComboBox;
    cmbRigheArretratiAP: TComboBox;
    dmemRegolaManuale: TDBMemo;
    pnlRegole: TPanel;
    Label2: TLabel;
    dchkRegolaModif: TDBCheckBox;
    btnRipristina: TBitBtn;
    dCmbArrotondamento: TDBLookupComboBox;
    btnCodAccorpamento: TBitBtn;
    btnValoreCostante: TBitBtn;
    lblParametro2: TLabel;
    dedtParametro2: TDBEdit;
    procedure btnCodAccorpamentoClick(Sender: TObject);
    procedure cmbTabArretratiAPChange(Sender: TObject);
    procedure cmbTabArretratiACChange(Sender: TObject);
    procedure cmbTabTredicesimaAPChange(Sender: TObject);
    procedure cmbTabTredicesimaACChange(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
    procedure dchkRegolaModifClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure btnRipristinaClick(Sender: TObject);
    procedure dCmbArrotondamentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TRegisClick(Sender: TObject);
    procedure drdgModalitaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    TipoElab:String;
    NumElab:Integer;
    lstElencoAppoggio: TList<TItemsValues>;
    procedure CaricaComboTabelle;
  public
    { Public declarations }
    TabElab,AnnoElab:String;
  end;

var
  P552FDettaglioRegoleContoAnn: TP552FDettaglioRegoleContoAnn;

  procedure OpenP522DettaglioRegoleContoAnn(Numero,Anno:Integer;Tipo,Tabella:String);

implementation

uses P552URegoleContoAnnualeDtM;

{$R *.dfm}

procedure OpenP522DettaglioRegoleContoAnn(Numero,Anno:Integer;Tipo,Tabella:String);
begin
  Application.CreateForm(TP552FDettaglioRegoleContoAnn,P552FDettaglioRegoleContoAnn);
  with P552FDettaglioRegoleContoAnn do
  try
    TipoElab:=Tipo;
    NumElab:=Numero;
    AnnoElab:=IntToStr(Anno);
    TabElab:=Tabella;
    ShowModal;
  finally
    FreeAndNil(P552FDettaglioRegoleContoAnn);
  end;
end;

procedure TP552FDettaglioRegoleContoAnn.FormShow(Sender: TObject);
begin
  inherited;

  with P552FRegoleContoAnnualeDtM do
  begin
    dCmbArrotondamento.ListSource:=P552FRegoleContoAnnualeMW.dsrP050;
    if TipoElab = TIPO_ELAB_RIGA then
    begin
      DButton.DataSet:=P552FRegoleContoAnnualeMW.selP552Righe;
      P552FDettaglioRegoleContoAnn.Caption:='<P552> Dettaglio righe';
      P552FDettaglioRegoleContoAnn.HelpContext:=3552100;
      lblNumero.Caption:='Numero riga';
      dedtNumero.DataField:='RIGA';
      lblValoreCostante.Caption:='Codice';
      dedtValoreCostante.Width:=50;
      btnValoreCostante.Visible:=False;
      gpbAccorpamento.Caption:='Accorpamento voci';
      lblCodAccorpamento.Visible:=True;
      dedtCodAccorpamento.Visible:=True;
      btnCodAccorpamento.Visible:=True;
      gpbTabSostitutive.Caption:='Tabella e riga sostitutiva in caso di';
      //Se Tipo_Tabella_Righe <> 'Accorp.Voci' per le Righe non faccio vedere dati di Accorp.voci
      if VarToStr(selP552.Lookup('ANNO;COD_TABELLA',VarArrayOf([AnnoElab,TabElab]),'TIPO_TABELLA_RIGHE')) <> '2' then
      begin
        lblParametro2.Visible:=False;
        dedtParametro2.Visible:=False;
        gpbAccorpamento.Visible:=False;
        lblArrotondamento.Visible:=False;
        dCmbArrotondamento.Visible:=False;
        pnlRegole.Visible:=False;
        dmemRegolaManuale.Visible:=False;
      end;
      P552FRegoleContoAnnualeMW.selP552Righe.SearchRecord('RIGA',NumElab,[srFromBeginning]);
    end
    else if TipoElab = TIPO_ELAB_COLONNA then
    begin
      DButton.DataSet:=P552FRegoleContoAnnualeMW.selP552Colonne;
      P552FDettaglioRegoleContoAnn.Caption:='<P552> Dettaglio colonne';
      P552FDettaglioRegoleContoAnn.HelpContext:=3552200;
      lblNumero.Caption:='Numero colonna';
      dedtNumero.DataField:='COLONNA';
      lblValoreCostante.Caption:='Parametro';
      dedtValoreCostante.Width:=525;
      btnValoreCostante.Visible:=True;
      gpbAccorpamento.Caption:='';
      lblCodAccorpamento.Visible:=False;
      dedtCodAccorpamento.Visible:=False;
      btnCodAccorpamento.Visible:=False;
      gpbTabSostitutive.Caption:='Tabella e colonna sostitutiva in caso di';
      //Se Tipo_Tabella_Righe = 'Accorp.Voci' per le Colonne non faccio vedere dati di dettaglio
      if VarToStr(selP552.Lookup('ANNO;COD_TABELLA',VarArrayOf([AnnoElab,TabElab]),'TIPO_TABELLA_RIGHE')) = '2' then
      begin
        lblParametro2.Visible:=False;
        dedtParametro2.Visible:=False;
        gpbAccorpamento.Visible:=False;
        lblArrotondamento.Visible:=False;
        dCmbArrotondamento.Visible:=False;
        lblValoreCostante.Visible:=False;
        dedtValoreCostante.Visible:=False;
        btnValoreCostante.Visible:=False;
        pnlRegole.Visible:=False;
        dmemRegolaManuale.Visible:=False;
      end;
      P552FRegoleContoAnnualeMW.selP552Colonne.SearchRecord('COLONNA',NumElab,[srFromBeginning]);
    end;
    edtAnno.Text:=AnnoElab;
    edtTabella.Text:=TabElab;
    lblTabella.Caption:=VarToStr(selP552.Lookup('ANNO;COD_TABELLA',VarArrayOf([AnnoElab,TabElab]),'DESCRIZIONE'));
    CaricaComboTabelle;
  end;
  actRefresh.Execute;
end;

procedure TP552FDettaglioRegoleContoAnn.CaricaComboTabelle;
var lstElenco: TList<TItemsValues>;
    ItemValue: TItemsValues;
begin
  CmbTabTredicesimaAC.Items.Clear;
  CmbTabTredicesimaAP.Items.Clear;
  CmbTabArretratiAC.Items.Clear;
  CmbTabArretratiAP.Items.Clear;
  lstElenco:=TList<TItemsValues>.Create();
  P552FRegoleContoAnnualeDtM.P552FRegoleContoAnnualeMW.getLstTabelleDettaglio(lstElenco);
  for ItemValue in lstElenco do
  begin
    CmbTabTredicesimaAC.Items.Add(ItemValue.item);
    CmbTabTredicesimaAP.Items.Add(ItemValue.item);
    CmbTabArretratiAC.Items.Add(ItemValue.item);
    CmbTabArretratiAP.Items.Add(ItemValue.item);
  end;
  FreeAndNil(lstElenco);
end;

procedure TP552FDettaglioRegoleContoAnn.FormCreate(Sender: TObject);
begin
  inherited;
  lstElencoAppoggio:=TList<TitemsValues>.Create;
end;

procedure TP552FDettaglioRegoleContoAnn.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(lstElencoAppoggio);
end;

procedure TP552FDettaglioRegoleContoAnn.drdgModalitaClick(Sender: TObject);
begin
  inherited;
  gpbTabSostitutive.Visible:=drdgModalita.ItemIndex <> 0;
  //Se Tipo_Tabella_Righe = 'Accorp.Voci' per le Righe faccio sempre vedere CodAccorpamento
  if VarToStr(P552FRegoleContoAnnualeDtM.selP552.Lookup('ANNO;COD_TABELLA',VarArrayOf([AnnoElab,TabElab]),'TIPO_TABELLA_RIGHE')) = '2' then
  begin
    lblCodAccorpamento.Visible:=(TipoElab = TIPO_ELAB_RIGA);
    if lblCodAccorpamento.Visible then
      lblCodAccorpamento.Caption:='Parametro';
    dedtCodAccorpamento.Visible:=(TipoElab = TIPO_ELAB_RIGA);
  end
  else  //Se Tipo_Tabella_Righe <> 'Accorp.Voci' per le Righe faccio vedere CodAccorpamento se diverso da Nessun accorp.
  begin
    lblCodAccorpamento.Visible:=(TipoElab = TIPO_ELAB_RIGA) and (drdgModalita.ItemIndex <> 0);
    dedtCodAccorpamento.Visible:=(TipoElab = TIPO_ELAB_RIGA) and (drdgModalita.ItemIndex <> 0);
  end;
  btnCodAccorpamento.Visible:=(TipoElab = TIPO_ELAB_RIGA) and (drdgModalita.ItemIndex <> 0);
  btnValoreCostante.Visible:=(TipoElab = TIPO_ELAB_COLONNA) and (drdgModalita.ItemIndex <> 0);
end;

procedure TP552FDettaglioRegoleContoAnn.TRegisClick(Sender: TObject);
begin
  inherited;
  actRefresh.Execute;
end;

procedure TP552FDettaglioRegoleContoAnn.dCmbArrotondamentoKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TP552FDettaglioRegoleContoAnn.btnRipristinaClick(Sender: TObject);
begin
  inherited;
  if (R180MessageBox(A000MSG_P552_DLG_RIPRISTINO_REGOLA ,DOMANDA) = mrYes) then
    DButton.Dataset.FieldByName('REGOLA_CALCOLO_MANUALE').AsString:=DButton.Dataset.FieldByName('REGOLA_CALCOLO_AUTOMATICA').AsString;
end;

procedure TP552FDettaglioRegoleContoAnn.DButtonStateChange(Sender: TObject);
begin
  inherited;
  gpbTabSostitutive.Enabled:=DButton.State <> dsBrowse;
  btnCodAccorpamento.Enabled:=DButton.State <> dsBrowse;
  btnValoreCostante.Enabled:=DButton.State <> dsBrowse;
  dchkRegolaModifClick(nil);
end;

procedure TP552FDettaglioRegoleContoAnn.dchkRegolaModifClick(Sender: TObject);
begin
  inherited;
  dMemRegolaManuale.Enabled:=(DButton.State <> dsBrowse) and (dchkRegolaModif.Checked);
  btnRipristina.Enabled:=(DButton.State <> dsBrowse) and (dchkRegolaModif.Checked);
end;

procedure TP552FDettaglioRegoleContoAnn.TAnnullaClick(Sender: TObject);
begin
  inherited;
  actRefresh.Execute;
end;

procedure TP552FDettaglioRegoleContoAnn.cmbTabTredicesimaACChange(Sender: TObject);
var
  ItemValue: TItemsValues;
begin
  inherited;
  if (Sender = cmbTabTredicesimaAC) and
     (Trim(Copy(cmbTabTredicesimaAC.Text,1,10)) <>
      Copy(DButton.Dataset.FieldByName('NUMERO_TREDCORR').AsString,1,Pos('.',DButton.Dataset.FieldByName('NUMERO_TREDCORR').AsString)-1)) then
    CmbRigheTredicesimaAC.Text:='';
  CmbRigheTredicesimaAC.Items.Clear;
  if (Trim(CmbTabTredicesimaAC.Text) <> '') and (Trim(Copy(CmbTabTredicesimaAC.Text,1,10)) <> 'NC') then
  begin
    P552FRegoleContoAnnualeDtM.P552FRegoleContoAnnualeMW.getElementiCombo(TipoElab,AnnoElab,TrimRight(Copy(CmbTabTredicesimaAC.Text,1,10)), lstElencoAppoggio);
    for ItemValue in lstElencoAppoggio do
      CmbRigheTredicesimaAC.Items.Add(ItemValue.item);
    CmbRigheTredicesimaAC.Enabled:=True;
  end
  else
    CmbRigheTredicesimaAC.Enabled:=False;
end;

procedure TP552FDettaglioRegoleContoAnn.cmbTabTredicesimaAPChange(Sender: TObject);
var
  ItemValue: TItemsValues;
begin
  inherited;
  if (Sender = cmbTabTredicesimaAP) and
     (Trim(Copy(cmbTabTredicesimaAP.Text,1,10)) <>
      Copy(DButton.Dataset.FieldByName('NUMERO_TREDPREC').AsString,1,Pos('.',DButton.Dataset.FieldByName('NUMERO_TREDPREC').AsString)-1)) then
    CmbRigheTredicesimaAP.Text:='';
  CmbRigheTredicesimaAP.Items.Clear;
  if (Trim(CmbTabTredicesimaAP.Text) <> '') and (Trim(Copy(CmbTabTredicesimaAP.Text,1,10)) <> 'NC') then
  begin
    P552FRegoleContoAnnualeDtM.P552FRegoleContoAnnualeMW.getElementiCombo(TipoElab,AnnoElab,TrimRight(Copy(CmbTabTredicesimaAP.Text,1,10)), lstElencoAppoggio);
    for ItemValue in lstElencoAppoggio do
      CmbRigheTredicesimaAP.Items.Add(ItemValue.Item);
    CmbRigheTredicesimaAP.Enabled:=True;
  end
  else
    CmbRigheTredicesimaAP.Enabled:=False;
end;

procedure TP552FDettaglioRegoleContoAnn.cmbTabArretratiACChange(Sender: TObject);
var
  ItemValue: TItemsValues;
begin
  inherited;
  if (Sender = CmbTabArretratiAC) and
     (Trim(Copy(CmbTabArretratiAC.Text,1,10)) <>
      Copy(DButton.Dataset.FieldByName('NUMERO_ARRCORR').AsString,1,Pos('.',DButton.Dataset.FieldByName('NUMERO_ARRCORR').AsString)-1)) then
    CmbRigheArretratiAC.Text:='';
  CmbRigheArretratiAC.Items.Clear;
  if (Trim(CmbTabArretratiAC.Text) <> '') and (Trim(Copy(CmbTabArretratiAC.Text,1,10)) <> 'NC') then
  begin
    P552FRegoleContoAnnualeDtM.P552FRegoleContoAnnualeMW.getElementiCombo(TipoElab,AnnoElab,TrimRight(Copy(CmbTabArretratiAC.Text,1,10)), lstElencoAppoggio);
    for ItemValue in lstElencoAppoggio do
      CmbRigheArretratiAC.Items.Add(ItemValue.Item);
    CmbRigheArretratiAC.Enabled:=True;
  end
  else
    CmbRigheArretratiAC.Enabled:=False;
end;

procedure TP552FDettaglioRegoleContoAnn.cmbTabArretratiAPChange(Sender: TObject);
var
  ItemValue: TItemsValues;
begin
  inherited;
  if (Sender = CmbTabArretratiAP) and
     (Trim(Copy(CmbTabArretratiAP.Text,1,10)) <>
      Copy(DButton.Dataset.FieldByName('NUMERO_ARRPREC').AsString,1,Pos('.',DButton.Dataset.FieldByName('NUMERO_ARRPREC').AsString)-1)) then
    CmbRigheArretratiAP.Text:='';
  CmbRigheArretratiAP.Items.Clear;
  if (Trim(CmbTabArretratiAP.Text) <> '') and (Trim(Copy(CmbTabArretratiAP.Text,1,10)) <> 'NC') then
  begin
    P552FRegoleContoAnnualeDtM.P552FRegoleContoAnnualeMW.getElementiCombo(TipoElab,AnnoElab,TrimRight(Copy(CmbTabArretratiAP.Text,1,10)), lstElencoAppoggio);
    for ItemValue in lstElencoAppoggio do
      CmbRigheArretratiAP.Items.Add(ItemValue.Item);
    CmbRigheArretratiAP.Enabled:=True;
  end
  else
    CmbRigheArretratiAP.Enabled:=False;
end;

procedure TP552FDettaglioRegoleContoAnn.btnCodAccorpamentoClick(Sender: TObject);
var S:String;
  ElencoAccorpamenti: TElencoValoriCheckList;
begin
  inherited;
  // richiamo C013 per esplodere lista
  C013FCheckList:=TC013FCheckList.Create(nil);
  C013FCheckList.Caption:='Elenco accorpamenti';
  with C013FCheckList do
    try
      ElencoAccorpamenti:=P552FRegoleContoAnnualeDtM.P552FRegoleContoAnnualeMW.ElencoAccorpamenti;
      clbListaDati.Items.Assign(ElencoAccorpamenti.lstDescrizione);
      FreeAndNil(ElencoAccorpamenti);
      if Sender = btnCodAccorpamento then
        S:=dedtCodAccorpamento.Text
      else if Sender = btnValoreCostante then
        S:=dedtValoreCostante.Text;
      S:=StringReplace(Copy(S,5,Length(S)-6),''',''',',',[rfReplaceAll]);
      R180PutCheckList(S,21,clbListaDati);
      if ShowModal = mrOK then
      begin
        S:=R180GetCheckList(21,clbListaDati);
        if Trim(S) <> '' then
          S:='IN(''' + StringReplace(S,',',''',''',[rfReplaceAll]) + ''')';
      if Sender = btnCodAccorpamento then
//        dedtCodAccorpamento.Text:=S
      begin
        dButton.Dataset.FieldByName('CODICI_ACCORPAMENTOVOCI').AsString:=S;
        dedtCodAccorpamento.Hint:=dButton.Dataset.FieldByName('CODICI_ACCORPAMENTOVOCI').AsString;
      end
      else if Sender = btnValoreCostante then
//        dedtValoreCostante.Text:=S;
        dButton.Dataset.FieldByName('VALORE_COSTANTE').AsString:=S;
      end;
    finally
      Free;
    end;
end;

end.
