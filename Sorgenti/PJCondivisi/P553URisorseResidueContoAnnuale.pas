unit P553URisorseResidueContoAnnuale;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  ExtCtrls, StdCtrls, DBCtrls, Mask, Oracle, OracleData, A000UCostanti, A000USessione, A000UInterfaccia, A002UInterfacciaSt,
  System.Actions;

type
  TP553FRisorseResidueContoAnnuale = class(TR001FGestTab)
    Panel2: TPanel;
    Label3: TLabel;
    dedtAnno: TDBEdit;
    Label4: TLabel;
    dmemDescrizione: TDBMemo;
    lblMacroCateg: TLabel;
    Label6: TLabel;
    dedtImpResid: TDBEdit;
    cmbMacroCateg: TDBLookupComboBox;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    lblColRiga: TLabel;
    grbColonnaCalcolo: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    cmbTabella: TComboBox;
    cmbColonnaRiga: TComboBox;
    cmbTabellaColonna: TComboBox;
    cmbColonna: TComboBox;
    procedure cmbColonnaRigaChange(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure cmbMacroCategKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbTabellaColonnaChange(Sender: TObject);
    procedure dedtAnnoExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbTabellaChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
  private
    lstAppoggio:TStringList;
    AnnoRegole:Integer;  //Lorena 31/07/2007
    procedure CaricaCombo(Tabella:String);
  public
    procedure CaricaComboTabelle;
  end;

var
  P553FRisorseResidueContoAnnuale: TP553FRisorseResidueContoAnnuale;

procedure OpenP553FRisorseResidueContoAnnuale;

implementation

{$R *.dfm}

uses P553URisorseResidueContoAnnualeDtM;

procedure OpenP553FRisorseResidueContoAnnuale;
var
  sInibizioni:string;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  sInibizioni:='OpenP553FRisorseResidueContoAnnuale';
  case A000GetInibizioni('Funzione',sInibizioni) of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TP553FRisorseResidueContoAnnuale, P553FRisorseResidueContoAnnuale);
  Application.CreateForm(TP553FRisorseResidueContoAnnualeDtM, P553FRisorseResidueContoAnnualeDtM);
  try
    Screen.Cursor:=crDefault;
    P553FRisorseResidueContoAnnuale.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    P553FRisorseResidueContoAnnuale.Free;
    P553FRisorseResidueContoAnnualeDtM.Free;
  end;
end;

//+++
procedure TP553FRisorseResidueContoAnnuale.FormCreate(Sender: TObject);
begin
  inherited;
  lstAppoggio:=TStringList.Create;
end;

//+++
procedure TP553FRisorseResidueContoAnnuale.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(lstAppoggio);
end;

//+++
procedure TP553FRisorseResidueContoAnnuale.FormShow(Sender: TObject);
begin
  inherited;
  cmbMacroCateg.ListSource:=P553FRisorseResidueContoAnnualeDtM.P553MW.dsrT470;
  CaricaComboTabelle;
  P553FRisorseResidueContoAnnualeDTM.selP553AfterScroll(DButton.Dataset);
end;

//+++
procedure TP553FRisorseResidueContoAnnuale.CaricaComboTabelle;
begin
  CmbTabella.Items.Clear;
  CmbTabellaColonna.Items.Clear;
  if Trim(dedtAnno.Text) = '' then
    Exit;

  with P553FRisorseResidueContoAnnualeDtM do
  begin
    AnnoRegole:=0;  //Lorena 31/07/2007
    P553MW.QSQL.Close;
    P553MW.QSQL.DeleteVariables;
    P553MW.QSQL.SQL.Clear;
    P553MW.QSQL.SQL.Add('SELECT MAX(ANNO) ANNO FROM P552_CONTOANNREGOLE WHERE ANNO <= ' + dedtAnno.Text);
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

procedure TP553FRisorseResidueContoAnnuale.TAnnullaClick(Sender: TObject);
begin
  inherited;
  actRefresh.Execute;
end;

//+++
procedure TP553FRisorseResidueContoAnnuale.cmbTabellaChange(Sender: TObject);
begin
  inherited;
  if (Sender = cmbTabella) and
     (Trim(Copy(cmbTabella.Text,1,10)) <> DButton.Dataset.FieldByName('COD_TABELLA').AsString) then
    CmbColonnaRiga.Text:='';
  CmbColonnaRiga.Items.Clear;
  if Trim(CmbTabella.Text) <> '' then
  begin
    P553FRisorseResidueContoAnnualeDtM.P553MW.selP552.SearchRecord('COD_TABELLA',TrimRight(Copy(CmbTabella.Text,1,10)),[srFromBeginning]);
    CaricaCombo(TrimRight(Copy(CmbTabella.Text,1,10)));
    CmbColonnaRiga.Items.AddStrings(lstAppoggio);
    CmbColonnaRiga.Enabled:=DButton.State in [dsEdit,dsInsert];
    if P553FRisorseResidueContoAnnualeDtM.P553MW.selP552.FieldByName('TIPO_TABELLA_RIGHE').AsString = '0' then
      lblColRiga.Caption:='Colonna'
    else
      lblColRiga.Caption:='Riga';
    cmbMacroCateg.Visible:=P553FRisorseResidueContoAnnualeDtM.P553MW.selP552.FieldByName('TIPO_TABELLA_RIGHE').AsString = '0';
    lblMacroCateg.Visible:=P553FRisorseResidueContoAnnualeDtM.P553MW.selP552.FieldByName('TIPO_TABELLA_RIGHE').AsString = '0';
    grbColonnaCalcolo.Visible:=P553FRisorseResidueContoAnnualeDtM.P553MW.selP552.FieldByName('TIPO_TABELLA_RIGHE').AsString = '0';
  end
  else
  begin
    CmbColonnaRiga.Enabled:=False;
    cmbMacroCateg.Visible:=False;
    lblMacroCateg.Visible:=False;
    grbColonnaCalcolo.Visible:=False;
  end;
  if DButton.State in [dsEdit,dsInsert] then
  begin
    if cmbMacroCateg.Visible then
    begin
      if (Trim(Copy(cmbTabella.Text,1,10)) <> DButton.Dataset.FieldByName('COD_TABELLA').AsString) then
        DButton.Dataset.FieldByName('MACRO_CATEG').AsString:='';
    end
    else
      DButton.Dataset.FieldByName('MACRO_CATEG').AsString:='0';
    if grbColonnaCalcolo.Visible then
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

//+++
procedure TP553FRisorseResidueContoAnnuale.CaricaCombo(Tabella:String);
var TipoElab:String;
begin
  lstAppoggio.Clear;
  with P553FRisorseResidueContoAnnualeDtM do
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

//+++
procedure TP553FRisorseResidueContoAnnuale.dedtAnnoExit(Sender: TObject);
begin
  inherited;
  CaricaComboTabelle;
end;

//+++
procedure TP553FRisorseResidueContoAnnuale.cmbTabellaColonnaChange(Sender: TObject);
begin
  inherited;
  if (Sender = cmbTabellaColonna) and
     (Trim(Copy(cmbTabellaColonna.Text,1,10)) <> DButton.Dataset.FieldByName('COD_TABELLA_QUOTE').AsString) then
    CmbColonna.Text:='';
  CmbColonna.Items.Clear;
  if Trim(cmbTabellaColonna.Text) <> '' then
  begin
    P553FRisorseResidueContoAnnualeDtM.P553MW.selP552.SearchRecord('COD_TABELLA',TrimRight(Copy(cmbTabellaColonna.Text,1,10)),[srFromBeginning]);
    CaricaCombo(TrimRight(Copy(cmbTabellaColonna.Text,1,10)));
    CmbColonna.Items.AddStrings(lstAppoggio);
    CmbColonna.Enabled:=DButton.State in [dsEdit,dsInsert];
  end
  else
    CmbColonna.Enabled:=False;
end;

procedure TP553FRisorseResidueContoAnnuale.cmbMacroCategKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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

//+++
procedure TP553FRisorseResidueContoAnnuale.DButtonStateChange(Sender: TObject);
begin
  inherited;
  cmbTabella.Enabled:=DButton.State in [dsEdit,dsInsert];
  cmbTabellaColonna.Enabled:=DButton.State in [dsEdit,dsInsert];
  cmbColonnaRiga.Enabled:=DButton.State in [dsEdit,dsInsert];
  cmbColonna.Enabled:=DButton.State in [dsEdit,dsInsert];
end;

//+++
procedure TP553FRisorseResidueContoAnnuale.cmbColonnaRigaChange(Sender: TObject);
begin
  inherited;
  if DButton.State in [dsEdit,dsInsert] then
  begin
    if Trim(dmemDescrizione.Text) = '' then
      DButton.Dataset.FieldByName('DESCRIZIONE').AsString:=Copy(cmbColonnaRiga.Text,5,Length(cmbColonnaRiga.Text)-4);
    if (grbColonnaCalcolo.Visible) and (Trim(cmbColonna.Text) = '') and
       (cmbTabella.Text = cmbTabellaColonna.Text) then
      cmbColonna.Text:=cmbColonnaRiga.Text;
  end;
end;

end.
