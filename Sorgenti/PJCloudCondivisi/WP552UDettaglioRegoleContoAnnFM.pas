unit WP552UDettaglioRegoleContoAnnFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompButton, meIWButton, WR100UBase,
  IWCompLabel, meIWLabel, IWCompEdit, IWDBStdCtrls, meIWDBEdit, P552URegoleContoAnnualeMW,
  OracleData, WP552uRegoleContoAnnualeDM, Data.DB, A000UCostanti,WC013UCheckListFM,
  IWCompListbox, meIWDBLookupComboBox, C190FunzioniGeneraliWeb, IWCompExtCtrls,
  IWDBExtCtrls, meIWDBRadioGroup, meIWComboBox, Generics.Collections,
  IWCompMemo, meIWDBMemo, meIWImageFile, medpIWImageButton, IWCompCheckbox,
  meIWDBCheckBox, A000UInterfaccia, A000UMessaggi, medpIWMessageDlg;

type
  TWP552FDettaglioRegoleContoAnnFM = class(TWR200FBaseFM)
    btnChiudi: TmeIWButton;
    btnConferma: TmeIWButton;
    lblNumero: TmeIWLabel;
    dedtNumero: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    lblValoreCostante: TmeIWLabel;
    dedtValoreCostante: TmeIWDBEdit;
    btnValoreCostante: TmeIWButton;
    lblArrotondamento: TmeIWLabel;
    dcmbArrotondamento: TmeIWDBLookupComboBox;
    lblAccorpamento: TmeIWLabel;
    drgpModalita: TmeIWDBRadioGroup;
    lblModalitaAccorpamento: TmeIWLabel;
    dedtCodAccorpamento: TmeIWDBEdit;
    btnCodAccorpamento: TmeIWButton;
    lblCodAccorpamento: TmeIWLabel;
    lblTabSost: TmeIWLabel;
    lblTredicesimaAC: TmeIWLabel;
    cmbTabTredicesimaAC: TmeIWComboBox;
    cmbRigheTredicesimaAC: TmeIWComboBox;
    cmbTabTredicesimaAP: TmeIWComboBox;
    cmbRigheTredicesimaAP: TmeIWComboBox;
    lblTredicesimaAP: TmeIWLabel;
    lblArretratiAC: TmeIWLabel;
    lblArretratiAP: TmeIWLabel;
    cmbTabArretratiAC: TmeIWComboBox;
    cmbTabArretratiAP: TmeIWComboBox;
    cmbRigheArretratiAC: TmeIWComboBox;
    cmbRigheArretratiAP: TmeIWComboBox;
    lblRegolaManuale: TmeIWLabel;
    dchkRegolaModif: TmeIWDBCheckBox;
    btnRipristina: TmedpIWImageButton;
    dmemRegolaManuale: TmeIWDBMemo;
    lblParametro2: TmeIWLabel;
    dedtParametro2: TmeIWDBEdit;
    procedure btnChiudiClick(Sender: TObject);
    procedure btnValoreCostanteClick(Sender: TObject);
    procedure drgpModalitaClick(Sender: TObject);
    procedure btnCodAccorpamentoClick(Sender: TObject);
    procedure cmbTabTredicesimaACAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure cmbTabTredicesimaAPAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure cmbTabArretratiACAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure cmbTabArretratiAPAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure dchkRegolaModifAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure btnRipristinaClick(Sender: TObject);
  private
    bTabSost: Boolean;
    ODS: TOracleDataset;
    TipoElab:String;
    procedure ValoreCostanteResult(Sender: TObject; Result: Boolean);
    procedure AccorpamentoResult(Sender: TObject; Result: Boolean);
    procedure CaricaComboTabelle;
    procedure CaricaComboTab(cmbTab, cmbRighe: TmeIWCombobox);
    procedure AbilitazioneRegola;
    procedure ResultRipristino(Sender: TObject; R: TmeIWModalResult;
      KI: String);
  public
    procedure Visualizza(Titolo, Tipo: String);
  end;


implementation
uses WP552URegoleContoAnnuale;
{$R *.dfm}

procedure TWP552FDettaglioRegoleContoAnnFM.btnCodAccorpamentoClick(Sender: TObject);
var
  ElencoAccorpamenti: TElencoValoriChecklist;
  WC013: TWC013FCheckListFM;
  S: String;
  LstSel: TStringList;
begin
  try
    ElencoAccorpamenti:=(WR302DM as TWP552FRegoleContoAnnualeDM).P552FRegoleContoAnnualeMW.ElencoAccorpamenti;

    WC013:=TWC013FCheckListFM.Create(Self.Owner);
    WC013.CaricaLista(ElencoAccorpamenti.LstDescrizione, ElencoAccorpamenti.lstCodice);

    S:=dedtCodAccorpamento.Text;
    S:=StringReplace(Copy(S,5,Length(S)-6),''',''',',',[rfReplaceAll]);
    LstSel:=TStringList.Create;
    LstSel.StrictDelimiter:=True;
    LstSel.CommaText:=S;
    WC013.ImpostaValoriSelezionati(LstSel);
    FreeAndNil(LstSel);
    WC013.ResultEvent:=AccorpamentoResult;
    WC013.Visualizza(0,0,'<WC013> Elenco accorpamenti');
  finally
    FreeAndNil(ElencoAccorpamenti);
    if LstSel <> nil then
      FreeAndNil(LstSel);
  end;
end;

procedure TWP552FDettaglioRegoleContoAnnFM.btnRipristinaClick(Sender: TObject);
begin
  MsgBox.WebMessageDlg(A000MSG_P552_DLG_RIPRISTINO_REGOLA,mtConfirmation,[mbYes,mbNo],ResultRipristino,'');
end;

procedure TWP552FDettaglioRegoleContoAnnFM.ResultRipristino(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    ODS.FieldByName('REGOLA_CALCOLO_MANUALE').AsString:=ODS.FieldByName('REGOLA_CALCOLO_AUTOMATICA').AsString;
  end;
end;

procedure TWP552FDettaglioRegoleContoAnnFM.btnValoreCostanteClick(Sender: TObject);
var
  ElencoAccorpamenti: TElencoValoriChecklist;
  WC013: TWC013FCheckListFM;
  S: String;
  LstSel: TStringList;
begin
  try
    ElencoAccorpamenti:=(WR302DM as TWP552FRegoleContoAnnualeDM).P552FRegoleContoAnnualeMW.ElencoAccorpamenti;

    WC013:=TWC013FCheckListFM.Create(Self.Owner);
    WC013.CaricaLista(ElencoAccorpamenti.LstDescrizione, ElencoAccorpamenti.lstCodice);

    S:=dedtValoreCostante.Text;
    S:=StringReplace(Copy(S,5,Length(S)-6),''',''',',',[rfReplaceAll]);
    LstSel:=TStringList.Create;
    LstSel.StrictDelimiter:=True;
    LstSel.CommaText:=S;
    WC013.ImpostaValoriSelezionati(LstSel);
    FreeAndNil(LstSel);
    WC013.ResultEvent:=ValoreCostanteResult;
    WC013.Visualizza(0,0,'<WC013> Elenco accorpamenti');

  finally
    FreeAndNil(ElencoAccorpamenti);
    if LstSel <> nil then
      FreeAndNil(LstSel);
  end;
end;

procedure TWP552FDettaglioRegoleContoAnnFM.AccorpamentoResult(Sender: TObject; Result: Boolean);
var
  lstTmp: TStringList;
  S: string;
begin
  if Result then
  begin
    lstTmp:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    S:=lstTmp.CommaText;
    FreeAndNil(lstTmp);
    if Trim(S) <> '' then
      S:='IN(''' + StringReplace(S,',',''',''',[rfReplaceAll]) + ''')';

    ODS.FieldByName('CODICI_ACCORPAMENTOVOCI').AsString:=S;
  end;
end;

procedure TWP552FDettaglioRegoleContoAnnFM.ValoreCostanteResult(Sender: TObject; Result: Boolean);
var
  lstTmp: TStringList;
  S: string;
begin
  if Result then
  begin
    lstTmp:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    S:=lstTmp.CommaText;
    FreeAndNil(lstTmp);
    if Trim(S) <> '' then
      S:='IN(''' + StringReplace(S,',',''',''',[rfReplaceAll]) + ''')';

    ODS.FieldByName('VALORE_COSTANTE').AsString:=S;
  end;
end;

procedure TWP552FDettaglioRegoleContoAnnFM.dchkRegolaModifAsyncClick(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  AbilitazioneRegola;
end;

procedure TWP552FDettaglioRegoleContoAnnFM.AbilitazioneRegola;
begin
  dMemRegolaManuale.Enabled:=ODS.FieldByName('REGOLA_MODIFICABILE').AsString = 'S';
  btnRipristina.Enabled:=dMemRegolaManuale.Enabled;
end;

procedure TWP552FDettaglioRegoleContoAnnFM.drgpModalitaClick(Sender: TObject);
begin
  inherited;
  bTabSost:=ODS.FieldByName('DATA_ACCORPAMENTO').AsString <> 'NA';
  C190VisualizzaElemento(JQuery,'groupboxTabSost',bTabSost);
  //Se Tipo_Tabella_Righe = 'Accorp.Voci' per le Righe faccio sempre vedere CodAccorpamento
  if WR302DM.selTabella.FieldByName('TIPO_TABELLA_RIGHE').AsString = '2' then
  begin
    lblCodAccorpamento.Visible:=(TipoElab = TIPO_ELAB_RIGA);
    if lblCodAccorpamento.Visible then
      lblCodAccorpamento.Caption:='Parametro';
    dedtCodAccorpamento.Visible:=(TipoElab = TIPO_ELAB_RIGA);
  end
  else  //Se Tipo_Tabella_Righe <> 'Accorp.Voci' per le Righe faccio vedere CodAccorpamento se diverso da Nessun accorp.
  begin
    lblCodAccorpamento.Visible:=(TipoElab = TIPO_ELAB_RIGA) and (bTabSost);
    dedtCodAccorpamento.Visible:=(TipoElab = TIPO_ELAB_RIGA) and (bTabSost);
  end;
  btnCodAccorpamento.Visible:=(TipoElab = TIPO_ELAB_RIGA) and (bTabSost);
  btnValoreCostante.Visible:=(TipoElab = TIPO_ELAB_COLONNA) and (bTabSost);
end;

procedure TWP552FDettaglioRegoleContoAnnFM.Visualizza(Titolo: String; Tipo: String);
var
  dsr: TDataSource;
  bNascondiAccorpamento: Boolean;
  Val, AppTab, AppRighe: string;
  i: Integer;
begin
  TipoElab:=Tipo;
  with (WR302DM as TWP552FRegoleContoAnnualeDM) do
  begin
    P552FRegoleContoAnnualeMW.ImpostaAnnoSelP552Ricerca(WR302DM.selTabella.FieldByName('ANNO').AsInteger);
  end;
  bNascondiAccorpamento:=False;
  if TipoElab = TIPO_ELAB_RIGA then
  begin
    dsr:=(WR302DM as TWP552FRegoleContoAnnualeDM).P552FRegoleContoAnnualeMW.dsrP552Righe;
    lblNumero.Caption:='Numero riga';
    dedtNumero.DataField:='RIGA';
    lblValoreCostante.Caption:='Codice';
    dedtValoreCostante.css:='width10chr';
    btnValoreCostante.Visible:=False;
    if WR302DM.selTabella.FieldByName('TIPO_TABELLA_RIGHE').AsString <> '2' then
    begin
      lblParametro2.Visible:=False;
      dedtParametro2.Visible:=False;
      bNascondiAccorpamento:=True;
      lblArrotondamento.Visible:=False;
      dCmbArrotondamento.Visible:=False;
      lblRegolaManuale.Visible:=False;
      dchkRegolaModif.Visible:=False;
      btnRipristina.Visible:=False;
      dmemRegolaManuale.Visible:=False;
    end;
  end
  else
  begin
    dsr:=(WR302DM as TWP552FRegoleContoAnnualeDM).P552FRegoleContoAnnualeMW.dsrP552Colonne;
    lblNumero.Caption:='Numero colonna';
    dedtNumero.DataField:='COLONNA';
    lblValoreCostante.Caption:='Parametro';
    dedtValoreCostante.css:='width40chr';
    btnValoreCostante.Visible:=True;

    if WR302DM.selTabella.FieldByName('TIPO_TABELLA_RIGHE').AsString = '2' then
    begin
      lblParametro2.Visible:=False;
      dedtParametro2.Visible:=False;
      bNascondiAccorpamento:=True;
      lblArrotondamento.Visible:=False;
      dCmbArrotondamento.Visible:=False;
      lblValoreCostante.Visible:=False;
      dedtValoreCostante.Visible:=False;
      btnValoreCostante.Visible:=False;
      lblRegolaManuale.Visible:=False;
      dchkRegolaModif.Visible:=False;
      btnRipristina.Visible:=False;
      dmemRegolaManuale.Visible:=False;
    end;
  end;
  ODS:=(dsr.Dataset as TOracleDataSet);
  dedtNumero.DataSource:=dsr;
  dedtDescrizione.DataSource:=dsr;
  dedtValoreCostante.DataSource:=dsr;
  dedtParametro2.DataSource:=dsr;
  dcmbArrotondamento.DataSource:=dsr;
  dcmbArrotondamento.listSource:=(WR302DM as TWP552FRegoleContoAnnualeDM).P552FRegoleContoAnnualeMW.dsrP050;
  drgpModalita.DataSource:=dsr;
  dedtCodAccorpamento.DataSource:=dsr;
  dchkRegolaModif.DataSource:=dsr;
  dmemRegolaManuale.DataSource:=dsr;

  CaricaComboTabelle;
  AbilitazioneRegola;
  //TREDICESIMA AC
  val:=ODS.FieldByName('NUMERO_TREDCORR').AsString;
  if val = 'NC' then
  begin
    AppTab:=val;
    AppRighe:='';
  end
  else
  begin
    AppTab:=Copy(val,1,Pos('.',val)-1);
    AppRighe:=Copy(val, Pos('.',val)+1,Length(val)-Pos('.',val));
  end;

  for i:=0 to cmbTabTredicesimaAC.Items.Count - 1  do
  begin
    if cmbTabTredicesimaAC.Items.ValueFromIndex[i] = AppTab then
    begin
      cmbTabTredicesimaAC.ItemIndex:=i;
      Break;
    end;
  end;
  cmbTabTredicesimaACAsyncChange(nil,nil); //carica combo righe
  for i:=0 to cmbRigheTredicesimaAC.Items.Count - 1  do
  begin
    if cmbRigheTredicesimaAC.Items.ValueFromIndex[i] = AppRighe then
    begin
      cmbRigheTredicesimaAC.ItemIndex:=i;
      Break;
    end;
  end;

  //TREDICESIMA AP
  val:=ODS.FieldByName('NUMERO_TREDPREC').AsString;
  if val = 'NC' then
  begin
    AppTab:=val;
    AppRighe:='';
  end
  else
  begin
    AppTab:=Copy(val,1,Pos('.',val)-1);
    AppRighe:=Copy(val, Pos('.',val)+1,Length(val)-Pos('.',val));
  end;

  for i:=0 to cmbTabTredicesimaAP.Items.Count - 1  do
  begin
    if cmbTabTredicesimaAP.Items.ValueFromIndex[i] = AppTab then
    begin
      cmbTabTredicesimaAP.ItemIndex:=i;
      Break;
    end;
  end;
  cmbTabTredicesimaAPAsyncChange(nil,nil); //carica combo righe
  for i:=0 to cmbRigheTredicesimaAP.Items.Count - 1  do
  begin
    if cmbRigheTredicesimaAP.Items.ValueFromIndex[i] = AppRighe then
    begin
      cmbRigheTredicesimaAP.ItemIndex:=i;
      Break;
    end;
  end;

  //ARRETRATI AC
  val:=ODS.FieldByName('NUMERO_ARRCORR').AsString;
  if val = 'NC' then
  begin
    AppTab:=val;
    AppRighe:='';
  end
  else
  begin
    AppTab:=Copy(val,1,Pos('.',val)-1);
    AppRighe:=Copy(val, Pos('.',val)+1,Length(val)-Pos('.',val));
  end;

  for i:=0 to cmbTabArretratiAC.Items.Count - 1  do
  begin
    if cmbTabArretratiAC.Items.ValueFromIndex[i] = AppTab then
    begin
      cmbTabArretratiAC.ItemIndex:=i;
      Break;
    end;
  end;
  cmbTabArretratiACAsyncChange(nil,nil); //carica combo righe
  for i:=0 to cmbRigheArretratiAC.Items.Count - 1  do
  begin
    if cmbRigheArretratiAC.Items.ValueFromIndex[i] = AppRighe then
    begin
      cmbRigheArretratiAC.ItemIndex:=i;
      Break;
    end;
  end;

  //ARRETRATI AP
  val:=ODS.FieldByName('NUMERO_ARRPREC').AsString;
  if val = 'NC' then
  begin
    AppTab:=val;
    AppRighe:='';
  end
  else
  begin
    AppTab:=Copy(val,1,Pos('.',val)-1);
    AppRighe:=Copy(val, Pos('.',val)+1,Length(val)-Pos('.',val));
  end;

  for i:=0 to cmbTabArretratiAP.Items.Count - 1  do
  begin
    if cmbTabArretratiAP.Items.ValueFromIndex[i] = AppTab then
    begin
      cmbTabArretratiAP.ItemIndex:=i;
      Break;
    end;
  end;
  cmbTabArretratiAPAsyncChange(nil,nil); //carica combo righe
  for i:=0 to cmbRigheArretratiAP.Items.Count - 1  do
  begin
    if cmbRigheArretratiAP.Items.ValueFromIndex[i] = AppRighe then
    begin
      cmbRigheArretratiAP.ItemIndex:=i;
      Break;
    end;
  end;

  (Self.Parent as TWR100FBase).VisualizzaJQMessaggio(jQuery,700,-1,450,Titolo,'#' + Self.Name,False,False);

  drgpModalitaClick(nil); //per impostare campi visibile
  if bNascondiAccorpamento then
  begin
    C190VisualizzaElemento(JQuery,'groupboxAccorpamento',False);
  end;
end;

procedure TWP552FDettaglioRegoleContoAnnFM.CaricaComboTabelle;
var
  lstElenco: TList<TItemsValues>;
  ItemValue: TItemsValues;
  S: string;
begin
  CmbTabTredicesimaAC.Items.Clear;
  CmbTabTredicesimaAP.Items.Clear;
  CmbTabArretratiAC.Items.Clear;
  CmbTabArretratiAP.Items.Clear;
  lstElenco:=TList<TItemsValues>.Create();
  (WR302DM as TWP552FRegoleContoAnnualeDM).P552FRegoleContoAnnualeMW.getLstTabelleDettaglio(lstElenco);
  for ItemValue in lstElenco do
  begin
    S:=Format('%s=%s',[ItemValue.item,ItemValue.value]);
    CmbTabTredicesimaAC.Items.Add(S);
    CmbTabTredicesimaAP.Items.Add(S);
    CmbTabArretratiAC.Items.Add(S);
    CmbTabArretratiAP.Items.Add(S);
  end;
  FreeAndNil(lstElenco);
end;

procedure TWP552FDettaglioRegoleContoAnnFM.cmbTabArretratiACAsyncChange(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  CaricaComboTab(cmbTabArretratiAC,cmbRigheArretratiAC);
end;

procedure TWP552FDettaglioRegoleContoAnnFM.cmbTabArretratiAPAsyncChange(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  CaricaComboTab(cmbTabArretratiAP,cmbRigheArretratiAP);
end;

procedure TWP552FDettaglioRegoleContoAnnFM.cmbTabTredicesimaACAsyncChange(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  CaricaComboTab(cmbTabTredicesimaAC,cmbRigheTredicesimaAC);
end;

procedure TWP552FDettaglioRegoleContoAnnFM.cmbTabTredicesimaAPAsyncChange(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  CaricaComboTab(cmbTabTredicesimaAP,cmbRigheTredicesimaAP);
end;

procedure TWP552FDettaglioRegoleContoAnnFM.CaricaComboTab(cmbTab,cmbRighe:TmeIWCombobox);
var
  valTab: String;
  ItemValue: TItemsValues;
  lstElencoAppoggio: Tlist<TItemsValues>;
begin
  valTab:='';
  if cmbTab.ItemIndex <> -1 then
    valTab:=Trim(cmbTab.Items.ValueFromIndex[cmbTab.ItemIndex]);

  cmbRighe.Items.Clear;
  lstElencoAppoggio:=Tlist<TItemsValues>.Create();
  try
    if (Trim(valTab) <> '') and (valTab <> 'NC') then
    begin
      (WR302DM as TWP552FRegoleContoAnnualeDM).P552FRegoleContoAnnualeMW.getElementiCombo(TipoElab,IntToStr(WR302DM.selTabella.FieldByName('ANNO').AsInteger),valTab, lstElencoAppoggio);
      for ItemValue in lstElencoAppoggio do
        CmbRighe.Items.Add(Format('%s=%s',[ItemValue.item,ItemValue.value]));
      CmbRighe.Enabled:=True;
    end
    else
      CmbRighe.Enabled:=False;
  finally
    FreeAndNil(lstElencoAppoggio);
  end;
end;

procedure TWP552FDettaglioRegoleContoAnnFM.btnChiudiClick(Sender: TObject);
begin
  inherited;
  if Sender = btnConferma then
  begin
    with (WR302DM as TWP552FRegoleContoAnnualeDM) do
    begin
      if CmbTabTredicesimaAC.ItemIndex <> -1 then
        DettaglioRegole.TabTredicesimaAC:=CmbTabTredicesimaAC.Items.ValueFromIndex[CmbTabTredicesimaAC.ItemIndex]
      else
        DettaglioRegole.TabTredicesimaAC:='';

      if CmbRigheTredicesimaAC.ItemIndex <> -1 then
        DettaglioRegole.RigheTredicesimaAC:=CmbRigheTredicesimaAC.Items.ValueFromIndex[CmbRigheTredicesimaAC.ItemIndex]
      else
        DettaglioRegole.RigheTredicesimaAC:='';

      if CmbTabTredicesimaAP.ItemIndex <> -1 then
        DettaglioRegole.TabTredicesimaAP:=CmbTabTredicesimaAP.Items.ValueFromIndex[CmbTabTredicesimaAP.ItemIndex]
      else
        DettaglioRegole.TabTredicesimaAP:='';

      if CmbRigheTredicesimaAP.ItemIndex <> -1 then
        DettaglioRegole.RigheTredicesimaAP:=CmbRigheTredicesimaAP.Items.ValueFromIndex[CmbRigheTredicesimaAP.ItemIndex]
      else
        DettaglioRegole.RigheTredicesimaAP:='';

      if CmbTabArretratiAC.ItemIndex <> -1 then
        DettaglioRegole.TabArretratiAC:=CmbTabArretratiAC.Items.ValueFromIndex[CmbTabArretratiAC.ItemIndex]
      else
        DettaglioRegole.TabArretratiAC:='';

      if CmbRigheArretratiAC.ItemIndex <> -1 then
        DettaglioRegole.RigheArretratiAC:=CmbRigheArretratiAC.Items.ValueFromIndex[CmbRigheArretratiAC.ItemIndex]
      else
        DettaglioRegole.RigheArretratiAC:='';

      if CmbTabArretratiAP.ItemIndex <> -1 then
        DettaglioRegole.TabArretratiAP:=CmbTabArretratiAP.Items.ValueFromIndex[CmbTabArretratiAP.ItemIndex]
      else
        DettaglioRegole.TabArretratiAP:='';

      if CmbRigheArretratiAP.ItemIndex <> -1 then
        DettaglioRegole.RigheArretratiAP:=CmbRigheArretratiAP.Items.ValueFromIndex[CmbRigheArretratiAP.ItemIndex]
      else
        DettaglioRegole.RigheArretratiAP:='';

      DettaglioRegole.TabElab:=SelTabella.FieldByName('COD_TABELLA').AsString;
      DettaglioRegole.AnnoElab:=SelTabella.FieldByName('ANNO').AsInteger;
      DettaglioRegole.bAccorpamento:=dedtCodAccorpamento.Visible;
      DettaglioRegole.bTabSostitutive:=bTabSost;
    end;

    if TipoElab = TIPO_ELAB_RIGA  then
      (Self.Owner as TWP552FRegoleContoAnnuale).DetailRighe.actConfermaExecute(nil)
    else
      (Self.Owner as TWP552FRegoleContoAnnuale).DetailColonne.actConfermaExecute(nil);
  end
  else
  begin
    if TipoElab = TIPO_ELAB_RIGA  then
      (Self.Owner as TWP552FRegoleContoAnnuale).DetailRighe.actAnnullaExecute(nil)
    else
      (Self.Owner as TWP552FRegoleContoAnnuale).DetailColonne.actAnnullaExecute(nil);
  end;
  ReleaseOggetti;
  Free;
end;

end.
