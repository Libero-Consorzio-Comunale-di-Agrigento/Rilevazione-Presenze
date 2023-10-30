unit WP553URisorseResidueContoAnnualeDettFM;

interface

uses
  C190FunzioniGeneraliWeb,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Data.DB, Oracle, OracleData,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompListbox, meIWComboBox,
  IWCompMemo, IWDBStdCtrls, meIWDBMemo, meIWDBLookupComboBox, IWCompEdit,
  meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompLabel, meIWLabel;

type
  TWP553FRisorseResidueContoAnnualeDettFM = class(TWR205FDettTabellaFM)
    lblAnno: TmeIWLabel;
    dedtAnno: TmeIWDBEdit;
    lblMacroCateg: TmeIWLabel;
    dcmbMacroCateg: TmeIWDBLookupComboBox;
    lblDescrizione: TmeIWLabel;
    dmemDescrizione: TmeIWDBMemo;
    lblDestinazione: TmeIWLabel;
    lblTabella: TmeIWLabel;
    cmbTabella: TmeIWComboBox;
    lblColRiga: TmeIWLabel;
    cmbColonnaRiga: TmeIWComboBox;
    lblTabellaColonna: TmeIWLabel;
    cmbTabellaColonna: TmeIWComboBox;
    cmbColonna: TmeIWComboBox;
    lblColonna: TmeIWLabel;
    lblColonnaCalcolo: TmeIWLabel;
    dedtImpResid: TmeIWDBEdit;
    lblImpResid: TmeIWLabel;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure cmbTabellaChange(Sender: TObject);
    procedure cmbTabellaColonnaChange(Sender: TObject);
    procedure cmbColonnaRigaChange(Sender: TObject);
    procedure dedtAnnoAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure IWFrameRegionRender(Sender: TObject);
  private
    PrimoRender:Boolean;
    lstAppoggio:TStringList;
    AnnoRegole:Integer;
  public
    GrpColonnaCalcoloVisibile: Boolean;
    procedure ReleaseOggetti; override;
    procedure CaricaComboTabelle;  //Lorena 31/07/2007
    procedure CaricaCombo(Tabella:String);
  end;

implementation

{$R *.dfm}

uses WP553URisorseResidueContoAnnualeDM;

{ TWP553FRisorseResidueContoAnnualeDettFM }

procedure TWP553FRisorseResidueContoAnnualeDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  lstAppoggio:=TStringList.Create;

  // v. Form.OnShow
  dcmbMacroCateg.ListSource:=(WR302DM as TWP553FRisorseResidueContoAnnualeDM).P553MW.dsrT470;
  PrimoRender:=True;
end;

procedure TWP553FRisorseResidueContoAnnualeDettFM.IWFrameRegionRender(
  Sender: TObject);
begin
  inherited;
  if PrimoRender then
  begin
    CaricaComboTabelle;
    (WR302DM as TWP553FRisorseResidueContoAnnualeDM).AfterScroll(WR302DM.dsrTabella.DataSet);
    PrimoRender:=False;
  end;
end;

procedure TWP553FRisorseResidueContoAnnualeDettFM.ReleaseOggetti;
begin
  FreeAndNil(lstAppoggio);
end;

procedure TWP553FRisorseResidueContoAnnualeDettFM.CaricaComboTabelle;
begin
  CmbTabella.Items.Clear;
  CmbTabellaColonna.Items.Clear;
  {
  if Trim(dedtAnno.Text) = '' then
    Exit;
  }
  with (WR302DM as TWP553FRisorseResidueContoAnnualeDM) do
  begin
    if selTabella.FieldByName('ANNO').IsNull then
      Exit;

    AnnoRegole:=0;  //Lorena 31/07/2007
    P553MW.QSQL.Close;
    P553MW.QSQL.DeleteVariables;
    P553MW.QSQL.SQL.Clear;
    P553MW.QSQL.SQL.Add('SELECT MAX(ANNO) ANNO FROM P552_CONTOANNREGOLE WHERE ANNO <= ' + selTabella.FieldByName('ANNO').AsString{dedtAnno.Text});
    P553MW.QSQL.Open;
    if P553MW.QSQL.RecordCount > 0 then
      AnnoRegole:=P553MW.QSQL.FieldByName('ANNO').AsInteger;
    P553MW.selP552.Close;
    P553MW.selP552.SetVariable('ANNO',AnnoRegole);
    P553MW.selP552.Open;
    P553MW.selP552.First;
    while not P553MW.selP552.Eof do
    begin
      CmbTabella.Items.Add(Format('%-10s',[P553MW.selP552.FieldByName('COD_TABELLA').AsString]) + '-' + P553MW.selP552.FieldByName('DESCRIZIONE').AsString);
      CmbTabellaColonna.Items.Add(Format('%-10s',[P553MW.selP552.FieldByName('COD_TABELLA').AsString]) + '-' + P553MW.selP552.FieldByName('DESCRIZIONE').AsString);
      P553MW.selP552.Next;
    end;
  end;
end;

procedure TWP553FRisorseResidueContoAnnualeDettFM.CaricaCombo(Tabella:String);
var TipoElab:String;
begin
  lstAppoggio.Clear;
  with (WR302DM as TWP553FRisorseResidueContoAnnualeDM) do
  begin
    TipoElab:='';
    if P553MW.selP552.FieldByName('TIPO_TABELLA_RIGHE').AsString = '0' then
      TipoElab:='COLONNA'
    else
      TipoElab:='RIGA';
    P553MW.QSQL.Close;
    P553MW.QSQL.SQL.Clear;
    P553MW.QSQL.SQL.Add('SELECT DISTINCT ' + TipoElab + ',DESCRIZIONE FROM P552_CONTOANNREGOLE');
    P553MW.QSQL.SQL.Add(' WHERE COD_TABELLA = ''' + Tabella + '''');
    P553MW.QSQL.SQL.Add('   AND ANNO = ' + IntToStr(AnnoRegole));
    P553MW.QSQL.SQL.Add('   AND ' + TipoElab + ' <> 0');
    P553MW.QSQL.Open;
    P553MW.QSQL.First;
    while not P553MW.QSQL.Eof do
    begin
      lstAppoggio.Add(Format('%-3s',[P553MW.QSQL.FieldByName(TipoElab).AsString]) + '-' + P553MW.QSQL.FieldByName('DESCRIZIONE').AsString);
      P553MW.QSQL.Next;
    end;
  end;
end;

procedure TWP553FRisorseResidueContoAnnualeDettFM.cmbTabellaChange(Sender: TObject);
begin
  inherited;
  if (Sender = cmbTabella) and
     (Trim(Copy(cmbTabella.Text,1,10)) <> WR302DM.dsrTabella.Dataset.FieldByName('COD_TABELLA').AsString) then
    cmbColonnaRiga.Text:='';
  cmbColonnaRiga.Items.Clear;
  if Trim(CmbTabella.Text) <> '' then
  begin
    (WR302DM as TWP553FRisorseResidueContoAnnualeDM).P553MW.selP552.SearchRecord('COD_TABELLA',TrimRight(Copy(CmbTabella.Text,1,10)),[srFromBeginning]);
    CaricaCombo(TrimRight(Copy(CmbTabella.Text,1,10)));
    cmbColonnaRiga.Items.AddStrings(lstAppoggio);
    cmbColonnaRiga.Enabled:=WR302DM.dsrTabella.State in [dsEdit,dsInsert];
    if (WR302DM as TWP553FRisorseResidueContoAnnualeDM).P553MW.selP552.FieldByName('TIPO_TABELLA_RIGHE').AsString = '0' then
      lblColRiga.Caption:='Colonna'
    else
      lblColRiga.Caption:='Riga';
    dcmbMacroCateg.Visible:=(WR302DM as TWP553FRisorseResidueContoAnnualeDM).P553MW.selP552.FieldByName('TIPO_TABELLA_RIGHE').AsString = '0';
    lblMacroCateg.Visible:=(WR302DM as TWP553FRisorseResidueContoAnnualeDM).P553MW.selP552.FieldByName('TIPO_TABELLA_RIGHE').AsString = '0';
    GrpColonnaCalcoloVisibile:=(WR302DM as TWP553FRisorseResidueContoAnnualeDM).P553MW.selP552.FieldByName('TIPO_TABELLA_RIGHE').AsString = '0';
    C190VisualizzaElemento(JQuery,'grpColonnaCalcolo',GrpColonnaCalcoloVisibile);
  end
  else
  begin
    cmbColonnaRiga.Enabled:=False;
    dcmbMacroCateg.Visible:=False;
    lblMacroCateg.Visible:=False;
    GrpColonnaCalcoloVisibile:=False;
    C190VisualizzaElemento(JQuery,'grpColonnaCalcolo',GrpColonnaCalcoloVisibile);
  end;
  if WR302DM.dsrTabella.State in [dsEdit,dsInsert] then
  begin
    if dcmbMacroCateg.Visible then
    begin
      if (Trim(Copy(cmbTabella.Text,1,10)) <> WR302DM.dsrTabella.Dataset.FieldByName('COD_TABELLA').AsString) then
        WR302DM.dsrTabella.Dataset.FieldByName('MACRO_CATEG').AsString:='';
    end
    else
      WR302DM.dsrTabella.Dataset.FieldByName('MACRO_CATEG').AsString:='0';
    if GrpColonnaCalcoloVisibile then
    begin
      if Trim(cmbTabellaColonna.Text) = '' then
        cmbTabellaColonna.Text:=cmbTabella.Text;
      cmbTabellaColonnaChange(nil);
      if Trim(cmbColonna.Text) = '' then
        cmbColonna.Text:=cmbColonnaRiga.Text;
    end
    else
    begin
      cmbTabellaColonna.Text:='';
      cmbColonna.Text:='';
    end;
  end;
end;

procedure TWP553FRisorseResidueContoAnnualeDettFM.cmbColonnaRigaChange(Sender: TObject);
begin
  inherited;
  if WR302DM.dsrTabella.State in [dsEdit,dsInsert] then
  begin
    if Trim(dmemDescrizione.Text) = '' then
      WR302DM.dsrTabella.Dataset.FieldByName('DESCRIZIONE').AsString:=Copy(cmbColonnaRiga.Text,5,Length(cmbColonnaRiga.Text)-4);
    if (GrpColonnaCalcoloVisibile) and (Trim(cmbColonna.Text) = '') and
       (cmbTabella.Text = cmbTabellaColonna.Text) then
      cmbColonna.Text:=cmbColonnaRiga.Text;
  end;
end;

procedure TWP553FRisorseResidueContoAnnualeDettFM.cmbTabellaColonnaChange(Sender: TObject);
begin
  inherited;
  if (Sender = cmbTabellaColonna) and
     (Trim(Copy(cmbTabellaColonna.Text,1,10)) <> WR302DM.dsrTabella.Dataset.FieldByName('COD_TABELLA_QUOTE').AsString) then
    cmbColonna.Text:='';
  cmbColonna.Items.Clear;
  if Trim(cmbTabellaColonna.Text) <> '' then
  begin
    (WR302DM as TWP553FRisorseResidueContoAnnualeDM).P553MW.selP552.SearchRecord('COD_TABELLA',TrimRight(Copy(cmbTabellaColonna.Text,1,10)),[srFromBeginning]);
    CaricaCombo(TrimRight(Copy(cmbTabellaColonna.Text,1,10)));
    cmbColonna.Items.AddStrings(lstAppoggio);
    cmbColonna.Enabled:=WR302DM.dsrTabella.State in [dsEdit,dsInsert];
  end
  else
    cmbColonna.Enabled:=False;
end;

procedure TWP553FRisorseResidueContoAnnualeDettFM.dedtAnnoAsyncChange(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  CaricaComboTabelle;
end;

end.
