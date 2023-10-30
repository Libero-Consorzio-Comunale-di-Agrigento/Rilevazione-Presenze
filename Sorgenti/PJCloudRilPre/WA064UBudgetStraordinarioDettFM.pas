unit WA064UBudgetStraordinarioDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, IWDBStdCtrls,
  meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompLabel, meIWLabel, medpIWMultiColumnComboBox, IWCompExtCtrls,
  meIWImageFile, DB, C180FunzioniGenerali, IWCompListbox, meIWComboBox,
  medpIWImageButton, A000UMessaggi, meIWDBComboBox,
  WC015USelEditGridFM, meIWEdit, WC013UCheckListFM, meIWDBLookupComboBox, meIWDBLabel, StrUtils;

type
  TWA064FBudgetStraordinarioDettFM = class(TWR205FDettTabellaFM)
    lblAnno: TmeIWLabel;
    dedtAnno: TmeIWDBEdit;
    dedtCodGruppo: TmeIWDBEdit;
    lblCodGruppo: TmeIWLabel;
    lblDescrizione: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    lblOre: TmeIWLabel;
    dedtOre: TmeIWDBEdit;
    lblImporto: TmeIWLabel;
    dedtImporto: TmeIWDBEdit;
    lblFiltroAnagrafe: TmeIWLabel;
    dedtFiltroAnagrafe: TmeIWDBEdit;
    lblTipo: TmeIWLabel;
    imgFiltroAnagrafe: TmeIWImageFile;
    cmbDalMese: TmeIWComboBox;
    cmbAlMese: TmeIWComboBox;
    lblDalMese: TmeIWLabel;
    lblAlMese: TmeIWLabel;
    btnDipendenti: TmedpIWImageButton;
    lblOperatori: TmeIWLabel;
    btnOperatori: TmedpIWImageButton;
    edtOperatori: TmeIWEdit;
    dcmbTipo: TMedpIWMultiColumnComboBox;
    lblDescTipo: TmeIWLabel;
    edtAutorizzatori: TmeIWEdit;
    lblAutorizzatori: TmeIWLabel;
    btnAutorizzatori: TmedpIWImageButton;
    procedure dedtAnnoAsyncExit(Sender: TObject; EventParams: TStringList);
    procedure cmbDalMeseAsyncExit(Sender: TObject; EventParams: TStringList);
    procedure cmbAlMeseAsyncExit(Sender: TObject; EventParams: TStringList);
    procedure imgSelAnagrafeClick(Sender: TObject);
    procedure btnDipendentiClick(Sender: TObject);
    procedure btnOperatoriClick(Sender: TObject);
    procedure dcmbTipoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
  private
    { Private declarations }
    WC013: TWC013FCheckListFM;
    WC015: TWC015FSelEditGridFM;
    procedure ResultSelAnagrafe(Sender: TObject; Result: Boolean);
    procedure ResultSelOperatori(Sender: TObject; Result:Boolean);
  public
    { Public declarations }
    procedure CaricaMultiColumnComboBox; override;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
  end;

implementation

uses C190FunzioniGeneraliWeb, WA064UBudgetStraordinarioDM,WA064UBudgetStraordinario;

{$R *.dfm}

procedure TWA064FBudgetStraordinarioDettFM.dcmbTipoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with TWA064FBudgetStraordinarioDM(WR302DM) do
  begin
    if Index <> -1 then
    begin
      selTabella.FieldByName('TIPO').AsString:=dcmbTipo.Text;
      lblDescTipo.Caption:=dcmbTipo.Items[Index].RowData[1];
    end
    else
    begin
      selTabella.FieldByName('TIPO').AsString:='';
      lblDescTipo.Caption:='';
    end;
  end;
end;

procedure TWA064FBudgetStraordinarioDettFM.dedtAnnoAsyncExit(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  cmbDalMeseAsyncExit(nil,nil);
  cmbAlMeseAsyncExit(nil,nil);
end;

procedure TWA064FBudgetStraordinarioDettFM.imgSelAnagrafeClick(Sender: TObject);
begin
  with (WR302DM as TWA064FBudgetStraordinarioDM).selTabella do
  begin
    if State in [dsEdit,dsInsert] then
      with TWA064FBudgetStraordinario(Self.Owner).grdC700 do
      begin
        WC700FM.ResultEvent:=resultSelAnagrafe;
        actSelezioneAnagraficheExecute(nil);
      end;
  end;
end;

procedure TWA064FBudgetStraordinarioDettFM.cmbDalMeseAsyncExit(Sender: TObject; EventParams: TStringList);
var Data:TDateTime;
begin
  inherited;
  try
    Data:=EncodeDate(StrToInt(dedtAnno.Text),R180NumeroMese(cmbDalMese.Text),1);
  except
    cmbDalMese.SetFocus;
    raise exception.Create(A000MSG_A064_ERR_INIZIO_VALIDITA);
  end;
  if R180NumeroMese(cmbDalMese.Text) > R180NumeroMese(cmbAlMese.Text) then
  begin
    cmbDalMese.SetFocus;
    raise exception.Create(A000MSG_A064_ERR_INIZIO_FINE_VALIDITA);
  end;
  (WR302DM as TWA064FBudgetStraordinarioDM).A064MW.selT713.FieldByName('DECORRENZA').AsDateTime:=Data;
end;

procedure TWA064FBudgetStraordinarioDettFM.DataSet2Componenti;
begin
  inherited;
  with TWA064FBudgetStraordinarioDM(WR302DM) do
  begin
    dcmbTipo.ItemIndex:=-1;
    dcmbTipo.Text:=selTabella.FieldByName('TIPO').AsString;
    lblDescTipo.Caption:=VarToStr(A064MW.selT275.LookUp('CODICE',selTabella.FieldByName('TIPO').AsString, 'DESCRIZIONE'));
  end;
end;

procedure TWA064FBudgetStraordinarioDettFM.Componenti2DataSet;
begin
  inherited;
  TWA064FBudgetStraordinarioDM(WR302DM).selTabella.FieldByName('TIPO').AsString:=dcmbTipo.Text;
end;

procedure TWA064FBudgetStraordinarioDettFM.cmbAlMeseAsyncExit(Sender: TObject; EventParams: TStringList);
var Data:TDateTime;
begin
  inherited;
  try
    Data:=EncodeDate(StrToInt(dedtAnno.Text),R180NumeroMese(cmbAlMese.Text),1);
  except
    cmbAlMese.SetFocus;
    raise exception.Create(A000MSG_A064_ERR_FINE_VALIDITA);
  end;
  if R180NumeroMese(cmbDalMese.Text) > R180NumeroMese(cmbAlMese.Text) then
  begin
    cmbAlMese.SetFocus;
    raise exception.Create(A000MSG_A064_ERR_INIZIO_FINE_VALIDITA);
  end;
  (WR302DM as TWA064FBudgetStraordinarioDM).A064MW.selT713.FieldByName('DECORRENZA_FINE').AsDateTime:=Data;
end;

procedure TWA064FBudgetStraordinarioDettFM.ResultSelAnagrafe(Sender: TObject; Result: Boolean);
var S:string;
begin
  if result then
  begin
    S:=Trim((Self.Owner as TWA064FBudgetStraordinario).grdC700.WC700FM.SQLCreato.Text);
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    (WR302DM as TWA064FBudgetStraordinarioDM).selTabella.FieldByName('FILTRO_ANAGRAFE').AsString:=S.Replace(#13#10,' ',[rfReplaceAll]);
  end;
end;

procedure TWA064FBudgetStraordinarioDettFM.btnOperatoriClick(Sender: TObject);
var
  lstOperatori: TStringList;
  lstSelezionati: TStringList;
  DimCodice, i: Integer;
begin
  inherited;
  if not ((WR302DM as TWA064FBudgetStraordinarioDM).selTabella.State in [dsEdit,dsInsert]) then
    exit;

  DimCodice:=1000;
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  try
    (WR302DM as TWA064FBudgetStraordinarioDM).A064MW.ResponsabileAutorizzatore:=Sender = btnAutorizzatori;
    (WR302DM as TWA064FBudgetStraordinarioDM).A064MW.selOperatori.Filtered:=True;
    lstOperatori:=(WR302DM as TWA064FBudgetStraordinarioDM).A064MW.GetLstOperatori;
    lstSelezionati:=(WR302DM as TWA064FBudgetStraordinarioDM).A064MW.GetLstOperatoriSelezionati;

    //Passo i valori da visualizzare mediante string list
    WC013.ckList.Items:=lstOperatori;
    C190PutCheckList(lstSelezionati.CommaText,
                     DimCodice,
                     WC013.ckList);

    WC013.ResultEvent:=ResultSelOperatori;
    WC013.Visualizza(0,0,IfThen(Sender=btnOperatori,'Operatori','Autorizzatori'));

  finally
    FreeAndNil(lstOperatori);
    FreeAndNil(lstSelezionati);
  end;
end;

procedure TWA064FBudgetStraordinarioDettFM.CaricaMultiColumnComboBox;
begin
  inherited;
  with TWA064FBudgetStraordinarioDM(WR302DM).A064MW.selT275 do
  begin
    Refresh;
    First;
    while not Eof do
    begin
      dcmbTipo.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      dcmbTipo.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
end;

procedure TWA064FBudgetStraordinarioDettFM.ResultSelOperatori(Sender: TObject; Result: Boolean);
var
  i, DimCodice: integer;
  lstSelezionati:TStringList;
  edt: TmeIWEdit;
begin
  if Result then
  begin
    DimCodice:=1000;
    lstSelezionati:=TStringList.Create;
    lstSelezionati.StrictDelimiter:=True;
    lstSelezionati.CommaText:=C190GetCheckList(DimCodice,WC013.ckList,',');
    (WR302DM as TWA064FBudgetStraordinarioDM).A064MW.SetLstOperatoriSelezionati(lstSelezionati);

    if (WR302DM as TWA064FBudgetStraordinarioDM).A064MW.ResponsabileAutorizzatore then
      edt:=edtAutorizzatori
    else
      edt:=edtOperatori;
    edt.Text:='';
    for i:=0 to lstSelezionati.Count-1 do
      edt.Text:=edt.Text + lstSelezionati[i] + '; ';
    exit;
  end;
end;

procedure TWA064FBudgetStraordinarioDettFM.btnDipendentiClick(Sender: TObject);
begin
  inherited;
  if Trim(TWA064FBudgetStraordinarioDM(WR302DM).A064MW.selT713.FieldByName('FILTRO_ANAGRAFE').AsString) = '' then
    exit;
  (WR302DM as TWA064FBudgetStraordinarioDM).A064MW.AperturaDipendenti;
  WC015:=TWC015FSelEditGridFM.Create(Self.Parent);
  WC015.Visualizza('Elenco dipendenti selezionati',TWA064FBudgetStraordinarioDM(WR302DM).A064MW.selbV430, False, False);
end;

end.
