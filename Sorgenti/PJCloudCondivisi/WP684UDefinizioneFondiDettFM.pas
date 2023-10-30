unit WP684UDefinizioneFondiDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, IWDBStdCtrls,
  meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompLabel, meIWLabel, IWCompMemo, meIWDBMemo, medpIWMultiColumnComboBox,
  IWHTMLControls, meIWLink, WR100UBase, IWCompExtCtrls, meIWImageFile,
  Data.DB, A000UInterfaccia, meIWEdit, medpIWImageButton;

type
  TWP684FDefinizioneFondiDettFM = class(TWR205FDettTabellaFM)
    lblCodFondo: TmeIWLabel;
    dedtCodFondo: TmeIWDBEdit;
    lblDecorrenza: TmeIWLabel;
    dedtDecorrenza: TmeIWDBEdit;
    lblScadenza: TmeIWLabel;
    dedtScadenza: TmeIWDBEdit;
    lblDataCostituz: TmeIWLabel;
    dedtDataCostituz: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    dmemDescrizione: TmeIWDBMemo;
    lnkMacroCateg: TmeIWLink;
    cmbMacroCateg: TMedpIWMultiColumnComboBox;
    lblDescMacrocateg: TmeIWLabel;
    lnkRaggr: TmeIWLink;
    cmbRaggr: TMedpIWMultiColumnComboBox;
    lblDescRaggr: TmeIWLabel;
    lblFiltroDipendenti: TmeIWLabel;
    imgC700SelezioneAnagrafe: TmeIWImageFile;
    dmemFiltroDipendenti: TmeIWDBMemo;
    lblMonitoraggio: TmeIWLabel;
    lblDataMonitoraggio: TmeIWLabel;
    dedtDataMonitoraggio: TmeIWDBEdit;
    lblTotRisorse: TmeIWLabel;
    edtTotRisorse: TmeIWEdit;
    lblTotSpeso: TmeIWLabel;
    edtTotSpeso: TmeIWEdit;
    lblTotResiduo: TmeIWLabel;
    edtTotResiduo: TmeIWEdit;
    imgAccedi: TmeIWImageFile;
    dmemNote: TmeIWDBMemo;
    lblNote: TmeIWLabel;
    procedure cmbMacroCategAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbRaggrAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure dedtDecorrenzaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure lnkMacroCategClick(Sender: TObject);
    procedure lnkRaggrClick(Sender: TObject);
    procedure imgC700SelezioneAnagrafeClick(Sender: TObject);
    procedure imgAccediClick(Sender: TObject);
  private
    { Private declarations }
    procedure ResultSelAnagrafe(Sender: TObject; Result: Boolean);
    procedure AggiornaDescrizioniCombo;
  public
    { Public declarations }
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure AbilitaComponenti; override;
    procedure CaricaMultiColumnCombobox; override;
  end;

implementation

uses WP684UDefinizioneFondiDM, WP684UDefinizioneFondi, WP684UGrigliaDettDefinizioneFondiDM;

{$R *.dfm}

procedure TWP684FDefinizioneFondiDettFM.cmbMacroCategAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with (WR302DM as TWP684FDefinizioneFondiDM) do
    selTabella.FieldByName('COD_MACROCATEG').AsString:=cmbMacroCateg.Text;
  AggiornaDescrizioniCombo;
end;

procedure TWP684FDefinizioneFondiDettFM.cmbRaggrAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with (WR302DM as TWP684FDefinizioneFondiDM) do
    selTabella.FieldByName('COD_RAGGR').AsString:=cmbRaggr.Text;
  AggiornaDescrizioniCombo;
end;

procedure TWP684FDefinizioneFondiDettFM.dedtDecorrenzaAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  with (WR302DM as TWP684FDefinizioneFondiDM) do
  begin
    if (selTabella.State in [dsEdit,dsInsert]) and
      (not selTabella.FieldByName('DECORRENZA_DA').IsNull) and (selTabella.FieldByName('DECORRENZA_A').IsNull) then
      selTabella.FieldByName('DECORRENZA_A').AsDateTime:=StrToDate('31/12/' + Copy(selTabella.FieldByName('DECORRENZA_DA').AsString,7,4));
  end;
end;

procedure TWP684FDefinizioneFondiDettFM.lnkMacroCategClick(Sender: TObject);
begin
  inherited;
  (Self.Owner as TWR100FBase).AccediForm(607,'COD_MACROCATEG=' + cmbMacroCateg.Text);
end;

procedure TWP684FDefinizioneFondiDettFM.lnkRaggrClick(Sender: TObject);
begin
  inherited;
  (Self.Owner as TWR100FBase).AccediForm(608,'COD_RAGGR=' + cmbRaggr.Text);
end;

procedure TWP684FDefinizioneFondiDettFM.imgC700SelezioneAnagrafeClick(Sender: TObject);
var dDataSelAnagrafe: TDateTime;
begin
  if WR302DM.selTabella.State in [dsEdit,dsInsert] then
  begin
    with (Self.Owner as TWP684FDefinizioneFondi).grdC700 do
    begin
      dDataSelAnagrafe:=Parametri.DataLavoro;
      if not WR302DM.selTabella.FieldByName('DECORRENZA_A').IsNull then
        dDataSelAnagrafe:=WR302DM.selTabella.FieldByName('DECORRENZA_A').AsDateTime;
      WC700FM.C700DataLavoro:=dDataSelAnagrafe;
      WC700FM.C700DataDal:=dDataSelAnagrafe;
      if WC700FM.C700SettaPeriodoSelAnagrafe(dDataSelAnagrafe,dDataSelAnagrafe) then
        SelAnagrafe.CloseAll;
      SelAnagrafe.Open;
      WC700FM.ResultEvent:=ResultSelAnagrafe;
      actSelezioneAnagraficheExecute(nil);
    end;
  end;
end;

procedure TWP684FDefinizioneFondiDettFM.ResultSelAnagrafe(Sender: TObject; Result: Boolean);
var S:string;
begin
  if Result then
  begin
    S:=Trim((Self.Owner as TWP684FDefinizioneFondi).grdC700.WC700FM.SQLCreato.Text);
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    WR302DM.selTabella.FieldByName('FILTRO_DIPENDENTI').AsString:=(WR302DM AS TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW.TrasformaV430(S);
  end;
end;

procedure TWP684FDefinizioneFondiDettFM.imgAccediClick(Sender: TObject);
begin
  inherited;
  with (WR302DM AS TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW do
  begin
    DataElabGrigliaDett:=selP684.FieldByName('DECORRENZA_DA').AsDateTime;
    FondoElabGrigliaDett:=selP684.FieldByName('COD_FONDO').AsString;
    CodGenElabGrigliaDett:='';
    CodDetElabGrigliaDett:='';
  end;
  (Self.Owner as TWP684FDefinizioneFondi).ApriGrigliaDettDefinizioneFondi;
end;

procedure TWP684FDefinizioneFondiDettFM.DataSet2Componenti;
begin
  inherited;
  with (WR302DM as TWP684FDefinizioneFondiDM) do
  begin
    cmbMacroCateg.Text:=selTabella.FieldByName('COD_MACROCATEG').AsString;
    cmbRaggr.Text:=selTabella.FieldByName('COD_RAGGR').AsString;
  end;
  AggiornaDescrizioniCombo;
end;

procedure TWP684FDefinizioneFondiDettFM.Componenti2DataSet;
begin
  inherited;
  with (WR302DM as TWP684FDefinizioneFondiDM) do
  begin
    selTabella.FieldByName('COD_MACROCATEG').AsString:=cmbMacroCateg.Text;
    selTabella.FieldByName('COD_RAGGR').AsString:=cmbRaggr.Text;
  end;
end;

procedure TWP684FDefinizioneFondiDettFM.AbilitaComponenti;
var bEdit: Boolean;
begin
  inherited;
  bEdit:=WR302DM.selTabella.State in [dsEdit, dsInsert];
  if bEdit then
  begin
    //Campi non editabili
    dedtDataMonitoraggio.Enabled:=False;
    edtTotRisorse.Enabled:=False;
    edtTotSpeso.Enabled:=False;
    edtTotResiduo.Enabled:=False;
  end;
  imgAccedi.Enabled:=not bEdit;
  imgAccedi.Visible:=not bEdit;
end;

procedure TWP684FDefinizioneFondiDettFM.CaricaMultiColumnCombobox;
begin
  inherited;
  with (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW do
  begin
    selP680.Refresh;
    selP680.First;
    cmbMacroCateg.Items.Clear;
    while not selP680.Eof do
    begin
      cmbMacroCateg.AddRow(selP680.FieldByName('COD_MACROCATEG').AsString + ';' +
        selP680.FieldByName('DESCRIZIONE').AsString);
      selP680.Next;
    end;
    selP682.Refresh;
    selP682.First;
    cmbRaggr.Items.Clear;
    while not selP682.Eof do
    begin
      cmbRaggr.AddRow(selP682.FieldByName('COD_RAGGR').AsString + ';' +
        selP682.FieldByName('DESCRIZIONE').AsString);
      selP682.Next;
    end;
  end;
end;

procedure TWP684FDefinizioneFondiDettFM.AggiornaDescrizioniCombo;
begin
  with (WR302DM as TWP684FDefinizioneFondiDM) do
  begin
    lblDescMacroCateg.Caption:=VarToStr(P684FDefinizioneFondiMW.selP680.Lookup('COD_MACROCATEG',selTabella.FieldByName('COD_MACROCATEG').AsString,'DESCRIZIONE'));
    lblDescRaggr.Caption:=VarToStr(P684FDefinizioneFondiMW.selP682.Lookup('COD_RAGGR',selTabella.FieldByName('COD_RAGGR').AsString,'DESCRIZIONE'));
  end;
end;

end.
