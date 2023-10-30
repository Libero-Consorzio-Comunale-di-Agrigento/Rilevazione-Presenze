unit WA169UPesatureIndividualiDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompLabel, meIWLabel, meIWDBLabel, medpIWMultiColumnComboBox, IWCompExtCtrls, meIWImageFile,
  meIWEdit, medpIWImageButton, DB, A000UInterfaccia, C180FunzioniGenerali, IWCompCheckbox,
  meIWDBCheckBox, WA169UPesatureIndividualiDM, A000UCostanti, WR100UBase;

type
  TWA169FPesatureIndividualiDettFM = class(TWR205FDettTabellaFM)
    lblAnno: TmeIWLabel;
    dedtAnno: TmeIWDBEdit;
    dedtDataRif: TmeIWDBEdit;
    lblDataRif: TmeIWLabel;
    lblCodice: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
    dedtDescrizione: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    cmbTipoQuota: TMedpIWMultiColumnComboBox;
    lblTipoQuota: TmeIWLabel;
    dedtFiltroAnagrafe: TmeIWDBEdit;
    lblFiltroAnagrafe: TmeIWLabel;
    imgC700SelezioneAnagrafe: TmeIWImageFile;
    dedtPesoIndMin: TmeIWDBEdit;
    lblPesoIndMin: TmeIWLabel;
    lblPesoIndMax: TmeIWLabel;
    lblPesoTotale: TmeIWLabel;
    lblQuotaTotale: TmeIWLabel;
    dedtPesoIndMax: TmeIWDBEdit;
    dedtPesoTotale: TmeIWDBEdit;
    dedtQuotaTotale: TmeIWDBEdit;
    lblTotPesiCalc: TmeIWLabel;
    lblTotQuote: TmeIWLabel;
    lblTotQuoteCalc: TmeIWLabel;
    edtTotPesiCalc: TmeIWEdit;
    lblTotPesi: TmeIWLabel;
    edtTotPesi: TmeIWEdit;
    edtTotQuote: TmeIWEdit;
    edtTotQuoteCalc: TmeIWEdit;
    btnAnomalie: TmedpIWImageButton;
    lblDescTipoQuota: TmeIWDBLabel;
    dchkChiuso: TmeIWDBCheckBox;
    procedure imgC700SelezioneAnagrafeClick(Sender: TObject);
    procedure cmbTipoQuotaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure btnAnomalieClick(Sender: TObject);
    procedure dedtAnnoAsyncExit(Sender: TObject; EventParams: TStringList);
    procedure dedtDataRifAsyncEnter(Sender: TObject; EventParams: TStringList);
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    procedure ResultSelAnagrafe(Sender: TObject; Result: Boolean);
  public
    procedure DataSet2Componenti; override;
    procedure CaricaMultiColumnCombobox; override;
    procedure AbilitaComponenti; override;
  end;

implementation
uses WA169UPesatureIndividuali;

{$R *.dfm}

procedure TWA169FPesatureIndividualiDettFM.imgC700SelezioneAnagrafeClick(Sender: TObject);
var
  dDataSelAnagrafe: TDateTime;
begin
  inherited;
  if WR302DM.selTabella.State in [dsEdit,dsInsert] then
  begin
    with (Self.Owner as TWA169FPesatureIndividuali).grdC700 do
    begin
      dDataSelAnagrafe:=Parametri.DataLavoro;
      if WR302DM.selTabella.FieldByName('DATARIF').AsDateTime <> DATE_NULL then
        dDataSelAnagrafe:=WR302DM.selTabella.FieldByName('DATARIF').AsDateTime;
      WC700FM.C700SettaPeriodoSelAnagrafe(dDataSelAnagrafe,dDataSelAnagrafe);
      WC700FM.ResultEvent:=ResultSelAnagrafe;
      actSelezioneAnagraficheExecute(nil);
    end;
  end;
end;

procedure TWA169FPesatureIndividualiDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  btnAnomalie.Enabled:=False;
end;

procedure TWA169FPesatureIndividualiDettFM.ResultSelAnagrafe(Sender: TObject; Result: Boolean);
var S:string;
begin
  if Result then
  begin
    S:=Trim((Self.Owner as TWA169FPesatureIndividuali).grdC700.WC700FM.SQLCreato.Text);
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    WR302DM.selTabella.FieldByName('FILTRO_ANAGRAFE').AsString:=S.Replace(#13#10,' ',[rfReplaceAll]);
  end;
end;

procedure TWA169FPesatureIndividualiDettFM.CaricaMultiColumnCombobox;
begin
  inherited;
  with (WR302DM AS TWA169FPesatureIndividualiDM).A169FPesatureIndividualiMW do
  begin
    cmbTipoQuota.Items.Clear;
    selT765.First;
    while not selT765.Eof do
    begin
      cmbTipoQuota.AddRow(Format('%s;%s',[selT765.FieldByName('CODICE').AsString,selT765.FieldByName('DESCRIZIONE').AsString]));
      selT765.Next;
    end;
  end;
end;

procedure TWA169FPesatureIndividualiDettFM.cmbTipoQuotaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  WR302DM.selTabella.FieldByName('CODTIPOQUOTA').AsString:=cmbTipoQuota.Text;
end;

procedure TWA169FPesatureIndividualiDettFM.DataSet2Componenti;
begin
   with (WR302DM AS TWA169FPesatureIndividualiDM) do
  begin
    cmbTipoQuota.Text:=SelTabella.FieldByName('CODTIPOQUOTA').AsString;
    lblDescTipoQuota.Text:=(WR302DM AS TWA169FPesatureIndividualiDM).A169FPesatureIndividualiMW.selT765.FieldByName('DESCRIZIONE').AsString;
  end;
end;

procedure TWA169FPesatureIndividualiDettFM.dedtAnnoAsyncExit(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  if (WR302DM.selTabella.State in [dsEdit,dsInsert]) and (WR302DM.selTabella.FieldByName('ANNO').asString <> '') and
     (WR302DM.selTabella.FieldByName('DATARIF').IsNull) then
     WR302DM.selTabella.FieldByName('DATARIF').AsDateTime:=StrToDate('31/12/' + WR302DM.selTabella.FieldByName('ANNO').asString);
end;

procedure TWA169FPesatureIndividualiDettFM.dedtDataRifAsyncEnter(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  //riutilizzo la stessa procedure dell'uscita dal campo Anno
  dedtAnnoAsyncExit(Sender, EventParams);
end;

procedure TWA169FPesatureIndividualiDettFM.AbilitaComponenti;
var
  bEdit: Boolean;
begin
  inherited;
  with WR302DM.selTabella do
  begin
    edtTotPesi.ReadOnly:=True;
    edtTotPesiCalc.ReadOnly:=True;
    edtTotQuote.ReadOnly:=True;
    edtTotQuoteCalc.ReadOnly:=True;
    btnAnomalie.Enabled:=False;
  end;
end;

procedure TWA169FPesatureIndividualiDettFM.btnAnomalieClick(Sender: TObject);
var
  Params: String;
begin
  inherited;
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' + Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + (Self.parent as TWR100FBase).medpCodiceForm + ParamDelimiter +
          'ID=' + IntToStr(RegistraMsg.ID) + ParamDelimiter +
          'TIPO=A,B,I';
  (Self.parent as TWR100FBase).accediForm(201,Params,True);
end;

end.
