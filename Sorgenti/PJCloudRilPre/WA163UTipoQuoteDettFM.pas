unit WA163UTipoQuoteDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompLabel, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompEdit, IWDBStdCtrls,
  meIWDBEdit, meIWLabel, IWCompExtCtrls, meIWRadioGroup, IWDBExtCtrls,
  meIWDBRadioGroup, medpIWMultiColumnComboBox, IWCompText, meIWDBText,
  meIWDBLabel, IWCompButton, meIWButton, WC013UCheckListFM,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, DB,
  IWCompCheckbox, meIWDBCheckBox;

type
  TWA163FTipoQuoteDettFM = class(TWR205FDettTabellaFM)
    dedtCodice: TmeIWDBEdit;
    Label1: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    Label2: TmeIWLabel;
    lblVPIntera: TmeIWLabel;
    lblVPProporzionata: TmeIWLabel;
    lblVPNetta: TmeIWLabel;
    lblVPNettaRisp: TmeIWLabel;
    lblVPRisparmio: TmeIWLabel;
    lblVPNoRisp: TmeIWLabel;
    lblVPQuantitativa: TmeIWLabel;
    dedtVPIntera: TmeIWDBEdit;
    dedtVPProporzionata: TmeIWDBEdit;
    dedtVPNetta: TmeIWDBEdit;
    dedtVPNettaRisp: TmeIWDBEdit;
    dedtVPRisparmio: TmeIWDBEdit;
    dedtVPNoRisp: TmeIWDBEdit;
    dedtVPQuantitativa: TmeIWDBEdit;
    drdgTipologia: TmeIWDBRadioGroup;
    dcmbcausale: TMedpIWMultiColumnComboBox;
    lblCausale: TmeIWLabel;
    dlblCausale: TmeIWDBLabel;
    btnAcconti: TmeIWButton;
    lblAcconti: TmeIWLabel;
    dedtAcconti: TmeIWDBEdit;
    dchkImpostaMeseCompMax: TmeIWDBCheckBox;
    dchkRifSaldoAnnoCorr: TmeIWDBCheckBox;
    lblGiorniMese: TmeIWLabel;
    dedtGiorniMese: TmeIWDBEdit;
    procedure drdgTipologiaClick(Sender: TObject);
    procedure btnAccontiClick(Sender: TObject);
    procedure dcmbCausaleAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure dchkRifSaldoAnnoCorrClick(Sender: TObject);
    procedure dedtGiorniMeseAsyncChange(Sender: TObject;
      EventParams: TStringList);
  private
    WC013: TWC013FCheckListFM;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnCombobox; override;
    procedure CaricaLista;
    procedure ResultAcconti(Sender: TObject; Result:Boolean);
  public
    procedure AbilitaComponenti; override;
  end;

implementation

uses WR102UGestTabella, WA163UTipoQuoteDM, IWInit;

{$R *.dfm}

procedure TWA163FTipoQuoteDettFM.DataSet2Componenti;
begin
  with TWA163FTipoQuoteDM(WR302DM) do
    dcmbCausale.Text:=selTabella.FieldByName('CAUSALE_ASSESTAMENTO').AsString;
end;

procedure TWA163FTipoQuoteDettFM.Componenti2DataSet;
begin
  with TWA163FTipoQuoteDM(WR302DM) do
    selTabella.FieldByName('CAUSALE_ASSESTAMENTO').AsString:=dcmbCausale.Text;
end;

procedure TWA163FTipoQuoteDettFM.CaricaMultiColumnCombobox;
begin
  inherited;
  with (WR302DM as TWA163FTipoQuoteDM).A163FTipoQuoteMW do
  begin
    selT305.First;
    dcmbCausale.Items.Clear;
    while not selT305.Eof do
    begin
      dcmbCausale.AddRow(selT305.FieldByName('CODICE').AsString + ';' + selT305.FieldByName('DESCRIZIONE').AsString);
      selT305.Next;
    end;
  end;
end;

procedure TWA163FTipoQuoteDettFM.drdgTipologiaClick(Sender: TObject);
begin
  AbilitaComponenti;
end;

procedure TWA163FTipoQuoteDettFM.btnAccontiClick(Sender: TObject);
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  CaricaLista;
  with WC013 do
  begin
    C190PutCheckList(dedtAcconti.Text,5,ckList);
    ResultEvent:=ResultAcconti;
    Visualizza;
  end;
end;

procedure TWA163FTipoQuoteDettFM.CaricaLista;
begin
  with (WR302DM as TWA163FTipoQuoteDM).A163FTipoQuoteMW do
  begin
    selT765Acc.Close;
    if drdgTipologia.ItemIndex = 8 then
      selT765Acc.SetVariable('TIPOQUOTA','''A'',''S'',''T'',''I'',''V'',''C'',''D'',''N''')
    else
      selT765Acc.SetVariable('TIPOQUOTA','''A''');
    selT765Acc.SetVariable('DATA',WR302DM.selTabella.FieldByName('DECORRENZA').AsDateTime);
    selT765Acc.Open;
    while not selT765Acc.Eof do
    begin
      WC013.ckList.Items.Add(Format('%-5s %s',[selT765Acc.FieldByName('Codice').AsString,selT765Acc.FieldByName('Descrizione').AsString]));
      selT765Acc.Next;
    end;
  end;
end;

procedure TWA163FTipoQuoteDettFM.ResultAcconti(Sender: TObject; Result:Boolean);
begin
  if Result then
    WR302DM.selTabella.FieldByName(dedtAcconti.DataField).AsString:=C190GetCheckList(5,WC013.ckList);
end;

procedure TWA163FTipoQuoteDettFM.dcmbCausaleAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  with TWA163FTipoQuoteDM(WR302DM) do
    selTabella.FieldByName('CAUSALE_ASSESTAMENTO').AsString:=dcmbCausale.Text;
end;

procedure TWA163FTipoQuoteDettFM.dedtGiorniMeseAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  with TWA163FTipoQuoteDM(WR302DM) do
    selTabella.FieldByName('GIORNI_MESE').AsFloat:=R180Arrotonda(selTabella.FieldByName('GIORNI_MESE').AsFloat,0.00001,'P');
end;

procedure TWA163FTipoQuoteDettFM.dchkRifSaldoAnnoCorrClick(Sender: TObject);
begin
  AbilitaComponenti;
end;

procedure TWA163FTipoQuoteDettFM.AbilitaComponenti;
var Tipologia:Integer;
begin
  inherited;
  Tipologia:=drdgTipologia.Values.IndexOf(TWA163FTipoQuoteDM(WR302DM).selTabella.FieldByName('TIPOQUOTA').AsString);
  drdgTipologia.Enabled:=not (Self.Owner as TWR102FGestTabella).InterfacciaWR102.StoricizzazioneInCorso;

  dchkImpostaMeseCompMax.Visible:=Tipologia = 7;
  dchkRifSaldoAnnoCorr.Visible:=Tipologia = 3;
  with TWA163FTipoQuoteDM(WR302DM) do
    if selTabella.State in [dsEdit,dsInsert] then
    begin
      if not dchkImpostaMeseCompMax.Visible then
        selTabella.FieldByName('IMPOSTA_MESE_COMP_MAX').AsString:='N';
      if not dchkRifSaldoAnnoCorr.Visible then
        selTabella.FieldByName('RIF_SALDO_ANNO_CORR').AsString:='N';
    end;


  lblAcconti.Caption:='Acconti di riferimento';
  if Tipologia = 8 then
    lblAcconti.Caption:='Quote qual. di riferimento';
  dedtAcconti.Enabled:=(Tipologia in [4,5,6,7,8]) or (TWA163FTipoQuoteDM(WR302DM).selTabella.FieldByName('RIF_SALDO_ANNO_CORR').AsString = 'S');
  lblAcconti.Enabled:=dedtAcconti.Enabled;
  btnAcconti.Enabled:=dedtAcconti.Enabled and (TWA163FTipoQuoteDM(WR302DM).selTabella.State  in [dsEdit,dsInsert]);

  dcmbCausale.Enabled:=Tipologia = 8;
  dcmbCausale.Visible:=dcmbCausale.Enabled;
  with TWA163FTipoQuoteDM(WR302DM) do
    if selTabella.State in [dsEdit,dsInsert] then
      if not dcmbCausale.Enabled then
        selTabella.FieldByName('CAUSALE_ASSESTAMENTO').AsString:='';
  lblCausale.Enabled:=dcmbCausale.Enabled;
  lblCausale.Visible:=lblCausale.Enabled;
  dlblCausale.Visible:=dcmbCausale.Enabled;
  dlblCausale.Visible:=dlblCausale.Enabled;

  dedtGiorniMese.Enabled:=drdgTipologia.ItemIndex in [0,1,2,3,4,5,8];
  lblGiorniMese.Enabled:=dedtGiorniMese.Enabled;
  with TWA163FTipoQuoteDM(WR302DM) do
    if selTabella.State in [dsEdit,dsInsert] then
      if not dedtGiorniMese.Enabled then
        selTabella.FieldByName('GIORNI_MESE').Value:=Null;

  lblVPQuantitativa.Enabled:=Tipologia = 8;
  dedtVPQuantitativa.Enabled:=Tipologia = 8;
  lblVPIntera.Enabled:=not (Tipologia in [8,9]);
  dedtVPIntera.Enabled:=not (Tipologia in [8,9]);
  lblVPProporzionata.Enabled:=not (Tipologia in [8,9]);
  dedtVPProporzionata.Enabled:=not (Tipologia in [8,9]);
  lblVPNetta.Enabled:=Tipologia <> 8;
  dedtVPNetta.Enabled:=Tipologia <> 8;
  lblVPNettaRisp.Enabled:=not (Tipologia in [8,9]);
  dedtVPNettaRisp.Enabled:=not (Tipologia in [8,9]);
  lblVPRisparmio.Enabled:=not (Tipologia in [8,9]);
  dedtVPRisparmio.Enabled:=not (Tipologia in [8,9]);
  lblVPNoRisp.Enabled:=not (Tipologia in [8,9]);
  dedtVPNoRisp.Enabled:=not (Tipologia in [8,9]);
  with TWA163FTipoQuoteDM(WR302DM) do
    if selTabella.State in [dsEdit,dsInsert] then
    begin
      if not dedtAcconti.Enabled then
        selTabella.FieldByName('ACCONTI').AsString:='';
      if not dedtVPQuantitativa.Enabled then
        selTabella.FieldByName('VP_QUANTITATIVA').AsString:='';
      if not dedtVPIntera.Enabled then
        selTabella.FieldByName('VP_INTERA').AsString:='';
      if not dedtVPProporzionata.Enabled then
        selTabella.FieldByName('VP_PROPORZIONATA').AsString:='';
      if not dedtVPNetta.Enabled then
        selTabella.FieldByName('VP_NETTA').AsString:='';
      if not dedtVPNettaRisp.Enabled then
        selTabella.FieldByName('VP_NETTARISP').AsString:='';
      if not dedtVPRisparmio.Enabled then
        selTabella.FieldByName('VP_RISPARMIO').AsString:='';
      if not dedtVPNoRisp.Enabled then
        selTabella.FieldByName('VP_NORISPARMIO').AsString:='';
    end;
end;

end.
